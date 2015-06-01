module UsersHelper


    m = User.new
    m.name = ["Tom","Randy","Bill","Harry"].sample
    m.password = "lam"
    m.admin = true

    m.save
end
