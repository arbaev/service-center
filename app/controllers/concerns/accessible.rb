# frozen_string_literal: true

module Accessible
  extend ActiveSupport::Concern

  included do
    before_action :check_user
  end

  protected

  def check_user
    if current_staff
      flash.clear
      redirect_to(staff_home_index_path) && return
    elsif current_client
      flash.clear
      redirect_to(client_home_index_path) && return
    end
  end
end
