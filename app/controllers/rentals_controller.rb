class RentalsController < ApplicationController
  belongs_to :customer
  belongs_to :movie
end
