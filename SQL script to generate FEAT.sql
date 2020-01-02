CREATE
  COLUMN TABLE "TEST"."RETAIL_BANK_CUSTOMER_BASE" ("KxId" BIGINT,
  "KxTimeStamp" TIMESTAMP,
  "SEX" VARCHAR(5),
  "BIRTH_DATE" DATE,
  "DISTRICT_NAME" VARCHAR(25),
  "REGION_NAME" VARCHAR(25),
  "NUMBER_INHABITANTS" INTEGER,
  "NUMBER_CITIES_1" INTEGER,
  "NUMBER_CITIES_2" INTEGER,
  "NUMBER_CITIES_3" INTEGER,
  "NUMBER_CITIES_4" INTEGER,
  "NUMBER_CITIES" INTEGER,
  "URBAN_RATIO" DOUBLE,
  "AVERAGE_SALARY" INTEGER,
  "UNEMP_RATE_95" DOUBLE,
  "UNEMP_RATE_96" DOUBLE,
  "RATIO_ENTREPRENEURS" INTEGER,
  "NUMBER_CRIMES_95" INTEGER,
  "NUMBER_CRIMES_96" INTEGER,
  "CLIENT_TYPE" VARCHAR(5),
  "ACCOUNT_ID_1" INTEGER,
  "FREQUENCY" VARCHAR(10),
  "ACCOUNT_DATE" DATE,
  "RefT4_kxrn0" BIGINT,
  PRIMARY KEY ("KxId",
  "KxTimeStamp",
  "ACCOUNT_ID_1")) ;

------ merge query --------------  
  INSERT
INTO
  "TEST"."RETAIL_BANK_CUSTOMER_BASE" select
    "CustomerPopulation"."KxId" as "KxId",
    to_timestamp('2010-10-01') as "KxTimeStamp",
    "CatalogRETAIL_BANKCLIENT"."SEX" as "SEX",
    "CatalogRETAIL_BANKCLIENT"."BIRTH_DATE" as "BIRTH_DATE",
    "CatalogRETAIL_BANKGEODEMO"."DISTRICT_NAME" as "DISTRICT_NAME",
    "CatalogRETAIL_BANKGEODEMO"."REGION_NAME" as "REGION_NAME",
    "CatalogRETAIL_BANKGEODEMO"."NUMBER_INHABITANTS" as "NUMBER_INHABITANTS",
    "CatalogRETAIL_BANKGEODEMO"."NUMBER_CITIES_1" as "NUMBER_CITIES_1",
    "CatalogRETAIL_BANKGEODEMO"."NUMBER_CITIES_2" as "NUMBER_CITIES_2",
    "CatalogRETAIL_BANKGEODEMO"."NUMBER_CITIES_3" as "NUMBER_CITIES_3",
    "CatalogRETAIL_BANKGEODEMO"."NUMBER_CITIES_4" as "NUMBER_CITIES_4",
    "CatalogRETAIL_BANKGEODEMO"."NUMBER_CITIES" as "NUMBER_CITIES",
    "CatalogRETAIL_BANKGEODEMO"."URBAN_RATIO" as "URBAN_RATIO",
    "CatalogRETAIL_BANKGEODEMO"."AVERAGE_SALARY" as "AVERAGE_SALARY",
    "CatalogRETAIL_BANKGEODEMO"."UNEMP_RATE_95" as "UNEMP_RATE_95",
    "CatalogRETAIL_BANKGEODEMO"."UNEMP_RATE_96" as "UNEMP_RATE_96",
    "CatalogRETAIL_BANKGEODEMO"."RATIO_ENTREPRENEURS" as "RATIO_ENTREPRENEURS",
    "CatalogRETAIL_BANKGEODEMO"."NUMBER_CRIMES_95" as "NUMBER_CRIMES_95",
    "CatalogRETAIL_BANKGEODEMO"."NUMBER_CRIMES_96" as "NUMBER_CRIMES_96",
    "CatalogRETAIL_BANKDISPOSITION"."CLIENT_TYPE" as "CLIENT_TYPE",
    "CatalogRETAIL_BANKACCOUNT"."ACCOUNT_ID" as "ACCOUNT_ID_1",
    "CatalogRETAIL_BANKACCOUNT"."FREQUENCY" as "FREQUENCY",
    "CatalogRETAIL_BANKACCOUNT"."ACCOUNT_DATE" as "ACCOUNT_DATE",
    "CatalogRETAIL_BANKACCOUNT"."RefT4_kxrn0"
  from
    (select "Customer"."KxId" as "KxId",
      to_timestamp('2010-10-01') as "KxTimeStamp"
    from
      (select "CatalogRETAIL_BANKCLIENT"."CLIENT_ID" as "KxId"
      from "RETAIL_BANK"."CLIENT" "CatalogRETAIL_BANKCLIENT") "Customer"
     ) "CustomerPopulation"
  left outer join
    "RETAIL_BANK"."CLIENT" "CatalogRETAIL_BANKCLIENT"
      on ( "CustomerPopulation"."KxId" = "CatalogRETAIL_BANKCLIENT"."CLIENT_ID" )
  left outer join
    "RETAIL_BANK"."GEODEMO" "CatalogRETAIL_BANKGEODEMO"
      on ( "CatalogRETAIL_BANKCLIENT"."HOME_GEOCODE_ID" = "CatalogRETAIL_BANKGEODEMO"."GEOCODE_ID"  )
  left outer join
    "RETAIL_BANK"."DISPOSITION" "CatalogRETAIL_BANKDISPOSITION"
      on ("CatalogRETAIL_BANKCLIENT"."CLIENT_ID" = "CatalogRETAIL_BANKDISPOSITION"."CLIENT_ID" )
  left outer join
    (
      select
        "RefT".*,
        row_number() over (partition
      by
        "RefT"."ACCOUNT_ID"
      order by
        "RefT"."ACCOUNT_ID" asc) as "RefT4_kxrn0"
      from
        "RETAIL_BANK"."ACCOUNT" "RefT"
    ) "CatalogRETAIL_BANKACCOUNT"
      on ("CatalogRETAIL_BANKDISPOSITION"."ACCOUNT_ID" = "CatalogRETAIL_BANKACCOUNT"."ACCOUNT_ID" ) ;
 
 ------ query for aggregate attributes ------------------------------
