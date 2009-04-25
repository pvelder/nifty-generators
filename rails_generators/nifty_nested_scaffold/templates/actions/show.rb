  def show
    @<%= singular_name %> = @<%= parent_singular_name %>.<%= plural_name %>.find(params[:id])
  end
