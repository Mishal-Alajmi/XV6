
_ps:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "uproc.h"

#define STR_MAX 16

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
  11:	83 ec 24             	sub    $0x24,%esp
    uint max = STR_MAX;
    uint sec,millisec,cpu_sec,cpu_millisec;
    struct uproc * ptable = malloc(max * sizeof(struct uproc));
  14:	68 00 06 00 00       	push   $0x600
  19:	e8 e2 07 00 00       	call   800 <malloc>
    int count = getprocs(max,ptable);
  1e:	59                   	pop    %ecx
  1f:	5b                   	pop    %ebx
  20:	50                   	push   %eax
    struct uproc * ptable = malloc(max * sizeof(struct uproc));
  21:	89 c7                	mov    %eax,%edi
    int count = getprocs(max,ptable);
  23:	6a 10                	push   $0x10
    struct uproc * ptable = malloc(max * sizeof(struct uproc));
  25:	89 45 dc             	mov    %eax,-0x24(%ebp)
    int count = getprocs(max,ptable);
  28:	e8 7c 04 00 00       	call   4a9 <getprocs>


    printf(1,"\nmax=%d",max);
  2d:	83 c4 0c             	add    $0xc,%esp
  30:	6a 10                	push   $0x10
    int count = getprocs(max,ptable);
  32:	89 c6                	mov    %eax,%esi
    printf(1,"\nmax=%d",max);
  34:	68 08 09 00 00       	push   $0x908
  39:	6a 01                	push   $0x1
  3b:	e8 60 05 00 00       	call   5a0 <printf>

    for(int i=0;i < count;++i){
  40:	83 c4 10             	add    $0x10,%esp
  43:	85 f6                	test   %esi,%esi
  45:	0f 8e 85 00 00 00    	jle    d0 <main+0xd0>
  4b:	8d 04 76             	lea    (%esi,%esi,2),%eax
  4e:	8d 5f 40             	lea    0x40(%edi),%ebx
        sec = ptable[i].elapsed_ticks/1000;
        millisec = ptable[i].elapsed_ticks%1000;

        cpu_sec = ptable[i].CPU_total_ticks/1000;
        cpu_millisec = ptable[i].CPU_total_ticks%1000;
  51:	bf d3 4d 62 10       	mov    $0x10624dd3,%edi
  56:	c1 e0 05             	shl    $0x5,%eax
  59:	01 d8                	add    %ebx,%eax
  5b:	89 45 e0             	mov    %eax,-0x20(%ebp)
  5e:	66 90                	xchg   %ax,%ax

#ifdef CS333_P4
        printf(1,"\nPID\tName\tUID\tGID\tPPID\tPrio\tElapsed\tCPU\tState\tSize\n");
  60:	83 ec 08             	sub    $0x8,%esp
        sec = ptable[i].elapsed_ticks/1000;
  63:	8b 73 d4             	mov    -0x2c(%ebx),%esi
        cpu_sec = ptable[i].CPU_total_ticks/1000;
  66:	8b 4b d8             	mov    -0x28(%ebx),%ecx
        printf(1,"\nPID\tName\tUID\tGID\tPPID\tPrio\tElapsed\tCPU\tState\tSize\n");
  69:	68 10 09 00 00       	push   $0x910
  6e:	6a 01                	push   $0x1
        cpu_sec = ptable[i].CPU_total_ticks/1000;
  70:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
        printf(1,"\nPID\tName\tUID\tGID\tPPID\tPrio\tElapsed\tCPU\tState\tSize\n");
  73:	e8 28 05 00 00       	call   5a0 <printf>
        cpu_millisec = ptable[i].CPU_total_ticks%1000;
  78:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
        printf(1, "%d\t%s\t%d\t%d\t%d\t%d\t%d.%d\t%d.%d\t%s\t%d\n", ptable[i].pid, ptable[i].name, ptable[i].uid, ptable[i].gid, ptable[i].ppid, ptable[i].priority, sec, millisec, cpu_sec, cpu_millisec, ptable[i].state, ptable[i].size);
  7b:	58                   	pop    %eax
  7c:	8d 43 dc             	lea    -0x24(%ebx),%eax
  7f:	5a                   	pop    %edx
  80:	ff 73 fc             	pushl  -0x4(%ebx)
  83:	50                   	push   %eax
        cpu_millisec = ptable[i].CPU_total_ticks%1000;
  84:	89 c8                	mov    %ecx,%eax
  86:	f7 e7                	mul    %edi
  88:	c1 ea 06             	shr    $0x6,%edx
  8b:	69 c2 e8 03 00 00    	imul   $0x3e8,%edx,%eax
  91:	29 c1                	sub    %eax,%ecx
        millisec = ptable[i].elapsed_ticks%1000;
  93:	89 f0                	mov    %esi,%eax
        printf(1, "%d\t%s\t%d\t%d\t%d\t%d\t%d.%d\t%d.%d\t%s\t%d\n", ptable[i].pid, ptable[i].name, ptable[i].uid, ptable[i].gid, ptable[i].ppid, ptable[i].priority, sec, millisec, cpu_sec, cpu_millisec, ptable[i].state, ptable[i].size);
  95:	51                   	push   %ecx
  96:	52                   	push   %edx
        millisec = ptable[i].elapsed_ticks%1000;
  97:	f7 e7                	mul    %edi
  99:	c1 ea 06             	shr    $0x6,%edx
  9c:	69 c2 e8 03 00 00    	imul   $0x3e8,%edx,%eax
  a2:	29 c6                	sub    %eax,%esi
        printf(1, "%d\t%s\t%d\t%d\t%d\t%d\t%d.%d\t%d.%d\t%s\t%d\n", ptable[i].pid, ptable[i].name, ptable[i].uid, ptable[i].gid, ptable[i].ppid, ptable[i].priority, sec, millisec, cpu_sec, cpu_millisec, ptable[i].state, ptable[i].size);
  a4:	56                   	push   %esi
  a5:	52                   	push   %edx
  a6:	ff 73 d0             	pushl  -0x30(%ebx)
  a9:	ff 73 cc             	pushl  -0x34(%ebx)
  ac:	ff 73 c8             	pushl  -0x38(%ebx)
  af:	ff 73 c4             	pushl  -0x3c(%ebx)
  b2:	53                   	push   %ebx
  b3:	83 c3 60             	add    $0x60,%ebx
  b6:	ff b3 60 ff ff ff    	pushl  -0xa0(%ebx)
  bc:	68 44 09 00 00       	push   $0x944
  c1:	6a 01                	push   $0x1
  c3:	e8 d8 04 00 00       	call   5a0 <printf>
    for(int i=0;i < count;++i){
  c8:	83 c4 40             	add    $0x40,%esp
  cb:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  ce:	75 90                	jne    60 <main+0x60>
#elif defined(CS333_P2)
        printf(1,"\nPID\tName\tUID\tGID\tPPID\tElapsed\tCPU\tState\tSize\n");
        printf(1, "%d\t%s\t%d\t%d\t%d\t%d.%d\t%d.%d\t%s\t%d\n", ptable[i].pid, ptable[i].name, ptable[i].uid, ptable[i].gid, ptable[i].ppid, sec, millisec, cpu_sec, cpu_millisec, ptable[i].state, ptable[i].size);
#endif
    }
    free(ptable);
  d0:	83 ec 0c             	sub    $0xc,%esp
  d3:	ff 75 dc             	pushl  -0x24(%ebp)
  d6:	e8 95 06 00 00       	call   770 <free>
    exit();
  db:	e8 f1 02 00 00       	call   3d1 <exit>

000000e0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  e0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  e1:	31 d2                	xor    %edx,%edx
{
  e3:	89 e5                	mov    %esp,%ebp
  e5:	53                   	push   %ebx
  e6:	8b 45 08             	mov    0x8(%ebp),%eax
  e9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  f0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
  f4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  f7:	83 c2 01             	add    $0x1,%edx
  fa:	84 c9                	test   %cl,%cl
  fc:	75 f2                	jne    f0 <strcpy+0x10>
    ;
  return os;
}
  fe:	5b                   	pop    %ebx
  ff:	5d                   	pop    %ebp
 100:	c3                   	ret    
 101:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 108:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 10f:	90                   	nop

00000110 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	56                   	push   %esi
 114:	53                   	push   %ebx
 115:	8b 5d 08             	mov    0x8(%ebp),%ebx
 118:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(*p && *p == *q)
 11b:	0f b6 13             	movzbl (%ebx),%edx
 11e:	0f b6 0e             	movzbl (%esi),%ecx
 121:	84 d2                	test   %dl,%dl
 123:	74 1e                	je     143 <strcmp+0x33>
 125:	b8 01 00 00 00       	mov    $0x1,%eax
 12a:	38 ca                	cmp    %cl,%dl
 12c:	74 09                	je     137 <strcmp+0x27>
 12e:	eb 20                	jmp    150 <strcmp+0x40>
 130:	83 c0 01             	add    $0x1,%eax
 133:	38 ca                	cmp    %cl,%dl
 135:	75 19                	jne    150 <strcmp+0x40>
 137:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 13b:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
 13f:	84 d2                	test   %dl,%dl
 141:	75 ed                	jne    130 <strcmp+0x20>
 143:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 145:	5b                   	pop    %ebx
 146:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
 147:	29 c8                	sub    %ecx,%eax
}
 149:	5d                   	pop    %ebp
 14a:	c3                   	ret    
 14b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 14f:	90                   	nop
 150:	0f b6 c2             	movzbl %dl,%eax
 153:	5b                   	pop    %ebx
 154:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
 155:	29 c8                	sub    %ecx,%eax
}
 157:	5d                   	pop    %ebp
 158:	c3                   	ret    
 159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000160 <strlen>:

