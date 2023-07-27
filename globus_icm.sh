Create your Globus ID and send it to us so we can associate you to your data:
https://www.globusid.org/create

Log in: username: florentc   @ globusid.org
https://www.globusid.org/login

Install and launch Globus Connect Personal on your local computer:
https://www.globus.org/globus-connect-personal
https://www.youtube.com/watch?v=46hR9W6R6JM
conda create --name globus_env
conda activate globus_env
conda install -c conda-forge globus-cli
globus gcp create mapped bettik_mapped
wget https://downloads.globus.org/globus-connect-personal/linux/stable/globusconnectpersonal-latest.tgz
tar xfvz globusconnectpersonal-latest.tg
./globusconnectpersonal-3.2.2/globusconnectpersonal -setup c1c68c94-d86c-473b-b7a2-7c0c43b1105b
./globusconnectpersonal-3.2.2/globusconnectpersonal -start  -restrict-paths  rw/home/chuffarf/projects/datashare/rnaseq_lafage_icm -debug


Click on the link that we will send you with the data, then select "Transfer or Sync" on globus.org:
https://docs.globus.org/how-to/get-started/
https://www.youtube.com/watch?v=UQazjDNzMMg
 
 mkdir -p ~/projects/datashare/rnaseq_lafage_icm/raw
cd ~/projects/datashare/rnaseq_lafage_icm/raw




cat ~/projects/datashare/rnaseq_lafage_icm/raw/md5.icm.txt





BF : BMP4 FGF2 
EF : EGF FGF2
ASO : Antisens Oligo Nuc

  design                        condition medium transfection               vector                genotype         
- 4 mono couches controles      cond 1    BF     notransf    novect           WT       
- 4 mono couches Hunt. hétéroz. cond 2    BF     notransf    novect           HE       
- 4 mono couches controles WT   cond 3    BF     asotrans           novect           WT       
- 4 mono couches ASO scrumble   cond 4    BF     asotrans           scrum      WT       
- 4 mono couches ASO h1         cond 5    BF     asotrans           vecph1    WT       
- 4 sphéroïdes contrôles        cond 6    EF     notransf    novect           WT
- 4 sphéroïdes Hunt. hétéroz.   cond 7    EF     notransf    novect           HE
- 4 sphéroïdes Hunt. homoz.     cond 8    EF     notransf    novect           HO

SVZ:Zone Sub Ventricular Zone


