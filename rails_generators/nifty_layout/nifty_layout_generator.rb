class NiftyLayoutGenerator < Rails::Generator::Base
  def initialize(runtime_args, runtime_options = {})
    super
    @name = @args.first || 'application'
  end
  
  def manifest
    record do |m|
      m.directory 'app/views/layouts'
      m.directory 'public/stylesheets'
      m.directory 'app/helpers'
      
      if options[:haml]
        m.template "layout.html.haml", "app/views/layouts/#{file_name}.html.haml"
        m.file     "stylesheet.css",  "public/stylesheets/#{file_name}.css"
        m.file     "javascript.js", "public/javascripts/#{file_name}.js"
        m.directory 'app/views/shared'
        m.file     "_stylesheets.html.haml", "app/views/shared/_stylesheets.html.haml"
        m.file     "_javascripts.html.haml", "app/views/shared/_javascripts.html.haml"
        m.file     "_header.html.haml", "app/views/shared/_header.html.haml"
        m.file     "_footer.html.haml", "app/views/shared/_footer.html.haml"
        m.file     "_navigation.html.haml", "app/views/shared/_navigation.html.haml"
        
      else
        m.template "layout.html.erb", "app/views/layouts/#{file_name}.html.erb"
        m.file     "stylesheet.css",  "public/stylesheets/#{file_name}.css"
      end
      m.file "helper.rb", "app/helpers/layout_helper.rb"
    end
  end
  
  def file_name
    @name.underscore
  end

  protected

    def add_options!(opt)
      opt.separator ''
      opt.separator 'Options:'
      opt.on("--haml", "Generate HAML for view, and SASS for stylesheet.") { |v| options[:haml] = v }
    end

    def banner
      <<-EOS
Creates generic layout, stylesheet, and helper files.

USAGE: #{$0} #{spec.name} [layout_name]
EOS
    end
end
