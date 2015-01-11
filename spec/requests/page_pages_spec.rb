require 'spec_helper'

describe "Page requests" do
  include Rails.application.routes.url_helpers

  subject { page }

  describe "index" do
    let(:page) { FactoryGirl.create(:page) }
    before(:each) do
      visit pages_path
    end

    it { should have_title('Path 1') }
    it { should have_content('Все страницы') }
    it { should have_link('Создать страницу') }
  end

  describe "new page" do
    before { visit 'add' }

    it { should have_content('Новая страница') }
    it { should have_link('Сохранить') }
  end

  describe "new page" do

    before { visit 'add' }

    let(:submit) { "Сохранить" }

    describe "with invalid information" do
      it "should not create a page" do
        expect { click_button submit }.not_to change(Page, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "RootPage1"
        fill_in "Title",        with: "Главная страница"
        fill_in "Content",     with: "Содержание"
      end

      it "should create a page" do
        expect { click_button submit }.to change(Page, :count).by(1)
      end

      describe "after saving the page" do
        before { click_button submit }

        it { should have_link('Создать подстраницу') }
        it { should have_link('Редактировать') }
        it { should have_selector('h1', text: 'Главная страница') }
      end
    end
  end

  describe "edit" do
    let(:page) { FactoryGirl.create(:page) }
    before { visit edit_page_path(page) }

    describe "page" do
      it { should have_content("Заголовок") }
      it { should have_content("Содержание") }
      it { should have_selector('h1', text: 'Главная страница') }
      it { should have_link('Сохранить') }
    end

    describe "with valid information" do
      let(:new_title)  { "New Name" }
      let(:new_content) { "new content" }
      before do
        fill_in "Title",             with: new_title
        fill_in "Content",           with: new_content
        click_button "Сохранить"
      end

      it { should have_selector('h1', text: "New Name") }
      it { should have_link('Создать подстраницу') }
      it { should have_link('Редактировать') }
    end
  end
end