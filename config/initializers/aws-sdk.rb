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


s3 = S3::Service.new(:access_key_id => "AKIAI5CRDNOCVAEAM5SA",
                      :secret_access_key => "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")