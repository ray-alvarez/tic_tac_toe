# example/example_game.rb
root = File.expand_path("../", File.dirname(__FILE__))
require "#{root}/lib/tic_tac_toe.rb"

puts "Welcome to tic tac toe"
danny = TicTacToe::Player.new({color: "X", name: "danny"})
ray = TicTacToe::Player.new({color: "O", name: "ray"})
players = [danny, ray]
TicTacToe::Game.new(players).play