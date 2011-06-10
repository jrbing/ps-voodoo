
module Voodoo

  module Commands
    extend self

    def migrate(project=nil)
      if project.nil?
        project = get_project
      end

      source = get_source
      target = get_target
      migration = get_migration

      # Check for source and target being the same
      if source == target
          says("Source and target cannot be the same")
      end

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

      # migration.copy_to_archive(target.

    end

  end

end

