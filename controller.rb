require_relative 'view'
require_relative 'scoreboard'
require_relative 'parser'

class Controller
    attr_accessor :score_board
    
    def initialize
        @view = View.new
        @parser = Parser.new
        @scoreboard = 0
    end

    def run_game
        location = @view.introduction
        teams = @parser.input_teams(location)
        @scoreboard = Scoreboard.new(teams)
        g_arrays = @scoreboard.create_games_arrays
        t_hashes = @scoreboard.create_team_hashes
        results = @scoreboard.determine_winners(g_arrays)
        final = @scoreboard.update_teams_hash(t_hashes, results)
        output = @scoreboard.output_prep(final)
        @parser.create_file(output)
        @view.outro
    end

end