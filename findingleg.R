leg <- function(niftystocks) {
  prevsymb = ""
  for (i in 1:nrow(niftystocks)){
    currsymb = niftystocks[i,1]
    if (currsymb != prevsymb )
    {
      canstrno = 1
      canendno = 1
      number = 1
      canendno = canendno + 1
      sdl = niftystocks[i,2]
      prevsymb = currsymb
      strtprc = niftystocks[i,6]
      next
    }
    low = niftystocks[i,6]
    high = niftystocks[i,5]
    #sdl = niftystocks[i-1,2]
    edl = niftystocks[i-1,2]
    prevlow = niftystocks[(i-1),6]
    
    if ((low-prevlow) < 0){
    ref = 'Down'
    }
    if ((low-prevlow) > 0){
    ref = 'Up'
    }
    if (canendno == 2){
      starthigh = niftystocks[(i-1),5]
      startlow = niftystocks[(i-1),6]
      dir = ref
    }
    if (ref != dir){
      if (ref == 'Down'){
        starthigh = niftystocks[(i-1),5]
        endprc = niftystocks[i-1,5]
      }
      if (ref == 'Up'){
        startlow = niftystocks[(i-1),6]
        endprc = niftystocks[i-1,6]
      }
      if (canendno == 2){
        dir = ref
      }
      legs = rbind(legs,c(currsymb,number,canstrno,sdl,strtprc,canendno,edl,endprc,
                          abs(starthigh - startlow),dir))
      dir = ref
      number = number + 1
      canstrno = canendno
      sdl = edl
      strtprc = endprc
    }
    canendno <-canendno + 1
  }
  return(legs)
}
niftystocks <- read.csv("C:/Users/Abhishek/Desktop/StudyMaterial/Hadoop/Vinay Kulkarni Sir/Project/niftystocks.csv",stringsAsFactors=F)
legs = c("STOCK_ID", "LEG_NO", "START CANDLE SERIAL NUMBER",
        "START DATE OF LEG", "START PRICE", "END CANDLE SERIAL NUMBER",
        "END DATE OF LEG", "END PRICE", "LEG HEIGHT", "LEG DIRECTION")
lg = leg(niftystocks)
#lg = as.data.frame(lg,row.names = NULL,stringsAsFactors = FALSE)
ratios = c("STOCK_ID","PREVIOUS LEG NUMBER","CURRENT LEG NUMBER",
           "RATIO OF LEG HEIGHTS")
for(i in 2:(nrow(lg)-1))
{
  if(lg[i,1] != lg[i+1,1])
  {
    next
  }
  #heightcurr = lg[i+1,9]
  #heightnxt = lg[i,9]
  
  ratio<- as.numeric(lg[i+1,9]) / as.numeric(lg[i,9])
  stkid<-lg[i,1]
  prevlgno<-lg[i,2]
  currlgno<-lg[i+1,2]
  lgratio<-ratio
  ratios = rbind(ratios,c(stkid,prevlgno,currlgno,lgratio))
}

write.csv(lg,"legs.csv",row.names = FALSE,col.names = FALSE)
write.csv(ratios,"legs_ratio.csv",row.names = FALSE,col.names = FALSE)
