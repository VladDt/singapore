class User < ApplicationRecord

	has_many :sessions, dependent: :destroy
	has_many :locations, dependent: :destroy
	has_many :patient_visits, class_name: 'Visit', foreign_key: 'patient_id'
	has_many :doctor_visits, class_name: 'Visit', foreign_key: 'doctor_id'

  validates :email, :phone_number, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :encrypted_password, presence: true, length: { minimum: 6, message: 'must contain at least 6 symbols' }

end
