class V1::ContactsController < ApplicationController
  before_action :set_contact, only: :create
  before_action :find_contact, only: %i(update show destroy)
  before_action :find_contacts, only: %i(index)

  def create
    if @contact.save
      render json: { status: :success }
    else
      render json: {
        status: :failure,
        errors: @contact.errors.messages
      }
    end
  end

  def update
    if @contact.update(contact_params)
      render json: { status: :success }
    else
      render json: {
        status: :failure,
        errors: @contact.errors.messages
      }
    end
  end

  def show
    render json: { contact: @contact }
  end

  def index
    render json: { contacts: @contacts }
  end

  def destroy
    @contact.destroy
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :name)
  end

  def set_contact
    @contact = Contact.new contact_params
  end

  def find_contact
    @contact = Contact.find_by email: params[:email]
  end

  def find_contacts
    @contacts = Contact.all
  end
end
