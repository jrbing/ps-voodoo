
module Voodoo

  module Commands
    extend self

    def compare(args=nil)
      setup?

      if args.first.nil?
        project = get_project
      else
        project = args.first
      end

      if args[1].nil?
        source = get_source
      else
        source = args[1].upcase
      end

      if args[2].nil?
        target = get_target
      else
        target = args[2].upcase
      end

      migration = get_migration

      ad = Voodoo::AppDesigner.new
      ad.compare(project, migration, source, target)
    end

  end

end

