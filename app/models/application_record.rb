class ApplicationRecord < ActiveRecord::Base
  def self.scrub_params(hash)
    return unless hash.respond_to?(:select)
    hash.select { |k| self.attribute_names.index(k) }
  end

  self.abstract_class = true
end
