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
      redirect_to @route, notice: "Маршрут успешно создан."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @route.update(route_params)
      # redirect_to - создание нового запроса. Важно помнить: при каждом запросе создается новый объект
      # контроллера, как и инстанс-переменные.
      # Новый запрос - новые данные в объектах
      redirect_to @route, notice: "Маршрут успешно изменен."
    else
      # render - рендеринг шаблона из вида на основе тех данных, которые есть в экшне
      # в случае ошибок мы делаем рендер edit, поскольку хотим отобразить наши ошибки в рамках
      # состояния текущих объектов. Если бы не было render :edit, то контроллер по умолчанию начал искать
      # шаблон с текущем именем экшна - update
      render :edit
    end
  end

  def destroy
    @route.destroy

    redirect_to routes_path, status: :see_other
  end

  private

  # в params используется хэш с indifferent(безразличный) access
  # можно писать в названии ключа как символ params[:id], так и строку params['id']
  def set_route
    @route = Route.find(params[:id])
  end

  # ко всему объему параметров в params мы применяем require(:route) - требуем определенный ключ
  # указываем какие во внутреннем хэше route могут быть поля: permit(:name, railway_station_ids: [])
  def route_params
    params.require(:route).permit(:name, railway_station_ids: [])
  end
end