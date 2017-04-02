class LottoesController < ApplicationController
    def lottoes_view
        require('open-uri')	#웹페이지 오픈에 필요
        require('json')		#JSON을 HASH로 변환에 필요
        
        # 로또 만드는데 필요한거
        # 고객
        # 배열 로또 번호 1~45
        
        lotto_numbers=(1..45).to_a
        @numbers6=lotto_numbers.sample(6).sort
        @show = "당신의 행운의 번호는 #{@numbers6} 이구요"
        
        
        
        ##로또 번호 가져오기
        page = open('http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=')
        lotto_info = page.read
        lotto_hash = JSON.parse(lotto_info)
        
        
        bnusNo=lotto_hash["bnusNo"]
        
        @realnum=[]
        i=1
        while i < 7
        @realnum.push(lotto_hash["drwtNo#{i}"])
        i+=1
        end
        
        @show2 = "이번주 당첨번호는 #{@realnum} 보너스 번호는 #{bnusNo} 입니당ㅎㅎ"
        
        realnum=@realnum
        hi=(@numbers6-realnum).count
        
         @resultvalue=case hi
            when 0
                then "1등"
            when 1
                then
                    if (numbers6-realnum)==bnusNo
                         "2등"
                    else 
                         "3등"
                    end
            when 2
                then "4등"
            when 3
                then "5등"
            when 4
                then "꽝"
            when 5
                then "꽝"
            when 6
                then "꽝"
            end
        #gi는 겹치지 않는번호고 ji는 겹치는 번호
        gi=(@numbers6-realnum).to_a
        ji=(@numbers6-gi).to_a
        @haha ="당신은" + @resultvalue + "입니다"
        @compare = "이거 겹쳤어요 ㅎㅎ#{ji}"
    end
    def write
        
        vari=Board.new
        vari.board_title=params[:numbers6]
        vari.board_content=params[:resultvalue]
        vari.save
        
        @gol = Board.all
        
        @numbers6 = params[:numbers6]
        @resultvalue = params[:resultvalue]

    end
end
