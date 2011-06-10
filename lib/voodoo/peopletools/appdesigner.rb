
module Voodoo

  class AppDesigner < PeopleTools

    def initialize
      super
      @executable = File.join(@tools_bin, %w{pside.exe}).gsub!(File::SEPARATOR, File::ALT_SEPARATOR)
    end

    def compare(project, migration, source, target)
      begin
        LOG.info("Creating compare reports for #{project} between #{source.name} and #{target.name}")
        append(:db_type => source.db_type)
        append(:env_name => source.name)
        append(:env_username => source.app_username)
        append(:env_password => source.app_password)
        append(:compare_project => project)
        append(:target_name => target.name)
        append(:target_username => target.app_username)
        append(:target_password => target.app_password)
        append(:log_file => File.join(migration.log_folder, "Compare_#{source.name}_to_#{target.name}.log"))
        append(:tgt => '1')
        append(:compare_folder => migration.compare_folder(source.name, target.name))
        append(:cmxml => '1')
        call_executable
        view_compare_report(migration.compare_folder(source.name, target.name))
      rescue
        LOG.error("Compare report creation failed")
      end
    end

    def copy_to_file(project, migration, source)
      begin
        LOG.info("Copying #{project} from #{source.name} to file")
        append(:db_type => source.db_type)
        append(:env_name => source.name)
        append(:env_username => source.app_username)
        append(:env_password => source.app_password)
        append(:archive_project => project)
        append(:output_folder => migration.export_folder(source.name))
        append(:log_file => File.join(migration.log_folder, "Copy_#{source.name}_to_file.log"))
        call_executable
        LOG.info("Project copied to file successfully")
      rescue
        LOG.error("Project file copy failed")
      end
    end

    def migrate_full_project(project, migration, source, target)
      begin
        LOG.info("Copying #{project} from #{source.name} to #{target.name}")
        append(:db_type => source.db_type)
        append(:env_name => source.name)
        append(:env_username => source.app_username)
        append(:env_password => source.app_password)
        append(:copy_project => project)
        append(:target_name => target.name)
        append(:target_username => target.app_username)
        append(:target_password => target.app_password)
        append(:log_file => File.join(migration.log_folder, "Copy_project_#{project}_from_#{source.name}_to_#{target.name}.log"))
        call_executable
        LOG.info("Project migrated successfully")
      rescue
        LOG.error("Project migration failed")
      end
    end

    def migrate_project_definition(project, migration, source, target)
      begin
        LOG.info("Copying #{project} definition from #{source.name} to #{target.name}")
        append(:db_type => source.db_type)
        append(:env_name => source.name)
        append(:env_username => source.app_username)
        append(:env_password => source.app_password)
        append(:copy_project => project)
        append(:target_name => target.name)
        append(:target_username => target.app_username)
        append(:target_password => target.app_password)
        append(:log_file => File.join(migration.log_folder, "Copy_project_definition_#{project}_from_#{source.name}_to_#{target.name}.log"))
        append(:exp => '1')
        append(:obj => '16')
        call_executable
        LOG.info("Project migrated successfully")
      rescue
        LOG.error("Project definition migration failed")
      end
    end

    def build_project(project, migration, source)
      begin
        LOG.info("Creating build SQL for #{project}")
        append(:db_type => source.db_type)
        append(:env_name => source.name)
        append(:env_username => source.app_username)
        append(:env_password => source.app_password)
        append(:build_project => project)
        update_build_settings(File.join(migration.log_folder, "PSBUILD.log"), File.join(migration.sql_folder, "PSBUILD.sql"))
        call_executable
        LOG.info("Project build SQL created successfully")
      rescue
        LOG.error("Project SQL build failed")
      end

    end

    private

    def view_compare_report(folder)
      `start #{folder + "\\CompareViewer.html"}`
    end

    def update_build_settings(log_file, sql_file)
      Win32::Registry::HKEY_CURRENT_USER.open('Software\PeopleSoft\PeopleTools\Release8.40\RDM Build Settings', Win32::Registry::KEY_WRITE) do |reg|
        reg['AlterAdds', Win32::Registry::REG_DWORD] = 1
        reg['AlterByTableRename', Win32::Registry::REG_DWORD] = 1
        reg['AlterChanges', Win32::Registry::REG_DWORD] = 1
        reg['AlterDeletes', Win32::Registry::REG_DWORD] = 1
        reg['AlterDropOption', Win32::Registry::REG_DWORD] = 1
        reg['AlterRenames', Win32::Registry::REG_DWORD] = 1
        reg['AlterTables', Win32::Registry::REG_DWORD] = 1
        reg['AlterTruncateOption', Win32::Registry::REG_DWORD] = 1
        reg['AlwaysOverwrite', Win32::Registry::REG_DWORD] = 1
        reg['CreateIndexes', Win32::Registry::REG_DWORD] = 1
        reg['CreateTables', Win32::Registry::REG_DWORD] = 1
        reg['CreateTrigger', Win32::Registry::REG_DWORD] = 1
        reg['CreateViews', Win32::Registry::REG_DWORD] = 1
        reg['ExecuteOption', Win32::Registry::REG_DWORD] = 2
        reg['ForceAlterOption', Win32::Registry::REG_DWORD] = 1
        reg['IndexOption', Win32::Registry::REG_DWORD] = 0
        reg['LogComments', Win32::Registry::REG_DWORD] = 1
        reg['LogErrors', Win32::Registry::REG_DWORD] = 1
        reg['LogFilename', Win32::Registry::REG_SZ] = log_file
        reg['LogSettings', Win32::Registry::REG_DWORD] = 1
        reg['LogToScript', Win32::Registry::REG_DWORD] = 1
        reg['LogToWindow', Win32::Registry::REG_DWORD] = 1
        reg['OutputToSingleFile', Win32::Registry::REG_DWORD] = 1
        reg['OutputToSingleFilename', Win32::Registry::REG_SZ] = sql_file
        reg['TableOption', Win32::Registry::REG_DWORD] = 2
        reg['UnicodeScript', Win32::Registry::REG_DWORD] = 0
        reg['ViewOption', Win32::Registry::REG_DWORD] = 1
      end
    end

  end

end
