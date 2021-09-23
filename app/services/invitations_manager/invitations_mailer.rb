module InvitationsManager
  class InvitationsMailer < ApplicationService
    attr_reader :invitations

    def initialize(invitations)
      @invitations = invitations
    end

    def call
      invitations.each do |invitation|
        InvitationMailer.with(invitation: invitation).invitation_email.deliver_later
      end
    end
  end
end
