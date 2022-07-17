class RailwayStation < ApplicationRecord
  # чтобы получать список всех поездов на станции
  # has_many :trains указывает, что станция имеет множество поездов
  #
  # где писать единственное число, а где множественное, запоминать не нужно, надо
  # просто понять суть: если объект принадлежит к другому объекту - единственное число,
  # если объект принадлежит к множеству других объектов - во множественном.
  has_many :trains, foreign_key: :current_station_id
  has_many :railway_stations_routes
  has_many :routes, through: :railway_stations_routes

  # scope :ordered - выводит упорядочено станции
  # нужно применить объединение таблиц: нашей r_s и r_s_r, поле position находится в таблице r_s_r,
  # и не смотря на то, что у нас есть связь has_many, фактически, эти таблицы не объединены
  # поэтому наш нужен запрос joins - объединить с таблицей, затем order - нужно указать полное
  # название таблицы и поле. В конце добавим метод uniq для исключения(убрать) повторяющихся станций
  scope :ordered, -> { joins(:railway_stations_routes).order('railway_stations_routes.position').uniq }

  validates :title, presence: true

  # метод принимает route - объект маршрута, position
  # дальше нам нужно найти через ассоциацию railway_stations_routes нужную запись в таблице
  # присвоим ее в локальную переменную и назовем station_route, а внутри переменной обращаемся
  # к ассоциации railway_station_routes. Так как мы работаем внутри конкретного объекта станции,
  # это означает, что railway_stations_routes, вызванный здесь, вернет нам только те записи, которые
  # связаны с нашей конкретной станцией, но станция может быть в разных маррутах, поэтому
  # нужен доп.фильтр where - фильтр по маршруту.
  # Мы найдем среди тех записей в таблице r_s_r, которые принадлежат конкретной станции, еще и те, которые
  # принадлежат конкретному переданному маршруту.
  # Но where возвращает не сам объект, а relation - связь. Чтобы получить сам объект, нужно вызвать first
  # (поскольку мы предполагаем, что он должен быть один)
  #
  # дальше у полученного объекта вызываем update, и обновляем поле position
  # НО! Запрос station_route = railway_stations_routes.where(route: route).first не гарантированно
  # вернет нам объект: если записи нет, то там будет nil, а вызвав update у nil будет ошибка
  # поэтому делаем доп.проверку if station_route(если у нас присутствует station_route)
  #
  # Теперь мы сможем вызвать в контроллере на объекте @railway_station метод update_position
  def update_position(route, position)
    station_route = station_route(route)
    station_route.update(position: position) if station_route
  end

  # метод будет возвращать нужную нам позицию, а в качестве параметра - объект маршрута,
  # потому что в разных маршрутах позиция может быть разная
  # метод try вызывает переданный в качестве символа метод, если объект,
  # на котором вызывается try, существует(не nil) - элегантная замена if station_route
  def position_in(route)
    station_route(route).try(:position)
  end

  protected

  # мы перенесли дублирующий элемент кода в отдельный метод
  def station_route(route)
    @station_route ||= railway_stations_routes.where(route: route).first
  end
end

