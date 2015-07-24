TEMPLATE_HELPERS = true

def ask_wizard(question)
  ask "\033[1m\033[36m#{'option'.rjust(10)}\033[1m\033[36m  #{question}\033[0m"
end

def yes_wizard?(question)
  answer = ask_wizard(question + " \033[33m(Y/n)\033[0m")
  case answer.downcase
  when "yes", "y", ""
    true
  when "no", "n"
    false
  else
    yes_wizard?(question)
  end
end

def apply_recipe(recipe)
  say "\033[1m\033[36m#{'recipe'.rjust(10)}\033[0m  Running #{recipe}..."
  apply File.join(File.dirname(__FILE__), 'recipes', "#{recipe}.rb")
end

def get_from_repo(source, destination = nil)
  destination ||= source
  source = File.join(File.dirname(__FILE__), 'templates', source)
  get source, destination
end
