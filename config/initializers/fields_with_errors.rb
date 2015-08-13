# Adds .error to fields with errors, rather than wrapping them in an error div.
ActionView::Base.field_error_proc = Proc.new do |html_tag|
  error_tag = html_tag
  if html_tag =~ /<(input|label|textarea|select)/
    doc = Nokogiri::XML(html_tag)
    doc.children.each do |field|
      unless !field.elem? || field['type'] == 'hidden' || field['class'] =~ /\berror\b/
        field['class'] = "#{field['class']} error".strip
      end
    end

    error_tag = doc.to_html.html_safe
  end
  error_tag
end
