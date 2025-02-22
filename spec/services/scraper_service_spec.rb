require 'rails_helper'

RSpec.describe ScraperService, type: :service do
  let(:valid_url) { 'https://example.com/product' }
  let(:invalid_url) { 'invalid-url' }

  describe '.scrape' do
    context 'with a valid URL' do
      it 'returns a hash with product details' do
        allow(HTTParty).to receive(:get).and_return(double(code: 200, body: '<html><head><meta name="twitter:title" content="Test Product"></head></html>'))
        result = ScraperService.scrape(valid_url)
        expect(result[:title]).to eq('Test Product')
      end
    end

    context 'with an invalid URL' do
      it 'returns nil' do
        expect(ScraperService.scrape(invalid_url)).to be_nil
      end
    end
  end
end