# frozen_string_literal: true

class Staff::StaffController < ApplicationController
  def user
    if current_staff
      options = { links: { logout_link: destroy_staff_session_path } }
      render json: serializer.new(current_staff, options)
    else
      render json: {}, status: :ok
    end
  end

  private

  def serializer
    StaffSerializer
  end
end
