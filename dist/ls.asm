
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  close(fd);
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
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 10             	sub    $0x10,%esp
  14:	8b 79 04             	mov    0x4(%ecx),%edi
  17:	8b 31                	mov    (%ecx),%esi
  int i;

#ifdef CS333_P5
  printf(1, "mode\t\tname\tuid\tgid\tinode\tsize\n");
  19:	68 44 0f 00 00       	push   $0xf44
  1e:	6a 01                	push   $0x1
  20:	e8 4b 0b 00 00       	call   b70 <printf>
#endif
  if(argc < 2){
  25:	83 c4 10             	add    $0x10,%esp
  28:	83 fe 01             	cmp    $0x1,%esi
  2b:	7e 24                	jle    51 <main+0x51>
  2d:	8d 5f 04             	lea    0x4(%edi),%ebx
  30:	8d 34 b7             	lea    (%edi,%esi,4),%esi
  33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  37:	90                   	nop
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
  38:	83 ec 0c             	sub    $0xc,%esp
  3b:	ff 33                	pushl  (%ebx)
  3d:	83 c3 04             	add    $0x4,%ebx
  40:	e8 ab 03 00 00       	call   3f0 <ls>
  for(i=1; i<argc; i++)
  45:	83 c4 10             	add    $0x10,%esp
  48:	39 f3                	cmp    %esi,%ebx
  4a:	75 ec                	jne    38 <main+0x38>
  exit();
  4c:	e8 50 09 00 00       	call   9a1 <exit>
    ls(".");
  51:	83 ec 0c             	sub    $0xc,%esp
  54:	68 40 0f 00 00       	push   $0xf40
  59:	e8 92 03 00 00       	call   3f0 <ls>
    exit();
  5e:	e8 3e 09 00 00       	call   9a1 <exit>
  63:	66 90                	xchg   %ax,%ax
  65:	66 90                	xchg   %ax,%ax
  67:	66 90                	xchg   %ax,%ax
  69:	66 90                	xchg   %ax,%ax
  6b:	66 90                	xchg   %ax,%ax
  6d:	66 90                	xchg   %ax,%ax
  6f:	90                   	nop

00000070 <print_mode>:
#ifdef CS333_P5
// this is an ugly series of if statements but it works
void
print_mode(struct stat* st)
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	53                   	push   %ebx
  74:	83 ec 04             	sub    $0x4,%esp
  77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  switch (st->type) {
  7a:	0f b7 03             	movzwl (%ebx),%eax
  7d:	66 83 f8 02          	cmp    $0x2,%ax
  81:	0f 84 59 02 00 00    	je     2e0 <print_mode+0x270>
  87:	66 83 f8 03          	cmp    $0x3,%ax
  8b:	0f 84 8f 02 00 00    	je     320 <print_mode+0x2b0>
  91:	66 83 f8 01          	cmp    $0x1,%ax
  95:	0f 84 65 02 00 00    	je     300 <print_mode+0x290>
    case T_DIR: printf(1, "d"); break;
    case T_FILE: printf(1, "-"); break;
    case T_DEV: printf(1, "c"); break;
    default: printf(1, "?");
  9b:	83 ec 08             	sub    $0x8,%esp
  9e:	68 de 0e 00 00       	push   $0xede
  a3:	6a 01                	push   $0x1
  a5:	e8 c6 0a 00 00       	call   b70 <printf>
  aa:	83 c4 10             	add    $0x10,%esp
  }

  if (st->mode.flags.u_r)
  ad:	f6 43 19 01          	testb  $0x1,0x19(%ebx)
  b1:	0f 84 d9 01 00 00    	je     290 <print_mode+0x220>
    printf(1, "r");
  b7:	83 ec 08             	sub    $0x8,%esp
  ba:	68 e0 0e 00 00       	push   $0xee0
  bf:	6a 01                	push   $0x1
  c1:	e8 aa 0a 00 00       	call   b70 <printf>
  c6:	83 c4 10             	add    $0x10,%esp
  else
    printf(1, "-");

  if (st->mode.flags.u_w)
  c9:	80 7b 18 00          	cmpb   $0x0,0x18(%ebx)
  cd:	0f 88 d9 01 00 00    	js     2ac <print_mode+0x23c>
    printf(1, "w");
  else
    printf(1, "-");
  d3:	83 ec 08             	sub    $0x8,%esp
  d6:	68 da 0e 00 00       	push   $0xeda
  db:	6a 01                	push   $0x1
  dd:	e8 8e 0a 00 00       	call   b70 <printf>
  e2:	83 c4 10             	add    $0x10,%esp

  if ((st->mode.flags.u_x) & (st->mode.flags.setuid))
  e5:	0f b6 53 18          	movzbl 0x18(%ebx),%edx
  e9:	0f b6 43 19          	movzbl 0x19(%ebx),%eax
  ed:	89 d1                	mov    %edx,%ecx
  ef:	d0 e8                	shr    %al
  f1:	c0 e9 06             	shr    $0x6,%cl
  f4:	83 e0 01             	and    $0x1,%eax
  f7:	84 c1                	test   %al,%cl
  f9:	0f 85 c9 01 00 00    	jne    2c8 <print_mode+0x258>
    printf(1, "S");
  else if (st->mode.flags.u_x)
  ff:	83 e2 40             	and    $0x40,%edx
 102:	0f 85 c8 00 00 00    	jne    1d0 <print_mode+0x160>
    printf(1, "x");
  else
    printf(1, "-");
 108:	83 ec 08             	sub    $0x8,%esp
 10b:	68 da 0e 00 00       	push   $0xeda
 110:	6a 01                	push   $0x1
 112:	e8 59 0a 00 00       	call   b70 <printf>
 117:	83 c4 10             	add    $0x10,%esp

  if (st->mode.flags.g_r)
 11a:	f6 43 18 20          	testb  $0x20,0x18(%ebx)
 11e:	0f 84 c8 00 00 00    	je     1ec <print_mode+0x17c>
    printf(1, "r");
 124:	83 ec 08             	sub    $0x8,%esp
 127:	68 e0 0e 00 00       	push   $0xee0
 12c:	6a 01                	push   $0x1
 12e:	e8 3d 0a 00 00       	call   b70 <printf>
 133:	83 c4 10             	add    $0x10,%esp
  else
    printf(1, "-");

  if (st->mode.flags.g_w)
 136:	f6 43 18 10          	testb  $0x10,0x18(%ebx)
 13a:	0f 84 c8 00 00 00    	je     208 <print_mode+0x198>
    printf(1, "w");
 140:	83 ec 08             	sub    $0x8,%esp
 143:	68 e2 0e 00 00       	push   $0xee2
 148:	6a 01                	push   $0x1
 14a:	e8 21 0a 00 00       	call   b70 <printf>
 14f:	83 c4 10             	add    $0x10,%esp
  else
    printf(1, "-");

  if (st->mode.flags.g_x)
 152:	f6 43 18 08          	testb  $0x8,0x18(%ebx)
 156:	0f 84 c8 00 00 00    	je     224 <print_mode+0x1b4>
    printf(1, "x");
 15c:	83 ec 08             	sub    $0x8,%esp
 15f:	68 e6 0e 00 00       	push   $0xee6
 164:	6a 01                	push   $0x1
 166:	e8 05 0a 00 00       	call   b70 <printf>
 16b:	83 c4 10             	add    $0x10,%esp
  else
    printf(1, "-");

  if (st->mode.flags.o_r)
 16e:	f6 43 18 04          	testb  $0x4,0x18(%ebx)
 172:	0f 84 c8 00 00 00    	je     240 <print_mode+0x1d0>
    printf(1, "r");
 178:	83 ec 08             	sub    $0x8,%esp
 17b:	68 e0 0e 00 00       	push   $0xee0
 180:	6a 01                	push   $0x1
 182:	e8 e9 09 00 00       	call   b70 <printf>
 187:	83 c4 10             	add    $0x10,%esp
  else
    printf(1, "-");

  if (st->mode.flags.o_w)
 18a:	f6 43 18 02          	testb  $0x2,0x18(%ebx)
 18e:	0f 84 c8 00 00 00    	je     25c <print_mode+0x1ec>
    printf(1, "w");
 194:	83 ec 08             	sub    $0x8,%esp
 197:	68 e2 0e 00 00       	push   $0xee2
 19c:	6a 01                	push   $0x1
 19e:	e8 cd 09 00 00       	call   b70 <printf>
 1a3:	83 c4 10             	add    $0x10,%esp
  else
    printf(1, "-");

  if (st->mode.flags.o_x)
 1a6:	f6 43 18 01          	testb  $0x1,0x18(%ebx)
 1aa:	0f 84 c8 00 00 00    	je     278 <print_mode+0x208>
    printf(1, "x");
 1b0:	83 ec 08             	sub    $0x8,%esp
 1b3:	68 e6 0e 00 00       	push   $0xee6
 1b8:	6a 01                	push   $0x1
 1ba:	e8 b1 09 00 00       	call   b70 <printf>
 1bf:	83 c4 10             	add    $0x10,%esp
  else
    printf(1, "-");

  return;
}
 1c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1c5:	c9                   	leave  
 1c6:	c3                   	ret    
 1c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ce:	66 90                	xchg   %ax,%ax
    printf(1, "x");
 1d0:	83 ec 08             	sub    $0x8,%esp
 1d3:	68 e6 0e 00 00       	push   $0xee6
 1d8:	6a 01                	push   $0x1
 1da:	e8 91 09 00 00       	call   b70 <printf>
 1df:	83 c4 10             	add    $0x10,%esp
  if (st->mode.flags.g_r)
 1e2:	f6 43 18 20          	testb  $0x20,0x18(%ebx)
 1e6:	0f 85 38 ff ff ff    	jne    124 <print_mode+0xb4>
    printf(1, "-");
 1ec:	83 ec 08             	sub    $0x8,%esp
 1ef:	68 da 0e 00 00       	push   $0xeda
 1f4:	6a 01                	push   $0x1
 1f6:	e8 75 09 00 00       	call   b70 <printf>
 1fb:	83 c4 10             	add    $0x10,%esp
  if (st->mode.flags.g_w)
 1fe:	f6 43 18 10          	testb  $0x10,0x18(%ebx)
 202:	0f 85 38 ff ff ff    	jne    140 <print_mode+0xd0>
    printf(1, "-");
 208:	83 ec 08             	sub    $0x8,%esp
 20b:	68 da 0e 00 00       	push   $0xeda
 210:	6a 01                	push   $0x1
 212:	e8 59 09 00 00       	call   b70 <printf>
 217:	83 c4 10             	add    $0x10,%esp
  if (st->mode.flags.g_x)
 21a:	f6 43 18 08          	testb  $0x8,0x18(%ebx)
 21e:	0f 85 38 ff ff ff    	jne    15c <print_mode+0xec>
    printf(1, "-");
 224:	83 ec 08             	sub    $0x8,%esp
 227:	68 da 0e 00 00       	push   $0xeda
 22c:	6a 01                	push   $0x1
 22e:	e8 3d 09 00 00       	call   b70 <printf>
 233:	83 c4 10             	add    $0x10,%esp
  if (st->mode.flags.o_r)
 236:	f6 43 18 04          	testb  $0x4,0x18(%ebx)
 23a:	0f 85 38 ff ff ff    	jne    178 <print_mode+0x108>
    printf(1, "-");
 240:	83 ec 08             	sub    $0x8,%esp
 243:	68 da 0e 00 00       	push   $0xeda
 248:	6a 01                	push   $0x1
 24a:	e8 21 09 00 00       	call   b70 <printf>
 24f:	83 c4 10             	add    $0x10,%esp
  if (st->mode.flags.o_w)
 252:	f6 43 18 02          	testb  $0x2,0x18(%ebx)
 256:	0f 85 38 ff ff ff    	jne    194 <print_mode+0x124>
    printf(1, "-");
 25c:	83 ec 08             	sub    $0x8,%esp
 25f:	68 da 0e 00 00       	push   $0xeda
 264:	6a 01                	push   $0x1
 266:	e8 05 09 00 00       	call   b70 <printf>
 26b:	83 c4 10             	add    $0x10,%esp
  if (st->mode.flags.o_x)
 26e:	f6 43 18 01          	testb  $0x1,0x18(%ebx)
 272:	0f 85 38 ff ff ff    	jne    1b0 <print_mode+0x140>
    printf(1, "-");
 278:	83 ec 08             	sub    $0x8,%esp
 27b:	68 da 0e 00 00       	push   $0xeda
 280:	6a 01                	push   $0x1
 282:	e8 e9 08 00 00       	call   b70 <printf>
 287:	83 c4 10             	add    $0x10,%esp
}
 28a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 28d:	c9                   	leave  
 28e:	c3                   	ret    
 28f:	90                   	nop
    printf(1, "-");
 290:	83 ec 08             	sub    $0x8,%esp
 293:	68 da 0e 00 00       	push   $0xeda
 298:	6a 01                	push   $0x1
 29a:	e8 d1 08 00 00       	call   b70 <printf>
 29f:	83 c4 10             	add    $0x10,%esp
  if (st->mode.flags.u_w)
 2a2:	80 7b 18 00          	cmpb   $0x0,0x18(%ebx)
 2a6:	0f 89 27 fe ff ff    	jns    d3 <print_mode+0x63>
    printf(1, "w");
 2ac:	83 ec 08             	sub    $0x8,%esp
 2af:	68 e2 0e 00 00       	push   $0xee2
 2b4:	6a 01                	push   $0x1
 2b6:	e8 b5 08 00 00       	call   b70 <printf>
 2bb:	83 c4 10             	add    $0x10,%esp
 2be:	e9 22 fe ff ff       	jmp    e5 <print_mode+0x75>
 2c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2c7:	90                   	nop
    printf(1, "S");
 2c8:	83 ec 08             	sub    $0x8,%esp
 2cb:	68 e4 0e 00 00       	push   $0xee4
 2d0:	6a 01                	push   $0x1
 2d2:	e8 99 08 00 00       	call   b70 <printf>
 2d7:	83 c4 10             	add    $0x10,%esp
 2da:	e9 3b fe ff ff       	jmp    11a <print_mode+0xaa>
 2df:	90                   	nop
    case T_FILE: printf(1, "-"); break;
 2e0:	83 ec 08             	sub    $0x8,%esp
 2e3:	68 da 0e 00 00       	push   $0xeda
 2e8:	6a 01                	push   $0x1
 2ea:	e8 81 08 00 00       	call   b70 <printf>
 2ef:	83 c4 10             	add    $0x10,%esp
 2f2:	e9 b6 fd ff ff       	jmp    ad <print_mode+0x3d>
 2f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2fe:	66 90                	xchg   %ax,%ax
    case T_DIR: printf(1, "d"); break;
 300:	83 ec 08             	sub    $0x8,%esp
 303:	68 d8 0e 00 00       	push   $0xed8
 308:	6a 01                	push   $0x1
 30a:	e8 61 08 00 00       	call   b70 <printf>
 30f:	83 c4 10             	add    $0x10,%esp
 312:	e9 96 fd ff ff       	jmp    ad <print_mode+0x3d>
 317:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 31e:	66 90                	xchg   %ax,%ax
    case T_DEV: printf(1, "c"); break;
 320:	83 ec 08             	sub    $0x8,%esp
 323:	68 dc 0e 00 00       	push   $0xedc
 328:	6a 01                	push   $0x1
 32a:	e8 41 08 00 00       	call   b70 <printf>
 32f:	83 c4 10             	add    $0x10,%esp
 332:	e9 76 fd ff ff       	jmp    ad <print_mode+0x3d>
 337:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 33e:	66 90                	xchg   %ax,%ax