SELECT COUNT(*) FROM
(
   select
  "KXTempT1"."KxId" as "KxId",
  to_timestamp('2010-10-01') as "KxTimeStamp",
  "KXTempT1"."SEX" as "SEX",
  "KXTempT1"."DISTRICT_NAME" as "DISTRICT_NAME",
  "KXTempT1"."REGION_NAME" as "REGION_NAME",
  "KXTempT1"."NUMBER_INHABITANTS" as "NUMBER_INHABITANTS",
  "KXTempT1"."NUMBER_CITIES_1" as "NUMBER_CITIES_1",
  "KXTempT1"."NUMBER_CITIES_2" as "NUMBER_CITIES_2",
  "KXTempT1"."NUMBER_CITIES_3" as "NUMBER_CITIES_3",
  "KXTempT1"."NUMBER_CITIES_4" as "NUMBER_CITIES_4",
  "KXTempT1"."NUMBER_CITIES" as "NUMBER_CITIES",
  "KXTempT1"."URBAN_RATIO" as "URBAN_RATIO",
  "KXTempT1"."AVERAGE_SALARY" as "AVERAGE_SALARY",
  "KXTempT1"."UNEMP_RATE_95" as "UNEMP_RATE_95",
  "KXTempT1"."UNEMP_RATE_96" as "UNEMP_RATE_96",
  "KXTempT1"."RATIO_ENTREPRENEURS" as "RATIO_ENTREPRENEURS",
  "KXTempT1"."NUMBER_CRIMES_95" as "NUMBER_CRIMES_95",
  "KXTempT1"."NUMBER_CRIMES_96" as "NUMBER_CRIMES_96",
  "KXTempT1"."CLIENT_TYPE" as "CLIENT_TYPE",
  "KXTempT1"."FREQUENCY" as "FREQUENCY",
  floor(cast((days_between("KXTempT1"."ACCOUNT_DATE" ,
  to_timestamp('2010-10-01')) / 365) as double)) as "ACCOUNT_TENURE",
  floor(cast((days_between("KXTempT1"."BIRTH_DATE" ,
  to_timestamp('2010-10-01')) / 365) as double)) as "CUSTOMER_AGE",
  "CorrT1"."Expr_22" as "AGG_12M12B_TYPE_F_AVG_0_AMOUNT",
  "CorrT1"."Expr_23" as "AGG_12M12B_TYPE_C_AVG_0_AMOUNT",
  "CorrT1"."Expr_24" as "AGG_12M12B_TYPE_H_AVG_0_AMOUNT",
  "CorrT1"."Expr_25" as "AGG_12M12B_TYPE_P_AVG_0_AMOUNT",
  "CorrT1"."Expr_26" as "AGG_12M12B_AVG_0_AMOUNT",
  "CorrT1"."Expr_27" as "AGG_12M12B_TYPE_F_AVG_0_BALANCE",
  "CorrT1"."Expr_28" as "AGG_12M12B_TYPE_C_AVG_0_BALANCE",
  "CorrT1"."Expr_29" as "AGG_12M12B_TYPE_H_AVG_0_BALANCE",
  "CorrT1"."Expr_30" as "AGG_12M12B_TYPE_P_AVG_0_BALANCE",
  "CorrT1"."Expr_31" as "AGG_12M12B_AVG_0_BALANCE",
  "CorrT2"."Expr_34" as "AGG_12M12B_TYPE_F_AVG_1_AMOUNT",
  "CorrT2"."Expr_35" as "AGG_12M12B_TYPE_C_AVG_1_AMOUNT",
  "CorrT2"."Expr_36" as "AGG_12M12B_TYPE_H_AVG_1_AMOUNT",
  "CorrT2"."Expr_37" as "AGG_12M12B_TYPE_P_AVG_1_AMOUNT",
  "CorrT2"."Expr_38" as "AGG_12M12B_AVG_1_AMOUNT",
  "CorrT2"."Expr_39" as "AGG_12M12B_TYPE_F_AVG_1_BALANCE",
  "CorrT2"."Expr_40" as "AGG_12M12B_TYPE_C_AVG_1_BALANCE",
  "CorrT2"."Expr_41" as "AGG_12M12B_TYPE_H_AVG_1_BALANCE",
  "CorrT2"."Expr_42" as "AGG_12M12B_TYPE_P_AVG_1_BALANCE",
  "CorrT2"."Expr_43" as "AGG_12M12B_AVG_1_BALANCE",
  "CorrT3"."Expr_46" as "AGG_12M12B_TYPE_F_AVG_2_AMOUNT",
  "CorrT3"."Expr_47" as "AGG_12M12B_TYPE_C_AVG_2_AMOUNT",
  "CorrT3"."Expr_48" as "AGG_12M12B_TYPE_H_AVG_2_AMOUNT",
  "CorrT3"."Expr_49" as "AGG_12M12B_TYPE_P_AVG_2_AMOUNT",
  "CorrT3"."Expr_50" as "AGG_12M12B_AVG_2_AMOUNT",
  "CorrT3"."Expr_51" as "AGG_12M12B_TYPE_F_AVG_2_BALANCE",
  "CorrT3"."Expr_52" as "AGG_12M12B_TYPE_C_AVG_2_BALANCE",
  "CorrT3"."Expr_53" as "AGG_12M12B_TYPE_H_AVG_2_BALANCE",
  "CorrT3"."Expr_54" as "AGG_12M12B_TYPE_P_AVG_2_BALANCE",
  "CorrT3"."Expr_55" as "AGG_12M12B_AVG_2_BALANCE",
  "CorrT4"."Expr_58" as "AGG_12M12B_TYPE_F_AVG_3_AMOUNT",
  "CorrT4"."Expr_59" as "AGG_12M12B_TYPE_C_AVG_3_AMOUNT",
  "CorrT4"."Expr_60" as "AGG_12M12B_TYPE_H_AVG_3_AMOUNT",
  "CorrT4"."Expr_61" as "AGG_12M12B_TYPE_P_AVG_3_AMOUNT",
  "CorrT4"."Expr_62" as "AGG_12M12B_AVG_3_AMOUNT",
  "CorrT4"."Expr_63" as "AGG_12M12B_TYPE_F_AVG_3_BALANCE",
  "CorrT4"."Expr_64" as "AGG_12M12B_TYPE_C_AVG_3_BALANCE",
  "CorrT4"."Expr_65" as "AGG_12M12B_TYPE_H_AVG_3_BALANCE",
  "CorrT4"."Expr_66" as "AGG_12M12B_TYPE_P_AVG_3_BALANCE",
  "CorrT4"."Expr_67" as "AGG_12M12B_AVG_3_BALANCE",
  "CorrT5"."Expr_70" as "AGG_12M12B_TYPE_F_AVG_4_AMOUNT",
  "CorrT5"."Expr_71" as "AGG_12M12B_TYPE_C_AVG_4_AMOUNT",
  "CorrT5"."Expr_72" as "AGG_12M12B_TYPE_H_AVG_4_AMOUNT",
  "CorrT5"."Expr_73" as "AGG_12M12B_TYPE_P_AVG_4_AMOUNT",
  "CorrT5"."Expr_74" as "AGG_12M12B_AVG_4_AMOUNT",
  "CorrT5"."Expr_75" as "AGG_12M12B_TYPE_F_AVG_4_BALANCE",
  "CorrT5"."Expr_76" as "AGG_12M12B_TYPE_C_AVG_4_BALANCE",
  "CorrT5"."Expr_77" as "AGG_12M12B_TYPE_H_AVG_4_BALANCE",
  "CorrT5"."Expr_78" as "AGG_12M12B_TYPE_P_AVG_4_BALANCE",
  "CorrT5"."Expr_79" as "AGG_12M12B_AVG_4_BALANCE",
  "CorrT6"."Expr_82" as "AGG_12M12B_TYPE_F_AVG_5_AMOUNT",
  "CorrT6"."Expr_83" as "AGG_12M12B_TYPE_C_AVG_5_AMOUNT",
  "CorrT6"."Expr_84" as "AGG_12M12B_TYPE_H_AVG_5_AMOUNT",
  "CorrT6"."Expr_85" as "AGG_12M12B_TYPE_P_AVG_5_AMOUNT",
  "CorrT6"."Expr_86" as "AGG_12M12B_AVG_5_AMOUNT",
  "CorrT6"."Expr_87" as "AGG_12M12B_TYPE_F_AVG_5_BALANCE",
  "CorrT6"."Expr_88" as "AGG_12M12B_TYPE_C_AVG_5_BALANCE",
  "CorrT6"."Expr_89" as "AGG_12M12B_TYPE_H_AVG_5_BALANCE",
  "CorrT6"."Expr_90" as "AGG_12M12B_TYPE_P_AVG_5_BALANCE",
  "CorrT6"."Expr_91" as "AGG_12M12B_AVG_5_BALANCE",
  "CorrT7"."Expr_94" as "AGG_12M12B_TYPE_F_AVG_6_AMOUNT",
  "CorrT7"."Expr_95" as "AGG_12M12B_TYPE_C_AVG_6_AMOUNT",
  "CorrT7"."Expr_96" as "AGG_12M12B_TYPE_H_AVG_6_AMOUNT",
  "CorrT7"."Expr_97" as "AGG_12M12B_TYPE_P_AVG_6_AMOUNT",
  "CorrT7"."Expr_98" as "AGG_12M12B_AVG_6_AMOUNT",
  "CorrT7"."Expr_99" as "AGG_12M12B_TYPE_F_AVG_6_BALANCE",
  "CorrT7"."Expr_100" as "AGG_12M12B_TYPE_C_AVG_6_BALANCE",
  "CorrT7"."Expr_101" as "AGG_12M12B_TYPE_H_AVG_6_BALANCE",
  "CorrT7"."Expr_102" as "AGG_12M12B_TYPE_P_AVG_6_BALANCE",
  "CorrT7"."Expr_103" as "AGG_12M12B_AVG_6_BALANCE",
  "CorrT8"."Expr_106" as "AGG_12M12B_TYPE_F_AVG_7_AMOUNT",
  "CorrT8"."Expr_107" as "AGG_12M12B_TYPE_C_AVG_7_AMOUNT",
  "CorrT8"."Expr_108" as "AGG_12M12B_TYPE_H_AVG_7_AMOUNT",
  "CorrT8"."Expr_109" as "AGG_12M12B_TYPE_P_AVG_7_AMOUNT",
  "CorrT8"."Expr_110" as "AGG_12M12B_AVG_7_AMOUNT",
  "CorrT8"."Expr_111" as "AGG_12M12B_TYPE_F_AVG_7_BALANCE",
  "CorrT8"."Expr_112" as "AGG_12M12B_TYPE_C_AVG_7_BALANCE",
  "CorrT8"."Expr_113" as "AGG_12M12B_TYPE_H_AVG_7_BALANCE",
  "CorrT8"."Expr_114" as "AGG_12M12B_TYPE_P_AVG_7_BALANCE",
  "CorrT8"."Expr_115" as "AGG_12M12B_AVG_7_BALANCE",
  "CorrT9"."Expr_118" as "AGG_12M12B_TYPE_F_AVG_8_AMOUNT",
  "CorrT9"."Expr_119" as "AGG_12M12B_TYPE_C_AVG_8_AMOUNT",
  "CorrT9"."Expr_120" as "AGG_12M12B_TYPE_H_AVG_8_AMOUNT",
  "CorrT9"."Expr_121" as "AGG_12M12B_TYPE_P_AVG_8_AMOUNT",
  "CorrT9"."Expr_122" as "AGG_12M12B_AVG_8_AMOUNT",
  "CorrT9"."Expr_123" as "AGG_12M12B_TYPE_F_AVG_8_BALANCE",
  "CorrT9"."Expr_124" as "AGG_12M12B_TYPE_C_AVG_8_BALANCE",
  "CorrT9"."Expr_125" as "AGG_12M12B_TYPE_H_AVG_8_BALANCE",
  "CorrT9"."Expr_126" as "AGG_12M12B_TYPE_P_AVG_8_BALANCE",
  "CorrT9"."Expr_127" as "AGG_12M12B_AVG_8_BALANCE",
  "CorrT10"."Expr_130" as "AGG_12M12B_TYPE_F_AVG_9_AMOUNT",
  "CorrT10"."Expr_131" as "AGG_12M12B_TYPE_C_AVG_9_AMOUNT",
  "CorrT10"."Expr_132" as "AGG_12M12B_TYPE_H_AVG_9_AMOUNT",
  "CorrT10"."Expr_133" as "AGG_12M12B_TYPE_P_AVG_9_AMOUNT",
  "CorrT10"."Expr_134" as "AGG_12M12B_AVG_9_AMOUNT",
  "CorrT10"."Expr_135" as "AGG_12M12B_TYPE_F_AVG_9_BALANCE",
  "CorrT10"."Expr_136" as "AGG_12M12B_TYPE_C_AVG_9_BALANCE",
  "CorrT10"."Expr_137" as "AGG_12M12B_TYPE_H_AVG_9_BALANCE",
  "CorrT10"."Expr_138" as "AGG_12M12B_TYPE_P_AVG_9_BALANCE",
  "CorrT10"."Expr_139" as "AGG_12M12B_AVG_9_BALANCE",
  "CorrT11"."Expr_142" as "AGG_12M12B_TYPE_F_AVG_10_AMOUNT",
  "CorrT11"."Expr_143" as "AGG_12M12B_TYPE_C_AVG_10_AMOUNT",
  "CorrT11"."Expr_144" as "AGG_12M12B_TYPE_H_AVG_10_AMOUNT",
  "CorrT11"."Expr_145" as "AGG_12M12B_TYPE_P_AVG_10_AMOUNT",
  "CorrT11"."Expr_146" as "AGG_12M12B_AVG_10_AMOUNT",
  "CorrT11"."Expr_147" as "AGG_12M12B_TYPE_F_AVG_10_BALANCE",
  "CorrT11"."Expr_148" as "AGG_12M12B_TYPE_C_AVG_10_BALANCE",
  "CorrT11"."Expr_149" as "AGG_12M12B_TYPE_H_AVG_10_BALANCE",
  "CorrT11"."Expr_150" as "AGG_12M12B_TYPE_P_AVG_10_BALANCE",
  "CorrT11"."Expr_151" as "AGG_12M12B_AVG_10_BALANCE",
  "CorrT12"."Expr_152" as "AGG_12M12B_TYPE_F_AVG_11_AMOUNT",
  "CorrT12"."Expr_153" as "AGG_12M12B_TYPE_C_AVG_11_AMOUNT",
  "CorrT12"."Expr_154" as "AGG_12M12B_TYPE_H_AVG_11_AMOUNT",
  "CorrT12"."Expr_155" as "AGG_12M12B_TYPE_P_AVG_11_AMOUNT",
  "CorrT12"."Expr_156" as "AGG_12M12B_AVG_11_AMOUNT",
  "CorrT12"."Expr_157" as "AGG_12M12B_TYPE_F_AVG_11_BALANCE",
  "CorrT12"."Expr_158" as "AGG_12M12B_TYPE_C_AVG_11_BALANCE",
  "CorrT12"."Expr_159" as "AGG_12M12B_TYPE_H_AVG_11_BALANCE",
  "CorrT12"."Expr_160" as "AGG_12M12B_TYPE_P_AVG_11_BALANCE",
  "CorrT12"."Expr_161" as "AGG_12M12B_AVG_11_BALANCE",
  case
    when ("CorrT1"."Expr_31"<>0 ) then ("CorrT1"."Expr_26" / "CorrT1"."Expr_31")
    else NULL
  end as "RATIO_0",
  case
    when ("CorrT11"."Expr_151"<>0 ) then ("CorrT11"."Expr_146" / "CorrT11"."Expr_151")
    else NULL
  end as "RATIO_10",
  case
    when ("CorrT12"."Expr_161"<>0 ) then ("CorrT12"."Expr_156" / "CorrT12"."Expr_161")
    else NULL
  end as "RATIO_11",
  case
    when ("CorrT2"."Expr_43"<>0 ) then ("CorrT2"."Expr_38" / "CorrT2"."Expr_43")
    else NULL
  end as "RATIO_1",
  case
    when ("CorrT3"."Expr_55"<>0 ) then ("CorrT3"."Expr_50" / "CorrT3"."Expr_55")
    else NULL
  end as "RATIO_2",
  case
    when ("CorrT4"."Expr_67"<>0 ) then ("CorrT4"."Expr_62" / "CorrT4"."Expr_67")
    else NULL
  end as "RATIO_3",
  case
    when ("CorrT5"."Expr_79"<>0 ) then ("CorrT5"."Expr_74" / "CorrT5"."Expr_79")
    else NULL
  end as "RATIO_4",
  case
    when ("CorrT6"."Expr_91"<>0 ) then ("CorrT6"."Expr_86" / "CorrT6"."Expr_91")
    else NULL
  end as "RATIO_5",
  case
    when ("CorrT7"."Expr_103"<>0 ) then ("CorrT7"."Expr_98" / "CorrT7"."Expr_103")
    else NULL
  end as "RATIO_6",
  case
    when ("CorrT8"."Expr_115"<>0 ) then ("CorrT8"."Expr_110" / "CorrT8"."Expr_115")
    else NULL
  end as "RATIO_7",
  case
    when ("CorrT9"."Expr_127"<>0 ) then ("CorrT9"."Expr_122" / "CorrT9"."Expr_127")
    else NULL
  end as "RATIO_8",
  case
    when ("CorrT10"."Expr_139"<>0 ) then ("CorrT10"."Expr_134" / "CorrT10"."Expr_139")
    else NULL
  end as "RATIO_9"
from
  "TEST"."RETAIL_BANK_CUSTOMER_BASE" "KXTempT1"
left outer join
  (
    select
      row_number() over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0"
    order by
      "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" asc) as "rn",
      "KXTempT1"."RefT4_kxrn0" as "RefT4_kxrn0",
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" as "JKey",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_25",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_30",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_24",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_29",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_22",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_27",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_23",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_28",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_26",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."BALANCE") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_31"
    from
      "TEST"."RETAIL_BANK_CUSTOMER_BASE" "KXTempT1",
      "RETAIL_BANK"."TRANSACTIONS" "CatalogRETAIL_BANKTRANSACTIONS"
    where
      (
        (
          "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" = "KXTempT1"."ACCOUNT_ID_1"
        )
        and (
          (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" >= add_months(to_timestamp('2010-10-01') , -12)
          )
          and (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" < add_months(to_timestamp('2010-10-01') , -11)
          )
        )
      )
  ) "CorrT1"
    on (
      (
        "CorrT1"."JKey" = "KXTempT1"."ACCOUNT_ID_1"
      )
      and (
        "KXTempT1"."RefT4_kxrn0" = "CorrT1"."RefT4_kxrn0"
      )
      and (
        "CorrT1"."rn" = 1
      )
    )
