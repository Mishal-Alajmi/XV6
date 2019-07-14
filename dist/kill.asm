
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "pdx.h"
#endif // PDX_XV6

int
main(int argc, char **argv)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 0c             	sub    $0xc,%esp
  13:	8b 01                	mov    (%ecx),%eax
  15:	8b 51 04             	mov    0x4(%ecx),%edx
  int i;

  if(argc < 2){
  18:	83 f8 01             	cmp    $0x1,%eax
  1b:	7e 2c                	jle    49 <main+0x49>
  1d:	8d 5a 04             	lea    0x4(%edx),%ebx
  20:	8d 34 82             	lea    (%edx,%eax,4),%esi
  23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  27:	90                   	nop
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  28:	83 ec 0c             	sub    $0xc,%esp
  2b:	ff 33                	pushl  (%ebx)
  2d:	83 c3 04             	add    $0x4,%ebx
  30:	e8 0b 02 00 00       	call   240 <atoi>
  35:	89 04 24             	mov    %eax,(%esp)
  38:	e8 44 03 00 00       	call   381 <kill>
  for(i=1; i<argc; i++)
  3d:	83 c4 10             	add    $0x10,%esp
  40:	39 f3                	cmp    %esi,%ebx
  42:	75 e4                	jne    28 <main+0x28>
  exit();
  44:	e8 08 03 00 00       	call   351 <exit>
    printf(2, "usage: kill pid...\n");
  49:	50                   	push   %eax
  4a:	50                   	push   %eax
  4b:	68 88 08 00 00       	push   $0x888
  50:	6a 02                	push   $0x2
  52:	e8 c9 04 00 00       	call   520 <printf>
    exit();
  57:	e8 f5 02 00 00       	call   351 <exit>
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  60:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  61:	31 d2                	xor    %edx,%edx
{
  63:	89 e5                	mov    %esp,%ebp
  65:	53                   	push   %ebx
  66:	8b 45 08             	mov    0x8(%ebp),%eax
  69:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  70:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
  74:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  77:	83 c2 01             	add    $0x1,%edx
  7a:	84 c9                	test   %cl,%cl
  7c:	75 f2                	jne    70 <strcpy+0x10>
    ;
  return os;
}
  7e:	5b                   	pop    %ebx
  7f:	5d                   	pop    %ebp
  80:	c3                   	ret    
  81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  8f:	90                   	nop

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	56                   	push   %esi
  94:	53                   	push   %ebx
  95:	8b 5d 08             	mov    0x8(%ebp),%ebx
  98:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(*p && *p == *q)
  9b:	0f b6 13             	movzbl (%ebx),%edx
  9e:	0f b6 0e             	movzbl (%esi),%ecx
  a1:	84 d2                	test   %dl,%dl
  a3:	74 1e                	je     c3 <strcmp+0x33>
  a5:	b8 01 00 00 00       	mov    $0x1,%eax
  aa:	38 ca                	cmp    %cl,%dl
  ac:	74 09                	je     b7 <strcmp+0x27>
  ae:	eb 20                	jmp    d0 <strcmp+0x40>
  b0:	83 c0 01             	add    $0x1,%eax
  b3:	38 ca                	cmp    %cl,%dl
  b5:	75 19                	jne    d0 <strcmp+0x40>
  b7:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  bb:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
  bf:	84 d2                	test   %dl,%dl
  c1:	75 ed                	jne    b0 <strcmp+0x20>
  c3:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  c5:	5b                   	pop    %ebx
  c6:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
  c7:	29 c8                	sub    %ecx,%eax
}
  c9:	5d                   	pop    %ebp
  ca:	c3                   	ret    
  cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  cf:	90                   	nop
  d0:	0f b6 c2             	movzbl %dl,%eax
  d3:	5b                   	pop    %ebx
  d4:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
  d5:	29 c8                	sub    %ecx,%eax
}
  d7:	5d                   	pop    %ebp
  d8:	c3                   	ret    
  d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000e0 <strlen>:

uint
strlen(char *s)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  e6:	80 39 00             	cmpb   $0x0,(%ecx)
  e9:	74 15                	je     100 <strlen+0x20>
  eb:	31 d2                	xor    %edx,%edx
  ed:	8d 76 00             	lea    0x0(%esi),%esi
  f0:	83 c2 01             	add    $0x1,%edx
  f3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  f7:	89 d0                	mov    %edx,%eax
  f9:	75 f5                	jne    f0 <strlen+0x10>
    ;
  return n;
}
  fb:	5d                   	pop    %ebp
  fc:	c3                   	ret    
  fd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 100:	31 c0                	xor    %eax,%eax
}
 102:	5d                   	pop    %ebp
 103:	c3                   	ret    
 104:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 10b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 10f:	90                   	nop

00000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 117:	8b 4d 10             	mov    0x10(%ebp),%ecx
 11a:	8b 45 0c             	mov    0xc(%ebp),%eax
 11d:	89 d7                	mov    %edx,%edi
 11f:	fc                   	cld    
 120:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 122:	89 d0                	mov    %edx,%eax
 124:	5f                   	pop    %edi
 125:	5d                   	pop    %ebp
 126:	c3                   	ret    
 127:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 12e:	66 90                	xchg   %ax,%ax

