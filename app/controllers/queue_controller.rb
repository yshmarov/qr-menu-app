class QueueController < ApplicationController
  before_action :public_order_queue_enabled?

  def index
    @orders = Order.queued
  end

  private

  def public_order_queue_enabled?
    public_order_queue = Setting.public_order_queue
    raise ActionController::RoutingError, "Public order queue is disabled" unless public_order_queue
  end
end
