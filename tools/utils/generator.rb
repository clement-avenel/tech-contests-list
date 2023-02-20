require "json"
require "./contest.rb"

raw_data = File.read('../data/contests-data.json')
TECH_CONTESTS_DATA = JSON.parse(raw_data)

module Generator
    class << self
        def generate_contests_array
            TECH_CONTESTS_DATA.map do |contest|
                Contest.new(contest['name'], contest['category'], contest['url'], contest['startDate'], contest['endDate'])
            end.sort_by(&:start_date)
        end

        def generate_contests_list(file)
            @contests = generate_contests_array
            (1..12).map do |month|
                file.puts "### #{Date::MONTHNAMES[month]}"
                @contests.select{|c|c.start_date.month == month}.each do |contest|
                    file.puts contest.to_markdown
                end
            end
        end

        def generate_readme
            File.open("../../README.md", "w") do |file|
                file.puts "# tech-contests-list"
                file.puts "This repository is a resource for technology enthusiasts who are interested in participating in various technology-related contests and stay up-to-date on the latest opportunities. The repository is a curated list of all upcoming technology contests with their corresponding dates, making it easy for competitors to stay informed and plan accordingly.\n\nIt's an open and collaborative project that welcomes contributions from anyone interested in sharing information about technology contests."
                file.puts "## How to contribute"
                file.puts "If you want to contribute to this repository, please do a [Pull Request (PR)](https://github.com/clement-avenel/tech-contests-list/pulls) in order to update this list."
                file.puts "## 2023"
                generate_contests_list(file)
            end
            return true
        end
    end
end