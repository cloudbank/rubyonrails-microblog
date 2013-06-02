class ApplicationController < ActionController::Base
  #protect against CSRF
  protect_from_forgery
  include SessionsHelper
end
