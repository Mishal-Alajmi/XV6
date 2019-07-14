
_mkdir:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	bf 01 00 00 00       	mov    $0x1,%edi
  13:	56                   	push   %esi
  14:	53                   	push   %ebx
  15:	51                   	push   %ecx
  16:	83 ec 08             	sub    $0x8,%esp
  19:	8b 59 04             	mov    0x4(%ecx),%ebx
  1c:	8b 31                	mov    (%ecx),%esi
  1e:	83 c3 04             	add    $0x4,%ebx
  int i;

  if(argc < 2){
  21:	83 fe 01             	cmp    $0x1,%esi
  24:	7e 3e                	jle    64 <main+0x64>
  26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  2d:	8d 76 00             	lea    0x0(%esi),%esi
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
  30:	83 ec 0c             	sub    $0xc,%esp
  33:	ff 33                	pushl  (%ebx)
  35:	e8 9f 03 00 00       	call   3d9 <mkdir>
  3a:	83 c4 10             	add    $0x10,%esp
  3d:	85 c0                	test   %eax,%eax
  3f:	78 0f                	js     50 <main+0x50>
  for(i = 1; i < argc; i++){
  41:	83 c7 01             	add    $0x1,%edi
  44:	83 c3 04             	add    $0x4,%ebx
  47:	39 fe                	cmp    %edi,%esi
  49:	75 e5                	jne    30 <main+0x30>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit();
  4b:	e8 21 03 00 00       	call   371 <exit>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  50:	50                   	push   %eax
  51:	ff 33                	pushl  (%ebx)
  53:	68 bf 08 00 00       	push   $0x8bf
  58:	6a 02                	push   $0x2
  5a:	e8 e1 04 00 00       	call   540 <printf>
      break;
  5f:	83 c4 10             	add    $0x10,%esp
  62:	eb e7                	jmp    4b <main+0x4b>
    printf(2, "Usage: mkdir files...\n");
  64:	52                   	push   %edx
  65:	52                   	push   %edx
  66:	68 a8 08 00 00       	push   $0x8a8
  6b:	6a 02                	push   $0x2
  6d:	e8 ce 04 00 00       	call   540 <printf>
    exit();
  72:	e8 fa 02 00 00       	call   371 <exit>
  77:	66 90                	xchg   %ax,%ax
  79:	66 90                	xchg   %ax,%ax
  7b:	66 90                	xchg   %ax,%ax
  7d:	66 90                	xchg   %ax,%ax
  7f:	90                   	nop

00000080 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  80:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  81:	31 d2                	xor    %edx,%edx
{
  83:	89 e5                	mov    %esp,%ebp
  85:	53                   	push   %ebx
  86:	8b 45 08             	mov    0x8(%ebp),%eax
  89:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  90:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
  94:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  97:	83 c2 01             	add    $0x1,%edx
  9a:	84 c9                	test   %cl,%cl
  9c:	75 f2                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  9e:	5b                   	pop    %ebx
  9f:	5d                   	pop    %ebp
  a0:	c3                   	ret    
  a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  af:	90                   	nop

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	56                   	push   %esi
  b4:	53                   	push   %ebx
  b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  b8:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(*p && *p == *q)
  bb:	0f b6 13             	movzbl (%ebx),%edx
  be:	0f b6 0e             	movzbl (%esi),%ecx
  c1:	84 d2                	test   %dl,%dl
  c3:	74 1e                	je     e3 <strcmp+0x33>
  c5:	b8 01 00 00 00       	mov    $0x1,%eax
  ca:	38 ca                	cmp    %cl,%dl
  cc:	74 09                	je     d7 <strcmp+0x27>
  ce:	eb 20                	jmp    f0 <strcmp+0x40>
  d0:	83 c0 01             	add    $0x1,%eax
  d3:	38 ca                	cmp    %cl,%dl
  d5:	75 19                	jne    f0 <strcmp+0x40>
  d7:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  db:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
  df:	84 d2                	test   %dl,%dl
  e1:	75 ed                	jne    d0 <strcmp+0x20>
  e3:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  e5:	5b                   	pop    %ebx
  e6:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
  e7:	29 c8                	sub    %ecx,%eax
}
  e9:	5d                   	pop    %ebp
  ea:	c3                   	ret    
  eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ef:	90                   	nop
  f0:	0f b6 c2             	movzbl %dl,%eax
  f3:	5b                   	pop    %ebx
  f4:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
  f5:	29 c8                	sub    %ecx,%eax
}
  f7:	5d                   	pop    %ebp
  f8:	c3                   	ret    
  f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000100 <strlen>:

uint
strlen(char *s)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 106:	80 39 00             	cmpb   $0x0,(%ecx)
 109:	74 15                	je     120 <strlen+0x20>
 10b:	31 d2                	xor    %edx,%edx
 10d:	8d 76 00             	lea    0x0(%esi),%esi
 110:	83 c2 01             	add    $0x1,%edx
 113:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 117:	89 d0                	mov    %edx,%eax
 119:	75 f5                	jne    110 <strlen+0x10>
    ;
  return n;
}
 11b:	5d                   	pop    %ebp
 11c:	c3                   	ret    
 11d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 120:	31 c0                	xor    %eax,%eax
}
 122:	5d                   	pop    %ebp
 123:	c3                   	ret    
 124:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 12b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 12f:	90                   	nop

