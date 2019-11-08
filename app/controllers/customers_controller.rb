class CustomersController < ApplicationController
  def index
    if params[:sort] || params[:n] || params[:p]
      if !params[:n].nil? && params[:n].to_i <= 0
        render json: {ok: false, "errors" => ["unable to group customers"]}, status: :bad_request
        return
      elsif !params[:p].nil? && params[:p].to_i <= 0
        render json: {ok: false, "errors" => ["unable to group customers"]}, status: :bad_request
        return
      elsif !params[:sort].nil? && !["name", "registered_at", "postal_code"].include?(params[:sort])
        render json: {ok: false, "errors" => ["unable to group customers"]}, status: :bad_request
        return
      else
        customers = Customer.group_by_n(params[:sort], params[:n], params[:p])
      end        
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
