
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
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
  27:	7e 56                	jle    7f <main+0x7f>
  29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	83 ec 08             	sub    $0x8,%esp
  33:	6a 00                	push   $0x0
  35:	ff 33                	pushl  (%ebx)
  37:	e8 75 04 00 00       	call   4b1 <open>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	89 c7                	mov    %eax,%edi
  41:	85 c0                	test   %eax,%eax
  43:	78 26                	js     6b <main+0x6b>
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  45:	83 ec 08             	sub    $0x8,%esp
  48:	ff 33                	pushl  (%ebx)
  for(i = 1; i < argc; i++){
  4a:	83 c6 01             	add    $0x1,%esi
  4d:	83 c3 04             	add    $0x4,%ebx
    wc(fd, argv[i]);
  50:	50                   	push   %eax
  51:	e8 4a 00 00 00       	call   a0 <wc>
    close(fd);
  56:	89 3c 24             	mov    %edi,(%esp)
  59:	e8 3b 04 00 00       	call   499 <close>
  for(i = 1; i < argc; i++){
  5e:	83 c4 10             	add    $0x10,%esp
  61:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  64:	75 ca                	jne    30 <main+0x30>
  }
  exit();
  66:	e8 06 04 00 00       	call   471 <exit>
      printf(1, "wc: cannot open %s\n", argv[i]);
  6b:	50                   	push   %eax
  6c:	ff 33                	pushl  (%ebx)
  6e:	68 cb 09 00 00       	push   $0x9cb
  73:	6a 01                	push   $0x1
  75:	e8 c6 05 00 00       	call   640 <printf>
      exit();
  7a:	e8 f2 03 00 00       	call   471 <exit>
    wc(0, "");
  7f:	52                   	push   %edx
  80:	52                   	push   %edx
  81:	68 bd 09 00 00       	push   $0x9bd
  86:	6a 00                	push   $0x0
  88:	e8 13 00 00 00       	call   a0 <wc>
    exit();
  8d:	e8 df 03 00 00       	call   471 <exit>
  92:	66 90                	xchg   %ax,%ax
  94:	66 90                	xchg   %ax,%ax
  96:	66 90                	xchg   %ax,%ax
  98:	66 90                	xchg   %ax,%ax
  9a:	66 90                	xchg   %ax,%ax
  9c:	66 90                	xchg   %ax,%ax
  9e:	66 90                	xchg   %ax,%ax

000000a0 <wc>:
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	57                   	push   %edi
  a4:	56                   	push   %esi
  a5:	53                   	push   %ebx
  l = w = c = 0;
  a6:	31 db                	xor    %ebx,%ebx
{
  a8:	83 ec 1c             	sub    $0x1c,%esp
  inword = 0;
  ab:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  l = w = c = 0;
  b2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  b9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  c0:	83 ec 04             	sub    $0x4,%esp
  c3:	68 00 02 00 00       	push   $0x200
  c8:	68 40 0d 00 00       	push   $0xd40
  cd:	ff 75 08             	pushl  0x8(%ebp)
  d0:	e8 b4 03 00 00       	call   489 <read>
  d5:	83 c4 10             	add    $0x10,%esp
  d8:	89 c6                	mov    %eax,%esi
  da:	85 c0                	test   %eax,%eax
  dc:	7e 62                	jle    140 <wc+0xa0>
    for(i=0; i<n; i++){
  de:	31 ff                	xor    %edi,%edi
  e0:	eb 14                	jmp    f6 <wc+0x56>
  e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        inword = 0;
  e8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    for(i=0; i<n; i++){
  ef:	83 c7 01             	add    $0x1,%edi
  f2:	39 fe                	cmp    %edi,%esi
  f4:	74 42                	je     138 <wc+0x98>
      if(buf[i] == '\n')
  f6:	0f be 87 40 0d 00 00 	movsbl 0xd40(%edi),%eax
        l++;
  fd:	31 c9                	xor    %ecx,%ecx
  ff:	3c 0a                	cmp    $0xa,%al
 101:	0f 94 c1             	sete   %cl
      if(strchr(" \r\t\n\v", buf[i]))
 104:	83 ec 08             	sub    $0x8,%esp
 107:	50                   	push   %eax
        l++;
 108:	01 cb                	add    %ecx,%ebx
      if(strchr(" \r\t\n\v", buf[i]))
 10a:	68 a8 09 00 00       	push   $0x9a8
 10f:	e8 3c 01 00 00       	call   250 <strchr>
 114:	83 c4 10             	add    $0x10,%esp
 117:	85 c0                	test   %eax,%eax
 119:	75 cd                	jne    e8 <wc+0x48>
      else if(!inword){
 11b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 11e:	85 d2                	test   %edx,%edx
 120:	75 cd                	jne    ef <wc+0x4f>
    for(i=0; i<n; i++){
 122:	83 c7 01             	add    $0x1,%edi
        w++;
 125:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
        inword = 1;
 129:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
    for(i=0; i<n; i++){
 130:	39 fe                	cmp    %edi,%esi
 132:	75 c2                	jne    f6 <wc+0x56>
 134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 138:	01 75 dc             	add    %esi,-0x24(%ebp)
 13b:	eb 83                	jmp    c0 <wc+0x20>
 13d:	8d 76 00             	lea    0x0(%esi),%esi
  if(n < 0){
 140:	75 24                	jne    166 <wc+0xc6>
  printf(1, "%d %d %d %s\n", l, w, c, name);
 142:	83 ec 08             	sub    $0x8,%esp
 145:	ff 75 0c             	pushl  0xc(%ebp)
 148:	ff 75 dc             	pushl  -0x24(%ebp)
 14b:	ff 75 e0             	pushl  -0x20(%ebp)
 14e:	53                   	push   %ebx
 14f:	68 be 09 00 00       	push   $0x9be
 154:	6a 01                	push   $0x1
 156:	e8 e5 04 00 00       	call   640 <printf>
}
 15b:	83 c4 20             	add    $0x20,%esp
 15e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 161:	5b                   	pop    %ebx
 162:	5e                   	pop    %esi
 163:	5f                   	pop    %edi
 164:	5d                   	pop    %ebp
 165:	c3                   	ret    
    printf(1, "wc: read error\n");
 166:	50                   	push   %eax
 167:	50                   	push   %eax
 168:	68 ae 09 00 00       	push   $0x9ae
 16d:	6a 01                	push   $0x1
 16f:	e8 cc 04 00 00       	call   640 <printf>
    exit();
 174:	e8 f8 02 00 00       	call   471 <exit>
 179:	66 90                	xchg   %ax,%ax
 17b:	66 90                	xchg   %ax,%ax
 17d:	66 90                	xchg   %ax,%ax
 17f:	90                   	nop

00000180 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 180:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 181:	31 d2                	xor    %edx,%edx
{
 183:	89 e5                	mov    %esp,%ebp
 185:	53                   	push   %ebx
 186:	8b 45 08             	mov    0x8(%ebp),%eax
 189:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 190:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 194:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 197:	83 c2 01             	add    $0x1,%edx
 19a:	84 c9                	test   %cl,%cl
 19c:	75 f2                	jne    190 <strcpy+0x10>
    ;
  return os;
}
 19e:	5b                   	pop    %ebx
 19f:	5d                   	pop    %ebp
 1a0:	c3                   	ret    
 1a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1af:	90                   	nop

000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	56                   	push   %esi
 1b4:	53                   	push   %ebx
 1b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 1b8:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(*p && *p == *q)
 1bb:	0f b6 13             	movzbl (%ebx),%edx
 1be:	0f b6 0e             	movzbl (%esi),%ecx
 1c1:	84 d2                	test   %dl,%dl
 1c3:	74 1e                	je     1e3 <strcmp+0x33>
 1c5:	b8 01 00 00 00       	mov    $0x1,%eax
 1ca:	38 ca                	cmp    %cl,%dl
 1cc:	74 09                	je     1d7 <strcmp+0x27>
 1ce:	eb 20                	jmp    1f0 <strcmp+0x40>
 1d0:	83 c0 01             	add    $0x1,%eax
 1d3:	38 ca                	cmp    %cl,%dl
 1d5:	75 19                	jne    1f0 <strcmp+0x40>
 1d7:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 1db:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
 1df:	84 d2                	test   %dl,%dl
 1e1:	75 ed                	jne    1d0 <strcmp+0x20>
 1e3:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 1e5:	5b                   	pop    %ebx
 1e6:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
 1e7:	29 c8                	sub    %ecx,%eax
}
 1e9:	5d                   	pop    %ebp
 1ea:	c3                   	ret    
 1eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1ef:	90                   	nop
 1f0:	0f b6 c2             	movzbl %dl,%eax
 1f3:	5b                   	pop    %ebx
 1f4:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
 1f5:	29 c8                	sub    %ecx,%eax
}
 1f7:	5d                   	pop    %ebp
 1f8:	c3                   	ret    
 1f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000200 <strlen>:

uint
strlen(char *s)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 206:	80 39 00             	cmpb   $0x0,(%ecx)
 209:	74 15                	je     220 <strlen+0x20>
 20b:	31 d2                	xor    %edx,%edx
 20d:	8d 76 00             	lea    0x0(%esi),%esi
 210:	83 c2 01             	add    $0x1,%edx
 213:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 217:	89 d0                	mov    %edx,%eax
 219:	75 f5                	jne    210 <strlen+0x10>
    ;
  return n;
}
 21b:	5d                   	pop    %ebp
 21c:	c3                   	ret    
 21d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 220:	31 c0                	xor    %eax,%eax
}
 222:	5d                   	pop    %ebp
 223:	c3                   	ret    
 224:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 22b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 22f:	90                   	nop

00000230 <memset>:

void*
memset(void *dst, int c, uint n)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	57                   	push   %edi
 234:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 237:	8b 4d 10             	mov    0x10(%ebp),%ecx
 23a:	8b 45 0c             	mov    0xc(%ebp),%eax
 23d:	89 d7                	mov    %edx,%edi
 23f:	fc                   	cld    
 240:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 242:	89 d0                	mov    %edx,%eax
 244:	5f                   	pop    %edi
 245:	5d                   	pop    %ebp
 246:	c3                   	ret    
 247:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 24e:	66 90                	xchg   %ax,%ax

00000250 <strchr>:

char*
strchr(const char *s, char c)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	53                   	push   %ebx
 254:	8b 45 08             	mov    0x8(%ebp),%eax
 257:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 25a:	0f b6 18             	movzbl (%eax),%ebx
 25d:	84 db                	test   %bl,%bl
 25f:	74 1d                	je     27e <strchr+0x2e>
 261:	89 d1                	mov    %edx,%ecx
    if(*s == c)
 263:	38 d3                	cmp    %dl,%bl
 265:	75 0d                	jne    274 <strchr+0x24>
 267:	eb 17                	jmp    280 <strchr+0x30>
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 270:	38 ca                	cmp    %cl,%dl
 272:	74 0c                	je     280 <strchr+0x30>
  for(; *s; s++)
 274:	83 c0 01             	add    $0x1,%eax
 277:	0f b6 10             	movzbl (%eax),%edx
 27a:	84 d2                	test   %dl,%dl
 27c:	75 f2                	jne    270 <strchr+0x20>
      return (char*)s;
  return 0;
 27e:	31 c0                	xor    %eax,%eax
}
 280:	5b                   	pop    %ebx
 281:	5d                   	pop    %ebp
 282:	c3                   	ret    
 283:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 28a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000290 <gets>:

char*
gets(char *buf, int max)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	57                   	push   %edi
 294:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 295:	31 f6                	xor    %esi,%esi
{
 297:	53                   	push   %ebx
 298:	89 f3                	mov    %esi,%ebx
 29a:	83 ec 1c             	sub    $0x1c,%esp
 29d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 2a0:	eb 2f                	jmp    2d1 <gets+0x41>
 2a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 2a8:	83 ec 04             	sub    $0x4,%esp
 2ab:	8d 45 e7             	lea    -0x19(%ebp),%eax
 2ae:	6a 01                	push   $0x1
 2b0:	50                   	push   %eax
 2b1:	6a 00                	push   $0x0
 2b3:	e8 d1 01 00 00       	call   489 <read>
    if(cc < 1)
 2b8:	83 c4 10             	add    $0x10,%esp
 2bb:	85 c0                	test   %eax,%eax
 2bd:	7e 1c                	jle    2db <gets+0x4b>
      break;
    buf[i++] = c;
 2bf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2c3:	83 c7 01             	add    $0x1,%edi
 2c6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 2c9:	3c 0a                	cmp    $0xa,%al
 2cb:	74 23                	je     2f0 <gets+0x60>
 2cd:	3c 0d                	cmp    $0xd,%al
 2cf:	74 1f                	je     2f0 <gets+0x60>
  for(i=0; i+1 < max; ){
 2d1:	83 c3 01             	add    $0x1,%ebx
 2d4:	89 fe                	mov    %edi,%esi
 2d6:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2d9:	7c cd                	jl     2a8 <gets+0x18>
 2db:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 2dd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 2e0:	c6 03 00             	movb   $0x0,(%ebx)
}
 2e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2e6:	5b                   	pop    %ebx
 2e7:	5e                   	pop    %esi
 2e8:	5f                   	pop    %edi
 2e9:	5d                   	pop    %ebp
 2ea:	c3                   	ret    
 2eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2ef:	90                   	nop
 2f0:	8b 75 08             	mov    0x8(%ebp),%esi
 2f3:	8b 45 08             	mov    0x8(%ebp),%eax
 2f6:	01 de                	add    %ebx,%esi
 2f8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 2fa:	c6 03 00             	movb   $0x0,(%ebx)
}
 2fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 300:	5b                   	pop    %ebx
 301:	5e                   	pop    %esi
 302:	5f                   	pop    %edi
 303:	5d                   	pop    %ebp
 304:	c3                   	ret    
 305:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 30c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000310 <stat>:

int
stat(char *n, struct stat *st)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	56                   	push   %esi
 314:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 315:	83 ec 08             	sub    $0x8,%esp
 318:	6a 00                	push   $0x0
 31a:	ff 75 08             	pushl  0x8(%ebp)
 31d:	e8 8f 01 00 00       	call   4b1 <open>
  if(fd < 0)
 322:	83 c4 10             	add    $0x10,%esp
 325:	85 c0                	test   %eax,%eax
 327:	78 27                	js     350 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 329:	83 ec 08             	sub    $0x8,%esp
 32c:	ff 75 0c             	pushl  0xc(%ebp)
 32f:	89 c3                	mov    %eax,%ebx
 331:	50                   	push   %eax
 332:	e8 92 01 00 00       	call   4c9 <fstat>
  close(fd);
 337:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 33a:	89 c6                	mov    %eax,%esi
  close(fd);
 33c:	e8 58 01 00 00       	call   499 <close>
  return r;
 341:	83 c4 10             	add    $0x10,%esp
}
 344:	8d 65 f8             	lea    -0x8(%ebp),%esp
 347:	89 f0                	mov    %esi,%eax
 349:	5b                   	pop    %ebx
 34a:	5e                   	pop    %esi
 34b:	5d                   	pop    %ebp
 34c:	c3                   	ret    
 34d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 350:	be ff ff ff ff       	mov    $0xffffffff,%esi
 355:	eb ed                	jmp    344 <stat+0x34>
 357:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 35e:	66 90                	xchg   %ax,%ax

00000360 <atoi>:

#ifdef PDX_XV6
int
atoi(const char *s)
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
 36e:	75 0b                	jne    37b <atoi+0x1b>
 370:	83 c2 01             	add    $0x1,%edx
 373:	0f b6 0a             	movzbl (%edx),%ecx
 376:	80 f9 20             	cmp    $0x20,%cl
 379:	74 f5                	je     370 <atoi+0x10>
  sign = (*s == '-') ? -1 : 1;
 37b:	80 f9 2d             	cmp    $0x2d,%cl
 37e:	74 40                	je     3c0 <atoi+0x60>
 380:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 385:	80 f9 2b             	cmp    $0x2b,%cl
 388:	74 3b                	je     3c5 <atoi+0x65>
    s++;
  while('0' <= *s && *s <= '9')
 38a:	0f be 0a             	movsbl (%edx),%ecx
 38d:	8d 41 d0             	lea    -0x30(%ecx),%eax
 390:	3c 09                	cmp    $0x9,%al
 392:	b8 00 00 00 00       	mov    $0x0,%eax
 397:	77 1f                	ja     3b8 <atoi+0x58>
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 3a0:	83 c2 01             	add    $0x1,%edx
 3a3:	8d 04 80             	lea    (%eax,%eax,4),%eax
 3a6:	8d 44 41 d0          	lea    -0x30(%ecx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 3aa:	0f be 0a             	movsbl (%edx),%ecx
 3ad:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 3b0:	80 fb 09             	cmp    $0x9,%bl
 3b3:	76 eb                	jbe    3a0 <atoi+0x40>
 3b5:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 3b8:	5b                   	pop    %ebx
 3b9:	5e                   	pop    %esi
 3ba:	5d                   	pop    %ebp
 3bb:	c3                   	ret    
 3bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 3c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 3c5:	83 c2 01             	add    $0x1,%edx
 3c8:	eb c0                	jmp    38a <atoi+0x2a>
 3ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003d0 <atoo>:

int
atoo(const char *s)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	56                   	push   %esi
 3d4:	8b 55 08             	mov    0x8(%ebp),%edx
 3d7:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 3d8:	0f b6 0a             	movzbl (%edx),%ecx
 3db:	80 f9 20             	cmp    $0x20,%cl
 3de:	75 0b                	jne    3eb <atoo+0x1b>
 3e0:	83 c2 01             	add    $0x1,%edx
 3e3:	0f b6 0a             	movzbl (%edx),%ecx
 3e6:	80 f9 20             	cmp    $0x20,%cl
 3e9:	74 f5                	je     3e0 <atoo+0x10>
  sign = (*s == '-') ? -1 : 1;
 3eb:	80 f9 2d             	cmp    $0x2d,%cl
 3ee:	74 40                	je     430 <atoo+0x60>
 3f0:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 3f5:	80 f9 2b             	cmp    $0x2b,%cl
 3f8:	74 3b                	je     435 <atoo+0x65>
    s++;
  while('0' <= *s && *s <= '7')
 3fa:	0f be 0a             	movsbl (%edx),%ecx
 3fd:	8d 41 d0             	lea    -0x30(%ecx),%eax
 400:	3c 07                	cmp    $0x7,%al
 402:	b8 00 00 00 00       	mov    $0x0,%eax
 407:	77 1c                	ja     425 <atoo+0x55>
 409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*8 + *s++ - '0';
 410:	83 c2 01             	add    $0x1,%edx
 413:	8d 44 c1 d0          	lea    -0x30(%ecx,%eax,8),%eax
  while('0' <= *s && *s <= '7')
 417:	0f be 0a             	movsbl (%edx),%ecx
 41a:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 41d:	80 fb 07             	cmp    $0x7,%bl
 420:	76 ee                	jbe    410 <atoo+0x40>
 422:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 425:	5b                   	pop    %ebx
 426:	5e                   	pop    %esi
 427:	5d                   	pop    %ebp
 428:	c3                   	ret    
 429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 430:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 435:	83 c2 01             	add    $0x1,%edx
 438:	eb c0                	jmp    3fa <atoo+0x2a>
 43a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000440 <memmove>:
}
#endif // PDX_XV6

void*
memmove(void *vdst, void *vsrc, int n)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	8b 55 10             	mov    0x10(%ebp),%edx
 447:	8b 45 08             	mov    0x8(%ebp),%eax
 44a:	56                   	push   %esi
 44b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 44e:	85 d2                	test   %edx,%edx
 450:	7e 13                	jle    465 <memmove+0x25>
 452:	01 c2                	add    %eax,%edx
  dst = vdst;
 454:	89 c7                	mov    %eax,%edi
 456:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 45d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 460:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 461:	39 fa                	cmp    %edi,%edx
 463:	75 fb                	jne    460 <memmove+0x20>
  return vdst;
}
 465:	5e                   	pop    %esi
 466:	5f                   	pop    %edi
 467:	5d                   	pop    %ebp
 468:	c3                   	ret    

