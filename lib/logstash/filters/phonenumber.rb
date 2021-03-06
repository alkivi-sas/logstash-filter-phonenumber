# encoding: utf-8
require "logstash/filters/base"
require 'phonelib'

# This  filter will replace the contents of the default
# message field with whatever you specify in the configuration.
#
# It is only intended to be used as an .
class LogStash::Filters::Phonenumber < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # filter {
  #    {
  #     message => "My message..."
  #   }
  # }
  #
  config_name "phonenumber"

  # Replace the message with this value.
  config :source, :validate => :string
  config :destination_country, :validate => :string
  config :destination_type, :validate => :string


  public
  def register
    Phonelib.default_country = "FR"
  end # def register

  public
  def filter(event)

    source = event.get(@source)
    if source
      if Phonelib.valid?(source)
        number = Phonelib.parse(source)
        if number.country
          event.set(@destination_country, number.country)
        end
        if number.human_type
          event.set(@destination_type, number.human_type)
        end
      end
    end

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Phonenumber
