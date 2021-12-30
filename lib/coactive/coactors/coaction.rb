# frozen_string_literal: true

module Coactive
  module Coactors
    class Coaction < Struct.new(:name, :options)
      def priority
        options[:priority]
      end
    end
  end
end
