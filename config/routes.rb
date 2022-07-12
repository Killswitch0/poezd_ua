Rails.application.routes.draw do
  # кастомный экшн у ресурса railway_stations
  # указываем, что у нас есть дополнительный экш, где перед ним
  # пишем HTTP метод, при помощи которого мы хотим обращаться к нашему экшену
  # после запятой задаем вопрос: этот экшн применяется к конкретному объекту или коллекции?
  # URL должен содердать id объекта или нет?
  # если коллекция, пишем on: :collection. если конкретный - on: :member
  #
  # здесь важно правильно указать HTTP-метод:
  # если получение данных без изменения - GET
  # создание чего-то нового или какая-то неконкретная отправка данных на сервер - POST
  # изменение - PATCH/PUT
  # удаление - DELETE
  resources :railway_stations do
    patch :update_position, on: :member
  end

  resources :trains
  resources :routes

  get 'welcome/index'
  get "/trains", to: "trains#index"
  get "/trains/:id", to: "trains#show"

  root 'welcome#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
