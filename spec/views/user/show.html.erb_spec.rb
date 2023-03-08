require 'rails_helper'
RSpec.describe 'User pages functionality : user show page', type: :feature do
  let!(:user) do
    User.create(
      name: 'Victor',
      photo: 'https://www.bing.com/th?id=ODL.c83b34c2350e6cd3a1010f7d1998cfa8&w=143&h=198&c=12&rs=1&qlt=99&pcl=faf9f7&o=6&pid=13.1',
      bio: 'author'
    )
  end
  let!(:post1) do
    Post.create(
      author_id: user.id,
      title: 'post1',
      text: 'this is my fifth post'
    )
  end
  let!(:post2) do
    Post.create(
      author_id: user.id,
      title: 'post2',
      text: 'this is my second post'
    )
  end
  let!(:post3) do
    Post.create(
      author_id: user.id,
      title: 'post3',
      text: 'this is my third post'
    )
  end
  let!(:post4) do
    Post.create(
      author_id: user.id,
      title: 'post4',
      text: 'this is my  fourth post'
    )
  end
  before(:each) do
    visit user_path(user)
  end
  it "I can see the user's profile picture" do
    expect(page).to have_xpath("//img[@src='#{user.photo}']")
  end
  it "I can see the user's username" do
    expect(page).to have_text(user.name)
  end
  it 'I can see the number of posts the user has written.' do
    expect(page).to have_content(/posts:[\d+]/i)
  end
  it "I can see the user's bio." do
    expect(page).to have_content(/#{user.bio}/i)
  end
  it "I can see a button that lets me view all of a user's posts." do
    expect(page).to have_text(/See all posts/i)
  end
  it "When I click a user's post, it redirects me to that post's show page." do
    visit user_posts_path(user)
    click_on post1.title
    expect(page).to have_current_path(user_post_path(user, post1))
  end
  it "When I click to see all posts, it redirects me to the user's post's index page" do
    visit user_post_path(user, post1)
    click_on 'See all posts'
    expect(page).to have_current_path(user_posts_path(user))
  end
  it "I can see the user's last three posts." do
    expect(page).to have_text(/#{post4.title}/i)
    expect(page).to have_text(/#{post3.title}/i)
    expect(page).to have_text(/#{post2.title}/i)
    expect(page).to_not have_text(/#{post1.title}/i)
  end
end
