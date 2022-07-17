class Route < ApplicationRecord
  has_many :railway_stations_routes
  has_many :railway_stations, through: :railway_stations_routes

  validates :name, presence: true
  validate :station_count # кастомная валидация

  # Collbacks - механизм выполнения пользовательского кода
  # при выполнении операций над объектом
  #
  # "Хуки"(методы), которые вызываются в жизненном цикле объекта
  before_validation :set_name

  # методы private не предназначены для прямого вызва - не являются
  # частью публичного интерфейса
  private

  def set_name
    # присваиваем атрибуту name первую и последнюю станцию маршрута
    self.name ||= "#{railway_stations.first.title} - #{railway_stations.last.title}"
  end

  def station_count
    if railway_stations.size < 2
      # все ошибки валидации хранятся во внутреннем объекте errors, так же
      # мы можем в него добавить ошибки вызвав .add и 2 параметра(1 - поле, к которому добавляем ошибку,
      # 2 - сообщение об ошибке )
      # в интерфейсе используется railway_station_ids, можно добавить ошибку на него, либо
      # на весь объект целиком, написав :base,
      # что здесь более логично - у нас маршрут должен содержать 2 станции.
      errors.add(:base, 'Route should contain at least 2 stations')
    end
  end
end
