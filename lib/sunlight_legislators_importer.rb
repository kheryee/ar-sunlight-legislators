require 'csv'
require_relative '../app/models/politician'

class SunlightLegislatorsImporter
  def self.import(filename=File.dirname(__FILE__) + "/../db/data/legislators.csv")
    csv = CSV.new(File.open(filename), :headers => true)
    ignore_fields = ["middlename","name_suffix","nickname","congress_office","bioguide_id","votesmart_id","fec_id","govtrack_id","crp_id","congresspedia_url","youtube_url","facebook_id","official_rss","senate_class"]

    csv.each do |row|
      hash = {}
      row.each do |field, value|

  # hash = { :firstname => ? }
        hash[field] = value unless ignore_fields.include?(field)
          # raise NotImplementedError, "TODO: figure out what to do with this row and do it!"
          # TODO: end
      end
      Politician.create(hash)
    end
  end
end

# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
# begin
#   raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
#   SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end
