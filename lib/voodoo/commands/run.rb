module Voodoo

    module Commands
        extend self

        def run_sqr(args=nil)
          setup?

          if args[0].nil?
            sqr_name = get_sqr
          else
            sqr_name = args.first
          end

          if args[1].nil?
            target = get_database
          else
            target = get_db_env(args[1].upcase)
          end

          migration = get_migration

          instance = Voodoo::Sqr.new
          instance.run(migration, target, sqr_name)
        end

        def run_appengine(args=nil)

          if args[0].nil?
            ae_name = get_appengine
          else
              ae_name = args[0].upcase
          end

          if args[1].nil?
            target = get_target
          else
            target = get_env(args[1].upcase)
          end

          instance = Voodoo::AppEngine.new
          instance.run(ae_name, target)
        end

    end

end
