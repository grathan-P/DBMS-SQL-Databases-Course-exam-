# Order Database - Output Files (Tables Only)

## CUSTOMER Table

| CUSTID | CNAME | CITY |
|--------|-------|------|
| 1 | TOM | UDUPI |
| 2 | RAM | BNGLR |
| 3 | SEETHA | MNGLR |
| 4 | JIM | HUBLI |
| 5 | JOHN | GADAG |

---

## C_ORDER Table

| ORDERID | ODATE | CUSTID | ORDAMT |
|---------|-------|--------|--------|
| 101 | 2020-11-10 | 1 | NULL |
| 102 | 2020-12-10 | 1 | NULL |
| 103 | 2004-11-10 | 2 | NULL |
| 104 | 2020-11-10 | 3 | NULL |
| 105 | 2004-11-10 | 4 | NULL |

---

## ITEM Table

| ITEMID | PRICE |
|--------|-------|
| 21 | 40 |
| 22 | 50 |
| 23 | 60 |
| 24 | 70 |
| 25 | 20 |

---

## ORDERITEM Table

| ORDERID | ITEMID | QTY |
|---------|--------|-----|
| 101 | 21 | 2 |
| 101 | 22 | 3 |
| 102 | 23 | 2 |
| 102 | 24 | 1 |
| 102 | 25 | 2 |
| 103 | 21 | 2 |
| 105 | 21 | 5 |
| 104 | 25 | 2 |
| 105 | 23 | 2 |

---

## WAREHOUSE Table

| WARID | CITY |
|-------|------|
| 201 | UDUPI |
| 202 | UDUPI2 |
| 203 | UDUPI3 |
| 204 | UDUPI4 |
| 205 | UDUPI5 |

---

## SHIPMENT Table

| ORDERID | WARID | SHIPDATE |
|---------|-------|----------|
| 101 | 201 | 1090-09-17 |
| 101 | 202 | 1091-09-17 |
| 101 | 203 | 1090-08-17 |
| 103 | 201 | 1090-09-10 |
| 103 | 202 | 1070-09-17 |
| 105 | 201 | 1090-05-17 |
| 102 | 204 | 1098-09-17 |
| 102 | 201 | 1090-09-17 |
| 102 | 201 | 1090-09-17 |
| 104 | 201 | 1090-09-17 |

---

## Query 1 Result

| CUSTNAME | #OFORDERS | AVG_ORDER_AMT |
|----------|-----------|---------------|
| TOM | 2 | NULL |
| RAM | 1 | NULL |
| SEETHA | 1 | NULL |
| JIM | 1 | NULL |

---

## Query 2 Result

| ITEMID | num_orders | total_quantity |
|--------|-----------|-----------------|
| 21 | 3 | 15 |

---

## Query 3 Result

| CNAME |
|-------|
| TOM |
