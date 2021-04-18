class AuthRoutes < Application
  helpers Auth

  post '/' do
    result = Auth::FetchUserService.call(extracted_token['uuid'])

    content_type :json

    if result.success?
      { user_id: result.user.id }.to_json
    else
      status 403
      error_response(result.errors)
    end
  end
end
