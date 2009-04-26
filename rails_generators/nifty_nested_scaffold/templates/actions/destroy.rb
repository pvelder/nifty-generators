  def destroy
    @<%= singular_name %> = @<%= parent_singular_name %>.<%= plural_name %>.find(params[:id])
    @<%= singular_name %>.destroy
    flash[:notice] = "Successfully removed <%= name.humanize.downcase %>."
    redirect_to <%= parent_singular_name %>_<%= plural_name %>_path(@<%= parent_singular_name %>)
  end
