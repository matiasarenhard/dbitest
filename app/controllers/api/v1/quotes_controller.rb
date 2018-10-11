require 'nokogiri'
require 'open-uri'
require 'rubygems'
require 'mechanize'


class Api::V1::QuotesController < ApplicationController
  def index
    mechanize = Mechanize.new
    mechanize.get('http://quotes.toscrape.com') do |page|
      page.search(".quote").map do |quote|
        quote = quote.children[1].text
        author = quote.children[3].text
        #author_about = quote.children[3].text
        tags = quote.children[5].text
        byebug
      end
    end
  end

  def create
  end
end
