describe Coactive::Coactions do
  let :coactor do
    BasicCoactor
  end

  let :base_class do
    coactor.coactive_config.base_class
  end

  before do
    coactor.coaction(:test_coaction)
  end

  after do
    Coactive::Coactions.registry[base_class].delete(:test_coaction)
  end

  it 'adds coactions' do
    coactions = Coactive::Coactions[base_class, :test_coaction]
    expect(coactions.map(&:coactor)).to eq([coactor])
  end
end
