class UserMailer < ActionMailer::Base
  default from: "admin@projectsmanagement.com"
  def assigned_todo(user)
    @user=user
    mail(:to => @user.email, :subject => "Welcome to projectsManagement!")
  end
  def todo_status_updates(user)
    @user=User.find_by_role("admin")
    mail(:to => @user.email, :subject => "Welcome to projectsManagement!")
  end
end
