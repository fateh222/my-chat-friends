class MessagesController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_user!
  before_action :set_chatroom
  skip_before_action :verify_authenticity_token

  def create
    @message =  @chatroom.messages.new(message_params)
    @message.user = current_user
    @message.save
    respond_to do |format|
      #redirect_to chatrooms_path

      format.json { render json: @message.to_json }
    end
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:chatroom_id])
  end

  def message_params
    params.require(:message).permit(:body)
  end

end
