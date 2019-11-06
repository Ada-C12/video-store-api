CUSTOMER_KEYS = ["id", "name", "address", "city", "state", "postal_code", "phone", "movies_checked_out_count"]

class CustomersController < ApplicationController

  # def zomg
  #   working = "it works!"
  #   render json: working, status: :ok
  # end

  def index
  customers = Customer.all.as_json(only: CUSTOMER_KEYS)
  render json: customers, status: :ok
  end

end
