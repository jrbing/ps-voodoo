
module Voodoo

  class Sqr

    attr_accessor :command_line_options, :executable

    def initialize
      @sqr_bin = File.join(Voodoo.configuration[:ps_home], %w{bin sqr ORA BINW}).gsub!(File::SEPARATOR, File::ALT_SEPARATOR)
      @executable = File.join(@sqr_bin, %w{sqrw.exe})
      @command_line_options = []
    end

    def run(migration, target, sqr_name)
      append(:db_login => target.db_username + '/' + target.db_password + '@' + target.name)
      append(:sqr => File.join(target.ps_home, 'sqr', sqr_name).gsub!(File::SEPARATOR, File::ALT_SEPARATOR))
      append(:output => migration.log_folder)
      append(:zif => File.join(target.ps_home, 'sqr', 'pssqr.ini').gsub!(File::SEPARATOR, File::ALT_SEPARATOR))
      append(:print => true)
      call_executable
    end

    def append(args)
      args.each_pair do |k, v|
        @command_line_options.push case
          when k == :db_login
            v
          when k == :sqr
            '-I ' + v
          when k == :output
            '-F ' + v
          when k == :zif
            '-ZIF ' + v
          when k == :print
            '-PRINTER:PD'
        end
      end
    end

    def call_executable
      LOG.debug("Executable is set to #{@executable}")
      LOG.debug("Command line options are set to #{@command_line_options.join(" ")}")
      Open3.popen2(@executable + " " + @command_line_options.join(" ")) {|i,o,t|
        p o.gets
      }
      @command_line_options.clear
    end

  end

end