00000469 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 469:	b8 01 00 00 00       	mov    $0x1,%eax
 46e:	cd 40                	int    $0x40
 470:	c3                   	ret    

00000471 <exit>:
SYSCALL(exit)
 471:	b8 02 00 00 00       	mov    $0x2,%eax
 476:	cd 40                	int    $0x40
 478:	c3                   	ret    

00000479 <wait>:
SYSCALL(wait)
 479:	b8 03 00 00 00       	mov    $0x3,%eax
 47e:	cd 40                	int    $0x40
 480:	c3                   	ret    

00000481 <pipe>:
SYSCALL(pipe)
 481:	b8 04 00 00 00       	mov    $0x4,%eax
 486:	cd 40                	int    $0x40
 488:	c3                   	ret    

00000489 <read>:
SYSCALL(read)
 489:	b8 05 00 00 00       	mov    $0x5,%eax
 48e:	cd 40                	int    $0x40
 490:	c3                   	ret    

00000491 <write>:
SYSCALL(write)
 491:	b8 10 00 00 00       	mov    $0x10,%eax
 496:	cd 40                	int    $0x40
 498:	c3                   	ret    

00000499 <close>:
SYSCALL(close)
 499:	b8 15 00 00 00       	mov    $0x15,%eax
 49e:	cd 40                	int    $0x40
 4a0:	c3                   	ret    

