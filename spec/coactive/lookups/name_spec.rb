describe Coactive::Lookups::Name do
  context 'name' do
    let :coactor do
      LookupByNameCoactor
    end

    it 'lookups coactors' do
      expect(coactor.new.coactors).to include(Lookups::ACoactor, Lookups::BCoactor)
    end
  end

  context 'name2' do
    let :coactor do
      LookupByName2Coactor
    end

    it 'lookups coactors' do
      expect(coactor.new.coactors).to include(Lookups::BCoactor, Lookups::CCoactor)
    end
  end
end
