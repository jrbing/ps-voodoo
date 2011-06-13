
module Voodoo

  module Commands
    extend self

    def migrate(args=nil)
      setup?

      if args.[0].nil?
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

      # Check for source and target being the same
      if source == target
        says("Source and target cannot be the same")
        exit
      end

      migration = get_migration
      ad = Voodoo::AppDesigner.new

      # Compare source to target
      ad.compare(project, migration, source, target)
      migration.continue?

      # Copy source to file
      ad.copy_to_file(project, migration, source)

      # Copy definition only to database
      ad.migrate_project_definition(project, migration, source, target)

      # Copy target to file
      ad.copy_to_file(project, migration, target)

      # Copy full project
      ad.migrate_full_project(project, migration, source, target)

      # Run second compare report
      ad.compare(project, migration, target,source)

      # Build project in target database
      if agree("Build project in target database? ") == true
        dm = Voodoo::DataMover.new
        ad.build_project(project, migration, target)
        dm.run(migration, target, "PSBUILD.sql")
      end

      # Move output files to archive folder for the target
      if agree("Copy output files to archive folder for #{target.name}? ") == true
        migration.copy_to_archive(target.migration_archive)
      end


    end

  end

end

