
module Voodoo

  class Sqr

    attr_accessor :command_line_options, :executable

    def initialize
      @sqr_bin = File.join(Voodoo.configuration[:ps_home], %w{bin sqr ORA BINW})
      @executable = File.join(@sqr_bin, %w{sqrw.exe})
      @command_line_options = []
    end

    def run(migration, target, sqr_name)
      @sqr_name = sqr_name.gsub(/\.sqr/, '')
      append(:sqr => File.join(target.ps_home, 'sqr', @sqr_name))
      append(:db_login => target.db_username + '/' + target.db_password + '@' + target.name)
      append(:input => File.join(target.ps_home, 'sqr'))
      append(:output => migration.log_folder)
      append(:log_file => File.join(migration.log_folder, @sqr_name + '_' + Time.now.strftime("%Y_%m_%d_%H_%M_%S") + '.log'))
      append(:zif => File.join(target.ps_home, 'sqr', 'pssqr.ini'))
      append(:print => true)
      append(:xmb=> true)
      append(:xcb=> true)
      append(:debug=> true)
      LOG.info("Running #{@sqr_name}...")
      #puts "Running #{@sqr_name}..."
      call_executable
    end

    def append(args)
      args.each_pair do |k, v|
        @command_line_options.push case
          when k == :db_login
            v
          when k == :sqr
            v + '.sqr'
          when k == :input
            '-I' + v + '\\'
          when k == :output
            '-F' + v + '\\'
          when k == :log_file
            '-O' + v
          when k == :zif
            '-ZIF' + v
          when k == :print
            '-PRINTER:PD'
          when k == :xmb
            '-XMB'
          when k == :xcb
            '-XCB'
          when k == :debug
            '-DEBUGX'
        end
        @command_line_options.gsub!(File::SEPARATOR, File::ALT_SEPARATOR)
      end
    end

    def call_executable
      LOG.debug("Executable is set to #{@executable}")
      LOG.debug("Command line options are set to #{@command_line_options.join(" ")}")

      #f = IO.popen(@executable + " " + @command_line_options.join(" "))
      #f.readlines.each { |line| puts ("#{line.chomp}")}
      #f.close
      pid = spawn(@executable + " " + @command_line_options.join(" "))
      LOG.debug("Created background process #{pid} for #{@executable}")
      Process.detach(pid)

      @command_line_options.clear
    end

  end

end
