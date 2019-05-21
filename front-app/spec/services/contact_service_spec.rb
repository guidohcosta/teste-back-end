require 'rails_helper'

RSpec.describe ContactService do
  before { WebMock.disable_net_connect!(allow_localhost: true) }

  describe '#create' do
    let(:url) { 'localhost:3001/v1/contacts' }

    it 'when successful' do
      expect(::ContactService).to receive(:post)

      stub_request(:post, url)
        .to_return(status: :success, body: '{}')

      ::ContactService.new.create(
        name: Faker::Name.name,
        email: Faker::Internet.email
      )
    end
  end
end
