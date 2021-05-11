class User < ApplicationRecord
    attr_accessor :remember_token
    has_secure_password
    has_many :exams, dependent: :destroy
    has_many :user_answers
    has_many :exam_questions, through: :user_answers

    validates :name, presence: true
    validates :password, presence: true, confirmation: true,
                         length: { minimum: 6 }
    validates :email, presence:true, uniqueness: true

    before_save :downcase_fields


    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def authenticated?(remember_token)
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    def forget
        update_attribute(:remember_digest, nil)
    end

    def downcase_fields
        self.email.downcase!
    end

    class << self
        # Returns the hash digest of the given string.
        def digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
            BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost)
        end
        # Returns a random token.
        def new_token
            SecureRandom.urlsafe_base64
        end

    end
end
