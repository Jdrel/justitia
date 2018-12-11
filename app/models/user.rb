class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :client, dependent: :destroy
  has_one :lawyer, dependent: :destroy
  after_create :link_user_to_client

  def is_lawyer?
    self.lawyer
  end

  def full_name
    self.first_name + " " + self.last_name
  end

  private

  def link_user_to_client
    client = Client.new
    client.user = self
    client.save
  end
end
