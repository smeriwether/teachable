module Teachable
  class User
    attr_accessor :id, :name, :nickname, :image, :email, :tokens

    def initialize(params = {})
      self.id = params[:id]
      self.name = params[:name]
      self.nickname = params[:nickname]
      self.image = params[:image]
      self.email = params[:email]
      self.tokens = params[:tokens]
    end

    def to_hash
      instance_variables.inject({}) do |accum, iv|
        accum[iv.to_s.delete("@")] = instance_variable_get(iv)
        accum
      end.with_indifferent_access
    end
  end
end
