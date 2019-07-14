
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	be 01 00 00 00       	mov    $0x1,%esi
  14:	53                   	push   %ebx
  15:	51                   	push   %ecx
  16:	83 ec 18             	sub    $0x18,%esp
  19:	8b 01                	mov    (%ecx),%eax
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  21:	83 c3 04             	add    $0x4,%ebx
  int fd, i;

  if(argc <= 1){
  24:	83 f8 01             	cmp    $0x1,%eax
  27:	7e 54                	jle    7d <main+0x7d>
  29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	83 ec 08             	sub    $0x8,%esp
  33:	6a 00                	push   $0x0
  35:	ff 33                	pushl  (%ebx)
  37:	e8 05 04 00 00       	call   441 <open>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	89 c7                	mov    %eax,%edi
  41:	85 c0                	test   %eax,%eax
  43:	78 24                	js     69 <main+0x69>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  45:	83 ec 0c             	sub    $0xc,%esp
  for(i = 1; i < argc; i++){
  48:	83 c6 01             	add    $0x1,%esi
  4b:	83 c3 04             	add    $0x4,%ebx
    cat(fd);
  4e:	50                   	push   %eax
  4f:	e8 3c 00 00 00       	call   90 <cat>
    close(fd);
  54:	89 3c 24             	mov    %edi,(%esp)
  57:	e8 cd 03 00 00       	call   429 <close>
  for(i = 1; i < argc; i++){
  5c:	83 c4 10             	add    $0x10,%esp
  5f:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  62:	75 cc                	jne    30 <main+0x30>
  }
  exit();
  64:	e8 98 03 00 00       	call   401 <exit>
      printf(1, "cat: cannot open %s\n", argv[i]);
  69:	50                   	push   %eax
  6a:	ff 33                	pushl  (%ebx)
  6c:	68 5b 09 00 00       	push   $0x95b
  71:	6a 01                	push   $0x1
  73:	e8 58 05 00 00       	call   5d0 <printf>
      exit();
  78:	e8 84 03 00 00       	call   401 <exit>
    cat(0);
  7d:	83 ec 0c             	sub    $0xc,%esp
  80:	6a 00                	push   $0x0
  82:	e8 09 00 00 00       	call   90 <cat>
    exit();
  87:	e8 75 03 00 00       	call   401 <exit>
  8c:	66 90                	xchg   %ax,%ax
  8e:	66 90                	xchg   %ax,%ax

00000090 <cat>:
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	56                   	push   %esi
  94:	8b 75 08             	mov    0x8(%ebp),%esi
  97:	53                   	push   %ebx
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  98:	eb 1d                	jmp    b7 <cat+0x27>
  9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (write(1, buf, n) != n) {
  a0:	83 ec 04             	sub    $0x4,%esp
  a3:	53                   	push   %ebx
  a4:	68 c0 0c 00 00       	push   $0xcc0
  a9:	6a 01                	push   $0x1
  ab:	e8 71 03 00 00       	call   421 <write>
  b0:	83 c4 10             	add    $0x10,%esp
  b3:	39 d8                	cmp    %ebx,%eax
  b5:	75 25                	jne    dc <cat+0x4c>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  b7:	83 ec 04             	sub    $0x4,%esp
  ba:	68 00 02 00 00       	push   $0x200
  bf:	68 c0 0c 00 00       	push   $0xcc0
  c4:	56                   	push   %esi
  c5:	e8 4f 03 00 00       	call   419 <read>
  ca:	83 c4 10             	add    $0x10,%esp
  cd:	89 c3                	mov    %eax,%ebx
  cf:	85 c0                	test   %eax,%eax
  d1:	7f cd                	jg     a0 <cat+0x10>
  if(n < 0){
  d3:	75 1b                	jne    f0 <cat+0x60>
}
  d5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  d8:	5b                   	pop    %ebx
  d9:	5e                   	pop    %esi
  da:	5d                   	pop    %ebp
  db:	c3                   	ret    
      printf(1, "cat: write error\n");
  dc:	83 ec 08             	sub    $0x8,%esp
  df:	68 38 09 00 00       	push   $0x938
  e4:	6a 01                	push   $0x1
  e6:	e8 e5 04 00 00       	call   5d0 <printf>
      exit();
  eb:	e8 11 03 00 00       	call   401 <exit>
    printf(1, "cat: read error\n");
  f0:	50                   	push   %eax
  f1:	50                   	push   %eax
  f2:	68 4a 09 00 00       	push   $0x94a
  f7:	6a 01                	push   $0x1
  f9:	e8 d2 04 00 00       	call   5d0 <printf>
    exit();
  fe:	e8 fe 02 00 00       	call   401 <exit>
 103:	66 90                	xchg   %ax,%ax
 105:	66 90                	xchg   %ax,%ax
 107:	66 90                	xchg   %ax,%ax
 109:	66 90                	xchg   %ax,%ax
 10b:	66 90                	xchg   %ax,%ax
 10d:	66 90                	xchg   %ax,%ax
 10f:	90                   	nop

00000110 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 110:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 111:	31 d2                	xor    %edx,%edx
{
 113:	89 e5                	mov    %esp,%ebp
 115:	53                   	push   %ebx
 116:	8b 45 08             	mov    0x8(%ebp),%eax
 119:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 120:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 124:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 127:	83 c2 01             	add    $0x1,%edx
 12a:	84 c9                	test   %cl,%cl
 12c:	75 f2                	jne    120 <strcpy+0x10>
    ;
  return os;
}
 12e:	5b                   	pop    %ebx
 12f:	5d                   	pop    %ebp
 130:	c3                   	ret    
 131:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 138:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13f:	90                   	nop

00000140 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	56                   	push   %esi
 144:	53                   	push   %ebx
 145:	8b 5d 08             	mov    0x8(%ebp),%ebx
 148:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(*p && *p == *q)
 14b:	0f b6 13             	movzbl (%ebx),%edx
 14e:	0f b6 0e             	movzbl (%esi),%ecx
 151:	84 d2                	test   %dl,%dl
 153:	74 1e                	je     173 <strcmp+0x33>
 155:	b8 01 00 00 00       	mov    $0x1,%eax
 15a:	38 ca                	cmp    %cl,%dl
 15c:	74 09                	je     167 <strcmp+0x27>
 15e:	eb 20                	jmp    180 <strcmp+0x40>
 160:	83 c0 01             	add    $0x1,%eax
 163:	38 ca                	cmp    %cl,%dl
 165:	75 19                	jne    180 <strcmp+0x40>
 167:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 16b:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
 16f:	84 d2                	test   %dl,%dl
 171:	75 ed                	jne    160 <strcmp+0x20>
 173:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 175:	5b                   	pop    %ebx
 176:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
 177:	29 c8                	sub    %ecx,%eax
}
 179:	5d                   	pop    %ebp
 17a:	c3                   	ret    
 17b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 17f:	90                   	nop
 180:	0f b6 c2             	movzbl %dl,%eax
 183:	5b                   	pop    %ebx
 184:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
 185:	29 c8                	sub    %ecx,%eax
}
 187:	5d                   	pop    %ebp
 188:	c3                   	ret    
 189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000190 <strlen>:

uint
strlen(char *s)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 196:	80 39 00             	cmpb   $0x0,(%ecx)
 199:	74 15                	je     1b0 <strlen+0x20>
 19b:	31 d2                	xor    %edx,%edx
 19d:	8d 76 00             	lea    0x0(%esi),%esi
 1a0:	83 c2 01             	add    $0x1,%edx
 1a3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1a7:	89 d0                	mov    %edx,%eax
 1a9:	75 f5                	jne    1a0 <strlen+0x10>
    ;
  return n;
}
 1ab:	5d                   	pop    %ebp
 1ac:	c3                   	ret    
 1ad:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 1b0:	31 c0                	xor    %eax,%eax
}
 1b2:	5d                   	pop    %ebp
 1b3:	c3                   	ret    
 1b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1bf:	90                   	nop

