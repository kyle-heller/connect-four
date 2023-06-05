require_relative '../lib/game'
require_relative '../lib/player'

describe Game do
  subject(:game) { Game.new(grid) }
  let(:grid) { Array.new(6) { Array.new(7, '⚫️') } }
  describe '#display_grid' do
    context 'when empty' do
      let(:grid) { Array.new(6) { Array.new(7, '⚫️') } }
      it 'display default' do
        expect(game.display_grid).to eq([
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"]])
      end
    end
  end
  describe '#next_empty_space' do
    let(:player_double) { instance_double(Player) }
    context 'when column 0, and column empty' do
      let(:grid) { Array.new(6) { Array.new(7, '⚫️') } }
      it 'returns 0' do
        allow(player_double).to receive(:get_choice).and_return(0)
        result = game.next_empty_space(player_double.get_choice)
        expect(result).to eq(0)
      end
    end
    context 'when column 0, and column full' do
      let(:grid) { [
        ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
        ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
        ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
        ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
        ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
        ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"]] }
      it 'returns 1' do
        allow(player_double).to receive(:get_choice).and_return(0)
        result = game.next_empty_space(0)
        expect(result).to eq(nil)
      end
    end
  end
  describe '#add_token' do
    context 'when grid empty, choice column 0, and token 🔵' do
      let(:grid) { Array.new(6) { Array.new(7, '⚫️') } }
      it 'adds a token to first empty space in column 0' do
        token = "🔵"
        game.add_token(0, token)
        expect(game.grid).to eq([
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"]])
      end
    end
    context 'when column not empty, choice column 0, and token 🔵' do
      let(:grid) { [
        ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
        ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
        ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
        ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
        ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
        ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"]] }

      it 'adds a token to next empty space in column 0' do
        token = "🔵"
        game.add_token(0, token)
        expect(game.grid).to eq([
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"]])
      end
    end
    context 'when column full' do
      let(:grid) { [
        ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
        ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
        ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
        ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
        ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
        ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"]] }
      it 'returns nil' do
        token = "🔵"
        result = game.add_token(0, token)
        expect(result).to eq(nil)
      end
    end
  end

  describe '#valid_move' do
    context 'when column full' do
      let(:grid) { [
        ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
        ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
        ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
        ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
        ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
        ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"]] }
      it 'returns false' do
        column = 0
        result = game.valid_move?(column)
        expect(result).to eq(false)
      end
    end
    context 'when column not full' do
      it 'returns true' do
        column = 0
        result = game.valid_move?(column)
        expect(result).to eq(true)
      end
    end
  end
  describe '#get_mode' do
    let(:player_double) { instance_double(Player) }
    context 'when player vs computer' do
      it 'player 2 is_computer true' do
        allow(game).to receive(:puts)
        allow_any_instance_of(Player).to receive(:gets).and_return("Kyle\n")
        allow(game).to receive(:gets).and_return("1\n")
        game.get_mode
        expect(game.player2.is_computer).to eq(true)
      end
    end
    context 'when player vs player' do
      it 'player 2 is_computer false' do
        allow(game).to receive(:puts)
        allow_any_instance_of(Player).to receive(:gets).and_return("Kyle\n")
        allow(game).to receive(:gets).and_return("2\n")
        game.get_mode
        expect(game.player2.is_computer).to eq(false)
      end
    end
  end
  describe '#game_won?' do
    let(:player_double) { instance_double(Player) }
    context 'when player choices contain 1, 2, 3, 4 (horizontal 4)' do
      it 'returns true' do
        allow(game).to receive(:print)
        allow(player_double).to receive(:choices).and_return(Set.new([1,2,3,4]))
        allow(player_double).to receive(:name).and_return("Kyle")
        result = game.game_won?(player_double)
        expect(result).to eq(true)
      end
    end
    context 'when player choices contain 1, 2, 3, 5 (no winning conditions)' do
      it 'returns false' do
        allow(game).to receive(:print)
        allow(player_double).to receive(:choices).and_return(Set.new([1,2,3,5]))
        allow(player_double).to receive(:name).and_return("Kyle")
        result = game.game_won?(player_double)
        expect(result).to eq(false)
      end
    end
    context 'when player choices contain 1, 8, 15, 22 (vertical win)' do
      it 'returns true' do
        allow(game).to receive(:print)
        allow(player_double).to receive(:choices).and_return(Set.new([1,8,15,22]))
        allow(player_double).to receive(:name).and_return("Kyle")
        result = game.game_won?(player_double)
        expect(result).to eq(true)
      end
    end
    context 'when player choices contain 1, 9, 17, 25 (diagonal-up win)' do
      it 'returns true' do
        allow(game).to receive(:print)
        allow(player_double).to receive(:choices).and_return(Set.new([1,9,17,25]))
        allow(player_double).to receive(:name).and_return("Kyle")
        result = game.game_won?(player_double)
        expect(result).to eq(true)
      end
    end
    context 'when player choices contain 7, 13, 19, 25 (diagonal-down win)' do
      it 'returns true' do
        allow(game).to receive(:print)
        allow(player_double).to receive(:choices).and_return(Set.new([7,13,19,25]))
        allow(player_double).to receive(:name).and_return("Kyle")
        result = game.game_won?(player_double)
        expect(result).to eq(true)
      end
    end
  end

#get_choice - Looping Script
# Verify that the method correctly enters the loop when the initial move is not valid.
# Check that subsequent iterations of the method are triggered when an invalid move is made.
# Ensure that the recursion terminates when a valid move is obtained.
  describe '#get_choice' do
    let(:player_double) { instance_double(Player) }
    context 'if move valid' do
      it 'sends message to place token' do
        allow(game).to receive(:gets).and_return('2')
        allow(game).to receive(:puts)
        allow(player_double).to receive(:get_choice).and_return(2)
        allow(player_double).to receive(:token).and_return("🔵")
        allow(player_double).to receive(:choices).and_return('2')
        expect(game).to receive(:add_token).once
        game.get_choice(player_double)
      end
    end
    context 'if move invalid' do
      it 'recursively calls get choice' do
        allow(game).to receive(:gets).and_return('8', '2')
        allow(game).to receive(:puts)
        allow(player_double).to receive(:get_choice).and_return(8, 2)
        allow(player_double).to receive(:token).and_return("🔵")
        allow(player_double).to receive(:choices).and_return('8','2')
        expect(game).to receive(:get_choice).twice.and_call_original
        game.get_choice(player_double)
      end
      it 'sends message to place token when invalid and then valid' do
        allow(game).to receive(:gets).and_return('8', '2')
        allow(game).to receive(:puts)
        allow(player_double).to receive(:get_choice).and_return(8, 2)
        allow(player_double).to receive(:token).and_return("🔵")
        allow(player_double).to receive(:choices).and_return('8','2')
        expect(game).to receive(:add_token).once
        game.get_choice(player_double)
      end
    end
  end
  describe '#new_game' do
    context 'when called' do
      it 'starts a new game' do
        allow(Game).to receive(:new).and_return(game)
        allow(game).to receive(:play_game)
        expect(Game).to receive(:new)
        game.new_game
      end
    end
  end
  describe '#play_again_prompt' do
    context 'when input is y or yes' do
      it 'initiates a new game' do
        allow(game).to receive(:gets).and_return('y')
        expect(game).to receive(:new_game)
        game.play_again_prompt
      end
    end
    context 'when input is not y or yes' do
      it 'exits program' do
        allow(game).to receive(:gets).and_return('n')
        expect(Kernel).to receive(:exit)
        game.play_again_prompt
      end
    end
  end
end