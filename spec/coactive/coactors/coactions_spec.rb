describe Coactive::Coactors::Coactions do
  let :coactor do
    BasicCoactor
  end

  let :base_class do
    BasicCoactor.coactive_config.base_class
  end

  before do
    coactor.coaction(:test_coaction)
  end

  after do
    base_class.coactions_map.delete(:test_coaction)
  end

  it 'adds coactions' do
    coactions = base_class.coactions_map[:test_coaction]
    expect(coactions.map(&:coactor)).to eq([BasicCoactor])
  end
end