00000130 <strchr>:

char*
strchr(const char *s, char c)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	53                   	push   %ebx
 134:	8b 45 08             	mov    0x8(%ebp),%eax
 137:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 13a:	0f b6 18             	movzbl (%eax),%ebx
 13d:	84 db                	test   %bl,%bl
 13f:	74 1d                	je     15e <strchr+0x2e>
 141:	89 d1                	mov    %edx,%ecx
    if(*s == c)
 143:	38 d3                	cmp    %dl,%bl
 145:	75 0d                	jne    154 <strchr+0x24>
 147:	eb 17                	jmp    160 <strchr+0x30>
 149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 150:	38 ca                	cmp    %cl,%dl
 152:	74 0c                	je     160 <strchr+0x30>
  for(; *s; s++)
 154:	83 c0 01             	add    $0x1,%eax
 157:	0f b6 10             	movzbl (%eax),%edx
 15a:	84 d2                	test   %dl,%dl
 15c:	75 f2                	jne    150 <strchr+0x20>
      return (char*)s;
  return 0;
 15e:	31 c0                	xor    %eax,%eax
}
 160:	5b                   	pop    %ebx
 161:	5d                   	pop    %ebp
 162:	c3                   	ret    
 163:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 16a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000170 <gets>:

char*
gets(char *buf, int max)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	57                   	push   %edi
 174:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 175:	31 f6                	xor    %esi,%esi
{
 177:	53                   	push   %ebx
 178:	89 f3                	mov    %esi,%ebx
 17a:	83 ec 1c             	sub    $0x1c,%esp
 17d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 180:	eb 2f                	jmp    1b1 <gets+0x41>
 182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 188:	83 ec 04             	sub    $0x4,%esp
 18b:	8d 45 e7             	lea    -0x19(%ebp),%eax
 18e:	6a 01                	push   $0x1
 190:	50                   	push   %eax
 191:	6a 00                	push   $0x0
 193:	e8 d1 01 00 00       	call   369 <read>
    if(cc < 1)
 198:	83 c4 10             	add    $0x10,%esp
 19b:	85 c0                	test   %eax,%eax
 19d:	7e 1c                	jle    1bb <gets+0x4b>
      break;
    buf[i++] = c;
 19f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1a3:	83 c7 01             	add    $0x1,%edi
 1a6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 1a9:	3c 0a                	cmp    $0xa,%al
 1ab:	74 23                	je     1d0 <gets+0x60>
 1ad:	3c 0d                	cmp    $0xd,%al
 1af:	74 1f                	je     1d0 <gets+0x60>
  for(i=0; i+1 < max; ){
 1b1:	83 c3 01             	add    $0x1,%ebx
 1b4:	89 fe                	mov    %edi,%esi
 1b6:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1b9:	7c cd                	jl     188 <gets+0x18>
 1bb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1bd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 1c0:	c6 03 00             	movb   $0x0,(%ebx)
}
 1c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1c6:	5b                   	pop    %ebx
 1c7:	5e                   	pop    %esi
 1c8:	5f                   	pop    %edi
 1c9:	5d                   	pop    %ebp
 1ca:	c3                   	ret    
 1cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1cf:	90                   	nop
 1d0:	8b 75 08             	mov    0x8(%ebp),%esi
 1d3:	8b 45 08             	mov    0x8(%ebp),%eax
 1d6:	01 de                	add    %ebx,%esi
 1d8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 1da:	c6 03 00             	movb   $0x0,(%ebx)
}
 1dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1e0:	5b                   	pop    %ebx
 1e1:	5e                   	pop    %esi
 1e2:	5f                   	pop    %edi
 1e3:	5d                   	pop    %ebp
 1e4:	c3                   	ret    
 1e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001f0 <stat>:

int
stat(char *n, struct stat *st)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	56                   	push   %esi
 1f4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f5:	83 ec 08             	sub    $0x8,%esp
 1f8:	6a 00                	push   $0x0
 1fa:	ff 75 08             	pushl  0x8(%ebp)
 1fd:	e8 8f 01 00 00       	call   391 <open>
  if(fd < 0)
 202:	83 c4 10             	add    $0x10,%esp
 205:	85 c0                	test   %eax,%eax
 207:	78 27                	js     230 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 209:	83 ec 08             	sub    $0x8,%esp
 20c:	ff 75 0c             	pushl  0xc(%ebp)
 20f:	89 c3                	mov    %eax,%ebx
 211:	50                   	push   %eax
 212:	e8 92 01 00 00       	call   3a9 <fstat>
  close(fd);
 217:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 21a:	89 c6                	mov    %eax,%esi
  close(fd);
 21c:	e8 58 01 00 00       	call   379 <close>
  return r;
 221:	83 c4 10             	add    $0x10,%esp
}
 224:	8d 65 f8             	lea    -0x8(%ebp),%esp
 227:	89 f0                	mov    %esi,%eax
 229:	5b                   	pop    %ebx
 22a:	5e                   	pop    %esi
 22b:	5d                   	pop    %ebp
 22c:	c3                   	ret    
 22d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 230:	be ff ff ff ff       	mov    $0xffffffff,%esi
 235:	eb ed                	jmp    224 <stat+0x34>
 237:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 23e:	66 90                	xchg   %ax,%ax

