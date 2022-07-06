class Train < ApplicationRecord
  validates :number, presence: true

  # belongs_to всегд принимает название модели в единственном числе
  # модель Train связана с одной current_station - теперь рельсы это знают
  # мы можем получить ту станцию, на которой сейчас находится поезд, через
  # метод current_station
  #
  # вся магия происхоидт из соглашения по именам:
  # указаов вот это, рельсы знают, что в нашей таблице trains
  # должно быть поле current_station_id и должно ссылаться на таблицу
  # railway_stations.
  #
  # Если мы будем обращаться на уровне моделей к этой ассоциации, то рельсы будут знать,
  # что нужно взять из таблицы railway_stations некую запись, связанную по id в таблице
  # trains, создать модель railway_station для этой записи(строки) и вернуть конкретную модель,
  # конкретный объект railway_station.
  #
  # модель у нас будет другая: class_name: 'ИмяАссоциации'. Теперь рельсы будут знать, что в
  # качестве таблицы нужно использовать raylway_stations, а в качестве модели класс RailwayStation.
  # желательно в таких случаях указывть в явном виде foreign_key: :название_внешнего_ключа
  #
  # поле - внешний ключ для таблицы, должно называться так же, как и таблица,
  # только в "единственном_числе_id"
  belongs_to :current_station, class_name: 'RailwayStation', foreign_key: :current_station_id




end