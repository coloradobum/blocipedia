class WikisController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_action :set_wiki, only: [:show, :edit, :update, :destroy]

  def index
    @public_wikis = Wiki.public_wikis
    @private_wikis = Wiki.private_wikis.owned_wikis(get_current_user) if user_signed_in?
    @collaboration_wikis = Wiki.show_wiki_details(get_list_of_wikis_being_collaborated) if user_signed_in?

  @number_of_wiki_collorations = is_wiki_collaborator? 8
  # @wikis = policy_cope(Wiki)
  @wikis = Wiki.all

  end

  def show
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
  end

  def edit
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user_id = current_user.id
    respond_to do |format|
      if @wiki.save
        format.html { redirect_to @wiki, notice: 'Wiki was successfully created.' }
        format.json { render :show, status: :created, location: @wiki }
      else
        format.html { render :new }
        format.json { render json: @wiki.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @wiki.update(wiki_params)
        format.html { redirect_to @wiki, notice: 'Wiki was successfully updated.' }
        format.json { render :show, status: :ok, location: @wiki }
      else
        format.html { render :edit }
        format.json { render json: @wiki.errors, status: :unprocessable_entity }
      end
    end
    authorize @wiki
  end

  def destroy
    @wiki.destroy
    respond_to do |format|
      format.html { redirect_to wikis_url, notice: 'Wiki was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wiki
      @wiki = Wiki.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wiki_params
      params.require(:wiki).permit(:title, :body, :private, :user_id,  user_ids: [])
    end

    def get_current_user
      if current_user == nil
        return nil 
      else
        current_user
      end
    end

    def get_list_of_wikis_being_collaborated
      if current_user == nil
        return nil 
      else
        current_user.collaborations.pluck(:wiki_id)
      end
    end

    def is_wiki_collaborator? (wiki_id)
      wiki_list = []
      current_user.collaborations.each { |wiki|  wiki_list << wiki.wiki_id } if user_signed_in?
      wiki_list.include? wiki_id 
    end
end