00000130 <memset>:

void*
memset(void *dst, int c, uint n)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 137:	8b 4d 10             	mov    0x10(%ebp),%ecx
 13a:	8b 45 0c             	mov    0xc(%ebp),%eax
 13d:	89 d7                	mov    %edx,%edi
 13f:	fc                   	cld    
 140:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 142:	89 d0                	mov    %edx,%eax
 144:	5f                   	pop    %edi
 145:	5d                   	pop    %ebp
 146:	c3                   	ret    
 147:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 14e:	66 90                	xchg   %ax,%ax

00000150 <strchr>:

char*
strchr(const char *s, char c)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	8b 45 08             	mov    0x8(%ebp),%eax
 157:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 15a:	0f b6 18             	movzbl (%eax),%ebx
 15d:	84 db                	test   %bl,%bl
 15f:	74 1d                	je     17e <strchr+0x2e>
 161:	89 d1                	mov    %edx,%ecx
    if(*s == c)
 163:	38 d3                	cmp    %dl,%bl
 165:	75 0d                	jne    174 <strchr+0x24>
 167:	eb 17                	jmp    180 <strchr+0x30>
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 170:	38 ca                	cmp    %cl,%dl
 172:	74 0c                	je     180 <strchr+0x30>
  for(; *s; s++)
 174:	83 c0 01             	add    $0x1,%eax
 177:	0f b6 10             	movzbl (%eax),%edx
 17a:	84 d2                	test   %dl,%dl
 17c:	75 f2                	jne    170 <strchr+0x20>
      return (char*)s;
  return 0;
 17e:	31 c0                	xor    %eax,%eax
}
 180:	5b                   	pop    %ebx
 181:	5d                   	pop    %ebp
 182:	c3                   	ret    
 183:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000190 <gets>:

char*
gets(char *buf, int max)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 195:	31 f6                	xor    %esi,%esi
{
 197:	53                   	push   %ebx
 198:	89 f3                	mov    %esi,%ebx
 19a:	83 ec 1c             	sub    $0x1c,%esp
 19d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 1a0:	eb 2f                	jmp    1d1 <gets+0x41>
 1a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 1a8:	83 ec 04             	sub    $0x4,%esp
 1ab:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1ae:	6a 01                	push   $0x1
 1b0:	50                   	push   %eax
 1b1:	6a 00                	push   $0x0
 1b3:	e8 d1 01 00 00       	call   389 <read>
    if(cc < 1)
 1b8:	83 c4 10             	add    $0x10,%esp
 1bb:	85 c0                	test   %eax,%eax
 1bd:	7e 1c                	jle    1db <gets+0x4b>
      break;
    buf[i++] = c;
 1bf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1c3:	83 c7 01             	add    $0x1,%edi
 1c6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 1c9:	3c 0a                	cmp    $0xa,%al
 1cb:	74 23                	je     1f0 <gets+0x60>
 1cd:	3c 0d                	cmp    $0xd,%al
 1cf:	74 1f                	je     1f0 <gets+0x60>
  for(i=0; i+1 < max; ){
 1d1:	83 c3 01             	add    $0x1,%ebx
 1d4:	89 fe                	mov    %edi,%esi
 1d6:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1d9:	7c cd                	jl     1a8 <gets+0x18>
 1db:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1dd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 1e0:	c6 03 00             	movb   $0x0,(%ebx)
}
 1e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1e6:	5b                   	pop    %ebx
 1e7:	5e                   	pop    %esi
 1e8:	5f                   	pop    %edi
 1e9:	5d                   	pop    %ebp
 1ea:	c3                   	ret    
 1eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1ef:	90                   	nop
 1f0:	8b 75 08             	mov    0x8(%ebp),%esi
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	01 de                	add    %ebx,%esi
 1f8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 1fa:	c6 03 00             	movb   $0x0,(%ebx)
}
 1fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 200:	5b                   	pop    %ebx
 201:	5e                   	pop    %esi
 202:	5f                   	pop    %edi
 203:	5d                   	pop    %ebp
 204:	c3                   	ret    
 205:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000210 <stat>:

int
stat(char *n, struct stat *st)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	56                   	push   %esi
 214:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 215:	83 ec 08             	sub    $0x8,%esp
 218:	6a 00                	push   $0x0
 21a:	ff 75 08             	pushl  0x8(%ebp)
 21d:	e8 8f 01 00 00       	call   3b1 <open>
  if(fd < 0)
 222:	83 c4 10             	add    $0x10,%esp
 225:	85 c0                	test   %eax,%eax
 227:	78 27                	js     250 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 229:	83 ec 08             	sub    $0x8,%esp
 22c:	ff 75 0c             	pushl  0xc(%ebp)
 22f:	89 c3                	mov    %eax,%ebx
 231:	50                   	push   %eax
 232:	e8 92 01 00 00       	call   3c9 <fstat>
  close(fd);
 237:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 23a:	89 c6                	mov    %eax,%esi
  close(fd);
 23c:	e8 58 01 00 00       	call   399 <close>
  return r;
 241:	83 c4 10             	add    $0x10,%esp
}
 244:	8d 65 f8             	lea    -0x8(%ebp),%esp
 247:	89 f0                	mov    %esi,%eax
 249:	5b                   	pop    %ebx
 24a:	5e                   	pop    %esi
 24b:	5d                   	pop    %ebp
 24c:	c3                   	ret    
 24d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 250:	be ff ff ff ff       	mov    $0xffffffff,%esi
 255:	eb ed                	jmp    244 <stat+0x34>
 257:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 25e:	66 90                	xchg   %ax,%ax

