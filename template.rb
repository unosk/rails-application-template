apply File.join(File.dirname(__FILE__), 'helpers.rb') unless defined? TEMPLATE_HELPERS

git :init
git commit: '-m "Initial commit" --allow-empty'

git add: '.'
git commit: '-m "Railsアプリケーションを新規作成"'

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
  devise
  carrierwave
  kaminari
  dotenv
).each do |recipe|
  apply_recipe recipe if yes_wizard?("Do you apply #{recipe}?")
end

after_bundle do
  git add: '. -A'
  git commit: '-m"アプリケーションテンプレートを適用"'
end
