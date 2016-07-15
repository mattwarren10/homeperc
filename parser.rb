require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require "yaml"

class Item
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
		img_src = ""
		description = ""
		model_number = ""
		price = ""
		index = 0
		while index < 25 do
			img_src = page.css('div.product-image img.stretchy')[index]['src'].strip
			description = page.css('a.item_description')[index].text.strip
			model_number = page.css('p.model_container')[index].text
			price = page.css('span.item_price')[index].text.strip
			add_item([img_src, description, model_number, price])
			index += 1
			binding.pry
			end
		end
	end

	def list_items
		puts @items
	end


oven = Item.new
oven.get_items
oven.list_items
oven.save