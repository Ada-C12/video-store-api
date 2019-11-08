class CustomersController < ApplicationController
  SORT_CATEGORIES = ["name", "registered_at", "postal_code"]
  
  def index
    if params[:sort] && SORT_CATEGORIES.include?(params[:sort]) == false
      render json: {ok: false, "errors" => ["invalid sort category"]}, status: :bad_request
      return
    end

    if params[:sort] || params[:n] || params[:p]
      customers = Customer.group_by_n(params[:sort], params[:n], params[:p])
      
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
