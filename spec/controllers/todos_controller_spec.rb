require 'spec_helper'

describe TodosController do
	let(:my_todo) { create(:todo) }
	let(:todo_list)  { create_list(:todo, 10) }

	context "When creating todos" do 
		it "creates todo with given parameters" do 
			post :create, { todo: { title: "My Title", description: "My todo description" } }
			expect(response).to redirect_to(todos_path)
			expect(flash[:notice]).to eq("Todo was successfully created.") 

			todo = assigns(:todo) 
			expect(todo).to be_persisted
			expect(todo.title).to eq("My Title")
			expect(todo.description).to eq("My todo description")
			expect(todo.status).to be_falsey
		end

		it "creates todo taking only valid parameters" do 
			post :create, { todo: { title: "My Title", extra_param: "Something extra" } }
			expect(response).to redirect_to(todos_path)

			todo = assigns(:todo) 
			expect(todo).to be_persisted
			expect(todo.title).to eq("My Title")
			expect(todo.respond_to?(:extra_param)).to be_falsey
		end
	end

	context "when assigning new todos" do 
		it "assigns a new todo_list as @todo_list" do
      get :new
      expect(assigns(:todo)).to be_a_new(Todo)
      expect(response).to have_rendered("todos/new")
    end
	end

	context "when getting todos" do
		before do 
			expect(todo_list.count).to eq(Todo.count)
		end

		it "gets all the todos that are not deleted" do 
			get :index
			expect(response).to be_success
			todos = assigns(:todos)

			expect(todos.count).to eq(10)
			expect(todos).to eq(todo_list)
		end

		context "when one of the todo is destroyed" do 
			before do 
				todo_item = todo_list.last
				todo_item.update_attribute(:deleted_at, Time.now)
			end

			it "gets all the todos that are not deleted" do 
				get :index
				expect(response).to be_success
				expect(assigns(:todos).count).to eq(9)
			end
		end

		it "gets details of a todo" do 
			get :show, id: my_todo.id
			expect(response).to be_success

			todo = assigns(:todo)
			expect(todo.id).to eq(my_todo.id)
			expect(todo.title).to eq(my_todo.title)
			expect(todo.description).to eq(my_todo.description)
			expect(todo.deleted_at).to be_nil
			expect(todo.status).to be_falsey
		end
	end

	context "when updating todos" do
		it "updates attributes of a todo" do 
			put :update, id: my_todo.id, todo: { title: "New Title" }
			expect(response).to redirect_to(todos_path)
			expect(flash[:notice]).to eq("Todo was successfully updated.") 

			todo = assigns(:todo)
			expect(todo.id).to eq(my_todo.id)
			expect(todo.title).to eq("New Title")
		end

		it "marks todo as complete" do 
			put :complete, id: my_todo.id
			expect(response).to redirect_to(todos_path)
			expect(flash[:notice]).to eq("Todo item marked as complete.") 

			todo = assigns(:todo)
			expect(todo.id).to eq(my_todo.id)
			expect(todo.status).to be_truthy
		end

		context "when updating a deleted todo" do 
			before do 
				my_todo.update_attribute(:deleted_at, Time.now)
			end

			it "errors when trying to update a deleted todo" do 
				expect {
        	put :update, id: my_todo.id
      	}.to raise_exception
			end
		end
	end

	context "When editing todos" do 
		it "assigns the requested todo" do
      get :edit, id: my_todo.id
      expect(assigns(:todo)).to eq(my_todo)

      expect(response).to have_rendered("todos/edit")
    end
	end

	context "when deleting todos" do 
		it "marks todo as deleted, but does not delete from db" do 
			delete :destroy, id: my_todo.id 
			expect(response).to redirect_to(todos_url)

			my_todo.reload 

			expect(my_todo).to be_persisted 
			expect(my_todo.deleted_at).to_not be_nil
		end
	end

end
