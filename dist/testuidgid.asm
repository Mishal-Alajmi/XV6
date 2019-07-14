
_testuidgid:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "Done!\n");
  return 0;
}

int
main() {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  uint uid = getuid();
   f:	e8 8d 06 00 00       	call   6a1 <getuid>
  printf(1, "Current UID is: %d\n", uid);
  14:	83 ec 04             	sub    $0x4,%esp
  17:	50                   	push   %eax
  18:	68 18 0b 00 00       	push   $0xb18
  1d:	6a 01                	push   $0x1
  1f:	e8 8c 07 00 00       	call   7b0 <printf>
  printf(1, "Setting UID to %d\n", nval);
  24:	83 c4 0c             	add    $0xc,%esp
  27:	6a 64                	push   $0x64
  29:	68 2c 0b 00 00       	push   $0xb2c
  2e:	6a 01                	push   $0x1
  30:	e8 7b 07 00 00       	call   7b0 <printf>
  if (setuid(nval) < 0)
  35:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
  3c:	e8 68 06 00 00       	call   6a9 <setuid>
  41:	83 c4 10             	add    $0x10,%esp
  44:	85 c0                	test   %eax,%eax
  46:	0f 88 5d 02 00 00    	js     2a9 <main+0x2a9>
  uid = getuid();
  4c:	e8 50 06 00 00       	call   6a1 <getuid>
  printf(1, "Current UID is: %d\n", uid);
  51:	83 ec 04             	sub    $0x4,%esp
  54:	50                   	push   %eax
  55:	68 18 0b 00 00       	push   $0xb18
  5a:	6a 01                	push   $0x1
  5c:	e8 4f 07 00 00       	call   7b0 <printf>
  sleep(5 * TPS);  // now type control-p
  61:	c7 04 24 88 13 00 00 	movl   $0x1388,(%esp)
  68:	e8 04 06 00 00       	call   671 <sleep>
  uint gid = getgid();
  6d:	e8 1f 06 00 00       	call   691 <getgid>
  printf(1, "Current GID is: %d\n", gid);
  72:	83 c4 0c             	add    $0xc,%esp
  75:	50                   	push   %eax
  76:	68 57 0b 00 00       	push   $0xb57
  7b:	6a 01                	push   $0x1
  7d:	e8 2e 07 00 00       	call   7b0 <printf>
  printf(1, "Setting GID to %d\n", nval);
  82:	83 c4 0c             	add    $0xc,%esp
  85:	68 c8 00 00 00       	push   $0xc8
  8a:	68 6b 0b 00 00       	push   $0xb6b
  8f:	6a 01                	push   $0x1
  91:	e8 1a 07 00 00       	call   7b0 <printf>
  if (setgid(nval) < 0)
  96:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
  9d:	e8 f7 05 00 00       	call   699 <setgid>
  a2:	83 c4 10             	add    $0x10,%esp
  a5:	85 c0                	test   %eax,%eax
  a7:	0f 88 e2 01 00 00    	js     28f <main+0x28f>
  setgid(nval);
  ad:	83 ec 0c             	sub    $0xc,%esp
  b0:	68 c8 00 00 00       	push   $0xc8
  b5:	e8 df 05 00 00       	call   699 <setgid>
  gid = getgid();
  ba:	e8 d2 05 00 00       	call   691 <getgid>
  printf(1, "Current GID is: %d\n", gid);
  bf:	83 c4 0c             	add    $0xc,%esp
  c2:	50                   	push   %eax
  c3:	68 57 0b 00 00       	push   $0xb57
  c8:	6a 01                	push   $0x1
  ca:	e8 e1 06 00 00       	call   7b0 <printf>
  sleep(5 * TPS);  // now type control-p
  cf:	c7 04 24 88 13 00 00 	movl   $0x1388,(%esp)
  d6:	e8 96 05 00 00       	call   671 <sleep>
  ppid = getppid();
  db:	e8 d1 05 00 00       	call   6b1 <getppid>
  printf(1, "My parent process is: %d\n", ppid);
  e0:	83 c4 0c             	add    $0xc,%esp
  e3:	50                   	push   %eax
  e4:	68 96 0b 00 00       	push   $0xb96
  e9:	6a 01                	push   $0x1
  eb:	e8 c0 06 00 00       	call   7b0 <printf>
  printf(1, "Setting UID to %d and GID to %d before fork(). Value"
  f0:	6a 6f                	push   $0x6f
  f2:	6a 6f                	push   $0x6f
  f4:	68 b8 0b 00 00       	push   $0xbb8
  f9:	6a 01                	push   $0x1
  fb:	e8 b0 06 00 00       	call   7b0 <printf>
  if (setuid(nval) < 0)
 100:	83 c4 14             	add    $0x14,%esp
 103:	6a 6f                	push   $0x6f
 105:	e8 9f 05 00 00       	call   6a9 <setuid>
 10a:	83 c4 10             	add    $0x10,%esp
 10d:	85 c0                	test   %eax,%eax
 10f:	0f 88 63 01 00 00    	js     278 <main+0x278>
  if (setgid(nval) < 0)
 115:	83 ec 0c             	sub    $0xc,%esp
 118:	6a 6f                	push   $0x6f
 11a:	e8 7a 05 00 00       	call   699 <setgid>
 11f:	83 c4 10             	add    $0x10,%esp
 122:	85 c0                	test   %eax,%eax
 124:	0f 88 37 01 00 00    	js     261 <main+0x261>
  printf(1, "Before fork(), UID = %d, GID = %d\n", getuid(), getgid());
 12a:	e8 62 05 00 00       	call   691 <getgid>
 12f:	89 c3                	mov    %eax,%ebx
 131:	e8 6b 05 00 00       	call   6a1 <getuid>
 136:	53                   	push   %ebx
 137:	50                   	push   %eax
 138:	68 04 0c 00 00       	push   $0xc04
 13d:	6a 01                	push   $0x1
 13f:	e8 6c 06 00 00       	call   7b0 <printf>
  pid = fork();
 144:	e8 90 04 00 00       	call   5d9 <fork>
  if (pid == 0) {  // child
 149:	83 c4 10             	add    $0x10,%esp
 14c:	85 c0                	test   %eax,%eax
 14e:	0f 84 6c 01 00 00    	je     2c0 <main+0x2c0>
    sleep(10 * TPS); // wait for child to exit before proceeding
 154:	83 ec 0c             	sub    $0xc,%esp
 157:	68 10 27 00 00       	push   $0x2710
 15c:	e8 10 05 00 00       	call   671 <sleep>
  printf(1, "Setting UID to %d. This test should FAIL\n", nval);
 161:	83 c4 0c             	add    $0xc,%esp
 164:	68 20 80 00 00       	push   $0x8020
 169:	68 48 0c 00 00       	push   $0xc48
 16e:	6a 01                	push   $0x1
 170:	e8 3b 06 00 00       	call   7b0 <printf>
  if (setuid(nval) < 0)
 175:	c7 04 24 20 80 00 00 	movl   $0x8020,(%esp)
 17c:	e8 28 05 00 00       	call   6a9 <setuid>
 181:	83 c4 10             	add    $0x10,%esp
 184:	85 c0                	test   %eax,%eax
 186:	0f 88 96 00 00 00    	js     222 <main+0x222>
    printf(2, "FAILURE! The setuid system call indicates success\n");
 18c:	50                   	push   %eax
 18d:	50                   	push   %eax
 18e:	68 a8 0c 00 00       	push   $0xca8
 193:	6a 02                	push   $0x2
 195:	e8 16 06 00 00       	call   7b0 <printf>
 19a:	83 c4 10             	add    $0x10,%esp
  printf(1, "Setting GID to %d. This test should FAIL\n", nval);
 19d:	83 ec 04             	sub    $0x4,%esp
 1a0:	68 20 80 00 00       	push   $0x8020
 1a5:	68 dc 0c 00 00       	push   $0xcdc
 1aa:	6a 01                	push   $0x1
 1ac:	e8 ff 05 00 00       	call   7b0 <printf>
  if (setgid(nval) < 0)
 1b1:	c7 04 24 20 80 00 00 	movl   $0x8020,(%esp)
 1b8:	e8 dc 04 00 00       	call   699 <setgid>
 1bd:	83 c4 10             	add    $0x10,%esp
 1c0:	85 c0                	test   %eax,%eax
 1c2:	0f 88 83 00 00 00    	js     24b <main+0x24b>
    printf(2, "FAILURE! The setgid system call indicates success\n");
 1c8:	51                   	push   %ecx
 1c9:	51                   	push   %ecx
 1ca:	68 3c 0d 00 00       	push   $0xd3c
 1cf:	6a 02                	push   $0x2
 1d1:	e8 da 05 00 00       	call   7b0 <printf>
 1d6:	83 c4 10             	add    $0x10,%esp
  printf(1, "Setting UID to %d. This test should FAIL\n", -1);
 1d9:	83 ec 04             	sub    $0x4,%esp
 1dc:	6a ff                	push   $0xffffffff
 1de:	68 48 0c 00 00       	push   $0xc48
 1e3:	6a 01                	push   $0x1
 1e5:	e8 c6 05 00 00       	call   7b0 <printf>
  if (setuid(-1) < 0)
 1ea:	c7 04 24 ff ff ff ff 	movl   $0xffffffff,(%esp)
 1f1:	e8 b3 04 00 00       	call   6a9 <setuid>
 1f6:	83 c4 10             	add    $0x10,%esp
 1f9:	85 c0                	test   %eax,%eax
 1fb:	78 3b                	js     238 <main+0x238>
    printf(2, "FAILURE! The setgid system call indicates success\n");
 1fd:	50                   	push   %eax
 1fe:	50                   	push   %eax
 1ff:	68 3c 0d 00 00       	push   $0xd3c
 204:	6a 02                	push   $0x2
 206:	e8 a5 05 00 00       	call   7b0 <printf>
 20b:	83 c4 10             	add    $0x10,%esp
  printf(1, "Done!\n");
 20e:	83 ec 08             	sub    $0x8,%esp
 211:	68 b0 0b 00 00       	push   $0xbb0
 216:	6a 01                	push   $0x1
 218:	e8 93 05 00 00       	call   7b0 <printf>
  testuidgid();
  exit();
 21d:	e8 bf 03 00 00       	call   5e1 <exit>
    printf(1, "SUCCESS! The setuid sytem call indicated failure\n");
 222:	50                   	push   %eax
 223:	50                   	push   %eax
 224:	68 74 0c 00 00       	push   $0xc74
 229:	6a 01                	push   $0x1
 22b:	e8 80 05 00 00       	call   7b0 <printf>
 230:	83 c4 10             	add    $0x10,%esp
 233:	e9 65 ff ff ff       	jmp    19d <main+0x19d>
    printf(1, "SUCCESS! The setuid sytem call indicated failure\n");
 238:	52                   	push   %edx
 239:	52                   	push   %edx
 23a:	68 74 0c 00 00       	push   $0xc74
 23f:	6a 01                	push   $0x1
 241:	e8 6a 05 00 00       	call   7b0 <printf>
 246:	83 c4 10             	add    $0x10,%esp
 249:	eb c3                	jmp    20e <main+0x20e>
    printf(1, "SUCCESS! The setgid sytem call indicated failure\n");
 24b:	53                   	push   %ebx
 24c:	53                   	push   %ebx
 24d:	68 08 0d 00 00       	push   $0xd08
 252:	6a 01                	push   $0x1
 254:	e8 57 05 00 00       	call   7b0 <printf>
 259:	83 c4 10             	add    $0x10,%esp
 25c:	e9 78 ff ff ff       	jmp    1d9 <main+0x1d9>
    printf(2, "Error. Invalid UID: %d\n", nval);
 261:	50                   	push   %eax
 262:	6a 6f                	push   $0x6f
 264:	68 3f 0b 00 00       	push   $0xb3f
 269:	6a 02                	push   $0x2
 26b:	e8 40 05 00 00       	call   7b0 <printf>
 270:	83 c4 10             	add    $0x10,%esp
 273:	e9 b2 fe ff ff       	jmp    12a <main+0x12a>
    printf(2, "Error. Invalid UID: %d\n", nval);
 278:	50                   	push   %eax
 279:	6a 6f                	push   $0x6f
 27b:	68 3f 0b 00 00       	push   $0xb3f
 280:	6a 02                	push   $0x2
 282:	e8 29 05 00 00       	call   7b0 <printf>
 287:	83 c4 10             	add    $0x10,%esp
 28a:	e9 86 fe ff ff       	jmp    115 <main+0x115>
    printf(2, "Error. Invalid GID: %d\n", nval);
 28f:	50                   	push   %eax
 290:	68 c8 00 00 00       	push   $0xc8
 295:	68 7e 0b 00 00       	push   $0xb7e
 29a:	6a 02                	push   $0x2
 29c:	e8 0f 05 00 00       	call   7b0 <printf>
 2a1:	83 c4 10             	add    $0x10,%esp
 2a4:	e9 04 fe ff ff       	jmp    ad <main+0xad>
    printf(2, "Error. Invalid UID: %d\n", nval);
 2a9:	50                   	push   %eax
 2aa:	6a 64                	push   $0x64
 2ac:	68 3f 0b 00 00       	push   $0xb3f
 2b1:	6a 02                	push   $0x2
 2b3:	e8 f8 04 00 00       	call   7b0 <printf>
 2b8:	83 c4 10             	add    $0x10,%esp
 2bb:	e9 8c fd ff ff       	jmp    4c <main+0x4c>
    uid = getuid();
 2c0:	e8 dc 03 00 00       	call   6a1 <getuid>
 2c5:	89 c3                	mov    %eax,%ebx
    gid = getgid();
 2c7:	e8 c5 03 00 00       	call   691 <getgid>
    printf(1, "Child: UID is: %d, GID is: %d\n", uid, gid);
 2cc:	50                   	push   %eax
 2cd:	53                   	push   %ebx
 2ce:	68 28 0c 00 00       	push   $0xc28
 2d3:	6a 01                	push   $0x1
 2d5:	e8 d6 04 00 00       	call   7b0 <printf>
    sleep(5 * TPS);  // now type control-p
 2da:	c7 04 24 88 13 00 00 	movl   $0x1388,(%esp)
 2e1:	e8 8b 03 00 00       	call   671 <sleep>
    exit();
 2e6:	e8 f6 02 00 00       	call   5e1 <exit>
 2eb:	66 90                	xchg   %ax,%ax
 2ed:	66 90                	xchg   %ax,%ax
 2ef:	90                   	nop

000002f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 2f0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2f1:	31 d2                	xor    %edx,%edx
{
 2f3:	89 e5                	mov    %esp,%ebp
 2f5:	53                   	push   %ebx
 2f6:	8b 45 08             	mov    0x8(%ebp),%eax
 2f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 2fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 300:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 304:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 307:	83 c2 01             	add    $0x1,%edx
 30a:	84 c9                	test   %cl,%cl
 30c:	75 f2                	jne    300 <strcpy+0x10>
    ;
  return os;
}
 30e:	5b                   	pop    %ebx
 30f:	5d                   	pop    %ebp
 310:	c3                   	ret    
 311:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 318:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 31f:	90                   	nop

00000320 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	56                   	push   %esi
 324:	53                   	push   %ebx
 325:	8b 5d 08             	mov    0x8(%ebp),%ebx
 328:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(*p && *p == *q)
 32b:	0f b6 13             	movzbl (%ebx),%edx
 32e:	0f b6 0e             	movzbl (%esi),%ecx
 331:	84 d2                	test   %dl,%dl
 333:	74 1e                	je     353 <strcmp+0x33>
 335:	b8 01 00 00 00       	mov    $0x1,%eax
 33a:	38 ca                	cmp    %cl,%dl
 33c:	74 09                	je     347 <strcmp+0x27>
 33e:	eb 20                	jmp    360 <strcmp+0x40>
 340:	83 c0 01             	add    $0x1,%eax
 343:	38 ca                	cmp    %cl,%dl
 345:	75 19                	jne    360 <strcmp+0x40>
 347:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 34b:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
 34f:	84 d2                	test   %dl,%dl
 351:	75 ed                	jne    340 <strcmp+0x20>
 353:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 355:	5b                   	pop    %ebx
 356:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
 357:	29 c8                	sub    %ecx,%eax
}
 359:	5d                   	pop    %ebp
 35a:	c3                   	ret    
 35b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 35f:	90                   	nop
 360:	0f b6 c2             	movzbl %dl,%eax
 363:	5b                   	pop    %ebx
 364:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
 365:	29 c8                	sub    %ecx,%eax
}
 367:	5d                   	pop    %ebp
 368:	c3                   	ret    
 369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000370 <strlen>:

uint
strlen(char *s)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 376:	80 39 00             	cmpb   $0x0,(%ecx)
 379:	74 15                	je     390 <strlen+0x20>
 37b:	31 d2                	xor    %edx,%edx
 37d:	8d 76 00             	lea    0x0(%esi),%esi
 380:	83 c2 01             	add    $0x1,%edx
 383:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 387:	89 d0                	mov    %edx,%eax
 389:	75 f5                	jne    380 <strlen+0x10>
    ;
  return n;
}
 38b:	5d                   	pop    %ebp
 38c:	c3                   	ret    
 38d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 390:	31 c0                	xor    %eax,%eax
}
 392:	5d                   	pop    %ebp
 393:	c3                   	ret    
 394:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 39b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 39f:	90                   	nop

