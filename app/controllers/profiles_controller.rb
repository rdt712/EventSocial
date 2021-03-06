class ProfilesController < ApplicationController

	before_action :authenticate_user!
  	before_action :only_current_user

	def new
    	# form where a user can fill out their own profile.
    	@user = User.find( params[:user_id] )
    	@profile = @profile = Profile.new
  	end

  	def create 
	    @user = User.find( params[:user_id] )
	    @profile = @user.build_profile(profile_params)
	    if @profile.save
	      	flash[:notice] = "Profile successfully created!"
	    	redirect_to user_path( params[:user_id] )
	    else
	      	render action: :new
	    end
  	end
  
	def edit
		@user = User.find( params[:user_id] )
		@profile = @user.profile
	end

	def delete_profile_pic
		@user = User.find(params[:user_id])
		@profile = @user.profile
		@profile.profile_pic.destroy
		@profile.save
		redirect_to edit_user_profile_path(@user)
	end
  
	def update
		@user = User.find( params[:user_id] )
		@profile = @user.profile
		if @profile.update_attributes(profile_params)
		  	flash[:notice] = "Profile successfully updated!"
		  	redirect_to user_path( params[:user_id] )
		else
		  	render action: :edit
		end
	end
  
	private
		def profile_params
		  	params.require(:profile).permit(:first_name, :last_name, :profile_pic, :occupation, :about_me)
		end

		def only_current_user
		  	@user = User.find( params[:user_id] )
		  	redirect_to(root_url) unless @user == current_user
		end

end