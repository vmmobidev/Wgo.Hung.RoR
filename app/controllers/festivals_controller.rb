class FestivalsController < ApplicationController

  # GET /festivals
  # GET /festivals.json
  # http://wgo-hung-ror.herokuapp.com/users/insertUser//changed to blooming something heroku
  def index
    # @offset, @limit = api_offset_and_limit
    @festivals =  Festival.find :all
                        # :limit  =>  @limit,
                        # :offset =>  @offset
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => {:Success => true, :Data => @festivals}, :callback => params[:callback] }
    end
  end

  # GET /festivals/1
  # GET /festivals/1.json
  def show
    @festival = Festival.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @festival }
    end
  end

  # GET /festivals/new
  # GET /festivals/new.json
  def new
    @festival = Festival.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @festival }
    end
  end

  # GET /festivals/1/edit
  def edit
    @festival = Festival.find(params[:id])
  end

  # POST /festivals
  # POST /festivals.json
  def create    
    puts request.params[:festival]["id"] #[:id].to_i
    puts params[:festival]
    puts '************************************************************'
    if request.params[:festival]["id"]
      puts 'Into the if loop'
      params[:festival] = JSON.parse(params[:festival])
      puts params[:festival]
    end
    puts '************************************************************'
    puts params[:festival]
    #@festival = Festival.new(:name =>params[:festival][:name], :details => params[:festival][:details],:city=> params[:festival][:city],:period=> params[:festival][:period],:timings=> params[:festival][:timings], :telephone => params[:festival][:telephone])    
    @festival = Festival.new(params[:festival])
    respond_to do |format|
      if @festival.save
        format.html { redirect_to @festival, notice: 'Festival was successfully created.' }
        format.json { render json: @festival, status: :created, location: @festival }
      else
        format.html { render action: "new" }
        format.json { render json: @festival.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /festivals/1
  # PUT /festivals/1.json
  def update
    @festival = Festival.find(params[:id])
    if(@festival.update_attributes(:name => params[:name], :details => params[:details], :city => params[:city], :period => params[:period], :timings => params[:timings], :telephone => params[:telephone]))
      respond_to do |format|
         format.html { redirect_to @festival, notice: 'Festival was successfully updated.' }
         format.json { render :json => {:Success => true}, :callback => params[:callback] }
      end
    else
      respond_to do |format|
         format.html { render action: "edit" }
         format.json { render :json => {:Success => true}, :callback => params[:callback] }
      end
    end
  end

  # DELETE /festivals/1
  # DELETE /festivals/1.json
  # http://localhost:3000/festivals/destroy/1
  # http://wgo-hung-ror.herokuapp.com/festivals/destroy/1
  # This URL is used to delete or destroy a particular festival
  def destroy
    @festival = Festival.find(params[:id])
    @festival.destroy

    respond_to do |format|
      format.html { redirect_to festivals_url }
      format.json { head :no_content }
    end
  end
end