000003a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ad:	89 d7                	mov    %edx,%edi
 3af:	fc                   	cld    
 3b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3b2:	89 d0                	mov    %edx,%eax
 3b4:	5f                   	pop    %edi
 3b5:	5d                   	pop    %ebp
 3b6:	c3                   	ret    
 3b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3be:	66 90                	xchg   %ax,%ax

000003c0 <strchr>:

char*
strchr(const char *s, char c)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	53                   	push   %ebx
 3c4:	8b 45 08             	mov    0x8(%ebp),%eax
 3c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 3ca:	0f b6 18             	movzbl (%eax),%ebx
 3cd:	84 db                	test   %bl,%bl
 3cf:	74 1d                	je     3ee <strchr+0x2e>
 3d1:	89 d1                	mov    %edx,%ecx
    if(*s == c)
 3d3:	38 d3                	cmp    %dl,%bl
 3d5:	75 0d                	jne    3e4 <strchr+0x24>
 3d7:	eb 17                	jmp    3f0 <strchr+0x30>
 3d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3e0:	38 ca                	cmp    %cl,%dl
 3e2:	74 0c                	je     3f0 <strchr+0x30>
  for(; *s; s++)
 3e4:	83 c0 01             	add    $0x1,%eax
 3e7:	0f b6 10             	movzbl (%eax),%edx
 3ea:	84 d2                	test   %dl,%dl
 3ec:	75 f2                	jne    3e0 <strchr+0x20>
      return (char*)s;
  return 0;
 3ee:	31 c0                	xor    %eax,%eax
}
 3f0:	5b                   	pop    %ebx
 3f1:	5d                   	pop    %ebp
 3f2:	c3                   	ret    
 3f3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000400 <gets>:

