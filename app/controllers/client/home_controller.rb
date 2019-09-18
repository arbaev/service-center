# frozen_string_literal: true

class Client::HomeController < ApplicationController
  before_action :authenticate_client!

  def index; end

  def user
    @user = current_client
  end
end
