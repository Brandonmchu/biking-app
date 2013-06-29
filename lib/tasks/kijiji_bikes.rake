desc "Fetches from kijiji"
task :fetch_prices => :environment do
  require 'nokogiri'
  require 'open-uri'


  url = "http://toronto.kijiji.ca/f-buy-and-sell-bikes-W0QQCatIdZ644"
  doc = Nokogiri::HTML(open(url))
  for i in 0..19
    title = doc.at_css("#resultRow#{i} td .adLinkSB").text
    price = doc.at_css("#resultRow#{i} .prc").text[/\$[0-9\.]+/]
    posted = doc.at_css("#resultRow#{i} .posted").text
    url = doc.at_css("#resultRow#{i} td .adLinkSB")[:href]
    @bike = Bike.new(:title => title, :price => price, :url => url, :posted => posted)
    @bike.save
  end
end
