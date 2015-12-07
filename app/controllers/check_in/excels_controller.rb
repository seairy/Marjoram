# -*- encoding : utf-8 -*-
class CheckIn::ExcelsController < CheckIn::BaseController

  def all
    file = StringIO.new.tap do |file|
      book = Spreadsheet::Workbook.new
      Hotel.all.each do |hotel|
        sheet = book.create_worksheet(name: hotel.name)
        sheet.row(0).concat %w{ID 参会类型 姓名 工作单位 世汉会员 住宿时间 住宿费 会议费 会员费 总计 POS 现金 发票抬头 备注}
        Participant.where(room_id: hotel.rooms.map(&:id)).each_with_index do |participant, i|
          hotel_fees = unless participant.room.blank?
            ((participant.departure_date.day - participant.entrance_date.day) * participant.room.price).round
          else
            0
          end
          sheet.insert_row(i + 1, [participant.id, participant.human_type, participant.name, participant.organization_name, (participant.is_member? ? '是' : '否'), (participant.room.blank? ? '无' : "#{participant.entrance_date.day}日-#{participant.departure_date.day}日"), (participant.room.blank? ? '无' : "#{hotel_fees}元"), (participant.registration_fees.zero? ? '免费' : "#{participant.registration_fees}元"), (participant.isclt_member_fees.zero? ? '无' : "#{participant.isclt_member_fees}元"), (hotel_fees + participant.registration_fees + participant.isclt_member_fees), '', '', '', ''])
        end
      end
      book.write(file)
    end
    send_data file.string, content_type: 'application/xls', filename: "all_participants_#{Time.now.strftime '%Y%m%d%H%M'}.xls"
  end
end