left outer join
  (
    select
      row_number() over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0"
    order by
      "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" asc) as "rn",
      "KXTempT1"."RefT4_kxrn0" as "RefT4_kxrn0",
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" as "JKey",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_37",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_42",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_36",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_41",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_34",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_39",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_35",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_40",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_38",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."BALANCE") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_43"
    from
      "TEST"."RETAIL_BANK_CUSTOMER_BASE" "KXTempT1",
      "RETAIL_BANK"."TRANSACTIONS" "CatalogRETAIL_BANKTRANSACTIONS"
    where
      (
        (
          "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" = "KXTempT1"."ACCOUNT_ID_1"
        )
        and (
          (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" >= add_months(to_timestamp('2010-10-01') , -11)
          )
          and (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" < add_months(to_timestamp('2010-10-01') , -10)
          )
        )
      )
  ) "CorrT2"
    on (
      (
        "CorrT2"."JKey" = "KXTempT1"."ACCOUNT_ID_1"
      )
      and (
        "KXTempT1"."RefT4_kxrn0" = "CorrT2"."RefT4_kxrn0"
      )
      and (
        "CorrT2"."rn" = 1
      )
    )
left outer join
  (
    select
      row_number() over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0"
    order by
      "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" asc) as "rn",
      "KXTempT1"."RefT4_kxrn0" as "RefT4_kxrn0",
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" as "JKey",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_49",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_54",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_48",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_53",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_46",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_51",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_47",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_52",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_50",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."BALANCE") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_55"
    from
      "TEST"."RETAIL_BANK_CUSTOMER_BASE" "KXTempT1",
      "RETAIL_BANK"."TRANSACTIONS" "CatalogRETAIL_BANKTRANSACTIONS"
    where
      (
        (
          "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" = "KXTempT1"."ACCOUNT_ID_1"
        )
        and (
          (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" >= add_months(to_timestamp('2010-10-01') , -10)
          )
          and (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" < add_months(to_timestamp('2010-10-01') , -9)
          )
        )
      )
  ) "CorrT3"
    on (
      (
        "CorrT3"."JKey" = "KXTempT1"."ACCOUNT_ID_1"
      )
      and (
        "KXTempT1"."RefT4_kxrn0" = "CorrT3"."RefT4_kxrn0"
      )
      and (
        "CorrT3"."rn" = 1
      )
    )
