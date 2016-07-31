module ControllerMacros
  def login_user
    @request.env['devise.mapping'] = Devise.mappings[:user]
    # Don't create the user twice
    user = User.find_by_email(FactoryGirl.attributes_for(:user)[:email])
    user = FactoryGirl.create(:user) unless user
    sign_in user
  end
end
