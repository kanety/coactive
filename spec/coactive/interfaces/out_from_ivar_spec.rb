describe Coactive::Interface do
  context 'output from ivar' do
    let :interface_class do
      Variables::OutFromIvarInterface
    end

    it 'sets output context' do
      interface = interface_class.new(in: 'in')
      interface.contextualize { interface.call } 
      expect(interface.context.out).to eq('instance variable')
    end
  end
end
