# frozen_string_literal: true

class Client::HomeController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_client!, only: :user
  before_action :authenticate_staff!, only: :create

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

  def user
    options = { links: { logout_link: destroy_client_session_path } }

    render json: serializer.new(current_client, options)
  end

  private

  def serializer
    ClientSerializer
  end

  def client_params
    params.permit(:fullname, :phone, :email, :password)
  end
end
