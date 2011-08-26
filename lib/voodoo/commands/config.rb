
module Voodoo

  module Commands

    def self.config
      settings = {}
      puts "\n----Global Configuration Settings-----------------"
      settings[:ps_home] = get_path("Local tools directory")
      settings[:migration_output_dir] = get_path("Default output directory for migration data")

      # if agree("\nWould you like to define email notification settings? (y/n) ") == true
      #   settings[:mail_server] = ask("SMTP server: ")
      #   settings[:smtp_port] = ask("SMTP port: ") { |q| q.default = "587" }
      #   settings[:email_from] = ask("Email from address: ")
      # end
      Voodoo.write_config_file(settings)
    end

  end

end