000004a1 <kill>:
SYSCALL(kill)
 4a1:	b8 06 00 00 00       	mov    $0x6,%eax
 4a6:	cd 40                	int    $0x40
 4a8:	c3                   	ret    

000004a9 <exec>:
SYSCALL(exec)
 4a9:	b8 07 00 00 00       	mov    $0x7,%eax
 4ae:	cd 40                	int    $0x40
 4b0:	c3                   	ret    

000004b1 <open>:
SYSCALL(open)
 4b1:	b8 0f 00 00 00       	mov    $0xf,%eax
 4b6:	cd 40                	int    $0x40
 4b8:	c3                   	ret    

000004b9 <mknod>:
SYSCALL(mknod)
 4b9:	b8 11 00 00 00       	mov    $0x11,%eax
 4be:	cd 40                	int    $0x40
 4c0:	c3                   	ret    

000004c1 <unlink>:
SYSCALL(unlink)
 4c1:	b8 12 00 00 00       	mov    $0x12,%eax
 4c6:	cd 40                	int    $0x40
 4c8:	c3                   	ret    

000004c9 <fstat>:
SYSCALL(fstat)
 4c9:	b8 08 00 00 00       	mov    $0x8,%eax
 4ce:	cd 40                	int    $0x40
 4d0:	c3                   	ret    

