class CreateBills < ActiveRecord::Migration[5.0]
  def change
    create_table :bills do |t|
      t.string   :bill_id
      t.string   :chamber
      t.string   :short_title
      t.string   :official_title
      t.string   :sponsor_id
      t.datetime :introduced_on
      t.datetime :last_action_at
      t.string   :pdf
      t.json     :history
      t.string   :related_bill_ids, array: true, default: []

      t.timestamps
    end
  end
end
