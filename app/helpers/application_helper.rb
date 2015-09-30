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

  def boolean_tag value
    case value
    when true then '是'
    when false then '否'
    end
  end

  def gender_tag gender
    case gender
    when '1' then '男'
    when '2' then '女'
    end
  end
  
  def generic_submenu_tag
    raw "<div id=\"submenu\">
      <h3>#{image_tag 'frontend/title_important_time.png'}</h3>
      <ul>
        <li class=\"title\">网上报名：</li>
        <li>7月15日 至 8月30日（延长至9月30日）</li>
        <li class=\"title\">公布参会名单：</li>
        <li>10月15日 前</li>
        <li class=\"title\">论文全文提交：</li>
        <li>10月15日 至 11月15日</li>
      </ul>
      <h3>#{image_tag 'frontend/title_organization.png'}</h3>
      <ul>
        <li class=\"title\">主办单位：</li>
        <li>#{link_to '世界汉语教学学会', 'http://www.shihan.org.cn', :target => '_blank'}</li>
        <li>#{link_to '孔子学院总部/国家汉办', 'http://www.hanban.org', :target => '_blank'}</li>
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
      <h3>#{image_tag 'frontend/title_information.png'}</h3>
      <ul>
        <li>#{link_to '修改密码', edit_password_experts_path}</li>
      </ul>
      <h3>#{image_tag 'frontend/title_review.png'}</h3>
      <ul>
        <li>#{link_to '未处理论文', unhandled_reviews_path}</li>
        <li>#{link_to '已处理论文', handled_reviews_path}</li>
        <li>#{link_to '评审标准', standard_reviews_path}</li>
      </ul>
      <h3>#{image_tag 'frontend/title_system.png'}</h3>
      <ul>
        <li>#{link_to '注销', expert_signout_path}</li>
      </ul>
    </div>"
  end

  def te_review_result result
    case result
    when :progressing then '进行中'
    when :success then '同意'
    when :failure then '不同意'
    when :reservation then '保留'
    end
  end
end