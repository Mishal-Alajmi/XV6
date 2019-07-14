
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   f:	83 ec 08             	sub    $0x8,%esp
  12:	6a 02                	push   $0x2
  14:	68 18 09 00 00       	push   $0x918
  19:	e8 03 04 00 00       	call   421 <open>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	85 c0                	test   %eax,%eax
  23:	0f 88 9f 00 00 00    	js     c8 <main+0xc8>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  29:	83 ec 0c             	sub    $0xc,%esp
  2c:	6a 00                	push   $0x0
  2e:	e8 26 04 00 00       	call   459 <dup>
  dup(0);  // stderr
  33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3a:	e8 1a 04 00 00       	call   459 <dup>
  3f:	83 c4 10             	add    $0x10,%esp
  42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(;;){
    printf(1, "init: starting sh\n");
  48:	83 ec 08             	sub    $0x8,%esp
  4b:	68 20 09 00 00       	push   $0x920
  50:	6a 01                	push   $0x1
  52:	e8 59 05 00 00       	call   5b0 <printf>
    pid = fork();
  57:	e8 7d 03 00 00       	call   3d9 <fork>
    if(pid < 0){
  5c:	83 c4 10             	add    $0x10,%esp
    pid = fork();
  5f:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  61:	85 c0                	test   %eax,%eax
  63:	78 2c                	js     91 <main+0x91>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
  65:	74 3d                	je     a4 <main+0xa4>
  67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  6e:	66 90                	xchg   %ax,%ax
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  70:	e8 74 03 00 00       	call   3e9 <wait>
  75:	85 c0                	test   %eax,%eax
  77:	78 cf                	js     48 <main+0x48>
  79:	39 c3                	cmp    %eax,%ebx
  7b:	74 cb                	je     48 <main+0x48>
      printf(1, "zombie!\n");
  7d:	83 ec 08             	sub    $0x8,%esp
  80:	68 5f 09 00 00       	push   $0x95f
  85:	6a 01                	push   $0x1
  87:	e8 24 05 00 00       	call   5b0 <printf>
  8c:	83 c4 10             	add    $0x10,%esp
  8f:	eb df                	jmp    70 <main+0x70>
      printf(1, "init: fork failed\n");
  91:	53                   	push   %ebx
  92:	53                   	push   %ebx
  93:	68 33 09 00 00       	push   $0x933
  98:	6a 01                	push   $0x1
  9a:	e8 11 05 00 00       	call   5b0 <printf>
      exit();
  9f:	e8 3d 03 00 00       	call   3e1 <exit>
      exec("sh", argv);
  a4:	50                   	push   %eax
  a5:	50                   	push   %eax
  a6:	68 50 0c 00 00       	push   $0xc50
  ab:	68 46 09 00 00       	push   $0x946
  b0:	e8 64 03 00 00       	call   419 <exec>
      printf(1, "init: exec sh failed\n");
  b5:	5a                   	pop    %edx
  b6:	59                   	pop    %ecx
  b7:	68 49 09 00 00       	push   $0x949
  bc:	6a 01                	push   $0x1
  be:	e8 ed 04 00 00       	call   5b0 <printf>
      exit();
  c3:	e8 19 03 00 00       	call   3e1 <exit>
    mknod("console", 1, 1);
  c8:	50                   	push   %eax
  c9:	6a 01                	push   $0x1
  cb:	6a 01                	push   $0x1
  cd:	68 18 09 00 00       	push   $0x918
  d2:	e8 52 03 00 00       	call   429 <mknod>
    open("console", O_RDWR);
  d7:	58                   	pop    %eax
  d8:	5a                   	pop    %edx
  d9:	6a 02                	push   $0x2
  db:	68 18 09 00 00       	push   $0x918
  e0:	e8 3c 03 00 00       	call   421 <open>
  e5:	83 c4 10             	add    $0x10,%esp
  e8:	e9 3c ff ff ff       	jmp    29 <main+0x29>
  ed:	66 90                	xchg   %ax,%ax
  ef:	90                   	nop

000000f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  f0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  f1:	31 d2                	xor    %edx,%edx
{
  f3:	89 e5                	mov    %esp,%ebp
  f5:	53                   	push   %ebx
  f6:	8b 45 08             	mov    0x8(%ebp),%eax
  f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 100:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 104:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 107:	83 c2 01             	add    $0x1,%edx
 10a:	84 c9                	test   %cl,%cl
 10c:	75 f2                	jne    100 <strcpy+0x10>
    ;
  return os;
}
 10e:	5b                   	pop    %ebx
 10f:	5d                   	pop    %ebp
 110:	c3                   	ret    
 111:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 118:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 11f:	90                   	nop

00000120 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	56                   	push   %esi
 124:	53                   	push   %ebx
 125:	8b 5d 08             	mov    0x8(%ebp),%ebx
 128:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(*p && *p == *q)
 12b:	0f b6 13             	movzbl (%ebx),%edx
 12e:	0f b6 0e             	movzbl (%esi),%ecx
 131:	84 d2                	test   %dl,%dl
 133:	74 1e                	je     153 <strcmp+0x33>
 135:	b8 01 00 00 00       	mov    $0x1,%eax
 13a:	38 ca                	cmp    %cl,%dl
 13c:	74 09                	je     147 <strcmp+0x27>
 13e:	eb 20                	jmp    160 <strcmp+0x40>
 140:	83 c0 01             	add    $0x1,%eax
 143:	38 ca                	cmp    %cl,%dl
 145:	75 19                	jne    160 <strcmp+0x40>
 147:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 14b:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
 14f:	84 d2                	test   %dl,%dl
 151:	75 ed                	jne    140 <strcmp+0x20>
 153:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 155:	5b                   	pop    %ebx
 156:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
 157:	29 c8                	sub    %ecx,%eax
}
 159:	5d                   	pop    %ebp
 15a:	c3                   	ret    
 15b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 15f:	90                   	nop
 160:	0f b6 c2             	movzbl %dl,%eax
 163:	5b                   	pop    %ebx
 164:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
 165:	29 c8                	sub    %ecx,%eax
}
 167:	5d                   	pop    %ebp
 168:	c3                   	ret    
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000170 <strlen>:

