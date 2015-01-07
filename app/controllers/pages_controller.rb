class PagesController < ApplicationController

  def index

  end

  def show

  end

  def new
    @page = Page.new
  end

  def add
    @page = Page.new(page_params)
    if @page.save
      flash[:success] = "Cтраница добавлена успешно!"
      redirect_to @page
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @page.update_attributes(page_params)
      flash[:success] = "Страница изменена"
      redirect_to @page
    else
      render 'edit'
    end
  end

  private

  def page_params
    params.require(:page).permit(:name, :title, :content, :parent_id)
  end
end
