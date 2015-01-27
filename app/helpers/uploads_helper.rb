module UploadsHelper
  def new_url(content)
    content.strip(0..-14)
  end
end
