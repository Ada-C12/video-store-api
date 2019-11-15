class CustomersController < ApplicationController
  def index
    customers = Customer.all
    
    if params[:sort]
      customers = customers.order(params[:sort])
    end
    
    if params[:p] || params[:n]
      customers = customers.paginate(page: params[:p], per_page: params[:n])
    end
    
    find_customers = customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count])
    render json: find_customers, status: :ok
    
  end
end
