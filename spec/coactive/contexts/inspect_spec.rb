describe Coactive::Context do
  it 'has to_s' do
    context = described_class.new(in: 'in')
    expect(context.to_s).to include('in="in"')
  end

  it 'inspects short array' do
    context = described_class.new(a: ["a", "b", "c", "d", "e", "f"])
    expect(context.to_s).to include('["a", "b", "c"...]')
  end

  it 'inspects short hash' do
    context = described_class.new(a: { a: "a", b: "b", c: "c", d: "d", e: "e", f: "f" })
    expect(context.to_s).to include('{a: "a", b: "b", c: "c"...}')
  end

  it 'inspects nil' do
    context = described_class.new(a: nil)
    expect(context.to_s).to include('a=nil')
  end
end
