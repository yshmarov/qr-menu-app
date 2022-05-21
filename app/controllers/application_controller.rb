class ApplicationController < ActionController::Base
  before_action :set_user_from_session

  protected

  def set_user_from_session
    @user_id = session.id.to_s
    @my_orders = Order.where(session_uid: @user_id)
    @current_order = @my_orders.draft.first
  end
end
