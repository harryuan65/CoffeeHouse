# frozen_string_literal: true

#
# The User model to allow users to sign in.
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  has_many :orders

  def admin?
    email == ENV["ADMIN_EMAIL"]
  end
end
