class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @products = Product.includes(:category).all
  end

  def show
    @product = Product.find(params[:id])
  
    # If product is older than a week, schedule an update
    if @product.last_fetched_at.nil? || @product.last_fetched_at.to_time < 1.week.ago
      UpdateProductJob.perform_later(@product.id)
    end
  end
  
  def new
    @product = Product.new
     Rails.logger.debug "Product instance: #{@product.inspect}"
  end

  def create
    url = params[:product][:url]
    data = ScraperService.scrape(url)

    if data.present?
      category_name = data[:category] || "Unknown" # Get category name
      category = Category.find_or_create_by(name: category_name) # Get category object
    
      @product = category.products.new(data.except(:category)) # Remove category from data hash
    
      if @product.save
        redirect_to @product, notice: "Product scraped and saved!"
      else
        render :new, alert: "Error saving product"
      end
    end    
  end
  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Product was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def search
    @products = Product.all
  
    if params[:query].present?
      @products = @products.where("LOWER(title) LIKE ?", "%#{params[:query].downcase}%")
    end
  
    if params[:category].present?
      @products = @products.joins(:category).where(categories: { name: params[:category] })
    end
  
    respond_to do |format|
      format.html { render partial: "products/list", locals: { products: @products } }
    end
  end
  

  def destroy
    @product.destroy
    redirect_to products_path, notice: "Product deleted."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :size, :contact_info, :category_id, :url, :last_fetched_at)
  end
end