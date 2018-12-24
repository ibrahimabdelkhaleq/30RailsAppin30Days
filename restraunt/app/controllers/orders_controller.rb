class OrdersController < ApplicationController
 

  # GET /orders
  def index
    @orders = Order.all

    render json: @orders
  end

  # POST /orders
  def create
    @table = Table.find(params[:table_id])
    @order = @table.orders.build(order_params)

    if @order.save
      render json: @order, status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end
  def add
    @order = Order.find(params[:id])
    order_item = OrderItem.where(order_id: @order.id,item_id:params[:item_id]).first.increment(:quantity) rescue
    order_item = @order.order_items.build(item_id: params[:item_id])
    if order_item.save
    render json: order_item, status: :created
    else
      render json: order_item.errors, status: :unprocessable_entity
    end
  end
  
def pay
  @order = Order.find(params[:id])
  if @order.total_amount ==params[:amount]
    @receipt = Receipt.new(order: @order, payment_method: params[:payment_method]) 
    if @receipt.save 
      render json: @receipt, status: :created
      else
      render json: @receipt.errors, status: :unprocessable_entity
    end
  else
      render json: {"message": "You didn't pay for the exact amount"},status: 422  
  end
  
end

  
  private

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:name, :email, :table_id)
    end
end
