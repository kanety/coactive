describe Coactive::Coactants do
  let :coactor do
    BasicCoactor
  end

  after do
    coactor.clear_coactants
  end

  it 'coactivates' do
    coactor.coact(Basics::ACoactor)
    expect(coactor.coactants).to eq([Basics::ACoactor])
  end

  it 'coactivates with position' do
    coactor.coact(Basics::ACoactor)
    coactor.coact(Basics::BCoactor, before: Basics::ACoactor)
    expect(coactor.coactants).to eq([Basics::BCoactor, Basics::ACoactor])
  end
end
