class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  # Associations
  has_many :ads
  has_one :profile_member

  # Validations
  validate :nested_attributes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  accepts_nested_attributes_for :profile_member

  # Ratyrate gem
  ratyrate_rater


  def nested_attributes
  	if nested_attributes_blank?
  		errors.add(:base, "É necessário preencher os campos Primeiro e Segundo nome.")
  	end
  end

  def nested_attributes_blank?
  	profile_member.first_name.blank? || profile_member.second_name.blank?
  end

end
