class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :video]

  def home
    get_category_names
  end

  def video
  end

  private

  def get_category_names
    @categories_names = ["All categories"]
    Category.all.each do |category|
      @categories_names << category.name
    end
    return @categories_names
  end
end
