require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  render_views
  let(:contact_service) { ::ContactService.new }

  describe '#new' do
    subject { get :new }

    it { is_expected.to have_http_status(:success) }
    it { is_expected.to render_template(:new) }
  end

  describe '#create' do
    subject(:do_create) do
      post :create,
        params: {
          contact: {
            email: Faker::Name.name,
            name: Faker::Internet.email
          }
        }
    end

    before { allow(::ContactService).to receive(:new).and_return(contact_service) }

    context 'when successful' do
      before do
        allow(contact_service).to receive(:create).and_return('{"status": "success"}')
      end
      it { is_expected.to have_http_status(:see_other) } 
      it { is_expected.to redirect_to page_path('thank-you') } 
      it 'calls service' do
        expect(contact_service).to receive(:create)
        do_create
      end
    end

    context 'when unsuccessful' do
      before do
        allow(contact_service).to receive(:create).and_return('{"status": "failure"}')
      end
      it { is_expected.to have_http_status(:ok) } 
      it { is_expected.to render_template :new } 
      it 'calls service' do
        expect(contact_service).to receive(:create)
        do_create
      end
    end
  end
end
