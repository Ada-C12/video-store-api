class CustomersController < ApplicationController
  
  def index 
    @customers = Customer.all
    customers = Customer.all.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count])
    render json: customers, status: :ok 
  end 
  
  def show 
    customer = Customer.find_by(id: params[:id])
    
    if customer
      render json: customer.as_json(only: [:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone, :movies_checked_out_count])
    else 
      not_found
    end 
  end 
  
end
