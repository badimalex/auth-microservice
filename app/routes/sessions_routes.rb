class SessionsRoutes < Application
  post '/' do
    user_params = validate_with!(SessionParamsContract)

    result = UserSessions::CreateService.call(
      user_params[:email],
      user_params[:password]
    )

    if result.success?
      token = ::JwtEncoder.encode(uuid: result.session.uuid)
      meta = { token: token }

      status 201
      { meta: meta }.to_json
    else
      status 401
      error_response result.session || result.errors
    end
  end
end
