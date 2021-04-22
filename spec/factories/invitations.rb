FactoryBot.define do
  factory :invitation, aliases: [:received_invitations, :sent_invitations] do
    host
    invitee
    event
  end
end
