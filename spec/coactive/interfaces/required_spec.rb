describe Coactive::Interface do
  context 'required' do
    let :interface_class do
      Variables::RequiredInterface
    end

    it 'requires input' do
      expect { interface_class.new }.to raise_error(Coactive::MissingContextError)
    end

    it 'calls without error' do
      expect { interface_class.new(in: 'in') }.not_to raise_error
    end
  end
end
