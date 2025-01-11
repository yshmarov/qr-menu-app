class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def generate_random_slug
    slug? ? slug : SecureRandom.uuid[0..5]
  end
end
