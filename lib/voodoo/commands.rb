require 'terminal-table/import'
Voodoo.require_all_libs_relative_to(__FILE__)

module Voodoo

  module Commands
    extend self

    def setup?
      if CONFIGURATION.ps_home == nil
        LOG.warnA("Global configuration not defined...use <voodoo config>")
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
      #TODO: fix this to throw an error message and exit if the environment isn't listed
      OpenStruct.new(ENVIRONMENTS[name])
    end

    def get_source
      choose("Environments") do |menu|
        menu.index = :letter
        menu.index_suffix = ") "
        menu.prompt = "Specify the source environment:  "
        ENVIRONMENTS.keys.each do |x|
          menu.choice(x) do |i|
            env = OpenStruct.new(ENVIRONMENTS[i])
            env.name = i
            env.app_password = get_app_password(i)
            return env
          end
        end
      end
    end

    def get_target
      choose("Environments") do |menu|
        menu.index = :letter
        menu.index_suffix = ") "
        menu.prompt = "Specify the target environment:  "
        ENVIRONMENTS.keys.each do |x|
          menu.choice(x) do |i|
            env = OpenStruct.new(ENVIRONMENTS[i])
            env.name = i
            env.app_password = get_app_password(i)
            return env
          end
        end
      end
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

  end

end