char*
gets(char *buf, int max)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 405:	31 f6                	xor    %esi,%esi
{
 407:	53                   	push   %ebx
 408:	89 f3                	mov    %esi,%ebx
 40a:	83 ec 1c             	sub    $0x1c,%esp
 40d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 410:	eb 2f                	jmp    441 <gets+0x41>
 412:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 418:	83 ec 04             	sub    $0x4,%esp
 41b:	8d 45 e7             	lea    -0x19(%ebp),%eax
 41e:	6a 01                	push   $0x1
 420:	50                   	push   %eax
 421:	6a 00                	push   $0x0
 423:	e8 d1 01 00 00       	call   5f9 <read>
    if(cc < 1)
 428:	83 c4 10             	add    $0x10,%esp
 42b:	85 c0                	test   %eax,%eax
 42d:	7e 1c                	jle    44b <gets+0x4b>
      break;
    buf[i++] = c;
 42f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 433:	83 c7 01             	add    $0x1,%edi
 436:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 439:	3c 0a                	cmp    $0xa,%al
 43b:	74 23                	je     460 <gets+0x60>
 43d:	3c 0d                	cmp    $0xd,%al
 43f:	74 1f                	je     460 <gets+0x60>
  for(i=0; i+1 < max; ){
 441:	83 c3 01             	add    $0x1,%ebx
 444:	89 fe                	mov    %edi,%esi
 446:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 449:	7c cd                	jl     418 <gets+0x18>
 44b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 44d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 450:	c6 03 00             	movb   $0x0,(%ebx)
}
 453:	8d 65 f4             	lea    -0xc(%ebp),%esp
 456:	5b                   	pop    %ebx
 457:	5e                   	pop    %esi
 458:	5f                   	pop    %edi
 459:	5d                   	pop    %ebp
 45a:	c3                   	ret    
 45b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 45f:	90                   	nop
 460:	8b 75 08             	mov    0x8(%ebp),%esi
 463:	8b 45 08             	mov    0x8(%ebp),%eax
 466:	01 de                	add    %ebx,%esi
 468:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 46a:	c6 03 00             	movb   $0x0,(%ebx)
}
 46d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 470:	5b                   	pop    %ebx
 471:	5e                   	pop    %esi
 472:	5f                   	pop    %edi
 473:	5d                   	pop    %ebp
 474:	c3                   	ret    
 475:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 47c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000480 <stat>:

