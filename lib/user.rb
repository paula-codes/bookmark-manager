require_relative './database_connection'
require 'bcrypt'

class User
  attr_reader :id, :email

  def initialize(id:, email:)
    @id = id
    @email = email
  end

  def self.add(email:, password:)
    encrypted_password = BCrypt::Password.create(password)
    data = DatabaseConnection.query("INSERT INTO users (email, password) VALUES('#{email}', '#{encrypted_password}') RETURNING id, email;")
    User.new(id: data[0]['id'], email: data[0]['email'])
  end

  def self.find(id:)
    return nil unless id
    data = DatabaseConnection.query("SELECT * FROM users WHERE id = #{id}")
    User.new(id: data[0]['id'], email: data[0]['email'])
  end

  def self.authenticate(email:, password:)
    data = DatabaseConnection.query("SELECT * FROM users WHERE email = '#{email}'")
    return unless data.any?
    return unless BCrypt::Password.new(data[0]['password']) == password

    User.new(id: data[0]['id'], email: data[0]['email'])
  end

end
