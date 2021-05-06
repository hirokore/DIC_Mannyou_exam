require 'rails_helper'

describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task) }
  before do
    driven_by(:selenium_chrome_headless)
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task_name",	with: "task_test"
        fill_in "task_content",	with: "details_test"
        fill_in "task_expired_at", with: "(002020-04-01).to_date"
        select "未着手", from: "task_status"
        click_on "タスク登録"
        expect(page).to have_content("登録完了")
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'test_first'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        FactoryBot.create(:second_task)
        visit tasks_path
        list = all('.task_list_name')
        expect(list[0]).to have_content 'test_second'
        expect(list[1]).to have_content 'test_first'
      end
    end
    context '終了期限でソートするというリンクを押した場合' do
      it '終了期限が一番遅いタスクが一番上に表示される' do
        FactoryBot.create(:second_task)
        visit tasks_path
        click_on "終了期限でソートする"
        sleep 0.5
        list = all('.task_list_expired_at')
        expect(list[0]).to have_content "2020-04-05"
        expect(list[1]).to have_content "2020-04-01"
      end
    end
    context '優先度でソートするというリンクを押した場合' do
      it '優先度が一番高いタスクが一番上に表示される' do
        FactoryBot.create(:second_task)
        visit tasks_path
        click_on "優先度でソートする"
        sleep 0.5
        list = all('.task_list_priority')
        expect(list[0]).to have_content "高"
        expect(list[1]).to have_content "低"
      end
    end
    context 'タイトル検索をした場合' do
      it 'タイトルで検索できる' do
        FactoryBot.create(:second_task)
        visit tasks_path
        fill_in "task_name", with: "test_f"
        click_on "検索"
        list = all('.task_list_name')
        expect(list[0]).to have_content "test_first"
      end
    end
    context 'ステータス検索をした場合' do
      it 'ステータスで検索できる' do
        FactoryBot.create(:second_task)
        visit tasks_path
        select "未着手", from: "search_status"
        click_on "検索"
        list = all('.task_list_status')
        expect(list[0]).to have_content "未着手"
      end
    end
    context 'タイトルとステータスの両方で検索をした場合' do
      it 'タイトルとステータスの両方で検索できる' do
        FactoryBot.create(:second_task)
        visit tasks_path
        fill_in "task_name", with: "test_first"
        select "未着手", from: "search_status"
        click_on "検索"
        list_name = all('.task_list_name')
        list_status = all('.task_list_status')
        expect(list_name[0]).to have_content "test_first"
        expect(list_status[0]).to have_content "未着手"
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit task_path(task)
        expect(page).to have_content('test_first')
      end
    end
  end
end