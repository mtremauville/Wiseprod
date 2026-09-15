class ReceiptsController < ApplicationController
  before_action :authenticate_user!

  def new
    if session[:cart].blank?
      redirect_to cart_path, alert: "Le panier est vide" and return
    end

    @cart_customer = Customer.find_by(id: session[:cart_customer_id])
    @customer_search = params[:q]
    @customers = @customer_search.present? ? Customer.where("phone LIKE :t OR email LIKE :t", t: "%#{@customer_search}%") : Customer.none
  end

  def create
    if session[:cart].blank?
      redirect_to cart_path, alert: "Le panier est vide" and return
    end

    customer = Customer.find(params[:customer_id])
    items = session[:cart].map do |entry|
      product = Product.find(entry["id"] || entry[:id])
      services = Array(entry["services"] || entry[:services]).map { |key| FnacService.by_key(key) }
      { product: product, services: services }
    end

    @receipt = Receipt.build_from_cart(items, customer)

    if @receipt.save
      session[:cart] = []
      redirect_to @receipt
    else
      redirect_to cart_path, alert: "Erreur lors de la création du ticket"
    end
  end

  def show
    @receipt = Receipt.find(params[:id])
  end
end
