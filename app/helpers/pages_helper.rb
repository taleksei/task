module PagesHelper
  def nested_pages(pages)
    pages.map do |page, sub_pages|
      render(page) + content_tag(:div, nested_pages(sub_pages), :class => "nested_pages")
    end.join.html_safe
  end
=begin
  def page_path(page, options={})
    page_url(page, options.merge(:only_path => true))
  end

  def page_url(page, options={})
    #url_for(options.merge(:controller => 'pages', :action => 'show', :slug => page.slug))
    url_for(options.merge(:controller => 'pages', :action => 'show', :id => page.id, :slug => page.slug))
    end
=end
end
