class VisitService
  include HTTParty
  base_uri 'localhost:3001/v1'

  def list
    self.class.get('/visits')
  end
end
