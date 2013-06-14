class ApplicationController < ActionController::Base
  #protect against CSRF
  protect_from_forgery
  include SessionsHelper

  def handle_unverified_request
    sign_out
    super
  end
end
