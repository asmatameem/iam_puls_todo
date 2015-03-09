require 'spec_helper'

describe Todo do
	let(:my_todo) { create(:todo) }
	let(:todos) { create_list(:todo, 10) }

	it "status of todo is false by default" do
		expect(my_todo.status).to be_falsey
    expect(my_todo.complete?).to be_falsey
  end

  it "status is true when status is set" do
  	my_todo.update_attribute(:status, !my_todo.status)
    expect(my_todo.complete?).to be_truthy
  end

  context "scopes" do 
  	before do 
  		todos.drop(7).map! { |todo| todo.update_attribute(:deleted_at, Time.now) }
  	end

  	it "returns all todos that are not deleted" do 
  		expect(Todo.all.count).to eq(10)
  		expect(Todo.all_todos.count).to eq(7)
  	end

  	it "returns only deleted todos" do 
  		expect(Todo.only_deleted.count).to eq(3)
  	end
  end
end
