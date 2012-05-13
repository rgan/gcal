require 'sinatra'
require 'uri'
require 'google/api_client'
require File.join(File.dirname(__FILE__), 'auth_helper.rb')

REFRESH_TOKEN = ENV['REFRESH_TOKEN'] || ''
CLIENT_ID= ENV['CLIENT_ID'] || ''
CLIENT_SECRET= ENV['CLIENT_SECRET'] || ''

get "/" do
  @msg = params[:msg]
  erb :index
end

post '/events' do
  client = Google::APIClient.new
  service = client.discovered_api('calendar', 'v3')
  AuthHelper.authorize_client(client)
  result = client.execute(:api_method => service.events.insert,
                          :parameters => {'calendarId' => 'primary', 'sendNotifications' => 'true'},
                          :body_object => JSON.parse(params[:request_body]),
                          :headers => {'Content-Type' => 'application/json'})
  if result.status == 200 then
    msg = "Event created with id:#{result.data.id}"
  else
    msg = "Error creating event:#{result.body}"
  end
  redirect "?msg=" + URI.escape(msg)
end