00000240 <atoi>:

#ifdef PDX_XV6
int
atoi(const char *s)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	56                   	push   %esi
 244:	8b 55 08             	mov    0x8(%ebp),%edx
 247:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 248:	0f b6 0a             	movzbl (%edx),%ecx
 24b:	80 f9 20             	cmp    $0x20,%cl
 24e:	75 0b                	jne    25b <atoi+0x1b>
 250:	83 c2 01             	add    $0x1,%edx
 253:	0f b6 0a             	movzbl (%edx),%ecx
 256:	80 f9 20             	cmp    $0x20,%cl
 259:	74 f5                	je     250 <atoi+0x10>
  sign = (*s == '-') ? -1 : 1;
 25b:	80 f9 2d             	cmp    $0x2d,%cl
 25e:	74 40                	je     2a0 <atoi+0x60>
 260:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 265:	80 f9 2b             	cmp    $0x2b,%cl
 268:	74 3b                	je     2a5 <atoi+0x65>
    s++;
  while('0' <= *s && *s <= '9')
 26a:	0f be 0a             	movsbl (%edx),%ecx
 26d:	8d 41 d0             	lea    -0x30(%ecx),%eax
 270:	3c 09                	cmp    $0x9,%al
 272:	b8 00 00 00 00       	mov    $0x0,%eax
 277:	77 1f                	ja     298 <atoi+0x58>
 279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 280:	83 c2 01             	add    $0x1,%edx
 283:	8d 04 80             	lea    (%eax,%eax,4),%eax
 286:	8d 44 41 d0          	lea    -0x30(%ecx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 28a:	0f be 0a             	movsbl (%edx),%ecx
 28d:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 290:	80 fb 09             	cmp    $0x9,%bl
 293:	76 eb                	jbe    280 <atoi+0x40>
 295:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 298:	5b                   	pop    %ebx
 299:	5e                   	pop    %esi
 29a:	5d                   	pop    %ebp
 29b:	c3                   	ret    
 29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 2a0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 2a5:	83 c2 01             	add    $0x1,%edx
 2a8:	eb c0                	jmp    26a <atoi+0x2a>
 2aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002b0 <atoo>:

int
atoo(const char *s)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	56                   	push   %esi
 2b4:	8b 55 08             	mov    0x8(%ebp),%edx
 2b7:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 2b8:	0f b6 0a             	movzbl (%edx),%ecx
 2bb:	80 f9 20             	cmp    $0x20,%cl
 2be:	75 0b                	jne    2cb <atoo+0x1b>
 2c0:	83 c2 01             	add    $0x1,%edx
 2c3:	0f b6 0a             	movzbl (%edx),%ecx
 2c6:	80 f9 20             	cmp    $0x20,%cl
 2c9:	74 f5                	je     2c0 <atoo+0x10>
  sign = (*s == '-') ? -1 : 1;
 2cb:	80 f9 2d             	cmp    $0x2d,%cl
 2ce:	74 40                	je     310 <atoo+0x60>
 2d0:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 2d5:	80 f9 2b             	cmp    $0x2b,%cl
 2d8:	74 3b                	je     315 <atoo+0x65>
    s++;
  while('0' <= *s && *s <= '7')
 2da:	0f be 0a             	movsbl (%edx),%ecx
 2dd:	8d 41 d0             	lea    -0x30(%ecx),%eax
 2e0:	3c 07                	cmp    $0x7,%al
 2e2:	b8 00 00 00 00       	mov    $0x0,%eax
 2e7:	77 1c                	ja     305 <atoo+0x55>
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*8 + *s++ - '0';
 2f0:	83 c2 01             	add    $0x1,%edx
 2f3:	8d 44 c1 d0          	lea    -0x30(%ecx,%eax,8),%eax
  while('0' <= *s && *s <= '7')
 2f7:	0f be 0a             	movsbl (%edx),%ecx
 2fa:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 2fd:	80 fb 07             	cmp    $0x7,%bl
 300:	76 ee                	jbe    2f0 <atoo+0x40>
 302:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 305:	5b                   	pop    %ebx
 306:	5e                   	pop    %esi
 307:	5d                   	pop    %ebp
 308:	c3                   	ret    
 309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 310:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 315:	83 c2 01             	add    $0x1,%edx
 318:	eb c0                	jmp    2da <atoo+0x2a>
 31a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000320 <memmove>:
}
#endif // PDX_XV6

