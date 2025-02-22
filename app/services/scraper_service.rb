require 'httparty'
require 'nokogiri'

class ScraperService
    def self.scrape(url)
        if url.blank? || !(url =~ URI::DEFAULT_PARSER.make_regexp)
          puts "Invalid or missing URL: #{url.inspect}"
          return nil
        end
      
        response = HTTParty.get(url, headers: { "User-Agent" => "Mozilla/5.0" })
      
        if response.code != 200
          puts "Failed to fetch the webpage. Status code: #{response.code}"
          return nil
        end
      
        parsed_page = Nokogiri::HTML(response.body)
      
        {
          title: parsed_page.at('meta[name="twitter:title"]')&.[]('content'),
          description: parsed_page.at('meta[name="twitter:description"]')&.[]('content'),
          price: parsed_page.at('div.Nx9bqj.CxhGGd')&.text&.strip,
          category: parsed_page.at("meta[property='og:category']")&.[]("content") || "Uncategorized",
          size: "N/A",
          contact_info: "N/A",
          url: url,
          last_fetched_at: Time.current
        }
    end      

    def self.scrape_and_update(product)
        scraped_data = scrape(product.url)
      
        return unless scraped_data  # Exit if scraping failed
      
        # Ensure category is properly set and linked to the product
        category_name = scraped_data[:category] || "Uncategorized"
        category = Category.find_or_create_by(name: category_name)
      
        # Update the product with scraped data and assign the correct category
        product.update!(
          scraped_data.merge(category: category, last_fetched_at: Time.current)
        )
    end      
end