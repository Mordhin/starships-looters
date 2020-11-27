class ShipsController < ApplicationController
  before_action :set_ship, only: [:show, :destroy, :edit, :update]
  def index
    @ships = Ship.all.order('name ASC')
    @all_ships = false

    @search = params["search"]
    if @search.present?
      name = @search["name"]
      if name === ""
        @ships = Ship.all.order('name ASC')
        @all_ships = false
      else
        @ships = Ship.global_search(name).order('name ASC')
        @all_ships = true
      end
    end

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
    @ship = Ship.find(params[:id])
  end

  def update
    if  @ship.update(ship_params)
      @ship.save
      redirect_to ship_path(@ship)
    else
      render :edit
    end
  end

  def profil
    @ships = Ship.where(user_id: current_user.id).order('name ASC')
    @all_my_ships = false

    @search = params["search"]
    if @search.present?
      name = @search["name"]
      if name === ""
        @ships = Ship.where(user_id: current_user.id).order('name ASC')
        @all_my_ships = false
      else
      @ships = Ship.where(user_id: current_user.id).order('name ASC').global_search(name)
      @all_my_ships = true
      end
    end
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
