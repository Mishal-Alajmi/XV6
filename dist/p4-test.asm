
_p4-test:     file format elf32-i386


Disassembly of section .text:

00000000 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
   0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
   1:	31 d2                	xor    %edx,%edx
{
   3:	89 e5                	mov    %esp,%ebp
   5:	53                   	push   %ebx
   6:	8b 45 08             	mov    0x8(%ebp),%eax
   9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
   c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  10:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
  14:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  17:	83 c2 01             	add    $0x1,%edx
  1a:	84 c9                	test   %cl,%cl
  1c:	75 f2                	jne    10 <strcpy+0x10>
    ;
  return os;
}
  1e:	5b                   	pop    %ebx
  1f:	5d                   	pop    %ebp
  20:	c3                   	ret    
  21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  2f:	90                   	nop

00000030 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	56                   	push   %esi
  34:	53                   	push   %ebx
  35:	8b 5d 08             	mov    0x8(%ebp),%ebx
  38:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(*p && *p == *q)
  3b:	0f b6 13             	movzbl (%ebx),%edx
  3e:	0f b6 0e             	movzbl (%esi),%ecx
  41:	84 d2                	test   %dl,%dl
  43:	74 1e                	je     63 <strcmp+0x33>
  45:	b8 01 00 00 00       	mov    $0x1,%eax
  4a:	38 ca                	cmp    %cl,%dl
  4c:	74 09                	je     57 <strcmp+0x27>
  4e:	eb 20                	jmp    70 <strcmp+0x40>
  50:	83 c0 01             	add    $0x1,%eax
  53:	38 ca                	cmp    %cl,%dl
  55:	75 19                	jne    70 <strcmp+0x40>
  57:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  5b:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
  5f:	84 d2                	test   %dl,%dl
  61:	75 ed                	jne    50 <strcmp+0x20>
  63:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  65:	5b                   	pop    %ebx
  66:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
  67:	29 c8                	sub    %ecx,%eax
}
  69:	5d                   	pop    %ebp
  6a:	c3                   	ret    
  6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  6f:	90                   	nop
  70:	0f b6 c2             	movzbl %dl,%eax
  73:	5b                   	pop    %ebx
  74:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
  75:	29 c8                	sub    %ecx,%eax
}
  77:	5d                   	pop    %ebp
  78:	c3                   	ret    
  79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000080 <strlen>:

uint
strlen(char *s)
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  86:	80 39 00             	cmpb   $0x0,(%ecx)
  89:	74 15                	je     a0 <strlen+0x20>
  8b:	31 d2                	xor    %edx,%edx
  8d:	8d 76 00             	lea    0x0(%esi),%esi
  90:	83 c2 01             	add    $0x1,%edx
  93:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  97:	89 d0                	mov    %edx,%eax
  99:	75 f5                	jne    90 <strlen+0x10>
    ;
  return n;
}
  9b:	5d                   	pop    %ebp
  9c:	c3                   	ret    
  9d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
  a0:	31 c0                	xor    %eax,%eax
}
  a2:	5d                   	pop    %ebp
  a3:	c3                   	ret    
  a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  af:	90                   	nop

000000b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	57                   	push   %edi
  b4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  bd:	89 d7                	mov    %edx,%edi
  bf:	fc                   	cld    
  c0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  c2:	89 d0                	mov    %edx,%eax
  c4:	5f                   	pop    %edi
  c5:	5d                   	pop    %ebp
  c6:	c3                   	ret    
  c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ce:	66 90                	xchg   %ax,%ax

000000d0 <strchr>:

char*
strchr(const char *s, char c)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	53                   	push   %ebx
  d4:	8b 45 08             	mov    0x8(%ebp),%eax
  d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
  da:	0f b6 18             	movzbl (%eax),%ebx
  dd:	84 db                	test   %bl,%bl
  df:	74 1d                	je     fe <strchr+0x2e>
  e1:	89 d1                	mov    %edx,%ecx
    if(*s == c)
  e3:	38 d3                	cmp    %dl,%bl
  e5:	75 0d                	jne    f4 <strchr+0x24>
  e7:	eb 17                	jmp    100 <strchr+0x30>
  e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  f0:	38 ca                	cmp    %cl,%dl
  f2:	74 0c                	je     100 <strchr+0x30>
  for(; *s; s++)
  f4:	83 c0 01             	add    $0x1,%eax
  f7:	0f b6 10             	movzbl (%eax),%edx
  fa:	84 d2                	test   %dl,%dl
  fc:	75 f2                	jne    f0 <strchr+0x20>
      return (char*)s;
  return 0;
  fe:	31 c0                	xor    %eax,%eax
}
 100:	5b                   	pop    %ebx
 101:	5d                   	pop    %ebp
 102:	c3                   	ret    
 103:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 10a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000110 <gets>:

