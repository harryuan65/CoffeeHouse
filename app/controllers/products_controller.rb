#
# Product Pages
#
class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.assign_attributes(product_params)

    if @product.save
      # https://stackoverflow.com/questions/71981471/why-is-my-flash-now-not-outputting-after-a-render
      # redirect_to product_path(@product), notice: "成功更新商品"
      flash[:notice] = "成功更新商品"
      redirect_to product_path(@product)
    else
      render :edit, alert: @product.errors.full_messages.join(", ")
    end
  end

  private

  def product_params
    params.require(:product).permit(:content, :name, :sku, :image_url, :price, :available_count, :created_at, :updated_at)
  end
end