left outer join
  (
    select
      row_number() over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0"
    order by
      "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" asc) as "rn",
      "KXTempT1"."RefT4_kxrn0" as "RefT4_kxrn0",
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" as "JKey",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_61",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_66",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_60",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_65",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_58",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_63",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_59",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_64",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_62",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."BALANCE") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_67"
    from
      "TEST"."RETAIL_BANK_CUSTOMER_BASE" "KXTempT1",
      "RETAIL_BANK"."TRANSACTIONS" "CatalogRETAIL_BANKTRANSACTIONS"
    where
      (
        (
          "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" = "KXTempT1"."ACCOUNT_ID_1"
        )
        and (
          (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" >= add_months(to_timestamp('2010-10-01') , -9)
          )
          and (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" < add_months(to_timestamp('2010-10-01') , -8)
          )
        )
      )
  ) "CorrT4"
    on (
      (
        "CorrT4"."JKey" = "KXTempT1"."ACCOUNT_ID_1"
      )
      and (
        "KXTempT1"."RefT4_kxrn0" = "CorrT4"."RefT4_kxrn0"
      )
      and (
        "CorrT4"."rn" = 1
      )
    )
left outer join
  (
    select
      row_number() over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0"
    order by
      "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" asc) as "rn",
      "KXTempT1"."RefT4_kxrn0" as "RefT4_kxrn0",
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" as "JKey",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_73",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_78",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_72",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_77",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_70",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_75",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_71",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_76",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_74",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."BALANCE") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_79"
    from
      "TEST"."RETAIL_BANK_CUSTOMER_BASE" "KXTempT1",
      "RETAIL_BANK"."TRANSACTIONS" "CatalogRETAIL_BANKTRANSACTIONS"
    where
      (
        (
          "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" = "KXTempT1"."ACCOUNT_ID_1"
        )
        and (
          (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" >= add_months(to_timestamp('2010-10-01') , -8)
          )
          and (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" < add_months(to_timestamp('2010-10-01') , -7)
          )
        )
      )
  ) "CorrT5"
    on (
      (
        "CorrT5"."JKey" = "KXTempT1"."ACCOUNT_ID_1"
      )
      and (
        "KXTempT1"."RefT4_kxrn0" = "CorrT5"."RefT4_kxrn0"
      )
      and (
        "CorrT5"."rn" = 1
      )
    )
