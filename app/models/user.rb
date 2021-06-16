class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    attr_accessor :remember_token
    has_many :exams, dependent: :destroy
    has_many :results, dependent: :nullify
    belongs_to :school, optional: true

    # validates :name, presence: true
    validates :password, presence: true, confirmation: true,
                            length: { minimum: 6 }
    validates :email, presence:true, uniqueness: true


    def admin?
        admin_role?
    end

    def results_average
        result_count = results.count > 0 ? results.count : 1
        results.sum(:value) / result_count
    end

    def submitted
        results.count
    end

    scope :top_user, ->{ joins(:results).order("results.value").group(:id) }
    scope :user, ->{ where(admin_role: false) }
end
