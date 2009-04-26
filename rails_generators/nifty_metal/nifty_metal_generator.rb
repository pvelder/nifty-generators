class NiftyMetalGenerator < Rails::Generator::Base
  def initialize(runtime_args, runtime_options = {})
    super
    #@name = @args.first || 'app'
  end
  
  def manifest
    record do |m|
      m.directory 'app/metal'

      m.template "metal.rb", "app/metal/api.rb"
    end
  end
  
end
