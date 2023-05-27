require_relative '../lib/player'

describe Player do
  before(:each) do
    @player = Player.new
  end
  describe '#get_name' do
    context 'when called' do
      it 'should prompt player for name' do
        allow_any_instance_of(described_class).to receive(:gets).and_return('Kyle')
        expect { @player.get_name }.to output("What is your name?\n").to_stdout
      end
    end
    context 'When name is valid' do
      it 'should accept and return name' do
        allow_any_instance_of(described_class).to receive(:gets).and_return('Kyle')
        expect(@player.get_name).to eq('Kyle')
      end
    end
    context 'When name is invalid' do
      it 'should request name again' do
        allow_any_instance_of(described_class).to receive(:gets).and_return('!!!', 'Kyle')
        expect { @player.get_name }.to output("What is your name?\nInvalid name\nWhat is your name?\n").to_stdout
      end
    end
  end
  describe '#get_choice' do
    context 'when called' do
      it 'should prompt player for choice' do
        allow_any_instance_of(described_class).to receive(:gets).and_return('1')
        expect { @player.get_choice }.to output("Choose a column\n").to_stdout
      end
    end
    context 'when choice invalid' do
      it 'should request another choice' do
        allow_any_instance_of(described_class).to receive(:gets).and_return('!', '1')
        expect { @player.get_choice }.to output("Choose a column\nInvalid choice\nChoose a column\n").to_stdout
      end
    end
  end
end
