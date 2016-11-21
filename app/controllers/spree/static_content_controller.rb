class Spree::StaticContentController < Spree::StoreController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  layout "application"

  helper 'spree/products'

  def show
    @page = Spree::Page.visible.find_by_slug!(params[:slug])
    if shop?
      @order = current_order || Spree::Order.incomplete.find_or_initialize_by(guest_token: cookies.signed[:guest_token])
    end
  end

  private
  
  def shop?
    params[:slug] =~ /help|terms_and_conditions/
  end
  
  def accurate_title
    @page ? (@page.meta_title.present? ? @page.meta_title : @page.title) : nil
  end
end
