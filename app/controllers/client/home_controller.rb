# frozen_string_literal: true

class Client::HomeController < ApplicationController
  before_action :authenticate_client!

  def index; end

  def user
    options = { links: { logout_link: destroy_client_session_path } }

    render json: serializer.new(current_client, options)
  end

  private

  def serializer
    UserSerializer
  end
end
