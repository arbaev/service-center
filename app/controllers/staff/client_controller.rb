# frozen_string_literal: true

class Staff::ClientController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_staff!

  def index
    render json: serializer.new(Client.all)
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      render json: serializer.new(@client), status: :created
    else
      render json: { errors: @client.errors }, status: :ok
    end
  end

  private

  def serializer
    ClientSerializer
  end

  def client_params
    params.permit(:fullname, :phone, :email, :password)
  end
end
