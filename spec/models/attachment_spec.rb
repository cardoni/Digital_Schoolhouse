require 'spec_helper'

describe Attachment do
    before { 
      @user = User.new(name: "Example User", 
                       email: "user@example.com",  
                       password_digest: "$2a$10$l2ZvnTqVQRCjAFqSjyyJhekqXJrAY8HpfMLaJ6h5YBCnLtWPgurIK") 
      @post = Post.new(title: "Some post", body: "Some body", user_id: @user.id, body_html: "body")
      @attachment = Attachment.new(provider: "Me", attachment_url: "http://www.example.com", description: "Awesome",
                                   copyright_info: "Chill out, I got this", user_id: @user.id, post_id: @post.id, 
                                   photo: "The photo"
      )
    }

  subject { @attachment }

  # it { should respond_to(:name) }
  # it { should respond_to(:email) }
  # it { should respond_to(:password_digest) }
  
  it { should be_valid }

  describe "when photo is not present" do
    # puts @attachment.provider
    before { @attachment.provider = " " }
    it { should_not be_valid }
  end
  
  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when email is not valid" do
      before { @user.email = "not valid at some domain dot com" }
    it { should_not be_valid }
  end
  
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end

    it { should_not be_valid }
  end
  
end


