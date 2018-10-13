require 'nokogiri'
require 'open-uri'
require 'rubygems'
require 'mechanize'

class Api::V1::QuotesController < ApplicationController
  def index
    @quotes_results = Array.new
    @find_errors = Array.new
    params[:tag].split(",").map do |tag_search|
      @verify = Quote.where(tags: /#{tag_search.strip}/)
      if @verify.count > 0
        @verify.map do |db_object|
          @quotes_results.push(db_object.id)
        end
      else
        mechanize = Mechanize.new
        mechanize.get("http://quotes.toscrape.com/tag/#{tag_search.strip}/page/1/") do |page|
          if page.search(".quote").count > 0
            page.search(".quote").map do |quote|
              start = quote.children[3].to_s.index("href=").to_i + 5
              stop = quote.children[3].to_s.index('">(').to_i
              tags_aux = []
              quote.search(".tag").map { |tag| tags_aux.push(tag.text) }
              created_quote = Quote.create(author: quote.search(".author").text, author_about: quote.children[3].to_s[start...stop], quote: quote.search(".text").text, tags: tags_aux)
              @quotes_results.push(created_quote.id)
            end
          else
            @find_errors.push("no results with tag: "+tag_search.to_s )
          end
        end
      end
    end
    render json: Api::V1::QuoteSerializer.new(Quote.where(:_id.in => @quotes_results)).serialized_json
  end
end
