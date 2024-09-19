# frozen_string_literal: true

class SessionsController < Clearance::SessionsController
  skip_before_action :verify_authenticity_token, only: %i[create_without_csrf destroy_without_csrf]

  # To authenticate in Cypress test
  def create_without_csrf
    @user = authenticate(params)
    sign_in(@user)
  end

  def destroy_without_csrf
    sign_out
  end
end
