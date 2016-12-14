module ReportsHelper
  include UsersHelper

  # black and white version of Gift Garden logo used in reports
  # I got some nice class variable help here:
  # www.railstips.org/blog/archives/2006/11/18/class-and-instance-variables-in-ruby/
  @@report_logo = "#{Rails.root}/app/assets/images/custom-logo-bw.png"
  def ReportsHelper.report_logo
    @@report_logo
  end

  # Retrieve the current user object
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
