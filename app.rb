require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/reloader'

require 'sidekiq'
require 'sidekiq/api'
require 'better_errors'

class MyApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    use BetterErrors::Middleware
  end

  get '/error' do
    raise 'oops!'
  end

  get '/' do
    redirect '/index.html'
  end

  get '/swagger' do
    # Swagger UI
    redirect '/index.html'
  end

  get '/api/get_json' do
    test = {:id => 'test'}
    json test
  end

  get '/api/start_worker' do
    test = Array.new
    10000.times do |count|
      HardWorker.perform_async(count)
      puts "#{count}. start_worker_called"
    end
    puts 'FINISHED START WORKER'
  end

end

class HardWorker
  include Sidekiq::Worker

  def perform(count)
    puts "\n#{count}. Doing hard work\n"
  end
end