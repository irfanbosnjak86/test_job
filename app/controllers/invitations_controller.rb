class InvitationsController < ApplicationController

  def index 
    @invitations = Invitation.all
  end

  def validation
    @invitation = Invitation.new 
  end

  def create
    @invitation = Invitation.new(invitation_params)

    respond_to do |format|
      if valid_email?(@invitation.email) 
        @invitation.save
        format.html { redirect_to root_path, notice: 'Invitation was successfully created.' }
        format.json { render :index, status: :created, location: :index }
      else
        flash[:error] = 'Bad email!'
        format.html { render :validation, notice: 'Something went wrong!' }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
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