000004d1 <link>:
SYSCALL(link)
 4d1:	b8 13 00 00 00       	mov    $0x13,%eax
 4d6:	cd 40                	int    $0x40
 4d8:	c3                   	ret    

000004d9 <mkdir>:
SYSCALL(mkdir)
 4d9:	b8 14 00 00 00       	mov    $0x14,%eax
 4de:	cd 40                	int    $0x40
 4e0:	c3                   	ret    

000004e1 <chdir>:
SYSCALL(chdir)
 4e1:	b8 09 00 00 00       	mov    $0x9,%eax
 4e6:	cd 40                	int    $0x40
 4e8:	c3                   	ret    

000004e9 <dup>:
SYSCALL(dup)
 4e9:	b8 0a 00 00 00       	mov    $0xa,%eax
 4ee:	cd 40                	int    $0x40
 4f0:	c3                   	ret    

000004f1 <getpid>:
SYSCALL(getpid)
 4f1:	b8 0b 00 00 00       	mov    $0xb,%eax
 4f6:	cd 40                	int    $0x40
 4f8:	c3                   	ret    

000004f9 <sbrk>:
SYSCALL(sbrk)
 4f9:	b8 0c 00 00 00       	mov    $0xc,%eax
 4fe:	cd 40                	int    $0x40
 500:	c3                   	ret    

