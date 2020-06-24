class SiteLink < ApplicationRecord
  include ArrangeSerializable

  has_ancestry

  validates :relative_path, :name, presence: true
  validates :relative_path, :name, uniqueness: { scope: :ancestry }
  validates_with RelativePathValidator
end
