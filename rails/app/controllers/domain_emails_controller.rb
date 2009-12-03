class DomainEmailsController < ApplicationController
  # GET /domain_emails
  # GET /domain_emails.xml
  def index
    @domain_emails = DomainEmail.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @domain_emails }
    end
  end

  # GET /domain_emails/1
  # GET /domain_emails/1.xml
  def show
    @domain_email = DomainEmail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @domain_email }
    end
  end

  # GET /domain_emails/new
  # GET /domain_emails/new.xml
  def new
    @domain_email = DomainEmail.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @domain_email }
    end
  end

  # GET /domain_emails/1/edit
  def edit
    @domain_email = DomainEmail.find(params[:id])
  end

  # POST /domain_emails
  # POST /domain_emails.xml
  def create
    @domain_email = DomainEmail.new(params[:domain_email])

    respond_to do |format|
      if @domain_email.save
        flash[:notice] = 'DomainEmail was successfully created.'
        format.html { redirect_to(@domain_email) }
        format.xml  { render :xml => @domain_email, :status => :created, :location => @domain_email }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @domain_email.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /domain_emails/1
  # PUT /domain_emails/1.xml
  def update
    @domain_email = DomainEmail.find(params[:id])

    respond_to do |format|
      if @domain_email.update_attributes(params[:domain_email])
        flash[:notice] = 'DomainEmail was successfully updated.'
        format.html { redirect_to(@domain_email) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @domain_email.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /domain_emails/1
  # DELETE /domain_emails/1.xml
  def destroy
    @domain_email = DomainEmail.find(params[:id])
    @domain_email.destroy

    respond_to do |format|
      format.html { redirect_to(domain_emails_url) }
      format.xml  { head :ok }
    end
  end
end
