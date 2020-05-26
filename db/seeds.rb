require 'open-uri'
require 'nokogiri'
require 'pry'

url_list = "https://www.atptour.com/en/scores/results-archive"
url_tournaments = []

html_file = open(url_list).read
html_doc = Nokogiri::HTML(html_file)

html_doc.search('.tourney-result .title-content a').each do |element|
  name_path = element.attribute('href').value
  tournament_link = "https://www.atptour.com#{name_path}"
  url_tournaments << tournament_link
end

url_tournaments.first(3).each do |url|
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  # tournament name
  name = html_doc.at('.last-name').text
  # total prize money
  prize_money = html_doc.at('.prize-money-bottom').text.strip
  # tournament surface
  surface = html_doc.at('.surface-bottom .item-value').text.strip
  # total single participants
  total_participants = html_doc.at('.bracket-sgl .item-inline-value').text.strip
  # link to official website
  official_link = html_doc.at('.official-website-link').attribute('href').value
  # ATP description
  description = html_doc.at('.the-blurb').text.strip
  # location of the tournament
  address = html_doc.search('.hero-date-range')[0].children.first.text
  # start and end dates
  date = html_doc.search('.hero-date-range')[1].children.first.text.gsub("- ", "").split(" ")
  start_date = Date.parse([date[0], date[1], date[3]].join(" "))
  end_date = Date.parse([date[0], date[2], date[3]].join(" "))
  # lon and lat
  gps_coordinates = html_doc.search('.tournament-hero-links').children[2].attributes.first[1].value.split('/')[5].split(',')
  lat = gps_coordinates[0]
  lon = gps_coordinates[1]
  # tournament photo
  tournament_photo = html_doc.at('#tournamentHero')
  photo_link = "https://www.atptour.com/#{tournament_photo.attributes['style'].value.split("'")[1]}"
  #atp logo
  tournament_logo = html_doc.at('.tournmanet-logo')
  puts logo_link = "https://www.atptour.com#{tournament_logo.children[1].attributes['src'].value}"

end

