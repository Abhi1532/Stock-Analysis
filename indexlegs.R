leg <- function(niftyindex) {
  currsymb = "NIFTYINDEX"
  canstrno = 1
  canendno = 1
  number = 1
  for (i in 1:nrow(niftyindex)){
    if (i == 1)
    {
      canendno = canendno + 1
      sdl = niftyindex[i,1]
      strtprc = niftyindex[i,4]
      next
    }
  
    if(niftyindex[i,1] == "Date")
    {
      next
    }
    
    if(niftyindex[(i-1),1] == "Date")
    {
      sdl = niftyindex[i,1]
      strtprc = niftyindex[i,4]
      next
    }
    
    low = as.numeric(niftyindex[i,4])
    high = as.numeric(niftyindex[i,3])
    edl = niftyindex[i-1,1]
    prevlow = as.numeric(niftyindex[(i-1),4])
    
    if ((low-prevlow) < 0){
    ref = 'Down'
    }
    if ((low-prevlow) > 0){
    ref = 'Up'
    }
    if (canendno == 2){
      starthigh = as.numeric(niftyindex[(i-1),3])
      startlow = as.numeric(niftyindex[(i-1),4])
      dir = ref
    }
    if (ref != dir){
      if (ref == 'Down'){
        starthigh = as.numeric(niftyindex[(i-1),3])
        endprc = as.numeric(niftyindex[i-1,3])
      }
      if (ref == 'Up'){
        startlow = as.numeric(niftyindex[(i-1),4])
        endprc = as.numeric(niftyindex[i-1,4])
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
niftyindex <- read.csv("C:/Users/Abhishek/Desktop/StudyMaterial/Hadoop/Vinay Kulkarni Sir/Project/nifty_index.csv",stringsAsFactors=F)
legs = c("STOCK_ID", "LEG_NO", "START CANDLE SERIAL NUMBER",
        "START DATE OF LEG", "START PRICE", "END CANDLE SERIAL NUMBER",
        "END DATE OF LEG", "END PRICE", "LEG HEIGHT", "LEG DIRECTION")
lg = leg(niftyindex)

ratios = c("STOCK_ID","PREVIOUS LEG NUMBER","CURRENT LEG NUMBER",
           "RATIO OF LEG HEIGHTS")
for(i in 2:(nrow(lg)-1))
{
  if(lg[i,1] != lg[i+1,1])
  {
    next
  }
    
  ratio<- as.numeric(lg[i+1,9]) / as.numeric(lg[i,9])
  stkid<-lg[i,1]
  prevlgno<-lg[i,2]
  currlgno<-lg[i+1,2]
  lgratio<-ratio
  ratios = rbind(ratios,c(stkid,prevlgno,currlgno,lgratio))
}

write.csv(lg,"indexlegs.csv",row.names = FALSE,col.names = FALSE)
write.csv(ratios,"indexlegs_ratio.csv",row.names = FALSE,col.names = FALSE)
