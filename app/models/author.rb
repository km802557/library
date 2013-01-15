# == Schema Information
#
# Table name: authors
#
#  id         :integer          not null, primary key
#  lastname   :string(255)
#  firstname  :string(255)
#  nickname   :string(255)
#  labo       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Author < ActiveRecord::Base
  attr_accessible :firstname, :labo, :lastname, :nickname, :password, :password_confirmation
  has_secure_password
  has_many :publications, dependent: :destroy
  
   before_save :create_remember_token
   
  validates :firstname, presence: true, length: { maximum: 40 }
  validates :lastname, presence: true, length: { maximum: 40 }
  validates :nickname, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }
  validates :labo, presence: true, length: { maximum: 20 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  private
  
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
  
  def feed
    # This is preliminary. See "Following users" for the full implementation.
    Publication.where("author_id = ?", id)
  end
  
end
