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
      render json: { errors: @client.errors }, status: :unprocessable_entity
    end
  end

  def update
    @client = Client.find(params[:id])

    if @client.update(client_params)
      render json: serializer.new(@client), status: :ok
    else
      render json: { errors: @client.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @client = Client.find(params[:id])

    if @client.destroy
      render json: serializer.new(@client), status: :ok
    else
      render json: { errors: @client.errors }, status: :unprocessable_entity
    end
  end

  def validation
    @client = Client.new(client_params)
    if @client.valid?
      render json: serializer.new(@client), status: :ok
    else
      render json: { errors: @client.errors }, status: :unprocessable_entity
    end
  end

  private

  def serializer
    ClientSerializer
  end

  def client_params
    params.require(:client).permit(:fullname, :phone, :email, :password)
  end
end
