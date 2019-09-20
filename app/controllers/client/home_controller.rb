# frozen_string_literal: true

class Client::HomeController < ApplicationController
  before_action :authenticate_client!, only: :user

  def index
    render json: serializer.new(Client.all)
  end

  def user
    options = { links: { logout_link: destroy_client_session_path } }

    render json: serializer.new(current_client, options)
  end

  private

  def serializer
    UserSerializer
  end
end
