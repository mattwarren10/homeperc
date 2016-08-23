
require "HTTParty"
require 'Nokogiri'
require 'json'
require 'Pry'
require 'csv'
require 'open-uri'

page = HTTParty.get('http://www.homedepot.com/s/oven?NCNI-5&Nao=0')

parse_page = Nokogiri::HTML(page)

items_array = []

index = 0
img_src = ""
description = ""
model_number = ""
price = ""
while index < 24 do
	img_src = parse_page.css('div.product-image img.stretchy')[index]['src'].strip
	description = parse_page.css('div.pod-plp__description a')[index].text.strip
	model_number = parse_page.css('div.pod-plp__model')[index].text.strip
	price = parse_page.css('span.price__format')[index].text.strip
	items_array.push([img_src, description, model_number, price])
	index += 1
end

File.open("items.json","w") do |f|
  f.write(items_array.to_json)
end

CSV.open('items.csv', 'w') do |csv|
	csv << items_array
end