uint
strlen(char *s)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 176:	80 39 00             	cmpb   $0x0,(%ecx)
 179:	74 15                	je     190 <strlen+0x20>
 17b:	31 d2                	xor    %edx,%edx
 17d:	8d 76 00             	lea    0x0(%esi),%esi
 180:	83 c2 01             	add    $0x1,%edx
 183:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 187:	89 d0                	mov    %edx,%eax
 189:	75 f5                	jne    180 <strlen+0x10>
    ;
  return n;
}
 18b:	5d                   	pop    %ebp
 18c:	c3                   	ret    
 18d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 190:	31 c0                	xor    %eax,%eax
}
 192:	5d                   	pop    %ebp
 193:	c3                   	ret    
 194:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 19b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 19f:	90                   	nop

000001a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	57                   	push   %edi
 1a4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ad:	89 d7                	mov    %edx,%edi
 1af:	fc                   	cld    
 1b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1b2:	89 d0                	mov    %edx,%eax
 1b4:	5f                   	pop    %edi
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret    
 1b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1be:	66 90                	xchg   %ax,%ax

000001c0 <strchr>:

char*
strchr(const char *s, char c)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	53                   	push   %ebx
 1c4:	8b 45 08             	mov    0x8(%ebp),%eax
 1c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 1ca:	0f b6 18             	movzbl (%eax),%ebx
 1cd:	84 db                	test   %bl,%bl
 1cf:	74 1d                	je     1ee <strchr+0x2e>
 1d1:	89 d1                	mov    %edx,%ecx
    if(*s == c)
 1d3:	38 d3                	cmp    %dl,%bl
 1d5:	75 0d                	jne    1e4 <strchr+0x24>
 1d7:	eb 17                	jmp    1f0 <strchr+0x30>
 1d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1e0:	38 ca                	cmp    %cl,%dl
 1e2:	74 0c                	je     1f0 <strchr+0x30>
  for(; *s; s++)
 1e4:	83 c0 01             	add    $0x1,%eax
 1e7:	0f b6 10             	movzbl (%eax),%edx
 1ea:	84 d2                	test   %dl,%dl
 1ec:	75 f2                	jne    1e0 <strchr+0x20>
      return (char*)s;
  return 0;
 1ee:	31 c0                	xor    %eax,%eax
}
 1f0:	5b                   	pop    %ebx
 1f1:	5d                   	pop    %ebp
 1f2:	c3                   	ret    
 1f3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000200 <gets>:

char*
gets(char *buf, int max)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	57                   	push   %edi
 204:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 205:	31 f6                	xor    %esi,%esi
{
 207:	53                   	push   %ebx
 208:	89 f3                	mov    %esi,%ebx
 20a:	83 ec 1c             	sub    $0x1c,%esp
 20d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 210:	eb 2f                	jmp    241 <gets+0x41>
 212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 218:	83 ec 04             	sub    $0x4,%esp
 21b:	8d 45 e7             	lea    -0x19(%ebp),%eax
 21e:	6a 01                	push   $0x1
 220:	50                   	push   %eax
 221:	6a 00                	push   $0x0
 223:	e8 d1 01 00 00       	call   3f9 <read>
    if(cc < 1)
 228:	83 c4 10             	add    $0x10,%esp
 22b:	85 c0                	test   %eax,%eax
 22d:	7e 1c                	jle    24b <gets+0x4b>
      break;
    buf[i++] = c;
 22f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 233:	83 c7 01             	add    $0x1,%edi
 236:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 239:	3c 0a                	cmp    $0xa,%al
 23b:	74 23                	je     260 <gets+0x60>
 23d:	3c 0d                	cmp    $0xd,%al
 23f:	74 1f                	je     260 <gets+0x60>
  for(i=0; i+1 < max; ){
 241:	83 c3 01             	add    $0x1,%ebx
 244:	89 fe                	mov    %edi,%esi
 246:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 249:	7c cd                	jl     218 <gets+0x18>
 24b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 24d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 250:	c6 03 00             	movb   $0x0,(%ebx)
}
 253:	8d 65 f4             	lea    -0xc(%ebp),%esp
 256:	5b                   	pop    %ebx
 257:	5e                   	pop    %esi
 258:	5f                   	pop    %edi
 259:	5d                   	pop    %ebp
 25a:	c3                   	ret    
 25b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 25f:	90                   	nop
 260:	8b 75 08             	mov    0x8(%ebp),%esi
 263:	8b 45 08             	mov    0x8(%ebp),%eax
 266:	01 de                	add    %ebx,%esi
 268:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 26a:	c6 03 00             	movb   $0x0,(%ebx)
}
 26d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 270:	5b                   	pop    %ebx
 271:	5e                   	pop    %esi
 272:	5f                   	pop    %edi
 273:	5d                   	pop    %ebp
 274:	c3                   	ret    
 275:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000280 <stat>:

