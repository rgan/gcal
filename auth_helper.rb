class AuthHelper
  
  def self.authorize_client(client)
    auth = client.authorization
    auth.client_id = CLIENT_ID
    auth.client_secret = CLIENT_SECRET
    auth.scope = "https://www.googleapis.com/auth/calendar"
    auth.refresh_token=REFRESH_TOKEN
    if auth.access_token.nil?
      auth.fetch_access_token!
    end
  end
end