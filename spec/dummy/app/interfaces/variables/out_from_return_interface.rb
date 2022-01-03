class Variables::OutFromReturnInterface < ApplicationInterface
  context :out, output: :return

  def call
    @out = 'instance variable'
    'return value'
  end
end
