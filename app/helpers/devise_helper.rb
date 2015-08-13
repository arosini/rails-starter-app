# Devise helper overrides
module DeviseHelper
  # Custom error messages for devise resources
  def devise_error_messages!
    resource_errors = resource.errors
    return '' if resource_errors.empty?

    messages = resource_errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t('errors.messages.not_saved',
                      count: resource_errors.count,
                      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id='errors' class='alert alert-danger left'>
      <button class='close' data-dismiss='alert' type='button'>
        <span aria-hidden='true'> × </span>
        <span class='sr-only'> #{I18n.t('alert.close')} </span>
      </button>
      <p class='bold'>#{sentence}</p>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
end
