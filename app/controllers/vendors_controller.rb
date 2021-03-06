class VendorsController < ApplicationController
  autocomplete :city, :name,:full => true
    def index
      if params[:search]
        @vendors = Vendor.search(params[:search]).order("created_at DESC")
      else
        @vendors = Vendor.all.order('created_at DESC')
      end
    end
          
    def show
      @vendor = Vendor.find(params[:id])
    end
     
    def new
      @vendor = Vendor.new
      @vendor.build_tax
    end
          
    def edit
      @vendor = Vendor.find(params[:id])
    end
          
    def create
      @vendor = Vendor.new(vendor_params)
      if @vendor.save
        flash.now[:success] = "Vendor is created sucessfully."
        redirect_to vendors_path
      else
        flash.now[:error] = "Vendor is not created . something wrong."
        render 'new'
      end
    end
          
    def update
      @vendor = Vendor.find(params[:id])
          
      if @vendor.update(vendor_params)
        flash.now[:success] = "Item is updated sucessfully."
        redirect_to @vendor
      else
        flash.now[:error] = "Vendor is not updated . something wrong."
        render 'edit'
      end
    end
          
    def destroy
      @vendor = Vendor.find(params[:id])
      @vendor.destroy
      flash.now[:success] = "Vendor is deleted sucessfully."      
      redirect_to vendors_path
    end

    def item
      @vendor = Vendor.find(params[:vendor_id])
      @categories = Product.select(:menu_category).where(vendor_id: params[:vendor_id]).group(:menu_category)
    end


    

    private
    def vendor_params
      params.require(:vendor).permit(:name,:tagline,:description,:featured_image,:order_fulfillment_time_in_minutes,:price_point,:city,:category_ids => [],tax_attributes: [:desc,:amount,:is_percentage,:terms]).merge(user_id: current_user.id)
    end
end
#