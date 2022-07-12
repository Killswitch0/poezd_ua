class Carriage < ApplicationRecord
  belongs_to :train

  validates :number, :top_seats, :bottom_seats, presence: true

  # дефолтный скоуп, который по умолчанию будет выводить нам сортировку вагонов по номеру
  # default_scope { order(:number) }

  # scope - это некая ограниченная выборка из данных
  # именованые скоупы - скоупы, которые сохраняются в модели и их можно
  # вызвать в любой момент как метод модели.
  scope :economy, -> { where(type: 'EconomyCarriage') }
  scope :coupe, -> { where(type: 'CoupeCarriage') }
  scope :ordered, -> { order(:number) }
end
