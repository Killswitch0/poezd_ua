class SearchesController < ApplicationController
  def show
    @railway_stations = RailwayStation.all
  end
end
