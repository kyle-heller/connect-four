class Player
  def get_name
    puts "What is your name?"
    name = gets
    if name =~ /^[a-zA-Z]+$/
      @name = name
    else
      puts "Invalid name"
      get_name
    end
  end
  def get_choice
    puts "Choose a column"
    choice = gets
    if choice =~ /^[1-7]+$/
      choice
    else
      puts "Invalid choice"
      get_choice
    end
  end
end
