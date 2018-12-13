class LawyersController < ApplicationController
  require "shellwords"

  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :lawyer_params, only: :create

  def index
    get_category_names
    search_result = search(params)
    if params[:category] == "All categories"
      @lawyers = Lawyer.all
    else
      search_result
    end
  end

  def show
    @lawyer = Lawyer.find(params[:id])
  end

  def new
    @lawyer = Lawyer.new
  end

  def create
    @lawyer = Lawyer.new
    @lawyer.user = current_user
    @lawyer.description = params['lawyer']['description']
    @lawyer.years_of_experience = params['lawyer']['years_of_experience']
    @lawyer.is_first_consultation_free = params['lawyer']['is_first_consultation_free']
    @lawyer.photo = params['lawyer']['photo']
    @lawyer.save
    url_stripe = "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=#{ENV['STRIPE_PLATFORM_ID']}&scope=read_write"
    redirect_to url_stripe
  end

  def stripe
    auth_code = params['code']
    api_key = ENV['STRIPE_SECRET_KEY']

    args = [ "-X", "POST",
         "-d", "client_secret=#{api_key}",
         "-d", "code=#{auth_code}",
         "-d", "grant_type=authorization_code",
         "https://connect.stripe.com/oauth/token" ]

    response = `curl #{args.shelljoin}`
    result = JSON.parse(response)
    lawyer = current_user.lawyer
    lawyer.stripe_id = result['stripe_user_id']
    lawyer.save

    # redirect
    flash[:notice] = "Stripe Account Correctly Linked"
    redirect_to lawyer_consultations_path(lawyer)
  end

  private

  def search(params)
    @lawyers = Lawyer.all
    if params[:is_online].present?
      @lawyers = @lawyers.where(is_online: params[:is_online])
    end
    if params[:min_price].present?
      price_in_cents = params[:min_price].to_i * 100
      sql_query = "hourly_rate_cents > :query"
      @lawyers = @lawyers.where(sql_query, query: "#{price_in_cents}")
    end
    if params[:max_price].present?
      price_in_cents = params[:min_price].to_i * 100
      sql_query = "hourly_rate_cents < :query"
      @lawyers = @lawyers.where(sql_query, query: "#{price_in_cents}")
    end
    if params[:category].present?
      @lawyers = @lawyers.joins(:specialties).joins(:categories).where(categories: { name: params[:category] }).uniq
    end
    return @lawyers
  end

  def get_category_names
    @category_names = []
    Category.all.each do |category|
      @category_names << category.name
    end
    return @category_names
  end

  def lawyer_params
    params.require(:lawyer).permit(:description, :years_of_experience, :hourly_rate, :is_first_consultation_free, :photo)
  end

end
