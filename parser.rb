require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require "yaml"

class Item
	attr_writer :descriptions, :model_numbers, :prices

	def initialize 
		@items = []
	end

	def save
    	File.open("items.yml", "w") do |file|
      	file.write(item.to_yaml)
    	end
    end
    
    def add_item(item)
    	@items.push(item)
    end	

	def get_items
		input = gets.chomp
		page_url = "http://www.homedepot.com/s/#{input}?NCNI-5&Nao=0"
		page = Nokogiri::HTML(open(page_url))
		index = 0
		description = ""
		model_number = ""
		price = ""
		while index < 25 do
			description = page.css('a.item_description')[index].text
			model_number = page.css('p.model_container')[index].text
			price = page.css('span.item_price')[index].text
			add_item([description, model_number, price])
			index += 1
			end
		end
	end


oven = Item.new
oven.get_items
