
user/_swaptest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user/user.h"

#define ALLOC_PAGES 300
#define PGSIZE 4096

int main() {
   0:	7161                	addi	sp,sp,-432
   2:	f706                	sd	ra,424(sp)
   4:	f322                	sd	s0,416(sp)
   6:	ef26                	sd	s1,408(sp)
   8:	eb4a                	sd	s2,400(sp)
   a:	e74e                	sd	s3,392(sp)
   c:	e352                	sd	s4,384(sp)
   e:	fed6                	sd	s5,376(sp)
  10:	fada                	sd	s6,368(sp)
  12:	1b00                	addi	s0,sp,432
  14:	81010113          	addi	sp,sp,-2032
    char *buf[ALLOC_PAGES];
    for(int i = 0; i < ALLOC_PAGES; i++){
  18:	797d                	lui	s2,0xfffff
  1a:	66090793          	addi	a5,s2,1632 # fffffffffffff660 <base+0xffffffffffffe650>
  1e:	00878933          	add	s2,a5,s0
  22:	4481                	li	s1,0
  24:	12c00993          	li	s3,300
        buf[i] = malloc(PGSIZE);
  28:	6505                	lui	a0,0x1
  2a:	00d000ef          	jal	836 <malloc>
  2e:	00a93023          	sd	a0,0(s2)
        if(buf[i] == 0){
  32:	cd1d                	beqz	a0,70 <main+0x70>
  34:	87aa                	mv	a5,a0
  36:	6705                	lui	a4,0x1
  38:	972a                	add	a4,a4,a0
            printf("malloc failed at %d\n", i);
            exit(1);
        }
        for(int j = 0; j < PGSIZE; j++)
            buf[i][j] = i;
  3a:	00978023          	sb	s1,0(a5)
        for(int j = 0; j < PGSIZE; j++)
  3e:	0785                	addi	a5,a5,1
  40:	fee79de3          	bne	a5,a4,3a <main+0x3a>
    for(int i = 0; i < ALLOC_PAGES; i++){
  44:	2485                	addiw	s1,s1,1
  46:	0921                	addi	s2,s2,8
  48:	ff3490e3          	bne	s1,s3,28 <main+0x28>
    }

    printf("Memory allocated and initialized.\n");
  4c:	00001517          	auipc	a0,0x1
  50:	90450513          	addi	a0,a0,-1788 # 950 <malloc+0x11a>
  54:	72e000ef          	jal	782 <printf>

    for(int i = ALLOC_PAGES-1; i >= 0; i--){
  58:	fb840913          	addi	s2,s0,-72
  5c:	12b00493          	li	s1,299
  60:	6a85                	lui	s5,0x1
        int sum = 0;
  62:	4a01                	li	s4,0
        for(int j = 0; j < PGSIZE; j++)
            sum += buf[i][j];
        if(sum != i*PGSIZE){
            printf("Data mismatch at page %d\n", i);
  64:	00001b17          	auipc	s6,0x1
  68:	914b0b13          	addi	s6,s6,-1772 # 978 <malloc+0x142>
    for(int i = ALLOC_PAGES-1; i >= 0; i--){
  6c:	59fd                	li	s3,-1
  6e:	a839                	j	8c <main+0x8c>
            printf("malloc failed at %d\n", i);
  70:	85a6                	mv	a1,s1
  72:	00001517          	auipc	a0,0x1
  76:	8be50513          	addi	a0,a0,-1858 # 930 <malloc+0xfa>
  7a:	708000ef          	jal	782 <printf>
            exit(1);
  7e:	4505                	li	a0,1
  80:	2da000ef          	jal	35a <exit>
    for(int i = ALLOC_PAGES-1; i >= 0; i--){
  84:	34fd                	addiw	s1,s1,-1
  86:	1961                	addi	s2,s2,-8
  88:	03348663          	beq	s1,s3,b4 <main+0xb4>
        for(int j = 0; j < PGSIZE; j++)
  8c:	00093783          	ld	a5,0(s2)
  90:	01578633          	add	a2,a5,s5
        int sum = 0;
  94:	8752                	mv	a4,s4
            sum += buf[i][j];
  96:	0007c683          	lbu	a3,0(a5)
  9a:	9f35                	addw	a4,a4,a3
        for(int j = 0; j < PGSIZE; j++)
  9c:	0785                	addi	a5,a5,1
  9e:	fef61ce3          	bne	a2,a5,96 <main+0x96>
        if(sum != i*PGSIZE){
  a2:	00c4979b          	slliw	a5,s1,0xc
  a6:	fce78fe3          	beq	a5,a4,84 <main+0x84>
            printf("Data mismatch at page %d\n", i);
  aa:	85a6                	mv	a1,s1
  ac:	855a                	mv	a0,s6
  ae:	6d4000ef          	jal	782 <printf>
  b2:	bfc9                	j	84 <main+0x84>
        }
    }

    printf("Swap test finished successfully.\n");
  b4:	00001517          	auipc	a0,0x1
  b8:	8e450513          	addi	a0,a0,-1820 # 998 <malloc+0x162>
  bc:	6c6000ef          	jal	782 <printf>
    exit(0);
  c0:	4501                	li	a0,0
  c2:	298000ef          	jal	35a <exit>

00000000000000c6 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  c6:	1141                	addi	sp,sp,-16
  c8:	e406                	sd	ra,8(sp)
  ca:	e022                	sd	s0,0(sp)
  cc:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  ce:	f33ff0ef          	jal	0 <main>
  exit(r);
  d2:	288000ef          	jal	35a <exit>

00000000000000d6 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  d6:	1141                	addi	sp,sp,-16
  d8:	e422                	sd	s0,8(sp)
  da:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  dc:	87aa                	mv	a5,a0
  de:	0585                	addi	a1,a1,1
  e0:	0785                	addi	a5,a5,1
  e2:	fff5c703          	lbu	a4,-1(a1)
  e6:	fee78fa3          	sb	a4,-1(a5)
  ea:	fb75                	bnez	a4,de <strcpy+0x8>
    ;
  return os;
}
  ec:	6422                	ld	s0,8(sp)
  ee:	0141                	addi	sp,sp,16
  f0:	8082                	ret

00000000000000f2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f2:	1141                	addi	sp,sp,-16
  f4:	e422                	sd	s0,8(sp)
  f6:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  f8:	00054783          	lbu	a5,0(a0)
  fc:	cb91                	beqz	a5,110 <strcmp+0x1e>
  fe:	0005c703          	lbu	a4,0(a1)
 102:	00f71763          	bne	a4,a5,110 <strcmp+0x1e>
    p++, q++;
 106:	0505                	addi	a0,a0,1
 108:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 10a:	00054783          	lbu	a5,0(a0)
 10e:	fbe5                	bnez	a5,fe <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 110:	0005c503          	lbu	a0,0(a1)
}
 114:	40a7853b          	subw	a0,a5,a0
 118:	6422                	ld	s0,8(sp)
 11a:	0141                	addi	sp,sp,16
 11c:	8082                	ret

000000000000011e <strlen>:

uint
strlen(const char *s)
{
 11e:	1141                	addi	sp,sp,-16
 120:	e422                	sd	s0,8(sp)
 122:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 124:	00054783          	lbu	a5,0(a0)
 128:	cf91                	beqz	a5,144 <strlen+0x26>
 12a:	0505                	addi	a0,a0,1
 12c:	87aa                	mv	a5,a0
 12e:	86be                	mv	a3,a5
 130:	0785                	addi	a5,a5,1
 132:	fff7c703          	lbu	a4,-1(a5)
 136:	ff65                	bnez	a4,12e <strlen+0x10>
 138:	40a6853b          	subw	a0,a3,a0
 13c:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 13e:	6422                	ld	s0,8(sp)
 140:	0141                	addi	sp,sp,16
 142:	8082                	ret
  for(n = 0; s[n]; n++)
 144:	4501                	li	a0,0
 146:	bfe5                	j	13e <strlen+0x20>

0000000000000148 <memset>:

void*
memset(void *dst, int c, uint n)
{
 148:	1141                	addi	sp,sp,-16
 14a:	e422                	sd	s0,8(sp)
 14c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 14e:	ca19                	beqz	a2,164 <memset+0x1c>
 150:	87aa                	mv	a5,a0
 152:	1602                	slli	a2,a2,0x20
 154:	9201                	srli	a2,a2,0x20
 156:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 15a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 15e:	0785                	addi	a5,a5,1
 160:	fee79de3          	bne	a5,a4,15a <memset+0x12>
  }
  return dst;
}
 164:	6422                	ld	s0,8(sp)
 166:	0141                	addi	sp,sp,16
 168:	8082                	ret

000000000000016a <strchr>:

char*
strchr(const char *s, char c)
{
 16a:	1141                	addi	sp,sp,-16
 16c:	e422                	sd	s0,8(sp)
 16e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 170:	00054783          	lbu	a5,0(a0)
 174:	cb99                	beqz	a5,18a <strchr+0x20>
    if(*s == c)
 176:	00f58763          	beq	a1,a5,184 <strchr+0x1a>
  for(; *s; s++)
 17a:	0505                	addi	a0,a0,1
 17c:	00054783          	lbu	a5,0(a0)
 180:	fbfd                	bnez	a5,176 <strchr+0xc>
      return (char*)s;
  return 0;
 182:	4501                	li	a0,0
}
 184:	6422                	ld	s0,8(sp)
 186:	0141                	addi	sp,sp,16
 188:	8082                	ret
  return 0;
 18a:	4501                	li	a0,0
 18c:	bfe5                	j	184 <strchr+0x1a>

000000000000018e <gets>:

char*
gets(char *buf, int max)
{
 18e:	711d                	addi	sp,sp,-96
 190:	ec86                	sd	ra,88(sp)
 192:	e8a2                	sd	s0,80(sp)
 194:	e4a6                	sd	s1,72(sp)
 196:	e0ca                	sd	s2,64(sp)
 198:	fc4e                	sd	s3,56(sp)
 19a:	f852                	sd	s4,48(sp)
 19c:	f456                	sd	s5,40(sp)
 19e:	f05a                	sd	s6,32(sp)
 1a0:	ec5e                	sd	s7,24(sp)
 1a2:	1080                	addi	s0,sp,96
 1a4:	8baa                	mv	s7,a0
 1a6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a8:	892a                	mv	s2,a0
 1aa:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1ac:	4aa9                	li	s5,10
 1ae:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1b0:	89a6                	mv	s3,s1
 1b2:	2485                	addiw	s1,s1,1
 1b4:	0344d663          	bge	s1,s4,1e0 <gets+0x52>
    cc = read(0, &c, 1);
 1b8:	4605                	li	a2,1
 1ba:	faf40593          	addi	a1,s0,-81
 1be:	4501                	li	a0,0
 1c0:	1b2000ef          	jal	372 <read>
    if(cc < 1)
 1c4:	00a05e63          	blez	a0,1e0 <gets+0x52>
    buf[i++] = c;
 1c8:	faf44783          	lbu	a5,-81(s0)
 1cc:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1d0:	01578763          	beq	a5,s5,1de <gets+0x50>
 1d4:	0905                	addi	s2,s2,1
 1d6:	fd679de3          	bne	a5,s6,1b0 <gets+0x22>
    buf[i++] = c;
 1da:	89a6                	mv	s3,s1
 1dc:	a011                	j	1e0 <gets+0x52>
 1de:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1e0:	99de                	add	s3,s3,s7
 1e2:	00098023          	sb	zero,0(s3)
  return buf;
}
 1e6:	855e                	mv	a0,s7
 1e8:	60e6                	ld	ra,88(sp)
 1ea:	6446                	ld	s0,80(sp)
 1ec:	64a6                	ld	s1,72(sp)
 1ee:	6906                	ld	s2,64(sp)
 1f0:	79e2                	ld	s3,56(sp)
 1f2:	7a42                	ld	s4,48(sp)
 1f4:	7aa2                	ld	s5,40(sp)
 1f6:	7b02                	ld	s6,32(sp)
 1f8:	6be2                	ld	s7,24(sp)
 1fa:	6125                	addi	sp,sp,96
 1fc:	8082                	ret

00000000000001fe <stat>:

int
stat(const char *n, struct stat *st)
{
 1fe:	1101                	addi	sp,sp,-32
 200:	ec06                	sd	ra,24(sp)
 202:	e822                	sd	s0,16(sp)
 204:	e04a                	sd	s2,0(sp)
 206:	1000                	addi	s0,sp,32
 208:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 20a:	4581                	li	a1,0
 20c:	18e000ef          	jal	39a <open>
  if(fd < 0)
 210:	02054263          	bltz	a0,234 <stat+0x36>
 214:	e426                	sd	s1,8(sp)
 216:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 218:	85ca                	mv	a1,s2
 21a:	198000ef          	jal	3b2 <fstat>
 21e:	892a                	mv	s2,a0
  close(fd);
 220:	8526                	mv	a0,s1
 222:	160000ef          	jal	382 <close>
  return r;
 226:	64a2                	ld	s1,8(sp)
}
 228:	854a                	mv	a0,s2
 22a:	60e2                	ld	ra,24(sp)
 22c:	6442                	ld	s0,16(sp)
 22e:	6902                	ld	s2,0(sp)
 230:	6105                	addi	sp,sp,32
 232:	8082                	ret
    return -1;
 234:	597d                	li	s2,-1
 236:	bfcd                	j	228 <stat+0x2a>

0000000000000238 <atoi>:

int
atoi(const char *s)
{
 238:	1141                	addi	sp,sp,-16
 23a:	e422                	sd	s0,8(sp)
 23c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 23e:	00054683          	lbu	a3,0(a0)
 242:	fd06879b          	addiw	a5,a3,-48
 246:	0ff7f793          	zext.b	a5,a5
 24a:	4625                	li	a2,9
 24c:	02f66863          	bltu	a2,a5,27c <atoi+0x44>
 250:	872a                	mv	a4,a0
  n = 0;
 252:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 254:	0705                	addi	a4,a4,1 # 1001 <freep+0x1>
 256:	0025179b          	slliw	a5,a0,0x2
 25a:	9fa9                	addw	a5,a5,a0
 25c:	0017979b          	slliw	a5,a5,0x1
 260:	9fb5                	addw	a5,a5,a3
 262:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 266:	00074683          	lbu	a3,0(a4)
 26a:	fd06879b          	addiw	a5,a3,-48
 26e:	0ff7f793          	zext.b	a5,a5
 272:	fef671e3          	bgeu	a2,a5,254 <atoi+0x1c>
  return n;
}
 276:	6422                	ld	s0,8(sp)
 278:	0141                	addi	sp,sp,16
 27a:	8082                	ret
  n = 0;
 27c:	4501                	li	a0,0
 27e:	bfe5                	j	276 <atoi+0x3e>

0000000000000280 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 280:	1141                	addi	sp,sp,-16
 282:	e422                	sd	s0,8(sp)
 284:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 286:	02b57463          	bgeu	a0,a1,2ae <memmove+0x2e>
    while(n-- > 0)
 28a:	00c05f63          	blez	a2,2a8 <memmove+0x28>
 28e:	1602                	slli	a2,a2,0x20
 290:	9201                	srli	a2,a2,0x20
 292:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 296:	872a                	mv	a4,a0
      *dst++ = *src++;
 298:	0585                	addi	a1,a1,1
 29a:	0705                	addi	a4,a4,1
 29c:	fff5c683          	lbu	a3,-1(a1)
 2a0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2a4:	fef71ae3          	bne	a4,a5,298 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2a8:	6422                	ld	s0,8(sp)
 2aa:	0141                	addi	sp,sp,16
 2ac:	8082                	ret
    dst += n;
 2ae:	00c50733          	add	a4,a0,a2
    src += n;
 2b2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2b4:	fec05ae3          	blez	a2,2a8 <memmove+0x28>
 2b8:	fff6079b          	addiw	a5,a2,-1
 2bc:	1782                	slli	a5,a5,0x20
 2be:	9381                	srli	a5,a5,0x20
 2c0:	fff7c793          	not	a5,a5
 2c4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2c6:	15fd                	addi	a1,a1,-1
 2c8:	177d                	addi	a4,a4,-1
 2ca:	0005c683          	lbu	a3,0(a1)
 2ce:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2d2:	fee79ae3          	bne	a5,a4,2c6 <memmove+0x46>
 2d6:	bfc9                	j	2a8 <memmove+0x28>

00000000000002d8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2d8:	1141                	addi	sp,sp,-16
 2da:	e422                	sd	s0,8(sp)
 2dc:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2de:	ca05                	beqz	a2,30e <memcmp+0x36>
 2e0:	fff6069b          	addiw	a3,a2,-1
 2e4:	1682                	slli	a3,a3,0x20
 2e6:	9281                	srli	a3,a3,0x20
 2e8:	0685                	addi	a3,a3,1
 2ea:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2ec:	00054783          	lbu	a5,0(a0)
 2f0:	0005c703          	lbu	a4,0(a1)
 2f4:	00e79863          	bne	a5,a4,304 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2f8:	0505                	addi	a0,a0,1
    p2++;
 2fa:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2fc:	fed518e3          	bne	a0,a3,2ec <memcmp+0x14>
  }
  return 0;
 300:	4501                	li	a0,0
 302:	a019                	j	308 <memcmp+0x30>
      return *p1 - *p2;
 304:	40e7853b          	subw	a0,a5,a4
}
 308:	6422                	ld	s0,8(sp)
 30a:	0141                	addi	sp,sp,16
 30c:	8082                	ret
  return 0;
 30e:	4501                	li	a0,0
 310:	bfe5                	j	308 <memcmp+0x30>

0000000000000312 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 312:	1141                	addi	sp,sp,-16
 314:	e406                	sd	ra,8(sp)
 316:	e022                	sd	s0,0(sp)
 318:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 31a:	f67ff0ef          	jal	280 <memmove>
}
 31e:	60a2                	ld	ra,8(sp)
 320:	6402                	ld	s0,0(sp)
 322:	0141                	addi	sp,sp,16
 324:	8082                	ret

