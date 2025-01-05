class QueueController < ApplicationController
  before_action :public_order_queue_enabled?

  def index
    @orders = Order.queued
  end

  private

  def public_order_queue_enabled?
    raise ActionController::RoutingError, "Public order queue is disabled" unless Rails.application.config_for(:settings).dig(:public_order_queue)
  end
end
