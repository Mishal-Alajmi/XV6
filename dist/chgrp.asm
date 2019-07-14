
_chgrp:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

int
main(int argc, char * argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
    if(argc < 3 || argc > 3){
   f:	83 39 03             	cmpl   $0x3,(%ecx)
{
  12:	8b 59 04             	mov    0x4(%ecx),%ebx
    if(argc < 3 || argc > 3){
  15:	74 13                	je     2a <main+0x2a>
        printf(1,"Incorrect number of arguments");
  17:	53                   	push   %ebx
  18:	53                   	push   %ebx
  19:	68 78 08 00 00       	push   $0x878
  1e:	6a 01                	push   $0x1
  20:	e8 eb 04 00 00       	call   510 <printf>
        exit();
  25:	e8 17 03 00 00       	call   341 <exit>
    }
    chgrp(argv[2],atoi(argv[1]));
  2a:	83 ec 0c             	sub    $0xc,%esp
  2d:	ff 73 04             	pushl  0x4(%ebx)
  30:	e8 fb 01 00 00       	call   230 <atoi>
  35:	5a                   	pop    %edx
  36:	59                   	pop    %ecx
  37:	50                   	push   %eax
  38:	ff 73 08             	pushl  0x8(%ebx)
  3b:	e8 01 04 00 00       	call   441 <chgrp>
    exit();
  40:	e8 fc 02 00 00       	call   341 <exit>
  45:	66 90                	xchg   %ax,%ax
  47:	66 90                	xchg   %ax,%ax
  49:	66 90                	xchg   %ax,%ax
  4b:	66 90                	xchg   %ax,%ax
  4d:	66 90                	xchg   %ax,%ax
  4f:	90                   	nop

00000050 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  50:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  51:	31 d2                	xor    %edx,%edx
{
  53:	89 e5                	mov    %esp,%ebp
  55:	53                   	push   %ebx
  56:	8b 45 08             	mov    0x8(%ebp),%eax
  59:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  60:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
  64:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  67:	83 c2 01             	add    $0x1,%edx
  6a:	84 c9                	test   %cl,%cl
  6c:	75 f2                	jne    60 <strcpy+0x10>
    ;
  return os;
}
  6e:	5b                   	pop    %ebx
  6f:	5d                   	pop    %ebp
  70:	c3                   	ret    
  71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  7f:	90                   	nop

00000080 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	56                   	push   %esi
  84:	53                   	push   %ebx
  85:	8b 5d 08             	mov    0x8(%ebp),%ebx
  88:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(*p && *p == *q)
  8b:	0f b6 13             	movzbl (%ebx),%edx
  8e:	0f b6 0e             	movzbl (%esi),%ecx
  91:	84 d2                	test   %dl,%dl
  93:	74 1e                	je     b3 <strcmp+0x33>
  95:	b8 01 00 00 00       	mov    $0x1,%eax
  9a:	38 ca                	cmp    %cl,%dl
  9c:	74 09                	je     a7 <strcmp+0x27>
  9e:	eb 20                	jmp    c0 <strcmp+0x40>
  a0:	83 c0 01             	add    $0x1,%eax
  a3:	38 ca                	cmp    %cl,%dl
  a5:	75 19                	jne    c0 <strcmp+0x40>
  a7:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  ab:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
  af:	84 d2                	test   %dl,%dl
  b1:	75 ed                	jne    a0 <strcmp+0x20>
  b3:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  b5:	5b                   	pop    %ebx
  b6:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
  b7:	29 c8                	sub    %ecx,%eax
}
  b9:	5d                   	pop    %ebp
  ba:	c3                   	ret    
  bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bf:	90                   	nop
  c0:	0f b6 c2             	movzbl %dl,%eax
  c3:	5b                   	pop    %ebx
  c4:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
  c5:	29 c8                	sub    %ecx,%eax
}
  c7:	5d                   	pop    %ebp
  c8:	c3                   	ret    
  c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000d0 <strlen>:

uint
strlen(char *s)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  d6:	80 39 00             	cmpb   $0x0,(%ecx)
  d9:	74 15                	je     f0 <strlen+0x20>
  db:	31 d2                	xor    %edx,%edx
  dd:	8d 76 00             	lea    0x0(%esi),%esi
  e0:	83 c2 01             	add    $0x1,%edx
  e3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  e7:	89 d0                	mov    %edx,%eax
  e9:	75 f5                	jne    e0 <strlen+0x10>
    ;
  return n;
}
  eb:	5d                   	pop    %ebp
  ec:	c3                   	ret    
  ed:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
  f0:	31 c0                	xor    %eax,%eax
}
  f2:	5d                   	pop    %ebp
  f3:	c3                   	ret    
  f4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ff:	90                   	nop

00000100 <memset>:

void*
memset(void *dst, int c, uint n)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	57                   	push   %edi
 104:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 107:	8b 4d 10             	mov    0x10(%ebp),%ecx
 10a:	8b 45 0c             	mov    0xc(%ebp),%eax
 10d:	89 d7                	mov    %edx,%edi
 10f:	fc                   	cld    
 110:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 112:	89 d0                	mov    %edx,%eax
 114:	5f                   	pop    %edi
 115:	5d                   	pop    %ebp
 116:	c3                   	ret    
 117:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 11e:	66 90                	xchg   %ax,%ax

