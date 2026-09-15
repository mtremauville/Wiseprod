class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_initialize { self.role ||= "vendeur" }

  def admin?
    role == "admin"
  end
end
