# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


puts "Cadastrando as categorias..."

categories =["Animais e acessórios",
							"Esportes",
							"Para a sua casa",
							"Eletrônicos e celulares",
							"Música e hobbies",
							"Bebês e crianças",
							"Moda e beleza",
							"Veículos e barcos",
							"Imóveis",
							"Empregos e negócios"]

categories.each do |category|
	Category.friendly.find_or_create_by(description: category)
end

puts "Categorias => cadastradas com sucesso!"

########################################

puts "Cadastrando o Administrador Padrão..."

	Admin.create!(name: "Administrador Padrão", 
								email: "admin@admin.com", 
								password: "123456", 
								password_confirmation: "123456",
								role: 0)

puts "Administrador => cadastrado com sucesso!"


puts "Cadastrando o Membro Padrão..."

	member = Member.new(
									email: "member@member.com", 
									password: "123456", 
									password_confirmation: "123456")
	member.build_profile_member
  member.profile_member.first_name = "Member"
  member.profile_member.second_name = "Member"
  member.save!

puts "Membro => cadastrado com sucesso!"
