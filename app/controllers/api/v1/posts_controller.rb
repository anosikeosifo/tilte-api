class Api::V1::PostsController < ApplicationController
  before_action :set_user, only: [:remove, :update, :favorite]
  before_action :set_post, only: [:favorite, :remove]

  respond_to :json
  def index
    if params[:post_ids]
      posts =  Post.find(params[:post_ids]).order(created_at: :desc).includes(:user, :comments)
    elsif params[:user_id]
      posts = Post.order(created_at: :desc).where(user_id: params[:user_id])
    else
      posts =  Post.order(created_at: :desc).includes(:user, :comments)
    end
    render json: { success: true, data: ActiveModel::ArraySerializer.new(posts), message: "" }
  end

  def update
    post = @user.posts.find_by(id: params[:id])

    if post.update(post_params)
      render json: { success: true, data: post, message: "" }, status: 200, location: [:api, post]
      # render json: post, status: 200, location: [:api, post]
    else
      # render json: { errors: post.errors }, status: 422
      render json: { success: false, data: "", message: post.errors.full_messages.to_sentence }, status: 422, location: [:api, post]
    end
  end

  def create
    post = Post.new(convert_data_uri_to_upload(post_params))
    post.image_url = "https://s3-eu-west-1.amazonaws.com/tilteposts#{post.image.url}"

    if post.save
      render json: { success: true, data: post, message: "" }, status: 200, location: [:api, post]
      # render json: post, status: 200, location:[:api, post]
    else
      render json: { success: false, data: "", message: post.errors.full_messages.to_sentence }, status: 422, location: [:api, post]
      # render json: { errors: post.errors }, status: 422
    end
  end

  def show
    post = Post.includes(:user, :comments).find_by(id: params[:id])
    render json: { success: true, data: PostSerializer.new(post), status: 200 }
  end

  def remove
    @user.posts.find_by(id: params[:id]).mark_as_removed!
    if post.save
      render json: { success: true, data: post, message: "" }, status: 200, location: [:api, post]
      #render json: post, status: 200, location: [:api, post]
    else
      render json: { errors: "Post could not be removed. Please try again" }, status: 422
    end
  end

  def favorite
    favorite = @user.favorites.create(post_id: @post.id)
    if favorite.valid?
      @post = Post.find(@post.id)
      render json: { success: true, data: PostSerializer.new(@post), message: "" }, status: 200
    else
      render json: { success: false, data: "", message: favorite.errors.full_messages.to_sentence }, status: 422
    end
  end

  private

    def split_base64(uri_str)
      if uri_str.match(%r{^data:(.*?);(.*?),(.*)$}m)
        uri = Hash.new
        uri[:type] = $1 #gets the image/jpg part of the image
        uri[:encoder] = $2 #base64
        uri[:data] = $3 #data string
        uri[:extension] = $1.split('/')[1]
        logger.info"uri[:data]: #{uri[:data]}"
        return uri
      else
        nil
      end
    end

    def convert_data_uri_to_upload(post_hash)
      if post_hash[:image_url].try(:match, %r{^data:(.*?);(.*?),(.*)$}m)
        image_data = split_base64(post_hash[:image_url])
        image_data_string = image_data[:data]
        logger.info "image_data_string: #{image_data_string}"
        image_data_binary = Base64.decode64(image_data_string) #.force_encoding('UTF-8').encode

        temp_img_file = Tempfile.new("")
        temp_img_file.binmode #sets the image file to binary mode
        temp_img_file.write(image_data_binary)
        temp_img_file.rewind

        img_params = { filename: "image.#{image_data[:extension]}", type:
        image_data[:type], tempfile: temp_img_file }
        uploaded_file = ActionDispatch::Http::UploadedFile.new(img_params)

        logger.info "uploaded_file: #{uploaded_file}"
        post_hash[:image] = uploaded_file
        post_hash.delete(:image_url)
      end
      post_hash
    end

    private
      def set_user
        @user = user = User.find(params[:user_id])
      end

      def set_post
        Post.signed_in_user = @user
        @post = Post.find(params[:post_id])
      end

      def post_params
        params.require(:post).permit(:description, :image_url, :user_id, :removed, :image)
      end
end
