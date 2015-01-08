class Message < ActsAsMessageable::Message


  def capitalize_title
    title.capitalize
  end
end
