class CustomersController < ApplicationController

  def index 
    @customers = Customer.all
    customers = Customer.all.as_json(only: [:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone])
    render json: customers, status: :ok 
  end 

  def show 
    customer = Customer.find_by(id: params[:id])

    if customer
      render json: customer.as_json(only: [:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone])
    else 
      not_found
    end 
  end 

  def create
    customer = Customer.new(customer_params)

    if customer.save
      render json: pet.as_json(only: [:id]), status: :created
      return
    else 
      bad_request(customer)
    end 
  end 

  private 
  
  def customer_params
    params.require(:customer).permit(:name, :registered_at, :address, :city, :state, :postal_code, :phone)
  end 

end
