require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe "associations" do
    it { should belong_to(:guest) }
  end

  describe "validations" do
    subject { build(:reservation) }

    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:status) }
  end
end