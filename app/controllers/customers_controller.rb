require 'pry'

class CustomersController < ApplicationController
  
  # def zomg
  #   working = "it works!"
  #   render json: working, status: :ok
  # end
  
  def index
    # binding.pry
    customers = Customer.all
    if KEYS.length < 2
      binding.pry
    end
    render json: customers.as_json(only: [:id, :name, :address, :city, :state, :postal_code, :phone, :movies_checked_out_count]), status: :ok
  end
  
end
