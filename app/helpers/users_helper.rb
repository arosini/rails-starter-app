# Helper methods for rendering User related content.
module UsersHelper
  def print_roles_as_links(user)
    user.roles.map { |role| link_to(role.name, role_path(role)) }.join(', ').html_safe
  end
end
