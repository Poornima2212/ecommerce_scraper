RSpec.describe UpdateProductJob, type: :job do
    let!(:product) { create(:product, last_fetched_at: 1.week.ago) }
  
    before do
      allow(ScraperService).to receive(:scrape).and_return({ title: "Updated Title" })
    end
  
    it 'updates product data' do
      expect {
        UpdateProductJob.perform_now(product.id)
        product.reload # Ensure we check the latest data from the DB
      }.to change { product.last_fetched_at }
    end
  end  