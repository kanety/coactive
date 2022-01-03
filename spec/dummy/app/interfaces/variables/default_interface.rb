class Variables::DefaultInterface < ApplicationInterface
  context :in, default: 'default value'
  context :in_method, default: :default_value_method
  context :in_proc, default: -> { default_value_method }

  def default_value_method
    'default value'
  end
end
