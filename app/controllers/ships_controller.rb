class ShipsController < ApplicationController
  def index
    @ships = Ship.all
  end

  def show
    @ship = Ship.find(params[:id])
    @available_status = available_status(@ship.available)
    
  end

  private

  def available_status(available)
    if available
      return "Ce vaisseau est disponible"
    else
      return "Désolé, ce vaisseau n'est pas disponible"
    end
  end
  
end
# frfrfr