
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "fork test OK\n");
}

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
  forktest();
   6:	e8 35 00 00 00       	call   40 <forktest>
  exit();
   b:	e8 21 04 00 00       	call   431 <exit>

00000010 <printf>:
{
  10:	55                   	push   %ebp
  11:	89 e5                	mov    %esp,%ebp
  13:	53                   	push   %ebx
  14:	83 ec 10             	sub    $0x10,%esp
  17:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  write(fd, s, strlen(s));
  1a:	53                   	push   %ebx
  1b:	e8 a0 01 00 00       	call   1c0 <strlen>
  20:	83 c4 0c             	add    $0xc,%esp
  23:	50                   	push   %eax
  24:	53                   	push   %ebx
  25:	ff 75 08             	pushl  0x8(%ebp)
  28:	e8 24 04 00 00       	call   451 <write>
}
  2d:	83 c4 10             	add    $0x10,%esp
  30:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  33:	c9                   	leave  
  34:	c3                   	ret    
  35:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000040 <forktest>:
{
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	53                   	push   %ebx
  for(n=0; n<N; n++){
  44:	31 db                	xor    %ebx,%ebx
{
  46:	83 ec 10             	sub    $0x10,%esp
  write(fd, s, strlen(s));
  49:	68 3c 05 00 00       	push   $0x53c
  4e:	e8 6d 01 00 00       	call   1c0 <strlen>
  53:	83 c4 0c             	add    $0xc,%esp
  56:	50                   	push   %eax
  57:	68 3c 05 00 00       	push   $0x53c
  5c:	6a 01                	push   $0x1
  5e:	e8 ee 03 00 00       	call   451 <write>
  63:	83 c4 10             	add    $0x10,%esp
  66:	eb 19                	jmp    81 <forktest+0x41>
  68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  6f:	90                   	nop
    if(pid == 0)
  70:	74 58                	je     ca <forktest+0x8a>
  for(n=0; n<N; n++){
  72:	83 c3 01             	add    $0x1,%ebx
  75:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  7b:	0f 84 92 00 00 00    	je     113 <forktest+0xd3>
    pid = fork();
  81:	e8 a3 03 00 00       	call   429 <fork>
    if(pid < 0)
  86:	85 c0                	test   %eax,%eax
  88:	79 e6                	jns    70 <forktest+0x30>
  for(; n > 0; n--){
  8a:	85 db                	test   %ebx,%ebx
  8c:	74 10                	je     9e <forktest+0x5e>
  8e:	66 90                	xchg   %ax,%ax
    if(wait() < 0){
  90:	e8 a4 03 00 00       	call   439 <wait>
  95:	85 c0                	test   %eax,%eax
  97:	78 36                	js     cf <forktest+0x8f>
  for(; n > 0; n--){
  99:	83 eb 01             	sub    $0x1,%ebx
  9c:	75 f2                	jne    90 <forktest+0x50>
  if(wait() != -1){
  9e:	e8 96 03 00 00       	call   439 <wait>
  a3:	83 f8 ff             	cmp    $0xffffffff,%eax
  a6:	75 49                	jne    f1 <forktest+0xb1>
  write(fd, s, strlen(s));
  a8:	83 ec 0c             	sub    $0xc,%esp
  ab:	68 6e 05 00 00       	push   $0x56e
  b0:	e8 0b 01 00 00       	call   1c0 <strlen>
  b5:	83 c4 0c             	add    $0xc,%esp
  b8:	50                   	push   %eax
  b9:	68 6e 05 00 00       	push   $0x56e
  be:	6a 01                	push   $0x1
  c0:	e8 8c 03 00 00       	call   451 <write>
}
  c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  c8:	c9                   	leave  
  c9:	c3                   	ret    
      exit();
  ca:	e8 62 03 00 00       	call   431 <exit>
  write(fd, s, strlen(s));
  cf:	83 ec 0c             	sub    $0xc,%esp
  d2:	68 47 05 00 00       	push   $0x547
  d7:	e8 e4 00 00 00       	call   1c0 <strlen>
  dc:	83 c4 0c             	add    $0xc,%esp
  df:	50                   	push   %eax
  e0:	68 47 05 00 00       	push   $0x547
  e5:	6a 01                	push   $0x1
  e7:	e8 65 03 00 00       	call   451 <write>
      exit();
  ec:	e8 40 03 00 00       	call   431 <exit>
  write(fd, s, strlen(s));
  f1:	83 ec 0c             	sub    $0xc,%esp
  f4:	68 5b 05 00 00       	push   $0x55b
  f9:	e8 c2 00 00 00       	call   1c0 <strlen>
  fe:	83 c4 0c             	add    $0xc,%esp
 101:	50                   	push   %eax
 102:	68 5b 05 00 00       	push   $0x55b
 107:	6a 01                	push   $0x1
 109:	e8 43 03 00 00       	call   451 <write>
    exit();
 10e:	e8 1e 03 00 00       	call   431 <exit>
  write(fd, s, strlen(s));
 113:	83 ec 0c             	sub    $0xc,%esp
 116:	68 7c 05 00 00       	push   $0x57c
 11b:	e8 a0 00 00 00       	call   1c0 <strlen>
 120:	83 c4 0c             	add    $0xc,%esp
 123:	50                   	push   %eax
 124:	68 7c 05 00 00       	push   $0x57c
 129:	6a 01                	push   $0x1
 12b:	e8 21 03 00 00       	call   451 <write>
    exit();
 130:	e8 fc 02 00 00       	call   431 <exit>
 135:	66 90                	xchg   %ax,%ax
 137:	66 90                	xchg   %ax,%ax
 139:	66 90                	xchg   %ax,%ax
 13b:	66 90                	xchg   %ax,%ax
 13d:	66 90                	xchg   %ax,%ax
 13f:	90                   	nop

00000140 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 140:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 141:	31 d2                	xor    %edx,%edx
{
 143:	89 e5                	mov    %esp,%ebp
 145:	53                   	push   %ebx
 146:	8b 45 08             	mov    0x8(%ebp),%eax
 149:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 150:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 154:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 157:	83 c2 01             	add    $0x1,%edx
 15a:	84 c9                	test   %cl,%cl
 15c:	75 f2                	jne    150 <strcpy+0x10>
    ;
  return os;
}
 15e:	5b                   	pop    %ebx
 15f:	5d                   	pop    %ebp
 160:	c3                   	ret    
 161:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 168:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 16f:	90                   	nop

00000170 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	56                   	push   %esi
 174:	53                   	push   %ebx
 175:	8b 5d 08             	mov    0x8(%ebp),%ebx
 178:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(*p && *p == *q)
 17b:	0f b6 13             	movzbl (%ebx),%edx
 17e:	0f b6 0e             	movzbl (%esi),%ecx
 181:	84 d2                	test   %dl,%dl
 183:	74 1e                	je     1a3 <strcmp+0x33>
 185:	b8 01 00 00 00       	mov    $0x1,%eax
 18a:	38 ca                	cmp    %cl,%dl
 18c:	74 09                	je     197 <strcmp+0x27>
 18e:	eb 20                	jmp    1b0 <strcmp+0x40>
 190:	83 c0 01             	add    $0x1,%eax
 193:	38 ca                	cmp    %cl,%dl
 195:	75 19                	jne    1b0 <strcmp+0x40>
 197:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 19b:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
 19f:	84 d2                	test   %dl,%dl
 1a1:	75 ed                	jne    190 <strcmp+0x20>
 1a3:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 1a5:	5b                   	pop    %ebx
 1a6:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
 1a7:	29 c8                	sub    %ecx,%eax
}
 1a9:	5d                   	pop    %ebp
 1aa:	c3                   	ret    
 1ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1af:	90                   	nop
 1b0:	0f b6 c2             	movzbl %dl,%eax
 1b3:	5b                   	pop    %ebx
 1b4:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
 1b5:	29 c8                	sub    %ecx,%eax
}
 1b7:	5d                   	pop    %ebp
 1b8:	c3                   	ret    
 1b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001c0 <strlen>:

uint
strlen(char *s)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1c6:	80 39 00             	cmpb   $0x0,(%ecx)
 1c9:	74 15                	je     1e0 <strlen+0x20>
 1cb:	31 d2                	xor    %edx,%edx
 1cd:	8d 76 00             	lea    0x0(%esi),%esi
 1d0:	83 c2 01             	add    $0x1,%edx
 1d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1d7:	89 d0                	mov    %edx,%eax
 1d9:	75 f5                	jne    1d0 <strlen+0x10>
    ;
  return n;
}
 1db:	5d                   	pop    %ebp
 1dc:	c3                   	ret    
 1dd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 1e0:	31 c0                	xor    %eax,%eax
}
 1e2:	5d                   	pop    %ebp
 1e3:	c3                   	ret    
 1e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1ef:	90                   	nop

000001f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	57                   	push   %edi
 1f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1fd:	89 d7                	mov    %edx,%edi
 1ff:	fc                   	cld    
 200:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 202:	89 d0                	mov    %edx,%eax
 204:	5f                   	pop    %edi
 205:	5d                   	pop    %ebp
 206:	c3                   	ret    
 207:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 20e:	66 90                	xchg   %ax,%ax

00000210 <strchr>:

char*
strchr(const char *s, char c)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	53                   	push   %ebx
 214:	8b 45 08             	mov    0x8(%ebp),%eax
 217:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 21a:	0f b6 18             	movzbl (%eax),%ebx
 21d:	84 db                	test   %bl,%bl
 21f:	74 1d                	je     23e <strchr+0x2e>
 221:	89 d1                	mov    %edx,%ecx
    if(*s == c)
 223:	38 d3                	cmp    %dl,%bl
 225:	75 0d                	jne    234 <strchr+0x24>
 227:	eb 17                	jmp    240 <strchr+0x30>
 229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 230:	38 ca                	cmp    %cl,%dl
 232:	74 0c                	je     240 <strchr+0x30>
  for(; *s; s++)
 234:	83 c0 01             	add    $0x1,%eax
 237:	0f b6 10             	movzbl (%eax),%edx
 23a:	84 d2                	test   %dl,%dl
 23c:	75 f2                	jne    230 <strchr+0x20>
      return (char*)s;
  return 0;
 23e:	31 c0                	xor    %eax,%eax
}
 240:	5b                   	pop    %ebx
 241:	5d                   	pop    %ebp
 242:	c3                   	ret    
 243:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 24a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000250 <gets>:

char*
gets(char *buf, int max)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	57                   	push   %edi
 254:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 255:	31 f6                	xor    %esi,%esi
{
 257:	53                   	push   %ebx
 258:	89 f3                	mov    %esi,%ebx
 25a:	83 ec 1c             	sub    $0x1c,%esp
 25d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 260:	eb 2f                	jmp    291 <gets+0x41>
 262:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 268:	83 ec 04             	sub    $0x4,%esp
 26b:	8d 45 e7             	lea    -0x19(%ebp),%eax
 26e:	6a 01                	push   $0x1
 270:	50                   	push   %eax
 271:	6a 00                	push   $0x0
 273:	e8 d1 01 00 00       	call   449 <read>
    if(cc < 1)
 278:	83 c4 10             	add    $0x10,%esp
 27b:	85 c0                	test   %eax,%eax
 27d:	7e 1c                	jle    29b <gets+0x4b>
      break;
    buf[i++] = c;
 27f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 283:	83 c7 01             	add    $0x1,%edi
 286:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 289:	3c 0a                	cmp    $0xa,%al
 28b:	74 23                	je     2b0 <gets+0x60>
 28d:	3c 0d                	cmp    $0xd,%al
 28f:	74 1f                	je     2b0 <gets+0x60>
  for(i=0; i+1 < max; ){
 291:	83 c3 01             	add    $0x1,%ebx
 294:	89 fe                	mov    %edi,%esi
 296:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 299:	7c cd                	jl     268 <gets+0x18>
 29b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 29d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 2a0:	c6 03 00             	movb   $0x0,(%ebx)
}
 2a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2a6:	5b                   	pop    %ebx
 2a7:	5e                   	pop    %esi
 2a8:	5f                   	pop    %edi
 2a9:	5d                   	pop    %ebp
 2aa:	c3                   	ret    
 2ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2af:	90                   	nop
 2b0:	8b 75 08             	mov    0x8(%ebp),%esi
 2b3:	8b 45 08             	mov    0x8(%ebp),%eax
 2b6:	01 de                	add    %ebx,%esi
 2b8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 2ba:	c6 03 00             	movb   $0x0,(%ebx)
}
 2bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2c0:	5b                   	pop    %ebx
 2c1:	5e                   	pop    %esi
 2c2:	5f                   	pop    %edi
 2c3:	5d                   	pop    %ebp
 2c4:	c3                   	ret    
 2c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002d0 <stat>:

int
stat(char *n, struct stat *st)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	56                   	push   %esi
 2d4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d5:	83 ec 08             	sub    $0x8,%esp
 2d8:	6a 00                	push   $0x0
 2da:	ff 75 08             	pushl  0x8(%ebp)
 2dd:	e8 8f 01 00 00       	call   471 <open>
  if(fd < 0)
 2e2:	83 c4 10             	add    $0x10,%esp
 2e5:	85 c0                	test   %eax,%eax
 2e7:	78 27                	js     310 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2e9:	83 ec 08             	sub    $0x8,%esp
 2ec:	ff 75 0c             	pushl  0xc(%ebp)
 2ef:	89 c3                	mov    %eax,%ebx
 2f1:	50                   	push   %eax
 2f2:	e8 92 01 00 00       	call   489 <fstat>
  close(fd);
 2f7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2fa:	89 c6                	mov    %eax,%esi
  close(fd);
 2fc:	e8 58 01 00 00       	call   459 <close>
  return r;
 301:	83 c4 10             	add    $0x10,%esp
}
 304:	8d 65 f8             	lea    -0x8(%ebp),%esp
 307:	89 f0                	mov    %esi,%eax
 309:	5b                   	pop    %ebx
 30a:	5e                   	pop    %esi
 30b:	5d                   	pop    %ebp
 30c:	c3                   	ret    
 30d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 310:	be ff ff ff ff       	mov    $0xffffffff,%esi
 315:	eb ed                	jmp    304 <stat+0x34>
 317:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 31e:	66 90                	xchg   %ax,%ax

00000320 <atoi>:

#ifdef PDX_XV6
int
atoi(const char *s)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	56                   	push   %esi
 324:	8b 55 08             	mov    0x8(%ebp),%edx
 327:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 328:	0f b6 0a             	movzbl (%edx),%ecx
 32b:	80 f9 20             	cmp    $0x20,%cl
 32e:	75 0b                	jne    33b <atoi+0x1b>
 330:	83 c2 01             	add    $0x1,%edx
 333:	0f b6 0a             	movzbl (%edx),%ecx
 336:	80 f9 20             	cmp    $0x20,%cl
 339:	74 f5                	je     330 <atoi+0x10>
  sign = (*s == '-') ? -1 : 1;
 33b:	80 f9 2d             	cmp    $0x2d,%cl
 33e:	74 40                	je     380 <atoi+0x60>
 340:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 345:	80 f9 2b             	cmp    $0x2b,%cl
 348:	74 3b                	je     385 <atoi+0x65>
    s++;
  while('0' <= *s && *s <= '9')
 34a:	0f be 0a             	movsbl (%edx),%ecx
 34d:	8d 41 d0             	lea    -0x30(%ecx),%eax
 350:	3c 09                	cmp    $0x9,%al
 352:	b8 00 00 00 00       	mov    $0x0,%eax
 357:	77 1f                	ja     378 <atoi+0x58>
 359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 360:	83 c2 01             	add    $0x1,%edx
 363:	8d 04 80             	lea    (%eax,%eax,4),%eax
 366:	8d 44 41 d0          	lea    -0x30(%ecx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 36a:	0f be 0a             	movsbl (%edx),%ecx
 36d:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 370:	80 fb 09             	cmp    $0x9,%bl
 373:	76 eb                	jbe    360 <atoi+0x40>
 375:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 378:	5b                   	pop    %ebx
 379:	5e                   	pop    %esi
 37a:	5d                   	pop    %ebp
 37b:	c3                   	ret    
 37c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 380:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 385:	83 c2 01             	add    $0x1,%edx
 388:	eb c0                	jmp    34a <atoi+0x2a>
 38a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000390 <atoo>:

int
atoo(const char *s)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	56                   	push   %esi
 394:	8b 55 08             	mov    0x8(%ebp),%edx
 397:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 398:	0f b6 0a             	movzbl (%edx),%ecx
 39b:	80 f9 20             	cmp    $0x20,%cl
 39e:	75 0b                	jne    3ab <atoo+0x1b>
 3a0:	83 c2 01             	add    $0x1,%edx
 3a3:	0f b6 0a             	movzbl (%edx),%ecx
 3a6:	80 f9 20             	cmp    $0x20,%cl
 3a9:	74 f5                	je     3a0 <atoo+0x10>
  sign = (*s == '-') ? -1 : 1;
 3ab:	80 f9 2d             	cmp    $0x2d,%cl
 3ae:	74 40                	je     3f0 <atoo+0x60>
 3b0:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 3b5:	80 f9 2b             	cmp    $0x2b,%cl
 3b8:	74 3b                	je     3f5 <atoo+0x65>
    s++;
  while('0' <= *s && *s <= '7')
 3ba:	0f be 0a             	movsbl (%edx),%ecx
 3bd:	8d 41 d0             	lea    -0x30(%ecx),%eax
 3c0:	3c 07                	cmp    $0x7,%al
 3c2:	b8 00 00 00 00       	mov    $0x0,%eax
 3c7:	77 1c                	ja     3e5 <atoo+0x55>
 3c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*8 + *s++ - '0';
 3d0:	83 c2 01             	add    $0x1,%edx
 3d3:	8d 44 c1 d0          	lea    -0x30(%ecx,%eax,8),%eax
  while('0' <= *s && *s <= '7')
 3d7:	0f be 0a             	movsbl (%edx),%ecx
 3da:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 3dd:	80 fb 07             	cmp    $0x7,%bl
 3e0:	76 ee                	jbe    3d0 <atoo+0x40>
 3e2:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 3e5:	5b                   	pop    %ebx
 3e6:	5e                   	pop    %esi
 3e7:	5d                   	pop    %ebp
 3e8:	c3                   	ret    
 3e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 3f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 3f5:	83 c2 01             	add    $0x1,%edx
 3f8:	eb c0                	jmp    3ba <atoo+0x2a>
 3fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000400 <memmove>:
}
#endif // PDX_XV6

void*
memmove(void *vdst, void *vsrc, int n)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	8b 55 10             	mov    0x10(%ebp),%edx
 407:	8b 45 08             	mov    0x8(%ebp),%eax
 40a:	56                   	push   %esi
 40b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 40e:	85 d2                	test   %edx,%edx
 410:	7e 13                	jle    425 <memmove+0x25>
 412:	01 c2                	add    %eax,%edx
  dst = vdst;
 414:	89 c7                	mov    %eax,%edi
 416:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 41d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 420:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 421:	39 fa                	cmp    %edi,%edx
 423:	75 fb                	jne    420 <memmove+0x20>
  return vdst;
}
 425:	5e                   	pop    %esi
 426:	5f                   	pop    %edi
 427:	5d                   	pop    %ebp
 428:	c3                   	ret    