int
stat(char *n, struct stat *st)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	56                   	push   %esi
 484:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 485:	83 ec 08             	sub    $0x8,%esp
 488:	6a 00                	push   $0x0
 48a:	ff 75 08             	pushl  0x8(%ebp)
 48d:	e8 8f 01 00 00       	call   621 <open>
  if(fd < 0)
 492:	83 c4 10             	add    $0x10,%esp
 495:	85 c0                	test   %eax,%eax
 497:	78 27                	js     4c0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 499:	83 ec 08             	sub    $0x8,%esp
 49c:	ff 75 0c             	pushl  0xc(%ebp)
 49f:	89 c3                	mov    %eax,%ebx
 4a1:	50                   	push   %eax
 4a2:	e8 92 01 00 00       	call   639 <fstat>
  close(fd);
 4a7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 4aa:	89 c6                	mov    %eax,%esi
  close(fd);
 4ac:	e8 58 01 00 00       	call   609 <close>
  return r;
 4b1:	83 c4 10             	add    $0x10,%esp
}
 4b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4b7:	89 f0                	mov    %esi,%eax
 4b9:	5b                   	pop    %ebx
 4ba:	5e                   	pop    %esi
 4bb:	5d                   	pop    %ebp
 4bc:	c3                   	ret    
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 4c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 4c5:	eb ed                	jmp    4b4 <stat+0x34>
 4c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ce:	66 90                	xchg   %ax,%ax

000004d0 <atoi>:

#ifdef PDX_XV6
int
atoi(const char *s)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	56                   	push   %esi
 4d4:	8b 55 08             	mov    0x8(%ebp),%edx
 4d7:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 4d8:	0f b6 0a             	movzbl (%edx),%ecx
 4db:	80 f9 20             	cmp    $0x20,%cl
 4de:	75 0b                	jne    4eb <atoi+0x1b>
 4e0:	83 c2 01             	add    $0x1,%edx
 4e3:	0f b6 0a             	movzbl (%edx),%ecx
 4e6:	80 f9 20             	cmp    $0x20,%cl
 4e9:	74 f5                	je     4e0 <atoi+0x10>
  sign = (*s == '-') ? -1 : 1;
 4eb:	80 f9 2d             	cmp    $0x2d,%cl
 4ee:	74 40                	je     530 <atoi+0x60>
 4f0:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 4f5:	80 f9 2b             	cmp    $0x2b,%cl
 4f8:	74 3b                	je     535 <atoi+0x65>
    s++;
  while('0' <= *s && *s <= '9')
 4fa:	0f be 0a             	movsbl (%edx),%ecx
 4fd:	8d 41 d0             	lea    -0x30(%ecx),%eax
 500:	3c 09                	cmp    $0x9,%al
 502:	b8 00 00 00 00       	mov    $0x0,%eax
 507:	77 1f                	ja     528 <atoi+0x58>
 509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 510:	83 c2 01             	add    $0x1,%edx
 513:	8d 04 80             	lea    (%eax,%eax,4),%eax
 516:	8d 44 41 d0          	lea    -0x30(%ecx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 51a:	0f be 0a             	movsbl (%edx),%ecx
 51d:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 520:	80 fb 09             	cmp    $0x9,%bl
 523:	76 eb                	jbe    510 <atoi+0x40>
 525:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 528:	5b                   	pop    %ebx
 529:	5e                   	pop    %esi
 52a:	5d                   	pop    %ebp
 52b:	c3                   	ret    
 52c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 530:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 535:	83 c2 01             	add    $0x1,%edx
 538:	eb c0                	jmp    4fa <atoi+0x2a>
 53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000540 <atoo>:

int
atoo(const char *s)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	56                   	push   %esi
 544:	8b 55 08             	mov    0x8(%ebp),%edx
 547:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 548:	0f b6 0a             	movzbl (%edx),%ecx
 54b:	80 f9 20             	cmp    $0x20,%cl
 54e:	75 0b                	jne    55b <atoo+0x1b>
 550:	83 c2 01             	add    $0x1,%edx
 553:	0f b6 0a             	movzbl (%edx),%ecx
 556:	80 f9 20             	cmp    $0x20,%cl
 559:	74 f5                	je     550 <atoo+0x10>
  sign = (*s == '-') ? -1 : 1;
 55b:	80 f9 2d             	cmp    $0x2d,%cl
 55e:	74 40                	je     5a0 <atoo+0x60>
 560:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 565:	80 f9 2b             	cmp    $0x2b,%cl
 568:	74 3b                	je     5a5 <atoo+0x65>
    s++;
  while('0' <= *s && *s <= '7')
 56a:	0f be 0a             	movsbl (%edx),%ecx
 56d:	8d 41 d0             	lea    -0x30(%ecx),%eax
 570:	3c 07                	cmp    $0x7,%al
 572:	b8 00 00 00 00       	mov    $0x0,%eax
 577:	77 1c                	ja     595 <atoo+0x55>
 579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*8 + *s++ - '0';
 580:	83 c2 01             	add    $0x1,%edx
 583:	8d 44 c1 d0          	lea    -0x30(%ecx,%eax,8),%eax
  while('0' <= *s && *s <= '7')
 587:	0f be 0a             	movsbl (%edx),%ecx
 58a:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 58d:	80 fb 07             	cmp    $0x7,%bl
 590:	76 ee                	jbe    580 <atoo+0x40>
 592:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 595:	5b                   	pop    %ebx
 596:	5e                   	pop    %esi
 597:	5d                   	pop    %ebp
 598:	c3                   	ret    
 599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 5a0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 5a5:	83 c2 01             	add    $0x1,%edx
 5a8:	eb c0                	jmp    56a <atoo+0x2a>
 5aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000005b0 <memmove>:
}
#endif // PDX_XV6