00000260 <atoi>:

#ifdef PDX_XV6
int
atoi(const char *s)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	56                   	push   %esi
 264:	8b 55 08             	mov    0x8(%ebp),%edx
 267:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 268:	0f b6 0a             	movzbl (%edx),%ecx
 26b:	80 f9 20             	cmp    $0x20,%cl
 26e:	75 0b                	jne    27b <atoi+0x1b>
 270:	83 c2 01             	add    $0x1,%edx
 273:	0f b6 0a             	movzbl (%edx),%ecx
 276:	80 f9 20             	cmp    $0x20,%cl
 279:	74 f5                	je     270 <atoi+0x10>
  sign = (*s == '-') ? -1 : 1;
 27b:	80 f9 2d             	cmp    $0x2d,%cl
 27e:	74 40                	je     2c0 <atoi+0x60>
 280:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 285:	80 f9 2b             	cmp    $0x2b,%cl
 288:	74 3b                	je     2c5 <atoi+0x65>
    s++;
  while('0' <= *s && *s <= '9')
 28a:	0f be 0a             	movsbl (%edx),%ecx
 28d:	8d 41 d0             	lea    -0x30(%ecx),%eax
 290:	3c 09                	cmp    $0x9,%al
 292:	b8 00 00 00 00       	mov    $0x0,%eax
 297:	77 1f                	ja     2b8 <atoi+0x58>
 299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 2a0:	83 c2 01             	add    $0x1,%edx
 2a3:	8d 04 80             	lea    (%eax,%eax,4),%eax
 2a6:	8d 44 41 d0          	lea    -0x30(%ecx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 2aa:	0f be 0a             	movsbl (%edx),%ecx
 2ad:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 2b0:	80 fb 09             	cmp    $0x9,%bl
 2b3:	76 eb                	jbe    2a0 <atoi+0x40>
 2b5:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 2b8:	5b                   	pop    %ebx
 2b9:	5e                   	pop    %esi
 2ba:	5d                   	pop    %ebp
 2bb:	c3                   	ret    
 2bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 2c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 2c5:	83 c2 01             	add    $0x1,%edx
 2c8:	eb c0                	jmp    28a <atoi+0x2a>
 2ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002d0 <atoo>:

int
atoo(const char *s)
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
 2de:	75 0b                	jne    2eb <atoo+0x1b>
 2e0:	83 c2 01             	add    $0x1,%edx
 2e3:	0f b6 0a             	movzbl (%edx),%ecx
 2e6:	80 f9 20             	cmp    $0x20,%cl
 2e9:	74 f5                	je     2e0 <atoo+0x10>
  sign = (*s == '-') ? -1 : 1;
 2eb:	80 f9 2d             	cmp    $0x2d,%cl
 2ee:	74 40                	je     330 <atoo+0x60>
 2f0:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 2f5:	80 f9 2b             	cmp    $0x2b,%cl
 2f8:	74 3b                	je     335 <atoo+0x65>
    s++;
  while('0' <= *s && *s <= '7')
 2fa:	0f be 0a             	movsbl (%edx),%ecx
 2fd:	8d 41 d0             	lea    -0x30(%ecx),%eax
 300:	3c 07                	cmp    $0x7,%al
 302:	b8 00 00 00 00       	mov    $0x0,%eax
 307:	77 1c                	ja     325 <atoo+0x55>
 309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*8 + *s++ - '0';
 310:	83 c2 01             	add    $0x1,%edx
 313:	8d 44 c1 d0          	lea    -0x30(%ecx,%eax,8),%eax
  while('0' <= *s && *s <= '7')
 317:	0f be 0a             	movsbl (%edx),%ecx
 31a:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 31d:	80 fb 07             	cmp    $0x7,%bl
 320:	76 ee                	jbe    310 <atoo+0x40>
 322:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 325:	5b                   	pop    %ebx
 326:	5e                   	pop    %esi
 327:	5d                   	pop    %ebp
 328:	c3                   	ret    
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 330:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 335:	83 c2 01             	add    $0x1,%edx
 338:	eb c0                	jmp    2fa <atoo+0x2a>
 33a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000340 <memmove>:
}
#endif // PDX_XV6

