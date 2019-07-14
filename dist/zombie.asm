
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
  11:	e8 03 03 00 00       	call   319 <fork>
  16:	85 c0                	test   %eax,%eax
  18:	7e 0d                	jle    27 <main+0x27>
    sleep(5);  // Let child exit before parent.
  1a:	83 ec 0c             	sub    $0xc,%esp
  1d:	6a 05                	push   $0x5
  1f:	e8 8d 03 00 00       	call   3b1 <sleep>
  24:	83 c4 10             	add    $0x10,%esp
  exit();
  27:	e8 f5 02 00 00       	call   321 <exit>
  2c:	66 90                	xchg   %ax,%ax
  2e:	66 90                	xchg   %ax,%ax

00000030 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  30:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  31:	31 d2                	xor    %edx,%edx
{
  33:	89 e5                	mov    %esp,%ebp
  35:	53                   	push   %ebx
  36:	8b 45 08             	mov    0x8(%ebp),%eax
  39:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  40:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
  44:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  47:	83 c2 01             	add    $0x1,%edx
  4a:	84 c9                	test   %cl,%cl
  4c:	75 f2                	jne    40 <strcpy+0x10>
    ;
  return os;
}
  4e:	5b                   	pop    %ebx
  4f:	5d                   	pop    %ebp
  50:	c3                   	ret    
  51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  5f:	90                   	nop

00000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	56                   	push   %esi
  64:	53                   	push   %ebx
  65:	8b 5d 08             	mov    0x8(%ebp),%ebx
  68:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(*p && *p == *q)
  6b:	0f b6 13             	movzbl (%ebx),%edx
  6e:	0f b6 0e             	movzbl (%esi),%ecx
  71:	84 d2                	test   %dl,%dl
  73:	74 1e                	je     93 <strcmp+0x33>
  75:	b8 01 00 00 00       	mov    $0x1,%eax
  7a:	38 ca                	cmp    %cl,%dl
  7c:	74 09                	je     87 <strcmp+0x27>
  7e:	eb 20                	jmp    a0 <strcmp+0x40>
  80:	83 c0 01             	add    $0x1,%eax
  83:	38 ca                	cmp    %cl,%dl
  85:	75 19                	jne    a0 <strcmp+0x40>
  87:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  8b:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
  8f:	84 d2                	test   %dl,%dl
  91:	75 ed                	jne    80 <strcmp+0x20>
  93:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  95:	5b                   	pop    %ebx
  96:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
  97:	29 c8                	sub    %ecx,%eax
}
  99:	5d                   	pop    %ebp
  9a:	c3                   	ret    
  9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  9f:	90                   	nop
  a0:	0f b6 c2             	movzbl %dl,%eax
  a3:	5b                   	pop    %ebx
  a4:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
  a5:	29 c8                	sub    %ecx,%eax
}
  a7:	5d                   	pop    %ebp
  a8:	c3                   	ret    
  a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000b0 <strlen>:

uint
strlen(char *s)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  b6:	80 39 00             	cmpb   $0x0,(%ecx)
  b9:	74 15                	je     d0 <strlen+0x20>
  bb:	31 d2                	xor    %edx,%edx
  bd:	8d 76 00             	lea    0x0(%esi),%esi
  c0:	83 c2 01             	add    $0x1,%edx
  c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  c7:	89 d0                	mov    %edx,%eax
  c9:	75 f5                	jne    c0 <strlen+0x10>
    ;
  return n;
}
  cb:	5d                   	pop    %ebp
  cc:	c3                   	ret    
  cd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
  d0:	31 c0                	xor    %eax,%eax
}
  d2:	5d                   	pop    %ebp
  d3:	c3                   	ret    
  d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  df:	90                   	nop

000000e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	57                   	push   %edi
  e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  ed:	89 d7                	mov    %edx,%edi
  ef:	fc                   	cld    
  f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  f2:	89 d0                	mov    %edx,%eax
  f4:	5f                   	pop    %edi
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  fe:	66 90                	xchg   %ax,%ax

00000100 <strchr>:

char*
strchr(const char *s, char c)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	53                   	push   %ebx
 104:	8b 45 08             	mov    0x8(%ebp),%eax
 107:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 10a:	0f b6 18             	movzbl (%eax),%ebx
 10d:	84 db                	test   %bl,%bl
 10f:	74 1d                	je     12e <strchr+0x2e>
 111:	89 d1                	mov    %edx,%ecx
    if(*s == c)
 113:	38 d3                	cmp    %dl,%bl
 115:	75 0d                	jne    124 <strchr+0x24>
 117:	eb 17                	jmp    130 <strchr+0x30>
 119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 120:	38 ca                	cmp    %cl,%dl
 122:	74 0c                	je     130 <strchr+0x30>
  for(; *s; s++)
 124:	83 c0 01             	add    $0x1,%eax
 127:	0f b6 10             	movzbl (%eax),%edx
 12a:	84 d2                	test   %dl,%dl
 12c:	75 f2                	jne    120 <strchr+0x20>
      return (char*)s;
  return 0;
 12e:	31 c0                	xor    %eax,%eax
}
 130:	5b                   	pop    %ebx
 131:	5d                   	pop    %ebp
 132:	c3                   	ret    
 133:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000140 <gets>:

