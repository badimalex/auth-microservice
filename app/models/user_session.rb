class UserSession < Sequel::Model
  many_to_one :user

  def validate
    super
    validates_presence :uuid, message: I18n.t(:blank, scope: 'model.errors.user.name')
  end

  def before_validation
    self.uuid = SecureRandom.uuid
    super
  end
end