0000000000000326 <sbrk>:

char *
sbrk(int n) {
 326:	1141                	addi	sp,sp,-16
 328:	e406                	sd	ra,8(sp)
 32a:	e022                	sd	s0,0(sp)
 32c:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 32e:	4585                	li	a1,1
 330:	0b2000ef          	jal	3e2 <sys_sbrk>
}
 334:	60a2                	ld	ra,8(sp)
 336:	6402                	ld	s0,0(sp)
 338:	0141                	addi	sp,sp,16
 33a:	8082                	ret

000000000000033c <sbrklazy>:

char *
sbrklazy(int n) {
 33c:	1141                	addi	sp,sp,-16
 33e:	e406                	sd	ra,8(sp)
 340:	e022                	sd	s0,0(sp)
 342:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 344:	4589                	li	a1,2
 346:	09c000ef          	jal	3e2 <sys_sbrk>
}
 34a:	60a2                	ld	ra,8(sp)
 34c:	6402                	ld	s0,0(sp)
 34e:	0141                	addi	sp,sp,16
 350:	8082                	ret

0000000000000352 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 352:	4885                	li	a7,1
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <exit>:
.global exit
exit:
 li a7, SYS_exit
 35a:	4889                	li	a7,2
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <wait>:
.global wait
wait:
 li a7, SYS_wait
 362:	488d                	li	a7,3
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 36a:	4891                	li	a7,4
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <read>:
.global read
read:
 li a7, SYS_read
 372:	4895                	li	a7,5
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <write>:
.global write
write:
 li a7, SYS_write
 37a:	48c1                	li	a7,16
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <close>:
.global close
close:
 li a7, SYS_close
 382:	48d5                	li	a7,21
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <kill>:
.global kill
kill:
 li a7, SYS_kill
 38a:	4899                	li	a7,6
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <exec>:
.global exec
exec:
 li a7, SYS_exec
 392:	489d                	li	a7,7
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <open>:
.global open
open:
 li a7, SYS_open
 39a:	48bd                	li	a7,15
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3a2:	48c5                	li	a7,17
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3aa:	48c9                	li	a7,18
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3b2:	48a1                	li	a7,8
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <link>:
.global link
link:
 li a7, SYS_link
 3ba:	48cd                	li	a7,19
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3c2:	48d1                	li	a7,20
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3ca:	48a5                	li	a7,9
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3d2:	48a9                	li	a7,10
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3da:	48ad                	li	a7,11
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 3e2:	48b1                	li	a7,12
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <pause>:
.global pause
pause:
 li a7, SYS_pause
 3ea:	48b5                	li	a7,13
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3f2:	48b9                	li	a7,14
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3fa:	1101                	addi	sp,sp,-32
 3fc:	ec06                	sd	ra,24(sp)
 3fe:	e822                	sd	s0,16(sp)
 400:	1000                	addi	s0,sp,32
 402:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 406:	4605                	li	a2,1
 408:	fef40593          	addi	a1,s0,-17
 40c:	f6fff0ef          	jal	37a <write>
}
 410:	60e2                	ld	ra,24(sp)
 412:	6442                	ld	s0,16(sp)
 414:	6105                	addi	sp,sp,32
 416:	8082                	ret

