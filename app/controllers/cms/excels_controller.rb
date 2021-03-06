# -*- encoding : utf-8 -*-
class Cms::ExcelsController < Cms::BaseController
  include ApplicationHelper

  def all
    file = export_users(User.all)
    send_data file.string, content_type: 'application/xls', filename: "all_users_#{Time.now.strftime '%Y%m%d%H%M'}.xls"
  end

  def accepted
    file = export_users(User.type_regulars.accepted)
    send_data file.string, content_type: 'application/xls', filename: "accepted_users_#{Time.now.strftime '%Y%m%d%H%M'}.xls"
  end

  def visitor
    file = export_users(User.type_visitors)
    send_data file.string, content_type: 'application/xls', filename: "visitor_users_#{Time.now.strftime '%Y%m%d%H%M'}.xls"
  end

  def hotel
    file = StringIO.new.tap do |file|
      book = Spreadsheet::Workbook.new
      sheet = book.create_worksheet(name: '参会者')
      sheet.row(0).concat %w{ID 类型 状态 中文姓名 外文姓名 账号 性别 国籍 联系地址 邮政编码 座机 手机 传真 电子邮件 工作单位 职称 职位 世汉会员 酒店 房型 入住日期 离店日期 备注}
      User.accepted.select{|user| !user.bookings.count.zero?}.each_with_index do |user, i|
        sheet.insert_row(i + 1, [user.id, user.human_type, user.human_state, user.chinese_name, user.foreign_name, user.account, gender_tag(user.gender), user.country.name, user.address, user.postal_code, user.phone_number, user.mobile_number, user.fax_number, user.email, user.organization, user.professional_title, user.position, boolean_tag(user.is_member?), user.bookings.first.room.hotel.name, user.bookings.first.room.name, user.bookings.first.entrance_date.strftime('%m月%d日'), user.bookings.first.departure_date.strftime('%m月%d日'), user.bookings.first.comment])
      end
      book.write(file)
    end
    send_data file.string, content_type: 'application/xls', filename: "hotel_#{Time.now.strftime '%Y%m%d%H%M'}.xls"
  end

  protected
    def export_users users
      StringIO.new.tap do |file|
        book = Spreadsheet::Workbook.new
        sheet = book.create_worksheet(name: '参会者')
        sheet.row(0).concat %w{ID 类型 状态 中文姓名 外文姓名 账号 性别 国籍 联系地址 邮政编码 座机 手机 传真 电子邮件 工作单位 职称 职位 世汉会员 论文题目 第一作者 第二作者 A组专家 评审结果 B组专家 评审结果 综合评分 关键词 摘要 论文全文 提交时间}
        users.each_with_index do |user, i|
          sheet.insert_row(i + 1, [user.id, user.human_type, user.human_state, user.chinese_name, user.foreign_name, user.account, gender_tag(user.gender), user.country.name, user.address, user.postal_code, user.phone_number, user.mobile_number, user.fax_number, user.email, user.organization, user.professional_title, user.position, boolean_tag(user.is_member?), user.subject, user.first_author, user.second_author, (user.group_a_rating ? user.group_a_rating.expert.name : '未指派'), (user.group_a_rating ? user.group_a_rating.human_result : '未指派'), (user.group_b_rating ? user.group_b_rating.expert.name : '未指派'), (user.group_b_rating ? user.group_b_rating.human_result : '未指派'), user.general_score, user.keywords, user.outline, (user.file.blank? ? '未提交' : '已提交'), user.created_at.strftime('%Y-%m-%d %H:%M')])
        end
        book.write(file)
      end
    end
end