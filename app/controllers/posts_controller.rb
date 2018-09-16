class PostsController < ApplicationController
    before_action :require_signin, only: [:new, :create]

    def new
        @post = Post.new
    end

    def index
        @posts = Post.paginate(page: params[:page], per_page: 10)
    end

    def create
      @post = Post.new(content: params[:post][:content], author_id: get_current_user.id) 
      if @post.save
          redirect_to posts_url          
      else
        flash[:danger] = "Could not create post"
        render 'new'
      end
    end

    private

        # before filter
        
        def require_signin
            unless signed_in? 
                flash[:danger] = "You must be logged in to access this page."
                redirect_to signin_path
            end
        end

end
