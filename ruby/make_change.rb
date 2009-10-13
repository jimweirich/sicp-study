# (define (count-change amount)
#   (cc amount 5))
# (define (cc amount kinds-of-coins)
#   (cond ((= amount 0) 1)
#         ((or (< amount 0) (= kinds-of-coins 0)) 0)
#         (else (+ (cc amount
#                      (- kinds-of-coins 1))
#                  (cc (- amount
#                         (first-denomination kinds-of-coins))
#                      kinds-of-coins)))))

begin
  DENOMINATIONS = [1, 5, 10, 25, 50]
  
  def first_denomination(n)
    DENOMINATIONS[n-1]
  end
  
  def cc(amount, coin=DENOMINATIONS.size)
    if amount == 0
      1
    elsif amount < 0 || coin == 0
      0
    else
      cc(amount, coin - 1) +
        cc(amount - first_denomination(coin), coin)
    end
  end
  
  def icc(amount)
    result = 0
    pending = [[amount, DENOMINATIONS.size]]
    while ! pending.empty?
      a, c = pending.pop
      if a == 0
        result += 1
      elsif a > 0 && c > 0
        pending.push([a, c-1])
        pending.push([a - first_denomination(c), c])
      end
    end
    result
  end

end

puts cc(100)
puts icc(100)
