class UpdateProductJob < ApplicationJob
  queue_as :default

  def perform(product_id)
    product = Product.find_by(id: product_id)
    if product.nil?
      Rails.logger.error "Product not found with ID: #{product_id}"
      return
    end

    if product.url.blank?
      Rails.logger.error "Product #{product.id} has no valid URL!"
      return
    end

    Rails.logger.info "Scraping URL: #{product.url}"
    ScraperService.scrape_and_update(product)
  end
end