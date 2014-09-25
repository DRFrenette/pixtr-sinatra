require "sinatra"
if development?
  require "sinatra/reloader" 
end
require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "photo_gallery"
)

class Gallery < ActiveRecord::Base
end

class Image < ActiveRecord::Base
  def secure_url
    url # convert http to https
    name
    description
  end
end

# galleries table
class Gallery < ActiveRecord::Base
end
#
# # images table
class Image < ActiveRecord::Base
end

get "/" do
  @galleries = Gallery.all
  erb :home
end

get "/galleries/new" do
  erb :new_gallery
end

post "/galleries" do
  new_gallery_name = params[:gallery][:name]
  gallery = Gallery.create(name: new_gallery_name)

  # send_file "/galleries/#{params[:file_name]}"
  redirect to("/galleries/#{gallery.id}")
end

get "/galleries/:id/edit" do
  @gallery = Gallery.find(params[:id])
  erb :edit_gallery
end

patch "/galleries/:id" do
  puts params
  id = params[:id]
  gallery = Gallery.find(params[:id])
  gallery.update(params[:gallery])
  redirect(to("/galleries/#{id}"))
end


get "/galleries/:id" do 
  id = params[:id]
  #   gallery = Gallery.where({id: id, name: "stuff", description: "Cool"})
  @gallery = Gallery.find(id)
  @images = Image.where(gallery_id: id)
  
  erb :gallery
end