char*
gets(char *buf, int max)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 145:	31 f6                	xor    %esi,%esi
{
 147:	53                   	push   %ebx
 148:	89 f3                	mov    %esi,%ebx
 14a:	83 ec 1c             	sub    $0x1c,%esp
 14d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 150:	eb 2f                	jmp    181 <gets+0x41>
 152:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 158:	83 ec 04             	sub    $0x4,%esp
 15b:	8d 45 e7             	lea    -0x19(%ebp),%eax
 15e:	6a 01                	push   $0x1
 160:	50                   	push   %eax
 161:	6a 00                	push   $0x0
 163:	e8 d1 01 00 00       	call   339 <read>
    if(cc < 1)
 168:	83 c4 10             	add    $0x10,%esp
 16b:	85 c0                	test   %eax,%eax
 16d:	7e 1c                	jle    18b <gets+0x4b>
      break;
    buf[i++] = c;
 16f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 173:	83 c7 01             	add    $0x1,%edi
 176:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 179:	3c 0a                	cmp    $0xa,%al
 17b:	74 23                	je     1a0 <gets+0x60>
 17d:	3c 0d                	cmp    $0xd,%al
 17f:	74 1f                	je     1a0 <gets+0x60>
  for(i=0; i+1 < max; ){
 181:	83 c3 01             	add    $0x1,%ebx
 184:	89 fe                	mov    %edi,%esi
 186:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 189:	7c cd                	jl     158 <gets+0x18>
 18b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 18d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 190:	c6 03 00             	movb   $0x0,(%ebx)
}
 193:	8d 65 f4             	lea    -0xc(%ebp),%esp
 196:	5b                   	pop    %ebx
 197:	5e                   	pop    %esi
 198:	5f                   	pop    %edi
 199:	5d                   	pop    %ebp
 19a:	c3                   	ret    
 19b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 19f:	90                   	nop
 1a0:	8b 75 08             	mov    0x8(%ebp),%esi
 1a3:	8b 45 08             	mov    0x8(%ebp),%eax
 1a6:	01 de                	add    %ebx,%esi
 1a8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 1aa:	c6 03 00             	movb   $0x0,(%ebx)
}
 1ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1b0:	5b                   	pop    %ebx
 1b1:	5e                   	pop    %esi
 1b2:	5f                   	pop    %edi
 1b3:	5d                   	pop    %ebp
 1b4:	c3                   	ret    
 1b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001c0 <stat>:

int
stat(char *n, struct stat *st)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	56                   	push   %esi
 1c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c5:	83 ec 08             	sub    $0x8,%esp
 1c8:	6a 00                	push   $0x0
 1ca:	ff 75 08             	pushl  0x8(%ebp)
 1cd:	e8 8f 01 00 00       	call   361 <open>
  if(fd < 0)
 1d2:	83 c4 10             	add    $0x10,%esp
 1d5:	85 c0                	test   %eax,%eax
 1d7:	78 27                	js     200 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1d9:	83 ec 08             	sub    $0x8,%esp
 1dc:	ff 75 0c             	pushl  0xc(%ebp)
 1df:	89 c3                	mov    %eax,%ebx
 1e1:	50                   	push   %eax
 1e2:	e8 92 01 00 00       	call   379 <fstat>
  close(fd);
 1e7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1ea:	89 c6                	mov    %eax,%esi
  close(fd);
 1ec:	e8 58 01 00 00       	call   349 <close>
  return r;
 1f1:	83 c4 10             	add    $0x10,%esp
}
 1f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1f7:	89 f0                	mov    %esi,%eax
 1f9:	5b                   	pop    %ebx
 1fa:	5e                   	pop    %esi
 1fb:	5d                   	pop    %ebp
 1fc:	c3                   	ret    
 1fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 200:	be ff ff ff ff       	mov    $0xffffffff,%esi
 205:	eb ed                	jmp    1f4 <stat+0x34>
 207:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 20e:	66 90                	xchg   %ax,%ax

00000210 <atoi>:

