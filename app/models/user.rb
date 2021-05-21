class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    attr_accessor :remember_token
    has_many :exams, dependent: :destroy
    has_many :exam_questions, through: :user_answers
    has_many :results, dependent: :destroy
    belongs_to :school, optional: true

    # validates :name, presence: true
    validates :password, presence: true, confirmation: true,
                            length: { minimum: 6 }
    validates :email, presence:true, uniqueness: true

    before_save :downcase_fields

    def downcase_fields
        self.email.downcase!
    end

    def admin?
        self.admin_role?
    end
end