int
stat(char *n, struct stat *st)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	56                   	push   %esi
 284:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 285:	83 ec 08             	sub    $0x8,%esp
 288:	6a 00                	push   $0x0
 28a:	ff 75 08             	pushl  0x8(%ebp)
 28d:	e8 8f 01 00 00       	call   421 <open>
  if(fd < 0)
 292:	83 c4 10             	add    $0x10,%esp
 295:	85 c0                	test   %eax,%eax
 297:	78 27                	js     2c0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 299:	83 ec 08             	sub    $0x8,%esp
 29c:	ff 75 0c             	pushl  0xc(%ebp)
 29f:	89 c3                	mov    %eax,%ebx
 2a1:	50                   	push   %eax
 2a2:	e8 92 01 00 00       	call   439 <fstat>
  close(fd);
 2a7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2aa:	89 c6                	mov    %eax,%esi
  close(fd);
 2ac:	e8 58 01 00 00       	call   409 <close>
  return r;
 2b1:	83 c4 10             	add    $0x10,%esp
}
 2b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2b7:	89 f0                	mov    %esi,%eax
 2b9:	5b                   	pop    %ebx
 2ba:	5e                   	pop    %esi
 2bb:	5d                   	pop    %ebp
 2bc:	c3                   	ret    
 2bd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2c5:	eb ed                	jmp    2b4 <stat+0x34>
 2c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ce:	66 90                	xchg   %ax,%ax

000002d0 <atoi>:

#ifdef PDX_XV6
int
atoi(const char *s)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	56                   	push   %esi
 2d4:	8b 55 08             	mov    0x8(%ebp),%edx
 2d7:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 2d8:	0f b6 0a             	movzbl (%edx),%ecx
 2db:	80 f9 20             	cmp    $0x20,%cl
 2de:	75 0b                	jne    2eb <atoi+0x1b>
 2e0:	83 c2 01             	add    $0x1,%edx
 2e3:	0f b6 0a             	movzbl (%edx),%ecx
 2e6:	80 f9 20             	cmp    $0x20,%cl
 2e9:	74 f5                	je     2e0 <atoi+0x10>
  sign = (*s == '-') ? -1 : 1;
 2eb:	80 f9 2d             	cmp    $0x2d,%cl
 2ee:	74 40                	je     330 <atoi+0x60>
 2f0:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 2f5:	80 f9 2b             	cmp    $0x2b,%cl
 2f8:	74 3b                	je     335 <atoi+0x65>
    s++;
  while('0' <= *s && *s <= '9')
 2fa:	0f be 0a             	movsbl (%edx),%ecx
 2fd:	8d 41 d0             	lea    -0x30(%ecx),%eax
 300:	3c 09                	cmp    $0x9,%al
 302:	b8 00 00 00 00       	mov    $0x0,%eax
 307:	77 1f                	ja     328 <atoi+0x58>
 309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 310:	83 c2 01             	add    $0x1,%edx
 313:	8d 04 80             	lea    (%eax,%eax,4),%eax
 316:	8d 44 41 d0          	lea    -0x30(%ecx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 31a:	0f be 0a             	movsbl (%edx),%ecx
 31d:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 320:	80 fb 09             	cmp    $0x9,%bl
 323:	76 eb                	jbe    310 <atoi+0x40>
 325:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 328:	5b                   	pop    %ebx
 329:	5e                   	pop    %esi
 32a:	5d                   	pop    %ebp
 32b:	c3                   	ret    
 32c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 330:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 335:	83 c2 01             	add    $0x1,%edx
 338:	eb c0                	jmp    2fa <atoi+0x2a>
 33a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000340 <atoo>:

int
atoo(const char *s)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	56                   	push   %esi
 344:	8b 55 08             	mov    0x8(%ebp),%edx
 347:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 348:	0f b6 0a             	movzbl (%edx),%ecx
 34b:	80 f9 20             	cmp    $0x20,%cl
 34e:	75 0b                	jne    35b <atoo+0x1b>
 350:	83 c2 01             	add    $0x1,%edx
 353:	0f b6 0a             	movzbl (%edx),%ecx
 356:	80 f9 20             	cmp    $0x20,%cl
 359:	74 f5                	je     350 <atoo+0x10>
  sign = (*s == '-') ? -1 : 1;
 35b:	80 f9 2d             	cmp    $0x2d,%cl
 35e:	74 40                	je     3a0 <atoo+0x60>
 360:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 365:	80 f9 2b             	cmp    $0x2b,%cl
 368:	74 3b                	je     3a5 <atoo+0x65>
    s++;
  while('0' <= *s && *s <= '7')
 36a:	0f be 0a             	movsbl (%edx),%ecx
 36d:	8d 41 d0             	lea    -0x30(%ecx),%eax
 370:	3c 07                	cmp    $0x7,%al
 372:	b8 00 00 00 00       	mov    $0x0,%eax
 377:	77 1c                	ja     395 <atoo+0x55>
 379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*8 + *s++ - '0';
 380:	83 c2 01             	add    $0x1,%edx
 383:	8d 44 c1 d0          	lea    -0x30(%ecx,%eax,8),%eax
  while('0' <= *s && *s <= '7')
 387:	0f be 0a             	movsbl (%edx),%ecx
 38a:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 38d:	80 fb 07             	cmp    $0x7,%bl
 390:	76 ee                	jbe    380 <atoo+0x40>
 392:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 395:	5b                   	pop    %ebx
 396:	5e                   	pop    %esi
 397:	5d                   	pop    %ebp
 398:	c3                   	ret    
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 3a0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 3a5:	83 c2 01             	add    $0x1,%edx
 3a8:	eb c0                	jmp    36a <atoo+0x2a>
 3aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003b0 <memmove>:
}
#endif // PDX_XV6

