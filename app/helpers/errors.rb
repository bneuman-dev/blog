helpers do
  def error_handler(post, update=false)
    errors = post.errors.messages.collect { |field, error| "#{field.to_s} #{error.join(" ")}"}.join(",")
    back = update ? "/posts/#{params[:post_id]}/edit/" : "/new/"
    "/posts/error/?from=#{back}&errors=#{errors}"
  end

  def tag_processor(tags)
    remove_whitespace(tags).split(',').collect do |tag|
      Tag.find_or_create_by(tag_name: tag.downcase.chomp)
    end
  end

  def remove_whitespace(tag_string)
    tag_string.gsub(' ', '')
  end
end
