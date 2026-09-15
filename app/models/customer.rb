class Customer < ApplicationRecord
  has_many :receipts, dependent: :destroy

  validates :first_name, :last_name, :email, :phone, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_validation :generate_matricule, on: :create

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def generate_matricule
    loop do
      self.matricule = "CL#{rand(100_000..999_999)}"
      break unless Customer.exists?(matricule: matricule)
    end
  end
end
