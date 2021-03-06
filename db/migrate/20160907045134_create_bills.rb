class CreateBills < ActiveRecord::Migration[5.0]
  def change
    create_table :bills, id: false do |t|
      t.string   :bill_id, null: false
      t.string   :chamber
      t.string   :short_title
      t.string   :official_title
      t.string   :sponsor_id
      t.datetime :introduced_on
      t.datetime :last_action_at
      t.string   :pdf
      t.json     :history
      t.string   :related_bill_ids, array: true, default: []
      t.string   :committee_ids, array: true, default: []

      t.timestamps
    end

    add_index :bills, :bill_id, unique: true
  end
end
