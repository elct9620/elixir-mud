# frozen_string_literal: true

chapter 1 do
  name '進入五倍'

  # Action 0
  action do
    say '歡迎來到五倍紅寶石'
    say '要進去嗎？(Y/n)'
    jump 1
    wait_input
  end

  # Action 1
  action do
    case input.downcase
    when 'n'
      say '你離開了五倍紅寶石'
      close
    else
      say '你看到了一隻貓。'
      say '要跟牠玩嗎？(Y/n)'
      jump 2
      wait_input
    end
  end

  # Action 2
  action do
    case input.downcase
    when 'n'
      say '你到了教室前面。'
      say '要進去上課嗎？(Y/n)'
      jump 3
    else
      if Random.rand(1..10) == 1
        say '學妹使用了翻滾一圈。'
      else
        say '學妹使用了爪子攻擊。'
      end
      say '要繼續嗎？(Y/n)'
    end

    wait_input
  end

  # Action 3
  action do
    case input.downcase
    when 'n'
      say '你離開了五倍紅寶石'
      close
    else
      say '學會了新技能！'
      say '要回家了嗎？(Y/n)'
      jump 4
      wait_input
    end
  end

  # Action 4
  action do
    case input.downcase
    when 'n'
      say '要跟貓玩嗎？(Y/n)'
      jump 1
      wait_input
    else
      say '你離開了五倍紅寶石'
      close
    end
  end
end
