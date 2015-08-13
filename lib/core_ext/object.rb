# Overrides to the Object class
class Object
  include ActionView::Helpers::TagHelper
  include ActionView::Context
  # Print errors for this object
  def form_errors
    return '' if errors.empty?

    messages = errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t('errors.messages.not_saved',
                      count: errors.count,
                      resource: self.class.model_name.human.downcase)

    html = <<-HTML
    <div id='errors' class='alert alert-danger left'>
      <p class='bold'>#{sentence}</p>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
end
