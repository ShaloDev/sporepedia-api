# frozen_string_literal: true

require 'net/http'
require 'nokogiri'

# Scraps info from Sproe API
module SporeScrapper
  @base_url = 'http://www.spore.com'

  # URL constructors

  # Large picture URL
  def self.large_asset_url(asset_id)
    sub1 = asset_id[0, 3]
    sub2 = asset_id[3, 3]
    sub3 = asset_id[6, 3]
    "#{@base_url}/static/image/#{sub1}/#{sub2}/#{sub3}/#{asset_id}_lrg.png"
  end

  # Thumb picture URL
  def self.asset_url(asset_id)
    sub1 = asset_id[0, 3]
    sub2 = asset_id[3, 3]
    sub3 = asset_id[6, 3]
    "#{@base_url}/static/thumb/#{sub1}/#{sub2}/#{sub3}/#{asset_id}.png"
  end

  # URL for creature stats
  def self.stats_for_creature_url(asset_id)
    "#{@base_url}/rest/creature/#{asset_id}"
  end

  # URL for info about creature
  def self.info_for_asset_url(asset_id)
    "#{@base_url}/rest/asset/#{asset_id}"
  end

  # Special Searches: List creations for a given view.
  # View Types are: TOP_RATED, TOP_RATED_NEW, NEWEST, FEATURED, MAXIS_MADE, RANDOM, CUTE_AND_CREEPY
  def self.asset_search_url(search_type, start, length)
    "#{@base_url}/rest/assets/search/#{search_type}/#{start}/#{length}/CREATURE"
  end

  def self.fetch_response(url)
    uri = URI(url)
    response = Net::HTTP.get_response(uri)
  end

  # Extract assets from response
  def self.extract_assets(response)
    parser = XmlParser.new(response.body)

    assets = []

    assets_element = parser.document[:children].find { |elem| elem[:name] == "assets>" }
    return assets unless assets_element

    assets_element[:children].each do |asset_element|
      next unless asset_element[:name] == "asset>"

      asset_hash = {}
      asset_element[:children].each do |child_element|
        child_name = child_element[:name].chop.to_sym
        asset_hash[child_name] = child_element[:text]
      end

      assets << asset_hash
    end

    assets
  end

  # Extract stats from response
  def self.extract_stats(response)
    parser = XmlParser.new(response.body)

    creature_stats = {}
    creature_element = parser.document[:children].find { |elem| elem[:name] == "creature>" }
    return creature_stats unless creature_element
    creature_element[:children].each do |stat_element|
      stat_name = stat_element[:name].chop.to_sym
      creature_stats[stat_name] = stat_element[:text]
    end
    creature_stats
  end
end
