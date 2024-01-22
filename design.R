cond = c(
  GSM2375278="WT",
  GSM2375279="WT",
  GSM2375280="WT",
  GSM2375281="MU",
  GSM2375282="MU",
  GSM2375283="MU",
  GSM2375284="WT",
  GSM2375285="WT",
  GSM2375286="WT",
  GSM2375287="MU",
  GSM2375288="MU",
  GSM2375289="MU",
  GSM2375290="WT",
  GSM2375291="WT",
  GSM2375292="WT",
  GSM2375293="MU",
  GSM2375294="MU",
  GSM2375295="MU",
  NULL
)

design = data.frame(gsm=names(cond), cond=cond, stringsAsFactors=FALSE)
rownames(design) = design$gsm
design$cond = factor(design$cond, levels=unique(design$cond))

design$line = design$cond 


design$time = c(
  GSM2375278="0h",
  GSM2375279="4h",
  GSM2375280="8h",
  GSM2375281="0h",
  GSM2375282="4h",
  GSM2375283="8h",
  GSM2375284="0h",
  GSM2375285="4h",
  GSM2375286="8h",
  GSM2375287="0h",
  GSM2375288="4h",
  GSM2375289="8h",
  GSM2375290="0h",
  GSM2375291="4h",
  GSM2375292="8h",
  GSM2375293="0h",
  GSM2375294="4h",
  GSM2375295="8h",
  NULL
)

design$replicate = c(
  GSM2375278="rep1",
  GSM2375279="rep1",
  GSM2375280="rep1",
  GSM2375281="rep1",
  GSM2375282="rep1",
  GSM2375283="rep1",
  GSM2375284="rep2",
  GSM2375285="rep2",
  GSM2375286="rep2",
  GSM2375287="rep2",
  GSM2375288="rep2",
  GSM2375289="rep2",
  GSM2375290="rep3",
  GSM2375291="rep3",
  GSM2375292="rep3",
  GSM2375293="rep3",
  GSM2375294="rep3",
  GSM2375295="rep3",
  NULL
)
