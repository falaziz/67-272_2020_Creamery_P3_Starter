json.extract! @store, :id, :name, :street, :city, :state, :phone, :zip, :active
json.extract! assignment, :id, :store_id, :employee_id, :start_date, :end_date, assignment: @assignment
json.extract! employee, :id, :first_name, :last_name, :ssn, :date_of_birth, :phone, :role, :active