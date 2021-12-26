describe Coactive::Coactors::Coaction do
  let :coactor do
    BasicCoactor
  end

  after do
    coactor.clear_coactions
  end

  it 'adds coactions' do
    coactor.coaction(:test_coaction)
    expect(coactor.coactions).to eq([:test_coaction])
  end
end
