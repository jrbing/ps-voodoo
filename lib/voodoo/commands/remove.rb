
module Voodoo

  module Commands

    def self.remove(args=nil)
      if args[0].nil?
        env = ask("Environment to remove?: ", ENVIRONMENTS.keys)
      else
        env = args[0].upcase
      end
      LOG.debug("Removing #{env} from the list of configured environments")
      ENVIRONMENTS.delete(env)
      Voodoo.write_env_file
    end

  end

end
