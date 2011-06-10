
module Voodoo

  module Commands

    def self.config
      settings = {}
      settings[:ps_home] = ask("Local tools installation directory: ")
      settings[:migration_output_dir] = ask("Output directory for migration data: ")
      Voodoo.write_config_file(settings)
    end

  end

end
