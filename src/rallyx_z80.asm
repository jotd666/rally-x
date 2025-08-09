;	map(0x0000, 0x3fff).rom();
;	map(0x8000, 0x8fff).ram().w(FUNC(rallyx_state::videoram_w)).share(m_videoram);
;	map(0x9800, 0x9fff).ram();
;	map(0xa000, 0xa000).portr("P1");
;	map(0xa080, 0xa080).portr("P2");
;	map(0xa100, 0xa100).portr("DSW");
;	map(0xa000, 0xa00f).writeonly().share(m_radarattr);
;	map(0xa080, 0xa080).w("watchdog", FUNC(watchdog_timer_device::reset_w));
;	map(0xa100, 0xa11f).w(m_namco_sound, FUNC(namco_device::pacman_sound_w));
;	map(0xa130, 0xa130).w(FUNC(rallyx_state::scrollx_w));
;	map(0xa140, 0xa140).w(FUNC(rallyx_state::scrolly_w));
;	map(0xa170, 0xa170).nopw();            // ?
;	map(0xa180, 0xa187).w("mainlatch", FUNC(ls259_device::write_d0));

;	PORT_START("P1")
;	PORT_BIT( 0x01, IP_ACTIVE_LOW, IPT_SERVICE1 )
;	PORT_BIT( 0x02, IP_ACTIVE_LOW, IPT_BUTTON1 )
;	PORT_BIT( 0x04, IP_ACTIVE_LOW, IPT_JOYSTICK_LEFT ) PORT_4WAY
;	PORT_BIT( 0x08, IP_ACTIVE_LOW, IPT_JOYSTICK_RIGHT ) PORT_4WAY
;	PORT_BIT( 0x10, IP_ACTIVE_LOW, IPT_JOYSTICK_DOWN ) PORT_4WAY
;	PORT_BIT( 0x20, IP_ACTIVE_LOW, IPT_JOYSTICK_UP ) PORT_4WAY
;	PORT_BIT( 0x40, IP_ACTIVE_LOW, IPT_START1 )
;	PORT_BIT( 0x80, IP_ACTIVE_LOW, IPT_COIN1 )
;
;	PORT_START("P2")
;	PORT_DIPNAME( 0x01, 0x01, DEF_STR( Cabinet ) )      PORT_DIPLOCATION("P2:1")
;	PORT_DIPSETTING(    0x01, DEF_STR( Upright ) )
;	PORT_DIPSETTING(    0x00, DEF_STR( Cocktail ) )
;	PORT_BIT( 0x02, IP_ACTIVE_LOW, IPT_BUTTON1 ) PORT_COCKTAIL
;	PORT_BIT( 0x04, IP_ACTIVE_LOW, IPT_JOYSTICK_LEFT ) PORT_4WAY PORT_COCKTAIL
;	PORT_BIT( 0x08, IP_ACTIVE_LOW, IPT_JOYSTICK_RIGHT ) PORT_4WAY PORT_COCKTAIL
;	PORT_BIT( 0x10, IP_ACTIVE_LOW, IPT_JOYSTICK_DOWN ) PORT_4WAY PORT_COCKTAIL
;	PORT_BIT( 0x20, IP_ACTIVE_LOW, IPT_JOYSTICK_UP ) PORT_4WAY PORT_COCKTAIL
;	PORT_BIT( 0x40, IP_ACTIVE_LOW, IPT_START2 )
;	PORT_BIT( 0x80, IP_ACTIVE_LOW, IPT_COIN2 )
;
;	PORT_START("DSW")
;	PORT_DIPNAME( 0xc0, 0xc0, DEF_STR( Coinage ) )      PORT_DIPLOCATION("DSW:7,8")
;	PORT_DIPSETTING(    0x40, DEF_STR( 2C_1C ) )
;	PORT_DIPSETTING(    0xc0, DEF_STR( 1C_1C ) )
;	PORT_DIPSETTING(    0x80, DEF_STR( 1C_2C ) )
;	PORT_DIPSETTING(    0x00, DEF_STR( Free_Play ) )
;	PORT_DIPNAME( 0x38, 0x08, DEF_STR( Difficulty ) )   PORT_DIPLOCATION("DSW:4,5,6")
;	PORT_DIPSETTING(    0x10, "1 Car, Medium" )
;	PORT_DIPSETTING(    0x28, "1 Car, Hard" )
;	PORT_DIPSETTING(    0x00, "2 Cars, Easy" )
;	PORT_DIPSETTING(    0x18, "2 Cars, Medium" )
;	PORT_DIPSETTING(    0x30, "2 Cars, Hard" )
;	PORT_DIPSETTING(    0x08, "3 Cars, Easy" )
;	PORT_DIPSETTING(    0x20, "3 Cars, Medium" )
;	PORT_DIPSETTING(    0x38, "3 Cars, Hard" )
;	PORT_DIPNAME( 0x06, 0x02, DEF_STR( Bonus_Life ) )   PORT_DIPLOCATION("DSW:2,3")
;	PORT_DIPSETTING(    0x02, "15000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x00)
;	PORT_DIPSETTING(    0x04, "30000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x00)
;	PORT_DIPSETTING(    0x06, "40000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x00)
;
;	PORT_DIPSETTING(    0x02, "20000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x08)
;	PORT_DIPSETTING(    0x04, "40000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x08)
;	PORT_DIPSETTING(    0x06, "60000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x08)
;
;	PORT_DIPSETTING(    0x02, "10000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x10)
;	PORT_DIPSETTING(    0x04, "20000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x10)
;	PORT_DIPSETTING(    0x06, "30000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x10)
;
;	PORT_DIPSETTING(    0x02, "15000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x18)
;	PORT_DIPSETTING(    0x04, "30000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x18)
;	PORT_DIPSETTING(    0x06, "40000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x18)
;
;	PORT_DIPSETTING(    0x02, "20000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x20)
;	PORT_DIPSETTING(    0x04, "40000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x20)
;	PORT_DIPSETTING(    0x06, "60000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x20)
;
;	PORT_DIPSETTING(    0x02, "10000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x28)
;	PORT_DIPSETTING(    0x04, "20000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x28)
;	PORT_DIPSETTING(    0x06, "30000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x28)
;
;	PORT_DIPSETTING(    0x02, "15000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x30)
;	PORT_DIPSETTING(    0x04, "30000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x30)
;	PORT_DIPSETTING(    0x06, "40000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x30)
;
;	PORT_DIPSETTING(    0x02, "20000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x38)
;	PORT_DIPSETTING(    0x04, "40000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x38)
;	PORT_DIPSETTING(    0x06, "60000" )     PORT_CONDITION("DSW", 0x38, EQUALS, 0x38)
;	PORT_DIPSETTING(    0x00, DEF_STR( None ) )
;	PORT_SERVICE_DIPLOC( 0x01, 0x01, "DSW:1")

nb_enemy_cars_824e = $824e
nb_rocks_8251 = $8251
p1_a000 = $a000
p2_a080 = $a080
scrollx_a130 = $a130
scrolly_a140 = $a140
watchdog_a080 = $a080
dsw_a100 = $a100
sound_a100 = $a100
unknown_8080 = $8080
enemy_car_structs_8088 = $8088
car_speed_8027 = $8027

0000: C3 00 38    jp   boot_3800

; reaches here when all memory & screen tests are done
0003: 31 00 84    ld   sp,$8400
0006: 18 32       jr   $003A

0030: C3 F0 01    jp   $01F0

003A: ED 46       im   0
003C: FB          ei
003D: 3E F7       ld   a,$F7
003F: D3 00       out  ($00),a
0041: 21 00 80    ld   hl,$8000
0044: 11 01 80    ld   de,$8001
0047: 01 00 08    ld   bc,$0800
004A: 36 00       ld   (hl),$00
004C: ED B0       ldir
004E: E5          push hl
004F: 0E 08       ld   c,$08
0051: 36 60       ld   (hl),$60
0053: ED B0       ldir
0055: 0E 18       ld   c,$18
0057: 36 00       ld   (hl),$00
0059: ED B0       ldir
005B: EB          ex   de,hl
005C: E1          pop  hl
005D: 01 E0 07    ld   bc,$07E0
0060: ED B0       ldir
0062: C3 E7 04    jp   $04E7

irq_0069:
0069: 32 80 A0    ld   (watchdog_a080),a
006C: FD 26 01    ld   iyh,$01
006F: 2A 69 80    ld   hl,($8069)
0072: ED 4B 50 80 ld   bc,($8050)
0076: 3A 6B 80    ld   a,($806B)
0079: A7          and  a
007A: 28 27       jr   z,$00A3
007C: 3A 48 80    ld   a,($8048)
007F: CB 47       bit  0,a
0081: C2 CE 00    jp   nz,$00CE
0084: ED 5B 4C 80 ld   de,($804C)
0088: 19          add  hl,de
0089: 22 4C 80    ld   ($804C),hl
008C: 7A          ld   a,d
008D: 94          sub  h
008E: 21 73 80    ld   hl,$8073
0091: CD 8C 0D    call $0D8C
0094: 81          add  a,c
0095: 32 50 80    ld   ($8050),a
0098: FD 7C       ld   a,iyh
009A: A7          and  a
009B: 28 31       jr   z,$00CE
009D: 2A 5A 80    ld   hl,($805A)
00A0: FD 26 00    ld   iyh,$00
00A3: 3A 48 80    ld   a,($8048)
00A6: CB 4F       bit  1,a
00A8: C2 CE 00    jp   nz,$00CE
00AB: ED 5B 4E 80 ld   de,($804E)
00AF: 19          add  hl,de
00B0: 22 4E 80    ld   ($804E),hl
00B3: 7A          ld   a,d
00B4: 94          sub  h
00B5: 21 75 80    ld   hl,$8075
00B8: CD 8C 0D    call $0D8C
00BB: ED 44       neg
00BD: 80          add  a,b
00BE: 32 51 80    ld   ($8051),a
00C1: FD 7C       ld   a,iyh
00C3: A7          and  a
00C4: 28 08       jr   z,$00CE
00C6: FD 26 00    ld   iyh,$00
00C9: 2A 5A 80    ld   hl,($805A)
00CC: 18 B6       jr   $0084

00CE: DD 21 68 80 ld   ix,$8068
00D2: 3A 4E 82    ld   a,(nb_enemy_cars_824e)
00D5: 3C          inc  a
00D6: 47          ld   b,a
00D7: FD 2E 01    ld   iyl,$01
00DA: CD E0 00    call $00E0
00DD: C3 78 01    jp   $0178

00E0: DD 7E 00    ld   a,(ix+$00)
00E3: A7          and  a
00E4: 28 0D       jr   z,$00F3
00E6: DD 7E 15    ld   a,(ix+$15)
00E9: A7          and  a
00EA: C2 85 01    jp   nz,$0185
00ED: DD 34 00    inc  (ix+$00)
00F0: C3 5A 01    jp   $015A

00F3: DD 66 02    ld   h,(ix+$02)
00F6: DD 6E 01    ld   l,(ix+$01)
00F9: DD 7E 03    ld   a,(ix+$03)
00FC: DD E5       push ix
00FE: DD 23       inc  ix
0100: 4F          ld   c,a
0101: A7          and  a
0102: 20 04       jr   nz,$0108
0104: DD 23       inc  ix
0106: DD 23       inc  ix
0108: DD 56 04    ld   d,(ix+$04)
010B: DD 5E 03    ld   e,(ix+$03)
010E: 19          add  hl,de
010F: DD 75 03    ld   (ix+$03),l
0112: DD 74 04    ld   (ix+$04),h
0115: 7C          ld   a,h
0116: C6 18       add  a,$18
0118: 6F          ld   l,a
0119: 3D          dec  a
011A: FA 51 01    jp   m,$0151
011D: D6 2F       sub  $2F
011F: 6F          ld   l,a
0120: FA 2D 01    jp   m,$012D
0123: 79          ld   a,c
0124: A1          and  c
0125: 20 2D       jr   nz,$0154
0127: DD 35 07    dec  (ix+$07)
012A: DD 75 04    ld   (ix+$04),l
012D: 7C          ld   a,h
012E: 92          sub  d
012F: CB 7F       bit  7,a
0131: 28 03       jr   z,$0136
0133: DD 34 0A    inc  (ix+$0a)
0136: DD 86 0B    add  a,(ix+$0b)
0139: DD 77 0B    ld   (ix+$0b),a
013C: 30 03       jr   nc,$0141
013E: DD 34 0A    inc  (ix+$0a)
0141: DD E1       pop  ix
0143: FD 2D       dec  iyl
0145: 20 13       jr   nz,$015A
0147: DD 7E 03    ld   a,(ix+$03)
014A: 2F          cpl
014B: 2A 5A 80    ld   hl,($805A)
014E: C3 FC 00    jp   $00FC

0151: A1          and  c
0152: 20 D3       jr   nz,$0127
0154: DD 34 07    inc  (ix+$07)
0157: C3 2A 01    jp   $012A

015A: DD 7E 08    ld   a,(ix+$08)
015D: 87          add  a,a
015E: 87          add  a,a
015F: 87          add  a,a
0160: DD 56 0A    ld   d,(ix+$0a)
0163: CB 3A       srl  d
0165: 1F          rra
0166: CB 3A       srl  d
0168: 1F          rra
0169: CB 3A       srl  d
016B: 1F          rra
016C: DD 77 11    ld   (ix+$11),a
016F: 7A          ld   a,d
0170: E6 07       and  $07
0172: F6 98       or   $98
0174: DD 77 12    ld   (ix+$12),a
0177: C9          ret

0178: 11 20 00    ld   de,$0020
017B: DD 19       add  ix,de
017D: FD 2E 00    ld   iyl,$00
0180: 05          dec  b
0181: C2 DA 00    jp   nz,$00DA
0184: C9          ret

0185: DD 7E 0F    ld   a,(ix+$0f)
0188: 21 70 22    ld   hl,$2270
018B: BE          cp   (hl)
018C: 23          inc  hl
018D: 20 FC       jr   nz,$018B
018F: DD 7E 00    ld   a,(ix+$00)
0192: E6 03       and  $03
0194: 20 04       jr   nz,$019A
0196: 7E          ld   a,(hl)
0197: DD 77 0F    ld   (ix+$0f),a
019A: DD 35 00    dec  (ix+$00)
019D: C2 5A 01    jp   nz,$015A
01A0: DD 36 15 00 ld   (ix+$15),$00
01A4: C5          push bc
01A5: DD 46 0C    ld   b,(ix+$0c)
01A8: DD 4E 0E    ld   c,(ix+$0e)
01AB: C5          push bc
01AC: CD 7F 0E    call $0E7F
01AF: C1          pop  bc
01B0: 7E          ld   a,(hl)
01B1: D6 BD       sub  $BD
01B3: 28 14       jr   z,$01C9
01B5: FE 09       cp   $09
01B7: 30 33       jr   nc,$01EC
01B9: FE 03       cp   $03
01BB: 38 06       jr   c,$01C3
01BD: 79          ld   a,c    ; [uncovered] 
01BE: C6 08       add  a,$08    ; [uncovered] 
01C0: 4F          ld   c,a    ; [uncovered] 
01C1: 18 E8       jr   $01AB    ; [uncovered] 

01C3: 78          ld   a,b
01C4: D6 08       sub  $08
01C6: 47          ld   b,a
01C7: 18 E2       jr   $01AB

01C9: 06 03       ld   b,$03
01CB: 54          ld   d,h
01CC: 5D          ld   e,l
01CD: CB DC       set  3,h
01CF: 0E 03       ld   c,$03
01D1: E5          push hl
01D2: D5          push de
01D3: 1A          ld   a,(de)
01D4: D6 BD       sub  $BD
01D6: FE 09       cp   $09
01D8: 30 05       jr   nc,$01DF
01DA: 3E 81       ld   a,$81
01DC: 12          ld   (de),a
01DD: 36 15       ld   (hl),$15
01DF: CD 5D 0E    call $0E5D
01E2: 0D          dec  c
01E3: 20 EE       jr   nz,$01D3
01E5: D1          pop  de
01E6: E1          pop  hl
01E7: CD 6C 0E    call $0E6C
01EA: 10 E3       djnz $01CF
01EC: C1          pop  bc
01ED: C3 5A 01    jp   $015A

01F0: E5          push hl
01F1: D5          push de
01F2: C5          push bc
01F3: F5          push af
01F4: DD E5       push ix
01F6: FD E5       push iy
01F8: AF          xor  a
01F9: 32 81 A1    ld   ($A181),a
01FC: 32 80 A0    ld   (watchdog_a080),a
01FF: CD C5 14    call $14C5
0202: CD 4D 15    call $154D
0205: 3A 20 80    ld   a,($8020)
0208: A7          and  a
0209: 28 05       jr   z,$0210
020B: FE 02       cp   $02
020D: C2 BD 03    jp   nz,$03BD
0210: 3A 4D 80    ld   a,($804D)
0213: 32 30 A1    ld   (scrollx_a130),a
0216: 3A 4F 80    ld   a,($804F)
0219: ED 44       neg
021B: 32 40 A1    ld   (scrolly_a140),a
021E: DD 21 14 88 ld   ix,$8814
0222: 21 15 80    ld   hl,$8015
0225: FD 21 02 80 ld   iy,$8002
0229: 06 06       ld   b,$06
022B: FD E5       push iy
022D: FD 5E 00    ld   e,(iy+$00)
0230: FD 56 01    ld   d,(iy+$01)
0233: 7A          ld   a,d
0234: B3          or   e
0235: 28 6E       jr   z,$02A5
0237: D5          push de
0238: FD E1       pop  iy
023A: D5          push de
023B: CD 90 04    call $0490
023E: FD 7E 00    ld   a,(iy+$00)
0241: 0F          rrca
0242: 30 07       jr   nc,$024B
0244: DD CB 01 FE set  7,(ix+$01)
0248: C3 4F 02    jp   $024F

024B: DD CB 01 BE res  7,(ix+$01)
024F: FD 7E 01    ld   a,(iy+$01)
0252: 77          ld   (hl),a
0253: FD 7E 03    ld   a,(iy+$03)
0256: DD 77 00    ld   (ix+$00),a
0259: FD 7E 04    ld   a,(iy+$04)
025C: 2B          dec  hl
025D: 77          ld   (hl),a
025E: 23          inc  hl
025F: FD 7E 05    ld   a,(iy+$05)
0262: E6 7F       and  $7F
0264: 57          ld   d,a
0265: DD 7E 01    ld   a,(ix+$01)
0268: E6 80       and  $80
026A: B2          or   d
026B: DD 77 01    ld   (ix+$01),a
026E: 78          ld   a,b
026F: FD E1       pop  iy
0271: FE 06       cp   $06
0273: 28 30       jr   z,$02A5
0275: ED 5B 52 80 ld   de,($8052)
0279: 3A 55 80    ld   a,($8055)
027C: 0F          rrca
027D: E6 01       and  $01
027F: ED 44       neg
0281: FD 86 FF    add  a,(iy-$01)
0284: 92          sub  d
0285: FE 0B       cp   $0B
0287: 30 2E       jr   nc,$02B7
0289: 57          ld   d,a
028A: 3A 54 80    ld   a,($8054)
028D: 0F          rrca
028E: E6 01       and  $01
0290: ED 44       neg
0292: FD 86 FD    add  a,(iy-$03)
0295: 93          sub  e
0296: FE 0B       cp   $0B
0298: 30 1D       jr   nc,$02B7
029A: FE 0A       cp   $0A
029C: CC C7 02    call z,$02C7
029F: 7A          ld   a,d
02A0: FE 0A       cp   $0A
02A2: CC D8 02    call z,$02D8
02A5: FD E1       pop  iy
02A7: FD 23       inc  iy
02A9: FD 23       inc  iy
02AB: DD 23       inc  ix
02AD: DD 23       inc  ix
02AF: 23          inc  hl
02B0: 23          inc  hl
02B1: 05          dec  b
02B2: C2 2B 02    jp   nz,$022B
02B5: 18 34       jr   $02EB

02B7: FD E1       pop  iy
02B9: AF          xor  a
02BA: FD 77 00    ld   (iy+$00),a
02BD: FD 77 01    ld   (iy+$01),a
02C0: 2B          dec  hl
02C1: 3E EC       ld   a,$EC
02C3: 77          ld   (hl),a
02C4: 23          inc  hl
02C5: 18 E0       jr   $02A7

02C7: 3A 54 80    ld   a,($8054)
02CA: A7          and  a
02CB: 28 04       jr   z,$02D1
02CD: 3D          dec  a
02CE: C8          ret  z
02CF: 18 16       jr   $02E7

02D1: FD CB FA 7E bit  7,(iy-$06)
02D5: C0          ret  nz
02D6: 18 0F       jr   $02E7

02D8: 3A 55 80    ld   a,($8055)
02DB: A7          and  a
02DC: 28 04       jr   z,$02E2
02DE: 3D          dec  a
02DF: C8          ret  z
02E0: 18 05       jr   $02E7

02E2: FD CB FC 7E bit  7,(iy-$04)
02E6: C8          ret  z
02E7: F1          pop  af
02E8: C3 B7 02    jp   $02B7

02EB: CD 69 00    call $0069
02EE: CD B2 0D    call $0DB2
02F1: CD 6B 1C    call $1C6B
02F4: DD 21 68 80 ld   ix,$8068
02F8: 06 09       ld   b,$09
02FA: 21 94 82    ld   hl,$8294
02FD: 11 34 80    ld   de,$8034
0300: 3A 6F 82    ld   a,($826F)
0303: E6 0F       and  $0F
0305: 20 04       jr   nz,$030B
0307: 36 0E       ld   (hl),$0E
0309: 18 06       jr   $0311

030B: E6 07       and  $07
030D: 20 02       jr   nz,$0311
030F: 36 08       ld   (hl),$08
0311: 3A A8 81    ld   a,($81A8)
0314: A7          and  a
0315: 20 39       jr   nz,$0350
0317: DD 7E 08    ld   a,(ix+$08)
031A: 87          add  a,a
031B: C6 E0       add  a,$E0
031D: CB 86       res  0,(hl)
031F: 38 02       jr   c,$0323
0321: CB C6       set  0,(hl)
0323: 12          ld   (de),a
0324: DD 7E 0A    ld   a,(ix+$0a)
0327: D6 64       sub  $64
0329: 28 07       jr   z,$0332
032B: C6 64       add  a,$64
032D: 87          add  a,a
032E: ED 44       neg
0330: C6 9D       add  a,$9D
0332: CB DA       set  3,d
0334: 12          ld   (de),a
0335: 78          ld   a,b
0336: 23          inc  hl
0337: CB 9A       res  3,d
0339: 13          inc  de
033A: 01 20 00    ld   bc,$0020
033D: DD 09       add  ix,bc
033F: 47          ld   b,a
0340: 10 CF       djnz $0311
0342: 21 94 82    ld   hl,$8294
0345: 11 04 A0    ld   de,$A004
0348: 01 09 00    ld   bc,$0009
034B: ED B0       ldir
034D: C3 6D 03    jp   $036D
0350: DD 7E 08    ld   a,(ix+$08)
0353: 87          add  a,a
0354: ED 44       neg
0356: C6 41       add  a,$41
0358: CB C6       set  0,(hl)
035A: 12          ld   (de),a
035B: DD 7E 0A    ld   a,(ix+$0a)
035E: D6 64       sub  $64
0360: 28 05       jr   z,$0367
0362: C6 64       add  a,$64
0364: 87          add  a,a
0365: C6 5F       add  a,$5F
0367: CB DA       set  3,d
0369: 12          ld   (de),a
036A: C3 35 03    jp   $0335
036D: 06 05       ld   b,$05
036F: DD 21 68 80 ld   ix,$8068
0373: FD 21 04 80 ld   iy,$8004
0377: 21 4C 82    ld   hl,$824C
037A: 7E          ld   a,(hl)
037B: 35          dec  (hl)
037C: FE 32       cp   $32
037E: 30 3D       jr   nc,$03BD
0380: A7          and  a
0381: 20 3A       jr   nz,$03BD
0383: 77          ld   (hl),a
0384: FD 66 01    ld   h,(iy+$01)
0387: FD 6E 00    ld   l,(iy+$00)
038A: 7D          ld   a,l
038B: B4          or   h
038C: 28 29       jr   z,$03B7
038E: 7E          ld   a,(hl)
038F: CB 47       bit  0,a
0391: 20 24       jr   nz,$03B7
0393: DD 7E 0C    ld   a,(ix+$0c)
0396: 23          inc  hl
0397: 96          sub  (hl)
0398: 30 02       jr   nc,$039C
039A: ED 44       neg
039C: FE 0B       cp   $0B
039E: 30 17       jr   nc,$03B7
03A0: DD 7E 0E    ld   a,(ix+$0e)
03A3: 23          inc  hl
03A4: 23          inc  hl
03A5: 96          sub  (hl)
03A6: 30 02       jr   nc,$03AA
03A8: ED 44       neg
03AA: FE 0B       cp   $0B
03AC: 30 09       jr   nc,$03B7
03AE: FB          ei
03AF: 3E 01       ld   a,$01
03B1: 32 81 A1    ld   ($A181),a
03B4: C3 D3 16    jp   $16D3

03B7: FD 23       inc  iy
03B9: FD 23       inc  iy
03BB: 10 C7       djnz $0384
03BD: 3A 4B 82    ld   a,($824B)
03C0: 3C          inc  a
03C1: 32 4B 82    ld   ($824B),a
03C4: CD 72 0D    call $0D72
03C7: 3A 6F 82    ld   a,($826F)
03CA: 3C          inc  a
03CB: 32 6F 82    ld   ($826F),a
03CE: C6 08       add  a,$08
03D0: E6 0F       and  $0F
03D2: CC C7 04    call z,$04C7
03D5: 3A 4D 82    ld   a,($824D)
03D8: 3C          inc  a
03D9: 32 4D 82    ld   ($824D),a
03DC: E6 3F       and  $3F
03DE: CC 72 04    call z,$0472
03E1: E6 07       and  $07
03E3: CC 62 04    call z,$0462
03E6: 3A 69 82    ld   a,($8269)
03E9: 3C          inc  a
03EA: 32 69 82    ld   ($8269),a
03ED: 2A 9A 89    ld   hl,($899A)
03F0: 3A 8C 82    ld   a,($828C)
03F3: A7          and  a
03F4: 20 03       jr   nz,$03F9
03F6: 3A 88 82    ld   a,($8288)
03F9: 3D          dec  a
03FA: 32 8C 82    ld   ($828C),a
03FD: 20 2F       jr   nz,$042E
03FF: 34          inc  (hl)
0400: 7E          ld   a,(hl)
0401: 21 8A 82    ld   hl,$828A
0404: 36 04       ld   (hl),$04
0406: FE 28       cp   $28
0408: 38 17       jr   c,$0421
040A: 36 03       ld   (hl),$03
040C: 28 10       jr   z,$041E
040E: FE 50       cp   $50
0410: 38 0F       jr   c,$0421
0412: 36 02       ld   (hl),$02
0414: 28 08       jr   z,$041E
0416: FE C8       cp   $C8
0418: 38 07       jr   c,$0421
041A: 36 01       ld   (hl),$01
041C: 20 03       jr   nz,$0421
041E: CD 0B 19    call $190B
0421: 3A 69 82    ld   a,($8269)
0424: 47          ld   b,a
0425: 3A 6E 82    ld   a,($826E)
0428: B8          cp   b
0429: 30 03       jr   nc,$042E
042B: 32 69 82    ld   ($8269),a
042E: 00          nop
042F: 21 F4 89    ld   hl,$89F4
0432: 3A 21 80    ld   a,($8021)
0435: A7          and  a
0436: 20 03       jr   nz,$043B
0438: 77          ld   (hl),a
0439: 23          inc  hl
043A: 77          ld   (hl),a
043B: CD 00 24    call $2400
043E: 3A 24 80    ld   a,($8024)
0441: FE 09       cp   $09
0443: 3E 00       ld   a,$00
0445: 30 01       jr   nc,$0448
0447: 3C          inc  a
0448: 32 86 A1    ld   ($A186),a
044B: 3A 00 A1    ld   a,(dsw_a100)
044E: E6 01       and  $01
0450: CA 00 38    jp   z,boot_3800
0453: 3E 01       ld   a,$01
0455: 32 81 A1    ld   ($A181),a
0458: FD E1       pop  iy
045A: DD E1       pop  ix
045C: F1          pop  af
045D: C1          pop  bc
045E: D1          pop  de
045F: E1          pop  hl
0460: FB          ei
0461: C9          ret

0462: 2A 2D 80    ld   hl,($802D)
0465: ED 5B 69 80 ld   de,($8069)
0469: 19          add  hl,de
046A: CB 2C       sra  h
046C: CB 1D       rr   l
046E: 22 69 80    ld   ($8069),hl
0471: C9          ret

0472: 47          ld   b,a
0473: 3A 92 82    ld   a,($8292)
0476: A7          and  a
0477: 78          ld   a,b
0478: C8          ret  z
0479: 2A 27 80    ld   hl,(car_speed_8027)
047C: 11 E0 FF    ld   de,$FFE0
047F: 19          add  hl,de
0480: 7C          ld   a,h
0481: A7          and  a
0482: 20 07       jr   nz,$048B
0484: 3A 2B 80    ld   a,($802B)    ; [uncovered] 
0487: BD          cp   l    ; [uncovered] 
0488: 38 01       jr   c,$048B    ; [uncovered] 
048A: 6F          ld   l,a    ; [uncovered] 
048B: 22 27 80    ld   (car_speed_8027),hl
048E: 78          ld   a,b
048F: C9          ret

0490: 3A A8 81    ld   a,($81A8)
0493: A7          and  a
0494: C8          ret  z
0495: E5          push hl    ; [uncovered] 
0496: FD 56 00    ld   d,(iy+$00)    ; [uncovered] 
0499: FD 5E 01    ld   e,(iy+$01)    ; [uncovered] 
049C: 21 14 01    ld   hl,$0114    ; [uncovered] 
049F: A7          and  a    ; [uncovered] 
04A0: ED 52       sbc  hl,de    ; [uncovered] 
04A2: FD 7E 03    ld   a,(iy+$03)    ; [uncovered] 
04A5: ED 44       neg    ; [uncovered] 
04A7: D6 10       sub  $10    ; [uncovered] 
04A9: 57          ld   d,a    ; [uncovered] 
04AA: FD 7E 04    ld   a,(iy+$04)    ; [uncovered] 
04AD: EE 03       xor  $03    ; [uncovered] 
04AF: FD 5E 05    ld   e,(iy+$05)    ; [uncovered] 
04B2: FD 21 88 81 ld   iy,$8188    ; [uncovered] 
04B6: FD 74 00    ld   (iy+$00),h    ; [uncovered] 
04B9: FD 75 01    ld   (iy+$01),l    ; [uncovered] 
04BC: FD 72 03    ld   (iy+$03),d    ; [uncovered] 
04BF: FD 77 04    ld   (iy+$04),a    ; [uncovered] 
04C2: FD 73 05    ld   (iy+$05),e    ; [uncovered] 
04C5: E1          pop  hl    ; [uncovered] 
04C6: C9          ret    ; [uncovered] 

04C7: 3A 20 80    ld   a,($8020)
04CA: 06 04       ld   b,$04
04CC: 2A 98 89    ld   hl,($8998)
04CF: FE 02       cp   $02
04D1: C0          ret  nz
04D2: 7E          ld   a,(hl)
04D3: FE 66       cp   $66
04D5: 3E 67       ld   a,$67
04D7: 28 02       jr   z,$04DB
04D9: 3E 66       ld   a,$66
04DB: 77          ld   (hl),a
04DC: 23          inc  hl
04DD: 10 FC       djnz $04DB
04DF: C9          ret
04E0: 06 04       ld   b,$04
04E2: 2A 98 89    ld   hl,($8998)
04E5: 18 EB       jr   $04D2
04E7: 21 8B 1F    ld   hl,$1F8B
04EA: 11 40 80    ld   de,$8040
04ED: 0E 66       ld   c,$66
04EF: CD 4E 1C    call $1C4E
04F2: CD 76 1B    call $1B76
04F5: 3A 00 A1    ld   a,(dsw_a100)
04F8: 47          ld   b,a
04F9: 21 AA 82    ld   hl,$82AA
04FC: E6 C0       and  $C0
04FE: 28 0E       jr   z,$050E
0500: 34          inc  (hl)
0501: CB 7F       bit  7,a
0503: 28 09       jr   z,$050E
0505: 23          inc  hl
0506: 34          inc  (hl)
0507: CB 77       bit  6,a
0509: 20 03       jr   nz,$050E
050B: 34          inc  (hl)    ; [uncovered] 
050C: 2B          dec  hl    ; [uncovered] 
050D: 34          inc  (hl)    ; [uncovered] 
050E: 78          ld   a,b
050F: 0F          rrca
0510: 0F          rrca
0511: 0F          rrca
0512: E6 07       and  $07
0514: FE 02       cp   $02
0516: 38 21       jr   c,$0539
0518: FE 05       cp   $05    ; [uncovered] 
051A: 30 0E       jr   nc,$052A    ; [uncovered] 
051C: 3D          dec  a    ; [uncovered] 
051D: 32 0E 80    ld   ($800E),a    ; [uncovered] 
0520: 21 D3 20    ld   hl,$20D3    ; [uncovered] 
0523: 3E 0B       ld   a,$0B    ; [uncovered] 
0525: 11 0B 22    ld   de,$220B    ; [uncovered] 
0528: 18 1C       jr   $0546    ; [uncovered] 
052A: D6 04       sub  $04
052C: 32 0E 80    ld   ($800E),a
052F: 21 1B 21    ld   hl,$211B
0532: 3E 08       ld   a,$08
0534: 11 03 22    ld   de,$2203
0537: 18 0D       jr   $0546
0539: C6 02       add  a,$02
053B: 32 0E 80    ld   ($800E),a
053E: 21 5B 20    ld   hl,$205B
0541: 3E 11       ld   a,$11
0543: 11 13 22    ld   de,$2213
0546: 22 D2 82    ld   ($82D2),hl
0549: 32 D8 82    ld   ($82D8),a
054C: 21 60 80    ld   hl,$8060
054F: 0E 70       ld   c,$70
0551: EB          ex   de,hl
0552: CD 4E 1C    call $1C4E
0555: 3A 0E 80    ld   a,($800E)
0558: 87          add  a,a
0559: 87          add  a,a
055A: 87          add  a,a
055B: 4F          ld   c,a
055C: 78          ld   a,b
055D: E6 06       and  $06
055F: B1          or   c
0560: 21 E3 21    ld   hl,$21E3
0563: 85          add  a,l
0564: 6F          ld   l,a
0565: 30 01       jr   nc,$0568
0567: 24          inc  h    ; [uncovered] 
0568: 5E          ld   e,(hl)
0569: 23          inc  hl
056A: 56          ld   d,(hl)
056B: ED 53 B3 81 ld   ($81B3),de
056F: 3A 80 A0    ld   a,(watchdog_a080)
0572: F6 FE       or   $FE
0574: 2F          cpl
0575: 32 A9 81    ld   ($81A9),a
0578: CD C5 14    call $14C5
057B: 3A A9 81    ld   a,($81A9)
057E: 32 83 A1    ld   ($A183),a
0581: 32 A8 81    ld   ($81A8),a
0584: CD 76 1B    call $1B76
0587: 3A 24 80    ld   a,($8024)
058A: A7          and  a
058B: C2 AB 06    jp   nz,$06AB
058E: 32 21 80    ld   ($8021),a
0591: 3C          inc  a
0592: 32 81 A1    ld   ($A181),a
0595: 32 20 80    ld   ($8020),a
0598: 3E F7       ld   a,$F7
059A: D3 00       out  ($00),a
059C: 3E 49       ld   a,$49
059E: CD CB 1D    call $1DCB
05A1: 21 40 8C    ld   hl,$8C40
05A4: 06 90       ld   b,$90
05A6: 36 4A       ld   (hl),$4A
05A8: 23          inc  hl
05A9: 10 FB       djnz $05A6
05AB: 21 00 8F    ld   hl,$8F00
05AE: 11 01 8F    ld   de,$8F01
05B1: 01 FF 00    ld   bc,$00FF
05B4: 36 47       ld   (hl),$47
05B6: ED B0       ldir
05B8: 21 F3 1F    ld   hl,$1FF3
05BB: FB          ei
05BC: CD 1B 1E    call $1E1B
05BF: CD 1B 1E    call $1E1B
05C2: CD 1B 1E    call $1E1B
05C5: CD 1B 1E    call $1E1B
05C8: CD 1B 1E    call $1E1B
05CB: CD 1B 1E    call $1E1B
05CE: 3E 01       ld   a,$01
05D0: 32 0F 80    ld   ($800F),a
05D3: 32 20 80    ld   ($8020),a
05D6: 32 4B 82    ld   ($824B),a
05D9: 32 81 A1    ld   ($A181),a
05DC: ED 5F       ld   a,r
05DE: E6 1F       and  $1F
05E0: 4F          ld   c,a
05E1: D6 0A       sub  $0A
05E3: 30 FB       jr   nc,$05E0
05E5: 0C          inc  c
05E6: 21 A8 8E    ld   hl,$8EA8
05E9: 06 07       ld   b,$07
05EB: 36 44       ld   (hl),$44
05ED: 23          inc  hl
05EE: 10 FB       djnz $05EB
05F0: 21 C8 8E    ld   hl,$8EC8
05F3: 36 44       ld   (hl),$44
05F5: 23          inc  hl
05F6: 36 44       ld   (hl),$44
05F8: DD 21 A8 86 ld   ix,$86A8
05FC: DD 36 01 87 ld   (ix+$01),$87
0600: DD 36 20 88 ld   (ix+$20),$88
0604: DD 36 21 89 ld   (ix+$21),$89
0608: 3E 81       ld   a,$81
060A: DD 77 00    ld   (ix+$00),a
060D: DD 77 02    ld   (ix+$02),a
0610: DD 77 05    ld   (ix+$05),a
0613: DD 77 06    ld   (ix+$06),a
0616: DD 36 08 50 ld   (ix+$08),$50
061A: DD 36 09 54 ld   (ix+$09),$54
061E: DD 36 0A 53 ld   (ix+$0a),$53
0622: 16 00       ld   d,$00
0624: 1E A0       ld   e,$A0
0626: 3E 81       ld   a,$81
0628: DD 77 03    ld   (ix+$03),a
062B: DD 77 04    ld   (ix+$04),a
062E: DD 77 05    ld   (ix+$05),a
0631: 3A 4B 82    ld   a,($824B)
0634: E6 3F       and  $3F
0636: 28 EE       jr   z,$0626
0638: E6 1F       and  $1F
063A: 20 F5       jr   nz,$0631
063C: 3A 4B 82    ld   a,($824B)
063F: 3C          inc  a
0640: 32 4B 82    ld   ($824B),a
0643: 0D          dec  c
0644: 3E 81       ld   a,$81
0646: 20 03       jr   nz,$064B
0648: 3E 8A       ld   a,$8A
064A: 57          ld   d,a
064B: DD 77 00    ld   (ix+$00),a
064E: CB 4A       bit  1,d
0650: 28 04       jr   z,$0656
0652: DD 36 05 AC ld   (ix+$05),$AC
0656: DD 36 04 AA ld   (ix+$04),$AA
065A: DD 73 03    ld   (ix+$03),e
065D: 7B          ld   a,e
065E: 1C          inc  e
065F: FE A9       cp   $A9
0661: 20 CE       jr   nz,$0631
0663: DD 36 03 A0 ld   (ix+$03),$A0
0667: DD 36 05 AB ld   (ix+$05),$AB
066B: DD 36 06 AC ld   (ix+$06),$AC
066F: 3E 01       ld   a,$01
0671: 32 4B 82    ld   ($824B),a
0674: 3A 4B 82    ld   a,($824B)
0677: E6 1F       and  $1F
0679: 20 F9       jr   nz,$0674
067B: 3E 01       ld   a,$01
067D: 32 B0 81    ld   ($81B0),a
0680: 21 3F E0    ld   hl,$E03F
0683: 22 F2 82    ld   ($82F2),hl
0686: 21 AB 81    ld   hl,$81AB
0689: 36 03       ld   (hl),$03
068B: C3 4C 07    jp   $074C

068E: 21 4B 82    ld   hl,$824B
0691: 36 88       ld   (hl),$88
0693: 7E          ld   a,(hl)
0694: A7          and  a
0695: 20 FC       jr   nz,$0693
0697: 21 14 80    ld   hl,$8014
069A: 11 02 80    ld   de,$8002
069D: 06 0C       ld   b,$0C
069F: AF          xor  a
06A0: 0E EC       ld   c,$EC
06A2: 71          ld   (hl),c
06A3: 23          inc  hl
06A4: 12          ld   (de),a
06A5: 13          inc  de
06A6: 10 FA       djnz $06A2
06A8: C3 7B 05    jp   $057B

06AB: 31 00 84    ld   sp,$8400
06AE: 3E 02       ld   a,$02
06B0: 32 21 80    ld   ($8021),a
06B3: 3D          dec  a
06B4: 32 20 80    ld   ($8020),a
06B7: 32 81 A1    ld   ($A181),a
06BA: FB          ei
06BB: 32 B0 81    ld   ($81B0),a
06BE: 32 B1 81    ld   ($81B1),a
06C1: 21 0E 80    ld   hl,$800E
06C4: 7E          ld   a,(hl)
06C5: 23          inc  hl
06C6: 77          ld   (hl),a
06C7: 23          inc  hl
06C8: 77          ld   (hl),a
06C9: 3E 66       ld   a,$66
06CB: CD CB 1D    call $1DCB
06CE: 21 30 1F    ld   hl,$1F30
06D1: 11 66 85    ld   de,$8566
06D4: CD 29 1C    call $1C29
06D7: E5          push hl
06D8: 2A B3 81    ld   hl,($81B3)
06DB: 7E          ld   a,(hl)
06DC: E1          pop  hl
06DD: FE 49       cp   $49
06DF: 28 1D       jr   z,$06FE
06E1: 11 E3 85    ld   de,$85E3
06E4: CD 29 1C    call $1C29
06E7: 2A B3 81    ld   hl,($81B3)
06EA: 01 07 00    ld   bc,$0007
06ED: 09          add  hl,bc
06EE: 11 F1 85    ld   de,$85F1
06F1: 0E 01       ld   c,$01
06F3: CD 2B 1C    call $1C2B
06F6: 2A B3 81    ld   hl,($81B3)
06F9: 0E 04       ld   c,$04
06FB: CD 2B 1C    call $1C2B
06FE: 21 5A 1F    ld   hl,$1F5A
0701: 11 6A 86    ld   de,$866A
0704: CD 29 1C    call $1C29
0707: 3A AA 82    ld   a,($82AA)
070A: A7          and  a
070B: C4 D2 1E    call nz,$1ED2
070E: 11 28 87    ld   de,$8728
0711: 21 6E 1F    ld   hl,$1F6E
0714: CD 15 1B    call $1B15
0717: 3A 4B 82    ld   a,($824B)
071A: E6 1F       and  $1F
071C: CC 30 1C    call z,$1C30
071F: E6 0F       and  $0F
0721: CC 3A 1C    call z,$1C3A
0724: 3A 00 A0    ld   a,(p1_a000)
0727: E6 40       and  $40
0729: 28 18       jr   z,$0743
072B: 3A 80 A0    ld   a,(watchdog_a080)
072E: E6 40       and  $40
0730: 20 E5       jr   nz,$0717
0732: 3A 24 80    ld   a,($8024)    ; [uncovered] 
0735: D6 02       sub  $02    ; [uncovered] 
0737: 38 DE       jr   c,$0717    ; [uncovered] 
0739: 32 24 80    ld   ($8024),a    ; [uncovered] 
073C: 21 AB 81    ld   hl,$81AB    ; [uncovered] 
073F: 36 03       ld   (hl),$03    ; [uncovered] 
0741: 18 09       jr   $074C    ; [uncovered] 

0743: 21 24 80    ld   hl,$8024
0746: 35          dec  (hl)
0747: 21 AB 81    ld   hl,$81AB
074A: 36 01       ld   (hl),$01
074C: AF          xor  a
074D: E5          push hl
074E: 21 14 80    ld   hl,$8014
0751: 11 15 80    ld   de,$8015
0754: 01 0B 00    ld   bc,$000B
0757: 36 EC       ld   (hl),$EC
0759: ED B0       ldir
075B: E1          pop  hl
075C: 32 81 A1    ld   ($A181),a
075F: 32 80 A0    ld   (watchdog_a080),a
0762: 3E F7       ld   a,$F7
0764: D3 00       out  ($00),a
0766: FB          ei
0767: 3E 80       ld   a,$80
0769: 32 F5 89    ld   ($89F5),a
076C: CD 41 17    call $1741
076F: CD 3A 1C    call $1C3A
0772: 21 9B 1F    ld   hl,$1F9B
0775: 11 80 80    ld   de,unknown_8080
0778: 0E 66       ld   c,$66
077A: CD 4E 1C    call $1C4E
077D: 0E 72       ld   c,$72
077F: 21 93 1F    ld   hl,$1F93
0782: CD 08 0B    call $0B08
0785: CD 4E 1C    call $1C4E
0788: 3A AB 81    ld   a,($81AB)
078B: 47          ld   b,a
078C: 0E 66       ld   c,$66
078E: FE 01       cp   $01
0790: 21 BB 1F    ld   hl,$1FBB
0793: 28 03       jr   z,$0798
0795: 21 A3 1F    ld   hl,$1FA3
0798: CD 08 0B    call $0B08
079B: CD 4E 1C    call $1C4E
079E: 0E 72       ld   c,$72
07A0: 21 93 1F    ld   hl,$1F93
07A3: 10 03       djnz $07A8
07A5: 21 BB 1F    ld   hl,$1FBB
07A8: CD 08 0B    call $0B08
07AB: CD 4E 1C    call $1C4E
07AE: 21 BB 1F    ld   hl,$1FBB
07B1: CD 4E 1C    call $1C4E
07B4: AF          xor  a
07B5: 32 B2 81    ld   ($81B2),a
07B8: 3E 01       ld   a,$01
07BA: 32 B7 81    ld   ($81B7),a
07BD: 2A 8A 89    ld   hl,($898A)
07C0: 34          inc  (hl)
07C1: AF          xor  a
07C2: 2A 8C 89    ld   hl,($898C)
07C5: 77          ld   (hl),a
07C6: 32 92 82    ld   ($8292),a
07C9: CD 0B 19    call $190B
07CC: CD 91 11    call $1191
07CF: CD C5 11    call $11C5
07D2: 3E 03       ld   a,$03
07D4: 32 81 A1    ld   ($A181),a
07D7: FB          ei
07D8: 32 20 80    ld   ($8020),a
07DB: 32 4B 82    ld   ($824B),a
07DE: 3A 4B 82    ld   a,($824B)
07E1: E6 3F       and  $3F
07E3: 20 F9       jr   nz,$07DE
07E5: AF          xor  a
07E6: 32 92 82    ld   ($8292),a
07E9: 21 90 82    ld   hl,$8290
07EC: 77          ld   (hl),a
07ED: 23          inc  hl
07EE: 77          ld   (hl),a
07EF: 2A 9C 89    ld   hl,($899C)
07F2: 77          ld   (hl),a
07F3: 2A 9A 89    ld   hl,($899A)
07F6: 77          ld   (hl),a
07F7: 2A 8E 89    ld   hl,($898E)
07FA: 77          ld   (hl),a
07FB: 23          inc  hl
07FC: 36 3C       ld   (hl),$3C
07FE: 21 8A 82    ld   hl,$828A
0801: 36 04       ld   (hl),$04
0803: CD 76 1B    call $1B76
0806: CD 0B 19    call $190B
0809: 21 00 00    ld   hl,$0000
080C: 11 00 98    ld   de,$9800
080F: 0E 38       ld   c,$38
0811: 06 20       ld   b,$20
0813: CD C5 12    call $12C5
0816: 12          ld   (de),a
0817: 13          inc  de
0818: 24          inc  h
0819: 10 F8       djnz $0813
081B: 32 80 A0    ld   (watchdog_a080),a
081E: 60          ld   h,b
081F: 2C          inc  l
0820: 0D          dec  c
0821: 20 EE       jr   nz,$0811
0823: 2A 92 89    ld   hl,($8992)
0826: 06 0A       ld   b,$0A
0828: 3E 01       ld   a,$01
082A: 5E          ld   e,(hl)
082B: 23          inc  hl
082C: 56          ld   d,(hl)
082D: 23          inc  hl
082E: 12          ld   (de),a
082F: 10 F9       djnz $082A
0831: 3C          inc  a
0832: 12          ld   (de),a
0833: 3A 51 82    ld   a,(nb_rocks_8251)
0836: 47          ld   b,a
0837: 3E 03       ld   a,$03
0839: 2A 96 89    ld   hl,($8996)
083C: 5E          ld   e,(hl)
083D: 23          inc  hl
083E: 56          ld   d,(hl)
083F: 23          inc  hl
0840: 12          ld   (de),a
0841: 10 F9       djnz $083C
0843: 21 AB 1F    ld   hl,$1FAB
0846: 11 20 81    ld   de,$8120
0849: 0E 6B       ld   c,$6B
084B: CD 4E 1C    call $1C4E
084E: 11 40 81    ld   de,$8140
0851: 0E 66       ld   c,$66
0853: 06 02       ld   b,$02
0855: 21 BB 1F    ld   hl,$1FBB
0858: CD 4E 1C    call $1C4E
085B: 10 F8       djnz $0855
085D: 06 0E       ld   b,$0E
085F: 0E 63       ld   c,$63
0861: 21 C3 1F    ld   hl,$1FC3
0864: CD 4E 1C    call $1C4E
0867: 10 F8       djnz $0861
0869: 3A B7 81    ld   a,($81B7)
086C: A7          and  a
086D: C4 5D 09    call nz,$095D
0870: 11 80 83    ld   de,$8380
0873: 0E 66       ld   c,$66
0875: 21 B3 1F    ld   hl,$1FB3
0878: 3A 83 83    ld   a,($8383)
087B: A7          and  a
087C: 28 06       jr   z,$0884
087E: 3A 21 80    ld   a,($8021)
0881: A7          and  a
0882: 28 1D       jr   z,$08A1
0884: CD 4E 1C    call $1C4E
0887: 2A 8A 89    ld   hl,($898A)
088A: 7E          ld   a,(hl)
088B: 3D          dec  a
088C: 21 83 83    ld   hl,$8383
088F: 06 00       ld   b,$00
0891: FE 0A       cp   $0A
0893: 38 05       jr   c,$089A
0895: 04          inc  b    ; [uncovered] 
0896: D6 0A       sub  $0A    ; [uncovered] 
0898: 18 F7       jr   $0891    ; [uncovered] 

089A: 77          ld   (hl),a
089B: 78          ld   a,b
089C: 2B          dec  hl
089D: A7          and  a
089E: 28 01       jr   z,$08A1
08A0: 77          ld   (hl),a    ; [uncovered] 
08A1: 3A A8 81    ld   a,($81A8)
08A4: 32 83 A1    ld   ($A183),a
08A7: CD AF 12    call $12AF
08AA: CD 1B 1D    call $1D1B
08AD: AF          xor  a
08AE: 32 D0 82    ld   ($82D0),a
08B1: 2A 8A 89    ld   hl,($898A)
08B4: 7E          ld   a,(hl)
08B5: E6 03       and  $03
08B7: C2 E0 08    jp   nz,$08E0
08BA: 21 F5 89    ld   hl,$89F5    ; [uncovered] 
08BD: 36 40       ld   (hl),$40    ; [uncovered] 
08BF: 3E 4A       ld   a,$4A    ; [uncovered] 
08C1: CD CB 1D    call $1DCB    ; [uncovered] 
08C4: 3A A8 81    ld   a,($81A8)    ; [uncovered] 
08C7: 32 83 A1    ld   ($A183),a    ; [uncovered] 
08CA: 21 DB 1F    ld   hl,$1FDB    ; [uncovered] 
08CD: CD 1B 1E    call $1E1B    ; [uncovered] 
08D0: 3E 03       ld   a,$03    ; [uncovered] 
08D2: 32 20 80    ld   ($8020),a    ; [uncovered] 
08D5: 32 81 A1    ld   ($A181),a    ; [uncovered] 
08D8: FB          ei    ; [uncovered] 
08D9: 21 F5 89    ld   hl,$89F5    ; [uncovered] 
08DC: CB 46       bit  0,(hl)    ; [uncovered] 
08DE: 28 FC       jr   z,$08DC    ; [uncovered] 
08E0: CD BA 0A    call $0ABA
08E3: 21 0A 2D    ld   hl,$2D0A
08E6: 22 52 80    ld   ($8052),hl
08E9: 3E 03       ld   a,$03
08EB: 32 20 80    ld   ($8020),a
08EE: 32 81 A1    ld   ($A181),a
08F1: FB          ei
08F2: AF          xor  a
08F3: 32 40 A1    ld   (scrolly_a140),a
08F6: 32 30 A1    ld   (scrollx_a130),a
08F9: CD 31 11    call $1131
08FC: 21 F5 89    ld   hl,$89F5
08FF: CB 46       bit  0,(hl)
0901: 28 FC       jr   z,$08FF
0903: 06 05       ld   b,$05
0905: 11 20 00    ld   de,$0020
0908: 0E 0D       ld   c,$0D
090A: 2A 27 80    ld   hl,(car_speed_8027)
090D: 22 2D 80    ld   ($802D),hl
0910: 2A 25 80    ld   hl,($8025)
0913: AF          xor  a
0914: DD 19       add  ix,de
0916: DD 36 00 B0 ld   (ix+$00),$B0
091A: DD 77 03    ld   (ix+$03),a
091D: DD 77 04    ld   (ix+$04),a
0920: DD 77 05    ld   (ix+$05),a
0923: DD 77 06    ld   (ix+$06),a
0926: DD 77 07    ld   (ix+$07),a
0929: DD 77 13    ld   (ix+$13),a
092C: DD 77 15    ld   (ix+$15),a
092F: DD 71 08    ld   (ix+$08),c
0932: 0C          inc  c
0933: 0C          inc  c
0934: DD 36 0A 34 ld   (ix+$0a),$34
0938: DD 36 0F F0 ld   (ix+$0f),$F0
093C: DD 36 10 02 ld   (ix+$10),$02
0940: DD 75 01    ld   (ix+$01),l
0943: DD 74 02    ld   (ix+$02),h
0946: 10 CC       djnz $0914
0948: 3A 4E 82    ld   a,(nb_enemy_cars_824e)
094B: D6 03       sub  $03
094D: 20 05       jr   nz,$0954
094F: DD 36 EA 64 ld   (ix-$16),$64
0953: 3C          inc  a
0954: 3D          dec  a
0955: 20 5A       jr   nz,$09B1
0957: DD 36 0A 64 ld   (ix+$0a),$64
095B: 18 58       jr   $09B5

095D: D5          push de
095E: AF          xor  a
095F: 32 B7 81    ld   ($81B7),a
0962: 11 40 83    ld   de,$8340
0965: 06 02       ld   b,$02
0967: 0E 63       ld   c,$63
0969: 21 BB 1F    ld   hl,$1FBB
096C: CD 4E 1C    call $1C4E
096F: 10 F8       djnz $0969
0971: D1          pop  de
0972: DD 21 44 83 ld   ix,$8344
0976: 2A 88 89    ld   hl,($8988)
0979: 4E          ld   c,(hl)
097A: 0C          inc  c
097B: 18 17       jr   $0994

097D: DD 21 44 83 ld   ix,$8344
0981: 11 40 83    ld   de,$8340
0984: 06 02       ld   b,$02
0986: 0E 63       ld   c,$63
0988: 21 BB 1F    ld   hl,$1FBB
098B: CD 4E 1C    call $1C4E
098E: 10 F8       djnz $0988
0990: 2A 88 89    ld   hl,($8988)
0993: 4E          ld   c,(hl)
0994: 0D          dec  c
0995: C8          ret  z
0996: 3E B0       ld   a,$B0
0998: DD 77 00    ld   (ix+$00),a
099B: 3C          inc  a
099C: DD 77 01    ld   (ix+$01),a
099F: 3C          inc  a
09A0: DD 77 20    ld   (ix+$20),a
09A3: 3C          inc  a
09A4: DD 77 21    ld   (ix+$21),a
09A7: DD 7D       ld   a,ixl
09A9: 3C          inc  a
09AA: 3C          inc  a
09AB: E6 F7       and  $F7
09AD: DD 6F       ld   ixl,a
09AF: 18 E3       jr   $0994

09B5: AF          xor  a
09B6: 0E 0F       ld   c,$0F
09B8: 06 03       ld   b,$03
09BA: CD 11 1E    call $1E11
09BD: DD 19       add  ix,de
09BF: DD 36 00 B0 ld   (ix+$00),$B0
09C3: DD 77 03    ld   (ix+$03),a
09C6: DD 77 04    ld   (ix+$04),a
09C9: DD 77 05    ld   (ix+$05),a
09CC: DD 77 06    ld   (ix+$06),a
09CF: DD 77 07    ld   (ix+$07),a
09D2: DD 71 08    ld   (ix+$08),c
09D5: 0C          inc  c
09D6: 0C          inc  c
09D7: DD 77 13    ld   (ix+$13),a
09DA: DD 77 15    ld   (ix+$15),a
09DD: DD 36 0A 64 ld   (ix+$0a),$64
09E1: DD 36 0F F2 ld   (ix+$0f),$F2
09E5: DD 36 10 02 ld   (ix+$10),$02
09E9: DD 75 01    ld   (ix+$01),l
09EC: DD 74 02    ld   (ix+$02),h
09EF: 10 CC       djnz $09BD
09F1: DD 36 08 0D ld   (ix+$08),$0D
09F5: 3A 4E 82    ld   a,(nb_enemy_cars_824e)
09F8: D6 06       sub  $06
09FA: 38 0E       jr   c,$0A0A
09FC: 47          ld   b,a    ; [uncovered] 
09FD: 04          inc  b    ; [uncovered] 
09FE: DD 21 08 81 ld   ix,$8108    ; [uncovered] 
0A02: DD 19       add  ix,de    ; [uncovered] 
0A04: DD 36 0A 01 ld   (ix+$0a),$01    ; [uncovered] 
0A08: 10 F8       djnz $0A02    ; [uncovered] 
0A0A: 21 02 80    ld   hl,$8002
0A0D: 06 0C       ld   b,$0C
0A0F: 11 14 88    ld   de,$8814
0A12: AF          xor  a
0A13: 77          ld   (hl),a
0A14: 12          ld   (de),a
0A15: 23          inc  hl
0A16: 13          inc  de
0A17: 10 FA       djnz $0A13
0A19: 21 73 80    ld   hl,$8073
0A1C: 22 02 80    ld   ($8002),hl
0A1F: 3E 03       ld   a,$03
0A21: 32 20 80    ld   ($8020),a
0A24: 32 81 A1    ld   ($A181),a
0A27: 32 4B 82    ld   ($824B),a
0A2A: 3A 4B 82    ld   a,($824B)
0A2D: E6 3F       and  $3F
0A2F: 20 F9       jr   nz,$0A2A
0A31: 21 95 82    ld   hl,$8295
0A34: 06 08       ld   b,$08
0A36: 3E 0C       ld   a,$0C
0A38: 77          ld   (hl),a
0A39: 23          inc  hl
0A3A: 10 FC       djnz $0A38
0A3C: 3E 08       ld   a,$08
0A3E: 06 03       ld   b,$03
0A40: 77          ld   (hl),a
0A41: 23          inc  hl
0A42: 10 FC       djnz $0A40
0A44: AF          xor  a
0A45: 32 8C 82    ld   ($828C),a
0A48: 2A 9A 89    ld   hl,($899A)
0A4B: 7E          ld   a,(hl)
0A4C: FE 64       cp   $64
0A4E: 38 02       jr   c,$0A52
0A50: 36 64       ld   (hl),$64    ; [uncovered] 
0A52: 3A 21 80    ld   a,($8021)
0A55: 32 20 80    ld   ($8020),a
0A58: 3E 3C       ld   a,$3C
0A5A: 32 4C 82    ld   ($824C),a
0A5D: 3E 01       ld   a,$01
0A5F: 32 81 A1    ld   ($A181),a
0A62: 21 F4 89    ld   hl,$89F4
0A65: 36 40       ld   (hl),$40
0A67: 23          inc  hl
0A68: 36 10       ld   (hl),$10
0A6A: 2A 9C 89    ld   hl,($899C)
0A6D: 36 01       ld   (hl),$01
0A6F: CD 7D 09    call $097D
0A72: CD 6F 1D    call $1D6F
0A75: CD 69 00    call $0069
0A78: 18 39       jr   $0AB3

0A7A: 31 00 84    ld   sp,$8400
0A7D: 3A 50 80    ld   a,($8050)
0A80: C6 07       add  a,$07
0A82: FE 0F       cp   $0F
0A84: D4 0D 10    call nc,$100D
0A87: 3A 51 80    ld   a,($8051)
0A8A: C6 07       add  a,$07
0A8C: FE 0F       cp   $0F
0A8E: D4 55 10    call nc,$1055
0A91: 3A 4B 82    ld   a,($824B)
0A94: FE 04       cp   $04
0A96: D4 CB 1B    call nc,$1BCB
0A99: 3A 22 80    ld   a,($8022)
0A9C: A7          and  a
0A9D: CA A0 0E    jp   z,$0EA0
0AA0: 3D          dec  a
0AA1: CA 24 0B    jp   z,$0B24
0AA4: 3D          dec  a
0AA5: CA A0 0E    jp   z,$0EA0
0AA8: 3D          dec  a
0AA9: CA 86 15    jp   z,$1586
0AAC: 3D          dec  a
0AAD: CA A0 0E    jp   z,$0EA0
0AB0: CD CF 13    call $13CF
0AB3: AF          xor  a
0AB4: 32 22 80    ld   ($8022),a
0AB7: C3 7A 0A    jp   $0A7A

0ABA: DD 21 68 80 ld   ix,$8068
0ABE: AF          xor  a
0ABF: 32 23 80    ld   ($8023),a
0AC2: 21 48 80    ld   hl,$8048
0AC5: 06 18       ld   b,$18
0AC7: 77          ld   (hl),a
0AC8: 23          inc  hl
0AC9: 10 FC       djnz $0AC7
0ACB: 32 81 A1    ld   ($A181),a
0ACE: 32 50 82    ld   ($8250),a
0AD1: DD 77 00    ld   (ix+$00),a
0AD4: DD 77 01    ld   (ix+$01),a
0AD7: DD 77 02    ld   (ix+$02),a
0ADA: DD 77 03    ld   (ix+$03),a
0ADD: DD 77 04    ld   (ix+$04),a
0AE0: DD 77 05    ld   (ix+$05),a
0AE3: DD 77 06    ld   (ix+$06),a
0AE6: DD 77 07    ld   (ix+$07),a
0AE9: DD 36 08 0F ld   (ix+$08),$0F
0AED: DD 36 0A 32 ld   (ix+$0a),$32
0AF1: DD 77 0B    ld   (ix+$0b),a
0AF4: DD 36 0C 70 ld   (ix+$0c),$70
0AF8: DD 36 0E 74 ld   (ix+$0e),$74
0AFC: DD 36 0F F0 ld   (ix+$0f),$F0
0B00: DD 36 10 01 ld   (ix+$10),$01
0B04: DD 77 13    ld   (ix+$13),a
0B07: C9          ret

0B08: 3A 21 80    ld   a,($8021)
0B0B: A7          and  a
0B0C: C0          ret  nz
0B0D: D5          push de
0B0E: 13          inc  de
0B0F: 1A          ld   a,(de)
0B10: A7          and  a
0B11: D1          pop  de
0B12: C8          ret  z
0B13: C5          push bc    ; [uncovered] 
0B14: 01 08 00    ld   bc,$0008    ; [uncovered] 
0B17: 09          add  hl,bc    ; [uncovered] 
0B18: EB          ex   de,hl    ; [uncovered] 
0B19: 0E 20       ld   c,$20    ; [uncovered] 
0B1B: 09          add  hl,bc    ; [uncovered] 
0B1C: EB          ex   de,hl    ; [uncovered] 
0B1D: C1          pop  bc    ; [uncovered] 
0B1E: E3          ex   (sp),hl    ; [uncovered] 
0B1F: 23          inc  hl    ; [uncovered] 
0B20: 23          inc  hl    ; [uncovered] 
0B21: 23          inc  hl    ; [uncovered] 
0B22: E3          ex   (sp),hl    ; [uncovered] 
0B23: C9          ret    ; [uncovered] 

0B24: DD 21 88 80 ld   ix,enemy_car_structs_8088
0B28: FD 21 68 80 ld   iy,$8068
0B2C: 3A 4E 82    ld   a,(nb_enemy_cars_824e)
0B2F: 47          ld   b,a
0B30: A7          and  a
0B31: CA 91 0C    jp   z,$0C91
0B34: DD 7E 00    ld   a,(ix+$00)
0B37: A7          and  a
0B38: C2 88 0C    jp   nz,$0C88
0B3B: AF          xor  a
0B3C: 32 B5 81    ld   ($81B5),a
0B3F: DD 7E 13    ld   a,(ix+$13)
0B42: DD 35 13    dec  (ix+$13)
0B45: A7          and  a
0B46: C2 4F 0C    jp   nz,$0C4F
0B49: DD 77 13    ld   (ix+$13),a
0B4C: FD 7E 08    ld   a,(iy+$08)
0B4F: DD 96 08    sub  (ix+$08)
0B52: 57          ld   d,a
0B53: 30 02       jr   nc,$0B57
0B55: ED 44       neg
0B57: 5F          ld   e,a
0B58: DD 7E 0A    ld   a,(ix+$0a)
0B5B: FD 96 0A    sub  (iy+$0a)
0B5E: 67          ld   h,a
0B5F: 30 02       jr   nc,$0B63
0B61: ED 44       neg
0B63: 6F          ld   l,a
0B64: 7D          ld   a,l
0B65: FE 07       cp   $07
0B67: 30 33       jr   nc,$0B9C
0B69: 7B          ld   a,e
0B6A: FE 07       cp   $07
0B6C: 30 2E       jr   nc,$0B9C
0B6E: 7D          ld   a,l
0B6F: B3          or   e
0B70: CC 98 0C    call z,$0C98
0B73: D9          exx
0B74: DD 46 0C    ld   b,(ix+$0c)
0B77: DD 4E 0E    ld   c,(ix+$0e)
0B7A: CD 7F 0E    call $0E7F
0B7D: 7E          ld   a,(hl)
0B7E: D9          exx
0B7F: FE BD       cp   $BD
0B81: 38 10       jr   c,$0B93
0B83: FE C6       cp   $C6
0B85: 30 0C       jr   nc,$0B93
0B87: DD 36 00 88 ld   (ix+$00),$88
0B8B: DD 36 15 01 ld   (ix+$15),$01
0B8F: DD 36 13 82 ld   (ix+$13),$82
0B93: 0E 01       ld   c,$01
0B95: 78          ld   a,b
0B96: E6 03       and  $03
0B98: 28 0C       jr   z,$0BA6
0B9A: 18 3E       jr   $0BDA

0B9C: 78          ld   a,b
0B9D: 32 B5 81    ld   ($81B5),a
0BA0: CB 47       bit  0,a
0BA2: 28 36       jr   z,$0BDA
0BA4: 0E 03       ld   c,$03
0BA6: FD 7E 03    ld   a,(iy+$03)
0BA9: A7          and  a
0BAA: 20 18       jr   nz,$0BC4
0BAC: FD CB 02 7E bit  7,(iy+$02)
0BB0: 28 03       jr   z,$0BB5
0BB2: 79          ld   a,c
0BB3: 18 02       jr   $0BB7

0BB5: AF          xor  a
0BB6: 91          sub  c
0BB7: 84          add  a,h
0BB8: 67          ld   h,a
0BB9: CB 7C       bit  7,h
0BBB: 6C          ld   l,h
0BBC: 28 1C       jr   z,$0BDA
0BBE: 7D          ld   a,l
0BBF: ED 44       neg
0BC1: 6F          ld   l,a
0BC2: 18 16       jr   $0BDA

0BC4: FD CB 02 7E bit  7,(iy+$02)
0BC8: 28 04       jr   z,$0BCE
0BCA: AF          xor  a
0BCB: 91          sub  c
0BCC: 18 01       jr   $0BCF

0BCE: 79          ld   a,c
0BCF: 82          add  a,d
0BD0: 57          ld   d,a
0BD1: CB 7A       bit  7,d
0BD3: 5A          ld   e,d
0BD4: 28 04       jr   z,$0BDA
0BD6: 7A          ld   a,d
0BD7: ED 44       neg
0BD9: 5F          ld   e,a
0BDA: DD 7E 05    ld   a,(ix+$05)
0BDD: C6 03       add  a,$03
0BDF: FE 07       cp   $07
0BE1: D2 4F 0C    jp   nc,$0C4F
0BE4: DD 7E 07    ld   a,(ix+$07)
0BE7: C6 03       add  a,$03
0BE9: FE 07       cp   $07
0BEB: D2 4F 0C    jp   nc,$0C4F
0BEE: 7D          ld   a,l
0BEF: BB          cp   e
0BF0: 30 05       jr   nc,$0BF7
0BF2: 4C          ld   c,h
0BF3: 3E FF       ld   a,$FF
0BF5: 18 03       jr   $0BFA

0BF7: 4A          ld   c,d
0BF8: 54          ld   d,h
0BF9: AF          xor  a
0BFA: F5          push af
0BFB: 3A B5 81    ld   a,($81B5)
0BFE: A7          and  a
0BFF: 2A 25 80    ld   hl,($8025)
0C02: 28 03       jr   z,$0C07
0C04: 2A 29 80    ld   hl,($8029)
0C07: F1          pop  af
0C08: CB 7A       bit  7,d
0C0A: C4 11 1E    call nz,$1E11
0C0D: DD 36 14 02 ld   (ix+$14),$02
0C11: 5F          ld   e,a
0C12: DD BE 03    cp   (ix+$03)
0C15: 20 0D       jr   nz,$0C24
0C17: DD 7E 02    ld   a,(ix+$02)
0C1A: AC          xor  h
0C1B: CB 7F       bit  7,a
0C1D: 7B          ld   a,e
0C1E: 20 09       jr   nz,$0C29
0C20: DD 36 14 00 ld   (ix+$14),$00
0C24: CD B1 0C    call $0CB1
0C27: 30 56       jr   nc,$0C7F
0C29: 2F          cpl
0C2A: F5          push af
0C2B: 79          ld   a,c
0C2C: AC          xor  h
0C2D: CB 7F       bit  7,a
0C2F: C4 11 1E    call nz,$1E11
0C32: F1          pop  af
0C33: DD 36 14 02 ld   (ix+$14),$02
0C37: DD BE 03    cp   (ix+$03)
0C3A: 20 0E       jr   nz,$0C4A
0C3C: DD 36 14 00 ld   (ix+$14),$00
0C40: 5F          ld   e,a
0C41: DD 7E 02    ld   a,(ix+$02)
0C44: AC          xor  h
0C45: CB 7F       bit  7,a
0C47: 20 06       jr   nz,$0C4F
0C49: 7B          ld   a,e
0C4A: CD B1 0C    call $0CB1
0C4D: 30 30       jr   nc,$0C7F
0C4F: 2A 25 80    ld   hl,($8025)
0C52: 3A B5 81    ld   a,($81B5)
0C55: A7          and  a
0C56: 28 03       jr   z,$0C5B
0C58: 2A 29 80    ld   hl,($8029)
0C5B: DD 7E 02    ld   a,(ix+$02)
0C5E: AC          xor  h
0C5F: CB 7F       bit  7,a
0C61: C4 11 1E    call nz,$1E11
0C64: DD 7E 03    ld   a,(ix+$03)
0C67: CD B1 0C    call $0CB1
0C6A: 30 13       jr   nc,$0C7F
0C6C: DD 36 14 02 ld   (ix+$14),$02
0C70: 2F          cpl
0C71: CD B1 0C    call $0CB1
0C74: 30 09       jr   nc,$0C7F
0C76: CD 11 1E    call $1E11
0C79: CD B1 0C    call $0CB1
0C7C: 30 01       jr   nc,$0C7F
0C7E: 2F          cpl
0C7F: DD 77 03    ld   (ix+$03),a
0C82: DD 74 02    ld   (ix+$02),h
0C85: DD 75 01    ld   (ix+$01),l
0C88: 11 20 00    ld   de,$0020
0C8B: DD 19       add  ix,de
0C8D: 05          dec  b
0C8E: C2 34 0B    jp   nz,$0B34
0C91: 21 22 80    ld   hl,$8022
0C94: 34          inc  (hl)
0C95: C3 7A 0A    jp   $0A7A

0CB1: C5          push bc
0CB2: 4F          ld   c,a
0CB3: E5          push hl
0CB4: EB          ex   de,hl
0CB5: DD 66 08    ld   h,(ix+$08)
0CB8: DD 6E 0A    ld   l,(ix+$0a)
0CBB: 06 00       ld   b,$00
0CBD: 1E 00       ld   e,$00
0CBF: 79          ld   a,c
0CC0: A7          and  a
0CC1: 20 40       jr   nz,$0D03
0CC3: DD 7E 05    ld   a,(ix+$05)
0CC6: C6 18       add  a,$18
0CC8: FE 2B       cp   $2B
0CCA: 30 1C       jr   nc,$0CE8
0CCC: FE 06       cp   $06
0CCE: 38 15       jr   c,$0CE5
0CD0: FE 1E       cp   $1E
0CD2: 30 04       jr   nc,$0CD8
0CD4: FE 13       cp   $13
0CD6: 30 11       jr   nc,$0CE9
0CD8: 3A 5B 80    ld   a,($805B)
0CDB: A7          and  a
0CDC: CA 5A 0D    jp   z,$0D5A
0CDF: 3C          inc  a
0CE0: CA 5A 0D    jp   z,$0D5A
0CE3: 18 04       jr   $0CE9    ; [uncovered] 

0CE5: 25          dec  h
0CE6: 18 01       jr   $0CE9

0CE8: 24          inc  h
0CE9: CB 7A       bit  7,d
0CEB: 20 0B       jr   nz,$0CF8
0CED: DD 7E 07    ld   a,(ix+$07)
0CF0: 1D          dec  e
0CF1: A7          and  a
0CF2: FA 3C 0D    jp   m,$0D3C
0CF5: 2D          dec  l
0CF6: 18 44       jr   $0D3C

0CF8: DD 7E 07    ld   a,(ix+$07)
0CFB: 1C          inc  e
0CFC: 3D          dec  a
0CFD: F2 3C 0D    jp   p,$0D3C
0D00: 2C          inc  l
0D01: 18 39       jr   $0D3C

0D03: DD 7E 07    ld   a,(ix+$07)
0D06: C6 18       add  a,$18
0D08: FE 2B       cp   $2B
0D0A: 30 1A       jr   nc,$0D26
0D0C: FE 06       cp   $06
0D0E: 38 13       jr   c,$0D23
0D10: FE 1E       cp   $1E
0D12: 30 04       jr   nc,$0D18
0D14: FE 13       cp   $13
0D16: 30 0F       jr   nc,$0D27
0D18: 3A 5B 80    ld   a,($805B)
0D1B: A7          and  a
0D1C: 28 3C       jr   z,$0D5A
0D1E: 3C          inc  a
0D1F: 28 39       jr   z,$0D5A
0D21: 18 04       jr   $0D27    ; [uncovered] 

0D23: 2C          inc  l
0D24: 18 01       jr   $0D27

0D26: 2D          dec  l
0D27: DD 7E 05    ld   a,(ix+$05)
0D2A: CB 7A       bit  7,d
0D2C: 20 08       jr   nz,$0D36
0D2E: 04          inc  b
0D2F: A7          and  a
0D30: FA 3C 0D    jp   m,$0D3C
0D33: 24          inc  h
0D34: 18 06       jr   $0D3C

0D36: 05          dec  b
0D37: 3D          dec  a
0D38: F2 3C 0D    jp   p,$0D3C
0D3B: 25          dec  h
0D3C: EB          ex   de,hl
0D3D: CD F2 12    call $12F2
0D40: 08          ex   af,af'
0D41: 7A          ld   a,d
0D42: 80          add  a,b
0D43: 57          ld   d,a
0D44: 7B          ld   a,e
0D45: 85          add  a,l
0D46: 5F          ld   e,a
0D47: CD F2 12    call $12F2
0D4A: 38 09       jr   c,$0D55
0D4C: 7A          ld   a,d
0D4D: 80          add  a,b
0D4E: 57          ld   d,a
0D4F: 7B          ld   a,e
0D50: 85          add  a,l
0D51: 5F          ld   e,a
0D52: CD F2 12    call $12F2
0D55: 08          ex   af,af'
0D56: E1          pop  hl
0D57: 79          ld   a,c
0D58: C1          pop  bc
0D59: C9          ret

0D5A: E1          pop  hl
0D5B: 79          ld   a,c
0D5C: C1          pop  bc
0D5D: 37          scf
0D5E: C9          ret

0D5F: 2B          dec  hl
0D60: 7D          ld   a,l
0D61: F6 E0       or   $E0
0D63: 3C          inc  a
0D64: C0          ret  nz
0D65: 21 00 9F    ld   hl,$9F00
0D68: C9          ret

0D69: 23          inc  hl
0D6A: 7D          ld   a,l
0D6B: E6 1F       and  $1F
0D6D: C0          ret  nz
0D6E: 21 00 9F    ld   hl,$9F00    ; [uncovered] 
0D71: C9          ret    ; [uncovered] 

0D72: E5          push hl
0D73: D5          push de
0D74: F5          push af
0D75: 2A 00 80    ld   hl,($8000)
0D78: 29          add  hl,hl
0D79: 30 01       jr   nc,$0D7C
0D7B: 2C          inc  l
0D7C: 7D          ld   a,l
0D7D: E6 49       and  $49
0D7F: 20 04       jr   nz,$0D85
0D81: 11 80 40    ld   de,$4080
0D84: 19          add  hl,de
0D85: 22 00 80    ld   ($8000),hl
0D88: F1          pop  af
0D89: D1          pop  de
0D8A: E1          pop  hl
0D8B: C9          ret

0D8C: 57          ld   d,a
0D8D: 1E 09       ld   e,$09
0D8F: 23          inc  hl
0D90: CB 7F       bit  7,a
0D92: 28 03       jr   z,$0D97
0D94: 2B          dec  hl
0D95: 34          inc  (hl)
0D96: 23          inc  hl
0D97: 86          add  a,(hl)
0D98: 77          ld   (hl),a
0D99: 30 03       jr   nc,$0D9E
0D9B: 2B          dec  hl
0D9C: 34          inc  (hl)
0D9D: 23          inc  hl
0D9E: 7D          ld   a,l
0D9F: C6 20       add  a,$20
0DA1: 30 01       jr   nc,$0DA4
0DA3: 24          inc  h
0DA4: 6F          ld   l,a
0DA5: 7A          ld   a,d
0DA6: 1D          dec  e
0DA7: 20 E7       jr   nz,$0D90
0DA9: C9          ret

0DB2: E5          push hl
0DB3: D5          push de
0DB4: C5          push bc
0DB5: 2A 9E 89    ld   hl,($899E)
0DB8: 7E          ld   a,(hl)
0DB9: 21 90 82    ld   hl,$8290
0DBC: 0F          rrca
0DBD: 0F          rrca
0DBE: CB 16       rl   (hl)
0DC0: 7E          ld   a,(hl)
0DC1: E6 0F       and  $0F
0DC3: FE 0C       cp   $0C
0DC5: 23          inc  hl
0DC6: 20 2C       jr   nz,$0DF4
0DC8: 7E          ld   a,(hl)
0DC9: A7          and  a
0DCA: 20 28       jr   nz,$0DF4
0DCC: ED 5B 8A 89 ld   de,($898A)
0DD0: 1A          ld   a,(de)
0DD1: E6 03       and  $03
0DD3: 28 1F       jr   z,$0DF4
0DD5: 3A 21 80    ld   a,($8021)
0DD8: A7          and  a
0DD9: 28 19       jr   z,$0DF4
0DDB: ED 5B 8E 89 ld   de,($898E)
0DDF: 13          inc  de
0DE0: 1A          ld   a,(de)
0DE1: A7          and  a
0DE2: 28 10       jr   z,$0DF4
0DE4: 06 03       ld   b,$03
0DE6: 3D          dec  a
0DE7: 28 0B       jr   z,$0DF4
0DE9: FE 0A       cp   $0A
0DEB: CC AA 0D    call z,$0DAA
0DEE: 10 F6       djnz $0DE6
0DF0: 12          ld   (de),a
0DF1: 34          inc  (hl)
0DF2: 34          inc  (hl)
0DF3: 34          inc  (hl)
0DF4: 7E          ld   a,(hl)
0DF5: A7          and  a
0DF6: 28 61       jr   z,$0E59
0DF8: DD 21 68 80 ld   ix,$8068
0DFC: DD 7E 0F    ld   a,(ix+$0f)
0DFF: 06 08       ld   b,$08
0E01: 0E F0       ld   c,$F0
0E03: FE F0       cp   $F0
0E05: 28 14       jr   z,$0E1B
0E07: 0E 18       ld   c,$18
0E09: FE F2       cp   $F2
0E0B: 28 0E       jr   z,$0E1B
0E0D: 0E 08       ld   c,$08
0E0F: 06 20       ld   b,$20
0E11: FE FC       cp   $FC
0E13: 28 06       jr   z,$0E1B
0E15: 06 F0       ld   b,$F0
0E17: FE FD       cp   $FD
0E19: 20 3E       jr   nz,$0E59
0E1B: DD 7E 0C    ld   a,(ix+$0c)
0E1E: 90          sub  b
0E1F: 47          ld   b,a
0E20: DD 7E 0E    ld   a,(ix+$0e)
0E23: 81          add  a,c
0E24: 4F          ld   c,a
0E25: CD 7F 0E    call $0E7F
0E28: 54          ld   d,h
0E29: 5D          ld   e,l
0E2A: CB DC       set  3,h
0E2C: CB 7E       bit  7,(hl)
0E2E: 28 29       jr   z,$0E59
0E30: 1A          ld   a,(de)
0E31: FE 81       cp   $81
0E33: 20 24       jr   nz,$0E59
0E35: CB BE       res  7,(hl)
0E37: 06 03       ld   b,$03
0E39: 3E BD       ld   a,$BD
0E3B: 0E 03       ld   c,$03
0E3D: E5          push hl
0E3E: D5          push de
0E3F: 12          ld   (de),a
0E40: 3C          inc  a
0E41: 36 45       ld   (hl),$45
0E43: CD 5D 0E    call $0E5D
0E46: 0D          dec  c
0E47: 20 F6       jr   nz,$0E3F
0E49: D1          pop  de
0E4A: E1          pop  hl
0E4B: CD 6C 0E    call $0E6C
0E4E: 10 EB       djnz $0E3B
0E50: 21 91 82    ld   hl,$8291
0E53: 35          dec  (hl)
0E54: 21 F4 89    ld   hl,$89F4
0E57: CB E6       set  4,(hl)
0E59: C1          pop  bc
0E5A: D1          pop  de
0E5B: E1          pop  hl
0E5C: C9          ret

0E5D: F5          push af
0E5E: 7B          ld   a,e
0E5F: F6 E0       or   $E0
0E61: 3C          inc  a
0E62: 20 04       jr   nz,$0E68
0E64: 7B          ld   a,e
0E65: D6 20       sub  $20
0E67: 5F          ld   e,a
0E68: 1C          inc  e
0E69: 6B          ld   l,e
0E6A: F1          pop  af
0E6B: C9          ret

0E6C: C5          push bc
0E6D: F5          push af
0E6E: 01 20 00    ld   bc,$0020
0E71: 09          add  hl,bc
0E72: 7C          ld   a,h
0E73: E6 03       and  $03
0E75: F6 8C       or   $8C
0E77: 67          ld   h,a
0E78: E6 F7       and  $F7
0E7A: 57          ld   d,a
0E7B: 5D          ld   e,l
0E7C: F1          pop  af
0E7D: C1          pop  bc
0E7E: C9          ret

0E7F: 3A 4D 80    ld   a,($804D)
0E82: 80          add  a,b
0E83: C6 03       add  a,$03
0E85: 0F          rrca
0E86: 0F          rrca
0E87: 0F          rrca
0E88: E6 1F       and  $1F
0E8A: 47          ld   b,a
0E8B: 3A 4F 80    ld   a,($804F)
0E8E: ED 44       neg
0E90: 91          sub  c
0E91: D6 08       sub  $08
0E93: 26 21       ld   h,$21
0E95: 17          rla
0E96: CB 14       rl   h
0E98: 17          rla
0E99: CB 14       rl   h
0E9B: E6 E0       and  $E0
0E9D: B0          or   b
0E9E: 6F          ld   l,a
0E9F: C9          ret

0EA0: 11 00 00    ld   de,$0000
0EA3: DD 21 68 80 ld   ix,$8068
0EA7: DD 7E 13    ld   a,(ix+$13)
0EAA: DD 35 13    dec  (ix+$13)
0EAD: A7          and  a
0EAE: C2 A6 0F    jp   nz,$0FA6
0EB1: DD 77 13    ld   (ix+$13),a
0EB4: 21 F4 89    ld   hl,$89F4
0EB7: CB F6       set  6,(hl)
0EB9: 2A 27 80    ld   hl,(car_speed_8027)
0EBC: ED 4B 9E 89 ld   bc,($899E)
0EC0: 0A          ld   a,(bc)
0EC1: 47          ld   b,a
0EC2: F3          di
0EC3: 22 2D 80    ld   ($802D),hl
0EC6: AF          xor  a
0EC7: 32 68 80    ld   ($8068),a
0ECA: 32 48 80    ld   ($8048),a
0ECD: 2A 69 80    ld   hl,($8069)
0ED0: 3A 20 80    ld   a,($8020)
0ED3: A7          and  a
0ED4: CC 8E 1B    call z,$1B8E
0ED7: CD D8 0F    call $0FD8
0EDA: 30 79       jr   nc,$0F55
0EDC: 3A 6B 80    ld   a,($806B)
0EDF: 2A 69 80    ld   hl,($8069)
0EE2: CD B1 0C    call $0CB1
0EE5: 30 2F       jr   nc,$0F16
0EE7: 2F          cpl
0EE8: 57          ld   d,a
0EE9: 3A 4B 80    ld   a,($804B)
0EEC: A7          and  a
0EED: 3E 00       ld   a,$00
0EEF: 32 4B 80    ld   ($804B),a
0EF2: 7A          ld   a,d
0EF3: 28 0B       jr   z,$0F00
0EF5: 2A 49 80    ld   hl,($8049)
0EF8: CD B1 0C    call $0CB1
0EFB: 30 19       jr   nc,$0F16
0EFD: 2A 69 80    ld   hl,($8069)    ; [uncovered] 
0F00: A7          and  a
0F01: CC 11 1E    call z,$1E11
0F04: CD B1 0C    call $0CB1
0F07: 30 0D       jr   nc,$0F16
0F09: CD 11 1E    call $1E11
0F0C: CD B1 0C    call $0CB1
0F0F: 30 05       jr   nc,$0F16
0F11: A7          and  a    ; [uncovered] 
0F12: CC 11 1E    call z,$1E11    ; [uncovered] 
0F15: 2F          cpl    ; [uncovered] 
0F16: 32 6B 80    ld   ($806B),a
0F19: 22 69 80    ld   ($8069),hl
0F1C: EB          ex   de,hl
0F1D: 2A 2D 80    ld   hl,($802D)
0F20: F5          push af
0F21: 7A          ld   a,d
0F22: AC          xor  h
0F23: CB 7F       bit  7,a
0F25: C4 11 1E    call nz,$1E11
0F28: F1          pop  af
0F29: 22 2D 80    ld   ($802D),hl
0F2C: FB          ei
0F2D: 21 80 00    ld   hl,$0080
0F30: A7          and  a
0F31: CA 78 0F    jp   z,$0F78
0F34: CB 68       bit  5,b
0F36: CA B0 0F    jp   z,$0FB0
0F39: CB 60       bit  4,b
0F3B: CA BA 0F    jp   z,$0FBA
0F3E: 3A 6F 80    ld   a,($806F)
0F41: A7          and  a
0F42: CA 99 0F    jp   z,$0F99
0F45: FE 13       cp   $13
0F47: F2 9C 0F    jp   p,$0F9C
0F4A: FE EE       cp   $EE
0F4C: FA 94 0F    jp   m,$0F94
0F4F: CB 7F       bit  7,a
0F51: 20 49       jr   nz,$0F9C
0F53: 18 3F       jr   $0F94

0F55: 08          ex   af,af'
0F56: 38 04       jr   c,$0F5C
0F58: 08          ex   af,af'
0F59: C3 16 0F    jp   $0F16

0F5C: 08          ex   af,af'
0F5D: C5          push bc
0F5E: DD 46 03    ld   b,(ix+$03)
0F61: B8          cp   b
0F62: C1          pop  bc
0F63: CA 16 0F    jp   z,$0F16
0F66: 08          ex   af,af'
0F67: 3E 01       ld   a,$01
0F69: 32 4B 80    ld   ($804B),a
0F6C: 08          ex   af,af'
0F6D: ED 5B 69 80 ld   de,($8069)
0F71: ED 53 49 80 ld   ($8049),de
0F75: C3 16 0F    jp   $0F16

0F78: CB 58       bit  3,b
0F7A: 28 48       jr   z,$0FC4
0F7C: CB 50       bit  2,b
0F7E: 28 4E       jr   z,$0FCE
0F80: 3A 6D 80    ld   a,($806D)
0F83: A7          and  a
0F84: 28 13       jr   z,$0F99
0F86: FE 13       cp   $13
0F88: F2 9C 0F    jp   p,$0F9C
0F8B: FE EE       cp   $EE
0F8D: FA 94 0F    jp   m,$0F94
0F90: CB 7F       bit  7,a
0F92: 20 08       jr   nz,$0F9C
0F94: 21 80 FF    ld   hl,$FF80
0F97: 18 03       jr   $0F9C

0F99: 21 00 00    ld   hl,$0000
0F9C: 22 5A 80    ld   ($805A),hl
0F9F: 3A 20 80    ld   a,($8020)
0FA2: A7          and  a
0FA3: CC C5 1B    call z,$1BC5
0FA6: 3A 22 80    ld   a,($8022)
0FA9: 3C          inc  a
0FAA: 32 22 80    ld   ($8022),a
0FAD: C3 7A 0A    jp   $0A7A

0FB0: 3A 6F 80    ld   a,($806F)
0FB3: FE 03       cp   $03
0FB5: FA 9C 0F    jp   m,$0F9C
0FB8: 18 DF       jr   $0F99

0FBA: 3A 6F 80    ld   a,($806F)
0FBD: FE FE       cp   $FE
0FBF: F2 94 0F    jp   p,$0F94
0FC2: 18 D5       jr   $0F99

0FC4: 3A 6D 80    ld   a,($806D)
0FC7: FE 03       cp   $03
0FC9: FA 9C 0F    jp   m,$0F9C
0FCC: 18 CB       jr   $0F99

0FCE: 3A 6D 80    ld   a,($806D)
0FD1: FE FE       cp   $FE
0FD3: F2 94 0F    jp   p,$0F94
0FD6: 18 C1       jr   $0F99

0FD8: 78          ld   a,b
0FD9: CB 6F       bit  5,a
0FDB: 28 0E       jr   z,$0FEB
0FDD: CB 67       bit  4,a
0FDF: 28 17       jr   z,$0FF8
0FE1: CB 5F       bit  3,a
0FE3: 28 20       jr   z,$1005
0FE5: CB 57       bit  2,a
0FE7: 28 20       jr   z,$1009
0FE9: 37          scf
0FEA: C9          ret

0FEB: 3E 00       ld   a,$00
0FED: CB 7C       bit  7,h
0FEF: CA B1 0C    jp   z,$0CB1
0FF2: CD 11 1E    call $1E11
0FF5: C3 B1 0C    jp   $0CB1

0FF8: 3E 00       ld   a,$00
0FFA: CB 7C       bit  7,h
0FFC: C2 B1 0C    jp   nz,$0CB1
0FFF: CD 11 1E    call $1E11
1002: C3 B1 0C    jp   $0CB1

1005: 3E FF       ld   a,$FF
1007: 18 E4       jr   $0FED

1009: 3E FF       ld   a,$FF
100B: 18 ED       jr   $0FFA

100D: F3          di
100E: CB 7F       bit  7,a
1010: 28 22       jr   z,$1034
1012: 3A 50 80    ld   a,($8050)
1015: C6 08       add  a,$08
1017: 32 50 80    ld   ($8050),a
101A: 3A 54 80    ld   a,($8054)
101D: 3C          inc  a
101E: 32 54 80    ld   ($8054),a
1021: FE 03       cp   $03
1023: C2 CC 10    jp   nz,$10CC
1026: AF          xor  a
1027: 32 54 80    ld   ($8054),a
102A: 3A 52 80    ld   a,($8052)
102D: 3C          inc  a
102E: 32 52 80    ld   ($8052),a
1031: C3 CC 10    jp   $10CC

1034: 3A 50 80    ld   a,($8050)
1037: D6 08       sub  $08
1039: 32 50 80    ld   ($8050),a
103C: 3A 54 80    ld   a,($8054)
103F: 3D          dec  a
1040: 32 54 80    ld   ($8054),a
1043: F2 F6 10    jp   p,$10F6
1046: 3E 02       ld   a,$02
1048: 32 54 80    ld   ($8054),a
104B: 3A 52 80    ld   a,($8052)
104E: 3D          dec  a
104F: 32 52 80    ld   ($8052),a
1052: C3 F6 10    jp   $10F6

1055: F3          di
1056: CB 7F       bit  7,a
1058: 28 22       jr   z,$107C
105A: 3A 51 80    ld   a,($8051)
105D: C6 08       add  a,$08
105F: 32 51 80    ld   ($8051),a
1062: 3A 55 80    ld   a,($8055)
1065: 3C          inc  a
1066: 32 55 80    ld   ($8055),a
1069: FE 03       cp   $03
106B: C2 9D 10    jp   nz,$109D
106E: AF          xor  a
106F: 32 55 80    ld   ($8055),a
1072: 3A 53 80    ld   a,($8053)
1075: 3C          inc  a
1076: 32 53 80    ld   ($8053),a
1079: C3 9D 10    jp   $109D

107C: 3A 51 80    ld   a,($8051)
107F: D6 08       sub  $08
1081: 32 51 80    ld   ($8051),a
1084: 3A 55 80    ld   a,($8055)
1087: 3D          dec  a
1088: 32 55 80    ld   ($8055),a
108B: F2 C1 10    jp   p,$10C1
108E: 3E 02       ld   a,$02
1090: 32 55 80    ld   ($8055),a
1093: 3A 53 80    ld   a,($8053)
1096: 3D          dec  a
1097: 32 53 80    ld   ($8053),a
109A: C3 C1 10    jp   $10C1

109D: CD 27 11    call $1127
10A0: ED 5B 54 80 ld   de,($8054)
10A4: 14          inc  d
10A5: 7A          ld   a,d
10A6: FE 03       cp   $03
10A8: 20 03       jr   nz,$10AD
10AA: 24          inc  h
10AB: 16 00       ld   d,$00
10AD: 7C          ld   a,h
10AE: C6 0A       add  a,$0A
10B0: 32 59 80    ld   ($8059),a
10B3: 2A 56 80    ld   hl,($8056)
10B6: 01 E0 FF    ld   bc,$FFE0
10B9: 09          add  hl,bc
10BA: CB D4       set  2,h
10BC: 22 56 80    ld   ($8056),hl
10BF: 18 07       jr   $10C8

10C1: CD 27 11    call $1127
10C4: ED 5B 54 80 ld   de,($8054)
10C8: FB          ei
10C9: C3 62 11    jp   $1162

10CC: CD 27 11    call $1127
10CF: ED 5B 54 80 ld   de,($8054)
10D3: 1C          inc  e
10D4: 7B          ld   a,e
10D5: FE 03       cp   $03
10D7: 20 03       jr   nz,$10DC
10D9: 1E 00       ld   e,$00
10DB: 2C          inc  l
10DC: 7D          ld   a,l
10DD: C6 0A       add  a,$0A
10DF: 32 58 80    ld   ($8058),a
10E2: 2A 56 80    ld   hl,($8056)
10E5: 7D          ld   a,l
10E6: E6 1F       and  $1F
10E8: 20 06       jr   nz,$10F0
10EA: 7D          ld   a,l
10EB: F6 1F       or   $1F
10ED: 6F          ld   l,a
10EE: 18 01       jr   $10F1

10F0: 2B          dec  hl
10F1: 22 56 80    ld   ($8056),hl
10F4: 18 07       jr   $10FD

10F6: CD 27 11    call $1127
10F9: ED 5B 54 80 ld   de,($8054)
10FD: FB          ei
10FE: 06 20       ld   b,$20
1100: 48          ld   c,b
1101: 2A 58 80    ld   hl,($8058)
1104: CD 1E 13    call $131E
1107: 14          inc  d
1108: 05          dec  b
1109: C8          ret  z
110A: E5          push hl
110B: 2A 56 80    ld   hl,($8056)
110E: 78          ld   a,b
110F: 06 00       ld   b,$00
1111: 09          add  hl,bc
1112: 47          ld   b,a
1113: 7C          ld   a,h
1114: E6 03       and  $03
1116: F6 84       or   $84
1118: 67          ld   h,a
1119: 22 56 80    ld   ($8056),hl
111C: E1          pop  hl
111D: 7A          ld   a,d
111E: FE 03       cp   $03
1120: 20 E2       jr   nz,$1104
1122: 16 00       ld   d,$00
1124: 24          inc  h
1125: 18 DD       jr   $1104

1127: CD 97 14    call $1497
112A: 2A 52 80    ld   hl,($8052)
112D: 22 58 80    ld   ($8058),hl
1130: C9          ret

1131: CD 27 11    call $1127
1134: ED 5B 54 80 ld   de,($8054)
1138: 06 20       ld   b,$20
113A: CD 62 11    call $1162
113D: 32 80 A0    ld   (watchdog_a080),a
1140: 2A 56 80    ld   hl,($8056)
1143: 78          ld   a,b
1144: 01 20 00    ld   bc,$0020
1147: 09          add  hl,bc
1148: 47          ld   b,a
1149: CB D4       set  2,h
114B: CB 9C       res  3,h
114D: 22 56 80    ld   ($8056),hl
1150: 7A          ld   a,d
1151: 05          dec  b
1152: C8          ret  z
1153: FE 03       cp   $03
1155: 20 E3       jr   nz,$113A
1157: 3A 59 80    ld   a,($8059)
115A: 3C          inc  a
115B: 32 59 80    ld   ($8059),a
115E: 16 00       ld   d,$00
1160: 18 D8       jr   $113A

1162: C5          push bc
1163: D5          push de
1164: 06 20       ld   b,$20
1166: 2A 58 80    ld   hl,($8058)
1169: CD 1E 13    call $131E
116C: 1C          inc  e
116D: E5          push hl
116E: 2A 56 80    ld   hl,($8056)
1171: 23          inc  hl
1172: 7D          ld   a,l
1173: E6 1F       and  $1F
1175: 20 05       jr   nz,$117C
1177: 2B          dec  hl
1178: 7D          ld   a,l
1179: E6 E0       and  $E0
117B: 6F          ld   l,a
117C: 22 56 80    ld   ($8056),hl
117F: E1          pop  hl
1180: 05          dec  b
1181: 28 0A       jr   z,$118D
1183: 7B          ld   a,e
1184: FE 03       cp   $03
1186: 20 E1       jr   nz,$1169
1188: 1E 00       ld   e,$00
118A: 2C          inc  l
118B: 18 DC       jr   $1169

118D: D1          pop  de
118E: C1          pop  bc
118F: 14          inc  d
1190: C9          ret

1191: 2A 96 89    ld   hl,($8996)
1194: 11 20 00    ld   de,$0020
1197: 19          add  hl,de
1198: ED 5B 94 89 ld   de,($8994)
119C: 3E FF       ld   a,$FF
119E: 06 18       ld   b,$18
11A0: 77          ld   (hl),a
11A1: 12          ld   (de),a
11A2: 13          inc  de
11A3: 23          inc  hl
11A4: 10 FA       djnz $11A0
11A6: 3A 51 82    ld   a,(nb_rocks_8251)
11A9: 47          ld   b,a
11AA: DD 2A 96 89 ld   ix,($8996)
11AE: 0E 00       ld   c,$00
11B0: CD 72 0D    call $0D72
11B3: 3A 00 80    ld   a,($8000)
11B6: E6 1E       and  $1E
11B8: C6 E0       add  a,$E0
11BA: 6F          ld   l,a
11BB: 3A 8F 82    ld   a,($828F)
11BE: 67          ld   h,a
11BF: 5E          ld   e,(hl)
11C0: 23          inc  hl
11C1: 56          ld   d,(hl)
11C2: EB          ex   de,hl
11C3: 18 37       jr   $11FC

11C5: 00          nop
11C6: DD 2A 96 89 ld   ix,($8996)
11CA: 11 20 00    ld   de,$0020
11CD: DD 19       add  ix,de
11CF: 0E 01       ld   c,$01
11D1: 06 0A       ld   b,$0A
11D3: DD 2A 92 89 ld   ix,($8992)
11D7: 3A 20 80    ld   a,($8020)
11DA: A7          and  a
11DB: 20 05       jr   nz,$11E2
11DD: 3E 34       ld   a,$34    ; [uncovered] 
11DF: 32 8F 82    ld   ($828F),a    ; [uncovered] 
11E2: 79          ld   a,c
11E3: A7          and  a
11E4: 28 CA       jr   z,$11B0
11E6: CD 72 0D    call $0D72
11E9: 3A 01 80    ld   a,($8001)
11EC: E6 3F       and  $3F
11EE: 67          ld   h,a
11EF: 3A 00 80    ld   a,($8000)
11F2: E6 1F       and  $1F
11F4: 6F          ld   l,a
11F5: 5C          ld   e,h
11F6: 55          ld   d,l
11F7: CD F2 12    call $12F2
11FA: 38 E6       jr   c,$11E2
11FC: C5          push bc
11FD: 0E 0A       ld   c,$0A
11FF: ED 5B 94 89 ld   de,($8994)
1203: CD 5F 12    call $125F
1206: C1          pop  bc
1207: 38 D9       jr   c,$11E2
1209: 3A 51 82    ld   a,(nb_rocks_8251)
120C: C5          push bc
120D: 4F          ld   c,a
120E: E5          push hl
120F: 2A 96 89    ld   hl,($8996)
1212: 11 20 00    ld   de,$0020
1215: 19          add  hl,de
1216: EB          ex   de,hl
1217: E1          pop  hl
1218: CD 5F 12    call $125F
121B: C1          pop  bc
121C: 38 C4       jr   c,$11E2
121E: C5          push bc
121F: 11 5B 12    ld   de,$125B
1222: 0E 02       ld   c,$02
1224: CD 5F 12    call $125F
1227: C1          pop  bc
1228: 38 B8       jr   c,$11E2
122A: DD 74 21    ld   (ix+$21),h
122D: DD 75 20    ld   (ix+$20),l
1230: 7D          ld   a,l
1231: 87          add  a,a
1232: 87          add  a,a
1233: 87          add  a,a
1234: CB 3C       srl  h
1236: 1F          rra
1237: CB 3C       srl  h
1239: 1F          rra
123A: CB 3C       srl  h
123C: 1F          rra
123D: 6F          ld   l,a
123E: 7C          ld   a,h
123F: E6 07       and  $07
1241: F6 98       or   $98
1243: 67          ld   h,a
1244: DD 74 01    ld   (ix+$01),h
1247: DD 75 00    ld   (ix+$00),l
124A: DD 23       inc  ix
124C: DD 23       inc  ix
124E: 10 92       djnz $11E2
1250: 3A 20 80    ld   a,($8020)
1253: A7          and  a
1254: C0          ret  nz
1255: 3E 28       ld   a,$28    ; [uncovered] 
1257: 32 8F 82    ld   ($828F),a    ; [uncovered] 
125A: C9          ret    ; [uncovered] 

125F: 1A          ld   a,(de)
1260: 13          inc  de
1261: FE FF       cp   $FF
1263: 28 12       jr   z,$1277
1265: 95          sub  l
1266: C6 04       add  a,$04
1268: FE 09       cp   $09
126A: 30 0B       jr   nc,$1277
126C: 1A          ld   a,(de)
126D: FE FF       cp   $FF
126F: 28 06       jr   z,$1277
1271: 94          sub  h
1272: C6 04       add  a,$04
1274: FE 09       cp   $09
1276: D8          ret  c
1277: 13          inc  de
1278: 0D          dec  c
1279: 20 E4       jr   nz,$125F
127B: AF          xor  a
127C: C9          ret

127D: 0E 80       ld   c,$80
127F: E5          push hl
1280: 7B          ld   a,e
1281: 0F          rrca
1282: 0F          rrca
1283: C6 04       add  a,$04
1285: E6 07       and  $07
1287: 6F          ld   l,a
1288: 7A          ld   a,d
1289: 26 40       ld   h,$40
128B: 17          rla
128C: 17          rla
128D: 17          rla
128E: CB 14       rl   h
1290: E6 E0       and  $E0
1292: B5          or   l
1293: 24          inc  h
1294: C6 80       add  a,$80
1296: 30 01       jr   nc,$1299
1298: 24          inc  h
1299: 6F          ld   l,a
129A: 71          ld   (hl),c
129B: CB DC       set  3,h
129D: 7E          ld   a,(hl)
129E: E6 3F       and  $3F
12A0: CB 4B       bit  1,e
12A2: 28 02       jr   z,$12A6
12A4: F6 40       or   $40
12A6: CB 4A       bit  1,d
12A8: 28 02       jr   z,$12AC
12AA: F6 80       or   $80
12AC: 77          ld   (hl),a
12AD: E1          pop  hl
12AE: C9          ret

12AF: 2A 94 89    ld   hl,($8994)
12B2: 0E C6       ld   c,$C6
12B4: 06 0A       ld   b,$0A
12B6: 5E          ld   e,(hl)
12B7: 7B          ld   a,e
12B8: 23          inc  hl
12B9: 56          ld   d,(hl)
12BA: 23          inc  hl
12BB: A2          and  d
12BC: 3C          inc  a
12BD: 28 03       jr   z,$12C2
12BF: CD 7F 12    call $127F
12C2: 10 F2       djnz $12B6
12C4: C9          ret

12C5: E5          push hl
12C6: D5          push de
12C7: C5          push bc
12C8: AF          xor  a
12C9: EB          ex   de,hl
12CA: CD F2 12    call $12F2
12CD: 30 1F       jr   nc,$12EE
12CF: 15          dec  d
12D0: 1D          dec  e
12D1: 21 67 22    ld   hl,$2267
12D4: 0E 03       ld   c,$03
12D6: 06 03       ld   b,$03
12D8: CD F2 12    call $12F2
12DB: 30 01       jr   nc,$12DE
12DD: B6          or   (hl)
12DE: 23          inc  hl
12DF: 14          inc  d
12E0: 10 F6       djnz $12D8
12E2: 15          dec  d
12E3: 15          dec  d
12E4: 15          dec  d
12E5: 1C          inc  e
12E6: 0D          dec  c
12E7: 20 ED       jr   nz,$12D6
12E9: A7          and  a
12EA: 20 02       jr   nz,$12EE
12EC: F6 87       or   $87
12EE: C1          pop  bc
12EF: D1          pop  de
12F0: E1          pop  hl
12F1: C9          ret

12F2: D5          push de
12F3: C5          push bc
12F4: 4F          ld   c,a
12F5: 7A          ld   a,d
12F6: FE 20       cp   $20
12F8: 30 1F       jr   nc,$1319
12FA: E6 07       and  $07
12FC: 47          ld   b,a
12FD: 04          inc  b
12FE: 7B          ld   a,e
12FF: FE 38       cp   $38
1301: 30 16       jr   nc,$1319
1303: 7A          ld   a,d
1304: 87          add  a,a
1305: 87          add  a,a
1306: 87          add  a,a
1307: 87          add  a,a
1308: CB 13       rl   e
130A: 87          add  a,a
130B: CB 13       rl   e
130D: 3A 8F 82    ld   a,($828F)
1310: 57          ld   d,a
1311: 1A          ld   a,(de)
1312: 87          add  a,a
1313: 10 FD       djnz $1312
1315: 79          ld   a,c
1316: C1          pop  bc
1317: D1          pop  de
1318: C9          ret

1319: 79          ld   a,c
131A: C1          pop  bc
131B: D1          pop  de
131C: 37          scf
131D: C9          ret

131E: C5          push bc
131F: D5          push de
1320: E5          push hl
1321: 7C          ld   a,h
1322: FE 38       cp   $38
1324: D2 B5 13    jp   nc,$13B5
1327: 7D          ld   a,l
1328: FE 20       cp   $20
132A: D2 B5 13    jp   nc,$13B5
132D: 87          add  a,a
132E: 87          add  a,a
132F: 87          add  a,a
1330: CB 3C       srl  h
1332: 1F          rra
1333: CB 3C       srl  h
1335: 1F          rra
1336: CB 3C       srl  h
1338: 1F          rra
1339: 6F          ld   l,a
133A: 7C          ld   a,h
133B: E6 07       and  $07
133D: F6 98       or   $98
133F: 67          ld   h,a
1340: 4E          ld   c,(hl)
1341: 79          ld   a,c
1342: E6 F8       and  $F8
1344: CA 86 13    jp   z,$1386
1347: 7A          ld   a,d
1348: 87          add  a,a
1349: 82          add  a,d
134A: 83          add  a,e
134B: 87          add  a,a
134C: 87          add  a,a
134D: 21 3B 22    ld   hl,$223B
1350: 85          add  a,l
1351: 30 01       jr   nc,$1354
1353: 24          inc  h    ; [uncovered] 
1354: 6F          ld   l,a
1355: 1E 00       ld   e,$00
1357: 46          ld   b,(hl)
1358: 23          inc  hl
1359: 7E          ld   a,(hl)
135A: A1          and  c
135B: 28 02       jr   z,$135F
135D: CB D3       set  2,e
135F: 23          inc  hl
1360: 7E          ld   a,(hl)
1361: A1          and  c
1362: 28 02       jr   z,$1366
1364: CB CB       set  1,e
1366: 23          inc  hl
1367: 7E          ld   a,(hl)
1368: A1          and  c
1369: 28 02       jr   z,$136D
136B: CB C3       set  0,e
136D: 7B          ld   a,e
136E: 21 5F 22    ld   hl,$225F
1371: 85          add  a,l
1372: 30 01       jr   nc,$1375
1374: 24          inc  h    ; [uncovered] 
1375: 6F          ld   l,a
1376: 4E          ld   c,(hl)
1377: 2A 56 80    ld   hl,($8056)
137A: 71          ld   (hl),c
137B: CB DC       set  3,h
137D: 3A B1 82    ld   a,($82B1)
1380: B0          or   b
1381: 77          ld   (hl),a
1382: E1          pop  hl
1383: D1          pop  de
1384: C1          pop  bc
1385: C9          ret

1386: AF          xor  a
1387: 47          ld   b,a
1388: 67          ld   h,a
1389: 69          ld   l,c
138A: 29          add  hl,hl
138B: 29          add  hl,hl
138C: 29          add  hl,hl
138D: 09          add  hl,bc
138E: 4A          ld   c,d
138F: 09          add  hl,bc
1390: 09          add  hl,bc
1391: 09          add  hl,bc
1392: 4B          ld   c,e
1393: 09          add  hl,bc
1394: 01 88 22    ld   bc,$2288
1397: 09          add  hl,bc
1398: ED 5B 56 80 ld   de,($8056)
139C: 7E          ld   a,(hl)
139D: E6 C0       and  $C0
139F: F6 15       or   $15
13A1: 47          ld   b,a
13A2: 7E          ld   a,(hl)
13A3: CB 6F       bit  5,a
13A5: 28 01       jr   z,$13A8
13A7: 04          inc  b
13A8: E6 1F       and  $1F
13AA: CB FF       set  7,a
13AC: 12          ld   (de),a
13AD: EB          ex   de,hl
13AE: CB DC       set  3,h
13B0: 70          ld   (hl),b
13B1: E1          pop  hl
13B2: D1          pop  de
13B3: C1          pop  bc
13B4: C9          ret

13B5: 3A D6 82    ld   a,($82D6)
13B8: 82          add  a,d
13B9: 82          add  a,d
13BA: 82          add  a,d
13BB: 83          add  a,e
13BC: ED 5B 56 80 ld   de,($8056)
13C0: 12          ld   (de),a
13C1: 06 51       ld   b,$51
13C3: 3A D6 82    ld   a,($82D6)
13C6: FE 5F       cp   $5F
13C8: 38 E3       jr   c,$13AD
13CA: D6 09       sub  $09    ; [uncovered] 
13CC: 04          inc  b    ; [uncovered] 
13CD: 18 F7       jr   $13C6    ; [uncovered] 

13CF: 3A 4E 82    ld   a,(nb_enemy_cars_824e)
13D2: A7          and  a
13D3: C8          ret  z
13D4: 21 F8 01    ld   hl,$01F8
13D7: F3          di
13D8: ED 5B 54 80 ld   de,($8054)
13DC: 3A 50 80    ld   a,($8050)
13DF: 06 00       ld   b,$00
13E1: 4F          ld   c,a
13E2: CB 7F       bit  7,a
13E4: 28 01       jr   z,$13E7
13E6: 05          dec  b
13E7: 09          add  hl,bc
13E8: 01 F8 FF    ld   bc,$FFF8
13EB: 1C          inc  e
13EC: 1D          dec  e
13ED: 28 03       jr   z,$13F2
13EF: 09          add  hl,bc
13F0: 18 FA       jr   $13EC

13F2: 22 48 82    ld   ($8248),hl
13F5: 3A 51 80    ld   a,($8051)
13F8: C6 14       add  a,$14
13FA: ED 44       neg
13FC: 14          inc  d
13FD: 15          dec  d
13FE: 28 03       jr   z,$1403
1400: 91          sub  c
1401: 18 FA       jr   $13FD

1403: 32 4A 82    ld   ($824A),a
1406: 3A 4E 82    ld   a,(nb_enemy_cars_824e)
1409: 47          ld   b,a
140A: DD 21 93 80 ld   ix,$8093
140E: 2A 52 80    ld   hl,($8052)
1411: DD 7E FD    ld   a,(ix-$03)
1414: 95          sub  l
1415: FE 0B       cp   $0B
1417: 30 0A       jr   nc,$1423
1419: 4F          ld   c,a
141A: DD 7E FF    ld   a,(ix-$01)
141D: 94          sub  h
141E: FE 0B       cp   $0B
1420: 57          ld   d,a
1421: 38 09       jr   c,$142C
1423: 11 20 00    ld   de,$0020
1426: DD 19       add  ix,de
1428: 10 E4       djnz $140E
142A: FB          ei
142B: C9          ret

142C: DD E5       push ix
142E: E1          pop  hl
142F: FD 21 02 80 ld   iy,$8002
1433: 1E 06       ld   e,$06
1435: FD 7E 00    ld   a,(iy+$00)
1438: BD          cp   l
1439: 20 06       jr   nz,$1441
143B: FD 7E 01    ld   a,(iy+$01)
143E: BC          cp   h
143F: 28 E2       jr   z,$1423
1441: FD 23       inc  iy
1443: FD 23       inc  iy
1445: 1D          dec  e
1446: 20 ED       jr   nz,$1435
1448: 1E 06       ld   e,$06
144A: FD 2B       dec  iy
144C: FD 2B       dec  iy
144E: FD 7E 00    ld   a,(iy+$00)
1451: FD B6 01    or   (iy+$01)
1454: 28 10       jr   z,$1466
1456: 1D          dec  e
1457: 20 F1       jr   nz,$144A
1459: 11 F5 FF    ld   de,$FFF5    ; [uncovered] 
145C: DD 19       add  ix,de    ; [uncovered] 
145E: CD 97 16    call $1697    ; [uncovered] 
1461: 11 2B 00    ld   de,$002B    ; [uncovered] 
1464: 18 C0       jr   $1426    ; [uncovered] 

1466: FD 75 00    ld   (iy+$00),l
1469: FD 74 01    ld   (iy+$01),h
146C: 7A          ld   a,d
146D: 87          add  a,a
146E: 82          add  a,d
146F: 87          add  a,a
1470: 87          add  a,a
1471: 87          add  a,a
1472: 57          ld   d,a
1473: 3A 4A 82    ld   a,($824A)
1476: 92          sub  d
1477: DD 77 03    ld   (ix+$03),a
147A: 79          ld   a,c
147B: 87          add  a,a
147C: 81          add  a,c
147D: 87          add  a,a
147E: 87          add  a,a
147F: 87          add  a,a
1480: 5F          ld   e,a
1481: 16 00       ld   d,$00
1483: 2A 48 82    ld   hl,($8248)
1486: 19          add  hl,de
1487: DD 74 00    ld   (ix+$00),h
148A: DD 75 01    ld   (ix+$01),l
148D: AF          xor  a
148E: DD 77 FC    ld   (ix-$04),a
1491: DD 77 FA    ld   (ix-$06),a
1494: C3 23 14    jp   $1423

1497: E5          push hl
1498: F5          push af
1499: 3A 4D 80    ld   a,($804D)
149C: 6F          ld   l,a
149D: 3A 4F 80    ld   a,($804F)
14A0: ED 44       neg
14A2: 67          ld   h,a
14A3: 3A 50 80    ld   a,($8050)
14A6: 85          add  a,l
14A7: E6 F8       and  $F8
14A9: D6 10       sub  $10
14AB: 0F          rrca
14AC: 0F          rrca
14AD: 0F          rrca
14AE: 6F          ld   l,a
14AF: 3A 51 80    ld   a,($8051)
14B2: 84          add  a,h
14B3: 26 21       ld   h,$21
14B5: 07          rlca
14B6: CB 14       rl   h
14B8: 07          rlca
14B9: CB 14       rl   h
14BB: E6 E0       and  $E0
14BD: B5          or   l
14BE: 6F          ld   l,a
14BF: 22 56 80    ld   ($8056),hl
14C2: F1          pop  af
14C3: E1          pop  hl
14C4: C9          ret

14C5: 00          nop
14C6: E5          push hl
14C7: D5          push de
14C8: C5          push bc
14C9: F5          push af
14CA: 3A AA 82    ld   a,($82AA)
14CD: A7          and  a
14CE: 20 07       jr   nz,$14D7
14D0: 21 24 80    ld   hl,$8024    ; [uncovered] 
14D3: 36 FF       ld   (hl),$FF    ; [uncovered] 
14D5: 18 3C       jr   $1513    ; [uncovered] 

14D7: 21 AC 82    ld   hl,$82AC
14DA: 3A 00 A0    ld   a,(p1_a000)
14DD: 47          ld   b,a
14DE: 1F          rra
14DF: CB 16       rl   (hl)
14E1: 23          inc  hl
14E2: CB 10       rl   b
14E4: CB 16       rl   (hl)
14E6: 23          inc  hl
14E7: 3A 80 A0    ld   a,(watchdog_a080)
14EA: 17          rla
14EB: CB 16       rl   (hl)
14ED: 7E          ld   a,(hl)
14EE: E6 0F       and  $0F
14F0: FE 0C       cp   $0C
14F2: CC 18 15    call z,$1518
14F5: 2B          dec  hl
14F6: 7E          ld   a,(hl)
14F7: E6 0F       and  $0F
14F9: FE 0C       cp   $0C
14FB: CC 18 15    call z,$1518
14FE: 2B          dec  hl
14FF: 7E          ld   a,(hl)
1500: E6 0F       and  $0F
1502: 06 01       ld   b,$01
1504: FE 0C       cp   $0C
1506: 20 0B       jr   nz,$1513
1508: 3A F6 89    ld   a,($89F6)    ; [uncovered] 
150B: CB F7       set  6,a    ; [uncovered] 
150D: 32 F6 89    ld   ($89F6),a    ; [uncovered] 
1510: CD 2A 15    call $152A    ; [uncovered] 
1513: F1          pop  af
1514: C1          pop  bc
1515: D1          pop  de
1516: E1          pop  hl
1517: C9          ret

1518: EB          ex   de,hl
1519: 21 A8 82    ld   hl,$82A8
151C: 34          inc  (hl)
151D: 23          inc  hl
151E: 34          inc  (hl)
151F: CB 46       bit  0,(hl)
1521: 23          inc  hl
1522: 28 01       jr   z,$1525
1524: 23          inc  hl
1525: 46          ld   b,(hl)
1526: EB          ex   de,hl
1527: 78          ld   a,b
1528: A7          and  a
1529: C8          ret  z
152A: EB          ex   de,hl
152B: 21 24 80    ld   hl,$8024
152E: 34          inc  (hl)
152F: 20 01       jr   nz,$1532
1531: 35          dec  (hl)    ; [uncovered] 
1532: 10 FA       djnz $152E
1534: EB          ex   de,hl
1535: 3A 21 80    ld   a,($8021)
1538: A7          and  a
1539: 28 09       jr   z,$1544
153B: 3A 20 80    ld   a,($8020)
153E: FE 01       cp   $01
1540: CC D2 1E    call z,$1ED2
1543: C9          ret

1544: 21 F4 89    ld   hl,$89F4
1547: 77          ld   (hl),a
1548: 23          inc  hl
1549: 77          ld   (hl),a
154A: C3 AB 06    jp   $06AB

154D: 3A A8 82    ld   a,($82A8)
1550: A7          and  a
1551: C8          ret  z
1552: E5          push hl
1553: D5          push de
1554: C5          push bc
1555: 21 AF 82    ld   hl,$82AF
1558: 11 87 A1    ld   de,$A187
155B: 7E          ld   a,(hl)
155C: 23          inc  hl
155D: A7          and  a
155E: 20 0B       jr   nz,$156B
1560: AF          xor  a
1561: 77          ld   (hl),a
1562: 3C          inc  a
1563: 12          ld   (de),a
1564: 2B          dec  hl
1565: 36 01       ld   (hl),$01
1567: C1          pop  bc
1568: D1          pop  de
1569: E1          pop  hl
156A: C9          ret

156B: 34          inc  (hl)
156C: 7E          ld   a,(hl)
156D: FE 10       cp   $10
156F: 20 0E       jr   nz,$157F
1571: 2B          dec  hl
1572: 36 00       ld   (hl),$00
1574: 21 A8 82    ld   hl,$82A8
1577: 35          dec  (hl)
1578: 21 F6 89    ld   hl,$89F6
157B: 36 80       ld   (hl),$80
157D: 18 E8       jr   $1567

157F: D6 08       sub  $08
1581: 20 E4       jr   nz,$1567
1583: 12          ld   (de),a
1584: 18 E1       jr   $1567

1586: DD 21 68 80 ld   ix,$8068
158A: DD 6E 11    ld   l,(ix+$11)
158D: DD 66 12    ld   h,(ix+$12)
1590: DD 7E 05    ld   a,(ix+$05)
1593: C6 0C       add  a,$0C
1595: FE 19       cp   $19
1597: 38 08       jr   c,$15A1
1599: CB 7F       bit  7,a
159B: 20 03       jr   nz,$15A0
159D: 23          inc  hl
159E: 18 01       jr   $15A1

15A0: 2B          dec  hl
15A1: DD 7E 07    ld   a,(ix+$07)
15A4: 11 20 00    ld   de,$0020
15A7: C6 0C       add  a,$0C
15A9: FE 19       cp   $19
15AB: 38 0A       jr   c,$15B7
15AD: CB 7F       bit  7,a
15AF: 28 03       jr   z,$15B4
15B1: 19          add  hl,de
15B2: 18 03       jr   $15B7

15B4: A7          and  a
15B5: ED 52       sbc  hl,de
15B7: EB          ex   de,hl
15B8: 2A 92 89    ld   hl,($8992)
15BB: 06 0A       ld   b,$0A
15BD: 7B          ld   a,e
15BE: BE          cp   (hl)
15BF: 23          inc  hl
15C0: 20 02       jr   nz,$15C4
15C2: 7A          ld   a,d
15C3: BE          cp   (hl)
15C4: 23          inc  hl
15C5: CA AF 17    jp   z,$17AF
15C8: 10 F3       djnz $15BD
15CA: 3A 4C 82    ld   a,($824C)
15CD: A7          and  a
15CE: C2 73 16    jp   nz,$1673
15D1: 1A          ld   a,(de)
15D2: FE 03       cp   $03
15D4: CA 96 19    jp   z,$1996
15D7: DD 21 88 80 ld   ix,enemy_car_structs_8088
15DB: FD 21 A8 80 ld   iy,$80A8
15DF: 06 07       ld   b,$07
15E1: C5          push bc
15E2: FD E5       push iy
15E4: DD 7E 13    ld   a,(ix+$13)
15E7: A7          and  a
15E8: 28 05       jr   z,$15EF
15EA: DD 35 13    dec  (ix+$13)
15ED: 18 2C       jr   $161B

15EF: DD 7E 08    ld   a,(ix+$08)
15F2: FD 96 08    sub  (iy+$08)
15F5: 6F          ld   l,a
15F6: DD 7E 05    ld   a,(ix+$05)
15F9: FD 96 05    sub  (iy+$05)
15FC: CD C3 16    call $16C3
15FF: 20 13       jr   nz,$1614
1601: DD 7E 0A    ld   a,(ix+$0a)
1604: FD 96 0A    sub  (iy+$0a)
1607: 6F          ld   l,a
1608: FD 7E 07    ld   a,(iy+$07)
160B: DD 96 07    sub  (ix+$07)
160E: CD C3 16    call $16C3
1611: CC 7A 16    call z,$167A
1614: 11 20 00    ld   de,$0020
1617: FD 19       add  iy,de
1619: 10 C9       djnz $15E4
161B: 11 20 00    ld   de,$0020
161E: FD E1       pop  iy
1620: C1          pop  bc
1621: DD 19       add  ix,de
1623: FD 19       add  iy,de
1625: 10 BA       djnz $15E1
1627: 0E 08       ld   c,$08
1629: DD 21 88 80 ld   ix,enemy_car_structs_8088
162D: DD 7E 13    ld   a,(ix+$13)
1630: A7          and  a
1631: 20 37       jr   nz,$166A
1633: DD 66 12    ld   h,(ix+$12)
1636: DD 6E 11    ld   l,(ix+$11)
1639: DD 7E 05    ld   a,(ix+$05)
163C: C6 0C       add  a,$0C
163E: FE 19       cp   $19
1640: 38 0C       jr   c,$164E
1642: CB 7F       bit  7,a
1644: 20 05       jr   nz,$164B
1646: CD 69 0D    call $0D69
1649: 18 03       jr   $164E

164B: CD 5F 0D    call $0D5F
164E: DD 7E 07    ld   a,(ix+$07)
1651: 11 20 00    ld   de,$0020
1654: C6 0C       add  a,$0C
1656: FE 19       cp   $19
1658: 38 0A       jr   c,$1664
165A: CB 7F       bit  7,a
165C: 28 03       jr   z,$1661
165E: 19          add  hl,de
165F: 18 03       jr   $1664

1661: A7          and  a
1662: ED 52       sbc  hl,de
1664: 7E          ld   a,(hl)
1665: FE 03       cp   $03
1667: CC 97 16    call z,$1697
166A: 11 20 00    ld   de,$0020
166D: DD 19       add  ix,de
166F: 0D          dec  c
1670: C2 2D 16    jp   nz,$162D
1673: 21 22 80    ld   hl,$8022
1676: 34          inc  (hl)
1677: C3 7A 0A    jp   $0A7A

167A: DD E5       push ix
167C: FD E5       push iy
167E: DD E1       pop  ix
1680: CD 97 16    call $1697
1683: DD E1       pop  ix
1685: FD 7E 02    ld   a,(iy+$02)
1688: DD AE 02    xor  (ix+$02)
168B: CB 7F       bit  7,a
168D: DD 7E 02    ld   a,(ix+$02)
1690: 28 02       jr   z,$1694
1692: ED 44       neg
1694: DD 77 02    ld   (ix+$02),a
1697: E5          push hl
1698: DD 36 00 E0 ld   (ix+$00),$E0
169C: DD 36 13 32 ld   (ix+$13),$32
16A0: 21 00 01    ld   hl,$0100
16A3: DD CB 02 7E bit  7,(ix+$02)
16A7: 20 02       jr   nz,$16AB
16A9: 26 FF       ld   h,$FF
16AB: DD 74 02    ld   (ix+$02),h
16AE: DD 75 01    ld   (ix+$01),l
16B1: 06 08       ld   b,$08
16B3: FD E5       push iy
16B5: FD 2E 00    ld   iyl,$00
16B8: CD F3 00    call $00F3
16BB: 10 FB       djnz $16B8
16BD: FD E1       pop  iy
16BF: 06 01       ld   b,$01
16C1: E1          pop  hl
16C2: C9          ret

16C3: 2D          dec  l
16C4: 2D          dec  l
16C5: C6 23       add  a,$23
16C7: CB 7F       bit  7,a
16C9: 20 05       jr   nz,$16D0
16CB: 2C          inc  l
16CC: D6 18       sub  $18
16CE: 18 F7       jr   $16C7

16D0: 7D          ld   a,l
16D1: A7          and  a
16D2: C9          ret

16D3: 3E 03       ld   a,$03
16D5: 32 20 80    ld   ($8020),a
16D8: 3E EC       ld   a,$EC
16DA: 32 14 80    ld   ($8014),a
16DD: 21 F4 89    ld   hl,$89F4
16E0: 36 80       ld   (hl),$80
16E2: 23          inc  hl
16E3: 36 08       ld   (hl),$08
16E5: CD 6E 17    call $176E
16E8: 3A 21 80    ld   a,($8021)
16EB: A7          and  a
16EC: CA 8E 06    jp   z,$068E
16EF: 2A 88 89    ld   hl,($8988)
16F2: 35          dec  (hl)
16F3: CA B9 19    jp   z,$19B9
16F6: 21 AA 81    ld   hl,$81AA
16F9: 7E          ld   a,(hl)
16FA: 47          ld   b,a
16FB: 23          inc  hl
16FC: A6          and  (hl)
16FD: CA 2A 17    jp   z,$172A
1700: 78          ld   a,b    ; [uncovered] 
1701: FE 02       cp   $02    ; [uncovered] 
1703: 28 0B       jr   z,$1710    ; [uncovered] 
1705: CD 41 17    call $1741    ; [uncovered] 
1708: 3E 01       ld   a,$01    ; [uncovered] 
170A: 32 B7 81    ld   ($81B7),a    ; [uncovered] 
170D: C3 2A 17    jp   $172A    ; [uncovered] 

172A: 2A 8A 89    ld   hl,($898A)
172D: 7E          ld   a,(hl)
172E: E6 03       and  $03
1730: CA BD 07    jp   z,$07BD
1733: AF          xor  a
1734: 32 4B 82    ld   ($824B),a
1737: 3A 4B 82    ld   a,($824B)
173A: FE 78       cp   $78
173C: 20 F9       jr   nz,$1737
173E: C3 E5 07    jp   $07E5

1741: 2B          dec  hl
1742: 36 02       ld   (hl),$02
1744: 2B          dec  hl
1745: 7E          ld   a,(hl)
1746: 2B          dec  hl
1747: 77          ld   (hl),a
1748: 21 00 1F    ld   hl,$1F00
174B: 11 88 89    ld   de,$8988
174E: 01 18 00    ld   bc,$0018
1751: ED B0       ldir
1753: C9          ret

176E: 3E 20       ld   a,$20
1770: 90          sub  b
1771: 90          sub  b
1772: 6F          ld   l,a
1773: 26 80       ld   h,$80
1775: 36 EC       ld   (hl),$EC
1777: DD 7E 0C    ld   a,(ix+$0c)
177A: D6 08       sub  $08
177C: 47          ld   b,a
177D: DD 7E 0E    ld   a,(ix+$0e)
1780: C6 08       add  a,$08
1782: 4F          ld   c,a
1783: CD 7F 0E    call $0E7F
1786: 54          ld   d,h
1787: 5D          ld   e,l
1788: CB DC       set  3,h
178A: 3E B4       ld   a,$B4
178C: 0E 03       ld   c,$03
178E: E5          push hl
178F: D5          push de
1790: 06 03       ld   b,$03
1792: 12          ld   (de),a
1793: 36 46       ld   (hl),$46
1795: CD 5D 0E    call $0E5D
1798: 3C          inc  a
1799: 10 F7       djnz $1792
179B: D1          pop  de
179C: E1          pop  hl
179D: CD 6C 0E    call $0E6C
17A0: 0D          dec  c
17A1: 20 EB       jr   nz,$178E
17A3: 2A 98 89    ld   hl,($8998)
17A6: 06 04       ld   b,$04
17A8: 3E 66       ld   a,$66
17AA: 77          ld   (hl),a
17AB: 23          inc  hl
17AC: 10 FC       djnz $17AA
17AE: C9          ret

17AF: E5          push hl
17B0: AF          xor  a
17B1: 12          ld   (de),a
17B2: 05          dec  b
17B3: 21 F4 89    ld   hl,$89F4
17B6: 0E 04       ld   c,$04
17B8: 20 07       jr   nz,$17C1
17BA: 0E 08       ld   c,$08
17BC: 3E 01       ld   a,$01
17BE: 32 23 80    ld   ($8023),a
17C1: 7E          ld   a,(hl)
17C2: B1          or   c
17C3: 77          ld   (hl),a
17C4: E1          pop  hl
17C5: AF          xor  a
17C6: 2B          dec  hl
17C7: 77          ld   (hl),a
17C8: 2B          dec  hl
17C9: 77          ld   (hl),a
17CA: 11 20 00    ld   de,$0020
17CD: 19          add  hl,de
17CE: 3D          dec  a
17CF: 5E          ld   e,(hl)
17D0: 77          ld   (hl),a
17D1: 23          inc  hl
17D2: 56          ld   d,(hl)
17D3: 77          ld   (hl),a
17D4: CD 7D 12    call $127D
17D7: CD AF 12    call $12AF
17DA: DD 7E 05    ld   a,(ix+$05)
17DD: C6 0C       add  a,$0C
17DF: FE 19       cp   $19
17E1: 38 08       jr   c,$17EB
17E3: D6 18       sub  $18
17E5: FE 1E       cp   $1E
17E7: 38 02       jr   c,$17EB
17E9: C6 30       add  a,$30
17EB: D6 0C       sub  $0C
17ED: ED 44       neg
17EF: DD 86 0C    add  a,(ix+$0c)
17F2: 47          ld   b,a
17F3: DD 7E 07    ld   a,(ix+$07)
17F6: C6 0C       add  a,$0C
17F8: FE 19       cp   $19
17FA: 38 08       jr   c,$1804
17FC: D6 18       sub  $18
17FE: FE 1E       cp   $1E
1800: 38 02       jr   c,$1804
1802: C6 30       add  a,$30
1804: D6 0C       sub  $0C
1806: ED 44       neg
1808: DD 86 0E    add  a,(ix+$0e)
180B: 4F          ld   c,a
180C: C5          push bc
180D: CD 7F 0E    call $0E7F
1810: 36 81       ld   (hl),$81
1812: C1          pop  bc
1813: E5          push hl
1814: C5          push bc
1815: 78          ld   a,b
1816: D6 08       sub  $08
1818: 47          ld   b,a
1819: C5          push bc
181A: CD 7F 0E    call $0E7F
181D: 36 81       ld   (hl),$81
181F: C1          pop  bc
1820: 79          ld   a,c
1821: D6 08       sub  $08
1823: 4F          ld   c,a
1824: C5          push bc
1825: CD 7F 0E    call $0E7F
1828: 36 81       ld   (hl),$81
182A: C1          pop  bc
182B: 79          ld   a,c
182C: C1          pop  bc
182D: 4F          ld   c,a
182E: CD 7F 0E    call $0E7F
1831: 36 81       ld   (hl),$81
1833: E1          pop  hl
1834: 7D          ld   a,l
1835: E6 1F       and  $1F
1837: 11 20 00    ld   de,$0020
183A: 20 01       jr   nz,$183D
183C: 19          add  hl,de
183D: 2B          dec  hl
183E: 3A 50 82    ld   a,($8250)
1841: 3C          inc  a
1842: 32 50 82    ld   ($8250),a
1845: FE 0A       cp   $0A
1847: 20 02       jr   nz,$184B
1849: 3E 01       ld   a,$01    ; [uncovered] 
184B: C6 9F       add  a,$9F
184D: 77          ld   (hl),a
184E: CD 8D 18    call $188D
1851: CD 88 19    call $1988
1854: 36 AA       ld   (hl),$AA
1856: CD 8D 18    call $188D
1859: 3A 50 82    ld   a,($8250)
185C: FE 0A       cp   $0A
185E: 20 08       jr   nz,$1868
1860: CD 88 19    call $1988    ; [uncovered] 
1863: 36 AB       ld   (hl),$AB    ; [uncovered] 
1865: CD 8D 18    call $188D    ; [uncovered] 
1868: 3A 23 80    ld   a,($8023)
186B: A7          and  a
186C: 28 28       jr   z,$1896
186E: E5          push hl
186F: CD 88 19    call $1988
1872: 7E          ld   a,(hl)
1873: FE 81       cp   $81
1875: 20 08       jr   nz,$187F
1877: 36 AC       ld   (hl),$AC
1879: CD 8D 18    call $188D
187C: E1          pop  hl
187D: 18 17       jr   $1896

188D: CB DC       set  3,h
188F: CB F6       set  6,(hl)
1891: CB BE       res  7,(hl)
1893: CB 9C       res  3,h
1895: C9          ret

1896: 2A 8C 89    ld   hl,($898C)
1899: 34          inc  (hl)
189A: 7E          ld   a,(hl)
189B: FE 0A       cp   $0A
189D: 20 05       jr   nz,$18A4
189F: 3E 03       ld   a,$03
18A1: 32 20 80    ld   ($8020),a
18A4: 3A 50 82    ld   a,($8250)
18A7: 47          ld   b,a
18A8: 3A 23 80    ld   a,($8023)
18AB: A7          and  a
18AC: 28 02       jr   z,$18B0
18AE: CB 20       sla  b
18B0: 0E 0A       ld   c,$0A
18B2: C5          push bc
18B3: CD 6F 1D    call $1D6F
18B6: CD F5 1D    call $1DF5
18B9: C1          pop  bc
18BA: 0D          dec  c
18BB: 20 F5       jr   nz,$18B2
18BD: 10 F1       djnz $18B0
18BF: CD 6F 1D    call $1D6F
18C2: CD 0B 19    call $190B
18C5: 2A 8C 89    ld   hl,($898C)
18C8: 7E          ld   a,(hl)
18C9: FE 0A       cp   $0A
18CB: C2 D7 15    jp   nz,$15D7
18CE: 3A 21 80    ld   a,($8021)
18D1: A7          and  a
18D2: CA 8E 06    jp   z,$068E
18D5: CD A3 17    call $17A3
18D8: 21 F4 89    ld   hl,$89F4
18DB: 7E          ld   a,(hl)
18DC: E6 3F       and  $3F
18DE: 77          ld   (hl),a
18DF: 23          inc  hl
18E0: 36 28       ld   (hl),$28
18E2: 3E EC       ld   a,$EC
18E4: 32 14 80    ld   ($8014),a
18E7: 3E 03       ld   a,$03
18E9: 32 20 80    ld   ($8020),a
18EC: 32 4B 82    ld   ($824B),a
18EF: 3A 4B 82    ld   a,($824B)
18F2: E6 3F       and  $3F
18F4: 20 F9       jr   nz,$18EF
18F6: CB 46       bit  0,(hl)
18F8: 28 FC       jr   z,$18F6
18FA: CD 2D 1D    call $1D2D
18FD: 3E E0       ld   a,$E0
18FF: 32 4B 82    ld   ($824B),a
1902: 3A 4B 82    ld   a,($824B)
1905: A7          and  a
1906: 20 FA       jr   nz,$1902
1908: C3 BD 07    jp   $07BD

190B: 3A 92 82    ld   a,($8292)
190E: A7          and  a
190F: C0          ret  nz
1910: 2A 8A 89    ld   hl,($898A)
1913: 7E          ld   a,(hl)
1914: 3D          dec  a
1915: 0F          rrca
1916: 0F          rrca
1917: E6 03       and  $03
1919: 47          ld   b,a
191A: 04          inc  b
191B: F6 30       or   $30
191D: 32 8F 82    ld   ($828F),a
1920: D6 23       sub  $23
1922: 32 B1 82    ld   ($82B1),a
1925: 3E 53       ld   a,$53
1927: C6 09       add  a,$09
1929: 10 FC       djnz $1927
192B: 32 D6 82    ld   ($82D6),a
192E: 3A D8 82    ld   a,($82D8)
1931: 57          ld   d,a
1932: 7E          ld   a,(hl)
1933: BA          cp   d
1934: 38 04       jr   c,$193A
1936: D6 04       sub  $04    ; [uncovered] 
1938: 18 F9       jr   $1933    ; [uncovered] 

193A: D6 02       sub  $02
193C: 87          add  a,a
193D: 87          add  a,a
193E: 87          add  a,a
193F: 6F          ld   l,a
1940: 26 00       ld   h,$00
1942: ED 5B D2 82 ld   de,($82D2)
1946: 19          add  hl,de
1947: 7E          ld   a,(hl)
1948: 32 4E 82    ld   (nb_enemy_cars_824e),a
194B: 23          inc  hl
194C: 7E          ld   a,(hl)
194D: 32 6E 82    ld   ($826E),a
1950: 23          inc  hl
1951: 7E          ld   a,(hl)
1952: 32 88 82    ld   ($8288),a
1955: 23          inc  hl
1956: 7E          ld   a,(hl)
1957: 32 51 82    ld   (nb_rocks_8251),a
195A: 23          inc  hl
195B: 3A 8A 82    ld   a,($828A)
195E: 47          ld   b,a
195F: ED 5B 8C 89 ld   de,($898C)
1963: 1A          ld   a,(de)
1964: 05          dec  b
1965: 28 11       jr   z,$1978
1967: 23          inc  hl
1968: 05          dec  b
1969: 28 0D       jr   z,$1978
196B: FE 08       cp   $08
196D: 30 09       jr   nc,$1978
196F: 23          inc  hl
1970: 05          dec  b
1971: 28 05       jr   z,$1978
1973: FE 05       cp   $05
1975: 30 01       jr   nc,$1978
1977: 23          inc  hl
1978: 5E          ld   e,(hl)
1979: 16 00       ld   d,$00
197B: 21 4B 21    ld   hl,$214B
197E: 19          add  hl,de
197F: 11 25 80    ld   de,$8025
1982: 01 08 00    ld   bc,$0008
1985: ED B0       ldir
1987: C9          ret

1988: 23          inc  hl
1989: 47          ld   b,a
198A: 7D          ld   a,l
198B: E6 1F       and  $1F
198D: 78          ld   a,b
198E: C0          ret  nz
198F: 2B          dec  hl
1990: 7D          ld   a,l
1991: E6 E0       and  $E0
1993: 6F          ld   l,a
1994: 78          ld   a,b
1995: C9          ret

1996: 3E 03       ld   a,$03
1998: 32 20 80    ld   ($8020),a
199B: 3E EC       ld   a,$EC
199D: 32 14 80    ld   ($8014),a
19A0: 21 F4 89    ld   hl,$89F4
19A3: 36 80       ld   (hl),$80
19A5: 23          inc  hl
19A6: 36 08       ld   (hl),$08
19A8: CD 6E 17    call $176E
19AB: 3A 21 80    ld   a,($8021)
19AE: A7          and  a
19AF: CA 8E 06    jp   z,$068E
19B2: 2A 88 89    ld   hl,($8988)    ; [uncovered] 
19B5: 35          dec  (hl)    ; [uncovered] 
19B6: C2 F6 16    jp   nz,$16F6    ; [uncovered] 
19B9: 3E A0       ld   a,$A0    ; [uncovered] 
19BB: 32 4B 82    ld   ($824B),a    ; [uncovered] 
19BE: 3A 4B 82    ld   a,($824B)    ; [uncovered] 
19C1: A7          and  a    ; [uncovered] 
19C2: 20 FA       jr   nz,$19BE    ; [uncovered] 
19C4: AF          xor  a    ; [uncovered] 
19C5: 32 F4 89    ld   ($89F4),a    ; [uncovered] 
19C8: DD 7E 0C    ld   a,(ix+$0c)    ; [uncovered] 
19CB: D6 08       sub  $08    ; [uncovered] 
19CD: 47          ld   b,a    ; [uncovered] 
19CE: DD 7E 0E    ld   a,(ix+$0e)    ; [uncovered] 
19D1: C6 08       add  a,$08    ; [uncovered] 
19D3: 4F          ld   c,a    ; [uncovered] 
19D4: CD 7F 0E    call $0E7F    ; [uncovered] 
19D7: 54          ld   d,h    ; [uncovered] 
19D8: 5D          ld   e,l    ; [uncovered] 
19D9: 06 03       ld   b,$03    ; [uncovered] 
19DB: 3E 81       ld   a,$81    ; [uncovered] 
19DD: E5          push hl    ; [uncovered] 
19DE: D5          push de    ; [uncovered] 
19DF: 0E 03       ld   c,$03    ; [uncovered] 
19E1: 12          ld   (de),a    ; [uncovered] 
19E2: CD 5D 0E    call $0E5D    ; [uncovered] 
19E5: 0D          dec  c    ; [uncovered] 
19E6: 20 F9       jr   nz,$19E1    ; [uncovered] 
19E8: D1          pop  de    ; [uncovered] 
19E9: E1          pop  hl    ; [uncovered] 
19EA: CD 6C 0E    call $0E6C    ; [uncovered] 
19ED: 10 EE       djnz $19DD    ; [uncovered] 
19EF: DD 21 14 80 ld   ix,$8014    ; [uncovered] 
19F3: FD 21 14 88 ld   iy,$8814    ; [uncovered] 
19F7: 3A A8 81    ld   a,($81A8)    ; [uncovered] 
19FA: A7          and  a    ; [uncovered] 
19FB: 20 22       jr   nz,$1A1F    ; [uncovered] 
19FD: DD 36 00 E0 ld   (ix+$00),$E0    ; [uncovered] 
1A01: DD 36 01 68 ld   (ix+$01),$68    ; [uncovered] 
1A05: FD 36 00 74 ld   (iy+$00),$74    ; [uncovered] 
1A09: FD 36 01 66 ld   (iy+$01),$66    ; [uncovered] 
1A0D: DD 36 02 E4 ld   (ix+$02),$E4    ; [uncovered] 
1A11: DD 36 03 78 ld   (ix+$03),$78    ; [uncovered] 
1A15: FD 36 02 74 ld   (iy+$02),$74    ; [uncovered] 
1A19: FD 36 03 66 ld   (iy+$03),$66    ; [uncovered] 
1A1D: 18 20       jr   $1A3F    ; [uncovered] 
1A1F: DD 36 00 E3 ld   (ix+$00),$E3
1A23: DD 36 01 AC ld   (ix+$01),$AC
1A27: DD 36 02 E7 ld   (ix+$02),$E7
1A2B: DD 36 03 9C ld   (ix+$03),$9C
1A2F: FD 36 00 7C ld   (iy+$00),$7C
1A33: FD 36 01 66 ld   (iy+$01),$66
1A37: FD 36 02 7C ld   (iy+$02),$7C
1A3B: FD 36 03 66 ld   (iy+$03),$66
1A3F: 3E 01       ld   a,$01
1A41: 32 4B 82    ld   ($824B),a
1A44: 3A 4B 82    ld   a,($824B)
1A47: E6 3F       and  $3F
1A49: 20 F9       jr   nz,$1A44
1A4B: 3A D0 82    ld   a,($82D0)
1A4E: A7          and  a
1A4F: CA D8 1A    jp   z,$1AD8
1A52: 3E 75       ld   a,$75
1A54: CD CB 1D    call $1DCB
1A57: 21 29 1B    ld   hl,$1B29
1A5A: 11 07 85    ld   de,$8507
1A5D: CD 15 1B    call $1B15
1A60: 11 86 85    ld   de,$8586
1A63: CD 15 1B    call $1B15
1A66: 11 C9 85    ld   de,$85C9
1A69: CD 15 1B    call $1B15
1A6C: 11 86 86    ld   de,$8686
1A6F: CD 15 1B    call $1B15
1A72: 11 C8 86    ld   de,$86C8
1A75: CD 15 1B    call $1B15
1A78: 3E 83       ld   a,$83
1A7A: 32 2F 86    ld   ($862F),a
1A7D: 21 F5 89    ld   hl,$89F5
1A80: CB D6       set  2,(hl)
1A82: 3E 01       ld   a,$01
1A84: 32 4B 82    ld   ($824B),a
1A87: 3A 4B 82    ld   a,($824B)
1A8A: E6 0F       and  $0F
1A8C: 20 F9       jr   nz,$1A87
1A8E: CB 46       bit  0,(hl)
1A90: 20 46       jr   nz,$1AD8
1A92: 11 60 88    ld   de,$8860
1A95: 1A          ld   a,(de)
1A96: EE 1F       xor  $1F
1A98: 06 08       ld   b,$08
1A9A: 12          ld   (de),a
1A9B: 13          inc  de
1A9C: 10 FC       djnz $1A9A
1A9E: E5          push hl
1A9F: 11 2F 86    ld   de,$862F
1AA2: 1A          ld   a,(de)
1AA3: 11 28 86    ld   de,$8628
1AA6: FE 40       cp   $40
1AA8: 20 1D       jr   nz,$1AC7
1AAA: 21 64 80    ld   hl,$8064
1AAD: 01 04 00    ld   bc,$0004
1AB0: ED B0       ldir
1AB2: 0E 04       ld   c,$04
1AB4: 21 60 80    ld   hl,$8060
1AB7: ED B0       ldir
1AB9: 3E 22       ld   a,$22
1ABB: 12          ld   (de),a
1ABC: 1B          dec  de
1ABD: 1A          ld   a,(de)
1ABE: FE 40       cp   $40
1AC0: 20 FA       jr   nz,$1ABC
1AC2: 3E 22       ld   a,$22
1AC4: 12          ld   (de),a
1AC5: 18 08       jr   $1ACF
1AC7: 06 09       ld   b,$09
1AC9: 3E 40       ld   a,$40
1ACB: 12          ld   (de),a
1ACC: 13          inc  de
1ACD: 10 FC       djnz $1ACB
1ACF: CD E0 04    call $04E0
1AD2: CD F5 1A    call $1AF5
1AD5: E1          pop  hl
1AD6: 18 AA       jr   $1A82
1AD8: CD A3 17    call $17A3
1ADB: CD 06 1B    call $1B06
1ADE: 21 60 88    ld   hl,$8860
1AE1: 06 08       ld   b,$08
1AE3: 36 70       ld   (hl),$70
1AE5: 23          inc  hl
1AE6: 10 FB       djnz $1AE3
1AE8: 21 AA 81    ld   hl,$81AA
1AEB: 7E          ld   a,(hl)
1AEC: 23          inc  hl
1AED: A6          and  (hl)
1AEE: 77          ld   (hl),a
1AEF: C2 F6 16    jp   nz,$16F6
1AF2: C3 8E 06    jp   $068E
1AF5: 2A 98 89    ld   hl,($8998)
1AF8: 01 1C 00    ld   bc,$001C
1AFB: 09          add  hl,bc
1AFC: 06 08       ld   b,$08
1AFE: 7E          ld   a,(hl)
1AFF: EE 15       xor  $15
1B01: 77          ld   (hl),a
1B02: 23          inc  hl
1B03: 10 FC       djnz $1B01
1B05: C9          ret
1B06: 2A 98 89    ld   hl,($8998)
1B09: 01 1C 00    ld   bc,$001C
1B0C: 09          add  hl,bc
1B0D: 06 08       ld   b,$08
1B0F: 36 72       ld   (hl),$72
1B11: 23          inc  hl
1B12: 10 FB       djnz $1B0F
1B14: C9          ret
1B15: F5          push af
1B16: C5          push bc
1B17: D5          push de
1B18: 7E          ld   a,(hl)
1B19: CB DA       set  3,d
1B1B: 23          inc  hl
1B1C: 46          ld   b,(hl)
1B1D: 12          ld   (de),a
1B1E: 13          inc  de
1B1F: 10 FC       djnz $1B1D
1B21: 4E          ld   c,(hl)
1B22: D1          pop  de
1B23: 23          inc  hl
1B24: ED B0       ldir
1B26: C1          pop  bc
1B27: F1          pop  af
1B28: C9          ret

1B76: E5          push hl
1B77: C5          push bc
1B78: 21 34 88    ld   hl,$8834
1B7B: 06 0C       ld   b,$0C
1B7D: 0E 00       ld   c,$00
1B7F: 71          ld   (hl),c
1B80: 23          inc  hl
1B81: 10 FC       djnz $1B7F
1B83: C1          pop  bc
1B84: E1          pop  hl
1B85: C9          ret

1B86: E5          push hl
1B87: 21 91 82    ld   hl,$8291
1B8A: 36 03       ld   (hl),$03
1B8C: E1          pop  hl
1B8D: C9          ret

1B8E: D9          exx
1B8F: 06 FF       ld   b,$FF
1B91: FD 21 88 80 ld   iy,enemy_car_structs_8088
1B95: 3A 4E 82    ld   a,(nb_enemy_cars_824e)
1B98: 47          ld   b,a
1B99: DD 7E 08    ld   a,(ix+$08)
1B9C: FD 96 08    sub  (iy+$08)
1B9F: 30 02       jr   nc,$1BA3
1BA1: ED 44       neg
1BA3: 57          ld   d,a
1BA4: FD 7E 0A    ld   a,(iy+$0a)
1BA7: DD 96 0A    sub  (ix+$0a)
1BAA: 30 02       jr   nc,$1BAE
1BAC: ED 44       neg
1BAE: B2          or   d
1BAF: FE 04       cp   $04
1BB1: DC 86 1B    call c,$1B86
1BB4: 11 20 00    ld   de,$0020
1BB7: FD 19       add  iy,de
1BB9: 10 DE       djnz $1B99
1BBB: 3E 34       ld   a,$34
1BBD: 32 8F 82    ld   ($828F),a
1BC0: 3E FF       ld   a,$FF
1BC2: D9          exx
1BC3: 47          ld   b,a
1BC4: C9          ret

1BC5: 3E 30       ld   a,$30
1BC7: 32 8F 82    ld   ($828F),a
1BCA: C9          ret

1BCB: DD 21 68 80 ld   ix,$8068
1BCF: 06 09       ld   b,$09
1BD1: 21 70 22    ld   hl,$2270
1BD4: DD 7E 15    ld   a,(ix+$15)
1BD7: A7          and  a
1BD8: 20 43       jr   nz,$1C1D
1BDA: DD 4E 02    ld   c,(ix+$02)
1BDD: 79          ld   a,c
1BDE: DD B6 01    or   (ix+$01)
1BE1: 28 3A       jr   z,$1C1D
1BE3: DD 7E 03    ld   a,(ix+$03)
1BE6: A7          and  a
1BE7: 28 08       jr   z,$1BF1
1BE9: CB 79       bit  7,c
1BEB: 28 0E       jr   z,$1BFB	; jumps in the middle of an instruction
1BED: 0E FD       ld   c,$FD
1BEF: 18 0C       jr   $1BFD

1BF1: CB 79       bit  7,c
1BF3: 28 03       jr   z,$1BF8	; jumps in the middle of an instruction
1BF5: 0E F2       ld   c,$F2
1BF7: 11 0E F0    ld   de,$F00E	; if executed, the next ld is skipped!
; crazy code interleave!
1BF8: 0E F0       ld   c,$F0
1BFA: 11 0E FC    ld   de,$FC0E	; if executed, the next ld is skipped!
; crazy code interleave!
; anyway, probably a mistake, as register de set value is not used
1BFB: 0E FC       ld   c,$FC
1BFD: DD 7E 0F    ld   a,(ix+$0f)
1C00: B9          cp   c
1C01: 28 1A       jr   z,$1C1D
1C03: 79          ld   a,c
1C04: BE          cp   (hl)
1C05: 23          inc  hl
1C06: 20 FC       jr   nz,$1C04
1C08: DD 7E 0F    ld   a,(ix+$0f)
1C0B: 0E 00       ld   c,$00
1C0D: 0C          inc  c
1C0E: BE          cp   (hl)
1C0F: 23          inc  hl
1C10: 20 FB       jr   nz,$1C0D
1C12: 79          ld   a,c
1C13: FE 06       cp   $06
1C15: 30 02       jr   nc,$1C19
1C17: 2B          dec  hl
1C18: 2B          dec  hl
1C19: 7E          ld   a,(hl)
1C1A: DD 77 0F    ld   (ix+$0f),a
1C1D: 11 20 00    ld   de,$0020
1C20: DD 19       add  ix,de
1C22: 10 AD       djnz $1BD1
1C24: AF          xor  a
1C25: 32 4B 82    ld   ($824B),a
1C28: C9          ret

1C29: 4E          ld   c,(hl)
1C2A: 23          inc  hl
1C2B: 06 00       ld   b,$00
1C2D: ED B0       ldir
1C2F: C9          ret

1C30: 3A 24 80    ld   a,($8024)
1C33: A7          and  a
1C34: 28 04       jr   z,$1C3A
1C36: 06 01       ld   b,$01
1C38: 18 02       jr   $1C3C

1C3A: 06 00       ld   b,$00
1C3C: 21 84 A1    ld   hl,$A184
1C3F: 70          ld   (hl),b
1C40: 23          inc  hl
1C41: 3A 24 80    ld   a,($8024)
1C44: FE 01       cp   $01
1C46: 20 02       jr   nz,$1C4A
1C48: 06 00       ld   b,$00
1C4A: 70          ld   (hl),b
1C4B: 3E 01       ld   a,$01
1C4D: C9          ret

1C4E: D5          push de
1C4F: C5          push bc
1C50: 01 08 00    ld   bc,$0008
1C53: ED B0       ldir
1C55: C1          pop  bc
1C56: D1          pop  de
1C57: E5          push hl
1C58: D5          push de
1C59: EB          ex   de,hl
1C5A: CB DC       set  3,h
1C5C: 16 08       ld   d,$08
1C5E: 71          ld   (hl),c
1C5F: 23          inc  hl
1C60: 15          dec  d
1C61: 20 FB       jr   nz,$1C5E
1C63: D1          pop  de
1C64: 21 20 00    ld   hl,$0020
1C67: 19          add  hl,de
1C68: EB          ex   de,hl
1C69: E1          pop  hl
1C6A: C9          ret

1C6B: 00          nop
1C6C: 3A 21 80    ld   a,($8021)
1C6F: A7          and  a
1C70: C8          ret  z
1C71: 2A 9C 89    ld   hl,($899C)
1C74: 7E          ld   a,(hl)
1C75: A7          and  a
1C76: C8          ret  z
1C77: 3A 69 82    ld   a,($8269)
1C7A: 47          ld   b,a
1C7B: 3A 6E 82    ld   a,($826E)
1C7E: B8          cp   b
1C7F: C0          ret  nz
1C80: AF          xor  a
1C81: 32 69 82    ld   ($8269),a
1C84: DD 2A 8E 89 ld   ix,($898E)
1C88: DD 7E 01    ld   a,(ix+$01)
1C8B: 21 CB 1F    ld   hl,$1FCB
1C8E: FE 0A       cp   $0A
1C90: 30 03       jr   nc,$1C95
1C92: 21 D3 1F    ld   hl,$1FD3
1C95: 11 40 89    ld   de,$8940
1C98: 01 08 00    ld   bc,$0008
1C9B: ED B0       ldir
1C9D: DD 7E 00    ld   a,(ix+$00)
1CA0: A7          and  a
1CA1: 20 0F       jr   nz,$1CB2
1CA3: DD 7E 01    ld   a,(ix+$01)
1CA6: FE 0A       cp   $0A
1CA8: 20 08       jr   nz,$1CB2
1CAA: 3A F4 89    ld   a,($89F4)
1CAD: F6 20       or   $20
1CAF: 32 F4 89    ld   ($89F4),a
1CB2: DD 2A 8E 89 ld   ix,($898E)
1CB6: DD 66 01    ld   h,(ix+$01)
1CB9: DD 6E 00    ld   l,(ix+$00)
1CBC: 7C          ld   a,h
1CBD: B5          or   l
1CBE: C8          ret  z
1CBF: 2D          dec  l
1CC0: CB 7D       bit  7,l
1CC2: 28 03       jr   z,$1CC7
1CC4: 2E 09       ld   l,$09
1CC6: 25          dec  h
1CC7: DD 75 00    ld   (ix+$00),l
1CCA: DD 74 01    ld   (ix+$01),h
1CCD: 7C          ld   a,h
1CCE: DD 5E 01    ld   e,(ix+$01)
1CD1: 21 44 81    ld   hl,$8144
1CD4: 16 36       ld   d,$36
1CD6: 0E C7       ld   c,$C7
1CD8: 3E 05       ld   a,$05
1CDA: 93          sub  e
1CDB: FE CF       cp   $CF
1CDD: 38 02       jr   c,$1CE1
1CDF: 3E CF       ld   a,$CF
1CE1: 77          ld   (hl),a
1CE2: 2C          inc  l
1CE3: 06 07       ld   b,$07
1CE5: 7A          ld   a,d
1CE6: BB          cp   e
1CE7: 30 01       jr   nc,$1CEA
1CE9: 5A          ld   e,d
1CEA: D6 08       sub  $08
1CEC: 57          ld   d,a
1CED: 7B          ld   a,e
1CEE: 92          sub  d
1CEF: CB 7F       bit  7,a
1CF1: 28 01       jr   z,$1CF4
1CF3: AF          xor  a
1CF4: 81          add  a,c
1CF5: 77          ld   (hl),a
1CF6: 7D          ld   a,l
1CF7: 3C          inc  a
1CF8: E6 F7       and  $F7
1CFA: 6F          ld   l,a
1CFB: 10 E8       djnz $1CE5
1CFD: DD 7E 01    ld   a,(ix+$01)
1D00: A7          and  a
1D01: C0          ret  nz
1D02: DD 7E 00    ld   a,(ix+$00)
1D05: FE 01       cp   $01
1D07: 28 07       jr   z,$1D10
1D09: A7          and  a
1D0A: C0          ret  nz
1D0B: 3C          inc  a
1D0C: 32 92 82    ld   ($8292),a
1D0F: C9          ret

1D10: 2A 9A 89    ld   hl,($899A)
1D13: 36 C7       ld   (hl),$C7
1D15: 21 8C 82    ld   hl,$828C
1D18: 36 01       ld   (hl),$01
1D1A: C9          ret

1D1B: DD 2A 8E 89 ld   ix,($898E)
1D1F: 21 CB 1F    ld   hl,$1FCB
1D22: 11 40 89    ld   de,$8940
1D25: 01 08 00    ld   bc,$0008
1D28: ED B0       ldir
1D2A: C3 CE 1C    jp   $1CCE

1D2D: DD 2A 8E 89 ld   ix,($898E)
1D31: 3A 20 80    ld   a,($8020)
1D34: A7          and  a
1D35: C8          ret  z
1D36: 06 0A       ld   b,$0A
1D38: DD 7E 00    ld   a,(ix+$00)
1D3B: DD B6 01    or   (ix+$01)
1D3E: C8          ret  z
1D3F: 3A F4 89    ld   a,($89F4)
1D42: E6 03       and  $03
1D44: F6 02       or   $02
1D46: 32 F4 89    ld   ($89F4),a
1D49: AF          xor  a
1D4A: 32 69 82    ld   ($8269),a
1D4D: 3A 69 82    ld   a,($8269)
1D50: 3D          dec  a
1D51: 20 FA       jr   nz,$1D4D
1D53: DD 7E 00    ld   a,(ix+$00)
1D56: DD B6 01    or   (ix+$01)
1D59: C8          ret  z
1D5A: C5          push bc
1D5B: CD B2 1C    call $1CB2
1D5E: CD F5 1D    call $1DF5
1D61: CD 6F 1D    call $1D6F
1D64: C1          pop  bc
1D65: 05          dec  b
1D66: 28 C5       jr   z,$1D2D
1D68: CB 40       bit  0,b
1D6A: 28 DD       jr   z,$1D49
1D6C: C3 53 1D    jp   $1D53

1D6F: 3A 20 80    ld   a,($8020)
1D72: A7          and  a
1D73: C8          ret  z
1D74: 3A D0 82    ld   a,($82D0)
1D77: 11 60 80    ld   de,$8060
1D7A: 2A 90 89    ld   hl,($8990)
1D7D: 01 08 00    ld   bc,$0008
1D80: FE 01       cp   $01
1D82: 20 04       jr   nz,$1D88
1D84: ED B0       ldir    ; [uncovered] 
1D86: 18 12       jr   $1D9A    ; [uncovered] 

1D88: 1A          ld   a,(de)
1D89: FE 40       cp   $40
1D8B: 28 03       jr   z,$1D90
1D8D: BE          cp   (hl)
1D8E: 20 0A       jr   nz,$1D9A
1D90: 23          inc  hl
1D91: 13          inc  de
1D92: 0D          dec  c
1D93: 20 F3       jr   nz,$1D88
1D95: 3E 01       ld   a,$01    ; [uncovered] 
1D97: 32 D0 82    ld   ($82D0),a    ; [uncovered] 
1D9A: 3A B2 81    ld   a,($81B2)
1D9D: 4F          ld   c,a
1D9E: 3A AA 81    ld   a,($81AA)
1DA1: A1          and  c
1DA2: C0          ret  nz
1DA3: 2A 90 89    ld   hl,($8990)
1DA6: ED 5B B3 81 ld   de,($81B3)
1DAA: 06 08       ld   b,$08
1DAC: 1A          ld   a,(de)
1DAD: BE          cp   (hl)
1DAE: C0          ret  nz
1DAF: 23          inc  hl
1DB0: 13          inc  de
1DB1: 10 F9       djnz $1DAC
1DB3: 3A AA 81    ld   a,($81AA)    ; [uncovered] 
1DB6: B1          or   c    ; [uncovered] 
1DB7: 32 B2 81    ld   ($81B2),a    ; [uncovered] 
1DBA: 2A 88 89    ld   hl,($8988)    ; [uncovered] 
1DBD: 34          inc  (hl)    ; [uncovered] 
1DBE: DD E5       push ix    ; [uncovered] 
1DC0: CD 7D 09    call $097D    ; [uncovered] 
1DC3: DD E1       pop  ix    ; [uncovered] 
1DC5: 21 F4 89    ld   hl,$89F4    ; [uncovered] 
1DC8: CB C6       set  0,(hl)    ; [uncovered] 
1DCA: C9          ret    ; [uncovered] 

1DCB: 21 00 84    ld   hl,$8400
1DCE: 11 01 84    ld   de,$8401
1DD1: 01 FF 03    ld   bc,$03FF
1DD4: 36 40       ld   (hl),$40
1DD6: ED B0       ldir
1DD8: 21 00 8C    ld   hl,$8C00
1DDB: 11 01 8C    ld   de,$8C01
1DDE: 01 FF 03    ld   bc,$03FF
1DE1: 77          ld   (hl),a
1DE2: ED B0       ldir
1DE4: AF          xor  a
1DE5: 32 40 A1    ld   (scrolly_a140),a
1DE8: 32 30 A1    ld   (scrollx_a130),a
1DEB: 21 4C 80    ld   hl,$804C
1DEE: 06 04       ld   b,$04
1DF0: 77          ld   (hl),a
1DF1: 23          inc  hl
1DF2: 10 FC       djnz $1DF0
1DF4: C9          ret

1DF5: 2A 90 89    ld   hl,($8990)
1DF8: 3A 20 80    ld   a,($8020)
1DFB: A7          and  a
1DFC: C8          ret  z
1DFD: 23          inc  hl
1DFE: 23          inc  hl
1DFF: 7E          ld   a,(hl)
1E00: 3C          inc  a
1E01: E6 0F       and  $0F
1E03: 77          ld   (hl),a
1E04: FE 0A       cp   $0A
1E06: D8          ret  c
1E07: D6 0A       sub  $0A
1E09: 77          ld   (hl),a
1E0A: CB DD       set  3,l
1E0C: 2D          dec  l
1E0D: CB 9D       res  3,l
1E0F: 18 EE       jr   $1DFF

1E11: F5          push af
1E12: 7C          ld   a,h
1E13: 2F          cpl
1E14: 67          ld   h,a
1E15: 7D          ld   a,l
1E16: 2F          cpl
1E17: 6F          ld   l,a
1E18: 23          inc  hl
1E19: F1          pop  af
1E1A: C9          ret

1E1B: 3A 4E 82    ld   a,(nb_enemy_cars_824e)
1E1E: F5          push af
1E1F: 3E 03       ld   a,$03
1E21: 32 48 80    ld   ($8048),a
1E24: 32 81 A1    ld   ($A181),a
1E27: 32 6B 80    ld   ($806B),a
1E2A: EB          ex   de,hl
1E2B: 21 00 04    ld   hl,$0400
1E2E: 22 69 80    ld   ($8069),hl
1E31: 22 2D 80    ld   ($802D),hl
1E34: AF          xor  a
1E35: 67          ld   h,a
1E36: 22 5A 80    ld   ($805A),hl
1E39: 32 20 80    ld   ($8020),a
1E3C: 32 4E 82    ld   (nb_enemy_cars_824e),a
1E3F: DD 21 68 80 ld   ix,$8068
1E43: D5          push de
1E44: 3E 64       ld   a,$64
1E46: 11 20 00    ld   de,$0020
1E49: 06 09       ld   b,$09
1E4B: DD 77 0A    ld   (ix+$0a),a
1E4E: DD 19       add  ix,de
1E50: 10 F9       djnz $1E4B
1E52: D1          pop  de
1E53: DD 21 68 80 ld   ix,$8068
1E57: DD 36 0B 01 ld   (ix+$0b),$01
1E5B: DD 36 0C F0 ld   (ix+$0c),$F0
1E5F: 1A          ld   a,(de)
1E60: 4F          ld   c,a
1E61: 13          inc  de
1E62: 1A          ld   a,(de)
1E63: DD 77 0E    ld   (ix+$0e),a
1E66: DD 36 0F FC ld   (ix+$0f),$FC
1E6A: DD 36 10 01 ld   (ix+$10),$01
1E6E: 21 73 80    ld   hl,$8073
1E71: 22 02 80    ld   ($8002),hl
1E74: 13          inc  de
1E75: 1A          ld   a,(de)
1E76: 13          inc  de
1E77: 47          ld   b,a
1E78: 79          ld   a,c
1E79: DD BE 0C    cp   (ix+$0c)
1E7C: 20 FB       jr   nz,$1E79
1E7E: C5          push bc
1E7F: DD 46 0C    ld   b,(ix+$0c)
1E82: DD 4E 0E    ld   c,(ix+$0e)
1E85: CD 7F 0E    call $0E7F
1E88: C1          pop  bc
1E89: 7D          ld   a,l
1E8A: B9          cp   c
1E8B: 28 F1       jr   z,$1E7E
1E8D: 4D          ld   c,l
1E8E: 1A          ld   a,(de)
1E8F: FE 25       cp   $25
1E91: 20 20       jr   nz,$1EB3
1E93: E5          push hl    ; [uncovered] 
1E94: 2A 8A 89    ld   hl,($898A)    ; [uncovered] 
1E97: 7E          ld   a,(hl)    ; [uncovered] 
1E98: E1          pop  hl    ; [uncovered] 
1E99: C5          push bc    ; [uncovered] 
1E9A: 06 00       ld   b,$00    ; [uncovered] 
1E9C: 0F          rrca    ; [uncovered] 
1E9D: 0F          rrca    ; [uncovered] 
1E9E: E6 3F       and  $3F    ; [uncovered] 
1EA0: FE 0A       cp   $0A    ; [uncovered] 
1EA2: 38 05       jr   c,$1EA9    ; [uncovered] 
1EA4: D6 0A       sub  $0A    ; [uncovered] 
1EA6: 04          inc  b    ; [uncovered] 
1EA7: 18 F7       jr   $1EA0    ; [uncovered] 
1EA9: 4F          ld   c,a
1EAA: 78          ld   a,b
1EAB: A7          and  a
1EAC: 20 03       jr   nz,$1EB1
1EAE: 79          ld   a,c
1EAF: 18 01       jr   $1EB2
1EB1: 71          ld   (hl),c
1EB2: C1          pop  bc    ; [uncovered] 
1EB3: 2B          dec  hl
1EB4: 77          ld   (hl),a
1EB5: 13          inc  de
1EB6: 10 C6       djnz $1E7E
1EB8: AF          xor  a
1EB9: DD BE 0C    cp   (ix+$0c)
1EBC: 20 FB       jr   nz,$1EB9
1EBE: 67          ld   h,a
1EBF: 6F          ld   l,a
1EC0: 22 2D 80    ld   ($802D),hl
1EC3: 22 69 80    ld   ($8069),hl
1EC6: 21 73 80    ld   hl,$8073
1EC9: 22 02 80    ld   ($8002),hl
1ECC: EB          ex   de,hl
1ECD: F1          pop  af
1ECE: 32 4E 82    ld   (nb_enemy_cars_824e),a
1ED1: C9          ret

1ED2: E5          push hl
1ED3: D5          push de
1ED4: C5          push bc
1ED5: 21 64 1F    ld   hl,$1F64
1ED8: 11 6A 86    ld   de,$866A
1EDB: CD 29 1C    call $1C29
1EDE: 3A 24 80    ld   a,($8024)
1EE1: 21 72 86    ld   hl,$8672
1EE4: 06 00       ld   b,$00
1EE6: FE 63       cp   $63
1EE8: 38 02       jr   c,$1EEC
1EEA: 3E 63       ld   a,$63    ; [uncovered] 
1EEC: FE 0A       cp   $0A
1EEE: 38 05       jr   c,$1EF5
1EF0: 04          inc  b    ; [uncovered] 
1EF1: D6 0A       sub  $0A    ; [uncovered] 
1EF3: 18 F7       jr   $1EEC    ; [uncovered] 

1EF5: 77          ld   (hl),a
1EF6: 78          ld   a,b
1EF7: A7          and  a
1EF8: 28 02       jr   z,$1EFC
1EFA: 2B          dec  hl    ; [uncovered] 
1EFB: 77          ld   (hl),a    ; [uncovered] 
1EFC: C1          pop  bc
1EFD: D1          pop  de
1EFE: E1          pop  hl
1EFF: C9          ret

2400: 00          nop
2401: E5          push hl
2402: D5          push de
2403: C5          push bc
2404: F5          push af
2405: 3E FF       ld   a,$FF
2407: 32 82 A1    ld   ($A182),a
240A: 3A F6 89    ld   a,($89F6)
240D: 21 0D 8A    ld   hl,$8A0D
2410: 36 00       ld   (hl),$00
2412: CB 7F       bit  7,a
2414: C2 BD 26    jp   nz,$26BD
2417: CB 77       bit  6,a
2419: C2 39 26    jp   nz,$2639
241C: 00          nop
241D: 3A F5 89    ld   a,($89F5)
2420: CB 7F       bit  7,a
2422: C2 D7 25    jp   nz,$25D7
2425: CB 77       bit  6,a
2427: C2 63 26    jp   nz,$2663
242A: CB 57       bit  2,a
242C: C2 88 25    jp   nz,$2588
242F: 3A F4 89    ld   a,($89F4)
2432: CB 7F       bit  7,a
2434: CA 4C 24    jp   z,$244C
2437: 3E FF       ld   a,$FF
2439: 3D          dec  a
243A: 32 80 A1    ld   ($A180),a
243D: 32 70 A1    ld   ($A170),a
2440: 20 F7       jr   nz,$2439
2442: 32 80 A1    ld   ($A180),a
2445: 21 F4 89    ld   hl,$89F4
2448: CB BE       res  7,(hl)
244A: 18 06       jr   $2452

244C: CD B3 27    call $27B3
244F: C3 87 24    jp   $2487

2452: 21 0D 8A    ld   hl,$8A0D
2455: 3A F6 89    ld   a,($89F6)
2458: 36 01       ld   (hl),$01
245A: 3A F4 89    ld   a,($89F4)
245D: CB 47       bit  0,a
245F: C2 CD 26    jp   nz,$26CD
2462: CB 6F       bit  5,a
2464: 28 49       jr   z,$24AF
2466: 21 E8 8A    ld   hl,$8AE8
2469: 11 FD 29    ld   de,$29FD
246C: CD 93 28    call $2893
246F: CD 45 28    call $2845
2472: 21 E8 8A    ld   hl,$8AE8
2475: CB 6E       bit  5,(hl)
2477: 28 36       jr   z,$24AF
2479: CB AE       res  5,(hl)
247B: CB B6       res  6,(hl)
247D: CB BE       res  7,(hl)
247F: 21 F4 89    ld   hl,$89F4
2482: CB AE       res  5,(hl)
2484: C3 AF 24    jp   $24AF

2487: 21 0D 8A    ld   hl,$8A0D
248A: 36 00       ld   (hl),$00
248C: 3A F4 89    ld   a,($89F4)
248F: CB 5F       bit  3,a
2491: C2 1F 27    jp   nz,$271F
2494: 36 01       ld   (hl),$01
2496: CB 57       bit  2,a
2498: C2 27 27    jp   nz,$2727
249B: 36 02       ld   (hl),$02
249D: CB 4F       bit  1,a
249F: C2 2F 27    jp   nz,$272F
24A2: 36 03       ld   (hl),$03
24A4: 3A F5 89    ld   a,($89F5)
24A7: CB 6F       bit  5,a
24A9: C2 37 27    jp   nz,$2737
24AC: C3 52 24    jp   $2452

24AF: CD 1C 25    call $251C
24B2: 21 F5 89    ld   hl,$89F5
24B5: 7E          ld   a,(hl)
24B6: E6 E0       and  $E0
24B8: 20 5E       jr   nz,$2518
24BA: 3A F5 89    ld   a,($89F5)
24BD: CB 57       bit  2,a
24BF: 20 57       jr   nz,$2518
24C1: CB C6       set  0,(hl)
24C3: 21 F4 89    ld   hl,$89F4
24C6: 7E          ld   a,(hl)
24C7: 23          inc  hl
24C8: 46          ld   b,(hl)
24C9: F5          push af
24CA: 78          ld   a,b
24CB: EE 01       xor  $01
24CD: 47          ld   b,a
24CE: F1          pop  af
24CF: 23          inc  hl
24D0: 4E          ld   c,(hl)
24D1: B0          or   b
24D2: B1          or   c
24D3: FE 00       cp   $00
24D5: 20 3C       jr   nz,$2513
24D7: 32 15 A1    ld   ($A115),a
24DA: 32 1A A1    ld   ($A11A),a
24DD: 32 1F A1    ld   ($A11F),a
24E0: 32 54 8A    ld   ($8A54),a
24E3: 32 68 8A    ld   ($8A68),a
24E6: 32 74 8A    ld   ($8A74),a
24E9: 32 88 8A    ld   ($8A88),a
24EC: 32 54 8B    ld   ($8B54),a
24EF: 32 A8 8A    ld   ($8AA8),a
24F2: 32 B4 8A    ld   ($8AB4),a
24F5: 32 E8 8A    ld   ($8AE8),a
24F8: 32 F4 8A    ld   ($8AF4),a
24FB: 32 94 8A    ld   ($8A94),a
24FE: 32 C8 8A    ld   ($8AC8),a
2501: 32 D4 8A    ld   ($8AD4),a
2504: 32 28 8A    ld   ($8A28),a
2507: 32 34 8A    ld   ($8A34),a
250A: 32 48 8A    ld   ($8A48),a
250D: 32 C8 8A    ld   ($8AC8),a
2510: 32 D4 8A    ld   ($8AD4),a
2513: F1          pop  af
2514: C1          pop  bc
2515: D1          pop  de
2516: E1          pop  hl
2517: C9          ret

2518: CB 86       res  0,(hl)
251A: 18 A7       jr   $24C3

251C: 21 F5 89    ld   hl,$89F5
251F: CB 5E       bit  3,(hl)
2521: 28 0C       jr   z,$252F
2523: CB 9E       res  3,(hl)
2525: CB A6       res  4,(hl)
2527: 3E 00       ld   a,$00
2529: 32 15 A1    ld   ($A115),a
252C: 32 1A A1    ld   ($A11A),a
252F: CB 66       bit  4,(hl)
2531: 20 13       jr   nz,$2546
2533: 21 C8 8A    ld   hl,$8AC8
2536: CB BE       res  7,(hl)
2538: CB B6       res  6,(hl)
253A: CB AE       res  5,(hl)
253C: 21 D4 8A    ld   hl,$8AD4
253F: CB BE       res  7,(hl)
2541: CB B6       res  6,(hl)
2543: CB AE       res  5,(hl)
2545: C9          ret

2546: 21 C8 8A    ld   hl,$8AC8
2549: 11 A1 2B    ld   de,$2BA1
254C: CD 93 28    call $2893
254F: 3A F4 89    ld   a,($89F4)
2552: E6 0E       and  $0E
2554: FE 00       cp   $00
2556: 20 0A       jr   nz,$2562
2558: 3A F5 89    ld   a,($89F5)
255B: CB 6F       bit  5,a
255D: 20 03       jr   nz,$2562
255F: CD 28 28    call $2828
2562: 21 D4 8A    ld   hl,$8AD4
2565: 11 30 2B    ld   de,$2B30
2568: CD 93 28    call $2893
256B: 3A F4 89    ld   a,($89F4)
256E: CB 47       bit  0,a
2570: 20 0E       jr   nz,$2580
2572: CB 6F       bit  5,a
2574: 20 0A       jr   nz,$2580
2576: 3A F6 89    ld   a,($89F6)
2579: CB 7F       bit  7,a
257B: 20 03       jr   nz,$2580
257D: CD 45 28    call $2845
2580: 21 D4 8A    ld   hl,$8AD4
2583: CB 6E       bit  5,(hl)
2585: C8          ret  z
2586: 18 AB       jr   $2533
2588: 21 08 8B    ld   hl,$8B08
258B: 11 36 2A    ld   de,$2A36
258E: CD 93 28    call $2893
2591: CD 28 28    call $2828
2594: 21 14 8B    ld   hl,$8B14
2597: 11 97 2A    ld   de,$2A97
259A: CD 93 28    call $2893
259D: CD 45 28    call $2845
25A0: 21 08 8B    ld   hl,$8B08
25A3: CB 6E       bit  5,(hl)
25A5: CA B2 24    jp   z,$24B2
25A8: 21 08 8B    ld   hl,$8B08
25AB: CB AE       res  5,(hl)
25AD: CB B6       res  6,(hl)
25AF: CB BE       res  7,(hl)
25B1: 21 14 8B    ld   hl,$8B14
25B4: CB AE       res  5,(hl)
25B6: CB B6       res  6,(hl)
25B8: CB BE       res  7,(hl)
25BA: 11 00 00    ld   de,$0000
25BD: ED 53 0F 8A ld   ($8A0F),de
25C1: 3E 00       ld   a,$00
25C3: 32 11 8A    ld   ($8A11),a
25C6: CD 28 28    call $2828
25C9: CD 45 28    call $2845
25CC: CD 5D 28    call $285D
25CF: 21 F5 89    ld   hl,$89F5
25D2: CB 96       res  2,(hl)
25D4: C3 B2 24    jp   $24B2
25D7: 3E 00       ld   a,$00
25D9: 32 08 8B    ld   ($8B08),a
25DC: 32 14 8B    ld   ($8B14),a
25DF: 21 D4 8A    ld   hl,$8AD4
25E2: 11 10 2C    ld   de,$2C10
25E5: CD 93 28    call $2893
25E8: CD 5D 28    call $285D
25EB: 21 C8 8A    ld   hl,$8AC8
25EE: 11 EB 2B    ld   de,$2BEB
25F1: CD 93 28    call $2893
25F4: 3A F6 89    ld   a,($89F6)
25F7: E6 C0       and  $C0
25F9: 20 03       jr   nz,$25FE
25FB: CD 45 28    call $2845
25FE: 00          nop
25FF: 21 94 8A    ld   hl,$8A94
2602: 11 B4 2B    ld   de,$2BB4
2605: CD 93 28    call $2893
2608: CD 28 28    call $2828
260B: 21 94 8A    ld   hl,$8A94
260E: CB 6E       bit  5,(hl)
2610: CA B2 24    jp   z,$24B2
2613: CD 74 27    call $2774
2616: 21 94 8A    ld   hl,$8A94
2619: CB AE       res  5,(hl)
261B: CB B6       res  6,(hl)
261D: CB BE       res  7,(hl)
261F: 21 C8 8A    ld   hl,$8AC8
2622: CB AE       res  5,(hl)
2624: CB B6       res  6,(hl)
2626: CB BE       res  7,(hl)
2628: 21 D4 8A    ld   hl,$8AD4
262B: CB AE       res  5,(hl)
262D: CB B6       res  6,(hl)
262F: CB BE       res  7,(hl)
2631: 21 F5 89    ld   hl,$89F5
2634: CB BE       res  7,(hl)
2636: C3 B2 24    jp   $24B2
2639: 21 54 8B    ld   hl,$8B54
263C: 11 A6 2B    ld   de,$2BA6
263F: CD 93 28    call $2893
2642: CD 45 28    call $2845
2645: 3E 00       ld   a,$00
2647: 32 15 A1    ld   ($A115),a
264A: 32 1F A1    ld   ($A11F),a
264D: 21 54 8B    ld   hl,$8B54
2650: CB 6E       bit  5,(hl)
2652: CA 1C 24    jp   z,$241C
2655: CB AE       res  5,(hl)
2657: CB B6       res  6,(hl)
2659: CB BE       res  7,(hl)
265B: 21 F6 89    ld   hl,$89F6
265E: CB B6       res  6,(hl)
2660: C3 1C 24    jp   $241C
2663: 21 48 8A    ld   hl,$8A48
2666: 11 15 2B    ld   de,$2B15
2669: CD 93 28    call $2893
266C: CD 5D 28    call $285D
266F: 21 34 8A    ld   hl,$8A34
2672: 11 F8 2A    ld   de,$2AF8
2675: CD 93 28    call $2893
2678: 3A F6 89    ld   a,($89F6)
267B: E6 C0       and  $C0
267D: 20 03       jr   nz,$2682
267F: CD 45 28    call $2845
2682: 00          nop
2683: 21 28 8A    ld   hl,$8A28
2686: 11 E3 2A    ld   de,$2AE3
2689: CD 93 28    call $2893
268C: CD 28 28    call $2828
268F: 21 28 8A    ld   hl,$8A28
2692: CB 6E       bit  5,(hl)
2694: CA B2 24    jp   z,$24B2
2697: CD 74 27    call $2774
269A: 21 28 8A    ld   hl,$8A28
269D: CB AE       res  5,(hl)
269F: CB B6       res  6,(hl)
26A1: CB BE       res  7,(hl)
26A3: 21 34 8A    ld   hl,$8A34
26A6: CB AE       res  5,(hl)
26A8: CB B6       res  6,(hl)
26AA: CB BE       res  7,(hl)
26AC: 21 48 8A    ld   hl,$8A48
26AF: CB AE       res  5,(hl)
26B1: CB B6       res  6,(hl)
26B3: CB BE       res  7,(hl)
26B5: 21 F5 89    ld   hl,$89F5
26B8: CB B6       res  6,(hl)
26BA: C3 B2 24    jp   $24B2
26BD: 21 54 8A    ld   hl,$8A54
26C0: 11 C9 29    ld   de,$29C9
26C3: 3E 00       ld   a,$00
26C5: 32 1F A1    ld   ($A11F),a
26C8: 32 15 A1    ld   ($A115),a
26CB: 18 2B       jr   $26F8
26CD: 21 68 8A    ld   hl,$8A68
26D0: 11 17 2A    ld   de,$2A17
26D3: CD 93 28    call $2893
26D6: CD 45 28    call $2845
26D9: 3E 00       ld   a,$00
26DB: 32 15 A1    ld   ($A115),a
26DE: CB 6E       bit  5,(hl)
26E0: CA AF 24    jp   z,$24AF
26E3: CB AE       res  5,(hl)
26E5: CB B6       res  6,(hl)
26E7: CB BE       res  7,(hl)
26E9: 3A 0D 8A    ld   a,($8A0D)
26EC: FE 00       cp   $00
26EE: 20 27       jr   nz,$2717
26F0: 21 F6 89    ld   hl,$89F6
26F3: CB BE       res  7,(hl)
26F5: C3 AF 24    jp   $24AF
26F8: CD 93 28    call $2893
26FB: CD 45 28    call $2845
26FE: 3A 54 8A    ld   a,($8A54)
2701: CB 6E       bit  5,(hl)
2703: CA 1C 24    jp   z,$241C
2706: 21 54 8A    ld   hl,$8A54
2709: CB AE       res  5,(hl)
270B: CB B6       res  6,(hl)
270D: CB BE       res  7,(hl)
270F: 21 F6 89    ld   hl,$89F6
2712: CB BE       res  7,(hl)
2714: C3 1C 24    jp   $241C
2717: 21 F4 89    ld   hl,$89F4
271A: CB 86       res  0,(hl)
271C: C3 AF 24    jp   $24AF
271F: 21 74 8A    ld   hl,$8A74
2722: 11 8E 29    ld   de,$298E
2725: 18 16       jr   $273D

2727: 21 88 8A    ld   hl,$8A88
272A: 11 F0 29    ld   de,$29F0
272D: 18 0E       jr   $273D

272F: 21 A8 8A    ld   hl,$8AA8
2732: 11 10 2A    ld   de,$2A10
2735: 18 06       jr   $273D

2737: 11 DA 29    ld   de,$29DA
273A: 21 B4 8A    ld   hl,$8AB4
273D: CD 93 28    call $2893
2740: CD 28 28    call $2828
2743: CB 6E       bit  5,(hl)
2745: CA AF 24    jp   z,$24AF
2748: CB B6       res  6,(hl)
274A: CB AE       res  5,(hl)
274C: CB BE       res  7,(hl)
274E: 3A 0D 8A    ld   a,($8A0D)
2751: 21 F4 89    ld   hl,$89F4
2754: FE 00       cp   $00
2756: 28 18       jr   z,$2770
2758: FE 01       cp   $01
275A: 28 10       jr   z,$276C
275C: FE 02       cp   $02
275E: 28 08       jr   z,$2768
2760: 21 F5 89    ld   hl,$89F5
2763: CB AE       res  5,(hl)
2765: C3 AF 24    jp   $24AF

2768: CB 8E       res  1,(hl)
276A: 18 F9       jr   $2765

276C: CB 96       res  2,(hl)
276E: 18 F5       jr   $2765

2770: CB 9E       res  3,(hl)
2772: 18 F1       jr   $2765

2774: 3E 00       ld   a,$00
2776: 32 15 A1    ld   ($A115),a
2779: 32 1A A1    ld   ($A11A),a
277C: 32 1F A1    ld   ($A11F),a
277F: C9          ret

2780: 21 F4 8A    ld   hl,$8AF4
2783: 11 DC 2A    ld   de,$2ADC
2786: CD 93 28    call $2893
2789: CD 5D 28    call $285D
278C: 21 F4 8A    ld   hl,$8AF4
278F: CB 7F       bit  7,a
2791: 28 07       jr   z,$279A
2793: 3E 01       ld   a,$01    ; [uncovered] 
2795: 32 80 A1    ld   ($A180),a    ; [uncovered] 
2798: 18 06       jr   $27A0    ; [uncovered] 

279A: 00          nop
279B: 3E 00       ld   a,$00
279D: 32 80 A1    ld   ($A180),a
27A0: 00          nop
27A1: 21 F4 8A    ld   hl,$8AF4
27A4: CB 6E       bit  5,(hl)
27A6: C8          ret  z
27A7: CB AE       res  5,(hl)
27A9: CB B6       res  6,(hl)
27AB: CB BE       res  7,(hl)
27AD: 21 F4 89    ld   hl,$89F4
27B0: CB A6       res  4,(hl)
27B2: C9          ret

27B3: 3A F4 89    ld   a,($89F4)
27B6: CB 77       bit  6,a
27B8: 20 06       jr   nz,$27C0
27BA: 3E 00       ld   a,$00
27BC: 32 1F A1    ld   ($A11F),a
27BF: C9          ret

27C0: 3A F4 89    ld   a,($89F4)
27C3: CB 67       bit  4,a
27C5: C2 80 27    jp   nz,$2780
27C8: 3A 6A 80    ld   a,($806A)
27CB: CB 7F       bit  7,a
27CD: 28 0E       jr   z,$27DD
27CF: 3A 6B 80    ld   a,($806B)
27D2: FE 00       cp   $00
27D4: 28 03       jr   z,$27D9
27D6: AF          xor  a
27D7: 18 11       jr   $27EA

27D9: 3E 01       ld   a,$01
27DB: 18 0D       jr   $27EA

27DD: 3A 6B 80    ld   a,($806B)
27E0: FE 00       cp   $00
27E2: 28 04       jr   z,$27E8
27E4: 3E 02       ld   a,$02
27E6: 18 02       jr   $27EA

27E8: 3E 03       ld   a,$03
27EA: 32 0F A1    ld   ($A10F),a
27ED: 3E 04       ld   a,$04
27EF: 32 1F A1    ld   ($A11F),a
27F2: 11 50 00    ld   de,$0050
27F5: 2A 69 80    ld   hl,($8069)
27F8: CB 7C       bit  7,h
27FA: 28 07       jr   z,$2803
27FC: 7C          ld   a,h
27FD: 2F          cpl
27FE: 67          ld   h,a
27FF: 7D          ld   a,l
2800: 2F          cpl
2801: 6F          ld   l,a
2802: 23          inc  hl
2803: 19          add  hl,de
2804: 7D          ld   a,l
2805: CB 3F       srl  a
2807: CB 3F       srl  a
2809: CB 3F       srl  a
280B: CB 3F       srl  a
280D: 32 1B A1    ld   ($A11B),a
2810: 7C          ld   a,h
2811: E6 0F       and  $0F
2813: 32 1C A1    ld   ($A11C),a
2816: 7C          ld   a,h
2817: CB 3F       srl  a
2819: CB 3F       srl  a
281B: CB 3F       srl  a
281D: CB 3F       srl  a
281F: 32 1D A1    ld   ($A11D),a
2822: 3E 00       ld   a,$00
2824: 32 1E A1    ld   ($A11E),a
2827: C9          ret

2828: 3A 0E 8A    ld   a,($8A0E)
282B: E5          push hl
282C: 32 05 A1    ld   ($A105),a
282F: 3A 11 8A    ld   a,($8A11)
2832: 32 15 A1    ld   ($A115),a
2835: 2A 0F 8A    ld   hl,($8A0F)
2838: 11 10 A1    ld   de,$A110
283B: 7D          ld   a,l
283C: E6 0F       and  $0F
283E: 12          ld   (de),a
283F: 13          inc  de
2840: CD 75 28    call $2875
2843: E1          pop  hl
2844: C9          ret

2845: 3A 0E 8A    ld   a,($8A0E)
2848: E5          push hl
2849: 32 0A A1    ld   ($A10A),a
284C: 3A 11 8A    ld   a,($8A11)
284F: 32 1A A1    ld   ($A11A),a
2852: 2A 0F 8A    ld   hl,($8A0F)
2855: 11 16 A1    ld   de,$A116
2858: CD 75 28    call $2875
285B: E1          pop  hl
285C: C9          ret

285D: 3A 0E 8A    ld   a,($8A0E)
2860: E5          push hl
2861: 32 0F A1    ld   ($A10F),a
2864: 3A 11 8A    ld   a,($8A11)
2867: 32 1F A1    ld   ($A11F),a
286A: 2A 0F 8A    ld   hl,($8A0F)
286D: 11 1B A1    ld   de,$A11B
2870: CD 75 28    call $2875
2873: E1          pop  hl
2874: C9          ret

2875: 7D          ld   a,l
2876: CB 3F       srl  a
2878: CB 3F       srl  a
287A: CB 3F       srl  a
287C: CB 3F       srl  a
287E: 12          ld   (de),a
287F: 13          inc  de
2880: 7C          ld   a,h
2881: E6 0F       and  $0F
2883: 12          ld   (de),a
2884: 13          inc  de
2885: 7C          ld   a,h
2886: CB 3F       srl  a
2888: CB 3F       srl  a
288A: CB 3F       srl  a
288C: CB 3F       srl  a
288E: 12          ld   (de),a
288F: 13          inc  de
2890: AF          xor  a
2891: 12          ld   (de),a
2892: C9          ret

2893: E5          push hl
2894: 22 0B 8A    ld   ($8A0B),hl
2897: CB 7E       bit  7,(hl)
2899: 20 1E       jr   nz,$28B9
289B: 23          inc  hl
289C: 73          ld   (hl),e
289D: 23          inc  hl
289E: 72          ld   (hl),d
289F: 23          inc  hl
28A0: 1B          dec  de
28A1: 1B          dec  de
28A2: 1B          dec  de
28A3: 1A          ld   a,(de)
28A4: 77          ld   (hl),a
28A5: 13          inc  de
28A6: 1A          ld   a,(de)
28A7: 32 0E 8A    ld   ($8A0E),a
28AA: 13          inc  de
28AB: 23          inc  hl
28AC: 23          inc  hl
28AD: 23          inc  hl
28AE: 23          inc  hl
28AF: 23          inc  hl
28B0: 77          ld   (hl),a
28B1: 2B          dec  hl
28B2: 1A          ld   a,(de)
28B3: 77          ld   (hl),a
28B4: 2A 0B 8A    ld   hl,($8A0B)
28B7: CB FE       set  7,(hl)
28B9: CB 76       bit  6,(hl)
28BB: 20 70       jr   nz,$292D
28BD: ED 5B 0B 8A ld   de,($8A0B)
28C1: 13          inc  de
28C2: 1A          ld   a,(de)
28C3: 6F          ld   l,a
28C4: 13          inc  de
28C5: 1A          ld   a,(de)
28C6: 67          ld   h,a
28C7: 3E 00       ld   a,$00
28C9: 32 11 8A    ld   ($8A11),a
28CC: 4E          ld   c,(hl)
28CD: CB 21       sla  c
28CF: E5          push hl
28D0: 06 00       ld   b,$00
28D2: 21 36 2C    ld   hl,$2C36
28D5: 09          add  hl,bc
28D6: 7E          ld   a,(hl)
28D7: 32 0F 8A    ld   ($8A0F),a
28DA: 23          inc  hl
28DB: 7E          ld   a,(hl)
28DC: 32 10 8A    ld   ($8A10),a
28DF: E1          pop  hl
28E0: 13          inc  de
28E1: 1A          ld   a,(de)
28E2: 13          inc  de
28E3: 12          ld   (de),a
28E4: 13          inc  de
28E5: 23          inc  hl
28E6: 7E          ld   a,(hl)
28E7: CB 3F       srl  a
28E9: CB 3F       srl  a
28EB: CB 3F       srl  a
28ED: CB 3F       srl  a
28EF: 12          ld   (de),a
28F0: 13          inc  de
28F1: 13          inc  de
28F2: 1A          ld   a,(de)
28F3: CD 72 29    call $2972
28F6: 1B          dec  de
28F7: 12          ld   (de),a
28F8: 23          inc  hl
28F9: ED 5B 0B 8A ld   de,($8A0B)
28FD: 13          inc  de
28FE: 7D          ld   a,l
28FF: 12          ld   (de),a
2900: 13          inc  de
2901: 7C          ld   a,h
2902: 12          ld   (de),a
2903: 3A 0F 8A    ld   a,($8A0F)
2906: FE 00       cp   $00
2908: 20 10       jr   nz,$291A
290A: 3A 10 8A    ld   a,($8A10)
290D: FE 00       cp   $00
290F: 20 09       jr   nz,$291A
2911: 2A 0B 8A    ld   hl,($8A0B)
2914: CB EE       set  5,(hl)
2916: CB BE       res  7,(hl)
2918: E1          pop  hl
2919: C9          ret

291A: 2A 0B 8A    ld   hl,($8A0B)
291D: CB F6       set  6,(hl)
291F: 2A 0B 8A    ld   hl,($8A0B)
2922: 11 09 00    ld   de,$0009
2925: 19          add  hl,de
2926: ED 5B 0F 8A ld   de,($8A0F)
292A: 73          ld   (hl),e
292B: 23          inc  hl
292C: 72          ld   (hl),d
292D: 2A 0B 8A    ld   hl,($8A0B)
2930: 11 09 00    ld   de,$0009
2933: 19          add  hl,de
2934: 7E          ld   a,(hl)
2935: 32 0F 8A    ld   ($8A0F),a
2938: 23          inc  hl
2939: 7E          ld   a,(hl)
293A: 32 10 8A    ld   ($8A10),a
293D: 2A 0B 8A    ld   hl,($8A0B)
2940: 11 08 00    ld   de,$0008
2943: 19          add  hl,de
2944: 7E          ld   a,(hl)
2945: 32 0E 8A    ld   ($8A0E),a
2948: 2A 0B 8A    ld   hl,($8A0B)
294B: 11 05 00    ld   de,$0005
294E: 19          add  hl,de
294F: 7E          ld   a,(hl)
2950: 32 11 8A    ld   ($8A11),a
2953: FE 00       cp   $00
2955: 28 0A       jr   z,$2961
2957: 2B          dec  hl
2958: 35          dec  (hl)
2959: 20 0C       jr   nz,$2967
295B: 2B          dec  hl
295C: 7E          ld   a,(hl)
295D: 23          inc  hl
295E: 77          ld   (hl),a
295F: 23          inc  hl
2960: 35          dec  (hl)
2961: 23          inc  hl
2962: 35          dec  (hl)
2963: 28 05       jr   z,$296A
2965: E1          pop  hl
2966: C9          ret

2967: 23          inc  hl
2968: 18 F7       jr   $2961

296A: 00          nop
296B: 2A 0B 8A    ld   hl,($8A0B)
296E: CB B6       res  6,(hl)
2970: E1          pop  hl
2971: C9          ret

2972: E5          push hl
2973: C5          push bc
2974: E6 0F       and  $0F
2976: 47          ld   b,a
2977: 7E          ld   a,(hl)
2978: E6 0F       and  $0F
297A: 4F          ld   c,a
297B: AF          xor  a
297C: 80          add  a,b
297D: 32 70 A1    ld   ($A170),a
2980: 0D          dec  c
2981: 20 F9       jr   nz,$297C
2983: C1          pop  bc
2984: E1          pop  hl
2985: C9          ret

boot_3800:
3800: 31 4C 38    ld   sp,$384C
3803: C9          ret				; jumps to 3911

boot_sequence_384C:
	.word	reset_3911
	.word	resume_boot_3967		; jump to 0003 directly to skip boot
	.word 	resume_boot_39b1
	
389E: 31 00 84    ld   sp,$8400
389F: 00          nop    ; [uncovered] 
38A0: 84          add  a,h    ; [uncovered] 
38A1: 21 00 80    ld   hl,$8000
38A4: 11 01 80    ld   de,$8001
38A7: 01 FF 03    ld   bc,$03FF
38AA: 36 00       ld   (hl),$00
38AC: ED B0       ldir
38AE: 21 00 88    ld   hl,$8800
38B1: 11 01 88    ld   de,$8801
38B4: 01 FF 03    ld   bc,$03FF
38B7: 36 00       ld   (hl),$00
38B9: ED B0       ldir
38BB: CD 1E 39    call $391E
38BE: 3E 01       ld   a,$01
38C0: 32 84 A1    ld   ($A184),a
38C3: 32 85 A1    ld   ($A185),a
38C6: 21 A0 02    ld   hl,$02A0
38C9: 22 69 80    ld   ($8069),hl
38CC: ED 5E       im   2
38CE: 3E 3F       ld   a,$3F
38D0: ED 47       ld   i,a
38D2: 3E FE       ld   a,$FE
38D4: D3 00       out  ($00),a
38D6: 3E 01       ld   a,$01
38D8: 32 81 A1    ld   ($A181),a
38DB: 32 82 A1    ld   ($A182),a
38DE: FB          ei
38DF: 3A 00 A1    ld   a,(dsw_a100)
38E2: CB 47       bit  0,a
38E4: 28 F9       jr   z,$38DF
38E6: F3          di
38E7: AF          xor  a
38E8: 32 81 A1    ld   ($A181),a
38EB: 32 82 A1    ld   ($A182),a
38EE: CD CE 3D    call $3DCE
38F1: 01 00 00    ld   bc,$0000
38F4: 3E 02       ld   a,$02
38F6: 32 80 A0    ld   (watchdog_a080),a
38F9: 3D          dec  a
38FA: 20 FA       jr   nz,$38F6
38FC: 0D          dec  c
38FD: 20 F5       jr   nz,$38F4
38FF: 10 F3       djnz $38F4
3901: 32 80 A0    ld   (watchdog_a080),a
3904: 3A 00 A1    ld   a,(dsw_a100)
3907: CB 47       bit  0,a
3909: 28 F6       jr   z,$3901
390B: CD 59 39    call $3959
390E: C3 03 00    jp   $0003

; after setting the stack to a value to hide entrypoint/boot sequence
; the game jumps here
reset_3911:
; various memory fills
3911: 21 00 84    ld   hl,$8400
3914: 11 01 84    ld   de,$8401
3917: 01 FF 03    ld   bc,$03FF
391A: 36 40       ld   (hl),$40
391C: ED B0       ldir			; fill video with $40
391E: 21 00 8C    ld   hl,$8C00
3921: 11 01 8C    ld   de,$8C01
3924: 01 FF 03    ld   bc,$03FF
3927: 36 66       ld   (hl),$66	; fill attibs
3929: ED B0       ldir
392B: 21 40 80    ld   hl,$8040
392E: 01 08 1C    ld   bc,$1C08
3931: 3E 40       ld   a,$40
3933: 57          ld   d,a
3934: 3E 20       ld   a,$20
3936: 91          sub  c
3937: 5F          ld   e,a
3938: 7A          ld   a,d
3939: 51          ld   d,c
393A: 77          ld   (hl),a
393B: 23          inc  hl
393C: 15          dec  d
393D: 20 FB       jr   nz,$393A
393F: 19          add  hl,de
3940: 10 F7       djnz $3939
3942: 21 40 88    ld   hl,$8840
3945: 01 08 1C    ld   bc,$1C08
3948: 3E 66       ld   a,$66
394A: 57          ld   d,a
394B: 3E 20       ld   a,$20
394D: 91          sub  c
394E: 5F          ld   e,a
394F: 7A          ld   a,d
3950: 51          ld   d,c
3951: 77          ld   (hl),a
3952: 23          inc  hl
3953: 15          dec  d
3954: 20 FB       jr   nz,$3951
3956: 19          add  hl,de
3957: 10 F7       djnz $3950
3959: 21 00 A0    ld   hl,p1_a000
395C: 01 00 02    ld   bc,$0200
395F: 71          ld   (hl),c
3960: 2C          inc  l
3961: 20 FC       jr   nz,$395F
3963: 24          inc  h
3964: 10 F9       djnz $395F
3966: C9          ret		; [disabled] continues to 3967

; another memory copy sequence
resume_boot_3967:
3967: 11 F9 3F    ld   de,$3FF9
396A: 21 00 00    ld   hl,$0000
396D: 01 00 10    ld   bc,$1000
3970: 32 80 A0    ld   (watchdog_a080),a
3973: 79          ld   a,c
3974: 86          add  a,(hl)
3975: 4F          ld   c,a
3976: 2C          inc  l
3977: 20 FA       jr   nz,$3973
3979: 24          inc  h
397A: 10 F4       djnz $3970
397C: 1A          ld   a,(de)
397D: B9          cp   c
397E: 20 0F       jr   nz,$398F
3980: 13          inc  de
3981: 7B          ld   a,e
3982: FE FD       cp   $FD
3984: 38 E7       jr   c,$396D
3986: 3E 4F       ld   a,$4F
3988: 32 8B 84    ld   ($848B),a
398B: 3E 4B       ld   a,$4B
398D: 18 03       jr   $3992

; displays "ROM OK"
3992: 32 8C 84    ld   ($848C),a
3995: 06 4F       ld   b,$4F
3997: 21 86 84    ld   hl,$8486
399A: 36 4D       ld   (hl),$4D
399C: 2D          dec  l
399D: 70          ld   (hl),b
399E: 2D          dec  l
399F: 36 52       ld   (hl),$52
39A1: FE 4B       cp   $4B
39A3: C8          ret  z		; jumps to 39B1
; error: reset
39A4: 32 80 A0    ld   (watchdog_a080),a    ; [uncovered] 
39A7: 3A 00 A1    ld   a,(dsw_a100)    ; [uncovered] 
39AA: CB 47       bit  0,a    ; [uncovered] 
39AC: 28 F6       jr   z,$39A4    ; [uncovered] 
39AE: C3 00 00    jp   $0000    ; [uncovered] 

resume_boot_39b1:
39B1: 16 0F       ld   d,$0F
39B3: E1          pop  hl
39B4: C1          pop  bc
39B5: 5A          ld   e,d
39B6: 32 80 A0    ld   (watchdog_a080),a
39B9: 7B          ld   a,e
39BA: 0F          rrca
39BB: 0F          rrca
39BC: 0F          rrca
39BD: 0F          rrca
39BE: 83          add  a,e
39BF: 80          add  a,b
39C0: A1          and  c
39C1: 77          ld   (hl),a
39C2: 7B          ld   a,e
39C3: 87          add  a,a
39C4: 87          add  a,a
39C5: 83          add  a,e
39C6: 3C          inc  a
39C7: 5F          ld   e,a
39C8: 2C          inc  l
39C9: 20 EE       jr   nz,$39B9
39CB: 24          inc  h
39CC: 10 E8       djnz $39B6
39CE: 3B          dec  sp
39CF: 3B          dec  sp
39D0: 3B          dec  sp
39D1: 3B          dec  sp
39D2: E1          pop  hl
39D3: C1          pop  bc
39D4: 5A          ld   e,d
39D5: 32 80 A0    ld   (watchdog_a080),a
39D8: 7B          ld   a,e
39D9: 0F          rrca
39DA: 0F          rrca
39DB: 0F          rrca
39DC: 0F          rrca
39DD: 83          add  a,e
39DE: 80          add  a,b
39DF: AE          xor  (hl)
39E0: A1          and  c
39E1: 20 17       jr   nz,$39FA
39E3: 7B          ld   a,e
39E4: 87          add  a,a
39E5: 87          add  a,a
39E6: 83          add  a,e
39E7: 3C          inc  a
39E8: 5F          ld   e,a
39E9: 2C          inc  l
39EA: 20 EC       jr   nz,$39D8
39EC: 24          inc  h
39ED: 10 E6       djnz $39D5
39EF: 3B          dec  sp
39F0: 3B          dec  sp
39F1: 3B          dec  sp
39F2: 3B          dec  sp
39F3: 15          dec  d
39F4: F2 B3 39    jp   p,$39B3
39F7: E1          pop  hl
39F8: C1          pop  bc
39F9: C9          ret

3A27: 32 CC 84    ld   ($84CC),a
3A2A: 06 0A       ld   b,$0A
3A2C: 21 C6 84    ld   hl,$84C6
3A2F: C3 9A 39    jp   $399A

3A32: 21 00 9C    ld   hl,$9C00
3A35: 11 00 84    ld   de,$8400
3A38: 01 00 04    ld   bc,$0400
3A3B: ED B0       ldir
3A3D: 3E 4F       ld   a,$4F
3A3F: 32 CB 84    ld   ($84CB),a
3A42: 3E 4B       ld   a,$4B
3A44: 18 E1       jr   $3A27

3A46: 21 00 84    ld   hl,$8400
3A49: 11 00 9C    ld   de,$9C00
3A4C: 01 00 04    ld   bc,$0400
3A4F: ED B0       ldir
3A51: C9          ret

3DCE: 3E 03       ld   a,$03
3DD0: 32 30 A1    ld   (scrollx_a130),a
3DD3: 21 00 84    ld   hl,$8400
3DD6: 11 01 84    ld   de,$8401
3DD9: 01 FF 03    ld   bc,$03FF
3DDC: 36 5B       ld   (hl),$5B
3DDE: ED B0       ldir
3DE0: 21 40 80    ld   hl,$8040
3DE3: 01 08 1C    ld   bc,$1C08
3DE6: 3E 5B       ld   a,$5B
3DE8: CD 20 3E    call $3E20
3DEB: 21 00 8C    ld   hl,$8C00
3DEE: 01 00 04    ld   bc,$0400
3DF1: CD 10 3E    call $3E10
3DF4: 23          inc  hl
3DF5: 0B          dec  bc
3DF6: 79          ld   a,c
3DF7: B0          or   b
3DF8: 20 F7       jr   nz,$3DF1
3DFA: 21 40 88    ld   hl,$8840
3DFD: 01 08 1C    ld   bc,$1C08
3E00: 3E 20       ld   a,$20
3E02: 91          sub  c
3E03: 5F          ld   e,a
3E04: 51          ld   d,c
3E05: CD 10 3E    call $3E10
3E08: 23          inc  hl
3E09: 15          dec  d
3E0A: 20 F9       jr   nz,$3E05
3E0C: 19          add  hl,de
3E0D: 10 F5       djnz $3E04
3E0F: C9          ret

3E10: CB 45       bit  0,l
3E12: CB F6       set  6,(hl)
3E14: 28 02       jr   z,$3E18
3E16: CB B6       res  6,(hl)
3E18: CB 6D       bit  5,l
3E1A: CB BE       res  7,(hl)
3E1C: C8          ret  z
3E1D: CB FE       set  7,(hl)
3E1F: C9          ret

3E20: 57          ld   d,a
3E21: 3E 20       ld   a,$20
3E23: 91          sub  c
3E24: 5F          ld   e,a
3E25: 7A          ld   a,d
3E26: 51          ld   d,c
3E27: 77          ld   (hl),a
3E28: 23          inc  hl
3E29: 15          dec  d
3E2A: 20 FB       jr   nz,$3E27
3E2C: 19          add  hl,de
3E2D: 10 F7       djnz $3E26
3E2F: C9          ret

