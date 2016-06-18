class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships
  has_many :organizations, through: :memberships
  ROLES = [:volunteer_center_admin, :org_admin]

  def add_role(new_role)
    roles = self.roles << new_role
    roles.map! { |r| r.to_sym }
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
    self.save
  end

  def roles
    ROLES.reject do |r|
     ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
    end
  end
end
