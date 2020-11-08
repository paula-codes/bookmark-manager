require 'user'
require 'database_helper'

describe User do
  
  describe '#self.add' do
    it 'adds a new user' do
      user = User.add(email: 'test@test.com', password: 'testpass')

      persisted_data = persisted_data(table: :users, id: user.id)

      expect(user.id).to eq persisted_data.first['id']
      expect(user.email).to eq 'test@test.com'
    end

    it 'hashes the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('testpass')

      User.add(email: 'test@test.com', password: 'testpass')
    end
  end

  describe '#self.find' do
    it 'finds a user by id' do
      user = User.add(email: 'test@test.com', password: 'testpass')
      data = User.find(id: user.id)

      expect(data.id).to eq user.id
      expect(data.email).to eq user.email
    end

    it 'returns nil if there is no id gived' do
      expect(User.find(id: nil)).to eq nil
    end
  end

  describe '#self.authenticate' do
    it 'returns a user if it exists' do
      user = User.add(email: 'test@test.com', password: 'testpass')
      authenticated_user = User.authenticate(email: 'test@test.com', password: 'testpass')

      expect(authenticated_user.id).to eq user.id
    end

    it 'returns nil given an incorrect email address' do
      user = User.add(email: 'test@test.com', password: 'testpass')
      expect(User.authenticate(email: 'wrong@test.com', password: 'testpass')).to be_nil

    end

    it 'returns nil given an incorrect password' do
      user = User.add(email: 'test@test.com', password: 'testpass')
      expect(User.authenticate(email: 'test@example.com', password: 'wrongpassword')).to be_nil

    end
  end

end