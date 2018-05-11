class CustomersController < ApplicationController
  # TODO add error handling with valid messages
  # TODO add unit test 
  def index
     page = params[:page].present? ? params[:page] : 1
     limit = params[:limit].present? ? params[:limit] : 50
    begin     
      @customers = Bigcommerce::Customer.all(page: page, limit: limit).collect{|c| [c.first_name + ' ' + c.last_name, c.id]}
      @order_ids = Bigcommerce::Order.all.collect(&:customer_id)
    rescue => e
      puts e.to_s
    end     
  end

  def show
    page = params[:page].present? ? params[:page] : 1
    limit = params[:limit].present? ? params[:limit] : 50
    begin
      @customer = Bigcommerce::Customer.find(params[:id])
      @orders = Bigcommerce::Order.all(customer_id: params[:id], page: page, limit: limit).collect{|o| [o.date_created, o.id, o.total_inc_tax]}
      @lifetime_value = @orders.collect { |order| order[2]}.map(&:to_f).inject(:+)
    rescue => e
      puts e.to_s
    end
  end

end

