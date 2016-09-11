class Amendment < ApplicationRecord
  belongs_to :bill, foreign_key: :amends_bill_id, primary_key: :bill_id
  belongs_to :legislator, foreign_key: :sponsor_id, primary_key: :bioguide_id
end
