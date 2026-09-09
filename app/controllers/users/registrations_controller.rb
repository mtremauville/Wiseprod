class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication, only: [ :new ], raise: false
  prepend_before_action :sign_out_current_user, only: [ :new ]

  private

  def sign_out_current_user
    sign_out(current_user) if user_signed_in?
  end
end