00000120 <strchr>:

char*
strchr(const char *s, char c)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	53                   	push   %ebx
 124:	8b 45 08             	mov    0x8(%ebp),%eax
 127:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 12a:	0f b6 18             	movzbl (%eax),%ebx
 12d:	84 db                	test   %bl,%bl
 12f:	74 1d                	je     14e <strchr+0x2e>
 131:	89 d1                	mov    %edx,%ecx
    if(*s == c)
 133:	38 d3                	cmp    %dl,%bl
 135:	75 0d                	jne    144 <strchr+0x24>
 137:	eb 17                	jmp    150 <strchr+0x30>
 139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 140:	38 ca                	cmp    %cl,%dl
 142:	74 0c                	je     150 <strchr+0x30>
  for(; *s; s++)
 144:	83 c0 01             	add    $0x1,%eax
 147:	0f b6 10             	movzbl (%eax),%edx
 14a:	84 d2                	test   %dl,%dl
 14c:	75 f2                	jne    140 <strchr+0x20>
      return (char*)s;
  return 0;
 14e:	31 c0                	xor    %eax,%eax
}
 150:	5b                   	pop    %ebx
 151:	5d                   	pop    %ebp
 152:	c3                   	ret    
 153:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 15a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000160 <gets>:

char*
gets(char *buf, int max)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	57                   	push   %edi
 164:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 165:	31 f6                	xor    %esi,%esi
{
 167:	53                   	push   %ebx
 168:	89 f3                	mov    %esi,%ebx
 16a:	83 ec 1c             	sub    $0x1c,%esp
 16d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 170:	eb 2f                	jmp    1a1 <gets+0x41>
 172:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 178:	83 ec 04             	sub    $0x4,%esp
 17b:	8d 45 e7             	lea    -0x19(%ebp),%eax
 17e:	6a 01                	push   $0x1
 180:	50                   	push   %eax
 181:	6a 00                	push   $0x0
 183:	e8 d1 01 00 00       	call   359 <read>
    if(cc < 1)
 188:	83 c4 10             	add    $0x10,%esp
 18b:	85 c0                	test   %eax,%eax
 18d:	7e 1c                	jle    1ab <gets+0x4b>
      break;
    buf[i++] = c;
 18f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 193:	83 c7 01             	add    $0x1,%edi
 196:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 199:	3c 0a                	cmp    $0xa,%al
 19b:	74 23                	je     1c0 <gets+0x60>
 19d:	3c 0d                	cmp    $0xd,%al
 19f:	74 1f                	je     1c0 <gets+0x60>
  for(i=0; i+1 < max; ){
 1a1:	83 c3 01             	add    $0x1,%ebx
 1a4:	89 fe                	mov    %edi,%esi
 1a6:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1a9:	7c cd                	jl     178 <gets+0x18>
 1ab:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1ad:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 1b0:	c6 03 00             	movb   $0x0,(%ebx)
}
 1b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1b6:	5b                   	pop    %ebx
 1b7:	5e                   	pop    %esi
 1b8:	5f                   	pop    %edi
 1b9:	5d                   	pop    %ebp
 1ba:	c3                   	ret    
 1bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1bf:	90                   	nop
 1c0:	8b 75 08             	mov    0x8(%ebp),%esi
 1c3:	8b 45 08             	mov    0x8(%ebp),%eax
 1c6:	01 de                	add    %ebx,%esi
 1c8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 1ca:	c6 03 00             	movb   $0x0,(%ebx)
}
 1cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1d0:	5b                   	pop    %ebx
 1d1:	5e                   	pop    %esi
 1d2:	5f                   	pop    %edi
 1d3:	5d                   	pop    %ebp
 1d4:	c3                   	ret    
 1d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001e0 <stat>:

int
stat(char *n, struct stat *st)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	56                   	push   %esi
 1e4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e5:	83 ec 08             	sub    $0x8,%esp
 1e8:	6a 00                	push   $0x0
 1ea:	ff 75 08             	pushl  0x8(%ebp)
 1ed:	e8 8f 01 00 00       	call   381 <open>
  if(fd < 0)
 1f2:	83 c4 10             	add    $0x10,%esp
 1f5:	85 c0                	test   %eax,%eax
 1f7:	78 27                	js     220 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1f9:	83 ec 08             	sub    $0x8,%esp
 1fc:	ff 75 0c             	pushl  0xc(%ebp)
 1ff:	89 c3                	mov    %eax,%ebx
 201:	50                   	push   %eax
 202:	e8 92 01 00 00       	call   399 <fstat>
  close(fd);
 207:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 20a:	89 c6                	mov    %eax,%esi
  close(fd);
 20c:	e8 58 01 00 00       	call   369 <close>
  return r;
 211:	83 c4 10             	add    $0x10,%esp
}
 214:	8d 65 f8             	lea    -0x8(%ebp),%esp
 217:	89 f0                	mov    %esi,%eax
 219:	5b                   	pop    %ebx
 21a:	5e                   	pop    %esi
 21b:	5d                   	pop    %ebp
 21c:	c3                   	ret    
 21d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 220:	be ff ff ff ff       	mov    $0xffffffff,%esi
 225:	eb ed                	jmp    214 <stat+0x34>
 227:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 22e:	66 90                	xchg   %ax,%ax

