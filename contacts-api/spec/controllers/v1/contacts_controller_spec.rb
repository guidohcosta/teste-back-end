require 'rails_helper'

RSpec.describe V1::ContactsController, type: :controller do
  let(:response) { JSON.parse(subject.body, object_class: OpenStruct) }
  let(:contact) { FactoryBot.create(:contact) }

  describe '#create' do
    subject(:do_create) do
      post :create, params: { contact: FactoryBot.attributes_for(:contact) }
    end

    context 'when successful' do
      it { expect { do_create }.to change(Contact, :count).by 1 }
      it { expect(response).to respond_to :status }
      it { expect(response).not_to respond_to :errors }
      it { expect(response.status).to eq 'success' }
    end

    context 'when unsuccessful' do
      before do
        allow_any_instance_of(Contact).to receive(:save).and_return(false)
      end

      it { expect { do_create }.not_to change(Contact, :count) }
      it { expect(response).to respond_to :status }
      it { expect(response).to respond_to :errors }
      it { expect(response.status).to eq 'failure' }
    end
  end

  describe '#update' do
    subject(:do_update) do
      patch :update, params: {
        email: contact.email,
        contact: { email: 'new@email.com', name: 'new name' }
      }
    end

    let(:updated_contact) { Contact.find(contact.id) }

    context 'when successful' do
      before { do_update }

      it { expect(updated_contact.email).to eq 'new@email.com' }
      it { expect(updated_contact.name).to eq 'new name' }
      it { expect(response).to respond_to :status }
      it { expect(response.status).to eq 'success' }
    end

    context 'when unsuccessful' do
      before do
        allow_any_instance_of(Contact).to receive(:update).and_return(false)
        do_update
      end

      it { expect(updated_contact.email).to eq contact.email }
      it { expect(updated_contact.name).to eq contact.name }
      it { expect(response).to respond_to :status }
      it { expect(response.status).to eq 'failure' }
    end
  end

  describe '#show' do
    subject { get :show, params: { email: contact.email } }

    it { is_expected.to respond_to :status }
    it { expect(response).to respond_to :contact }
  end

  describe '#index' do
    subject { get :index }
    before { FactoryBot.create_list(:contact, 20) }

    it { is_expected.to respond_to :status }
    it { expect(response).to respond_to :contacts }
    it { expect(response.contacts.length).to eq 20 }
  end

  describe '#destroy' do
    subject(:do_delete) do
      delete :destroy, params: { email: contact.email }
    end
    before { contact }

    it { expect { do_delete }.to change(Contact, :count).by(-1) }
  end
end
