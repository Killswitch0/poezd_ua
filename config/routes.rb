Rails.application.routes.draw do
  # кастомный экшн у ресурса railway_stations
  # указываем, что у нас есть дополнительный экш, где перед ним
  # пишем HTTP метод, при помощи которого мы хотим обращаться к нашему экшену
  # после запятой задаем вопрос: этот экшн применяется к конкретному объекту или коллекции?
  # URL должен содержать id объекта или нет?
  # если коллекция, пишем on: :collection. если конкретный - on: :member
  #
  # здесь важно правильно указать HTTP-метод:
  # если получение данных без изменения - GET
  # создание чего-то нового или какая-то неконкретная отправка данных на сервер - POST
  # изменение - PATCH/PUT
  # удаление - DELETE
  resources :railway_stations do
    put :update_position, on: :member
  end

  resources :trains do
    # shallow: true - эта опция укажет, что родительский объект @train нужен только для
    # экшнов index, create, new. Все остальные его не требуют. Можем в этом убедиться, посмотрев
    # роутинг командой rails routes
    resources :carriages, shallow: true
  end

  resources :routes

  # когда мы пишем resource(в единственном числе), мы создаем singular resource(единственный ресурс)
  # rails routes покажет, что у singular resource в роутинге нет метода index, что логично -
  # - раз ресурс в одном экземпляре, значит нет списка этих ресурсов
  #
  # У любого ресурса можно указать, какие экшны нам нужны - опция only для определенных экшнов,
  # опция except - все, кроме.
  resource :search, only: %i[new show edit]

  get 'welcome/index'
  get "/trains", to: "trains#index"
  get "/trains/:id", to: "trains#show"

  root 'welcome#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