left outer join
  (
    select
      row_number() over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0"
    order by
      "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" asc) as "rn",
      "KXTempT1"."RefT4_kxrn0" as "RefT4_kxrn0",
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" as "JKey",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_85",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_90",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_84",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_89",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_82",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_87",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_83",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_88",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_86",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."BALANCE") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_91"
    from
      "TEST"."RETAIL_BANK_CUSTOMER_BASE" "KXTempT1",
      "RETAIL_BANK"."TRANSACTIONS" "CatalogRETAIL_BANKTRANSACTIONS"
    where
      (
        (
          "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" = "KXTempT1"."ACCOUNT_ID_1"
        )
        and (
          (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" >= add_months(to_timestamp('2010-10-01') , -7)
          )
          and (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" < add_months(to_timestamp('2010-10-01') , -6)
          )
        )
      )
  ) "CorrT6"
    on (
      (
        "CorrT6"."JKey" = "KXTempT1"."ACCOUNT_ID_1"
      )
      and (
        "KXTempT1"."RefT4_kxrn0" = "CorrT6"."RefT4_kxrn0"
      )
      and (
        "CorrT6"."rn" = 1
      )
    )
left outer join
  (
    select
      row_number() over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0"
    order by
      "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" asc) as "rn",
      "KXTempT1"."RefT4_kxrn0" as "RefT4_kxrn0",
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" as "JKey",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_97",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_102",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_96",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_101",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_94",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_99",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_95",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_100",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_98",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."BALANCE") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_103"
    from
      "TEST"."RETAIL_BANK_CUSTOMER_BASE" "KXTempT1",
      "RETAIL_BANK"."TRANSACTIONS" "CatalogRETAIL_BANKTRANSACTIONS"
    where
      (
        (
          "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" = "KXTempT1"."ACCOUNT_ID_1"
        )
        and (
          (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" >= add_months(to_timestamp('2010-10-01') , -6)
          )
          and (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" < add_months(to_timestamp('2010-10-01') , -5)
          )
        )
      )
  ) "CorrT7"
    on (
      (
        "CorrT7"."JKey" = "KXTempT1"."ACCOUNT_ID_1"
      )
      and (
        "KXTempT1"."RefT4_kxrn0" = "CorrT7"."RefT4_kxrn0"
      )
      and (
        "CorrT7"."rn" = 1
      )
    )
