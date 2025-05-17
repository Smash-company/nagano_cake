class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy

  def full_name
      last_name + '' + first_name
    end
    
    def full_name_kana
      last_name_kana + '' + first_name_kana
    end
    
    def customer_status
      if is_active == true
        "有効"
      else
        "無効"
      end
    end

    def active_for_authentication?
      super && (is_active == true)
    end
  end
