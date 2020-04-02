class StoresController < ApplicationController
    
    before_action :set_store, only: [:show, :edit, :update]
    
    def index
        @stores = Store.active.alphabetical.paginate(:page => params[:page]).per_page(5)
        @active_stores = Store.active
        @inactive_stores = Store.inactive
    end
    
    def show
        @current_managers = @store.assignments.for_role('manager')
        @current_managers = @store.assignments.for_role('employee')
    end
    
    def new
        @store = Store.new
    end
    
    def create
        @store = Store.new(store_params)
        if @store.save
            redirect_to store_path(@store), notice: "#{@store.name} was added to the system."
        else
            render action: 'new'
        end
    end
    
    def edit
        @store = Store.find(params[:id])
    end
    
    def update
        if @store.update(store_params)
            redirect_to store_path(@store), notice: "Updated store information for #{@store.name}."
        else
            render action: 'edit'
        end
    end
    
    private
    def set_store
        @store= Store.find(params[:id])
    end
    
    def store_params
        params.require(:store).permit(:name, :street, :city, :state, :zip, :phone, :active)
    end
end
