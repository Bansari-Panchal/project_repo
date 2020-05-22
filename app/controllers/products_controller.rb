class ProductsController < ApplicationController
  def index
    @vendor = Vendor.find(params[:vendor_id])
    @products = Product.all.where(:vendor_id => @vendor.id)
  end
        
  def show
    @product = Product.find(params[:id])
  end
        
  def new
    @product = Product.new
    @vendor = Vendor.find(params[:vendor_id])
    @vendor.products.build
    @product.choices.build
    #@product.choices.options.build
  end
        
  def edit
    @vendor = Vendor.find(params[:vendor_id])
    @product = Product.find(params[:id])
    
  end
        
  def create
    @vendor = Vendor.find(params[:vendor_id])
    @product = @vendor.products.build(product_params)
      if @product.save
        redirect_to vendor_products_path
      else
        render 'new'
      end
  end
        
  def update
    @vendor = Vendor.find(params[:vendor_id])
    @product = @vendor.products.find(params[:id])
        
    if @product.update(product_params)
      redirect_to vendor_products_path
    else
      render 'edit'
    end
  end
        
  def destroy
    @vendor = Vendor.find(params[:vendor_id])
    @product = @vendor.products.find(params[:id])
    @product.destroy
    redirect_to vendor_path(@vendor)
  end
 
   private
    def product_params
          params.require(:product).permit(:vendor_id,:name,:cost_in_dollars,:description,:menu_category,:item_tags,:availability,:popular,:item_image,:is_catering, choices_attributes:[:id, :name, :allow_multiple, :_destroy,options_attributes: [:id, :name, :cost_in_dollars,  :choice_id,:_destroy]])
    end
              
             
end
#[:id,:name,:allow_multiple,:_destroy]