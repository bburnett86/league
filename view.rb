class View

    def introduction
        puts "Welcome to League Calculator"
        puts "Please put in the file location of the league you would like to calculate"
        games = gets.chomp
        return games
    end

    def outro
        puts "Thank you for using League Calculator, your processed standings have been saved to final.txt"
    end
end