prefix                  design                        condition date  daily_batch  batch_id  medium transfection   vector  genotype  new_prefix  
SVZ13_01-WT-BF          4 mono couches controles      cond1     13_01 n1           b1301n1   BF     notransf       novect  WT        b1301n1_bf_notransf_novect_wt          
SVZ14_01-WT-BF          4 mono couches controles      cond1     14_01 n1           b1401n1   BF     notransf       novect  WT        b1401n1_bf_notransf_novect_wt          
SVZ16_12-WT-BF          4 mono couches controles      cond1     16_12 n1           b1612n1   BF     notransf       novect  WT        b1612n1_bf_notransf_novect_wt          
SVZ17_12-WT-BF          4 mono couches controles      cond1     17_12 n1           b1712n1   BF     notransf       novect  WT        b1712n1_bf_notransf_novect_wt          
SVZ13_01-HE-BF          4 mono couches Hunt. hétéroz. cond2     13_01 n1           b1301n1   BF     notransf       novect  HE        b1301n1_bf_notransf_novect_he          
SVZ14_01-HE-BF          4 mono couches Hunt. hétéroz. cond2     14_01 n1           b1401n1   BF     notransf       novect  HE        b1401n1_bf_notransf_novect_he          
SVZ16_12-HE-BF          4 mono couches Hunt. hétéroz. cond2     16_12 n1           b1612n1   BF     notransf       novect  HE        b1612n1_bf_notransf_novect_he          
SVZ17_12-HE-BF          4 mono couches Hunt. hétéroz. cond2     17_12 n1           b1712n1   BF     notransf       novect  HE        b1712n1_bf_notransf_novect_he          
SVZ02_05-n2-WT-Ctrl     4 mono couches controles WT   cond3     02_05 n2           b0205n2   BF     ASOtrans       novect  WT        b0205n2_bf_asotrans_novect_wt          
SVZ03_05-n1-WT-Ctrl     4 mono couches controles WT   cond3     03_05 n1           b0305n1   BF     ASOtrans       novect  WT        b0305n1_bf_asotrans_novect_wt          
SVZ03_05-n2-WT-Ctrl     4 mono couches controles WT   cond3     03_05 n2           b0305n2   BF     ASOtrans       novect  WT        b0305n2_bf_asotrans_novect_wt          
SVZ22_03-WT-Ctrl        4 mono couches controles WT   cond3     22_03 n1           b2203n1   BF     ASOtrans       novect  WT        b2203n1_bf_asotrans_novect_wt          
SVZ02_05-n2-Scr         4 mono couches ASO scrumble   cond4     02_05 n2           b0205n2   BF     ASOtrans       scrumb  WT        b0205n2_bf_asotrans_scrumb_wt          
SVZ03_05-n1-Scr         4 mono couches ASO scrumble   cond4     03_05 n1           b0305n1   BF     ASOtrans       scrumb  WT        b0305n1_bf_asotrans_scrumb_wt          
SVZ03_05-n2-Scr         4 mono couches ASO scrumble   cond4     03_05 n2           b0305n2   BF     ASOtrans       scrumb  WT        b0305n2_bf_asotrans_scrumb_wt          
SVZ22_03-Scr            4 mono couches ASO scrumble   cond4     22_03 n1           b2203n1   BF     ASOtrans       scrumb  WT        b2203n1_bf_asotrans_scrumb_wt          
SVZ02_05-n2-PH1         4 mono couches ASO h1         cond5     02_05 n2           b0205n2   BF     ASOtrans       vecph1  WT        b0205n2_bf_asotrans_vecph1_wt          
SVZ03_05-n1-PH1         4 mono couches ASO h1         cond5     03_05 n1           b0305n1   BF     ASOtrans       vecph1  WT        b0305n1_bf_asotrans_vecph1_wt          
SVZ03_05-n2-PH1         4 mono couches ASO h1         cond5     03_05 n2           b0305n2   BF     ASOtrans       vecph1  WT        b0305n2_bf_asotrans_vecph1_wt          
SVZ22_03-PH1            4 mono couches ASO h1         cond5     22_03 n1           b2203n1   BF     ASOtrans       vecph1  WT        b2203n1_bf_asotrans_vecph1_wt          
SVZ24_02-spheres-WT     4 sphéroïdes contrôles        cond6     24_02 n1           b2402n1   EF     notransf       novect  WT        b2402n1_ef_notransf_novect_wt          
SVZ01_03-spheres-WT     4 sphéroïdes contrôles        cond6     01_03 n1           b0103n1   EF     notransf       novect  WT        b0103n1_ef_notransf_novect_wt          
SVZ03_03-spheres-WT     4 sphéroïdes contrôles        cond6     03_03 n1           b0303n1   EF     notransf       novect  WT        b0303n1_ef_notransf_novect_wt          
SVZ29_04-spheres-WT     4 sphéroïdes contrôles        cond6     29_04 n1           b2904n1   EF     notransf       novect  WT        b2904n1_ef_notransf_novect_wt          
SVZ24_02-spheres-HE     4 sphéroïdes Hunt. hétéroz.   cond7     24_02 n1           b2402n1   EF     notransf       novect  HE        b2402n1_ef_notransf_novect_he          
SVZ01_03-spheres-HE     4 sphéroïdes Hunt. hétéroz.   cond7     01_03 n1           b0103n1   EF     notransf       novect  HE        b0103n1_ef_notransf_novect_he          
SVZ03_03-spheres-HE     4 sphéroïdes Hunt. hétéroz.   cond7     03_03 n1           b0303n1   EF     notransf       novect  HE        b0303n1_ef_notransf_novect_he          
SVZ29_04-spheres-HE     4 sphéroïdes Hunt. hétéroz.   cond7     29_04 n1           b2904n1   EF     notransf       novect  HE        b2904n1_ef_notransf_novect_he          
SVZ24_02-spheres-HO     4 sphéroïdes Hunt. homoz.     cond8     24_02 n1           b2402n1   EF     notransf       novect  HO        b2402n1_ef_notransf_novect_ho          
SVZ29_04-spheres-HO     4 sphéroïdes Hunt. homoz.     cond8     29_04 n1           b2904n1   EF     notransf       novect  HO        b2904n1_ef_notransf_novect_ho          
SVZ01_03-spheres-HO     4 sphéroïdes Hunt. homoz.     cond8     01_03 n1           b0103n1   EF     notransf       novect  HO        b0103n1_ef_notransf_novect_ho          
SVZ03_03-spheres-HO     4 sphéroïdes Hunt. homoz.     cond8     03_03 n1           b0303n1   EF     notransf       novect  HO        b0303n1_ef_notransf_novect_ho          



