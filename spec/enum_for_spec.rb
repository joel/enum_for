class FakeModel
  attr_reader :saved_enum

  # To fake active record [] method, value is set to 2
  def [](value)
    { color: 1 }.with_indifferent_access[value]
  end

  extend EnumFor

  enum_for color: { red: 0, green: 1, blue: 2 }
end

RSpec.describe EnumFor do
  let(:fake_model) { FakeModel.new }

  describe '.colors' do
    it 'returns hash passed to enum_for method' do
      expect(FakeModel.colors).to eql(
        { red: 0, green: 1, blue: 2 }.with_indifferent_access
      )
    end
  end

  it 'generates predicate methods' do
    expect(fake_model.red?).to   be(false)
    expect(fake_model.green?).to be(true)
    expect(fake_model.blue?).to  be(false)
  end

  it 'generates color method' do
    expect(fake_model.color).to eql('green')
  end

  it 'generates bang methods' do
    %i[red! green! blue!].each do |method_name|
      expect(fake_model).to be_respond_to(method_name)
    end
  end

  describe '#red!' do
    before do
      allow(fake_model).to receive('[]=')
      allow(fake_model).to receive(:save!)
    end

    it { fake_model.red! }
  end

  describe '#color=' do
    before do
      allow(fake_model).to receive('[]=')
    end

    it 'accepts enum as string' do
      expect(fake_model).to receive('[]=').with('color', 2)
      fake_model.color = 'blue'
    end

    it 'accepts enum as string with integer' do
      expect(fake_model).to receive('[]=').with('color', 2)
      fake_model.color = '2'
    end

    it 'accepts enum as integer' do
      expect(fake_model).to receive('[]=').with('color', 2)
      fake_model.color = 2
    end
  end

  it 'generates color_to_enum method' do
    expect(fake_model.color_to_enum).to be(1)
  end
end
