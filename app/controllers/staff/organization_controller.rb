# frozen_string_literal: true

class Staff::OrganizationController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_staff!

  def index
    render json: serializer.new(Organization.all)
  end

  def create
    org_type = OrgType.find(organization_params[:org_type_id])
    @organization = org_type.organizations.new(organization_params)

    if @organization.save
      render json: serializer.new(@organization), status: :created
    else
      render json: { errors: @organization.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @organization = Organization.find(params[:id])

    if @organization.destroy
      render json: serializer.new(@organization), status: :ok
    else
      render json: { errors: @organization.errors }, status: :unprocessable_entity
    end
  end

  private

  def serializer
    OrganizationSerializer
  end

  def organization_params
    params.require(:organization).permit(:name, :org_type_id, :inn, :ogrn)
  end
end