0000000000000418 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 418:	715d                	addi	sp,sp,-80
 41a:	e486                	sd	ra,72(sp)
 41c:	e0a2                	sd	s0,64(sp)
 41e:	f84a                	sd	s2,48(sp)
 420:	0880                	addi	s0,sp,80
 422:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 424:	c299                	beqz	a3,42a <printint+0x12>
 426:	0805c363          	bltz	a1,4ac <printint+0x94>
  neg = 0;
 42a:	4881                	li	a7,0
 42c:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 430:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 432:	00000517          	auipc	a0,0x0
 436:	59650513          	addi	a0,a0,1430 # 9c8 <digits>
 43a:	883e                	mv	a6,a5
 43c:	2785                	addiw	a5,a5,1
 43e:	02c5f733          	remu	a4,a1,a2
 442:	972a                	add	a4,a4,a0
 444:	00074703          	lbu	a4,0(a4)
 448:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 44c:	872e                	mv	a4,a1
 44e:	02c5d5b3          	divu	a1,a1,a2
 452:	0685                	addi	a3,a3,1
 454:	fec773e3          	bgeu	a4,a2,43a <printint+0x22>
  if(neg)
 458:	00088b63          	beqz	a7,46e <printint+0x56>
    buf[i++] = '-';
 45c:	fd078793          	addi	a5,a5,-48
 460:	97a2                	add	a5,a5,s0
 462:	02d00713          	li	a4,45
 466:	fee78423          	sb	a4,-24(a5)
 46a:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 46e:	02f05a63          	blez	a5,4a2 <printint+0x8a>
 472:	fc26                	sd	s1,56(sp)
 474:	f44e                	sd	s3,40(sp)
 476:	fb840713          	addi	a4,s0,-72
 47a:	00f704b3          	add	s1,a4,a5
 47e:	fff70993          	addi	s3,a4,-1
 482:	99be                	add	s3,s3,a5
 484:	37fd                	addiw	a5,a5,-1
 486:	1782                	slli	a5,a5,0x20
 488:	9381                	srli	a5,a5,0x20
 48a:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 48e:	fff4c583          	lbu	a1,-1(s1)
 492:	854a                	mv	a0,s2
 494:	f67ff0ef          	jal	3fa <putc>
  while(--i >= 0)
 498:	14fd                	addi	s1,s1,-1
 49a:	ff349ae3          	bne	s1,s3,48e <printint+0x76>
 49e:	74e2                	ld	s1,56(sp)
 4a0:	79a2                	ld	s3,40(sp)
}
 4a2:	60a6                	ld	ra,72(sp)
 4a4:	6406                	ld	s0,64(sp)
 4a6:	7942                	ld	s2,48(sp)
 4a8:	6161                	addi	sp,sp,80
 4aa:	8082                	ret
    x = -xx;
 4ac:	40b005b3          	neg	a1,a1
    neg = 1;
 4b0:	4885                	li	a7,1
    x = -xx;
 4b2:	bfad                	j	42c <printint+0x14>

