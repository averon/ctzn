class Legislator < ApplicationRecord
  def self.scrub_params(hash)
    hash.select { |k| self.attribute_names.index(k) }
  end

  attr_accessor :vote

  has_many :bills, foreign_key: :sponsor_id, primary_key: :bioguide_id
end
