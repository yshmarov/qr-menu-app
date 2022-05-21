class QueueController < ApplicationController
  def index
    @orders = Order.queued
  end
end
