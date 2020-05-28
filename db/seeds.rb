require 'open-uri'
require 'nokogiri'

def download_to_file(uri)
  stream = open(uri, "rb")
  return stream if stream.respond_to?(:path)
  Tempfile.new.tap do |file|
    file.binmode
    IO.copy_stream(stream, file)
    stream.close
    file.rewind
  end
end

url_list = "https://www.atptour.com/en/scores/results-archive"
url_tournaments = []

html_file = open(url_list).read
html_doc = Nokogiri::HTML(html_file)



html_doc.search('.tourney-result .title-content a').each do |element|
  name_path = element.attribute('href').value
  tournament_link = "https://www.atptour.com#{name_path}?detailTab=points"
  url_tournaments << tournament_link
end

# url_tournaments[44]
# url_tournaments[54]

puts "Cleaning tournaments...."
Tournament.destroy_all

puts "Creating tournament database...."
url_tournaments.each do |url|
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  p "------------------------"

  # tournament name
  if html_doc.at('.last-name').present?
    name = html_doc.at('.last-name').text.strip
  else
    name = ""
  end

  # total prize money
  if html_doc.at('.prize-money-bottom').present?
    prize_money = html_doc.at('.prize-money-bottom').text.strip
  else
    prize_money = 0
  end
  # tournament surface
  if html_doc.at('.surface-bottom .item-value').present?
    surface = html_doc.at('.surface-bottom .item-value').text.strip
  else
    surface = ""
  end
  # total single participants
  if html_doc.at('.bracket-sgl .item-inline-value').present?
    total_participants = html_doc.at('.bracket-sgl .item-inline-value').text.strip
  else
    total_participants = 28
  end
  # link to official website
  if html_doc.at('.player-profile-hero-social .official-website-link').present?
    official_link = html_doc.at('.player-profile-hero-social .official-website-link').attribute('href').value
  else
    official_link = ""
  end
  # ATP description
  if html_doc.at('.the-blurb').present?
    description = html_doc.at('.the-blurb').text.strip
  else
    description = ""
  end
  # location of the tournament
  if html_doc.search('.hero-date-range').present?
    address = html_doc.search('.hero-date-range')[0].children.first.text
  else
    address = ""
  end
  # start and end dates
  if html_doc.search('.hero-date-range').present?
    date = html_doc.search('.hero-date-range')[1].children.first.text.gsub("- ", "").split(" ")
    start_date = Date.parse([date[0], date[1], date[3]].join(" "))
    if date.length == 4
      end_date = Date.parse([date[0], date[2], date[3]].join(" "))
    elsif date.length == 5
      end_date = Date.parse([date[2], date[3], date[4]].join(" "))
    end
  else
    start_date = 2020/01/01
    start_end = 2020/01/02
  end
  # lon and lat
  if html_doc.search('.tournament-hero-links').present?
    gps_coordinates = html_doc.search('.tournament-hero-links').children[2].attributes.first[1].value.split('/')[5].split(',')
    lat = gps_coordinates[0]
    lon = gps_coordinates[1]
  else
    lat = 48.8588376
    lon = 2.2768487
  end
  # tournament photo
  tournament_photo = html_doc.at('#tournamentHero')
  photo_link = "https://www.atptour.com/#{tournament_photo.attributes['style'].value.split("'")[1]}"
  downloaded_photo = URI.open(photo_link)
  if downloaded_photo.is_a? StringIO
    downloaded_photo = download_to_file(URI.parse(photo_link))
  end

  # atp logo
  tournament_logo = html_doc.at('.tournmanet-logo')
  logo_link = "https://www.atptour.com#{tournament_logo.children[1].attributes['src'].value}"
  downloaded_logo = URI.open(logo_link)
  if downloaded_logo.is_a? StringIO
    downloaded_logo = download_to_file(URI.parse(logo_link))
  end

  # atp category
  if html_doc.at('.tournmanet-logo').present?
    category = html_doc.at('.tournmanet-logo').children[1].attributes['alt'].value
  else
    category = ""
  end

  # atp points
  # tournament_points = html_doc.search('#tourneyOverviewTabs > div.tourney-tab-content > div > div:nth-child(1) > table > tbody > tr:nth-child(1) > td:nth-child(3)')

  # tournament creation
  tournament = Tournament.new({ name: name, address: address, official_link: official_link, prize_money: prize_money, surface: surface, category: category, start_date: start_date, end_date: end_date, participants: total_participants, description: description, latitude: lat, longitude: lon })
  tournament.save
  tournament.photo.attach(io: downloaded_photo, filename: "tournament.jpg")
  tournament.logo.attach(io: downloaded_logo, filename: "category.png")

  p "#{name} created!"
end

puts "Finished"

# puts "Cleaning Users seeds"
# User.destroy_all
# puts "Creating some Users"
# stephane = User.new({ first_name: "stephane", last_name: "Bargès", email: "stephane@gmail.com", password: "tennis" })
# stephane.avatar.attach(io: File.open("app/assets/images/stephane.jpg"), filename: "avatar.jpg", content_type: "image/jpg")
# stephane.save
# puts "Finished!"

