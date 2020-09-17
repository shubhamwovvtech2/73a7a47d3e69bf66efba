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
    @follow = Follow.new(follow_params)

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
    byebug
    if Follow.find_by(following_id: params[:following_id],followed_by_id: current_user.id,is_follow: true).present?
      redirect_to "/homes",notice: "Already followed"
    else
      @followuser = Follow.create(following_id: params[:following_id],followed_by_id: current_user.id,is_follow: true)
      redirect_to "/homes",notice: "User followed successfully."
    end
  end

  def unfollowuser
    if Follow.find_by(following_id: params[:following_id],followed_by_id: current_user.id,is_follow: false).present?
      redirect_to "/homes",notice: "Already unfollowed"
    else
      @followuser = Follow.create(following_id: params[:following_id],followed_by_id: current_user.id,is_follow: false)
      redirect_to "/homes",notice: "User unfollowed successfully."
    end
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
      params.require(:follow).permit(:followed_by_id, :following_id,:is_follow)
    end
end
