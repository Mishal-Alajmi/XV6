
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
// ***** processing for shell builtins ends here *****
#endif

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 04             	sub    $0x4,%esp
  static char buf[100];
  int fd;

  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
      11:	eb 0e                	jmp    21 <main+0x21>
      13:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      17:	90                   	nop
    if(fd >= 3){
      18:	83 f8 02             	cmp    $0x2,%eax
      1b:	0f 8f e9 00 00 00    	jg     10a <main+0x10a>
  while((fd = open("console", O_RDWR)) >= 0){
      21:	83 ec 08             	sub    $0x8,%esp
      24:	6a 02                	push   $0x2
      26:	68 af 16 00 00       	push   $0x16af
      2b:	e8 a1 10 00 00       	call   10d1 <open>
      30:	83 c4 10             	add    $0x10,%esp
      33:	85 c0                	test   %eax,%eax
      35:	79 e1                	jns    18 <main+0x18>
      37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      3e:	66 90                	xchg   %ax,%ax
      break;
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
      40:	83 ec 08             	sub    $0x8,%esp
      43:	6a 64                	push   $0x64
      45:	68 00 1e 00 00       	push   $0x1e00
      4a:	e8 71 02 00 00       	call   2c0 <getcmd>
      4f:	83 c4 10             	add    $0x10,%esp
      52:	85 c0                	test   %eax,%eax
      54:	0f 88 ab 00 00 00    	js     105 <main+0x105>
// add support for built-ins here. cd is a built-in
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      5a:	0f b6 05 00 1e 00 00 	movzbl 0x1e00,%eax
      61:	3c 63                	cmp    $0x63,%al
      63:	74 2b                	je     90 <main+0x90>
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
#ifdef USE_BUILTINS
    if (buf[0]=='_') {     // assume it is a builtin command
      65:	3c 5f                	cmp    $0x5f,%al
      67:	0f 84 83 00 00 00    	je     f0 <main+0xf0>
int
fork1(void)
{
  int pid;

  pid = fork();
      6d:	e8 17 10 00 00       	call   1089 <fork>
  if(pid == -1)
      72:	83 f8 ff             	cmp    $0xffffffff,%eax
      75:	0f 84 b5 00 00 00    	je     130 <main+0x130>
    if(fork1() == 0)
      7b:	85 c0                	test   %eax,%eax
      7d:	0f 84 98 00 00 00    	je     11b <main+0x11b>
    wait();
      83:	e8 11 10 00 00       	call   1099 <wait>
      88:	eb b6                	jmp    40 <main+0x40>
      8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      90:	80 3d 01 1e 00 00 64 	cmpb   $0x64,0x1e01
      97:	75 d4                	jne    6d <main+0x6d>
      99:	80 3d 02 1e 00 00 20 	cmpb   $0x20,0x1e02
      a0:	75 cb                	jne    6d <main+0x6d>
      buf[strlen(buf)-1] = 0;  // chop \n
      a2:	83 ec 0c             	sub    $0xc,%esp
      a5:	68 00 1e 00 00       	push   $0x1e00
      aa:	e8 71 0d 00 00       	call   e20 <strlen>
      if(chdir(buf+3) < 0)
      af:	c7 04 24 03 1e 00 00 	movl   $0x1e03,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      b6:	c6 80 ff 1d 00 00 00 	movb   $0x0,0x1dff(%eax)
      if(chdir(buf+3) < 0)
      bd:	e8 3f 10 00 00       	call   1101 <chdir>
      c2:	83 c4 10             	add    $0x10,%esp
      c5:	85 c0                	test   %eax,%eax
      c7:	0f 89 73 ff ff ff    	jns    40 <main+0x40>
        printf(2, "cannot cd %s\n", buf+3);
      cd:	50                   	push   %eax
      ce:	68 03 1e 00 00       	push   $0x1e03
      d3:	68 b7 16 00 00       	push   $0x16b7
      d8:	6a 02                	push   $0x2
      da:	e8 81 11 00 00       	call   1260 <printf>
      df:	83 c4 10             	add    $0x10,%esp
      e2:	e9 59 ff ff ff       	jmp    40 <main+0x40>
      e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ee:	66 90                	xchg   %ax,%ax
      dobuiltin(buf);
      f0:	83 ec 0c             	sub    $0xc,%esp
      f3:	68 00 1e 00 00       	push   $0x1e00
      f8:	e8 73 02 00 00       	call   370 <dobuiltin>
      continue;
      fd:	83 c4 10             	add    $0x10,%esp
     100:	e9 3b ff ff ff       	jmp    40 <main+0x40>
  exit();
     105:	e8 87 0f 00 00       	call   1091 <exit>
      close(fd);
     10a:	83 ec 0c             	sub    $0xc,%esp
     10d:	50                   	push   %eax
     10e:	e8 a6 0f 00 00       	call   10b9 <close>
      break;
     113:	83 c4 10             	add    $0x10,%esp
     116:	e9 25 ff ff ff       	jmp    40 <main+0x40>
      runcmd(parsecmd(buf));
     11b:	83 ec 0c             	sub    $0xc,%esp
     11e:	68 00 1e 00 00       	push   $0x1e00
     123:	e8 08 0c 00 00       	call   d30 <parsecmd>
     128:	89 04 24             	mov    %eax,(%esp)
     12b:	e8 10 03 00 00       	call   440 <runcmd>
    panic("fork");
     130:	83 ec 0c             	sub    $0xc,%esp
     133:	68 38 16 00 00       	push   $0x1638
     138:	e8 e3 02 00 00       	call   420 <panic>
     13d:	66 90                	xchg   %ax,%ax
     13f:	90                   	nop

00000140 <setbuiltin>:
{
     140:	55                   	push   %ebp
     141:	89 e5                	mov    %esp,%ebp
     143:	53                   	push   %ebx
     144:	83 ec 10             	sub    $0x10,%esp
  p += strlen("_set");
     147:	68 c8 15 00 00       	push   $0x15c8
     14c:	e8 cf 0c 00 00       	call   e20 <strlen>
     151:	03 45 08             	add    0x8(%ebp),%eax
  while (strncmp(p, " ", 1) == 0) p++; // chomp spaces
     154:	83 c4 10             	add    $0x10,%esp
  p += strlen("_set");
     157:	89 c3                	mov    %eax,%ebx
  while (strncmp(p, " ", 1) == 0) p++; // chomp spaces
     159:	eb 08                	jmp    163 <setbuiltin+0x23>
     15b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     15f:	90                   	nop
     160:	83 c3 01             	add    $0x1,%ebx
    while(n > 0 && *p && *p == *q)
     163:	0f b6 03             	movzbl (%ebx),%eax
     166:	3c 20                	cmp    $0x20,%al
     168:	74 f6                	je     160 <setbuiltin+0x20>
     16a:	3c 75                	cmp    $0x75,%al
     16c:	75 59                	jne    1c7 <setbuiltin+0x87>
     16e:	80 7b 01 69          	cmpb   $0x69,0x1(%ebx)
     172:	0f 85 98 00 00 00    	jne    210 <setbuiltin+0xd0>
     178:	80 7b 02 64          	cmpb   $0x64,0x2(%ebx)
     17c:	0f 85 8e 00 00 00    	jne    210 <setbuiltin+0xd0>
    p += strlen("uid");
     182:	83 ec 0c             	sub    $0xc,%esp
     185:	68 cd 15 00 00       	push   $0x15cd
     18a:	e8 91 0c 00 00       	call   e20 <strlen>
    while (strncmp(p, " ", 1) == 0) p++; // chomp spaces
     18f:	83 c4 10             	add    $0x10,%esp
    p += strlen("uid");
     192:	01 c3                	add    %eax,%ebx
    while (strncmp(p, " ", 1) == 0) p++; // chomp spaces
     194:	eb 0d                	jmp    1a3 <setbuiltin+0x63>
     196:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     19d:	8d 76 00             	lea    0x0(%esi),%esi
     1a0:	83 c3 01             	add    $0x1,%ebx
    while(n > 0 && *p && *p == *q)
     1a3:	80 3b 20             	cmpb   $0x20,(%ebx)
     1a6:	74 f8                	je     1a0 <setbuiltin+0x60>
    i = atoi(p);
     1a8:	83 ec 0c             	sub    $0xc,%esp
     1ab:	53                   	push   %ebx
     1ac:	e8 cf 0d 00 00       	call   f80 <atoi>
    rc = (setuid(i));
     1b1:	89 04 24             	mov    %eax,(%esp)
     1b4:	e8 a0 0f 00 00       	call   1159 <setuid>
    if (rc == 0)
     1b9:	83 c4 10             	add    $0x10,%esp
     1bc:	85 c0                	test   %eax,%eax
     1be:	75 50                	jne    210 <setbuiltin+0xd0>
      return 0;
     1c0:	31 c0                	xor    %eax,%eax
}
     1c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     1c5:	c9                   	leave  
     1c6:	c3                   	ret    
    while(n > 0 && *p && *p == *q)
     1c7:	3c 67                	cmp    $0x67,%al
     1c9:	75 45                	jne    210 <setbuiltin+0xd0>
     1cb:	80 7b 01 69          	cmpb   $0x69,0x1(%ebx)
     1cf:	75 3f                	jne    210 <setbuiltin+0xd0>
     1d1:	80 7b 02 64          	cmpb   $0x64,0x2(%ebx)
     1d5:	75 39                	jne    210 <setbuiltin+0xd0>
    p += strlen("gid");
     1d7:	83 ec 0c             	sub    $0xc,%esp
     1da:	68 e9 15 00 00       	push   $0x15e9
     1df:	e8 3c 0c 00 00       	call   e20 <strlen>
    while (strncmp(p, " ", 1) == 0) p++; // chomp spaces
     1e4:	83 c4 10             	add    $0x10,%esp
    p += strlen("gid");
     1e7:	01 c3                	add    %eax,%ebx
    while (strncmp(p, " ", 1) == 0) p++; // chomp spaces
     1e9:	eb 08                	jmp    1f3 <setbuiltin+0xb3>
     1eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     1ef:	90                   	nop
     1f0:	83 c3 01             	add    $0x1,%ebx
    while(n > 0 && *p && *p == *q)
     1f3:	80 3b 20             	cmpb   $0x20,(%ebx)
     1f6:	74 f8                	je     1f0 <setbuiltin+0xb0>
    i = atoi(p);
     1f8:	83 ec 0c             	sub    $0xc,%esp
     1fb:	53                   	push   %ebx
     1fc:	e8 7f 0d 00 00       	call   f80 <atoi>
    rc = (setgid(i));
     201:	89 04 24             	mov    %eax,(%esp)
     204:	e8 40 0f 00 00       	call   1149 <setgid>
    if (rc == 0)
     209:	83 c4 10             	add    $0x10,%esp
     20c:	85 c0                	test   %eax,%eax
     20e:	74 b0                	je     1c0 <setbuiltin+0x80>
  printf(2, "Invalid _set parameter\n");
     210:	83 ec 08             	sub    $0x8,%esp
     213:	68 d1 15 00 00       	push   $0x15d1
     218:	6a 02                	push   $0x2
     21a:	e8 41 10 00 00       	call   1260 <printf>
  return -1;
     21f:	83 c4 10             	add    $0x10,%esp
     222:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     227:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     22a:	c9                   	leave  
     22b:	c3                   	ret    
     22c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000230 <getbuiltin>:
{
     230:	55                   	push   %ebp
     231:	89 e5                	mov    %esp,%ebp
     233:	83 ec 14             	sub    $0x14,%esp
  p += strlen("_get");
     236:	68 ed 15 00 00       	push   $0x15ed
     23b:	e8 e0 0b 00 00       	call   e20 <strlen>
  while (strncmp(p, " ", 1) == 0) p++; // chomp spaces
     240:	83 c4 10             	add    $0x10,%esp
  p += strlen("_get");
     243:	03 45 08             	add    0x8(%ebp),%eax
  while (strncmp(p, " ", 1) == 0) p++; // chomp spaces
     246:	eb 0b                	jmp    253 <getbuiltin+0x23>
     248:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     24f:	90                   	nop
     250:	83 c0 01             	add    $0x1,%eax
    while(n > 0 && *p && *p == *q)
     253:	0f b6 10             	movzbl (%eax),%edx
     256:	80 fa 20             	cmp    $0x20,%dl
     259:	74 f5                	je     250 <getbuiltin+0x20>
     25b:	80 fa 75             	cmp    $0x75,%dl
     25e:	75 28                	jne    288 <getbuiltin+0x58>
     260:	80 78 01 69          	cmpb   $0x69,0x1(%eax)
     264:	75 3a                	jne    2a0 <getbuiltin+0x70>
     266:	80 78 02 64          	cmpb   $0x64,0x2(%eax)
     26a:	75 34                	jne    2a0 <getbuiltin+0x70>
    printf(2, "%d\n", getuid());
     26c:	e8 e0 0e 00 00       	call   1151 <getuid>
    printf(2, "%d\n", getgid());
     271:	83 ec 04             	sub    $0x4,%esp
     274:	50                   	push   %eax
     275:	68 f2 15 00 00       	push   $0x15f2
     27a:	6a 02                	push   $0x2
     27c:	e8 df 0f 00 00       	call   1260 <printf>
    return 0;
     281:	83 c4 10             	add    $0x10,%esp
     284:	31 c0                	xor    %eax,%eax
}
     286:	c9                   	leave  
     287:	c3                   	ret    
    while(n > 0 && *p && *p == *q)
     288:	80 fa 67             	cmp    $0x67,%dl
     28b:	75 13                	jne    2a0 <getbuiltin+0x70>
     28d:	80 78 01 69          	cmpb   $0x69,0x1(%eax)
     291:	75 0d                	jne    2a0 <getbuiltin+0x70>
     293:	80 78 02 64          	cmpb   $0x64,0x2(%eax)
     297:	75 07                	jne    2a0 <getbuiltin+0x70>
    printf(2, "%d\n", getgid());
     299:	e8 a3 0e 00 00       	call   1141 <getgid>
     29e:	eb d1                	jmp    271 <getbuiltin+0x41>
  printf(2, "Invalid _get parameter\n");
     2a0:	83 ec 08             	sub    $0x8,%esp
     2a3:	68 f6 15 00 00       	push   $0x15f6
     2a8:	6a 02                	push   $0x2
     2aa:	e8 b1 0f 00 00       	call   1260 <printf>
  return -1;
     2af:	83 c4 10             	add    $0x10,%esp
     2b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     2b7:	c9                   	leave  
     2b8:	c3                   	ret    
     2b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002c0 <getcmd>:
{
     2c0:	55                   	push   %ebp
     2c1:	89 e5                	mov    %esp,%ebp
     2c3:	56                   	push   %esi
     2c4:	53                   	push   %ebx
     2c5:	8b 75 0c             	mov    0xc(%ebp),%esi
     2c8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  printf(2, "$ ");
     2cb:	83 ec 08             	sub    $0x8,%esp
     2ce:	68 0e 16 00 00       	push   $0x160e
     2d3:	6a 02                	push   $0x2
     2d5:	e8 86 0f 00 00       	call   1260 <printf>
  memset(buf, 0, nbuf);
     2da:	83 c4 0c             	add    $0xc,%esp
     2dd:	56                   	push   %esi
     2de:	6a 00                	push   $0x0
     2e0:	53                   	push   %ebx
     2e1:	e8 6a 0b 00 00       	call   e50 <memset>
  gets(buf, nbuf);
     2e6:	58                   	pop    %eax
     2e7:	5a                   	pop    %edx
     2e8:	56                   	push   %esi
     2e9:	53                   	push   %ebx
     2ea:	e8 c1 0b 00 00       	call   eb0 <gets>
  if(buf[0] == 0) // EOF
     2ef:	83 c4 10             	add    $0x10,%esp
     2f2:	31 c0                	xor    %eax,%eax
     2f4:	80 3b 00             	cmpb   $0x0,(%ebx)
     2f7:	0f 94 c0             	sete   %al
}
     2fa:	8d 65 f8             	lea    -0x8(%ebp),%esp
     2fd:	5b                   	pop    %ebx
  if(buf[0] == 0) // EOF
     2fe:	f7 d8                	neg    %eax
}
     300:	5e                   	pop    %esi
     301:	5d                   	pop    %ebp
     302:	c3                   	ret    
     303:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     30a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000310 <strncmp>:
{
     310:	55                   	push   %ebp
     311:	89 e5                	mov    %esp,%ebp
     313:	57                   	push   %edi
     314:	8b 7d 10             	mov    0x10(%ebp),%edi
     317:	8b 4d 08             	mov    0x8(%ebp),%ecx
     31a:	56                   	push   %esi
     31b:	8b 75 0c             	mov    0xc(%ebp),%esi
     31e:	53                   	push   %ebx
    while(n > 0 && *p && *p == *q)
     31f:	85 ff                	test   %edi,%edi
     321:	74 2f                	je     352 <strncmp+0x42>
     323:	0f b6 11             	movzbl (%ecx),%edx
     326:	0f b6 1e             	movzbl (%esi),%ebx
     329:	84 d2                	test   %dl,%dl
     32b:	74 37                	je     364 <strncmp+0x54>
     32d:	38 da                	cmp    %bl,%dl
     32f:	75 33                	jne    364 <strncmp+0x54>
     331:	01 f7                	add    %esi,%edi
     333:	eb 13                	jmp    348 <strncmp+0x38>
     335:	8d 76 00             	lea    0x0(%esi),%esi
     338:	0f b6 11             	movzbl (%ecx),%edx
     33b:	84 d2                	test   %dl,%dl
     33d:	74 21                	je     360 <strncmp+0x50>
     33f:	0f b6 18             	movzbl (%eax),%ebx
     342:	89 c6                	mov    %eax,%esi
     344:	38 da                	cmp    %bl,%dl
     346:	75 1c                	jne    364 <strncmp+0x54>
      n--, p++, q++;
     348:	8d 46 01             	lea    0x1(%esi),%eax
     34b:	83 c1 01             	add    $0x1,%ecx
    while(n > 0 && *p && *p == *q)
     34e:	39 f8                	cmp    %edi,%eax
     350:	75 e6                	jne    338 <strncmp+0x28>
}
     352:	5b                   	pop    %ebx
      return 0;
     353:	31 c0                	xor    %eax,%eax
}
     355:	5e                   	pop    %esi
     356:	5f                   	pop    %edi
     357:	5d                   	pop    %ebp
     358:	c3                   	ret    
     359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     360:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
    return (uchar)*p - (uchar)*q;
     364:	0f b6 c2             	movzbl %dl,%eax
     367:	29 d8                	sub    %ebx,%eax
}
     369:	5b                   	pop    %ebx
     36a:	5e                   	pop    %esi
     36b:	5f                   	pop    %edi
     36c:	5d                   	pop    %ebp
     36d:	c3                   	ret    
     36e:	66 90                	xchg   %ax,%ax

00000370 <dobuiltin>:
  for (i=0; i<FDTcount; i++)
     370:	a1 e0 1d 00 00       	mov    0x1de0,%eax
     375:	85 c0                	test   %eax,%eax
     377:	0f 8e 93 00 00 00    	jle    410 <dobuiltin+0xa0>
dobuiltin(char *cmd) {
     37d:	55                   	push   %ebp
     37e:	89 e5                	mov    %esp,%ebp
     380:	57                   	push   %edi
     381:	56                   	push   %esi
     382:	31 f6                	xor    %esi,%esi
     384:	53                   	push   %ebx
     385:	83 ec 0c             	sub    $0xc,%esp
    if (strncmp(cmd, fdt[i].cmd, strlen(fdt[i].cmd)) == 0)
     388:	83 ec 0c             	sub    $0xc,%esp
     38b:	ff 34 f5 e4 1d 00 00 	pushl  0x1de4(,%esi,8)
     392:	e8 89 0a 00 00       	call   e20 <strlen>
     397:	8b 0c f5 e4 1d 00 00 	mov    0x1de4(,%esi,8),%ecx
    while(n > 0 && *p && *p == *q)
     39e:	83 c4 10             	add    $0x10,%esp
     3a1:	85 c0                	test   %eax,%eax
     3a3:	74 32                	je     3d7 <dobuiltin+0x67>
     3a5:	8b 7d 08             	mov    0x8(%ebp),%edi
     3a8:	0f b6 19             	movzbl (%ecx),%ebx
     3ab:	0f b6 17             	movzbl (%edi),%edx
     3ae:	84 d2                	test   %dl,%dl
     3b0:	74 52                	je     404 <dobuiltin+0x94>
     3b2:	38 d3                	cmp    %dl,%bl
     3b4:	75 31                	jne    3e7 <dobuiltin+0x77>
     3b6:	8d 57 01             	lea    0x1(%edi),%edx
     3b9:	01 f8                	add    %edi,%eax
     3bb:	eb 13                	jmp    3d0 <dobuiltin+0x60>
     3bd:	8d 76 00             	lea    0x0(%esi),%esi
     3c0:	0f b6 1a             	movzbl (%edx),%ebx
     3c3:	84 db                	test   %bl,%bl
     3c5:	74 39                	je     400 <dobuiltin+0x90>
     3c7:	83 c2 01             	add    $0x1,%edx
     3ca:	89 f9                	mov    %edi,%ecx
     3cc:	3a 1f                	cmp    (%edi),%bl
     3ce:	75 17                	jne    3e7 <dobuiltin+0x77>
      n--, p++, q++;
     3d0:	8d 79 01             	lea    0x1(%ecx),%edi
    while(n > 0 && *p && *p == *q)
     3d3:	39 c2                	cmp    %eax,%edx
     3d5:	75 e9                	jne    3c0 <dobuiltin+0x50>
     (*fdt[i].name)(cmd);
     3d7:	83 ec 0c             	sub    $0xc,%esp
     3da:	ff 75 08             	pushl  0x8(%ebp)
     3dd:	ff 14 f5 e8 1d 00 00 	call   *0x1de8(,%esi,8)
     3e4:	83 c4 10             	add    $0x10,%esp
  for (i=0; i<FDTcount; i++)
     3e7:	83 c6 01             	add    $0x1,%esi
     3ea:	39 35 e0 1d 00 00    	cmp    %esi,0x1de0
     3f0:	7f 96                	jg     388 <dobuiltin+0x18>
}
     3f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     3f5:	5b                   	pop    %ebx
     3f6:	5e                   	pop    %esi
     3f7:	5f                   	pop    %edi
     3f8:	5d                   	pop    %ebp
     3f9:	c3                   	ret    
     3fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     400:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    if (strncmp(cmd, fdt[i].cmd, strlen(fdt[i].cmd)) == 0)
     404:	84 db                	test   %bl,%bl
     406:	74 cf                	je     3d7 <dobuiltin+0x67>
     408:	eb dd                	jmp    3e7 <dobuiltin+0x77>
     40a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     410:	c3                   	ret    
     411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     418:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     41f:	90                   	nop

00000420 <panic>:
{
     420:	55                   	push   %ebp
     421:	89 e5                	mov    %esp,%ebp
     423:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     426:	ff 75 08             	pushl  0x8(%ebp)
     429:	68 ab 16 00 00       	push   $0x16ab
     42e:	6a 02                	push   $0x2
     430:	e8 2b 0e 00 00       	call   1260 <printf>
  exit();
     435:	e8 57 0c 00 00       	call   1091 <exit>
     43a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000440 <runcmd>:
{
     440:	55                   	push   %ebp
     441:	89 e5                	mov    %esp,%ebp
     443:	53                   	push   %ebx
     444:	83 ec 14             	sub    $0x14,%esp
     447:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     44a:	85 db                	test   %ebx,%ebx
     44c:	74 7a                	je     4c8 <runcmd+0x88>
  switch(cmd->type){
     44e:	83 3b 05             	cmpl   $0x5,(%ebx)
     451:	0f 87 00 01 00 00    	ja     557 <runcmd+0x117>
     457:	8b 03                	mov    (%ebx),%eax
     459:	ff 24 85 c8 16 00 00 	jmp    *0x16c8(,%eax,4)
    if(pipe(p) < 0)
     460:	83 ec 0c             	sub    $0xc,%esp
     463:	8d 45 f0             	lea    -0x10(%ebp),%eax
     466:	50                   	push   %eax
     467:	e8 35 0c 00 00       	call   10a1 <pipe>
     46c:	83 c4 10             	add    $0x10,%esp
     46f:	85 c0                	test   %eax,%eax
     471:	0f 88 02 01 00 00    	js     579 <runcmd+0x139>
  pid = fork();
     477:	e8 0d 0c 00 00       	call   1089 <fork>
  if(pid == -1)
     47c:	83 f8 ff             	cmp    $0xffffffff,%eax
     47f:	0f 84 5d 01 00 00    	je     5e2 <runcmd+0x1a2>
    if(fork1() == 0){
     485:	85 c0                	test   %eax,%eax
     487:	0f 84 f9 00 00 00    	je     586 <runcmd+0x146>
  pid = fork();
     48d:	e8 f7 0b 00 00       	call   1089 <fork>
  if(pid == -1)
     492:	83 f8 ff             	cmp    $0xffffffff,%eax
     495:	0f 84 47 01 00 00    	je     5e2 <runcmd+0x1a2>
    if(fork1() == 0){
     49b:	85 c0                	test   %eax,%eax
     49d:	0f 84 11 01 00 00    	je     5b4 <runcmd+0x174>
    close(p[0]);
     4a3:	83 ec 0c             	sub    $0xc,%esp
     4a6:	ff 75 f0             	pushl  -0x10(%ebp)
     4a9:	e8 0b 0c 00 00       	call   10b9 <close>
    close(p[1]);
     4ae:	58                   	pop    %eax
     4af:	ff 75 f4             	pushl  -0xc(%ebp)
     4b2:	e8 02 0c 00 00       	call   10b9 <close>
    wait();
     4b7:	e8 dd 0b 00 00       	call   1099 <wait>
    wait();
     4bc:	e8 d8 0b 00 00       	call   1099 <wait>
    break;
     4c1:	83 c4 10             	add    $0x10,%esp
     4c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit();
     4c8:	e8 c4 0b 00 00       	call   1091 <exit>
  pid = fork();
     4cd:	e8 b7 0b 00 00       	call   1089 <fork>
  if(pid == -1)
     4d2:	83 f8 ff             	cmp    $0xffffffff,%eax
     4d5:	0f 84 07 01 00 00    	je     5e2 <runcmd+0x1a2>
    if(fork1() == 0)
     4db:	85 c0                	test   %eax,%eax
     4dd:	75 e9                	jne    4c8 <runcmd+0x88>
     4df:	eb 6b                	jmp    54c <runcmd+0x10c>
    if(ecmd->argv[0] == 0)
     4e1:	8b 43 04             	mov    0x4(%ebx),%eax
     4e4:	85 c0                	test   %eax,%eax
     4e6:	74 e0                	je     4c8 <runcmd+0x88>
    exec(ecmd->argv[0], ecmd->argv);
     4e8:	52                   	push   %edx
     4e9:	52                   	push   %edx
     4ea:	8d 53 04             	lea    0x4(%ebx),%edx
     4ed:	52                   	push   %edx
     4ee:	50                   	push   %eax
     4ef:	e8 d5 0b 00 00       	call   10c9 <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     4f4:	83 c4 0c             	add    $0xc,%esp
     4f7:	ff 73 04             	pushl  0x4(%ebx)
     4fa:	68 18 16 00 00       	push   $0x1618
     4ff:	6a 02                	push   $0x2
     501:	e8 5a 0d 00 00       	call   1260 <printf>
    break;
     506:	83 c4 10             	add    $0x10,%esp
     509:	eb bd                	jmp    4c8 <runcmd+0x88>
  pid = fork();
     50b:	e8 79 0b 00 00       	call   1089 <fork>
  if(pid == -1)
     510:	83 f8 ff             	cmp    $0xffffffff,%eax
     513:	0f 84 c9 00 00 00    	je     5e2 <runcmd+0x1a2>
    if(fork1() == 0)
     519:	85 c0                	test   %eax,%eax
     51b:	74 2f                	je     54c <runcmd+0x10c>
    wait();
     51d:	e8 77 0b 00 00       	call   1099 <wait>
    runcmd(lcmd->right);
     522:	83 ec 0c             	sub    $0xc,%esp
     525:	ff 73 08             	pushl  0x8(%ebx)
     528:	e8 13 ff ff ff       	call   440 <runcmd>
    close(rcmd->fd);
     52d:	83 ec 0c             	sub    $0xc,%esp
     530:	ff 73 14             	pushl  0x14(%ebx)
     533:	e8 81 0b 00 00       	call   10b9 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     538:	59                   	pop    %ecx
     539:	58                   	pop    %eax
     53a:	ff 73 10             	pushl  0x10(%ebx)
     53d:	ff 73 08             	pushl  0x8(%ebx)
     540:	e8 8c 0b 00 00       	call   10d1 <open>
     545:	83 c4 10             	add    $0x10,%esp
     548:	85 c0                	test   %eax,%eax
     54a:	78 18                	js     564 <runcmd+0x124>
      runcmd(bcmd->cmd);
     54c:	83 ec 0c             	sub    $0xc,%esp
     54f:	ff 73 04             	pushl  0x4(%ebx)
     552:	e8 e9 fe ff ff       	call   440 <runcmd>
    panic("runcmd");
     557:	83 ec 0c             	sub    $0xc,%esp
     55a:	68 11 16 00 00       	push   $0x1611
     55f:	e8 bc fe ff ff       	call   420 <panic>
      printf(2, "open %s failed\n", rcmd->file);
     564:	52                   	push   %edx
     565:	ff 73 08             	pushl  0x8(%ebx)
     568:	68 28 16 00 00       	push   $0x1628
     56d:	6a 02                	push   $0x2
     56f:	e8 ec 0c 00 00       	call   1260 <printf>
      exit();
     574:	e8 18 0b 00 00       	call   1091 <exit>
      panic("pipe");
     579:	83 ec 0c             	sub    $0xc,%esp
     57c:	68 3d 16 00 00       	push   $0x163d
     581:	e8 9a fe ff ff       	call   420 <panic>
      close(1);
     586:	83 ec 0c             	sub    $0xc,%esp
     589:	6a 01                	push   $0x1
     58b:	e8 29 0b 00 00       	call   10b9 <close>
      dup(p[1]);
     590:	58                   	pop    %eax
     591:	ff 75 f4             	pushl  -0xc(%ebp)
     594:	e8 70 0b 00 00       	call   1109 <dup>
      close(p[0]);
     599:	58                   	pop    %eax
     59a:	ff 75 f0             	pushl  -0x10(%ebp)
     59d:	e8 17 0b 00 00       	call   10b9 <close>
      close(p[1]);
     5a2:	58                   	pop    %eax
     5a3:	ff 75 f4             	pushl  -0xc(%ebp)
     5a6:	e8 0e 0b 00 00       	call   10b9 <close>
      runcmd(pcmd->left);
     5ab:	58                   	pop    %eax
     5ac:	ff 73 04             	pushl  0x4(%ebx)
     5af:	e8 8c fe ff ff       	call   440 <runcmd>
      close(0);
     5b4:	83 ec 0c             	sub    $0xc,%esp
     5b7:	6a 00                	push   $0x0
     5b9:	e8 fb 0a 00 00       	call   10b9 <close>
      dup(p[0]);
     5be:	5a                   	pop    %edx
     5bf:	ff 75 f0             	pushl  -0x10(%ebp)
     5c2:	e8 42 0b 00 00       	call   1109 <dup>
      close(p[0]);
     5c7:	59                   	pop    %ecx
     5c8:	ff 75 f0             	pushl  -0x10(%ebp)
     5cb:	e8 e9 0a 00 00       	call   10b9 <close>
      close(p[1]);
     5d0:	58                   	pop    %eax
     5d1:	ff 75 f4             	pushl  -0xc(%ebp)
     5d4:	e8 e0 0a 00 00       	call   10b9 <close>
      runcmd(pcmd->right);
     5d9:	58                   	pop    %eax
     5da:	ff 73 08             	pushl  0x8(%ebx)
     5dd:	e8 5e fe ff ff       	call   440 <runcmd>
    panic("fork");
     5e2:	83 ec 0c             	sub    $0xc,%esp
     5e5:	68 38 16 00 00       	push   $0x1638
     5ea:	e8 31 fe ff ff       	call   420 <panic>
     5ef:	90                   	nop

000005f0 <fork1>:
{
     5f0:	55                   	push   %ebp
     5f1:	89 e5                	mov    %esp,%ebp
     5f3:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     5f6:	e8 8e 0a 00 00       	call   1089 <fork>
  if(pid == -1)
     5fb:	83 f8 ff             	cmp    $0xffffffff,%eax
     5fe:	74 02                	je     602 <fork1+0x12>
  return pid;
}
     600:	c9                   	leave  
     601:	c3                   	ret    
    panic("fork");
     602:	83 ec 0c             	sub    $0xc,%esp
     605:	68 38 16 00 00       	push   $0x1638
     60a:	e8 11 fe ff ff       	call   420 <panic>
     60f:	90                   	nop

00000610 <execcmd>:

// Constructors

struct cmd*
execcmd(void)
{
     610:	55                   	push   %ebp
     611:	89 e5                	mov    %esp,%ebp
     613:	53                   	push   %ebx
     614:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     617:	6a 54                	push   $0x54
     619:	e8 a2 0e 00 00       	call   14c0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     61e:	83 c4 0c             	add    $0xc,%esp
     621:	6a 54                	push   $0x54
  cmd = malloc(sizeof(*cmd));
     623:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     625:	6a 00                	push   $0x0
     627:	50                   	push   %eax
     628:	e8 23 08 00 00       	call   e50 <memset>
  cmd->type = EXEC;
     62d:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     633:	89 d8                	mov    %ebx,%eax
     635:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     638:	c9                   	leave  
     639:	c3                   	ret    
     63a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000640 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     640:	55                   	push   %ebp
     641:	89 e5                	mov    %esp,%ebp
     643:	53                   	push   %ebx
     644:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     647:	6a 18                	push   $0x18
     649:	e8 72 0e 00 00       	call   14c0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     64e:	83 c4 0c             	add    $0xc,%esp
     651:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     653:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     655:	6a 00                	push   $0x0
     657:	50                   	push   %eax
     658:	e8 f3 07 00 00       	call   e50 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     65d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     660:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     666:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     669:	8b 45 0c             	mov    0xc(%ebp),%eax
     66c:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     66f:	8b 45 10             	mov    0x10(%ebp),%eax
     672:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     675:	8b 45 14             	mov    0x14(%ebp),%eax
     678:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     67b:	8b 45 18             	mov    0x18(%ebp),%eax
     67e:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     681:	89 d8                	mov    %ebx,%eax
     683:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     686:	c9                   	leave  
     687:	c3                   	ret    
     688:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     68f:	90                   	nop

00000690 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     690:	55                   	push   %ebp
     691:	89 e5                	mov    %esp,%ebp
     693:	53                   	push   %ebx
     694:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     697:	6a 0c                	push   $0xc
     699:	e8 22 0e 00 00       	call   14c0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     69e:	83 c4 0c             	add    $0xc,%esp
     6a1:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     6a3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     6a5:	6a 00                	push   $0x0
     6a7:	50                   	push   %eax
     6a8:	e8 a3 07 00 00       	call   e50 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     6ad:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     6b0:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     6b6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     6b9:	8b 45 0c             	mov    0xc(%ebp),%eax
     6bc:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     6bf:	89 d8                	mov    %ebx,%eax
     6c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     6c4:	c9                   	leave  
     6c5:	c3                   	ret    
     6c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     6cd:	8d 76 00             	lea    0x0(%esi),%esi

000006d0 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     6d0:	55                   	push   %ebp
     6d1:	89 e5                	mov    %esp,%ebp
     6d3:	53                   	push   %ebx
     6d4:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     6d7:	6a 0c                	push   $0xc
     6d9:	e8 e2 0d 00 00       	call   14c0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     6de:	83 c4 0c             	add    $0xc,%esp
     6e1:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     6e3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     6e5:	6a 00                	push   $0x0
     6e7:	50                   	push   %eax
     6e8:	e8 63 07 00 00       	call   e50 <memset>
  cmd->type = LIST;
  cmd->left = left;
     6ed:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     6f0:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     6f6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     6f9:	8b 45 0c             	mov    0xc(%ebp),%eax
     6fc:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     6ff:	89 d8                	mov    %ebx,%eax
     701:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     704:	c9                   	leave  
     705:	c3                   	ret    
     706:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     70d:	8d 76 00             	lea    0x0(%esi),%esi

00000710 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     710:	55                   	push   %ebp
     711:	89 e5                	mov    %esp,%ebp
     713:	53                   	push   %ebx
     714:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     717:	6a 08                	push   $0x8
     719:	e8 a2 0d 00 00       	call   14c0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     71e:	83 c4 0c             	add    $0xc,%esp
     721:	6a 08                	push   $0x8
  cmd = malloc(sizeof(*cmd));
     723:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     725:	6a 00                	push   $0x0
     727:	50                   	push   %eax
     728:	e8 23 07 00 00       	call   e50 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     72d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     730:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     736:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     739:	89 d8                	mov    %ebx,%eax
     73b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     73e:	c9                   	leave  
     73f:	c3                   	ret    

00000740 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     740:	55                   	push   %ebp
     741:	89 e5                	mov    %esp,%ebp
     743:	57                   	push   %edi
     744:	56                   	push   %esi
     745:	53                   	push   %ebx
     746:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     749:	8b 45 08             	mov    0x8(%ebp),%eax
{
     74c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     74f:	8b 7d 10             	mov    0x10(%ebp),%edi
  s = *ps;
     752:	8b 30                	mov    (%eax),%esi
  while(s < es && strchr(whitespace, *s))
     754:	39 de                	cmp    %ebx,%esi
     756:	72 0f                	jb     767 <gettoken+0x27>
     758:	eb 25                	jmp    77f <gettoken+0x3f>
     75a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     760:	83 c6 01             	add    $0x1,%esi
  while(s < es && strchr(whitespace, *s))
     763:	39 f3                	cmp    %esi,%ebx
     765:	74 18                	je     77f <gettoken+0x3f>
     767:	0f be 06             	movsbl (%esi),%eax
     76a:	83 ec 08             	sub    $0x8,%esp
     76d:	50                   	push   %eax
     76e:	68 d8 1d 00 00       	push   $0x1dd8
     773:	e8 f8 06 00 00       	call   e70 <strchr>
     778:	83 c4 10             	add    $0x10,%esp
     77b:	85 c0                	test   %eax,%eax
     77d:	75 e1                	jne    760 <gettoken+0x20>
  if(q)
     77f:	85 ff                	test   %edi,%edi
     781:	74 02                	je     785 <gettoken+0x45>
    *q = s;
     783:	89 37                	mov    %esi,(%edi)
  ret = *s;
     785:	0f be 06             	movsbl (%esi),%eax
  switch(*s){
     788:	3c 29                	cmp    $0x29,%al
     78a:	0f 8f b8 00 00 00    	jg     848 <gettoken+0x108>
     790:	3c 28                	cmp    $0x28,%al
     792:	0f 8d de 00 00 00    	jge    876 <gettoken+0x136>
     798:	31 ff                	xor    %edi,%edi
     79a:	84 c0                	test   %al,%al
     79c:	75 42                	jne    7e0 <gettoken+0xa0>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     79e:	8b 55 14             	mov    0x14(%ebp),%edx
     7a1:	85 d2                	test   %edx,%edx
     7a3:	74 05                	je     7aa <gettoken+0x6a>
    *eq = s;
     7a5:	8b 45 14             	mov    0x14(%ebp),%eax
     7a8:	89 30                	mov    %esi,(%eax)

  while(s < es && strchr(whitespace, *s))
     7aa:	39 de                	cmp    %ebx,%esi
     7ac:	72 09                	jb     7b7 <gettoken+0x77>
     7ae:	eb 1f                	jmp    7cf <gettoken+0x8f>
    s++;
     7b0:	83 c6 01             	add    $0x1,%esi
  while(s < es && strchr(whitespace, *s))
     7b3:	39 f3                	cmp    %esi,%ebx
     7b5:	74 18                	je     7cf <gettoken+0x8f>
     7b7:	0f be 06             	movsbl (%esi),%eax
     7ba:	83 ec 08             	sub    $0x8,%esp
     7bd:	50                   	push   %eax
     7be:	68 d8 1d 00 00       	push   $0x1dd8
     7c3:	e8 a8 06 00 00       	call   e70 <strchr>
     7c8:	83 c4 10             	add    $0x10,%esp
     7cb:	85 c0                	test   %eax,%eax
     7cd:	75 e1                	jne    7b0 <gettoken+0x70>
  *ps = s;
     7cf:	8b 45 08             	mov    0x8(%ebp),%eax
     7d2:	89 30                	mov    %esi,(%eax)
  return ret;
}
     7d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7d7:	89 f8                	mov    %edi,%eax
     7d9:	5b                   	pop    %ebx
     7da:	5e                   	pop    %esi
     7db:	5f                   	pop    %edi
     7dc:	5d                   	pop    %ebp
     7dd:	c3                   	ret    
     7de:	66 90                	xchg   %ax,%ax
  switch(*s){
     7e0:	3c 26                	cmp    $0x26,%al
     7e2:	0f 84 8e 00 00 00    	je     876 <gettoken+0x136>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     7e8:	39 f3                	cmp    %esi,%ebx
     7ea:	77 36                	ja     822 <gettoken+0xe2>
  if(eq)
     7ec:	8b 45 14             	mov    0x14(%ebp),%eax
     7ef:	bf 61 00 00 00       	mov    $0x61,%edi
     7f4:	85 c0                	test   %eax,%eax
     7f6:	75 ad                	jne    7a5 <gettoken+0x65>
     7f8:	eb d5                	jmp    7cf <gettoken+0x8f>
     7fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     800:	0f be 06             	movsbl (%esi),%eax
     803:	83 ec 08             	sub    $0x8,%esp
     806:	50                   	push   %eax
     807:	68 d0 1d 00 00       	push   $0x1dd0
     80c:	e8 5f 06 00 00       	call   e70 <strchr>
     811:	83 c4 10             	add    $0x10,%esp
     814:	85 c0                	test   %eax,%eax
     816:	75 1f                	jne    837 <gettoken+0xf7>
      s++;
     818:	83 c6 01             	add    $0x1,%esi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     81b:	39 f3                	cmp    %esi,%ebx
     81d:	74 cd                	je     7ec <gettoken+0xac>
     81f:	0f be 06             	movsbl (%esi),%eax
     822:	83 ec 08             	sub    $0x8,%esp
     825:	50                   	push   %eax
     826:	68 d8 1d 00 00       	push   $0x1dd8
     82b:	e8 40 06 00 00       	call   e70 <strchr>
     830:	83 c4 10             	add    $0x10,%esp
     833:	85 c0                	test   %eax,%eax
     835:	74 c9                	je     800 <gettoken+0xc0>
    ret = 'a';
     837:	bf 61 00 00 00       	mov    $0x61,%edi
     83c:	e9 5d ff ff ff       	jmp    79e <gettoken+0x5e>
     841:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     848:	3c 3e                	cmp    $0x3e,%al
     84a:	75 1c                	jne    868 <gettoken+0x128>
    if(*s == '>'){
     84c:	80 7e 01 3e          	cmpb   $0x3e,0x1(%esi)
    s++;
     850:	8d 46 01             	lea    0x1(%esi),%eax
    if(*s == '>'){
     853:	74 3c                	je     891 <gettoken+0x151>
    s++;
     855:	89 c6                	mov    %eax,%esi
     857:	bf 3e 00 00 00       	mov    $0x3e,%edi
     85c:	e9 3d ff ff ff       	jmp    79e <gettoken+0x5e>
     861:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     868:	7f 1e                	jg     888 <gettoken+0x148>
     86a:	8d 48 c5             	lea    -0x3b(%eax),%ecx
     86d:	80 f9 01             	cmp    $0x1,%cl
     870:	0f 87 72 ff ff ff    	ja     7e8 <gettoken+0xa8>
  ret = *s;
     876:	0f be f8             	movsbl %al,%edi
    s++;
     879:	83 c6 01             	add    $0x1,%esi
    break;
     87c:	e9 1d ff ff ff       	jmp    79e <gettoken+0x5e>
     881:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     888:	3c 7c                	cmp    $0x7c,%al
     88a:	74 ea                	je     876 <gettoken+0x136>
     88c:	e9 57 ff ff ff       	jmp    7e8 <gettoken+0xa8>
      s++;
     891:	83 c6 02             	add    $0x2,%esi
      ret = '+';
     894:	bf 2b 00 00 00       	mov    $0x2b,%edi
     899:	e9 00 ff ff ff       	jmp    79e <gettoken+0x5e>
     89e:	66 90                	xchg   %ax,%ax

000008a0 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     8a0:	55                   	push   %ebp
     8a1:	89 e5                	mov    %esp,%ebp
     8a3:	57                   	push   %edi
     8a4:	56                   	push   %esi
     8a5:	53                   	push   %ebx
     8a6:	83 ec 0c             	sub    $0xc,%esp
     8a9:	8b 7d 08             	mov    0x8(%ebp),%edi
     8ac:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     8af:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     8b1:	39 f3                	cmp    %esi,%ebx
     8b3:	72 12                	jb     8c7 <peek+0x27>
     8b5:	eb 28                	jmp    8df <peek+0x3f>
     8b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     8be:	66 90                	xchg   %ax,%ax
    s++;
     8c0:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     8c3:	39 de                	cmp    %ebx,%esi
     8c5:	74 18                	je     8df <peek+0x3f>
     8c7:	0f be 03             	movsbl (%ebx),%eax
     8ca:	83 ec 08             	sub    $0x8,%esp
     8cd:	50                   	push   %eax
     8ce:	68 d8 1d 00 00       	push   $0x1dd8
     8d3:	e8 98 05 00 00       	call   e70 <strchr>
     8d8:	83 c4 10             	add    $0x10,%esp
     8db:	85 c0                	test   %eax,%eax
     8dd:	75 e1                	jne    8c0 <peek+0x20>
  *ps = s;
     8df:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     8e1:	0f be 13             	movsbl (%ebx),%edx
     8e4:	31 c0                	xor    %eax,%eax
     8e6:	84 d2                	test   %dl,%dl
     8e8:	75 0e                	jne    8f8 <peek+0x58>
}
     8ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8ed:	5b                   	pop    %ebx
     8ee:	5e                   	pop    %esi
     8ef:	5f                   	pop    %edi
     8f0:	5d                   	pop    %ebp
     8f1:	c3                   	ret    
     8f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return *s && strchr(toks, *s);
     8f8:	83 ec 08             	sub    $0x8,%esp
     8fb:	52                   	push   %edx
     8fc:	ff 75 10             	pushl  0x10(%ebp)
     8ff:	e8 6c 05 00 00       	call   e70 <strchr>
     904:	83 c4 10             	add    $0x10,%esp
     907:	85 c0                	test   %eax,%eax
     909:	0f 95 c0             	setne  %al
}
     90c:	8d 65 f4             	lea    -0xc(%ebp),%esp
     90f:	5b                   	pop    %ebx
  return *s && strchr(toks, *s);
     910:	0f b6 c0             	movzbl %al,%eax
}
     913:	5e                   	pop    %esi
     914:	5f                   	pop    %edi
     915:	5d                   	pop    %ebp
     916:	c3                   	ret    
     917:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     91e:	66 90                	xchg   %ax,%ax

00000920 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     920:	55                   	push   %ebp
     921:	89 e5                	mov    %esp,%ebp
     923:	57                   	push   %edi
     924:	56                   	push   %esi
     925:	53                   	push   %ebx
     926:	83 ec 1c             	sub    $0x1c,%esp
     929:	8b 75 0c             	mov    0xc(%ebp),%esi
     92c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     92f:	90                   	nop
     930:	83 ec 04             	sub    $0x4,%esp
     933:	68 5f 16 00 00       	push   $0x165f
     938:	53                   	push   %ebx
     939:	56                   	push   %esi
     93a:	e8 61 ff ff ff       	call   8a0 <peek>
     93f:	83 c4 10             	add    $0x10,%esp
     942:	85 c0                	test   %eax,%eax
     944:	74 6a                	je     9b0 <parseredirs+0x90>
    tok = gettoken(ps, es, 0, 0);
     946:	6a 00                	push   $0x0
     948:	6a 00                	push   $0x0
     94a:	53                   	push   %ebx
     94b:	56                   	push   %esi
     94c:	e8 ef fd ff ff       	call   740 <gettoken>
     951:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     953:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     956:	50                   	push   %eax
     957:	8d 45 e0             	lea    -0x20(%ebp),%eax
     95a:	50                   	push   %eax
     95b:	53                   	push   %ebx
     95c:	56                   	push   %esi
     95d:	e8 de fd ff ff       	call   740 <gettoken>
     962:	83 c4 20             	add    $0x20,%esp
     965:	83 f8 61             	cmp    $0x61,%eax
     968:	75 51                	jne    9bb <parseredirs+0x9b>
      panic("missing file for redirection");
    switch(tok){
     96a:	83 ff 3c             	cmp    $0x3c,%edi
     96d:	74 31                	je     9a0 <parseredirs+0x80>
     96f:	83 ff 3e             	cmp    $0x3e,%edi
     972:	74 05                	je     979 <parseredirs+0x59>
     974:	83 ff 2b             	cmp    $0x2b,%edi
     977:	75 b7                	jne    930 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     979:	83 ec 0c             	sub    $0xc,%esp
     97c:	6a 01                	push   $0x1
     97e:	68 01 02 00 00       	push   $0x201
     983:	ff 75 e4             	pushl  -0x1c(%ebp)
     986:	ff 75 e0             	pushl  -0x20(%ebp)
     989:	ff 75 08             	pushl  0x8(%ebp)
     98c:	e8 af fc ff ff       	call   640 <redircmd>
      break;
     991:	83 c4 20             	add    $0x20,%esp
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     994:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     997:	eb 97                	jmp    930 <parseredirs+0x10>
     999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     9a0:	83 ec 0c             	sub    $0xc,%esp
     9a3:	6a 00                	push   $0x0
     9a5:	6a 00                	push   $0x0
     9a7:	eb da                	jmp    983 <parseredirs+0x63>
     9a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }
  return cmd;
}
     9b0:	8b 45 08             	mov    0x8(%ebp),%eax
     9b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     9b6:	5b                   	pop    %ebx
     9b7:	5e                   	pop    %esi
     9b8:	5f                   	pop    %edi
     9b9:	5d                   	pop    %ebp
     9ba:	c3                   	ret    
      panic("missing file for redirection");
     9bb:	83 ec 0c             	sub    $0xc,%esp
     9be:	68 42 16 00 00       	push   $0x1642
     9c3:	e8 58 fa ff ff       	call   420 <panic>
     9c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     9cf:	90                   	nop

000009d0 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     9d0:	55                   	push   %ebp
     9d1:	89 e5                	mov    %esp,%ebp
     9d3:	57                   	push   %edi
     9d4:	56                   	push   %esi
     9d5:	53                   	push   %ebx
     9d6:	83 ec 30             	sub    $0x30,%esp
     9d9:	8b 75 08             	mov    0x8(%ebp),%esi
     9dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     9df:	68 62 16 00 00       	push   $0x1662
     9e4:	57                   	push   %edi
     9e5:	56                   	push   %esi
     9e6:	e8 b5 fe ff ff       	call   8a0 <peek>
     9eb:	83 c4 10             	add    $0x10,%esp
     9ee:	85 c0                	test   %eax,%eax
     9f0:	0f 85 92 00 00 00    	jne    a88 <parseexec+0xb8>
     9f6:	89 c3                	mov    %eax,%ebx
    return parseblock(ps, es);

  ret = execcmd();
     9f8:	e8 13 fc ff ff       	call   610 <execcmd>
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     9fd:	83 ec 04             	sub    $0x4,%esp
     a00:	57                   	push   %edi
     a01:	56                   	push   %esi
     a02:	50                   	push   %eax
  ret = execcmd();
     a03:	89 45 d0             	mov    %eax,-0x30(%ebp)
  ret = parseredirs(ret, ps, es);
     a06:	e8 15 ff ff ff       	call   920 <parseredirs>
     a0b:	83 c4 10             	add    $0x10,%esp
     a0e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     a11:	eb 18                	jmp    a2b <parseexec+0x5b>
     a13:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     a17:	90                   	nop
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     a18:	83 ec 04             	sub    $0x4,%esp
     a1b:	57                   	push   %edi
     a1c:	56                   	push   %esi
     a1d:	ff 75 d4             	pushl  -0x2c(%ebp)
     a20:	e8 fb fe ff ff       	call   920 <parseredirs>
     a25:	83 c4 10             	add    $0x10,%esp
     a28:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     a2b:	83 ec 04             	sub    $0x4,%esp
     a2e:	68 79 16 00 00       	push   $0x1679
     a33:	57                   	push   %edi
     a34:	56                   	push   %esi
     a35:	e8 66 fe ff ff       	call   8a0 <peek>
     a3a:	83 c4 10             	add    $0x10,%esp
     a3d:	85 c0                	test   %eax,%eax
     a3f:	75 67                	jne    aa8 <parseexec+0xd8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     a41:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     a44:	50                   	push   %eax
     a45:	8d 45 e0             	lea    -0x20(%ebp),%eax
     a48:	50                   	push   %eax
     a49:	57                   	push   %edi
     a4a:	56                   	push   %esi
     a4b:	e8 f0 fc ff ff       	call   740 <gettoken>
     a50:	83 c4 10             	add    $0x10,%esp
     a53:	85 c0                	test   %eax,%eax
     a55:	74 51                	je     aa8 <parseexec+0xd8>
    if(tok != 'a')
     a57:	83 f8 61             	cmp    $0x61,%eax
     a5a:	75 6b                	jne    ac7 <parseexec+0xf7>
    cmd->argv[argc] = q;
     a5c:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a5f:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a62:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
    cmd->eargv[argc] = eq;
     a66:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a69:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
    argc++;
     a6d:	83 c3 01             	add    $0x1,%ebx
    if(argc >= MAXARGS)
     a70:	83 fb 0a             	cmp    $0xa,%ebx
     a73:	75 a3                	jne    a18 <parseexec+0x48>
      panic("too many args");
     a75:	83 ec 0c             	sub    $0xc,%esp
     a78:	68 6b 16 00 00       	push   $0x166b
     a7d:	e8 9e f9 ff ff       	call   420 <panic>
     a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     a88:	83 ec 08             	sub    $0x8,%esp
     a8b:	57                   	push   %edi
     a8c:	56                   	push   %esi
     a8d:	e8 5e 01 00 00       	call   bf0 <parseblock>
     a92:	83 c4 10             	add    $0x10,%esp
     a95:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     a98:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     a9b:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a9e:	5b                   	pop    %ebx
     a9f:	5e                   	pop    %esi
     aa0:	5f                   	pop    %edi
     aa1:	5d                   	pop    %ebp
     aa2:	c3                   	ret    
     aa3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     aa7:	90                   	nop
  cmd->argv[argc] = 0;
     aa8:	8b 45 d0             	mov    -0x30(%ebp),%eax
     aab:	8d 04 98             	lea    (%eax,%ebx,4),%eax
     aae:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  cmd->eargv[argc] = 0;
     ab5:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
}
     abc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     abf:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ac2:	5b                   	pop    %ebx
     ac3:	5e                   	pop    %esi
     ac4:	5f                   	pop    %edi
     ac5:	5d                   	pop    %ebp
     ac6:	c3                   	ret    
      panic("syntax");
     ac7:	83 ec 0c             	sub    $0xc,%esp
     aca:	68 64 16 00 00       	push   $0x1664
     acf:	e8 4c f9 ff ff       	call   420 <panic>
     ad4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     adb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     adf:	90                   	nop

00000ae0 <parsepipe>:
{
     ae0:	55                   	push   %ebp
     ae1:	89 e5                	mov    %esp,%ebp
     ae3:	57                   	push   %edi
     ae4:	56                   	push   %esi
     ae5:	53                   	push   %ebx
     ae6:	83 ec 14             	sub    $0x14,%esp
     ae9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     aec:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parseexec(ps, es);
     aef:	56                   	push   %esi
     af0:	53                   	push   %ebx
     af1:	e8 da fe ff ff       	call   9d0 <parseexec>
  if(peek(ps, es, "|")){
     af6:	83 c4 0c             	add    $0xc,%esp
     af9:	68 7e 16 00 00       	push   $0x167e
  cmd = parseexec(ps, es);
     afe:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
     b00:	56                   	push   %esi
     b01:	53                   	push   %ebx
     b02:	e8 99 fd ff ff       	call   8a0 <peek>
     b07:	83 c4 10             	add    $0x10,%esp
     b0a:	85 c0                	test   %eax,%eax
     b0c:	75 12                	jne    b20 <parsepipe+0x40>
}
     b0e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b11:	89 f8                	mov    %edi,%eax
     b13:	5b                   	pop    %ebx
     b14:	5e                   	pop    %esi
     b15:	5f                   	pop    %edi
     b16:	5d                   	pop    %ebp
     b17:	c3                   	ret    
     b18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b1f:	90                   	nop
    gettoken(ps, es, 0, 0);
     b20:	6a 00                	push   $0x0
     b22:	6a 00                	push   $0x0
     b24:	56                   	push   %esi
     b25:	53                   	push   %ebx
     b26:	e8 15 fc ff ff       	call   740 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     b2b:	58                   	pop    %eax
     b2c:	5a                   	pop    %edx
     b2d:	56                   	push   %esi
     b2e:	53                   	push   %ebx
     b2f:	e8 ac ff ff ff       	call   ae0 <parsepipe>
     b34:	89 7d 08             	mov    %edi,0x8(%ebp)
     b37:	83 c4 10             	add    $0x10,%esp
     b3a:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     b3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b40:	5b                   	pop    %ebx
     b41:	5e                   	pop    %esi
     b42:	5f                   	pop    %edi
     b43:	5d                   	pop    %ebp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     b44:	e9 47 fb ff ff       	jmp    690 <pipecmd>
     b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000b50 <parseline>:
{
     b50:	55                   	push   %ebp
     b51:	89 e5                	mov    %esp,%ebp
     b53:	57                   	push   %edi
     b54:	56                   	push   %esi
     b55:	53                   	push   %ebx
     b56:	83 ec 14             	sub    $0x14,%esp
     b59:	8b 5d 08             	mov    0x8(%ebp),%ebx
     b5c:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parsepipe(ps, es);
     b5f:	56                   	push   %esi
     b60:	53                   	push   %ebx
     b61:	e8 7a ff ff ff       	call   ae0 <parsepipe>
  while(peek(ps, es, "&")){
     b66:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
     b69:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     b6b:	eb 1b                	jmp    b88 <parseline+0x38>
     b6d:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     b70:	6a 00                	push   $0x0
     b72:	6a 00                	push   $0x0
     b74:	56                   	push   %esi
     b75:	53                   	push   %ebx
     b76:	e8 c5 fb ff ff       	call   740 <gettoken>
    cmd = backcmd(cmd);
     b7b:	89 3c 24             	mov    %edi,(%esp)
     b7e:	e8 8d fb ff ff       	call   710 <backcmd>
     b83:	83 c4 10             	add    $0x10,%esp
     b86:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     b88:	83 ec 04             	sub    $0x4,%esp
     b8b:	68 80 16 00 00       	push   $0x1680
     b90:	56                   	push   %esi
     b91:	53                   	push   %ebx
     b92:	e8 09 fd ff ff       	call   8a0 <peek>
     b97:	83 c4 10             	add    $0x10,%esp
     b9a:	85 c0                	test   %eax,%eax
     b9c:	75 d2                	jne    b70 <parseline+0x20>
  if(peek(ps, es, ";")){
     b9e:	83 ec 04             	sub    $0x4,%esp
     ba1:	68 7c 16 00 00       	push   $0x167c
     ba6:	56                   	push   %esi
     ba7:	53                   	push   %ebx
     ba8:	e8 f3 fc ff ff       	call   8a0 <peek>
     bad:	83 c4 10             	add    $0x10,%esp
     bb0:	85 c0                	test   %eax,%eax
     bb2:	75 0c                	jne    bc0 <parseline+0x70>
}
     bb4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     bb7:	89 f8                	mov    %edi,%eax
     bb9:	5b                   	pop    %ebx
     bba:	5e                   	pop    %esi
     bbb:	5f                   	pop    %edi
     bbc:	5d                   	pop    %ebp
     bbd:	c3                   	ret    
     bbe:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     bc0:	6a 00                	push   $0x0
     bc2:	6a 00                	push   $0x0
     bc4:	56                   	push   %esi
     bc5:	53                   	push   %ebx
     bc6:	e8 75 fb ff ff       	call   740 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     bcb:	58                   	pop    %eax
     bcc:	5a                   	pop    %edx
     bcd:	56                   	push   %esi
     bce:	53                   	push   %ebx
     bcf:	e8 7c ff ff ff       	call   b50 <parseline>
     bd4:	89 7d 08             	mov    %edi,0x8(%ebp)
     bd7:	83 c4 10             	add    $0x10,%esp
     bda:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     bdd:	8d 65 f4             	lea    -0xc(%ebp),%esp
     be0:	5b                   	pop    %ebx
     be1:	5e                   	pop    %esi
     be2:	5f                   	pop    %edi
     be3:	5d                   	pop    %ebp
    cmd = listcmd(cmd, parseline(ps, es));
     be4:	e9 e7 fa ff ff       	jmp    6d0 <listcmd>
     be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000bf0 <parseblock>:
{
     bf0:	55                   	push   %ebp
     bf1:	89 e5                	mov    %esp,%ebp
     bf3:	57                   	push   %edi
     bf4:	56                   	push   %esi
     bf5:	53                   	push   %ebx
     bf6:	83 ec 10             	sub    $0x10,%esp
     bf9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     bfc:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     bff:	68 62 16 00 00       	push   $0x1662
     c04:	56                   	push   %esi
     c05:	53                   	push   %ebx
     c06:	e8 95 fc ff ff       	call   8a0 <peek>
     c0b:	83 c4 10             	add    $0x10,%esp
     c0e:	85 c0                	test   %eax,%eax
     c10:	74 4a                	je     c5c <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     c12:	6a 00                	push   $0x0
     c14:	6a 00                	push   $0x0
     c16:	56                   	push   %esi
     c17:	53                   	push   %ebx
     c18:	e8 23 fb ff ff       	call   740 <gettoken>
  cmd = parseline(ps, es);
     c1d:	58                   	pop    %eax
     c1e:	5a                   	pop    %edx
     c1f:	56                   	push   %esi
     c20:	53                   	push   %ebx
     c21:	e8 2a ff ff ff       	call   b50 <parseline>
  if(!peek(ps, es, ")"))
     c26:	83 c4 0c             	add    $0xc,%esp
     c29:	68 9e 16 00 00       	push   $0x169e
  cmd = parseline(ps, es);
     c2e:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     c30:	56                   	push   %esi
     c31:	53                   	push   %ebx
     c32:	e8 69 fc ff ff       	call   8a0 <peek>
     c37:	83 c4 10             	add    $0x10,%esp
     c3a:	85 c0                	test   %eax,%eax
     c3c:	74 2b                	je     c69 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
     c3e:	6a 00                	push   $0x0
     c40:	6a 00                	push   $0x0
     c42:	56                   	push   %esi
     c43:	53                   	push   %ebx
     c44:	e8 f7 fa ff ff       	call   740 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     c49:	83 c4 0c             	add    $0xc,%esp
     c4c:	56                   	push   %esi
     c4d:	53                   	push   %ebx
     c4e:	57                   	push   %edi
     c4f:	e8 cc fc ff ff       	call   920 <parseredirs>
}
     c54:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c57:	5b                   	pop    %ebx
     c58:	5e                   	pop    %esi
     c59:	5f                   	pop    %edi
     c5a:	5d                   	pop    %ebp
     c5b:	c3                   	ret    
    panic("parseblock");
     c5c:	83 ec 0c             	sub    $0xc,%esp
     c5f:	68 82 16 00 00       	push   $0x1682
     c64:	e8 b7 f7 ff ff       	call   420 <panic>
    panic("syntax - missing )");
     c69:	83 ec 0c             	sub    $0xc,%esp
     c6c:	68 8d 16 00 00       	push   $0x168d
     c71:	e8 aa f7 ff ff       	call   420 <panic>
     c76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c7d:	8d 76 00             	lea    0x0(%esi),%esi

00000c80 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     c80:	55                   	push   %ebp
     c81:	89 e5                	mov    %esp,%ebp
     c83:	53                   	push   %ebx
     c84:	83 ec 04             	sub    $0x4,%esp
     c87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     c8a:	85 db                	test   %ebx,%ebx
     c8c:	74 20                	je     cae <nulterminate+0x2e>
    return 0;

  switch(cmd->type){
     c8e:	83 3b 05             	cmpl   $0x5,(%ebx)
     c91:	77 1b                	ja     cae <nulterminate+0x2e>
     c93:	8b 03                	mov    (%ebx),%eax
     c95:	ff 24 85 e0 16 00 00 	jmp    *0x16e0(,%eax,4)
     c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
     ca0:	83 ec 0c             	sub    $0xc,%esp
     ca3:	ff 73 04             	pushl  0x4(%ebx)
     ca6:	e8 d5 ff ff ff       	call   c80 <nulterminate>
    break;
     cab:	83 c4 10             	add    $0x10,%esp
  }
  return cmd;
}
     cae:	89 d8                	mov    %ebx,%eax
     cb0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     cb3:	c9                   	leave  
     cb4:	c3                   	ret    
     cb5:	8d 76 00             	lea    0x0(%esi),%esi
    nulterminate(lcmd->left);
     cb8:	83 ec 0c             	sub    $0xc,%esp
     cbb:	ff 73 04             	pushl  0x4(%ebx)
     cbe:	e8 bd ff ff ff       	call   c80 <nulterminate>
    nulterminate(lcmd->right);
     cc3:	58                   	pop    %eax
     cc4:	ff 73 08             	pushl  0x8(%ebx)
     cc7:	e8 b4 ff ff ff       	call   c80 <nulterminate>
}
     ccc:	89 d8                	mov    %ebx,%eax
    break;
     cce:	83 c4 10             	add    $0x10,%esp
}
     cd1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     cd4:	c9                   	leave  
     cd5:	c3                   	ret    
     cd6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     cdd:	8d 76 00             	lea    0x0(%esi),%esi
    for(i=0; ecmd->argv[i]; i++)
     ce0:	8b 4b 04             	mov    0x4(%ebx),%ecx
     ce3:	8d 43 08             	lea    0x8(%ebx),%eax
     ce6:	85 c9                	test   %ecx,%ecx
     ce8:	74 c4                	je     cae <nulterminate+0x2e>
     cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     cf0:	8b 50 24             	mov    0x24(%eax),%edx
     cf3:	83 c0 04             	add    $0x4,%eax
     cf6:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     cf9:	8b 50 fc             	mov    -0x4(%eax),%edx
     cfc:	85 d2                	test   %edx,%edx
     cfe:	75 f0                	jne    cf0 <nulterminate+0x70>
}
     d00:	89 d8                	mov    %ebx,%eax
     d02:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d05:	c9                   	leave  
     d06:	c3                   	ret    
     d07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d0e:	66 90                	xchg   %ax,%ax
    nulterminate(rcmd->cmd);
     d10:	83 ec 0c             	sub    $0xc,%esp
     d13:	ff 73 04             	pushl  0x4(%ebx)
     d16:	e8 65 ff ff ff       	call   c80 <nulterminate>
    *rcmd->efile = 0;
     d1b:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     d1e:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     d21:	c6 00 00             	movb   $0x0,(%eax)
}
     d24:	89 d8                	mov    %ebx,%eax
     d26:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d29:	c9                   	leave  
     d2a:	c3                   	ret    
     d2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d2f:	90                   	nop

00000d30 <parsecmd>:
{
     d30:	55                   	push   %ebp
     d31:	89 e5                	mov    %esp,%ebp
     d33:	56                   	push   %esi
     d34:	53                   	push   %ebx
  es = s + strlen(s);
     d35:	8b 5d 08             	mov    0x8(%ebp),%ebx
     d38:	83 ec 0c             	sub    $0xc,%esp
     d3b:	53                   	push   %ebx
     d3c:	e8 df 00 00 00       	call   e20 <strlen>
  cmd = parseline(&s, es);
     d41:	59                   	pop    %ecx
     d42:	5e                   	pop    %esi
  es = s + strlen(s);
     d43:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     d45:	8d 45 08             	lea    0x8(%ebp),%eax
     d48:	53                   	push   %ebx
     d49:	50                   	push   %eax
     d4a:	e8 01 fe ff ff       	call   b50 <parseline>
  peek(&s, es, "");
     d4f:	83 c4 0c             	add    $0xc,%esp
  cmd = parseline(&s, es);
     d52:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     d54:	8d 45 08             	lea    0x8(%ebp),%eax
     d57:	68 f5 15 00 00       	push   $0x15f5
     d5c:	53                   	push   %ebx
     d5d:	50                   	push   %eax
     d5e:	e8 3d fb ff ff       	call   8a0 <peek>
  if(s != es){
     d63:	8b 45 08             	mov    0x8(%ebp),%eax
     d66:	83 c4 10             	add    $0x10,%esp
     d69:	39 d8                	cmp    %ebx,%eax
     d6b:	75 12                	jne    d7f <parsecmd+0x4f>
  nulterminate(cmd);
     d6d:	83 ec 0c             	sub    $0xc,%esp
     d70:	56                   	push   %esi
     d71:	e8 0a ff ff ff       	call   c80 <nulterminate>
}
     d76:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d79:	89 f0                	mov    %esi,%eax
     d7b:	5b                   	pop    %ebx
     d7c:	5e                   	pop    %esi
     d7d:	5d                   	pop    %ebp
     d7e:	c3                   	ret    
    printf(2, "leftovers: %s\n", s);
     d7f:	52                   	push   %edx
     d80:	50                   	push   %eax
     d81:	68 a0 16 00 00       	push   $0x16a0
     d86:	6a 02                	push   $0x2
     d88:	e8 d3 04 00 00       	call   1260 <printf>
    panic("syntax");
     d8d:	c7 04 24 64 16 00 00 	movl   $0x1664,(%esp)
     d94:	e8 87 f6 ff ff       	call   420 <panic>
     d99:	66 90                	xchg   %ax,%ax
     d9b:	66 90                	xchg   %ax,%ax
     d9d:	66 90                	xchg   %ax,%ax
     d9f:	90                   	nop

00000da0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     da0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     da1:	31 d2                	xor    %edx,%edx
{
     da3:	89 e5                	mov    %esp,%ebp
     da5:	53                   	push   %ebx
     da6:	8b 45 08             	mov    0x8(%ebp),%eax
     da9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
     db0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
     db4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     db7:	83 c2 01             	add    $0x1,%edx
     dba:	84 c9                	test   %cl,%cl
     dbc:	75 f2                	jne    db0 <strcpy+0x10>
    ;
  return os;
}
     dbe:	5b                   	pop    %ebx
     dbf:	5d                   	pop    %ebp
     dc0:	c3                   	ret    
     dc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     dc8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     dcf:	90                   	nop

00000dd0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     dd0:	55                   	push   %ebp
     dd1:	89 e5                	mov    %esp,%ebp
     dd3:	56                   	push   %esi
     dd4:	53                   	push   %ebx
     dd5:	8b 5d 08             	mov    0x8(%ebp),%ebx
     dd8:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(*p && *p == *q)
     ddb:	0f b6 13             	movzbl (%ebx),%edx
     dde:	0f b6 0e             	movzbl (%esi),%ecx
     de1:	84 d2                	test   %dl,%dl
     de3:	74 1e                	je     e03 <strcmp+0x33>
     de5:	b8 01 00 00 00       	mov    $0x1,%eax
     dea:	38 ca                	cmp    %cl,%dl
     dec:	74 09                	je     df7 <strcmp+0x27>
     dee:	eb 20                	jmp    e10 <strcmp+0x40>
     df0:	83 c0 01             	add    $0x1,%eax
     df3:	38 ca                	cmp    %cl,%dl
     df5:	75 19                	jne    e10 <strcmp+0x40>
     df7:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     dfb:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
     dff:	84 d2                	test   %dl,%dl
     e01:	75 ed                	jne    df0 <strcmp+0x20>
     e03:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
     e05:	5b                   	pop    %ebx
     e06:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
     e07:	29 c8                	sub    %ecx,%eax
}
     e09:	5d                   	pop    %ebp
     e0a:	c3                   	ret    
     e0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e0f:	90                   	nop
     e10:	0f b6 c2             	movzbl %dl,%eax
     e13:	5b                   	pop    %ebx
     e14:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
     e15:	29 c8                	sub    %ecx,%eax
}
     e17:	5d                   	pop    %ebp
     e18:	c3                   	ret    
     e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000e20 <strlen>:

uint
strlen(char *s)
{
     e20:	55                   	push   %ebp
     e21:	89 e5                	mov    %esp,%ebp
     e23:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     e26:	80 39 00             	cmpb   $0x0,(%ecx)
     e29:	74 15                	je     e40 <strlen+0x20>
     e2b:	31 d2                	xor    %edx,%edx
     e2d:	8d 76 00             	lea    0x0(%esi),%esi
     e30:	83 c2 01             	add    $0x1,%edx
     e33:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     e37:	89 d0                	mov    %edx,%eax
     e39:	75 f5                	jne    e30 <strlen+0x10>
    ;
  return n;
}
     e3b:	5d                   	pop    %ebp
     e3c:	c3                   	ret    
     e3d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
     e40:	31 c0                	xor    %eax,%eax
}
     e42:	5d                   	pop    %ebp
     e43:	c3                   	ret    
     e44:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e4f:	90                   	nop

00000e50 <memset>:

void*
memset(void *dst, int c, uint n)
{
     e50:	55                   	push   %ebp
     e51:	89 e5                	mov    %esp,%ebp
     e53:	57                   	push   %edi
     e54:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     e57:	8b 4d 10             	mov    0x10(%ebp),%ecx
     e5a:	8b 45 0c             	mov    0xc(%ebp),%eax
     e5d:	89 d7                	mov    %edx,%edi
     e5f:	fc                   	cld    
     e60:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     e62:	89 d0                	mov    %edx,%eax
     e64:	5f                   	pop    %edi
     e65:	5d                   	pop    %ebp
     e66:	c3                   	ret    
     e67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e6e:	66 90                	xchg   %ax,%ax

00000e70 <strchr>:

char*
strchr(const char *s, char c)
{
     e70:	55                   	push   %ebp
     e71:	89 e5                	mov    %esp,%ebp
     e73:	53                   	push   %ebx
     e74:	8b 45 08             	mov    0x8(%ebp),%eax
     e77:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
     e7a:	0f b6 18             	movzbl (%eax),%ebx
     e7d:	84 db                	test   %bl,%bl
     e7f:	74 1d                	je     e9e <strchr+0x2e>
     e81:	89 d1                	mov    %edx,%ecx
    if(*s == c)
     e83:	38 d3                	cmp    %dl,%bl
     e85:	75 0d                	jne    e94 <strchr+0x24>
     e87:	eb 17                	jmp    ea0 <strchr+0x30>
     e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e90:	38 ca                	cmp    %cl,%dl
     e92:	74 0c                	je     ea0 <strchr+0x30>
  for(; *s; s++)
     e94:	83 c0 01             	add    $0x1,%eax
     e97:	0f b6 10             	movzbl (%eax),%edx
     e9a:	84 d2                	test   %dl,%dl
     e9c:	75 f2                	jne    e90 <strchr+0x20>
      return (char*)s;
  return 0;
     e9e:	31 c0                	xor    %eax,%eax
}
     ea0:	5b                   	pop    %ebx
     ea1:	5d                   	pop    %ebp
     ea2:	c3                   	ret    
     ea3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000eb0 <gets>:

char*
gets(char *buf, int max)
{
     eb0:	55                   	push   %ebp
     eb1:	89 e5                	mov    %esp,%ebp
     eb3:	57                   	push   %edi
     eb4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     eb5:	31 f6                	xor    %esi,%esi
{
     eb7:	53                   	push   %ebx
     eb8:	89 f3                	mov    %esi,%ebx
     eba:	83 ec 1c             	sub    $0x1c,%esp
     ebd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
     ec0:	eb 2f                	jmp    ef1 <gets+0x41>
     ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
     ec8:	83 ec 04             	sub    $0x4,%esp
     ecb:	8d 45 e7             	lea    -0x19(%ebp),%eax
     ece:	6a 01                	push   $0x1
     ed0:	50                   	push   %eax
     ed1:	6a 00                	push   $0x0
     ed3:	e8 d1 01 00 00       	call   10a9 <read>
    if(cc < 1)
     ed8:	83 c4 10             	add    $0x10,%esp
     edb:	85 c0                	test   %eax,%eax
     edd:	7e 1c                	jle    efb <gets+0x4b>
      break;
    buf[i++] = c;
     edf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     ee3:	83 c7 01             	add    $0x1,%edi
     ee6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
     ee9:	3c 0a                	cmp    $0xa,%al
     eeb:	74 23                	je     f10 <gets+0x60>
     eed:	3c 0d                	cmp    $0xd,%al
     eef:	74 1f                	je     f10 <gets+0x60>
  for(i=0; i+1 < max; ){
     ef1:	83 c3 01             	add    $0x1,%ebx
     ef4:	89 fe                	mov    %edi,%esi
     ef6:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     ef9:	7c cd                	jl     ec8 <gets+0x18>
     efb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
     efd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
     f00:	c6 03 00             	movb   $0x0,(%ebx)
}
     f03:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f06:	5b                   	pop    %ebx
     f07:	5e                   	pop    %esi
     f08:	5f                   	pop    %edi
     f09:	5d                   	pop    %ebp
     f0a:	c3                   	ret    
     f0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     f0f:	90                   	nop
     f10:	8b 75 08             	mov    0x8(%ebp),%esi
     f13:	8b 45 08             	mov    0x8(%ebp),%eax
     f16:	01 de                	add    %ebx,%esi
     f18:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
     f1a:	c6 03 00             	movb   $0x0,(%ebx)
}
     f1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f20:	5b                   	pop    %ebx
     f21:	5e                   	pop    %esi
     f22:	5f                   	pop    %edi
     f23:	5d                   	pop    %ebp
     f24:	c3                   	ret    
     f25:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000f30 <stat>:

int
stat(char *n, struct stat *st)
{
     f30:	55                   	push   %ebp
     f31:	89 e5                	mov    %esp,%ebp
     f33:	56                   	push   %esi
     f34:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     f35:	83 ec 08             	sub    $0x8,%esp
     f38:	6a 00                	push   $0x0
     f3a:	ff 75 08             	pushl  0x8(%ebp)
     f3d:	e8 8f 01 00 00       	call   10d1 <open>
  if(fd < 0)
     f42:	83 c4 10             	add    $0x10,%esp
     f45:	85 c0                	test   %eax,%eax
     f47:	78 27                	js     f70 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     f49:	83 ec 08             	sub    $0x8,%esp
     f4c:	ff 75 0c             	pushl  0xc(%ebp)
     f4f:	89 c3                	mov    %eax,%ebx
     f51:	50                   	push   %eax
     f52:	e8 92 01 00 00       	call   10e9 <fstat>
  close(fd);
     f57:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     f5a:	89 c6                	mov    %eax,%esi
  close(fd);
     f5c:	e8 58 01 00 00       	call   10b9 <close>
  return r;
     f61:	83 c4 10             	add    $0x10,%esp
}
     f64:	8d 65 f8             	lea    -0x8(%ebp),%esp
     f67:	89 f0                	mov    %esi,%eax
     f69:	5b                   	pop    %ebx
     f6a:	5e                   	pop    %esi
     f6b:	5d                   	pop    %ebp
     f6c:	c3                   	ret    
     f6d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     f70:	be ff ff ff ff       	mov    $0xffffffff,%esi
     f75:	eb ed                	jmp    f64 <stat+0x34>
     f77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f7e:	66 90                	xchg   %ax,%ax

00000f80 <atoi>:

#ifdef PDX_XV6
int
atoi(const char *s)
{
     f80:	55                   	push   %ebp
     f81:	89 e5                	mov    %esp,%ebp
     f83:	56                   	push   %esi
     f84:	8b 55 08             	mov    0x8(%ebp),%edx
     f87:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
     f88:	0f b6 0a             	movzbl (%edx),%ecx
     f8b:	80 f9 20             	cmp    $0x20,%cl
     f8e:	75 0b                	jne    f9b <atoi+0x1b>
     f90:	83 c2 01             	add    $0x1,%edx
     f93:	0f b6 0a             	movzbl (%edx),%ecx
     f96:	80 f9 20             	cmp    $0x20,%cl
     f99:	74 f5                	je     f90 <atoi+0x10>
  sign = (*s == '-') ? -1 : 1;
     f9b:	80 f9 2d             	cmp    $0x2d,%cl
     f9e:	74 40                	je     fe0 <atoi+0x60>
     fa0:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
     fa5:	80 f9 2b             	cmp    $0x2b,%cl
     fa8:	74 3b                	je     fe5 <atoi+0x65>
    s++;
  while('0' <= *s && *s <= '9')
     faa:	0f be 0a             	movsbl (%edx),%ecx
     fad:	8d 41 d0             	lea    -0x30(%ecx),%eax
     fb0:	3c 09                	cmp    $0x9,%al
     fb2:	b8 00 00 00 00       	mov    $0x0,%eax
     fb7:	77 1f                	ja     fd8 <atoi+0x58>
     fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
     fc0:	83 c2 01             	add    $0x1,%edx
     fc3:	8d 04 80             	lea    (%eax,%eax,4),%eax
     fc6:	8d 44 41 d0          	lea    -0x30(%ecx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     fca:	0f be 0a             	movsbl (%edx),%ecx
     fcd:	8d 59 d0             	lea    -0x30(%ecx),%ebx
     fd0:	80 fb 09             	cmp    $0x9,%bl
     fd3:	76 eb                	jbe    fc0 <atoi+0x40>
     fd5:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
     fd8:	5b                   	pop    %ebx
     fd9:	5e                   	pop    %esi
     fda:	5d                   	pop    %ebp
     fdb:	c3                   	ret    
     fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
     fe0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
     fe5:	83 c2 01             	add    $0x1,%edx
     fe8:	eb c0                	jmp    faa <atoi+0x2a>
     fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000ff0 <atoo>:

int
atoo(const char *s)
{
     ff0:	55                   	push   %ebp
     ff1:	89 e5                	mov    %esp,%ebp
     ff3:	56                   	push   %esi
     ff4:	8b 55 08             	mov    0x8(%ebp),%edx
     ff7:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
     ff8:	0f b6 0a             	movzbl (%edx),%ecx
     ffb:	80 f9 20             	cmp    $0x20,%cl
     ffe:	75 0b                	jne    100b <atoo+0x1b>
    1000:	83 c2 01             	add    $0x1,%edx
    1003:	0f b6 0a             	movzbl (%edx),%ecx
    1006:	80 f9 20             	cmp    $0x20,%cl
    1009:	74 f5                	je     1000 <atoo+0x10>
  sign = (*s == '-') ? -1 : 1;
    100b:	80 f9 2d             	cmp    $0x2d,%cl
    100e:	74 40                	je     1050 <atoo+0x60>
    1010:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
    1015:	80 f9 2b             	cmp    $0x2b,%cl
    1018:	74 3b                	je     1055 <atoo+0x65>
    s++;
  while('0' <= *s && *s <= '7')
    101a:	0f be 0a             	movsbl (%edx),%ecx
    101d:	8d 41 d0             	lea    -0x30(%ecx),%eax
    1020:	3c 07                	cmp    $0x7,%al
    1022:	b8 00 00 00 00       	mov    $0x0,%eax
    1027:	77 1c                	ja     1045 <atoo+0x55>
    1029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*8 + *s++ - '0';
    1030:	83 c2 01             	add    $0x1,%edx
    1033:	8d 44 c1 d0          	lea    -0x30(%ecx,%eax,8),%eax
  while('0' <= *s && *s <= '7')
    1037:	0f be 0a             	movsbl (%edx),%ecx
    103a:	8d 59 d0             	lea    -0x30(%ecx),%ebx
    103d:	80 fb 07             	cmp    $0x7,%bl
    1040:	76 ee                	jbe    1030 <atoo+0x40>
    1042:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
    1045:	5b                   	pop    %ebx
    1046:	5e                   	pop    %esi
    1047:	5d                   	pop    %ebp
    1048:	c3                   	ret    
    1049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
    1050:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
    1055:	83 c2 01             	add    $0x1,%edx
    1058:	eb c0                	jmp    101a <atoo+0x2a>
    105a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001060 <memmove>:
}
#endif // PDX_XV6

void*
memmove(void *vdst, void *vsrc, int n)
{
    1060:	55                   	push   %ebp
    1061:	89 e5                	mov    %esp,%ebp
    1063:	57                   	push   %edi
    1064:	8b 55 10             	mov    0x10(%ebp),%edx
    1067:	8b 45 08             	mov    0x8(%ebp),%eax
    106a:	56                   	push   %esi
    106b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    106e:	85 d2                	test   %edx,%edx
    1070:	7e 13                	jle    1085 <memmove+0x25>
    1072:	01 c2                	add    %eax,%edx
  dst = vdst;
    1074:	89 c7                	mov    %eax,%edi
    1076:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    107d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    1080:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    1081:	39 fa                	cmp    %edi,%edx
    1083:	75 fb                	jne    1080 <memmove+0x20>
  return vdst;
}
    1085:	5e                   	pop    %esi
    1086:	5f                   	pop    %edi
    1087:	5d                   	pop    %ebp
    1088:	c3                   	ret    

00001089 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1089:	b8 01 00 00 00       	mov    $0x1,%eax
    108e:	cd 40                	int    $0x40
    1090:	c3                   	ret    

00001091 <exit>:
SYSCALL(exit)
    1091:	b8 02 00 00 00       	mov    $0x2,%eax
    1096:	cd 40                	int    $0x40
    1098:	c3                   	ret    

00001099 <wait>:
SYSCALL(wait)
    1099:	b8 03 00 00 00       	mov    $0x3,%eax
    109e:	cd 40                	int    $0x40
    10a0:	c3                   	ret    

000010a1 <pipe>:
SYSCALL(pipe)
    10a1:	b8 04 00 00 00       	mov    $0x4,%eax
    10a6:	cd 40                	int    $0x40
    10a8:	c3                   	ret    

000010a9 <read>:
SYSCALL(read)
    10a9:	b8 05 00 00 00       	mov    $0x5,%eax
    10ae:	cd 40                	int    $0x40
    10b0:	c3                   	ret    

000010b1 <write>:
SYSCALL(write)
    10b1:	b8 10 00 00 00       	mov    $0x10,%eax
    10b6:	cd 40                	int    $0x40
    10b8:	c3                   	ret    

000010b9 <close>:
SYSCALL(close)
    10b9:	b8 15 00 00 00       	mov    $0x15,%eax
    10be:	cd 40                	int    $0x40
    10c0:	c3                   	ret    

000010c1 <kill>:
SYSCALL(kill)
    10c1:	b8 06 00 00 00       	mov    $0x6,%eax
    10c6:	cd 40                	int    $0x40
    10c8:	c3                   	ret    

000010c9 <exec>:
SYSCALL(exec)
    10c9:	b8 07 00 00 00       	mov    $0x7,%eax
    10ce:	cd 40                	int    $0x40
    10d0:	c3                   	ret    

000010d1 <open>:
SYSCALL(open)
    10d1:	b8 0f 00 00 00       	mov    $0xf,%eax
    10d6:	cd 40                	int    $0x40
    10d8:	c3                   	ret    

000010d9 <mknod>:
SYSCALL(mknod)
    10d9:	b8 11 00 00 00       	mov    $0x11,%eax
    10de:	cd 40                	int    $0x40
    10e0:	c3                   	ret    

000010e1 <unlink>:
SYSCALL(unlink)
    10e1:	b8 12 00 00 00       	mov    $0x12,%eax
    10e6:	cd 40                	int    $0x40
    10e8:	c3                   	ret    

000010e9 <fstat>:
SYSCALL(fstat)
    10e9:	b8 08 00 00 00       	mov    $0x8,%eax
    10ee:	cd 40                	int    $0x40
    10f0:	c3                   	ret    

000010f1 <link>:
SYSCALL(link)
    10f1:	b8 13 00 00 00       	mov    $0x13,%eax
    10f6:	cd 40                	int    $0x40
    10f8:	c3                   	ret    

000010f9 <mkdir>:
SYSCALL(mkdir)
    10f9:	b8 14 00 00 00       	mov    $0x14,%eax
    10fe:	cd 40                	int    $0x40
    1100:	c3                   	ret    

00001101 <chdir>:
SYSCALL(chdir)
    1101:	b8 09 00 00 00       	mov    $0x9,%eax
    1106:	cd 40                	int    $0x40
    1108:	c3                   	ret    

00001109 <dup>:
SYSCALL(dup)
    1109:	b8 0a 00 00 00       	mov    $0xa,%eax
    110e:	cd 40                	int    $0x40
    1110:	c3                   	ret    

00001111 <getpid>:
SYSCALL(getpid)
    1111:	b8 0b 00 00 00       	mov    $0xb,%eax
    1116:	cd 40                	int    $0x40
    1118:	c3                   	ret    

00001119 <sbrk>:
SYSCALL(sbrk)
    1119:	b8 0c 00 00 00       	mov    $0xc,%eax
    111e:	cd 40                	int    $0x40
    1120:	c3                   	ret    

00001121 <sleep>:
SYSCALL(sleep)
    1121:	b8 0d 00 00 00       	mov    $0xd,%eax
    1126:	cd 40                	int    $0x40
    1128:	c3                   	ret    

00001129 <uptime>:
SYSCALL(uptime)
    1129:	b8 0e 00 00 00       	mov    $0xe,%eax
    112e:	cd 40                	int    $0x40
    1130:	c3                   	ret    

00001131 <halt>:
SYSCALL(halt)
    1131:	b8 16 00 00 00       	mov    $0x16,%eax
    1136:	cd 40                	int    $0x40
    1138:	c3                   	ret    

00001139 <date>:
SYSCALL(date)
    1139:	b8 17 00 00 00       	mov    $0x17,%eax
    113e:	cd 40                	int    $0x40
    1140:	c3                   	ret    

00001141 <getgid>:
SYSCALL(getgid)
    1141:	b8 18 00 00 00       	mov    $0x18,%eax
    1146:	cd 40                	int    $0x40
    1148:	c3                   	ret    

00001149 <setgid>:
SYSCALL(setgid)
    1149:	b8 19 00 00 00       	mov    $0x19,%eax
    114e:	cd 40                	int    $0x40
    1150:	c3                   	ret    

00001151 <getuid>:
SYSCALL(getuid)
    1151:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1156:	cd 40                	int    $0x40
    1158:	c3                   	ret    

00001159 <setuid>:
SYSCALL(setuid)
    1159:	b8 1b 00 00 00       	mov    $0x1b,%eax
    115e:	cd 40                	int    $0x40
    1160:	c3                   	ret    

00001161 <getppid>:
SYSCALL(getppid)
    1161:	b8 1c 00 00 00       	mov    $0x1c,%eax
    1166:	cd 40                	int    $0x40
    1168:	c3                   	ret    

00001169 <getprocs>:
SYSCALL(getprocs)
    1169:	b8 1d 00 00 00       	mov    $0x1d,%eax
    116e:	cd 40                	int    $0x40
    1170:	c3                   	ret    

00001171 <setpriority>:
SYSCALL(setpriority)
    1171:	b8 1e 00 00 00       	mov    $0x1e,%eax
    1176:	cd 40                	int    $0x40
    1178:	c3                   	ret    

00001179 <getpriority>:
SYSCALL(getpriority)
    1179:	b8 1f 00 00 00       	mov    $0x1f,%eax
    117e:	cd 40                	int    $0x40
    1180:	c3                   	ret    

00001181 <chmod>:
SYSCALL(chmod)
    1181:	b8 20 00 00 00       	mov    $0x20,%eax
    1186:	cd 40                	int    $0x40
    1188:	c3                   	ret    

00001189 <chown>:
SYSCALL(chown)
    1189:	b8 21 00 00 00       	mov    $0x21,%eax
    118e:	cd 40                	int    $0x40
    1190:	c3                   	ret    

00001191 <chgrp>:
SYSCALL(chgrp)
    1191:	b8 22 00 00 00       	mov    $0x22,%eax
    1196:	cd 40                	int    $0x40
    1198:	c3                   	ret    
    1199:	66 90                	xchg   %ax,%ax
    119b:	66 90                	xchg   %ax,%ax
    119d:	66 90                	xchg   %ax,%ax
    119f:	90                   	nop

000011a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    11a0:	55                   	push   %ebp
    11a1:	89 e5                	mov    %esp,%ebp
    11a3:	57                   	push   %edi
    11a4:	56                   	push   %esi
    11a5:	53                   	push   %ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    11a6:	89 d3                	mov    %edx,%ebx
{
    11a8:	83 ec 3c             	sub    $0x3c,%esp
    11ab:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
    11ae:	85 d2                	test   %edx,%edx
    11b0:	0f 89 92 00 00 00    	jns    1248 <printint+0xa8>
    11b6:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    11ba:	0f 84 88 00 00 00    	je     1248 <printint+0xa8>
    neg = 1;
    11c0:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
    11c7:	f7 db                	neg    %ebx
  } else {
    x = xx;
  }

  i = 0;
    11c9:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    11d0:	8d 75 d7             	lea    -0x29(%ebp),%esi
    11d3:	eb 08                	jmp    11dd <printint+0x3d>
    11d5:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    11d8:	89 7d c4             	mov    %edi,-0x3c(%ebp)
  }while((x /= base) != 0);
    11db:	89 c3                	mov    %eax,%ebx
    buf[i++] = digits[x % base];
    11dd:	89 d8                	mov    %ebx,%eax
    11df:	31 d2                	xor    %edx,%edx
    11e1:	8b 7d c4             	mov    -0x3c(%ebp),%edi
    11e4:	f7 f1                	div    %ecx
    11e6:	83 c7 01             	add    $0x1,%edi
    11e9:	0f b6 92 00 17 00 00 	movzbl 0x1700(%edx),%edx
    11f0:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
    11f3:	39 d9                	cmp    %ebx,%ecx
    11f5:	76 e1                	jbe    11d8 <printint+0x38>
  if(neg)
    11f7:	8b 45 c0             	mov    -0x40(%ebp),%eax
    11fa:	85 c0                	test   %eax,%eax
    11fc:	74 0d                	je     120b <printint+0x6b>
    buf[i++] = '-';
    11fe:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    1203:	ba 2d 00 00 00       	mov    $0x2d,%edx
    buf[i++] = digits[x % base];
    1208:	89 7d c4             	mov    %edi,-0x3c(%ebp)
    120b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    120e:	8b 7d bc             	mov    -0x44(%ebp),%edi
    1211:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    1215:	eb 0f                	jmp    1226 <printint+0x86>
    1217:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    121e:	66 90                	xchg   %ax,%ax
    1220:	0f b6 13             	movzbl (%ebx),%edx
    1223:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    1226:	83 ec 04             	sub    $0x4,%esp
    1229:	88 55 d7             	mov    %dl,-0x29(%ebp)
    122c:	6a 01                	push   $0x1
    122e:	56                   	push   %esi
    122f:	57                   	push   %edi
    1230:	e8 7c fe ff ff       	call   10b1 <write>

  while(--i >= 0)
    1235:	83 c4 10             	add    $0x10,%esp
    1238:	39 de                	cmp    %ebx,%esi
    123a:	75 e4                	jne    1220 <printint+0x80>
    putc(fd, buf[i]);
}
    123c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    123f:	5b                   	pop    %ebx
    1240:	5e                   	pop    %esi
    1241:	5f                   	pop    %edi
    1242:	5d                   	pop    %ebp
    1243:	c3                   	ret    
    1244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1248:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    124f:	e9 75 ff ff ff       	jmp    11c9 <printint+0x29>
    1254:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    125b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    125f:	90                   	nop

00001260 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1260:	55                   	push   %ebp
    1261:	89 e5                	mov    %esp,%ebp
    1263:	57                   	push   %edi
    1264:	56                   	push   %esi
    1265:	53                   	push   %ebx
    1266:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1269:	8b 75 0c             	mov    0xc(%ebp),%esi
    126c:	0f b6 1e             	movzbl (%esi),%ebx
    126f:	84 db                	test   %bl,%bl
    1271:	0f 84 b9 00 00 00    	je     1330 <printf+0xd0>
  ap = (uint*)(void*)&fmt + 1;
    1277:	8d 45 10             	lea    0x10(%ebp),%eax
    127a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    127d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    1280:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    1282:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1285:	eb 38                	jmp    12bf <printf+0x5f>
    1287:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    128e:	66 90                	xchg   %ax,%ax
    1290:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    1293:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    1298:	83 f8 25             	cmp    $0x25,%eax
    129b:	74 17                	je     12b4 <printf+0x54>
  write(fd, &c, 1);
    129d:	83 ec 04             	sub    $0x4,%esp
    12a0:	88 5d e7             	mov    %bl,-0x19(%ebp)
    12a3:	6a 01                	push   $0x1
    12a5:	57                   	push   %edi
    12a6:	ff 75 08             	pushl  0x8(%ebp)
    12a9:	e8 03 fe ff ff       	call   10b1 <write>
    12ae:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    12b1:	83 c4 10             	add    $0x10,%esp
    12b4:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
    12b7:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    12bb:	84 db                	test   %bl,%bl
    12bd:	74 71                	je     1330 <printf+0xd0>
    c = fmt[i] & 0xff;
    12bf:	0f be cb             	movsbl %bl,%ecx
    12c2:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    12c5:	85 d2                	test   %edx,%edx
    12c7:	74 c7                	je     1290 <printf+0x30>
      }
    } else if(state == '%'){
    12c9:	83 fa 25             	cmp    $0x25,%edx
    12cc:	75 e6                	jne    12b4 <printf+0x54>
      if(c == 'd'){
    12ce:	83 f8 64             	cmp    $0x64,%eax
    12d1:	0f 84 99 00 00 00    	je     1370 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    12d7:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    12dd:	83 f9 70             	cmp    $0x70,%ecx
    12e0:	74 5e                	je     1340 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    12e2:	83 f8 73             	cmp    $0x73,%eax
    12e5:	0f 84 d5 00 00 00    	je     13c0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    12eb:	83 f8 63             	cmp    $0x63,%eax
    12ee:	0f 84 8c 00 00 00    	je     1380 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    12f4:	83 f8 25             	cmp    $0x25,%eax
    12f7:	0f 84 b3 00 00 00    	je     13b0 <printf+0x150>
  write(fd, &c, 1);
    12fd:	83 ec 04             	sub    $0x4,%esp
    1300:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1304:	6a 01                	push   $0x1
    1306:	57                   	push   %edi
    1307:	ff 75 08             	pushl  0x8(%ebp)
    130a:	e8 a2 fd ff ff       	call   10b1 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    130f:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1312:	83 c4 0c             	add    $0xc,%esp
    1315:	6a 01                	push   $0x1
    1317:	83 c6 01             	add    $0x1,%esi
    131a:	57                   	push   %edi
    131b:	ff 75 08             	pushl  0x8(%ebp)
    131e:	e8 8e fd ff ff       	call   10b1 <write>
  for(i = 0; fmt[i]; i++){
    1323:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    1327:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    132a:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    132c:	84 db                	test   %bl,%bl
    132e:	75 8f                	jne    12bf <printf+0x5f>
    }
  }
}
    1330:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1333:	5b                   	pop    %ebx
    1334:	5e                   	pop    %esi
    1335:	5f                   	pop    %edi
    1336:	5d                   	pop    %ebp
    1337:	c3                   	ret    
    1338:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    133f:	90                   	nop
        printint(fd, *ap, 16, 0);
    1340:	83 ec 0c             	sub    $0xc,%esp
    1343:	b9 10 00 00 00       	mov    $0x10,%ecx
    1348:	6a 00                	push   $0x0
    134a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    134d:	8b 45 08             	mov    0x8(%ebp),%eax
    1350:	8b 13                	mov    (%ebx),%edx
    1352:	e8 49 fe ff ff       	call   11a0 <printint>
        ap++;
    1357:	89 d8                	mov    %ebx,%eax
    1359:	83 c4 10             	add    $0x10,%esp
      state = 0;
    135c:	31 d2                	xor    %edx,%edx
        ap++;
    135e:	83 c0 04             	add    $0x4,%eax
    1361:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1364:	e9 4b ff ff ff       	jmp    12b4 <printf+0x54>
    1369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    1370:	83 ec 0c             	sub    $0xc,%esp
    1373:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1378:	6a 01                	push   $0x1
    137a:	eb ce                	jmp    134a <printf+0xea>
    137c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    1380:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    1383:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1386:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    1388:	6a 01                	push   $0x1
        ap++;
    138a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    138d:	57                   	push   %edi
    138e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    1391:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1394:	e8 18 fd ff ff       	call   10b1 <write>
        ap++;
    1399:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    139c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    139f:	31 d2                	xor    %edx,%edx
    13a1:	e9 0e ff ff ff       	jmp    12b4 <printf+0x54>
    13a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13ad:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    13b0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    13b3:	83 ec 04             	sub    $0x4,%esp
    13b6:	e9 5a ff ff ff       	jmp    1315 <printf+0xb5>
    13bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    13bf:	90                   	nop
        s = (char*)*ap;
    13c0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    13c3:	8b 18                	mov    (%eax),%ebx
        ap++;
    13c5:	83 c0 04             	add    $0x4,%eax
    13c8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    13cb:	85 db                	test   %ebx,%ebx
    13cd:	74 17                	je     13e6 <printf+0x186>
        while(*s != 0){
    13cf:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    13d2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    13d4:	84 c0                	test   %al,%al
    13d6:	0f 84 d8 fe ff ff    	je     12b4 <printf+0x54>
    13dc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    13df:	89 de                	mov    %ebx,%esi
    13e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
    13e4:	eb 1a                	jmp    1400 <printf+0x1a0>
          s = "(null)";
    13e6:	bb f8 16 00 00       	mov    $0x16f8,%ebx
        while(*s != 0){
    13eb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    13ee:	b8 28 00 00 00       	mov    $0x28,%eax
    13f3:	89 de                	mov    %ebx,%esi
    13f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
    13f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13ff:	90                   	nop
  write(fd, &c, 1);
    1400:	83 ec 04             	sub    $0x4,%esp
          s++;
    1403:	83 c6 01             	add    $0x1,%esi
    1406:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1409:	6a 01                	push   $0x1
    140b:	57                   	push   %edi
    140c:	53                   	push   %ebx
    140d:	e8 9f fc ff ff       	call   10b1 <write>
        while(*s != 0){
    1412:	0f b6 06             	movzbl (%esi),%eax
    1415:	83 c4 10             	add    $0x10,%esp
    1418:	84 c0                	test   %al,%al
    141a:	75 e4                	jne    1400 <printf+0x1a0>
    141c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
    141f:	31 d2                	xor    %edx,%edx
    1421:	e9 8e fe ff ff       	jmp    12b4 <printf+0x54>
    1426:	66 90                	xchg   %ax,%ax
    1428:	66 90                	xchg   %ax,%ax
    142a:	66 90                	xchg   %ax,%ax
    142c:	66 90                	xchg   %ax,%ax
    142e:	66 90                	xchg   %ax,%ax

00001430 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1430:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1431:	a1 64 1e 00 00       	mov    0x1e64,%eax
{
    1436:	89 e5                	mov    %esp,%ebp
    1438:	57                   	push   %edi
    1439:	56                   	push   %esi
    143a:	53                   	push   %ebx
    143b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    143e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
    1440:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1443:	39 c8                	cmp    %ecx,%eax
    1445:	73 19                	jae    1460 <free+0x30>
    1447:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    144e:	66 90                	xchg   %ax,%ax
    1450:	39 d1                	cmp    %edx,%ecx
    1452:	72 14                	jb     1468 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1454:	39 d0                	cmp    %edx,%eax
    1456:	73 10                	jae    1468 <free+0x38>
{
    1458:	89 d0                	mov    %edx,%eax
    145a:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    145c:	39 c8                	cmp    %ecx,%eax
    145e:	72 f0                	jb     1450 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1460:	39 d0                	cmp    %edx,%eax
    1462:	72 f4                	jb     1458 <free+0x28>
    1464:	39 d1                	cmp    %edx,%ecx
    1466:	73 f0                	jae    1458 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1468:	8b 73 fc             	mov    -0x4(%ebx),%esi
    146b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    146e:	39 fa                	cmp    %edi,%edx
    1470:	74 1e                	je     1490 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1472:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1475:	8b 50 04             	mov    0x4(%eax),%edx
    1478:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    147b:	39 f1                	cmp    %esi,%ecx
    147d:	74 28                	je     14a7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    147f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
    1481:	5b                   	pop    %ebx
  freep = p;
    1482:	a3 64 1e 00 00       	mov    %eax,0x1e64
}
    1487:	5e                   	pop    %esi
    1488:	5f                   	pop    %edi
    1489:	5d                   	pop    %ebp
    148a:	c3                   	ret    
    148b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    148f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
    1490:	03 72 04             	add    0x4(%edx),%esi
    1493:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1496:	8b 10                	mov    (%eax),%edx
    1498:	8b 12                	mov    (%edx),%edx
    149a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    149d:	8b 50 04             	mov    0x4(%eax),%edx
    14a0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    14a3:	39 f1                	cmp    %esi,%ecx
    14a5:	75 d8                	jne    147f <free+0x4f>
    p->s.size += bp->s.size;
    14a7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    14aa:	a3 64 1e 00 00       	mov    %eax,0x1e64
    p->s.size += bp->s.size;
    14af:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    14b2:	8b 53 f8             	mov    -0x8(%ebx),%edx
    14b5:	89 10                	mov    %edx,(%eax)
}
    14b7:	5b                   	pop    %ebx
    14b8:	5e                   	pop    %esi
    14b9:	5f                   	pop    %edi
    14ba:	5d                   	pop    %ebp
    14bb:	c3                   	ret    
    14bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000014c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    14c0:	55                   	push   %ebp
    14c1:	89 e5                	mov    %esp,%ebp
    14c3:	57                   	push   %edi
    14c4:	56                   	push   %esi
    14c5:	53                   	push   %ebx
    14c6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    14c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    14cc:	8b 3d 64 1e 00 00    	mov    0x1e64,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    14d2:	8d 70 07             	lea    0x7(%eax),%esi
    14d5:	c1 ee 03             	shr    $0x3,%esi
    14d8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    14db:	85 ff                	test   %edi,%edi
    14dd:	0f 84 ad 00 00 00    	je     1590 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    14e3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
    14e5:	8b 4a 04             	mov    0x4(%edx),%ecx
    14e8:	39 f1                	cmp    %esi,%ecx
    14ea:	73 72                	jae    155e <malloc+0x9e>
    14ec:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    14f2:	bb 00 10 00 00       	mov    $0x1000,%ebx
    14f7:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    14fa:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    1501:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1504:	eb 1b                	jmp    1521 <malloc+0x61>
    1506:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    150d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1510:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1512:	8b 48 04             	mov    0x4(%eax),%ecx
    1515:	39 f1                	cmp    %esi,%ecx
    1517:	73 4f                	jae    1568 <malloc+0xa8>
    1519:	8b 3d 64 1e 00 00    	mov    0x1e64,%edi
    151f:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1521:	39 d7                	cmp    %edx,%edi
    1523:	75 eb                	jne    1510 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    1525:	83 ec 0c             	sub    $0xc,%esp
    1528:	ff 75 e4             	pushl  -0x1c(%ebp)
    152b:	e8 e9 fb ff ff       	call   1119 <sbrk>
  if(p == (char*)-1)
    1530:	83 c4 10             	add    $0x10,%esp
    1533:	83 f8 ff             	cmp    $0xffffffff,%eax
    1536:	74 1c                	je     1554 <malloc+0x94>
  hp->s.size = nu;
    1538:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    153b:	83 ec 0c             	sub    $0xc,%esp
    153e:	83 c0 08             	add    $0x8,%eax
    1541:	50                   	push   %eax
    1542:	e8 e9 fe ff ff       	call   1430 <free>
  return freep;
    1547:	8b 15 64 1e 00 00    	mov    0x1e64,%edx
      if((p = morecore(nunits)) == 0)
    154d:	83 c4 10             	add    $0x10,%esp
    1550:	85 d2                	test   %edx,%edx
    1552:	75 bc                	jne    1510 <malloc+0x50>
        return 0;
  }
}
    1554:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1557:	31 c0                	xor    %eax,%eax
}
    1559:	5b                   	pop    %ebx
    155a:	5e                   	pop    %esi
    155b:	5f                   	pop    %edi
    155c:	5d                   	pop    %ebp
    155d:	c3                   	ret    
    if(p->s.size >= nunits){
    155e:	89 d0                	mov    %edx,%eax
    1560:	89 fa                	mov    %edi,%edx
    1562:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1568:	39 ce                	cmp    %ecx,%esi
    156a:	74 54                	je     15c0 <malloc+0x100>
        p->s.size -= nunits;
    156c:	29 f1                	sub    %esi,%ecx
    156e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1571:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1574:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    1577:	89 15 64 1e 00 00    	mov    %edx,0x1e64
}
    157d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1580:	83 c0 08             	add    $0x8,%eax
}
    1583:	5b                   	pop    %ebx
    1584:	5e                   	pop    %esi
    1585:	5f                   	pop    %edi
    1586:	5d                   	pop    %ebp
    1587:	c3                   	ret    
    1588:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    158f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
    1590:	c7 05 64 1e 00 00 68 	movl   $0x1e68,0x1e64
    1597:	1e 00 00 
    base.s.size = 0;
    159a:	bf 68 1e 00 00       	mov    $0x1e68,%edi
    base.s.ptr = freep = prevp = &base;
    159f:	c7 05 68 1e 00 00 68 	movl   $0x1e68,0x1e68
    15a6:	1e 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15a9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
    15ab:	c7 05 6c 1e 00 00 00 	movl   $0x0,0x1e6c
    15b2:	00 00 00 
    if(p->s.size >= nunits){
    15b5:	e9 32 ff ff ff       	jmp    14ec <malloc+0x2c>
    15ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    15c0:	8b 08                	mov    (%eax),%ecx
    15c2:	89 0a                	mov    %ecx,(%edx)
    15c4:	eb b1                	jmp    1577 <malloc+0xb7>
