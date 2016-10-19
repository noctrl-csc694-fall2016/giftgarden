class DonorsController < ApplicationController
 #----------------------------------#
  # GiftGarden Donors Controller
  # original written by: Andy W, Oct 17 2016
  # major contributions by:
  #         
  #----------------------------------#
 
 # creates new donor object for New Donor screen
  def new
    @donor = Donor.new
  end
  
  # populates Edit Donor screen with data for the correct donor id
  def edit
    @donor = Donor.find(params[:id])
  end
  
  # creates new donor with permitted donor params defined below in private section
  # or renders for again with error messages
  def create
    @donor = Donor.new(donor_params)
    if @donor.save
      # flash[:success] = "Activty added successfully!"
      redirect_to donors_url
    else
      render 'new'
    end
  end
  
  # updates donor information or renders update form again with error messages
  def update
    @donor = Donor.find(params[:id])
    if @donor.update(donor_params)
       redirect_to donors_url
      # flash[:success] = "Donor updated successfully!"
    else
      render 'edit'
    end
  end
  
    
  def import
    Donor.import(params[:file])
    redirect_to root_url, notice: "Donors imported."
  end
  
  # list all donors on index page
  def index
    @donors = Donor.all
    respond_to do |format|
      format.html
        format.pdf do
          pdf = ReportPdf.new(@donors)
          send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
        end
      end
  end
  
  
  
  
  # delete donor
  def destroy
    Donor.find(params[:id]).destroy
    flash[:success] = "Donor deleted."
    redirect_to donors_path
  end
  
  private
    # defines permitted and required parameters for create and update methods
    def donor_params
      params.required(:donor).permit(:first_name, :last_name, :address, :address2, :city,
       :state, :zip, :phone, :email, :notes)
    end
end
