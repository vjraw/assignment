module CustomersHelper

  def orders_count(order_ids, id)
    return order_ids.count(id)
  end

  def product_count(order_id)
    return Bigcommerce::OrderProduct.count(order_id).first[1]
  end
end
