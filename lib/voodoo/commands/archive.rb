
module Voodoo

  module Commands
    extend self

    def archive(args=nil)
      setup?

      if args[0].nil?
        project = get_project
      else
        project = args.first
      end

      if args[1].nil?
        source = get_source
      else
        source = get_env(args[1].upcase)
      end

      migration = get_migration

      ad = Voodoo::AppDesigner.new

      ad.copy_to_file(project, migration, source)
    end

  end

end