00000501 <sleep>:
SYSCALL(sleep)
 501:	b8 0d 00 00 00       	mov    $0xd,%eax
 506:	cd 40                	int    $0x40
 508:	c3                   	ret    

00000509 <uptime>:
SYSCALL(uptime)
 509:	b8 0e 00 00 00       	mov    $0xe,%eax
 50e:	cd 40                	int    $0x40
 510:	c3                   	ret    

00000511 <halt>:
SYSCALL(halt)
 511:	b8 16 00 00 00       	mov    $0x16,%eax
 516:	cd 40                	int    $0x40
 518:	c3                   	ret    

00000519 <date>:
SYSCALL(date)
 519:	b8 17 00 00 00       	mov    $0x17,%eax
 51e:	cd 40                	int    $0x40
 520:	c3                   	ret    

00000521 <getgid>:
SYSCALL(getgid)
 521:	b8 18 00 00 00       	mov    $0x18,%eax
 526:	cd 40                	int    $0x40
 528:	c3                   	ret    

00000529 <setgid>:
SYSCALL(setgid)
 529:	b8 19 00 00 00       	mov    $0x19,%eax
 52e:	cd 40                	int    $0x40
 530:	c3                   	ret    

00000531 <getuid>:
SYSCALL(getuid)
 531:	b8 1a 00 00 00       	mov    $0x1a,%eax
 536:	cd 40                	int    $0x40
 538:	c3                   	ret    

00000539 <setuid>:
SYSCALL(setuid)
 539:	b8 1b 00 00 00       	mov    $0x1b,%eax
 53e:	cd 40                	int    $0x40
 540:	c3                   	ret    

00000541 <getppid>:
SYSCALL(getppid)
 541:	b8 1c 00 00 00       	mov    $0x1c,%eax
 546:	cd 40                	int    $0x40
 548:	c3                   	ret    

00000549 <getprocs>:
SYSCALL(getprocs)
 549:	b8 1d 00 00 00       	mov    $0x1d,%eax
 54e:	cd 40                	int    $0x40
 550:	c3                   	ret    

00000551 <setpriority>:
SYSCALL(setpriority)
 551:	b8 1e 00 00 00       	mov    $0x1e,%eax
 556:	cd 40                	int    $0x40
 558:	c3                   	ret    

00000559 <getpriority>:
SYSCALL(getpriority)
 559:	b8 1f 00 00 00       	mov    $0x1f,%eax
 55e:	cd 40                	int    $0x40
 560:	c3                   	ret    

00000561 <chmod>:
SYSCALL(chmod)
 561:	b8 20 00 00 00       	mov    $0x20,%eax
 566:	cd 40                	int    $0x40
 568:	c3                   	ret    

00000569 <chown>:
SYSCALL(chown)
 569:	b8 21 00 00 00       	mov    $0x21,%eax
 56e:	cd 40                	int    $0x40
 570:	c3                   	ret    

00000571 <chgrp>:
SYSCALL(chgrp)
 571:	b8 22 00 00 00       	mov    $0x22,%eax
 576:	cd 40                	int    $0x40
 578:	c3                   	ret    
 579:	66 90                	xchg   %ax,%ax
 57b:	66 90                	xchg   %ax,%ax
 57d:	66 90                	xchg   %ax,%ax
 57f:	90                   	nop