000001c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	57                   	push   %edi
 1c4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 1cd:	89 d7                	mov    %edx,%edi
 1cf:	fc                   	cld    
 1d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1d2:	89 d0                	mov    %edx,%eax
 1d4:	5f                   	pop    %edi
 1d5:	5d                   	pop    %ebp
 1d6:	c3                   	ret    
 1d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1de:	66 90                	xchg   %ax,%ax

000001e0 <strchr>:

char*
strchr(const char *s, char c)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	53                   	push   %ebx
 1e4:	8b 45 08             	mov    0x8(%ebp),%eax
 1e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 1ea:	0f b6 18             	movzbl (%eax),%ebx
 1ed:	84 db                	test   %bl,%bl
 1ef:	74 1d                	je     20e <strchr+0x2e>
 1f1:	89 d1                	mov    %edx,%ecx
    if(*s == c)
 1f3:	38 d3                	cmp    %dl,%bl
 1f5:	75 0d                	jne    204 <strchr+0x24>
 1f7:	eb 17                	jmp    210 <strchr+0x30>
 1f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 200:	38 ca                	cmp    %cl,%dl
 202:	74 0c                	je     210 <strchr+0x30>
  for(; *s; s++)
 204:	83 c0 01             	add    $0x1,%eax
 207:	0f b6 10             	movzbl (%eax),%edx
 20a:	84 d2                	test   %dl,%dl
 20c:	75 f2                	jne    200 <strchr+0x20>
      return (char*)s;
  return 0;
 20e:	31 c0                	xor    %eax,%eax
}
 210:	5b                   	pop    %ebx
 211:	5d                   	pop    %ebp
 212:	c3                   	ret    
 213:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 21a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000220 <gets>:

