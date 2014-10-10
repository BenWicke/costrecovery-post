=begin
AWS.config({
:access_key_id => 'AKIAI5CRDNOCVAEAM5SA',
:secret_access_key => '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',
})
=end


=begin
[default]
aws_access_key_id = AKIAI5CRDNOCVAEAM5SA
aws_secret_access_key = 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
=end

=begin
s3 = S3::Service.new(:access_key_id => "AKIAI5CRDNOCVAEAM5SA",
                      :secret_access_key => "jMiNIbulZwrahcaIyFhtRO7pjXqooRfVOpHddiZl")

=end


=begin    
    AWS::S3::DEFAULT_HOST.replace "s3-website-us-east-1.amazonaws.com"
    
    AWS::S3::Base.establish_connection!(
      :access_key_id  => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
    )
=end