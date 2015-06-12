class Spree::Page < ActiveRecord::Base
  default_scope -> { order("position ASC") }

  validates_presence_of :title
  validates_presence_of [:slug, :body], if: :not_using_foreign_link?
  validates_presence_of :layout, if: :render_layout_as_partial?

  translates :title, :body, :slug, :meta_keywords, :meta_description, :meta_title, fallbacks_for_empty_tranlsations: true
  include SpreeI18n::Translatable

  validates :slug, uniqueness: true, if: :not_using_foreign_link?
  validates :foreign_link, uniqueness: true, allow_blank: true

  validate :dont_start_with_slash

  scope :visible, -> { where(visible: true) }
  scope :header_links, -> { where(show_in_header: true).visible }
  scope :footer_links, -> { where(show_in_footer: true).visible }
  scope :sidebar_links, -> { where(show_in_sidebar: true).visible }

  before_save :update_positions_and_slug

  def initialize(*args)
    super(*args)

    last_page = Spree::Page.last
    self.position = last_page ? last_page.position + 1 : 0
  end
  
  def dont_start_with_slash
    if self.slug.starts_with? '/'
      self.errors[:slug] << 'Not valid'
    end
  end

  def link
    foreign_link.blank? ? slug : foreign_link
  end

private

  def update_positions_and_slug
    # ensure that all slugs start with a slash
    #slug.prepend('/') if not_using_foreign_link? and not slug.start_with? '/'

    unless new_record?
      return unless prev_position = Spree::Page.find(self.id).position
      if prev_position > self.position
        Spree::Page.where("? <= position AND position < ?", self.position, prev_position).update_all("position = position + 1")
      elsif prev_position < self.position
        Spree::Page.where("? < position AND position <= ?", prev_position,  self.position).update_all("position = position - 1")
      end
    end

    true
  end

  def not_using_foreign_link?
    foreign_link.blank?
  end
end
