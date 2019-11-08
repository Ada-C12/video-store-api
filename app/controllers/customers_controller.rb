class CustomersController < ApplicationController
  KEYS = [:id, :name, :address, :city, :state, :postal_code, :phone, :registered_at, :movies_checked_out_count]
  
  def index
    if ["name","registered_at", "postal_code"].include? params[:sort]
      sort_value = params[:sort]
    else
      sort_value = "id" 
    end
    
    customers = Customer.order(sort_value).as_json(only: KEYS)
    render json: customers, status: :ok
  end
end
