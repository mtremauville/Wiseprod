class CustomersController < ApplicationController
  before_action :authenticate_user!

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer, notice: "Client créé : #{@customer.matricule}"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def search
    if params[:q].present?
      term = "%#{Customer.sanitize_sql_like(params[:q])}%"
      @customers = Customer.where(
        "first_name LIKE :term OR last_name LIKE :term OR phone LIKE :term OR email LIKE :term OR matricule LIKE :term",
        term: term
      ).order(:last_name, :first_name).limit(50)
    else
      @customers = Customer.none
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :postal_address, :phone)
  end
end