void*
memmove(void *vdst, void *vsrc, int n)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	8b 55 10             	mov    0x10(%ebp),%edx
 347:	8b 45 08             	mov    0x8(%ebp),%eax
 34a:	56                   	push   %esi
 34b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 34e:	85 d2                	test   %edx,%edx
 350:	7e 13                	jle    365 <memmove+0x25>
 352:	01 c2                	add    %eax,%edx
  dst = vdst;
 354:	89 c7                	mov    %eax,%edi
 356:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 35d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 360:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 361:	39 fa                	cmp    %edi,%edx
 363:	75 fb                	jne    360 <memmove+0x20>
  return vdst;
}
 365:	5e                   	pop    %esi
 366:	5f                   	pop    %edi
 367:	5d                   	pop    %ebp
 368:	c3                   	ret    

00000369 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 369:	b8 01 00 00 00       	mov    $0x1,%eax
 36e:	cd 40                	int    $0x40
 370:	c3                   	ret    

00000371 <exit>:
SYSCALL(exit)
 371:	b8 02 00 00 00       	mov    $0x2,%eax
 376:	cd 40                	int    $0x40
 378:	c3                   	ret    

00000379 <wait>:
SYSCALL(wait)
 379:	b8 03 00 00 00       	mov    $0x3,%eax
 37e:	cd 40                	int    $0x40
 380:	c3                   	ret    

00000381 <pipe>:
SYSCALL(pipe)
 381:	b8 04 00 00 00       	mov    $0x4,%eax
 386:	cd 40                	int    $0x40
 388:	c3                   	ret    

00000389 <read>:
SYSCALL(read)
 389:	b8 05 00 00 00       	mov    $0x5,%eax
 38e:	cd 40                	int    $0x40
 390:	c3                   	ret    

00000391 <write>:
SYSCALL(write)
 391:	b8 10 00 00 00       	mov    $0x10,%eax
 396:	cd 40                	int    $0x40
 398:	c3                   	ret    

00000399 <close>:
SYSCALL(close)
 399:	b8 15 00 00 00       	mov    $0x15,%eax
 39e:	cd 40                	int    $0x40
 3a0:	c3                   	ret    

000003a1 <kill>:
SYSCALL(kill)
 3a1:	b8 06 00 00 00       	mov    $0x6,%eax
 3a6:	cd 40                	int    $0x40
 3a8:	c3                   	ret    

000003a9 <exec>:
SYSCALL(exec)
 3a9:	b8 07 00 00 00       	mov    $0x7,%eax
 3ae:	cd 40                	int    $0x40
 3b0:	c3                   	ret    

000003b1 <open>:
SYSCALL(open)
 3b1:	b8 0f 00 00 00       	mov    $0xf,%eax
 3b6:	cd 40                	int    $0x40
 3b8:	c3                   	ret    

000003b9 <mknod>:
SYSCALL(mknod)
 3b9:	b8 11 00 00 00       	mov    $0x11,%eax
 3be:	cd 40                	int    $0x40
 3c0:	c3                   	ret    

000003c1 <unlink>:
SYSCALL(unlink)
 3c1:	b8 12 00 00 00       	mov    $0x12,%eax
 3c6:	cd 40                	int    $0x40
 3c8:	c3                   	ret    

000003c9 <fstat>:
SYSCALL(fstat)
 3c9:	b8 08 00 00 00       	mov    $0x8,%eax
 3ce:	cd 40                	int    $0x40
 3d0:	c3                   	ret    

000003d1 <link>:
SYSCALL(link)
 3d1:	b8 13 00 00 00       	mov    $0x13,%eax
 3d6:	cd 40                	int    $0x40
 3d8:	c3                   	ret    

000003d9 <mkdir>:
SYSCALL(mkdir)
 3d9:	b8 14 00 00 00       	mov    $0x14,%eax
 3de:	cd 40                	int    $0x40
 3e0:	c3                   	ret    

000003e1 <chdir>:
SYSCALL(chdir)
 3e1:	b8 09 00 00 00       	mov    $0x9,%eax
 3e6:	cd 40                	int    $0x40
 3e8:	c3                   	ret    

000003e9 <dup>:
SYSCALL(dup)
 3e9:	b8 0a 00 00 00       	mov    $0xa,%eax
 3ee:	cd 40                	int    $0x40
 3f0:	c3                   	ret    

000003f1 <getpid>:
SYSCALL(getpid)
 3f1:	b8 0b 00 00 00       	mov    $0xb,%eax
 3f6:	cd 40                	int    $0x40
 3f8:	c3                   	ret    

000003f9 <sbrk>:
SYSCALL(sbrk)
 3f9:	b8 0c 00 00 00       	mov    $0xc,%eax
 3fe:	cd 40                	int    $0x40
 400:	c3                   	ret    

00000401 <sleep>:
SYSCALL(sleep)
 401:	b8 0d 00 00 00       	mov    $0xd,%eax
 406:	cd 40                	int    $0x40
 408:	c3                   	ret    

00000409 <uptime>:
SYSCALL(uptime)
 409:	b8 0e 00 00 00       	mov    $0xe,%eax
 40e:	cd 40                	int    $0x40
 410:	c3                   	ret    

00000411 <halt>:
SYSCALL(halt)
 411:	b8 16 00 00 00       	mov    $0x16,%eax
 416:	cd 40                	int    $0x40
 418:	c3                   	ret    

