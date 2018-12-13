class LawyersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :lawyer_params, only: :create

  def index
    get_category_names
    @search_result = search(params)
    if params[:category] == "All categories"
      @lawyers = Lawyer.all
    else
      @search_result
    end
  end

  def show
    @lawyer = Lawyer.find(params[:id])
  end


  # METHODS THAT ALLOW LAWYER TO PUT HIMSELF ONLINE/OFFLINE

   def online
    @lawyer = Lawyer.find(params[:lawyer_id])
    @lawyer.is_online = true
    @lawyer.save
    render "update_online"
  end

  def offline
    @lawyer = Lawyer.find(params[:lawyer_id])
    @lawyer.is_online = false
    @lawyer.save
    render "update_online"
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
    redirect_to lawyer_path(@lawyer)
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
