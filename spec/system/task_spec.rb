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
        task_list = all('.task_list')
        expect(task_list[0]).to have_content 'test_second'
        expect(task_list[1]).to have_content 'test_first'
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