00000580 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	57                   	push   %edi
 584:	56                   	push   %esi
 585:	53                   	push   %ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 586:	89 d3                	mov    %edx,%ebx
{
 588:	83 ec 3c             	sub    $0x3c,%esp
 58b:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 58e:	85 d2                	test   %edx,%edx
 590:	0f 89 92 00 00 00    	jns    628 <printint+0xa8>
 596:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 59a:	0f 84 88 00 00 00    	je     628 <printint+0xa8>
    neg = 1;
 5a0:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 5a7:	f7 db                	neg    %ebx
  } else {
    x = xx;
  }

  i = 0;
 5a9:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 5b0:	8d 75 d7             	lea    -0x29(%ebp),%esi
 5b3:	eb 08                	jmp    5bd <printint+0x3d>
 5b5:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 5b8:	89 7d c4             	mov    %edi,-0x3c(%ebp)
  }while((x /= base) != 0);
 5bb:	89 c3                	mov    %eax,%ebx
    buf[i++] = digits[x % base];
 5bd:	89 d8                	mov    %ebx,%eax
 5bf:	31 d2                	xor    %edx,%edx
 5c1:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 5c4:	f7 f1                	div    %ecx
 5c6:	83 c7 01             	add    $0x1,%edi
 5c9:	0f b6 92 e8 09 00 00 	movzbl 0x9e8(%edx),%edx
 5d0:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 5d3:	39 d9                	cmp    %ebx,%ecx
 5d5:	76 e1                	jbe    5b8 <printint+0x38>
  if(neg)
 5d7:	8b 45 c0             	mov    -0x40(%ebp),%eax
 5da:	85 c0                	test   %eax,%eax
 5dc:	74 0d                	je     5eb <printint+0x6b>
    buf[i++] = '-';
 5de:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 5e3:	ba 2d 00 00 00       	mov    $0x2d,%edx
    buf[i++] = digits[x % base];
 5e8:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 5eb:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 5ee:	8b 7d bc             	mov    -0x44(%ebp),%edi
 5f1:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 5f5:	eb 0f                	jmp    606 <printint+0x86>
 5f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5fe:	66 90                	xchg   %ax,%ax
 600:	0f b6 13             	movzbl (%ebx),%edx
 603:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 606:	83 ec 04             	sub    $0x4,%esp
 609:	88 55 d7             	mov    %dl,-0x29(%ebp)
 60c:	6a 01                	push   $0x1
 60e:	56                   	push   %esi
 60f:	57                   	push   %edi
 610:	e8 7c fe ff ff       	call   491 <write>

  while(--i >= 0)
 615:	83 c4 10             	add    $0x10,%esp
 618:	39 de                	cmp    %ebx,%esi
 61a:	75 e4                	jne    600 <printint+0x80>
    putc(fd, buf[i]);
}
 61c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 61f:	5b                   	pop    %ebx
 620:	5e                   	pop    %esi
 621:	5f                   	pop    %edi
 622:	5d                   	pop    %ebp
 623:	c3                   	ret    
 624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 628:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 62f:	e9 75 ff ff ff       	jmp    5a9 <printint+0x29>
 634:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 63b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 63f:	90                   	nop

