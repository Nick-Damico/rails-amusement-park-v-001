class User < ActiveRecord::Base
  has_secure_password
  # Validations
  validates :name, presence: true,
                   uniqueness: true
  validates :height, presence: true,
                     numericality: { only_integer: false }
  validates :happiness, presence: true,
                        numericality: { only_integer: true,
                                        greater_than: 0,
                                        less_than: 6
                                      }
  validates :nausea, presence: true,
                     numericality: { only_integer: true,
                                     greater_than: 0,
                                     less_than: 6
                                   }
  validates :tickets, presence: true,
                      numericality: { only_integer: true }
                      
  # Associations
  has_many :rides
  has_many :attractions, through: :rides

  def mood
    happiness > nausea ? 'happy' : 'sad'
  end
end
