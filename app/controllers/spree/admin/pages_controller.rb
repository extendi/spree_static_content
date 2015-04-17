module Spree
  class Admin::PagesController < Admin::ResourceController
    def index
      per_page = params[:per_page] || 20
      @pages = Spree::Page.page(params[:page]).per(per_page)
    end
  end
end
