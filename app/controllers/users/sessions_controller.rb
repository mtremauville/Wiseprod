class Users::SessionsController < Devise::SessionsController
  skip_before_action :require_no_authentication, only: [ :create ], raise: false
  prepend_before_action :sign_out_current_user, only: [ :create ]
  before_action :set_minimum_password_length, only: [ :new ]

  private

  def sign_out_current_user
    sign_out(current_user) if user_signed_in?
  end
end
