class CustomersController < ApplicationController
  KEYS = [:id, :name, :address, :city, :state, :postal_code, :phone, :registered_at3, :registered_at, :created_at]
  
  def index
    customers = Customer.all.as_json(only: KEYS)
    render json: customers, status: :ok
  end
end
