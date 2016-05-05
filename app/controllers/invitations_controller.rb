class InvitationsController < ApplicationController

  def index 
    @invitations = Invitation.all
  end

  def new
    @invitation = Invitation.new 
  end

  def create
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
        format.html { redirect_to invitations_path, notice: 'Invitation was successfully created.' }
        format.js {render 'valid'}
        format.json { render :index, status: :created, location: :index }
      else 
        format.html { render :validation, notice: 'Something went wrong!' }
        format.js {}
        format.json { render json: @novalid_array.errors, status: :unprocessable_entity }
      end
    end 
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