char*
gets(char *buf, int max)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 225:	31 f6                	xor    %esi,%esi
{
 227:	53                   	push   %ebx
 228:	89 f3                	mov    %esi,%ebx
 22a:	83 ec 1c             	sub    $0x1c,%esp
 22d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 230:	eb 2f                	jmp    261 <gets+0x41>
 232:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 238:	83 ec 04             	sub    $0x4,%esp
 23b:	8d 45 e7             	lea    -0x19(%ebp),%eax
 23e:	6a 01                	push   $0x1
 240:	50                   	push   %eax
 241:	6a 00                	push   $0x0
 243:	e8 d1 01 00 00       	call   419 <read>
    if(cc < 1)
 248:	83 c4 10             	add    $0x10,%esp
 24b:	85 c0                	test   %eax,%eax
 24d:	7e 1c                	jle    26b <gets+0x4b>
      break;
    buf[i++] = c;
 24f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 253:	83 c7 01             	add    $0x1,%edi
 256:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 259:	3c 0a                	cmp    $0xa,%al
 25b:	74 23                	je     280 <gets+0x60>
 25d:	3c 0d                	cmp    $0xd,%al
 25f:	74 1f                	je     280 <gets+0x60>
  for(i=0; i+1 < max; ){
 261:	83 c3 01             	add    $0x1,%ebx
 264:	89 fe                	mov    %edi,%esi
 266:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 269:	7c cd                	jl     238 <gets+0x18>
 26b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 26d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 270:	c6 03 00             	movb   $0x0,(%ebx)
}
 273:	8d 65 f4             	lea    -0xc(%ebp),%esp
 276:	5b                   	pop    %ebx
 277:	5e                   	pop    %esi
 278:	5f                   	pop    %edi
 279:	5d                   	pop    %ebp
 27a:	c3                   	ret    
 27b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 27f:	90                   	nop
 280:	8b 75 08             	mov    0x8(%ebp),%esi
 283:	8b 45 08             	mov    0x8(%ebp),%eax
 286:	01 de                	add    %ebx,%esi
 288:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 28a:	c6 03 00             	movb   $0x0,(%ebx)
}
 28d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 290:	5b                   	pop    %ebx
 291:	5e                   	pop    %esi
 292:	5f                   	pop    %edi
 293:	5d                   	pop    %ebp
 294:	c3                   	ret    
 295:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002a0 <stat>:

int
stat(char *n, struct stat *st)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	56                   	push   %esi
 2a4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a5:	83 ec 08             	sub    $0x8,%esp
 2a8:	6a 00                	push   $0x0
 2aa:	ff 75 08             	pushl  0x8(%ebp)
 2ad:	e8 8f 01 00 00       	call   441 <open>
  if(fd < 0)
 2b2:	83 c4 10             	add    $0x10,%esp
 2b5:	85 c0                	test   %eax,%eax
 2b7:	78 27                	js     2e0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2b9:	83 ec 08             	sub    $0x8,%esp
 2bc:	ff 75 0c             	pushl  0xc(%ebp)
 2bf:	89 c3                	mov    %eax,%ebx
 2c1:	50                   	push   %eax
 2c2:	e8 92 01 00 00       	call   459 <fstat>
  close(fd);
 2c7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2ca:	89 c6                	mov    %eax,%esi
  close(fd);
 2cc:	e8 58 01 00 00       	call   429 <close>
  return r;
 2d1:	83 c4 10             	add    $0x10,%esp
}
 2d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2d7:	89 f0                	mov    %esi,%eax
 2d9:	5b                   	pop    %ebx
 2da:	5e                   	pop    %esi
 2db:	5d                   	pop    %ebp
 2dc:	c3                   	ret    
 2dd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2e5:	eb ed                	jmp    2d4 <stat+0x34>
 2e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ee:	66 90                	xchg   %ax,%ax

000002f0 <atoi>:

#ifdef PDX_XV6
int
atoi(const char *s)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	56                   	push   %esi
 2f4:	8b 55 08             	mov    0x8(%ebp),%edx
 2f7:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 2f8:	0f b6 0a             	movzbl (%edx),%ecx
 2fb:	80 f9 20             	cmp    $0x20,%cl
 2fe:	75 0b                	jne    30b <atoi+0x1b>
 300:	83 c2 01             	add    $0x1,%edx
 303:	0f b6 0a             	movzbl (%edx),%ecx
 306:	80 f9 20             	cmp    $0x20,%cl
 309:	74 f5                	je     300 <atoi+0x10>
  sign = (*s == '-') ? -1 : 1;
 30b:	80 f9 2d             	cmp    $0x2d,%cl
 30e:	74 40                	je     350 <atoi+0x60>
 310:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 315:	80 f9 2b             	cmp    $0x2b,%cl
 318:	74 3b                	je     355 <atoi+0x65>
    s++;
  while('0' <= *s && *s <= '9')
 31a:	0f be 0a             	movsbl (%edx),%ecx
 31d:	8d 41 d0             	lea    -0x30(%ecx),%eax
 320:	3c 09                	cmp    $0x9,%al
 322:	b8 00 00 00 00       	mov    $0x0,%eax
 327:	77 1f                	ja     348 <atoi+0x58>
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 330:	83 c2 01             	add    $0x1,%edx
 333:	8d 04 80             	lea    (%eax,%eax,4),%eax
 336:	8d 44 41 d0          	lea    -0x30(%ecx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 33a:	0f be 0a             	movsbl (%edx),%ecx
 33d:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 340:	80 fb 09             	cmp    $0x9,%bl
 343:	76 eb                	jbe    330 <atoi+0x40>
 345:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 348:	5b                   	pop    %ebx
 349:	5e                   	pop    %esi
 34a:	5d                   	pop    %ebp
 34b:	c3                   	ret    
 34c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 350:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 355:	83 c2 01             	add    $0x1,%edx
 358:	eb c0                	jmp    31a <atoi+0x2a>
 35a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000360 <atoo>:

int
atoo(const char *s)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	56                   	push   %esi
 364:	8b 55 08             	mov    0x8(%ebp),%edx
 367:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 368:	0f b6 0a             	movzbl (%edx),%ecx
 36b:	80 f9 20             	cmp    $0x20,%cl
 36e:	75 0b                	jne    37b <atoo+0x1b>
 370:	83 c2 01             	add    $0x1,%edx
 373:	0f b6 0a             	movzbl (%edx),%ecx
 376:	80 f9 20             	cmp    $0x20,%cl
 379:	74 f5                	je     370 <atoo+0x10>
  sign = (*s == '-') ? -1 : 1;
 37b:	80 f9 2d             	cmp    $0x2d,%cl
 37e:	74 40                	je     3c0 <atoo+0x60>
 380:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 385:	80 f9 2b             	cmp    $0x2b,%cl
 388:	74 3b                	je     3c5 <atoo+0x65>
    s++;
  while('0' <= *s && *s <= '7')
 38a:	0f be 0a             	movsbl (%edx),%ecx
 38d:	8d 41 d0             	lea    -0x30(%ecx),%eax
 390:	3c 07                	cmp    $0x7,%al
 392:	b8 00 00 00 00       	mov    $0x0,%eax
 397:	77 1c                	ja     3b5 <atoo+0x55>
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*8 + *s++ - '0';
 3a0:	83 c2 01             	add    $0x1,%edx
 3a3:	8d 44 c1 d0          	lea    -0x30(%ecx,%eax,8),%eax
  while('0' <= *s && *s <= '7')
 3a7:	0f be 0a             	movsbl (%edx),%ecx
 3aa:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 3ad:	80 fb 07             	cmp    $0x7,%bl
 3b0:	76 ee                	jbe    3a0 <atoo+0x40>
 3b2:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 3b5:	5b                   	pop    %ebx
 3b6:	5e                   	pop    %esi
 3b7:	5d                   	pop    %ebp
 3b8:	c3                   	ret    
 3b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 3c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 3c5:	83 c2 01             	add    $0x1,%edx
 3c8:	eb c0                	jmp    38a <atoo+0x2a>
 3ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003d0 <memmove>:
}
#endif // PDX_XV6