#ifdef PDX_XV6
int
atoi(const char *s)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	56                   	push   %esi
 214:	8b 55 08             	mov    0x8(%ebp),%edx
 217:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 218:	0f b6 0a             	movzbl (%edx),%ecx
 21b:	80 f9 20             	cmp    $0x20,%cl
 21e:	75 0b                	jne    22b <atoi+0x1b>
 220:	83 c2 01             	add    $0x1,%edx
 223:	0f b6 0a             	movzbl (%edx),%ecx
 226:	80 f9 20             	cmp    $0x20,%cl
 229:	74 f5                	je     220 <atoi+0x10>
  sign = (*s == '-') ? -1 : 1;
 22b:	80 f9 2d             	cmp    $0x2d,%cl
 22e:	74 40                	je     270 <atoi+0x60>
 230:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 235:	80 f9 2b             	cmp    $0x2b,%cl
 238:	74 3b                	je     275 <atoi+0x65>
    s++;
  while('0' <= *s && *s <= '9')
 23a:	0f be 0a             	movsbl (%edx),%ecx
 23d:	8d 41 d0             	lea    -0x30(%ecx),%eax
 240:	3c 09                	cmp    $0x9,%al
 242:	b8 00 00 00 00       	mov    $0x0,%eax
 247:	77 1f                	ja     268 <atoi+0x58>
 249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 250:	83 c2 01             	add    $0x1,%edx
 253:	8d 04 80             	lea    (%eax,%eax,4),%eax
 256:	8d 44 41 d0          	lea    -0x30(%ecx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 25a:	0f be 0a             	movsbl (%edx),%ecx
 25d:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 260:	80 fb 09             	cmp    $0x9,%bl
 263:	76 eb                	jbe    250 <atoi+0x40>
 265:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 268:	5b                   	pop    %ebx
 269:	5e                   	pop    %esi
 26a:	5d                   	pop    %ebp
 26b:	c3                   	ret    
 26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 270:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 275:	83 c2 01             	add    $0x1,%edx
 278:	eb c0                	jmp    23a <atoi+0x2a>
 27a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000280 <atoo>:

int
atoo(const char *s)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	56                   	push   %esi
 284:	8b 55 08             	mov    0x8(%ebp),%edx
 287:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 288:	0f b6 0a             	movzbl (%edx),%ecx
 28b:	80 f9 20             	cmp    $0x20,%cl
 28e:	75 0b                	jne    29b <atoo+0x1b>
 290:	83 c2 01             	add    $0x1,%edx
 293:	0f b6 0a             	movzbl (%edx),%ecx
 296:	80 f9 20             	cmp    $0x20,%cl
 299:	74 f5                	je     290 <atoo+0x10>
  sign = (*s == '-') ? -1 : 1;
 29b:	80 f9 2d             	cmp    $0x2d,%cl
 29e:	74 40                	je     2e0 <atoo+0x60>
 2a0:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 2a5:	80 f9 2b             	cmp    $0x2b,%cl
 2a8:	74 3b                	je     2e5 <atoo+0x65>
    s++;
  while('0' <= *s && *s <= '7')
 2aa:	0f be 0a             	movsbl (%edx),%ecx
 2ad:	8d 41 d0             	lea    -0x30(%ecx),%eax
 2b0:	3c 07                	cmp    $0x7,%al
 2b2:	b8 00 00 00 00       	mov    $0x0,%eax
 2b7:	77 1c                	ja     2d5 <atoo+0x55>
 2b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*8 + *s++ - '0';
 2c0:	83 c2 01             	add    $0x1,%edx
 2c3:	8d 44 c1 d0          	lea    -0x30(%ecx,%eax,8),%eax
  while('0' <= *s && *s <= '7')
 2c7:	0f be 0a             	movsbl (%edx),%ecx
 2ca:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 2cd:	80 fb 07             	cmp    $0x7,%bl
 2d0:	76 ee                	jbe    2c0 <atoo+0x40>
 2d2:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 2d5:	5b                   	pop    %ebx
 2d6:	5e                   	pop    %esi
 2d7:	5d                   	pop    %ebp
 2d8:	c3                   	ret    
 2d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 2e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 2e5:	83 c2 01             	add    $0x1,%edx
 2e8:	eb c0                	jmp    2aa <atoo+0x2a>
 2ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002f0 <memmove>:
}
#endif // PDX_XV6

void*
memmove(void *vdst, void *vsrc, int n)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	57                   	push   %edi
 2f4:	8b 55 10             	mov    0x10(%ebp),%edx
 2f7:	8b 45 08             	mov    0x8(%ebp),%eax
 2fa:	56                   	push   %esi
 2fb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2fe:	85 d2                	test   %edx,%edx
 300:	7e 13                	jle    315 <memmove+0x25>
 302:	01 c2                	add    %eax,%edx
  dst = vdst;
 304:	89 c7                	mov    %eax,%edi
 306:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 30d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 310:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 311:	39 fa                	cmp    %edi,%edx
 313:	75 fb                	jne    310 <memmove+0x20>
  return vdst;
}
 315:	5e                   	pop    %esi
 316:	5f                   	pop    %edi
 317:	5d                   	pop    %ebp
 318:	c3                   	ret    

00000319 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 319:	b8 01 00 00 00       	mov    $0x1,%eax
 31e:	cd 40                	int    $0x40
 320:	c3                   	ret    

