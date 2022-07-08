class RoutesController < ApplicationController
  # метод, который мы выполняем до того, как выполним перечисленные методы в [....]
  # указываем опцию only: и массив символов, в котором указаны те экшены, перед
  # которыми будет выполняться метод set_train
  before_action :set_route, only: %i[show edit update destroy]

  def index
    @routes = Route.all
  end

  def show
  end

  def new
    @route = Route.new
  end

  def edit
  end

  def create
    @route = Route.new(route_params)

    if @route.save
      redirect_to @route, notice: "Поезд успешно создан."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @route.update(route_params)
      redirect_to @route, notice: "Поезд успешно изменен."
    else
      render :edit
    end
  end

  def destroy
    @route.destroy

    redirect_to routes_path, status: :see_other
  end

  private
  def set_route
    @route = Route.find(params[:id])
  end

  def route_params
    params.require(:route).permit(:name)
  end
end