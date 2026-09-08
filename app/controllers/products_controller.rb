class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [ :demo_login ]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

def generate_sales_argument
  @product = Product.find(params[:id])
  selected_services = Array(params[:services])

  generator = SalesArgumentGenerator.new(@product, selected_services)
  response = generator.call

  redirect_to @product, notice: "Argumentaire généré avec succès",
    flash: { sales_argument: response, sales_argument_services: selected_services.join(",") }
end

  def demo_login
    demo_user = User.find_by(email: "demo@wiseprod.fr")
    sign_in(demo_user)
    redirect_to products_path, notice: "Connecté avec le compte démo"
  end
end
