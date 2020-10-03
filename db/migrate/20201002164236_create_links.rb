class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :full_url, nil: false
      t.string :slug, nil: false

      t.timestamps
    end
  end
end
