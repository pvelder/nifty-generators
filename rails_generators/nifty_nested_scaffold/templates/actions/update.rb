  def update
    
    @<%= singular_name %> = @<%= parent_singular_name %>.<%= plural_name %>.find(params[:id])
    respond_to do |wants|
      if @<%= singular_name %>.update_attributes(params[:<%= singular_name %>])
        wants.html do
          flash[:notice] = "Successfully updated <%= name.humanize.downcase %>."
          redirect_to <%= parent_singular_name %>_<%= plural_name %>_path(@<%= parent_singular_name %>)
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
