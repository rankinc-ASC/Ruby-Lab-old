class RestaurantsController < ApplicationController
    before_action :find_restaurant, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, only: [:new, :edit]

    def index
        if params[:search]
            @restaurants = Restaurant.search(params[:search]).order("created_at DESC")
        else
            @restaurants = Restaurant.all.order("created_at DESC")
        end
    end

    def show
        if @restaurant.reviews.blank?
            @average_review = 0
        else
            @average_review = @restaurant.reviews.average(:rating).round(2)
        end
    end

    def new
        @restaurant = current_user.restaurants.build
    end

    def create
        @restaurant = current_user.restaurants.build(restaurant_params)

        if @restaurant.save
            redirect_to root_path
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        if @restaurant.update(restaurant_params)
            redirect_to restaurant_path(@restaurant)
        else
            render 'edit'
        end
    end

    def destroy
        @restaurant.destroy
        redirect_to root_path
    end

    private
        def restaurant_params
            params.require(:restaurant).permit(:name, :description, :contactInfo)
        end

        def find_restaurant
            @restaurant = Restaurant.find(params[:id])
        end
end
