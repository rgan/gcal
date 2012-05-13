require File.join(File.dirname(__FILE__), '..', 'gcal_app.rb')
require File.join(File.dirname(__FILE__), '..', 'auth_helper.rb')
require 'sinatra'
require 'rspec'
require 'rack/test'

set :environment, :test