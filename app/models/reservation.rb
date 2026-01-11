class Reservation < ApplicationRecord
  belongs_to :guest

  validates :start_date, :end_date, :status, presence: true
end
