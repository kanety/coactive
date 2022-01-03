describe Coactive::Context do
  it 'initializes with no arguments' do
    context = described_class.new
    expect(context._data).to eq({})
  end

  it 'initializes with hash' do
    context = described_class.new(in: 'in')
    expect(context._data[:in]).to eq('in')
  end

  it 'has getter and setter' do
    context = described_class.new(in: 'in')
    expect(context[:in]).to eq('in')
    context[:in] = 'changed'
    expect(context[:in]).to eq('changed')
  end

  it 'has to_s' do
    context = described_class.new(in: 'in')
    expect(context.to_s).to include('in="in"')
  end

  it 'defines accessors' do
    context = described_class.new(in: 'in')
    context.define_accessors!(:in)
    expect(context.in).to eq('in')
    context.in = 'changed'
    expect(context.in).to eq('changed')
  end
end
