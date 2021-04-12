class AuthRoutes < Application
  helpers Auth

  namespace '/v1' do
    post do
      result = Auth::FetchUserService.call(extracted_token['uuid'])

      if result.success?
        { user_id: result.user.id }.to_json
      else
        status 403
        error_response(result.errors)
      end
    end
  end
end
