NS2 Project 
A test scenario AODV and DSDV project

Condition
- Network ขนาด 1.5km x 1.5km
- ใช้ Constant Bit Rate Traffic (CBR) packet size = 512 Bytes, at 5 pkt/s (*CBR จะ run บน UDP) ใช้ cbrgen.tcl เพื่อสร้าง traffic load มี 40 connections
- ก าหนดให้มี 50 โหนด เดินทางแบบ Random-Way-Point โดยใช้ค าสั่ง setdest ในการสร้าง mobility trace ความเร็วอยู่ระหว่าง 40km/hr - 60km/hr
- Pause time = 0, 100, 200, 300, … , 900 วินาที
- ให้run simulation เป็นเวลา 15 นาที(simulated second)
- ให้ output ออกมาที่ myoutput.tr โดยให้มี trace ของ routing protocol ออกมาด้วย
-trace file ที่ได้มาหาค่า Packet Delivery Ratio และ Loss Rate
- แต่ละจุดให้ run 20 ครั้งเพื่อหาค่าเฉลี่ย แต่ละครั้งให้ใช้ seed ที่ต่างกัน