00000000000004b4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4b4:	711d                	addi	sp,sp,-96
 4b6:	ec86                	sd	ra,88(sp)
 4b8:	e8a2                	sd	s0,80(sp)
 4ba:	e0ca                	sd	s2,64(sp)
 4bc:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4be:	0005c903          	lbu	s2,0(a1)
 4c2:	28090663          	beqz	s2,74e <vprintf+0x29a>
 4c6:	e4a6                	sd	s1,72(sp)
 4c8:	fc4e                	sd	s3,56(sp)
 4ca:	f852                	sd	s4,48(sp)
 4cc:	f456                	sd	s5,40(sp)
 4ce:	f05a                	sd	s6,32(sp)
 4d0:	ec5e                	sd	s7,24(sp)
 4d2:	e862                	sd	s8,16(sp)
 4d4:	e466                	sd	s9,8(sp)
 4d6:	8b2a                	mv	s6,a0
 4d8:	8a2e                	mv	s4,a1
 4da:	8bb2                	mv	s7,a2
  state = 0;
 4dc:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 4de:	4481                	li	s1,0
 4e0:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 4e2:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 4e6:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 4ea:	06c00c93          	li	s9,108
 4ee:	a005                	j	50e <vprintf+0x5a>
        putc(fd, c0);
 4f0:	85ca                	mv	a1,s2
 4f2:	855a                	mv	a0,s6
 4f4:	f07ff0ef          	jal	3fa <putc>
 4f8:	a019                	j	4fe <vprintf+0x4a>
    } else if(state == '%'){
 4fa:	03598263          	beq	s3,s5,51e <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 4fe:	2485                	addiw	s1,s1,1
 500:	8726                	mv	a4,s1
 502:	009a07b3          	add	a5,s4,s1
 506:	0007c903          	lbu	s2,0(a5)
 50a:	22090a63          	beqz	s2,73e <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 50e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 512:	fe0994e3          	bnez	s3,4fa <vprintf+0x46>
      if(c0 == '%'){
 516:	fd579de3          	bne	a5,s5,4f0 <vprintf+0x3c>
        state = '%';
 51a:	89be                	mv	s3,a5
 51c:	b7cd                	j	4fe <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 51e:	00ea06b3          	add	a3,s4,a4
 522:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 526:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 528:	c681                	beqz	a3,530 <vprintf+0x7c>
 52a:	9752                	add	a4,a4,s4
 52c:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 530:	05878363          	beq	a5,s8,576 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 534:	05978d63          	beq	a5,s9,58e <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 538:	07500713          	li	a4,117
 53c:	0ee78763          	beq	a5,a4,62a <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 540:	07800713          	li	a4,120
 544:	12e78963          	beq	a5,a4,676 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 548:	07000713          	li	a4,112
 54c:	14e78e63          	beq	a5,a4,6a8 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 550:	06300713          	li	a4,99
 554:	18e78e63          	beq	a5,a4,6f0 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 558:	07300713          	li	a4,115
 55c:	1ae78463          	beq	a5,a4,704 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 560:	02500713          	li	a4,37
 564:	04e79563          	bne	a5,a4,5ae <vprintf+0xfa>
        putc(fd, '%');
 568:	02500593          	li	a1,37
 56c:	855a                	mv	a0,s6
 56e:	e8dff0ef          	jal	3fa <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 572:	4981                	li	s3,0
 574:	b769                	j	4fe <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 576:	008b8913          	addi	s2,s7,8
 57a:	4685                	li	a3,1
 57c:	4629                	li	a2,10
 57e:	000ba583          	lw	a1,0(s7)
 582:	855a                	mv	a0,s6
 584:	e95ff0ef          	jal	418 <printint>
 588:	8bca                	mv	s7,s2
      state = 0;
 58a:	4981                	li	s3,0
 58c:	bf8d                	j	4fe <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 58e:	06400793          	li	a5,100
 592:	02f68963          	beq	a3,a5,5c4 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 596:	06c00793          	li	a5,108
 59a:	04f68263          	beq	a3,a5,5de <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 59e:	07500793          	li	a5,117
 5a2:	0af68063          	beq	a3,a5,642 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 5a6:	07800793          	li	a5,120
 5aa:	0ef68263          	beq	a3,a5,68e <vprintf+0x1da>
        putc(fd, '%');
 5ae:	02500593          	li	a1,37
 5b2:	855a                	mv	a0,s6
 5b4:	e47ff0ef          	jal	3fa <putc>
        putc(fd, c0);
 5b8:	85ca                	mv	a1,s2
 5ba:	855a                	mv	a0,s6
 5bc:	e3fff0ef          	jal	3fa <putc>
      state = 0;
 5c0:	4981                	li	s3,0
 5c2:	bf35                	j	4fe <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5c4:	008b8913          	addi	s2,s7,8
 5c8:	4685                	li	a3,1
 5ca:	4629                	li	a2,10
 5cc:	000bb583          	ld	a1,0(s7)
 5d0:	855a                	mv	a0,s6
 5d2:	e47ff0ef          	jal	418 <printint>
        i += 1;
 5d6:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 5d8:	8bca                	mv	s7,s2
      state = 0;
 5da:	4981                	li	s3,0
        i += 1;
 5dc:	b70d                	j	4fe <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5de:	06400793          	li	a5,100
 5e2:	02f60763          	beq	a2,a5,610 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 5e6:	07500793          	li	a5,117
 5ea:	06f60963          	beq	a2,a5,65c <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 5ee:	07800793          	li	a5,120
 5f2:	faf61ee3          	bne	a2,a5,5ae <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 5f6:	008b8913          	addi	s2,s7,8
 5fa:	4681                	li	a3,0
 5fc:	4641                	li	a2,16
 5fe:	000bb583          	ld	a1,0(s7)
 602:	855a                	mv	a0,s6
 604:	e15ff0ef          	jal	418 <printint>
        i += 2;
 608:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 60a:	8bca                	mv	s7,s2
      state = 0;
 60c:	4981                	li	s3,0
        i += 2;
 60e:	bdc5                	j	4fe <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 610:	008b8913          	addi	s2,s7,8
 614:	4685                	li	a3,1
 616:	4629                	li	a2,10
 618:	000bb583          	ld	a1,0(s7)
 61c:	855a                	mv	a0,s6
 61e:	dfbff0ef          	jal	418 <printint>
        i += 2;
 622:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 624:	8bca                	mv	s7,s2
      state = 0;
 626:	4981                	li	s3,0
        i += 2;
 628:	bdd9                	j	4fe <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 62a:	008b8913          	addi	s2,s7,8
 62e:	4681                	li	a3,0
 630:	4629                	li	a2,10
 632:	000be583          	lwu	a1,0(s7)
 636:	855a                	mv	a0,s6
 638:	de1ff0ef          	jal	418 <printint>
 63c:	8bca                	mv	s7,s2
      state = 0;
 63e:	4981                	li	s3,0
 640:	bd7d                	j	4fe <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 642:	008b8913          	addi	s2,s7,8
 646:	4681                	li	a3,0
 648:	4629                	li	a2,10
 64a:	000bb583          	ld	a1,0(s7)
 64e:	855a                	mv	a0,s6
 650:	dc9ff0ef          	jal	418 <printint>
        i += 1;
 654:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 656:	8bca                	mv	s7,s2
      state = 0;
 658:	4981                	li	s3,0
        i += 1;
 65a:	b555                	j	4fe <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 65c:	008b8913          	addi	s2,s7,8
 660:	4681                	li	a3,0
 662:	4629                	li	a2,10
 664:	000bb583          	ld	a1,0(s7)
 668:	855a                	mv	a0,s6
 66a:	dafff0ef          	jal	418 <printint>
        i += 2;
 66e:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 670:	8bca                	mv	s7,s2
      state = 0;
 672:	4981                	li	s3,0
        i += 2;
 674:	b569                	j	4fe <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 676:	008b8913          	addi	s2,s7,8
 67a:	4681                	li	a3,0
 67c:	4641                	li	a2,16
 67e:	000be583          	lwu	a1,0(s7)
 682:	855a                	mv	a0,s6
 684:	d95ff0ef          	jal	418 <printint>
 688:	8bca                	mv	s7,s2
      state = 0;
 68a:	4981                	li	s3,0
 68c:	bd8d                	j	4fe <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 68e:	008b8913          	addi	s2,s7,8
 692:	4681                	li	a3,0
 694:	4641                	li	a2,16
 696:	000bb583          	ld	a1,0(s7)
 69a:	855a                	mv	a0,s6
 69c:	d7dff0ef          	jal	418 <printint>
        i += 1;
 6a0:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 6a2:	8bca                	mv	s7,s2
      state = 0;
 6a4:	4981                	li	s3,0
        i += 1;
 6a6:	bda1                	j	4fe <vprintf+0x4a>
 6a8:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 6aa:	008b8d13          	addi	s10,s7,8
 6ae:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6b2:	03000593          	li	a1,48
 6b6:	855a                	mv	a0,s6
 6b8:	d43ff0ef          	jal	3fa <putc>
  putc(fd, 'x');
 6bc:	07800593          	li	a1,120
 6c0:	855a                	mv	a0,s6
 6c2:	d39ff0ef          	jal	3fa <putc>
 6c6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6c8:	00000b97          	auipc	s7,0x0
 6cc:	300b8b93          	addi	s7,s7,768 # 9c8 <digits>
 6d0:	03c9d793          	srli	a5,s3,0x3c
 6d4:	97de                	add	a5,a5,s7
 6d6:	0007c583          	lbu	a1,0(a5)
 6da:	855a                	mv	a0,s6
 6dc:	d1fff0ef          	jal	3fa <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6e0:	0992                	slli	s3,s3,0x4
 6e2:	397d                	addiw	s2,s2,-1
 6e4:	fe0916e3          	bnez	s2,6d0 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 6e8:	8bea                	mv	s7,s10
      state = 0;
 6ea:	4981                	li	s3,0
 6ec:	6d02                	ld	s10,0(sp)
 6ee:	bd01                	j	4fe <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 6f0:	008b8913          	addi	s2,s7,8
 6f4:	000bc583          	lbu	a1,0(s7)
 6f8:	855a                	mv	a0,s6
 6fa:	d01ff0ef          	jal	3fa <putc>
 6fe:	8bca                	mv	s7,s2
      state = 0;
 700:	4981                	li	s3,0
 702:	bbf5                	j	4fe <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 704:	008b8993          	addi	s3,s7,8
 708:	000bb903          	ld	s2,0(s7)
 70c:	00090f63          	beqz	s2,72a <vprintf+0x276>
        for(; *s; s++)
 710:	00094583          	lbu	a1,0(s2)
 714:	c195                	beqz	a1,738 <vprintf+0x284>
          putc(fd, *s);
 716:	855a                	mv	a0,s6
 718:	ce3ff0ef          	jal	3fa <putc>
        for(; *s; s++)
 71c:	0905                	addi	s2,s2,1
 71e:	00094583          	lbu	a1,0(s2)
 722:	f9f5                	bnez	a1,716 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 724:	8bce                	mv	s7,s3
      state = 0;
 726:	4981                	li	s3,0
 728:	bbd9                	j	4fe <vprintf+0x4a>
          s = "(null)";
 72a:	00000917          	auipc	s2,0x0
 72e:	29690913          	addi	s2,s2,662 # 9c0 <malloc+0x18a>
        for(; *s; s++)
 732:	02800593          	li	a1,40
 736:	b7c5                	j	716 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 738:	8bce                	mv	s7,s3
      state = 0;
 73a:	4981                	li	s3,0
 73c:	b3c9                	j	4fe <vprintf+0x4a>
 73e:	64a6                	ld	s1,72(sp)
 740:	79e2                	ld	s3,56(sp)
 742:	7a42                	ld	s4,48(sp)
 744:	7aa2                	ld	s5,40(sp)
 746:	7b02                	ld	s6,32(sp)
 748:	6be2                	ld	s7,24(sp)
 74a:	6c42                	ld	s8,16(sp)
 74c:	6ca2                	ld	s9,8(sp)
    }
  }
}
 74e:	60e6                	ld	ra,88(sp)
 750:	6446                	ld	s0,80(sp)
 752:	6906                	ld	s2,64(sp)
 754:	6125                	addi	sp,sp,96
 756:	8082                	ret