00000230 <atoi>:

#ifdef PDX_XV6
int
atoi(const char *s)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	56                   	push   %esi
 234:	8b 55 08             	mov    0x8(%ebp),%edx
 237:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 238:	0f b6 0a             	movzbl (%edx),%ecx
 23b:	80 f9 20             	cmp    $0x20,%cl
 23e:	75 0b                	jne    24b <atoi+0x1b>
 240:	83 c2 01             	add    $0x1,%edx
 243:	0f b6 0a             	movzbl (%edx),%ecx
 246:	80 f9 20             	cmp    $0x20,%cl
 249:	74 f5                	je     240 <atoi+0x10>
  sign = (*s == '-') ? -1 : 1;
 24b:	80 f9 2d             	cmp    $0x2d,%cl
 24e:	74 40                	je     290 <atoi+0x60>
 250:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 255:	80 f9 2b             	cmp    $0x2b,%cl
 258:	74 3b                	je     295 <atoi+0x65>
    s++;
  while('0' <= *s && *s <= '9')
 25a:	0f be 0a             	movsbl (%edx),%ecx
 25d:	8d 41 d0             	lea    -0x30(%ecx),%eax
 260:	3c 09                	cmp    $0x9,%al
 262:	b8 00 00 00 00       	mov    $0x0,%eax
 267:	77 1f                	ja     288 <atoi+0x58>
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 270:	83 c2 01             	add    $0x1,%edx
 273:	8d 04 80             	lea    (%eax,%eax,4),%eax
 276:	8d 44 41 d0          	lea    -0x30(%ecx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 27a:	0f be 0a             	movsbl (%edx),%ecx
 27d:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 280:	80 fb 09             	cmp    $0x9,%bl
 283:	76 eb                	jbe    270 <atoi+0x40>
 285:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 288:	5b                   	pop    %ebx
 289:	5e                   	pop    %esi
 28a:	5d                   	pop    %ebp
 28b:	c3                   	ret    
 28c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 290:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 295:	83 c2 01             	add    $0x1,%edx
 298:	eb c0                	jmp    25a <atoi+0x2a>
 29a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002a0 <atoo>:

int
atoo(const char *s)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	56                   	push   %esi
 2a4:	8b 55 08             	mov    0x8(%ebp),%edx
 2a7:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 2a8:	0f b6 0a             	movzbl (%edx),%ecx
 2ab:	80 f9 20             	cmp    $0x20,%cl
 2ae:	75 0b                	jne    2bb <atoo+0x1b>
 2b0:	83 c2 01             	add    $0x1,%edx
 2b3:	0f b6 0a             	movzbl (%edx),%ecx
 2b6:	80 f9 20             	cmp    $0x20,%cl
 2b9:	74 f5                	je     2b0 <atoo+0x10>
  sign = (*s == '-') ? -1 : 1;
 2bb:	80 f9 2d             	cmp    $0x2d,%cl
 2be:	74 40                	je     300 <atoo+0x60>
 2c0:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 2c5:	80 f9 2b             	cmp    $0x2b,%cl
 2c8:	74 3b                	je     305 <atoo+0x65>
    s++;
  while('0' <= *s && *s <= '7')
 2ca:	0f be 0a             	movsbl (%edx),%ecx
 2cd:	8d 41 d0             	lea    -0x30(%ecx),%eax
 2d0:	3c 07                	cmp    $0x7,%al
 2d2:	b8 00 00 00 00       	mov    $0x0,%eax
 2d7:	77 1c                	ja     2f5 <atoo+0x55>
 2d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*8 + *s++ - '0';
 2e0:	83 c2 01             	add    $0x1,%edx
 2e3:	8d 44 c1 d0          	lea    -0x30(%ecx,%eax,8),%eax
  while('0' <= *s && *s <= '7')
 2e7:	0f be 0a             	movsbl (%edx),%ecx
 2ea:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 2ed:	80 fb 07             	cmp    $0x7,%bl
 2f0:	76 ee                	jbe    2e0 <atoo+0x40>
 2f2:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 2f5:	5b                   	pop    %ebx
 2f6:	5e                   	pop    %esi
 2f7:	5d                   	pop    %ebp
 2f8:	c3                   	ret    
 2f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 300:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 305:	83 c2 01             	add    $0x1,%edx
 308:	eb c0                	jmp    2ca <atoo+0x2a>
 30a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000310 <memmove>:
}
#endif // PDX_XV6

