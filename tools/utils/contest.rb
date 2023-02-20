require "date"

class Contest
    attr_reader :name, :category, :url, :start_date, :end_date

    def initialize(name, category, url, start_date, end_date)
        @name = name
        @category = category
        @url = url
        @start_date = DateTime.iso8601(start_date)
        @end_date = DateTime.iso8601(end_date)
    end

    def is_over?
        @end_date < DateTime.now
    end

    def is_upcoming?
        @start_date > DateTime.now
    end

    def is_ongoing?
        !is_over? && !is_upcoming?
    end

    def is_multi_day?
        @start_date != @end_date
    end

    def to_markdown
        date = is_multi_day? ? "#{@start_date.day}-#{@end_date.day}" : @start_date.day
        "* #{date}: [#{@name}](#{@url}) <img alt=\"#{@category}\" src=\"https://img.shields.io/badge/#{@category.capitalize}-yellow\">"
    end

end