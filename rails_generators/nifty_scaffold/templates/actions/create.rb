  def create
    @<%= singular_name %> = <%= class_name %>.new(params[:<%= singular_name %>])
    respond_to do |wants|
      if @<%= singular_name %>.save
        wants.html do
          flash[:notice] = "Successfully created <%= name.humanize.downcase %>."
          redirect_to <%= item_path('url') %>
        end
        wants.js
      else
        wants.html { render :action => 'new' }
        wants.js { render :action => 'error' }
      end
    end
  end
