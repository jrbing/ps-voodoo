
module Voodoo

  module Commands
    extend self

    def build(args=nil)
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
      dm = Voodoo::DataMover.new

      ad.build_project(project, migration, source)
      dm.run(migration, source, "PSBUILD.sql")
    end

  end

end
