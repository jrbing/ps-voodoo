
module Voodoo

  class Sqr

    def initialize
      @sqr_bin = File.join(Voodoo.configuration[:ps_home], %w{bin sqr ORA BINW}).gsub!(File::SEPARATOR, File::ALT_SEPARATOR)
      @executable = File.join(@tools_bin, %w{sqrw.exe})
    end

    def run(target, sqr_name)
      append(:db_type => target.db_type)
      append(:env_name => target.name)
      append(:env_username => target.app_username)
      append(:env_password => target.app_password)
      append(:r => '1')
      append(:sqr_name => sqr_name)
      call_executable
    end

    # def run_sqr(executable_path, sqrbin_path, sqr_name, db_username, db_password, db_name, output_directory)
    #   executable = 'sqrw.exe'

    #   if File.exists?(sqrbin_path + sqr_name)
    #     s.run_sqr(SQR_BIN, database["ps_home"] + "\\sqr\\isc\\", sqr_name, database["db_username"], database["db_password"], db, BASE_DIRECTORY + "\\" + output_directory)
    #   elsif File.exists?(database["ps_home"] + "\\sqr\\" + sqr_name)
    #     s.run_sqr(SQR_BIN, database["ps_home"] + "\\sqr\\", sqr_name, database["db_username"], database["db_password"], db, BASE_DIRECTORY + "\\" + output_directory)
    #   else
    #     say("SQR not found...")
    #   end
    #   arguments = Array.new
    #   arguments << executable_path + executable
    #   arguments << sqrbin_path + sqr_name
    #   arguments << db_username + '/' + db_password + '@' + db_name
    #   arguments << '-I' + sqrbin_path
    #   arguments << '-F' + output_directory
    #   arguments << '-ZIF' + sqrbin_path + 'pssqr.ini'
    #   arguments << '-PRINTER:PD'
    #   Dir.mkdir(output_directory) unless File.exists?(output_directory)
    #   executable_string = arguments.join(" ")
    #   puts executable_string
    #   # `#{executable_string}`
    #   f = IO.popen(executable_string)
    #   f.readlines.each { |line| print "#{line}"}
    #   f.close
    # end

    def append(args)
      args.each_pair do |k, v|
        @command_line_options.push case
          when k == :db_type
            '-CT ' + v
          when k == :env_name
            '-CD ' + v
          when k == :env_username
            '-CO ' + v
          when k == :env_password
            '-CP ' + v
          when k == :compare_project
            '-PJM ' + v
          when k == :archive_project
            '-PJTF ' + v
          when k == :copy_project
            '-PJC ' + v
          when k == :build_project
            '-PJB ' + v
          when k == :target_name
            '-TD ' + v
          when k == :target_username
            '-TO ' + v
          when k == :target_password
            '-TP ' + v
          when k == :log_file
            '-LF ' + v
          when k == :tgt
            '-TGT ' + v
          when k == :cmxml
            '-CMXML ' + v
          when k == :compare_folder
            '-ROD ' + v
          when k == :exp
            '-EXP ' + v
          when k == :obj
            '-OBJ ' + v
          when k == :r
            '-R ' + v
          when k == :ae_name
            '-AI ' + v
          when k == :output_folder
            '-FP ' + v
        end
      end
    end

    def call_executable
      LOG.debug("Executable is set to #{@executable}")
      LOG.debug("Command line options are set to #{@command_line_options.join(" ")}")
      f = IO.popen(@executable + " " + @command_line_options.join(" "))
      f.readlines.each { |line| LOG.info("#{line}")}
      f.close
      @command_line_options.clear
      set_base_parameters
    end

    private

    def set_base_parameters
      @command_line_options = [].push("-HIDE -QUIET -SS NO")
    end
  end

end
