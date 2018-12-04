class LawyersController < ApplicationController
   skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @lawyers = Lawyer.all
  end

  def show
    @lawyer = Lawyer.find(params[:id])
  end
end
