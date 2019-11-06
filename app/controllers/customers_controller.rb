class CustomersController < ApplicationController

  def zomg
    working = "it works!"
    render json: working, status: :ok
  end

  

end
