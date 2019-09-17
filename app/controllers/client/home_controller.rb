# frozen_string_literal: true

class Client::HomeController < ApplicationController
  before_action :authenticate_client!, only: :index

  def index; end
end