void*
memmove(void *vdst, void *vsrc, int n)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	57                   	push   %edi
 3b4:	8b 55 10             	mov    0x10(%ebp),%edx
 3b7:	8b 45 08             	mov    0x8(%ebp),%eax
 3ba:	56                   	push   %esi
 3bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3be:	85 d2                	test   %edx,%edx
 3c0:	7e 13                	jle    3d5 <memmove+0x25>
 3c2:	01 c2                	add    %eax,%edx
  dst = vdst;
 3c4:	89 c7                	mov    %eax,%edi
 3c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 3d0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3d1:	39 fa                	cmp    %edi,%edx
 3d3:	75 fb                	jne    3d0 <memmove+0x20>
  return vdst;
}
 3d5:	5e                   	pop    %esi
 3d6:	5f                   	pop    %edi
 3d7:	5d                   	pop    %ebp
 3d8:	c3                   	ret    

000003d9 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3d9:	b8 01 00 00 00       	mov    $0x1,%eax
 3de:	cd 40                	int    $0x40
 3e0:	c3                   	ret    

000003e1 <exit>:
SYSCALL(exit)
 3e1:	b8 02 00 00 00       	mov    $0x2,%eax
 3e6:	cd 40                	int    $0x40
 3e8:	c3                   	ret    

000003e9 <wait>:
SYSCALL(wait)
 3e9:	b8 03 00 00 00       	mov    $0x3,%eax
 3ee:	cd 40                	int    $0x40
 3f0:	c3                   	ret    

000003f1 <pipe>:
SYSCALL(pipe)
 3f1:	b8 04 00 00 00       	mov    $0x4,%eax
 3f6:	cd 40                	int    $0x40
 3f8:	c3                   	ret    

000003f9 <read>:
SYSCALL(read)
 3f9:	b8 05 00 00 00       	mov    $0x5,%eax
 3fe:	cd 40                	int    $0x40
 400:	c3                   	ret    

00000401 <write>:
SYSCALL(write)
 401:	b8 10 00 00 00       	mov    $0x10,%eax
 406:	cd 40                	int    $0x40
 408:	c3                   	ret    

00000409 <close>:
SYSCALL(close)
 409:	b8 15 00 00 00       	mov    $0x15,%eax
 40e:	cd 40                	int    $0x40
 410:	c3                   	ret    

00000411 <kill>:
SYSCALL(kill)
 411:	b8 06 00 00 00       	mov    $0x6,%eax
 416:	cd 40                	int    $0x40
 418:	c3                   	ret    

00000419 <exec>:
SYSCALL(exec)
 419:	b8 07 00 00 00       	mov    $0x7,%eax
 41e:	cd 40                	int    $0x40
 420:	c3                   	ret    

00000421 <open>:
SYSCALL(open)
 421:	b8 0f 00 00 00       	mov    $0xf,%eax
 426:	cd 40                	int    $0x40
 428:	c3                   	ret    

00000429 <mknod>:
SYSCALL(mknod)
 429:	b8 11 00 00 00       	mov    $0x11,%eax
 42e:	cd 40                	int    $0x40
 430:	c3                   	ret    

00000431 <unlink>:
SYSCALL(unlink)
 431:	b8 12 00 00 00       	mov    $0x12,%eax
 436:	cd 40                	int    $0x40
 438:	c3                   	ret    

00000439 <fstat>:
SYSCALL(fstat)
 439:	b8 08 00 00 00       	mov    $0x8,%eax
 43e:	cd 40                	int    $0x40
 440:	c3                   	ret    

00000441 <link>:
SYSCALL(link)
 441:	b8 13 00 00 00       	mov    $0x13,%eax
 446:	cd 40                	int    $0x40
 448:	c3                   	ret    

00000449 <mkdir>:
SYSCALL(mkdir)
 449:	b8 14 00 00 00       	mov    $0x14,%eax
 44e:	cd 40                	int    $0x40
 450:	c3                   	ret    

00000451 <chdir>:
SYSCALL(chdir)
 451:	b8 09 00 00 00       	mov    $0x9,%eax
 456:	cd 40                	int    $0x40
 458:	c3                   	ret    

00000459 <dup>:
SYSCALL(dup)
 459:	b8 0a 00 00 00       	mov    $0xa,%eax
 45e:	cd 40                	int    $0x40
 460:	c3                   	ret    

