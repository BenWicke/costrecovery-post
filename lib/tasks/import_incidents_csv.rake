require 'csv'
require 'open-uri'
#require 's3'
#Below is the most up to date gem 
#require 'aws-sdk'

#require 'aws/s3'
#require 'net/ftp'

=begin

AWS.config(
  :access_key_id => 'AKIAI5CRDNOCVAEAM5SA',
  :secret_access_key => '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')
=end

=begin
s3 = S3::Service.new(:access_key_id => "AKIAI5CRDNOCVAEAM5SA",
                          :secret_access_key => "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")
=end

=begin
Net::FTP.open('97.74.158.128', 'crpost', 'Recovery1!') do |ftp|
  ftp.chdir('/irst/connect')
  files = ftp.list('nlst')
end
=end


=begin
pay no attention to

  url = URL.new('http://www.ciagent-stormwater.com/irst/connect/sample.txt', 'r')
  url.gets
  response = url.get
=end


=begin
puts "buckets"
service.buckets
=end
                          
=begin                          
new_bucket = service.buckets.build("fireballs_on_the_east_coast_4444444444444")
new_bucket.save(:location => :us)



s3 = AWS::S3.new
s3.buckets.each do |bucket|
  puts bucket.name
end


AWS::S3::Service.buckets
first_bucket = service.buckets.find("fireballs_on_the_east_coast_1234874634")


=begin
attempt to connect via ftp; pay no attention to

    ftp = FtpSync.new 'http://ciagent-stormwater.com', 'dparker-ciagent', 'ciagent'
    ftp.pull_dir '../connect', '/webroot/irst/connect', :since => Time.now

=end


=begin 
trying to figure out how to reference a a csv file from an above directory


    #puts __FILE__
    #puts File.expand_path(__FILE__)
    #puts File.dirname(__FILE__)
    #File.join(File.dirname(__FILE__), '..', "Lexington")
    #puts "#{current}"
    #puts File.expand_path(Dir.pwd, '..')
    
=end     


namespace :import_incidents_csv do

	task :create_incidents => :environment do
		puts "Import Incidents"    
		
		#csv_text = File.read('/Users/Ben/Sites/ror/LFD/incidents.csv', :encoding => 'windows-1251:utf-8')
		csv_text = open("http://www.ciagent-stormwater.com/Lexington_Files/incidents.csv") {|f| f.read}
    csv = CSV.parse(csv_text, :headers => true)
		
		@incident_id_array = []
		@report_nr_array = []
		csv.each do |row|
			row = row.to_hash.with_indifferent_access
			Incident.create!(row.to_hash.symbolize_keys)
			@incident_id_array << Incident.last.id
			@report_nr_array << Incident.last.report_nr
		end
		
#------This combines the incidents array and the report_nr array into a hash
		
		@report_incident_hash = {}
		@report_nr_array.each_with_index do |value, index|
			@report_incident_hash[value] = @incident_id_array[index]
		end
		#puts @report_incident_hash
#----------------------------------------------------------------------------
		
   end
end