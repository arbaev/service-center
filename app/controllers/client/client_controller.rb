# frozen_string_literal: true

class Client::ClientController < ApplicationController
  def user
    if current_client
      options = { links: { logout_link: destroy_client_session_path } }
      render json: serializer.new(current_client, options)
    else
      render json: {}, status: :ok
    end
  end

  private

  def serializer
    ClientSerializer
  end
end
