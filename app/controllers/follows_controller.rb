class FollowsController < ApplicationController

  before_action :set_follow, only: [:show, :edit, :update, :destroy]


  # GET /follows
  # GET /follows.json
  def index
    @follows = Follow.all
  end

  # GET /follows/1
  # GET /follows/1.json
  def show
  end

  # GET /follows/new
  def new
    @follow = Follow.new
  end

  # GET /follows/1/edit
  def edit
  end

  # POST /follows
  # POST /follows.json
  def create
    @follow = Follow.new(follow_params.merge(followed_by_id: current_user.id))

    respond_to do |format|
      if @follow.save
        format.html { redirect_to @follow, notice: 'Follow was successfully created.' }
        format.json { render :show, status: :created, location: @follow }
      else
        format.html { render :new }
        format.json { render json: @follow.errors, status: :unprocessable_entity }
      end
    end
  end


  def followuser

    if Follow.find_by(following_id: params[:following_id],followed_by_id: current_user.id,is_follow: [:is_follow]).present? == true
      redirect_to "/homes",notice: "Already followed"
    end
    if Follow.find_by(following_id: params[:following_id],followed_by_id: current_user.id,is_follow: [:is_follow]).present? == false
       Follow.create(following_id: params[:following_id],user_id: current_user.id,followed_by_id: current_user.id,is_follow: true) 
       redirect_to "/homes",notice: "User followed successfully."
    end
  end

  def unfollowuser
    if Follow.find_by(following_id: params[:following_id],followed_by_id: current_user.id,is_follow: false).present? == true
      redirect_to "/homes",notice: "Already unfollowed"
    elsif Follow.find_by(following_id: params[:following_id],followed_by_id: current_user.id,is_follow: false).present? == false
       Follow.create(following_id: params[:following_id],followed_by_id: current_user.id,user_id: current_user.id,is_follow: false)
      redirect_to "/homes",notice: "User unfollowed successfully."
    end
  end


  def usersfollow_list
      current_user = User.find_by(id: params[:id])
      @tweetlist = current_user.tweets
      @followings = User.where(id: current_user.follows.pluck(:following_id))

  end

  # PATCH/PUT /follows/1
  # PATCH/PUT /follows/1.json
  def update
    respond_to do |format|
      if @follow.update(follow_params)
        format.html { redirect_to @follow, notice: 'Follow was successfully updated.' }
        format.json { render :show, status: :ok, location: @follow }
      else
        format.html { render :edit }
        format.json { render json: @follow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /follows/1
  # DELETE /follows/1.json
  def destroy
    @follow.destroy
    respond_to do |format|
      format.html { redirect_to follows_url, notice: 'Follow was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_follow
      @follow = Follow.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def follow_params
      params.require(:follow).permit(:followed_by_id, :following_id,:is_follow,:user_id)
    end
end
