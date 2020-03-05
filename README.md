Elixir MUD
===

Use Ruby as DSL backend to generate story and handle TCP connection by Elixir

## Installation

Use `mix deps.get` to install

## Usage

Start server by `mix run --no-halt`

Connect to game by `telnet localhost 6666`

## Write Story in Ruby

```ruby
# stories/chapter1.rb

# Create a chapter
chapter 1 do
  # Create an action
  action do # Index: 0
    say "Hi, Welcome to Elixir.MUD" # Print message
    say "Do you want to continue?(Y/n)"
    jump 1 # Jump to Index: 1
    wait_input # Display "> " to user
  end

  action do # Index: 1
    say "Cool, you learned how to create a MUD"
    close # Close connection to end the game
  end
end
```
