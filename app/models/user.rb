class User < ApplicationRecord
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable
  has_many :dresses, dependent: :destroy

  #declare relationships with the Transaction
  has_many :sales, class_name: "Transaction", foreign_key: :seller_id, dependent: :destroy 
  has_many :sold_dresses, through: :sales, source: :dress, dependent: :destroy 
  has_many :purchases, class_name: "Transaction", foreign_key: :buyer_id, dependent: :destroy 
  has_many :purchased_dresses, through: :purchases, source: :dress, dependent: :destroy 

  #give me all transactions with seller_id 
  scope :sellers, -> { joins(:sales) }
  #give me all transactions with buyer_id 
  scope :buyers, -> { joins(:purchases) }
  
  #a user instance can have many reviews 
  has_many :reviews, as: :reviewable, dependent: :destroy 

  #establish two relations for conversations
  has_many :sent_conversations, class_name: 'Conversation', foreign_key: :sender_id, dependent: :destroy
  has_many :received_conversations, class_name: 'Conversation', foreign_key: :receiver_id, dependent: :destroy

  #relation with message
  has_many :messages, dependent: :destroy
end