0000000000000758 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 758:	715d                	addi	sp,sp,-80
 75a:	ec06                	sd	ra,24(sp)
 75c:	e822                	sd	s0,16(sp)
 75e:	1000                	addi	s0,sp,32
 760:	e010                	sd	a2,0(s0)
 762:	e414                	sd	a3,8(s0)
 764:	e818                	sd	a4,16(s0)
 766:	ec1c                	sd	a5,24(s0)
 768:	03043023          	sd	a6,32(s0)
 76c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 770:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 774:	8622                	mv	a2,s0
 776:	d3fff0ef          	jal	4b4 <vprintf>
}
 77a:	60e2                	ld	ra,24(sp)
 77c:	6442                	ld	s0,16(sp)
 77e:	6161                	addi	sp,sp,80
 780:	8082                	ret

0000000000000782 <printf>:

void
printf(const char *fmt, ...)
{
 782:	711d                	addi	sp,sp,-96
 784:	ec06                	sd	ra,24(sp)
 786:	e822                	sd	s0,16(sp)
 788:	1000                	addi	s0,sp,32
 78a:	e40c                	sd	a1,8(s0)
 78c:	e810                	sd	a2,16(s0)
 78e:	ec14                	sd	a3,24(s0)
 790:	f018                	sd	a4,32(s0)
 792:	f41c                	sd	a5,40(s0)
 794:	03043823          	sd	a6,48(s0)
 798:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 79c:	00840613          	addi	a2,s0,8
 7a0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7a4:	85aa                	mv	a1,a0
 7a6:	4505                	li	a0,1
 7a8:	d0dff0ef          	jal	4b4 <vprintf>
}
 7ac:	60e2                	ld	ra,24(sp)
 7ae:	6442                	ld	s0,16(sp)
 7b0:	6125                	addi	sp,sp,96
 7b2:	8082                	ret