uint
strlen(char *s)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 166:	80 39 00             	cmpb   $0x0,(%ecx)
 169:	74 15                	je     180 <strlen+0x20>
 16b:	31 d2                	xor    %edx,%edx
 16d:	8d 76 00             	lea    0x0(%esi),%esi
 170:	83 c2 01             	add    $0x1,%edx
 173:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 177:	89 d0                	mov    %edx,%eax
 179:	75 f5                	jne    170 <strlen+0x10>
    ;
  return n;
}
 17b:	5d                   	pop    %ebp
 17c:	c3                   	ret    
 17d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 180:	31 c0                	xor    %eax,%eax
}
 182:	5d                   	pop    %ebp
 183:	c3                   	ret    
 184:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 18f:	90                   	nop

00000190 <memset>:

void*
memset(void *dst, int c, uint n)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 197:	8b 4d 10             	mov    0x10(%ebp),%ecx
 19a:	8b 45 0c             	mov    0xc(%ebp),%eax
 19d:	89 d7                	mov    %edx,%edi
 19f:	fc                   	cld    
 1a0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1a2:	89 d0                	mov    %edx,%eax
 1a4:	5f                   	pop    %edi
 1a5:	5d                   	pop    %ebp
 1a6:	c3                   	ret    
 1a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ae:	66 90                	xchg   %ax,%ax

000001b0 <strchr>:

