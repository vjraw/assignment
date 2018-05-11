class CustomersController < ApplicationController

  def index
     page = params[:page].present? ? params[:page] : 1
     limit = params[:limit].present? ? params[:limit] : 50
     @customers = Bigcommerce::Customer.all(page: page, limit: limit).collect{|s| [s.first_name + ' ' + s.last_name, s.id]}
     @order_ids = Bigcommerce::Order.all.collect(&:customer_id)     
  end

  def show
    page = params[:page].present? ? params[:page] : 1
    limit = params[:limit].present? ? params[:limit] : 50
    @customer = Bigcommerce::Customer.find(params[:id])
    @orders = Bigcommerce::Order.all(customer_id: params[:id], page: page, limit: limit).collect{|o| [o.date_created, o.id, o.total_inc_tax]}
    @lifetime_value = @orders.collect { |order| order[2]}.map(&:to_f).inject(:+)
  end

end

