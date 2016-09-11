class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes, id: false do |t|
      t.string  :roll_id, null: false
      t.string  :chamber
      t.string  :congress
      t.integer :number
      t.string  :question
      t.string  :required
      t.string  :result
      t.string  :bill_id
      t.string  :roll_type
      t.string  :url
      t.string  :vote_type
      t.string  :voted_at
      t.string  :year
      t.json    :summary

      t.timestamps
    end

    add_index :votes, :roll_id, unique: true
  end
end
