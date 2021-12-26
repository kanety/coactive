describe Coactive::Coactor do
  let :coactor do
    ApplicationCoactor
  end

  it 'has coactors method' do
    expect(coactor.new.coactors).to eq([])
  end

  context 'by class' do
    let :coactor do
      LookupCoactor
    end

    it 'lookups coactors' do
      expect(coactor.new.coactors).to eq([Lookups::ACoactor, Lookups::BCoactor])
    end
  end

  context 'by block' do
    let :coactor do
      LookupByBlockCoactor
    end

    it 'lookups coactors' do
      expect(coactor.new.coactors).to eq([Lookups::ACoactor, Lookups::BCoactor, Lookups::CCoactor])
    end
  end

  context 'by method' do
    let :coactor do
      LookupByMethodCoactor
    end

    it 'lookups coactors' do
      expect(coactor.new.coactors).to eq([Lookups::ACoactor, Lookups::BCoactor, Lookups::CCoactor])
    end
  end
end
