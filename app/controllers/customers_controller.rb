CUSTOMER_KEYS = ["address", "city", "id", "movies_checked_out_count", "name", "phone", "postal_code", "registered_at", "state"] 

class CustomersController < ApplicationController
  def zomg
    customers = Customer.all.as_json(only: CUSTOMER_KEYS)
    render json: customers, status: :ok
  end
  def index
    customers = Customer.all.as_json(only: CUSTOMER_KEYS)
    render json: customers, status: :ok
  end
  
  def show
    customer_id = params[:id]
    customer = Customer.find_by(id: customer_id)
    
    if customer
      render json: customer.as_json(only: CUSTOMER_KEYS), status: :ok
      return
    else
      render json: {"errors"=>["not found"]}, status: :not_found
      # {
      #   "errors": {
      #     "title": ["Movie 'Revenge of the Gnomes' not found"]
      #   }
      # }
      return
    end
  end
  
  private
  
  def customer_params
    params.require(:customer).permit("id", "name", "address", "city", "state", "postal_code", "phone", "registered_at", "movies_checked_out_count")
  end
end
