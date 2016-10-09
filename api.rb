require 'grape'
require 'grape-swagger'
require './app'

class API < Grape::API
  content_type :json, 'application/json'

  default_format :json

  resources :users do
    get '/' do
      @users = User.order('created_at DESC')
      @users
    end

    params do
      requires :name, type: String, desc: 'Name'
    end

    post '/' do
      @user = User.new params
      @user.save
      HardWorker.perform_async(3, @user.id)
    end
  end

  add_swagger_documentation info: {title: 'Swagger for example API using grape',
                                   description: 'Playground to build up an API using grape and display it with swagger'},
                            base_path: '/api',
                            hide_documentation_path: true
end