require 'rails_helper'

RSpec.describe V1::VisitsController, type: :controller do
  let(:response) { JSON.parse(subject.body, object_class: OpenStruct) }
  let(:visit) { FactoryBot.create(:visit) }

  describe '#create' do
    subject(:do_create) do
      post :create, params: { visit: FactoryBot.attributes_for(:visit) }
    end

    context 'when successful' do
      it { expect { do_create }.to change(Visit, :count).by 1 }
      it { expect(response).to respond_to :status }
      it { expect(response).not_to respond_to :errors }
      it { expect(response.status).to eq 'success' }
    end

    context 'when unsuccessful' do
      before do
        allow_any_instance_of(Visit).to receive(:save).and_return(false)
      end

      it { expect { do_create }.not_to change(Visit, :count) }
      it { expect(response).to respond_to :status }
      it { expect(response).to respond_to :errors }
      it { expect(response.status).to eq 'failure' }
    end
  end

  describe '#index' do
    subject { get :index }
    before { FactoryBot.create_list(:visit, 20) }

    it { is_expected.to respond_to :status }
    it { expect(response).to respond_to :visits }
    it { expect(response.visits.length).to eq 20 }
  end
end
