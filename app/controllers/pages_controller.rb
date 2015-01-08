class PagesController < ApplicationController

  def index
    @pages = Page.order("id")
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new(:parent_id => params[:parent_id])
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      #flash[:success] = "Cтраница добавлена успешно!"
      redirect_to @page
    else
      render 'new'
    end
  end

  def edit
    @page = Page.find_by_id(params[:id])
  end

  def update
    @page = Page.find_by_id(params[:id])
    if @page.update_attributes(params[:page])
     # flash[:success] = "Страница изменена"
      redirect_to @page
    else
      render 'edit'
    end
  end

  def destroy

  end
end
