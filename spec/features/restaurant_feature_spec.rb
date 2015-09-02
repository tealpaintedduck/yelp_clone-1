require 'rails_helper'

feature 'restaurants' do
  before(:each) do
    user = build(:user)
    sign_up(user)
  end

  context 'no restaurants have been added' do
    scenario 'it should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'KFC'
      expect(page).not_to have_content 'No restaurants yet'
    end
  end

  context 'creating a restaurant' do
    scenario 'prompts user to fill out a form then displays the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    context 'an invalid Restaurant' do
      it 'does not let you submit a name that is too short' do
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end

  context 'viewing Restaurant' do
    let!(:kfc){ Restaurant.create(name: 'KFC') }

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do
    before(:each) do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Trade'
      click_button 'Create Restaurant'
    end

    scenario 'let a user edit a restaurant if created by them' do
      click_link 'Edit Trade'
      fill_in 'Name', with: 'TradeMade'
      click_button 'Update Restaurant'
      expect(page).to have_content 'TradeMade'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'do not allow a user to edit a restaurant if not created by them' do
      click_link 'Sign out'

      jeremina = build(:jeremina)
      sign_up(jeremina)
      expect(page).not_to have_content 'Edit Trade'
    end
  end

  context 'deleting restaurants' do
    before{ Restaurant.create name: 'KFC' }

    scenario 'let a user delete a restaurant if created by them' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

    xscenario 'do not allow a user to delete a restaurant if not created by them' do

    end
  end

end



