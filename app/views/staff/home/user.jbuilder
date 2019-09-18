json.user do
  json.email @user.email
  json.logout_link url_for(destroy_staff_session_path)
end
