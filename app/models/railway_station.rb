class RailwayStation < ApplicationRecord
  validates :title, presence: true
  # чтобы получать список всех поездов на станции
  # has_many :trains указывает, что станция имеет множество поездов
  #
  # где писать единственное число, а где множественное запоминать не нужно, надо
  # просто понять суть: если объект принадлежит к другому объекту - единственное число,
  # если объект принадлежит к множеству других объектов - во множественном.
  has_many :trains, foreign_key: :current_station_id
  has_many :railway_stations_routes
  has_many :routes, through: :railway_stations_routes
end
