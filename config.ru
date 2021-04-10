require_relative 'config/environment'

map '/users' do
  run UserRoutes
end

map '/sessions' do
  run SessionsRoutes
end

map '/auth' do
  run AuthRoutes
end
