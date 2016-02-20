class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :kind
      t.string :title
      t.text :code
      t.boolean :private
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
