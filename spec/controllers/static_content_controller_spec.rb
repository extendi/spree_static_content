require 'spec_helper'

describe Spree::StaticContentController do
  before do
    controller.stub spree_current_user: nil
  end

  context '#show' do

    it 'accepts path as string' do
      page = create(:page, slug: 'hello')
      controller.request.stub(:slug).and_return(page.slug)
      spree_get :show, slug: page.slug
      expect(response).to be_success
    end

    it 'accepts path as nested' do
      page = create(:page, slug: 'aa/bb/cc')
      controller.request.stub(:slug).and_return(page.slug)
      spree_get :show, slug: page.slug
      expect(response).to be_success
    end

    it 'respond with a 404 when no page exists' do
      spree_get :show, slug: 'not_existent'
      expect(response.response_code).to eq(404)
    end
  end
end
