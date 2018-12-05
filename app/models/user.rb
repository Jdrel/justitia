class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :client
  has_one :lawyer
  after_create :link_user_to_client

private

  def link_user_to_client
    client = Client.new
    client.user = self
    client.save
  end
end
