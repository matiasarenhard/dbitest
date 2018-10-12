require 'nokogiri'
require 'open-uri'
require 'rubygems'
require 'mechanize'


class Api::V1::QuotesController < ApplicationController
  def index
    response = []
    params[:tag].split(",").map do |tag_search|
      verify = Quote.where(tags: /#{tag_search}/)
      if verify.count > 0
        response.push(verify)
      else
        mechanize = Mechanize.new
        mechanize.get("http://quotes.toscrape.com/tag/#{tag_search}/page/1/") do |page|
          page.search(".quote").map do |quote|
            description_quote = quote.search(".text").text
            author = quote.search(".author").text
            start = quote.children[3].to_s.index("href=").to_i + 5
            stop = quote.children[3].to_s.index('">(').to_i
            author_about = quote.children[3].to_s[start...stop]
            tags_aux = []
            quote.search(".tag").map do |tag|
              tags_aux.push(tag.text)
            end
            create_quote = Quote.create(author: author, author_about: author_about, quote: description_quote, tags: tags_aux)
            response.push(create_quote)
          end
        end
      end
    end
  end
end