00000429 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 429:	b8 01 00 00 00       	mov    $0x1,%eax
 42e:	cd 40                	int    $0x40
 430:	c3                   	ret    

00000431 <exit>:
SYSCALL(exit)
 431:	b8 02 00 00 00       	mov    $0x2,%eax
 436:	cd 40                	int    $0x40
 438:	c3                   	ret    

00000439 <wait>:
SYSCALL(wait)
 439:	b8 03 00 00 00       	mov    $0x3,%eax
 43e:	cd 40                	int    $0x40
 440:	c3                   	ret    

00000441 <pipe>:
SYSCALL(pipe)
 441:	b8 04 00 00 00       	mov    $0x4,%eax
 446:	cd 40                	int    $0x40
 448:	c3                   	ret    

00000449 <read>:
SYSCALL(read)
 449:	b8 05 00 00 00       	mov    $0x5,%eax
 44e:	cd 40                	int    $0x40
 450:	c3                   	ret    

00000451 <write>:
SYSCALL(write)
 451:	b8 10 00 00 00       	mov    $0x10,%eax
 456:	cd 40                	int    $0x40
 458:	c3                   	ret    

00000459 <close>:
SYSCALL(close)
 459:	b8 15 00 00 00       	mov    $0x15,%eax
 45e:	cd 40                	int    $0x40
 460:	c3                   	ret    

