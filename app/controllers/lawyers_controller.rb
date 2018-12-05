class LawyersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    if params[:category] == ""
      @lawyers = Lawyer.all
    else
      @lawyers = []
      all_lawyers = Lawyer.all
      all_lawyers.each do |lawyer|
        lawyer.specialties.each do |specialty|
          if specialty.category.name == params[:category]
            @lawyers << lawyer
          end
        end
      end
      return @lawyers
    end
  end

  def show
    @lawyer = Lawyer.find(params[:id])
  end
end