00000340 <fmtname>:
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	56                   	push   %esi
 344:	53                   	push   %ebx
 345:	8b 75 08             	mov    0x8(%ebp),%esi
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
 348:	83 ec 0c             	sub    $0xc,%esp
 34b:	56                   	push   %esi
 34c:	e8 df 03 00 00       	call   730 <strlen>
 351:	83 c4 10             	add    $0x10,%esp
 354:	01 f0                	add    %esi,%eax
 356:	89 c3                	mov    %eax,%ebx
 358:	0f 82 82 00 00 00    	jb     3e0 <fmtname+0xa0>
 35e:	80 38 2f             	cmpb   $0x2f,(%eax)
 361:	75 0d                	jne    370 <fmtname+0x30>
 363:	eb 7b                	jmp    3e0 <fmtname+0xa0>
 365:	8d 76 00             	lea    0x0(%esi),%esi
 368:	80 7b ff 2f          	cmpb   $0x2f,-0x1(%ebx)
 36c:	74 09                	je     377 <fmtname+0x37>
 36e:	89 c3                	mov    %eax,%ebx
 370:	8d 43 ff             	lea    -0x1(%ebx),%eax
 373:	39 c6                	cmp    %eax,%esi
 375:	76 f1                	jbe    368 <fmtname+0x28>
  if(strlen(p) >= DIRSIZ)
 377:	83 ec 0c             	sub    $0xc,%esp
 37a:	53                   	push   %ebx
 37b:	e8 b0 03 00 00       	call   730 <strlen>
 380:	83 c4 10             	add    $0x10,%esp
 383:	83 f8 0d             	cmp    $0xd,%eax
 386:	77 4a                	ja     3d2 <fmtname+0x92>
  memmove(buf, p, strlen(p));
 388:	83 ec 0c             	sub    $0xc,%esp
 38b:	53                   	push   %ebx
 38c:	e8 9f 03 00 00       	call   730 <strlen>
 391:	83 c4 0c             	add    $0xc,%esp
 394:	50                   	push   %eax
 395:	53                   	push   %ebx
 396:	68 04 13 00 00       	push   $0x1304
 39b:	e8 d0 05 00 00       	call   970 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 3a0:	89 1c 24             	mov    %ebx,(%esp)
 3a3:	e8 88 03 00 00       	call   730 <strlen>
 3a8:	89 1c 24             	mov    %ebx,(%esp)
  return buf;
 3ab:	bb 04 13 00 00       	mov    $0x1304,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 3b0:	89 c6                	mov    %eax,%esi
 3b2:	e8 79 03 00 00       	call   730 <strlen>
 3b7:	ba 0e 00 00 00       	mov    $0xe,%edx
 3bc:	83 c4 0c             	add    $0xc,%esp
 3bf:	29 f2                	sub    %esi,%edx
 3c1:	05 04 13 00 00       	add    $0x1304,%eax
 3c6:	52                   	push   %edx
 3c7:	6a 20                	push   $0x20
 3c9:	50                   	push   %eax
 3ca:	e8 91 03 00 00       	call   760 <memset>
  return buf;
 3cf:	83 c4 10             	add    $0x10,%esp
}
 3d2:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3d5:	89 d8                	mov    %ebx,%eax
 3d7:	5b                   	pop    %ebx
 3d8:	5e                   	pop    %esi
 3d9:	5d                   	pop    %ebp
 3da:	c3                   	ret    
 3db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3df:	90                   	nop
 3e0:	83 c3 01             	add    $0x1,%ebx
 3e3:	eb 92                	jmp    377 <fmtname+0x37>
 3e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003f0 <ls>:
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	56                   	push   %esi
 3f5:	53                   	push   %ebx
 3f6:	81 ec 64 02 00 00    	sub    $0x264,%esp
  if((fd = open(path, 0)) < 0){
 3fc:	6a 00                	push   $0x0
 3fe:	ff 75 08             	pushl  0x8(%ebp)
 401:	e8 db 05 00 00       	call   9e1 <open>
 406:	83 c4 10             	add    $0x10,%esp
 409:	85 c0                	test   %eax,%eax
 40b:	0f 88 ff 00 00 00    	js     510 <ls+0x120>
  if(fstat(fd, &st) < 0){
 411:	83 ec 08             	sub    $0x8,%esp
 414:	8d 9d cc fd ff ff    	lea    -0x234(%ebp),%ebx
 41a:	89 c7                	mov    %eax,%edi
 41c:	53                   	push   %ebx
 41d:	50                   	push   %eax
 41e:	e8 d6 05 00 00       	call   9f9 <fstat>
 423:	83 c4 10             	add    $0x10,%esp
 426:	85 c0                	test   %eax,%eax
 428:	0f 88 32 01 00 00    	js     560 <ls+0x170>
  switch(st.type){
 42e:	0f bf b5 cc fd ff ff 	movswl -0x234(%ebp),%esi
 435:	66 83 fe 02          	cmp    $0x2,%si
 439:	74 2d                	je     468 <ls+0x78>
 43b:	66 83 fe 03          	cmp    $0x3,%si
 43f:	0f 84 85 00 00 00    	je     4ca <ls+0xda>
 445:	66 83 fe 01          	cmp    $0x1,%si
 449:	0f 84 e1 00 00 00    	je     530 <ls+0x140>
  close(fd);
 44f:	83 ec 0c             	sub    $0xc,%esp
 452:	57                   	push   %edi
 453:	e8 71 05 00 00       	call   9c9 <close>
 458:	83 c4 10             	add    $0x10,%esp
}
 45b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 45e:	5b                   	pop    %ebx
 45f:	5e                   	pop    %esi
 460:	5f                   	pop    %edi
 461:	5d                   	pop    %ebp
 462:	c3                   	ret    
 463:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 467:	90                   	nop
      print_mode(&st);
 468:	83 ec 0c             	sub    $0xc,%esp
 46b:	53                   	push   %ebx
 46c:	e8 ff fb ff ff       	call   70 <print_mode>
      printf(1,"%s %d\t%d\t%d\t%d\n",fmtname(path), st.uid, st.gid, st.ino, st.size);
 471:	8b 8d dc fd ff ff    	mov    -0x224(%ebp),%ecx
 477:	8b 95 d4 fd ff ff    	mov    -0x22c(%ebp),%edx
 47d:	0f b7 b5 e0 fd ff ff 	movzwl -0x220(%ebp),%esi
 484:	0f b7 9d e2 fd ff ff 	movzwl -0x21e(%ebp),%ebx
 48b:	89 8d b0 fd ff ff    	mov    %ecx,-0x250(%ebp)
 491:	59                   	pop    %ecx
 492:	ff 75 08             	pushl  0x8(%ebp)
 495:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 49b:	e8 a0 fe ff ff       	call   340 <fmtname>
 4a0:	8b 8d b0 fd ff ff    	mov    -0x250(%ebp),%ecx
 4a6:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 4ac:	83 c4 0c             	add    $0xc,%esp
 4af:	51                   	push   %ecx
 4b0:	52                   	push   %edx
 4b1:	53                   	push   %ebx
 4b2:	56                   	push   %esi
 4b3:	50                   	push   %eax
 4b4:	68 10 0f 00 00       	push   $0xf10
 4b9:	6a 01                	push   $0x1
 4bb:	e8 b0 06 00 00       	call   b70 <printf>
 4c0:	0f bf b5 cc fd ff ff 	movswl -0x234(%ebp),%esi
 4c7:	83 c4 20             	add    $0x20,%esp
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 4ca:	83 ec 0c             	sub    $0xc,%esp
 4cd:	ff 75 08             	pushl  0x8(%ebp)
 4d0:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 4d6:	8b 9d d4 fd ff ff    	mov    -0x22c(%ebp),%ebx
 4dc:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 4e2:	e8 59 fe ff ff       	call   340 <fmtname>
 4e7:	59                   	pop    %ecx
 4e8:	5a                   	pop    %edx
 4e9:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 4ef:	52                   	push   %edx
 4f0:	53                   	push   %ebx
 4f1:	56                   	push   %esi
 4f2:	50                   	push   %eax
 4f3:	68 20 0f 00 00       	push   $0xf20
 4f8:	6a 01                	push   $0x1
 4fa:	e8 71 06 00 00       	call   b70 <printf>
    break;
 4ff:	83 c4 20             	add    $0x20,%esp
 502:	e9 48 ff ff ff       	jmp    44f <ls+0x5f>
 507:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 50e:	66 90                	xchg   %ax,%ax
    printf(2, "ls: cannot open %s\n", path);
 510:	83 ec 04             	sub    $0x4,%esp
 513:	ff 75 08             	pushl  0x8(%ebp)
 516:	68 e8 0e 00 00       	push   $0xee8
 51b:	6a 02                	push   $0x2
 51d:	e8 4e 06 00 00       	call   b70 <printf>
    return;
 522:	83 c4 10             	add    $0x10,%esp
}
 525:	8d 65 f4             	lea    -0xc(%ebp),%esp
 528:	5b                   	pop    %ebx
 529:	5e                   	pop    %esi
 52a:	5f                   	pop    %edi
 52b:	5d                   	pop    %ebp
 52c:	c3                   	ret    
 52d:	8d 76 00             	lea    0x0(%esi),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 530:	83 ec 0c             	sub    $0xc,%esp
 533:	ff 75 08             	pushl  0x8(%ebp)
 536:	e8 f5 01 00 00       	call   730 <strlen>
 53b:	83 c4 10             	add    $0x10,%esp
 53e:	83 c0 10             	add    $0x10,%eax
 541:	3d 00 02 00 00       	cmp    $0x200,%eax
 546:	76 40                	jbe    588 <ls+0x198>
      printf(1, "ls: path too long\n");
 548:	83 ec 08             	sub    $0x8,%esp
 54b:	68 2d 0f 00 00       	push   $0xf2d
 550:	6a 01                	push   $0x1
 552:	e8 19 06 00 00       	call   b70 <printf>
      break;
 557:	83 c4 10             	add    $0x10,%esp
 55a:	e9 f0 fe ff ff       	jmp    44f <ls+0x5f>
 55f:	90                   	nop
    printf(2, "ls: cannot stat %s\n", path);
 560:	83 ec 04             	sub    $0x4,%esp
 563:	ff 75 08             	pushl  0x8(%ebp)
 566:	68 fc 0e 00 00       	push   $0xefc
 56b:	6a 02                	push   $0x2
 56d:	e8 fe 05 00 00       	call   b70 <printf>
    close(fd);
 572:	89 3c 24             	mov    %edi,(%esp)
 575:	e8 4f 04 00 00       	call   9c9 <close>
    return;
 57a:	83 c4 10             	add    $0x10,%esp
}
 57d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 580:	5b                   	pop    %ebx
 581:	5e                   	pop    %esi
 582:	5f                   	pop    %edi
 583:	5d                   	pop    %ebp
 584:	c3                   	ret    
 585:	8d 76 00             	lea    0x0(%esi),%esi
    strcpy(buf, path);
 588:	83 ec 08             	sub    $0x8,%esp
 58b:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
 591:	ff 75 08             	pushl  0x8(%ebp)
 594:	56                   	push   %esi
 595:	e8 16 01 00 00       	call   6b0 <strcpy>
    p = buf+strlen(buf);
 59a:	89 34 24             	mov    %esi,(%esp)
 59d:	e8 8e 01 00 00       	call   730 <strlen>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 5a2:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 5a5:	01 f0                	add    %esi,%eax
    *p++ = '/';
 5a7:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 5aa:	89 85 a4 fd ff ff    	mov    %eax,-0x25c(%ebp)
    *p++ = '/';
 5b0:	89 8d a0 fd ff ff    	mov    %ecx,-0x260(%ebp)
 5b6:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 5b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5c0:	83 ec 04             	sub    $0x4,%esp
 5c3:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
 5c9:	6a 10                	push   $0x10
 5cb:	50                   	push   %eax
 5cc:	57                   	push   %edi
 5cd:	e8 e7 03 00 00       	call   9b9 <read>
 5d2:	83 c4 10             	add    $0x10,%esp
 5d5:	83 f8 10             	cmp    $0x10,%eax
 5d8:	0f 85 71 fe ff ff    	jne    44f <ls+0x5f>
      if(de.inum == 0)
 5de:	66 83 bd bc fd ff ff 	cmpw   $0x0,-0x244(%ebp)
 5e5:	00 
 5e6:	74 d8                	je     5c0 <ls+0x1d0>
      memmove(p, de.name, DIRSIZ);
 5e8:	83 ec 04             	sub    $0x4,%esp
 5eb:	8d 85 be fd ff ff    	lea    -0x242(%ebp),%eax
 5f1:	6a 0e                	push   $0xe
 5f3:	50                   	push   %eax
 5f4:	ff b5 a0 fd ff ff    	pushl  -0x260(%ebp)
 5fa:	e8 71 03 00 00       	call   970 <memmove>
      p[DIRSIZ] = 0;
 5ff:	8b 85 a4 fd ff ff    	mov    -0x25c(%ebp),%eax
 605:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 609:	58                   	pop    %eax
 60a:	5a                   	pop    %edx
 60b:	53                   	push   %ebx
 60c:	56                   	push   %esi
 60d:	e8 2e 02 00 00       	call   840 <stat>
 612:	83 c4 10             	add    $0x10,%esp
 615:	85 c0                	test   %eax,%eax
 617:	78 77                	js     690 <ls+0x2a0>
      print_mode(&st);
 619:	83 ec 0c             	sub    $0xc,%esp
 61c:	53                   	push   %ebx
 61d:	e8 4e fa ff ff       	call   70 <print_mode>
      printf(1,"%s %d\t%d\t%d\t%d\n",fmtname(buf), st.uid, st.gid, st.ino, st.size);
 622:	8b 8d dc fd ff ff    	mov    -0x224(%ebp),%ecx
 628:	8b 95 d4 fd ff ff    	mov    -0x22c(%ebp),%edx
 62e:	89 34 24             	mov    %esi,(%esp)
 631:	0f b7 85 e2 fd ff ff 	movzwl -0x21e(%ebp),%eax
 638:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
 63e:	0f b7 8d e0 fd ff ff 	movzwl -0x220(%ebp),%ecx
 645:	89 95 ac fd ff ff    	mov    %edx,-0x254(%ebp)
 64b:	89 8d b0 fd ff ff    	mov    %ecx,-0x250(%ebp)
 651:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 657:	e8 e4 fc ff ff       	call   340 <fmtname>
 65c:	8b 8d a8 fd ff ff    	mov    -0x258(%ebp),%ecx
 662:	8b 95 ac fd ff ff    	mov    -0x254(%ebp),%edx
 668:	83 c4 0c             	add    $0xc,%esp
 66b:	51                   	push   %ecx
 66c:	52                   	push   %edx
 66d:	ff b5 b4 fd ff ff    	pushl  -0x24c(%ebp)
 673:	ff b5 b0 fd ff ff    	pushl  -0x250(%ebp)
 679:	50                   	push   %eax
 67a:	68 10 0f 00 00       	push   $0xf10
 67f:	6a 01                	push   $0x1
 681:	e8 ea 04 00 00       	call   b70 <printf>
 686:	83 c4 20             	add    $0x20,%esp
 689:	e9 32 ff ff ff       	jmp    5c0 <ls+0x1d0>
 68e:	66 90                	xchg   %ax,%ax
        printf(1, "ls: cannot stat %s\n", buf);
 690:	83 ec 04             	sub    $0x4,%esp
 693:	56                   	push   %esi
 694:	68 fc 0e 00 00       	push   $0xefc
 699:	6a 01                	push   $0x1
 69b:	e8 d0 04 00 00       	call   b70 <printf>
        continue;
 6a0:	83 c4 10             	add    $0x10,%esp
 6a3:	e9 18 ff ff ff       	jmp    5c0 <ls+0x1d0>
 6a8:	66 90                	xchg   %ax,%ax
 6aa:	66 90                	xchg   %ax,%ax
 6ac:	66 90                	xchg   %ax,%ax
 6ae:	66 90                	xchg   %ax,%ax

