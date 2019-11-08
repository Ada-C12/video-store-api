class CustomersController < ApplicationController
  def index
    if params[:sort]
      customers = Customer.order(params[:sort])
    elsif params[:n] && params[:p] && !params[:sort]
      customers = Customer.page(params[:p])
    elsif params[:n] && params[:p] && params[:sort]
      customers = Customer.paginate(page: params[:p], per_page: params[:n])
    else
      customers = Customer.all
    end

    find_customers = customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count])
    render json: find_customers, status: :ok
  end
end
