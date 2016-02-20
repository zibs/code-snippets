class SnippetsController < ApplicationController
  before_action :find_snippet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @snippets = Snippet.recent(10).page(params[:page]).per(10)
  end

  def new
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.new(snippet_params)
    @snippet.user = current_user
      if @snippet.save
        redirect_to snippets_path(@snippet), flash: { success: "Snipped!"}
      else
        flash[:danger] = "Snippet Failure ..."
        render :new
      end
  end

  def show
  end

  def edit
  end

  def update
    if @snippet.update(snippet_params)
      redirect_to(snippet_path(@snippet), flash: { success:  "Snippet Updated"})
    else
      flash[:warning] = "Snippet was not successful"
      render :edit
    end
  end

  def destroy
    snippet = current_user.snippets.find(params[:id])
    snippet.destroy
    redirect_to((root_path), flash: { danger: "Snippet Removed!" })
  end

  private

    def snippet_params
      params.require(:snippet).permit([:kind, :title, :code, :private])
    end

    def find_snippet
      @snippet = Snippet.find(params[:id])
    end

    def authorize_user
      unless can? :manage, @snippet
      redirect_to root_path , flash: { info: "Access Denied" }
      end
    end



end
