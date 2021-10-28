# encoding: utf-8
require "logstash/filters/base"
require 'global_phone'

GlobalPhone.db_path = '/usr/share/logstash/global_phone.json'

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
  config :destination, :validate => :string


  public
  def register
    # Add instance variables
  end # def register

  public
  def filter(event)

    source = event.get(@source)
    if source
        number = GlobalPhone.parse(source)
        if number.valid?
          if number.territory.name
            event.set(@destination, number.territory.name)
          end
        end
    end


    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Phonenumber
