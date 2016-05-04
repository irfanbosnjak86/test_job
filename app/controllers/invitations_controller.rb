class InvitationsController < ApplicationController

  def index 
    @invitations = Invitation.all
  end

  def validation
    @invitation = Invitation.new 
  end

  def create
    @invitation = Invitation.new(invitation_params)
    invitation_params[:email].split(', ').each do |email|
      Invitation.create(email: email, :message => invitation_params[:message])
    end

    redirect_to root_path
  end

  def testingajax
  end

  private 

  def invitation_params
    params.require(:invitation).permit(:email, :message)
  end

  def valid_email?(email)
    @VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

    email.present? && (email =~ @VALID_EMAIL_REGEX)
  end
end
