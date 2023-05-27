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
    context 'check column 0' do
      let(:grid) { Array.new(6) { Array.new(7, '⚫️') } }
      it 'returns first row in column that is empty' do
        allow(player_double).to receive(:get_choice).and_return(0)
        result = game.next_empty_space(player_double.get_choice)
        expect(result).to eq(0)
      end
      it 'when c0r0 taken, returns 1' do
        game.instance_variable_set(:@grid, [
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"]])
        allow(player_double).to receive(:get_choice).and_return(0)
        result = game.next_empty_space(player_double.get_choice)
        expect(result).to eq(1)
      end
      it 'when c0r0 and c0r1 taken, returns 2' do
        game.instance_variable_set(:@grid, [
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"]])
        result = game.next_empty_space(0)
        expect(result).to eq(2)
      end
      it 'when c0r0 through c0r4 taken, returns 5' do
        game.instance_variable_set(:@grid, [
          ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"]])
        result = game.next_empty_space(0)
        expect(result).to eq(5)
      end
      it 'when column full, returns -1' do
        game.instance_variable_set(:@grid, [
          ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
          ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"]])
        result = game.next_empty_space(0)
        expect(result).to eq(nil)
      end
    end
  end
  describe '#add_token' do
    context 'when grid empty, choice column 0, and token X' do
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
    context 'when column not empty, choice column 0, and token X' do
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
end

# get_choice
# if move_valid? 
#   place token
# else get_choice
# end




# describe '#add_token' do
#   context 'when grid empty, choice column 0, and token X' do
#     let(:grid) { Array.new(6) { Array.new(7, '⚫️') } }
#     it 'adds a token to first empty space in column 0' do
#       token = "🔵"
#       game.add_token(0, token)
#       expect(game.grid).to eq([
#         ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
#         ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
#         ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
#         ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
#         ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
#         ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"]])
#     end
#   end
#   context 'when column not empty, choice column 0, and token X' do
#     let(:grid) { [
#       ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
#       ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
#       ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
#       ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
#       ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
#       ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"]] }

#     it 'adds a token to next empty space in column 0' do
#       token = "🔵"
#       game.add_token(0, token)
#       expect(game.grid).to eq([
#         ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
#         ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
#         ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
#         ["⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
#         ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
#         ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"]])
#     end
#   end
#   context 'when column full' do
#     let(:grid) { [
#       ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
#       ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
#       ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
#       ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
#       ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
#       ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"]] }
#     it 'returns nil' do
#       token = "🔵"
#       result = game.add_token(0, token)
#       expect(result).to eq(-1)
#     end
#   end
# end