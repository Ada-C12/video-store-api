class ApplicationController < ActionController::API

  def not_found
    render json: { 
      ok: false, 
      errors: ["Not Found"] 
      }, status: :not_found
  end 

  def bad_request
    render json: { 
      ok: false, 
      errors: pet.errors.messages 
      }, status: :bad_request
  end 

end
