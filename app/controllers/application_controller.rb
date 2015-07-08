class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do
    #redirect_to "http://shamenun.com"
    redirect_to :back, notice: "You are not authorized to see this page"
  end
end
