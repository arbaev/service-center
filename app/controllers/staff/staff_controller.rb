# frozen_string_literal: true
class Staff::StaffController < ApplicationController
  before_action :authenticate_staff!

  def user
    options = { links: { logout_link: destroy_staff_session_path } }

    render json: serializer.new(current_staff, options)
  end

  private

  def serializer
    StaffSerializer
  end
end
