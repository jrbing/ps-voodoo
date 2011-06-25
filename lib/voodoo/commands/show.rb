
module Voodoo

  module Commands

    def self.show(args=nil)
      setup?
      if args[0].nil?
        source = ask("Environment name: ").upcase
      else
        source = args[0].upcase
      end
      env = Voodoo.environments[source]
      user_table = table
      user_table.headings = source.upcase, ' '
      env.each do |key, value|
        user_table << [key, value]
      end
      puts user_table
    end

  end

end
