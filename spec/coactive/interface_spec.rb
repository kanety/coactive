describe Coactive::Initializer do
  let :interface_class do
    BasicInterface
  end

  it 'takes no arguments' do
    interface = interface_class.new
    expect(interface.context.in).to eq(nil)
  end

  it 'takes context' do
    context = Coactive::Context.new(in: 'in')
    interface = interface_class.new(context)
    expect(interface.context.in).to eq('in')
  end

  it 'has context input' do
    interface = interface_class.new(in: 'in')
    expect(interface.context.in).to eq('in')
    interface.contextualize
    expect(interface.in).to eq('in')
    expect(interface.instance_variable_get(:@in)).to eq('in')
  end

  it 'has context output' do
    interface = interface_class.new(in: 'in')
    expect(interface.context.out).to eq(nil)
    interface.contextualize { interface.instance_variable_set(:@out, 'out') }
    expect(interface.context.out).to eq('out')
  end
end
