class CustomersController < ApplicationController
  CUSTOMER_FIELDS = ["id", "name", "registered_at", "postal_code", "phone", "movies_checked_out_count"]
  
  # def success
  #   render json: { statement: "It works!!" }, status: :ok
  # end
  
  def index
    customers = Customer.all.as_json(only: CUSTOMER_FIELDS)
    render json: customers, status: :ok
  end
end
