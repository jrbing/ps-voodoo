
module Voodoo

  module Commands
    extend self

    def build(project=nil)
      if project.nil?
        project = get_project
      end

      source = get_source
      migration = get_migration

      ad = Voodoo::AppDesigner.new
      dm = Voodoo::DataMover.new

      ad.build_project(project, migration, source)
      dm.run(migration, source, "PSBUILD.sql")
    end

  end

end