void*
memmove(void *vdst, void *vsrc, int n)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	8b 55 10             	mov    0x10(%ebp),%edx
 3d7:	8b 45 08             	mov    0x8(%ebp),%eax
 3da:	56                   	push   %esi
 3db:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3de:	85 d2                	test   %edx,%edx
 3e0:	7e 13                	jle    3f5 <memmove+0x25>
 3e2:	01 c2                	add    %eax,%edx
  dst = vdst;
 3e4:	89 c7                	mov    %eax,%edi
 3e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3ed:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 3f0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3f1:	39 fa                	cmp    %edi,%edx
 3f3:	75 fb                	jne    3f0 <memmove+0x20>
  return vdst;
}
 3f5:	5e                   	pop    %esi
 3f6:	5f                   	pop    %edi
 3f7:	5d                   	pop    %ebp
 3f8:	c3                   	ret    

000003f9 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3f9:	b8 01 00 00 00       	mov    $0x1,%eax
 3fe:	cd 40                	int    $0x40
 400:	c3                   	ret    

00000401 <exit>:
SYSCALL(exit)
 401:	b8 02 00 00 00       	mov    $0x2,%eax
 406:	cd 40                	int    $0x40
 408:	c3                   	ret    

00000409 <wait>:
SYSCALL(wait)
 409:	b8 03 00 00 00       	mov    $0x3,%eax
 40e:	cd 40                	int    $0x40
 410:	c3                   	ret    

00000411 <pipe>:
SYSCALL(pipe)
 411:	b8 04 00 00 00       	mov    $0x4,%eax
 416:	cd 40                	int    $0x40
 418:	c3                   	ret    

00000419 <read>:
SYSCALL(read)
 419:	b8 05 00 00 00       	mov    $0x5,%eax
 41e:	cd 40                	int    $0x40
 420:	c3                   	ret    

00000421 <write>:
SYSCALL(write)
 421:	b8 10 00 00 00       	mov    $0x10,%eax
 426:	cd 40                	int    $0x40
 428:	c3                   	ret    

00000429 <close>:
SYSCALL(close)
 429:	b8 15 00 00 00       	mov    $0x15,%eax
 42e:	cd 40                	int    $0x40
 430:	c3                   	ret    

00000431 <kill>:
SYSCALL(kill)
 431:	b8 06 00 00 00       	mov    $0x6,%eax
 436:	cd 40                	int    $0x40
 438:	c3                   	ret    

00000439 <exec>:
SYSCALL(exec)
 439:	b8 07 00 00 00       	mov    $0x7,%eax
 43e:	cd 40                	int    $0x40
 440:	c3                   	ret    

00000441 <open>:
SYSCALL(open)
 441:	b8 0f 00 00 00       	mov    $0xf,%eax
 446:	cd 40                	int    $0x40
 448:	c3                   	ret    

00000449 <mknod>:
SYSCALL(mknod)
 449:	b8 11 00 00 00       	mov    $0x11,%eax
 44e:	cd 40                	int    $0x40
 450:	c3                   	ret    

00000451 <unlink>:
SYSCALL(unlink)
 451:	b8 12 00 00 00       	mov    $0x12,%eax
 456:	cd 40                	int    $0x40
 458:	c3                   	ret    

00000459 <fstat>:
SYSCALL(fstat)
 459:	b8 08 00 00 00       	mov    $0x8,%eax
 45e:	cd 40                	int    $0x40
 460:	c3                   	ret    

00000461 <link>:
SYSCALL(link)
 461:	b8 13 00 00 00       	mov    $0x13,%eax
 466:	cd 40                	int    $0x40
 468:	c3                   	ret    

00000469 <mkdir>:
SYSCALL(mkdir)
 469:	b8 14 00 00 00       	mov    $0x14,%eax
 46e:	cd 40                	int    $0x40
 470:	c3                   	ret    

