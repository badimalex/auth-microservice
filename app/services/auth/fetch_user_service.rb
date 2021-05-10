module Auth
  class FetchUserService
    prepend BasicService

    param :uuid

    attr_reader :user

    def call
      return fail!(I18n.t(:forbidden, scope: 'services.auth.fetch_user_service')) if @uuid.blank? || session.blank?
      @user = session.user
    end

    private

    # @todo
    def session
      @session ||= UserSession.fetch("SELECT * FROM user_sessions WHERE uuid::text = ? LIMIT 1", @uuid).first rescue nil
    end
  end
end
