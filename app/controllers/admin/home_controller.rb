class Admin::HomeController < ApplicationController
  before_action :authenticate_admin_staff!, only: :index

  def index
  end
end
