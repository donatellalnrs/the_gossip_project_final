require 'faker'
I18n.reload!

5.times do 
  my_city = City.create(name: Faker::Address.city, zip_code: Faker::Address.zip_code)
end

10.times do 
  my_user = User.new(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.sentence, email: Faker::Internet.email, age: Faker::Number.between(from: 15, to: 90), password: Faker::Internet.password, password_digest: Faker::Internet.password)
  my_user.city_id = rand (1..5) #on assigne une ville à un user
  my_user.save
end 

20.times do 
  my_gossip = Gossip.new(title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph)
  random = rand (1..10) 
  my_user = User.find(random) #on choisit un user de manière aléatoire
  my_gossip.user = my_user #on l'assigne à un gossip
  my_gossip.save
end 

10.times do 
  my_tag = Tag.create(title: "##{Faker::Lorem.word}") #on crée des hashtags
end 

20.times do |i|
  my_gossip = Gossip.find(i+1) #on prend un gossip
  number_of_tags = rand (1..3) #on choisit le nombre de tags que le gossip aura, de manière aléatoire
  number_of_tags.times do |j|
   my_tag = Tag.find(rand (1..10)) #on choisit un tag de manière aléatoire
   join_table = JoinTableGossipTag.create(gossip: my_gossip, tag: my_tag) #on assigne ce tag au gossip
  end 
end 

5.times do 
  random = rand (1..10) 
  my_user = User.find(random) #on choisit un user de manière aléatoire
  number_of_recipients = rand (1..3)
  content = Faker::Lorem.paragraph #on simule un contenu à envoyer
  number_of_recipients.times do |k|
  	my_pm = PrivateMessage.new(content: content) #on simule à private message
  	my_pm.sender = my_user #on indique qui est l'expéditeur du pm
  	my_pm.recipient = User.find(rand(1..10)) #on choisit un recipient de manière aléatoire
  	my_pm.save
  end 
end 


20.times do 
  my_comment = Comment.new(content: Faker::Lorem.paragraph)
  my_user = User.find(rand (1..10)) #on choisit un user de manière aléatoire
  my_comment.user = my_user #on l'assigne à un commentaire
  my_gossip = Gossip.find(rand (1..20)) #on choisit un gossip de manière aléatoire
  my_comment.gossip = my_gossip #on l'assigne à un commentaire
  my_comment.save
end 

#20.times do 
  #my_like = Like.new
  #my_gossip = Gossip.find(rand (1..20)) #on choisit un gossip de manière aléatoire
  #my_comment = Comment.find(rand (1..20)) #on choisit un user de manière aléatoire
  #my_like.gossip = my_gossip #on l'assigne à un like
  #my_like.comment = my_comment #on l'assigne à un like
  #my_like.save
#end 