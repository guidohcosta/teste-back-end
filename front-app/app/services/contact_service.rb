class ContactService
  include HTTParty
  base_uri 'localhost:3001/v1'

  def create(attributes)
    self.class.post('/contacts', { contact: attributes })
  end
end
