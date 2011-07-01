require 'terminal-table/import'
Voodoo.require_all_libs_relative_to(__FILE__)

module Voodoo

  module Commands
    extend self

    def setup?
      if CONFIGURATION.ps_home == nil
        puts "Global configuration not defined...use <voodoo config>"
        exit
      end

      if ENVIRONMENTS.empty?
        puts "No environments defined....use <voodoo add [environment]>"
        exit
      end

    end

    def get_project
      ask("Project name: ")
    end

    def get_env(name)
      if ENVIRONMENTS[name]
          env = OpenStruct.new(ENVIRONMENTS[name])
          env.name = name
          env.app_password = get_app_password(name)
      else
          puts "#{name} is not listed in the configuration file"
          exit
      end
      return env
    end

    def get_db_env(name)
      if ENVIRONMENTS[name]
          env = OpenStruct.new(ENVIRONMENTS[name])
          env.name = name
          env.db_password = get_db_password(name)
      else
          puts "#{name} is not listed in the configuration file"
          exit
      end
      return env
    end

    def get_source
      source = ask("Source environment: ", ENVIRONMENTS.keys)
      env = OpenStruct.new(ENVIRONMENTS[source])
      env.name = source
      env.app_password = get_app_password(source)
      return env
    end

    def get_target
      target = ask("Target environment: ", ENVIRONMENTS.keys)
      env = OpenStruct.new(ENVIRONMENTS[target])
      env.name = target
      env.app_password = get_app_password(target)
      return env
    end

    def get_database
      name = ask("Database name: ", ENVIRONMENTS.keys)
      env = OpenStruct.new(ENVIRONMENTS[name])
      env.name = name
      env.db_password = get_db_password(name)
      return env
    end

    def get_migration
      folder_name = ask("Name for output folder: ")
      Migration.new(folder_name)
    end

    #TODO: validate that the SQR name and path is valid
    def get_sqr
      ask("SQR name: ")
    end

    #TODO: validate that the appengine name and path is valid
    def get_appengine
      ask("Appengine name: ")
    end

    #TODO: change this so that you can specify the root of a drive
    def get_path(prompt)
      ask("#{prompt}: ") do |q|
        q.validate = %r=^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w ]*))=
        q.responses[:not_valid] = "Please enter a valid folder path."
      end
    end

    def dttm
      Time.now.strftime("%m/%d/%Y %H:%M:%S") + " >>> "
    end

    private

    def get_app_password(name)
      ask("Password for #{name}: ") { |q| q.echo = "*" }
    end

    def get_db_password(name)
      ask("Password for #{name}: ") { |q| q.echo = "*" }
    end

  end

end

