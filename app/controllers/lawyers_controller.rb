class LawyersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    get_category_names
    search_result = search(params)
    if search_result.first.nil?
      @lawyers = Lawyer.all
    else
      search_result
    end
  end

  def show
    @lawyer = Lawyer.find(params[:id])
  end

  private

  def find_lawyers_with_specialty(param_speciality)
    @lawyers = []
    all_lawyers = Lawyer.all
    if params[:category] == "All categories"
      @lawyers = all_lawyers
    else
      all_lawyers.each do |lawyer|
        lawyer.specialties.each do |specialty|
          if specialty.category.name == param_speciality
            @lawyers << lawyer
          end
        end
      end
    end
    return @lawyers
  end

  def search(params)
    @lawyers = Lawyer.all
    if params[:is_online].present?
      @lawyers = @lawyers.where(is_online: params[:is_online])
    end

    if params[:min_price].present?
      sql_query = "hourly_rate > :query"
      @lawyers = @lawyers.where(sql_query, query: "#{params[:min_price]}")
    end
    if params[:max_price].present?
      sql_query = "hourly_rate < :query"
      @lawyers = @lawyers.where(sql_query, query: "#{params[:max_price]}")
    end
    if params[:category].present?
      @lawyers = find_lawyers_with_specialty(params[:category])
    end
    return @lawyers
  end

  def get_category_names
    @categories_names = []
    Category.all.each do |category|
      @categories_names << category.name
    end
    return @categories_names
  end
end