000006b0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 6b0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 6b1:	31 d2                	xor    %edx,%edx
{
 6b3:	89 e5                	mov    %esp,%ebp
 6b5:	53                   	push   %ebx
 6b6:	8b 45 08             	mov    0x8(%ebp),%eax
 6b9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 6c0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 6c4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 6c7:	83 c2 01             	add    $0x1,%edx
 6ca:	84 c9                	test   %cl,%cl
 6cc:	75 f2                	jne    6c0 <strcpy+0x10>
    ;
  return os;
}
 6ce:	5b                   	pop    %ebx
 6cf:	5d                   	pop    %ebp
 6d0:	c3                   	ret    
 6d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6df:	90                   	nop

000006e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	56                   	push   %esi
 6e4:	53                   	push   %ebx
 6e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6e8:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(*p && *p == *q)
 6eb:	0f b6 13             	movzbl (%ebx),%edx
 6ee:	0f b6 0e             	movzbl (%esi),%ecx
 6f1:	84 d2                	test   %dl,%dl
 6f3:	74 1e                	je     713 <strcmp+0x33>
 6f5:	b8 01 00 00 00       	mov    $0x1,%eax
 6fa:	38 ca                	cmp    %cl,%dl
 6fc:	74 09                	je     707 <strcmp+0x27>
 6fe:	eb 20                	jmp    720 <strcmp+0x40>
 700:	83 c0 01             	add    $0x1,%eax
 703:	38 ca                	cmp    %cl,%dl
 705:	75 19                	jne    720 <strcmp+0x40>
 707:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 70b:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
 70f:	84 d2                	test   %dl,%dl
 711:	75 ed                	jne    700 <strcmp+0x20>
 713:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 715:	5b                   	pop    %ebx
 716:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
 717:	29 c8                	sub    %ecx,%eax
}
 719:	5d                   	pop    %ebp
 71a:	c3                   	ret    
 71b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 71f:	90                   	nop
 720:	0f b6 c2             	movzbl %dl,%eax
 723:	5b                   	pop    %ebx
 724:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
 725:	29 c8                	sub    %ecx,%eax
}
 727:	5d                   	pop    %ebp
 728:	c3                   	ret    
 729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000730 <strlen>:

