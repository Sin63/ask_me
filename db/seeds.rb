User.create!(
  name: 'Mike',
  username: 'mike',
  email: 'mike@mail.com',
  password: '0000'
)

5.times do
  user =
    User.create!(
      name: FFaker::Name.unique.name,
      username: FFaker::Internet.unique.domain_word,
      email: FFaker::Internet.unique.free_email,
      avatar_url: FFaker::Avatar.unique.image,
      password: '0000'
    )

  user.questions.create!(
    text: FFaker::Lorem.phrase
  )
end
