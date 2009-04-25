  def new
    @<%= singular_name %> = @<%= parent_singular_name %>.<%= plural_name %>.build
    respond_to do |wants|
      wants.html
      <%- if options[:ajaxify] %>
      wants.js { render :action => "dialog" }
      <%- end %>
    end
    
  end
