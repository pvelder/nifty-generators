  def edit
    @<%= singular_name %> = <%= class_name %>.find(params[:id])
    respond_to do |wants|
      wants.html
      <%- if options[:ajaxify] %>
      wants.js { render :action => "dialog" }
      <%- end %>
    end

  end
