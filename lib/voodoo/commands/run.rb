module Voodoo

    module Commands
        extend self

        def run_sqr(sqr_name=nil)
          if sqr_name.nil?
            sqr_name = get_sqr
          end

          target = get_target
          migration = get_migration

          instance = Voodoo::Sqr.new
          instance.run(migration, target)
        end

        def run_appengine(ae_name=nil)
          if ae_name.nil?
            ae_name = get_appengine
          end

          target = get_target
          migration = get_migration

          instance = Voodoo::AppEngine.new
          instance.run(migration, target)
        end

    end

end