void*
memmove(void *vdst, void *vsrc, int n)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	8b 55 10             	mov    0x10(%ebp),%edx
 317:	8b 45 08             	mov    0x8(%ebp),%eax
 31a:	56                   	push   %esi
 31b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 31e:	85 d2                	test   %edx,%edx
 320:	7e 13                	jle    335 <memmove+0x25>
 322:	01 c2                	add    %eax,%edx
  dst = vdst;
 324:	89 c7                	mov    %eax,%edi
 326:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 32d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 330:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 331:	39 fa                	cmp    %edi,%edx
 333:	75 fb                	jne    330 <memmove+0x20>
  return vdst;
}
 335:	5e                   	pop    %esi
 336:	5f                   	pop    %edi
 337:	5d                   	pop    %ebp
 338:	c3                   	ret    

00000339 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 339:	b8 01 00 00 00       	mov    $0x1,%eax
 33e:	cd 40                	int    $0x40
 340:	c3                   	ret    

00000341 <exit>:
SYSCALL(exit)
 341:	b8 02 00 00 00       	mov    $0x2,%eax
 346:	cd 40                	int    $0x40
 348:	c3                   	ret    

00000349 <wait>:
SYSCALL(wait)
 349:	b8 03 00 00 00       	mov    $0x3,%eax
 34e:	cd 40                	int    $0x40
 350:	c3                   	ret    

00000351 <pipe>:
SYSCALL(pipe)
 351:	b8 04 00 00 00       	mov    $0x4,%eax
 356:	cd 40                	int    $0x40
 358:	c3                   	ret    

00000359 <read>:
SYSCALL(read)
 359:	b8 05 00 00 00       	mov    $0x5,%eax
 35e:	cd 40                	int    $0x40
 360:	c3                   	ret    

00000361 <write>:
SYSCALL(write)
 361:	b8 10 00 00 00       	mov    $0x10,%eax
 366:	cd 40                	int    $0x40
 368:	c3                   	ret    

00000369 <close>:
SYSCALL(close)
 369:	b8 15 00 00 00       	mov    $0x15,%eax
 36e:	cd 40                	int    $0x40
 370:	c3                   	ret    

00000371 <kill>:
SYSCALL(kill)
 371:	b8 06 00 00 00       	mov    $0x6,%eax
 376:	cd 40                	int    $0x40
 378:	c3                   	ret    

00000379 <exec>:
SYSCALL(exec)
 379:	b8 07 00 00 00       	mov    $0x7,%eax
 37e:	cd 40                	int    $0x40
 380:	c3                   	ret    

00000381 <open>:
SYSCALL(open)
 381:	b8 0f 00 00 00       	mov    $0xf,%eax
 386:	cd 40                	int    $0x40
 388:	c3                   	ret    

00000389 <mknod>:
SYSCALL(mknod)
 389:	b8 11 00 00 00       	mov    $0x11,%eax
 38e:	cd 40                	int    $0x40
 390:	c3                   	ret    

00000391 <unlink>:
SYSCALL(unlink)
 391:	b8 12 00 00 00       	mov    $0x12,%eax
 396:	cd 40                	int    $0x40
 398:	c3                   	ret    

00000399 <fstat>:
SYSCALL(fstat)
 399:	b8 08 00 00 00       	mov    $0x8,%eax
 39e:	cd 40                	int    $0x40
 3a0:	c3                   	ret    

000003a1 <link>:
SYSCALL(link)
 3a1:	b8 13 00 00 00       	mov    $0x13,%eax
 3a6:	cd 40                	int    $0x40
 3a8:	c3                   	ret    

000003a9 <mkdir>:
SYSCALL(mkdir)
 3a9:	b8 14 00 00 00       	mov    $0x14,%eax
 3ae:	cd 40                	int    $0x40
 3b0:	c3                   	ret    

000003b1 <chdir>:
SYSCALL(chdir)
 3b1:	b8 09 00 00 00       	mov    $0x9,%eax
 3b6:	cd 40                	int    $0x40
 3b8:	c3                   	ret    

000003b9 <dup>:
SYSCALL(dup)
 3b9:	b8 0a 00 00 00       	mov    $0xa,%eax
 3be:	cd 40                	int    $0x40
 3c0:	c3                   	ret    

000003c1 <getpid>:
SYSCALL(getpid)
 3c1:	b8 0b 00 00 00       	mov    $0xb,%eax
 3c6:	cd 40                	int    $0x40
 3c8:	c3                   	ret    

000003c9 <sbrk>:
SYSCALL(sbrk)
 3c9:	b8 0c 00 00 00       	mov    $0xc,%eax
 3ce:	cd 40                	int    $0x40
 3d0:	c3                   	ret    

000003d1 <sleep>:
SYSCALL(sleep)
 3d1:	b8 0d 00 00 00       	mov    $0xd,%eax
 3d6:	cd 40                	int    $0x40
 3d8:	c3                   	ret    

000003d9 <uptime>:
SYSCALL(uptime)
 3d9:	b8 0e 00 00 00       	mov    $0xe,%eax
 3de:	cd 40                	int    $0x40
 3e0:	c3                   	ret    

000003e1 <halt>:
SYSCALL(halt)
 3e1:	b8 16 00 00 00       	mov    $0x16,%eax
 3e6:	cd 40                	int    $0x40
 3e8:	c3                   	ret    

