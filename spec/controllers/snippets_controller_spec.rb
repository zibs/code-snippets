require 'rails_helper'

RSpec.describe SnippetsController, type: :controller do
  let(:user){create(:user)}
  let(:snippet){create(:snippet)}

  describe "#create" do

    context "authenticated user" do
      before {log_in(user)}
      let(:snippet_attrs){attributes_for(:snippet)}

      def valid_post_request
        post :create, { snippet: snippet_attrs }
      end

      it "creates a record in the DB" do
        expect{valid_post_request}.to change{Snippet.count}.by(1)
      end

      it "associates the created record with the user" do
        valid_post_request
        expect(Snippet.first.user).to eq(user)
      end

    end
    context "unauthenticated user" do
      let(:snippet_attrs){attributes_for(:snippet)}

      def invalid_post_request
        post :create, { snippet: snippet_attrs }
      end

      it "doesn't save a record to the database" do
        expect{invalid_post_request}.to_not change{Snippet.count}
      end

      it "redirects to the sign in page" do
        invalid_post_request
        expect(response).to redirect_to(new_session_path)
      end
    end

  end

  describe "#update" do
    context "authenticated user" do
      before { log_in(user) }

      let!(:snippet){ create(:snippet, {kind: "Ruby", user: user})}

      context "with authorized user" do

        it "should update the record in the DB" do
          patch :update, id: snippet, snippet: {kind: "JavaScript"}
          expect(snippet.reload.kind).to eq("JavaScript")
        end

        it "should redirect to the snippet show page" do
          patch :update, id: snippet, snippet: {title: "1ababab"}
          expect(response).to redirect_to(snippet)
        end

      end

      context "with unauthorized user" do
        let!(:user_two){create(:user)}
        let!(:snippet){ create(:snippet, {title: "123123", user: user_two})}

        it "should not update the record in the databse" do
          patch :update, id: snippet, snippet: {title: "1ababab"}
          expect(snippet.reload.title).to eq("123123")
        end
      end

    end

    context "unauthenticated" do
      let!(:snippet){ create(:snippet) }

      it "redirects to the sign in page" do
        patch :update, id: snippet, snippet: {title: "123123123"}
        expect(response).to redirect_to(new_session_path)
      end
    end

  end

  describe "#destroy" do
    context "with authenticated user" do
      before { log_in(user) }

      context "with authorized user"
        let!(:snippet){create(:snippet, {user: user})}
        def valid_delete_request
          delete :destroy, id: snippet
        end

        it "should remove snippet from the DB" do
          expect{valid_delete_request}.to change{Snippet.count}.by(-1)
        end

        it "should redirect to the homepage" do
          valid_delete_request
          expect(response).to redirect_to(root_path)
        end

      context "with unauthorized user" do
        let!(:snippet){create(:snippet)}
        def invalid_delete_request
          delete :destroy, id: snippet
        end

        it "should not remove a record for the DB" do
          expect{invalid_delete_request}.to_not change{Snippet}
        end

        # it "should raise ActiveRecord Error" do
          # expect{invalid_delete_request}.to  raise_error(ActiveRecord::RecordNotFound)
        # end

        it "should redirect to the root path" do
          invalid_delete_request
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context "with unauthenticated user" do
      let!(:snippet){create(:snippet)}
      it "should redirect to the sign-in page" do
        delete :destroy, id: snippet
        expect(response).to redirect_to(new_session_path)
      end
    end

  end

end
