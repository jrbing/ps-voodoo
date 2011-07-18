
module Voodoo

  class Migration

    def initialize(name)
      @migration_folder = create_folder(File.join(CONFIGURATION.migration_output_dir, name))
    end

    def log_folder
      @log_folder = create_folder(File.join(@migration_folder, 'logs').gsub!(File::SEPARATOR, File::ALT_SEPARATOR))
    end

    def archive_folder
      @archive_folder = create_folder(File.join(@migration_folder, 'archive').gsub!(File::SEPARATOR, File::ALT_SEPARATOR))
    end

    def sql_folder
      @sql_folder = create_folder(File.join(@migration_folder, 'sql').gsub!(File::SEPARATOR, File::ALT_SEPARATOR))
    end

    def compare_folder(source, target)
      create_folder(File.join(compare_base_folder, "#{source}_to_#{target}").gsub!(File::SEPARATOR, File::ALT_SEPARATOR))
    end

    def export_folder(source)
      create_folder(File.join(project_folder, source).gsub!(File::SEPARATOR, File::ALT_SEPARATOR))
    end

    def continue?
      if agree("Continue? ") == false
        exit
      end
    end

    def copy_to_archive(archive_folder)
      FileUtils.cp_r(@migration_folder, archive_folder, :verbose => true)
    end

    private

    def project_folder
      @project_folder = create_folder(File.join(@migration_folder, 'project').gsub!(File::SEPARATOR, File::ALT_SEPARATOR))
    end

    def compare_base_folder
      @compare_base_folder = create_folder(File.join(@migration_folder, 'compares').gsub!(File::SEPARATOR, File::ALT_SEPARATOR))
    end

    def create_folder(folder_path)
      Dir.mkdir(folder_path) unless File.exists?(folder_path)
      return folder_path
    end

  end

end

