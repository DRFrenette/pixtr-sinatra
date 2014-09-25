require "sinatra"
if development?
  require "sinatra/reloader" 
end
require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "photo_gallery"
)

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
  Gallery.create(name: new_gallery_name)

  redirect to("/")
end

get "/galleries/:id" do 
  id = params[:id]
  #   gallery = Gallery.where({id: id, name: "stuff", description: "Cool"})
  gallery = Gallery.find(id)
  @name = gallery.name
  @images = Image.where(gallery_id: id)
  erb :gallery


end
# end
#
