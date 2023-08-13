class CreateAssociationPostAndTags < ActiveRecord::Migration[6.1]
  def change
    create_table :association_post_and_tags do |t|
      t.references :post, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
