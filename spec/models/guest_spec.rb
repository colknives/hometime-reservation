require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe "associations" do
    it { should have_many(:reservations).dependent(:destroy) }
  end

  describe "validations" do
    subject { build(:guest) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end
end