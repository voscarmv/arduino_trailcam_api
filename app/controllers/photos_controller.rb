class PhotosController < ApplicationController
  # before_action :require_authentication
  before_action :set_photo, only: %i[ show update destroy ]
  # before_action :require_camera, only: [ :create ]

  # GET /photos
  def index
    @photos = Current.user.photos.all
    render_success(
      message: "Photos loaded successfully.",
      data: { photos: @photos }
    )  end

  # GET /photos/1
  def show
    render_success(
      message: "Photo retrieved successfully.",
      data: { photo: @photo }
    )
  end

  # POST /photos
  def create
    @photo = Current.user.photos.new(photo_params)

    if @photo.save
      ActionCable.server.broadcast(
        "notifications_#{Current.user.id}",
        { body: "New photo taken!", unviewed_photos_count: Current.user.unviewed_photos_count }
      )
      render_success(
        message: "Photo uploaded.",
        data: {}
      )
    else
      render_error(
        message: "Upload failed.",
        errors: @photo.errors,
        status: :unprocessable_entity
      )
    end
  end

  # PATCH/PUT /photos/1
  def update
    if @photo.update(photo_params)
      render_success(
        message: "Photo updated successfully.",
        data: { photo: @photo }
      )
    else
      render_error(
        message: "Photo update failed.",
        errors: @photo.errors,
        status: :unprocessable_entity
      )
    end
  end

  # DELETE /photos/1
  def destroy
    @photo.destroy!
    render_success(
      message: "Photo deleted successfully.",
      data: {}
    )
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Current.user.photos.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def photo_params
      params.expect(photo: [ :title, :image, :source ])
    end
end
