module Teachable
  class User
    include Hashable

    attr_accessor :id, :name, :nickname, :image, :email, :tokens

    def initialize(params = {})
      self.id = params[:id]
      self.name = params[:name]
      self.nickname = params[:nickname]
      self.image = params[:image]
      self.email = params[:email]
      self.tokens = params[:tokens]
    end
  end
end
