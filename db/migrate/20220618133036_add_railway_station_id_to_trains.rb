class AddRailwayStationIdToTrains < ActiveRecord::Migration[7.0]
  def change
    # add_column :trains, :railway_station_id, :integer

    # в таблицу trains мы добавляем связь с таблицей railway_station через столбец
    # current_station_id
    #
    # add_belongs_to добавит в таблицу trains нам целочисленное поле current_station_id
    add_belongs_to :trains, :current_station
  end
end