00000461 <kill>:
SYSCALL(kill)
 461:	b8 06 00 00 00       	mov    $0x6,%eax
 466:	cd 40                	int    $0x40
 468:	c3                   	ret    

00000469 <exec>:
SYSCALL(exec)
 469:	b8 07 00 00 00       	mov    $0x7,%eax
 46e:	cd 40                	int    $0x40
 470:	c3                   	ret    

00000471 <open>:
SYSCALL(open)
 471:	b8 0f 00 00 00       	mov    $0xf,%eax
 476:	cd 40                	int    $0x40
 478:	c3                   	ret    

00000479 <mknod>:
SYSCALL(mknod)
 479:	b8 11 00 00 00       	mov    $0x11,%eax
 47e:	cd 40                	int    $0x40
 480:	c3                   	ret    

00000481 <unlink>:
SYSCALL(unlink)
 481:	b8 12 00 00 00       	mov    $0x12,%eax
 486:	cd 40                	int    $0x40
 488:	c3                   	ret    

00000489 <fstat>:
SYSCALL(fstat)
 489:	b8 08 00 00 00       	mov    $0x8,%eax
 48e:	cd 40                	int    $0x40
 490:	c3                   	ret    

00000491 <link>:
SYSCALL(link)
 491:	b8 13 00 00 00       	mov    $0x13,%eax
 496:	cd 40                	int    $0x40
 498:	c3                   	ret    

