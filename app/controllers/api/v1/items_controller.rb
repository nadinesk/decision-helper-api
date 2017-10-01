class Api::V1::ItemsController < ApplicationController

  before_action :current_user
  
  def index
    
    @items = Decision.find_by(id: params[:decision_id])&.items
    
    if @items 
    	render 'items/items.json.jbuilder', items: @items
    else 
    	render json: {
    		errors: {
    			message: "Page not found"
    		}, status: 404
    	}
    end
   end

  def show
    @item = Item.find_by(id: params[:id])
    if @item
      render 'items/item.json.jbuilder', item: @item
    else
      render json: {
        errors: {
          message: "Page not found"
        }
      }, status: 404
    end
   end

   def create
   	
   	@user = User.find_by(id: params[:user_id])

    if @user.id == current_user.id
   		@decision = Decision.find(params[:decision_id])
	    @item = @decision.items.build(item_params)

	    @item.save
	     if @item.save
	       render '/items/item.json.jbuilder', item: @item
	     else
	       render json: {
   					errors: @item.errors.full_messages
   				}, status: 500
	      end
	   else
   		 render json: {
   				errors: [
   					{message: "No permission to add decisions"}
   				]
   			}, status: 403
   	 end
  end

   def destroy
     item = Item.find(params[:id])
      if item
        item.destroy
        head :no_contnet
      else
        render json: {
          errors: {
            message: "Page not found"
          }
        }, status: 404
      end

  end

  def update
      @user = User.find_by(id: params[:user_id])
      if @user.id == current_user.id
        @item = Item.find(params[:id])
        if @item.update_attributes(item_params)
          render '/items/item.json.jbuilder', item: @item
        else
          render json: {
            errors: @item.errors.full_messages
          }, status: 500
        end
      else
        render json: {
          errors: [
            {message: "You don't have permission to edit"}
          ]
        }, status: 403
      end
   end


 	private

    def item_params
      params.require(:item).permit(:description, :category, :weight)
    end





end
