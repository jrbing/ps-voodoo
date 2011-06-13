require 'ostruct'
require 'yaml'
require 'logger'

module Voodoo

  extend self

  LIBPATH = ::File.expand_path(::File.dirname(__FILE__)) + ::File::SEPARATOR
  PATH = ::File.dirname(LIBPATH) + ::File::SEPARATOR

  # Log settings
  LOG = Logger.new(STDOUT)
  LOG.level = Logger::DEBUG

  def self.libpath( *args )
    rv =  args.empty? ? LIBPATH : ::File.join(LIBPATH, args.flatten)
    if block_given?
      begin
        $LOAD_PATH.unshift LIBPATH
        rv = yield
      ensure
        $LOAD_PATH.shift
      end
    end
    return rv
  end

  def self.path( *args )
    rv = args.empty? ? PATH : ::File.join(PATH, args.flatten)
    if block_given?
      begin
        $LOAD_PATH.unshift PATH
        rv = yield
      ensure
        $LOAD_PATH.shift
      end
    end
    return rv
  end

  def self.require_all_libs_relative_to( fname, dir = nil )
    dir ||= ::File.basename(fname, '.*')
    search_me = ::File.expand_path(
        ::File.join(::File.dirname(fname), dir, '**', '*.rb'))

    Dir.glob(search_me).sort.each {|rb| require rb}
  end

  def home
    @home ||= (ENV['HOME'] || ENV['USERPROFILE']) + '/.voodoo'
    unless File.exists?(@home)
      Dir.mkdir(@home)
    end
    return @home
  end

  def config_file
    filename = File.join(Voodoo.home, 'configuration.yml')
    File.open(filename, File::CREAT|File::RDWR)
  end

  def configuration
    @configuration = YAML.load_file(Voodoo.config_file)
  end

  def write_config_file(settings)
    Voodoo.config_file.write(settings.to_yaml)
  end

  def env_file
    filename = File.join(Voodoo.home, 'environments.yml')
    File.open(filename, File::CREAT|File::RDWR)
    return filename
  end

  def environments
    list = YAML.load_file(Voodoo.env_file)
    if list
      @environments = list
    else
      @environments = {}
    end
  end

  def write_env_file
    environment_file = File.open(Voodoo.env_file, 'w')
    LOG.debug("Writing environment configuration file.")
    environment_file.write(ENVIRONMENTS.to_yaml)
  end

end

Voodoo.require_all_libs_relative_to(__FILE__)
ENVIRONMENTS = Voodoo.environments
CONFIGURATION = OpenStruct.new(Voodoo.configuration)
