class CreateCastVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :cast_votes do |t|
      t.string :legislator_id, null: false
      t.string :roll_id,       null: false
      t.string :vote_cast,     null: false

      t.timestamps
    end
  end
end
