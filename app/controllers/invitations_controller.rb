class InvitationsController < ApplicationController

  def index 
    @invitations = Invitation.all
  end

  def validation
    @invitation = Invitation.new 
  end

  def create
    @invitation = Invitation.new (invitation_params)

    respond_to do |format|
      if @invitation.save
        format.html { redirect_to root_path, notice: 'Invitation was successfully created.' }
        format.json { render :index, status: :created, location: :index }
      else
        format.html { render :validation }
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
end
