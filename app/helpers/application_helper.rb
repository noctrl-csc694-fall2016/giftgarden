module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Gift Garden"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # Returns random artwork file name
  def random_artwork
    images = [ "assets/images/art/bee1.jpg", "assets/images/art/butterfly1.jpg", 
          "assets/images/art/butterfly2.jpg", "assets/images/art/dragonfly1.jpg",
          "assets/images/art/flower1.jpg", "assets/images/art/flower2.jpg",
          "assets/images/art/flower3.jpg", "assets/images/art/flower4.jpg",
          "assets/images/art/flower5.jpg", "assets/images/art/flower6.jpg",
          "assets/images/art/flower7.jpg", "assets/images/art/flower8.jpg",
          "assets/images/art/ladybug1.jpg" ]
    images[rand(images.size)]
  end
end
