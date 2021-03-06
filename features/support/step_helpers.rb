# For handling links inside emails
require 'uri'

# Include helpers
module Helpers
  include UsersHelper
  include Devise::TestHelpers
end
World(Helpers)

# The different names for the page seen by going to the root path
AUTHENTICATED_ROOT_ALIASES   = %w(home users).freeze
UNAUTHENTICATED_ROOT_ALIASES = %w(landing welcome).freeze

# Converts the name of a page into a path. Modify this method as needed when page names are more complex.
def pathify(page_name_or_path)
  page_name_or_path = page_name_or_path.downcase
  return root_path if AUTHENTICATED_ROOT_ALIASES.include?(page_name_or_path) ||
                      UNAUTHENTICATED_ROOT_ALIASES.include?(page_name_or_path)
  return new_user_password_path if page_name_or_path == 'forgot your password'
  path = page_name_or_path.tr(' ', '_')
  Rails.application.routes.url_helpers.send(path + '_path') rescue path
end

# Excludes the navbar when executing the block
def within_page_content(&_block)
  within(:css, 'div#content-wrap') { yield }
end

# Excludes the main page content when executing the block
def within_navbar(&_block)
  within(:css, 'nav.navbar') { yield }
end