00000461 <getpid>:
SYSCALL(getpid)
 461:	b8 0b 00 00 00       	mov    $0xb,%eax
 466:	cd 40                	int    $0x40
 468:	c3                   	ret    

00000469 <sbrk>:
SYSCALL(sbrk)
 469:	b8 0c 00 00 00       	mov    $0xc,%eax
 46e:	cd 40                	int    $0x40
 470:	c3                   	ret    

00000471 <sleep>:
SYSCALL(sleep)
 471:	b8 0d 00 00 00       	mov    $0xd,%eax
 476:	cd 40                	int    $0x40
 478:	c3                   	ret    

00000479 <uptime>:
SYSCALL(uptime)
 479:	b8 0e 00 00 00       	mov    $0xe,%eax
 47e:	cd 40                	int    $0x40
 480:	c3                   	ret    

00000481 <halt>:
SYSCALL(halt)
 481:	b8 16 00 00 00       	mov    $0x16,%eax
 486:	cd 40                	int    $0x40
 488:	c3                   	ret    

00000489 <date>:
SYSCALL(date)
 489:	b8 17 00 00 00       	mov    $0x17,%eax
 48e:	cd 40                	int    $0x40
 490:	c3                   	ret    

00000491 <getgid>:
SYSCALL(getgid)
 491:	b8 18 00 00 00       	mov    $0x18,%eax
 496:	cd 40                	int    $0x40
 498:	c3                   	ret    

00000499 <setgid>:
SYSCALL(setgid)
 499:	b8 19 00 00 00       	mov    $0x19,%eax
 49e:	cd 40                	int    $0x40
 4a0:	c3                   	ret    

000004a1 <getuid>:
SYSCALL(getuid)
 4a1:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4a6:	cd 40                	int    $0x40
 4a8:	c3                   	ret    

000004a9 <setuid>:
SYSCALL(setuid)
 4a9:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4ae:	cd 40                	int    $0x40
 4b0:	c3                   	ret    

000004b1 <getppid>:
SYSCALL(getppid)
 4b1:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4b6:	cd 40                	int    $0x40
 4b8:	c3                   	ret    

000004b9 <getprocs>:
SYSCALL(getprocs)
 4b9:	b8 1d 00 00 00       	mov    $0x1d,%eax
 4be:	cd 40                	int    $0x40
 4c0:	c3                   	ret    

000004c1 <setpriority>:
SYSCALL(setpriority)
 4c1:	b8 1e 00 00 00       	mov    $0x1e,%eax
 4c6:	cd 40                	int    $0x40
 4c8:	c3                   	ret    

000004c9 <getpriority>:
SYSCALL(getpriority)
 4c9:	b8 1f 00 00 00       	mov    $0x1f,%eax
 4ce:	cd 40                	int    $0x40
 4d0:	c3                   	ret    

000004d1 <chmod>:
SYSCALL(chmod)
 4d1:	b8 20 00 00 00       	mov    $0x20,%eax
 4d6:	cd 40                	int    $0x40
 4d8:	c3                   	ret    

000004d9 <chown>:
SYSCALL(chown)
 4d9:	b8 21 00 00 00       	mov    $0x21,%eax
 4de:	cd 40                	int    $0x40
 4e0:	c3                   	ret    

000004e1 <chgrp>:
SYSCALL(chgrp)
 4e1:	b8 22 00 00 00       	mov    $0x22,%eax
 4e6:	cd 40                	int    $0x40
 4e8:	c3                   	ret    
 4e9:	66 90                	xchg   %ax,%ax
 4eb:	66 90                	xchg   %ax,%ax
 4ed:	66 90                	xchg   %ax,%ax
 4ef:	90                   	nop

000004f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	57                   	push   %edi
 4f4:	56                   	push   %esi
 4f5:	53                   	push   %ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4f6:	89 d3                	mov    %edx,%ebx
{
 4f8:	83 ec 3c             	sub    $0x3c,%esp
 4fb:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 4fe:	85 d2                	test   %edx,%edx
 500:	0f 89 92 00 00 00    	jns    598 <printint+0xa8>
 506:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 50a:	0f 84 88 00 00 00    	je     598 <printint+0xa8>
    neg = 1;
 510:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 517:	f7 db                	neg    %ebx
  } else {
    x = xx;
  }

  i = 0;
 519:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 520:	8d 75 d7             	lea    -0x29(%ebp),%esi
 523:	eb 08                	jmp    52d <printint+0x3d>
 525:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 528:	89 7d c4             	mov    %edi,-0x3c(%ebp)
  }while((x /= base) != 0);
 52b:	89 c3                	mov    %eax,%ebx
    buf[i++] = digits[x % base];
 52d:	89 d8                	mov    %ebx,%eax
 52f:	31 d2                	xor    %edx,%edx
 531:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 534:	f7 f1                	div    %ecx
 536:	83 c7 01             	add    $0x1,%edi
 539:	0f b6 92 70 09 00 00 	movzbl 0x970(%edx),%edx
 540:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 543:	39 d9                	cmp    %ebx,%ecx
 545:	76 e1                	jbe    528 <printint+0x38>
  if(neg)
 547:	8b 45 c0             	mov    -0x40(%ebp),%eax
 54a:	85 c0                	test   %eax,%eax
 54c:	74 0d                	je     55b <printint+0x6b>
    buf[i++] = '-';
 54e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 553:	ba 2d 00 00 00       	mov    $0x2d,%edx
    buf[i++] = digits[x % base];
 558:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 55b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 55e:	8b 7d bc             	mov    -0x44(%ebp),%edi
 561:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 565:	eb 0f                	jmp    576 <printint+0x86>
 567:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 56e:	66 90                	xchg   %ax,%ax
 570:	0f b6 13             	movzbl (%ebx),%edx
 573:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 576:	83 ec 04             	sub    $0x4,%esp
 579:	88 55 d7             	mov    %dl,-0x29(%ebp)
 57c:	6a 01                	push   $0x1
 57e:	56                   	push   %esi
 57f:	57                   	push   %edi
 580:	e8 7c fe ff ff       	call   401 <write>

  while(--i >= 0)
 585:	83 c4 10             	add    $0x10,%esp
 588:	39 de                	cmp    %ebx,%esi
 58a:	75 e4                	jne    570 <printint+0x80>
    putc(fd, buf[i]);
}
 58c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 58f:	5b                   	pop    %ebx
 590:	5e                   	pop    %esi
 591:	5f                   	pop    %edi
 592:	5d                   	pop    %ebp
 593:	c3                   	ret    
 594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 598:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 59f:	e9 75 ff ff ff       	jmp    519 <printint+0x29>
 5a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5af:	90                   	nop

