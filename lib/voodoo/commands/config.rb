
module Voodoo

  module Commands

    def self.config
      settings = {}
      puts "\n### Global Configuration Settings ###"
      settings[:ps_home] = get_path("Local tools directory")
      settings[:migration_output_dir] = get_path("Default output directory for migration data")
      Voodoo.write_config_file(settings)
    end

  end

end