left outer join
  (
    select
      row_number() over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0"
    order by
      "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" asc) as "rn",
      "KXTempT1"."RefT4_kxrn0" as "RefT4_kxrn0",
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" as "JKey",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_109",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_114",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_108",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_113",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_106",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_111",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_107",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_112",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_110",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."BALANCE") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_115"
    from
      "TEST"."RETAIL_BANK_CUSTOMER_BASE" "KXTempT1",
      "RETAIL_BANK"."TRANSACTIONS" "CatalogRETAIL_BANKTRANSACTIONS"
    where
      (
        (
          "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" = "KXTempT1"."ACCOUNT_ID_1"
        )
        and (
          (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" >= add_months(to_timestamp('2010-10-01') , -5)
          )
          and (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" < add_months(to_timestamp('2010-10-01') , -4)
          )
        )
      )
  ) "CorrT8"
    on (
      (
        "CorrT8"."JKey" = "KXTempT1"."ACCOUNT_ID_1"
      )
      and (
        "KXTempT1"."RefT4_kxrn0" = "CorrT8"."RefT4_kxrn0"
      )
      and (
        "CorrT8"."rn" = 1
      )
    )
left outer join
  (
    select
      row_number() over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0"
    order by
      "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" asc) as "rn",
      "KXTempT1"."RefT4_kxrn0" as "RefT4_kxrn0",
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" as "JKey",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_121",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_126",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_120",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_125",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_118",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_123",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_119",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_124",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_122",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."BALANCE") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_127"
    from
      "TEST"."RETAIL_BANK_CUSTOMER_BASE" "KXTempT1",
      "RETAIL_BANK"."TRANSACTIONS" "CatalogRETAIL_BANKTRANSACTIONS"
    where
      (
        (
          "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" = "KXTempT1"."ACCOUNT_ID_1"
        )
        and (
          (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" >= add_months(to_timestamp('2010-10-01') , -4)
          )
          and (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" < add_months(to_timestamp('2010-10-01') , -3)
          )
        )
      )
  ) "CorrT9"
    on (
      (
        "CorrT9"."JKey" = "KXTempT1"."ACCOUNT_ID_1"
      )
      and (
        "KXTempT1"."RefT4_kxrn0" = "CorrT9"."RefT4_kxrn0"
      )
      and (
        "CorrT9"."rn" = 1
      )
    )
