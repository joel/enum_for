RSpec.shared_examples 'as an enum' do
  it 'common behaviours' do
    expect(Conversation.statuses).to eql('active' => 0, 'archived' => 1)
    expect(conversation).to be_active
    expect(
      Conversation.where('status = ?', Conversation.statuses[:active])
    ).to be_present
    expect { conversation.archived! }
      .to  change(conversation, :status).from('active').to('archived')
    expect(conversation).not_to be_changed # Fire the request
  end
end

RSpec.describe EnumFor do
  let(:conversation) { ::Conversation.create(title: 'Whatever') }

  with_model :Conversation do
    table do |t|
      t.string :title
      t.integer :status, default: 0
      t.timestamps
    end
  end

  before { Conversation.include(my_module) }

  context 'with AR Enum' do
    let(:my_module) do
      Module.new do
        def self.included(base)
          base.class_eval do
            enum status: %i[active archived]
          end
        end
      end
    end

    it_behaves_like 'as an enum'

    it 'validation' do
      expect { conversation.status = 'unknown value' }
        .to raise_error(ArgumentError, "'unknown value' is not a valid status")
    end
  end

  context 'with EnumFor' do
    let(:my_module) do
      Module.new do
        def self.included(base)
          base.class_eval do
            extend EnumFor
            enum_for status: { active: 0, archived: 1 }
            validates :status, inclusion: statuses.keys
          end
        end
      end
    end

    it_behaves_like 'as an enum'

    it 'validation' do
      expect { conversation.status = 'unknown value' }
        .not_to raise_error
      expect(conversation).to be_changed # Not fire the request
      expect(conversation).not_to be_valid
      expect(conversation.errors.messages)
        .to eql(status: ['is not included in the list'])
    end
  end
end