000003e9 <date>:
SYSCALL(date)
 3e9:	b8 17 00 00 00       	mov    $0x17,%eax
 3ee:	cd 40                	int    $0x40
 3f0:	c3                   	ret    

000003f1 <getgid>:
SYSCALL(getgid)
 3f1:	b8 18 00 00 00       	mov    $0x18,%eax
 3f6:	cd 40                	int    $0x40
 3f8:	c3                   	ret    

000003f9 <setgid>:
SYSCALL(setgid)
 3f9:	b8 19 00 00 00       	mov    $0x19,%eax
 3fe:	cd 40                	int    $0x40
 400:	c3                   	ret    

00000401 <getuid>:
SYSCALL(getuid)
 401:	b8 1a 00 00 00       	mov    $0x1a,%eax
 406:	cd 40                	int    $0x40
 408:	c3                   	ret    

00000409 <setuid>:
SYSCALL(setuid)
 409:	b8 1b 00 00 00       	mov    $0x1b,%eax
 40e:	cd 40                	int    $0x40
 410:	c3                   	ret    

00000411 <getppid>:
SYSCALL(getppid)
 411:	b8 1c 00 00 00       	mov    $0x1c,%eax
 416:	cd 40                	int    $0x40
 418:	c3                   	ret    

00000419 <getprocs>:
SYSCALL(getprocs)
 419:	b8 1d 00 00 00       	mov    $0x1d,%eax
 41e:	cd 40                	int    $0x40
 420:	c3                   	ret    

00000421 <setpriority>:
SYSCALL(setpriority)
 421:	b8 1e 00 00 00       	mov    $0x1e,%eax
 426:	cd 40                	int    $0x40
 428:	c3                   	ret    

00000429 <getpriority>:
SYSCALL(getpriority)
 429:	b8 1f 00 00 00       	mov    $0x1f,%eax
 42e:	cd 40                	int    $0x40
 430:	c3                   	ret    

00000431 <chmod>:
SYSCALL(chmod)
 431:	b8 20 00 00 00       	mov    $0x20,%eax
 436:	cd 40                	int    $0x40
 438:	c3                   	ret    

00000439 <chown>:
SYSCALL(chown)
 439:	b8 21 00 00 00       	mov    $0x21,%eax
 43e:	cd 40                	int    $0x40
 440:	c3                   	ret    

00000441 <chgrp>:
SYSCALL(chgrp)
 441:	b8 22 00 00 00       	mov    $0x22,%eax
 446:	cd 40                	int    $0x40
 448:	c3                   	ret    
 449:	66 90                	xchg   %ax,%ax
 44b:	66 90                	xchg   %ax,%ax
 44d:	66 90                	xchg   %ax,%ax
 44f:	90                   	nop

00000450 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
 455:	53                   	push   %ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 456:	89 d3                	mov    %edx,%ebx
{
 458:	83 ec 3c             	sub    $0x3c,%esp
 45b:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 45e:	85 d2                	test   %edx,%edx
 460:	0f 89 92 00 00 00    	jns    4f8 <printint+0xa8>
 466:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 46a:	0f 84 88 00 00 00    	je     4f8 <printint+0xa8>
    neg = 1;
 470:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 477:	f7 db                	neg    %ebx
  } else {
    x = xx;
  }

  i = 0;
 479:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 480:	8d 75 d7             	lea    -0x29(%ebp),%esi
 483:	eb 08                	jmp    48d <printint+0x3d>
 485:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 488:	89 7d c4             	mov    %edi,-0x3c(%ebp)
  }while((x /= base) != 0);
 48b:	89 c3                	mov    %eax,%ebx
    buf[i++] = digits[x % base];
 48d:	89 d8                	mov    %ebx,%eax
 48f:	31 d2                	xor    %edx,%edx
 491:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 494:	f7 f1                	div    %ecx
 496:	83 c7 01             	add    $0x1,%edi
 499:	0f b6 92 a0 08 00 00 	movzbl 0x8a0(%edx),%edx
 4a0:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 4a3:	39 d9                	cmp    %ebx,%ecx
 4a5:	76 e1                	jbe    488 <printint+0x38>
  if(neg)
 4a7:	8b 45 c0             	mov    -0x40(%ebp),%eax
 4aa:	85 c0                	test   %eax,%eax
 4ac:	74 0d                	je     4bb <printint+0x6b>
    buf[i++] = '-';
 4ae:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 4b3:	ba 2d 00 00 00       	mov    $0x2d,%edx
    buf[i++] = digits[x % base];
 4b8:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 4bb:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4be:	8b 7d bc             	mov    -0x44(%ebp),%edi
 4c1:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 4c5:	eb 0f                	jmp    4d6 <printint+0x86>
 4c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ce:	66 90                	xchg   %ax,%ax
 4d0:	0f b6 13             	movzbl (%ebx),%edx
 4d3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 4d6:	83 ec 04             	sub    $0x4,%esp
 4d9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 4dc:	6a 01                	push   $0x1
 4de:	56                   	push   %esi
 4df:	57                   	push   %edi
 4e0:	e8 7c fe ff ff       	call   361 <write>

  while(--i >= 0)
 4e5:	83 c4 10             	add    $0x10,%esp
 4e8:	39 de                	cmp    %ebx,%esi
 4ea:	75 e4                	jne    4d0 <printint+0x80>
    putc(fd, buf[i]);
}
 4ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4ef:	5b                   	pop    %ebx
 4f0:	5e                   	pop    %esi
 4f1:	5f                   	pop    %edi
 4f2:	5d                   	pop    %ebp
 4f3:	c3                   	ret    
 4f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4f8:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 4ff:	e9 75 ff ff ff       	jmp    479 <printint+0x29>
 504:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 50b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 50f:	90                   	nop

