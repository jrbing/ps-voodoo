
module Voodoo

  module Commands

    def self.add(name=nil)
      settings = {}
      if name.nil?
        name = ask("Database name: ")
      end
      settings['db_type'] = ask("Database type: ", %w{Oracle})
      settings['ps_home'] = ask("Local ps_home path: ")
      settings['app_username'] = ask("Application default username: ")
      settings['db_username'] = ask("Database default username: ") { |q| q.default = "sysadm" }
      settings['migration_archive'] = ask("Archive directory for migration data: ")
      new_env = {name.upcase => settings}
      LOG.info("Adding #{name.upcase} to the list of configured environments")
      ENVIRONMENTS.merge!(new_env)
      Voodoo.write_env_file
    end
  end

end
