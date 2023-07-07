cond = c(
  GSM5155752 = "dmso",
  GSM5155753 = "dmso",
  GSM5155754 = "dmso",
  GSM5155749 = "aphi",
  GSM5155750 = "aphi",
  GSM5155751 = "aphi"
)

design = data.frame(gsm=names(cond), cond=cond, stringsAsFactors=FALSE)
rownames(design) = design$gsm
design$cond = factor(design$cond, levels=unique(design$cond))
