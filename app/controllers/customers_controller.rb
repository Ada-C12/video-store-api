class CustomersController < ApplicationController
  def index
    if params[:sort] == "name"
      customers = Customer.sort_by_name
    else
      customers = Customer.all
    end

    if params[:n] && params[:p]
      new_array = Customer.group_by_n(params[:n], params[:sort])
      customers = new_array[params[:p].to_i - 1]
    end

    render json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count]), status: :ok
    return
  end
end
