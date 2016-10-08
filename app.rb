require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/reloader'
require 'sinatra/activerecord'

require 'sidekiq'
require 'sidekiq/api'
require 'better_errors'

class User < ActiveRecord::Base
end

class MyApp < Sinatra::Base
  before do
    content_type :json
  end

  configure :development do
    register Sinatra::Reloader
    use BetterErrors::Middleware
  end

  get '/swagger' do
    redirect '/index.html'
  end
end

class HardWorker
  include Sidekiq::Worker

  def perform(secs)
    sleep secs
    puts 'works'
  end
end

