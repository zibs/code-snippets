class ChangePrivateToDefaultsOnSnippet < ActiveRecord::Migration
  def change
     change_column :snippets, :private, :boolean, :default => false
  end
end
