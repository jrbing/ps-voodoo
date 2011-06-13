
module Voodoo

  module Commands

    def self.add(args=nil)
      settings = {}
      if args.first.nil?
        name = ask("Database name: ").upcase
      else
        name = args.first.upcase
      end
      settings['db_type'] = ask("Database type: ", %w{Oracle}) { |q| q.default = "Oracle" }
      settings['app_username'] = ask("Application username: ")
      settings['db_username'] = ask("Database username: ") { |q| q.default = "sysadm" }
      settings['migration_archive'] = get_path("Archive destination")
      new_env = {name => settings}
      LOG.info("Adding #{name} to the list of configured environments")
      ENVIRONMENTS.merge!(new_env)
      Voodoo.write_env_file
    end
  end

end
