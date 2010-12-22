class ResumesController < ApplicationController

  before_filter :authenticate_user!, :except => [:html, :pdf, :edit, :update]
  
  # GET /resumes
  # GET /resumes.xml
  def index
    @resumes = current_user.resumes.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @resumes }
    end
  end

  # GET /resumes/1
  # GET /resumes/1.xml
  def show
    @resume = current_user.resume.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @resume }
    end
  end

  # GET /resumes/new
  # GET /resumes/new.xml
  def new
    @resume = current_user.resume.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @resume }
    end
  end

  # GET /resumes/1/edit
  # This method is open for unauthenticated users also, 
  # only demo resumes can be accessed/edited without authentication
  # This is slightly insecure as one demo user can access/edit another demo user's resumes. But that's by design
  def edit
    user = demo? ? admin : current_user
    @resume = user.resumes.find(params[:id])
    @style = @resume.style || default_style
    render :layout => "demo"  if demo?
  end

  # POST /resumes
  # POST /resumes.xml
  def create
    @resume = current_user.resume.new(params[:resume])

    respond_to do |format|
      if @resume.save
        format.html { redirect_to(@resume, :notice => 'Resume was successfully created.') }
        format.xml  { render :xml => @resume, :status => :created, :location => @resume }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @resume.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /resumes/1
  # PUT /resumes/1.xml
  # This method is open for unauthenticated users also, 
  # only demo resumes can be updated without authentication
  # This is slightly insecure as one demo user can update another demo user's resumes. But that's by design
  def update
    user = demo? ? admin : current_user
    @resume = user.resumes.find(params[:id])
    @resume.update_count += 1

    respond_to do |format|
      if @resume.update_attributes(params[:resume])
        format.html { 
          redirect_to(html_resume_path(@resume), :notice => 'updated')         
        }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resume.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /resumes/1
  # DELETE /resumes/1.xml
  # Note that there is no unauthenticated access for this action - 
  #  unauthenticated users can't destroy their own demo resumes also. That's by design.
  def destroy
    @resume = current_user.resume.find(params[:id])
    @resume.destroy

    respond_to do |format|
      format.html { redirect_to(resumes_url) }
      format.xml  { head :ok }
    end
  end
  
  # GET /resumes/1/html
  # Unless otherwise configured (TODO), this method is accessible to unauthenticated users - publically visible.
  def html
    @resume = Resume.find(params[:id])
	  #@html_resume = RDiscount.new(@resume.content).to_html				# Markdown only. C binary. Fast
	  #@html_resume = RedCloth.new(@resume.content).to_html				# Textile. C binary. Fast
	  @html_resume = Kramdown::Document.new(@resume.content).to_html		# MArkdown extensions. Pure ruby. Slow
    render :layout => "output"
  end
  
  # GET /resumes/1/pdf
  # Unless otherwise configured (TODO), this method is accessible to unauthenticated users - publically visible.
  def pdf
    @resume = Resume.find(params[:id])
    html = Kramdown::Document.new(@resume.content).to_html
    kit = PDFKit.new(html, :page_size => 'Letter')
    pdf = kit.to_pdf
    
    file_path = "#{RAILS_ROOT}/tmp/#{@resume.id}.pdf"
    file = kit.to_file(file_path)
    send_file file_path,  :type => 'pdf', :disposition => 'inline'
  end
    
end