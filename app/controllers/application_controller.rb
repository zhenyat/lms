class ApplicationController < ActionController::Base
  include ZT
#  protect_from_forgery with: :exception
  before_action :set_locale
  
  http_basic_authenticate_with name: 'lms', password: 'lms-2017' if ACCESS_RESTRICTED
end
