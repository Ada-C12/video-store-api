class CustomersController < ApplicationController
  def index
    customers = Customer.all.as_json

    if customers.empty?
      render json: { message: "No customers" }, status: :ok
    else
      render json: customers, status: :ok
    end
  end
end
