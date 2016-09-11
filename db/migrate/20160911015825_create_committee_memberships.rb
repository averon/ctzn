class CreateCommitteeMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :committee_memberships do |t|
      t.string :committee_id, null: false
      t.string :legislator_id, null: false

      t.timestamps
    end

    add_index :committee_memberships, [:committee_id, :legislator_id], unique: true
  end
end
