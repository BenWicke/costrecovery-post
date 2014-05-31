require 'csv'

namespace :import_pumpers_csv do

	task :create_pumpers => :environment do
		puts "Import Pumpers"
	
		csv_text = File.read('/Users/Ben/Sites/ror/LFD/pumpers.csv')
		csv = CSV.parse(csv_text, :headers => true)
		csv.each_with_index do |row,index|
			row = row.to_hash.with_indifferent_access
			Pumper.create!(row.to_hash.symbolize_keys)
			one_pumper = Pumper.last
			if @report_timesheet_hash.key?(one_pumper.report_nr)
				one_pumper.timesheet_id = "#{@report_timesheet_hash[one_pumper.report_nr]}"
			end
			
			#one_pumper.timesheet_id = @timesheet_id_array[index]
			one_pumper.save
		end
    end
end