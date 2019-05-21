require 'rails_helper'

RSpec.describe Visit, type: :model do
  describe 'attributes' do
    it { is_expected.to respond_to :url }
    it { is_expected.to respond_to :identifier }
    it { is_expected.to respond_to :created_at }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :url }
    it { is_expected.to validate_presence_of :identifier }

    describe 'identifier format' do
      it { is_expected.to allow_value('3057a47c-11b3-46fb-9d6e-115f494819bb').for :identifier }
      it { is_expected.not_to allow_value('3057a47c11b346fb9d6e15f494819bb').for :identifier }
      it { is_expected.not_to allow_value('3057a47c_11b3_46fb_9d6e_115f494819bb').for :identifier }
    end
  end
end