000005b0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	57                   	push   %edi
 5b4:	56                   	push   %esi
 5b5:	53                   	push   %ebx
 5b6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5b9:	8b 75 0c             	mov    0xc(%ebp),%esi
 5bc:	0f b6 1e             	movzbl (%esi),%ebx
 5bf:	84 db                	test   %bl,%bl
 5c1:	0f 84 b9 00 00 00    	je     680 <printf+0xd0>
  ap = (uint*)(void*)&fmt + 1;
 5c7:	8d 45 10             	lea    0x10(%ebp),%eax
 5ca:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 5cd:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 5d0:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 5d2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5d5:	eb 38                	jmp    60f <printf+0x5f>
 5d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5de:	66 90                	xchg   %ax,%ax
 5e0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 5e3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 5e8:	83 f8 25             	cmp    $0x25,%eax
 5eb:	74 17                	je     604 <printf+0x54>
  write(fd, &c, 1);
 5ed:	83 ec 04             	sub    $0x4,%esp
 5f0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5f3:	6a 01                	push   $0x1
 5f5:	57                   	push   %edi
 5f6:	ff 75 08             	pushl  0x8(%ebp)
 5f9:	e8 03 fe ff ff       	call   401 <write>
 5fe:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 601:	83 c4 10             	add    $0x10,%esp
 604:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 607:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 60b:	84 db                	test   %bl,%bl
 60d:	74 71                	je     680 <printf+0xd0>
    c = fmt[i] & 0xff;
 60f:	0f be cb             	movsbl %bl,%ecx
 612:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 615:	85 d2                	test   %edx,%edx
 617:	74 c7                	je     5e0 <printf+0x30>
      }
    } else if(state == '%'){
 619:	83 fa 25             	cmp    $0x25,%edx
 61c:	75 e6                	jne    604 <printf+0x54>
      if(c == 'd'){
 61e:	83 f8 64             	cmp    $0x64,%eax
 621:	0f 84 99 00 00 00    	je     6c0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 627:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 62d:	83 f9 70             	cmp    $0x70,%ecx
 630:	74 5e                	je     690 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 632:	83 f8 73             	cmp    $0x73,%eax
 635:	0f 84 d5 00 00 00    	je     710 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 63b:	83 f8 63             	cmp    $0x63,%eax
 63e:	0f 84 8c 00 00 00    	je     6d0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 644:	83 f8 25             	cmp    $0x25,%eax
 647:	0f 84 b3 00 00 00    	je     700 <printf+0x150>
  write(fd, &c, 1);
 64d:	83 ec 04             	sub    $0x4,%esp
 650:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 654:	6a 01                	push   $0x1
 656:	57                   	push   %edi
 657:	ff 75 08             	pushl  0x8(%ebp)
 65a:	e8 a2 fd ff ff       	call   401 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 65f:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 662:	83 c4 0c             	add    $0xc,%esp
 665:	6a 01                	push   $0x1
 667:	83 c6 01             	add    $0x1,%esi
 66a:	57                   	push   %edi
 66b:	ff 75 08             	pushl  0x8(%ebp)
 66e:	e8 8e fd ff ff       	call   401 <write>
  for(i = 0; fmt[i]; i++){
 673:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 677:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 67a:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 67c:	84 db                	test   %bl,%bl
 67e:	75 8f                	jne    60f <printf+0x5f>
    }
  }
}
 680:	8d 65 f4             	lea    -0xc(%ebp),%esp
 683:	5b                   	pop    %ebx
 684:	5e                   	pop    %esi
 685:	5f                   	pop    %edi
 686:	5d                   	pop    %ebp
 687:	c3                   	ret    
 688:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 68f:	90                   	nop
        printint(fd, *ap, 16, 0);
 690:	83 ec 0c             	sub    $0xc,%esp
 693:	b9 10 00 00 00       	mov    $0x10,%ecx
 698:	6a 00                	push   $0x0
 69a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 69d:	8b 45 08             	mov    0x8(%ebp),%eax
 6a0:	8b 13                	mov    (%ebx),%edx
 6a2:	e8 49 fe ff ff       	call   4f0 <printint>
        ap++;
 6a7:	89 d8                	mov    %ebx,%eax
 6a9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6ac:	31 d2                	xor    %edx,%edx
        ap++;
 6ae:	83 c0 04             	add    $0x4,%eax
 6b1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6b4:	e9 4b ff ff ff       	jmp    604 <printf+0x54>
 6b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 6c0:	83 ec 0c             	sub    $0xc,%esp
 6c3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6c8:	6a 01                	push   $0x1
 6ca:	eb ce                	jmp    69a <printf+0xea>
 6cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 6d0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 6d3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 6d6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 6d8:	6a 01                	push   $0x1
        ap++;
 6da:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 6dd:	57                   	push   %edi
 6de:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 6e1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6e4:	e8 18 fd ff ff       	call   401 <write>
        ap++;
 6e9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6ec:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6ef:	31 d2                	xor    %edx,%edx
 6f1:	e9 0e ff ff ff       	jmp    604 <printf+0x54>
 6f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6fd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 700:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 703:	83 ec 04             	sub    $0x4,%esp
 706:	e9 5a ff ff ff       	jmp    665 <printf+0xb5>
 70b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 70f:	90                   	nop
        s = (char*)*ap;
 710:	8b 45 d0             	mov    -0x30(%ebp),%eax
 713:	8b 18                	mov    (%eax),%ebx
        ap++;
 715:	83 c0 04             	add    $0x4,%eax
 718:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 71b:	85 db                	test   %ebx,%ebx
 71d:	74 17                	je     736 <printf+0x186>
        while(*s != 0){
 71f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 722:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 724:	84 c0                	test   %al,%al
 726:	0f 84 d8 fe ff ff    	je     604 <printf+0x54>
 72c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 72f:	89 de                	mov    %ebx,%esi
 731:	8b 5d 08             	mov    0x8(%ebp),%ebx
 734:	eb 1a                	jmp    750 <printf+0x1a0>
          s = "(null)";
 736:	bb 68 09 00 00       	mov    $0x968,%ebx
        while(*s != 0){
 73b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 73e:	b8 28 00 00 00       	mov    $0x28,%eax
 743:	89 de                	mov    %ebx,%esi
 745:	8b 5d 08             	mov    0x8(%ebp),%ebx
 748:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 74f:	90                   	nop
  write(fd, &c, 1);
 750:	83 ec 04             	sub    $0x4,%esp
          s++;
 753:	83 c6 01             	add    $0x1,%esi
 756:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 759:	6a 01                	push   $0x1
 75b:	57                   	push   %edi
 75c:	53                   	push   %ebx
 75d:	e8 9f fc ff ff       	call   401 <write>
        while(*s != 0){
 762:	0f b6 06             	movzbl (%esi),%eax
 765:	83 c4 10             	add    $0x10,%esp
 768:	84 c0                	test   %al,%al
 76a:	75 e4                	jne    750 <printf+0x1a0>
 76c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 76f:	31 d2                	xor    %edx,%edx
 771:	e9 8e fe ff ff       	jmp    604 <printf+0x54>
 776:	66 90                	xchg   %ax,%ax
 778:	66 90                	xchg   %ax,%ax
 77a:	66 90                	xchg   %ax,%ax
 77c:	66 90                	xchg   %ax,%ax
 77e:	66 90                	xchg   %ax,%ax

00000780 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 780:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 781:	a1 58 0c 00 00       	mov    0xc58,%eax
{
 786:	89 e5                	mov    %esp,%ebp
 788:	57                   	push   %edi
 789:	56                   	push   %esi
 78a:	53                   	push   %ebx
 78b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 78e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 790:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 793:	39 c8                	cmp    %ecx,%eax
 795:	73 19                	jae    7b0 <free+0x30>
 797:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 79e:	66 90                	xchg   %ax,%ax
 7a0:	39 d1                	cmp    %edx,%ecx
 7a2:	72 14                	jb     7b8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a4:	39 d0                	cmp    %edx,%eax
 7a6:	73 10                	jae    7b8 <free+0x38>
{
 7a8:	89 d0                	mov    %edx,%eax
 7aa:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ac:	39 c8                	cmp    %ecx,%eax
 7ae:	72 f0                	jb     7a0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7b0:	39 d0                	cmp    %edx,%eax
 7b2:	72 f4                	jb     7a8 <free+0x28>
 7b4:	39 d1                	cmp    %edx,%ecx
 7b6:	73 f0                	jae    7a8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7b8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7bb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7be:	39 fa                	cmp    %edi,%edx
 7c0:	74 1e                	je     7e0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7c2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7c5:	8b 50 04             	mov    0x4(%eax),%edx
 7c8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7cb:	39 f1                	cmp    %esi,%ecx
 7cd:	74 28                	je     7f7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7cf:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 7d1:	5b                   	pop    %ebx
  freep = p;
 7d2:	a3 58 0c 00 00       	mov    %eax,0xc58
}
 7d7:	5e                   	pop    %esi
 7d8:	5f                   	pop    %edi
 7d9:	5d                   	pop    %ebp
 7da:	c3                   	ret    
 7db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7df:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 7e0:	03 72 04             	add    0x4(%edx),%esi
 7e3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7e6:	8b 10                	mov    (%eax),%edx
 7e8:	8b 12                	mov    (%edx),%edx
 7ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7ed:	8b 50 04             	mov    0x4(%eax),%edx
 7f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7f3:	39 f1                	cmp    %esi,%ecx
 7f5:	75 d8                	jne    7cf <free+0x4f>
    p->s.size += bp->s.size;
 7f7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 7fa:	a3 58 0c 00 00       	mov    %eax,0xc58
    p->s.size += bp->s.size;
 7ff:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 802:	8b 53 f8             	mov    -0x8(%ebx),%edx
 805:	89 10                	mov    %edx,(%eax)
}
 807:	5b                   	pop    %ebx
 808:	5e                   	pop    %esi
 809:	5f                   	pop    %edi
 80a:	5d                   	pop    %ebp
 80b:	c3                   	ret    
 80c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000810 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 810:	55                   	push   %ebp
 811:	89 e5                	mov    %esp,%ebp
 813:	57                   	push   %edi
 814:	56                   	push   %esi
 815:	53                   	push   %ebx
 816:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 819:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 81c:	8b 3d 58 0c 00 00    	mov    0xc58,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 822:	8d 70 07             	lea    0x7(%eax),%esi
 825:	c1 ee 03             	shr    $0x3,%esi
 828:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 82b:	85 ff                	test   %edi,%edi
 82d:	0f 84 ad 00 00 00    	je     8e0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 833:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 835:	8b 4a 04             	mov    0x4(%edx),%ecx
 838:	39 f1                	cmp    %esi,%ecx
 83a:	73 72                	jae    8ae <malloc+0x9e>
 83c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 842:	bb 00 10 00 00       	mov    $0x1000,%ebx
 847:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 84a:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 851:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 854:	eb 1b                	jmp    871 <malloc+0x61>
 856:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 85d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 860:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 862:	8b 48 04             	mov    0x4(%eax),%ecx
 865:	39 f1                	cmp    %esi,%ecx
 867:	73 4f                	jae    8b8 <malloc+0xa8>
 869:	8b 3d 58 0c 00 00    	mov    0xc58,%edi
 86f:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 871:	39 d7                	cmp    %edx,%edi
 873:	75 eb                	jne    860 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 875:	83 ec 0c             	sub    $0xc,%esp
 878:	ff 75 e4             	pushl  -0x1c(%ebp)
 87b:	e8 e9 fb ff ff       	call   469 <sbrk>
  if(p == (char*)-1)
 880:	83 c4 10             	add    $0x10,%esp
 883:	83 f8 ff             	cmp    $0xffffffff,%eax
 886:	74 1c                	je     8a4 <malloc+0x94>
  hp->s.size = nu;
 888:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 88b:	83 ec 0c             	sub    $0xc,%esp
 88e:	83 c0 08             	add    $0x8,%eax
 891:	50                   	push   %eax
 892:	e8 e9 fe ff ff       	call   780 <free>
  return freep;
 897:	8b 15 58 0c 00 00    	mov    0xc58,%edx
      if((p = morecore(nunits)) == 0)
 89d:	83 c4 10             	add    $0x10,%esp
 8a0:	85 d2                	test   %edx,%edx
 8a2:	75 bc                	jne    860 <malloc+0x50>
        return 0;
  }
}
 8a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 8a7:	31 c0                	xor    %eax,%eax
}
 8a9:	5b                   	pop    %ebx
 8aa:	5e                   	pop    %esi
 8ab:	5f                   	pop    %edi
 8ac:	5d                   	pop    %ebp
 8ad:	c3                   	ret    
    if(p->s.size >= nunits){
 8ae:	89 d0                	mov    %edx,%eax
 8b0:	89 fa                	mov    %edi,%edx
 8b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 8b8:	39 ce                	cmp    %ecx,%esi
 8ba:	74 54                	je     910 <malloc+0x100>
        p->s.size -= nunits;
 8bc:	29 f1                	sub    %esi,%ecx
 8be:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 8c1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 8c4:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 8c7:	89 15 58 0c 00 00    	mov    %edx,0xc58
}
 8cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 8d0:	83 c0 08             	add    $0x8,%eax
}
 8d3:	5b                   	pop    %ebx
 8d4:	5e                   	pop    %esi
 8d5:	5f                   	pop    %edi
 8d6:	5d                   	pop    %ebp
 8d7:	c3                   	ret    
 8d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8df:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 8e0:	c7 05 58 0c 00 00 5c 	movl   $0xc5c,0xc58
 8e7:	0c 00 00 
    base.s.size = 0;
 8ea:	bf 5c 0c 00 00       	mov    $0xc5c,%edi
    base.s.ptr = freep = prevp = &base;
 8ef:	c7 05 5c 0c 00 00 5c 	movl   $0xc5c,0xc5c
 8f6:	0c 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 8fb:	c7 05 60 0c 00 00 00 	movl   $0x0,0xc60
 902:	00 00 00 
    if(p->s.size >= nunits){
 905:	e9 32 ff ff ff       	jmp    83c <malloc+0x2c>
 90a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 910:	8b 08                	mov    (%eax),%ecx
 912:	89 0a                	mov    %ecx,(%edx)
 914:	eb b1                	jmp    8c7 <malloc+0xb7>
