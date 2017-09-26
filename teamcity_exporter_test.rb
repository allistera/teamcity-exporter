ENV['RACK_ENV'] = 'test'

require_relative 'teamcity_exporter'
require 'test/unit'
require 'rack/test'
require 'mocha/test_unit'

# Tests for exporter
class TeamcityExporterTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def setup
    ENV['TEAMCITY_HOST'] = 'http://foo.bar'
    ENV['TEAMCITY_USERNAME'] = 'foo'
    ENV['TEAMCITY_PASSWORD'] = 'bar'
    ENV['TEAMCITY_PROJECTS'] = 'test_Project'
  end

  def test_success_shows
    mock_response('FooBar', 'SUCCESS')

    get '/metrics'
    assert last_response.ok?
    assert last_response.body.include?('teamcity_project_success{project="FooBar"} 1')
  end

  def test_failure_shows
    mock_response('FooBar', 'FAILURE')

    get '/metrics'
    assert last_response.ok?
    assert last_response.body.include?('teamcity_project_success{project="FooBar"} 0')
  end

  private

  def mock_response(id, status)
    HTTParty.expects(:get).with(
      'http://foo.bar/httpAuth/app/rest/buildTypes/id:test_Project/builds?branchName=master&count=1',
      basic_auth: { username: 'foo', password: 'bar' },
      headers: { :Accept => 'application/json', 'Content-Type' => 'application/json' },
      format: :json
    ).returns('build' => [
                {
                  'buildTypeId' => id,
                  'status' => status
                }
              ])
  end
end
