#~ require 'rubygems'
#~ require 'gosu'

# Class reponsible of loading images when game start in order
# to avoid to have multiple instances of a same original image.
class ImagesLoader
  
  def initialize(window)
    @window = window
    @images = {}
    
    # Load all PNG images in media
    Dir["media/*.png"].each do |filename_with_ext|
      # "media/toto.png" => "toto"
      filename = filename_with_ext[6...-4]
      @images[filename.to_sym] = Image.new(window, "#{filename_with_ext}", false)
    end
    
    puts "===================="
    puts "ImageLoader content:"
    puts "--------------------"
    @images.each do |k, v|
      puts "#{k}"
    end
    puts ""
  end
  
  def get_image(id_name)
    if @images.has_key? id_name.to_sym
      @images[id_name.to_sym]
    else
      puts "No image for #{id_name}!!!"
    end
  end
  
end