
_time:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#ifdef CS333_P2
#include "types.h"
#include "user.h"

int
main(int argc, char * argv[]){
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 18             	sub    $0x18,%esp
  14:	8b 31                	mov    (%ecx),%esi
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
    int pid = fork();
  19:	e8 8b 03 00 00       	call   3a9 <fork>
  1e:	89 c7                	mov    %eax,%edi
    int start_t, end_t, seconds, millisec;

    start_t = uptime();
  20:	e8 24 04 00 00       	call   449 <uptime>
  25:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    if(pid == 0){
  28:	85 ff                	test   %edi,%edi
  2a:	75 50                	jne    7c <main+0x7c>

        if(argc == 1){
  2c:	83 ee 01             	sub    $0x1,%esi
  2f:	74 46                	je     77 <main+0x77>
            exit();
        }

        ++argv; // skip the first arg
  31:	8d 73 04             	lea    0x4(%ebx),%esi
        if(exec(argv[0],argv)){
  34:	51                   	push   %ecx
  35:	51                   	push   %ecx
  36:	56                   	push   %esi
  37:	ff 73 04             	pushl  0x4(%ebx)
  3a:	e8 aa 03 00 00       	call   3e9 <exec>
  3f:	83 c4 10             	add    $0x10,%esp
  42:	85 c0                	test   %eax,%eax
  44:	75 62                	jne    a8 <main+0xa8>
        printf(1,"Fork Failed");
        exit();
    }


    wait();
  46:	e8 6e 03 00 00       	call   3b9 <wait>
    end_t = uptime();
  4b:	e8 f9 03 00 00       	call   449 <uptime>
    seconds = (end_t - start_t)/1000;
  50:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  53:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  58:	99                   	cltd   
  59:	f7 f9                	idiv   %ecx
    millisec = (end_t - start_t)%1000; 

    if(!argv[1]){
  5b:	83 7e 04 00          	cmpl   $0x0,0x4(%esi)
  5f:	74 34                	je     95 <main+0x95>
        printf(1, "Ran in: %d.%d\n",seconds,millisec);
    }

    else{
        printf(1,"%s ran in: %d.%d\n",argv[0],seconds,millisec);
  61:	83 ec 0c             	sub    $0xc,%esp
  64:	52                   	push   %edx
  65:	50                   	push   %eax
  66:	ff 36                	pushl  (%esi)
  68:	68 10 09 00 00       	push   $0x910
  6d:	6a 01                	push   $0x1
  6f:	e8 0c 05 00 00       	call   580 <printf>
  74:	83 c4 20             	add    $0x20,%esp
            exit();
  77:	e8 35 03 00 00       	call   3b1 <exit>
    if(pid < 0){
  7c:	79 13                	jns    91 <main+0x91>
        printf(1,"Fork Failed");
  7e:	50                   	push   %eax
  7f:	50                   	push   %eax
  80:	68 f5 08 00 00       	push   $0x8f5
  85:	6a 01                	push   $0x1
  87:	e8 f4 04 00 00       	call   580 <printf>
        exit();
  8c:	e8 20 03 00 00       	call   3b1 <exit>
  91:	89 de                	mov    %ebx,%esi
  93:	eb b1                	jmp    46 <main+0x46>
        printf(1, "Ran in: %d.%d\n",seconds,millisec);
  95:	52                   	push   %edx
  96:	50                   	push   %eax
  97:	68 01 09 00 00       	push   $0x901
  9c:	6a 01                	push   $0x1
  9e:	e8 dd 04 00 00       	call   580 <printf>
  a3:	83 c4 10             	add    $0x10,%esp
  a6:	eb cf                	jmp    77 <main+0x77>
            printf(1,"exec failed!");
  a8:	52                   	push   %edx
  a9:	52                   	push   %edx
  aa:	68 e8 08 00 00       	push   $0x8e8
  af:	6a 01                	push   $0x1
  b1:	e8 ca 04 00 00       	call   580 <printf>
            exit();
  b6:	e8 f6 02 00 00       	call   3b1 <exit>
  bb:	66 90                	xchg   %ax,%ax
  bd:	66 90                	xchg   %ax,%ax
  bf:	90                   	nop

000000c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  c0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  c1:	31 d2                	xor    %edx,%edx
{
  c3:	89 e5                	mov    %esp,%ebp
  c5:	53                   	push   %ebx
  c6:	8b 45 08             	mov    0x8(%ebp),%eax
  c9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  d0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
  d4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  d7:	83 c2 01             	add    $0x1,%edx
  da:	84 c9                	test   %cl,%cl
  dc:	75 f2                	jne    d0 <strcpy+0x10>
    ;
  return os;
}
  de:	5b                   	pop    %ebx
  df:	5d                   	pop    %ebp
  e0:	c3                   	ret    
  e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ef:	90                   	nop

000000f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	56                   	push   %esi
  f4:	53                   	push   %ebx
  f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  f8:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(*p && *p == *q)
  fb:	0f b6 13             	movzbl (%ebx),%edx
  fe:	0f b6 0e             	movzbl (%esi),%ecx
 101:	84 d2                	test   %dl,%dl
 103:	74 1e                	je     123 <strcmp+0x33>
 105:	b8 01 00 00 00       	mov    $0x1,%eax
 10a:	38 ca                	cmp    %cl,%dl
 10c:	74 09                	je     117 <strcmp+0x27>
 10e:	eb 20                	jmp    130 <strcmp+0x40>
 110:	83 c0 01             	add    $0x1,%eax
 113:	38 ca                	cmp    %cl,%dl
 115:	75 19                	jne    130 <strcmp+0x40>
 117:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 11b:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
 11f:	84 d2                	test   %dl,%dl
 121:	75 ed                	jne    110 <strcmp+0x20>
 123:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 125:	5b                   	pop    %ebx
 126:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
 127:	29 c8                	sub    %ecx,%eax
}
 129:	5d                   	pop    %ebp
 12a:	c3                   	ret    
 12b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 12f:	90                   	nop
 130:	0f b6 c2             	movzbl %dl,%eax
 133:	5b                   	pop    %ebx
 134:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
 135:	29 c8                	sub    %ecx,%eax
}
 137:	5d                   	pop    %ebp
 138:	c3                   	ret    
 139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000140 <strlen>:

uint
strlen(char *s)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 146:	80 39 00             	cmpb   $0x0,(%ecx)
 149:	74 15                	je     160 <strlen+0x20>
 14b:	31 d2                	xor    %edx,%edx
 14d:	8d 76 00             	lea    0x0(%esi),%esi
 150:	83 c2 01             	add    $0x1,%edx
 153:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 157:	89 d0                	mov    %edx,%eax
 159:	75 f5                	jne    150 <strlen+0x10>
    ;
  return n;
}
 15b:	5d                   	pop    %ebp
 15c:	c3                   	ret    
 15d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 160:	31 c0                	xor    %eax,%eax
}
 162:	5d                   	pop    %ebp
 163:	c3                   	ret    
 164:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 16b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 16f:	90                   	nop

