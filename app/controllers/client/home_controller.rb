# frozen_string_literal: true

class Client::HomeController < ApplicationController
  before_action :authenticate_client!

  def index; end
end
