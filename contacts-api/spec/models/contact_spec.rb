require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'attributes' do
    it { is_expected.to respond_to :email }
    it { is_expected.to respond_to :name }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }

    describe 'email_format' do
      it { is_expected.to allow_value('example@email.com').for(:email) }
      it { is_expected.to allow_value('admin@mailserver1').for(:email) }
      it { is_expected.to allow_value('x@example.com').for(:email) }
      it { is_expected.not_to allow_value('exampleemail.com').for(:email) }
      it { is_expected.not_to allow_value('A@b@c@example.com').for(:email) }
      it { is_expected.not_to allow_value('this is"not\allowed@example.com').for(:email) }
    end
  end
end
