class ContactsController < ApplicationController
  def new
  end

  def create
    if create_contact.status == 'success'
      redirect_to page_path('thank-you'), status: :see_other
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact)
          .permit(:name, :email)
  end

  def create_contact
    JSON.parse(contact_service.create(contact_params), object_class: OpenStruct)
  end

  def contact_service
    ::ContactService.new
  end
end
