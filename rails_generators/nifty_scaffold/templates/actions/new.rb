  def new
    @<%= singular_name %> = <%= class_name %>.new
    respond_to do |wants|
      wants.html
      <%- if options[:ajaxify] %>
      wants.js { render :action => "dialog" }
      <%- end %>
    end
    
  end
