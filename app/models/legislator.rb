class Legislator < ApplicationRecord
  attr_accessor :vote

  has_many :bills, foreign_key: :sponsor_id, primary_key: :bioguide_id
end
