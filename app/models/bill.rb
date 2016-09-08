class Bill < ApplicationRecord
  belongs_to :legislator, foreign_key: :sponsor_id, primary_key: :bioguide_id
  alias_attribute :sponsor, :legislator
end
