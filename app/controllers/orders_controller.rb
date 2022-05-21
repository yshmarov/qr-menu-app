class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]

  # current_user orders
  def index
    # @orders = Order.where(session_uid: ActiveRecord::SessionStore::Session.ids)
    # @orders = Order.where(session_uid: request.session.id.to_s)
    @orders = Order.where(session_uid: @user_id)
    # @orders = Order.where(session_uid: request.session_options[:id])
    # @orders = Order.all
  end

  def all
    @orders = Order.all
    render 'orders/index'
  end

  def show; end

  def edit; end

  # create_from_table
  # params[:table_id]
  # def create
  #   # @order = Order.find_or_create_by(session_uid: request.session.id.to_s)
  #   @order = Order.new(order_params)
  #   @order.status = Order.statuses[:draft]
  #   @order.session_uid = session.id
  #   respond_to do |format|
  #     if @order.save
  #       format.html { redirect_to order_url(@order), notice: 'Order was successfully created.' }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def update
    # @order.update(order_params)
    # redirect_to root_url
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: 'Order was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status)
  end
end
