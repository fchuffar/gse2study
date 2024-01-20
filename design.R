cond = c(
  SCT00repA="T00",
  SCT00repB="T00",
  SCT00repC="T00",
  SCT00repD="T00",
  SCT04repA="T04",
  SCT04repB="T04",
  SCT04repC="T04",
  SCT04repD="T04",
  SCT08repA="T08",
  SCT08repB="T08",
  SCT08repC="T08",
  SCT08repD="T08",
  SCT48repA="T48",
  SCT48repB="T48",
  SCT48repC="T48",
  SCT48repD="T48",
  NULL
)

design = data.frame(gsm=names(cond), cond=cond, stringsAsFactors=FALSE)
rownames(design) = design$gsm
design$cond = factor(design$cond, levels=unique(design$cond))

design$time = design$cond 

design$replicate = c(
  SCT00repA="repA",
  SCT00repB="repB",
  SCT00repC="repC",
  SCT00repD="repD",
  SCT04repA="repA",
  SCT04repB="repB",
  SCT04repC="repC",
  SCT04repD="repD",
  SCT08repA="repA",
  SCT08repB="repB",
  SCT08repC="repC",
  SCT08repD="repD",
  SCT48repA="repA",
  SCT48repB="repB",
  SCT48repC="repC",
  SCT48repD="repD",
  NULL
)