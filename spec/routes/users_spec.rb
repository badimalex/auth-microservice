RSpec.describe UserRoutes, type: :routes do
  describe 'POST /signup' do
    context 'missing parameters' do
      let(:user_params) do
        { name: 'bob', email: 'bob@example.com', password: '' }
      end

      it 'returns an error' do
        post '/', user: user_params

        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      let(:user_params) do
        { name: 'b.o.b', email: 'bob@example.com', password: 'givemeatoken' }
      end

      it 'returns an error' do
        post '/', user: user_params

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
          {
            'detail' => 'Укажите имя, используя буквы, цифры или символ подчёркивания',
            'source' => {
              'pointer' => '/data/attributes/name'
            }
          }
        )
      end
    end

    context 'valid parameters' do
      let(:user_params) do
        {
          name: 'bob',
          email: 'bob@example.com',
          password: 'givemeatoken'
        }
      end

      it 'returns created status' do
        post '/', user: user_params

        expect(last_response.status).to eq(201)
      end
    end
  end
end
