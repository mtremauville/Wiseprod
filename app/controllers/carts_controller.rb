class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @items = cart_items
    @customer = current_cart_customer
  end

  def add_product
    add_to_cart(type: "product", id: params[:product_id], services: Array(params[:services]))
    redirect_to cart_path, notice: "Ajouté au panier"
  end

  def remove_item
    session[:cart].delete_at(params[:index].to_i) if session[:cart]
    redirect_to cart_path
  end

  def clear
    session[:cart] = []
    redirect_to cart_path
  end

  def assign_customer
    customer = Customer.find(params[:customer_id])
    session[:cart_customer_id] = customer.id
    redirect_to cart_path, notice: "Panier assigné à #{customer.full_name}"
  end

  def unassign_customer
    session.delete(:cart_customer_id)
    redirect_to cart_path, notice: "Client retiré du panier"
  end

  private

  def current_cart_customer
    Customer.find_by(id: session[:cart_customer_id])
  end

  def add_to_cart(item)
    session[:cart] ||= []
    session[:cart] << item
  end

  def cart_items
    (session[:cart] || []).map do |entry|
      product = Product.find(entry["id"] || entry[:id])
      services = Array(entry["services"] || entry[:services]).filter_map { |key| FnacService.by_key(key) }
      { product: product, services: services }
    end
  end
end
