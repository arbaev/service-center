# frozen_string_literal: true

class Staff::OrgTypeController < ApplicationController
  def index
    render json: { data: OrgType.all.pluck(:name) }, status: :ok
  end
end