char*
gets(char *buf, int max)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 115:	31 f6                	xor    %esi,%esi
{
 117:	53                   	push   %ebx
 118:	89 f3                	mov    %esi,%ebx
 11a:	83 ec 1c             	sub    $0x1c,%esp
 11d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 120:	eb 2f                	jmp    151 <gets+0x41>
 122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 128:	83 ec 04             	sub    $0x4,%esp
 12b:	8d 45 e7             	lea    -0x19(%ebp),%eax
 12e:	6a 01                	push   $0x1
 130:	50                   	push   %eax
 131:	6a 00                	push   $0x0
 133:	e8 d1 01 00 00       	call   309 <read>
    if(cc < 1)
 138:	83 c4 10             	add    $0x10,%esp
 13b:	85 c0                	test   %eax,%eax
 13d:	7e 1c                	jle    15b <gets+0x4b>
      break;
    buf[i++] = c;
 13f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 143:	83 c7 01             	add    $0x1,%edi
 146:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 149:	3c 0a                	cmp    $0xa,%al
 14b:	74 23                	je     170 <gets+0x60>
 14d:	3c 0d                	cmp    $0xd,%al
 14f:	74 1f                	je     170 <gets+0x60>
  for(i=0; i+1 < max; ){
 151:	83 c3 01             	add    $0x1,%ebx
 154:	89 fe                	mov    %edi,%esi
 156:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 159:	7c cd                	jl     128 <gets+0x18>
 15b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 15d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 160:	c6 03 00             	movb   $0x0,(%ebx)
}
 163:	8d 65 f4             	lea    -0xc(%ebp),%esp
 166:	5b                   	pop    %ebx
 167:	5e                   	pop    %esi
 168:	5f                   	pop    %edi
 169:	5d                   	pop    %ebp
 16a:	c3                   	ret    
 16b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 16f:	90                   	nop
 170:	8b 75 08             	mov    0x8(%ebp),%esi
 173:	8b 45 08             	mov    0x8(%ebp),%eax
 176:	01 de                	add    %ebx,%esi
 178:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 17a:	c6 03 00             	movb   $0x0,(%ebx)
}
 17d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 180:	5b                   	pop    %ebx
 181:	5e                   	pop    %esi
 182:	5f                   	pop    %edi
 183:	5d                   	pop    %ebp
 184:	c3                   	ret    
 185:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000190 <stat>:

int
stat(char *n, struct stat *st)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	56                   	push   %esi
 194:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 195:	83 ec 08             	sub    $0x8,%esp
 198:	6a 00                	push   $0x0
 19a:	ff 75 08             	pushl  0x8(%ebp)
 19d:	e8 8f 01 00 00       	call   331 <open>
  if(fd < 0)
 1a2:	83 c4 10             	add    $0x10,%esp
 1a5:	85 c0                	test   %eax,%eax
 1a7:	78 27                	js     1d0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1a9:	83 ec 08             	sub    $0x8,%esp
 1ac:	ff 75 0c             	pushl  0xc(%ebp)
 1af:	89 c3                	mov    %eax,%ebx
 1b1:	50                   	push   %eax
 1b2:	e8 92 01 00 00       	call   349 <fstat>
  close(fd);
 1b7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1ba:	89 c6                	mov    %eax,%esi
  close(fd);
 1bc:	e8 58 01 00 00       	call   319 <close>
  return r;
 1c1:	83 c4 10             	add    $0x10,%esp
}
 1c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1c7:	89 f0                	mov    %esi,%eax
 1c9:	5b                   	pop    %ebx
 1ca:	5e                   	pop    %esi
 1cb:	5d                   	pop    %ebp
 1cc:	c3                   	ret    
 1cd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 1d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1d5:	eb ed                	jmp    1c4 <stat+0x34>
 1d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1de:	66 90                	xchg   %ax,%ax

000001e0 <atoi>:

