class ProductsController < ApplicationController
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
end
