apply File.join(File.dirname(__FILE__), 'helpers.rb') unless defined? TEMPLATE_HELPERS

%w(
  timezone
  i18n
  assets
  generators
  debug
  annotate
  rspec
  factory_girl
  faker
  bullet
  rubocop
  yard
  mailcatcher
  cleanup
).each do |recipe|
  apply_recipe recipe
end

%w(
  devise
  carrierwave
  kaminari
).each do |recipe|
  apply_recipe recipe if yes_wizard?("Do you use #{recipe}?")
end
