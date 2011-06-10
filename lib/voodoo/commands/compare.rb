
module Voodoo

  module Commands
    extend self

    def compare(project=nil)
      if project.nil?
        project = get_project
      end

      source = get_source
      target = get_target
      migration = get_migration

      ad = Voodoo::AppDesigner.new
      ad.compare(project, migration, source, target)
    end

  end

end

