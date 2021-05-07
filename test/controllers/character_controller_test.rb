require 'test_helper'

class CharacterControllerTest < ActionDispatch::IntegrationTest
  test "should get appearance" do
    get character_appearance_url
    assert_response :success
  end

  test "should get traits" do
    get character_traits_url
    assert_response :success
  end

  test "should get relationships" do
    get character_relationships_url
    assert_response :success
  end

end
