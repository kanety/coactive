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

  it 'inspects object' do
    a = ItemA.new
    context = described_class.new(a: a)
    expect(context.to_s).to include("a=#<ItemA:#{a.object_id}>")
  end

  it 'inspects object with id' do
    a = ItemA.new
    def a.id
      100
    end
    context = described_class.new(a: a)
    expect(context.to_s).to include("a=#<ItemA/#{a.id}>")
  end

  it 'inspects object with attributes' do
    a = ItemA.new
    def a.attributes
      {a: "a"}
    end
    context = described_class.new(a: a)
    expect(context.to_s).to include('a=#<ItemA {a: "a"}>')
  end

  it 'truncates long string' do
    context = described_class.new(a: 'a'*1000)
    expect(context.to_s).to include(%Q|a="#{'a'*100}...|)
  end
end
