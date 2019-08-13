# spec/game_spec.rb
require "spec_helper"

module TicTacToe 
    describe Game do

        let (:danny) { Player.new({color: "X", name: "danny"}) }
        let (:ray) { Player.new({color: "O", name: "ray"}) }
        let (:game) { Game.new([danny, ray]) }

        context "initialize" do
            it "randomly selects a current_player" do
                allow_any_instance_of(Array).to receive(:shuffle) { [ray, danny] }
                game = Game.new([danny, ray])
                expect(game.current_player).to eq ray
            end

            it "randomly selects another player" do
                allow_any_instance_of(Array).to receive(:shuffle) { [ray, danny] }
                game = Game.new([danny, ray])
                expect(game.other_player).to eq danny
            end
        end

        context "#switch_players" do
            it "will set @current_player to @other_player" do
                game = Game.new([danny, ray])
                other_player = game.other_player
                game.switch_players
                expect(game.current_player).to eq other_player
            end

            it "will set @other_player to @current_player" do
                game = Game.new([danny, ray])
                current_player = game.current_player
                game.switch_players
                expect(game.other_player).to eq current_player
            end
        end

        context "#solicit_move" do
            it "asks the player to make a move" do
                game = Game.new([danny, ray])
                allow(game).to receive(:current_player) { danny }
                expected = "danny: Enter a number between 1 and 9 to make your move"
                expect(game.solicit_move).to eq expected
            end

            it "generates the right message" do
                game = Game.new([danny, ray])
                game.stub_chain(:current_player, :name).and_return "ray"
                expected = "frank: Enter a number between 1 and 9 to make your move"
                expect(game.solicit_move).to eq expected
            end
        end

        context "#get_move" do
            it "converts human_move of '1' to [0,0]" do
                game = Game.new([danny, ray])
                expect(game.get_move("1")).to eq [0,0]
            end

            it "converts human_move of '7' to [0, 2]" do
                game = Game.new([danny, ray])
                expect(game.get_move("7")).to eq [0, 2]
            end

            it "calls #human_move_to_coordinate" do
                game = Game.new([danny, ray])
                game.should_receive(:human_move_to_coordinate).with("x")
                game.get_move("x")
            end
        end

        context "#game_over_message" do
            it "returns '{current player name} won!' If board shows a winner" do
                game = Game.new([danny, ray])
                allow(game).to receive(:current_player) {danny}
                allow(game.board).to receive(:game_over) { :winner }
                expect(game.game_over_message).to eq "danny won!"
            end

            it "returns 'The game ended in a tie' if board shows a draw" do
                game = Game.new([danny, ray])
                allow(game).to receive(:current_player) {danny}
                allow(game.board).to receive(:game_over) { :draw }
                expect(game.game_over_message).to eq "THe game ended in a tie"
            end
        end
        
    end
end