#ifdef PDX_XV6
int
atoi(const char *s)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	56                   	push   %esi
 1e4:	8b 55 08             	mov    0x8(%ebp),%edx
 1e7:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 1e8:	0f b6 0a             	movzbl (%edx),%ecx
 1eb:	80 f9 20             	cmp    $0x20,%cl
 1ee:	75 0b                	jne    1fb <atoi+0x1b>
 1f0:	83 c2 01             	add    $0x1,%edx
 1f3:	0f b6 0a             	movzbl (%edx),%ecx
 1f6:	80 f9 20             	cmp    $0x20,%cl
 1f9:	74 f5                	je     1f0 <atoi+0x10>
  sign = (*s == '-') ? -1 : 1;
 1fb:	80 f9 2d             	cmp    $0x2d,%cl
 1fe:	74 40                	je     240 <atoi+0x60>
 200:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 205:	80 f9 2b             	cmp    $0x2b,%cl
 208:	74 3b                	je     245 <atoi+0x65>
    s++;
  while('0' <= *s && *s <= '9')
 20a:	0f be 0a             	movsbl (%edx),%ecx
 20d:	8d 41 d0             	lea    -0x30(%ecx),%eax
 210:	3c 09                	cmp    $0x9,%al
 212:	b8 00 00 00 00       	mov    $0x0,%eax
 217:	77 1f                	ja     238 <atoi+0x58>
 219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 220:	83 c2 01             	add    $0x1,%edx
 223:	8d 04 80             	lea    (%eax,%eax,4),%eax
 226:	8d 44 41 d0          	lea    -0x30(%ecx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 22a:	0f be 0a             	movsbl (%edx),%ecx
 22d:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 230:	80 fb 09             	cmp    $0x9,%bl
 233:	76 eb                	jbe    220 <atoi+0x40>
 235:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 238:	5b                   	pop    %ebx
 239:	5e                   	pop    %esi
 23a:	5d                   	pop    %ebp
 23b:	c3                   	ret    
 23c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 240:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 245:	83 c2 01             	add    $0x1,%edx
 248:	eb c0                	jmp    20a <atoi+0x2a>
 24a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000250 <atoo>:

int
atoo(const char *s)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	56                   	push   %esi
 254:	8b 55 08             	mov    0x8(%ebp),%edx
 257:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 258:	0f b6 0a             	movzbl (%edx),%ecx
 25b:	80 f9 20             	cmp    $0x20,%cl
 25e:	75 0b                	jne    26b <atoo+0x1b>
 260:	83 c2 01             	add    $0x1,%edx
 263:	0f b6 0a             	movzbl (%edx),%ecx
 266:	80 f9 20             	cmp    $0x20,%cl
 269:	74 f5                	je     260 <atoo+0x10>
  sign = (*s == '-') ? -1 : 1;
 26b:	80 f9 2d             	cmp    $0x2d,%cl
 26e:	74 40                	je     2b0 <atoo+0x60>
 270:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 275:	80 f9 2b             	cmp    $0x2b,%cl
 278:	74 3b                	je     2b5 <atoo+0x65>
    s++;
  while('0' <= *s && *s <= '7')
 27a:	0f be 0a             	movsbl (%edx),%ecx
 27d:	8d 41 d0             	lea    -0x30(%ecx),%eax
 280:	3c 07                	cmp    $0x7,%al
 282:	b8 00 00 00 00       	mov    $0x0,%eax
 287:	77 1c                	ja     2a5 <atoo+0x55>
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*8 + *s++ - '0';
 290:	83 c2 01             	add    $0x1,%edx
 293:	8d 44 c1 d0          	lea    -0x30(%ecx,%eax,8),%eax
  while('0' <= *s && *s <= '7')
 297:	0f be 0a             	movsbl (%edx),%ecx
 29a:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 29d:	80 fb 07             	cmp    $0x7,%bl
 2a0:	76 ee                	jbe    290 <atoo+0x40>
 2a2:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 2a5:	5b                   	pop    %ebx
 2a6:	5e                   	pop    %esi
 2a7:	5d                   	pop    %ebp
 2a8:	c3                   	ret    
 2a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 2b0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 2b5:	83 c2 01             	add    $0x1,%edx
 2b8:	eb c0                	jmp    27a <atoo+0x2a>
 2ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002c0 <memmove>:
}
#endif // PDX_XV6

void*
memmove(void *vdst, void *vsrc, int n)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	57                   	push   %edi
 2c4:	8b 55 10             	mov    0x10(%ebp),%edx
 2c7:	8b 45 08             	mov    0x8(%ebp),%eax
 2ca:	56                   	push   %esi
 2cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ce:	85 d2                	test   %edx,%edx
 2d0:	7e 13                	jle    2e5 <memmove+0x25>
 2d2:	01 c2                	add    %eax,%edx
  dst = vdst;
 2d4:	89 c7                	mov    %eax,%edi
 2d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2dd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 2e0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2e1:	39 fa                	cmp    %edi,%edx
 2e3:	75 fb                	jne    2e0 <memmove+0x20>
  return vdst;
}
 2e5:	5e                   	pop    %esi
 2e6:	5f                   	pop    %edi
 2e7:	5d                   	pop    %ebp
 2e8:	c3                   	ret    

000002e9 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2e9:	b8 01 00 00 00       	mov    $0x1,%eax
 2ee:	cd 40                	int    $0x40
 2f0:	c3                   	ret    

000002f1 <exit>:
SYSCALL(exit)
 2f1:	b8 02 00 00 00       	mov    $0x2,%eax
 2f6:	cd 40                	int    $0x40
 2f8:	c3                   	ret    

000002f9 <wait>:
SYSCALL(wait)
 2f9:	b8 03 00 00 00       	mov    $0x3,%eax
 2fe:	cd 40                	int    $0x40
 300:	c3                   	ret    

