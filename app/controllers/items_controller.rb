class ItemsController < ApplicationController
  
  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find_by_id(params[:id])
  end

  # GET /items/new
  def new
    @list = List.find(params[:list_id])
    @item = @list.items.build
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @list = List.find(params[:list_id])
    @item = @list.items.create(item_params)

    if @item.save 
      redirect_to list_path(@list)
    else
      render 'new' 
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @list = List.find(params[:list_id])
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to list_path(@list)
  end

  private
  def set_list
    @list = List.find(params[:list_id])
  end

  # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :quantity, :list_id)
    end 
end