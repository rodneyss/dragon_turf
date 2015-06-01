module UsersHelper

  def make_user
    m = User.new
    m.name = ["Tom","Randy","Bill","Harry"].sample
    m.password = "lam"
    m.admin = true

    m.save
  end
end
