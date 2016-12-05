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
  def random_artwork_icon
    images = [ "icons/bee1_square.png", "icons/butterfly1_square.png", 
          "icons/butterfly2_square.png", "icons/dragonfly1_square.png",
          "icons/flower1_square.png", "icons/flower2_square.png",
          "icons/flower3_square.png", "icons/flower4_square.png",
          "icons/flower5_square.png", "icons/flower6_square.png",
          "icons/flower7_square.png", "icons/flower8_square.png",
          "icons/ladybug1_square.png" ]
    images[rand(images.size)]
  end
end
