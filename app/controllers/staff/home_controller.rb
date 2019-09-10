class Staff::HomeController < ApplicationController
  before_action :authenticate_staff!, only: :index

  def index
  end
end
