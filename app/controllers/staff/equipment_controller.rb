# frozen_string_literal: true

class Staff::EquipmentController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_staff!

  def index
    render json: serializer.new(Equipment.all)
  end

  private

  def serializer
    EquipmentSerializer
  end
end
