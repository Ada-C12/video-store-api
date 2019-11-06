class CustomersController < ApplicationController

  def index
    customers = Customer.all 
    render json: { customers.as_json(only: [:name, :registered_at, :address, :city, :state, :postal_code, :phone]), customers.movies.count }, status: :ok
  end

end
