class InvitationsController < ApplicationController

  def index 
    @invitations = Invitation.all
  end

  def validation
    @invitation = Invitation.new 
  end

  def create
    @invitation = Invitation.new(invitation_params)
    @valid_array ||= []
    @novalid_array ||= []
    
    invitation_params[:email].split(', ').each do |email|
      if valid_email?(email)
        @valid_array << email
      else
        @novalid_array << email
      end
    end

    respond_to do |format|
      if @novalid_array.empty?
          @valid_array.each do |email|
            Invitation.create(email: email, :message => invitation_params[:message])
          end
        redirect_to root_path
      else 
        flash[:error] = @novalid_array
        format.html { render :validation, notice: 'Something went wrong!' }
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
