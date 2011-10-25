
module Voodoo

  class AppEngine < PeopleTools

    def initialize
      super
      @executable = File.join(@tools_bin, %w{psae.exe})
    end

    def run(ae_name, target)
      append(:db_type => target.db_type)
      append(:env_name => target.name)
      append(:env_username => target.app_username)
      append(:env_password => target.app_password)
      append(:r => '1')
      append(:ae_name => ae_name)
      #puts "Running #{ae_name}..."
      LOG.info("Running #{ae_name}...")
      call_executable
    end

    def call_executable
      LOG.debug("Executable is set to #{@executable}")
      LOG.debug("Command line options are set to #{@command_line_options.join(" ")}")

      #f = IO.popen(@executable + " " + @command_line_options.join(" "))
      #f.readlines.each { |line| puts ("#{line.chomp}")}
      #f.close
      pid = spawn("start " + @executable + " " + @command_line_options.join(" "))
      LOG.debug("Created background process #{pid} for #{@executable}")
      Process.detach(pid)

      @command_line_options.clear
      set_base_parameters
    end

  end
end