uint
strlen(char *s)
{
 730:	55                   	push   %ebp
 731:	89 e5                	mov    %esp,%ebp
 733:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 736:	80 39 00             	cmpb   $0x0,(%ecx)
 739:	74 15                	je     750 <strlen+0x20>
 73b:	31 d2                	xor    %edx,%edx
 73d:	8d 76 00             	lea    0x0(%esi),%esi
 740:	83 c2 01             	add    $0x1,%edx
 743:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 747:	89 d0                	mov    %edx,%eax
 749:	75 f5                	jne    740 <strlen+0x10>
    ;
  return n;
}
 74b:	5d                   	pop    %ebp
 74c:	c3                   	ret    
 74d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 750:	31 c0                	xor    %eax,%eax
}
 752:	5d                   	pop    %ebp
 753:	c3                   	ret    
 754:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 75b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 75f:	90                   	nop

00000760 <memset>:

void*
memset(void *dst, int c, uint n)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 767:	8b 4d 10             	mov    0x10(%ebp),%ecx
 76a:	8b 45 0c             	mov    0xc(%ebp),%eax
 76d:	89 d7                	mov    %edx,%edi
 76f:	fc                   	cld    
 770:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 772:	89 d0                	mov    %edx,%eax
 774:	5f                   	pop    %edi
 775:	5d                   	pop    %ebp
 776:	c3                   	ret    
 777:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 77e:	66 90                	xchg   %ax,%ax

00000780 <strchr>:

