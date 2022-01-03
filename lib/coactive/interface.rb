# frozen_string_literal: true

require_relative 'initializer'
require_relative 'contextualizer'

module Coactive
  module Interface
    extend ActiveSupport::Concern

    included do
      include Initializer
      include Contextualizer
    end
  end
end
