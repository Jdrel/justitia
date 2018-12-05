class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :video]

  def home
    @categories = Category.all
    @categories_names_json = []

    @categories.each do |categorie|
      @categories_names_json << categorie.name
    end
   @categories_names_json = @categories_names_json.to_json
  end

  def video
  end
end
