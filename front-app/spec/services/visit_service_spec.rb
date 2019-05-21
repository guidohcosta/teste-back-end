require 'rails_helper'

RSpec.describe VisitService do
  before { WebMock.disable_net_connect!(allow_localhost: true) }

  describe '#create' do
    let(:url) { 'localhost:3001/v1/visits' }

    it 'when successful' do
      expect(::VisitService).to receive(:get)

      stub_request(:get, url)
        .to_return(status: :success, body: '{[]}')

      ::VisitService.new.list
    end
  end
end
