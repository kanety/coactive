# frozen_string_literal: true

require_relative 'configure'
require_relative 'coact'
require_relative 'coaction'
require_relative 'coactors'
require_relative 'loader'

module Coactive
  module Base
    extend ActiveSupport::Concern

    included do
      include Configure
      include Coact
      include Coaction
      include Coactors
    end
  end
end
