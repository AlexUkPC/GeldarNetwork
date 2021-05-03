class PostsController < ApplicationController
  def create
    is_posted = Post::Creator.call(
    current_user,
    permitted_params
    )
    unless is_posted
    flash[:alert] = "Something went wrong"
    end

    redirect_back fallback_location: timelines_path
  end
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to timelines_url, notice: "Post was successfully deleted." }
      format.json { head :no_content }
    end
  end
  private
    def permitted_params
        params.require(:post).permit(
        :postable_type,
        :status_text,
        :sight_place_id,
        :thread_id,
        :pictures => [],
        )
    end
end
