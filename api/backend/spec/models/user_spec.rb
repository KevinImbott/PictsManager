# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  context 'user with ' do
    it 'no pseudo' do
      user.pseudo = nil
      expect(user).to_not be_valid
    end
    it 'no email' do
      user.email = nil
      expect(user).to_not be_valid
    end
    it 'bad email' do
      user.email = 'bademail'
      expect(user).to_not be_valid
    end
    it 'no password' do
      user.password = nil
      expect(user).to_not be_valid
    end
  end
  context 'user with good attributes' do
    it 'is valid' do
      expect(user).to be_valid
    end
    it 'can update email' do
      user.email = 'test@test.com'
      expect(user.email).to eq 'test@test.com'
    end
    it 'can update pseudo' do
      user.pseudo = 'test'
      expect(user.pseudo).to eq 'test'
    end
    it 'can update password' do
      user.email = 'password'
      expect(user.email).to eq 'password'
    end
  end
end
