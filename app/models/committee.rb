class Committee < ApplicationRecord
  self.primary_key = 'committee_id'

  has_many :committee_memberships, foreign_key: :committee_id, primary_key: :committee_id
  has_many :legislators, through: :committee_memberships
end