00000170 <memset>:

void*
memset(void *dst, int c, uint n)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	57                   	push   %edi
 174:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 177:	8b 4d 10             	mov    0x10(%ebp),%ecx
 17a:	8b 45 0c             	mov    0xc(%ebp),%eax
 17d:	89 d7                	mov    %edx,%edi
 17f:	fc                   	cld    
 180:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 182:	89 d0                	mov    %edx,%eax
 184:	5f                   	pop    %edi
 185:	5d                   	pop    %ebp
 186:	c3                   	ret    
 187:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18e:	66 90                	xchg   %ax,%ax

00000190 <strchr>:

char*
strchr(const char *s, char c)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	53                   	push   %ebx
 194:	8b 45 08             	mov    0x8(%ebp),%eax
 197:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 19a:	0f b6 18             	movzbl (%eax),%ebx
 19d:	84 db                	test   %bl,%bl
 19f:	74 1d                	je     1be <strchr+0x2e>
 1a1:	89 d1                	mov    %edx,%ecx
    if(*s == c)
 1a3:	38 d3                	cmp    %dl,%bl
 1a5:	75 0d                	jne    1b4 <strchr+0x24>
 1a7:	eb 17                	jmp    1c0 <strchr+0x30>
 1a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1b0:	38 ca                	cmp    %cl,%dl
 1b2:	74 0c                	je     1c0 <strchr+0x30>
  for(; *s; s++)
 1b4:	83 c0 01             	add    $0x1,%eax
 1b7:	0f b6 10             	movzbl (%eax),%edx
 1ba:	84 d2                	test   %dl,%dl
 1bc:	75 f2                	jne    1b0 <strchr+0x20>
      return (char*)s;
  return 0;
 1be:	31 c0                	xor    %eax,%eax
}
 1c0:	5b                   	pop    %ebx
 1c1:	5d                   	pop    %ebp
 1c2:	c3                   	ret    
 1c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001d0 <gets>:

char*
gets(char *buf, int max)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	57                   	push   %edi
 1d4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d5:	31 f6                	xor    %esi,%esi
{
 1d7:	53                   	push   %ebx
 1d8:	89 f3                	mov    %esi,%ebx
 1da:	83 ec 1c             	sub    $0x1c,%esp
 1dd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 1e0:	eb 2f                	jmp    211 <gets+0x41>
 1e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 1e8:	83 ec 04             	sub    $0x4,%esp
 1eb:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1ee:	6a 01                	push   $0x1
 1f0:	50                   	push   %eax
 1f1:	6a 00                	push   $0x0
 1f3:	e8 d1 01 00 00       	call   3c9 <read>
    if(cc < 1)
 1f8:	83 c4 10             	add    $0x10,%esp
 1fb:	85 c0                	test   %eax,%eax
 1fd:	7e 1c                	jle    21b <gets+0x4b>
      break;
    buf[i++] = c;
 1ff:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 203:	83 c7 01             	add    $0x1,%edi
 206:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 209:	3c 0a                	cmp    $0xa,%al
 20b:	74 23                	je     230 <gets+0x60>
 20d:	3c 0d                	cmp    $0xd,%al
 20f:	74 1f                	je     230 <gets+0x60>
  for(i=0; i+1 < max; ){
 211:	83 c3 01             	add    $0x1,%ebx
 214:	89 fe                	mov    %edi,%esi
 216:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 219:	7c cd                	jl     1e8 <gets+0x18>
 21b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 21d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 220:	c6 03 00             	movb   $0x0,(%ebx)
}
 223:	8d 65 f4             	lea    -0xc(%ebp),%esp
 226:	5b                   	pop    %ebx
 227:	5e                   	pop    %esi
 228:	5f                   	pop    %edi
 229:	5d                   	pop    %ebp
 22a:	c3                   	ret    
 22b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 22f:	90                   	nop
 230:	8b 75 08             	mov    0x8(%ebp),%esi
 233:	8b 45 08             	mov    0x8(%ebp),%eax
 236:	01 de                	add    %ebx,%esi
 238:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 23a:	c6 03 00             	movb   $0x0,(%ebx)
}
 23d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 240:	5b                   	pop    %ebx
 241:	5e                   	pop    %esi
 242:	5f                   	pop    %edi
 243:	5d                   	pop    %ebp
 244:	c3                   	ret    
 245:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 24c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000250 <stat>:

