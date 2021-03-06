module ApplicationHelper



    def intellinav
    nav = ''

    if @current_user.present?
        nav += '<li>' + link_to("Search Enemies", search_path) + '</li>'
        nav += '<li>' + link_to("View Profile", @current_user) + '</li>'
        nav += '<li>' + link_to("Logout #{ @current_user.name }", login_path, :method => :delete) + '</li>'
    else
         nav +=  '<li>' + link_to('New user', new_user_path)+ '</li>'
        nav += '<li>' + link_to('Login', login_path) + '</li>'
    end

    nav


    end



    def intellinav2
        nav = ''
        if @current_user.present? && @current_user.admin?
            nav += '<li>' + link_to('Show users', users_path) + '</li>'
            nav += '<li>' + link_to('Show spells', spells_path) + '</li>'
            nav += '<li>' + link_to('Show monsters', monsters_path) + '</li>'
            nav += '<li>' + link_to('Show zones', zones_path) + '</li>'
        end

        nav
    end




end
