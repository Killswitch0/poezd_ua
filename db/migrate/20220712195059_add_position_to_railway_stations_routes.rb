class AddPositionToRailwayStationsRoutes < ActiveRecord::Migration[7.0]
  def change
    add_column :railway_stations_routes, :position, :integer
  end
end