00000321 <exit>:
SYSCALL(exit)
 321:	b8 02 00 00 00       	mov    $0x2,%eax
 326:	cd 40                	int    $0x40
 328:	c3                   	ret    

00000329 <wait>:
SYSCALL(wait)
 329:	b8 03 00 00 00       	mov    $0x3,%eax
 32e:	cd 40                	int    $0x40
 330:	c3                   	ret    

00000331 <pipe>:
SYSCALL(pipe)
 331:	b8 04 00 00 00       	mov    $0x4,%eax
 336:	cd 40                	int    $0x40
 338:	c3                   	ret    

00000339 <read>:
SYSCALL(read)
 339:	b8 05 00 00 00       	mov    $0x5,%eax
 33e:	cd 40                	int    $0x40
 340:	c3                   	ret    

00000341 <write>:
SYSCALL(write)
 341:	b8 10 00 00 00       	mov    $0x10,%eax
 346:	cd 40                	int    $0x40
 348:	c3                   	ret    

00000349 <close>:
SYSCALL(close)
 349:	b8 15 00 00 00       	mov    $0x15,%eax
 34e:	cd 40                	int    $0x40
 350:	c3                   	ret    

00000351 <kill>:
SYSCALL(kill)
 351:	b8 06 00 00 00       	mov    $0x6,%eax
 356:	cd 40                	int    $0x40
 358:	c3                   	ret    

00000359 <exec>:
SYSCALL(exec)
 359:	b8 07 00 00 00       	mov    $0x7,%eax
 35e:	cd 40                	int    $0x40
 360:	c3                   	ret    

00000361 <open>:
SYSCALL(open)
 361:	b8 0f 00 00 00       	mov    $0xf,%eax
 366:	cd 40                	int    $0x40
 368:	c3                   	ret    

00000369 <mknod>:
SYSCALL(mknod)
 369:	b8 11 00 00 00       	mov    $0x11,%eax
 36e:	cd 40                	int    $0x40
 370:	c3                   	ret    

00000371 <unlink>:
SYSCALL(unlink)
 371:	b8 12 00 00 00       	mov    $0x12,%eax
 376:	cd 40                	int    $0x40
 378:	c3                   	ret    

00000379 <fstat>:
SYSCALL(fstat)
 379:	b8 08 00 00 00       	mov    $0x8,%eax
 37e:	cd 40                	int    $0x40
 380:	c3                   	ret    

00000381 <link>:
SYSCALL(link)
 381:	b8 13 00 00 00       	mov    $0x13,%eax
 386:	cd 40                	int    $0x40
 388:	c3                   	ret    

00000389 <mkdir>:
SYSCALL(mkdir)
 389:	b8 14 00 00 00       	mov    $0x14,%eax
 38e:	cd 40                	int    $0x40
 390:	c3                   	ret    

00000391 <chdir>:
SYSCALL(chdir)
 391:	b8 09 00 00 00       	mov    $0x9,%eax
 396:	cd 40                	int    $0x40
 398:	c3                   	ret    

00000399 <dup>:
SYSCALL(dup)
 399:	b8 0a 00 00 00       	mov    $0xa,%eax
 39e:	cd 40                	int    $0x40
 3a0:	c3                   	ret    

000003a1 <getpid>:
SYSCALL(getpid)
 3a1:	b8 0b 00 00 00       	mov    $0xb,%eax
 3a6:	cd 40                	int    $0x40
 3a8:	c3                   	ret    

000003a9 <sbrk>:
SYSCALL(sbrk)
 3a9:	b8 0c 00 00 00       	mov    $0xc,%eax
 3ae:	cd 40                	int    $0x40
 3b0:	c3                   	ret    

000003b1 <sleep>:
SYSCALL(sleep)
 3b1:	b8 0d 00 00 00       	mov    $0xd,%eax
 3b6:	cd 40                	int    $0x40
 3b8:	c3                   	ret    

000003b9 <uptime>:
SYSCALL(uptime)
 3b9:	b8 0e 00 00 00       	mov    $0xe,%eax
 3be:	cd 40                	int    $0x40
 3c0:	c3                   	ret    

000003c1 <halt>:
SYSCALL(halt)
 3c1:	b8 16 00 00 00       	mov    $0x16,%eax
 3c6:	cd 40                	int    $0x40
 3c8:	c3                   	ret    

000003c9 <date>:
SYSCALL(date)
 3c9:	b8 17 00 00 00       	mov    $0x17,%eax
 3ce:	cd 40                	int    $0x40
 3d0:	c3                   	ret    

000003d1 <getgid>:
SYSCALL(getgid)
 3d1:	b8 18 00 00 00       	mov    $0x18,%eax
 3d6:	cd 40                	int    $0x40
 3d8:	c3                   	ret    

000003d9 <setgid>:
SYSCALL(setgid)
 3d9:	b8 19 00 00 00       	mov    $0x19,%eax
 3de:	cd 40                	int    $0x40
 3e0:	c3                   	ret    