00000471 <chdir>:
SYSCALL(chdir)
 471:	b8 09 00 00 00       	mov    $0x9,%eax
 476:	cd 40                	int    $0x40
 478:	c3                   	ret    

00000479 <dup>:
SYSCALL(dup)
 479:	b8 0a 00 00 00       	mov    $0xa,%eax
 47e:	cd 40                	int    $0x40
 480:	c3                   	ret    

00000481 <getpid>:
SYSCALL(getpid)
 481:	b8 0b 00 00 00       	mov    $0xb,%eax
 486:	cd 40                	int    $0x40
 488:	c3                   	ret    

00000489 <sbrk>:
SYSCALL(sbrk)
 489:	b8 0c 00 00 00       	mov    $0xc,%eax
 48e:	cd 40                	int    $0x40
 490:	c3                   	ret    

00000491 <sleep>:
SYSCALL(sleep)
 491:	b8 0d 00 00 00       	mov    $0xd,%eax
 496:	cd 40                	int    $0x40
 498:	c3                   	ret    

00000499 <uptime>:
SYSCALL(uptime)
 499:	b8 0e 00 00 00       	mov    $0xe,%eax
 49e:	cd 40                	int    $0x40
 4a0:	c3                   	ret    

000004a1 <halt>:
SYSCALL(halt)
 4a1:	b8 16 00 00 00       	mov    $0x16,%eax
 4a6:	cd 40                	int    $0x40
 4a8:	c3                   	ret    

000004a9 <date>:
SYSCALL(date)
 4a9:	b8 17 00 00 00       	mov    $0x17,%eax
 4ae:	cd 40                	int    $0x40
 4b0:	c3                   	ret    

000004b1 <getgid>:
SYSCALL(getgid)
 4b1:	b8 18 00 00 00       	mov    $0x18,%eax
 4b6:	cd 40                	int    $0x40
 4b8:	c3                   	ret    

000004b9 <setgid>:
SYSCALL(setgid)
 4b9:	b8 19 00 00 00       	mov    $0x19,%eax
 4be:	cd 40                	int    $0x40
 4c0:	c3                   	ret    

000004c1 <getuid>:
SYSCALL(getuid)
 4c1:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4c6:	cd 40                	int    $0x40
 4c8:	c3                   	ret    

000004c9 <setuid>:
SYSCALL(setuid)
 4c9:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4ce:	cd 40                	int    $0x40
 4d0:	c3                   	ret    

000004d1 <getppid>:
SYSCALL(getppid)
 4d1:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4d6:	cd 40                	int    $0x40
 4d8:	c3                   	ret    

000004d9 <getprocs>:
SYSCALL(getprocs)
 4d9:	b8 1d 00 00 00       	mov    $0x1d,%eax
 4de:	cd 40                	int    $0x40
 4e0:	c3                   	ret    

000004e1 <setpriority>:
SYSCALL(setpriority)
 4e1:	b8 1e 00 00 00       	mov    $0x1e,%eax
 4e6:	cd 40                	int    $0x40
 4e8:	c3                   	ret    

000004e9 <getpriority>:
SYSCALL(getpriority)
 4e9:	b8 1f 00 00 00       	mov    $0x1f,%eax
 4ee:	cd 40                	int    $0x40
 4f0:	c3                   	ret    

000004f1 <chmod>:
SYSCALL(chmod)
 4f1:	b8 20 00 00 00       	mov    $0x20,%eax
 4f6:	cd 40                	int    $0x40
 4f8:	c3                   	ret    

000004f9 <chown>:
SYSCALL(chown)
 4f9:	b8 21 00 00 00       	mov    $0x21,%eax
 4fe:	cd 40                	int    $0x40
 500:	c3                   	ret    

00000501 <chgrp>:
SYSCALL(chgrp)
 501:	b8 22 00 00 00       	mov    $0x22,%eax
 506:	cd 40                	int    $0x40
 508:	c3                   	ret    
 509:	66 90                	xchg   %ax,%ax
 50b:	66 90                	xchg   %ax,%ax
 50d:	66 90                	xchg   %ax,%ax
 50f:	90                   	nop

