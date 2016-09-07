class Bill < ApplicationRecord
  def self.scrub_params(hash)
    hash.select { |k| self.attribute_names.index(k) }
  end

  belongs_to :legislator, foreign_key: :sponsor_id, primary_key: :bioguide_id
  alias_attribute :sponsor, :legislator
end
