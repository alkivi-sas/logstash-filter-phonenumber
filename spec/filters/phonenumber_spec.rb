# encoding: utf-8
require_relative '../spec_helper'
require "logstash/filters/phonenumber"

describe LogStash::Filters::Phonenumber do
  describe "French Mobile" do
    let(:config) do <<-CONFIG
      filter {
        phonenumber {
           source => 'destination_number'
           destination_country => 'destination_number_country'
           destination_type => 'destination_number_type'
        }
      }
    CONFIG
    end

    sample({"destination_number" => "+33662414141"}) do
      expect(subject).to include("destination_number_country")
      expect(subject).to include("destination_number_type")
      expect(subject.get('destination_number_country')).to eq('FR')
      expect(subject.get('destination_number_type')).to eq('Mobile')
    end
  end

  describe "French Landline" do
    let(:config) do <<-CONFIG
      filter {
        phonenumber {
           source => 'destination_number'
           destination_country => 'destination_number_country'
           destination_type => 'destination_number_type'
        }
      }
    CONFIG
    end

    sample({"destination_number" => "+33162414141"}) do
      expect(subject).to include("destination_number_country")
      expect(subject).to include("destination_number_type")
      expect(subject.get('destination_number_country')).to eq('FR')
      expect(subject.get('destination_number_type')).to eq('Fixed Line')
    end
  end

  describe "Anonymous" do
    let(:config) do <<-CONFIG
      filter {
        phonenumber {
           source => 'destination_number'
           destination_country => 'destination_number_country'
           destination_type => 'destination_number_type'
        }
      }
    CONFIG
    end

    sample({"destination_number" => "anonymous"}) do
      expect(subject).not_to include("destination_number_country")
      expect(subject).not_to include("destination_number_type")
    end
  end

end
