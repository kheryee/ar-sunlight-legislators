require 'open-uri'
require 'oauth'
require 'rexml/document'
require 'json'
require 'openssl'
require_relative '../app/models/tweet'

def get_tweets(politician_id, twitter_id, num_of_tweets)
  baseurl = "https://api.twitter.com"
  path = "/1.1/statuses/user_timeline.json"
  query = URI.encode_www_form(
      "screen_name" => twitter_id,
      "count" => num_of_tweets)
  address = URI("#{baseurl}{path}?#{query}")
  request = Net::HTTP::Get.new address.request_url

  http = Net::HTTP.new address.host, address.port
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER

  consumer_key = OAuth::Consumer.new(
    "sal0YAhSFdLWbi3XkkyxilVPX",
    "i50BoYZC5TRqTSNYa3pm51aFGkjhr0GPieFQOiqQvfcFE1Va52")
  access_token = OAuth::Token.new(
    "718167336-yvnhuCMJPFCU6bx5WdMyVFo5YC9pVD0sk9HnUvlr",
    "qg5xrX6hk5kc0Y7sdhHCR7PsN2yUBAYopFL0h0q20sP4V")

  request.oauth! http, consumer_key, access_token
  http.start
  response = http.request request

  tweets = nil
  if response.code == '200' then
    tweets = JSON.parse(response.body)

    tweets.each do |x|
      puts "#{politician_id} #{x["user"]["name"]} #{x["text"]}"
      Tweet.create({'politician_id' => politician_id.to_i, 'text' => t["text"], 'tweet_datetime' => x["created_at"]})
    end
  end
end