00000499 <mkdir>:
SYSCALL(mkdir)
 499:	b8 14 00 00 00       	mov    $0x14,%eax
 49e:	cd 40                	int    $0x40
 4a0:	c3                   	ret    

000004a1 <chdir>:
SYSCALL(chdir)
 4a1:	b8 09 00 00 00       	mov    $0x9,%eax
 4a6:	cd 40                	int    $0x40
 4a8:	c3                   	ret    

000004a9 <dup>:
SYSCALL(dup)
 4a9:	b8 0a 00 00 00       	mov    $0xa,%eax
 4ae:	cd 40                	int    $0x40
 4b0:	c3                   	ret    

000004b1 <getpid>:
SYSCALL(getpid)
 4b1:	b8 0b 00 00 00       	mov    $0xb,%eax
 4b6:	cd 40                	int    $0x40
 4b8:	c3                   	ret    

000004b9 <sbrk>:
SYSCALL(sbrk)
 4b9:	b8 0c 00 00 00       	mov    $0xc,%eax
 4be:	cd 40                	int    $0x40
 4c0:	c3                   	ret    

000004c1 <sleep>:
SYSCALL(sleep)
 4c1:	b8 0d 00 00 00       	mov    $0xd,%eax
 4c6:	cd 40                	int    $0x40
 4c8:	c3                   	ret    

