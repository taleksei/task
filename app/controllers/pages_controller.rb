class PagesController < ApplicationController

  def index
    @pages = Page.order("id")
  end

  def show
    @page = Page.find(params[:id])
    #только для отображения содержимого поля content ввиде HTML-разметки
    @page.content = to_show(@page.content)
  end

  def new
    #присвоение parent_id необходимо для создания иерархической структуры страниц
    @page = Page.new(:parent_id => params[:id])
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      redirect_to @page
    else
      render 'new'
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attribute( :content , params[:page][:content] ) &&
        @page.update_attribute( :title , params[:page][:title] )
      redirect_to @page
    else
      render 'edit'
    end
  end

  def destroy

  end

  #преобразование служебных символов к HTML-разметке
  def to_show(content)
    content.gsub(/\\\\([^\\]+)\\\\/, '<b>\1</b>').gsub(/\*\*([^\*]+)\*\*/, '<i>\1</i>')
        .gsub(/\(\((\S*)\s+([^\)]+)\)\)/, '<a href="'+root_url+'\1">\2</a>')
  end
end
