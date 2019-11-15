class CustomersController < ApplicationController
  
  CUSTOMER_FIELDS = ['id', 'name', 'phone', 'postal_code', 'registered_at']

  def index
    customers = Customer.all
    # binding.pry
    render json: customers.as_json(only: CUSTOMER_FIELDS), status: :ok
  end 
end
