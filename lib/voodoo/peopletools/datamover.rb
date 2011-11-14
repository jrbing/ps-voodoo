
module Voodoo

  class DataMover < PeopleTools

    def initialize
      super
      @executable = File.join(@tools_bin, %w{psdmtx.exe})
    end

    def run(migration, source, script_name)
      append(:db_type => source.db_type)
      append(:env_name => source.name)
      append(:env_username => source.app_username)
      append(:env_password => source.app_password)
      append(:output_folder => File.join(migration.sql_folder, script_name))
      update_dms_settings(migration.sql_folder, migration.log_folder)
      call_executable
    end

    private

    def update_dms_settings(io, logs)
      Win32::Registry::HKEY_LOCAL_MACHINE.open('SOFTWARE\PeopleSoft\PeopleTools\Release8.40\Profiles\Default\Data Mover', Win32::Registry::KEY_WRITE) do |reg|
        reg['InputDir', Win32::Registry::REG_SZ] = io
        reg['OutputDir', Win32::Registry::REG_SZ] = io
        reg['LogDir', Win32::Registry::REG_SZ] = logs
      end
    end

  end

end
