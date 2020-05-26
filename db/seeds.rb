
require 'open-uri'
require 'nokogiri'
require 'pry'

url_list = "https://www.atptour.com/en/scores/results-archive"
url_tournaments = []

html_file = open(url_list).read
html_doc = Nokogiri::HTML(html_file)

html_doc.search('.tourney-result .title-content a').each do |element|
  name_path = element.attribute('href').value
  tournament_link = "https://www.atptour.com#{name_path}?detailTab=points"
  url_tournaments << tournament_link
end

url_tournaments.first(2).each do |url|
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
  # atp logo
  tournament_logo = html_doc.at('.tournmanet-logo')
  logo_link = "https://www.atptour.com#{tournament_logo.children[1].attributes['src'].value}"

  # atp category
  category = html_doc.at('.tournmanet-logo').children[1].attributes['alt'].value

  tournament = Tournament.new({ name: name, address: address, prize_money: prize_money, surface: surface, category: category, start_date: start_date, end_date: end_date, participants: total_participants, description: description, latitude: lat, longitude: lon,  })
  tournament.photo.attach(io: URI.open(photo_link), filename: "tournament.jpg", content_type: "image/jpg")
  tournament.logo.attach(io: URI.open(logo_link), filename: "category.jpg", content_type: "image/jpg")
  tournament.save!
end

# puts "Cleaning Users seeds"
# User.destroy_all
# puts "Creating some Users"
# benoit = User.new({ first_name: "Benoit", last_name: "Bargès", email: "benoit@gmail.com", password: "tennis" })
# benoit.avatar.attach(io: File.open("app/assets/images/avatars/benoit.jpg"), filename: "avatar.jpg", content_type: "image/jpg")
# benoit.save
# augustin = User.new({ first_name: "Augustin", last_name: "Lazarus", email: "augustin@gmail.com", password: "tennis" })
# augustin.avatar.attach(io: File.open("app/assets/images/avatars/augustin.jpg"), filename: "avatar.jpg", content_type: "image/jpg")
# augustin.save
# francois = User.new({ first_name: "François", last_name: "Desazars", email: "francois@gmail.com", password: "tennis" })
# francois.avatar.attach(io: File.open("app/assets/images/avatars/francois.jpg"), filename: "avatar.jpg", content_type: "image/jpg")
# francois.save
# alexandre = User.new({ first_name: "Alexandre", last_name: "Deniau", email: "alexandre@gmail.com", password: "tennis" })
# alexandre.avatar.attach(io: File.open("app/assets/images/avatars/alex.jpg"), filename: "avatar.jpg", content_type: "image/jpg")
# alexandre.save
# puts "Finished!"