000003e1 <getuid>:
SYSCALL(getuid)
 3e1:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3e6:	cd 40                	int    $0x40
 3e8:	c3                   	ret    

000003e9 <setuid>:
SYSCALL(setuid)
 3e9:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3ee:	cd 40                	int    $0x40
 3f0:	c3                   	ret    

000003f1 <getppid>:
SYSCALL(getppid)
 3f1:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3f6:	cd 40                	int    $0x40
 3f8:	c3                   	ret    

000003f9 <getprocs>:
SYSCALL(getprocs)
 3f9:	b8 1d 00 00 00       	mov    $0x1d,%eax
 3fe:	cd 40                	int    $0x40
 400:	c3                   	ret    

00000401 <setpriority>:
SYSCALL(setpriority)
 401:	b8 1e 00 00 00       	mov    $0x1e,%eax
 406:	cd 40                	int    $0x40
 408:	c3                   	ret    

00000409 <getpriority>:
SYSCALL(getpriority)
 409:	b8 1f 00 00 00       	mov    $0x1f,%eax
 40e:	cd 40                	int    $0x40
 410:	c3                   	ret    

00000411 <chmod>:
SYSCALL(chmod)
 411:	b8 20 00 00 00       	mov    $0x20,%eax
 416:	cd 40                	int    $0x40
 418:	c3                   	ret    

00000419 <chown>:
SYSCALL(chown)
 419:	b8 21 00 00 00       	mov    $0x21,%eax
 41e:	cd 40                	int    $0x40
 420:	c3                   	ret    

00000421 <chgrp>:
SYSCALL(chgrp)
 421:	b8 22 00 00 00       	mov    $0x22,%eax
 426:	cd 40                	int    $0x40
 428:	c3                   	ret    
 429:	66 90                	xchg   %ax,%ax
 42b:	66 90                	xchg   %ax,%ax
 42d:	66 90                	xchg   %ax,%ax
 42f:	90                   	nop

00000430 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	57                   	push   %edi
 434:	56                   	push   %esi
 435:	53                   	push   %ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 436:	89 d3                	mov    %edx,%ebx
{
 438:	83 ec 3c             	sub    $0x3c,%esp
 43b:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 43e:	85 d2                	test   %edx,%edx
 440:	0f 89 92 00 00 00    	jns    4d8 <printint+0xa8>
 446:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 44a:	0f 84 88 00 00 00    	je     4d8 <printint+0xa8>
    neg = 1;
 450:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 457:	f7 db                	neg    %ebx
  } else {
    x = xx;
  }

  i = 0;
 459:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 460:	8d 75 d7             	lea    -0x29(%ebp),%esi
 463:	eb 08                	jmp    46d <printint+0x3d>
 465:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 468:	89 7d c4             	mov    %edi,-0x3c(%ebp)
  }while((x /= base) != 0);
 46b:	89 c3                	mov    %eax,%ebx
    buf[i++] = digits[x % base];
 46d:	89 d8                	mov    %ebx,%eax
 46f:	31 d2                	xor    %edx,%edx
 471:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 474:	f7 f1                	div    %ecx
 476:	83 c7 01             	add    $0x1,%edi
 479:	0f b6 92 60 08 00 00 	movzbl 0x860(%edx),%edx
 480:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 483:	39 d9                	cmp    %ebx,%ecx
 485:	76 e1                	jbe    468 <printint+0x38>
  if(neg)
 487:	8b 45 c0             	mov    -0x40(%ebp),%eax
 48a:	85 c0                	test   %eax,%eax
 48c:	74 0d                	je     49b <printint+0x6b>
    buf[i++] = '-';
 48e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 493:	ba 2d 00 00 00       	mov    $0x2d,%edx
    buf[i++] = digits[x % base];
 498:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 49b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 49e:	8b 7d bc             	mov    -0x44(%ebp),%edi
 4a1:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 4a5:	eb 0f                	jmp    4b6 <printint+0x86>
 4a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ae:	66 90                	xchg   %ax,%ax
 4b0:	0f b6 13             	movzbl (%ebx),%edx
 4b3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 4b6:	83 ec 04             	sub    $0x4,%esp
 4b9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 4bc:	6a 01                	push   $0x1
 4be:	56                   	push   %esi
 4bf:	57                   	push   %edi
 4c0:	e8 7c fe ff ff       	call   341 <write>

  while(--i >= 0)
 4c5:	83 c4 10             	add    $0x10,%esp
 4c8:	39 de                	cmp    %ebx,%esi
 4ca:	75 e4                	jne    4b0 <printint+0x80>
    putc(fd, buf[i]);
}
 4cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4cf:	5b                   	pop    %ebx
 4d0:	5e                   	pop    %esi
 4d1:	5f                   	pop    %edi
 4d2:	5d                   	pop    %ebp
 4d3:	c3                   	ret    
 4d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4d8:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 4df:	e9 75 ff ff ff       	jmp    459 <printint+0x29>
 4e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4ef:	90                   	nop