char*
strchr(const char *s, char c)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	53                   	push   %ebx
 1b4:	8b 45 08             	mov    0x8(%ebp),%eax
 1b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 1ba:	0f b6 18             	movzbl (%eax),%ebx
 1bd:	84 db                	test   %bl,%bl
 1bf:	74 1d                	je     1de <strchr+0x2e>
 1c1:	89 d1                	mov    %edx,%ecx
    if(*s == c)
 1c3:	38 d3                	cmp    %dl,%bl
 1c5:	75 0d                	jne    1d4 <strchr+0x24>
 1c7:	eb 17                	jmp    1e0 <strchr+0x30>
 1c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1d0:	38 ca                	cmp    %cl,%dl
 1d2:	74 0c                	je     1e0 <strchr+0x30>
  for(; *s; s++)
 1d4:	83 c0 01             	add    $0x1,%eax
 1d7:	0f b6 10             	movzbl (%eax),%edx
 1da:	84 d2                	test   %dl,%dl
 1dc:	75 f2                	jne    1d0 <strchr+0x20>
      return (char*)s;
  return 0;
 1de:	31 c0                	xor    %eax,%eax
}
 1e0:	5b                   	pop    %ebx
 1e1:	5d                   	pop    %ebp
 1e2:	c3                   	ret    
 1e3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001f0 <gets>:

char*
gets(char *buf, int max)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	57                   	push   %edi
 1f4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f5:	31 f6                	xor    %esi,%esi
{
 1f7:	53                   	push   %ebx
 1f8:	89 f3                	mov    %esi,%ebx
 1fa:	83 ec 1c             	sub    $0x1c,%esp
 1fd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 200:	eb 2f                	jmp    231 <gets+0x41>
 202:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 208:	83 ec 04             	sub    $0x4,%esp
 20b:	8d 45 e7             	lea    -0x19(%ebp),%eax
 20e:	6a 01                	push   $0x1
 210:	50                   	push   %eax
 211:	6a 00                	push   $0x0
 213:	e8 d1 01 00 00       	call   3e9 <read>
    if(cc < 1)
 218:	83 c4 10             	add    $0x10,%esp
 21b:	85 c0                	test   %eax,%eax
 21d:	7e 1c                	jle    23b <gets+0x4b>
      break;
    buf[i++] = c;
 21f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 223:	83 c7 01             	add    $0x1,%edi
 226:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 229:	3c 0a                	cmp    $0xa,%al
 22b:	74 23                	je     250 <gets+0x60>
 22d:	3c 0d                	cmp    $0xd,%al
 22f:	74 1f                	je     250 <gets+0x60>
  for(i=0; i+1 < max; ){
 231:	83 c3 01             	add    $0x1,%ebx
 234:	89 fe                	mov    %edi,%esi
 236:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 239:	7c cd                	jl     208 <gets+0x18>
 23b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 23d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 240:	c6 03 00             	movb   $0x0,(%ebx)
}
 243:	8d 65 f4             	lea    -0xc(%ebp),%esp
 246:	5b                   	pop    %ebx
 247:	5e                   	pop    %esi
 248:	5f                   	pop    %edi
 249:	5d                   	pop    %ebp
 24a:	c3                   	ret    
 24b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 24f:	90                   	nop
 250:	8b 75 08             	mov    0x8(%ebp),%esi
 253:	8b 45 08             	mov    0x8(%ebp),%eax
 256:	01 de                	add    %ebx,%esi
 258:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 25a:	c6 03 00             	movb   $0x0,(%ebx)
}
 25d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 260:	5b                   	pop    %ebx
 261:	5e                   	pop    %esi
 262:	5f                   	pop    %edi
 263:	5d                   	pop    %ebp
 264:	c3                   	ret    
 265:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000270 <stat>:

int
stat(char *n, struct stat *st)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	56                   	push   %esi
 274:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 275:	83 ec 08             	sub    $0x8,%esp
 278:	6a 00                	push   $0x0
 27a:	ff 75 08             	pushl  0x8(%ebp)
 27d:	e8 8f 01 00 00       	call   411 <open>
  if(fd < 0)
 282:	83 c4 10             	add    $0x10,%esp
 285:	85 c0                	test   %eax,%eax
 287:	78 27                	js     2b0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 289:	83 ec 08             	sub    $0x8,%esp
 28c:	ff 75 0c             	pushl  0xc(%ebp)
 28f:	89 c3                	mov    %eax,%ebx
 291:	50                   	push   %eax
 292:	e8 92 01 00 00       	call   429 <fstat>
  close(fd);
 297:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 29a:	89 c6                	mov    %eax,%esi
  close(fd);
 29c:	e8 58 01 00 00       	call   3f9 <close>
  return r;
 2a1:	83 c4 10             	add    $0x10,%esp
}
 2a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2a7:	89 f0                	mov    %esi,%eax
 2a9:	5b                   	pop    %ebx
 2aa:	5e                   	pop    %esi
 2ab:	5d                   	pop    %ebp
 2ac:	c3                   	ret    
 2ad:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2b0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2b5:	eb ed                	jmp    2a4 <stat+0x34>
 2b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2be:	66 90                	xchg   %ax,%ax

000002c0 <atoi>:

