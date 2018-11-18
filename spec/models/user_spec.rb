require 'rails_helper'

describe User do
  user = FactoryGirl.build(:user)

  it 'is valid with a full name, phone number, email, and password' do
    user = User.create(
      full_name: 'Test User',
      phone_number: '123345546',
      email: 'test@example.com',
      encrypted_password: 'passssswdwdsdwpd',
      )
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = User.create(full_name: nil)
    user.valid?
    expect(user.errors[:full_name]).to include("can't be blank")
  end

  it 'is invalid without a phone number' do
    user = User.create(phone_number: nil)
    user.valid?
    expect(user.errors[:phone_number]).to include("can't be blank")
  end

  it 'is invalid without an email' do
    user = User.create(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid without a password' do
    user = User.create(encrypted_password: nil)
    user.valid?
    expect(user.errors[:full_name]).to include("can't be blank")
  end

  it 'is invalid with a duplicating phone numbers' do
    user = User.create(
      full_name: 'Test User',
      phone_number: '123345546',
      email: 'test@example.com',
      encrypted_password: 'passssswdwdsdwpd',
      )
    user = User.create(
      full_name: 'Test User',
      phone_number: '123345546',
      email: 'test1@example.com',
      encrypted_password: 'passssswdwdsdwpd',
      )
    user.valid?
    expect(user.errors[:phone_number]).to include('has already been taken')
  end

  it 'is invalid with a duplicating emails' do
    user = User.create(
      full_name: 'Test User',
      phone_number: '123345547',
      email: 'test@example.com',
      encrypted_password: 'passssswdwdsdwpd',
      )
    user = User.create(
      full_name: 'Test User',
      phone_number: '123345546',
      email: 'test@example.com',
      encrypted_password: 'passssswdwdsdwpd',
      )
    user.valid?
    expect(user.errors[:email]).to include('has already been taken')
  end

  it 'is invalid with a password length < 6' do
    user = User.create(
      full_name: 'Test User',
      phone_number: '123345547',
      email: 'test@example.com',
      encrypted_password: 'passwdg',
      )
    user.valid?
    expect(user.errors[:encrypted_password]).to include('must contain at least 6 symbols')
  end

  describe 'ActiveRecord Associations' do
    it { expect(user).to have_many(:sessions).dependent(:destroy) }
    it { expect(user).to have_many(:locations).dependent(:destroy) }
    it { expect(user).to have_many(:doctor_visits) }
    it { expect(user).to have_many(:patient_visits) }
  end

  describe "Password Length Validations" do
    #it { expect(user).to validate_length_of(:encrypted_password).is_at_least(6) }
  end

end