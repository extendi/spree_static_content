module Spree::PagesHelper
  def render_snippet(slug)
    page = Spree::Page.find_by_slug(slug)
    raw page.body if page
  end
  
  def static_page_path slug
    page = Spree::Page.where(slug: slug).first
    if page.present?
      spree.static_path page.slug
    end
  end
  
  def careers_path
    
  end
  
  def help_path
    static_page_path 'help'
  end
  
  def terms_and_conditions_path
    static_page_path 'terms_and_conditions'
  end
  
  def privacy_path
    static_page_path 'privacy'
  end
  
  def legal_path
    static_page_path 'legal'
  end
  
  def know_how_path
    
  end
end