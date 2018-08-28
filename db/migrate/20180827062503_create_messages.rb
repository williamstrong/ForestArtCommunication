class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :message_body
      t.string :subject
      t.references :person, foreign_key: true

      t.timestamps
    end
  end
end
