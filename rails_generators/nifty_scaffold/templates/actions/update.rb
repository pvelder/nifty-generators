  def update
    @<%= singular_name %> = <%= class_name %>.find(params[:id])
    respond_to do |wants|
      if @<%= singular_name %>.update_attributes(params[:<%= singular_name %>])
        wants.html do
          flash[:notice] = "Successfully updated <%= name.humanize.downcase %>."
          redirect_to <%= item_path('url') %>
        end
        wants.js
      else
        wants.html { render :action => 'edit' }
        wants.js { render :action => 'error' }
      end
    end
  end
