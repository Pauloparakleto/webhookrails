class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.integer :issue_id
      t.string :name

      t.timestamps
    end
  end
end
