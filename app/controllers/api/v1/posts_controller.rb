class Api::V1::PostsController < ApplicationController

  respond_to :json
  def index
    if params[:post_ids]
      posts =  Post.find(params[:post_ids])
    else
      posts =  Post.all
    end
    respond_with posts
  end

  def update
    user = User.find_by(id: params[:user_id])
    post = user.posts.find_by(id: params[:id])

    if post.update(post_params)
      render json: post, status: 200, location: [:api, post]
    else
      render json: { errors: post.errors }, status: 422
    end
  end

  def create
    post = Post.new(post_params)

    if post.save
      render json: post, status: 200, location:[:api, post]
    else
      render json: { errors: post.errors }, status: 422
    end
  end

  def show 
    respond_with Post.find_by(id: params[:id])
  end

  def remove
    user = User.find_by(id: params[:user_id])
    post = user.posts.find_by(id: params[:id])
    
    post.mark_as_removed!
    if post.save
      render json: post, status: 200, location: [:api, post]
    else
      render json: { errors: "Post could not be removed. Please try again" }, status: 422
    end
    
  end

  private 
    def post_params
      # params.require(:post).permit(:description, :image_url, :user_id, :removed, :image_url, :image_data)
      json_data = JSON.parse(request.raw_post)
      params = ActionController::Parameters.new(json_data)

      params = params.require(:post).permit(:description, :image_url, :user_id, :removed, :image_url, :image_data)
      
      params[:image_url] = decode_image_data(params[:image_data])
    end

    def decode_image_data(base64_image_data)
      filename = "post_photo"
      in_content_type, encoding, string = base64_image_data.split(/[:;,]/)[1..3]
      # data = PostUploader.new(Base64.decode64(base64_image_data))

      #create a new tempfile to hold the uploaded photo
      @tempFile = TempFile.new(filename)
      @tempFile.binmode
      @tempfile.write Base64.decode64(string)
      @tempfile.rewind

      #for security, i want to use the actual content type, not just what was passed in.
      content_type = `file --mime -b #{@tempfile.path}`.split(";")[0]

      #i check that an appropriate content_type is passed in, then assign it to the image
      extension = content_type.match(/gif|jpg|jpeg|png/).to_s
      filename += ".#{extension}" if extension #appebd the appropriate extension
    
      ActionDispatch::Http::UploadedFile.new({
        tempfile: @tempfile,
        content_type: content_type,
        filename: filename
      })
    end


    def clean_tempfile
      if @tempFile
        @tempfile.close
        @tempFile.unlink
      end
    end
end
