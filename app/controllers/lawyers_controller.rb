class LawyersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

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

  def new
    @lawyer = Lawyer.new
  end
end
