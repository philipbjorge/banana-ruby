require 'singleton'
require 'rest-client'
require 'retries'

class Banana::Client
  include Singleton

  def initialize
    @api = RestClient::Resource.new(Banana.config.base_url, 
                                    headers: { 
                                      Authorization: "Bearer #{Banana.config.api_key}"
                                    })
  end

  def upload_suite_results(results)
    with_retries(:max_tries => 3) do
      suite.put(results)
    end
  end

  private
  
  def suite
    @suite ||= with_retries(:max_tries => 3) do
      response = @api['suite'].post({})
      json = JSON.parse(response.body)
      @api["suite/#{json['id']}"]
    end
  end
end