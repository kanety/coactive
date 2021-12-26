# frozen_string_literal: true

require_relative 'configure'
require_relative 'coactor'

module Coactive
  module Base
    extend ActiveSupport::Concern

    included do
      include Configure
      include Coactor
    end
  end
end
