class ShipsController < ApplicationController
  def index
    @ships = Ship.all
  end

  def show
    @ship = Ship.find(params[:id])
    @available_status = available_status(@ship.available)
    # lol
    
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

  private

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
