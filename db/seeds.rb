require 'faker'

# 10.times do
#   post = Post.create(title: Faker::Lorem.words.join(' '), content: Faker::Lorem.paragraphs.join(' '))
#   5.times do
#     post.tags += Faker::Lorem.words.collect { |word| Tag.create(tag_name: word) }
#   end
# end

posts = Post.all.size

Tag.all.each do |tag|
  2.times do
    post = Post.find(rand(1..posts))
    post.tags << tag
  end
end
