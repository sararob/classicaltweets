Twitter.configure do |config|
  config.consumer_key = "Bj6KHLuHy8Z7sPqqMxgfBA"
  config.consumer_secret = "fg1owHOGFbtYpa75ObSt2U0rMPtZr9ls4fbr7NOI"
  config.oauth_token = "332018940-rmtIzqccdIgQhQH8kcAG7SOROb5aUbXUpkpJq3Su"
  config.oauth_token_secret = "Tj3iGznqJTvPBl6cFqTPneu6ZlyCu3mFmexGMk8"
end

middleware = Proc.new do |builder|
  builder.use Twitter::Request::MultipartWithFile
  builder.use Faraday::Request::Multipart
  builder.use Faraday::Request::UrlEncoded
  builder.use Twitter::Response::RaiseError, Twitter::Error::ClientError
  builder.use Twitter::Response::ParseJson
  builder.use Twitter::Response::RaiseError, Twitter::Error::ServerError
  builder.adapter :typhoeus
end

Twitter.middleware = Faraday::Builder.new(&middleware)
