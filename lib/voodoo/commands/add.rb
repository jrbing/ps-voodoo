
module Voodoo

  module Commands

    def self.add(args=nil)
      settings = {}
      if args.first.nil?
        name = ask("Database name: ").upcase
      else
        name = args.first.upcase
      end
      puts "\n### Appdesigner/Datamover/AppEngine Settings ###"
      settings['db_type'] = ask("Database type: ", %w{ORACLE}) { |q| q.default = "ORACLE" }
      settings['app_username'] = ask("Application username: ")
      # Add a line to ask if the data should be archived
      if agree("\nWould you like to archive migration output files for this environment? (y/n) ") == true
        settings['migration_archive'] = get_path("Archive destination")
      end

      puts "\n### SQR Settings ###"
      settings['db_username'] = ask("Database username: ") { |q| q.default = "sysadm" }
      settings['ps_home'] = get_path("PS_HOME directory: )")

      new_env = {name => settings}
      LOG.debug("Adding #{name} to the list of configured environments")
      ENVIRONMENTS.merge!(new_env)
      Voodoo.write_env_file
    end
  end

end
