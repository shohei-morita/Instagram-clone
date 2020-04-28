class ApplicationController < ActionController::Base
  protect_from_forgery within: :exception
  include SessionsHelper
end
