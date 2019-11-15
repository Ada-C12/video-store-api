CUSTOMER_KEYS = ["address", "city", "id", "movies_checked_out_count", "name", "phone", "postal_code", "registered_at", "state"] 

class CustomersController < ApplicationController
  before_action :find_customer, only: [:show]
  
  def index
    customers = Customer.all.as_json(only: CUSTOMER_KEYS)
    render json: customers, status: :ok
  end
  
  def show
    if @customer.nil?
      render json: {"errors"=>["not found"]}, status: :not_found
      return
    else
      render json: @customer.as_json(only: CUSTOMER_KEYS), status: :ok
      return
    end
  end
  
  private
  
  def customer_params
    params.require(:customer).permit("id", "name", "address", "city", "state", "postal_code", "phone", "registered_at", "movies_checked_out_count")
  end
  
  def find_customer
    @customer = Customer.find_by(id: params[:id])
  end
end
