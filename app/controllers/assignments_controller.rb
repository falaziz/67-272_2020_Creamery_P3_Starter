class AssignmentsController < ApplicationController
    before_action :set_assignment, only: [:show, :edit, :update, :destroy]
    
    def terminate
        @assignment.end_date = Date.today
    end
    
    def index
        @assignments = Assignment.chronological.paginate(:page => params[:page]).per_page(5)
    end
    
    def show
    end
    
    def new
        @assignment = Assignment.new
    end
    
    def create
        @assignment = Assignment.new(assignment_params)
        if @assignment.save
            redirect_to assignment_path(@assignment), notice: "#Succesfully added the assignment."
        else
            render action: 'new'
        end
    end
    
    def edit
        @assignment = Assignment.find(params[:id])
    end
    
    def update
        if @assignment.update
            redirect_to assignment_path(@assignment), notice: "Assignment was revised in the system."
        else
            render action: 'edit'
        end
    end
    
    def destroy
        @assignment.destroy
        redirect_to assignments_url, notice: "Removed assignment from the system."
    end
    
    private
    def set_assignment
        @assignment= Assignment.find(params[:id])
    end
    
    def assignment_params
        params.require(:assignment).permit(:store_id, :employee_id, :start_date)
    end
end
