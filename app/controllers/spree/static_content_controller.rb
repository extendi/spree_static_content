class Spree::StaticContentController < Spree::StoreController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  layout :choose_layout

  helper 'spree/products'

  def show
    @page = Spree::Page.visible.find_by_slug!(params[:slug])
    if shop?
      @order = current_order
    end
  end

  private
  
  def shop?
    params[:slug] =~ /help|terms_and_conditions/
  end
  
  def choose_layout
    if shop?
      'ecommerce'
    else
      'application'
    end
  end
  
  def accurate_title
    @page ? (@page.meta_title.present? ? @page.meta_title : @page.title) : nil
  end
end