00000510 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	57                   	push   %edi
 514:	56                   	push   %esi
 515:	53                   	push   %ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 516:	89 d3                	mov    %edx,%ebx
{
 518:	83 ec 3c             	sub    $0x3c,%esp
 51b:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 51e:	85 d2                	test   %edx,%edx
 520:	0f 89 92 00 00 00    	jns    5b8 <printint+0xa8>
 526:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 52a:	0f 84 88 00 00 00    	je     5b8 <printint+0xa8>
    neg = 1;
 530:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 537:	f7 db                	neg    %ebx
  } else {
    x = xx;
  }

  i = 0;
 539:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 540:	8d 75 d7             	lea    -0x29(%ebp),%esi
 543:	eb 08                	jmp    54d <printint+0x3d>
 545:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 548:	89 7d c4             	mov    %edi,-0x3c(%ebp)
  }while((x /= base) != 0);
 54b:	89 c3                	mov    %eax,%ebx
    buf[i++] = digits[x % base];
 54d:	89 d8                	mov    %ebx,%eax
 54f:	31 d2                	xor    %edx,%edx
 551:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 554:	f7 f1                	div    %ecx
 556:	83 c7 01             	add    $0x1,%edi
 559:	0f b6 92 78 09 00 00 	movzbl 0x978(%edx),%edx
 560:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 563:	39 d9                	cmp    %ebx,%ecx
 565:	76 e1                	jbe    548 <printint+0x38>
  if(neg)
 567:	8b 45 c0             	mov    -0x40(%ebp),%eax
 56a:	85 c0                	test   %eax,%eax
 56c:	74 0d                	je     57b <printint+0x6b>
    buf[i++] = '-';
 56e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 573:	ba 2d 00 00 00       	mov    $0x2d,%edx
    buf[i++] = digits[x % base];
 578:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 57b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 57e:	8b 7d bc             	mov    -0x44(%ebp),%edi
 581:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 585:	eb 0f                	jmp    596 <printint+0x86>
 587:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 58e:	66 90                	xchg   %ax,%ax
 590:	0f b6 13             	movzbl (%ebx),%edx
 593:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 596:	83 ec 04             	sub    $0x4,%esp
 599:	88 55 d7             	mov    %dl,-0x29(%ebp)
 59c:	6a 01                	push   $0x1
 59e:	56                   	push   %esi
 59f:	57                   	push   %edi
 5a0:	e8 7c fe ff ff       	call   421 <write>

  while(--i >= 0)
 5a5:	83 c4 10             	add    $0x10,%esp
 5a8:	39 de                	cmp    %ebx,%esi
 5aa:	75 e4                	jne    590 <printint+0x80>
    putc(fd, buf[i]);
}
 5ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5af:	5b                   	pop    %ebx
 5b0:	5e                   	pop    %esi
 5b1:	5f                   	pop    %edi
 5b2:	5d                   	pop    %ebp
 5b3:	c3                   	ret    
 5b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 5b8:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 5bf:	e9 75 ff ff ff       	jmp    539 <printint+0x29>
 5c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5cf:	90                   	nop