00000419 <date>:
SYSCALL(date)
 419:	b8 17 00 00 00       	mov    $0x17,%eax
 41e:	cd 40                	int    $0x40
 420:	c3                   	ret    

00000421 <getgid>:
SYSCALL(getgid)
 421:	b8 18 00 00 00       	mov    $0x18,%eax
 426:	cd 40                	int    $0x40
 428:	c3                   	ret    

00000429 <setgid>:
SYSCALL(setgid)
 429:	b8 19 00 00 00       	mov    $0x19,%eax
 42e:	cd 40                	int    $0x40
 430:	c3                   	ret    

00000431 <getuid>:
SYSCALL(getuid)
 431:	b8 1a 00 00 00       	mov    $0x1a,%eax
 436:	cd 40                	int    $0x40
 438:	c3                   	ret    

00000439 <setuid>:
SYSCALL(setuid)
 439:	b8 1b 00 00 00       	mov    $0x1b,%eax
 43e:	cd 40                	int    $0x40
 440:	c3                   	ret    

00000441 <getppid>:
SYSCALL(getppid)
 441:	b8 1c 00 00 00       	mov    $0x1c,%eax
 446:	cd 40                	int    $0x40
 448:	c3                   	ret    

00000449 <getprocs>:
SYSCALL(getprocs)
 449:	b8 1d 00 00 00       	mov    $0x1d,%eax
 44e:	cd 40                	int    $0x40
 450:	c3                   	ret    

00000451 <setpriority>:
SYSCALL(setpriority)
 451:	b8 1e 00 00 00       	mov    $0x1e,%eax
 456:	cd 40                	int    $0x40
 458:	c3                   	ret    

00000459 <getpriority>:
SYSCALL(getpriority)
 459:	b8 1f 00 00 00       	mov    $0x1f,%eax
 45e:	cd 40                	int    $0x40
 460:	c3                   	ret    

00000461 <chmod>:
SYSCALL(chmod)
 461:	b8 20 00 00 00       	mov    $0x20,%eax
 466:	cd 40                	int    $0x40
 468:	c3                   	ret    

00000469 <chown>:
SYSCALL(chown)
 469:	b8 21 00 00 00       	mov    $0x21,%eax
 46e:	cd 40                	int    $0x40
 470:	c3                   	ret    

00000471 <chgrp>:
SYSCALL(chgrp)
 471:	b8 22 00 00 00       	mov    $0x22,%eax
 476:	cd 40                	int    $0x40
 478:	c3                   	ret    
 479:	66 90                	xchg   %ax,%ax
 47b:	66 90                	xchg   %ax,%ax
 47d:	66 90                	xchg   %ax,%ax
 47f:	90                   	nop

00000480 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	53                   	push   %ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 486:	89 d3                	mov    %edx,%ebx
{
 488:	83 ec 3c             	sub    $0x3c,%esp
 48b:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 48e:	85 d2                	test   %edx,%edx
 490:	0f 89 92 00 00 00    	jns    528 <printint+0xa8>
 496:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 49a:	0f 84 88 00 00 00    	je     528 <printint+0xa8>
    neg = 1;
 4a0:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 4a7:	f7 db                	neg    %ebx
  } else {
    x = xx;
  }

  i = 0;
 4a9:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 4b0:	8d 75 d7             	lea    -0x29(%ebp),%esi
 4b3:	eb 08                	jmp    4bd <printint+0x3d>
 4b5:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4b8:	89 7d c4             	mov    %edi,-0x3c(%ebp)
  }while((x /= base) != 0);
 4bb:	89 c3                	mov    %eax,%ebx
    buf[i++] = digits[x % base];
 4bd:	89 d8                	mov    %ebx,%eax
 4bf:	31 d2                	xor    %edx,%edx
 4c1:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 4c4:	f7 f1                	div    %ecx
 4c6:	83 c7 01             	add    $0x1,%edi
 4c9:	0f b6 92 e4 08 00 00 	movzbl 0x8e4(%edx),%edx
 4d0:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 4d3:	39 d9                	cmp    %ebx,%ecx
 4d5:	76 e1                	jbe    4b8 <printint+0x38>
  if(neg)
 4d7:	8b 45 c0             	mov    -0x40(%ebp),%eax
 4da:	85 c0                	test   %eax,%eax
 4dc:	74 0d                	je     4eb <printint+0x6b>
    buf[i++] = '-';
 4de:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 4e3:	ba 2d 00 00 00       	mov    $0x2d,%edx
    buf[i++] = digits[x % base];
 4e8:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 4eb:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4ee:	8b 7d bc             	mov    -0x44(%ebp),%edi
 4f1:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 4f5:	eb 0f                	jmp    506 <printint+0x86>
 4f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4fe:	66 90                	xchg   %ax,%ax
 500:	0f b6 13             	movzbl (%ebx),%edx
 503:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 506:	83 ec 04             	sub    $0x4,%esp
 509:	88 55 d7             	mov    %dl,-0x29(%ebp)
 50c:	6a 01                	push   $0x1
 50e:	56                   	push   %esi
 50f:	57                   	push   %edi
 510:	e8 7c fe ff ff       	call   391 <write>

  while(--i >= 0)
 515:	83 c4 10             	add    $0x10,%esp
 518:	39 de                	cmp    %ebx,%esi
 51a:	75 e4                	jne    500 <printint+0x80>
    putc(fd, buf[i]);
}
 51c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 51f:	5b                   	pop    %ebx
 520:	5e                   	pop    %esi
 521:	5f                   	pop    %edi
 522:	5d                   	pop    %ebp
 523:	c3                   	ret    
 524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 528:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 52f:	e9 75 ff ff ff       	jmp    4a9 <printint+0x29>
 534:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 53b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 53f:	90                   	nop

