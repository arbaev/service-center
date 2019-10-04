# frozen_string_literal: true

class Staff::OrganizationController < ApplicationController
  before_action :authenticate_staff!

  def index
    render json: serializer.new(Organization.all)
  end

  private

  def serializer
    OrganizationSerializer
  end
end