#ifdef PDX_XV6
int
atoi(const char *s)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	56                   	push   %esi
 2c4:	8b 55 08             	mov    0x8(%ebp),%edx
 2c7:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 2c8:	0f b6 0a             	movzbl (%edx),%ecx
 2cb:	80 f9 20             	cmp    $0x20,%cl
 2ce:	75 0b                	jne    2db <atoi+0x1b>
 2d0:	83 c2 01             	add    $0x1,%edx
 2d3:	0f b6 0a             	movzbl (%edx),%ecx
 2d6:	80 f9 20             	cmp    $0x20,%cl
 2d9:	74 f5                	je     2d0 <atoi+0x10>
  sign = (*s == '-') ? -1 : 1;
 2db:	80 f9 2d             	cmp    $0x2d,%cl
 2de:	74 40                	je     320 <atoi+0x60>
 2e0:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 2e5:	80 f9 2b             	cmp    $0x2b,%cl
 2e8:	74 3b                	je     325 <atoi+0x65>
    s++;
  while('0' <= *s && *s <= '9')
 2ea:	0f be 0a             	movsbl (%edx),%ecx
 2ed:	8d 41 d0             	lea    -0x30(%ecx),%eax
 2f0:	3c 09                	cmp    $0x9,%al
 2f2:	b8 00 00 00 00       	mov    $0x0,%eax
 2f7:	77 1f                	ja     318 <atoi+0x58>
 2f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 300:	83 c2 01             	add    $0x1,%edx
 303:	8d 04 80             	lea    (%eax,%eax,4),%eax
 306:	8d 44 41 d0          	lea    -0x30(%ecx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 30a:	0f be 0a             	movsbl (%edx),%ecx
 30d:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 310:	80 fb 09             	cmp    $0x9,%bl
 313:	76 eb                	jbe    300 <atoi+0x40>
 315:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 318:	5b                   	pop    %ebx
 319:	5e                   	pop    %esi
 31a:	5d                   	pop    %ebp
 31b:	c3                   	ret    
 31c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 320:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 325:	83 c2 01             	add    $0x1,%edx
 328:	eb c0                	jmp    2ea <atoi+0x2a>
 32a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000330 <atoo>:

int
atoo(const char *s)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	56                   	push   %esi
 334:	8b 55 08             	mov    0x8(%ebp),%edx
 337:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 338:	0f b6 0a             	movzbl (%edx),%ecx
 33b:	80 f9 20             	cmp    $0x20,%cl
 33e:	75 0b                	jne    34b <atoo+0x1b>
 340:	83 c2 01             	add    $0x1,%edx
 343:	0f b6 0a             	movzbl (%edx),%ecx
 346:	80 f9 20             	cmp    $0x20,%cl
 349:	74 f5                	je     340 <atoo+0x10>
  sign = (*s == '-') ? -1 : 1;
 34b:	80 f9 2d             	cmp    $0x2d,%cl
 34e:	74 40                	je     390 <atoo+0x60>
 350:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 355:	80 f9 2b             	cmp    $0x2b,%cl
 358:	74 3b                	je     395 <atoo+0x65>
    s++;
  while('0' <= *s && *s <= '7')
 35a:	0f be 0a             	movsbl (%edx),%ecx
 35d:	8d 41 d0             	lea    -0x30(%ecx),%eax
 360:	3c 07                	cmp    $0x7,%al
 362:	b8 00 00 00 00       	mov    $0x0,%eax
 367:	77 1c                	ja     385 <atoo+0x55>
 369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*8 + *s++ - '0';
 370:	83 c2 01             	add    $0x1,%edx
 373:	8d 44 c1 d0          	lea    -0x30(%ecx,%eax,8),%eax
  while('0' <= *s && *s <= '7')
 377:	0f be 0a             	movsbl (%edx),%ecx
 37a:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 37d:	80 fb 07             	cmp    $0x7,%bl
 380:	76 ee                	jbe    370 <atoo+0x40>
 382:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 385:	5b                   	pop    %ebx
 386:	5e                   	pop    %esi
 387:	5d                   	pop    %ebp
 388:	c3                   	ret    
 389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 390:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 395:	83 c2 01             	add    $0x1,%edx
 398:	eb c0                	jmp    35a <atoo+0x2a>
 39a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003a0 <memmove>:
}
#endif // PDX_XV6

void*
memmove(void *vdst, void *vsrc, int n)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	8b 55 10             	mov    0x10(%ebp),%edx
 3a7:	8b 45 08             	mov    0x8(%ebp),%eax
 3aa:	56                   	push   %esi
 3ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3ae:	85 d2                	test   %edx,%edx
 3b0:	7e 13                	jle    3c5 <memmove+0x25>
 3b2:	01 c2                	add    %eax,%edx
  dst = vdst;
 3b4:	89 c7                	mov    %eax,%edi
 3b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3bd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 3c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3c1:	39 fa                	cmp    %edi,%edx
 3c3:	75 fb                	jne    3c0 <memmove+0x20>
  return vdst;
}
 3c5:	5e                   	pop    %esi
 3c6:	5f                   	pop    %edi
 3c7:	5d                   	pop    %ebp
 3c8:	c3                   	ret    

000003c9 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3c9:	b8 01 00 00 00       	mov    $0x1,%eax
 3ce:	cd 40                	int    $0x40
 3d0:	c3                   	ret    

000003d1 <exit>:
SYSCALL(exit)
 3d1:	b8 02 00 00 00       	mov    $0x2,%eax
 3d6:	cd 40                	int    $0x40
 3d8:	c3                   	ret    

000003d9 <wait>:
SYSCALL(wait)
 3d9:	b8 03 00 00 00       	mov    $0x3,%eax
 3de:	cd 40                	int    $0x40
 3e0:	c3                   	ret    

000003e1 <pipe>:
SYSCALL(pipe)
 3e1:	b8 04 00 00 00       	mov    $0x4,%eax
 3e6:	cd 40                	int    $0x40
 3e8:	c3                   	ret    

000003e9 <read>:
SYSCALL(read)
 3e9:	b8 05 00 00 00       	mov    $0x5,%eax
 3ee:	cd 40                	int    $0x40
 3f0:	c3                   	ret    

000003f1 <write>:
SYSCALL(write)
 3f1:	b8 10 00 00 00       	mov    $0x10,%eax
 3f6:	cd 40                	int    $0x40
 3f8:	c3                   	ret    

000003f9 <close>:
SYSCALL(close)
 3f9:	b8 15 00 00 00       	mov    $0x15,%eax
 3fe:	cd 40                	int    $0x40
 400:	c3                   	ret    

00000401 <kill>:
SYSCALL(kill)
 401:	b8 06 00 00 00       	mov    $0x6,%eax
 406:	cd 40                	int    $0x40
 408:	c3                   	ret    

