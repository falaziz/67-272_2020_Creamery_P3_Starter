class AssignmentsController < ApplicationController
    before_action :set_assignment, only: [:show, :destroy]
    
    def terminate
        @assignment.end_date = Date.today
        redirect_to assignments_url
    end
    
    def index
        @assignments = Assignment.chronological.paginate(:page => params[:page]).per_page(5)
        @current_assignments = Assignment.current
        @past_assignments = Assignment.past
    end
    
    def show
    end
    
    def new
        @assignment = Assignment.new
    end
    
    def create
        @assignment = Assignment.new(assignment_params)
        if @assignment.save
            redirect_to assignment_path, notice: "Successfully added the assignment."
        else
            render action: 'new'
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