void*
memmove(void *vdst, void *vsrc, int n)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	57                   	push   %edi
 324:	8b 55 10             	mov    0x10(%ebp),%edx
 327:	8b 45 08             	mov    0x8(%ebp),%eax
 32a:	56                   	push   %esi
 32b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 32e:	85 d2                	test   %edx,%edx
 330:	7e 13                	jle    345 <memmove+0x25>
 332:	01 c2                	add    %eax,%edx
  dst = vdst;
 334:	89 c7                	mov    %eax,%edi
 336:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 33d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 340:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 341:	39 fa                	cmp    %edi,%edx
 343:	75 fb                	jne    340 <memmove+0x20>
  return vdst;
}
 345:	5e                   	pop    %esi
 346:	5f                   	pop    %edi
 347:	5d                   	pop    %ebp
 348:	c3                   	ret    

00000349 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 349:	b8 01 00 00 00       	mov    $0x1,%eax
 34e:	cd 40                	int    $0x40
 350:	c3                   	ret    

00000351 <exit>:
SYSCALL(exit)
 351:	b8 02 00 00 00       	mov    $0x2,%eax
 356:	cd 40                	int    $0x40
 358:	c3                   	ret    

00000359 <wait>:
SYSCALL(wait)
 359:	b8 03 00 00 00       	mov    $0x3,%eax
 35e:	cd 40                	int    $0x40
 360:	c3                   	ret    

00000361 <pipe>:
SYSCALL(pipe)
 361:	b8 04 00 00 00       	mov    $0x4,%eax
 366:	cd 40                	int    $0x40
 368:	c3                   	ret    

00000369 <read>:
SYSCALL(read)
 369:	b8 05 00 00 00       	mov    $0x5,%eax
 36e:	cd 40                	int    $0x40
 370:	c3                   	ret    

00000371 <write>:
SYSCALL(write)
 371:	b8 10 00 00 00       	mov    $0x10,%eax
 376:	cd 40                	int    $0x40
 378:	c3                   	ret    

00000379 <close>:
SYSCALL(close)
 379:	b8 15 00 00 00       	mov    $0x15,%eax
 37e:	cd 40                	int    $0x40
 380:	c3                   	ret    

00000381 <kill>:
SYSCALL(kill)
 381:	b8 06 00 00 00       	mov    $0x6,%eax
 386:	cd 40                	int    $0x40
 388:	c3                   	ret    

00000389 <exec>:
SYSCALL(exec)
 389:	b8 07 00 00 00       	mov    $0x7,%eax
 38e:	cd 40                	int    $0x40
 390:	c3                   	ret    

00000391 <open>:
SYSCALL(open)
 391:	b8 0f 00 00 00       	mov    $0xf,%eax
 396:	cd 40                	int    $0x40
 398:	c3                   	ret    

00000399 <mknod>:
SYSCALL(mknod)
 399:	b8 11 00 00 00       	mov    $0x11,%eax
 39e:	cd 40                	int    $0x40
 3a0:	c3                   	ret    

000003a1 <unlink>:
SYSCALL(unlink)
 3a1:	b8 12 00 00 00       	mov    $0x12,%eax
 3a6:	cd 40                	int    $0x40
 3a8:	c3                   	ret    

000003a9 <fstat>:
SYSCALL(fstat)
 3a9:	b8 08 00 00 00       	mov    $0x8,%eax
 3ae:	cd 40                	int    $0x40
 3b0:	c3                   	ret    

000003b1 <link>:
SYSCALL(link)
 3b1:	b8 13 00 00 00       	mov    $0x13,%eax
 3b6:	cd 40                	int    $0x40
 3b8:	c3                   	ret    

000003b9 <mkdir>:
SYSCALL(mkdir)
 3b9:	b8 14 00 00 00       	mov    $0x14,%eax
 3be:	cd 40                	int    $0x40
 3c0:	c3                   	ret    

000003c1 <chdir>:
SYSCALL(chdir)
 3c1:	b8 09 00 00 00       	mov    $0x9,%eax
 3c6:	cd 40                	int    $0x40
 3c8:	c3                   	ret    

000003c9 <dup>:
SYSCALL(dup)
 3c9:	b8 0a 00 00 00       	mov    $0xa,%eax
 3ce:	cd 40                	int    $0x40
 3d0:	c3                   	ret    

000003d1 <getpid>:
SYSCALL(getpid)
 3d1:	b8 0b 00 00 00       	mov    $0xb,%eax
 3d6:	cd 40                	int    $0x40
 3d8:	c3                   	ret    

000003d9 <sbrk>:
SYSCALL(sbrk)
 3d9:	b8 0c 00 00 00       	mov    $0xc,%eax
 3de:	cd 40                	int    $0x40
 3e0:	c3                   	ret    

000003e1 <sleep>:
SYSCALL(sleep)
 3e1:	b8 0d 00 00 00       	mov    $0xd,%eax
 3e6:	cd 40                	int    $0x40
 3e8:	c3                   	ret    

000003e9 <uptime>:
SYSCALL(uptime)
 3e9:	b8 0e 00 00 00       	mov    $0xe,%eax
 3ee:	cd 40                	int    $0x40
 3f0:	c3                   	ret    

000003f1 <halt>:
SYSCALL(halt)
 3f1:	b8 16 00 00 00       	mov    $0x16,%eax
 3f6:	cd 40                	int    $0x40
 3f8:	c3                   	ret    

