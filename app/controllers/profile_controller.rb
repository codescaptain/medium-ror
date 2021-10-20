class ProfileController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.availables
    sql = "
      SELECT
          posts.title as post_name,
          posts.user_id,
        comments.title
      FROM
      posts
      INNER JOIN comments
      ON comments.user_id = posts.user_id
      Where comments.user_id = #{@user.id} AND  comments.accepted = true
    "
 @comments = ActiveRecord::Base.connection.execute(sql)
  end

  def feed
    @posts = current_user.feed.ordered_by_created_at
  end
end
