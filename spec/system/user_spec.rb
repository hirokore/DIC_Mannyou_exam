require 'rails_helper'

describe "ユーザー管理機能" do
  before do
    driven_by(:selenium_chrome_headless)
  end
  describe "新規作成機能" do
    context "ユーザを新規作成した場合" do
      it "作成したタスクが表示される" do
        visit new_user_path
        fill_in "user[name]",	with: "test" 
        fill_in "user[email]",	with: "test@dic.com" 
        fill_in "user[password]",	with: "000000"
        fill_in "user[password_confirmation]",	with: "000000"
        click_on "アカウント作成"
        expect(page).to have_content 'ユーザが作成されました！'        
      end
    end
    context "ユーザがログインせずタスク一覧画面に飛ぼうとした場合" do
      it "ログイン画面に遷移すること" do
        visit tasks_path
        expect(page).to have_content 'Log in'
      end
    end
  end
  describe "セッション機能" do
    let!(:mob1) { FactoryBot.create(:user) }
    let!(:mob2) { FactoryBot.create(:second_user) }
    context "ログインした時" do
      it "ログインができること" do
        visit new_session_path
        fill_in "session[email]",	with: "mob1@dic.com" 
        fill_in "session[password]",	with: "000000"
        click_on "ログイン"
        expect(page).to have_content 'ログインしました'
      end
    end
    context "自分の詳細ページに飛ぼうとした場合" do
      it "詳細ページ画面に遷移すること" do
        visit new_session_path
        fill_in "session[email]",	with: "mob1@dic.com" 
        fill_in "session[password]",	with: "000000"
        click_on "ログイン"
        visit user_path(mob1)
        expect(page).to have_content "#{mob1.name}のページ"
      end
    end
    context "一般ユーザが他人の詳細画面に飛ぼうとした場合" do
      it "タスク一覧画面に遷移すること" do
        visit new_session_path
        fill_in "session[email]",	with: "mob1@dic.com" 
        fill_in "session[password]",	with: "000000"
        click_on "ログイン"
        visit user_path(mob2)
        expect(page).to have_content "不正操作を記録しました。"
      end
    end
    context "ログアウトした場合" do
      it "ログアウトできること" do
        visit new_session_path
        fill_in "session[email]",	with: "mob1@dic.com" 
        fill_in "session[password]",	with: "000000"
        click_on "ログイン"
        click_on "for_test_logout"
        click_on "ログアウト"
        expect(page).to have_content "ログアウトしました!"
      end
    end
  end
  # before do
  #   visit new_session_path
  #   fill_in "session[email]",	with: "root@dic.com" 
  #   fill_in "session[password]",	with: "000000"
  #   click_on "ログイン"
  # end
  describe "セッション機能" do
    let!(:mob1) { FactoryBot.create(:user) }
    let!(:mob2) { FactoryBot.create(:second_user) }
    let!(:root) { FactoryBot.create(:root_user) }
  context "管理者ユーザが管理画面にアクセスした場合" do
      it "アクセスできること" do
        visit new_session_path
        fill_in "session[email]",	with: "root@dic.com" 
        fill_in "session[password]",	with: "000000"
        click_on "ログイン"
        visit admin_users_path
        expect(page).to have_content "管理者ページ"
      end
    end
    context "一般ユーザが管理画面にアクセスした場合" do
      it "アクセスできないこと" do
        visit new_session_path
        fill_in "session[email]",	with: "mob1@dic.com" 
        fill_in "session[password]",	with: "000000"
        click_on "ログイン"
        visit admin_users_path
        expect(page).to have_content "管理者以外はアクセスできません"
      end
    end
    context "管理ユーザがユーザを新規作成した場合" do
      it "ユーザの作成ができること" do
        visit new_session_path
        fill_in "session[email]",	with: "root@dic.com" 
        fill_in "session[password]",	with: "000000"
        click_on "ログイン"
        visit new_admin_user_path
        fill_in "user[name]",	with: "test" 
        fill_in "user[email]",	with: "test@dic.com" 
        fill_in "user[password]",	with: "000000"
        fill_in "user[password_confirmation]",	with: "000000"
        click_on "送信"
        expect(page).to have_content '作成完了'        
      end
    end
    context "管理ユーザがユーザの詳細ページに移動した場合" do
      it "ユーザの詳細ページに遷移できること" do
        visit new_session_path
        fill_in "session[email]",	with: "root@dic.com" 
        fill_in "session[password]",	with: "000000"
        click_on "ログイン"
        visit user_path(mob1)
        expect(page).to have_content "#{mob1.name}のページ"
      end
    end
    context "管理ユーザがユーザを編集した場合" do
      it "ユーザの編集ができること" do
        visit new_session_path
        fill_in "session[email]",	with: "mob1@dic.com" 
        fill_in "session[password]",	with: "000000"
        click_on "ログイン"
        visit user_path(mob2)
        expect(page).to have_content "不正操作を記録しました。"
      end
    end
    context "管理ユーザがユーザを削除した場合" do
      it "ユーザの削除ができること" do
        visit new_session_path
        fill_in "session[email]",	with: "root@dic.com" 
        fill_in "session[password]",	with: "000000"
        click_on "ログイン"
        visit admin_users_path
        click_on :delete_button, match: :first
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "削除完了"
      end
    end
  end
end
