module Markdownable
  extend ActiveSupport::Concern
  
  included do
    before_action :set_markdown_renderer
  end
  
  # set up a renderer that the views can use to render markdown
  # stored in i18n files and post content
  def set_markdown_renderer
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, 
                    :autolink => true, 
                    :disable_indented_code_blocks => true,
                    :fenced_code_blocks => true,
                    :lax_spacing => true,
                    :no_intra_emphasis => true,
                    :space_after_headers => true,
                    :tables => true)
  end
end