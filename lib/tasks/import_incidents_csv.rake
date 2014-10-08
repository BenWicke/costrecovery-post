require 'csv'
require 's3'
#require 'aws/s3'
#require 'net/ftp'


service = S3::Service.new(:access_key_id => "AKIAI5CRDNOCVAEAM5SA",
                          :secret_access_key => "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")


=begin
Net::FTP.open('97.74.158.128', 'crpost', 'Recovery1!') do |ftp|
  ftp.chdir('/irst/connect')
  files = ftp.list('nlst')
end
=end


=begin
url = URL.new('http://www.ciagent-stormwater.com/irst/connect/sample.txt', 'r')
url.gets
#response = url.get
=end


=begin
puts "buckets"
service.buckets
=end
                          
                          
new_bucket = service.buckets.build("newbucketname")
new_bucket.save(:location => :us)


namespace :import_incidents_csv do

	task :create_incidents => :environment do
		puts "Import Incidents"
    
#    ftp = FtpSync.new 'http://ciagent-stormwater.com', 'dparker-ciagent', 'ciagent'
#    ftp.pull_dir '../connect', '/webroot/irst/connect', :since => Time.now




=begin    
    puts __FILE__
    puts File.expand_path(__FILE__)
    puts File.dirname(__FILE__)
    puts File.join(File.dirname(__FILE__), '..', 'connect')
=end
		
		csv_text = File.read('/Users/Ben/Sites/ror/LFD/incidents.csv', :encoding => 'windows-1251:utf-8')
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