00000409 <exec>:
SYSCALL(exec)
 409:	b8 07 00 00 00       	mov    $0x7,%eax
 40e:	cd 40                	int    $0x40
 410:	c3                   	ret    

00000411 <open>:
SYSCALL(open)
 411:	b8 0f 00 00 00       	mov    $0xf,%eax
 416:	cd 40                	int    $0x40
 418:	c3                   	ret    

00000419 <mknod>:
SYSCALL(mknod)
 419:	b8 11 00 00 00       	mov    $0x11,%eax
 41e:	cd 40                	int    $0x40
 420:	c3                   	ret    

00000421 <unlink>:
SYSCALL(unlink)
 421:	b8 12 00 00 00       	mov    $0x12,%eax
 426:	cd 40                	int    $0x40
 428:	c3                   	ret    

00000429 <fstat>:
SYSCALL(fstat)
 429:	b8 08 00 00 00       	mov    $0x8,%eax
 42e:	cd 40                	int    $0x40
 430:	c3                   	ret    

00000431 <link>:
SYSCALL(link)
 431:	b8 13 00 00 00       	mov    $0x13,%eax
 436:	cd 40                	int    $0x40
 438:	c3                   	ret    

00000439 <mkdir>:
SYSCALL(mkdir)
 439:	b8 14 00 00 00       	mov    $0x14,%eax
 43e:	cd 40                	int    $0x40
 440:	c3                   	ret    

00000441 <chdir>:
SYSCALL(chdir)
 441:	b8 09 00 00 00       	mov    $0x9,%eax
 446:	cd 40                	int    $0x40
 448:	c3                   	ret    

00000449 <dup>:
SYSCALL(dup)
 449:	b8 0a 00 00 00       	mov    $0xa,%eax
 44e:	cd 40                	int    $0x40
 450:	c3                   	ret    

00000451 <getpid>:
SYSCALL(getpid)
 451:	b8 0b 00 00 00       	mov    $0xb,%eax
 456:	cd 40                	int    $0x40
 458:	c3                   	ret    

00000459 <sbrk>:
SYSCALL(sbrk)
 459:	b8 0c 00 00 00       	mov    $0xc,%eax
 45e:	cd 40                	int    $0x40
 460:	c3                   	ret    

00000461 <sleep>:
SYSCALL(sleep)
 461:	b8 0d 00 00 00       	mov    $0xd,%eax
 466:	cd 40                	int    $0x40
 468:	c3                   	ret    

00000469 <uptime>:
SYSCALL(uptime)
 469:	b8 0e 00 00 00       	mov    $0xe,%eax
 46e:	cd 40                	int    $0x40
 470:	c3                   	ret    

00000471 <halt>:
SYSCALL(halt)
 471:	b8 16 00 00 00       	mov    $0x16,%eax
 476:	cd 40                	int    $0x40
 478:	c3                   	ret    

00000479 <date>:
SYSCALL(date)
 479:	b8 17 00 00 00       	mov    $0x17,%eax
 47e:	cd 40                	int    $0x40
 480:	c3                   	ret    

00000481 <getgid>:
SYSCALL(getgid)
 481:	b8 18 00 00 00       	mov    $0x18,%eax
 486:	cd 40                	int    $0x40
 488:	c3                   	ret    

00000489 <setgid>:
SYSCALL(setgid)
 489:	b8 19 00 00 00       	mov    $0x19,%eax
 48e:	cd 40                	int    $0x40
 490:	c3                   	ret    

00000491 <getuid>:
SYSCALL(getuid)
 491:	b8 1a 00 00 00       	mov    $0x1a,%eax
 496:	cd 40                	int    $0x40
 498:	c3                   	ret    

00000499 <setuid>:
SYSCALL(setuid)
 499:	b8 1b 00 00 00       	mov    $0x1b,%eax
 49e:	cd 40                	int    $0x40
 4a0:	c3                   	ret    

000004a1 <getppid>:
SYSCALL(getppid)
 4a1:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4a6:	cd 40                	int    $0x40
 4a8:	c3                   	ret    

000004a9 <getprocs>:
SYSCALL(getprocs)
 4a9:	b8 1d 00 00 00       	mov    $0x1d,%eax
 4ae:	cd 40                	int    $0x40
 4b0:	c3                   	ret    

000004b1 <setpriority>:
SYSCALL(setpriority)
 4b1:	b8 1e 00 00 00       	mov    $0x1e,%eax
 4b6:	cd 40                	int    $0x40
 4b8:	c3                   	ret    

000004b9 <getpriority>:
SYSCALL(getpriority)
 4b9:	b8 1f 00 00 00       	mov    $0x1f,%eax
 4be:	cd 40                	int    $0x40
 4c0:	c3                   	ret    

000004c1 <chmod>:
SYSCALL(chmod)
 4c1:	b8 20 00 00 00       	mov    $0x20,%eax
 4c6:	cd 40                	int    $0x40
 4c8:	c3                   	ret    

000004c9 <chown>:
SYSCALL(chown)
 4c9:	b8 21 00 00 00       	mov    $0x21,%eax
 4ce:	cd 40                	int    $0x40
 4d0:	c3                   	ret    

000004d1 <chgrp>:
SYSCALL(chgrp)
 4d1:	b8 22 00 00 00       	mov    $0x22,%eax
 4d6:	cd 40                	int    $0x40
 4d8:	c3                   	ret    
 4d9:	66 90                	xchg   %ax,%ax
 4db:	66 90                	xchg   %ax,%ax
 4dd:	66 90                	xchg   %ax,%ax
 4df:	90                   	nop

