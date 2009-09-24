module LinkToPrintHelper

  # Creates a link to print the given remote URL.  Takes the same arguments as link_to.
  # A +:url+ option is required.
  #   
  #
  def link_to_print(name, options = {}, html_options = {})
    if options[:url].nil?
      raise <<-MESSAGE
      link_to_print expects a :url option.  Example:

        link_to_print "Print Some Page", :url => some_page_path
        link_to_print "Print Some Page", :url => 'http://somepage.com'

      MESSAGE
    end

    path       = url_for(options[:url])
    frame_name = "print-#{path.gsub(/[\W\_]+/, '-')}"

    link_to_function(name, options, html_options) do |page|
      page.insert_html :bottom, 'stellar_site', 
        content_tag(:iframe, '', :src => path, :name => frame_name, :style => 'display:none;')
      page << "window.frames['#{frame_name}'].print();"
    end
  end

end
