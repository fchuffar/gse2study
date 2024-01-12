cond = c(
  CA51_scr_rep1="CA51",
  CA51_scr_rep2="CA51",
  CA51_scr_rep3="CA51",
  CA51_si1_rep1="CA51",
  CA51_si1_rep2="CA51",
  CA51_si1_rep3="CA51",
  CA51_si3_rep1="CA51",
  CA51_si3_rep2="CA51",
  CA51_si3_rep3="CA51",
  MCF7_scr_rep1="MCF7",
  MCF7_scr_rep2="MCF7",
  MCF7_scr_rep3="MCF7",
  MCF7_si1_rep1="MCF7",
  MCF7_si1_rep2="MCF7",
  MCF7_si1_rep3="MCF7",
  MCF7_si3_rep1="MCF7",
  MCF7_si3_rep2="MCF7",
  MCF7_si3_rep3="MCF7",
  NULL
)

line = c(
  CA51_scr_rep1="CA51",
  CA51_scr_rep2="CA51",
  CA51_scr_rep3="CA51",
  CA51_si1_rep1="CA51",
  CA51_si1_rep2="CA51",
  CA51_si1_rep3="CA51",
  CA51_si3_rep1="CA51",
  CA51_si3_rep2="CA51",
  CA51_si3_rep3="CA51",
  MCF7_scr_rep1="MCF7",
  MCF7_scr_rep2="MCF7",
  MCF7_scr_rep3="MCF7",
  MCF7_si1_rep1="MCF7",
  MCF7_si1_rep2="MCF7",
  MCF7_si1_rep3="MCF7",
  MCF7_si3_rep1="MCF7",
  MCF7_si3_rep2="MCF7",
  MCF7_si3_rep3="MCF7",
  NULL
)

si = c(
  CA51_scr_rep1="scr",
  CA51_scr_rep2="scr",
  CA51_scr_rep3="scr",
  CA51_si1_rep1="si1",
  CA51_si1_rep2="si1",
  CA51_si1_rep3="si1",
  CA51_si3_rep1="si3",
  CA51_si3_rep2="si3",
  CA51_si3_rep3="si3",
  MCF7_scr_rep1="scr",
  MCF7_scr_rep2="scr",
  MCF7_scr_rep3="scr",
  MCF7_si1_rep1="si1",
  MCF7_si1_rep2="si1",
  MCF7_si1_rep3="si1",
  MCF7_si3_rep1="si3",
  MCF7_si3_rep2="si3",
  MCF7_si3_rep3="si3",
  NULL
)

replicate = c(
  CA51_scr_rep1="rep1",
  CA51_scr_rep2="rep2",
  CA51_scr_rep3="rep3",
  CA51_si1_rep1="rep1",
  CA51_si1_rep2="rep2",
  CA51_si1_rep3="rep3",
  CA51_si3_rep1="rep1",
  CA51_si3_rep2="rep2",
  CA51_si3_rep3="rep3",
  MCF7_scr_rep1="rep1",
  MCF7_scr_rep2="rep2",
  MCF7_scr_rep3="rep3",
  MCF7_si1_rep1="rep1",
  MCF7_si1_rep2="rep2",
  MCF7_si1_rep3="rep3",
  MCF7_si3_rep1="rep1",
  MCF7_si3_rep2="rep2",
  MCF7_si3_rep3="rep3",
  NULL
)



design = data.frame(gsm=names(cond), cond=cond, stringsAsFactors=FALSE)
rownames(design) = design$gsm
design$cond = factor(design$cond, levels=unique(design$cond))

design$line = line[rownames(design)]
design$line = factor(design$line, levels=unique(design$line))
design$si = si[rownames(design)]
design$si = factor(design$si, levels=unique(design$si))
design$replicate = replicate[rownames(design)]
design$replicate = factor(design$replicate, levels=unique(design$replicate))

