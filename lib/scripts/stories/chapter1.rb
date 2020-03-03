# frozen_string_literal: true

chapter 1 do
  name '進入五倍'
  dialog do
    [
      [
        :msg,
        "你進入了五倍紅寶石，要做什麼呢？\r\n" \
        '(1) 上課 (2) 玩貓'
      ],
      [
        :next, 1
      ]
    ]
  end

  dialog do |params|
    case params.action
    when '1' then [[:msg, "你開始上課了！\r\n"], [:msg, '要繼續嗎？ (Y/n)'], [:jmp, 2]]
    when '2' then [[:msg, "你開始玩貓了！\r\n"], [:msg, '要繼續嗎？？(Y/n)'], [:jmp, 3]]
    else [[:msg, '...']]
    end
  end

  dialog do |params|
    case params.action.downcase
    when 'n' then [[:msg, '你離開了五倍紅寶石⋯⋯'], [:jmp, 0]]
    else [[:msg, "你認真的上課⋯⋯\r\n"], [:msg, '(1) 上課 (2) 玩貓'], [:jmp, 1]]
    end
  end

  dialog do |params|
    case params.action.downcase
    when 'n' then [[:msg, "你開始上課了！\r\n"], [:msg, '要繼續嗎？ (Y/n)'], [:jmp, 2]]
    else [[:msg, "你繼續玩貓⋯⋯\r\n"], [:msg, '要繼續嗎？ (Y/n)']]
    end
  end
end