00000301 <pipe>:
SYSCALL(pipe)
 301:	b8 04 00 00 00       	mov    $0x4,%eax
 306:	cd 40                	int    $0x40
 308:	c3                   	ret    

00000309 <read>:
SYSCALL(read)
 309:	b8 05 00 00 00       	mov    $0x5,%eax
 30e:	cd 40                	int    $0x40
 310:	c3                   	ret    

00000311 <write>:
SYSCALL(write)
 311:	b8 10 00 00 00       	mov    $0x10,%eax
 316:	cd 40                	int    $0x40
 318:	c3                   	ret    

00000319 <close>:
SYSCALL(close)
 319:	b8 15 00 00 00       	mov    $0x15,%eax
 31e:	cd 40                	int    $0x40
 320:	c3                   	ret    

00000321 <kill>:
SYSCALL(kill)
 321:	b8 06 00 00 00       	mov    $0x6,%eax
 326:	cd 40                	int    $0x40
 328:	c3                   	ret    

00000329 <exec>:
SYSCALL(exec)
 329:	b8 07 00 00 00       	mov    $0x7,%eax
 32e:	cd 40                	int    $0x40
 330:	c3                   	ret    

00000331 <open>:
SYSCALL(open)
 331:	b8 0f 00 00 00       	mov    $0xf,%eax
 336:	cd 40                	int    $0x40
 338:	c3                   	ret    

00000339 <mknod>:
SYSCALL(mknod)
 339:	b8 11 00 00 00       	mov    $0x11,%eax
 33e:	cd 40                	int    $0x40
 340:	c3                   	ret    

00000341 <unlink>:
SYSCALL(unlink)
 341:	b8 12 00 00 00       	mov    $0x12,%eax
 346:	cd 40                	int    $0x40
 348:	c3                   	ret    

00000349 <fstat>:
SYSCALL(fstat)
 349:	b8 08 00 00 00       	mov    $0x8,%eax
 34e:	cd 40                	int    $0x40
 350:	c3                   	ret    

00000351 <link>:
SYSCALL(link)
 351:	b8 13 00 00 00       	mov    $0x13,%eax
 356:	cd 40                	int    $0x40
 358:	c3                   	ret    

00000359 <mkdir>:
SYSCALL(mkdir)
 359:	b8 14 00 00 00       	mov    $0x14,%eax
 35e:	cd 40                	int    $0x40
 360:	c3                   	ret    

00000361 <chdir>:
SYSCALL(chdir)
 361:	b8 09 00 00 00       	mov    $0x9,%eax
 366:	cd 40                	int    $0x40
 368:	c3                   	ret    

00000369 <dup>:
SYSCALL(dup)
 369:	b8 0a 00 00 00       	mov    $0xa,%eax
 36e:	cd 40                	int    $0x40
 370:	c3                   	ret    

00000371 <getpid>:
SYSCALL(getpid)
 371:	b8 0b 00 00 00       	mov    $0xb,%eax
 376:	cd 40                	int    $0x40
 378:	c3                   	ret    

00000379 <sbrk>:
SYSCALL(sbrk)
 379:	b8 0c 00 00 00       	mov    $0xc,%eax
 37e:	cd 40                	int    $0x40
 380:	c3                   	ret    

00000381 <sleep>:
SYSCALL(sleep)
 381:	b8 0d 00 00 00       	mov    $0xd,%eax
 386:	cd 40                	int    $0x40
 388:	c3                   	ret    

00000389 <uptime>:
SYSCALL(uptime)
 389:	b8 0e 00 00 00       	mov    $0xe,%eax
 38e:	cd 40                	int    $0x40
 390:	c3                   	ret    

00000391 <halt>:
SYSCALL(halt)
 391:	b8 16 00 00 00       	mov    $0x16,%eax
 396:	cd 40                	int    $0x40
 398:	c3                   	ret    

00000399 <date>:
SYSCALL(date)
 399:	b8 17 00 00 00       	mov    $0x17,%eax
 39e:	cd 40                	int    $0x40
 3a0:	c3                   	ret    

000003a1 <getgid>:
SYSCALL(getgid)
 3a1:	b8 18 00 00 00       	mov    $0x18,%eax
 3a6:	cd 40                	int    $0x40
 3a8:	c3                   	ret    

000003a9 <setgid>:
SYSCALL(setgid)
 3a9:	b8 19 00 00 00       	mov    $0x19,%eax
 3ae:	cd 40                	int    $0x40
 3b0:	c3                   	ret    

000003b1 <getuid>:
SYSCALL(getuid)
 3b1:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3b6:	cd 40                	int    $0x40
 3b8:	c3                   	ret    

000003b9 <setuid>:
SYSCALL(setuid)
 3b9:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3be:	cd 40                	int    $0x40
 3c0:	c3                   	ret    

