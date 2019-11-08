CUSTOMER_KEYS = [:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone, :movies_checked_out_count]

class CustomersController < ApplicationController

  def index
    customers = Customer.all.as_json(only: CUSTOMER_KEYS)
    render json: customers, status: :ok
  end

  def show
    customer = Customer.find_by(id: params[:id])
    
    if customer
      render json: customer.as_json(only: CUSTOMER_KEYS), status: :ok
      return
    else
      render json: {"errors" => ["not found"]}, status: :not_found
      return
    end
  end
  
  def create
    customer = Customer.new(customer_params)

    if customer.save
      render json: customer.as_json(only: [:id, :name]), status: :created
      return 
    else
      render json: {ok: false, errors: customer.errors.messages}, status: :bad_request
    end
  end

  private

  def customer_params
    params.require(:customer).permit(CUSTOMER_KEYS)
  end
end
