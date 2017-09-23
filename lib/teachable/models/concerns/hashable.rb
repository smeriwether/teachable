module Teachable
  module Hashable
    def to_hash
      instance_variables.inject({}) do |accum, iv|
        accum[iv.to_s.delete("@")] = instance_variable_get(iv)
        accum
      end.with_indifferent_access
    end
  end
end
