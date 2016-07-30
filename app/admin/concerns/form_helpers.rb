module FormHelpers
  def self.file_hint(form)
    return content_tag(:span, 'upload a PGN') if form.object.nil?
    image_tag(form.object.logo.url(:medium))
  end
end
