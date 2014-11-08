module Almanack
  class SerializedTransformation

    def initialize(subject)
      @subject = subject
      @transformations = {}
    end

    def key(&block)
      @transformations[:key] = block
    end

    def value(&block)
      @transformations[:value] = block
    end

    def apply
      recurse(cloned)
    end

    private

    def cloned
      @subject.dup
    end

    def recursable?(node)
      node.is_a?(Array) || node.is_a?(Hash)
    end

    def no_change
      -> (obj) { obj }
    end

    def transformation(type, entity)
      (@transformations[type] || no_change).call(entity)
    end

    def recurse(entity)
      cloned = case entity
      when Array
        entity.map { |child| recurse(child) }
      when Hash
        entity.each_with_object({}) do |(key, value), hash|
          transformed_key = recursable?(key) ? recurse(key) : transformation(:key, key)
          hash[transformed_key] = recurse(value)
        end
      else
        transformation(:value, entity)
      end
    end
  end
end
