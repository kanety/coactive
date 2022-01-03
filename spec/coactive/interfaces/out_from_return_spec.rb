describe Coactive::Interface do
  context 'output from return' do
    let :interface_class do
      Variables::OutFromReturnInterface
    end

    it 'sets output context' do
      interface = interface_class.new(in: 'in')
      interface.contextualize { interface.call } 
      expect(interface.context.out).to eq('return value')
    end
  end
end