char*
strchr(const char *s, char c)
{
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	53                   	push   %ebx
 784:	8b 45 08             	mov    0x8(%ebp),%eax
 787:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 78a:	0f b6 18             	movzbl (%eax),%ebx
 78d:	84 db                	test   %bl,%bl
 78f:	74 1d                	je     7ae <strchr+0x2e>
 791:	89 d1                	mov    %edx,%ecx
    if(*s == c)
 793:	38 d3                	cmp    %dl,%bl
 795:	75 0d                	jne    7a4 <strchr+0x24>
 797:	eb 17                	jmp    7b0 <strchr+0x30>
 799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7a0:	38 ca                	cmp    %cl,%dl
 7a2:	74 0c                	je     7b0 <strchr+0x30>
  for(; *s; s++)
 7a4:	83 c0 01             	add    $0x1,%eax
 7a7:	0f b6 10             	movzbl (%eax),%edx
 7aa:	84 d2                	test   %dl,%dl
 7ac:	75 f2                	jne    7a0 <strchr+0x20>
      return (char*)s;
  return 0;
 7ae:	31 c0                	xor    %eax,%eax
}
 7b0:	5b                   	pop    %ebx
 7b1:	5d                   	pop    %ebp
 7b2:	c3                   	ret    
 7b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000007c0 <gets>:

