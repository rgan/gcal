require 'spec_helper'

describe "controller" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "home page" do

    it "shows form to create event" do
      get '/'
      last_response.should be_ok
      last_response.body.should match(/textarea rows="20" cols="40" name="request_body"/)
      last_response.body.should match(/form action="\/events" method=POST/)
    end
  end

  describe "POST events" do
    before(:each) do
      @event = '{ "summary": "testevent"}'
      @client = stub(:APIClient)
      
      @insert_method = stub()
      events = stub(:events, :insert => @insert_method)
      service = stub(:service, :events => events)

      Google::APIClient.should_receive(:new){ @client }
      AuthHelper.should_receive(:authorize_client).with(@client)
      @client.should_receive(:discovered_api).with('calendar', 'v3'){ service}
    end

    it "should execute insert event" do
      json = JSON.parse(@event)
      result = stub(:Result, :status => 200, :data => stub(:data, :id => 1))
      @client.should_receive(:execute).with(:api_method => @insert_method,
                                            :parameters => {'calendarId' => 'primary', 'sendNotifications' => 'true'},
                                            :body_object => json,
                                            :headers => {'Content-Type' => 'application/json'}) { result }
      post "/events", params={:request_body => @event}
    end

  end
end