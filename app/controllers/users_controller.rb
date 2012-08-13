class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @offset, @limit = api_offset_and_limit
    @users =  User.find :all,
                        :limit  =>  @limit,
                        :offset =>  @offset
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => {:Success => true, :Data => @users}, :callback => params[:callback] }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  # http://localhost:3000/users/destroy/1
  # This URL is used to delete or destroy a particular user
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  # This function is used to authenticate an user
  # http://localhost:3000/users/authenticate
  def authenticate     
     @getUser = User.where("username = ? AND password = ?", params[:username], params[:password])       
     if (@getUser!=[])       
       respond_to do |format| 
        format.html { render :json => {:Success => true, :Data => @getUser}, :callback => params[:callback] }
        format.json { render :json => {:Success => true, :Data => @getUser}, :callback => params[:callback] }
       end
     else           
      respond_to do |format|
        format.html { render :json => {:Success => false, :Data => @getUser}, :callback => params[:callback] }
        format.json { render :json => {:Success => false, :Data => @getUser}, :callback => params[:callback] }
      end 
     end
  end
  
  # This function is used to Create an new User
  # http://localhost:3000/users/insertUser
  def insertUser
    query = "INSERT INTO users (username,password,email,created_at,updated_at) VALUES ('#{params[:username]}', '#{params[:password]}', '#{params[:email]}',current_date,current_date)"
    ActiveRecord::Base.connection.execute(query)
    if(ActiveRecord::Base.connection.execute(query))
      respond_to do |format| 
          format.html { render :json => {:Success => true}, :callback => params[:callback] }
          format.json { render :json => {:Success => true}, :callback => params[:callback] }
         end
       else           
        respond_to do |format|
          format.html { render :json => {:Success => false}, :callback => params[:callback] }
          format.json { render :json => {:Success => false}, :callback => params[:callback] }
        end 
       end 
  end
  
  # This function is used to edit an existing user and update
  # http://localhost:3000/users/editUser
  def editUser
     @user = User.find(params[:id])              
     @user.update_attributes(:username => params[:username], :password => params[:password], :email => params[:email] )
    if(@user.update_attributes(:username => params[:username], :password => params[:password], :email => params[:email] ))
      respond_to do |format| 
          format.html { render :json => {:Success => true}, :callback => params[:callback] }
          format.json { render :json => {:Success => true}, :callback => params[:callback] }
         end
       else           
        respond_to do |format|
          format.html { render :json => {:Success => false}, :callback => params[:callback] }
          format.json { render :json => {:Success => false}, :callback => params[:callback] }
        end 
    end 
  end
  
  # This function is used to Create an new User or Edit an existing user and update
  # http://localhost:3000/users/saveUser
  def saveUser
    if(params[:id]!='')
        @user = User.find(params[:id])              
        @user.update_attributes(:username => params[:username], :password => params[:password], :email => params[:email] )
       if(@user.update_attributes(:username => params[:username], :password => params[:password], :email => params[:email] ))
         respond_to do |format| 
             format.html { render :json => {:Success => true}, :callback => params[:callback] }
             format.json { render :json => {:Success => true}, :callback => params[:callback] }
            end
          else           
           respond_to do |format|
             format.html { render :json => {:Success => false}, :callback => params[:callback] }
             format.json { render :json => {:Success => false}, :callback => params[:callback] }
           end       
       end
    else
       query = "INSERT INTO users (username,password,email,created_at,updated_at) VALUES ('#{params[:username]}', '#{params[:password]}', '#{params[:email]}',current_date,current_date)"
       ActiveRecord::Base.connection.execute(query)
       if(ActiveRecord::Base.connection.execute(query))
         respond_to do |format| 
             format.html { render :json => {:Success => true}, :callback => params[:callback] }
             format.json { render :json => {:Success => true}, :callback => params[:callback] }
            end
          else           
           respond_to do |format|
             format.html { render :json => {:Success => false}, :callback => params[:callback] }
             format.json { render :json => {:Success => false}, :callback => params[:callback] }
           end 
       end
    end  
  end  
  
  
end