void*
memmove(void *vdst, void *vsrc, int n)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	57                   	push   %edi
 5b4:	8b 55 10             	mov    0x10(%ebp),%edx
 5b7:	8b 45 08             	mov    0x8(%ebp),%eax
 5ba:	56                   	push   %esi
 5bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5be:	85 d2                	test   %edx,%edx
 5c0:	7e 13                	jle    5d5 <memmove+0x25>
 5c2:	01 c2                	add    %eax,%edx
  dst = vdst;
 5c4:	89 c7                	mov    %eax,%edi
 5c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5cd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 5d0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 5d1:	39 fa                	cmp    %edi,%edx
 5d3:	75 fb                	jne    5d0 <memmove+0x20>
  return vdst;
}
 5d5:	5e                   	pop    %esi
 5d6:	5f                   	pop    %edi
 5d7:	5d                   	pop    %ebp
 5d8:	c3                   	ret    

000005d9 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5d9:	b8 01 00 00 00       	mov    $0x1,%eax
 5de:	cd 40                	int    $0x40
 5e0:	c3                   	ret    

000005e1 <exit>:
SYSCALL(exit)
 5e1:	b8 02 00 00 00       	mov    $0x2,%eax
 5e6:	cd 40                	int    $0x40
 5e8:	c3                   	ret    

000005e9 <wait>:
SYSCALL(wait)
 5e9:	b8 03 00 00 00       	mov    $0x3,%eax
 5ee:	cd 40                	int    $0x40
 5f0:	c3                   	ret    

000005f1 <pipe>:
SYSCALL(pipe)
 5f1:	b8 04 00 00 00       	mov    $0x4,%eax
 5f6:	cd 40                	int    $0x40
 5f8:	c3                   	ret    

000005f9 <read>:
SYSCALL(read)
 5f9:	b8 05 00 00 00       	mov    $0x5,%eax
 5fe:	cd 40                	int    $0x40
 600:	c3                   	ret    

00000601 <write>:
SYSCALL(write)
 601:	b8 10 00 00 00       	mov    $0x10,%eax
 606:	cd 40                	int    $0x40
 608:	c3                   	ret    

00000609 <close>:
SYSCALL(close)
 609:	b8 15 00 00 00       	mov    $0x15,%eax
 60e:	cd 40                	int    $0x40
 610:	c3                   	ret    

00000611 <kill>:
SYSCALL(kill)
 611:	b8 06 00 00 00       	mov    $0x6,%eax
 616:	cd 40                	int    $0x40
 618:	c3                   	ret    

00000619 <exec>:
SYSCALL(exec)
 619:	b8 07 00 00 00       	mov    $0x7,%eax
 61e:	cd 40                	int    $0x40
 620:	c3                   	ret    

00000621 <open>:
SYSCALL(open)
 621:	b8 0f 00 00 00       	mov    $0xf,%eax
 626:	cd 40                	int    $0x40
 628:	c3                   	ret    

00000629 <mknod>:
SYSCALL(mknod)
 629:	b8 11 00 00 00       	mov    $0x11,%eax
 62e:	cd 40                	int    $0x40
 630:	c3                   	ret    

00000631 <unlink>:
SYSCALL(unlink)
 631:	b8 12 00 00 00       	mov    $0x12,%eax
 636:	cd 40                	int    $0x40
 638:	c3                   	ret    

00000639 <fstat>:
SYSCALL(fstat)
 639:	b8 08 00 00 00       	mov    $0x8,%eax
 63e:	cd 40                	int    $0x40
 640:	c3                   	ret    

00000641 <link>:
SYSCALL(link)
 641:	b8 13 00 00 00       	mov    $0x13,%eax
 646:	cd 40                	int    $0x40
 648:	c3                   	ret    

00000649 <mkdir>:
SYSCALL(mkdir)
 649:	b8 14 00 00 00       	mov    $0x14,%eax
 64e:	cd 40                	int    $0x40
 650:	c3                   	ret    

00000651 <chdir>:
SYSCALL(chdir)
 651:	b8 09 00 00 00       	mov    $0x9,%eax
 656:	cd 40                	int    $0x40
 658:	c3                   	ret    

00000659 <dup>:
SYSCALL(dup)
 659:	b8 0a 00 00 00       	mov    $0xa,%eax
 65e:	cd 40                	int    $0x40
 660:	c3                   	ret    

00000661 <getpid>:
SYSCALL(getpid)
 661:	b8 0b 00 00 00       	mov    $0xb,%eax
 666:	cd 40                	int    $0x40
 668:	c3                   	ret    

00000669 <sbrk>:
SYSCALL(sbrk)
 669:	b8 0c 00 00 00       	mov    $0xc,%eax
 66e:	cd 40                	int    $0x40
 670:	c3                   	ret    

00000671 <sleep>:
SYSCALL(sleep)
 671:	b8 0d 00 00 00       	mov    $0xd,%eax
 676:	cd 40                	int    $0x40
 678:	c3                   	ret    

00000679 <uptime>:
SYSCALL(uptime)
 679:	b8 0e 00 00 00       	mov    $0xe,%eax
 67e:	cd 40                	int    $0x40
 680:	c3                   	ret    

00000681 <halt>:
SYSCALL(halt)
 681:	b8 16 00 00 00       	mov    $0x16,%eax
 686:	cd 40                	int    $0x40
 688:	c3                   	ret    

00000689 <date>:
SYSCALL(date)
 689:	b8 17 00 00 00       	mov    $0x17,%eax
 68e:	cd 40                	int    $0x40
 690:	c3                   	ret    

00000691 <getgid>:
SYSCALL(getgid)
 691:	b8 18 00 00 00       	mov    $0x18,%eax
 696:	cd 40                	int    $0x40
 698:	c3                   	ret    

00000699 <setgid>:
SYSCALL(setgid)
 699:	b8 19 00 00 00       	mov    $0x19,%eax
 69e:	cd 40                	int    $0x40
 6a0:	c3                   	ret    

