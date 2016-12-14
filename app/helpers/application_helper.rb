module ApplicationHelper

  # Global variables for current version and deploy date strings
  # I got some nice class variable help here:
  # http://www.railstips.org/blog/archives/2006/11/18/class-and-instance-variables-in-ruby/

  @@gift_garden_version = "V1.0"    # major GG version
  def ApplicationHelper.gift_garden_version
    @@gift_garden_version
  end

  @@gift_garden_version_detailed = "V1.0-beta2"   # detailed GG version
  def ApplicationHelper.gift_garden_version_detailed
    @@gift_garden_version_detailed
  end

  @@gift_garden_deploy_date = "Dec 25, 2016"    # deploy date for GG
  def ApplicationHelper.gift_garden_deploy_date
    @@gift_garden_deploy_date
  end


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
