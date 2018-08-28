class CommunicationsController < ApplicationController
  before_action :set_person

  def create
    @person.messages.create!(message_params)
    json_response(@person, :created)
  end

  private

  def communication_params
    params.permit(:first_name, :last_name, :email, :message_body, :subject)
  end

  def person_params
    params.permit(:first_name, :last_name, :email)
  end

  def message_params
    params.permit(:message_body, :subject)
  end

  def set_person
    @person = Person.find_or_create_by(email: params[:email]) do |user|
      user.update(person_params)
    end
  end
end