int
stat(char *n, struct stat *st)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	56                   	push   %esi
 254:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 255:	83 ec 08             	sub    $0x8,%esp
 258:	6a 00                	push   $0x0
 25a:	ff 75 08             	pushl  0x8(%ebp)
 25d:	e8 8f 01 00 00       	call   3f1 <open>
  if(fd < 0)
 262:	83 c4 10             	add    $0x10,%esp
 265:	85 c0                	test   %eax,%eax
 267:	78 27                	js     290 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 269:	83 ec 08             	sub    $0x8,%esp
 26c:	ff 75 0c             	pushl  0xc(%ebp)
 26f:	89 c3                	mov    %eax,%ebx
 271:	50                   	push   %eax
 272:	e8 92 01 00 00       	call   409 <fstat>
  close(fd);
 277:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 27a:	89 c6                	mov    %eax,%esi
  close(fd);
 27c:	e8 58 01 00 00       	call   3d9 <close>
  return r;
 281:	83 c4 10             	add    $0x10,%esp
}
 284:	8d 65 f8             	lea    -0x8(%ebp),%esp
 287:	89 f0                	mov    %esi,%eax
 289:	5b                   	pop    %ebx
 28a:	5e                   	pop    %esi
 28b:	5d                   	pop    %ebp
 28c:	c3                   	ret    
 28d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 290:	be ff ff ff ff       	mov    $0xffffffff,%esi
 295:	eb ed                	jmp    284 <stat+0x34>
 297:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 29e:	66 90                	xchg   %ax,%ax

000002a0 <atoi>:

#ifdef PDX_XV6
int
atoi(const char *s)
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
 2ae:	75 0b                	jne    2bb <atoi+0x1b>
 2b0:	83 c2 01             	add    $0x1,%edx
 2b3:	0f b6 0a             	movzbl (%edx),%ecx
 2b6:	80 f9 20             	cmp    $0x20,%cl
 2b9:	74 f5                	je     2b0 <atoi+0x10>
  sign = (*s == '-') ? -1 : 1;
 2bb:	80 f9 2d             	cmp    $0x2d,%cl
 2be:	74 40                	je     300 <atoi+0x60>
 2c0:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 2c5:	80 f9 2b             	cmp    $0x2b,%cl
 2c8:	74 3b                	je     305 <atoi+0x65>
    s++;
  while('0' <= *s && *s <= '9')
 2ca:	0f be 0a             	movsbl (%edx),%ecx
 2cd:	8d 41 d0             	lea    -0x30(%ecx),%eax
 2d0:	3c 09                	cmp    $0x9,%al
 2d2:	b8 00 00 00 00       	mov    $0x0,%eax
 2d7:	77 1f                	ja     2f8 <atoi+0x58>
 2d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 2e0:	83 c2 01             	add    $0x1,%edx
 2e3:	8d 04 80             	lea    (%eax,%eax,4),%eax
 2e6:	8d 44 41 d0          	lea    -0x30(%ecx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 2ea:	0f be 0a             	movsbl (%edx),%ecx
 2ed:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 2f0:	80 fb 09             	cmp    $0x9,%bl
 2f3:	76 eb                	jbe    2e0 <atoi+0x40>
 2f5:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 2f8:	5b                   	pop    %ebx
 2f9:	5e                   	pop    %esi
 2fa:	5d                   	pop    %ebp
 2fb:	c3                   	ret    
 2fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 300:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 305:	83 c2 01             	add    $0x1,%edx
 308:	eb c0                	jmp    2ca <atoi+0x2a>
 30a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000310 <atoo>:

int
atoo(const char *s)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	56                   	push   %esi
 314:	8b 55 08             	mov    0x8(%ebp),%edx
 317:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 318:	0f b6 0a             	movzbl (%edx),%ecx
 31b:	80 f9 20             	cmp    $0x20,%cl
 31e:	75 0b                	jne    32b <atoo+0x1b>
 320:	83 c2 01             	add    $0x1,%edx
 323:	0f b6 0a             	movzbl (%edx),%ecx
 326:	80 f9 20             	cmp    $0x20,%cl
 329:	74 f5                	je     320 <atoo+0x10>
  sign = (*s == '-') ? -1 : 1;
 32b:	80 f9 2d             	cmp    $0x2d,%cl
 32e:	74 40                	je     370 <atoo+0x60>
 330:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 335:	80 f9 2b             	cmp    $0x2b,%cl
 338:	74 3b                	je     375 <atoo+0x65>
    s++;
  while('0' <= *s && *s <= '7')
 33a:	0f be 0a             	movsbl (%edx),%ecx
 33d:	8d 41 d0             	lea    -0x30(%ecx),%eax
 340:	3c 07                	cmp    $0x7,%al
 342:	b8 00 00 00 00       	mov    $0x0,%eax
 347:	77 1c                	ja     365 <atoo+0x55>
 349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*8 + *s++ - '0';
 350:	83 c2 01             	add    $0x1,%edx
 353:	8d 44 c1 d0          	lea    -0x30(%ecx,%eax,8),%eax
  while('0' <= *s && *s <= '7')
 357:	0f be 0a             	movsbl (%edx),%ecx
 35a:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 35d:	80 fb 07             	cmp    $0x7,%bl
 360:	76 ee                	jbe    350 <atoo+0x40>
 362:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 365:	5b                   	pop    %ebx
 366:	5e                   	pop    %esi
 367:	5d                   	pop    %ebp
 368:	c3                   	ret    
 369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 370:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 375:	83 c2 01             	add    $0x1,%edx
 378:	eb c0                	jmp    33a <atoo+0x2a>
 37a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000380 <memmove>:
}
#endif // PDX_XV6

