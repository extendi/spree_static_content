class RemoveStoreRelationships < ActiveRecord::Migration
  def change
    drop_table :spree_pages_stores
  end
end
