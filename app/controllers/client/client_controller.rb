# frozen_string_literal: true

class Client::ClientController < ApplicationController
  before_action :authenticate_client!

  def user
    options = { links: { logout_link: destroy_client_session_path } }

    render json: serializer.new(current_client, options)
  end

  private

  def serializer
    ClientSerializer
  end
end
