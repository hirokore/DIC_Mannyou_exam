require 'rails_helper'

describe "ラベル機能" do
  before do
    driven_by(:selenium_chrome_headless)
  end
  describe "一般ユーザー" do
    let!(:mob1) { FactoryBot.create(:user) }
    let!(:mob2) { FactoryBot.create(:second_user) }
    context "ラベル作成をした時" do
      it "ラベルが作成され、ユーザー詳細画面に出力されること" do
        visit new_session_path
        fill_in "session[email]",	with: "mob1@dic.com" 
        fill_in "session[password]",	with: "000000"
        click_on "ログイン"
        click_on "for_test_logout"
        click_on "ラベル作成"
        fill_in "label[name]",	with: "label_test" 
        click_on "commit"
        expect(page).to have_content 'label_test'
      end
    end
    context "タスクを登録しようとした場合" do
      it "作成したラベルが使用できること" do
        visit new_session_path
        fill_in "session[email]",	with: "mob1@dic.com" 
        fill_in "session[password]",	with: "000000"
        click_on "ログイン"
        click_on "for_test_logout"
        click_on "ラベル作成"
        fill_in "label[name]",	with: "label_test" 
        click_on "commit"
        visit new_session_path
        fill_in "session[email]",	with: "mob1@dic.com" 
        fill_in "session[password]",	with: "000000"
        click_on "ログイン"
        click_on "for_test_logout"
        click_on "ラベル作成"
        fill_in "label[name]",	with: "label_test2" 
        click_on "commit"
        visit new_task_path
        fill_in "task_name",	with: "task_test"
        fill_in "task_content",	with: "details_test"
        fill_in "task_expired_at", with: "(002020-04-01).to_date"
        select "未着手", from: "task[status]"
        select "低", from: "task[priority]"
        find('label', text: 'label_test', match: :first).click
        click_on "タスク登録"
        expect(page).to have_content("label_test")
      end
    end
    context "タスクを編集する場合" do
      it "ラベルも変更できること" do
        visit new_session_path
        fill_in "session[email]",	with: "mob1@dic.com" 
        fill_in "session[password]",	with: "000000"
        click_on "ログイン"
        click_on "for_test_logout"
        click_on "ラベル作成"
        fill_in "label[name]",	with: "label_test" 
        click_on "commit"
        visit new_session_path
        fill_in "session[email]",	with: "mob1@dic.com" 
        fill_in "session[password]",	with: "000000"
        click_on "ログイン"
        click_on "for_test_logout"
        click_on "ラベル作成"
        fill_in "label[name]",	with: "label_test2" 
        click_on "commit"
        visit new_task_path
        fill_in "task_name",	with: "task_test"
        fill_in "task_content",	with: "details_test"
        fill_in "task_expired_at", with: "(002020-04-01).to_date"
        select "未着手", from: "task[status]"
        select "低", from: "task[priority]"
        find('label', text: 'label_test', match: :first).click
        click_on "タスク登録"
        click_on "編集"
        find('label', text: 'label_test2', match: :first).click
        expect(page).to have_content("label_test2")
      end
    end
    context "ラベルを検索した場合" do
      it "ラベルが確認できること" do
        visit new_session_path
        fill_in "session[email]",	with: "mob1@dic.com" 
        fill_in "session[password]",	with: "000000"
        click_on "ログイン"
        click_on "for_test_logout"
        click_on "ラベル作成"
        fill_in "label[name]",	with: "label_test" 
        click_on "commit"
        visit new_session_path
        fill_in "session[email]",	with: "mob1@dic.com" 
        fill_in "session[password]",	with: "000000"
        click_on "ログイン"
        click_on "for_test_logout"
        click_on "ラベル作成"
        fill_in "label[name]",	with: "label_test2" 
        click_on "commit"
        visit new_task_path
        fill_in "task_name",	with: "task_test"
        fill_in "task_content",	with: "details_test"
        fill_in "task_expired_at", with: "(002020-04-01).to_date"
        select "未着手", from: "task[status]"
        select "低", from: "task[priority]"
        find('label', text: 'label_test', match: :first).click
        click_on "タスク登録"
        visit new_task_path
        fill_in "task_name",	with: "task_test"
        fill_in "task_content",	with: "details_test"
        fill_in "task_expired_at", with: "(002020-04-01).to_date"
        select "未着手", from: "task[status]"
        select "低", from: "task[priority]"
        find('label', text: 'label_test2', match: :first).click
        click_on "タスク登録"
        select "label_test", from: "search_label_id"
        click_on "ラベル検索"
        expect(page).to have_content("label_test")
      end
    end
  #   context "ログアウトした場合" do
  #     it "ログアウトできること" do
  #       visit new_session_path
  #       fill_in "session[email]",	with: "mob1@dic.com" 
  #       fill_in "session[password]",	with: "000000"
  #       click_on "ログイン"
  #       click_on "for_test_logout"
  #       click_on "ログアウト"
  #       expect(page).to have_content "ログアウトしました!"
  #     end
  #   end
  # end
  # describe "管理ユーザー" do
  #   let!(:mob1) { FactoryBot.create(:user) }
  #   let!(:mob2) { FactoryBot.create(:second_user) }
  #   let!(:root) { FactoryBot.create(:root_user) }
  #   context "管理者ユーザが管理画面にアクセスした場合" do
  #     it "アクセスできること" do
  #       visit new_session_path
  #       fill_in "session[email]",	with: "root@dic.com" 
  #       fill_in "session[password]",	with: "000000"
  #       click_on "ログイン"
  #       visit admin_users_path
  #       expect(page).to have_content "管理者ページ"
  #     end
  #   end
  #   context "一般ユーザが管理画面にアクセスした場合" do
  #     it "アクセスできないこと" do
  #       visit new_session_path
  #       fill_in "session[email]",	with: "mob1@dic.com" 
  #       fill_in "session[password]",	with: "000000"
  #       click_on "ログイン"
  #       visit admin_users_path
  #       expect(page).to have_content "管理者以外はアクセスできません"
  #     end
  #   end
  #   context "管理ユーザがユーザを新規作成した場合" do
  #     it "ユーザの作成ができること" do
  #       visit new_session_path
  #       fill_in "session[email]",	with: "root@dic.com" 
  #       fill_in "session[password]",	with: "000000"
  #       click_on "ログイン"
  #       visit new_admin_user_path
  #       fill_in "user[name]",	with: "test" 
  #       fill_in "user[email]",	with: "test@dic.com" 
  #       fill_in "user[password]",	with: "000000"
  #       fill_in "user[password_confirmation]",	with: "000000"
  #       click_on "送信"
  #       expect(page).to have_content '作成完了'        
  #     end
  #   end
  #   context "管理ユーザがユーザの詳細ページに移動した場合" do
  #     it "ユーザの詳細ページに遷移できること" do
  #       visit new_session_path
  #       fill_in "session[email]",	with: "root@dic.com" 
  #       fill_in "session[password]",	with: "000000"
  #       click_on "ログイン"
  #       visit user_path(mob1)
  #       expect(page).to have_content "#{mob1.name}のページ"
  #     end
  #   end
  #   context "管理ユーザがユーザを編集した場合" do
  #     it "ユーザの編集ができること" do
  #       visit new_session_path
  #       fill_in "session[email]",	with: "mob1@dic.com" 
  #       fill_in "session[password]",	with: "000000"
  #       click_on "ログイン"
  #       visit user_path(mob2)
  #       expect(page).to have_content "不正操作を記録しました。"
  #     end
  #   end
  #   context "管理ユーザがユーザを削除した場合" do
  #     it "ユーザの削除ができること" do
  #       visit new_session_path
  #       fill_in "session[email]",	with: "root@dic.com" 
  #       fill_in "session[password]",	with: "000000"
  #       click_on "ログイン"
  #       visit admin_users_path
  #       click_on :delete_button, match: :first
  #       page.driver.browser.switch_to.alert.accept
  #       expect(page).to have_content "削除完了"
  #     end
  #   end
  end
end