000004c9 <uptime>:
SYSCALL(uptime)
 4c9:	b8 0e 00 00 00       	mov    $0xe,%eax
 4ce:	cd 40                	int    $0x40
 4d0:	c3                   	ret    

000004d1 <halt>:
SYSCALL(halt)
 4d1:	b8 16 00 00 00       	mov    $0x16,%eax
 4d6:	cd 40                	int    $0x40
 4d8:	c3                   	ret    

000004d9 <date>:
SYSCALL(date)
 4d9:	b8 17 00 00 00       	mov    $0x17,%eax
 4de:	cd 40                	int    $0x40
 4e0:	c3                   	ret    

000004e1 <getgid>:
SYSCALL(getgid)
 4e1:	b8 18 00 00 00       	mov    $0x18,%eax
 4e6:	cd 40                	int    $0x40
 4e8:	c3                   	ret    

000004e9 <setgid>:
SYSCALL(setgid)
 4e9:	b8 19 00 00 00       	mov    $0x19,%eax
 4ee:	cd 40                	int    $0x40
 4f0:	c3                   	ret    

000004f1 <getuid>:
SYSCALL(getuid)
 4f1:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4f6:	cd 40                	int    $0x40
 4f8:	c3                   	ret    

000004f9 <setuid>:
SYSCALL(setuid)
 4f9:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4fe:	cd 40                	int    $0x40
 500:	c3                   	ret    

