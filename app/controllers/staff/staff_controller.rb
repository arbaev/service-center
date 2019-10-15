# frozen_string_literal: true

class Staff::StaffController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_staff!, only: %i[index create]

  def index
    render json: serializer.new(Staff.all)
  end

  def create
    @staff = Staff.new(staff_params)

    if @staff.save
      render json: serializer.new(@staff), status: :created
    else
      render json: { errors: @staff.errors }, status: :unprocessable_entity
    end
  end

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

  def staff_params
    params.require(:staff).permit(:email, :password)
  end
end
