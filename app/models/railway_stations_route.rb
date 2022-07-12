class RailwayStationsRoute < ApplicationRecord
  belongs_to :railway_station
  belongs_to :route

  # Мы запускаем валидацию в промежуточной таблице, поскольку в ней есть нужное поле
  # railway_station_id
  # Мы не можем валидировать всю таблицу целиком, нам нужно конкретное поле
  #
  # Поэтому рекомендуется создавать связи моделей многие ко многим через промежуточные модели,
  # благодаря подходу has_many ..., through: :...
  #
  # Для uniqueness есть опция { scope: :... } задающая область ограничения: в рамках каких других полей
  # мы должны проверять уникальность. Не в рамках всей таблицы, а в рамках route_id, что будет означать:
  # с route_id 1 может выть railway_station_id 1 только один раз. А в других route_id может быть встречена
  # еще раз.
  validates :railway_station_id, uniqueness: { scope: :route_id }
end