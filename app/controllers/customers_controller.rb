class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render json: customers.as_json(only: [:id, :name, :phone, :postal_code, :registered_at]), status: :ok
  end
end