00000540 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	57                   	push   %edi
 544:	56                   	push   %esi
 545:	53                   	push   %ebx
 546:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 549:	8b 75 0c             	mov    0xc(%ebp),%esi
 54c:	0f b6 1e             	movzbl (%esi),%ebx
 54f:	84 db                	test   %bl,%bl
 551:	0f 84 b9 00 00 00    	je     610 <printf+0xd0>
  ap = (uint*)(void*)&fmt + 1;
 557:	8d 45 10             	lea    0x10(%ebp),%eax
 55a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 55d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 560:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 562:	89 45 d0             	mov    %eax,-0x30(%ebp)
 565:	eb 38                	jmp    59f <printf+0x5f>
 567:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 56e:	66 90                	xchg   %ax,%ax
 570:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 573:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 578:	83 f8 25             	cmp    $0x25,%eax
 57b:	74 17                	je     594 <printf+0x54>
  write(fd, &c, 1);
 57d:	83 ec 04             	sub    $0x4,%esp
 580:	88 5d e7             	mov    %bl,-0x19(%ebp)
 583:	6a 01                	push   $0x1
 585:	57                   	push   %edi
 586:	ff 75 08             	pushl  0x8(%ebp)
 589:	e8 03 fe ff ff       	call   391 <write>
 58e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 591:	83 c4 10             	add    $0x10,%esp
 594:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 597:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 59b:	84 db                	test   %bl,%bl
 59d:	74 71                	je     610 <printf+0xd0>
    c = fmt[i] & 0xff;
 59f:	0f be cb             	movsbl %bl,%ecx
 5a2:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5a5:	85 d2                	test   %edx,%edx
 5a7:	74 c7                	je     570 <printf+0x30>
      }
    } else if(state == '%'){
 5a9:	83 fa 25             	cmp    $0x25,%edx
 5ac:	75 e6                	jne    594 <printf+0x54>
      if(c == 'd'){
 5ae:	83 f8 64             	cmp    $0x64,%eax
 5b1:	0f 84 99 00 00 00    	je     650 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5b7:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 5bd:	83 f9 70             	cmp    $0x70,%ecx
 5c0:	74 5e                	je     620 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5c2:	83 f8 73             	cmp    $0x73,%eax
 5c5:	0f 84 d5 00 00 00    	je     6a0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5cb:	83 f8 63             	cmp    $0x63,%eax
 5ce:	0f 84 8c 00 00 00    	je     660 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5d4:	83 f8 25             	cmp    $0x25,%eax
 5d7:	0f 84 b3 00 00 00    	je     690 <printf+0x150>
  write(fd, &c, 1);
 5dd:	83 ec 04             	sub    $0x4,%esp
 5e0:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5e4:	6a 01                	push   $0x1
 5e6:	57                   	push   %edi
 5e7:	ff 75 08             	pushl  0x8(%ebp)
 5ea:	e8 a2 fd ff ff       	call   391 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5ef:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 5f2:	83 c4 0c             	add    $0xc,%esp
 5f5:	6a 01                	push   $0x1
 5f7:	83 c6 01             	add    $0x1,%esi
 5fa:	57                   	push   %edi
 5fb:	ff 75 08             	pushl  0x8(%ebp)
 5fe:	e8 8e fd ff ff       	call   391 <write>
  for(i = 0; fmt[i]; i++){
 603:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 607:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 60a:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 60c:	84 db                	test   %bl,%bl
 60e:	75 8f                	jne    59f <printf+0x5f>
    }
  }
}
 610:	8d 65 f4             	lea    -0xc(%ebp),%esp
 613:	5b                   	pop    %ebx
 614:	5e                   	pop    %esi
 615:	5f                   	pop    %edi
 616:	5d                   	pop    %ebp
 617:	c3                   	ret    
 618:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 61f:	90                   	nop
        printint(fd, *ap, 16, 0);
 620:	83 ec 0c             	sub    $0xc,%esp
 623:	b9 10 00 00 00       	mov    $0x10,%ecx
 628:	6a 00                	push   $0x0
 62a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 62d:	8b 45 08             	mov    0x8(%ebp),%eax
 630:	8b 13                	mov    (%ebx),%edx
 632:	e8 49 fe ff ff       	call   480 <printint>
        ap++;
 637:	89 d8                	mov    %ebx,%eax
 639:	83 c4 10             	add    $0x10,%esp
      state = 0;
 63c:	31 d2                	xor    %edx,%edx
        ap++;
 63e:	83 c0 04             	add    $0x4,%eax
 641:	89 45 d0             	mov    %eax,-0x30(%ebp)
 644:	e9 4b ff ff ff       	jmp    594 <printf+0x54>
 649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 650:	83 ec 0c             	sub    $0xc,%esp
 653:	b9 0a 00 00 00       	mov    $0xa,%ecx
 658:	6a 01                	push   $0x1
 65a:	eb ce                	jmp    62a <printf+0xea>
 65c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 660:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 663:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 666:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 668:	6a 01                	push   $0x1
        ap++;
 66a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 66d:	57                   	push   %edi
 66e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 671:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 674:	e8 18 fd ff ff       	call   391 <write>
        ap++;
 679:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 67c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 67f:	31 d2                	xor    %edx,%edx
 681:	e9 0e ff ff ff       	jmp    594 <printf+0x54>
 686:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 68d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 690:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 693:	83 ec 04             	sub    $0x4,%esp
 696:	e9 5a ff ff ff       	jmp    5f5 <printf+0xb5>
 69b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 69f:	90                   	nop
        s = (char*)*ap;
 6a0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6a3:	8b 18                	mov    (%eax),%ebx
        ap++;
 6a5:	83 c0 04             	add    $0x4,%eax
 6a8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 6ab:	85 db                	test   %ebx,%ebx
 6ad:	74 17                	je     6c6 <printf+0x186>
        while(*s != 0){
 6af:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 6b2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 6b4:	84 c0                	test   %al,%al
 6b6:	0f 84 d8 fe ff ff    	je     594 <printf+0x54>
 6bc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6bf:	89 de                	mov    %ebx,%esi
 6c1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6c4:	eb 1a                	jmp    6e0 <printf+0x1a0>
          s = "(null)";
 6c6:	bb db 08 00 00       	mov    $0x8db,%ebx
        while(*s != 0){
 6cb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6ce:	b8 28 00 00 00       	mov    $0x28,%eax
 6d3:	89 de                	mov    %ebx,%esi
 6d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6df:	90                   	nop
  write(fd, &c, 1);
 6e0:	83 ec 04             	sub    $0x4,%esp
          s++;
 6e3:	83 c6 01             	add    $0x1,%esi
 6e6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6e9:	6a 01                	push   $0x1
 6eb:	57                   	push   %edi
 6ec:	53                   	push   %ebx
 6ed:	e8 9f fc ff ff       	call   391 <write>
        while(*s != 0){
 6f2:	0f b6 06             	movzbl (%esi),%eax
 6f5:	83 c4 10             	add    $0x10,%esp
 6f8:	84 c0                	test   %al,%al
 6fa:	75 e4                	jne    6e0 <printf+0x1a0>
 6fc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 6ff:	31 d2                	xor    %edx,%edx
 701:	e9 8e fe ff ff       	jmp    594 <printf+0x54>
 706:	66 90                	xchg   %ax,%ax
 708:	66 90                	xchg   %ax,%ax
 70a:	66 90                	xchg   %ax,%ax
 70c:	66 90                	xchg   %ax,%ax
 70e:	66 90                	xchg   %ax,%ax

00000710 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 710:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 711:	a1 d0 0b 00 00       	mov    0xbd0,%eax
{
 716:	89 e5                	mov    %esp,%ebp
 718:	57                   	push   %edi
 719:	56                   	push   %esi
 71a:	53                   	push   %ebx
 71b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 71e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 720:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 723:	39 c8                	cmp    %ecx,%eax
 725:	73 19                	jae    740 <free+0x30>
 727:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 72e:	66 90                	xchg   %ax,%ax
 730:	39 d1                	cmp    %edx,%ecx
 732:	72 14                	jb     748 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 734:	39 d0                	cmp    %edx,%eax
 736:	73 10                	jae    748 <free+0x38>
{
 738:	89 d0                	mov    %edx,%eax
 73a:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 73c:	39 c8                	cmp    %ecx,%eax
 73e:	72 f0                	jb     730 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 740:	39 d0                	cmp    %edx,%eax
 742:	72 f4                	jb     738 <free+0x28>
 744:	39 d1                	cmp    %edx,%ecx
 746:	73 f0                	jae    738 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 748:	8b 73 fc             	mov    -0x4(%ebx),%esi
 74b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 74e:	39 fa                	cmp    %edi,%edx
 750:	74 1e                	je     770 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 752:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 755:	8b 50 04             	mov    0x4(%eax),%edx
 758:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 75b:	39 f1                	cmp    %esi,%ecx
 75d:	74 28                	je     787 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 75f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 761:	5b                   	pop    %ebx
  freep = p;
 762:	a3 d0 0b 00 00       	mov    %eax,0xbd0
}
 767:	5e                   	pop    %esi
 768:	5f                   	pop    %edi
 769:	5d                   	pop    %ebp
 76a:	c3                   	ret    
 76b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 76f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 770:	03 72 04             	add    0x4(%edx),%esi
 773:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 776:	8b 10                	mov    (%eax),%edx
 778:	8b 12                	mov    (%edx),%edx
 77a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 77d:	8b 50 04             	mov    0x4(%eax),%edx
 780:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 783:	39 f1                	cmp    %esi,%ecx
 785:	75 d8                	jne    75f <free+0x4f>
    p->s.size += bp->s.size;
 787:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 78a:	a3 d0 0b 00 00       	mov    %eax,0xbd0
    p->s.size += bp->s.size;
 78f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 792:	8b 53 f8             	mov    -0x8(%ebx),%edx
 795:	89 10                	mov    %edx,(%eax)
}
 797:	5b                   	pop    %ebx
 798:	5e                   	pop    %esi
 799:	5f                   	pop    %edi
 79a:	5d                   	pop    %ebp
 79b:	c3                   	ret    
 79c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7a0:	55                   	push   %ebp
 7a1:	89 e5                	mov    %esp,%ebp
 7a3:	57                   	push   %edi
 7a4:	56                   	push   %esi
 7a5:	53                   	push   %ebx
 7a6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7ac:	8b 3d d0 0b 00 00    	mov    0xbd0,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7b2:	8d 70 07             	lea    0x7(%eax),%esi
 7b5:	c1 ee 03             	shr    $0x3,%esi
 7b8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 7bb:	85 ff                	test   %edi,%edi
 7bd:	0f 84 ad 00 00 00    	je     870 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 7c5:	8b 4a 04             	mov    0x4(%edx),%ecx
 7c8:	39 f1                	cmp    %esi,%ecx
 7ca:	73 72                	jae    83e <malloc+0x9e>
 7cc:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 7d2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7d7:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 7da:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 7e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 7e4:	eb 1b                	jmp    801 <malloc+0x61>
 7e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7ed:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7f2:	8b 48 04             	mov    0x4(%eax),%ecx
 7f5:	39 f1                	cmp    %esi,%ecx
 7f7:	73 4f                	jae    848 <malloc+0xa8>
 7f9:	8b 3d d0 0b 00 00    	mov    0xbd0,%edi
 7ff:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 801:	39 d7                	cmp    %edx,%edi
 803:	75 eb                	jne    7f0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 805:	83 ec 0c             	sub    $0xc,%esp
 808:	ff 75 e4             	pushl  -0x1c(%ebp)
 80b:	e8 e9 fb ff ff       	call   3f9 <sbrk>
  if(p == (char*)-1)
 810:	83 c4 10             	add    $0x10,%esp
 813:	83 f8 ff             	cmp    $0xffffffff,%eax
 816:	74 1c                	je     834 <malloc+0x94>
  hp->s.size = nu;
 818:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 81b:	83 ec 0c             	sub    $0xc,%esp
 81e:	83 c0 08             	add    $0x8,%eax
 821:	50                   	push   %eax
 822:	e8 e9 fe ff ff       	call   710 <free>
  return freep;
 827:	8b 15 d0 0b 00 00    	mov    0xbd0,%edx
      if((p = morecore(nunits)) == 0)
 82d:	83 c4 10             	add    $0x10,%esp
 830:	85 d2                	test   %edx,%edx
 832:	75 bc                	jne    7f0 <malloc+0x50>
        return 0;
  }
}
 834:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 837:	31 c0                	xor    %eax,%eax
}
 839:	5b                   	pop    %ebx
 83a:	5e                   	pop    %esi
 83b:	5f                   	pop    %edi
 83c:	5d                   	pop    %ebp
 83d:	c3                   	ret    
    if(p->s.size >= nunits){
 83e:	89 d0                	mov    %edx,%eax
 840:	89 fa                	mov    %edi,%edx
 842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 848:	39 ce                	cmp    %ecx,%esi
 84a:	74 54                	je     8a0 <malloc+0x100>
        p->s.size -= nunits;
 84c:	29 f1                	sub    %esi,%ecx
 84e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 851:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 854:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 857:	89 15 d0 0b 00 00    	mov    %edx,0xbd0
}
 85d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 860:	83 c0 08             	add    $0x8,%eax
}
 863:	5b                   	pop    %ebx
 864:	5e                   	pop    %esi
 865:	5f                   	pop    %edi
 866:	5d                   	pop    %ebp
 867:	c3                   	ret    
 868:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 86f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 870:	c7 05 d0 0b 00 00 d4 	movl   $0xbd4,0xbd0
 877:	0b 00 00 
    base.s.size = 0;
 87a:	bf d4 0b 00 00       	mov    $0xbd4,%edi
    base.s.ptr = freep = prevp = &base;
 87f:	c7 05 d4 0b 00 00 d4 	movl   $0xbd4,0xbd4
 886:	0b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 889:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 88b:	c7 05 d8 0b 00 00 00 	movl   $0x0,0xbd8
 892:	00 00 00 
    if(p->s.size >= nunits){
 895:	e9 32 ff ff ff       	jmp    7cc <malloc+0x2c>
 89a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 8a0:	8b 08                	mov    (%eax),%ecx
 8a2:	89 0a                	mov    %ecx,(%edx)
 8a4:	eb b1                	jmp    857 <malloc+0xb7>
