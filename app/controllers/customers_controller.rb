class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

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
  end

  def edit
    authorize @customer
  end

  def update
    authorize @customer
    if @customer.update(customer_params)
      redirect_to @customer, notice: "Fiche client mise à jour"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @customer
    @customer.destroy
    redirect_to root_path, notice: "Client supprimé"
  end

  def search
    if params[:q].present?
      term = "%#{Customer.sanitize_sql_like(params[:q])}%"
      @customers = Customer.where("phone LIKE :term OR email LIKE :term OR matricule LIKE :term", term: term)
    else
      @customers = Customer.none
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :postal_address, :phone)
  end
end
