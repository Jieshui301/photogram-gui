class PhotosController < ApplicationController
  def index
    matching_photos = Photo.all
    @list_of_photos = matching_photos.order({ :created_at => :desc })
    render({ :template => "photos_templates/index" })
  end

  def show
    url_photo_id = params.fetch("path_id")

    matching_photo_id = Photo.where({ :id => url_photo_id })

    @the_photo = matching_photo_id.at(0)

    #if @the_user == nil
      #redirect_to("/404")
    #else
    render({ :template => "photos_templates/show" })
    #end
  end

  def delete
    the_id = params.fetch("path_id")
    matching_photos = Photo.where({ :id => the_id})
    the_photo = matching_photos.at(0)
    the_photo.destroy
    redirect_to("/photos")
  end

  def create
    p = Photo.new
    p.image = params.fetch("input_image")
    p.caption = params.fetch("input_caption")
    p.owner_id = params.fetch("input_owner_id")
    p.save
    redirect_to("/photos/" + p.id.to_s)
  end  

  def update
    the_id = params.fetch("path_id")
    matching_photos = Photo.where({ :id => the_id})
    the_photo = matching_photos.at(0)
    the_photo.image = params.fetch("input_image")
    the_photo.caption = params.fetch("input_caption")
    the_photo.save
    redirect_to("/photos/" + the_photo.id.to_s)
  end
end
