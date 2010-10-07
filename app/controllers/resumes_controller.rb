class ResumesController < ApplicationController
  # GET /resumes
  # GET /resumes.xml
  def index
    @resumes = Resume.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @resumes }
    end
  end

  # GET /resumes/1
  # GET /resumes/1.xml
  def show
    @resume = Resume.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @resume }
    end
  end

  # GET /resumes/new
  # GET /resumes/new.xml
  def new
    @resume = Resume.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @resume }
    end
  end

  # GET /resumes/1/edit
  def edit
    @resume = Resume.find(params[:id])
  end

  # POST /resumes
  # POST /resumes.xml
  def create
    @resume = Resume.new(params[:resume])

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
  def update
    @resume = Resume.find(params[:id])

    respond_to do |format|
      if @resume.update_attributes(params[:resume])
        format.html { redirect_to(@resume, :notice => 'Resume was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resume.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /resumes/1
  # DELETE /resumes/1.xml
  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy

    respond_to do |format|
      format.html { redirect_to(resumes_url) }
      format.xml  { head :ok }
    end
  end
  
  # GET /resumes/1/html
  def html
    @resume = Resume.find(params[:id])
	#@html_resume = RDiscount.new(@resume.content).to_html				# Markdown only. C binary. Fast
	#@html_resume = RedCloth.new(@resume.content).to_html				# Textile. C binary. Fast
	@html_resume = Kramdown::Document.new(@resume.content).to_html		# MArkdown extensions. Pure ruby. Slow
  end
  
  # GET /resumes/1/pdf
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