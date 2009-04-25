  def create
    
    @<%= singular_name %> = @<%= parent_singular_name %>.<%= plural_name %>.build(params[:<%= singular_name %>])
    respond_to do |wants|
      if @<%= singular_name %>.save
        wants.html do
          flash[:notice] = "Successfully created <%= name.humanize.downcase %>."
          redirect_to <%= item_path('url') %>
        end
        <%- if options[:ajaxify] %>
        wants.js
        <%- end %>
      else
        wants.html { render :action => 'new' }
        <%- if options[:ajaxify] %>
        wants.js { render :action => 'error' }
        <%- end %>        
      end
    end
  end
