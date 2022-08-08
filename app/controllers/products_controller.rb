#
# Product Pages
#
class ProductsController < ApplicationController
  before_action :admin_required, only: %i[edit update]

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
      redirect_to product_path(@product), notice: "成功更新商品"
    else
      render :edit, alert: @product.errors.full_messages.join(", ")
    end
  end

  private

  def product_params
    params.require(:product).permit(:content, :name, :sku, :image_url, :price, :available_count, :created_at, :updated_at)
  end

  def admin_required
    return redirect_to(root_path) unless current_user&.admin?
  end
end
