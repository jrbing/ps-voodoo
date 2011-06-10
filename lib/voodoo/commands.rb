require 'terminal-table/import'
Voodoo.require_all_libs_relative_to(__FILE__)

module Voodoo

  module Commands
    extend self

    def get_project
      ask("Project name: ")
    end

    def get_source
      # choices = ENVIRONMENTS.keys

      choose("Preconfigured environments") do |menu|
        menu.index        = :letter
        menu.index_suffix = ") "
        menu.prompt = "Select the source environment:  "
        menu.choices(ENVIRONMENTS.keys) do |i|
          puts i
        end
      end

      # env = OpenStruct.new(ENVIRONMENTS[selected_environment])
      # env.name = selected_environment
      # env.app_password = get_app_password(selected_environment)
      # return env
    end

    def get_target
      target = ask("Target environment: ", ENVIRONMENTS.keys)
      env = OpenStruct.new(ENVIRONMENTS[target])
      env.name = target
      env.app_password = get_app_password(target)
      return env
    end

    def get_migration
      folder_name = ask("Name for output folder: ")
      Migration.new(folder_name)
    end

    def get_sqr
      ask("SQR name: ")
    end

    def get_appengine
      ask("Appengine name: ")
    end

    private

    def get_app_password(name)
      ask("Password for #{name}: ") { |q| q.echo = "*" }
    end

  end

end

