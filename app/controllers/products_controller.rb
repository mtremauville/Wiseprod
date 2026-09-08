class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [ :demo_login ]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def generate_sav_response
    @product = Product.find(params[:id])
    situation = params[:situation]

    generator = SavResponseGenerator.new(@product, situation)
    response = generator.call

    GeneratedContent.create(
      content_type: "sav_response",
      prompt: situation,
      response: response,
      product: @product
    )

    redirect_to @product, notice: "Réponse générée avec succès"
  end

  def demo_login
    demo_user = User.find_by(email: "demo@wiseprod.fr")
    sign_in(demo_user)
    redirect_to products_path, notice: "Connecté avec le compte démo"
  end
end
