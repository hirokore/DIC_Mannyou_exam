require 'rails_helper'

describe 'タスクモデル機能', type: :model do
  let!(:task) { FactoryBot.create(:task, name: 'task', status: '着手中') }
  let!(:second_task) { FactoryBot.create(:second_task, name: "sample", status: '未着手') }
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(name: '', details: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: '失敗テスト', details: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = FactoryBot.create(:task, name: 'task', details: 'detail')
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, name: 'task', status: '着手中') }
    let!(:second_task) { FactoryBot.create(:second_task, name: "sample", status: '未着手') }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.name_like('tas')).to include(task)
        expect(Task.name_like('task')).not_to include(second_task)
        expect(Task.name_like('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status_like('未着手')).to include(second_task)
        expect(Task.status_like('未着手')).not_to include(task)
        expect(Task.status_like('未着手').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.name_status_like('sample','未着手')).to include(second_task)
        expect(Task.name_status_like('sample','未着手')).not_to include(task)
        expect(Task.name_status_like('sample','未着手').count).to eq 1
      end
    end
  end
end