000003c1 <getppid>:
SYSCALL(getppid)
 3c1:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3c6:	cd 40                	int    $0x40
 3c8:	c3                   	ret    

000003c9 <getprocs>:
SYSCALL(getprocs)
 3c9:	b8 1d 00 00 00       	mov    $0x1d,%eax
 3ce:	cd 40                	int    $0x40
 3d0:	c3                   	ret    

000003d1 <setpriority>:
SYSCALL(setpriority)
 3d1:	b8 1e 00 00 00       	mov    $0x1e,%eax
 3d6:	cd 40                	int    $0x40
 3d8:	c3                   	ret    

000003d9 <getpriority>:
SYSCALL(getpriority)
 3d9:	b8 1f 00 00 00       	mov    $0x1f,%eax
 3de:	cd 40                	int    $0x40
 3e0:	c3                   	ret    

000003e1 <chmod>:
SYSCALL(chmod)
 3e1:	b8 20 00 00 00       	mov    $0x20,%eax
 3e6:	cd 40                	int    $0x40
 3e8:	c3                   	ret    

000003e9 <chown>:
SYSCALL(chown)
 3e9:	b8 21 00 00 00       	mov    $0x21,%eax
 3ee:	cd 40                	int    $0x40
 3f0:	c3                   	ret    

000003f1 <chgrp>:
SYSCALL(chgrp)
 3f1:	b8 22 00 00 00       	mov    $0x22,%eax
 3f6:	cd 40                	int    $0x40
 3f8:	c3                   	ret    
 3f9:	66 90                	xchg   %ax,%ax
 3fb:	66 90                	xchg   %ax,%ax
 3fd:	66 90                	xchg   %ax,%ax
 3ff:	90                   	nop

00000400 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	56                   	push   %esi
 405:	53                   	push   %ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 406:	89 d3                	mov    %edx,%ebx
{
 408:	83 ec 3c             	sub    $0x3c,%esp
 40b:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 40e:	85 d2                	test   %edx,%edx
 410:	0f 89 92 00 00 00    	jns    4a8 <printint+0xa8>
 416:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 41a:	0f 84 88 00 00 00    	je     4a8 <printint+0xa8>
    neg = 1;
 420:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 427:	f7 db                	neg    %ebx
  } else {
    x = xx;
  }

  i = 0;
 429:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 430:	8d 75 d7             	lea    -0x29(%ebp),%esi
 433:	eb 08                	jmp    43d <printint+0x3d>
 435:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 438:	89 7d c4             	mov    %edi,-0x3c(%ebp)
  }while((x /= base) != 0);
 43b:	89 c3                	mov    %eax,%ebx
    buf[i++] = digits[x % base];
 43d:	89 d8                	mov    %ebx,%eax
 43f:	31 d2                	xor    %edx,%edx
 441:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 444:	f7 f1                	div    %ecx
 446:	83 c7 01             	add    $0x1,%edi
 449:	0f b6 92 30 08 00 00 	movzbl 0x830(%edx),%edx
 450:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 453:	39 d9                	cmp    %ebx,%ecx
 455:	76 e1                	jbe    438 <printint+0x38>
  if(neg)
 457:	8b 45 c0             	mov    -0x40(%ebp),%eax
 45a:	85 c0                	test   %eax,%eax
 45c:	74 0d                	je     46b <printint+0x6b>
    buf[i++] = '-';
 45e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 463:	ba 2d 00 00 00       	mov    $0x2d,%edx
    buf[i++] = digits[x % base];
 468:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 46b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 46e:	8b 7d bc             	mov    -0x44(%ebp),%edi
 471:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 475:	eb 0f                	jmp    486 <printint+0x86>
 477:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 47e:	66 90                	xchg   %ax,%ax
 480:	0f b6 13             	movzbl (%ebx),%edx
 483:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 486:	83 ec 04             	sub    $0x4,%esp
 489:	88 55 d7             	mov    %dl,-0x29(%ebp)
 48c:	6a 01                	push   $0x1
 48e:	56                   	push   %esi
 48f:	57                   	push   %edi
 490:	e8 7c fe ff ff       	call   311 <write>

  while(--i >= 0)
 495:	83 c4 10             	add    $0x10,%esp
 498:	39 de                	cmp    %ebx,%esi
 49a:	75 e4                	jne    480 <printint+0x80>
    putc(fd, buf[i]);
}
 49c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 49f:	5b                   	pop    %ebx
 4a0:	5e                   	pop    %esi
 4a1:	5f                   	pop    %edi
 4a2:	5d                   	pop    %ebp
 4a3:	c3                   	ret    
 4a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4a8:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 4af:	e9 75 ff ff ff       	jmp    429 <printint+0x29>
 4b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4bf:	90                   	nop

