class ConsultationsController < ApplicationController
  before_action :authenticate_user!

  DEVICE_TYPE_VALUES = %w[ordinateur tablette smartphone].freeze

  def device_type
  end

  def save_device_type
    session[:consultation] = { "device_type" => params[:device_type] }
    redirect_to usage_consultations_path
  end

  def usage
    redirect_to root_path unless session[:consultation]
  end

  def save_usage
    session[:consultation]["usage_type"] = params[:usage_type]
    redirect_to budget_consultations_path
  end

  def budget
    redirect_to root_path unless session[:consultation]
  end

  def save_budget
    session[:consultation]["budget_range"] = params[:budget_range]

    if session[:consultation]["device_type"] == "je_ne_sais_pas"
      redirect_to mobility_consultations_path
    else
      redirect_to priority_consultations_path
    end
  end

  def mobility
    redirect_to root_path unless session[:consultation]
  end

  def save_mobility
    session[:consultation]["mobility"] = params[:mobility]
    redirect_to priority_consultations_path
  end

  def priority
    redirect_to root_path unless session[:consultation]
  end

  def save_priority
    device_type = session[:consultation]["device_type"]
    resolved_category_hint = DEVICE_TYPE_VALUES.include?(device_type) ? device_type : session[:consultation]["mobility"]

    @consultation = Consultation.create!(
      device_type: device_type,
      usage_type: session[:consultation]["usage_type"],
      budget_range: session[:consultation]["budget_range"],
      mobility: resolved_category_hint,
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
