class AddDefaultAdmin < ActiveRecord::Migration[5.2]
  def up
    admin = Employee.new
    admin.first_name = "Admin"
    admin.last_name = "Admin"
    admin.ssn = "023649320"
    admin.date_of_birth = "1993-01-25"
    admin.phone = "1234567890"
    admin.username = "admin"
    admin.password = "admin"
    admin.password_confirmation = "admin"
    admin.role = "admin"
    admin.save
  end
  def down
    admin = Employee.find_by_username "admin"
    Employee.delete admin
  end
end
