if ENV['COVERAGE']
  require 'simplecov'
  require 'simplecov-rcov'
  class SimpleCov::Formatter::CIFriendly
    def format(result)
      SimpleCov::Formatter::HTMLFormatter.new.format(result)
      SimpleCov::Formatter::RcovFormatter.new.format(result)
    end
  end

  SimpleCov.start 'rails' do
    # any custom configs like groups and filters can be here at a central place
    SimpleCov.formatter = SimpleCov::Formatter::CIFriendly
  end
end
