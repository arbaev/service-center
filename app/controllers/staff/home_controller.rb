# frozen_string_literal: true

class Staff::HomeController < ApplicationController
  before_action :authenticate_staff!

  def index; end

  def user
    options = { links: { logout_link: destroy_staff_session_path } }

    render json: serializer.new(current_staff, options)
  end

  private

  def serializer
    StaffSerializer
  end
end
