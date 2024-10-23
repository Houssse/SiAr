require 'faker'

User.create!(
  name: 'Default User',
  email: 'user@user.com',
  password: '123456'
)

User.create!(
  name: 'Admin User',
  email: 'admin@admin.com',
  password: '123456',
  admin: true
)

# Создаем случайное количество пользователей от 5 до 10
num_users = rand(5..10)

# Массив для хранения созданных пользователей
users = []

num_users.times do
  # Создаем пользователя
  user = User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: 'password'
  )
  
  users << user 
end

10.times do
  # Выбираем случайного пользователя из массива users
  random_user = users.sample
  
  Article.create!(
    title: Faker::Book.title,
    content: Faker::Lorem.paragraph(sentence_count: 50),
    user: random_user  # Привязываем статью к выбранному пользователю
  )
end

articles = Article.all

# Для каждой статьи создаем комментарии
articles.each do |article|
  3.times do
    random_user = users.sample

    # Добавляем комментарий к текущей статье
    article.comments.create!(
      body: Faker::Lorem.sentence(word_count: 10),
      user: random_user
    )
  end

  10.times do
    random_user = users.sample
      Like.create(user: random_user, likeable: article, like_type: 1)
  end

  10.times do
    random_user = users.sample
      Like.create(user: random_user, likeable: article, like_type: -1)
  end

end

puts "Seed finished"
