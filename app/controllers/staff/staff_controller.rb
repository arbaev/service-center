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

  def update
    @staff = Staff.find(params[:id])

    if @staff.update(staff_params)
      render json: serializer.new(@staff), status: :ok
    else
      render json: { errors: @staff.errors }, status: :unprocessable_entity
    end
  end

  def reset_password
    @staff = Staff.find(params[:id])
    @staff.send_reset_password_instructions

    head :no_content
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
