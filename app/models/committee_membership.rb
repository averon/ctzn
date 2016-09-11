class CommitteeMembership < ApplicationRecord
  belongs_to :legislator, foreign_key: :legislator_id, primary_key: :bioguide_id
  belongs_to :committee, foreign_key: :committee_id, primary_key: :committee_id
end
