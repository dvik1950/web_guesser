require 'sinatra'
require 'sinatra/reloader' #Doesn't require a server restart with ctrl+c each time, but automatically reloads the page when changes r made
@@remaining_guesses = 5
@@random_number = rand(101)
def checker(guessed_number)
  if guessed_number == nil
    return "empty. Try your luck above ^^^"
  end

  if @@remaining_guesses == 0
    return "...was not guessed right, try again!"
    @@remaining_guesses = 5
    @@random_number = rand(101)
  end
  if guessed_number.to_i  > @@random_number + 5
    @@remaining_guesses = @@remaining_guesses - 1
    return "Way too high"
  elsif guessed_number.to_i < @@random_number - 5
    @@remaining_guesses = @@remaining_guesses - 1
    return "Way too low"
  elsif guessed_number.to_i < @@random_number
    @@remaining_guesses = @@remaining_guesses - 1
    return "Too low"
  elsif guessed_number.to_i > @@random_number
    @@remaining_guesses = @@remaining_guesses - 1
    return "Too high"
  elsif guessed_number.to_i == @@random_number
    return "CORRECT!"
  end

end

def colorize(response)
  if response == "Way too high"
    return "#BC1F1F"
  elsif response == "Way too low"
    return "#73E6F3"
  elsif response == "Too low"
    return "#202DEA"
  elsif response == "Too high"
    return "#EFB223"
  end
end


get '/' do
  guessed_number = params['guess']
  response = checker(guessed_number)
  page_color = colorize(response)
  erb :index, :locals => {:guessed_number => guessed_number, :response => response, :page_color => page_color, :remaining_guesses => @@remaining_guesses}

end

