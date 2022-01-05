describe Coactive::Interface do
  context 'inherited' do
    it 'overwrites context variable' do
      expect(BasicInterface._contexts.find { |v| v.name == :in }.options).to eq({})
      expect(Variables::BasicInterface._contexts.find { |v| v.name == :in }.options).to eq({ required: true })
    end
  end
end
