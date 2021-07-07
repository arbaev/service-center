# frozen_string_literal: true

class Staff::EquipmentController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_staff!

  def index
    render json: serializer.new(Equipment.all)
  end

  def update
    @equipment = Equipment.find(params[:id])
    @organization = params[:organization_id] == 0 ? nil : Organization.find(params[:organization_id])

    @equipment.organization = @organization

    if @equipment.update(equipment_params)
      render json: serializer.new(@equipment), status: :ok
    else
      render json: { errors: @equipment.errors }, status: :unprocessable_entity
    end
  end

  private

  def serializer
    EquipmentSerializer
  end

  def equipment_params
    params.require(:equipment).permit(:name, :kind, :sn)
  end
end
