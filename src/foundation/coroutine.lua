
co = coroutine.create( 
    function (  )
        for i=1,10 do
            print(i)
            if i % 2 == 0 then
                coroutine.yield()
            end
        end
    end
 )

coroutine.resume(co)
coroutine.resume(co)
