require 'net/http'
require 'open-uri'
require 'nokogiri'


class Crawler

	attr_accessor :link
	
	def initialize
		@link=[]
	end

	def parse(page)
		arr_parsed_links = []
			doc = Nokogiri::HTML(open(page))
			doc.xpath('//a').each do |link|
				if !((link[:href]=='#') || (link[:href].nil?)) then
					if link[:href].include?('http') then 
						arr_parsed_links << link[:href] 
					end
				end
			end
			arr_parsed_links
		end

	def find_links(page, depth)
		unless @link.include? page 
			links_array = parse(page)
			if depth > 1 then 
				links_array.each  do |page| 
					find_links(page, depth-1)
				end 
			end
			@link += links_array
		end
		@link
	end
	
end
