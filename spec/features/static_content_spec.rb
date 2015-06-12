require 'spec_helper'

feature 'Static Content Page', js: true do

  context 'render page' do
    scenario 'is a query string' do
      create(:page, slug: 'faq', title: 'Query Test')
      visit '/page/faq'
      expect(page).to have_text 'Query Test'
    end

    scenario 'can have slug with multiple /' do
      create(:page, slug: 'hello/shoppers/page3', title: 'Multiple Slash Test')
      visit '/page/hello/shoppers/page3'
      expect(page).to have_text 'Multiple Slash Test'
    end


    scenario 'fetch correct page' do
      create(:page, slug: 'page')
      create(:page, slug: 'hello', title: 'Hello')
      create(:page, slug: 'somewhere')
      create(:page, :with_foreign_link, slug: 'whatever')
      visit '/page/hello'
      expect(page).to have_text 'Hello'
    end

    scenario 'do not effect the rendering of the rest of the site' do
      product = create(:product)
      visit spree.product_path(product)
      expect(page).to have_text product.name
    end
  end
end
