describe Coactive::Lookups::Object do
  context 'object' do
    let :coactor do
      LookupByObjectCoactor
    end

    it 'lookups coactors' do
      expect(coactor.new.coactors).to eq([
        LookupByObject::ACoactor,
        LookupByObject::BCoactor,
        LookupByObject::Inherited::ACoactor,
        LookupByObject::BCoactor
      ])
    end
  end
end
