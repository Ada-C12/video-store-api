class CustomersController < ApplicationController
  def index
    if params[:sort] || params[:n]
      customers = Customer.group_by_n(params[:n], params[:sort], params[:p])
      if customers == nil
        render json: {ok: false, "errors" => ["not found"]}, status: :not_found
        return
      end
    else
      customers = Customer.all
    end  
    
    render json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count]), status: :ok
    return
  end
end
