class TrainsController < ApplicationController
  # метод, который мы выполняем до того, как выполним перечисленные методы в [....]
  # указываем опцию only: и массив символов, в котором указаны те экшены, перед
  # которыми будет выполняться метод set_train
  before_action :set_train, only: %i[show edit update destroy]

  def index
    @trains = Train.all
  end

  def show
  end

  def new
    @train = Train.new
  end

  def edit
  end

  def create
    @train = Train.new(train_params)

    if @train.save
      redirect_to @train, notice: "Поезд успешно создан."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @train.update(train_params)
      redirect_to @train, notice: "Поезд успешно изменен."
    else
      render :edit
    end
  end

  def destroy
    @train.destroy

    redirect_to trains_path, status: :see_other
  end

  private

  def set_train
    @train = Train.find(params[:id])
  end

  def train_params
    params.require(:train).permit(:number, :current_station_id)
  end
end
