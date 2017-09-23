module Teachable
  class Order
    include Hashable

    attr_accessor :id, :number, :total, :total_quantity, :email, :special_instructions

    def initialize(params = {})
      self.id = params[:id]
      self.number = params[:number]
      self.total = params[:total]
      self.total_quantity = params[:total_quantity]
      self.email = params[:email]
      self.special_instructions = params[:special_instructions]
    end
  end
end
