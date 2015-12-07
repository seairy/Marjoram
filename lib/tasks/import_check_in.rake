namespace :check_in do
  task import_staffs: :environment do
    Staff.create!(account: 'admin', password: '123456', password_confirmation: '123456', role: :admin, name: '管理员', available: true)
  end

  task import_regular_and_visitor: :environment do
    (User.type_regulars.accepted + User.type_visitors.accepted).each do |user|
      Participant.create!(type: user.type,
        name: user.chinese_name,
        gender: (user.gender == 1 ? :male : :female),
        country_id: user.country_id,
        phone_number: user.phone_number,
        mobile_number: user.mobile_number,
        email: user.email,
        organization_name: user.organization,
        subject: user.subject,
        is_member: user.is_member?,
        room_id: user.bookings.first.try(:room_id),
        registration_fees: 0,
        isclt_member_fees: 0,
        checked_in: false)
    end
  end

  task import_invited: :environment do
    ['王珏', '林凡', '林永珪', '马奕男', '尹文英', 'Elvira S. Balinas', 'CAVIN FRANCO PAMINTUAN（裴刚）', '李严', 'F. Andrew McMichael', 'Dr. Sam Evans', '朱瑞平', '张旺熹', '阮国偲', '小松洋大', '赵安娜', '陈恩倩'].each do |name|
      Participant.create!(type: :invited, name: name, gender: :unknown, country_id: 0, is_member: true, registration_fees: 0, isclt_member_fees: 0, checked_in: false)
    end
    ['温象羽', '敖玉敏', '李芸', '耿虎', '尚小萌', '侯明', '郭杨', '歌·朝格吉乐玛', '张代生', '任友梅', '宋继华'].each do |name|
      Participant.create!(type: :invited, name: name, gender: :unknown, country_id: 0, is_member: true, registration_fees: 0, isclt_member_fees: 0, room_id: 6, entrance_date: Time.local(2015, 12, 8), departure_date: Time.local(2015, 12, 11), checked_in: false)
    end
  end

  task import_councilman: :environment do
    ['施仲谋', '吴坚立', '黄端铭', '塔勒哈特•马木尔', '陈曦', '蔡昌杰', '阮福禄', '李夏德', '孟柱亿', '白建华', '朝吉勒玛', '周敏康', '吴英成', '崔希亮', '丁安琪', '姜明宝', '李泉', '卢福波', '骆小所', '孟长勇', '宁继鸣', '沙平', '吴勇毅', '吴中伟', '杨金成', '袁礼', '张建民', '张晓慧', '钟英华', '朱小健', '於滨', '沙宗元', '王京', '周洪波', '帅式毅', '黄小明', '李伟', '郭红', '李晨', '白家瑶', '王贵彬', '黄彬', '易福成', '白乐桑', '刘骏', '刘乐宁', '姚载瑜', '许嘉璐', '马箭飞'].each do |name|
      if exist_participant = Participant.where(name: name).first
        exist_participant.update!(type_cd: :councilman)
      else
        Participant.create!(type: :councilman, name: name, gender: :unknown, country_id: 0, is_member: true, registration_fees: 0, isclt_member_fees: 0, checked_in: false)
      end
    end
  end
end