00000510 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	57                   	push   %edi
 514:	56                   	push   %esi
 515:	53                   	push   %ebx
 516:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 519:	8b 75 0c             	mov    0xc(%ebp),%esi
 51c:	0f b6 1e             	movzbl (%esi),%ebx
 51f:	84 db                	test   %bl,%bl
 521:	0f 84 b9 00 00 00    	je     5e0 <printf+0xd0>
  ap = (uint*)(void*)&fmt + 1;
 527:	8d 45 10             	lea    0x10(%ebp),%eax
 52a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 52d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 530:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 532:	89 45 d0             	mov    %eax,-0x30(%ebp)
 535:	eb 38                	jmp    56f <printf+0x5f>
 537:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 53e:	66 90                	xchg   %ax,%ax
 540:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 543:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 548:	83 f8 25             	cmp    $0x25,%eax
 54b:	74 17                	je     564 <printf+0x54>
  write(fd, &c, 1);
 54d:	83 ec 04             	sub    $0x4,%esp
 550:	88 5d e7             	mov    %bl,-0x19(%ebp)
 553:	6a 01                	push   $0x1
 555:	57                   	push   %edi
 556:	ff 75 08             	pushl  0x8(%ebp)
 559:	e8 03 fe ff ff       	call   361 <write>
 55e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 561:	83 c4 10             	add    $0x10,%esp
 564:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 567:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 56b:	84 db                	test   %bl,%bl
 56d:	74 71                	je     5e0 <printf+0xd0>
    c = fmt[i] & 0xff;
 56f:	0f be cb             	movsbl %bl,%ecx
 572:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 575:	85 d2                	test   %edx,%edx
 577:	74 c7                	je     540 <printf+0x30>
      }
    } else if(state == '%'){
 579:	83 fa 25             	cmp    $0x25,%edx
 57c:	75 e6                	jne    564 <printf+0x54>
      if(c == 'd'){
 57e:	83 f8 64             	cmp    $0x64,%eax
 581:	0f 84 99 00 00 00    	je     620 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 587:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 58d:	83 f9 70             	cmp    $0x70,%ecx
 590:	74 5e                	je     5f0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 592:	83 f8 73             	cmp    $0x73,%eax
 595:	0f 84 d5 00 00 00    	je     670 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 59b:	83 f8 63             	cmp    $0x63,%eax
 59e:	0f 84 8c 00 00 00    	je     630 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5a4:	83 f8 25             	cmp    $0x25,%eax
 5a7:	0f 84 b3 00 00 00    	je     660 <printf+0x150>
  write(fd, &c, 1);
 5ad:	83 ec 04             	sub    $0x4,%esp
 5b0:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5b4:	6a 01                	push   $0x1
 5b6:	57                   	push   %edi
 5b7:	ff 75 08             	pushl  0x8(%ebp)
 5ba:	e8 a2 fd ff ff       	call   361 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5bf:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 5c2:	83 c4 0c             	add    $0xc,%esp
 5c5:	6a 01                	push   $0x1
 5c7:	83 c6 01             	add    $0x1,%esi
 5ca:	57                   	push   %edi
 5cb:	ff 75 08             	pushl  0x8(%ebp)
 5ce:	e8 8e fd ff ff       	call   361 <write>
  for(i = 0; fmt[i]; i++){
 5d3:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 5d7:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5da:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 5dc:	84 db                	test   %bl,%bl
 5de:	75 8f                	jne    56f <printf+0x5f>
    }
  }
}
 5e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5e3:	5b                   	pop    %ebx
 5e4:	5e                   	pop    %esi
 5e5:	5f                   	pop    %edi
 5e6:	5d                   	pop    %ebp
 5e7:	c3                   	ret    
 5e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ef:	90                   	nop
        printint(fd, *ap, 16, 0);
 5f0:	83 ec 0c             	sub    $0xc,%esp
 5f3:	b9 10 00 00 00       	mov    $0x10,%ecx
 5f8:	6a 00                	push   $0x0
 5fa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5fd:	8b 45 08             	mov    0x8(%ebp),%eax
 600:	8b 13                	mov    (%ebx),%edx
 602:	e8 49 fe ff ff       	call   450 <printint>
        ap++;
 607:	89 d8                	mov    %ebx,%eax
 609:	83 c4 10             	add    $0x10,%esp
      state = 0;
 60c:	31 d2                	xor    %edx,%edx
        ap++;
 60e:	83 c0 04             	add    $0x4,%eax
 611:	89 45 d0             	mov    %eax,-0x30(%ebp)
 614:	e9 4b ff ff ff       	jmp    564 <printf+0x54>
 619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 620:	83 ec 0c             	sub    $0xc,%esp
 623:	b9 0a 00 00 00       	mov    $0xa,%ecx
 628:	6a 01                	push   $0x1
 62a:	eb ce                	jmp    5fa <printf+0xea>
 62c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 630:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 633:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 636:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 638:	6a 01                	push   $0x1
        ap++;
 63a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 63d:	57                   	push   %edi
 63e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 641:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 644:	e8 18 fd ff ff       	call   361 <write>
        ap++;
 649:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 64c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 64f:	31 d2                	xor    %edx,%edx
 651:	e9 0e ff ff ff       	jmp    564 <printf+0x54>
 656:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 65d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 660:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 663:	83 ec 04             	sub    $0x4,%esp
 666:	e9 5a ff ff ff       	jmp    5c5 <printf+0xb5>
 66b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 66f:	90                   	nop
        s = (char*)*ap;
 670:	8b 45 d0             	mov    -0x30(%ebp),%eax
 673:	8b 18                	mov    (%eax),%ebx
        ap++;
 675:	83 c0 04             	add    $0x4,%eax
 678:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 67b:	85 db                	test   %ebx,%ebx
 67d:	74 17                	je     696 <printf+0x186>
        while(*s != 0){
 67f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 682:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 684:	84 c0                	test   %al,%al
 686:	0f 84 d8 fe ff ff    	je     564 <printf+0x54>
 68c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 68f:	89 de                	mov    %ebx,%esi
 691:	8b 5d 08             	mov    0x8(%ebp),%ebx
 694:	eb 1a                	jmp    6b0 <printf+0x1a0>
          s = "(null)";
 696:	bb 96 08 00 00       	mov    $0x896,%ebx
        while(*s != 0){
 69b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 69e:	b8 28 00 00 00       	mov    $0x28,%eax
 6a3:	89 de                	mov    %ebx,%esi
 6a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6af:	90                   	nop
  write(fd, &c, 1);
 6b0:	83 ec 04             	sub    $0x4,%esp
          s++;
 6b3:	83 c6 01             	add    $0x1,%esi
 6b6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6b9:	6a 01                	push   $0x1
 6bb:	57                   	push   %edi
 6bc:	53                   	push   %ebx
 6bd:	e8 9f fc ff ff       	call   361 <write>
        while(*s != 0){
 6c2:	0f b6 06             	movzbl (%esi),%eax
 6c5:	83 c4 10             	add    $0x10,%esp
 6c8:	84 c0                	test   %al,%al
 6ca:	75 e4                	jne    6b0 <printf+0x1a0>
 6cc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 6cf:	31 d2                	xor    %edx,%edx
 6d1:	e9 8e fe ff ff       	jmp    564 <printf+0x54>
 6d6:	66 90                	xchg   %ax,%ax
 6d8:	66 90                	xchg   %ax,%ax
 6da:	66 90                	xchg   %ax,%ax
 6dc:	66 90                	xchg   %ax,%ax
 6de:	66 90                	xchg   %ax,%ax

000006e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e1:	a1 80 0b 00 00       	mov    0xb80,%eax
{
 6e6:	89 e5                	mov    %esp,%ebp
 6e8:	57                   	push   %edi
 6e9:	56                   	push   %esi
 6ea:	53                   	push   %ebx
 6eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6ee:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 6f0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f3:	39 c8                	cmp    %ecx,%eax
 6f5:	73 19                	jae    710 <free+0x30>
 6f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6fe:	66 90                	xchg   %ax,%ax
 700:	39 d1                	cmp    %edx,%ecx
 702:	72 14                	jb     718 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 704:	39 d0                	cmp    %edx,%eax
 706:	73 10                	jae    718 <free+0x38>
{
 708:	89 d0                	mov    %edx,%eax
 70a:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 70c:	39 c8                	cmp    %ecx,%eax
 70e:	72 f0                	jb     700 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 710:	39 d0                	cmp    %edx,%eax
 712:	72 f4                	jb     708 <free+0x28>
 714:	39 d1                	cmp    %edx,%ecx
 716:	73 f0                	jae    708 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 718:	8b 73 fc             	mov    -0x4(%ebx),%esi
 71b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 71e:	39 fa                	cmp    %edi,%edx
 720:	74 1e                	je     740 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 722:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 725:	8b 50 04             	mov    0x4(%eax),%edx
 728:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 72b:	39 f1                	cmp    %esi,%ecx
 72d:	74 28                	je     757 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 72f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 731:	5b                   	pop    %ebx
  freep = p;
 732:	a3 80 0b 00 00       	mov    %eax,0xb80
}
 737:	5e                   	pop    %esi
 738:	5f                   	pop    %edi
 739:	5d                   	pop    %ebp
 73a:	c3                   	ret    
 73b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 73f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 740:	03 72 04             	add    0x4(%edx),%esi
 743:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 746:	8b 10                	mov    (%eax),%edx
 748:	8b 12                	mov    (%edx),%edx
 74a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 74d:	8b 50 04             	mov    0x4(%eax),%edx
 750:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 753:	39 f1                	cmp    %esi,%ecx
 755:	75 d8                	jne    72f <free+0x4f>
    p->s.size += bp->s.size;
 757:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 75a:	a3 80 0b 00 00       	mov    %eax,0xb80
    p->s.size += bp->s.size;
 75f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 762:	8b 53 f8             	mov    -0x8(%ebx),%edx
 765:	89 10                	mov    %edx,(%eax)
}
 767:	5b                   	pop    %ebx
 768:	5e                   	pop    %esi
 769:	5f                   	pop    %edi
 76a:	5d                   	pop    %ebp
 76b:	c3                   	ret    
 76c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000770 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 770:	55                   	push   %ebp
 771:	89 e5                	mov    %esp,%ebp
 773:	57                   	push   %edi
 774:	56                   	push   %esi
 775:	53                   	push   %ebx
 776:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 779:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 77c:	8b 3d 80 0b 00 00    	mov    0xb80,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 782:	8d 70 07             	lea    0x7(%eax),%esi
 785:	c1 ee 03             	shr    $0x3,%esi
 788:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 78b:	85 ff                	test   %edi,%edi
 78d:	0f 84 ad 00 00 00    	je     840 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 793:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 795:	8b 4a 04             	mov    0x4(%edx),%ecx
 798:	39 f1                	cmp    %esi,%ecx
 79a:	73 72                	jae    80e <malloc+0x9e>
 79c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 7a2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7a7:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 7aa:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 7b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 7b4:	eb 1b                	jmp    7d1 <malloc+0x61>
 7b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7bd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7c2:	8b 48 04             	mov    0x4(%eax),%ecx
 7c5:	39 f1                	cmp    %esi,%ecx
 7c7:	73 4f                	jae    818 <malloc+0xa8>
 7c9:	8b 3d 80 0b 00 00    	mov    0xb80,%edi
 7cf:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7d1:	39 d7                	cmp    %edx,%edi
 7d3:	75 eb                	jne    7c0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 7d5:	83 ec 0c             	sub    $0xc,%esp
 7d8:	ff 75 e4             	pushl  -0x1c(%ebp)
 7db:	e8 e9 fb ff ff       	call   3c9 <sbrk>
  if(p == (char*)-1)
 7e0:	83 c4 10             	add    $0x10,%esp
 7e3:	83 f8 ff             	cmp    $0xffffffff,%eax
 7e6:	74 1c                	je     804 <malloc+0x94>
  hp->s.size = nu;
 7e8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7eb:	83 ec 0c             	sub    $0xc,%esp
 7ee:	83 c0 08             	add    $0x8,%eax
 7f1:	50                   	push   %eax
 7f2:	e8 e9 fe ff ff       	call   6e0 <free>
  return freep;
 7f7:	8b 15 80 0b 00 00    	mov    0xb80,%edx
      if((p = morecore(nunits)) == 0)
 7fd:	83 c4 10             	add    $0x10,%esp
 800:	85 d2                	test   %edx,%edx
 802:	75 bc                	jne    7c0 <malloc+0x50>
        return 0;
  }
}
 804:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 807:	31 c0                	xor    %eax,%eax
}
 809:	5b                   	pop    %ebx
 80a:	5e                   	pop    %esi
 80b:	5f                   	pop    %edi
 80c:	5d                   	pop    %ebp
 80d:	c3                   	ret    
    if(p->s.size >= nunits){
 80e:	89 d0                	mov    %edx,%eax
 810:	89 fa                	mov    %edi,%edx
 812:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 818:	39 ce                	cmp    %ecx,%esi
 81a:	74 54                	je     870 <malloc+0x100>
        p->s.size -= nunits;
 81c:	29 f1                	sub    %esi,%ecx
 81e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 821:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 824:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 827:	89 15 80 0b 00 00    	mov    %edx,0xb80
}
 82d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 830:	83 c0 08             	add    $0x8,%eax
}
 833:	5b                   	pop    %ebx
 834:	5e                   	pop    %esi
 835:	5f                   	pop    %edi
 836:	5d                   	pop    %ebp
 837:	c3                   	ret    
 838:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 83f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 840:	c7 05 80 0b 00 00 84 	movl   $0xb84,0xb80
 847:	0b 00 00 
    base.s.size = 0;
 84a:	bf 84 0b 00 00       	mov    $0xb84,%edi
    base.s.ptr = freep = prevp = &base;
 84f:	c7 05 84 0b 00 00 84 	movl   $0xb84,0xb84
 856:	0b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 859:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 85b:	c7 05 88 0b 00 00 00 	movl   $0x0,0xb88
 862:	00 00 00 
    if(p->s.size >= nunits){
 865:	e9 32 ff ff ff       	jmp    79c <malloc+0x2c>
 86a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 870:	8b 08                	mov    (%eax),%ecx
 872:	89 0a                	mov    %ecx,(%edx)
 874:	eb b1                	jmp    827 <malloc+0xb7>
