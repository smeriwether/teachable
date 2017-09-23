module Teachable
  class Order
    attr_accessor :id, :number, :total, :total_quantity, :email, :special_instructions

    def initialize(params = {})
      self.id = params[:id]
      self.number = params[:number]
      self.total = params[:total]
      self.total_quantity = params[:total_quantity]
      self.email = params[:email]
      self.special_instructions = params[:special_instructions]
    end

    def to_hash
      instance_variables.inject({}) do |accum, iv|
        accum[iv.to_s.delete("@")] = instance_variable_get(iv)
        accum
      end.with_indifferent_access
    end
  end
end
