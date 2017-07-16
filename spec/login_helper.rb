# Log in as a particular user.
def log_in_as(user)
  session[:user_id] = user.id
end

## for request
def sign_in_as(user, password: user.password, remember_me: '1')
  post login_path, params: { session: { username: user.username,
                                               password: password,
                                               remember_me: remember_me } }
end
