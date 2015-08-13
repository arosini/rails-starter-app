# App-wide view helpers
module ApplicationHelper
  def mobile_agent?
    request.user_agent =~ /Mobile|webOS/
  end

  def foreign_request?
    previous_url = request.env['HTTP_REFERER'] || ''
    URI.parse(previous_url).host != request.host
  end

  # Generates a back button.
  def back_btn(path = 'javascript:history.back();', text = I18n.t('navigation.back'))
    # Generate a path to home if linked directly to a page with a 'Back' button
    if foreign_request?
      path = root_path
      text = I18n.t('navigation.home')
    end
    html = <<-HTML
    <div id='back-btn-wrap'>
      <a class='btn btn-primary' href='#{path}' id='back-btn'>#{text}</a>
    </div>
    HTML
    html.html_safe
  end

  # Action boolean methods
  def edit?
    params[:action] == 'edit'
  end

  def update?
    params[:action] == 'update'
  end

  def new?
    params[:action] == 'new'
  end

  def create?
    params[:action] == 'create'
  end

  # Devise helpers
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end
end
