
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
  int fd, i;
  char path[] = "stressfs0";
   7:	b8 30 00 00 00       	mov    $0x30,%eax
{
   c:	ff 71 fc             	pushl  -0x4(%ecx)
   f:	55                   	push   %ebp
  10:	89 e5                	mov    %esp,%ebp
  12:	57                   	push   %edi
  13:	56                   	push   %esi
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));
  14:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
{
  1a:	53                   	push   %ebx

  for(i = 0; i < 4; i++)
  1b:	31 db                	xor    %ebx,%ebx
{
  1d:	51                   	push   %ecx
  1e:	81 ec 20 02 00 00    	sub    $0x220,%esp
  char path[] = "stressfs0";
  24:	66 89 85 e6 fd ff ff 	mov    %ax,-0x21a(%ebp)
  printf(1, "stressfs starting\n");
  2b:	68 68 09 00 00       	push   $0x968
  30:	6a 01                	push   $0x1
  char path[] = "stressfs0";
  32:	c7 85 de fd ff ff 73 	movl   $0x65727473,-0x222(%ebp)
  39:	74 72 65 
  3c:	c7 85 e2 fd ff ff 73 	movl   $0x73667373,-0x21e(%ebp)
  43:	73 66 73 
  printf(1, "stressfs starting\n");
  46:	e8 b5 05 00 00       	call   600 <printf>
  memset(data, 'a', sizeof(data));
  4b:	83 c4 0c             	add    $0xc,%esp
  4e:	68 00 02 00 00       	push   $0x200
  53:	6a 61                	push   $0x61
  55:	56                   	push   %esi
  56:	e8 95 01 00 00       	call   1f0 <memset>
  5b:	83 c4 10             	add    $0x10,%esp
    if(fork() > 0)
  5e:	e8 c6 03 00 00       	call   429 <fork>
  63:	85 c0                	test   %eax,%eax
  65:	0f 8f bf 00 00 00    	jg     12a <main+0x12a>
  for(i = 0; i < 4; i++)
  6b:	83 c3 01             	add    $0x1,%ebx
  6e:	83 fb 04             	cmp    $0x4,%ebx
  71:	75 eb                	jne    5e <main+0x5e>
  73:	bf 04 00 00 00       	mov    $0x4,%edi
      break;

  printf(1, "write %d\n", i);
  78:	83 ec 04             	sub    $0x4,%esp
  7b:	53                   	push   %ebx

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  7c:	bb 14 00 00 00       	mov    $0x14,%ebx
  printf(1, "write %d\n", i);
  81:	68 7b 09 00 00       	push   $0x97b
  86:	6a 01                	push   $0x1
  88:	e8 73 05 00 00       	call   600 <printf>
  path[8] += i;
  8d:	89 f8                	mov    %edi,%eax
  fd = open(path, O_CREATE | O_RDWR);
  8f:	5f                   	pop    %edi
  path[8] += i;
  90:	00 85 e6 fd ff ff    	add    %al,-0x21a(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  96:	58                   	pop    %eax
  97:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  9d:	68 02 02 00 00       	push   $0x202
  a2:	50                   	push   %eax
  a3:	e8 c9 03 00 00       	call   471 <open>
  a8:	83 c4 10             	add    $0x10,%esp
  ab:	89 c7                	mov    %eax,%edi
  for(i = 0; i < 20; i++)
  ad:	8d 76 00             	lea    0x0(%esi),%esi
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  b0:	83 ec 04             	sub    $0x4,%esp
  b3:	68 00 02 00 00       	push   $0x200
  b8:	56                   	push   %esi
  b9:	57                   	push   %edi
  ba:	e8 92 03 00 00       	call   451 <write>
  for(i = 0; i < 20; i++)
  bf:	83 c4 10             	add    $0x10,%esp
  c2:	83 eb 01             	sub    $0x1,%ebx
  c5:	75 e9                	jne    b0 <main+0xb0>
  close(fd);
  c7:	83 ec 0c             	sub    $0xc,%esp
  ca:	57                   	push   %edi
  cb:	e8 89 03 00 00       	call   459 <close>

  printf(1, "read\n");
  d0:	58                   	pop    %eax
  d1:	5a                   	pop    %edx
  d2:	68 85 09 00 00       	push   $0x985
  d7:	6a 01                	push   $0x1
  d9:	e8 22 05 00 00       	call   600 <printf>

  fd = open(path, O_RDONLY);
  de:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  e4:	59                   	pop    %ecx
  e5:	5b                   	pop    %ebx
  e6:	6a 00                	push   $0x0
  e8:	bb 14 00 00 00       	mov    $0x14,%ebx
  ed:	50                   	push   %eax
  ee:	e8 7e 03 00 00       	call   471 <open>
  f3:	83 c4 10             	add    $0x10,%esp
  f6:	89 c7                	mov    %eax,%edi
  for (i = 0; i < 20; i++)
  f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff:	90                   	nop
    read(fd, data, sizeof(data));
 100:	83 ec 04             	sub    $0x4,%esp
 103:	68 00 02 00 00       	push   $0x200
 108:	56                   	push   %esi
 109:	57                   	push   %edi
 10a:	e8 3a 03 00 00       	call   449 <read>
  for (i = 0; i < 20; i++)
 10f:	83 c4 10             	add    $0x10,%esp
 112:	83 eb 01             	sub    $0x1,%ebx
 115:	75 e9                	jne    100 <main+0x100>
  close(fd);
 117:	83 ec 0c             	sub    $0xc,%esp
 11a:	57                   	push   %edi
 11b:	e8 39 03 00 00       	call   459 <close>

  wait();
 120:	e8 14 03 00 00       	call   439 <wait>

  exit();
 125:	e8 07 03 00 00       	call   431 <exit>
 12a:	89 df                	mov    %ebx,%edi
 12c:	e9 47 ff ff ff       	jmp    78 <main+0x78>
 131:	66 90                	xchg   %ax,%ax
 133:	66 90                	xchg   %ax,%ax
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
 539:	66 90                	xchg   %ax,%ax
 53b:	66 90                	xchg   %ax,%ax
 53d:	66 90                	xchg   %ax,%ax
 53f:	90                   	nop

00000540 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	57                   	push   %edi
 544:	56                   	push   %esi
 545:	53                   	push   %ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 546:	89 d3                	mov    %edx,%ebx
{
 548:	83 ec 3c             	sub    $0x3c,%esp
 54b:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 54e:	85 d2                	test   %edx,%edx
 550:	0f 89 92 00 00 00    	jns    5e8 <printint+0xa8>
 556:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 55a:	0f 84 88 00 00 00    	je     5e8 <printint+0xa8>
    neg = 1;
 560:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 567:	f7 db                	neg    %ebx
  } else {
    x = xx;
  }

  i = 0;
 569:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 570:	8d 75 d7             	lea    -0x29(%ebp),%esi
 573:	eb 08                	jmp    57d <printint+0x3d>
 575:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 578:	89 7d c4             	mov    %edi,-0x3c(%ebp)
  }while((x /= base) != 0);
 57b:	89 c3                	mov    %eax,%ebx
    buf[i++] = digits[x % base];
 57d:	89 d8                	mov    %ebx,%eax
 57f:	31 d2                	xor    %edx,%edx
 581:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 584:	f7 f1                	div    %ecx
 586:	83 c7 01             	add    $0x1,%edi
 589:	0f b6 92 94 09 00 00 	movzbl 0x994(%edx),%edx
 590:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 593:	39 d9                	cmp    %ebx,%ecx
 595:	76 e1                	jbe    578 <printint+0x38>
  if(neg)
 597:	8b 45 c0             	mov    -0x40(%ebp),%eax
 59a:	85 c0                	test   %eax,%eax
 59c:	74 0d                	je     5ab <printint+0x6b>
    buf[i++] = '-';
 59e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 5a3:	ba 2d 00 00 00       	mov    $0x2d,%edx
    buf[i++] = digits[x % base];
 5a8:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 5ab:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 5ae:	8b 7d bc             	mov    -0x44(%ebp),%edi
 5b1:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 5b5:	eb 0f                	jmp    5c6 <printint+0x86>
 5b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5be:	66 90                	xchg   %ax,%ax
 5c0:	0f b6 13             	movzbl (%ebx),%edx
 5c3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 5c6:	83 ec 04             	sub    $0x4,%esp
 5c9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 5cc:	6a 01                	push   $0x1
 5ce:	56                   	push   %esi
 5cf:	57                   	push   %edi
 5d0:	e8 7c fe ff ff       	call   451 <write>

  while(--i >= 0)
 5d5:	83 c4 10             	add    $0x10,%esp
 5d8:	39 de                	cmp    %ebx,%esi
 5da:	75 e4                	jne    5c0 <printint+0x80>
    putc(fd, buf[i]);
}
 5dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5df:	5b                   	pop    %ebx
 5e0:	5e                   	pop    %esi
 5e1:	5f                   	pop    %edi
 5e2:	5d                   	pop    %ebp
 5e3:	c3                   	ret    
 5e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 5e8:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 5ef:	e9 75 ff ff ff       	jmp    569 <printint+0x29>
 5f4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5ff:	90                   	nop

00000600 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	57                   	push   %edi
 604:	56                   	push   %esi
 605:	53                   	push   %ebx
 606:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 609:	8b 75 0c             	mov    0xc(%ebp),%esi
 60c:	0f b6 1e             	movzbl (%esi),%ebx
 60f:	84 db                	test   %bl,%bl
 611:	0f 84 b9 00 00 00    	je     6d0 <printf+0xd0>
  ap = (uint*)(void*)&fmt + 1;
 617:	8d 45 10             	lea    0x10(%ebp),%eax
 61a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 61d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 620:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 622:	89 45 d0             	mov    %eax,-0x30(%ebp)
 625:	eb 38                	jmp    65f <printf+0x5f>
 627:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 62e:	66 90                	xchg   %ax,%ax
 630:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 633:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 638:	83 f8 25             	cmp    $0x25,%eax
 63b:	74 17                	je     654 <printf+0x54>
  write(fd, &c, 1);
 63d:	83 ec 04             	sub    $0x4,%esp
 640:	88 5d e7             	mov    %bl,-0x19(%ebp)
 643:	6a 01                	push   $0x1
 645:	57                   	push   %edi
 646:	ff 75 08             	pushl  0x8(%ebp)
 649:	e8 03 fe ff ff       	call   451 <write>
 64e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 651:	83 c4 10             	add    $0x10,%esp
 654:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 657:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 65b:	84 db                	test   %bl,%bl
 65d:	74 71                	je     6d0 <printf+0xd0>
    c = fmt[i] & 0xff;
 65f:	0f be cb             	movsbl %bl,%ecx
 662:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 665:	85 d2                	test   %edx,%edx
 667:	74 c7                	je     630 <printf+0x30>
      }
    } else if(state == '%'){
 669:	83 fa 25             	cmp    $0x25,%edx
 66c:	75 e6                	jne    654 <printf+0x54>
      if(c == 'd'){
 66e:	83 f8 64             	cmp    $0x64,%eax
 671:	0f 84 99 00 00 00    	je     710 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 677:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 67d:	83 f9 70             	cmp    $0x70,%ecx
 680:	74 5e                	je     6e0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 682:	83 f8 73             	cmp    $0x73,%eax
 685:	0f 84 d5 00 00 00    	je     760 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 68b:	83 f8 63             	cmp    $0x63,%eax
 68e:	0f 84 8c 00 00 00    	je     720 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 694:	83 f8 25             	cmp    $0x25,%eax
 697:	0f 84 b3 00 00 00    	je     750 <printf+0x150>
  write(fd, &c, 1);
 69d:	83 ec 04             	sub    $0x4,%esp
 6a0:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 6a4:	6a 01                	push   $0x1
 6a6:	57                   	push   %edi
 6a7:	ff 75 08             	pushl  0x8(%ebp)
 6aa:	e8 a2 fd ff ff       	call   451 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 6af:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 6b2:	83 c4 0c             	add    $0xc,%esp
 6b5:	6a 01                	push   $0x1
 6b7:	83 c6 01             	add    $0x1,%esi
 6ba:	57                   	push   %edi
 6bb:	ff 75 08             	pushl  0x8(%ebp)
 6be:	e8 8e fd ff ff       	call   451 <write>
  for(i = 0; fmt[i]; i++){
 6c3:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 6c7:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 6ca:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 6cc:	84 db                	test   %bl,%bl
 6ce:	75 8f                	jne    65f <printf+0x5f>
    }
  }
}
 6d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6d3:	5b                   	pop    %ebx
 6d4:	5e                   	pop    %esi
 6d5:	5f                   	pop    %edi
 6d6:	5d                   	pop    %ebp
 6d7:	c3                   	ret    
 6d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6df:	90                   	nop
        printint(fd, *ap, 16, 0);
 6e0:	83 ec 0c             	sub    $0xc,%esp
 6e3:	b9 10 00 00 00       	mov    $0x10,%ecx
 6e8:	6a 00                	push   $0x0
 6ea:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 6ed:	8b 45 08             	mov    0x8(%ebp),%eax
 6f0:	8b 13                	mov    (%ebx),%edx
 6f2:	e8 49 fe ff ff       	call   540 <printint>
        ap++;
 6f7:	89 d8                	mov    %ebx,%eax
 6f9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6fc:	31 d2                	xor    %edx,%edx
        ap++;
 6fe:	83 c0 04             	add    $0x4,%eax
 701:	89 45 d0             	mov    %eax,-0x30(%ebp)
 704:	e9 4b ff ff ff       	jmp    654 <printf+0x54>
 709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 710:	83 ec 0c             	sub    $0xc,%esp
 713:	b9 0a 00 00 00       	mov    $0xa,%ecx
 718:	6a 01                	push   $0x1
 71a:	eb ce                	jmp    6ea <printf+0xea>
 71c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 720:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 723:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 726:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 728:	6a 01                	push   $0x1
        ap++;
 72a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 72d:	57                   	push   %edi
 72e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 731:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 734:	e8 18 fd ff ff       	call   451 <write>
        ap++;
 739:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 73c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 73f:	31 d2                	xor    %edx,%edx
 741:	e9 0e ff ff ff       	jmp    654 <printf+0x54>
 746:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 74d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 750:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 753:	83 ec 04             	sub    $0x4,%esp
 756:	e9 5a ff ff ff       	jmp    6b5 <printf+0xb5>
 75b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 75f:	90                   	nop
        s = (char*)*ap;
 760:	8b 45 d0             	mov    -0x30(%ebp),%eax
 763:	8b 18                	mov    (%eax),%ebx
        ap++;
 765:	83 c0 04             	add    $0x4,%eax
 768:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 76b:	85 db                	test   %ebx,%ebx
 76d:	74 17                	je     786 <printf+0x186>
        while(*s != 0){
 76f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 772:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 774:	84 c0                	test   %al,%al
 776:	0f 84 d8 fe ff ff    	je     654 <printf+0x54>
 77c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 77f:	89 de                	mov    %ebx,%esi
 781:	8b 5d 08             	mov    0x8(%ebp),%ebx
 784:	eb 1a                	jmp    7a0 <printf+0x1a0>
          s = "(null)";
 786:	bb 8b 09 00 00       	mov    $0x98b,%ebx
        while(*s != 0){
 78b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 78e:	b8 28 00 00 00       	mov    $0x28,%eax
 793:	89 de                	mov    %ebx,%esi
 795:	8b 5d 08             	mov    0x8(%ebp),%ebx
 798:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 79f:	90                   	nop
  write(fd, &c, 1);
 7a0:	83 ec 04             	sub    $0x4,%esp
          s++;
 7a3:	83 c6 01             	add    $0x1,%esi
 7a6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 7a9:	6a 01                	push   $0x1
 7ab:	57                   	push   %edi
 7ac:	53                   	push   %ebx
 7ad:	e8 9f fc ff ff       	call   451 <write>
        while(*s != 0){
 7b2:	0f b6 06             	movzbl (%esi),%eax
 7b5:	83 c4 10             	add    $0x10,%esp
 7b8:	84 c0                	test   %al,%al
 7ba:	75 e4                	jne    7a0 <printf+0x1a0>
 7bc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 7bf:	31 d2                	xor    %edx,%edx
 7c1:	e9 8e fe ff ff       	jmp    654 <printf+0x54>
 7c6:	66 90                	xchg   %ax,%ax
 7c8:	66 90                	xchg   %ax,%ax
 7ca:	66 90                	xchg   %ax,%ax
 7cc:	66 90                	xchg   %ax,%ax
 7ce:	66 90                	xchg   %ax,%ax

000007d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d1:	a1 80 0c 00 00       	mov    0xc80,%eax
{
 7d6:	89 e5                	mov    %esp,%ebp
 7d8:	57                   	push   %edi
 7d9:	56                   	push   %esi
 7da:	53                   	push   %ebx
 7db:	8b 5d 08             	mov    0x8(%ebp),%ebx
 7de:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 7e0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e3:	39 c8                	cmp    %ecx,%eax
 7e5:	73 19                	jae    800 <free+0x30>
 7e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7ee:	66 90                	xchg   %ax,%ax
 7f0:	39 d1                	cmp    %edx,%ecx
 7f2:	72 14                	jb     808 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7f4:	39 d0                	cmp    %edx,%eax
 7f6:	73 10                	jae    808 <free+0x38>
{
 7f8:	89 d0                	mov    %edx,%eax
 7fa:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7fc:	39 c8                	cmp    %ecx,%eax
 7fe:	72 f0                	jb     7f0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 800:	39 d0                	cmp    %edx,%eax
 802:	72 f4                	jb     7f8 <free+0x28>
 804:	39 d1                	cmp    %edx,%ecx
 806:	73 f0                	jae    7f8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 808:	8b 73 fc             	mov    -0x4(%ebx),%esi
 80b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 80e:	39 fa                	cmp    %edi,%edx
 810:	74 1e                	je     830 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 812:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 815:	8b 50 04             	mov    0x4(%eax),%edx
 818:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 81b:	39 f1                	cmp    %esi,%ecx
 81d:	74 28                	je     847 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 81f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 821:	5b                   	pop    %ebx
  freep = p;
 822:	a3 80 0c 00 00       	mov    %eax,0xc80
}
 827:	5e                   	pop    %esi
 828:	5f                   	pop    %edi
 829:	5d                   	pop    %ebp
 82a:	c3                   	ret    
 82b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 82f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 830:	03 72 04             	add    0x4(%edx),%esi
 833:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 836:	8b 10                	mov    (%eax),%edx
 838:	8b 12                	mov    (%edx),%edx
 83a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 83d:	8b 50 04             	mov    0x4(%eax),%edx
 840:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 843:	39 f1                	cmp    %esi,%ecx
 845:	75 d8                	jne    81f <free+0x4f>
    p->s.size += bp->s.size;
 847:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 84a:	a3 80 0c 00 00       	mov    %eax,0xc80
    p->s.size += bp->s.size;
 84f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 852:	8b 53 f8             	mov    -0x8(%ebx),%edx
 855:	89 10                	mov    %edx,(%eax)
}
 857:	5b                   	pop    %ebx
 858:	5e                   	pop    %esi
 859:	5f                   	pop    %edi
 85a:	5d                   	pop    %ebp
 85b:	c3                   	ret    
 85c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000860 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 860:	55                   	push   %ebp
 861:	89 e5                	mov    %esp,%ebp
 863:	57                   	push   %edi
 864:	56                   	push   %esi
 865:	53                   	push   %ebx
 866:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 869:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 86c:	8b 3d 80 0c 00 00    	mov    0xc80,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 872:	8d 70 07             	lea    0x7(%eax),%esi
 875:	c1 ee 03             	shr    $0x3,%esi
 878:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 87b:	85 ff                	test   %edi,%edi
 87d:	0f 84 ad 00 00 00    	je     930 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 883:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 885:	8b 4a 04             	mov    0x4(%edx),%ecx
 888:	39 f1                	cmp    %esi,%ecx
 88a:	73 72                	jae    8fe <malloc+0x9e>
 88c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 892:	bb 00 10 00 00       	mov    $0x1000,%ebx
 897:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 89a:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 8a1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 8a4:	eb 1b                	jmp    8c1 <malloc+0x61>
 8a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8ad:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8b0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8b2:	8b 48 04             	mov    0x4(%eax),%ecx
 8b5:	39 f1                	cmp    %esi,%ecx
 8b7:	73 4f                	jae    908 <malloc+0xa8>
 8b9:	8b 3d 80 0c 00 00    	mov    0xc80,%edi
 8bf:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8c1:	39 d7                	cmp    %edx,%edi
 8c3:	75 eb                	jne    8b0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 8c5:	83 ec 0c             	sub    $0xc,%esp
 8c8:	ff 75 e4             	pushl  -0x1c(%ebp)
 8cb:	e8 e9 fb ff ff       	call   4b9 <sbrk>
  if(p == (char*)-1)
 8d0:	83 c4 10             	add    $0x10,%esp
 8d3:	83 f8 ff             	cmp    $0xffffffff,%eax
 8d6:	74 1c                	je     8f4 <malloc+0x94>
  hp->s.size = nu;
 8d8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 8db:	83 ec 0c             	sub    $0xc,%esp
 8de:	83 c0 08             	add    $0x8,%eax
 8e1:	50                   	push   %eax
 8e2:	e8 e9 fe ff ff       	call   7d0 <free>
  return freep;
 8e7:	8b 15 80 0c 00 00    	mov    0xc80,%edx
      if((p = morecore(nunits)) == 0)
 8ed:	83 c4 10             	add    $0x10,%esp
 8f0:	85 d2                	test   %edx,%edx
 8f2:	75 bc                	jne    8b0 <malloc+0x50>
        return 0;
  }
}
 8f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 8f7:	31 c0                	xor    %eax,%eax
}
 8f9:	5b                   	pop    %ebx
 8fa:	5e                   	pop    %esi
 8fb:	5f                   	pop    %edi
 8fc:	5d                   	pop    %ebp
 8fd:	c3                   	ret    
    if(p->s.size >= nunits){
 8fe:	89 d0                	mov    %edx,%eax
 900:	89 fa                	mov    %edi,%edx
 902:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 908:	39 ce                	cmp    %ecx,%esi
 90a:	74 54                	je     960 <malloc+0x100>
        p->s.size -= nunits;
 90c:	29 f1                	sub    %esi,%ecx
 90e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 911:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 914:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 917:	89 15 80 0c 00 00    	mov    %edx,0xc80
}
 91d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 920:	83 c0 08             	add    $0x8,%eax
}
 923:	5b                   	pop    %ebx
 924:	5e                   	pop    %esi
 925:	5f                   	pop    %edi
 926:	5d                   	pop    %ebp
 927:	c3                   	ret    
 928:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 92f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 930:	c7 05 80 0c 00 00 84 	movl   $0xc84,0xc80
 937:	0c 00 00 
    base.s.size = 0;
 93a:	bf 84 0c 00 00       	mov    $0xc84,%edi
    base.s.ptr = freep = prevp = &base;
 93f:	c7 05 84 0c 00 00 84 	movl   $0xc84,0xc84
 946:	0c 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 949:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 94b:	c7 05 88 0c 00 00 00 	movl   $0x0,0xc88
 952:	00 00 00 
    if(p->s.size >= nunits){
 955:	e9 32 ff ff ff       	jmp    88c <malloc+0x2c>
 95a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 960:	8b 08                	mov    (%eax),%ecx
 962:	89 0a                	mov    %ecx,(%edx)
 964:	eb b1                	jmp    917 <malloc+0xb7>
