class Legislator < ApplicationRecord
  self.primary_key = 'bioguide_id'

  attr_accessor :vote

  has_many :bills, foreign_key: :sponsor_id, primary_key: :bioguide_id
  has_many :cast_votes, foreign_key: :legislator_id, primary_key: :bioguide_id
  has_many :votes, through: :cast_votes
  has_many :committee_memberships, foreign_key: :legislator_id, primary_key: :bioguide_id
  has_many :committees, through: :committee_memberships

  def img
    "https://theunitedstates.io/images/congress/225x275/#{bioguide_id}.jpg"
  end
end