00000000000007b4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7b4:	1141                	addi	sp,sp,-16
 7b6:	e422                	sd	s0,8(sp)
 7b8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7ba:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7be:	00001797          	auipc	a5,0x1
 7c2:	8427b783          	ld	a5,-1982(a5) # 1000 <freep>
 7c6:	a02d                	j	7f0 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7c8:	4618                	lw	a4,8(a2)
 7ca:	9f2d                	addw	a4,a4,a1
 7cc:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7d0:	6398                	ld	a4,0(a5)
 7d2:	6310                	ld	a2,0(a4)
 7d4:	a83d                	j	812 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7d6:	ff852703          	lw	a4,-8(a0)
 7da:	9f31                	addw	a4,a4,a2
 7dc:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7de:	ff053683          	ld	a3,-16(a0)
 7e2:	a091                	j	826 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7e4:	6398                	ld	a4,0(a5)
 7e6:	00e7e463          	bltu	a5,a4,7ee <free+0x3a>
 7ea:	00e6ea63          	bltu	a3,a4,7fe <free+0x4a>
{
 7ee:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f0:	fed7fae3          	bgeu	a5,a3,7e4 <free+0x30>
 7f4:	6398                	ld	a4,0(a5)
 7f6:	00e6e463          	bltu	a3,a4,7fe <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7fa:	fee7eae3          	bltu	a5,a4,7ee <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 7fe:	ff852583          	lw	a1,-8(a0)
 802:	6390                	ld	a2,0(a5)
 804:	02059813          	slli	a6,a1,0x20
 808:	01c85713          	srli	a4,a6,0x1c
 80c:	9736                	add	a4,a4,a3
 80e:	fae60de3          	beq	a2,a4,7c8 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 812:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 816:	4790                	lw	a2,8(a5)
 818:	02061593          	slli	a1,a2,0x20
 81c:	01c5d713          	srli	a4,a1,0x1c
 820:	973e                	add	a4,a4,a5
 822:	fae68ae3          	beq	a3,a4,7d6 <free+0x22>
    p->s.ptr = bp->s.ptr;
 826:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 828:	00000717          	auipc	a4,0x0
 82c:	7cf73c23          	sd	a5,2008(a4) # 1000 <freep>
}
 830:	6422                	ld	s0,8(sp)
 832:	0141                	addi	sp,sp,16
 834:	8082                	ret

