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
      if valid_email?(email)
        @valid_array = email
        #Invitation.create(email: email, :message => invitation_params[:message])
      else
        #flash[:error] = 'Bad email!'
        @novalid_array = email
      end
    end

    if @novalid_array.nil?
      invitation_params[:email].split(', ').each do |email|
        Invitation.create(email: email, :message => invitation_params[:message])
      end
    else 
      flash[:error] = 'Bad email!'   
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