000006a1 <getuid>:
SYSCALL(getuid)
 6a1:	b8 1a 00 00 00       	mov    $0x1a,%eax
 6a6:	cd 40                	int    $0x40
 6a8:	c3                   	ret    

000006a9 <setuid>:
SYSCALL(setuid)
 6a9:	b8 1b 00 00 00       	mov    $0x1b,%eax
 6ae:	cd 40                	int    $0x40
 6b0:	c3                   	ret    

000006b1 <getppid>:
SYSCALL(getppid)
 6b1:	b8 1c 00 00 00       	mov    $0x1c,%eax
 6b6:	cd 40                	int    $0x40
 6b8:	c3                   	ret    

000006b9 <getprocs>:
SYSCALL(getprocs)
 6b9:	b8 1d 00 00 00       	mov    $0x1d,%eax
 6be:	cd 40                	int    $0x40
 6c0:	c3                   	ret    

000006c1 <setpriority>:
SYSCALL(setpriority)
 6c1:	b8 1e 00 00 00       	mov    $0x1e,%eax
 6c6:	cd 40                	int    $0x40
 6c8:	c3                   	ret    

000006c9 <getpriority>:
SYSCALL(getpriority)
 6c9:	b8 1f 00 00 00       	mov    $0x1f,%eax
 6ce:	cd 40                	int    $0x40
 6d0:	c3                   	ret    

000006d1 <chmod>:
SYSCALL(chmod)
 6d1:	b8 20 00 00 00       	mov    $0x20,%eax
 6d6:	cd 40                	int    $0x40
 6d8:	c3                   	ret    

000006d9 <chown>:
SYSCALL(chown)
 6d9:	b8 21 00 00 00       	mov    $0x21,%eax
 6de:	cd 40                	int    $0x40
 6e0:	c3                   	ret    

000006e1 <chgrp>:
SYSCALL(chgrp)
 6e1:	b8 22 00 00 00       	mov    $0x22,%eax
 6e6:	cd 40                	int    $0x40
 6e8:	c3                   	ret    
 6e9:	66 90                	xchg   %ax,%ax
 6eb:	66 90                	xchg   %ax,%ax
 6ed:	66 90                	xchg   %ax,%ax
 6ef:	90                   	nop

000006f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	57                   	push   %edi
 6f4:	56                   	push   %esi
 6f5:	53                   	push   %ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 6f6:	89 d3                	mov    %edx,%ebx
{
 6f8:	83 ec 3c             	sub    $0x3c,%esp
 6fb:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 6fe:	85 d2                	test   %edx,%edx
 700:	0f 89 92 00 00 00    	jns    798 <printint+0xa8>
 706:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 70a:	0f 84 88 00 00 00    	je     798 <printint+0xa8>
    neg = 1;
 710:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 717:	f7 db                	neg    %ebx
  } else {
    x = xx;
  }

  i = 0;
 719:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 720:	8d 75 d7             	lea    -0x29(%ebp),%esi
 723:	eb 08                	jmp    72d <printint+0x3d>
 725:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 728:	89 7d c4             	mov    %edi,-0x3c(%ebp)
  }while((x /= base) != 0);
 72b:	89 c3                	mov    %eax,%ebx
    buf[i++] = digits[x % base];
 72d:	89 d8                	mov    %ebx,%eax
 72f:	31 d2                	xor    %edx,%edx
 731:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 734:	f7 f1                	div    %ecx
 736:	83 c7 01             	add    $0x1,%edi
 739:	0f b6 92 78 0d 00 00 	movzbl 0xd78(%edx),%edx
 740:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 743:	39 d9                	cmp    %ebx,%ecx
 745:	76 e1                	jbe    728 <printint+0x38>
  if(neg)
 747:	8b 45 c0             	mov    -0x40(%ebp),%eax
 74a:	85 c0                	test   %eax,%eax
 74c:	74 0d                	je     75b <printint+0x6b>
    buf[i++] = '-';
 74e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 753:	ba 2d 00 00 00       	mov    $0x2d,%edx
    buf[i++] = digits[x % base];
 758:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 75b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 75e:	8b 7d bc             	mov    -0x44(%ebp),%edi
 761:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 765:	eb 0f                	jmp    776 <printint+0x86>
 767:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 76e:	66 90                	xchg   %ax,%ax
 770:	0f b6 13             	movzbl (%ebx),%edx
 773:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 776:	83 ec 04             	sub    $0x4,%esp
 779:	88 55 d7             	mov    %dl,-0x29(%ebp)
 77c:	6a 01                	push   $0x1
 77e:	56                   	push   %esi
 77f:	57                   	push   %edi
 780:	e8 7c fe ff ff       	call   601 <write>

  while(--i >= 0)
 785:	83 c4 10             	add    $0x10,%esp
 788:	39 de                	cmp    %ebx,%esi
 78a:	75 e4                	jne    770 <printint+0x80>
    putc(fd, buf[i]);
}
 78c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 78f:	5b                   	pop    %ebx
 790:	5e                   	pop    %esi
 791:	5f                   	pop    %edi
 792:	5d                   	pop    %ebp
 793:	c3                   	ret    
 794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 798:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 79f:	e9 75 ff ff ff       	jmp    719 <printint+0x29>
 7a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7af:	90                   	nop

