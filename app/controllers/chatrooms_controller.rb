class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom, only: [:show, :edit, :update, :destroy]

  # GET /chatrooms
  # GET /chatrooms.json
  def index
    @chatrooms = Chatroom.all
    @chatroom = Chatroom.first
    @messages = @chatroom.messages.order(created_at: :desc).limit(100).reverse
  end

  def new
    @chatroom = Chatroom.new
  end

  # GET /chatrooms/1/edit
  def edit
  end

  # POST /chatrooms
  # POST /chatrooms.json
  def create
    @chatroom = Chatroom.new(chatroom_params)

    respond_to do |format|
      if @chatroom.save
        format.html { redirect_to chatrooms_path, notice: 'Chatroom was successfully created.' }
        #format.json { render :show, status: :created, location: @chatroom }
      else
        format.html { render :new }
        #format.json { render json: @chatroom.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def chatroom_params
    params.require(:chatroom).permit(:name)
  end
end