000004f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	57                   	push   %edi
 4f4:	56                   	push   %esi
 4f5:	53                   	push   %ebx
 4f6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4f9:	8b 75 0c             	mov    0xc(%ebp),%esi
 4fc:	0f b6 1e             	movzbl (%esi),%ebx
 4ff:	84 db                	test   %bl,%bl
 501:	0f 84 b9 00 00 00    	je     5c0 <printf+0xd0>
  ap = (uint*)(void*)&fmt + 1;
 507:	8d 45 10             	lea    0x10(%ebp),%eax
 50a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 50d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 510:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 512:	89 45 d0             	mov    %eax,-0x30(%ebp)
 515:	eb 38                	jmp    54f <printf+0x5f>
 517:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 51e:	66 90                	xchg   %ax,%ax
 520:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 523:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 528:	83 f8 25             	cmp    $0x25,%eax
 52b:	74 17                	je     544 <printf+0x54>
  write(fd, &c, 1);
 52d:	83 ec 04             	sub    $0x4,%esp
 530:	88 5d e7             	mov    %bl,-0x19(%ebp)
 533:	6a 01                	push   $0x1
 535:	57                   	push   %edi
 536:	ff 75 08             	pushl  0x8(%ebp)
 539:	e8 03 fe ff ff       	call   341 <write>
 53e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 541:	83 c4 10             	add    $0x10,%esp
 544:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 547:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 54b:	84 db                	test   %bl,%bl
 54d:	74 71                	je     5c0 <printf+0xd0>
    c = fmt[i] & 0xff;
 54f:	0f be cb             	movsbl %bl,%ecx
 552:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 555:	85 d2                	test   %edx,%edx
 557:	74 c7                	je     520 <printf+0x30>
      }
    } else if(state == '%'){
 559:	83 fa 25             	cmp    $0x25,%edx
 55c:	75 e6                	jne    544 <printf+0x54>
      if(c == 'd'){
 55e:	83 f8 64             	cmp    $0x64,%eax
 561:	0f 84 99 00 00 00    	je     600 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 567:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 56d:	83 f9 70             	cmp    $0x70,%ecx
 570:	74 5e                	je     5d0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 572:	83 f8 73             	cmp    $0x73,%eax
 575:	0f 84 d5 00 00 00    	je     650 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 57b:	83 f8 63             	cmp    $0x63,%eax
 57e:	0f 84 8c 00 00 00    	je     610 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 584:	83 f8 25             	cmp    $0x25,%eax
 587:	0f 84 b3 00 00 00    	je     640 <printf+0x150>
  write(fd, &c, 1);
 58d:	83 ec 04             	sub    $0x4,%esp
 590:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 594:	6a 01                	push   $0x1
 596:	57                   	push   %edi
 597:	ff 75 08             	pushl  0x8(%ebp)
 59a:	e8 a2 fd ff ff       	call   341 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 59f:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 5a2:	83 c4 0c             	add    $0xc,%esp
 5a5:	6a 01                	push   $0x1
 5a7:	83 c6 01             	add    $0x1,%esi
 5aa:	57                   	push   %edi
 5ab:	ff 75 08             	pushl  0x8(%ebp)
 5ae:	e8 8e fd ff ff       	call   341 <write>
  for(i = 0; fmt[i]; i++){
 5b3:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 5b7:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5ba:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 5bc:	84 db                	test   %bl,%bl
 5be:	75 8f                	jne    54f <printf+0x5f>
    }
  }
}
 5c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5c3:	5b                   	pop    %ebx
 5c4:	5e                   	pop    %esi
 5c5:	5f                   	pop    %edi
 5c6:	5d                   	pop    %ebp
 5c7:	c3                   	ret    
 5c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5cf:	90                   	nop
        printint(fd, *ap, 16, 0);
 5d0:	83 ec 0c             	sub    $0xc,%esp
 5d3:	b9 10 00 00 00       	mov    $0x10,%ecx
 5d8:	6a 00                	push   $0x0
 5da:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5dd:	8b 45 08             	mov    0x8(%ebp),%eax
 5e0:	8b 13                	mov    (%ebx),%edx
 5e2:	e8 49 fe ff ff       	call   430 <printint>
        ap++;
 5e7:	89 d8                	mov    %ebx,%eax
 5e9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5ec:	31 d2                	xor    %edx,%edx
        ap++;
 5ee:	83 c0 04             	add    $0x4,%eax
 5f1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5f4:	e9 4b ff ff ff       	jmp    544 <printf+0x54>
 5f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 600:	83 ec 0c             	sub    $0xc,%esp
 603:	b9 0a 00 00 00       	mov    $0xa,%ecx
 608:	6a 01                	push   $0x1
 60a:	eb ce                	jmp    5da <printf+0xea>
 60c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 610:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 613:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 616:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 618:	6a 01                	push   $0x1
        ap++;
 61a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 61d:	57                   	push   %edi
 61e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 621:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 624:	e8 18 fd ff ff       	call   341 <write>
        ap++;
 629:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 62c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 62f:	31 d2                	xor    %edx,%edx
 631:	e9 0e ff ff ff       	jmp    544 <printf+0x54>
 636:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 63d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 640:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 643:	83 ec 04             	sub    $0x4,%esp
 646:	e9 5a ff ff ff       	jmp    5a5 <printf+0xb5>
 64b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 64f:	90                   	nop
        s = (char*)*ap;
 650:	8b 45 d0             	mov    -0x30(%ebp),%eax
 653:	8b 18                	mov    (%eax),%ebx
        ap++;
 655:	83 c0 04             	add    $0x4,%eax
 658:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 65b:	85 db                	test   %ebx,%ebx
 65d:	74 17                	je     676 <printf+0x186>
        while(*s != 0){
 65f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 662:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 664:	84 c0                	test   %al,%al
 666:	0f 84 d8 fe ff ff    	je     544 <printf+0x54>
 66c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 66f:	89 de                	mov    %ebx,%esi
 671:	8b 5d 08             	mov    0x8(%ebp),%ebx
 674:	eb 1a                	jmp    690 <printf+0x1a0>
          s = "(null)";
 676:	bb 58 08 00 00       	mov    $0x858,%ebx
        while(*s != 0){
 67b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 67e:	b8 28 00 00 00       	mov    $0x28,%eax
 683:	89 de                	mov    %ebx,%esi
 685:	8b 5d 08             	mov    0x8(%ebp),%ebx
 688:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 68f:	90                   	nop
  write(fd, &c, 1);
 690:	83 ec 04             	sub    $0x4,%esp
          s++;
 693:	83 c6 01             	add    $0x1,%esi
 696:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 699:	6a 01                	push   $0x1
 69b:	57                   	push   %edi
 69c:	53                   	push   %ebx
 69d:	e8 9f fc ff ff       	call   341 <write>
        while(*s != 0){
 6a2:	0f b6 06             	movzbl (%esi),%eax
 6a5:	83 c4 10             	add    $0x10,%esp
 6a8:	84 c0                	test   %al,%al
 6aa:	75 e4                	jne    690 <printf+0x1a0>
 6ac:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 6af:	31 d2                	xor    %edx,%edx
 6b1:	e9 8e fe ff ff       	jmp    544 <printf+0x54>
 6b6:	66 90                	xchg   %ax,%ax
 6b8:	66 90                	xchg   %ax,%ax
 6ba:	66 90                	xchg   %ax,%ax
 6bc:	66 90                	xchg   %ax,%ax
 6be:	66 90                	xchg   %ax,%ax

000006c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c1:	a1 3c 0b 00 00       	mov    0xb3c,%eax
{
 6c6:	89 e5                	mov    %esp,%ebp
 6c8:	57                   	push   %edi
 6c9:	56                   	push   %esi
 6ca:	53                   	push   %ebx
 6cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6ce:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 6d0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d3:	39 c8                	cmp    %ecx,%eax
 6d5:	73 19                	jae    6f0 <free+0x30>
 6d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6de:	66 90                	xchg   %ax,%ax
 6e0:	39 d1                	cmp    %edx,%ecx
 6e2:	72 14                	jb     6f8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e4:	39 d0                	cmp    %edx,%eax
 6e6:	73 10                	jae    6f8 <free+0x38>
{
 6e8:	89 d0                	mov    %edx,%eax
 6ea:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ec:	39 c8                	cmp    %ecx,%eax
 6ee:	72 f0                	jb     6e0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f0:	39 d0                	cmp    %edx,%eax
 6f2:	72 f4                	jb     6e8 <free+0x28>
 6f4:	39 d1                	cmp    %edx,%ecx
 6f6:	73 f0                	jae    6e8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6f8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6fb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6fe:	39 fa                	cmp    %edi,%edx
 700:	74 1e                	je     720 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 702:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 705:	8b 50 04             	mov    0x4(%eax),%edx
 708:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 70b:	39 f1                	cmp    %esi,%ecx
 70d:	74 28                	je     737 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 70f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 711:	5b                   	pop    %ebx
  freep = p;
 712:	a3 3c 0b 00 00       	mov    %eax,0xb3c
}
 717:	5e                   	pop    %esi
 718:	5f                   	pop    %edi
 719:	5d                   	pop    %ebp
 71a:	c3                   	ret    
 71b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 71f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 720:	03 72 04             	add    0x4(%edx),%esi
 723:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 726:	8b 10                	mov    (%eax),%edx
 728:	8b 12                	mov    (%edx),%edx
 72a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 72d:	8b 50 04             	mov    0x4(%eax),%edx
 730:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 733:	39 f1                	cmp    %esi,%ecx
 735:	75 d8                	jne    70f <free+0x4f>
    p->s.size += bp->s.size;
 737:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 73a:	a3 3c 0b 00 00       	mov    %eax,0xb3c
    p->s.size += bp->s.size;
 73f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 742:	8b 53 f8             	mov    -0x8(%ebx),%edx
 745:	89 10                	mov    %edx,(%eax)
}
 747:	5b                   	pop    %ebx
 748:	5e                   	pop    %esi
 749:	5f                   	pop    %edi
 74a:	5d                   	pop    %ebp
 74b:	c3                   	ret    
 74c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000750 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	57                   	push   %edi
 754:	56                   	push   %esi
 755:	53                   	push   %ebx
 756:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 759:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 75c:	8b 3d 3c 0b 00 00    	mov    0xb3c,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 762:	8d 70 07             	lea    0x7(%eax),%esi
 765:	c1 ee 03             	shr    $0x3,%esi
 768:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 76b:	85 ff                	test   %edi,%edi
 76d:	0f 84 ad 00 00 00    	je     820 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 773:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 775:	8b 4a 04             	mov    0x4(%edx),%ecx
 778:	39 f1                	cmp    %esi,%ecx
 77a:	73 72                	jae    7ee <malloc+0x9e>
 77c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 782:	bb 00 10 00 00       	mov    $0x1000,%ebx
 787:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 78a:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 791:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 794:	eb 1b                	jmp    7b1 <malloc+0x61>
 796:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 79d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7a2:	8b 48 04             	mov    0x4(%eax),%ecx
 7a5:	39 f1                	cmp    %esi,%ecx
 7a7:	73 4f                	jae    7f8 <malloc+0xa8>
 7a9:	8b 3d 3c 0b 00 00    	mov    0xb3c,%edi
 7af:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7b1:	39 d7                	cmp    %edx,%edi
 7b3:	75 eb                	jne    7a0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 7b5:	83 ec 0c             	sub    $0xc,%esp
 7b8:	ff 75 e4             	pushl  -0x1c(%ebp)
 7bb:	e8 e9 fb ff ff       	call   3a9 <sbrk>
  if(p == (char*)-1)
 7c0:	83 c4 10             	add    $0x10,%esp
 7c3:	83 f8 ff             	cmp    $0xffffffff,%eax
 7c6:	74 1c                	je     7e4 <malloc+0x94>
  hp->s.size = nu;
 7c8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7cb:	83 ec 0c             	sub    $0xc,%esp
 7ce:	83 c0 08             	add    $0x8,%eax
 7d1:	50                   	push   %eax
 7d2:	e8 e9 fe ff ff       	call   6c0 <free>
  return freep;
 7d7:	8b 15 3c 0b 00 00    	mov    0xb3c,%edx
      if((p = morecore(nunits)) == 0)
 7dd:	83 c4 10             	add    $0x10,%esp
 7e0:	85 d2                	test   %edx,%edx
 7e2:	75 bc                	jne    7a0 <malloc+0x50>
        return 0;
  }
}
 7e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7e7:	31 c0                	xor    %eax,%eax
}
 7e9:	5b                   	pop    %ebx
 7ea:	5e                   	pop    %esi
 7eb:	5f                   	pop    %edi
 7ec:	5d                   	pop    %ebp
 7ed:	c3                   	ret    
    if(p->s.size >= nunits){
 7ee:	89 d0                	mov    %edx,%eax
 7f0:	89 fa                	mov    %edi,%edx
 7f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7f8:	39 ce                	cmp    %ecx,%esi
 7fa:	74 54                	je     850 <malloc+0x100>
        p->s.size -= nunits;
 7fc:	29 f1                	sub    %esi,%ecx
 7fe:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 801:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 804:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 807:	89 15 3c 0b 00 00    	mov    %edx,0xb3c
}
 80d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 810:	83 c0 08             	add    $0x8,%eax
}
 813:	5b                   	pop    %ebx
 814:	5e                   	pop    %esi
 815:	5f                   	pop    %edi
 816:	5d                   	pop    %ebp
 817:	c3                   	ret    
 818:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 81f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 820:	c7 05 3c 0b 00 00 40 	movl   $0xb40,0xb3c
 827:	0b 00 00 
    base.s.size = 0;
 82a:	bf 40 0b 00 00       	mov    $0xb40,%edi
    base.s.ptr = freep = prevp = &base;
 82f:	c7 05 40 0b 00 00 40 	movl   $0xb40,0xb40
 836:	0b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 839:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 83b:	c7 05 44 0b 00 00 00 	movl   $0x0,0xb44
 842:	00 00 00 
    if(p->s.size >= nunits){
 845:	e9 32 ff ff ff       	jmp    77c <malloc+0x2c>
 84a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 850:	8b 08                	mov    (%eax),%ecx
 852:	89 0a                	mov    %ecx,(%edx)
 854:	eb b1                	jmp    807 <malloc+0xb7>