000007b0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 7b0:	55                   	push   %ebp
 7b1:	89 e5                	mov    %esp,%ebp
 7b3:	57                   	push   %edi
 7b4:	56                   	push   %esi
 7b5:	53                   	push   %ebx
 7b6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7b9:	8b 75 0c             	mov    0xc(%ebp),%esi
 7bc:	0f b6 1e             	movzbl (%esi),%ebx
 7bf:	84 db                	test   %bl,%bl
 7c1:	0f 84 b9 00 00 00    	je     880 <printf+0xd0>
  ap = (uint*)(void*)&fmt + 1;
 7c7:	8d 45 10             	lea    0x10(%ebp),%eax
 7ca:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 7cd:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 7d0:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 7d2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 7d5:	eb 38                	jmp    80f <printf+0x5f>
 7d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7de:	66 90                	xchg   %ax,%ax
 7e0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 7e3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 7e8:	83 f8 25             	cmp    $0x25,%eax
 7eb:	74 17                	je     804 <printf+0x54>
  write(fd, &c, 1);
 7ed:	83 ec 04             	sub    $0x4,%esp
 7f0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 7f3:	6a 01                	push   $0x1
 7f5:	57                   	push   %edi
 7f6:	ff 75 08             	pushl  0x8(%ebp)
 7f9:	e8 03 fe ff ff       	call   601 <write>
 7fe:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 801:	83 c4 10             	add    $0x10,%esp
 804:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 807:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 80b:	84 db                	test   %bl,%bl
 80d:	74 71                	je     880 <printf+0xd0>
    c = fmt[i] & 0xff;
 80f:	0f be cb             	movsbl %bl,%ecx
 812:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 815:	85 d2                	test   %edx,%edx
 817:	74 c7                	je     7e0 <printf+0x30>
      }
    } else if(state == '%'){
 819:	83 fa 25             	cmp    $0x25,%edx
 81c:	75 e6                	jne    804 <printf+0x54>
      if(c == 'd'){
 81e:	83 f8 64             	cmp    $0x64,%eax
 821:	0f 84 99 00 00 00    	je     8c0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 827:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 82d:	83 f9 70             	cmp    $0x70,%ecx
 830:	74 5e                	je     890 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 832:	83 f8 73             	cmp    $0x73,%eax
 835:	0f 84 d5 00 00 00    	je     910 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 83b:	83 f8 63             	cmp    $0x63,%eax
 83e:	0f 84 8c 00 00 00    	je     8d0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 844:	83 f8 25             	cmp    $0x25,%eax
 847:	0f 84 b3 00 00 00    	je     900 <printf+0x150>
  write(fd, &c, 1);
 84d:	83 ec 04             	sub    $0x4,%esp
 850:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 854:	6a 01                	push   $0x1
 856:	57                   	push   %edi
 857:	ff 75 08             	pushl  0x8(%ebp)
 85a:	e8 a2 fd ff ff       	call   601 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 85f:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 862:	83 c4 0c             	add    $0xc,%esp
 865:	6a 01                	push   $0x1
 867:	83 c6 01             	add    $0x1,%esi
 86a:	57                   	push   %edi
 86b:	ff 75 08             	pushl  0x8(%ebp)
 86e:	e8 8e fd ff ff       	call   601 <write>
  for(i = 0; fmt[i]; i++){
 873:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 877:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 87a:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 87c:	84 db                	test   %bl,%bl
 87e:	75 8f                	jne    80f <printf+0x5f>
    }
  }
}
 880:	8d 65 f4             	lea    -0xc(%ebp),%esp
 883:	5b                   	pop    %ebx
 884:	5e                   	pop    %esi
 885:	5f                   	pop    %edi
 886:	5d                   	pop    %ebp
 887:	c3                   	ret    
 888:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 88f:	90                   	nop
        printint(fd, *ap, 16, 0);
 890:	83 ec 0c             	sub    $0xc,%esp
 893:	b9 10 00 00 00       	mov    $0x10,%ecx
 898:	6a 00                	push   $0x0
 89a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 89d:	8b 45 08             	mov    0x8(%ebp),%eax
 8a0:	8b 13                	mov    (%ebx),%edx
 8a2:	e8 49 fe ff ff       	call   6f0 <printint>
        ap++;
 8a7:	89 d8                	mov    %ebx,%eax
 8a9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 8ac:	31 d2                	xor    %edx,%edx
        ap++;
 8ae:	83 c0 04             	add    $0x4,%eax
 8b1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 8b4:	e9 4b ff ff ff       	jmp    804 <printf+0x54>
 8b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 8c0:	83 ec 0c             	sub    $0xc,%esp
 8c3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 8c8:	6a 01                	push   $0x1
 8ca:	eb ce                	jmp    89a <printf+0xea>
 8cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 8d0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 8d3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 8d6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 8d8:	6a 01                	push   $0x1
        ap++;
 8da:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 8dd:	57                   	push   %edi
 8de:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 8e1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 8e4:	e8 18 fd ff ff       	call   601 <write>
        ap++;
 8e9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 8ec:	83 c4 10             	add    $0x10,%esp
      state = 0;
 8ef:	31 d2                	xor    %edx,%edx
 8f1:	e9 0e ff ff ff       	jmp    804 <printf+0x54>
 8f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8fd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 900:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 903:	83 ec 04             	sub    $0x4,%esp
 906:	e9 5a ff ff ff       	jmp    865 <printf+0xb5>
 90b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 90f:	90                   	nop
        s = (char*)*ap;
 910:	8b 45 d0             	mov    -0x30(%ebp),%eax
 913:	8b 18                	mov    (%eax),%ebx
        ap++;
 915:	83 c0 04             	add    $0x4,%eax
 918:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 91b:	85 db                	test   %ebx,%ebx
 91d:	74 17                	je     936 <printf+0x186>
        while(*s != 0){
 91f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 922:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 924:	84 c0                	test   %al,%al
 926:	0f 84 d8 fe ff ff    	je     804 <printf+0x54>
 92c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 92f:	89 de                	mov    %ebx,%esi
 931:	8b 5d 08             	mov    0x8(%ebp),%ebx
 934:	eb 1a                	jmp    950 <printf+0x1a0>
          s = "(null)";
 936:	bb 70 0d 00 00       	mov    $0xd70,%ebx
        while(*s != 0){
 93b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 93e:	b8 28 00 00 00       	mov    $0x28,%eax
 943:	89 de                	mov    %ebx,%esi
 945:	8b 5d 08             	mov    0x8(%ebp),%ebx
 948:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 94f:	90                   	nop
  write(fd, &c, 1);
 950:	83 ec 04             	sub    $0x4,%esp
          s++;
 953:	83 c6 01             	add    $0x1,%esi
 956:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 959:	6a 01                	push   $0x1
 95b:	57                   	push   %edi
 95c:	53                   	push   %ebx
 95d:	e8 9f fc ff ff       	call   601 <write>
        while(*s != 0){
 962:	0f b6 06             	movzbl (%esi),%eax
 965:	83 c4 10             	add    $0x10,%esp
 968:	84 c0                	test   %al,%al
 96a:	75 e4                	jne    950 <printf+0x1a0>
 96c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 96f:	31 d2                	xor    %edx,%edx
 971:	e9 8e fe ff ff       	jmp    804 <printf+0x54>
 976:	66 90                	xchg   %ax,%ax
 978:	66 90                	xchg   %ax,%ax
 97a:	66 90                	xchg   %ax,%ax
 97c:	66 90                	xchg   %ax,%ax
 97e:	66 90                	xchg   %ax,%ax

00000980 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 980:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 981:	a1 58 10 00 00       	mov    0x1058,%eax
{
 986:	89 e5                	mov    %esp,%ebp
 988:	57                   	push   %edi
 989:	56                   	push   %esi
 98a:	53                   	push   %ebx
 98b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 98e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 990:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 993:	39 c8                	cmp    %ecx,%eax
 995:	73 19                	jae    9b0 <free+0x30>
 997:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 99e:	66 90                	xchg   %ax,%ax
 9a0:	39 d1                	cmp    %edx,%ecx
 9a2:	72 14                	jb     9b8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9a4:	39 d0                	cmp    %edx,%eax
 9a6:	73 10                	jae    9b8 <free+0x38>
{
 9a8:	89 d0                	mov    %edx,%eax
 9aa:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9ac:	39 c8                	cmp    %ecx,%eax
 9ae:	72 f0                	jb     9a0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9b0:	39 d0                	cmp    %edx,%eax
 9b2:	72 f4                	jb     9a8 <free+0x28>
 9b4:	39 d1                	cmp    %edx,%ecx
 9b6:	73 f0                	jae    9a8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 9b8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 9bb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 9be:	39 fa                	cmp    %edi,%edx
 9c0:	74 1e                	je     9e0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 9c2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 9c5:	8b 50 04             	mov    0x4(%eax),%edx
 9c8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 9cb:	39 f1                	cmp    %esi,%ecx
 9cd:	74 28                	je     9f7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 9cf:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 9d1:	5b                   	pop    %ebx
  freep = p;
 9d2:	a3 58 10 00 00       	mov    %eax,0x1058
}
 9d7:	5e                   	pop    %esi
 9d8:	5f                   	pop    %edi
 9d9:	5d                   	pop    %ebp
 9da:	c3                   	ret    
 9db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 9df:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 9e0:	03 72 04             	add    0x4(%edx),%esi
 9e3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 9e6:	8b 10                	mov    (%eax),%edx
 9e8:	8b 12                	mov    (%edx),%edx
 9ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 9ed:	8b 50 04             	mov    0x4(%eax),%edx
 9f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 9f3:	39 f1                	cmp    %esi,%ecx
 9f5:	75 d8                	jne    9cf <free+0x4f>
    p->s.size += bp->s.size;
 9f7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 9fa:	a3 58 10 00 00       	mov    %eax,0x1058
    p->s.size += bp->s.size;
 9ff:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 a02:	8b 53 f8             	mov    -0x8(%ebx),%edx
 a05:	89 10                	mov    %edx,(%eax)
}
 a07:	5b                   	pop    %ebx
 a08:	5e                   	pop    %esi
 a09:	5f                   	pop    %edi
 a0a:	5d                   	pop    %ebp
 a0b:	c3                   	ret    
 a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a10 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a10:	55                   	push   %ebp
 a11:	89 e5                	mov    %esp,%ebp
 a13:	57                   	push   %edi
 a14:	56                   	push   %esi
 a15:	53                   	push   %ebx
 a16:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a19:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a1c:	8b 3d 58 10 00 00    	mov    0x1058,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a22:	8d 70 07             	lea    0x7(%eax),%esi
 a25:	c1 ee 03             	shr    $0x3,%esi
 a28:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 a2b:	85 ff                	test   %edi,%edi
 a2d:	0f 84 ad 00 00 00    	je     ae0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a33:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 a35:	8b 4a 04             	mov    0x4(%edx),%ecx
 a38:	39 f1                	cmp    %esi,%ecx
 a3a:	73 72                	jae    aae <malloc+0x9e>
 a3c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 a42:	bb 00 10 00 00       	mov    $0x1000,%ebx
 a47:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 a4a:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 a51:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 a54:	eb 1b                	jmp    a71 <malloc+0x61>
 a56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a5d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a60:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a62:	8b 48 04             	mov    0x4(%eax),%ecx
 a65:	39 f1                	cmp    %esi,%ecx
 a67:	73 4f                	jae    ab8 <malloc+0xa8>
 a69:	8b 3d 58 10 00 00    	mov    0x1058,%edi
 a6f:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a71:	39 d7                	cmp    %edx,%edi
 a73:	75 eb                	jne    a60 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 a75:	83 ec 0c             	sub    $0xc,%esp
 a78:	ff 75 e4             	pushl  -0x1c(%ebp)
 a7b:	e8 e9 fb ff ff       	call   669 <sbrk>
  if(p == (char*)-1)
 a80:	83 c4 10             	add    $0x10,%esp
 a83:	83 f8 ff             	cmp    $0xffffffff,%eax
 a86:	74 1c                	je     aa4 <malloc+0x94>
  hp->s.size = nu;
 a88:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 a8b:	83 ec 0c             	sub    $0xc,%esp
 a8e:	83 c0 08             	add    $0x8,%eax
 a91:	50                   	push   %eax
 a92:	e8 e9 fe ff ff       	call   980 <free>
  return freep;
 a97:	8b 15 58 10 00 00    	mov    0x1058,%edx
      if((p = morecore(nunits)) == 0)
 a9d:	83 c4 10             	add    $0x10,%esp
 aa0:	85 d2                	test   %edx,%edx
 aa2:	75 bc                	jne    a60 <malloc+0x50>
        return 0;
  }
}
 aa4:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 aa7:	31 c0                	xor    %eax,%eax
}
 aa9:	5b                   	pop    %ebx
 aaa:	5e                   	pop    %esi
 aab:	5f                   	pop    %edi
 aac:	5d                   	pop    %ebp
 aad:	c3                   	ret    
    if(p->s.size >= nunits){
 aae:	89 d0                	mov    %edx,%eax
 ab0:	89 fa                	mov    %edi,%edx
 ab2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 ab8:	39 ce                	cmp    %ecx,%esi
 aba:	74 54                	je     b10 <malloc+0x100>
        p->s.size -= nunits;
 abc:	29 f1                	sub    %esi,%ecx
 abe:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 ac1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 ac4:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 ac7:	89 15 58 10 00 00    	mov    %edx,0x1058
}
 acd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 ad0:	83 c0 08             	add    $0x8,%eax
}
 ad3:	5b                   	pop    %ebx
 ad4:	5e                   	pop    %esi
 ad5:	5f                   	pop    %edi
 ad6:	5d                   	pop    %ebp
 ad7:	c3                   	ret    
 ad8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 adf:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 ae0:	c7 05 58 10 00 00 5c 	movl   $0x105c,0x1058
 ae7:	10 00 00 
    base.s.size = 0;
 aea:	bf 5c 10 00 00       	mov    $0x105c,%edi
    base.s.ptr = freep = prevp = &base;
 aef:	c7 05 5c 10 00 00 5c 	movl   $0x105c,0x105c
 af6:	10 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 af9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 afb:	c7 05 60 10 00 00 00 	movl   $0x0,0x1060
 b02:	00 00 00 
    if(p->s.size >= nunits){
 b05:	e9 32 ff ff ff       	jmp    a3c <malloc+0x2c>
 b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 b10:	8b 08                	mov    (%eax),%ecx
 b12:	89 0a                	mov    %ecx,(%edx)
 b14:	eb b1                	jmp    ac7 <malloc+0xb7>
