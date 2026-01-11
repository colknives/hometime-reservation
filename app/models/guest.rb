class Guest < ApplicationRecord
  has_many :reservations, dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
