class ApplicationController < ActionController::Base
  def current_user
    @first_user = User.includes(:posts).find(params[:user_id])
  end
end
