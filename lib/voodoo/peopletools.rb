require 'fileutils'
require 'win32/registry'

module Voodoo

  class PeopleTools

    attr_accessor :command_line_options, :executable

    def initialize
      set_base_parameters
      @tools_bin = File.join(Voodoo.configuration[:ps_home], %w{bin client winx86}).gsub!(File::SEPARATOR, File::ALT_SEPARATOR)
      LOG.debug("Tools bin is set to #{@tools_bin}")
    end

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
      f.readlines.each { |line| LOG.debug("#{line}")}
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

Voodoo.require_all_libs_relative_to(__FILE__)
