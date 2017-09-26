require 'sinatra'
require 'httparty'

set :bind, '0.0.0.0'

def fetch_statuses
  ENV['TEAMCITY_PROJECTS'].split(',').map do |build|
    response = HTTParty.get(
      "#{ENV['TEAMCITY_HOST']}/httpAuth/app/rest/buildTypes/id:#{build}/builds?branchName=master&count=1",
      basic_auth: { username: ENV['TEAMCITY_USERNAME'], password: ENV['TEAMCITY_PASSWORD'] },
      headers: { Accept: 'application/json', 'Content-Type' => 'application/json' },
      format: :json
    )
    response
  end
end

get '/metrics' do
  content_type 'text/plain'
  @status = fetch_statuses
  erb :response
end
