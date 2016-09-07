class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.string  :chamber
      t.string  :congress
      t.integer :number
      t.string  :question
      t.string  :required
      t.string  :result
      t.string  :bill_id
      t.string  :roll_id
      t.string  :roll_type
      t.string  :url
      t.string  :vote_type
      t.string  :voted_at
      t.string  :year

      t.timestamps
    end
  end
end