void*
memmove(void *vdst, void *vsrc, int n)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	8b 55 10             	mov    0x10(%ebp),%edx
 387:	8b 45 08             	mov    0x8(%ebp),%eax
 38a:	56                   	push   %esi
 38b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 38e:	85 d2                	test   %edx,%edx
 390:	7e 13                	jle    3a5 <memmove+0x25>
 392:	01 c2                	add    %eax,%edx
  dst = vdst;
 394:	89 c7                	mov    %eax,%edi
 396:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 39d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 3a0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3a1:	39 fa                	cmp    %edi,%edx
 3a3:	75 fb                	jne    3a0 <memmove+0x20>
  return vdst;
}
 3a5:	5e                   	pop    %esi
 3a6:	5f                   	pop    %edi
 3a7:	5d                   	pop    %ebp
 3a8:	c3                   	ret    

000003a9 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3a9:	b8 01 00 00 00       	mov    $0x1,%eax
 3ae:	cd 40                	int    $0x40
 3b0:	c3                   	ret    

000003b1 <exit>:
SYSCALL(exit)
 3b1:	b8 02 00 00 00       	mov    $0x2,%eax
 3b6:	cd 40                	int    $0x40
 3b8:	c3                   	ret    

000003b9 <wait>:
SYSCALL(wait)
 3b9:	b8 03 00 00 00       	mov    $0x3,%eax
 3be:	cd 40                	int    $0x40
 3c0:	c3                   	ret    

000003c1 <pipe>:
SYSCALL(pipe)
 3c1:	b8 04 00 00 00       	mov    $0x4,%eax
 3c6:	cd 40                	int    $0x40
 3c8:	c3                   	ret    

000003c9 <read>:
SYSCALL(read)
 3c9:	b8 05 00 00 00       	mov    $0x5,%eax
 3ce:	cd 40                	int    $0x40
 3d0:	c3                   	ret    

000003d1 <write>:
SYSCALL(write)
 3d1:	b8 10 00 00 00       	mov    $0x10,%eax
 3d6:	cd 40                	int    $0x40
 3d8:	c3                   	ret    

000003d9 <close>:
SYSCALL(close)
 3d9:	b8 15 00 00 00       	mov    $0x15,%eax
 3de:	cd 40                	int    $0x40
 3e0:	c3                   	ret    

000003e1 <kill>:
SYSCALL(kill)
 3e1:	b8 06 00 00 00       	mov    $0x6,%eax
 3e6:	cd 40                	int    $0x40
 3e8:	c3                   	ret    

000003e9 <exec>:
SYSCALL(exec)
 3e9:	b8 07 00 00 00       	mov    $0x7,%eax
 3ee:	cd 40                	int    $0x40
 3f0:	c3                   	ret    

000003f1 <open>:
SYSCALL(open)
 3f1:	b8 0f 00 00 00       	mov    $0xf,%eax
 3f6:	cd 40                	int    $0x40
 3f8:	c3                   	ret    

000003f9 <mknod>:
SYSCALL(mknod)
 3f9:	b8 11 00 00 00       	mov    $0x11,%eax
 3fe:	cd 40                	int    $0x40
 400:	c3                   	ret    

00000401 <unlink>:
SYSCALL(unlink)
 401:	b8 12 00 00 00       	mov    $0x12,%eax
 406:	cd 40                	int    $0x40
 408:	c3                   	ret    

00000409 <fstat>:
SYSCALL(fstat)
 409:	b8 08 00 00 00       	mov    $0x8,%eax
 40e:	cd 40                	int    $0x40
 410:	c3                   	ret    

00000411 <link>:
SYSCALL(link)
 411:	b8 13 00 00 00       	mov    $0x13,%eax
 416:	cd 40                	int    $0x40
 418:	c3                   	ret    

00000419 <mkdir>:
SYSCALL(mkdir)
 419:	b8 14 00 00 00       	mov    $0x14,%eax
 41e:	cd 40                	int    $0x40
 420:	c3                   	ret    

00000421 <chdir>:
SYSCALL(chdir)
 421:	b8 09 00 00 00       	mov    $0x9,%eax
 426:	cd 40                	int    $0x40
 428:	c3                   	ret    

00000429 <dup>:
SYSCALL(dup)
 429:	b8 0a 00 00 00       	mov    $0xa,%eax
 42e:	cd 40                	int    $0x40
 430:	c3                   	ret    

