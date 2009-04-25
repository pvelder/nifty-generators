  def destroy
    @<%= singular_name %> = @<%= parent_singular_name %>.<%= plural_name %>.find(params[:id])
    @<%= singular_name %>.destroy
    flash[:notice] = "Successfully removed <%= name.humanize.downcase %>."
    redirect_to <%= plural_name %>_url
  end
