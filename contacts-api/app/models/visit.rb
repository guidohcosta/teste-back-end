class Visit < ApplicationRecord
  IDENTIFIER_FORMAT = /[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[34][0-9a-fA-F]{3}-[89ab][0-9a-fA-F]{3}-[0-9a-fA-F]{12}/

  validates :url, presence: true
  validates :identifier, presence: true,
                         format: { with: IDENTIFIER_FORMAT }

end
