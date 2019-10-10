# frozen_string_literal: true

class Staff::OrgTypeController < ApplicationController
  def index
    render json: { data: OrgType.select(:id, :name) }, status: :ok
  end
end
