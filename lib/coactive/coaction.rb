# frozen_string_literal: true

module Coactive
  class Coaction < Struct.new(:coactor, :name, :path, :path_index, :options)
    def priority
      options[:priority]
    end

    def priority=(val)
      options[:priority] = val
    end
  end
end