0000000000000836 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 836:	7139                	addi	sp,sp,-64
 838:	fc06                	sd	ra,56(sp)
 83a:	f822                	sd	s0,48(sp)
 83c:	f426                	sd	s1,40(sp)
 83e:	ec4e                	sd	s3,24(sp)
 840:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 842:	02051493          	slli	s1,a0,0x20
 846:	9081                	srli	s1,s1,0x20
 848:	04bd                	addi	s1,s1,15
 84a:	8091                	srli	s1,s1,0x4
 84c:	0014899b          	addiw	s3,s1,1
 850:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 852:	00000517          	auipc	a0,0x0
 856:	7ae53503          	ld	a0,1966(a0) # 1000 <freep>
 85a:	c915                	beqz	a0,88e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 85c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 85e:	4798                	lw	a4,8(a5)
 860:	08977a63          	bgeu	a4,s1,8f4 <malloc+0xbe>
 864:	f04a                	sd	s2,32(sp)
 866:	e852                	sd	s4,16(sp)
 868:	e456                	sd	s5,8(sp)
 86a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 86c:	8a4e                	mv	s4,s3
 86e:	0009871b          	sext.w	a4,s3
 872:	6685                	lui	a3,0x1
 874:	00d77363          	bgeu	a4,a3,87a <malloc+0x44>
 878:	6a05                	lui	s4,0x1
 87a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 87e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 882:	00000917          	auipc	s2,0x0
 886:	77e90913          	addi	s2,s2,1918 # 1000 <freep>
  if(p == SBRK_ERROR)
 88a:	5afd                	li	s5,-1
 88c:	a081                	j	8cc <malloc+0x96>
 88e:	f04a                	sd	s2,32(sp)
 890:	e852                	sd	s4,16(sp)
 892:	e456                	sd	s5,8(sp)
 894:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 896:	00000797          	auipc	a5,0x0
 89a:	77a78793          	addi	a5,a5,1914 # 1010 <base>
 89e:	00000717          	auipc	a4,0x0
 8a2:	76f73123          	sd	a5,1890(a4) # 1000 <freep>
 8a6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8a8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8ac:	b7c1                	j	86c <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 8ae:	6398                	ld	a4,0(a5)
 8b0:	e118                	sd	a4,0(a0)
 8b2:	a8a9                	j	90c <malloc+0xd6>
  hp->s.size = nu;
 8b4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8b8:	0541                	addi	a0,a0,16
 8ba:	efbff0ef          	jal	7b4 <free>
  return freep;
 8be:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8c2:	c12d                	beqz	a0,924 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8c6:	4798                	lw	a4,8(a5)
 8c8:	02977263          	bgeu	a4,s1,8ec <malloc+0xb6>
    if(p == freep)
 8cc:	00093703          	ld	a4,0(s2)
 8d0:	853e                	mv	a0,a5
 8d2:	fef719e3          	bne	a4,a5,8c4 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 8d6:	8552                	mv	a0,s4
 8d8:	a4fff0ef          	jal	326 <sbrk>
  if(p == SBRK_ERROR)
 8dc:	fd551ce3          	bne	a0,s5,8b4 <malloc+0x7e>
        return 0;
 8e0:	4501                	li	a0,0
 8e2:	7902                	ld	s2,32(sp)
 8e4:	6a42                	ld	s4,16(sp)
 8e6:	6aa2                	ld	s5,8(sp)
 8e8:	6b02                	ld	s6,0(sp)
 8ea:	a03d                	j	918 <malloc+0xe2>
 8ec:	7902                	ld	s2,32(sp)
 8ee:	6a42                	ld	s4,16(sp)
 8f0:	6aa2                	ld	s5,8(sp)
 8f2:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 8f4:	fae48de3          	beq	s1,a4,8ae <malloc+0x78>
        p->s.size -= nunits;
 8f8:	4137073b          	subw	a4,a4,s3
 8fc:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8fe:	02071693          	slli	a3,a4,0x20
 902:	01c6d713          	srli	a4,a3,0x1c
 906:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 908:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 90c:	00000717          	auipc	a4,0x0
 910:	6ea73a23          	sd	a0,1780(a4) # 1000 <freep>
      return (void*)(p + 1);
 914:	01078513          	addi	a0,a5,16
  }
}
 918:	70e2                	ld	ra,56(sp)
 91a:	7442                	ld	s0,48(sp)
 91c:	74a2                	ld	s1,40(sp)
 91e:	69e2                	ld	s3,24(sp)
 920:	6121                	addi	sp,sp,64
 922:	8082                	ret
 924:	7902                	ld	s2,32(sp)
 926:	6a42                	ld	s4,16(sp)
 928:	6aa2                	ld	s5,8(sp)
 92a:	6b02                	ld	s6,0(sp)
 92c:	b7f5                	j	918 <malloc+0xe2>
