cond = c(
  GSM2684046="mock1",
  GSM2684047="mock2",
  GSM2684048="01sal",
  GSM2684049="12sal",
  GSM2684050="01hea",
  GSM2684051="12hea",
  GSM2684052="mock1",
  GSM2684053="mock2",
  GSM2684054="01sal",
  GSM2684055="12sal",
  GSM2684056="01hea",
  GSM2684057="12hea"
)
design = data.frame(gsm=names(cond), cond=cond, stringsAsFactors=FALSE)
rownames(design) = design$gsm
design$cond = factor(design$cond, levels=unique(design$cond))
