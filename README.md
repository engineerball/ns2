NS2 Little Project 
------------------

1. AODV vs. DSR
2. AODV ที่ Hello Interval = 0.25, 0.5, 1, และ 2 วินาที
3. DSR vs. DSDV
4. AODV vs. DSDV

Condition
- Network ขนาด 1.5km x 1.5km
- ใช้ Constant Bit Rate Traffic (CBR) packet size = 512 Bytes, at 5 pkt/s (*CBR จะ run
บน UDP) ใช้ cbrgen.tcl เพื่อสร้าง traffic load โดยก าหนดให้มี 5 connections
- เดินทางแบบ Random-Way-Point โดยใช้ค าสั่ง setdest ในการสร้าง mobility trace ให้ pause
time = 0, 15, 30, 60, 150, 300 วินาที และความเร็วอยู่ระหว่าง 40km/hr -60km/hr
- จ านวนโหนด 25, 50, 100
- ให้ run simulation เป็นเวลา 5 นาที (simulated second)
- ให้ output ออกมาที่ myoutput.tr โดยให้มี trace ของ routing protocol ออกมาด้วย
