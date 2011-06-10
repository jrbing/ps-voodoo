
module Voodoo

  module Commands

    def self.show(name)
      env = Voodoo.environments[name]
      user_table = table
      user_table.headings = name, ' '
      env.each do |key, value|
        user_table << [key, value]
      end
      puts user_table
    end

  end

end
