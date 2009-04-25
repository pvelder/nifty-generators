  def update
    @<%= singular_name %> = <%= class_name %>.find(params[:id])
    respond_to do |wants|
      if @<%= singular_name %>.update_attributes(params[:<%= singular_name %>])
        wants.html do
          flash[:notice] = "Successfully updated <%= name.humanize.downcase %>."
          redirect_to <%= item_path('url') %>
        end
        <%- if options[:ajaxify] %>
        wants.js
        <%- end %>
      else
        wants.html { render :action => 'edit' }
        <%- if options[:ajaxify] %>
        wants.js { render :action => 'error' }
        <%- end %>
      end
    end
  end
