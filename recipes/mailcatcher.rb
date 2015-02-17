apply File.join(File.dirname(__FILE__), '..', 'helpers.rb') unless defined? TEMPLATE_HELPERS

inject_into_file 'config/environments/development.rb', %(
  # Use MailCatcher
  # https://github.com/sj26/mailcatcher
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = { address: 'localhost', port: 1025 }

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
), after: "config.action_mailer.raise_delivery_errors = false\n"
