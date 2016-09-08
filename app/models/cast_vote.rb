class CastVote < ApplicationRecord
  belongs_to :legislator, foreign_key: :legislator_id, primary_key: :bioguide_id
  belongs_to :vote, foreign_key: :roll_id, primary_key: :roll_id
end
