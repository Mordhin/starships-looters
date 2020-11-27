class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @ships = Ship.order('RANDOM()').limit(3)
  end

  def support
  end
end
