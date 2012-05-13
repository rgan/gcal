require 'spec_helper'

describe "auth helper" do

  it "should get access token" do

    client = stub(:APIClient)
    authorization = stub(:auth, :client_id= => {}, :client_secret= => {},
                         :scope= => {}, :refresh_token= => {}, :access_token => nil)
    client.should_receive(:authorization) { authorization }
    authorization.should_receive(:fetch_access_token!)
    AuthHelper.authorize_client(client)
  end
end