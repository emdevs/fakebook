# Warden::Manager.after_set_user do |user,auth,opts|
#     scope = opts[:scope]
#     warden_key = Rails.application.config.session_options[:warden].user

#     puts(warden_key)
#     auth.cookies.signed["#{scope}.id"] = warden_key
# end

# Warden::Manager.before_logout do |user, auth, opts|
#     scope = opts[:scope]
#     auth.cookies.signed["#{scope}.id"] = nil
# end