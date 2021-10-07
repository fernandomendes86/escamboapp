namespace :dev do
  
  desc "Setup Dev"
  task setup: :environment do
  
    puts "Setup do desenvolvimento..."
    
    puts "Drop DB..."
    puts %x(rake db:drop)

    puts "Apagando as imagens de public/system"
    puts %x(rm -rf public/system)

    puts "Create DB..."
    puts %x(rake db:create)
    
    puts "Migrations DB..."
    puts %x(rake db:migrate)
    
    puts "Seed DB..."
    puts %x(rake db:seed) 
    
    puts "Dev Admin..."
    puts %x(rake dev:generate_admins) 

    puts "Dev Membros..."
    puts %x(rake dev:generate_members) 

    puts "Dev Anúncios..."
    puts %x(rake dev:generate_ads) 

    puts "Dev Comentários..."
    puts %x(rake dev:generate_comments) 

    puts "Setup do desenvolvimento completado com sucesso!"

  end

  desc "Criar administradores Fake"
  task generate_admins: :environment do
  
	  puts "Cadastrando ADMINISTRADORES..."
	  
	  (2..10).each do |x| 
	  	Admin.create!(name: Faker::Name.name, 
	  								email: Faker::Internet.email, 
	  								password: "123456", 
	  								password_confirmation: "123456",
	  								role: [0,1,1,1,1].sample)
	  end

	  puts "ADMINISTRADORES cadastrados com sucesso!"

  end


  desc "Criar Membros Fake"
  task generate_members: :environment do
  
    puts "Cadastrando MEMBROS..."
    
    (2..100).each do |x| 
      member = Member.new( 
                    email: Faker::Internet.email, 
                    password: "123456", 
                    password_confirmation: "123456")
      member.build_profile_member
      member.profile_member.first_name = Faker::Name.first_name
      member.profile_member.second_name = Faker::Name.last_name
      member.save!
    end

    puts "MEMBROS cadastrados com sucesso!"

  end



  ###################################################################################################################
  desc "Cria Anúncios Fake"
  task generate_ads: :environment do

    puts "Cadastrando ANÚNCIOS..."

    (1..5).each do |x|
      Ad.create!(
        title: Faker::Lorem.sentence,
        description_md: Faker::Markdown.sandwich(sentences: 5),
        description_short: Faker::Lorem.paragraph,
        member: Member.first,
        category: Category.all.sample,
        finish_date: Date.today + Random.rand(99),
        price: "#{Random.rand(0..600)},#{Random.rand(0..99)}",
        picture: File.new(Rails.root.join('public', 'templates', 'images-for-ads', "#{Random.rand(0..9)}.jpg"), 'r')
      )
    end

    (6..100).each do |x|
      Ad.create!(
        title: Faker::Lorem.sentence,
        description_md: Faker::Markdown.sandwich(sentences: 5),
        description_short: Faker::Lorem.paragraph,
        member: Member.all.sample,
        category: Category.all.sample,
        finish_date: Date.today + Random.rand(99),
        price: "#{Random.rand(0..600)},#{Random.rand(0..99)}",
        picture: File.new(Rails.root.join('public', 'templates', 'images-for-ads', "#{Random.rand(0..9)}.jpg"), 'r')
      )
    end

    puts "ANÚNCIOS cadastrados com sucesso!"
  end

  desc "Criar Comentários Fake"
  task generate_comments: :environment do
  
    puts "Cadastrando COMENTÁRIOS..."
    
    Ad.all.each do |ad|
      (Random.rand(3)).times do
        Comment.create!(
          body: Faker::Lorem.paragraph,
          member: Member.all.sample,
          ad: ad
          )
      end
    end

    puts "COMENTÁRIOS cadastrados com sucesso!"

  end



end