00000431 <getpid>:
SYSCALL(getpid)
 431:	b8 0b 00 00 00       	mov    $0xb,%eax
 436:	cd 40                	int    $0x40
 438:	c3                   	ret    

00000439 <sbrk>:
SYSCALL(sbrk)
 439:	b8 0c 00 00 00       	mov    $0xc,%eax
 43e:	cd 40                	int    $0x40
 440:	c3                   	ret    

00000441 <sleep>:
SYSCALL(sleep)
 441:	b8 0d 00 00 00       	mov    $0xd,%eax
 446:	cd 40                	int    $0x40
 448:	c3                   	ret    

00000449 <uptime>:
SYSCALL(uptime)
 449:	b8 0e 00 00 00       	mov    $0xe,%eax
 44e:	cd 40                	int    $0x40
 450:	c3                   	ret    

00000451 <halt>:
SYSCALL(halt)
 451:	b8 16 00 00 00       	mov    $0x16,%eax
 456:	cd 40                	int    $0x40
 458:	c3                   	ret    

00000459 <date>:
SYSCALL(date)
 459:	b8 17 00 00 00       	mov    $0x17,%eax
 45e:	cd 40                	int    $0x40
 460:	c3                   	ret    

00000461 <getgid>:
SYSCALL(getgid)
 461:	b8 18 00 00 00       	mov    $0x18,%eax
 466:	cd 40                	int    $0x40
 468:	c3                   	ret    

00000469 <setgid>:
SYSCALL(setgid)
 469:	b8 19 00 00 00       	mov    $0x19,%eax
 46e:	cd 40                	int    $0x40
 470:	c3                   	ret    

00000471 <getuid>:
SYSCALL(getuid)
 471:	b8 1a 00 00 00       	mov    $0x1a,%eax
 476:	cd 40                	int    $0x40
 478:	c3                   	ret    

00000479 <setuid>:
SYSCALL(setuid)
 479:	b8 1b 00 00 00       	mov    $0x1b,%eax
 47e:	cd 40                	int    $0x40
 480:	c3                   	ret    

00000481 <getppid>:
SYSCALL(getppid)
 481:	b8 1c 00 00 00       	mov    $0x1c,%eax
 486:	cd 40                	int    $0x40
 488:	c3                   	ret    

00000489 <getprocs>:
SYSCALL(getprocs)
 489:	b8 1d 00 00 00       	mov    $0x1d,%eax
 48e:	cd 40                	int    $0x40
 490:	c3                   	ret    

00000491 <setpriority>:
SYSCALL(setpriority)
 491:	b8 1e 00 00 00       	mov    $0x1e,%eax
 496:	cd 40                	int    $0x40
 498:	c3                   	ret    

00000499 <getpriority>:
SYSCALL(getpriority)
 499:	b8 1f 00 00 00       	mov    $0x1f,%eax
 49e:	cd 40                	int    $0x40
 4a0:	c3                   	ret    

000004a1 <chmod>:
SYSCALL(chmod)
 4a1:	b8 20 00 00 00       	mov    $0x20,%eax
 4a6:	cd 40                	int    $0x40
 4a8:	c3                   	ret    

000004a9 <chown>:
SYSCALL(chown)
 4a9:	b8 21 00 00 00       	mov    $0x21,%eax
 4ae:	cd 40                	int    $0x40
 4b0:	c3                   	ret    

000004b1 <chgrp>:
SYSCALL(chgrp)
 4b1:	b8 22 00 00 00       	mov    $0x22,%eax
 4b6:	cd 40                	int    $0x40
 4b8:	c3                   	ret    
 4b9:	66 90                	xchg   %ax,%ax
 4bb:	66 90                	xchg   %ax,%ax
 4bd:	66 90                	xchg   %ax,%ax
 4bf:	90                   	nop

000004c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	53                   	push   %ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4c6:	89 d3                	mov    %edx,%ebx
{
 4c8:	83 ec 3c             	sub    $0x3c,%esp
 4cb:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 4ce:	85 d2                	test   %edx,%edx
 4d0:	0f 89 92 00 00 00    	jns    568 <printint+0xa8>
 4d6:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4da:	0f 84 88 00 00 00    	je     568 <printint+0xa8>
    neg = 1;
 4e0:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 4e7:	f7 db                	neg    %ebx
  } else {
    x = xx;
  }

  i = 0;
 4e9:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 4f0:	8d 75 d7             	lea    -0x29(%ebp),%esi
 4f3:	eb 08                	jmp    4fd <printint+0x3d>
 4f5:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4f8:	89 7d c4             	mov    %edi,-0x3c(%ebp)
  }while((x /= base) != 0);
 4fb:	89 c3                	mov    %eax,%ebx
    buf[i++] = digits[x % base];
 4fd:	89 d8                	mov    %ebx,%eax
 4ff:	31 d2                	xor    %edx,%edx
 501:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 504:	f7 f1                	div    %ecx
 506:	83 c7 01             	add    $0x1,%edi
 509:	0f b6 92 2c 09 00 00 	movzbl 0x92c(%edx),%edx
 510:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 513:	39 d9                	cmp    %ebx,%ecx
 515:	76 e1                	jbe    4f8 <printint+0x38>
  if(neg)
 517:	8b 45 c0             	mov    -0x40(%ebp),%eax
 51a:	85 c0                	test   %eax,%eax
 51c:	74 0d                	je     52b <printint+0x6b>
    buf[i++] = '-';
 51e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 523:	ba 2d 00 00 00       	mov    $0x2d,%edx
    buf[i++] = digits[x % base];
 528:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 52b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 52e:	8b 7d bc             	mov    -0x44(%ebp),%edi
 531:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 535:	eb 0f                	jmp    546 <printint+0x86>
 537:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 53e:	66 90                	xchg   %ax,%ax
 540:	0f b6 13             	movzbl (%ebx),%edx
 543:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 546:	83 ec 04             	sub    $0x4,%esp
 549:	88 55 d7             	mov    %dl,-0x29(%ebp)
 54c:	6a 01                	push   $0x1
 54e:	56                   	push   %esi
 54f:	57                   	push   %edi
 550:	e8 7c fe ff ff       	call   3d1 <write>

  while(--i >= 0)
 555:	83 c4 10             	add    $0x10,%esp
 558:	39 de                	cmp    %ebx,%esi
 55a:	75 e4                	jne    540 <printint+0x80>
    putc(fd, buf[i]);
}
 55c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 55f:	5b                   	pop    %ebx
 560:	5e                   	pop    %esi
 561:	5f                   	pop    %edi
 562:	5d                   	pop    %ebp
 563:	c3                   	ret    
 564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 568:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 56f:	e9 75 ff ff ff       	jmp    4e9 <printint+0x29>
 574:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 57b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 57f:	90                   	nop

