class CreateCastVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :cast_votes do |t|
      t.string :legislator_id, null: false
      t.string :roll_id,       null: false
      t.string :vote_cast,     null: false

      t.timestamps
    end

    add_index :cast_votes, :legislator_id
    add_index :cast_votes, :roll_id
    add_index :cast_votes, [:legislator_id, :roll_id], unique: true
  end
end
