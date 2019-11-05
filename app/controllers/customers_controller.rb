class CustomersController < ApplicationController
  def index
    customers = Customer.all.as_json
    render json: customers, status: :ok
  end
end