- 4 sphéroïdes contrôles
- 4 sphéroïdes Hunt. hétéroz.
- 4 sphéroïdes Hunt. homoz.

SVZ24_02-spheres-WT_
SVZ01_03-spheres-WT_
SVZ03_03-spheres-WT_
SVZ29_04-spheres-WT_
SVZ24_02-spheres-HE_
SVZ01_03-spheres-HE_
SVZ03_03-spheres-HE_
SVZ29_04-spheres-HE_
SVZ24_02-spheres-HO_
SVZ29_04-spheres-HO_
SVZ01_03-spheres-HO_
SVZ03_03-spheres-HO_








rsync -auvP ~/projects/datashare/rnaseq_lafage_icm/raw/md5.icm.txt cargo:~/projects/datashare/rnaseq_lafage_icm/raw/AGASSE/Novaseq_240723/fastq_merged_lanes/.

cd ~/projects/datashare/rnaseq_lafage_icm/raw/AGASSE/Novaseq_240723/fastq_merged_lanes/
md5sum *.fastq.gz > md5.bettik.txt
cat md5.bettik.txt | cut -f1 -d" "  | sort > tmp.md5.bettik.txt
cat md5.icm.txt | grep -v fastq.gz | cut -f1 -d"\\" | tr '[:upper:]' '[:lower:]' | sort > tmp.md5.icm.txt
diff tmp.md5.icm.txt tmp.md5.bettik.txt




