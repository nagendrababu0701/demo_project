class CreateAdminUser < ActiveRecord::Migration
  def change
    User.create(:name=>"admin", :employee_id=>"1", :email=>'admin@projectsmanagement.com', :password=>'admin123', :password_confirmation=>'admin123', :role=>'admin')
  end
end
