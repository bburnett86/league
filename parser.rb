class Parser
    def input_teams(file_location)
        games = File.open(file_location).read.split("\n")
    end

    def create_file(output)
        File.open("final.txt", "w+") do |f|
            output.each { |element| f.puts(element) }
          end
    end
end