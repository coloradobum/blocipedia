class User < ActiveRecord::Base
  has_many :collaborations
  has_many :users, through: :collaborations

  has_many :wikis

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
end
