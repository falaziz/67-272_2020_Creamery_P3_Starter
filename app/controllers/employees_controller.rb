class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
    
    def index
        @employees = Employee.active.alphabetical.paginate(:page => params[:page]).per_page(5)
        @active_managers=Employee.active.managers
        @active_employees=Employee.active
        @inactive_employees=Employee.inactive
    end
    
    def show
        @current_assignment = Employee.current_assignment
        @previous_assignment = Employee.assignments.past
    end
    
    def new
        @employee = Employee.new
    end
    
    def create
        @employee = Employee.new(employee_params)
        if @employee.save
            redirect_to employee_path(@employee), notice: "Successfully added #{@employee.proper_name} as an employee."
        else
            render action: 'new'
        end
    end
    
    def edit
        @employee = Employee.find(params[:id])
    end
    
    def update
        if @employee.update(employee_params)
            redirect_to employee_path(@employee), notice: "Updated #{@employee.proper_name}'s information."
        else
            render action: 'edit'
        end
    end
    
    private
    def set_employee
        @employee= Employee.find(params[:id])
    end
    
    def employee_params
        params.require(:employee).permit(:first_name, :last_name, :ssn, :phone, :date_of_birth, :role, :active)
    end
end
