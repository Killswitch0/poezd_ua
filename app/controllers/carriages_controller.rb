class CarriagesController < ApplicationController
  # only: %i[new create], поскольку в файле routes, во вложенном resource :carriages,
  # добавили опцию shallow: true - объект @train нужен только для
  # экшнов index, create, new.
  before_action :set_train, only: %i[new create]

  def new
    @carriage = Carriage.new
  end

  def show
    @carriage = Carriage.find(params[:id])
  end

  # суть вложенный ресурсов в том, чтобы создавать сразу связанные объекты,
  # а это можно сделать через ассоциации
  def create
    @carriage = @train.carriages.new(carriage_params)

    if @carriage.save
      redirect_to @train
    else
      render :new
    end
  end

  protected

  def set_train
    # загружаем объект @train и родительский параметр будет называться :train_id,
    # который указан в роутинге  /trains/:train_id/carriages
    @train = Train.find(params[:train_id])
  end

  def carriage_params
    params.require(:carriage).permit(:number,
                                     :top_seats,
                                     :bottom_seats,
                                     :side_top_seats,
                                     :bottom_top_seats)
  end
end
