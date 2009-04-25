class <%= plural_class_name %>Controller < ApplicationController
  before_filter :load_parent
  
  <%= controller_methods :actions %>
  
  protected
  
  def load_parent
    @<%= parent_singular_name %> = <%= parent_class_name %>.find(params[:<%= parent_singular_name %>_id])  
  end
  
end
