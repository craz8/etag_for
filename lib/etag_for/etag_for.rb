module EtagFor
  extend ActiveSupport::Concern

  def etag_for(item_or_items, options = {})
    css_file = options[:css] || 'application'
    js_file = options[:js] || 'application'

    files = []
    files << "layouts/#{options[:layout]}" if options[:layout]
    files << options[:view] if options[:view]
    files += options[:files] if options[:files]

    [ item_or_items ].flatten + [ css_path(css_file), js_path(js_file) ] + digests_of(files)
  end

protected
  def digests_of(file_list)
    file_list.map do |file| 
      Digest::MD5.hexdigest(File.read("#{Rails.root}/app/views/#{file}"))
    end
  end

  def css_path(css_file)
    view_context.stylesheet_path(css_file) if css_file && css_file.length > 0
  end

  def js_path(js_file)
    view_context.javascript_path(js_file) if js_file && js_file.length > 0
  end

end
