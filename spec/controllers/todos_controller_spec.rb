require 'spec_helper'

describe TodosController do
	let(:todo) { create(:todo) }

	context "when getting todos" do
		before do 
			create_list(:todo, 10)
		end

		it "gets all the todos that are not deleted" do 
			get :index
			expect(response).to be_success
		end
	end

	context "when updating todos" do 
	end

	context "when deleting todos" do 
	end

end
