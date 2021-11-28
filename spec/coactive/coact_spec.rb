describe Coactive::Coact do
  let :coactor do
    SimpleCoactor
  end

  after do
    coactor.clear_coactants
  end

  it 'coactivates' do
    coactor.coact(Simples::ACoactor)
    expect(coactor.coactants).to eq([Simples::ACoactor])
  end

  it 'coactivates with position' do
    coactor.coact(Simples::ACoactor)
    coactor.coact(Simples::BCoactor, before: Simples::ACoactor)
    expect(coactor.coactants).to eq([Simples::BCoactor, Simples::ACoactor])
  end
end
