describe Coactive::Interface do
  context 'default' do
    let :interface_class do
      Variables::DefaultInterface
    end

    it 'sets default value' do
      interface = interface_class.new
      expect(interface.context.in).to eq('default value')
    end

    it 'sets default value by method' do
      interface = interface_class.new
      expect(interface.context.in_method).to eq('default value')
    end

    it 'sets default value by proc' do
      interface = interface_class.new
      expect(interface.context.in_proc).to eq('default value')
    end
  end
end
