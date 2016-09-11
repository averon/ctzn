class Bill < ApplicationRecord
  self.primary_key = 'bill_id'

  belongs_to :legislator, foreign_key: :sponsor_id, primary_key: :bioguide_id
  alias_attribute :sponsor, :legislator

  has_many :votes

  def active?
    history['active']
  end

  def vetoed?
    history['vetoed']
  end

  def awaiting_signature?
    history['awaiting_signature']
  end

  def enacted?
    history['enacted']
  end
end
