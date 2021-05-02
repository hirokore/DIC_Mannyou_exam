require 'rails_helper'

describe 'タスク管理機能', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "Name",	with: "task_test"
        fill_in "Details",	with: "details_test"
        click_on "タスク登録"
        expect(page).to have_content("登録完了")
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, name: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        # ここに実装する
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, name: 'edit_test')
        visit task_path(task)
        expect(page).to have_content('edit_test')
      end
    end
  end
end