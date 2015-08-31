# -*- encoding : utf-8 -*-
class Cms::ExcelsController < Cms::BaseController
  include ApplicationHelper

  def all
    file = export_users(User.all)
    send_data file.string, content_type: 'application/xls', filename: "all_users_#{Time.now.strftime '%Y%m%d%H%M'}.xls"
  end

  protected
    def export_users users
      StringIO.new.tap do |file|
        book = Spreadsheet::Workbook.new
        sheet = book.create_worksheet(name: '参会者')
        sheet.row(0).concat %w{ID 中文姓名 外文姓名 账号 性别 国籍 联系地址 邮政编码 座机 手机 传真 电子邮件 工作单位 职称 职位 世汉会员 论文题目 第一作者 第二作者 关键词 摘要 提交时间}
        users.each_with_index do |user, i|
          sheet.insert_row(i + 1, [user.id, user.chinese_name, user.foreign_name, user.account, gender_tag(user.gender), user.country.name, user.address, user.postal_code, user.phone_number, user.mobile_number, user.fax_number, user.email, user.organization, user.professional_title, user.position, boolean_tag(user.is_member?), user.subject, user.first_author, user.second_author, user.keywords, user.outline, user.created_at.strftime('%Y-%m-%d %H:%M')])
        end
        book.write(file)
      end
    end
end