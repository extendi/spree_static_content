class AddMultilanguageToPages < ActiveRecord::Migration
  def up
      params = { title: :string, body: :text, slug: :string, meta_keywords: :string, meta_description: :string, meta_title: :string }
      Spree::Page.create_translation_table!(params, { migrate_data: true })
    end

    def down
      Spree::Page.drop_translation_table! migrate_data: true
    end
end
