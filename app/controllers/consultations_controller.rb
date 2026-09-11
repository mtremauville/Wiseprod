class ConsultationsController < ApplicationController
  before_action :authenticate_user!

  def usage
  end

  def save_usage
    session[:consultation] = { usage_type: params[:usage_type] }
    redirect_to budget_consultations_path
  end

  def budget
    redirect_to usage_consultations_path unless session[:consultation]
  end

  def save_budget
    session[:consultation]["budget_range"] = params[:budget_range]
    redirect_to mobility_consultations_path
  end

  def mobility
    redirect_to usage_consultations_path unless session[:consultation]
  end

  def save_mobility
    session[:consultation]["mobility"] = params[:mobility]
    redirect_to priority_consultations_path
  end

  def priority
    redirect_to usage_consultations_path unless session[:consultation]
  end

  def save_priority
    session[:consultation]["priority"] = params[:priority]

    @consultation = Consultation.create!(
      usage_type: session[:consultation]["usage_type"],
      budget_range: session[:consultation]["budget_range"],
      mobility: session[:consultation]["mobility"],
      priority: params[:priority],
      user: current_user
    )

    session.delete(:consultation)
    redirect_to consultation_path(@consultation)
  end

  def show
    @consultation = Consultation.find(params[:id])
    @matched_products = ProductMatcher.new(@consultation).call
  end

  def generate_argument
    @consultation = Consultation.find(params[:id])
    product = Product.find(params[:product_id])
    selected_services = Array(params[:services])

    generator = SalesArgumentGenerator.new(product, selected_services, @consultation)
    response = generator.call

    GeneratedContent.create(
      content_type: "sales_argument",
      prompt: product.name,
      response: response,
      services: selected_services.join(","),
      product: product
    )

    redirect_to consultation_path(@consultation), notice: "Argumentaire généré"
  end
end
