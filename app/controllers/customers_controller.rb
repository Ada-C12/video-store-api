class CustomersController < ApplicationController
  KEYS = [:id, :name, :address, :city, :state, :postal_code, :phone, :registered_at, :movies_checked_out_count]
  
  def index
    customers = Customer.all.as_json(only: KEYS)
    render json: customers, status: :ok
  end
end
