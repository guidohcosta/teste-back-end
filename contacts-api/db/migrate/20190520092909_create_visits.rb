class CreateVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.string :identifier
      t.string :url

      t.timestamps
    end
  end
end
