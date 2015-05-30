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
    post = Post.new(convert_data_uri_to_upload(post_params))
    logger.info "New post: #{post.inspect}"
    if post.save
      render json: post, status: 200, location:[:api, post]
    else
      logger.error "could not create post: #{post.errors.full_messages.to_sentence}"
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

    def split_base64(uri_str)
      if uri_str.match(%r{^data:(.*?);(.*?),(.*)$})
        uri = Hash.new
        uri[:type] = $1 #gets the image/jpg part of the image
        uri[:encoder] = $2 #base64
        uri[:data] = $3 #data string
        uri[:extension] = $1.split('/')[1]

        return uri
      else
        nil
      end
    end

    def convert_data_uri_to_upload(post_hash)
      if post_hash[:image_url].try(:match, %r{^data:(.*?);(.*?),(.*)$} )
        image_data = split_base64(post_hash[:image_url])
        image_data_string = image_data[:data]
        image_data_binary = Base64.decode64(image_data_string)

        temp_img_file = Tempfile.new("")
        temp_img_file.binmode #sets the image file to binary mode
        temp_img_file << image_data_binary
        temp_img_file.rewind

        img_params = { filename: "image.#{image_data[:extension]}", type: image_data[:type], tempfile: temp_img_file }
        uploaded_file = ActionDispatch::Http::UploadedFile.new(img_params)

        post_hash[:image] = uploaded_file
        post_hash.delete(:image_url)
      end
      post_hash
    end

    def post_params
      params.require(:post).permit(:description, :image_url, :user_id, :removed, :image_url, :image)
    end

    # def decode_image_data(base64_image_data)
    #   filename = "post_photo"
    #   in_content_type, encoding, string = base64_image_data.split(/[:;,]/)[1..3] 
    #   # data = PostUploader.new(Base64.decode64(base64_image_data))

    #   #create a new tempfile to hold the uploaded photo
    #   @tempfile = Tempfile.new(filename)
    #   @tempfile.binmode
    #   @tempfile.write Base64.decode64(string)
    #   @tempfile.rewind

    #   #for security, i want to use the actual content type, not just what was passed in.
    #   content_type = `file --mime -b #{@tempfile.path}`.split(";")[0]

    #   #i check that an appropriate content_type is passed in, then assign it to the image
    #   extension = content_type.match(/gif|jpg|jpeg|png/).to_s
    #   filename += ".#{extension}" if extension #appebd the appropriate extension
    
    #   ActionDispatch::Http::UploadedFile.new({
    #     tempfile: @tempfile,
    #     content_type: content_type,
    #     filename: filename
    #   })
    # end

    # def clean_tempfile
    #   if @tempFile
    #     @tempfile.close
    #     @tempFile.unlink
    #   end
    # end
end
