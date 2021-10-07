class Admin < ActiveRecord::Base

	enum role: {full_access: 0, restricted_access: 1}

	scope :with_full_acccess, -> { where(role: 0)}

  scope :with_restricted_access, -> { where(role: 1)}
	

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


end
