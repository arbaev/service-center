# frozen_string_literal: true

class Staff::HomeController < ApplicationController
  before_action :authenticate_staff!

  def index; end
end
