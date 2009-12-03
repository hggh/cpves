require 'test_helper'

class DomainEmailsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:domain_emails)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create domain_email" do
    assert_difference('DomainEmail.count') do
      post :create, :domain_email => { }
    end

    assert_redirected_to domain_email_path(assigns(:domain_email))
  end

  test "should show domain_email" do
    get :show, :id => domain_emails(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => domain_emails(:one).to_param
    assert_response :success
  end

  test "should update domain_email" do
    put :update, :id => domain_emails(:one).to_param, :domain_email => { }
    assert_redirected_to domain_email_path(assigns(:domain_email))
  end

  test "should destroy domain_email" do
    assert_difference('DomainEmail.count', -1) do
      delete :destroy, :id => domain_emails(:one).to_param
    end

    assert_redirected_to domain_emails_path
  end
end
