class LottoesController < ApplicationController
    def lottoes_view
        require('open-uri')	#웹페이지 오픈에 필요
        require('json')		#JSON을 HASH로 변환에 필요
        
        # 로또 만드는데 필요한거
        # 고객
        # 배열 로또 번호 1~45
        
        lotto_numbers=(1..45).to_a
        numbers6=lotto_numbers.sample(6).sort
        @show = "당신의 행운의 번호는 #{numbers6} 이구요"
        
        
        
        ##로또 번호 가져오기
        page = open('http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=')
        lotto_info = page.read
        lotto_hash = JSON.parse(lotto_info)
        
        
        bnusNo=lotto_hash["bnusNo"]
        
        realnum=[]
        i=1
        while i < 7
        realnum.push(lotto_hash["drwtNo#{i}"])
        i+=1
        end
        
        @show2 = "이번주 당첨번호는 #{realnum} 보너스 번호는 #{bnusNo} 입니당ㅎㅎ"
        
        hi=(numbers6-realnum).count
        
        case hi
        when 0
            @no1 = "와 대박 1등임ㅠㅠㅠ."
        when 1
            if (numbers6-realnum)==bnusNo
                @no2 = "와 대박 2등임."
            else 
                @no3 = "와 대박 3등임."
            end
        when 2
            @no4 = "에이 아쉽다 4등임."
        when 3
            @no5 = "에이 아쉽다 5등임."
        when 4
            @haha = "그래서 당신은 꽝 ㅎ"
        when 5
            @haha = "그래서 당신은 꽝 ㅎ"
        when 6
            @haha = "그래서 당신은 꽝 ㅎ"
        end
        #gi는 겹치지 않는번호고 ji는 겹치는 번호
        gi=(numbers6-realnum).to_a
        ji=(numbers6-gi).to_a
        @compare = "이거 겹쳤어요 ㅎㅎ#{ji}"
    end
end
