require_relative '../scoreboard'

RSpec.describe Scoreboard do
    let(:scoreboard) {Scoreboard.new(["Lions 3, Snakes 3", "Tarantulas 1, FC Awesome 0", "Lions 1, FC Awesome 1", "Tarantulas 3, Snakes 1", "Lions 4, Grouches 0"])}

    it 'creates an array of game arrays from initial scoreboard string' do
        expect(scoreboard.create_games_arrays).to eq([["Lions", 3], ["Snakes", 3], ["Tarantulas", 1], ["FC Awesome", 0], ["Lions", 1], ["FC Awesome", 1], ["Tarantulas", 3],["Snakes", 1], ["Lions", 4], ["Grouches", 0]])
    end

    it 'creates an array of team hashes from the original scoreboard string' do
        expect(scoreboard.create_team_hashes).to eq({"Lions"=>0, "Snakes"=>0, "Tarantulas"=>0, "FC Awesome"=>0, "Grouches"=>0})
    end

    it 'determines winner of games and changes score to "w", "l" or "t"' do
        expect(scoreboard.determine_winners([["Lions", 3], ["Snakes", 3], ["Tarantulas", 1], ["FC Awesome", 0], ["Lions", 1], ["FC Awesome", 1], ["Tarantulas", 3],["Snakes", 1], ["Lions", 4], ["Grouches", 0]])).to eq([["Lions", "t"], ["Snakes", "t"], ["Tarantulas", "w"], ["FC Awesome", "l"], ["Lions", "t"], ["FC Awesome", "t"], ["Tarantulas", "w"], ["Snakes", "l"], ["Lions", "w"], ["Grouches", "l"]])
    end

    it 'calculates scores using the team hash and the array of teams and their game results' do
        expect(scoreboard.update_teams_hash({"Lions"=>0, "Snakes"=>0, "Tarantulas"=>0, "FC Awesome"=>0, "Grouches"=>0}, [["Lions", "t"], ["Snakes", "t"], ["Tarantulas", "w"], ["FC Awesome", "l"], ["Lions", "t"], ["FC Awesome", "t"], ["Tarantulas", "w"], ["Snakes", "l"], ["Lions", "w"], ["Grouches", "l"]])).to eq({"Lions"=>5, "Snakes"=>1, "Tarantulas"=>6, "FC Awesome"=>1, "Grouches"=>0})
    end

    it 'formats results array for txt file' do
        expect(scoreboard.output_prep({"Lions"=>5, "Snakes"=>1, "Tarantulas"=>6, "FC Awesome"=>1, "Grouches"=>0})).to eq(["1. Tarantulas, 6 pts", "2. Lions, 5 pts", "3. FC Awesome, 1 pt", "3. Snakes, 1 pt", "5. Grouches, 0 pts"])
    end
end