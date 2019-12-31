# INFOSYS-D-19-00090


## Preparation Steps

* Create three tables using queries in `create tables.sql`
* Create a dimension view with hierarchy defined.
* Complete table `"SCH_COMP"."sap.hana.im.ess.eg.deploy.hier::ATTRIBUTE_GRAPH_NODES"` with attributes in the defined hierarchy.



## Computation Steps
* Run the procedure `COMPUTE_ATTRIBUTE_GRAPH.hdbprocedure` with input parameter **HIERARCHY_ID**
* The attribute graph will be stored in table `"SCH_COMP"."sap.hana.im.ess.eg.deploy.hier::ATTRIBUTE_GRAPH_EDGES" `.

## Example
Dimension **TIME** (DAY -> MONTH -> YEAR), you need to insert following tuples into table `"SCH_COMP"."sap.hana.im.ess.eg.deploy.hier::ATTRIBUTE_GRAPH_NODES"` :

| HIERARCHY_ID | NAME | LEVEL_NUM |
| :- | :- | :- |
| 1 | DAY | 3 |
| 1 | MONTH | 2|
| 1 | YEAR  | 1|

Run the procedure `COMPUTE_ATTRIBUTE_GRAPH.hdbprocedure` with input parameter **HIERARCHY_ID = 1**, and the attribute graph is:

| HIERARCHY_ID | ATT_NAME | PARENT_ATT_NAME | LABEL |
| :-| :- | :- |:- |
|1 | DAY | MONTH | 'f' |
|1 | MONTH | YEAR | '+' |
|1 | DAY | YEAR | 'f' |
