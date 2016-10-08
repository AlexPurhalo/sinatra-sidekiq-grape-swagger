require 'grape'
require 'grape-swagger'
require './app'

class API < Grape::API
  content_type :json, 'application/json'
  content_type :xml, 'application/xml'

  default_format :json


  get :hello do
    { hello: "world" }
  end

  resource :job do
    desc 'Start Sidekiq Background Job'
    get :start_background_job do
      test = Array.new
      100.times do |count|
        HardWorker.perform_async(count)
        puts "#{count}. start_worker_called"
      end
      puts 'FINISHED START WORKER'
      {status: 'success'}
    end
  end


  resource :person do
    resource :read do
      route_param :name do
        desc 'Reads name of a person and returns that name in selected format'
        params do
          requires :name, type:String, desc: 'Name'
        end
        get do
          {name: params[:name]}
        end
      end
    end
  end


  add_swagger_documentation info: {title: 'Swagger for example API using grape',
                                   description: 'Playground to build up an API using grape and display it with swagger'},
                            base_path: '/api',
                            hide_documentation_path: true
end