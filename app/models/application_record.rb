class ApplicationRecord < ActiveRecord::Base
  def self.scrub_params(hash)
    hash.select { |k| self.attribute_names.index(k) }
  end

  self.abstract_class = true
end