000005d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5d0:	55                   	push   %ebp
 5d1:	89 e5                	mov    %esp,%ebp
 5d3:	57                   	push   %edi
 5d4:	56                   	push   %esi
 5d5:	53                   	push   %ebx
 5d6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5d9:	8b 75 0c             	mov    0xc(%ebp),%esi
 5dc:	0f b6 1e             	movzbl (%esi),%ebx
 5df:	84 db                	test   %bl,%bl
 5e1:	0f 84 b9 00 00 00    	je     6a0 <printf+0xd0>
  ap = (uint*)(void*)&fmt + 1;
 5e7:	8d 45 10             	lea    0x10(%ebp),%eax
 5ea:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 5ed:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 5f0:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 5f2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5f5:	eb 38                	jmp    62f <printf+0x5f>
 5f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5fe:	66 90                	xchg   %ax,%ax
 600:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 603:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 608:	83 f8 25             	cmp    $0x25,%eax
 60b:	74 17                	je     624 <printf+0x54>
  write(fd, &c, 1);
 60d:	83 ec 04             	sub    $0x4,%esp
 610:	88 5d e7             	mov    %bl,-0x19(%ebp)
 613:	6a 01                	push   $0x1
 615:	57                   	push   %edi
 616:	ff 75 08             	pushl  0x8(%ebp)
 619:	e8 03 fe ff ff       	call   421 <write>
 61e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 621:	83 c4 10             	add    $0x10,%esp
 624:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 627:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 62b:	84 db                	test   %bl,%bl
 62d:	74 71                	je     6a0 <printf+0xd0>
    c = fmt[i] & 0xff;
 62f:	0f be cb             	movsbl %bl,%ecx
 632:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 635:	85 d2                	test   %edx,%edx
 637:	74 c7                	je     600 <printf+0x30>
      }
    } else if(state == '%'){
 639:	83 fa 25             	cmp    $0x25,%edx
 63c:	75 e6                	jne    624 <printf+0x54>
      if(c == 'd'){
 63e:	83 f8 64             	cmp    $0x64,%eax
 641:	0f 84 99 00 00 00    	je     6e0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 647:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 64d:	83 f9 70             	cmp    $0x70,%ecx
 650:	74 5e                	je     6b0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 652:	83 f8 73             	cmp    $0x73,%eax
 655:	0f 84 d5 00 00 00    	je     730 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 65b:	83 f8 63             	cmp    $0x63,%eax
 65e:	0f 84 8c 00 00 00    	je     6f0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 664:	83 f8 25             	cmp    $0x25,%eax
 667:	0f 84 b3 00 00 00    	je     720 <printf+0x150>
  write(fd, &c, 1);
 66d:	83 ec 04             	sub    $0x4,%esp
 670:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 674:	6a 01                	push   $0x1
 676:	57                   	push   %edi
 677:	ff 75 08             	pushl  0x8(%ebp)
 67a:	e8 a2 fd ff ff       	call   421 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 67f:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 682:	83 c4 0c             	add    $0xc,%esp
 685:	6a 01                	push   $0x1
 687:	83 c6 01             	add    $0x1,%esi
 68a:	57                   	push   %edi
 68b:	ff 75 08             	pushl  0x8(%ebp)
 68e:	e8 8e fd ff ff       	call   421 <write>
  for(i = 0; fmt[i]; i++){
 693:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 697:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 69a:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 69c:	84 db                	test   %bl,%bl
 69e:	75 8f                	jne    62f <printf+0x5f>
    }
  }
}
 6a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6a3:	5b                   	pop    %ebx
 6a4:	5e                   	pop    %esi
 6a5:	5f                   	pop    %edi
 6a6:	5d                   	pop    %ebp
 6a7:	c3                   	ret    
 6a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6af:	90                   	nop
        printint(fd, *ap, 16, 0);
 6b0:	83 ec 0c             	sub    $0xc,%esp
 6b3:	b9 10 00 00 00       	mov    $0x10,%ecx
 6b8:	6a 00                	push   $0x0
 6ba:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 6bd:	8b 45 08             	mov    0x8(%ebp),%eax
 6c0:	8b 13                	mov    (%ebx),%edx
 6c2:	e8 49 fe ff ff       	call   510 <printint>
        ap++;
 6c7:	89 d8                	mov    %ebx,%eax
 6c9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6cc:	31 d2                	xor    %edx,%edx
        ap++;
 6ce:	83 c0 04             	add    $0x4,%eax
 6d1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6d4:	e9 4b ff ff ff       	jmp    624 <printf+0x54>
 6d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 6e0:	83 ec 0c             	sub    $0xc,%esp
 6e3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6e8:	6a 01                	push   $0x1
 6ea:	eb ce                	jmp    6ba <printf+0xea>
 6ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 6f0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 6f3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 6f6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 6f8:	6a 01                	push   $0x1
        ap++;
 6fa:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 6fd:	57                   	push   %edi
 6fe:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 701:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 704:	e8 18 fd ff ff       	call   421 <write>
        ap++;
 709:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 70c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 70f:	31 d2                	xor    %edx,%edx
 711:	e9 0e ff ff ff       	jmp    624 <printf+0x54>
 716:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 71d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 720:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 723:	83 ec 04             	sub    $0x4,%esp
 726:	e9 5a ff ff ff       	jmp    685 <printf+0xb5>
 72b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 72f:	90                   	nop
        s = (char*)*ap;
 730:	8b 45 d0             	mov    -0x30(%ebp),%eax
 733:	8b 18                	mov    (%eax),%ebx
        ap++;
 735:	83 c0 04             	add    $0x4,%eax
 738:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 73b:	85 db                	test   %ebx,%ebx
 73d:	74 17                	je     756 <printf+0x186>
        while(*s != 0){
 73f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 742:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 744:	84 c0                	test   %al,%al
 746:	0f 84 d8 fe ff ff    	je     624 <printf+0x54>
 74c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 74f:	89 de                	mov    %ebx,%esi
 751:	8b 5d 08             	mov    0x8(%ebp),%ebx
 754:	eb 1a                	jmp    770 <printf+0x1a0>
          s = "(null)";
 756:	bb 70 09 00 00       	mov    $0x970,%ebx
        while(*s != 0){
 75b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 75e:	b8 28 00 00 00       	mov    $0x28,%eax
 763:	89 de                	mov    %ebx,%esi
 765:	8b 5d 08             	mov    0x8(%ebp),%ebx
 768:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 76f:	90                   	nop
  write(fd, &c, 1);
 770:	83 ec 04             	sub    $0x4,%esp
          s++;
 773:	83 c6 01             	add    $0x1,%esi
 776:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 779:	6a 01                	push   $0x1
 77b:	57                   	push   %edi
 77c:	53                   	push   %ebx
 77d:	e8 9f fc ff ff       	call   421 <write>
        while(*s != 0){
 782:	0f b6 06             	movzbl (%esi),%eax
 785:	83 c4 10             	add    $0x10,%esp
 788:	84 c0                	test   %al,%al
 78a:	75 e4                	jne    770 <printf+0x1a0>
 78c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 78f:	31 d2                	xor    %edx,%edx
 791:	e9 8e fe ff ff       	jmp    624 <printf+0x54>
 796:	66 90                	xchg   %ax,%ax
 798:	66 90                	xchg   %ax,%ax
 79a:	66 90                	xchg   %ax,%ax
 79c:	66 90                	xchg   %ax,%ax
 79e:	66 90                	xchg   %ax,%ax

000007a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a1:	a1 a0 0c 00 00       	mov    0xca0,%eax
{
 7a6:	89 e5                	mov    %esp,%ebp
 7a8:	57                   	push   %edi
 7a9:	56                   	push   %esi
 7aa:	53                   	push   %ebx
 7ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
 7ae:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 7b0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b3:	39 c8                	cmp    %ecx,%eax
 7b5:	73 19                	jae    7d0 <free+0x30>
 7b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7be:	66 90                	xchg   %ax,%ax
 7c0:	39 d1                	cmp    %edx,%ecx
 7c2:	72 14                	jb     7d8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7c4:	39 d0                	cmp    %edx,%eax
 7c6:	73 10                	jae    7d8 <free+0x38>
{
 7c8:	89 d0                	mov    %edx,%eax
 7ca:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7cc:	39 c8                	cmp    %ecx,%eax
 7ce:	72 f0                	jb     7c0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d0:	39 d0                	cmp    %edx,%eax
 7d2:	72 f4                	jb     7c8 <free+0x28>
 7d4:	39 d1                	cmp    %edx,%ecx
 7d6:	73 f0                	jae    7c8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7d8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7db:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7de:	39 fa                	cmp    %edi,%edx
 7e0:	74 1e                	je     800 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7e2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7e5:	8b 50 04             	mov    0x4(%eax),%edx
 7e8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7eb:	39 f1                	cmp    %esi,%ecx
 7ed:	74 28                	je     817 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7ef:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 7f1:	5b                   	pop    %ebx
  freep = p;
 7f2:	a3 a0 0c 00 00       	mov    %eax,0xca0
}
 7f7:	5e                   	pop    %esi
 7f8:	5f                   	pop    %edi
 7f9:	5d                   	pop    %ebp
 7fa:	c3                   	ret    
 7fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7ff:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 800:	03 72 04             	add    0x4(%edx),%esi
 803:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 806:	8b 10                	mov    (%eax),%edx
 808:	8b 12                	mov    (%edx),%edx
 80a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 80d:	8b 50 04             	mov    0x4(%eax),%edx
 810:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 813:	39 f1                	cmp    %esi,%ecx
 815:	75 d8                	jne    7ef <free+0x4f>
    p->s.size += bp->s.size;
 817:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 81a:	a3 a0 0c 00 00       	mov    %eax,0xca0
    p->s.size += bp->s.size;
 81f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 822:	8b 53 f8             	mov    -0x8(%ebx),%edx
 825:	89 10                	mov    %edx,(%eax)
}
 827:	5b                   	pop    %ebx
 828:	5e                   	pop    %esi
 829:	5f                   	pop    %edi
 82a:	5d                   	pop    %ebp
 82b:	c3                   	ret    
 82c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000830 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	57                   	push   %edi
 834:	56                   	push   %esi
 835:	53                   	push   %ebx
 836:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 839:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 83c:	8b 3d a0 0c 00 00    	mov    0xca0,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 842:	8d 70 07             	lea    0x7(%eax),%esi
 845:	c1 ee 03             	shr    $0x3,%esi
 848:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 84b:	85 ff                	test   %edi,%edi
 84d:	0f 84 ad 00 00 00    	je     900 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 853:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 855:	8b 4a 04             	mov    0x4(%edx),%ecx
 858:	39 f1                	cmp    %esi,%ecx
 85a:	73 72                	jae    8ce <malloc+0x9e>
 85c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 862:	bb 00 10 00 00       	mov    $0x1000,%ebx
 867:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 86a:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 871:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 874:	eb 1b                	jmp    891 <malloc+0x61>
 876:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 87d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 880:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 882:	8b 48 04             	mov    0x4(%eax),%ecx
 885:	39 f1                	cmp    %esi,%ecx
 887:	73 4f                	jae    8d8 <malloc+0xa8>
 889:	8b 3d a0 0c 00 00    	mov    0xca0,%edi
 88f:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 891:	39 d7                	cmp    %edx,%edi
 893:	75 eb                	jne    880 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 895:	83 ec 0c             	sub    $0xc,%esp
 898:	ff 75 e4             	pushl  -0x1c(%ebp)
 89b:	e8 e9 fb ff ff       	call   489 <sbrk>
  if(p == (char*)-1)
 8a0:	83 c4 10             	add    $0x10,%esp
 8a3:	83 f8 ff             	cmp    $0xffffffff,%eax
 8a6:	74 1c                	je     8c4 <malloc+0x94>
  hp->s.size = nu;
 8a8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 8ab:	83 ec 0c             	sub    $0xc,%esp
 8ae:	83 c0 08             	add    $0x8,%eax
 8b1:	50                   	push   %eax
 8b2:	e8 e9 fe ff ff       	call   7a0 <free>
  return freep;
 8b7:	8b 15 a0 0c 00 00    	mov    0xca0,%edx
      if((p = morecore(nunits)) == 0)
 8bd:	83 c4 10             	add    $0x10,%esp
 8c0:	85 d2                	test   %edx,%edx
 8c2:	75 bc                	jne    880 <malloc+0x50>
        return 0;
  }
}
 8c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 8c7:	31 c0                	xor    %eax,%eax
}
 8c9:	5b                   	pop    %ebx
 8ca:	5e                   	pop    %esi
 8cb:	5f                   	pop    %edi
 8cc:	5d                   	pop    %ebp
 8cd:	c3                   	ret    
    if(p->s.size >= nunits){
 8ce:	89 d0                	mov    %edx,%eax
 8d0:	89 fa                	mov    %edi,%edx
 8d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 8d8:	39 ce                	cmp    %ecx,%esi
 8da:	74 54                	je     930 <malloc+0x100>
        p->s.size -= nunits;
 8dc:	29 f1                	sub    %esi,%ecx
 8de:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 8e1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 8e4:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 8e7:	89 15 a0 0c 00 00    	mov    %edx,0xca0
}
 8ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 8f0:	83 c0 08             	add    $0x8,%eax
}
 8f3:	5b                   	pop    %ebx
 8f4:	5e                   	pop    %esi
 8f5:	5f                   	pop    %edi
 8f6:	5d                   	pop    %ebp
 8f7:	c3                   	ret    
 8f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8ff:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 900:	c7 05 a0 0c 00 00 a4 	movl   $0xca4,0xca0
 907:	0c 00 00 
    base.s.size = 0;
 90a:	bf a4 0c 00 00       	mov    $0xca4,%edi
    base.s.ptr = freep = prevp = &base;
 90f:	c7 05 a4 0c 00 00 a4 	movl   $0xca4,0xca4
 916:	0c 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 919:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 91b:	c7 05 a8 0c 00 00 00 	movl   $0x0,0xca8
 922:	00 00 00 
    if(p->s.size >= nunits){
 925:	e9 32 ff ff ff       	jmp    85c <malloc+0x2c>
 92a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 930:	8b 08                	mov    (%eax),%ecx
 932:	89 0a                	mov    %ecx,(%edx)
 934:	eb b1                	jmp    8e7 <malloc+0xb7>
