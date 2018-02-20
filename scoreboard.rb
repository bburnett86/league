class Scoreboard
    def initialize(games_array)
        @games_array = games_array
    end

    def create_games_arrays
        games_array =[]
        @games_array.each do |game|
            game.split(", ").each do |team_score|
                value = team_score.scan(/\d+/).join
                array_slicer = (value.length) * (-1)
                key = team_score[0...array_slicer].rstrip!
                games_array << [key , value.to_i]
            end
        end
        return games_array
    end

    def create_team_hashes
        teams_hash ={}
        @games_array.each do |game|
            game.split(", ").each do |team_score|
                value = team_score.scan(/\d+/).join
                array_slicer = (value.length) * (-1)
                key = team_score[0...array_slicer].rstrip!
                teams_hash["#{key}"] = 0
            end
        end
        return teams_hash
    end

    def determine_winners(games_hashes)
        results_array = []
        counter = 0
        ((games_hashes.length)/2).times do
            if games_hashes[counter][1] > games_hashes[(counter +1)][1]
                games_hashes[counter][1] = "w"
                games_hashes[(counter +1)][1] = "l"
                results_array << [games_hashes[counter][0], games_hashes[counter][1] ]
                results_array << [games_hashes[(counter + 1)][0], games_hashes[(counter + 1)][1]]
                counter += 2
            elsif games_hashes[(counter +1)][1] > games_hashes[counter][1]
                games_hashes[counter][1] = "l"
                games_hashes[(counter +1)][1] = "w"
                results_array << [games_hashes[counter][0], games_hashes[counter][1] ]
                results_array << [games_hashes[(counter + 1)][0], games_hashes[(counter + 1)][1]]
                counter += 2
            else
                games_hashes[counter][1] = "t"
                games_hashes[(counter +1)][1] = "t"
                results_array << [games_hashes[counter][0], games_hashes[counter][1] ]
                results_array << [games_hashes[(counter + 1)][0], games_hashes[(counter + 1)][1]]
                counter += 2
            end
        end
        return results_array
    end

    def update_teams_hash(teams_hash, results_array)
        results_array.each do |result|
            if result[1] == "w"
                teams_hash["#{result[0]}"] += 3
            elsif result[1] == "t"
                teams_hash["#{result[0]}"] += 1
            end
        end
        return teams_hash
    end

    def output_prep(results_hash)
        final_array = []
        count_ayyay = []
        alph_array = results_hash.sort.to_a
        last_value = (results_hash.values.uniq).length
        organized_arrays = alph_array.sort { |a, b| b[1] <=> a[1]}
        count = 1
        index = 0
        skip = 0
        (organized_arrays.length - 1).times do
            if organized_arrays[index][1] > organized_arrays[index + 1][1]
                organized_arrays[index][0] = "#{count}. ".concat(organized_arrays[index][0])
                count = count + skip
                count +=1
                index +=1
            elsif organized_arrays[index][1] == organized_arrays[index + 1][1]
                organized_arrays[index][0] = "#{count}. ".concat(organized_arrays[index][0])
                skip +=1
                index +=1
            end
        end
        organized_arrays[-1][0] = "#{(last_value + skip)}. ".concat(organized_arrays[-1][0])

        organized_arrays.each do |arr|
            point = ""
            if arr[1] == 1
                point = " pt"
            else
                point = " pts"
            end
            final_array << arr.join(", ") + point
        end
        return final_array
    end

end

s = Scoreboard.new(["Lions 3, Snakes 3", "Tarantulas 1, FC Awesome 0", "Lions 1, FC Awesome 1", "Tarantulas 3, Snakes 1", "Lions 4, Grouches 0"])
g_arrays = s.create_games_arrays
t_hashes = s.create_team_hashes
results = s.determine_winners(g_arrays)
final = s.update_teams_hash(t_hashes, results)
p output = s.output_prep(final)