left outer join
  (
    select
      row_number() over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0"
    order by
      "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" asc) as "rn",
      "KXTempT1"."RefT4_kxrn0" as "RefT4_kxrn0",
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" as "JKey",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_133",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_138",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_132",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_137",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_130",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_135",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_131",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_136",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_134",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."BALANCE") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_139"
    from
      "TEST"."RETAIL_BANK_CUSTOMER_BASE" "KXTempT1",
      "RETAIL_BANK"."TRANSACTIONS" "CatalogRETAIL_BANKTRANSACTIONS"
    where
      (
        (
          "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" = "KXTempT1"."ACCOUNT_ID_1"
        )
        and (
          (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" >= add_months(to_timestamp('2010-10-01') , -3)
          )
          and (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" < add_months(to_timestamp('2010-10-01') , -2)
          )
        )
      )
  ) "CorrT10"
    on (
      (
        "CorrT10"."JKey" = "KXTempT1"."ACCOUNT_ID_1"
      )
      and (
        "KXTempT1"."RefT4_kxrn0" = "CorrT10"."RefT4_kxrn0"
      )
      and (
        "CorrT10"."rn" = 1
      )
    )
left outer join
  (
    select
      row_number() over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0"
    order by
      "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" asc) as "rn",
      "KXTempT1"."RefT4_kxrn0" as "RefT4_kxrn0",
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" as "JKey",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_145",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_150",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_144",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_149",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_142",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_147",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_143",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_148",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_146",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."BALANCE") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_151"
    from
      "TEST"."RETAIL_BANK_CUSTOMER_BASE" "KXTempT1",
      "RETAIL_BANK"."TRANSACTIONS" "CatalogRETAIL_BANKTRANSACTIONS"
    where
      (
        (
          "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" = "KXTempT1"."ACCOUNT_ID_1"
        )
        and (
          (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" >= add_months(to_timestamp('2010-10-01') , -2)
          )
          and (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" < add_months(to_timestamp('2010-10-01') , -1)
          )
        )
      )
  ) "CorrT11"
    on (
      (
        "CorrT11"."JKey" = "KXTempT1"."ACCOUNT_ID_1"
      )
      and (
        "KXTempT1"."RefT4_kxrn0" = "CorrT11"."RefT4_kxrn0"
      )
      and (
        "CorrT11"."rn" = 1
      )
    )