000004e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	53                   	push   %ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4e6:	89 d3                	mov    %edx,%ebx
{
 4e8:	83 ec 3c             	sub    $0x3c,%esp
 4eb:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 4ee:	85 d2                	test   %edx,%edx
 4f0:	0f 89 92 00 00 00    	jns    588 <printint+0xa8>
 4f6:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4fa:	0f 84 88 00 00 00    	je     588 <printint+0xa8>
    neg = 1;
 500:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 507:	f7 db                	neg    %ebx
  } else {
    x = xx;
  }

  i = 0;
 509:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 510:	8d 75 d7             	lea    -0x29(%ebp),%esi
 513:	eb 08                	jmp    51d <printint+0x3d>
 515:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 518:	89 7d c4             	mov    %edi,-0x3c(%ebp)
  }while((x /= base) != 0);
 51b:	89 c3                	mov    %eax,%ebx
    buf[i++] = digits[x % base];
 51d:	89 d8                	mov    %ebx,%eax
 51f:	31 d2                	xor    %edx,%edx
 521:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 524:	f7 f1                	div    %ecx
 526:	83 c7 01             	add    $0x1,%edi
 529:	0f b6 92 74 09 00 00 	movzbl 0x974(%edx),%edx
 530:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 533:	39 d9                	cmp    %ebx,%ecx
 535:	76 e1                	jbe    518 <printint+0x38>
  if(neg)
 537:	8b 45 c0             	mov    -0x40(%ebp),%eax
 53a:	85 c0                	test   %eax,%eax
 53c:	74 0d                	je     54b <printint+0x6b>
    buf[i++] = '-';
 53e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 543:	ba 2d 00 00 00       	mov    $0x2d,%edx
    buf[i++] = digits[x % base];
 548:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 54b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 54e:	8b 7d bc             	mov    -0x44(%ebp),%edi
 551:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 555:	eb 0f                	jmp    566 <printint+0x86>
 557:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 55e:	66 90                	xchg   %ax,%ax
 560:	0f b6 13             	movzbl (%ebx),%edx
 563:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 566:	83 ec 04             	sub    $0x4,%esp
 569:	88 55 d7             	mov    %dl,-0x29(%ebp)
 56c:	6a 01                	push   $0x1
 56e:	56                   	push   %esi
 56f:	57                   	push   %edi
 570:	e8 7c fe ff ff       	call   3f1 <write>

  while(--i >= 0)
 575:	83 c4 10             	add    $0x10,%esp
 578:	39 de                	cmp    %ebx,%esi
 57a:	75 e4                	jne    560 <printint+0x80>
    putc(fd, buf[i]);
}
 57c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 57f:	5b                   	pop    %ebx
 580:	5e                   	pop    %esi
 581:	5f                   	pop    %edi
 582:	5d                   	pop    %ebp
 583:	c3                   	ret    
 584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 588:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 58f:	e9 75 ff ff ff       	jmp    509 <printint+0x29>
 594:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 59b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 59f:	90                   	nop