000004c0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	53                   	push   %ebx
 4c6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4c9:	8b 75 0c             	mov    0xc(%ebp),%esi
 4cc:	0f b6 1e             	movzbl (%esi),%ebx
 4cf:	84 db                	test   %bl,%bl
 4d1:	0f 84 b9 00 00 00    	je     590 <printf+0xd0>
  ap = (uint*)(void*)&fmt + 1;
 4d7:	8d 45 10             	lea    0x10(%ebp),%eax
 4da:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 4dd:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 4e0:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 4e2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4e5:	eb 38                	jmp    51f <printf+0x5f>
 4e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ee:	66 90                	xchg   %ax,%ax
 4f0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4f3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 4f8:	83 f8 25             	cmp    $0x25,%eax
 4fb:	74 17                	je     514 <printf+0x54>
  write(fd, &c, 1);
 4fd:	83 ec 04             	sub    $0x4,%esp
 500:	88 5d e7             	mov    %bl,-0x19(%ebp)
 503:	6a 01                	push   $0x1
 505:	57                   	push   %edi
 506:	ff 75 08             	pushl  0x8(%ebp)
 509:	e8 03 fe ff ff       	call   311 <write>
 50e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 511:	83 c4 10             	add    $0x10,%esp
 514:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 517:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 51b:	84 db                	test   %bl,%bl
 51d:	74 71                	je     590 <printf+0xd0>
    c = fmt[i] & 0xff;
 51f:	0f be cb             	movsbl %bl,%ecx
 522:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 525:	85 d2                	test   %edx,%edx
 527:	74 c7                	je     4f0 <printf+0x30>
      }
    } else if(state == '%'){
 529:	83 fa 25             	cmp    $0x25,%edx
 52c:	75 e6                	jne    514 <printf+0x54>
      if(c == 'd'){
 52e:	83 f8 64             	cmp    $0x64,%eax
 531:	0f 84 99 00 00 00    	je     5d0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 537:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 53d:	83 f9 70             	cmp    $0x70,%ecx
 540:	74 5e                	je     5a0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 542:	83 f8 73             	cmp    $0x73,%eax
 545:	0f 84 d5 00 00 00    	je     620 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 54b:	83 f8 63             	cmp    $0x63,%eax
 54e:	0f 84 8c 00 00 00    	je     5e0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 554:	83 f8 25             	cmp    $0x25,%eax
 557:	0f 84 b3 00 00 00    	je     610 <printf+0x150>
  write(fd, &c, 1);
 55d:	83 ec 04             	sub    $0x4,%esp
 560:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 564:	6a 01                	push   $0x1
 566:	57                   	push   %edi
 567:	ff 75 08             	pushl  0x8(%ebp)
 56a:	e8 a2 fd ff ff       	call   311 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 56f:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 572:	83 c4 0c             	add    $0xc,%esp
 575:	6a 01                	push   $0x1
 577:	83 c6 01             	add    $0x1,%esi
 57a:	57                   	push   %edi
 57b:	ff 75 08             	pushl  0x8(%ebp)
 57e:	e8 8e fd ff ff       	call   311 <write>
  for(i = 0; fmt[i]; i++){
 583:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 587:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 58a:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 58c:	84 db                	test   %bl,%bl
 58e:	75 8f                	jne    51f <printf+0x5f>
    }
  }
}
 590:	8d 65 f4             	lea    -0xc(%ebp),%esp
 593:	5b                   	pop    %ebx
 594:	5e                   	pop    %esi
 595:	5f                   	pop    %edi
 596:	5d                   	pop    %ebp
 597:	c3                   	ret    
 598:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 59f:	90                   	nop
        printint(fd, *ap, 16, 0);
 5a0:	83 ec 0c             	sub    $0xc,%esp
 5a3:	b9 10 00 00 00       	mov    $0x10,%ecx
 5a8:	6a 00                	push   $0x0
 5aa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5ad:	8b 45 08             	mov    0x8(%ebp),%eax
 5b0:	8b 13                	mov    (%ebx),%edx
 5b2:	e8 49 fe ff ff       	call   400 <printint>
        ap++;
 5b7:	89 d8                	mov    %ebx,%eax
 5b9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5bc:	31 d2                	xor    %edx,%edx
        ap++;
 5be:	83 c0 04             	add    $0x4,%eax
 5c1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5c4:	e9 4b ff ff ff       	jmp    514 <printf+0x54>
 5c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 5d0:	83 ec 0c             	sub    $0xc,%esp
 5d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5d8:	6a 01                	push   $0x1
 5da:	eb ce                	jmp    5aa <printf+0xea>
 5dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 5e0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 5e3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 5e6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 5e8:	6a 01                	push   $0x1
        ap++;
 5ea:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 5ed:	57                   	push   %edi
 5ee:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 5f1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5f4:	e8 18 fd ff ff       	call   311 <write>
        ap++;
 5f9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5fc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5ff:	31 d2                	xor    %edx,%edx
 601:	e9 0e ff ff ff       	jmp    514 <printf+0x54>
 606:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 60d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 610:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 613:	83 ec 04             	sub    $0x4,%esp
 616:	e9 5a ff ff ff       	jmp    575 <printf+0xb5>
 61b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 61f:	90                   	nop
        s = (char*)*ap;
 620:	8b 45 d0             	mov    -0x30(%ebp),%eax
 623:	8b 18                	mov    (%eax),%ebx
        ap++;
 625:	83 c0 04             	add    $0x4,%eax
 628:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 62b:	85 db                	test   %ebx,%ebx
 62d:	74 17                	je     646 <printf+0x186>
        while(*s != 0){
 62f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 632:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 634:	84 c0                	test   %al,%al
 636:	0f 84 d8 fe ff ff    	je     514 <printf+0x54>
 63c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 63f:	89 de                	mov    %ebx,%esi
 641:	8b 5d 08             	mov    0x8(%ebp),%ebx
 644:	eb 1a                	jmp    660 <printf+0x1a0>
          s = "(null)";
 646:	bb 28 08 00 00       	mov    $0x828,%ebx
        while(*s != 0){
 64b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 64e:	b8 28 00 00 00       	mov    $0x28,%eax
 653:	89 de                	mov    %ebx,%esi
 655:	8b 5d 08             	mov    0x8(%ebp),%ebx
 658:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 65f:	90                   	nop
  write(fd, &c, 1);
 660:	83 ec 04             	sub    $0x4,%esp
          s++;
 663:	83 c6 01             	add    $0x1,%esi
 666:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 669:	6a 01                	push   $0x1
 66b:	57                   	push   %edi
 66c:	53                   	push   %ebx
 66d:	e8 9f fc ff ff       	call   311 <write>
        while(*s != 0){
 672:	0f b6 06             	movzbl (%esi),%eax
 675:	83 c4 10             	add    $0x10,%esp
 678:	84 c0                	test   %al,%al
 67a:	75 e4                	jne    660 <printf+0x1a0>
 67c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 67f:	31 d2                	xor    %edx,%edx
 681:	e9 8e fe ff ff       	jmp    514 <printf+0x54>
 686:	66 90                	xchg   %ax,%ax
 688:	66 90                	xchg   %ax,%ax
 68a:	66 90                	xchg   %ax,%ax
 68c:	66 90                	xchg   %ax,%ax
 68e:	66 90                	xchg   %ax,%ax

00000690 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 690:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 691:	a1 e8 0a 00 00       	mov    0xae8,%eax
{
 696:	89 e5                	mov    %esp,%ebp
 698:	57                   	push   %edi
 699:	56                   	push   %esi
 69a:	53                   	push   %ebx
 69b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 69e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 6a0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a3:	39 c8                	cmp    %ecx,%eax
 6a5:	73 19                	jae    6c0 <free+0x30>
 6a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6ae:	66 90                	xchg   %ax,%ax
 6b0:	39 d1                	cmp    %edx,%ecx
 6b2:	72 14                	jb     6c8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b4:	39 d0                	cmp    %edx,%eax
 6b6:	73 10                	jae    6c8 <free+0x38>
{
 6b8:	89 d0                	mov    %edx,%eax
 6ba:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6bc:	39 c8                	cmp    %ecx,%eax
 6be:	72 f0                	jb     6b0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c0:	39 d0                	cmp    %edx,%eax
 6c2:	72 f4                	jb     6b8 <free+0x28>
 6c4:	39 d1                	cmp    %edx,%ecx
 6c6:	73 f0                	jae    6b8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6c8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6cb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6ce:	39 fa                	cmp    %edi,%edx
 6d0:	74 1e                	je     6f0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6d2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6d5:	8b 50 04             	mov    0x4(%eax),%edx
 6d8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6db:	39 f1                	cmp    %esi,%ecx
 6dd:	74 28                	je     707 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6df:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 6e1:	5b                   	pop    %ebx
  freep = p;
 6e2:	a3 e8 0a 00 00       	mov    %eax,0xae8
}
 6e7:	5e                   	pop    %esi
 6e8:	5f                   	pop    %edi
 6e9:	5d                   	pop    %ebp
 6ea:	c3                   	ret    
 6eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6ef:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 6f0:	03 72 04             	add    0x4(%edx),%esi
 6f3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6f6:	8b 10                	mov    (%eax),%edx
 6f8:	8b 12                	mov    (%edx),%edx
 6fa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6fd:	8b 50 04             	mov    0x4(%eax),%edx
 700:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 703:	39 f1                	cmp    %esi,%ecx
 705:	75 d8                	jne    6df <free+0x4f>
    p->s.size += bp->s.size;
 707:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 70a:	a3 e8 0a 00 00       	mov    %eax,0xae8
    p->s.size += bp->s.size;
 70f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 712:	8b 53 f8             	mov    -0x8(%ebx),%edx
 715:	89 10                	mov    %edx,(%eax)
}
 717:	5b                   	pop    %ebx
 718:	5e                   	pop    %esi
 719:	5f                   	pop    %edi
 71a:	5d                   	pop    %ebp
 71b:	c3                   	ret    
 71c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000720 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	57                   	push   %edi
 724:	56                   	push   %esi
 725:	53                   	push   %ebx
 726:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 729:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 72c:	8b 3d e8 0a 00 00    	mov    0xae8,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 732:	8d 70 07             	lea    0x7(%eax),%esi
 735:	c1 ee 03             	shr    $0x3,%esi
 738:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 73b:	85 ff                	test   %edi,%edi
 73d:	0f 84 ad 00 00 00    	je     7f0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 743:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 745:	8b 4a 04             	mov    0x4(%edx),%ecx
 748:	39 f1                	cmp    %esi,%ecx
 74a:	73 72                	jae    7be <malloc+0x9e>
 74c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 752:	bb 00 10 00 00       	mov    $0x1000,%ebx
 757:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 75a:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 761:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 764:	eb 1b                	jmp    781 <malloc+0x61>
 766:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 76d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 770:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 772:	8b 48 04             	mov    0x4(%eax),%ecx
 775:	39 f1                	cmp    %esi,%ecx
 777:	73 4f                	jae    7c8 <malloc+0xa8>
 779:	8b 3d e8 0a 00 00    	mov    0xae8,%edi
 77f:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 781:	39 d7                	cmp    %edx,%edi
 783:	75 eb                	jne    770 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 785:	83 ec 0c             	sub    $0xc,%esp
 788:	ff 75 e4             	pushl  -0x1c(%ebp)
 78b:	e8 e9 fb ff ff       	call   379 <sbrk>
  if(p == (char*)-1)
 790:	83 c4 10             	add    $0x10,%esp
 793:	83 f8 ff             	cmp    $0xffffffff,%eax
 796:	74 1c                	je     7b4 <malloc+0x94>
  hp->s.size = nu;
 798:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 79b:	83 ec 0c             	sub    $0xc,%esp
 79e:	83 c0 08             	add    $0x8,%eax
 7a1:	50                   	push   %eax
 7a2:	e8 e9 fe ff ff       	call   690 <free>
  return freep;
 7a7:	8b 15 e8 0a 00 00    	mov    0xae8,%edx
      if((p = morecore(nunits)) == 0)
 7ad:	83 c4 10             	add    $0x10,%esp
 7b0:	85 d2                	test   %edx,%edx
 7b2:	75 bc                	jne    770 <malloc+0x50>
        return 0;
  }
}
 7b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7b7:	31 c0                	xor    %eax,%eax
}
 7b9:	5b                   	pop    %ebx
 7ba:	5e                   	pop    %esi
 7bb:	5f                   	pop    %edi
 7bc:	5d                   	pop    %ebp
 7bd:	c3                   	ret    
    if(p->s.size >= nunits){
 7be:	89 d0                	mov    %edx,%eax
 7c0:	89 fa                	mov    %edi,%edx
 7c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7c8:	39 ce                	cmp    %ecx,%esi
 7ca:	74 54                	je     820 <malloc+0x100>
        p->s.size -= nunits;
 7cc:	29 f1                	sub    %esi,%ecx
 7ce:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7d1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7d4:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 7d7:	89 15 e8 0a 00 00    	mov    %edx,0xae8
}
 7dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7e0:	83 c0 08             	add    $0x8,%eax
}
 7e3:	5b                   	pop    %ebx
 7e4:	5e                   	pop    %esi
 7e5:	5f                   	pop    %edi
 7e6:	5d                   	pop    %ebp
 7e7:	c3                   	ret    
 7e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7ef:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 7f0:	c7 05 e8 0a 00 00 ec 	movl   $0xaec,0xae8
 7f7:	0a 00 00 
    base.s.size = 0;
 7fa:	bf ec 0a 00 00       	mov    $0xaec,%edi
    base.s.ptr = freep = prevp = &base;
 7ff:	c7 05 ec 0a 00 00 ec 	movl   $0xaec,0xaec
 806:	0a 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 809:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 80b:	c7 05 f0 0a 00 00 00 	movl   $0x0,0xaf0
 812:	00 00 00 
    if(p->s.size >= nunits){
 815:	e9 32 ff ff ff       	jmp    74c <malloc+0x2c>
 81a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 820:	8b 08                	mov    (%eax),%ecx
 822:	89 0a                	mov    %ecx,(%edx)
 824:	eb b1                	jmp    7d7 <malloc+0xb7>
