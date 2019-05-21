require 'rails_helper'

RSpec.describe VisitsController, type: :controller do
  render_views
  let(:visit_service) { ::VisitService.new }

  describe '#index' do
    subject(:do_index) { get :index }

    before { allow(::VisitService).to receive(:new).and_return(visit_service) }

    context 'when successful' do
      before { allow(visit_service).to receive(:list).and_return('{"visits": []}') }

      it { is_expected.to have_http_status :ok }
      it { is_expected.to render_template :index }
      it 'calls service' do
        expect(visit_service).to receive(:list)
        do_index
      end
    end
  end
end
