
module Voodoo

  module Commands

    def self.remove(args=nil)
      if args[0].nil?
        source = get_source
      else
        source = args[0].upcase
      end
      LOG.info("Removing #{source} from the list of configured environments")
      ENVIRONMENTS.delete(source)
      Voodoo.write_env_file
    end

  end

end