00000501 <getppid>:
SYSCALL(getppid)
 501:	b8 1c 00 00 00       	mov    $0x1c,%eax
 506:	cd 40                	int    $0x40
 508:	c3                   	ret    

00000509 <getprocs>:
SYSCALL(getprocs)
 509:	b8 1d 00 00 00       	mov    $0x1d,%eax
 50e:	cd 40                	int    $0x40
 510:	c3                   	ret    

00000511 <setpriority>:
SYSCALL(setpriority)
 511:	b8 1e 00 00 00       	mov    $0x1e,%eax
 516:	cd 40                	int    $0x40
 518:	c3                   	ret    

00000519 <getpriority>:
SYSCALL(getpriority)
 519:	b8 1f 00 00 00       	mov    $0x1f,%eax
 51e:	cd 40                	int    $0x40
 520:	c3                   	ret    

00000521 <chmod>:
SYSCALL(chmod)
 521:	b8 20 00 00 00       	mov    $0x20,%eax
 526:	cd 40                	int    $0x40
 528:	c3                   	ret    

00000529 <chown>:
SYSCALL(chown)
 529:	b8 21 00 00 00       	mov    $0x21,%eax
 52e:	cd 40                	int    $0x40
 530:	c3                   	ret    

00000531 <chgrp>:
SYSCALL(chgrp)
 531:	b8 22 00 00 00       	mov    $0x22,%eax
 536:	cd 40                	int    $0x40
 538:	c3                   	ret    
