describe Coactive::Coactors::Coactions do
  let :coactor do
    BasicCoactor
  end

  after do
    coactor.clear_coactions
  end

  it 'adds coactions' do
    coactor.coaction(:test_coaction)
    expect(coactor.coactions.map(&:name)).to eq([:test_coaction])
  end
end
