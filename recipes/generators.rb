apply File.join(File.dirname(__FILE__), '..', 'helpers.rb') unless defined? TEMPLATE_HELPERS

gsub_file 'config/application.rb', /^  end$/, %(
    config.generators do |g|
      g.helper false
      g.stylesheets false
      g.javascripts false
      g.view_specs false
      g.helper_specs false
      g.routing_specs false
    end
  end)
