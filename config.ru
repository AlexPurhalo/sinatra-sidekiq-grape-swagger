require 'rubygems'
require 'bundler'
require './api'

Bundler.require

require 'sidekiq/web'
require 'grape'

map '/sidekiq' do
  run Sidekiq::Web
end

map '/api' do
  run API
end

require './app'
run MyApp


