require "application_system_test_case"

class RailwayStationsTest < ApplicationSystemTestCase
  setup do
    @railway_station = railway_stations(:one)
  end

  test "visiting the index" do
    visit railway_stations_url
    assert_selector "h1", text: "Railway stations"
  end

  test "should create railway station" do
    visit railway_stations_url
    click_on "New railway station"

    fill_in "Title", with: @railway_station.title
    click_on "Create Railway station"

    assert_text "Railway station was successfully created"
    click_on "Back"
  end

  test "should update Railway station" do
    visit railway_station_url(@railway_station)
    click_on "Edit this railway station", match: :first

    fill_in "Title", with: @railway_station.title
    click_on "Update Railway station"

    assert_text "Railway station was successfully updated"
    click_on "Back"
  end

  test "should destroy Railway station" do
    visit railway_station_url(@railway_station)
    click_on "Destroy this railway station", match: :first

    assert_text "Railway station was successfully destroyed"
  end
end
