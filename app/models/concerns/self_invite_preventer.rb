class SelfInvitePreventer < ActiveModel::Validator
  def validate(record)
    if record.host == record.invitee
      record.errors.add(:invitation, 'Host cannot send an invitation to themself.')
    end
  end
end