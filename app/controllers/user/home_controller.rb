class User::HomeController < ApplicationController
  before_action :authenticate_user_client!, only: :index

  def index
  end
end
