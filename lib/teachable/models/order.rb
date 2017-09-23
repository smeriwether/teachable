module Teachable
  class Order
    attr_accessor :number, :total, :total_quantity, :user_email, :special_instructions

    def initialize(number:, total:, total_quantity:, user_email:, special_instructions: nil)
      self.number = number
      self.total = total
      self.total_quantity = total_quantity
      self.user_email = user_email
      self.special_instructions = special_instructions
    end

    def to_hash
      {
        number: number,
        total: total,
        total_quantity: total_quantity,
        user_email: user_email,
        special_instructions: special_instructions
      }
    end
  end
end