000005a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	57                   	push   %edi
 5a4:	56                   	push   %esi
 5a5:	53                   	push   %ebx
 5a6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5a9:	8b 75 0c             	mov    0xc(%ebp),%esi
 5ac:	0f b6 1e             	movzbl (%esi),%ebx
 5af:	84 db                	test   %bl,%bl
 5b1:	0f 84 b9 00 00 00    	je     670 <printf+0xd0>
  ap = (uint*)(void*)&fmt + 1;
 5b7:	8d 45 10             	lea    0x10(%ebp),%eax
 5ba:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 5bd:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 5c0:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 5c2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5c5:	eb 38                	jmp    5ff <printf+0x5f>
 5c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ce:	66 90                	xchg   %ax,%ax
 5d0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 5d3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 5d8:	83 f8 25             	cmp    $0x25,%eax
 5db:	74 17                	je     5f4 <printf+0x54>
  write(fd, &c, 1);
 5dd:	83 ec 04             	sub    $0x4,%esp
 5e0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5e3:	6a 01                	push   $0x1
 5e5:	57                   	push   %edi
 5e6:	ff 75 08             	pushl  0x8(%ebp)
 5e9:	e8 03 fe ff ff       	call   3f1 <write>
 5ee:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 5f1:	83 c4 10             	add    $0x10,%esp
 5f4:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 5f7:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 5fb:	84 db                	test   %bl,%bl
 5fd:	74 71                	je     670 <printf+0xd0>
    c = fmt[i] & 0xff;
 5ff:	0f be cb             	movsbl %bl,%ecx
 602:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 605:	85 d2                	test   %edx,%edx
 607:	74 c7                	je     5d0 <printf+0x30>
      }
    } else if(state == '%'){
 609:	83 fa 25             	cmp    $0x25,%edx
 60c:	75 e6                	jne    5f4 <printf+0x54>
      if(c == 'd'){
 60e:	83 f8 64             	cmp    $0x64,%eax
 611:	0f 84 99 00 00 00    	je     6b0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 617:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 61d:	83 f9 70             	cmp    $0x70,%ecx
 620:	74 5e                	je     680 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 622:	83 f8 73             	cmp    $0x73,%eax
 625:	0f 84 d5 00 00 00    	je     700 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 62b:	83 f8 63             	cmp    $0x63,%eax
 62e:	0f 84 8c 00 00 00    	je     6c0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 634:	83 f8 25             	cmp    $0x25,%eax
 637:	0f 84 b3 00 00 00    	je     6f0 <printf+0x150>
  write(fd, &c, 1);
 63d:	83 ec 04             	sub    $0x4,%esp
 640:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 644:	6a 01                	push   $0x1
 646:	57                   	push   %edi
 647:	ff 75 08             	pushl  0x8(%ebp)
 64a:	e8 a2 fd ff ff       	call   3f1 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 64f:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 652:	83 c4 0c             	add    $0xc,%esp
 655:	6a 01                	push   $0x1
 657:	83 c6 01             	add    $0x1,%esi
 65a:	57                   	push   %edi
 65b:	ff 75 08             	pushl  0x8(%ebp)
 65e:	e8 8e fd ff ff       	call   3f1 <write>
  for(i = 0; fmt[i]; i++){
 663:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 667:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 66a:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 66c:	84 db                	test   %bl,%bl
 66e:	75 8f                	jne    5ff <printf+0x5f>
    }
  }
}
 670:	8d 65 f4             	lea    -0xc(%ebp),%esp
 673:	5b                   	pop    %ebx
 674:	5e                   	pop    %esi
 675:	5f                   	pop    %edi
 676:	5d                   	pop    %ebp
 677:	c3                   	ret    
 678:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 67f:	90                   	nop
        printint(fd, *ap, 16, 0);
 680:	83 ec 0c             	sub    $0xc,%esp
 683:	b9 10 00 00 00       	mov    $0x10,%ecx
 688:	6a 00                	push   $0x0
 68a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 68d:	8b 45 08             	mov    0x8(%ebp),%eax
 690:	8b 13                	mov    (%ebx),%edx
 692:	e8 49 fe ff ff       	call   4e0 <printint>
        ap++;
 697:	89 d8                	mov    %ebx,%eax
 699:	83 c4 10             	add    $0x10,%esp
      state = 0;
 69c:	31 d2                	xor    %edx,%edx
        ap++;
 69e:	83 c0 04             	add    $0x4,%eax
 6a1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6a4:	e9 4b ff ff ff       	jmp    5f4 <printf+0x54>
 6a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 6b0:	83 ec 0c             	sub    $0xc,%esp
 6b3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6b8:	6a 01                	push   $0x1
 6ba:	eb ce                	jmp    68a <printf+0xea>
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 6c0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 6c3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 6c6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 6c8:	6a 01                	push   $0x1
        ap++;
 6ca:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 6cd:	57                   	push   %edi
 6ce:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 6d1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6d4:	e8 18 fd ff ff       	call   3f1 <write>
        ap++;
 6d9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6dc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6df:	31 d2                	xor    %edx,%edx
 6e1:	e9 0e ff ff ff       	jmp    5f4 <printf+0x54>
 6e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6ed:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 6f0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 6f3:	83 ec 04             	sub    $0x4,%esp
 6f6:	e9 5a ff ff ff       	jmp    655 <printf+0xb5>
 6fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6ff:	90                   	nop
        s = (char*)*ap;
 700:	8b 45 d0             	mov    -0x30(%ebp),%eax
 703:	8b 18                	mov    (%eax),%ebx
        ap++;
 705:	83 c0 04             	add    $0x4,%eax
 708:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 70b:	85 db                	test   %ebx,%ebx
 70d:	74 17                	je     726 <printf+0x186>
        while(*s != 0){
 70f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 712:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 714:	84 c0                	test   %al,%al
 716:	0f 84 d8 fe ff ff    	je     5f4 <printf+0x54>
 71c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 71f:	89 de                	mov    %ebx,%esi
 721:	8b 5d 08             	mov    0x8(%ebp),%ebx
 724:	eb 1a                	jmp    740 <printf+0x1a0>
          s = "(null)";
 726:	bb 6c 09 00 00       	mov    $0x96c,%ebx
        while(*s != 0){
 72b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 72e:	b8 28 00 00 00       	mov    $0x28,%eax
 733:	89 de                	mov    %ebx,%esi
 735:	8b 5d 08             	mov    0x8(%ebp),%ebx
 738:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 73f:	90                   	nop
  write(fd, &c, 1);
 740:	83 ec 04             	sub    $0x4,%esp
          s++;
 743:	83 c6 01             	add    $0x1,%esi
 746:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 749:	6a 01                	push   $0x1
 74b:	57                   	push   %edi
 74c:	53                   	push   %ebx
 74d:	e8 9f fc ff ff       	call   3f1 <write>
        while(*s != 0){
 752:	0f b6 06             	movzbl (%esi),%eax
 755:	83 c4 10             	add    $0x10,%esp
 758:	84 c0                	test   %al,%al
 75a:	75 e4                	jne    740 <printf+0x1a0>
 75c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 75f:	31 d2                	xor    %edx,%edx
 761:	e9 8e fe ff ff       	jmp    5f4 <printf+0x54>
 766:	66 90                	xchg   %ax,%ax
 768:	66 90                	xchg   %ax,%ax
 76a:	66 90                	xchg   %ax,%ax
 76c:	66 90                	xchg   %ax,%ax
 76e:	66 90                	xchg   %ax,%ax

00000770 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 770:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 771:	a1 5c 0c 00 00       	mov    0xc5c,%eax
{
 776:	89 e5                	mov    %esp,%ebp
 778:	57                   	push   %edi
 779:	56                   	push   %esi
 77a:	53                   	push   %ebx
 77b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 77e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 780:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 783:	39 c8                	cmp    %ecx,%eax
 785:	73 19                	jae    7a0 <free+0x30>
 787:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 78e:	66 90                	xchg   %ax,%ax
 790:	39 d1                	cmp    %edx,%ecx
 792:	72 14                	jb     7a8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 794:	39 d0                	cmp    %edx,%eax
 796:	73 10                	jae    7a8 <free+0x38>
{
 798:	89 d0                	mov    %edx,%eax
 79a:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 79c:	39 c8                	cmp    %ecx,%eax
 79e:	72 f0                	jb     790 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a0:	39 d0                	cmp    %edx,%eax
 7a2:	72 f4                	jb     798 <free+0x28>
 7a4:	39 d1                	cmp    %edx,%ecx
 7a6:	73 f0                	jae    798 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7a8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7ab:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7ae:	39 fa                	cmp    %edi,%edx
 7b0:	74 1e                	je     7d0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7b2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7b5:	8b 50 04             	mov    0x4(%eax),%edx
 7b8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7bb:	39 f1                	cmp    %esi,%ecx
 7bd:	74 28                	je     7e7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7bf:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 7c1:	5b                   	pop    %ebx
  freep = p;
 7c2:	a3 5c 0c 00 00       	mov    %eax,0xc5c
}
 7c7:	5e                   	pop    %esi
 7c8:	5f                   	pop    %edi
 7c9:	5d                   	pop    %ebp
 7ca:	c3                   	ret    
 7cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7cf:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 7d0:	03 72 04             	add    0x4(%edx),%esi
 7d3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7d6:	8b 10                	mov    (%eax),%edx
 7d8:	8b 12                	mov    (%edx),%edx
 7da:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7dd:	8b 50 04             	mov    0x4(%eax),%edx
 7e0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7e3:	39 f1                	cmp    %esi,%ecx
 7e5:	75 d8                	jne    7bf <free+0x4f>
    p->s.size += bp->s.size;
 7e7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 7ea:	a3 5c 0c 00 00       	mov    %eax,0xc5c
    p->s.size += bp->s.size;
 7ef:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7f2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7f5:	89 10                	mov    %edx,(%eax)
}
 7f7:	5b                   	pop    %ebx
 7f8:	5e                   	pop    %esi
 7f9:	5f                   	pop    %edi
 7fa:	5d                   	pop    %ebp
 7fb:	c3                   	ret    
 7fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000800 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 800:	55                   	push   %ebp
 801:	89 e5                	mov    %esp,%ebp
 803:	57                   	push   %edi
 804:	56                   	push   %esi
 805:	53                   	push   %ebx
 806:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 809:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 80c:	8b 3d 5c 0c 00 00    	mov    0xc5c,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 812:	8d 70 07             	lea    0x7(%eax),%esi
 815:	c1 ee 03             	shr    $0x3,%esi
 818:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 81b:	85 ff                	test   %edi,%edi
 81d:	0f 84 ad 00 00 00    	je     8d0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 823:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 825:	8b 4a 04             	mov    0x4(%edx),%ecx
 828:	39 f1                	cmp    %esi,%ecx
 82a:	73 72                	jae    89e <malloc+0x9e>
 82c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 832:	bb 00 10 00 00       	mov    $0x1000,%ebx
 837:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 83a:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 841:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 844:	eb 1b                	jmp    861 <malloc+0x61>
 846:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 84d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 850:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 852:	8b 48 04             	mov    0x4(%eax),%ecx
 855:	39 f1                	cmp    %esi,%ecx
 857:	73 4f                	jae    8a8 <malloc+0xa8>
 859:	8b 3d 5c 0c 00 00    	mov    0xc5c,%edi
 85f:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 861:	39 d7                	cmp    %edx,%edi
 863:	75 eb                	jne    850 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 865:	83 ec 0c             	sub    $0xc,%esp
 868:	ff 75 e4             	pushl  -0x1c(%ebp)
 86b:	e8 e9 fb ff ff       	call   459 <sbrk>
  if(p == (char*)-1)
 870:	83 c4 10             	add    $0x10,%esp
 873:	83 f8 ff             	cmp    $0xffffffff,%eax
 876:	74 1c                	je     894 <malloc+0x94>
  hp->s.size = nu;
 878:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 87b:	83 ec 0c             	sub    $0xc,%esp
 87e:	83 c0 08             	add    $0x8,%eax
 881:	50                   	push   %eax
 882:	e8 e9 fe ff ff       	call   770 <free>
  return freep;
 887:	8b 15 5c 0c 00 00    	mov    0xc5c,%edx
      if((p = morecore(nunits)) == 0)
 88d:	83 c4 10             	add    $0x10,%esp
 890:	85 d2                	test   %edx,%edx
 892:	75 bc                	jne    850 <malloc+0x50>
        return 0;
  }
}
 894:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 897:	31 c0                	xor    %eax,%eax
}
 899:	5b                   	pop    %ebx
 89a:	5e                   	pop    %esi
 89b:	5f                   	pop    %edi
 89c:	5d                   	pop    %ebp
 89d:	c3                   	ret    
    if(p->s.size >= nunits){
 89e:	89 d0                	mov    %edx,%eax
 8a0:	89 fa                	mov    %edi,%edx
 8a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 8a8:	39 ce                	cmp    %ecx,%esi
 8aa:	74 54                	je     900 <malloc+0x100>
        p->s.size -= nunits;
 8ac:	29 f1                	sub    %esi,%ecx
 8ae:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 8b1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 8b4:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 8b7:	89 15 5c 0c 00 00    	mov    %edx,0xc5c
}
 8bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 8c0:	83 c0 08             	add    $0x8,%eax
}
 8c3:	5b                   	pop    %ebx
 8c4:	5e                   	pop    %esi
 8c5:	5f                   	pop    %edi
 8c6:	5d                   	pop    %ebp
 8c7:	c3                   	ret    
 8c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8cf:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 8d0:	c7 05 5c 0c 00 00 60 	movl   $0xc60,0xc5c
 8d7:	0c 00 00 
    base.s.size = 0;
 8da:	bf 60 0c 00 00       	mov    $0xc60,%edi
    base.s.ptr = freep = prevp = &base;
 8df:	c7 05 60 0c 00 00 60 	movl   $0xc60,0xc60
 8e6:	0c 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 8eb:	c7 05 64 0c 00 00 00 	movl   $0x0,0xc64
 8f2:	00 00 00 
    if(p->s.size >= nunits){
 8f5:	e9 32 ff ff ff       	jmp    82c <malloc+0x2c>
 8fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 900:	8b 08                	mov    (%eax),%ecx
 902:	89 0a                	mov    %ecx,(%edx)
 904:	eb b1                	jmp    8b7 <malloc+0xb7>