000003f9 <date>:
SYSCALL(date)
 3f9:	b8 17 00 00 00       	mov    $0x17,%eax
 3fe:	cd 40                	int    $0x40
 400:	c3                   	ret    

00000401 <getgid>:
SYSCALL(getgid)
 401:	b8 18 00 00 00       	mov    $0x18,%eax
 406:	cd 40                	int    $0x40
 408:	c3                   	ret    

00000409 <setgid>:
SYSCALL(setgid)
 409:	b8 19 00 00 00       	mov    $0x19,%eax
 40e:	cd 40                	int    $0x40
 410:	c3                   	ret    

00000411 <getuid>:
SYSCALL(getuid)
 411:	b8 1a 00 00 00       	mov    $0x1a,%eax
 416:	cd 40                	int    $0x40
 418:	c3                   	ret    

00000419 <setuid>:
SYSCALL(setuid)
 419:	b8 1b 00 00 00       	mov    $0x1b,%eax
 41e:	cd 40                	int    $0x40
 420:	c3                   	ret    

00000421 <getppid>:
SYSCALL(getppid)
 421:	b8 1c 00 00 00       	mov    $0x1c,%eax
 426:	cd 40                	int    $0x40
 428:	c3                   	ret    

00000429 <getprocs>:
SYSCALL(getprocs)
 429:	b8 1d 00 00 00       	mov    $0x1d,%eax
 42e:	cd 40                	int    $0x40
 430:	c3                   	ret    

00000431 <setpriority>:
SYSCALL(setpriority)
 431:	b8 1e 00 00 00       	mov    $0x1e,%eax
 436:	cd 40                	int    $0x40
 438:	c3                   	ret    

00000439 <getpriority>:
SYSCALL(getpriority)
 439:	b8 1f 00 00 00       	mov    $0x1f,%eax
 43e:	cd 40                	int    $0x40
 440:	c3                   	ret    

00000441 <chmod>:
SYSCALL(chmod)
 441:	b8 20 00 00 00       	mov    $0x20,%eax
 446:	cd 40                	int    $0x40
 448:	c3                   	ret    

00000449 <chown>:
SYSCALL(chown)
 449:	b8 21 00 00 00       	mov    $0x21,%eax
 44e:	cd 40                	int    $0x40
 450:	c3                   	ret    

00000451 <chgrp>:
SYSCALL(chgrp)
 451:	b8 22 00 00 00       	mov    $0x22,%eax
 456:	cd 40                	int    $0x40
 458:	c3                   	ret    
 459:	66 90                	xchg   %ax,%ax
 45b:	66 90                	xchg   %ax,%ax
 45d:	66 90                	xchg   %ax,%ax
 45f:	90                   	nop

00000460 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	56                   	push   %esi
 465:	53                   	push   %ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 466:	89 d3                	mov    %edx,%ebx
{
 468:	83 ec 3c             	sub    $0x3c,%esp
 46b:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 46e:	85 d2                	test   %edx,%edx
 470:	0f 89 92 00 00 00    	jns    508 <printint+0xa8>
 476:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 47a:	0f 84 88 00 00 00    	je     508 <printint+0xa8>
    neg = 1;
 480:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 487:	f7 db                	neg    %ebx
  } else {
    x = xx;
  }

  i = 0;
 489:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 490:	8d 75 d7             	lea    -0x29(%ebp),%esi
 493:	eb 08                	jmp    49d <printint+0x3d>
 495:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 498:	89 7d c4             	mov    %edi,-0x3c(%ebp)
  }while((x /= base) != 0);
 49b:	89 c3                	mov    %eax,%ebx
    buf[i++] = digits[x % base];
 49d:	89 d8                	mov    %ebx,%eax
 49f:	31 d2                	xor    %edx,%edx
 4a1:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 4a4:	f7 f1                	div    %ecx
 4a6:	83 c7 01             	add    $0x1,%edi
 4a9:	0f b6 92 a4 08 00 00 	movzbl 0x8a4(%edx),%edx
 4b0:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 4b3:	39 d9                	cmp    %ebx,%ecx
 4b5:	76 e1                	jbe    498 <printint+0x38>
  if(neg)
 4b7:	8b 45 c0             	mov    -0x40(%ebp),%eax
 4ba:	85 c0                	test   %eax,%eax
 4bc:	74 0d                	je     4cb <printint+0x6b>
    buf[i++] = '-';
 4be:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 4c3:	ba 2d 00 00 00       	mov    $0x2d,%edx
    buf[i++] = digits[x % base];
 4c8:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 4cb:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4ce:	8b 7d bc             	mov    -0x44(%ebp),%edi
 4d1:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 4d5:	eb 0f                	jmp    4e6 <printint+0x86>
 4d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4de:	66 90                	xchg   %ax,%ax
 4e0:	0f b6 13             	movzbl (%ebx),%edx
 4e3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 4e6:	83 ec 04             	sub    $0x4,%esp
 4e9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 4ec:	6a 01                	push   $0x1
 4ee:	56                   	push   %esi
 4ef:	57                   	push   %edi
 4f0:	e8 7c fe ff ff       	call   371 <write>

  while(--i >= 0)
 4f5:	83 c4 10             	add    $0x10,%esp
 4f8:	39 de                	cmp    %ebx,%esi
 4fa:	75 e4                	jne    4e0 <printint+0x80>
    putc(fd, buf[i]);
}
 4fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4ff:	5b                   	pop    %ebx
 500:	5e                   	pop    %esi
 501:	5f                   	pop    %edi
 502:	5d                   	pop    %ebp
 503:	c3                   	ret    
 504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 508:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 50f:	e9 75 ff ff ff       	jmp    489 <printint+0x29>
 514:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 51b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 51f:	90                   	nop

