RSpec.describe Users::CreateService do
  subject { described_class }

  context 'valid parameters' do
    let(:user_params) do
      {
        name: 'bob',
        email: 'bob@example.com',
        password: 'givemeatoken'
      }
    end

    it 'creates a new user' do
      expect { subject.call(user: user_params) }
        .to change { User.count }.from(0).to(1)
    end

    it 'assigns user' do
      result = subject.call(user: user_params)

      expect(result.user).to be_kind_of(User)
    end
  end

  context 'invalid parameters' do
    let(:user_params) do
      {
        name: 'bob',
        email: 'bob@example.com',
        password: ''
      }
    end

    it 'does not create user' do
      expect { subject.call(user: user_params) }
        .not_to change { User.count }
    end

    it 'assigns user' do
      result = subject.call(user: user_params)

      expect(result.user).to be_kind_of(User)
    end
  end
end
