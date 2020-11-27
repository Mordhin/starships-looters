class PaymentsController < ApplicationController
  def new
    @order = current_user.orders.where(state: 'To pay').find(params[:order_id])
  end
end
