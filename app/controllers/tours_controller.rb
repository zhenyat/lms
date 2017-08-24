class ToursController < ApplicationController
  def index
    @tours = Tour.active
  end

  def show
    @tour = Tour.find(params[:id])
  end
end