left outer join
  (
    select
      row_number() over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0"
    order by
      "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" asc) as "rn",
      "KXTempT1"."RefT4_kxrn0" as "RefT4_kxrn0",
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" as "JKey",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_155",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'P')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_160",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_154",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'H')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_159",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_152",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'F')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_157",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_153",
      avg( case
        when ("CatalogRETAIL_BANKTRANSACTIONS"."TYPE" in (N'C')) then "CatalogRETAIL_BANKTRANSACTIONS"."BALANCE"
        else NULL
      end ) over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_158",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."AMOUNT") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_156",
      avg("CatalogRETAIL_BANKTRANSACTIONS"."BALANCE") over (partition
    by
      "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID",
      "KXTempT1"."RefT4_kxrn0") as "Expr_161"
    from
      "TEST"."RETAIL_BANK_CUSTOMER_BASE" "KXTempT1",
      "RETAIL_BANK"."TRANSACTIONS" "CatalogRETAIL_BANKTRANSACTIONS"
    where
      (
        (
          "CatalogRETAIL_BANKTRANSACTIONS"."ACCOUNT_ID" = "KXTempT1"."ACCOUNT_ID_1"
        )
        and (
          (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" >= add_months(to_timestamp('2010-10-01') , -1)
          )
          and (
            "CatalogRETAIL_BANKTRANSACTIONS"."DATE_TRANSACTION" < to_timestamp('2010-10-01')
          )
        )
      )
  ) "CorrT12"
    on (
      (
        "CorrT12"."JKey" = "KXTempT1"."ACCOUNT_ID_1"
      )
      and (
        "KXTempT1"."RefT4_kxrn0" = "CorrT12"."RefT4_kxrn0"
      )
      and (
        "CorrT12"."rn" = 1
      )
    ) ;
