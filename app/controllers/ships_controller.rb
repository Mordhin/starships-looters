class ShipsController < ApplicationController
  before_action :set_ship, only: [:show, :destroy, :edit, :update]
  def index
    @ships = Ship.all
  end

  def show
    @available_status = available_status(@ship.available)
  end

  def new
    @ship = Ship.new
  end

  def create
    @ship = Ship.new(ship_params)
    user = current_user
    @ship.user = user


    @ship.save

    redirect_to ship_path(@ship)
  end

  def destroy
    @ship.destroy
    redirect_to ships_path
  end

  def edit
  end

  def update
    @ship.update(ship_params)
    redirect_to ship_path(@ship)
  end

  def profil
    @ships = Ship.where(user_id: current_user.id)
  end

  private

  def set_ship
    @ship = Ship.find(params[:id])
  end

  def available_status(available)
    if available
      return "Ce vaisseau est disponible"
    else
      return "Désolé, ce vaisseau n'est pas disponible"
    end
  end

  def ship_params
    params.require(:ship).permit(:name, :description, :location, :purpose, :size, :crew_capacity, :price_per_day, :available, :photo)
  end
end
