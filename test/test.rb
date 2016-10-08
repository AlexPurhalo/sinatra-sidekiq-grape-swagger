ENV['RACK_ENV'] = 'test'

require '../app'
require 'rack/test'
require 'test/unit'

class HelloWorldTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    MyApp
  end

  def test_it_says_hello_world
    get '/'
    assert last_response.ok?
    assert_equal 'Hello world!', last_response.body
  end

  def test_api_returns_json
    get '/api/get_json'
    json = JSON.parse(last_response.body)
    assert_equal 'test', json['id']
  end

end
