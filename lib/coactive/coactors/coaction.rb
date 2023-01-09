# frozen_string_literal: true

module Coactive
  module Coactors
    class Coaction < Struct.new(:coactor, :name, :options)
      def priority
        options[:priority] || 1 << 63
      end
    end
  end
end
