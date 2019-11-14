class CustomersController < ApplicationController
    KEYS = [:id, :name, :registered_at, :address, :city, :movies_checked_out_count, :state, :postal_code, :phone]
    def index
        customers = Customer.all.as_json(only: KEYS)
        render json: customers, status: :ok
    end
    
    
    private
    
    def customer_params
        params.permit(:id, :name, :registered_at, :address, :city, :state, :movies_checked_out_count, :postal_code, :phone)
    end
    
end
