desc "Fetches from kijiji"
task :fetch_prices => :environment do
  require 'nokogiri'
  require 'open-uri'


  url = "http://toronto.kijiji.ca/f-buy-and-sell-bikes-W0QQCatIdZ644"
  doc = Nokogiri::HTML(open(url))
  for i in 0..5
    title = doc.at_css("#resultRow#{i} td .adLinkSB").text
    price = doc.at_css("#resultRow#{i} .prc").text
    price = '%.3f' % price.delete( "$" ).to_f
    url = doc.at_css("#resultRow#{i} td .adLinkSB")[:href]
    unless doc.at_css("#resultRow#{i} li") == nil
      locationKijiji = doc.at_css("#resultRow#{i} li").text
    end
    imageDocKijiji = Nokogiri::HTML(open(url))
    unless imageDocKijiji.at_css(".view") == nil
      imageUrl = imageDocKijiji.at_css(".view").attribute('src').to_s
    end
    @bike = Bike.new(:title => title, :price => price, :url => url, :posted => imageUrl, :location => locationKijiji)
    @bike.save
  end

  urlCraigs = "http://toronto.en.craigslist.ca/tor/bik/"
  docCraigs = Nokogiri::HTML(open(urlCraigs))
  docCraigs.css(".row").take(2).each do |bike|
    titleCraigs = bike.at_css(".pl a").text
    urlCraigs = "http://toronto.en.craigslist.ca"+bike.at_css(".pl a")[:href]
    unless bike.at_css(".price") == nil
      priceCraigs = bike.at_css(".price").text
      priceCraigs = '%.3f' % priceCraigs.delete( "$" ).to_f
    end
    unless bike.at_css("small") == nil
      locationCraigs = bike.at_css("small").text.delete('()')
    end
    imageCraigs = "http://toronto.en.craigslist.ca"+bike.at_css(".pl a")[:href]
    imageDocCraigs = Nokogiri::HTML(open(imageCraigs))
    unless imageDocCraigs.at_css("#iwi") == nil
      imageUrlCraigs = imageDocCraigs.at_css("#iwi").attribute('src').to_s
    end
    @bike = Bike.new(:title => titleCraigs, :price => priceCraigs, :url => urlCraigs, :posted => imageUrlCraigs, :location => locationCraigs)
    @bike.save
  end

end

# Original
  # url = "http://toronto.kijiji.ca/f-buy-and-sell-bikes-W0QQCatIdZ644"
  # doc = Nokogiri::HTML(open(url))
  # for i in 0..19
  #   title = doc.at_css("#resultRow#{i} td .adLinkSB").text
  #   price = doc.at_css("#resultRow#{i} .prc").text
  #   price = '%.3f' % price.delete( "$" ).to_f
  #   url = doc.at_css("#resultRow#{i} td .adLinkSB")[:href]
  #   imageDocKijiji = Nokogiri::HTML(open(url))
  #   unless imageDocKijiji.at_css(".view") == nil
  #     imageUrl = imageDocKijiji.at_css(".view").attribute('src').to_s
  #   end
  #   @bike = Bike.new(:title => title, :price => price, :url => url, :posted => imageUrl)
  #   @bike.save
  # end

  # urlCraigs = "http://toronto.en.craigslist.ca/tor/bik/"
  # docCraigs = Nokogiri::HTML(open(urlCraigs))
  # docCraigs.css(".row").each do |bike|
  #   titleCraigs = bike.at_css(".pl a").text
  #   urlCraigs = "http://toronto.en.craigslist.ca"+bike.at_css(".pl a")[:href]
  #   unless bike.at_css(".price") == nil
  #     priceCraigs = bike.at_css(".price").text
  #     priceCraigs = '%.3f' % priceCraigs.delete( "$" ).to_f
  #   end
  #   unless bike.at_css("small") == nil
  #     locationCraigs = bike.at_css("small").text
  #   end
  #   imageCraigs = "http://toronto.en.craigslist.ca"+bike.at_css(".pl a")[:href]
  #   imageDocCraigs = Nokogiri::HTML(open(imageCraigs))
  #   unless imageDocCraigs.at_css("#iwi") == nil
  #     imageUrlCraigs = imageDocCraigs.at_css("#iwi").attribute('src').to_s
  #   end
  #   @bike = Bike.new(:title => titleCraigs, :price => priceCraigs, :url => urlCraigs, :posted => imageUrlCraigs)
  #   @bike.save
  # end
