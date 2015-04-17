Deface::Override.new(
  virtual_path: 'spree/admin/shared/_main_menu',
  name: 'add_pages_tab',
  insert_before: "erb[silent]:contains('Spree.user_class')",
  partial: 'spree/admin/shared/pages_sidebar_menu')
