class Variables::OutFromIvarInterface < ApplicationInterface
  context :out, output: true

  def call
    @out = 'instance variable'
    'return value'
  end
end
