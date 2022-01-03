describe Coactive::Lookups::Object do
  context 'object' do
    let :coactor do
      LookupByObjectCoactor
    end

    it 'lookups coactors' do
      expect(coactor.new.coactors).to eq([
        LookupByObject::ItemACoactor,
        LookupByObject::ItemBCoactor,
        LookupByObject::Inherited::ItemACoactor,
        LookupByObject::ItemBCoactor
      ])
    end
  end
end
