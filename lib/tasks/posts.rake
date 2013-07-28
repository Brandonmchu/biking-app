desc "Fetches from kijiji"
task :fetch_prices => :environment do
  require 'nokogiri'
  require 'open-uri'

kijiji = { "bike" => "f-buy-and-sell-bikes-W0QQCatIdZ644",
           "rentals" => "f-real-estate-apartments-condos-W0QQCatIdZ37"
}

kijiji.each_pair do |category,catUrl|
  url = "http://toronto.kijiji.ca/"+catUrl
  doc = Nokogiri::HTML(open(url))
  for i in 0..5
    title = doc.at_css("#resultRow#{i} td .adLinkSB").text
    price = doc.at_css("#resultRow#{i} .prc").text
    price = price.delete("$")
    price = price.delete(",")
    price = price.to_f
    url = doc.at_css("#resultRow#{i} td .adLinkSB")[:href]
    unless doc.at_css("#resultRow#{i} li") == nil 
      locationKijiji = doc.at_css("#resultRow#{i} li").text
    end
    imageDocKijiji = Nokogiri::HTML(open(url))
    imageUrl = nil #clears out the previous iteration's image
    unless imageDocKijiji.at_css(".view") == nil
      imageUrl = imageDocKijiji.at_css(".view").attribute('src').to_s
    end
    @post = Post.new(:title => title, :price => price, :url => url, :posted => imageUrl, :location => locationKijiji, :category => category)
    @post.save
  end
end

  urlCraigs = "http://toronto.en.craigslist.ca/tor/bik/"
  docCraigs = Nokogiri::HTML(open(urlCraigs))
  docCraigs.css(".row").take(2).each do |post|
    titleCraigs = post.at_css(".pl a").text
    urlCraigs = "http://toronto.en.craigslist.ca"+post.at_css(".pl a")[:href]
    unless post.at_css(".price") == nil
      priceCraigs = post.at_css(".price").text
      price = price.delete("$")
      price = price.delete(",")
      price = price.to_f
    end
    unless post.at_css("small") == nil
      locationCraigs = post.at_css("small").text.delete('()')
    end
    imageCraigs = "http://toronto.en.craigslist.ca"+post.at_css(".pl a")[:href]
    imageDocCraigs = Nokogiri::HTML(open(imageCraigs))
    unless imageDocCraigs.at_css("#iwi") == nil
      imageUrlCraigs = imageDocCraigs.at_css("#iwi").attribute('src').to_s
    end
    @post = Post.new(:title => titleCraigs, :price => priceCraigs, :url => urlCraigs, :posted => imageUrlCraigs, :location => locationCraigs)
    @post.save
  end

end

