module ApplicationHelper
  def user_signined?
    session[:user_id]
  end

  def expert_signined?
    session[:expert_id]
  end

  def flash_tag
    if flash[:alert]
      content_tag 'p', h(flash[:alert]), :class => 'notice alert'
    elsif flash[:notice]
      content_tag 'p', h(flash[:notice]), :class => 'notice'
    end
  end
  
  def generic_submenu_tag
    raw "<div id=\"submenu\">
      <h3>#{image_tag 'frontend/title_important_time.png'}</h3>
      <ul>
        <li class=\"title\">网上报名：</li>
        <li>7月15日 至 8月30日</li>
        <li class=\"title\">公布参会名单：</li>
        <li>9月15日 前</li>
        <li class=\"title\">论文全文提交：</li>
        <li>9月15日 至 11月15日</li>
      </ul>
      <h3>#{image_tag 'frontend/title_organization.png'}</h3>
      <ul>
        <li class=\"title\">主办单位：</li>
        <li>#{link_to '世界汉语教学学会', 'http://www.shihan.org.cn', :target => '_blank'}</li>
        <li>#{link_to '国家汉办/孔子学院总部', 'http://www.hanban.org', :target => '_blank'}</li>
        </ul>
    </div>"
  end

  def user_submenu_tag
    raw "<div id=\"submenu\">
      <h3>#{image_tag 'frontend/title_information.png'}</h3>
      <ul>
        <li>#{link_to '修改密码', edit_password_users_path}</li>
        <li>#{link_to '修改信息', edit_user_path(User.find(session[:user_id]))}</li>
      </ul>
      <h3>#{image_tag 'frontend/title_thesis.png'}</h3>
      <ul>
        <li>#{link_to '查看论文', show_project_users_path}</li>
        <li>#{link_to '修改论文', edit_project_users_path}</li>
      </ul>
      <h3>#{image_tag 'frontend/title_system.png'}</h3>
      <ul>
        <li>#{link_to '注销', user_signout_path}</li>
      </ul>
    </div>"
  end
  
  def expert_submenu_tag
    raw "<div id=\"submenu\">
      <h3>#{image_tag 'title_information.png'}</h3>
      <ul>
        <li>#{link_to '修改密码', edit_password_experts_path}</li>
      </ul>
      <h3>#{image_tag 'title_review.png'}</h3>
      <ul>
        <li>#{link_to '未处理论文', unrate_expert_ratings_path(Expert.find(session[:expert_id]))}</li>
        <li>#{link_to '已处理论文', rated_expert_ratings_path(Expert.find(session[:expert_id]))}</li>
        <li>#{link_to '论文评审标准', standard_expert_ratings_path(Expert.find(session[:expert_id]))}</li>
      </ul>
      <h3>#{image_tag 'title_system.png'}</h3>
      <ul>
        <li>#{link_to '注销', expert_signout_path}</li>
      </ul>
    </div>"
  end
end