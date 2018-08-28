class MessagesController < ApplicationController
  before_action :set_person
  before_action :set_person_message, only: [:show, :update, :destroy]

  def index
    json_response(@person.messages)
  end

  def show
    json_response(@message)
  end

  def create
    @person.messages.create!(message_params)
    json_response(@person, :created)
  end

  def update
    @message.update(message_params)
    head :no_content
  end

  def destroy
    @message.destroy
    head :no_content
  end

  private

  def message_params
    params.permit(:message_body, :subject)
  end

  def set_person
    @person = Person.find(params[:person_id])
  end

  def set_person_message
    @message = @person.messages.find_by!(id: params[:id]) if @person
  end
end