char*
gets(char *buf, int max)
{
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	57                   	push   %edi
 7c4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 7c5:	31 f6                	xor    %esi,%esi
{
 7c7:	53                   	push   %ebx
 7c8:	89 f3                	mov    %esi,%ebx
 7ca:	83 ec 1c             	sub    $0x1c,%esp
 7cd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 7d0:	eb 2f                	jmp    801 <gets+0x41>
 7d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 7d8:	83 ec 04             	sub    $0x4,%esp
 7db:	8d 45 e7             	lea    -0x19(%ebp),%eax
 7de:	6a 01                	push   $0x1
 7e0:	50                   	push   %eax
 7e1:	6a 00                	push   $0x0
 7e3:	e8 d1 01 00 00       	call   9b9 <read>
    if(cc < 1)
 7e8:	83 c4 10             	add    $0x10,%esp
 7eb:	85 c0                	test   %eax,%eax
 7ed:	7e 1c                	jle    80b <gets+0x4b>
      break;
    buf[i++] = c;
 7ef:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 7f3:	83 c7 01             	add    $0x1,%edi
 7f6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 7f9:	3c 0a                	cmp    $0xa,%al
 7fb:	74 23                	je     820 <gets+0x60>
 7fd:	3c 0d                	cmp    $0xd,%al
 7ff:	74 1f                	je     820 <gets+0x60>
  for(i=0; i+1 < max; ){
 801:	83 c3 01             	add    $0x1,%ebx
 804:	89 fe                	mov    %edi,%esi
 806:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 809:	7c cd                	jl     7d8 <gets+0x18>
 80b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 80d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 810:	c6 03 00             	movb   $0x0,(%ebx)
}
 813:	8d 65 f4             	lea    -0xc(%ebp),%esp
 816:	5b                   	pop    %ebx
 817:	5e                   	pop    %esi
 818:	5f                   	pop    %edi
 819:	5d                   	pop    %ebp
 81a:	c3                   	ret    
 81b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 81f:	90                   	nop
 820:	8b 75 08             	mov    0x8(%ebp),%esi
 823:	8b 45 08             	mov    0x8(%ebp),%eax
 826:	01 de                	add    %ebx,%esi
 828:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 82a:	c6 03 00             	movb   $0x0,(%ebx)
}
 82d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 830:	5b                   	pop    %ebx
 831:	5e                   	pop    %esi
 832:	5f                   	pop    %edi
 833:	5d                   	pop    %ebp
 834:	c3                   	ret    
 835:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 83c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000840 <stat>:

int
stat(char *n, struct stat *st)
{
 840:	55                   	push   %ebp
 841:	89 e5                	mov    %esp,%ebp
 843:	56                   	push   %esi
 844:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 845:	83 ec 08             	sub    $0x8,%esp
 848:	6a 00                	push   $0x0
 84a:	ff 75 08             	pushl  0x8(%ebp)
 84d:	e8 8f 01 00 00       	call   9e1 <open>
  if(fd < 0)
 852:	83 c4 10             	add    $0x10,%esp
 855:	85 c0                	test   %eax,%eax
 857:	78 27                	js     880 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 859:	83 ec 08             	sub    $0x8,%esp
 85c:	ff 75 0c             	pushl  0xc(%ebp)
 85f:	89 c3                	mov    %eax,%ebx
 861:	50                   	push   %eax
 862:	e8 92 01 00 00       	call   9f9 <fstat>
  close(fd);
 867:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 86a:	89 c6                	mov    %eax,%esi
  close(fd);
 86c:	e8 58 01 00 00       	call   9c9 <close>
  return r;
 871:	83 c4 10             	add    $0x10,%esp
}
 874:	8d 65 f8             	lea    -0x8(%ebp),%esp
 877:	89 f0                	mov    %esi,%eax
 879:	5b                   	pop    %ebx
 87a:	5e                   	pop    %esi
 87b:	5d                   	pop    %ebp
 87c:	c3                   	ret    
 87d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 880:	be ff ff ff ff       	mov    $0xffffffff,%esi
 885:	eb ed                	jmp    874 <stat+0x34>
 887:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 88e:	66 90                	xchg   %ax,%ax

00000890 <atoi>:

#ifdef PDX_XV6
int
atoi(const char *s)
{
 890:	55                   	push   %ebp
 891:	89 e5                	mov    %esp,%ebp
 893:	56                   	push   %esi
 894:	8b 55 08             	mov    0x8(%ebp),%edx
 897:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 898:	0f b6 0a             	movzbl (%edx),%ecx
 89b:	80 f9 20             	cmp    $0x20,%cl
 89e:	75 0b                	jne    8ab <atoi+0x1b>
 8a0:	83 c2 01             	add    $0x1,%edx
 8a3:	0f b6 0a             	movzbl (%edx),%ecx
 8a6:	80 f9 20             	cmp    $0x20,%cl
 8a9:	74 f5                	je     8a0 <atoi+0x10>
  sign = (*s == '-') ? -1 : 1;
 8ab:	80 f9 2d             	cmp    $0x2d,%cl
 8ae:	74 40                	je     8f0 <atoi+0x60>
 8b0:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 8b5:	80 f9 2b             	cmp    $0x2b,%cl
 8b8:	74 3b                	je     8f5 <atoi+0x65>
    s++;
  while('0' <= *s && *s <= '9')
 8ba:	0f be 0a             	movsbl (%edx),%ecx
 8bd:	8d 41 d0             	lea    -0x30(%ecx),%eax
 8c0:	3c 09                	cmp    $0x9,%al
 8c2:	b8 00 00 00 00       	mov    $0x0,%eax
 8c7:	77 1f                	ja     8e8 <atoi+0x58>
 8c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 8d0:	83 c2 01             	add    $0x1,%edx
 8d3:	8d 04 80             	lea    (%eax,%eax,4),%eax
 8d6:	8d 44 41 d0          	lea    -0x30(%ecx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 8da:	0f be 0a             	movsbl (%edx),%ecx
 8dd:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 8e0:	80 fb 09             	cmp    $0x9,%bl
 8e3:	76 eb                	jbe    8d0 <atoi+0x40>
 8e5:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 8e8:	5b                   	pop    %ebx
 8e9:	5e                   	pop    %esi
 8ea:	5d                   	pop    %ebp
 8eb:	c3                   	ret    
 8ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 8f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 8f5:	83 c2 01             	add    $0x1,%edx
 8f8:	eb c0                	jmp    8ba <atoi+0x2a>
 8fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000900 <atoo>:

int
atoo(const char *s)
{
 900:	55                   	push   %ebp
 901:	89 e5                	mov    %esp,%ebp
 903:	56                   	push   %esi
 904:	8b 55 08             	mov    0x8(%ebp),%edx
 907:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 908:	0f b6 0a             	movzbl (%edx),%ecx
 90b:	80 f9 20             	cmp    $0x20,%cl
 90e:	75 0b                	jne    91b <atoo+0x1b>
 910:	83 c2 01             	add    $0x1,%edx
 913:	0f b6 0a             	movzbl (%edx),%ecx
 916:	80 f9 20             	cmp    $0x20,%cl
 919:	74 f5                	je     910 <atoo+0x10>
  sign = (*s == '-') ? -1 : 1;
 91b:	80 f9 2d             	cmp    $0x2d,%cl
 91e:	74 40                	je     960 <atoo+0x60>
 920:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
 925:	80 f9 2b             	cmp    $0x2b,%cl
 928:	74 3b                	je     965 <atoo+0x65>
    s++;
  while('0' <= *s && *s <= '7')
 92a:	0f be 0a             	movsbl (%edx),%ecx
 92d:	8d 41 d0             	lea    -0x30(%ecx),%eax
 930:	3c 07                	cmp    $0x7,%al
 932:	b8 00 00 00 00       	mov    $0x0,%eax
 937:	77 1c                	ja     955 <atoo+0x55>
 939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*8 + *s++ - '0';
 940:	83 c2 01             	add    $0x1,%edx
 943:	8d 44 c1 d0          	lea    -0x30(%ecx,%eax,8),%eax
  while('0' <= *s && *s <= '7')
 947:	0f be 0a             	movsbl (%edx),%ecx
 94a:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 94d:	80 fb 07             	cmp    $0x7,%bl
 950:	76 ee                	jbe    940 <atoo+0x40>
 952:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
 955:	5b                   	pop    %ebx
 956:	5e                   	pop    %esi
 957:	5d                   	pop    %ebp
 958:	c3                   	ret    
 959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
 960:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
 965:	83 c2 01             	add    $0x1,%edx
 968:	eb c0                	jmp    92a <atoo+0x2a>
 96a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000970 <memmove>:
}
#endif // PDX_XV6

void*
memmove(void *vdst, void *vsrc, int n)
{
 970:	55                   	push   %ebp
 971:	89 e5                	mov    %esp,%ebp
 973:	57                   	push   %edi
 974:	8b 55 10             	mov    0x10(%ebp),%edx
 977:	8b 45 08             	mov    0x8(%ebp),%eax
 97a:	56                   	push   %esi
 97b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 97e:	85 d2                	test   %edx,%edx
 980:	7e 13                	jle    995 <memmove+0x25>
 982:	01 c2                	add    %eax,%edx
  dst = vdst;
 984:	89 c7                	mov    %eax,%edi
 986:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 98d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 990:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 991:	39 fa                	cmp    %edi,%edx
 993:	75 fb                	jne    990 <memmove+0x20>
  return vdst;
}
 995:	5e                   	pop    %esi
 996:	5f                   	pop    %edi
 997:	5d                   	pop    %ebp
 998:	c3                   	ret    

00000999 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 999:	b8 01 00 00 00       	mov    $0x1,%eax
 99e:	cd 40                	int    $0x40
 9a0:	c3                   	ret    

000009a1 <exit>:
SYSCALL(exit)
 9a1:	b8 02 00 00 00       	mov    $0x2,%eax
 9a6:	cd 40                	int    $0x40
 9a8:	c3                   	ret    

000009a9 <wait>:
SYSCALL(wait)
 9a9:	b8 03 00 00 00       	mov    $0x3,%eax
 9ae:	cd 40                	int    $0x40
 9b0:	c3                   	ret    

000009b1 <pipe>:
SYSCALL(pipe)
 9b1:	b8 04 00 00 00       	mov    $0x4,%eax
 9b6:	cd 40                	int    $0x40
 9b8:	c3                   	ret    

000009b9 <read>:
SYSCALL(read)
 9b9:	b8 05 00 00 00       	mov    $0x5,%eax
 9be:	cd 40                	int    $0x40
 9c0:	c3                   	ret    

000009c1 <write>:
SYSCALL(write)
 9c1:	b8 10 00 00 00       	mov    $0x10,%eax
 9c6:	cd 40                	int    $0x40
 9c8:	c3                   	ret    

000009c9 <close>:
SYSCALL(close)
 9c9:	b8 15 00 00 00       	mov    $0x15,%eax
 9ce:	cd 40                	int    $0x40
 9d0:	c3                   	ret    

000009d1 <kill>:
SYSCALL(kill)
 9d1:	b8 06 00 00 00       	mov    $0x6,%eax
 9d6:	cd 40                	int    $0x40
 9d8:	c3                   	ret    

000009d9 <exec>:
SYSCALL(exec)
 9d9:	b8 07 00 00 00       	mov    $0x7,%eax
 9de:	cd 40                	int    $0x40
 9e0:	c3                   	ret    

000009e1 <open>:
SYSCALL(open)
 9e1:	b8 0f 00 00 00       	mov    $0xf,%eax
 9e6:	cd 40                	int    $0x40
 9e8:	c3                   	ret    

000009e9 <mknod>:
SYSCALL(mknod)
 9e9:	b8 11 00 00 00       	mov    $0x11,%eax
 9ee:	cd 40                	int    $0x40
 9f0:	c3                   	ret    

000009f1 <unlink>:
SYSCALL(unlink)
 9f1:	b8 12 00 00 00       	mov    $0x12,%eax
 9f6:	cd 40                	int    $0x40
 9f8:	c3                   	ret    

000009f9 <fstat>:
SYSCALL(fstat)
 9f9:	b8 08 00 00 00       	mov    $0x8,%eax
 9fe:	cd 40                	int    $0x40
 a00:	c3                   	ret    

00000a01 <link>:
SYSCALL(link)
 a01:	b8 13 00 00 00       	mov    $0x13,%eax
 a06:	cd 40                	int    $0x40
 a08:	c3                   	ret    

00000a09 <mkdir>:
SYSCALL(mkdir)
 a09:	b8 14 00 00 00       	mov    $0x14,%eax
 a0e:	cd 40                	int    $0x40
 a10:	c3                   	ret    

00000a11 <chdir>:
SYSCALL(chdir)
 a11:	b8 09 00 00 00       	mov    $0x9,%eax
 a16:	cd 40                	int    $0x40
 a18:	c3                   	ret    

00000a19 <dup>:
SYSCALL(dup)
 a19:	b8 0a 00 00 00       	mov    $0xa,%eax
 a1e:	cd 40                	int    $0x40
 a20:	c3                   	ret    

00000a21 <getpid>:
SYSCALL(getpid)
 a21:	b8 0b 00 00 00       	mov    $0xb,%eax
 a26:	cd 40                	int    $0x40
 a28:	c3                   	ret    

00000a29 <sbrk>:
SYSCALL(sbrk)
 a29:	b8 0c 00 00 00       	mov    $0xc,%eax
 a2e:	cd 40                	int    $0x40
 a30:	c3                   	ret    

00000a31 <sleep>:
SYSCALL(sleep)
 a31:	b8 0d 00 00 00       	mov    $0xd,%eax
 a36:	cd 40                	int    $0x40
 a38:	c3                   	ret    

00000a39 <uptime>:
SYSCALL(uptime)
 a39:	b8 0e 00 00 00       	mov    $0xe,%eax
 a3e:	cd 40                	int    $0x40
 a40:	c3                   	ret    

00000a41 <halt>:
SYSCALL(halt)
 a41:	b8 16 00 00 00       	mov    $0x16,%eax
 a46:	cd 40                	int    $0x40
 a48:	c3                   	ret    

00000a49 <date>:
SYSCALL(date)
 a49:	b8 17 00 00 00       	mov    $0x17,%eax
 a4e:	cd 40                	int    $0x40
 a50:	c3                   	ret    

00000a51 <getgid>:
SYSCALL(getgid)
 a51:	b8 18 00 00 00       	mov    $0x18,%eax
 a56:	cd 40                	int    $0x40
 a58:	c3                   	ret    

00000a59 <setgid>:
SYSCALL(setgid)
 a59:	b8 19 00 00 00       	mov    $0x19,%eax
 a5e:	cd 40                	int    $0x40
 a60:	c3                   	ret    

00000a61 <getuid>:
SYSCALL(getuid)
 a61:	b8 1a 00 00 00       	mov    $0x1a,%eax
 a66:	cd 40                	int    $0x40
 a68:	c3                   	ret    

00000a69 <setuid>:
SYSCALL(setuid)
 a69:	b8 1b 00 00 00       	mov    $0x1b,%eax
 a6e:	cd 40                	int    $0x40
 a70:	c3                   	ret    

00000a71 <getppid>:
SYSCALL(getppid)
 a71:	b8 1c 00 00 00       	mov    $0x1c,%eax
 a76:	cd 40                	int    $0x40
 a78:	c3                   	ret    

00000a79 <getprocs>:
SYSCALL(getprocs)
 a79:	b8 1d 00 00 00       	mov    $0x1d,%eax
 a7e:	cd 40                	int    $0x40
 a80:	c3                   	ret    

00000a81 <setpriority>:
SYSCALL(setpriority)
 a81:	b8 1e 00 00 00       	mov    $0x1e,%eax
 a86:	cd 40                	int    $0x40
 a88:	c3                   	ret    

00000a89 <getpriority>:
SYSCALL(getpriority)
 a89:	b8 1f 00 00 00       	mov    $0x1f,%eax
 a8e:	cd 40                	int    $0x40
 a90:	c3                   	ret    

00000a91 <chmod>:
SYSCALL(chmod)
 a91:	b8 20 00 00 00       	mov    $0x20,%eax
 a96:	cd 40                	int    $0x40
 a98:	c3                   	ret    

00000a99 <chown>:
SYSCALL(chown)
 a99:	b8 21 00 00 00       	mov    $0x21,%eax
 a9e:	cd 40                	int    $0x40
 aa0:	c3                   	ret    

00000aa1 <chgrp>:
SYSCALL(chgrp)
 aa1:	b8 22 00 00 00       	mov    $0x22,%eax
 aa6:	cd 40                	int    $0x40
 aa8:	c3                   	ret    
 aa9:	66 90                	xchg   %ax,%ax
 aab:	66 90                	xchg   %ax,%ax
 aad:	66 90                	xchg   %ax,%ax
 aaf:	90                   	nop

00000ab0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 ab0:	55                   	push   %ebp
 ab1:	89 e5                	mov    %esp,%ebp
 ab3:	57                   	push   %edi
 ab4:	56                   	push   %esi
 ab5:	53                   	push   %ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 ab6:	89 d3                	mov    %edx,%ebx
{
 ab8:	83 ec 3c             	sub    $0x3c,%esp
 abb:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 abe:	85 d2                	test   %edx,%edx
 ac0:	0f 89 92 00 00 00    	jns    b58 <printint+0xa8>
 ac6:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 aca:	0f 84 88 00 00 00    	je     b58 <printint+0xa8>
    neg = 1;
 ad0:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 ad7:	f7 db                	neg    %ebx
  } else {
    x = xx;
  }

  i = 0;
 ad9:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 ae0:	8d 75 d7             	lea    -0x29(%ebp),%esi
 ae3:	eb 08                	jmp    aed <printint+0x3d>
 ae5:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 ae8:	89 7d c4             	mov    %edi,-0x3c(%ebp)
  }while((x /= base) != 0);
 aeb:	89 c3                	mov    %eax,%ebx
    buf[i++] = digits[x % base];
 aed:	89 d8                	mov    %ebx,%eax
 aef:	31 d2                	xor    %edx,%edx
 af1:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 af4:	f7 f1                	div    %ecx
 af6:	83 c7 01             	add    $0x1,%edi
 af9:	0f b6 92 6c 0f 00 00 	movzbl 0xf6c(%edx),%edx
 b00:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 b03:	39 d9                	cmp    %ebx,%ecx
 b05:	76 e1                	jbe    ae8 <printint+0x38>
  if(neg)
 b07:	8b 45 c0             	mov    -0x40(%ebp),%eax
 b0a:	85 c0                	test   %eax,%eax
 b0c:	74 0d                	je     b1b <printint+0x6b>
    buf[i++] = '-';
 b0e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 b13:	ba 2d 00 00 00       	mov    $0x2d,%edx
    buf[i++] = digits[x % base];
 b18:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 b1b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 b1e:	8b 7d bc             	mov    -0x44(%ebp),%edi
 b21:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 b25:	eb 0f                	jmp    b36 <printint+0x86>
 b27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 b2e:	66 90                	xchg   %ax,%ax
 b30:	0f b6 13             	movzbl (%ebx),%edx
 b33:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 b36:	83 ec 04             	sub    $0x4,%esp
 b39:	88 55 d7             	mov    %dl,-0x29(%ebp)
 b3c:	6a 01                	push   $0x1
 b3e:	56                   	push   %esi
 b3f:	57                   	push   %edi
 b40:	e8 7c fe ff ff       	call   9c1 <write>

  while(--i >= 0)
 b45:	83 c4 10             	add    $0x10,%esp
 b48:	39 de                	cmp    %ebx,%esi
 b4a:	75 e4                	jne    b30 <printint+0x80>
    putc(fd, buf[i]);
}
 b4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 b4f:	5b                   	pop    %ebx
 b50:	5e                   	pop    %esi
 b51:	5f                   	pop    %edi
 b52:	5d                   	pop    %ebp
 b53:	c3                   	ret    
 b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 b58:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 b5f:	e9 75 ff ff ff       	jmp    ad9 <printint+0x29>
 b64:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 b6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 b6f:	90                   	nop

00000b70 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 b70:	55                   	push   %ebp
 b71:	89 e5                	mov    %esp,%ebp
 b73:	57                   	push   %edi
 b74:	56                   	push   %esi
 b75:	53                   	push   %ebx
 b76:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 b79:	8b 75 0c             	mov    0xc(%ebp),%esi
 b7c:	0f b6 1e             	movzbl (%esi),%ebx
 b7f:	84 db                	test   %bl,%bl
 b81:	0f 84 b9 00 00 00    	je     c40 <printf+0xd0>
  ap = (uint*)(void*)&fmt + 1;
 b87:	8d 45 10             	lea    0x10(%ebp),%eax
 b8a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 b8d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 b90:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 b92:	89 45 d0             	mov    %eax,-0x30(%ebp)
 b95:	eb 38                	jmp    bcf <printf+0x5f>
 b97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 b9e:	66 90                	xchg   %ax,%ax
 ba0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 ba3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 ba8:	83 f8 25             	cmp    $0x25,%eax
 bab:	74 17                	je     bc4 <printf+0x54>
  write(fd, &c, 1);
 bad:	83 ec 04             	sub    $0x4,%esp
 bb0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 bb3:	6a 01                	push   $0x1
 bb5:	57                   	push   %edi
 bb6:	ff 75 08             	pushl  0x8(%ebp)
 bb9:	e8 03 fe ff ff       	call   9c1 <write>
 bbe:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 bc1:	83 c4 10             	add    $0x10,%esp
 bc4:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 bc7:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 bcb:	84 db                	test   %bl,%bl
 bcd:	74 71                	je     c40 <printf+0xd0>
    c = fmt[i] & 0xff;
 bcf:	0f be cb             	movsbl %bl,%ecx
 bd2:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 bd5:	85 d2                	test   %edx,%edx
 bd7:	74 c7                	je     ba0 <printf+0x30>
      }
    } else if(state == '%'){
 bd9:	83 fa 25             	cmp    $0x25,%edx
 bdc:	75 e6                	jne    bc4 <printf+0x54>
      if(c == 'd'){
 bde:	83 f8 64             	cmp    $0x64,%eax
 be1:	0f 84 99 00 00 00    	je     c80 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 be7:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 bed:	83 f9 70             	cmp    $0x70,%ecx
 bf0:	74 5e                	je     c50 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 bf2:	83 f8 73             	cmp    $0x73,%eax
 bf5:	0f 84 d5 00 00 00    	je     cd0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 bfb:	83 f8 63             	cmp    $0x63,%eax
 bfe:	0f 84 8c 00 00 00    	je     c90 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 c04:	83 f8 25             	cmp    $0x25,%eax
 c07:	0f 84 b3 00 00 00    	je     cc0 <printf+0x150>
  write(fd, &c, 1);
 c0d:	83 ec 04             	sub    $0x4,%esp
 c10:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 c14:	6a 01                	push   $0x1
 c16:	57                   	push   %edi
 c17:	ff 75 08             	pushl  0x8(%ebp)
 c1a:	e8 a2 fd ff ff       	call   9c1 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 c1f:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 c22:	83 c4 0c             	add    $0xc,%esp
 c25:	6a 01                	push   $0x1
 c27:	83 c6 01             	add    $0x1,%esi
 c2a:	57                   	push   %edi
 c2b:	ff 75 08             	pushl  0x8(%ebp)
 c2e:	e8 8e fd ff ff       	call   9c1 <write>
  for(i = 0; fmt[i]; i++){
 c33:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 c37:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 c3a:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 c3c:	84 db                	test   %bl,%bl
 c3e:	75 8f                	jne    bcf <printf+0x5f>
    }
  }
}
 c40:	8d 65 f4             	lea    -0xc(%ebp),%esp
 c43:	5b                   	pop    %ebx
 c44:	5e                   	pop    %esi
 c45:	5f                   	pop    %edi
 c46:	5d                   	pop    %ebp
 c47:	c3                   	ret    
 c48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 c4f:	90                   	nop
        printint(fd, *ap, 16, 0);
 c50:	83 ec 0c             	sub    $0xc,%esp
 c53:	b9 10 00 00 00       	mov    $0x10,%ecx
 c58:	6a 00                	push   $0x0
 c5a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 c5d:	8b 45 08             	mov    0x8(%ebp),%eax
 c60:	8b 13                	mov    (%ebx),%edx
 c62:	e8 49 fe ff ff       	call   ab0 <printint>
        ap++;
 c67:	89 d8                	mov    %ebx,%eax
 c69:	83 c4 10             	add    $0x10,%esp
      state = 0;
 c6c:	31 d2                	xor    %edx,%edx
        ap++;
 c6e:	83 c0 04             	add    $0x4,%eax
 c71:	89 45 d0             	mov    %eax,-0x30(%ebp)
 c74:	e9 4b ff ff ff       	jmp    bc4 <printf+0x54>
 c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 c80:	83 ec 0c             	sub    $0xc,%esp
 c83:	b9 0a 00 00 00       	mov    $0xa,%ecx
 c88:	6a 01                	push   $0x1
 c8a:	eb ce                	jmp    c5a <printf+0xea>
 c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 c90:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 c93:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 c96:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 c98:	6a 01                	push   $0x1
        ap++;
 c9a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 c9d:	57                   	push   %edi
 c9e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 ca1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 ca4:	e8 18 fd ff ff       	call   9c1 <write>
        ap++;
 ca9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 cac:	83 c4 10             	add    $0x10,%esp
      state = 0;
 caf:	31 d2                	xor    %edx,%edx
 cb1:	e9 0e ff ff ff       	jmp    bc4 <printf+0x54>
 cb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 cbd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 cc0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 cc3:	83 ec 04             	sub    $0x4,%esp
 cc6:	e9 5a ff ff ff       	jmp    c25 <printf+0xb5>
 ccb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 ccf:	90                   	nop
        s = (char*)*ap;
 cd0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 cd3:	8b 18                	mov    (%eax),%ebx
        ap++;
 cd5:	83 c0 04             	add    $0x4,%eax
 cd8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 cdb:	85 db                	test   %ebx,%ebx
 cdd:	74 17                	je     cf6 <printf+0x186>
        while(*s != 0){
 cdf:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 ce2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 ce4:	84 c0                	test   %al,%al
 ce6:	0f 84 d8 fe ff ff    	je     bc4 <printf+0x54>
 cec:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 cef:	89 de                	mov    %ebx,%esi
 cf1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 cf4:	eb 1a                	jmp    d10 <printf+0x1a0>
          s = "(null)";
 cf6:	bb 64 0f 00 00       	mov    $0xf64,%ebx
        while(*s != 0){
 cfb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 cfe:	b8 28 00 00 00       	mov    $0x28,%eax
 d03:	89 de                	mov    %ebx,%esi
 d05:	8b 5d 08             	mov    0x8(%ebp),%ebx
 d08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 d0f:	90                   	nop
  write(fd, &c, 1);
 d10:	83 ec 04             	sub    $0x4,%esp
          s++;
 d13:	83 c6 01             	add    $0x1,%esi
 d16:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 d19:	6a 01                	push   $0x1
 d1b:	57                   	push   %edi
 d1c:	53                   	push   %ebx
 d1d:	e8 9f fc ff ff       	call   9c1 <write>
        while(*s != 0){
 d22:	0f b6 06             	movzbl (%esi),%eax
 d25:	83 c4 10             	add    $0x10,%esp
 d28:	84 c0                	test   %al,%al
 d2a:	75 e4                	jne    d10 <printf+0x1a0>
 d2c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 d2f:	31 d2                	xor    %edx,%edx
 d31:	e9 8e fe ff ff       	jmp    bc4 <printf+0x54>
 d36:	66 90                	xchg   %ax,%ax
 d38:	66 90                	xchg   %ax,%ax
 d3a:	66 90                	xchg   %ax,%ax
 d3c:	66 90                	xchg   %ax,%ax
 d3e:	66 90                	xchg   %ax,%ax

00000d40 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 d40:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d41:	a1 14 13 00 00       	mov    0x1314,%eax
{
 d46:	89 e5                	mov    %esp,%ebp
 d48:	57                   	push   %edi
 d49:	56                   	push   %esi
 d4a:	53                   	push   %ebx
 d4b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 d4e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 d50:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d53:	39 c8                	cmp    %ecx,%eax
 d55:	73 19                	jae    d70 <free+0x30>
 d57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 d5e:	66 90                	xchg   %ax,%ax
 d60:	39 d1                	cmp    %edx,%ecx
 d62:	72 14                	jb     d78 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d64:	39 d0                	cmp    %edx,%eax
 d66:	73 10                	jae    d78 <free+0x38>
{
 d68:	89 d0                	mov    %edx,%eax
 d6a:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d6c:	39 c8                	cmp    %ecx,%eax
 d6e:	72 f0                	jb     d60 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d70:	39 d0                	cmp    %edx,%eax
 d72:	72 f4                	jb     d68 <free+0x28>
 d74:	39 d1                	cmp    %edx,%ecx
 d76:	73 f0                	jae    d68 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 d78:	8b 73 fc             	mov    -0x4(%ebx),%esi
 d7b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 d7e:	39 fa                	cmp    %edi,%edx
 d80:	74 1e                	je     da0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 d82:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 d85:	8b 50 04             	mov    0x4(%eax),%edx
 d88:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 d8b:	39 f1                	cmp    %esi,%ecx
 d8d:	74 28                	je     db7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 d8f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 d91:	5b                   	pop    %ebx
  freep = p;
 d92:	a3 14 13 00 00       	mov    %eax,0x1314
}
 d97:	5e                   	pop    %esi
 d98:	5f                   	pop    %edi
 d99:	5d                   	pop    %ebp
 d9a:	c3                   	ret    
 d9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 d9f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 da0:	03 72 04             	add    0x4(%edx),%esi
 da3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 da6:	8b 10                	mov    (%eax),%edx
 da8:	8b 12                	mov    (%edx),%edx
 daa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 dad:	8b 50 04             	mov    0x4(%eax),%edx
 db0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 db3:	39 f1                	cmp    %esi,%ecx
 db5:	75 d8                	jne    d8f <free+0x4f>
    p->s.size += bp->s.size;
 db7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 dba:	a3 14 13 00 00       	mov    %eax,0x1314
    p->s.size += bp->s.size;
 dbf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 dc2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 dc5:	89 10                	mov    %edx,(%eax)
}
 dc7:	5b                   	pop    %ebx
 dc8:	5e                   	pop    %esi
 dc9:	5f                   	pop    %edi
 dca:	5d                   	pop    %ebp
 dcb:	c3                   	ret    
 dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000dd0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 dd0:	55                   	push   %ebp
 dd1:	89 e5                	mov    %esp,%ebp
 dd3:	57                   	push   %edi
 dd4:	56                   	push   %esi
 dd5:	53                   	push   %ebx
 dd6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 dd9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 ddc:	8b 3d 14 13 00 00    	mov    0x1314,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 de2:	8d 70 07             	lea    0x7(%eax),%esi
 de5:	c1 ee 03             	shr    $0x3,%esi
 de8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 deb:	85 ff                	test   %edi,%edi
 ded:	0f 84 ad 00 00 00    	je     ea0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 df3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 df5:	8b 4a 04             	mov    0x4(%edx),%ecx
 df8:	39 f1                	cmp    %esi,%ecx
 dfa:	73 72                	jae    e6e <malloc+0x9e>
 dfc:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 e02:	bb 00 10 00 00       	mov    $0x1000,%ebx
 e07:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 e0a:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 e11:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 e14:	eb 1b                	jmp    e31 <malloc+0x61>
 e16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 e1d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e20:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 e22:	8b 48 04             	mov    0x4(%eax),%ecx
 e25:	39 f1                	cmp    %esi,%ecx
 e27:	73 4f                	jae    e78 <malloc+0xa8>
 e29:	8b 3d 14 13 00 00    	mov    0x1314,%edi
 e2f:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 e31:	39 d7                	cmp    %edx,%edi
 e33:	75 eb                	jne    e20 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 e35:	83 ec 0c             	sub    $0xc,%esp
 e38:	ff 75 e4             	pushl  -0x1c(%ebp)
 e3b:	e8 e9 fb ff ff       	call   a29 <sbrk>
  if(p == (char*)-1)
 e40:	83 c4 10             	add    $0x10,%esp
 e43:	83 f8 ff             	cmp    $0xffffffff,%eax
 e46:	74 1c                	je     e64 <malloc+0x94>
  hp->s.size = nu;
 e48:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 e4b:	83 ec 0c             	sub    $0xc,%esp
 e4e:	83 c0 08             	add    $0x8,%eax
 e51:	50                   	push   %eax
 e52:	e8 e9 fe ff ff       	call   d40 <free>
  return freep;
 e57:	8b 15 14 13 00 00    	mov    0x1314,%edx
      if((p = morecore(nunits)) == 0)
 e5d:	83 c4 10             	add    $0x10,%esp
 e60:	85 d2                	test   %edx,%edx
 e62:	75 bc                	jne    e20 <malloc+0x50>
        return 0;
  }
}
 e64:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 e67:	31 c0                	xor    %eax,%eax
}
 e69:	5b                   	pop    %ebx
 e6a:	5e                   	pop    %esi
 e6b:	5f                   	pop    %edi
 e6c:	5d                   	pop    %ebp
 e6d:	c3                   	ret    
    if(p->s.size >= nunits){
 e6e:	89 d0                	mov    %edx,%eax
 e70:	89 fa                	mov    %edi,%edx
 e72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 e78:	39 ce                	cmp    %ecx,%esi
 e7a:	74 54                	je     ed0 <malloc+0x100>
        p->s.size -= nunits;
 e7c:	29 f1                	sub    %esi,%ecx
 e7e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 e81:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 e84:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 e87:	89 15 14 13 00 00    	mov    %edx,0x1314
}
 e8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 e90:	83 c0 08             	add    $0x8,%eax
}
 e93:	5b                   	pop    %ebx
 e94:	5e                   	pop    %esi
 e95:	5f                   	pop    %edi
 e96:	5d                   	pop    %ebp
 e97:	c3                   	ret    
 e98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 e9f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 ea0:	c7 05 14 13 00 00 18 	movl   $0x1318,0x1314
 ea7:	13 00 00 
    base.s.size = 0;
 eaa:	bf 18 13 00 00       	mov    $0x1318,%edi
    base.s.ptr = freep = prevp = &base;
 eaf:	c7 05 18 13 00 00 18 	movl   $0x1318,0x1318
 eb6:	13 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 eb9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 ebb:	c7 05 1c 13 00 00 00 	movl   $0x0,0x131c
 ec2:	00 00 00 
    if(p->s.size >= nunits){
 ec5:	e9 32 ff ff ff       	jmp    dfc <malloc+0x2c>
 eca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 ed0:	8b 08                	mov    (%eax),%ecx
 ed2:	89 0a                	mov    %ecx,(%edx)
 ed4:	eb b1                	jmp    e87 <malloc+0xb7>
