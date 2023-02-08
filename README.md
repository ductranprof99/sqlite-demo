# Very big note here:
This is my first time working with sqlite in ios (for real, the last time i use sql when i need to do some the assignment in university)
So i accept any jugdement, and also any helpful comment cus i'm stuck to understand how `Expression` in SQLite library work (not like wrapper, and also cannot convert back to string)
Thank you for create an opportunity for me to learning this, but still i'm prefer something not SQL like 

## I. Trường hợp 1: Từ version 1 sang version 2
Note: Trong mọi trường hợp migrate, nên tạo một backup cho database.
Duplicate database script: sqlite3 old.db ".dump mytable" | sqlite3 new.db

1. Update database script:
Hai column thay doi:
Wallet: - "balance": INTEGER to TEXT
        - "pendingBalance"  INTEGER to TEXT

Phương pháp migrate 1: Sử dụng temporary table để migrate

```SQL
ALTER TABLE wallet RENAME TO temp_wallet;
CREATE TABLE wallet (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  address TEXT,
  name TEXT,
  balance TEXT,
  pendingBalance TEXT
);

INSERT INTO wallet (id, address, balance, pendingBalance)
SELECT id, address, balance, pendingBalance
FROM temp_wallet;
DROP TABLE temp_wallet;
```
Phương pháp migrate 2: Insert trực tiếp 
- suggestion 1: sử dụng backup của version 1 làm chính version 1 sau khi insert
- Suggestion 2: sử dụng cho trường hợp đã có nhiều data trong database

```SQL
ALTER TABLE wallet ADD COLUMN name TEXT;
```

Với bảng transaction, chỉ cần thêm 2 cột là data và totalBalance

```SQL
ALTER TABLE transaction ADD COLUMN data TEXT;
ALTER TABLE transaction ADD COLUMN totalBalance TEXT;
```

2. Verify data integrity ( check datatype)

---------
## II. Trường hợp 2: Từ version 2.0 sang 3.0

Upgrade script:

Bảng wallet chỉ thêm 1 cột -> Sử dụng duplicate sau đó insert trực tiếp:
ALTER TABLE wallet ADD COLUMN totalBalance TEXT

Thêm bảng node: 
```SQL
CREATE TABLE node (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  ip TEXT, 
  port INTEGER, 
  time INTEGER
);
```

----------
## III. Trường hợp 3: Từ version 1.0 sang 3.0
Thực hiện đồng thời giải pháp tối ưu nhất upgrade từ version 1 sang version 2, sau đó

1. Duplicate database

2. Thêm bảng node

3. Thêm column cho bảng transaction

```SQL
ALTER TABLE transaction ADD COLUMN data TEXT;
ALTER TABLE transaction ADD COLUMN totalBalance TEXT;
```

4. Tạo bảng mới sau đó insert từ bảng temporary cũ qua

```SQL
ALTER TABLE wallet RENAME TO temp_wallet;
CREATE TABLE wallet (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  address TEXT,
  name TEXT,
  balance TEXT,
  pendingBalance TEXT,
  totalBalance TEXT
);

INSERT INTO wallet (id, address, balance, pendingBalance)
SELECT id, address, balance, pendingBalance
FROM temp_wallet;
DROP TABLE temp_wallet;
```