00000580 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	57                   	push   %edi
 584:	56                   	push   %esi
 585:	53                   	push   %ebx
 586:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 589:	8b 75 0c             	mov    0xc(%ebp),%esi
 58c:	0f b6 1e             	movzbl (%esi),%ebx
 58f:	84 db                	test   %bl,%bl
 591:	0f 84 b9 00 00 00    	je     650 <printf+0xd0>
  ap = (uint*)(void*)&fmt + 1;
 597:	8d 45 10             	lea    0x10(%ebp),%eax
 59a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 59d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 5a0:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 5a2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5a5:	eb 38                	jmp    5df <printf+0x5f>
 5a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ae:	66 90                	xchg   %ax,%ax
 5b0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 5b3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 5b8:	83 f8 25             	cmp    $0x25,%eax
 5bb:	74 17                	je     5d4 <printf+0x54>
  write(fd, &c, 1);
 5bd:	83 ec 04             	sub    $0x4,%esp
 5c0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5c3:	6a 01                	push   $0x1
 5c5:	57                   	push   %edi
 5c6:	ff 75 08             	pushl  0x8(%ebp)
 5c9:	e8 03 fe ff ff       	call   3d1 <write>
 5ce:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 5d1:	83 c4 10             	add    $0x10,%esp
 5d4:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 5d7:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 5db:	84 db                	test   %bl,%bl
 5dd:	74 71                	je     650 <printf+0xd0>
    c = fmt[i] & 0xff;
 5df:	0f be cb             	movsbl %bl,%ecx
 5e2:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5e5:	85 d2                	test   %edx,%edx
 5e7:	74 c7                	je     5b0 <printf+0x30>
      }
    } else if(state == '%'){
 5e9:	83 fa 25             	cmp    $0x25,%edx
 5ec:	75 e6                	jne    5d4 <printf+0x54>
      if(c == 'd'){
 5ee:	83 f8 64             	cmp    $0x64,%eax
 5f1:	0f 84 99 00 00 00    	je     690 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5f7:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 5fd:	83 f9 70             	cmp    $0x70,%ecx
 600:	74 5e                	je     660 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 602:	83 f8 73             	cmp    $0x73,%eax
 605:	0f 84 d5 00 00 00    	je     6e0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 60b:	83 f8 63             	cmp    $0x63,%eax
 60e:	0f 84 8c 00 00 00    	je     6a0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 614:	83 f8 25             	cmp    $0x25,%eax
 617:	0f 84 b3 00 00 00    	je     6d0 <printf+0x150>
  write(fd, &c, 1);
 61d:	83 ec 04             	sub    $0x4,%esp
 620:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 624:	6a 01                	push   $0x1
 626:	57                   	push   %edi
 627:	ff 75 08             	pushl  0x8(%ebp)
 62a:	e8 a2 fd ff ff       	call   3d1 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 62f:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 632:	83 c4 0c             	add    $0xc,%esp
 635:	6a 01                	push   $0x1
 637:	83 c6 01             	add    $0x1,%esi
 63a:	57                   	push   %edi
 63b:	ff 75 08             	pushl  0x8(%ebp)
 63e:	e8 8e fd ff ff       	call   3d1 <write>
  for(i = 0; fmt[i]; i++){
 643:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 647:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 64a:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 64c:	84 db                	test   %bl,%bl
 64e:	75 8f                	jne    5df <printf+0x5f>
    }
  }
}
 650:	8d 65 f4             	lea    -0xc(%ebp),%esp
 653:	5b                   	pop    %ebx
 654:	5e                   	pop    %esi
 655:	5f                   	pop    %edi
 656:	5d                   	pop    %ebp
 657:	c3                   	ret    
 658:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 65f:	90                   	nop
        printint(fd, *ap, 16, 0);
 660:	83 ec 0c             	sub    $0xc,%esp
 663:	b9 10 00 00 00       	mov    $0x10,%ecx
 668:	6a 00                	push   $0x0
 66a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 66d:	8b 45 08             	mov    0x8(%ebp),%eax
 670:	8b 13                	mov    (%ebx),%edx
 672:	e8 49 fe ff ff       	call   4c0 <printint>
        ap++;
 677:	89 d8                	mov    %ebx,%eax
 679:	83 c4 10             	add    $0x10,%esp
      state = 0;
 67c:	31 d2                	xor    %edx,%edx
        ap++;
 67e:	83 c0 04             	add    $0x4,%eax
 681:	89 45 d0             	mov    %eax,-0x30(%ebp)
 684:	e9 4b ff ff ff       	jmp    5d4 <printf+0x54>
 689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 690:	83 ec 0c             	sub    $0xc,%esp
 693:	b9 0a 00 00 00       	mov    $0xa,%ecx
 698:	6a 01                	push   $0x1
 69a:	eb ce                	jmp    66a <printf+0xea>
 69c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 6a0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 6a3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 6a6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 6a8:	6a 01                	push   $0x1
        ap++;
 6aa:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 6ad:	57                   	push   %edi
 6ae:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 6b1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6b4:	e8 18 fd ff ff       	call   3d1 <write>
        ap++;
 6b9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6bc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6bf:	31 d2                	xor    %edx,%edx
 6c1:	e9 0e ff ff ff       	jmp    5d4 <printf+0x54>
 6c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6cd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 6d0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 6d3:	83 ec 04             	sub    $0x4,%esp
 6d6:	e9 5a ff ff ff       	jmp    635 <printf+0xb5>
 6db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6df:	90                   	nop
        s = (char*)*ap;
 6e0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6e3:	8b 18                	mov    (%eax),%ebx
        ap++;
 6e5:	83 c0 04             	add    $0x4,%eax
 6e8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 6eb:	85 db                	test   %ebx,%ebx
 6ed:	74 17                	je     706 <printf+0x186>
        while(*s != 0){
 6ef:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 6f2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 6f4:	84 c0                	test   %al,%al
 6f6:	0f 84 d8 fe ff ff    	je     5d4 <printf+0x54>
 6fc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6ff:	89 de                	mov    %ebx,%esi
 701:	8b 5d 08             	mov    0x8(%ebp),%ebx
 704:	eb 1a                	jmp    720 <printf+0x1a0>
          s = "(null)";
 706:	bb 22 09 00 00       	mov    $0x922,%ebx
        while(*s != 0){
 70b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 70e:	b8 28 00 00 00       	mov    $0x28,%eax
 713:	89 de                	mov    %ebx,%esi
 715:	8b 5d 08             	mov    0x8(%ebp),%ebx
 718:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 71f:	90                   	nop
  write(fd, &c, 1);
 720:	83 ec 04             	sub    $0x4,%esp
          s++;
 723:	83 c6 01             	add    $0x1,%esi
 726:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 729:	6a 01                	push   $0x1
 72b:	57                   	push   %edi
 72c:	53                   	push   %ebx
 72d:	e8 9f fc ff ff       	call   3d1 <write>
        while(*s != 0){
 732:	0f b6 06             	movzbl (%esi),%eax
 735:	83 c4 10             	add    $0x10,%esp
 738:	84 c0                	test   %al,%al
 73a:	75 e4                	jne    720 <printf+0x1a0>
 73c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 73f:	31 d2                	xor    %edx,%edx
 741:	e9 8e fe ff ff       	jmp    5d4 <printf+0x54>
 746:	66 90                	xchg   %ax,%ax
 748:	66 90                	xchg   %ax,%ax
 74a:	66 90                	xchg   %ax,%ax
 74c:	66 90                	xchg   %ax,%ax
 74e:	66 90                	xchg   %ax,%ax

00000750 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 750:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 751:	a1 14 0c 00 00       	mov    0xc14,%eax
{
 756:	89 e5                	mov    %esp,%ebp
 758:	57                   	push   %edi
 759:	56                   	push   %esi
 75a:	53                   	push   %ebx
 75b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 75e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 760:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 763:	39 c8                	cmp    %ecx,%eax
 765:	73 19                	jae    780 <free+0x30>
 767:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 76e:	66 90                	xchg   %ax,%ax
 770:	39 d1                	cmp    %edx,%ecx
 772:	72 14                	jb     788 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 774:	39 d0                	cmp    %edx,%eax
 776:	73 10                	jae    788 <free+0x38>
{
 778:	89 d0                	mov    %edx,%eax
 77a:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 77c:	39 c8                	cmp    %ecx,%eax
 77e:	72 f0                	jb     770 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 780:	39 d0                	cmp    %edx,%eax
 782:	72 f4                	jb     778 <free+0x28>
 784:	39 d1                	cmp    %edx,%ecx
 786:	73 f0                	jae    778 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 788:	8b 73 fc             	mov    -0x4(%ebx),%esi
 78b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 78e:	39 fa                	cmp    %edi,%edx
 790:	74 1e                	je     7b0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 792:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 795:	8b 50 04             	mov    0x4(%eax),%edx
 798:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 79b:	39 f1                	cmp    %esi,%ecx
 79d:	74 28                	je     7c7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 79f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 7a1:	5b                   	pop    %ebx
  freep = p;
 7a2:	a3 14 0c 00 00       	mov    %eax,0xc14
}
 7a7:	5e                   	pop    %esi
 7a8:	5f                   	pop    %edi
 7a9:	5d                   	pop    %ebp
 7aa:	c3                   	ret    
 7ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7af:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 7b0:	03 72 04             	add    0x4(%edx),%esi
 7b3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7b6:	8b 10                	mov    (%eax),%edx
 7b8:	8b 12                	mov    (%edx),%edx
 7ba:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7bd:	8b 50 04             	mov    0x4(%eax),%edx
 7c0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7c3:	39 f1                	cmp    %esi,%ecx
 7c5:	75 d8                	jne    79f <free+0x4f>
    p->s.size += bp->s.size;
 7c7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 7ca:	a3 14 0c 00 00       	mov    %eax,0xc14
    p->s.size += bp->s.size;
 7cf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7d2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7d5:	89 10                	mov    %edx,(%eax)
}
 7d7:	5b                   	pop    %ebx
 7d8:	5e                   	pop    %esi
 7d9:	5f                   	pop    %edi
 7da:	5d                   	pop    %ebp
 7db:	c3                   	ret    
 7dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7e0:	55                   	push   %ebp
 7e1:	89 e5                	mov    %esp,%ebp
 7e3:	57                   	push   %edi
 7e4:	56                   	push   %esi
 7e5:	53                   	push   %ebx
 7e6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7ec:	8b 3d 14 0c 00 00    	mov    0xc14,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f2:	8d 70 07             	lea    0x7(%eax),%esi
 7f5:	c1 ee 03             	shr    $0x3,%esi
 7f8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 7fb:	85 ff                	test   %edi,%edi
 7fd:	0f 84 ad 00 00 00    	je     8b0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 803:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 805:	8b 4a 04             	mov    0x4(%edx),%ecx
 808:	39 f1                	cmp    %esi,%ecx
 80a:	73 72                	jae    87e <malloc+0x9e>
 80c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 812:	bb 00 10 00 00       	mov    $0x1000,%ebx
 817:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 81a:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 821:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 824:	eb 1b                	jmp    841 <malloc+0x61>
 826:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 82d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 830:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 832:	8b 48 04             	mov    0x4(%eax),%ecx
 835:	39 f1                	cmp    %esi,%ecx
 837:	73 4f                	jae    888 <malloc+0xa8>
 839:	8b 3d 14 0c 00 00    	mov    0xc14,%edi
 83f:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 841:	39 d7                	cmp    %edx,%edi
 843:	75 eb                	jne    830 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 845:	83 ec 0c             	sub    $0xc,%esp
 848:	ff 75 e4             	pushl  -0x1c(%ebp)
 84b:	e8 e9 fb ff ff       	call   439 <sbrk>
  if(p == (char*)-1)
 850:	83 c4 10             	add    $0x10,%esp
 853:	83 f8 ff             	cmp    $0xffffffff,%eax
 856:	74 1c                	je     874 <malloc+0x94>
  hp->s.size = nu;
 858:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 85b:	83 ec 0c             	sub    $0xc,%esp
 85e:	83 c0 08             	add    $0x8,%eax
 861:	50                   	push   %eax
 862:	e8 e9 fe ff ff       	call   750 <free>
  return freep;
 867:	8b 15 14 0c 00 00    	mov    0xc14,%edx
      if((p = morecore(nunits)) == 0)
 86d:	83 c4 10             	add    $0x10,%esp
 870:	85 d2                	test   %edx,%edx
 872:	75 bc                	jne    830 <malloc+0x50>
        return 0;
  }
}
 874:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 877:	31 c0                	xor    %eax,%eax
}
 879:	5b                   	pop    %ebx
 87a:	5e                   	pop    %esi
 87b:	5f                   	pop    %edi
 87c:	5d                   	pop    %ebp
 87d:	c3                   	ret    
    if(p->s.size >= nunits){
 87e:	89 d0                	mov    %edx,%eax
 880:	89 fa                	mov    %edi,%edx
 882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 888:	39 ce                	cmp    %ecx,%esi
 88a:	74 54                	je     8e0 <malloc+0x100>
        p->s.size -= nunits;
 88c:	29 f1                	sub    %esi,%ecx
 88e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 891:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 894:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 897:	89 15 14 0c 00 00    	mov    %edx,0xc14
}
 89d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 8a0:	83 c0 08             	add    $0x8,%eax
}
 8a3:	5b                   	pop    %ebx
 8a4:	5e                   	pop    %esi
 8a5:	5f                   	pop    %edi
 8a6:	5d                   	pop    %ebp
 8a7:	c3                   	ret    
 8a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8af:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 8b0:	c7 05 14 0c 00 00 18 	movl   $0xc18,0xc14
 8b7:	0c 00 00 
    base.s.size = 0;
 8ba:	bf 18 0c 00 00       	mov    $0xc18,%edi
    base.s.ptr = freep = prevp = &base;
 8bf:	c7 05 18 0c 00 00 18 	movl   $0xc18,0xc18
 8c6:	0c 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 8cb:	c7 05 1c 0c 00 00 00 	movl   $0x0,0xc1c
 8d2:	00 00 00 
    if(p->s.size >= nunits){
 8d5:	e9 32 ff ff ff       	jmp    80c <malloc+0x2c>
 8da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 8e0:	8b 08                	mov    (%eax),%ecx
 8e2:	89 0a                	mov    %ecx,(%edx)
 8e4:	eb b1                	jmp    897 <malloc+0xb7>
