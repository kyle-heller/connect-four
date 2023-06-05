require 'set'

class Player

  attr_accessor :name, :is_computer, :choices, :token
  def initialize(token = nil, mode = 0, name = get_name)
    @name = name
    @is_computer = (mode == 1) ? true : false
    @choices = Set.new
    @token = token
  end

  def get_name
    name = gets
    name = name.chomp
    puts name
    if name =~ /^[a-zA-Z]+$/
      name
    else
      puts 'Invalid name'
      get_name
    end
  end

  def get_choice
    if is_computer == false
      puts "#{name}, choose a column:"
      choice = gets.chomp
      if choice =~ /^[1-7]+$/
        choice.to_i - 1
      else
        puts 'Invalid choice'
        get_choice
      end
    elsif is_computer == true
      sleep(1)
      rand(1..7)
    end
  end
end