cd ~/projects/datashare/rnaseq_lafage_icm/raw
ls -lha AGASSE/Novaseq_240723/fastq_merged_lanes/*
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ13_01-WT-BF_R1.fastq.gz           b1301n1_bf_notransf_novect_wt_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ14_01-WT-BF_R1.fastq.gz           b1401n1_bf_notransf_novect_wt_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ16_12-WT-BF_R1.fastq.gz           b1612n1_bf_notransf_novect_wt_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ17_12-WT-BF_R1.fastq.gz           b1712n1_bf_notransf_novect_wt_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ13_01-HE-BF_R1.fastq.gz           b1301n1_bf_notransf_novect_he_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ14_01-HE-BF_R1.fastq.gz           b1401n1_bf_notransf_novect_he_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ16_12-HE-BF_R1.fastq.gz           b1612n1_bf_notransf_novect_he_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ17_12-HE-BF_R1.fastq.gz           b1712n1_bf_notransf_novect_he_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ02_05-n2-WT-Ctrl_R1.fastq.gz      b0205n2_bf_asotrans_novect_wt_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ03_05-n1-WT-Ctrl_R1.fastq.gz      b0305n1_bf_asotrans_novect_wt_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ03_05-n2-WT-Ctrl_R1.fastq.gz      b0305n2_bf_asotrans_novect_wt_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ22_03-WT-Ctrl_R1.fastq.gz         b2203n1_bf_asotrans_novect_wt_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ02_05-n2-Scr_R1.fastq.gz          b0205n2_bf_asotrans_scrumb_wt_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ03_05-n1-Scr_R1.fastq.gz          b0305n1_bf_asotrans_scrumb_wt_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ03_05-n2-Scr_R1.fastq.gz          b0305n2_bf_asotrans_scrumb_wt_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ22_03-Scr_R1.fastq.gz             b2203n1_bf_asotrans_scrumb_wt_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ02_05-n2-PH1_R1.fastq.gz          b0205n2_bf_asotrans_vecph1_wt_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ03_05-n1-PH1_R1.fastq.gz          b0305n1_bf_asotrans_vecph1_wt_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ03_05-n2-PH1_R1.fastq.gz          b0305n2_bf_asotrans_vecph1_wt_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ22_03-PH1_R1.fastq.gz             b2203n1_bf_asotrans_vecph1_wt_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ24_02-spheres-WT_R1.fastq.gz      b2402n1_ef_notransf_novect_wt_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ01_03-spheres-WT_R1.fastq.gz      b0103n1_ef_notransf_novect_wt_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ03_03-spheres-WT_R1.fastq.gz      b0303n1_ef_notransf_novect_wt_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ29_04-spheres-WT_R1.fastq.gz      b2904n1_ef_notransf_novect_wt_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ24_02-spheres-HE_R1.fastq.gz      b2402n1_ef_notransf_novect_he_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ01_03-spheres-HE_R1.fastq.gz      b0103n1_ef_notransf_novect_he_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ03_03-spheres-HE_R1.fastq.gz      b0303n1_ef_notransf_novect_he_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ29_04-spheres-HE_R1.fastq.gz      b2904n1_ef_notransf_novect_he_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ24_02-spheres-HO_R1.fastq.gz      b2402n1_ef_notransf_novect_ho_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ29_04-spheres-HO_R1.fastq.gz      b2904n1_ef_notransf_novect_ho_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ01_03-spheres-HO_R1.fastq.gz      b0103n1_ef_notransf_novect_ho_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ03_03-spheres-HO_R1.fastq.gz      b0303n1_ef_notransf_novect_ho_R1.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ13_01-WT-BF_R2.fastq.gz           b1301n1_bf_notransf_novect_wt_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ14_01-WT-BF_R2.fastq.gz           b1401n1_bf_notransf_novect_wt_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ16_12-WT-BF_R2.fastq.gz           b1612n1_bf_notransf_novect_wt_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ17_12-WT-BF_R2.fastq.gz           b1712n1_bf_notransf_novect_wt_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ13_01-HE-BF_R2.fastq.gz           b1301n1_bf_notransf_novect_he_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ14_01-HE-BF_R2.fastq.gz           b1401n1_bf_notransf_novect_he_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ16_12-HE-BF_R2.fastq.gz           b1612n1_bf_notransf_novect_he_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ17_12-HE-BF_R2.fastq.gz           b1712n1_bf_notransf_novect_he_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ02_05-n2-WT-Ctrl_R2.fastq.gz      b0205n2_bf_asotrans_novect_wt_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ03_05-n1-WT-Ctrl_R2.fastq.gz      b0305n1_bf_asotrans_novect_wt_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ03_05-n2-WT-Ctrl_R2.fastq.gz      b0305n2_bf_asotrans_novect_wt_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ22_03-WT-Ctrl_R2.fastq.gz         b2203n1_bf_asotrans_novect_wt_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ02_05-n2-Scr_R2.fastq.gz          b0205n2_bf_asotrans_scrumb_wt_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ03_05-n1-Scr_R2.fastq.gz          b0305n1_bf_asotrans_scrumb_wt_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ03_05-n2-Scr_R2.fastq.gz          b0305n2_bf_asotrans_scrumb_wt_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ22_03-Scr_R2.fastq.gz             b2203n1_bf_asotrans_scrumb_wt_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ02_05-n2-PH1_R2.fastq.gz          b0205n2_bf_asotrans_vecph1_wt_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ03_05-n1-PH1_R2.fastq.gz          b0305n1_bf_asotrans_vecph1_wt_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ03_05-n2-PH1_R2.fastq.gz          b0305n2_bf_asotrans_vecph1_wt_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ22_03-PH1_R2.fastq.gz             b2203n1_bf_asotrans_vecph1_wt_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ24_02-spheres-WT_R2.fastq.gz      b2402n1_ef_notransf_novect_wt_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ01_03-spheres-WT_R2.fastq.gz      b0103n1_ef_notransf_novect_wt_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ03_03-spheres-WT_R2.fastq.gz      b0303n1_ef_notransf_novect_wt_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ29_04-spheres-WT_R2.fastq.gz      b2904n1_ef_notransf_novect_wt_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ24_02-spheres-HE_R2.fastq.gz      b2402n1_ef_notransf_novect_he_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ01_03-spheres-HE_R2.fastq.gz      b0103n1_ef_notransf_novect_he_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ03_03-spheres-HE_R2.fastq.gz      b0303n1_ef_notransf_novect_he_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ29_04-spheres-HE_R2.fastq.gz      b2904n1_ef_notransf_novect_he_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ24_02-spheres-HO_R2.fastq.gz      b2402n1_ef_notransf_novect_ho_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ29_04-spheres-HO_R2.fastq.gz      b2904n1_ef_notransf_novect_ho_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ01_03-spheres-HO_R2.fastq.gz      b0103n1_ef_notransf_novect_ho_R2.fastq.gz
ln -s AGASSE/Novaseq_240723/fastq_merged_lanes/SVZ03_03-spheres-HO_R2.fastq.gz      b0303n1_ef_notransf_novect_ho_R2.fastq.gz


md5sum *.fastq.gz > md5.bettik.txt




cd ~/projects/datashare/rnaseq_lafage_icm



echo raw/b1301n1_bf_notransf_novect_wt_R1.fastq.gz raw/b1301n1_bf_notransf_novect_wt_R2.fastq.gz > b1301n1_bf_notransf_novect_wt_notrim_fqgz.info
echo raw/b1401n1_bf_notransf_novect_wt_R1.fastq.gz raw/b1401n1_bf_notransf_novect_wt_R2.fastq.gz > b1401n1_bf_notransf_novect_wt_notrim_fqgz.info
echo raw/b1612n1_bf_notransf_novect_wt_R1.fastq.gz raw/b1612n1_bf_notransf_novect_wt_R2.fastq.gz > b1612n1_bf_notransf_novect_wt_notrim_fqgz.info
echo raw/b1712n1_bf_notransf_novect_wt_R1.fastq.gz raw/b1712n1_bf_notransf_novect_wt_R2.fastq.gz > b1712n1_bf_notransf_novect_wt_notrim_fqgz.info
echo raw/b1301n1_bf_notransf_novect_he_R1.fastq.gz raw/b1301n1_bf_notransf_novect_he_R2.fastq.gz > b1301n1_bf_notransf_novect_he_notrim_fqgz.info
echo raw/b1401n1_bf_notransf_novect_he_R1.fastq.gz raw/b1401n1_bf_notransf_novect_he_R2.fastq.gz > b1401n1_bf_notransf_novect_he_notrim_fqgz.info
echo raw/b1612n1_bf_notransf_novect_he_R1.fastq.gz raw/b1612n1_bf_notransf_novect_he_R2.fastq.gz > b1612n1_bf_notransf_novect_he_notrim_fqgz.info
echo raw/b1712n1_bf_notransf_novect_he_R1.fastq.gz raw/b1712n1_bf_notransf_novect_he_R2.fastq.gz > b1712n1_bf_notransf_novect_he_notrim_fqgz.info
echo raw/b0205n2_bf_asotrans_novect_wt_R1.fastq.gz raw/b0205n2_bf_asotrans_novect_wt_R2.fastq.gz > b0205n2_bf_asotrans_novect_wt_notrim_fqgz.info
echo raw/b0305n1_bf_asotrans_novect_wt_R1.fastq.gz raw/b0305n1_bf_asotrans_novect_wt_R2.fastq.gz > b0305n1_bf_asotrans_novect_wt_notrim_fqgz.info
echo raw/b0305n2_bf_asotrans_novect_wt_R1.fastq.gz raw/b0305n2_bf_asotrans_novect_wt_R2.fastq.gz > b0305n2_bf_asotrans_novect_wt_notrim_fqgz.info
echo raw/b2203n1_bf_asotrans_novect_wt_R1.fastq.gz raw/b2203n1_bf_asotrans_novect_wt_R2.fastq.gz > b2203n1_bf_asotrans_novect_wt_notrim_fqgz.info
echo raw/b0205n2_bf_asotrans_scrumb_wt_R1.fastq.gz raw/b0205n2_bf_asotrans_scrumb_wt_R2.fastq.gz > b0205n2_bf_asotrans_scrumb_wt_notrim_fqgz.info
echo raw/b0305n1_bf_asotrans_scrumb_wt_R1.fastq.gz raw/b0305n1_bf_asotrans_scrumb_wt_R2.fastq.gz > b0305n1_bf_asotrans_scrumb_wt_notrim_fqgz.info
echo raw/b0305n2_bf_asotrans_scrumb_wt_R1.fastq.gz raw/b0305n2_bf_asotrans_scrumb_wt_R2.fastq.gz > b0305n2_bf_asotrans_scrumb_wt_notrim_fqgz.info
echo raw/b2203n1_bf_asotrans_scrumb_wt_R1.fastq.gz raw/b2203n1_bf_asotrans_scrumb_wt_R2.fastq.gz > b2203n1_bf_asotrans_scrumb_wt_notrim_fqgz.info
echo raw/b0205n2_bf_asotrans_vecph1_wt_R1.fastq.gz raw/b0205n2_bf_asotrans_vecph1_wt_R2.fastq.gz > b0205n2_bf_asotrans_vecph1_wt_notrim_fqgz.info
echo raw/b0305n1_bf_asotrans_vecph1_wt_R1.fastq.gz raw/b0305n1_bf_asotrans_vecph1_wt_R2.fastq.gz > b0305n1_bf_asotrans_vecph1_wt_notrim_fqgz.info
echo raw/b0305n2_bf_asotrans_vecph1_wt_R1.fastq.gz raw/b0305n2_bf_asotrans_vecph1_wt_R2.fastq.gz > b0305n2_bf_asotrans_vecph1_wt_notrim_fqgz.info
echo raw/b2203n1_bf_asotrans_vecph1_wt_R1.fastq.gz raw/b2203n1_bf_asotrans_vecph1_wt_R2.fastq.gz > b2203n1_bf_asotrans_vecph1_wt_notrim_fqgz.info
echo raw/b2402n1_ef_notransf_novect_wt_R1.fastq.gz raw/b2402n1_ef_notransf_novect_wt_R2.fastq.gz > b2402n1_ef_notransf_novect_wt_notrim_fqgz.info
echo raw/b0103n1_ef_notransf_novect_wt_R1.fastq.gz raw/b0103n1_ef_notransf_novect_wt_R2.fastq.gz > b0103n1_ef_notransf_novect_wt_notrim_fqgz.info
echo raw/b0303n1_ef_notransf_novect_wt_R1.fastq.gz raw/b0303n1_ef_notransf_novect_wt_R2.fastq.gz > b0303n1_ef_notransf_novect_wt_notrim_fqgz.info
echo raw/b2904n1_ef_notransf_novect_wt_R1.fastq.gz raw/b2904n1_ef_notransf_novect_wt_R2.fastq.gz > b2904n1_ef_notransf_novect_wt_notrim_fqgz.info
echo raw/b2402n1_ef_notransf_novect_he_R1.fastq.gz raw/b2402n1_ef_notransf_novect_he_R2.fastq.gz > b2402n1_ef_notransf_novect_he_notrim_fqgz.info
echo raw/b0103n1_ef_notransf_novect_he_R1.fastq.gz raw/b0103n1_ef_notransf_novect_he_R2.fastq.gz > b0103n1_ef_notransf_novect_he_notrim_fqgz.info
echo raw/b0303n1_ef_notransf_novect_he_R1.fastq.gz raw/b0303n1_ef_notransf_novect_he_R2.fastq.gz > b0303n1_ef_notransf_novect_he_notrim_fqgz.info
echo raw/b2904n1_ef_notransf_novect_he_R1.fastq.gz raw/b2904n1_ef_notransf_novect_he_R2.fastq.gz > b2904n1_ef_notransf_novect_he_notrim_fqgz.info
echo raw/b2402n1_ef_notransf_novect_ho_R1.fastq.gz raw/b2402n1_ef_notransf_novect_ho_R2.fastq.gz > b2402n1_ef_notransf_novect_ho_notrim_fqgz.info
echo raw/b2904n1_ef_notransf_novect_ho_R1.fastq.gz raw/b2904n1_ef_notransf_novect_ho_R2.fastq.gz > b2904n1_ef_notransf_novect_ho_notrim_fqgz.info
echo raw/b0103n1_ef_notransf_novect_ho_R1.fastq.gz raw/b0103n1_ef_notransf_novect_ho_R2.fastq.gz > b0103n1_ef_notransf_novect_ho_notrim_fqgz.info
echo raw/b0303n1_ef_notransf_novect_ho_R1.fastq.gz raw/b0303n1_ef_notransf_novect_ho_R2.fastq.gz > b0303n1_ef_notransf_novect_ho_notrim_fqgz.info






