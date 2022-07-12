class CreateCarriages < ActiveRecord::Migration[7.0]
  def change
    create_table :carriages do |t|
      t.integer :number
      t.integer :top_seats
      t.integer :bottom_seats
      t.integer :side_top_seats
      t.integer :side_bottom_seats
      t.belongs_to :train
      # если мы в миграцию добавляем строковое поле type, рельсы автоматически применяют к этой таблице
      # паттерн Single Table Inheritance
      t.string :type

      t.timestamps
    end
  end
end
