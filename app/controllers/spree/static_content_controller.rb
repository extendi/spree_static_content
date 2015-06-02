class Spree::StaticContentController < Spree::StoreController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  layout 'application'

  helper 'spree/products'

  def show
    @page = Spree::Page.by_store(current_store).visible.find_by_slug!(params[:slug])
  end

  private
    def accurate_title
      @page ? (@page.meta_title.present? ? @page.meta_title : @page.title) : nil
    end
end
