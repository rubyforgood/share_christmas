module ControllerMacros
  def login_user(admin: false)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user = User.find_by_email(FactoryGirl.attributes_for(:user)[:email])
    user = FactoryGirl.create(:user) unless user
    user.add_role(:admin) if admin
    sign_in user
  end
end
