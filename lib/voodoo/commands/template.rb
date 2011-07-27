require 'erb'

module Voodoo

  module Commands
    extend self

    class ErbBinding < OpenStruct
      def get_binding
        return binding()
      end
    end

    def template_datafix(args=nil)

      if args[0].nil?
        datafix = get_migration
      else
        datafix = Migration.new(args.first.upcase)
      end

      records = ask("Records to be affected: ", Array)

      backup_template = File.read(File.join((File.dirname(__FILE__)), '/templates/backup.dms').gsub!(File::SEPARATOR, File::ALT_SEPARATOR))

      vars = ErbBinding.new
      vars.name = datafix.migration_name
      vars.folder = datafix.migration_folder
      vars.records = records
      vars_binding = vars.send(:get_binding)

      generated_backup = ERB.new(backup_template, 0, "%<>")

      backup_file = File.join(datafix.migration_folder, 'backup.dms')
      File.open(backup_file, 'w') {|f| f.write(generated_backup.result(vars_binding))}

      # puts File.expand_path(__FILE__)
    end

  end

end
