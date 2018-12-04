class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :video]

  def home
  end

  def video
  end
end
