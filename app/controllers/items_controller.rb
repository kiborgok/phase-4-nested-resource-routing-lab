class ItemsController < ApplicationController

  def index
    items = Item.all
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      if !user
        return render json: {error: "User not found"}, status: :not_found
      end
      items = user.items
    end
    render json: items, include: :user
  end

  def show
    item = Item.find_by(id: params[:id])
    if !item
        return render json: {error: "Item not found"}, status: :not_found
    end
    render json: item, include: :user
  end

  def create
    user = User.find_by(id: params[:user_id])
    if !user
      return render json: {error: "User not found"}, status: :not_found
    end
    item = user.items.create(item_params)
    render json: item, status: :created
  end

  private

  def item_params
    params.permit(:name, :description, :price)
  end

end
