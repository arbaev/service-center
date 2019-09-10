module Accessible
  extend ActiveSupport::Concern

  included do
    before_action :check_user
  end

  protected

  def check_user
    if current_admin_staff
      flash.clear
      redirect_to(admin_home_index_path) && return
    elsif current_user_client
      flash.clear
      redirect_to(user_home_index_path) && return
    end
  end
end