00000520 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
 524:	56                   	push   %esi
 525:	53                   	push   %ebx
 526:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 529:	8b 75 0c             	mov    0xc(%ebp),%esi
 52c:	0f b6 1e             	movzbl (%esi),%ebx
 52f:	84 db                	test   %bl,%bl
 531:	0f 84 b9 00 00 00    	je     5f0 <printf+0xd0>
  ap = (uint*)(void*)&fmt + 1;
 537:	8d 45 10             	lea    0x10(%ebp),%eax
 53a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 53d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 540:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 542:	89 45 d0             	mov    %eax,-0x30(%ebp)
 545:	eb 38                	jmp    57f <printf+0x5f>
 547:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 54e:	66 90                	xchg   %ax,%ax
 550:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 553:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 558:	83 f8 25             	cmp    $0x25,%eax
 55b:	74 17                	je     574 <printf+0x54>
  write(fd, &c, 1);
 55d:	83 ec 04             	sub    $0x4,%esp
 560:	88 5d e7             	mov    %bl,-0x19(%ebp)
 563:	6a 01                	push   $0x1
 565:	57                   	push   %edi
 566:	ff 75 08             	pushl  0x8(%ebp)
 569:	e8 03 fe ff ff       	call   371 <write>
 56e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 571:	83 c4 10             	add    $0x10,%esp
 574:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 577:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 57b:	84 db                	test   %bl,%bl
 57d:	74 71                	je     5f0 <printf+0xd0>
    c = fmt[i] & 0xff;
 57f:	0f be cb             	movsbl %bl,%ecx
 582:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 585:	85 d2                	test   %edx,%edx
 587:	74 c7                	je     550 <printf+0x30>
      }
    } else if(state == '%'){
 589:	83 fa 25             	cmp    $0x25,%edx
 58c:	75 e6                	jne    574 <printf+0x54>
      if(c == 'd'){
 58e:	83 f8 64             	cmp    $0x64,%eax
 591:	0f 84 99 00 00 00    	je     630 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 597:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 59d:	83 f9 70             	cmp    $0x70,%ecx
 5a0:	74 5e                	je     600 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5a2:	83 f8 73             	cmp    $0x73,%eax
 5a5:	0f 84 d5 00 00 00    	je     680 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ab:	83 f8 63             	cmp    $0x63,%eax
 5ae:	0f 84 8c 00 00 00    	je     640 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5b4:	83 f8 25             	cmp    $0x25,%eax
 5b7:	0f 84 b3 00 00 00    	je     670 <printf+0x150>
  write(fd, &c, 1);
 5bd:	83 ec 04             	sub    $0x4,%esp
 5c0:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5c4:	6a 01                	push   $0x1
 5c6:	57                   	push   %edi
 5c7:	ff 75 08             	pushl  0x8(%ebp)
 5ca:	e8 a2 fd ff ff       	call   371 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5cf:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 5d2:	83 c4 0c             	add    $0xc,%esp
 5d5:	6a 01                	push   $0x1
 5d7:	83 c6 01             	add    $0x1,%esi
 5da:	57                   	push   %edi
 5db:	ff 75 08             	pushl  0x8(%ebp)
 5de:	e8 8e fd ff ff       	call   371 <write>
  for(i = 0; fmt[i]; i++){
 5e3:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 5e7:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5ea:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 5ec:	84 db                	test   %bl,%bl
 5ee:	75 8f                	jne    57f <printf+0x5f>
    }
  }
}
 5f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5f3:	5b                   	pop    %ebx
 5f4:	5e                   	pop    %esi
 5f5:	5f                   	pop    %edi
 5f6:	5d                   	pop    %ebp
 5f7:	c3                   	ret    
 5f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ff:	90                   	nop
        printint(fd, *ap, 16, 0);
 600:	83 ec 0c             	sub    $0xc,%esp
 603:	b9 10 00 00 00       	mov    $0x10,%ecx
 608:	6a 00                	push   $0x0
 60a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 60d:	8b 45 08             	mov    0x8(%ebp),%eax
 610:	8b 13                	mov    (%ebx),%edx
 612:	e8 49 fe ff ff       	call   460 <printint>
        ap++;
 617:	89 d8                	mov    %ebx,%eax
 619:	83 c4 10             	add    $0x10,%esp
      state = 0;
 61c:	31 d2                	xor    %edx,%edx
        ap++;
 61e:	83 c0 04             	add    $0x4,%eax
 621:	89 45 d0             	mov    %eax,-0x30(%ebp)
 624:	e9 4b ff ff ff       	jmp    574 <printf+0x54>
 629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 630:	83 ec 0c             	sub    $0xc,%esp
 633:	b9 0a 00 00 00       	mov    $0xa,%ecx
 638:	6a 01                	push   $0x1
 63a:	eb ce                	jmp    60a <printf+0xea>
 63c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 640:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 643:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 646:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 648:	6a 01                	push   $0x1
        ap++;
 64a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 64d:	57                   	push   %edi
 64e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 651:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 654:	e8 18 fd ff ff       	call   371 <write>
        ap++;
 659:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 65c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 65f:	31 d2                	xor    %edx,%edx
 661:	e9 0e ff ff ff       	jmp    574 <printf+0x54>
 666:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 66d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 670:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 673:	83 ec 04             	sub    $0x4,%esp
 676:	e9 5a ff ff ff       	jmp    5d5 <printf+0xb5>
 67b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 67f:	90                   	nop
        s = (char*)*ap;
 680:	8b 45 d0             	mov    -0x30(%ebp),%eax
 683:	8b 18                	mov    (%eax),%ebx
        ap++;
 685:	83 c0 04             	add    $0x4,%eax
 688:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 68b:	85 db                	test   %ebx,%ebx
 68d:	74 17                	je     6a6 <printf+0x186>
        while(*s != 0){
 68f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 692:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 694:	84 c0                	test   %al,%al
 696:	0f 84 d8 fe ff ff    	je     574 <printf+0x54>
 69c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 69f:	89 de                	mov    %ebx,%esi
 6a1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6a4:	eb 1a                	jmp    6c0 <printf+0x1a0>
          s = "(null)";
 6a6:	bb 9c 08 00 00       	mov    $0x89c,%ebx
        while(*s != 0){
 6ab:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6ae:	b8 28 00 00 00       	mov    $0x28,%eax
 6b3:	89 de                	mov    %ebx,%esi
 6b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6bf:	90                   	nop
  write(fd, &c, 1);
 6c0:	83 ec 04             	sub    $0x4,%esp
          s++;
 6c3:	83 c6 01             	add    $0x1,%esi
 6c6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6c9:	6a 01                	push   $0x1
 6cb:	57                   	push   %edi
 6cc:	53                   	push   %ebx
 6cd:	e8 9f fc ff ff       	call   371 <write>
        while(*s != 0){
 6d2:	0f b6 06             	movzbl (%esi),%eax
 6d5:	83 c4 10             	add    $0x10,%esp
 6d8:	84 c0                	test   %al,%al
 6da:	75 e4                	jne    6c0 <printf+0x1a0>
 6dc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 6df:	31 d2                	xor    %edx,%edx
 6e1:	e9 8e fe ff ff       	jmp    574 <printf+0x54>
 6e6:	66 90                	xchg   %ax,%ax
 6e8:	66 90                	xchg   %ax,%ax
 6ea:	66 90                	xchg   %ax,%ax
 6ec:	66 90                	xchg   %ax,%ax
 6ee:	66 90                	xchg   %ax,%ax

000006f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f1:	a1 88 0b 00 00       	mov    0xb88,%eax
{
 6f6:	89 e5                	mov    %esp,%ebp
 6f8:	57                   	push   %edi
 6f9:	56                   	push   %esi
 6fa:	53                   	push   %ebx
 6fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6fe:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 700:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 703:	39 c8                	cmp    %ecx,%eax
 705:	73 19                	jae    720 <free+0x30>
 707:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 70e:	66 90                	xchg   %ax,%ax
 710:	39 d1                	cmp    %edx,%ecx
 712:	72 14                	jb     728 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 714:	39 d0                	cmp    %edx,%eax
 716:	73 10                	jae    728 <free+0x38>
{
 718:	89 d0                	mov    %edx,%eax
 71a:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 71c:	39 c8                	cmp    %ecx,%eax
 71e:	72 f0                	jb     710 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 720:	39 d0                	cmp    %edx,%eax
 722:	72 f4                	jb     718 <free+0x28>
 724:	39 d1                	cmp    %edx,%ecx
 726:	73 f0                	jae    718 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 728:	8b 73 fc             	mov    -0x4(%ebx),%esi
 72b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 72e:	39 fa                	cmp    %edi,%edx
 730:	74 1e                	je     750 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 732:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 735:	8b 50 04             	mov    0x4(%eax),%edx
 738:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 73b:	39 f1                	cmp    %esi,%ecx
 73d:	74 28                	je     767 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 73f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 741:	5b                   	pop    %ebx
  freep = p;
 742:	a3 88 0b 00 00       	mov    %eax,0xb88
}
 747:	5e                   	pop    %esi
 748:	5f                   	pop    %edi
 749:	5d                   	pop    %ebp
 74a:	c3                   	ret    
 74b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 74f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 750:	03 72 04             	add    0x4(%edx),%esi
 753:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 756:	8b 10                	mov    (%eax),%edx
 758:	8b 12                	mov    (%edx),%edx
 75a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 75d:	8b 50 04             	mov    0x4(%eax),%edx
 760:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 763:	39 f1                	cmp    %esi,%ecx
 765:	75 d8                	jne    73f <free+0x4f>
    p->s.size += bp->s.size;
 767:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 76a:	a3 88 0b 00 00       	mov    %eax,0xb88
    p->s.size += bp->s.size;
 76f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 772:	8b 53 f8             	mov    -0x8(%ebx),%edx
 775:	89 10                	mov    %edx,(%eax)
}
 777:	5b                   	pop    %ebx
 778:	5e                   	pop    %esi
 779:	5f                   	pop    %edi
 77a:	5d                   	pop    %ebp
 77b:	c3                   	ret    
 77c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000780 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	57                   	push   %edi
 784:	56                   	push   %esi
 785:	53                   	push   %ebx
 786:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 789:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 78c:	8b 3d 88 0b 00 00    	mov    0xb88,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 792:	8d 70 07             	lea    0x7(%eax),%esi
 795:	c1 ee 03             	shr    $0x3,%esi
 798:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 79b:	85 ff                	test   %edi,%edi
 79d:	0f 84 ad 00 00 00    	je     850 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 7a5:	8b 4a 04             	mov    0x4(%edx),%ecx
 7a8:	39 f1                	cmp    %esi,%ecx
 7aa:	73 72                	jae    81e <malloc+0x9e>
 7ac:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 7b2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7b7:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 7ba:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 7c1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 7c4:	eb 1b                	jmp    7e1 <malloc+0x61>
 7c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7cd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7d2:	8b 48 04             	mov    0x4(%eax),%ecx
 7d5:	39 f1                	cmp    %esi,%ecx
 7d7:	73 4f                	jae    828 <malloc+0xa8>
 7d9:	8b 3d 88 0b 00 00    	mov    0xb88,%edi
 7df:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7e1:	39 d7                	cmp    %edx,%edi
 7e3:	75 eb                	jne    7d0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 7e5:	83 ec 0c             	sub    $0xc,%esp
 7e8:	ff 75 e4             	pushl  -0x1c(%ebp)
 7eb:	e8 e9 fb ff ff       	call   3d9 <sbrk>
  if(p == (char*)-1)
 7f0:	83 c4 10             	add    $0x10,%esp
 7f3:	83 f8 ff             	cmp    $0xffffffff,%eax
 7f6:	74 1c                	je     814 <malloc+0x94>
  hp->s.size = nu;
 7f8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7fb:	83 ec 0c             	sub    $0xc,%esp
 7fe:	83 c0 08             	add    $0x8,%eax
 801:	50                   	push   %eax
 802:	e8 e9 fe ff ff       	call   6f0 <free>
  return freep;
 807:	8b 15 88 0b 00 00    	mov    0xb88,%edx
      if((p = morecore(nunits)) == 0)
 80d:	83 c4 10             	add    $0x10,%esp
 810:	85 d2                	test   %edx,%edx
 812:	75 bc                	jne    7d0 <malloc+0x50>
        return 0;
  }
}
 814:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 817:	31 c0                	xor    %eax,%eax
}
 819:	5b                   	pop    %ebx
 81a:	5e                   	pop    %esi
 81b:	5f                   	pop    %edi
 81c:	5d                   	pop    %ebp
 81d:	c3                   	ret    
    if(p->s.size >= nunits){
 81e:	89 d0                	mov    %edx,%eax
 820:	89 fa                	mov    %edi,%edx
 822:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 828:	39 ce                	cmp    %ecx,%esi
 82a:	74 54                	je     880 <malloc+0x100>
        p->s.size -= nunits;
 82c:	29 f1                	sub    %esi,%ecx
 82e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 831:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 834:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 837:	89 15 88 0b 00 00    	mov    %edx,0xb88
}
 83d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 840:	83 c0 08             	add    $0x8,%eax
}
 843:	5b                   	pop    %ebx
 844:	5e                   	pop    %esi
 845:	5f                   	pop    %edi
 846:	5d                   	pop    %ebp
 847:	c3                   	ret    
 848:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 84f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 850:	c7 05 88 0b 00 00 8c 	movl   $0xb8c,0xb88
 857:	0b 00 00 
    base.s.size = 0;
 85a:	bf 8c 0b 00 00       	mov    $0xb8c,%edi
    base.s.ptr = freep = prevp = &base;
 85f:	c7 05 8c 0b 00 00 8c 	movl   $0xb8c,0xb8c
 866:	0b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 869:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 86b:	c7 05 90 0b 00 00 00 	movl   $0x0,0xb90
 872:	00 00 00 
    if(p->s.size >= nunits){
 875:	e9 32 ff ff ff       	jmp    7ac <malloc+0x2c>
 87a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 880:	8b 08                	mov    (%eax),%ecx
 882:	89 0a                	mov    %ecx,(%edx)
 884:	eb b1                	jmp    837 <malloc+0xb7>