00000640 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	57                   	push   %edi
 644:	56                   	push   %esi
 645:	53                   	push   %ebx
 646:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 649:	8b 75 0c             	mov    0xc(%ebp),%esi
 64c:	0f b6 1e             	movzbl (%esi),%ebx
 64f:	84 db                	test   %bl,%bl
 651:	0f 84 b9 00 00 00    	je     710 <printf+0xd0>
  ap = (uint*)(void*)&fmt + 1;
 657:	8d 45 10             	lea    0x10(%ebp),%eax
 65a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 65d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 660:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 662:	89 45 d0             	mov    %eax,-0x30(%ebp)
 665:	eb 38                	jmp    69f <printf+0x5f>
 667:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 66e:	66 90                	xchg   %ax,%ax
 670:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 673:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 678:	83 f8 25             	cmp    $0x25,%eax
 67b:	74 17                	je     694 <printf+0x54>
  write(fd, &c, 1);
 67d:	83 ec 04             	sub    $0x4,%esp
 680:	88 5d e7             	mov    %bl,-0x19(%ebp)
 683:	6a 01                	push   $0x1
 685:	57                   	push   %edi
 686:	ff 75 08             	pushl  0x8(%ebp)
 689:	e8 03 fe ff ff       	call   491 <write>
 68e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 691:	83 c4 10             	add    $0x10,%esp
 694:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 697:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 69b:	84 db                	test   %bl,%bl
 69d:	74 71                	je     710 <printf+0xd0>
    c = fmt[i] & 0xff;
 69f:	0f be cb             	movsbl %bl,%ecx
 6a2:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 6a5:	85 d2                	test   %edx,%edx
 6a7:	74 c7                	je     670 <printf+0x30>
      }
    } else if(state == '%'){
 6a9:	83 fa 25             	cmp    $0x25,%edx
 6ac:	75 e6                	jne    694 <printf+0x54>
      if(c == 'd'){
 6ae:	83 f8 64             	cmp    $0x64,%eax
 6b1:	0f 84 99 00 00 00    	je     750 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 6b7:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 6bd:	83 f9 70             	cmp    $0x70,%ecx
 6c0:	74 5e                	je     720 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 6c2:	83 f8 73             	cmp    $0x73,%eax
 6c5:	0f 84 d5 00 00 00    	je     7a0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6cb:	83 f8 63             	cmp    $0x63,%eax
 6ce:	0f 84 8c 00 00 00    	je     760 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 6d4:	83 f8 25             	cmp    $0x25,%eax
 6d7:	0f 84 b3 00 00 00    	je     790 <printf+0x150>
  write(fd, &c, 1);
 6dd:	83 ec 04             	sub    $0x4,%esp
 6e0:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 6e4:	6a 01                	push   $0x1
 6e6:	57                   	push   %edi
 6e7:	ff 75 08             	pushl  0x8(%ebp)
 6ea:	e8 a2 fd ff ff       	call   491 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 6ef:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 6f2:	83 c4 0c             	add    $0xc,%esp
 6f5:	6a 01                	push   $0x1
 6f7:	83 c6 01             	add    $0x1,%esi
 6fa:	57                   	push   %edi
 6fb:	ff 75 08             	pushl  0x8(%ebp)
 6fe:	e8 8e fd ff ff       	call   491 <write>
  for(i = 0; fmt[i]; i++){
 703:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 707:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 70a:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 70c:	84 db                	test   %bl,%bl
 70e:	75 8f                	jne    69f <printf+0x5f>
    }
  }
}
 710:	8d 65 f4             	lea    -0xc(%ebp),%esp
 713:	5b                   	pop    %ebx
 714:	5e                   	pop    %esi
 715:	5f                   	pop    %edi
 716:	5d                   	pop    %ebp
 717:	c3                   	ret    
 718:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 71f:	90                   	nop
        printint(fd, *ap, 16, 0);
 720:	83 ec 0c             	sub    $0xc,%esp
 723:	b9 10 00 00 00       	mov    $0x10,%ecx
 728:	6a 00                	push   $0x0
 72a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 72d:	8b 45 08             	mov    0x8(%ebp),%eax
 730:	8b 13                	mov    (%ebx),%edx
 732:	e8 49 fe ff ff       	call   580 <printint>
        ap++;
 737:	89 d8                	mov    %ebx,%eax
 739:	83 c4 10             	add    $0x10,%esp
      state = 0;
 73c:	31 d2                	xor    %edx,%edx
        ap++;
 73e:	83 c0 04             	add    $0x4,%eax
 741:	89 45 d0             	mov    %eax,-0x30(%ebp)
 744:	e9 4b ff ff ff       	jmp    694 <printf+0x54>
 749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 750:	83 ec 0c             	sub    $0xc,%esp
 753:	b9 0a 00 00 00       	mov    $0xa,%ecx
 758:	6a 01                	push   $0x1
 75a:	eb ce                	jmp    72a <printf+0xea>
 75c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 760:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 763:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 766:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 768:	6a 01                	push   $0x1
        ap++;
 76a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 76d:	57                   	push   %edi
 76e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 771:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 774:	e8 18 fd ff ff       	call   491 <write>
        ap++;
 779:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 77c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 77f:	31 d2                	xor    %edx,%edx
 781:	e9 0e ff ff ff       	jmp    694 <printf+0x54>
 786:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 78d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 790:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 793:	83 ec 04             	sub    $0x4,%esp
 796:	e9 5a ff ff ff       	jmp    6f5 <printf+0xb5>
 79b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 79f:	90                   	nop
        s = (char*)*ap;
 7a0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 7a3:	8b 18                	mov    (%eax),%ebx
        ap++;
 7a5:	83 c0 04             	add    $0x4,%eax
 7a8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 7ab:	85 db                	test   %ebx,%ebx
 7ad:	74 17                	je     7c6 <printf+0x186>
        while(*s != 0){
 7af:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 7b2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 7b4:	84 c0                	test   %al,%al
 7b6:	0f 84 d8 fe ff ff    	je     694 <printf+0x54>
 7bc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 7bf:	89 de                	mov    %ebx,%esi
 7c1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 7c4:	eb 1a                	jmp    7e0 <printf+0x1a0>
          s = "(null)";
 7c6:	bb df 09 00 00       	mov    $0x9df,%ebx
        while(*s != 0){
 7cb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 7ce:	b8 28 00 00 00       	mov    $0x28,%eax
 7d3:	89 de                	mov    %ebx,%esi
 7d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 7d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7df:	90                   	nop
  write(fd, &c, 1);
 7e0:	83 ec 04             	sub    $0x4,%esp
          s++;
 7e3:	83 c6 01             	add    $0x1,%esi
 7e6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 7e9:	6a 01                	push   $0x1
 7eb:	57                   	push   %edi
 7ec:	53                   	push   %ebx
 7ed:	e8 9f fc ff ff       	call   491 <write>
        while(*s != 0){
 7f2:	0f b6 06             	movzbl (%esi),%eax
 7f5:	83 c4 10             	add    $0x10,%esp
 7f8:	84 c0                	test   %al,%al
 7fa:	75 e4                	jne    7e0 <printf+0x1a0>
 7fc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 7ff:	31 d2                	xor    %edx,%edx
 801:	e9 8e fe ff ff       	jmp    694 <printf+0x54>
 806:	66 90                	xchg   %ax,%ax
 808:	66 90                	xchg   %ax,%ax
 80a:	66 90                	xchg   %ax,%ax
 80c:	66 90                	xchg   %ax,%ax
 80e:	66 90                	xchg   %ax,%ax

00000810 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 810:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 811:	a1 20 0d 00 00       	mov    0xd20,%eax
{
 816:	89 e5                	mov    %esp,%ebp
 818:	57                   	push   %edi
 819:	56                   	push   %esi
 81a:	53                   	push   %ebx
 81b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 81e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 820:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 823:	39 c8                	cmp    %ecx,%eax
 825:	73 19                	jae    840 <free+0x30>
 827:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 82e:	66 90                	xchg   %ax,%ax
 830:	39 d1                	cmp    %edx,%ecx
 832:	72 14                	jb     848 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 834:	39 d0                	cmp    %edx,%eax
 836:	73 10                	jae    848 <free+0x38>
{
 838:	89 d0                	mov    %edx,%eax
 83a:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 83c:	39 c8                	cmp    %ecx,%eax
 83e:	72 f0                	jb     830 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 840:	39 d0                	cmp    %edx,%eax
 842:	72 f4                	jb     838 <free+0x28>
 844:	39 d1                	cmp    %edx,%ecx
 846:	73 f0                	jae    838 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 848:	8b 73 fc             	mov    -0x4(%ebx),%esi
 84b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 84e:	39 fa                	cmp    %edi,%edx
 850:	74 1e                	je     870 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 852:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 855:	8b 50 04             	mov    0x4(%eax),%edx
 858:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 85b:	39 f1                	cmp    %esi,%ecx
 85d:	74 28                	je     887 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 85f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 861:	5b                   	pop    %ebx
  freep = p;
 862:	a3 20 0d 00 00       	mov    %eax,0xd20
}
 867:	5e                   	pop    %esi
 868:	5f                   	pop    %edi
 869:	5d                   	pop    %ebp
 86a:	c3                   	ret    
 86b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 86f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 870:	03 72 04             	add    0x4(%edx),%esi
 873:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 876:	8b 10                	mov    (%eax),%edx
 878:	8b 12                	mov    (%edx),%edx
 87a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 87d:	8b 50 04             	mov    0x4(%eax),%edx
 880:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 883:	39 f1                	cmp    %esi,%ecx
 885:	75 d8                	jne    85f <free+0x4f>
    p->s.size += bp->s.size;
 887:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 88a:	a3 20 0d 00 00       	mov    %eax,0xd20
    p->s.size += bp->s.size;
 88f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 892:	8b 53 f8             	mov    -0x8(%ebx),%edx
 895:	89 10                	mov    %edx,(%eax)
}
 897:	5b                   	pop    %ebx
 898:	5e                   	pop    %esi
 899:	5f                   	pop    %edi
 89a:	5d                   	pop    %ebp
 89b:	c3                   	ret    
 89c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000008a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8a0:	55                   	push   %ebp
 8a1:	89 e5                	mov    %esp,%ebp
 8a3:	57                   	push   %edi
 8a4:	56                   	push   %esi
 8a5:	53                   	push   %ebx
 8a6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 8ac:	8b 3d 20 0d 00 00    	mov    0xd20,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8b2:	8d 70 07             	lea    0x7(%eax),%esi
 8b5:	c1 ee 03             	shr    $0x3,%esi
 8b8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 8bb:	85 ff                	test   %edi,%edi
 8bd:	0f 84 ad 00 00 00    	je     970 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 8c5:	8b 4a 04             	mov    0x4(%edx),%ecx
 8c8:	39 f1                	cmp    %esi,%ecx
 8ca:	73 72                	jae    93e <malloc+0x9e>
 8cc:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 8d2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 8d7:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 8da:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 8e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 8e4:	eb 1b                	jmp    901 <malloc+0x61>
 8e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8ed:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8f2:	8b 48 04             	mov    0x4(%eax),%ecx
 8f5:	39 f1                	cmp    %esi,%ecx
 8f7:	73 4f                	jae    948 <malloc+0xa8>
 8f9:	8b 3d 20 0d 00 00    	mov    0xd20,%edi
 8ff:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 901:	39 d7                	cmp    %edx,%edi
 903:	75 eb                	jne    8f0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 905:	83 ec 0c             	sub    $0xc,%esp
 908:	ff 75 e4             	pushl  -0x1c(%ebp)
 90b:	e8 e9 fb ff ff       	call   4f9 <sbrk>
  if(p == (char*)-1)
 910:	83 c4 10             	add    $0x10,%esp
 913:	83 f8 ff             	cmp    $0xffffffff,%eax
 916:	74 1c                	je     934 <malloc+0x94>
  hp->s.size = nu;
 918:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 91b:	83 ec 0c             	sub    $0xc,%esp
 91e:	83 c0 08             	add    $0x8,%eax
 921:	50                   	push   %eax
 922:	e8 e9 fe ff ff       	call   810 <free>
  return freep;
 927:	8b 15 20 0d 00 00    	mov    0xd20,%edx
      if((p = morecore(nunits)) == 0)
 92d:	83 c4 10             	add    $0x10,%esp
 930:	85 d2                	test   %edx,%edx
 932:	75 bc                	jne    8f0 <malloc+0x50>
        return 0;
  }
}
 934:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 937:	31 c0                	xor    %eax,%eax
}
 939:	5b                   	pop    %ebx
 93a:	5e                   	pop    %esi
 93b:	5f                   	pop    %edi
 93c:	5d                   	pop    %ebp
 93d:	c3                   	ret    
    if(p->s.size >= nunits){
 93e:	89 d0                	mov    %edx,%eax
 940:	89 fa                	mov    %edi,%edx
 942:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 948:	39 ce                	cmp    %ecx,%esi
 94a:	74 54                	je     9a0 <malloc+0x100>
        p->s.size -= nunits;
 94c:	29 f1                	sub    %esi,%ecx
 94e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 951:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 954:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 957:	89 15 20 0d 00 00    	mov    %edx,0xd20
}
 95d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 960:	83 c0 08             	add    $0x8,%eax
}
 963:	5b                   	pop    %ebx
 964:	5e                   	pop    %esi
 965:	5f                   	pop    %edi
 966:	5d                   	pop    %ebp
 967:	c3                   	ret    
 968:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 96f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 970:	c7 05 20 0d 00 00 24 	movl   $0xd24,0xd20
 977:	0d 00 00 
    base.s.size = 0;
 97a:	bf 24 0d 00 00       	mov    $0xd24,%edi
    base.s.ptr = freep = prevp = &base;
 97f:	c7 05 24 0d 00 00 24 	movl   $0xd24,0xd24
 986:	0d 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 989:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 98b:	c7 05 28 0d 00 00 00 	movl   $0x0,0xd28
 992:	00 00 00 
    if(p->s.size >= nunits){
 995:	e9 32 ff ff ff       	jmp    8cc <malloc+0x2c>
 99a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 9a0:	8b 08                	mov    (%eax),%ecx
 9a2:	89 0a                	mov    %ecx,(%edx)
 9a4:	eb b1                	jmp    957 <malloc+0xb7>
