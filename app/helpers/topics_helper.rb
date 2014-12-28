module TopicsHelper
  def topic_params
    params.require(:topic).permit(:title, :description, :topic_id)
  end


end
