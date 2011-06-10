
module Voodoo

  module Commands

    def self.remove(name)
      LOG.info("Removing #{name} from the list of configured environments")
      ENVIRONMENTS.delete(name)
      Voodoo.write_env_file
    end

  end

end
