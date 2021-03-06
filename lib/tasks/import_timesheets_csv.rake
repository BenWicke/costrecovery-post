require 'csv'
require 'open-uri'

namespace :import_timesheets_csv do

	task :create_timesheets => :environment do
		puts "Import Timesheets"
	
#		csv_text = File.read('http://www.ciagent-stormwater.com/Lexington_Files/timesheets.csv', :encoding => 'windows-1251:utf-8')
    csv_text = open("http://www.ciagent-stormwater.com/irst/lexington/timesheets.csv") {|f| f.read}
		csv = CSV.parse(csv_text, :headers => true)
		@timesheet_id_array = []
		csv.each_with_index do |row,index|
			row = row.to_hash.with_indifferent_access
			Timesheet.create!(row.to_hash.symbolize_keys)
			@timesheet_id_array << Timesheet.last.id
			timesheet = Timesheet.last
			timesheet.incident_id = @incident_id_array[index]
			timesheet.save
		end

#------This combines the timesheet array and the report_nr array into a hash
		
		@report_timesheet_hash = {}
		@report_nr_array.each_with_index do |value, index|
			@report_timesheet_hash[value] = @timesheet_id_array[index]
		end
		puts @report_timesheet_hash
#----------------------------------------------------------------------------
		
    end
end

