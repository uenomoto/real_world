class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.string :slug
      t.text :body

      t.timestamps
    end

    add_index :articles, :slug
  end
end
