class AddExtensionHstore < ActiveRecord::Migration[7.0]
  def up
    enable_extension :hstore
  end

  def down
    disable_extension :hstore
  end
end
