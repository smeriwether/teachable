module Teachable
  class Order
    attr_accessor :id, :number, :total, :total_quantity, :email, :special_instructions

    def initialize(id:, number:, total:, total_quantity:, email:, special_instructions: nil, **)
      self.id = id
      self.number = number
      self.total = total
      self.total_quantity = total_quantity
      self.email = email
      self.special_instructions = special_instructions
    end

    def to_hash
      {
        id: id,
        number: number,
        total: total,
        total_quantity: total_quantity,
        email: email,
        special_instructions: special_instructions
      }
    end
  end
end
