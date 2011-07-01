module Voodoo

  module Commands

    # TODO: add an error message if there are no environments configured
    def self.list
      setup?
      env_table = table
      env_table.headings = ['ENVIRONMENTS']
      Voodoo.environments.keys.each do |env|
        env_table << [env]
      end
      puts env_table
    end

  end

end
