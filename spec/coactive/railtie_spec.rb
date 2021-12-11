describe Coactive::Railtie do
  let :coactor do
    LookupByNameCoactor
  end

  it 'clears cache when reloaded' do
    coactor.new.coactors
    expect(Coactive::Lookup.cache.size).not_to eq(0)

    Rails.application.reloader.reload!
    expect(Coactive::Lookup.cache.size).to eq(0)

    coactor.new.coactors
    expect(Coactive::Lookup.cache.size).not_to eq(0)
  end
end
