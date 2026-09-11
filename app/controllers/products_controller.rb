class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [ :demo_login ]

  SORT_OPTIONS = {
    "price_asc" => { price: :asc },
    "price_desc" => { price: :desc },
    "name_asc" => { name: :asc }
  }.freeze

  def index
    @categories = Product.distinct.order(:category).pluck(:category)

    @products = Product.all
    @products = @products.where(category: params[:category]) if params[:category].present?
    if params[:q].present?
      term = "%#{Product.sanitize_sql_like(params[:q])}%"
      @products = @products.where("name LIKE :term OR CAST(price AS TEXT) LIKE :term", term: term)
    end
    @products = @products.order(SORT_OPTIONS.fetch(params[:sort], { name: :asc }))
  end

  def show
    @product = Product.find(params[:id])
    if @product.sales_argument.blank?
      @product.update(sales_argument: SalesArgumentGenerator.new(@product).call)
    end

    @alternative_products = Product.where(category: @product.category)
      .where.not(id: @product.id)
      .order(Arel.sql("ABS(price - #{@product.price})"))
      .limit(2)
  end

  def demo_login
    demo_user = User.find_by(email: "demo@wiseprod.fr")
    sign_in(demo_user)
    redirect_to root_path, notice: "Connecté avec le compte démo"
  end
end
