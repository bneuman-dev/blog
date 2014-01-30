get '/' do
  # Look in app/views/index.erb
  @posts = Post.all
  erb :index
end

get '/new/' do
  erb :new
end

post '/create/' do
  tags = tag_processor(params[:tags])
  post = Post.create(title: params[:title], content: params[:content], tags: tags)
  dest = (post.id.nil?) ? error_handler(post) : "/posts/#{post.id}/"
  redirect dest
end



get '/tags/:tag_name/' do
  @tag = Tag.find_by(tag_name: params[:tag_name])
  @posts = @tag.posts
  erb :tag_posts
end





get '/posts/:post_id/' do
  @post = Post.find(params[:post_id])
  erb :post
end

get '/posts/:post_id/edit/' do
  @post = Post.find(params[:post_id])
  @tags = @post.tags.collect { |tag| tag.tag_name }.join(",")
  erb :edit
end

post '/posts/:post_id/edit/' do
  post = Post.find(params[:post_id])
  tags = tag_processor(params[:tags])
  post.update(title: params[:title], content: params[:content], tags: tags)
  dest = (post.valid?) ? "/posts/#{params[:post_id]}/" : error_handler(post, update=true)

  redirect dest
end

get '/posts/:post_id/delete/' do
  post = Post.find(params[:post_id])
  post.destroy

  redirect "/"
end

get '/posts/error/' do
  @backtrack = params[:from]
  @errors = params[:errors].split(",")
  erb :error
end


