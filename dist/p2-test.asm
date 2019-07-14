
_p2-test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
}
#endif

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
      11:	83 ec 20             	sub    $0x20,%esp
      14:	8b 41 04             	mov    0x4(%ecx),%eax
  #ifdef CPUTIME_TEST
  testcputime(argv[0]);
      17:	8b 30                	mov    (%eax),%esi
  printf(1, "\n----------\nRunning CPU Time Test\n----------\n");
      19:	68 cc 14 00 00       	push   $0x14cc
      1e:	6a 01                	push   $0x1
      20:	e8 eb 0e 00 00       	call   f10 <printf>
  table = malloc(sizeof(struct uproc) * 64);
      25:	c7 04 24 00 18 00 00 	movl   $0x1800,(%esp)
      2c:	e8 3f 11 00 00       	call   1170 <malloc>
  if (!table) {
      31:	83 c4 10             	add    $0x10,%esp
      34:	85 c0                	test   %eax,%eax
      36:	0f 84 a1 04 00 00    	je     4dd <main+0x4dd>
  printf(1, "This will take a couple seconds\n");
      3c:	83 ec 08             	sub    $0x8,%esp
      3f:	89 c3                	mov    %eax,%ebx
    ++num;
      41:	bf 01 00 00 00       	mov    $0x1,%edi
  printf(1, "This will take a couple seconds\n");
      46:	68 fc 14 00 00       	push   $0x14fc
      4b:	6a 01                	push   $0x1
      4d:	e8 be 0e 00 00       	call   f10 <printf>
  time1 = getcputime(name, table);
      52:	89 da                	mov    %ebx,%edx
      54:	89 f0                	mov    %esi,%eax
      56:	e8 c5 06 00 00       	call   720 <getcputime>
      5b:	83 c4 10             	add    $0x10,%esp
  int success = 0;
      5e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  time1 = getcputime(name, table);
      65:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(num % 100000 == 0){
      68:	eb 0e                	jmp    78 <main+0x78>
      6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(i = 0, num = 0; i < 1000000; ++i){
      70:	81 ff 40 42 0f 00    	cmp    $0xf4240,%edi
      76:	74 70                	je     e8 <main+0xe8>
    ++num;
      78:	83 c7 01             	add    $0x1,%edi
    if(num % 100000 == 0){
      7b:	b8 c5 5a 7c 0a       	mov    $0xa7c5ac5,%eax
      80:	89 fa                	mov    %edi,%edx
      82:	c1 ea 05             	shr    $0x5,%edx
      85:	f7 e2                	mul    %edx
      87:	c1 ea 07             	shr    $0x7,%edx
      8a:	69 d2 a0 86 01 00    	imul   $0x186a0,%edx,%edx
      90:	39 d7                	cmp    %edx,%edi
      92:	75 dc                	jne    70 <main+0x70>
      pre_sleep = getcputime(name, table);
      94:	89 da                	mov    %ebx,%edx
      96:	89 f0                	mov    %esi,%eax
      98:	e8 83 06 00 00       	call   720 <getcputime>
      sleep(200);
      9d:	83 ec 0c             	sub    $0xc,%esp
      a0:	68 c8 00 00 00       	push   $0xc8
      pre_sleep = getcputime(name, table);
      a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
      sleep(200);
      a8:	e8 24 0d 00 00       	call   dd1 <sleep>
      post_sleep = getcputime(name, table);
      ad:	89 da                	mov    %ebx,%edx
      af:	89 f0                	mov    %esi,%eax
      b1:	e8 6a 06 00 00       	call   720 <getcputime>
      if((post_sleep - pre_sleep) >= 100){
      b6:	2b 45 e0             	sub    -0x20(%ebp),%eax
      b9:	83 c4 10             	add    $0x10,%esp
      bc:	83 f8 63             	cmp    $0x63,%eax
      bf:	76 af                	jbe    70 <main+0x70>
        printf(2, "FAILED: CPU_total_ticks changed by 100+ milliseconds while process was asleep\n");
      c1:	83 ec 08             	sub    $0x8,%esp
      c4:	68 20 15 00 00       	push   $0x1520
      c9:	6a 02                	push   $0x2
      cb:	e8 40 0e 00 00       	call   f10 <printf>
      d0:	83 c4 10             	add    $0x10,%esp
        success = -1;
      d3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  for(i = 0, num = 0; i < 1000000; ++i){
      da:	81 ff 40 42 0f 00    	cmp    $0xf4240,%edi
      e0:	75 96                	jne    78 <main+0x78>
      e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  time2 = getcputime(name, table);
      e8:	89 f0                	mov    %esi,%eax
      ea:	89 da                	mov    %ebx,%edx
      ec:	e8 2f 06 00 00       	call   720 <getcputime>
  if((time2 - time1) > 400){
      f1:	2b 45 dc             	sub    -0x24(%ebp),%eax
      f4:	89 c6                	mov    %eax,%esi
      f6:	3d 90 01 00 00       	cmp    $0x190,%eax
      fb:	0f 87 72 02 00 00    	ja     373 <main+0x373>
  printf(1, "T2 - T1 = %d milliseconds\n", (time2 - time1));
     101:	83 ec 04             	sub    $0x4,%esp
     104:	50                   	push   %eax
     105:	68 25 18 00 00       	push   $0x1825
     10a:	6a 01                	push   $0x1
     10c:	e8 ff 0d 00 00       	call   f10 <printf>
  free(table);
     111:	89 1c 24             	mov    %ebx,(%esp)
     114:	e8 c7 0f 00 00       	call   10e0 <free>
  if(success == 0)
     119:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     11c:	83 c4 10             	add    $0x10,%esp
     11f:	85 c0                	test   %eax,%eax
     121:	75 11                	jne    134 <main+0x134>
    printf(1, "** All Tests Passed! **\n");
     123:	50                   	push   %eax
     124:	50                   	push   %eax
     125:	68 40 18 00 00       	push   $0x1840
     12a:	6a 01                	push   $0x1
     12c:	e8 df 0d 00 00       	call   f10 <printf>
     131:	83 c4 10             	add    $0x10,%esp
  printf(1, "\n----------\nRunning UID / GID Tests\n----------\n");
     134:	83 ec 08             	sub    $0x8,%esp
  int success = 0;
     137:	31 db                	xor    %ebx,%ebx
  printf(1, "\n----------\nRunning UID / GID Tests\n----------\n");
     139:	68 b0 15 00 00       	push   $0x15b0
     13e:	6a 01                	push   $0x1
     140:	e8 cb 0d 00 00       	call   f10 <printf>
  uid = getuid();
     145:	e8 b7 0c 00 00       	call   e01 <getuid>
  if(uid < 0 || uid > 32767){
     14a:	83 c4 10             	add    $0x10,%esp
     14d:	3d ff 7f 00 00       	cmp    $0x7fff,%eax
     152:	0f 87 49 02 00 00    	ja     3a1 <main+0x3a1>
  if (testuid(0, 0, 0))
     158:	31 c9                	xor    %ecx,%ecx
     15a:	31 d2                	xor    %edx,%edx
     15c:	31 c0                	xor    %eax,%eax
    success = -1;
     15e:	be ff ff ff ff       	mov    $0xffffffff,%esi
  if (testuid(0, 0, 0))
     163:	e8 28 04 00 00       	call   590 <testuid>
  if (testuid(5, 5, 0))
     168:	ba 05 00 00 00       	mov    $0x5,%edx
    success = -1;
     16d:	85 c0                	test   %eax,%eax
  if (testuid(5, 5, 0))
     16f:	b8 05 00 00 00       	mov    $0x5,%eax
    success = -1;
     174:	0f 45 de             	cmovne %esi,%ebx
  if (testuid(5, 5, 0))
     177:	31 c9                	xor    %ecx,%ecx
     179:	e8 12 04 00 00       	call   590 <testuid>
  if (testuid(32767, 32767, 0))
     17e:	ba ff 7f 00 00       	mov    $0x7fff,%edx
    success = -1;
     183:	85 c0                	test   %eax,%eax
  if (testuid(32767, 32767, 0))
     185:	b8 ff 7f 00 00       	mov    $0x7fff,%eax
    success = -1;
     18a:	0f 45 de             	cmovne %esi,%ebx
  if (testuid(32767, 32767, 0))
     18d:	31 c9                	xor    %ecx,%ecx
     18f:	e8 fc 03 00 00       	call   590 <testuid>
  if (testuid(32768, 32767, -1))
     194:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
     199:	ba ff 7f 00 00       	mov    $0x7fff,%edx
    success = -1;
     19e:	85 c0                	test   %eax,%eax
  if (testuid(32768, 32767, -1))
     1a0:	b8 00 80 00 00       	mov    $0x8000,%eax
    success = -1;
     1a5:	0f 45 de             	cmovne %esi,%ebx
  if (testuid(32768, 32767, -1))
     1a8:	e8 e3 03 00 00       	call   590 <testuid>
  if (testuid(-1, 32767, -1))
     1ad:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
     1b2:	ba ff 7f 00 00       	mov    $0x7fff,%edx
    success = -1;
     1b7:	85 c0                	test   %eax,%eax
  if (testuid(-1, 32767, -1))
     1b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    success = -1;
     1be:	0f 45 de             	cmovne %esi,%ebx
  if (testuid(-1, 32767, -1))
     1c1:	e8 ca 03 00 00       	call   590 <testuid>
    success = -1;
     1c6:	85 c0                	test   %eax,%eax
     1c8:	0f 45 de             	cmovne %esi,%ebx
  gid = getgid();
     1cb:	e8 21 0c 00 00       	call   df1 <getgid>
  if(gid < 0 || gid > 32767){
     1d0:	3d ff 7f 00 00       	cmp    $0x7fff,%eax
     1d5:	0f 87 7f 01 00 00    	ja     35a <main+0x35a>
  if (testgid(0, 0, 0))
     1db:	31 c9                	xor    %ecx,%ecx
     1dd:	31 d2                	xor    %edx,%edx
     1df:	31 c0                	xor    %eax,%eax
    success = -1;
     1e1:	be ff ff ff ff       	mov    $0xffffffff,%esi
  if (testgid(0, 0, 0))
     1e6:	e8 25 04 00 00       	call   610 <testgid>
  if (testgid(5, 5, 0))
     1eb:	ba 05 00 00 00       	mov    $0x5,%edx
    success = -1;
     1f0:	85 c0                	test   %eax,%eax
  if (testgid(5, 5, 0))
     1f2:	b8 05 00 00 00       	mov    $0x5,%eax
    success = -1;
     1f7:	0f 45 de             	cmovne %esi,%ebx
  if (testgid(5, 5, 0))
     1fa:	31 c9                	xor    %ecx,%ecx
     1fc:	e8 0f 04 00 00       	call   610 <testgid>
  if (testgid(32767, 32767, 0))
     201:	ba ff 7f 00 00       	mov    $0x7fff,%edx
    success = -1;
     206:	85 c0                	test   %eax,%eax
  if (testgid(32767, 32767, 0))
     208:	b8 ff 7f 00 00       	mov    $0x7fff,%eax
    success = -1;
     20d:	0f 45 de             	cmovne %esi,%ebx
  if (testgid(32767, 32767, 0))
     210:	31 c9                	xor    %ecx,%ecx
     212:	e8 f9 03 00 00       	call   610 <testgid>
  if (testgid(-1, 32767, -1))
     217:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
     21c:	ba ff 7f 00 00       	mov    $0x7fff,%edx
  if (testgid(32767, 32767, 0))
     221:	85 c0                	test   %eax,%eax
  if (testgid(-1, 32767, -1))
     223:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if (testgid(32767, 32767, 0))
     228:	0f 84 cb 00 00 00    	je     2f9 <main+0x2f9>
  if (testgid(-1, 32767, -1))
     22e:	e8 dd 03 00 00       	call   610 <testgid>
  if (testgid(32768, 32767, -1))
     233:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
     238:	ba ff 7f 00 00       	mov    $0x7fff,%edx
     23d:	b8 00 80 00 00       	mov    $0x8000,%eax
     242:	e8 c9 03 00 00       	call   610 <testgid>
  printf(1, "\n----------\nRunning UID / GID Inheritance Test\n----------\n");
     247:	83 ec 08             	sub    $0x8,%esp
     24a:	68 30 16 00 00       	push   $0x1630
     24f:	6a 01                	push   $0x1
     251:	e8 ba 0c 00 00       	call   f10 <printf>
  if (testuid(12345, 12345, 0))
     256:	31 c9                	xor    %ecx,%ecx
     258:	ba 39 30 00 00       	mov    $0x3039,%edx
     25d:	b8 39 30 00 00       	mov    $0x3039,%eax
     262:	e8 29 03 00 00       	call   590 <testuid>
     267:	83 c4 10             	add    $0x10,%esp
  if (testgid(12345, 12345, 0))
     26a:	31 c9                	xor    %ecx,%ecx
     26c:	ba 39 30 00 00       	mov    $0x3039,%edx
  if (testuid(12345, 12345, 0))
     271:	85 c0                	test   %eax,%eax
  if (testgid(12345, 12345, 0))
     273:	b8 39 30 00 00       	mov    $0x3039,%eax
  if (testuid(12345, 12345, 0))
     278:	0f 84 b8 00 00 00    	je     336 <main+0x336>
  if (testgid(12345, 12345, 0))
     27e:	e8 8d 03 00 00       	call   610 <testgid>
  printf(1, "\n----------\nRunning PPID Test\n----------\n");
     283:	83 ec 08             	sub    $0x8,%esp
     286:	68 cc 16 00 00       	push   $0x16cc
     28b:	6a 01                	push   $0x1
     28d:	e8 7e 0c 00 00       	call   f10 <printf>
  pid = getpid();
     292:	e8 2a 0b 00 00       	call   dc1 <getpid>
     297:	89 c3                	mov    %eax,%ebx
  ret = fork();
     299:	e8 9b 0a 00 00       	call   d39 <fork>
  if(ret == 0){
     29e:	83 c4 10             	add    $0x10,%esp
     2a1:	85 c0                	test   %eax,%eax
     2a3:	0f 84 15 02 00 00    	je     4be <main+0x4be>
    wait();
     2a9:	e8 9b 0a 00 00       	call   d49 <wait>
  printf(1, "\n----------\nRunning GetProcs Test\n----------\n");
     2ae:	83 ec 08             	sub    $0x8,%esp
     2b1:	68 28 17 00 00       	push   $0x1728
     2b6:	6a 01                	push   $0x1
     2b8:	e8 53 0c 00 00       	call   f10 <printf>
  printf(1, "Filling the proc[] array with dummy processes\n");
     2bd:	5f                   	pop    %edi
     2be:	58                   	pop    %eax
     2bf:	68 58 17 00 00       	push   $0x1758
     2c4:	6a 01                	push   $0x1
     2c6:	e8 45 0c 00 00       	call   f10 <printf>
  ret = fork();
     2cb:	e8 69 0a 00 00       	call   d39 <fork>
  if (ret == 0){
     2d0:	83 c4 10             	add    $0x10,%esp
     2d3:	85 c0                	test   %eax,%eax
     2d5:	0f 85 df 00 00 00    	jne    3ba <main+0x3ba>
     2db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     2df:	90                   	nop
    while((ret = fork()) == 0);
     2e0:	e8 54 0a 00 00       	call   d39 <fork>
     2e5:	85 c0                	test   %eax,%eax
     2e7:	74 f7                	je     2e0 <main+0x2e0>
    if(ret > 0){
     2e9:	0f 8e e8 00 00 00    	jle    3d7 <main+0x3d7>
      wait();
     2ef:	e8 55 0a 00 00       	call   d49 <wait>
      exit();
     2f4:	e8 48 0a 00 00       	call   d41 <exit>
  if (testgid(-1, 32767, -1))
     2f9:	e8 12 03 00 00       	call   610 <testgid>
     2fe:	85 c0                	test   %eax,%eax
     300:	0f 85 2d ff ff ff    	jne    233 <main+0x233>
  if (testgid(32768, 32767, -1))
     306:	83 c9 ff             	or     $0xffffffff,%ecx
     309:	ba ff 7f 00 00       	mov    $0x7fff,%edx
     30e:	b8 00 80 00 00       	mov    $0x8000,%eax
     313:	e8 f8 02 00 00       	call   610 <testgid>
  if (success == 0)
     318:	09 d8                	or     %ebx,%eax
     31a:	0f 85 27 ff ff ff    	jne    247 <main+0x247>
    printf(1, "** All tests passed! **\n");
     320:	53                   	push   %ebx
     321:	53                   	push   %ebx
     322:	68 59 18 00 00       	push   $0x1859
     327:	6a 01                	push   $0x1
     329:	e8 e2 0b 00 00       	call   f10 <printf>
     32e:	83 c4 10             	add    $0x10,%esp
     331:	e9 11 ff ff ff       	jmp    247 <main+0x247>
  if (testgid(12345, 12345, 0))
     336:	e8 d5 02 00 00       	call   610 <testgid>
     33b:	85 c0                	test   %eax,%eax
     33d:	0f 85 40 ff ff ff    	jne    283 <main+0x283>
  ret = fork();
     343:	e8 f1 09 00 00       	call   d39 <fork>
  if(ret == 0){
     348:	85 c0                	test   %eax,%eax
     34a:	0f 84 be 01 00 00    	je     50e <main+0x50e>
    wait();
     350:	e8 f4 09 00 00       	call   d49 <wait>
     355:	e9 29 ff ff ff       	jmp    283 <main+0x283>
    printf(1, "FAILED: Default GID %d, out of range\n", gid);
     35a:	56                   	push   %esi
    success = -1;
     35b:	83 cb ff             	or     $0xffffffff,%ebx
    printf(1, "FAILED: Default GID %d, out of range\n", gid);
     35e:	50                   	push   %eax
     35f:	68 08 16 00 00       	push   $0x1608
     364:	6a 01                	push   $0x1
     366:	e8 a5 0b 00 00       	call   f10 <printf>
     36b:	83 c4 10             	add    $0x10,%esp
     36e:	e9 68 fe ff ff       	jmp    1db <main+0x1db>
    printf(2, "ABNORMALLY HIGH: T2 - T1 = %d milliseconds.  Run test again\n", (time2 - time1));
     373:	50                   	push   %eax
     374:	56                   	push   %esi
     375:	68 70 15 00 00       	push   $0x1570
     37a:	6a 02                	push   $0x2
     37c:	e8 8f 0b 00 00       	call   f10 <printf>
  printf(1, "T2 - T1 = %d milliseconds\n", (time2 - time1));
     381:	83 c4 0c             	add    $0xc,%esp
     384:	56                   	push   %esi
     385:	68 25 18 00 00       	push   $0x1825
     38a:	6a 01                	push   $0x1
     38c:	e8 7f 0b 00 00       	call   f10 <printf>
  free(table);
     391:	89 1c 24             	mov    %ebx,(%esp)
     394:	e8 47 0d 00 00       	call   10e0 <free>
     399:	83 c4 10             	add    $0x10,%esp
     39c:	e9 93 fd ff ff       	jmp    134 <main+0x134>
    printf(1, "FAILED: Default UID %d, out of range\n", uid);
     3a1:	57                   	push   %edi
    success = -1;
     3a2:	83 cb ff             	or     $0xffffffff,%ebx
    printf(1, "FAILED: Default UID %d, out of range\n", uid);
     3a5:	50                   	push   %eax
     3a6:	68 e0 15 00 00       	push   $0x15e0
     3ab:	6a 01                	push   $0x1
     3ad:	e8 5e 0b 00 00       	call   f10 <printf>
     3b2:	83 c4 10             	add    $0x10,%esp
     3b5:	e9 9e fd ff ff       	jmp    158 <main+0x158>
  wait();
     3ba:	e8 8a 09 00 00       	call   d49 <wait>
  #endif
  #ifdef GETPROCS_TEST
  testgetprocs();  // no need to pass argv[0]
  #endif
  #ifdef TIME_TEST
  testtime();
     3bf:	e8 3c 04 00 00       	call   800 <testtime>
  #endif
  printf(1, "\n** End of Tests **\n");
     3c4:	50                   	push   %eax
     3c5:	50                   	push   %eax
     3c6:	68 b2 18 00 00       	push   $0x18b2
     3cb:	6a 01                	push   $0x1
     3cd:	e8 3e 0b 00 00       	call   f10 <printf>
  exit();
     3d2:	e8 6a 09 00 00       	call   d41 <exit>
  table = malloc(sizeof(struct uproc));
     3d7:	83 ec 0c             	sub    $0xc,%esp
     3da:	6a 60                	push   $0x60
     3dc:	e8 8f 0d 00 00       	call   1170 <malloc>
  if (!table) {
     3e1:	83 c4 10             	add    $0x10,%esp
  table = malloc(sizeof(struct uproc));
     3e4:	89 c3                	mov    %eax,%ebx
  if (!table) {
     3e6:	85 c0                	test   %eax,%eax
     3e8:	0f 84 4a 01 00 00    	je     538 <main+0x538>
  ret = getprocs(1024, table);
     3ee:	56                   	push   %esi
     3ef:	56                   	push   %esi
     3f0:	50                   	push   %eax
     3f1:	68 00 04 00 00       	push   $0x400
     3f6:	e8 1e 0a 00 00       	call   e19 <getprocs>
  free(table);
     3fb:	89 1c 24             	mov    %ebx,(%esp)
  ret = getprocs(1024, table);
     3fe:	89 c6                	mov    %eax,%esi
  free(table);
     400:	e8 db 0c 00 00       	call   10e0 <free>
  if(ret >= 0){
     405:	83 c4 10             	add    $0x10,%esp
     408:	85 f6                	test   %esi,%esi
     40a:	79 60                	jns    46c <main+0x46c>
    success |= testprocarray( 1,  1);
     40c:	ba 01 00 00 00       	mov    $0x1,%edx
     411:	b8 01 00 00 00       	mov    $0x1,%eax
     416:	e8 75 02 00 00       	call   690 <testprocarray>
    success |= testprocarray(16, 16);
     41b:	ba 10 00 00 00       	mov    $0x10,%edx
    success |= testprocarray( 1,  1);
     420:	89 c3                	mov    %eax,%ebx
    success |= testprocarray(16, 16);
     422:	b8 10 00 00 00       	mov    $0x10,%eax
     427:	e8 64 02 00 00       	call   690 <testprocarray>
    success |= testprocarray(64, 64);
     42c:	ba 40 00 00 00       	mov    $0x40,%edx
    success |= testprocarray(16, 16);
     431:	09 c3                	or     %eax,%ebx
    success |= testprocarray(64, 64);
     433:	b8 40 00 00 00       	mov    $0x40,%eax
     438:	e8 53 02 00 00       	call   690 <testprocarray>
    success |= testprocarray(72, 64);
     43d:	ba 40 00 00 00       	mov    $0x40,%edx
    success |= testprocarray(64, 64);
     442:	09 c3                	or     %eax,%ebx
    success |= testprocarray(72, 64);
     444:	b8 48 00 00 00       	mov    $0x48,%eax
     449:	e8 42 02 00 00       	call   690 <testprocarray>
    if (success == 0)
     44e:	09 c3                	or     %eax,%ebx
     450:	0f 85 9e fe ff ff    	jne    2f4 <main+0x2f4>
      printf(1, "** All Tests Passed **\n");
     456:	52                   	push   %edx
     457:	52                   	push   %edx
     458:	68 9a 18 00 00       	push   $0x189a
     45d:	6a 01                	push   $0x1
     45f:	e8 ac 0a 00 00       	call   f10 <printf>
     464:	83 c4 10             	add    $0x10,%esp
     467:	e9 88 fe ff ff       	jmp    2f4 <main+0x2f4>
    printf(2, "FAILED: called getprocs with max way larger than table and returned %d, not error\n", ret);
     46c:	51                   	push   %ecx
     46d:	56                   	push   %esi
     46e:	68 88 17 00 00       	push   $0x1788
     473:	6a 02                	push   $0x2
     475:	e8 96 0a 00 00       	call   f10 <printf>
    success |= testprocarray( 1,  1);
     47a:	ba 01 00 00 00       	mov    $0x1,%edx
     47f:	b8 01 00 00 00       	mov    $0x1,%eax
     484:	e8 07 02 00 00       	call   690 <testprocarray>
    success |= testprocarray(16, 16);
     489:	ba 10 00 00 00       	mov    $0x10,%edx
     48e:	b8 10 00 00 00       	mov    $0x10,%eax
     493:	e8 f8 01 00 00       	call   690 <testprocarray>
    success |= testprocarray(64, 64);
     498:	ba 40 00 00 00       	mov    $0x40,%edx
     49d:	b8 40 00 00 00       	mov    $0x40,%eax
     4a2:	e8 e9 01 00 00       	call   690 <testprocarray>
    success |= testprocarray(72, 64);
     4a7:	ba 40 00 00 00       	mov    $0x40,%edx
     4ac:	b8 48 00 00 00       	mov    $0x48,%eax
     4b1:	e8 da 01 00 00       	call   690 <testprocarray>
     4b6:	83 c4 10             	add    $0x10,%esp
     4b9:	e9 36 fe ff ff       	jmp    2f4 <main+0x2f4>
    ppid = getppid();
     4be:	e8 4e 09 00 00       	call   e11 <getppid>
    if(ppid != pid)
     4c3:	39 c3                	cmp    %eax,%ebx
     4c5:	74 31                	je     4f8 <main+0x4f8>
      printf(2, "FAILED: Parent PID is %d, Child's PPID is %d\n", pid, ppid);
     4c7:	50                   	push   %eax
     4c8:	53                   	push   %ebx
     4c9:	68 f8 16 00 00       	push   $0x16f8
     4ce:	6a 02                	push   $0x2
     4d0:	e8 3b 0a 00 00       	call   f10 <printf>
     4d5:	83 c4 10             	add    $0x10,%esp
     4d8:	e9 17 fe ff ff       	jmp    2f4 <main+0x2f4>
    printf(2, "Error: malloc() call failed. %s at line %d\n", __FUNCTION__, __LINE__);
     4dd:	68 c1 00 00 00       	push   $0xc1
     4e2:	68 ec 18 00 00       	push   $0x18ec
     4e7:	68 70 13 00 00       	push   $0x1370
     4ec:	6a 02                	push   $0x2
     4ee:	e8 1d 0a 00 00       	call   f10 <printf>
    exit();
     4f3:	e8 49 08 00 00       	call   d41 <exit>
      printf(1, "** Test passed! **\n");
     4f8:	50                   	push   %eax
     4f9:	50                   	push   %eax
     4fa:	68 86 18 00 00       	push   $0x1886
     4ff:	6a 01                	push   $0x1
     501:	e8 0a 0a 00 00       	call   f10 <printf>
     506:	83 c4 10             	add    $0x10,%esp
     509:	e9 e6 fd ff ff       	jmp    2f4 <main+0x2f4>
    uid = getuid();
     50e:	e8 ee 08 00 00       	call   e01 <getuid>
     513:	89 c3                	mov    %eax,%ebx
    gid = getgid();
     515:	e8 d7 08 00 00       	call   df1 <getgid>
    if(uid != 12345){
     51a:	81 fb 39 30 00 00    	cmp    $0x3039,%ebx
     520:	74 31                	je     553 <main+0x553>
      printf(2, "FAILED: Parent UID is 12345, child UID is %d\n", uid);
     522:	51                   	push   %ecx
     523:	53                   	push   %ebx
     524:	68 6c 16 00 00       	push   $0x166c
     529:	6a 02                	push   $0x2
     52b:	e8 e0 09 00 00       	call   f10 <printf>
     530:	83 c4 10             	add    $0x10,%esp
     533:	e9 bc fd ff ff       	jmp    2f4 <main+0x2f4>
    printf(2, "Error: malloc() call failed. %s at line %d\n", __FUNCTION__, __LINE__);
     538:	68 06 01 00 00       	push   $0x106
     53d:	68 d8 18 00 00       	push   $0x18d8
     542:	68 70 13 00 00       	push   $0x1370
     547:	6a 02                	push   $0x2
     549:	e8 c2 09 00 00       	call   f10 <printf>
    exit();
     54e:	e8 ee 07 00 00       	call   d41 <exit>
    else if(gid != 12345){
     553:	3d 39 30 00 00       	cmp    $0x3039,%eax
     558:	74 16                	je     570 <main+0x570>
      printf(2, "FAILED: Parent GID is 12345, child GID is %d\n", gid);
     55a:	52                   	push   %edx
     55b:	50                   	push   %eax
     55c:	68 9c 16 00 00       	push   $0x169c
     561:	6a 02                	push   $0x2
     563:	e8 a8 09 00 00       	call   f10 <printf>
     568:	83 c4 10             	add    $0x10,%esp
     56b:	e9 84 fd ff ff       	jmp    2f4 <main+0x2f4>
      printf(1, "** Test Passed! **\n");
     570:	50                   	push   %eax
     571:	50                   	push   %eax
     572:	68 72 18 00 00       	push   $0x1872
     577:	6a 01                	push   $0x1
     579:	e8 92 09 00 00       	call   f10 <printf>
     57e:	83 c4 10             	add    $0x10,%esp
    exit();
     581:	e9 6e fd ff ff       	jmp    2f4 <main+0x2f4>
     586:	66 90                	xchg   %ax,%ax
     588:	66 90                	xchg   %ax,%ax
     58a:	66 90                	xchg   %ax,%ax
     58c:	66 90                	xchg   %ax,%ax
     58e:	66 90                	xchg   %ax,%ax

00000590 <testuid>:
testuid(uint new_val, uint expected_get_val, int expected_set_ret){
     590:	55                   	push   %ebp
     591:	89 e5                	mov    %esp,%ebp
     593:	57                   	push   %edi
     594:	89 d7                	mov    %edx,%edi
     596:	56                   	push   %esi
     597:	89 c6                	mov    %eax,%esi
     599:	53                   	push   %ebx
     59a:	89 cb                	mov    %ecx,%ebx
     59c:	83 ec 1c             	sub    $0x1c,%esp
  pre_uid = getuid();
     59f:	e8 5d 08 00 00       	call   e01 <getuid>
  ret = setuid(new_val);
     5a4:	83 ec 0c             	sub    $0xc,%esp
     5a7:	56                   	push   %esi
  pre_uid = getuid();
     5a8:	89 45 e0             	mov    %eax,-0x20(%ebp)
  ret = setuid(new_val);
     5ab:	e8 59 08 00 00       	call   e09 <setuid>
  if((ret < 0 && expected_set_ret >= 0) || (ret >= 0 && expected_set_ret < 0)){
     5b0:	89 d9                	mov    %ebx,%ecx
     5b2:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
     5b5:	83 c4 10             	add    $0x10,%esp
     5b8:	89 c2                	mov    %eax,%edx
     5ba:	c1 e9 1f             	shr    $0x1f,%ecx
     5bd:	31 db                	xor    %ebx,%ebx
     5bf:	c1 ea 1f             	shr    $0x1f,%edx
     5c2:	38 ca                	cmp    %cl,%dl
     5c4:	74 1a                	je     5e0 <testuid+0x50>
    printf(2, "FAILED: setuid(%d) returned %d, expected %d\n", new_val, ret, expected_set_ret);
     5c6:	83 ec 0c             	sub    $0xc,%esp
     5c9:	ff 75 e4             	pushl  -0x1c(%ebp)
    success = -1;
     5cc:	83 cb ff             	or     $0xffffffff,%ebx
    printf(2, "FAILED: setuid(%d) returned %d, expected %d\n", new_val, ret, expected_set_ret);
     5cf:	50                   	push   %eax
     5d0:	56                   	push   %esi
     5d1:	68 78 12 00 00       	push   $0x1278
     5d6:	6a 02                	push   $0x2
     5d8:	e8 33 09 00 00       	call   f10 <printf>
     5dd:	83 c4 20             	add    $0x20,%esp
  post_uid = getuid();
     5e0:	e8 1c 08 00 00       	call   e01 <getuid>
  if(post_uid != expected_get_val){
     5e5:	39 f8                	cmp    %edi,%eax
     5e7:	75 0a                	jne    5f3 <testuid+0x63>
}
     5e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
     5ec:	89 d8                	mov    %ebx,%eax
     5ee:	5b                   	pop    %ebx
     5ef:	5e                   	pop    %esi
     5f0:	5f                   	pop    %edi
     5f1:	5d                   	pop    %ebp
     5f2:	c3                   	ret    
    printf(2, "FAILED: UID was %d. After setuid(%d), getuid() returned %d, expected %d\n",
     5f3:	52                   	push   %edx
    success = -1;
     5f4:	83 cb ff             	or     $0xffffffff,%ebx
    printf(2, "FAILED: UID was %d. After setuid(%d), getuid() returned %d, expected %d\n",
     5f7:	52                   	push   %edx
     5f8:	57                   	push   %edi
     5f9:	50                   	push   %eax
     5fa:	56                   	push   %esi
     5fb:	ff 75 e0             	pushl  -0x20(%ebp)
     5fe:	68 a8 12 00 00       	push   $0x12a8
     603:	6a 02                	push   $0x2
     605:	e8 06 09 00 00       	call   f10 <printf>
     60a:	83 c4 20             	add    $0x20,%esp
  return success;
     60d:	eb da                	jmp    5e9 <testuid+0x59>
     60f:	90                   	nop

00000610 <testgid>:
testgid(uint new_val, uint expected_get_val, int expected_set_ret){
     610:	55                   	push   %ebp
     611:	89 e5                	mov    %esp,%ebp
     613:	57                   	push   %edi
     614:	89 d7                	mov    %edx,%edi
     616:	56                   	push   %esi
     617:	89 c6                	mov    %eax,%esi
     619:	53                   	push   %ebx
     61a:	89 cb                	mov    %ecx,%ebx
     61c:	83 ec 1c             	sub    $0x1c,%esp
  pre_gid = getgid();
     61f:	e8 cd 07 00 00       	call   df1 <getgid>
  ret = setgid(new_val);
     624:	83 ec 0c             	sub    $0xc,%esp
     627:	56                   	push   %esi
  pre_gid = getgid();
     628:	89 45 e0             	mov    %eax,-0x20(%ebp)
  ret = setgid(new_val);
     62b:	e8 c9 07 00 00       	call   df9 <setgid>
  if((ret < 0 && expected_set_ret >= 0) || (ret >= 0 && expected_set_ret < 0)){
     630:	89 d9                	mov    %ebx,%ecx
     632:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
     635:	83 c4 10             	add    $0x10,%esp
     638:	89 c2                	mov    %eax,%edx
     63a:	c1 e9 1f             	shr    $0x1f,%ecx
     63d:	31 db                	xor    %ebx,%ebx
     63f:	c1 ea 1f             	shr    $0x1f,%edx
     642:	38 ca                	cmp    %cl,%dl
     644:	74 1a                	je     660 <testgid+0x50>
    printf(2, "FAILED: setgid(%d) returned %d, expected %d\n", new_val, ret, expected_set_ret);
     646:	83 ec 0c             	sub    $0xc,%esp
     649:	ff 75 e4             	pushl  -0x1c(%ebp)
    success = -1;
     64c:	83 cb ff             	or     $0xffffffff,%ebx
    printf(2, "FAILED: setgid(%d) returned %d, expected %d\n", new_val, ret, expected_set_ret);
     64f:	50                   	push   %eax
     650:	56                   	push   %esi
     651:	68 f4 12 00 00       	push   $0x12f4
     656:	6a 02                	push   $0x2
     658:	e8 b3 08 00 00       	call   f10 <printf>
     65d:	83 c4 20             	add    $0x20,%esp
  post_gid = getgid();
     660:	e8 8c 07 00 00       	call   df1 <getgid>
  if(post_gid != expected_get_val){
     665:	39 f8                	cmp    %edi,%eax
     667:	75 0a                	jne    673 <testgid+0x63>
}
     669:	8d 65 f4             	lea    -0xc(%ebp),%esp
     66c:	89 d8                	mov    %ebx,%eax
     66e:	5b                   	pop    %ebx
     66f:	5e                   	pop    %esi
     670:	5f                   	pop    %edi
     671:	5d                   	pop    %ebp
     672:	c3                   	ret    
    printf(2, "FAILED: UID was %d. After setgid(%d), getgid() returned %d, expected %d\n",
     673:	52                   	push   %edx
    success = -1;
     674:	83 cb ff             	or     $0xffffffff,%ebx
    printf(2, "FAILED: UID was %d. After setgid(%d), getgid() returned %d, expected %d\n",
     677:	52                   	push   %edx
     678:	57                   	push   %edi
     679:	50                   	push   %eax
     67a:	56                   	push   %esi
     67b:	ff 75 e0             	pushl  -0x20(%ebp)
     67e:	68 24 13 00 00       	push   $0x1324
     683:	6a 02                	push   $0x2
     685:	e8 86 08 00 00       	call   f10 <printf>
     68a:	83 c4 20             	add    $0x20,%esp
  return success;
     68d:	eb da                	jmp    669 <testgid+0x59>
     68f:	90                   	nop

00000690 <testprocarray>:
testprocarray(int max, int expected_ret){
     690:	55                   	push   %ebp
     691:	89 e5                	mov    %esp,%ebp
     693:	57                   	push   %edi
     694:	56                   	push   %esi
     695:	89 d6                	mov    %edx,%esi
     697:	53                   	push   %ebx
     698:	89 c3                	mov    %eax,%ebx
  table = malloc(sizeof(struct uproc) * max);  // bad code, assumes success
     69a:	8d 04 40             	lea    (%eax,%eax,2),%eax
     69d:	c1 e0 05             	shl    $0x5,%eax
testprocarray(int max, int expected_ret){
     6a0:	83 ec 18             	sub    $0x18,%esp
  table = malloc(sizeof(struct uproc) * max);  // bad code, assumes success
     6a3:	50                   	push   %eax
     6a4:	e8 c7 0a 00 00       	call   1170 <malloc>
  if (!table) {
     6a9:	83 c4 10             	add    $0x10,%esp
     6ac:	85 c0                	test   %eax,%eax
     6ae:	74 53                	je     703 <testprocarray+0x73>
  ret = getprocs(max, table);
     6b0:	83 ec 08             	sub    $0x8,%esp
     6b3:	89 c7                	mov    %eax,%edi
     6b5:	50                   	push   %eax
     6b6:	53                   	push   %ebx
     6b7:	e8 5d 07 00 00       	call   e19 <getprocs>
  if (ret != expected_ret){
     6bc:	83 c4 10             	add    $0x10,%esp
     6bf:	39 f0                	cmp    %esi,%eax
     6c1:	75 26                	jne    6e9 <testprocarray+0x59>
    printf(2, "getprocs() was asked for %d processes and returned %d. SUCCESS\n", max, expected_ret);
     6c3:	50                   	push   %eax
     6c4:	53                   	push   %ebx
  int ret, success = 0;
     6c5:	31 db                	xor    %ebx,%ebx
    printf(2, "getprocs() was asked for %d processes and returned %d. SUCCESS\n", max, expected_ret);
     6c7:	68 cc 13 00 00       	push   $0x13cc
     6cc:	6a 02                	push   $0x2
     6ce:	e8 3d 08 00 00       	call   f10 <printf>
     6d3:	83 c4 10             	add    $0x10,%esp
  free(table);
     6d6:	83 ec 0c             	sub    $0xc,%esp
     6d9:	57                   	push   %edi
     6da:	e8 01 0a 00 00       	call   10e0 <free>
}
     6df:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6e2:	89 d8                	mov    %ebx,%eax
     6e4:	5b                   	pop    %ebx
     6e5:	5e                   	pop    %esi
     6e6:	5f                   	pop    %edi
     6e7:	5d                   	pop    %ebp
     6e8:	c3                   	ret    
    printf(2, "FAILED: getprocs(%d) returned %d, expected %d\n", max, ret, expected_ret);
     6e9:	83 ec 0c             	sub    $0xc,%esp
     6ec:	56                   	push   %esi
     6ed:	50                   	push   %eax
     6ee:	53                   	push   %ebx
    success = -1;
     6ef:	83 cb ff             	or     $0xffffffff,%ebx
    printf(2, "FAILED: getprocs(%d) returned %d, expected %d\n", max, ret, expected_ret);
     6f2:	68 9c 13 00 00       	push   $0x139c
     6f7:	6a 02                	push   $0x2
     6f9:	e8 12 08 00 00       	call   f10 <printf>
    success = -1;
     6fe:	83 c4 20             	add    $0x20,%esp
     701:	eb d3                	jmp    6d6 <testprocarray+0x46>
    printf(2, "Error: malloc() call failed. %s at line %d\n", __FUNCTION__, __LINE__);
     703:	68 f0 00 00 00       	push   $0xf0
     708:	68 c8 18 00 00       	push   $0x18c8
     70d:	68 70 13 00 00       	push   $0x1370
     712:	6a 02                	push   $0x2
     714:	e8 f7 07 00 00       	call   f10 <printf>
    exit();
     719:	e8 23 06 00 00       	call   d41 <exit>
     71e:	66 90                	xchg   %ax,%ax

00000720 <getcputime>:
getcputime(char * name, struct uproc * table){
     720:	55                   	push   %ebp
     721:	89 e5                	mov    %esp,%ebp
     723:	57                   	push   %edi
     724:	31 ff                	xor    %edi,%edi
     726:	56                   	push   %esi
     727:	89 c6                	mov    %eax,%esi
     729:	53                   	push   %ebx
     72a:	89 d3                	mov    %edx,%ebx
     72c:	83 ec 24             	sub    $0x24,%esp
  size = getprocs(64, table);
     72f:	52                   	push   %edx
     730:	6a 40                	push   $0x40
     732:	e8 e2 06 00 00       	call   e19 <getprocs>
  for(int i = 0; i < size; ++i){
     737:	83 c4 10             	add    $0x10,%esp
  size = getprocs(64, table);
     73a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(int i = 0; i < size; ++i){
     73d:	85 c0                	test   %eax,%eax
     73f:	7f 12                	jg     753 <getcputime+0x33>
     741:	eb 3d                	jmp    780 <getcputime+0x60>
     743:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     747:	90                   	nop
     748:	83 c7 01             	add    $0x1,%edi
     74b:	83 c3 60             	add    $0x60,%ebx
     74e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
     751:	74 2d                	je     780 <getcputime+0x60>
    if(strcmp(table[i].name, name) == 0){
     753:	83 ec 08             	sub    $0x8,%esp
     756:	8d 43 40             	lea    0x40(%ebx),%eax
     759:	56                   	push   %esi
     75a:	50                   	push   %eax
     75b:	e8 20 03 00 00       	call   a80 <strcmp>
     760:	83 c4 10             	add    $0x10,%esp
     763:	85 c0                	test   %eax,%eax
     765:	75 e1                	jne    748 <getcputime+0x28>
  if(p == 0){
     767:	85 db                	test   %ebx,%ebx
     769:	74 15                	je     780 <getcputime+0x60>
    return p->CPU_total_ticks;
     76b:	8b 43 18             	mov    0x18(%ebx),%eax
}
     76e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     771:	5b                   	pop    %ebx
     772:	5e                   	pop    %esi
     773:	5f                   	pop    %edi
     774:	5d                   	pop    %ebp
     775:	c3                   	ret    
     776:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     77d:	8d 76 00             	lea    0x0(%esi),%esi
    printf(2, "FAILED: Test program \"%s\" not found in table returned by getprocs\n", name);
     780:	83 ec 04             	sub    $0x4,%esp
     783:	56                   	push   %esi
     784:	68 0c 14 00 00       	push   $0x140c
     789:	6a 02                	push   $0x2
     78b:	e8 80 07 00 00       	call   f10 <printf>
     790:	83 c4 10             	add    $0x10,%esp
}
     793:	8d 65 f4             	lea    -0xc(%ebp),%esp
    printf(2, "FAILED: Test program \"%s\" not found in table returned by getprocs\n", name);
     796:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     79b:	5b                   	pop    %ebx
     79c:	5e                   	pop    %esi
     79d:	5f                   	pop    %edi
     79e:	5d                   	pop    %ebp
     79f:	c3                   	ret    

000007a0 <testtimewitharg>:
testtimewitharg(char **arg){
     7a0:	55                   	push   %ebp
     7a1:	89 e5                	mov    %esp,%ebp
     7a3:	53                   	push   %ebx
     7a4:	83 ec 04             	sub    $0x4,%esp
     7a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  ret = fork();
     7aa:	e8 8a 05 00 00       	call   d39 <fork>
  if (ret == 0){
     7af:	85 c0                	test   %eax,%eax
     7b1:	74 2c                	je     7df <testtimewitharg+0x3f>
  else if(ret == -1){
     7b3:	83 f8 ff             	cmp    $0xffffffff,%eax
     7b6:	74 10                	je     7c8 <testtimewitharg+0x28>
}
     7b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7bb:	c9                   	leave  
    wait();
     7bc:	e9 88 05 00 00       	jmp    d49 <wait>
     7c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "FAILED: fork failed\n");
     7c8:	83 ec 08             	sub    $0x8,%esp
     7cb:	68 dc 17 00 00       	push   $0x17dc
     7d0:	6a 02                	push   $0x2
     7d2:	e8 39 07 00 00       	call   f10 <printf>
     7d7:	83 c4 10             	add    $0x10,%esp
}
     7da:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7dd:	c9                   	leave  
     7de:	c3                   	ret    
    exec(arg[0], arg);
     7df:	50                   	push   %eax
     7e0:	50                   	push   %eax
     7e1:	53                   	push   %ebx
     7e2:	ff 33                	pushl  (%ebx)
     7e4:	e8 90 05 00 00       	call   d79 <exec>
    printf(2, "FAILED: exec failed to execute %s\n", arg[0]);
     7e9:	83 c4 0c             	add    $0xc,%esp
     7ec:	ff 33                	pushl  (%ebx)
     7ee:	68 50 14 00 00       	push   $0x1450
     7f3:	6a 02                	push   $0x2
     7f5:	e8 16 07 00 00       	call   f10 <printf>
    exit();
     7fa:	e8 42 05 00 00       	call   d41 <exit>
     7ff:	90                   	nop

00000800 <testtime>:
testtime(void){
     800:	55                   	push   %ebp
     801:	89 e5                	mov    %esp,%ebp
     803:	57                   	push   %edi
     804:	56                   	push   %esi
     805:	53                   	push   %ebx
     806:	83 ec 28             	sub    $0x28,%esp
  char **arg1 = malloc(sizeof(char *));
     809:	6a 04                	push   $0x4
     80b:	e8 60 09 00 00       	call   1170 <malloc>
  char **arg2 = malloc(sizeof(char *)*2);
     810:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  char **arg1 = malloc(sizeof(char *));
     817:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char **arg2 = malloc(sizeof(char *)*2);
     81a:	e8 51 09 00 00       	call   1170 <malloc>
  char **arg3 = malloc(sizeof(char *)*2);
     81f:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  char **arg2 = malloc(sizeof(char *)*2);
     826:	89 c7                	mov    %eax,%edi
  char **arg3 = malloc(sizeof(char *)*2);
     828:	e8 43 09 00 00       	call   1170 <malloc>
  char **arg4 = malloc(sizeof(char *)*4);
     82d:	c7 04 24 10 00 00 00 	movl   $0x10,(%esp)
  char **arg3 = malloc(sizeof(char *)*2);
     834:	89 c6                	mov    %eax,%esi
  char **arg4 = malloc(sizeof(char *)*4);
     836:	e8 35 09 00 00       	call   1170 <malloc>
  arg1[0] = malloc(sizeof(char) * 5);
     83b:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  char **arg4 = malloc(sizeof(char *)*4);
     842:	89 c3                	mov    %eax,%ebx
  arg1[0] = malloc(sizeof(char) * 5);
     844:	e8 27 09 00 00       	call   1170 <malloc>
     849:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     84c:	89 02                	mov    %eax,(%edx)
  strcpy(arg1[0], "time");
     84e:	5a                   	pop    %edx
     84f:	59                   	pop    %ecx
     850:	68 f1 17 00 00       	push   $0x17f1
     855:	50                   	push   %eax
     856:	e8 f5 01 00 00       	call   a50 <strcpy>
  arg2[0] = malloc(sizeof(char) * 5);
     85b:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     862:	e8 09 09 00 00       	call   1170 <malloc>
     867:	89 07                	mov    %eax,(%edi)
  strcpy(arg2[0], "time");
     869:	5a                   	pop    %edx
     86a:	59                   	pop    %ecx
     86b:	68 f1 17 00 00       	push   $0x17f1
     870:	50                   	push   %eax
     871:	e8 da 01 00 00       	call   a50 <strcpy>
  arg2[1] = malloc(sizeof(char) * 4);
     876:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
     87d:	e8 ee 08 00 00       	call   1170 <malloc>
     882:	89 47 04             	mov    %eax,0x4(%edi)
  strcpy(arg2[1], "abc");
     885:	5a                   	pop    %edx
     886:	59                   	pop    %ecx
     887:	68 f6 17 00 00       	push   $0x17f6
     88c:	50                   	push   %eax
     88d:	e8 be 01 00 00       	call   a50 <strcpy>
  arg3[0] = malloc(sizeof(char) * 5);
     892:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     899:	e8 d2 08 00 00       	call   1170 <malloc>
     89e:	89 06                	mov    %eax,(%esi)
  strcpy(arg3[0], "time");
     8a0:	5a                   	pop    %edx
     8a1:	59                   	pop    %ecx
     8a2:	68 f1 17 00 00       	push   $0x17f1
     8a7:	50                   	push   %eax
     8a8:	e8 a3 01 00 00       	call   a50 <strcpy>
  arg3[1] = malloc(sizeof(char) * 5);
     8ad:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     8b4:	e8 b7 08 00 00       	call   1170 <malloc>
     8b9:	89 46 04             	mov    %eax,0x4(%esi)
  strcpy(arg3[1], "date");
     8bc:	5a                   	pop    %edx
     8bd:	59                   	pop    %ecx
     8be:	68 fa 17 00 00       	push   $0x17fa
     8c3:	50                   	push   %eax
     8c4:	e8 87 01 00 00       	call   a50 <strcpy>
  arg4[0] = malloc(sizeof(char) * 5);
     8c9:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     8d0:	e8 9b 08 00 00       	call   1170 <malloc>
     8d5:	89 03                	mov    %eax,(%ebx)
  strcpy(arg4[0], "time");
     8d7:	5a                   	pop    %edx
     8d8:	59                   	pop    %ecx
     8d9:	68 f1 17 00 00       	push   $0x17f1
     8de:	50                   	push   %eax
     8df:	e8 6c 01 00 00       	call   a50 <strcpy>
  arg4[1] = malloc(sizeof(char) * 5);
     8e4:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     8eb:	e8 80 08 00 00       	call   1170 <malloc>
     8f0:	89 43 04             	mov    %eax,0x4(%ebx)
  strcpy(arg4[1], "time");
     8f3:	5a                   	pop    %edx
     8f4:	59                   	pop    %ecx
     8f5:	68 f1 17 00 00       	push   $0x17f1
     8fa:	50                   	push   %eax
     8fb:	e8 50 01 00 00       	call   a50 <strcpy>
  arg4[2] = malloc(sizeof(char) * 5);
     900:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     907:	e8 64 08 00 00       	call   1170 <malloc>
     90c:	89 43 08             	mov    %eax,0x8(%ebx)
  strcpy(arg4[2], "echo");
     90f:	5a                   	pop    %edx
     910:	59                   	pop    %ecx
     911:	68 ff 17 00 00       	push   $0x17ff
     916:	50                   	push   %eax
     917:	e8 34 01 00 00       	call   a50 <strcpy>
  arg4[3] = malloc(sizeof(char) * 6);
     91c:	c7 04 24 06 00 00 00 	movl   $0x6,(%esp)
     923:	e8 48 08 00 00       	call   1170 <malloc>
     928:	89 43 0c             	mov    %eax,0xc(%ebx)
  strcpy(arg4[3], "\"abc\"");
     92b:	5a                   	pop    %edx
     92c:	59                   	pop    %ecx
     92d:	68 04 18 00 00       	push   $0x1804
     932:	50                   	push   %eax
     933:	e8 18 01 00 00       	call   a50 <strcpy>
  printf(1, "\n----------\nRunning Time Test\n----------\n");
     938:	58                   	pop    %eax
     939:	5a                   	pop    %edx
     93a:	68 74 14 00 00       	push   $0x1474
     93f:	6a 01                	push   $0x1
     941:	e8 ca 05 00 00       	call   f10 <printf>
  printf(1, "You will need to verify these tests passed\n");
     946:	59                   	pop    %ecx
     947:	58                   	pop    %eax
     948:	68 a0 14 00 00       	push   $0x14a0
     94d:	6a 01                	push   $0x1
     94f:	e8 bc 05 00 00       	call   f10 <printf>
  printf(1,"\n%s\n", arg1[0]);
     954:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     957:	83 c4 0c             	add    $0xc,%esp
     95a:	ff 32                	pushl  (%edx)
     95c:	68 0a 18 00 00       	push   $0x180a
     961:	6a 01                	push   $0x1
     963:	e8 a8 05 00 00       	call   f10 <printf>
  testtimewitharg(arg1);
     968:	58                   	pop    %eax
     969:	ff 75 e4             	pushl  -0x1c(%ebp)
     96c:	e8 2f fe ff ff       	call   7a0 <testtimewitharg>
  printf(1,"\n%s %s\n", arg2[0], arg2[1]);
     971:	ff 77 04             	pushl  0x4(%edi)
     974:	ff 37                	pushl  (%edi)
     976:	68 0f 18 00 00       	push   $0x180f
     97b:	6a 01                	push   $0x1
     97d:	e8 8e 05 00 00       	call   f10 <printf>
  testtimewitharg(arg2);
     982:	83 c4 14             	add    $0x14,%esp
     985:	57                   	push   %edi
     986:	e8 15 fe ff ff       	call   7a0 <testtimewitharg>
  printf(1,"\n%s %s\n", arg3[0], arg3[1]);
     98b:	ff 76 04             	pushl  0x4(%esi)
     98e:	ff 36                	pushl  (%esi)
     990:	68 0f 18 00 00       	push   $0x180f
     995:	6a 01                	push   $0x1
     997:	e8 74 05 00 00       	call   f10 <printf>
  testtimewitharg(arg3);
     99c:	83 c4 14             	add    $0x14,%esp
     99f:	56                   	push   %esi
     9a0:	e8 fb fd ff ff       	call   7a0 <testtimewitharg>
  printf(1,"\n%s %s %s %s\n", arg4[0], arg4[1], arg4[2], arg4[3]);
     9a5:	58                   	pop    %eax
     9a6:	5a                   	pop    %edx
     9a7:	ff 73 0c             	pushl  0xc(%ebx)
     9aa:	ff 73 08             	pushl  0x8(%ebx)
     9ad:	ff 73 04             	pushl  0x4(%ebx)
     9b0:	ff 33                	pushl  (%ebx)
     9b2:	68 17 18 00 00       	push   $0x1817
     9b7:	6a 01                	push   $0x1
     9b9:	e8 52 05 00 00       	call   f10 <printf>
  testtimewitharg(arg4);
     9be:	83 c4 14             	add    $0x14,%esp
     9c1:	53                   	push   %ebx
     9c2:	e8 d9 fd ff ff       	call   7a0 <testtimewitharg>
  free(arg1[0]);
     9c7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     9ca:	59                   	pop    %ecx
     9cb:	ff 32                	pushl  (%edx)
     9cd:	e8 0e 07 00 00       	call   10e0 <free>
  free(arg1);
     9d2:	58                   	pop    %eax
     9d3:	ff 75 e4             	pushl  -0x1c(%ebp)
     9d6:	e8 05 07 00 00       	call   10e0 <free>
  free(arg2[0]); free(arg2[1]);
     9db:	58                   	pop    %eax
     9dc:	ff 37                	pushl  (%edi)
     9de:	e8 fd 06 00 00       	call   10e0 <free>
     9e3:	58                   	pop    %eax
     9e4:	ff 77 04             	pushl  0x4(%edi)
     9e7:	e8 f4 06 00 00       	call   10e0 <free>
  free(arg2);
     9ec:	89 3c 24             	mov    %edi,(%esp)
     9ef:	e8 ec 06 00 00       	call   10e0 <free>
  free(arg3[0]); free(arg3[1]);
     9f4:	58                   	pop    %eax
     9f5:	ff 36                	pushl  (%esi)
     9f7:	e8 e4 06 00 00       	call   10e0 <free>
     9fc:	58                   	pop    %eax
     9fd:	ff 76 04             	pushl  0x4(%esi)
     a00:	e8 db 06 00 00       	call   10e0 <free>
  free(arg3);
     a05:	89 34 24             	mov    %esi,(%esp)
     a08:	e8 d3 06 00 00       	call   10e0 <free>
  free(arg4[0]); free(arg4[1]); free(arg4[2]); free(arg4[3]);
     a0d:	58                   	pop    %eax
     a0e:	ff 33                	pushl  (%ebx)
     a10:	e8 cb 06 00 00       	call   10e0 <free>
     a15:	5a                   	pop    %edx
     a16:	ff 73 04             	pushl  0x4(%ebx)
     a19:	e8 c2 06 00 00       	call   10e0 <free>
     a1e:	59                   	pop    %ecx
     a1f:	ff 73 08             	pushl  0x8(%ebx)
     a22:	e8 b9 06 00 00       	call   10e0 <free>
     a27:	5e                   	pop    %esi
     a28:	ff 73 0c             	pushl  0xc(%ebx)
     a2b:	e8 b0 06 00 00       	call   10e0 <free>
  free(arg4);
     a30:	89 1c 24             	mov    %ebx,(%esp)
     a33:	e8 a8 06 00 00       	call   10e0 <free>
}
     a38:	83 c4 10             	add    $0x10,%esp
     a3b:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a3e:	5b                   	pop    %ebx
     a3f:	5e                   	pop    %esi
     a40:	5f                   	pop    %edi
     a41:	5d                   	pop    %ebp
     a42:	c3                   	ret    
     a43:	66 90                	xchg   %ax,%ax
     a45:	66 90                	xchg   %ax,%ax
     a47:	66 90                	xchg   %ax,%ax
     a49:	66 90                	xchg   %ax,%ax
     a4b:	66 90                	xchg   %ax,%ax
     a4d:	66 90                	xchg   %ax,%ax
     a4f:	90                   	nop

00000a50 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     a50:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     a51:	31 d2                	xor    %edx,%edx
{
     a53:	89 e5                	mov    %esp,%ebp
     a55:	53                   	push   %ebx
     a56:	8b 45 08             	mov    0x8(%ebp),%eax
     a59:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
     a60:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
     a64:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     a67:	83 c2 01             	add    $0x1,%edx
     a6a:	84 c9                	test   %cl,%cl
     a6c:	75 f2                	jne    a60 <strcpy+0x10>
    ;
  return os;
}
     a6e:	5b                   	pop    %ebx
     a6f:	5d                   	pop    %ebp
     a70:	c3                   	ret    
     a71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a7f:	90                   	nop

00000a80 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     a80:	55                   	push   %ebp
     a81:	89 e5                	mov    %esp,%ebp
     a83:	56                   	push   %esi
     a84:	53                   	push   %ebx
     a85:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a88:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(*p && *p == *q)
     a8b:	0f b6 13             	movzbl (%ebx),%edx
     a8e:	0f b6 0e             	movzbl (%esi),%ecx
     a91:	84 d2                	test   %dl,%dl
     a93:	74 1e                	je     ab3 <strcmp+0x33>
     a95:	b8 01 00 00 00       	mov    $0x1,%eax
     a9a:	38 ca                	cmp    %cl,%dl
     a9c:	74 09                	je     aa7 <strcmp+0x27>
     a9e:	eb 20                	jmp    ac0 <strcmp+0x40>
     aa0:	83 c0 01             	add    $0x1,%eax
     aa3:	38 ca                	cmp    %cl,%dl
     aa5:	75 19                	jne    ac0 <strcmp+0x40>
     aa7:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     aab:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
     aaf:	84 d2                	test   %dl,%dl
     ab1:	75 ed                	jne    aa0 <strcmp+0x20>
     ab3:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
     ab5:	5b                   	pop    %ebx
     ab6:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
     ab7:	29 c8                	sub    %ecx,%eax
}
     ab9:	5d                   	pop    %ebp
     aba:	c3                   	ret    
     abb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     abf:	90                   	nop
     ac0:	0f b6 c2             	movzbl %dl,%eax
     ac3:	5b                   	pop    %ebx
     ac4:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
     ac5:	29 c8                	sub    %ecx,%eax
}
     ac7:	5d                   	pop    %ebp
     ac8:	c3                   	ret    
     ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000ad0 <strlen>:

uint
strlen(char *s)
{
     ad0:	55                   	push   %ebp
     ad1:	89 e5                	mov    %esp,%ebp
     ad3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     ad6:	80 39 00             	cmpb   $0x0,(%ecx)
     ad9:	74 15                	je     af0 <strlen+0x20>
     adb:	31 d2                	xor    %edx,%edx
     add:	8d 76 00             	lea    0x0(%esi),%esi
     ae0:	83 c2 01             	add    $0x1,%edx
     ae3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     ae7:	89 d0                	mov    %edx,%eax
     ae9:	75 f5                	jne    ae0 <strlen+0x10>
    ;
  return n;
}
     aeb:	5d                   	pop    %ebp
     aec:	c3                   	ret    
     aed:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
     af0:	31 c0                	xor    %eax,%eax
}
     af2:	5d                   	pop    %ebp
     af3:	c3                   	ret    
     af4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     afb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     aff:	90                   	nop

00000b00 <memset>:

void*
memset(void *dst, int c, uint n)
{
     b00:	55                   	push   %ebp
     b01:	89 e5                	mov    %esp,%ebp
     b03:	57                   	push   %edi
     b04:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     b07:	8b 4d 10             	mov    0x10(%ebp),%ecx
     b0a:	8b 45 0c             	mov    0xc(%ebp),%eax
     b0d:	89 d7                	mov    %edx,%edi
     b0f:	fc                   	cld    
     b10:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     b12:	89 d0                	mov    %edx,%eax
     b14:	5f                   	pop    %edi
     b15:	5d                   	pop    %ebp
     b16:	c3                   	ret    
     b17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b1e:	66 90                	xchg   %ax,%ax

00000b20 <strchr>:

char*
strchr(const char *s, char c)
{
     b20:	55                   	push   %ebp
     b21:	89 e5                	mov    %esp,%ebp
     b23:	53                   	push   %ebx
     b24:	8b 45 08             	mov    0x8(%ebp),%eax
     b27:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
     b2a:	0f b6 18             	movzbl (%eax),%ebx
     b2d:	84 db                	test   %bl,%bl
     b2f:	74 1d                	je     b4e <strchr+0x2e>
     b31:	89 d1                	mov    %edx,%ecx
    if(*s == c)
     b33:	38 d3                	cmp    %dl,%bl
     b35:	75 0d                	jne    b44 <strchr+0x24>
     b37:	eb 17                	jmp    b50 <strchr+0x30>
     b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b40:	38 ca                	cmp    %cl,%dl
     b42:	74 0c                	je     b50 <strchr+0x30>
  for(; *s; s++)
     b44:	83 c0 01             	add    $0x1,%eax
     b47:	0f b6 10             	movzbl (%eax),%edx
     b4a:	84 d2                	test   %dl,%dl
     b4c:	75 f2                	jne    b40 <strchr+0x20>
      return (char*)s;
  return 0;
     b4e:	31 c0                	xor    %eax,%eax
}
     b50:	5b                   	pop    %ebx
     b51:	5d                   	pop    %ebp
     b52:	c3                   	ret    
     b53:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000b60 <gets>:

char*
gets(char *buf, int max)
{
     b60:	55                   	push   %ebp
     b61:	89 e5                	mov    %esp,%ebp
     b63:	57                   	push   %edi
     b64:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     b65:	31 f6                	xor    %esi,%esi
{
     b67:	53                   	push   %ebx
     b68:	89 f3                	mov    %esi,%ebx
     b6a:	83 ec 1c             	sub    $0x1c,%esp
     b6d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
     b70:	eb 2f                	jmp    ba1 <gets+0x41>
     b72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
     b78:	83 ec 04             	sub    $0x4,%esp
     b7b:	8d 45 e7             	lea    -0x19(%ebp),%eax
     b7e:	6a 01                	push   $0x1
     b80:	50                   	push   %eax
     b81:	6a 00                	push   $0x0
     b83:	e8 d1 01 00 00       	call   d59 <read>
    if(cc < 1)
     b88:	83 c4 10             	add    $0x10,%esp
     b8b:	85 c0                	test   %eax,%eax
     b8d:	7e 1c                	jle    bab <gets+0x4b>
      break;
    buf[i++] = c;
     b8f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     b93:	83 c7 01             	add    $0x1,%edi
     b96:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
     b99:	3c 0a                	cmp    $0xa,%al
     b9b:	74 23                	je     bc0 <gets+0x60>
     b9d:	3c 0d                	cmp    $0xd,%al
     b9f:	74 1f                	je     bc0 <gets+0x60>
  for(i=0; i+1 < max; ){
     ba1:	83 c3 01             	add    $0x1,%ebx
     ba4:	89 fe                	mov    %edi,%esi
     ba6:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     ba9:	7c cd                	jl     b78 <gets+0x18>
     bab:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
     bad:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
     bb0:	c6 03 00             	movb   $0x0,(%ebx)
}
     bb3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     bb6:	5b                   	pop    %ebx
     bb7:	5e                   	pop    %esi
     bb8:	5f                   	pop    %edi
     bb9:	5d                   	pop    %ebp
     bba:	c3                   	ret    
     bbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     bbf:	90                   	nop
     bc0:	8b 75 08             	mov    0x8(%ebp),%esi
     bc3:	8b 45 08             	mov    0x8(%ebp),%eax
     bc6:	01 de                	add    %ebx,%esi
     bc8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
     bca:	c6 03 00             	movb   $0x0,(%ebx)
}
     bcd:	8d 65 f4             	lea    -0xc(%ebp),%esp
     bd0:	5b                   	pop    %ebx
     bd1:	5e                   	pop    %esi
     bd2:	5f                   	pop    %edi
     bd3:	5d                   	pop    %ebp
     bd4:	c3                   	ret    
     bd5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000be0 <stat>:

int
stat(char *n, struct stat *st)
{
     be0:	55                   	push   %ebp
     be1:	89 e5                	mov    %esp,%ebp
     be3:	56                   	push   %esi
     be4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     be5:	83 ec 08             	sub    $0x8,%esp
     be8:	6a 00                	push   $0x0
     bea:	ff 75 08             	pushl  0x8(%ebp)
     bed:	e8 8f 01 00 00       	call   d81 <open>
  if(fd < 0)
     bf2:	83 c4 10             	add    $0x10,%esp
     bf5:	85 c0                	test   %eax,%eax
     bf7:	78 27                	js     c20 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     bf9:	83 ec 08             	sub    $0x8,%esp
     bfc:	ff 75 0c             	pushl  0xc(%ebp)
     bff:	89 c3                	mov    %eax,%ebx
     c01:	50                   	push   %eax
     c02:	e8 92 01 00 00       	call   d99 <fstat>
  close(fd);
     c07:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     c0a:	89 c6                	mov    %eax,%esi
  close(fd);
     c0c:	e8 58 01 00 00       	call   d69 <close>
  return r;
     c11:	83 c4 10             	add    $0x10,%esp
}
     c14:	8d 65 f8             	lea    -0x8(%ebp),%esp
     c17:	89 f0                	mov    %esi,%eax
     c19:	5b                   	pop    %ebx
     c1a:	5e                   	pop    %esi
     c1b:	5d                   	pop    %ebp
     c1c:	c3                   	ret    
     c1d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     c20:	be ff ff ff ff       	mov    $0xffffffff,%esi
     c25:	eb ed                	jmp    c14 <stat+0x34>
     c27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c2e:	66 90                	xchg   %ax,%ax

00000c30 <atoi>:

#ifdef PDX_XV6
int
atoi(const char *s)
{
     c30:	55                   	push   %ebp
     c31:	89 e5                	mov    %esp,%ebp
     c33:	56                   	push   %esi
     c34:	8b 55 08             	mov    0x8(%ebp),%edx
     c37:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
     c38:	0f b6 0a             	movzbl (%edx),%ecx
     c3b:	80 f9 20             	cmp    $0x20,%cl
     c3e:	75 0b                	jne    c4b <atoi+0x1b>
     c40:	83 c2 01             	add    $0x1,%edx
     c43:	0f b6 0a             	movzbl (%edx),%ecx
     c46:	80 f9 20             	cmp    $0x20,%cl
     c49:	74 f5                	je     c40 <atoi+0x10>
  sign = (*s == '-') ? -1 : 1;
     c4b:	80 f9 2d             	cmp    $0x2d,%cl
     c4e:	74 40                	je     c90 <atoi+0x60>
     c50:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
     c55:	80 f9 2b             	cmp    $0x2b,%cl
     c58:	74 3b                	je     c95 <atoi+0x65>
    s++;
  while('0' <= *s && *s <= '9')
     c5a:	0f be 0a             	movsbl (%edx),%ecx
     c5d:	8d 41 d0             	lea    -0x30(%ecx),%eax
     c60:	3c 09                	cmp    $0x9,%al
     c62:	b8 00 00 00 00       	mov    $0x0,%eax
     c67:	77 1f                	ja     c88 <atoi+0x58>
     c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
     c70:	83 c2 01             	add    $0x1,%edx
     c73:	8d 04 80             	lea    (%eax,%eax,4),%eax
     c76:	8d 44 41 d0          	lea    -0x30(%ecx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     c7a:	0f be 0a             	movsbl (%edx),%ecx
     c7d:	8d 59 d0             	lea    -0x30(%ecx),%ebx
     c80:	80 fb 09             	cmp    $0x9,%bl
     c83:	76 eb                	jbe    c70 <atoi+0x40>
     c85:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
     c88:	5b                   	pop    %ebx
     c89:	5e                   	pop    %esi
     c8a:	5d                   	pop    %ebp
     c8b:	c3                   	ret    
     c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
     c90:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
     c95:	83 c2 01             	add    $0x1,%edx
     c98:	eb c0                	jmp    c5a <atoi+0x2a>
     c9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000ca0 <atoo>:

int
atoo(const char *s)
{
     ca0:	55                   	push   %ebp
     ca1:	89 e5                	mov    %esp,%ebp
     ca3:	56                   	push   %esi
     ca4:	8b 55 08             	mov    0x8(%ebp),%edx
     ca7:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
     ca8:	0f b6 0a             	movzbl (%edx),%ecx
     cab:	80 f9 20             	cmp    $0x20,%cl
     cae:	75 0b                	jne    cbb <atoo+0x1b>
     cb0:	83 c2 01             	add    $0x1,%edx
     cb3:	0f b6 0a             	movzbl (%edx),%ecx
     cb6:	80 f9 20             	cmp    $0x20,%cl
     cb9:	74 f5                	je     cb0 <atoo+0x10>
  sign = (*s == '-') ? -1 : 1;
     cbb:	80 f9 2d             	cmp    $0x2d,%cl
     cbe:	74 40                	je     d00 <atoo+0x60>
     cc0:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
     cc5:	80 f9 2b             	cmp    $0x2b,%cl
     cc8:	74 3b                	je     d05 <atoo+0x65>
    s++;
  while('0' <= *s && *s <= '7')
     cca:	0f be 0a             	movsbl (%edx),%ecx
     ccd:	8d 41 d0             	lea    -0x30(%ecx),%eax
     cd0:	3c 07                	cmp    $0x7,%al
     cd2:	b8 00 00 00 00       	mov    $0x0,%eax
     cd7:	77 1c                	ja     cf5 <atoo+0x55>
     cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*8 + *s++ - '0';
     ce0:	83 c2 01             	add    $0x1,%edx
     ce3:	8d 44 c1 d0          	lea    -0x30(%ecx,%eax,8),%eax
  while('0' <= *s && *s <= '7')
     ce7:	0f be 0a             	movsbl (%edx),%ecx
     cea:	8d 59 d0             	lea    -0x30(%ecx),%ebx
     ced:	80 fb 07             	cmp    $0x7,%bl
     cf0:	76 ee                	jbe    ce0 <atoo+0x40>
     cf2:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
     cf5:	5b                   	pop    %ebx
     cf6:	5e                   	pop    %esi
     cf7:	5d                   	pop    %ebp
     cf8:	c3                   	ret    
     cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
     d00:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
     d05:	83 c2 01             	add    $0x1,%edx
     d08:	eb c0                	jmp    cca <atoo+0x2a>
     d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000d10 <memmove>:
}
#endif // PDX_XV6

void*
memmove(void *vdst, void *vsrc, int n)
{
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	57                   	push   %edi
     d14:	8b 55 10             	mov    0x10(%ebp),%edx
     d17:	8b 45 08             	mov    0x8(%ebp),%eax
     d1a:	56                   	push   %esi
     d1b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     d1e:	85 d2                	test   %edx,%edx
     d20:	7e 13                	jle    d35 <memmove+0x25>
     d22:	01 c2                	add    %eax,%edx
  dst = vdst;
     d24:	89 c7                	mov    %eax,%edi
     d26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d2d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
     d30:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
     d31:	39 fa                	cmp    %edi,%edx
     d33:	75 fb                	jne    d30 <memmove+0x20>
  return vdst;
}
     d35:	5e                   	pop    %esi
     d36:	5f                   	pop    %edi
     d37:	5d                   	pop    %ebp
     d38:	c3                   	ret    

00000d39 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     d39:	b8 01 00 00 00       	mov    $0x1,%eax
     d3e:	cd 40                	int    $0x40
     d40:	c3                   	ret    

00000d41 <exit>:
SYSCALL(exit)
     d41:	b8 02 00 00 00       	mov    $0x2,%eax
     d46:	cd 40                	int    $0x40
     d48:	c3                   	ret    

00000d49 <wait>:
SYSCALL(wait)
     d49:	b8 03 00 00 00       	mov    $0x3,%eax
     d4e:	cd 40                	int    $0x40
     d50:	c3                   	ret    

00000d51 <pipe>:
SYSCALL(pipe)
     d51:	b8 04 00 00 00       	mov    $0x4,%eax
     d56:	cd 40                	int    $0x40
     d58:	c3                   	ret    

00000d59 <read>:
SYSCALL(read)
     d59:	b8 05 00 00 00       	mov    $0x5,%eax
     d5e:	cd 40                	int    $0x40
     d60:	c3                   	ret    

00000d61 <write>:
SYSCALL(write)
     d61:	b8 10 00 00 00       	mov    $0x10,%eax
     d66:	cd 40                	int    $0x40
     d68:	c3                   	ret    

00000d69 <close>:
SYSCALL(close)
     d69:	b8 15 00 00 00       	mov    $0x15,%eax
     d6e:	cd 40                	int    $0x40
     d70:	c3                   	ret    

00000d71 <kill>:
SYSCALL(kill)
     d71:	b8 06 00 00 00       	mov    $0x6,%eax
     d76:	cd 40                	int    $0x40
     d78:	c3                   	ret    

00000d79 <exec>:
SYSCALL(exec)
     d79:	b8 07 00 00 00       	mov    $0x7,%eax
     d7e:	cd 40                	int    $0x40
     d80:	c3                   	ret    

00000d81 <open>:
SYSCALL(open)
     d81:	b8 0f 00 00 00       	mov    $0xf,%eax
     d86:	cd 40                	int    $0x40
     d88:	c3                   	ret    

00000d89 <mknod>:
SYSCALL(mknod)
     d89:	b8 11 00 00 00       	mov    $0x11,%eax
     d8e:	cd 40                	int    $0x40
     d90:	c3                   	ret    

00000d91 <unlink>:
SYSCALL(unlink)
     d91:	b8 12 00 00 00       	mov    $0x12,%eax
     d96:	cd 40                	int    $0x40
     d98:	c3                   	ret    

00000d99 <fstat>:
SYSCALL(fstat)
     d99:	b8 08 00 00 00       	mov    $0x8,%eax
     d9e:	cd 40                	int    $0x40
     da0:	c3                   	ret    

00000da1 <link>:
SYSCALL(link)
     da1:	b8 13 00 00 00       	mov    $0x13,%eax
     da6:	cd 40                	int    $0x40
     da8:	c3                   	ret    

00000da9 <mkdir>:
SYSCALL(mkdir)
     da9:	b8 14 00 00 00       	mov    $0x14,%eax
     dae:	cd 40                	int    $0x40
     db0:	c3                   	ret    

00000db1 <chdir>:
SYSCALL(chdir)
     db1:	b8 09 00 00 00       	mov    $0x9,%eax
     db6:	cd 40                	int    $0x40
     db8:	c3                   	ret    

00000db9 <dup>:
SYSCALL(dup)
     db9:	b8 0a 00 00 00       	mov    $0xa,%eax
     dbe:	cd 40                	int    $0x40
     dc0:	c3                   	ret    

00000dc1 <getpid>:
SYSCALL(getpid)
     dc1:	b8 0b 00 00 00       	mov    $0xb,%eax
     dc6:	cd 40                	int    $0x40
     dc8:	c3                   	ret    

00000dc9 <sbrk>:
SYSCALL(sbrk)
     dc9:	b8 0c 00 00 00       	mov    $0xc,%eax
     dce:	cd 40                	int    $0x40
     dd0:	c3                   	ret    

00000dd1 <sleep>:
SYSCALL(sleep)
     dd1:	b8 0d 00 00 00       	mov    $0xd,%eax
     dd6:	cd 40                	int    $0x40
     dd8:	c3                   	ret    

00000dd9 <uptime>:
SYSCALL(uptime)
     dd9:	b8 0e 00 00 00       	mov    $0xe,%eax
     dde:	cd 40                	int    $0x40
     de0:	c3                   	ret    

00000de1 <halt>:
SYSCALL(halt)
     de1:	b8 16 00 00 00       	mov    $0x16,%eax
     de6:	cd 40                	int    $0x40
     de8:	c3                   	ret    

00000de9 <date>:
SYSCALL(date)
     de9:	b8 17 00 00 00       	mov    $0x17,%eax
     dee:	cd 40                	int    $0x40
     df0:	c3                   	ret    

00000df1 <getgid>:
SYSCALL(getgid)
     df1:	b8 18 00 00 00       	mov    $0x18,%eax
     df6:	cd 40                	int    $0x40
     df8:	c3                   	ret    

00000df9 <setgid>:
SYSCALL(setgid)
     df9:	b8 19 00 00 00       	mov    $0x19,%eax
     dfe:	cd 40                	int    $0x40
     e00:	c3                   	ret    

00000e01 <getuid>:
SYSCALL(getuid)
     e01:	b8 1a 00 00 00       	mov    $0x1a,%eax
     e06:	cd 40                	int    $0x40
     e08:	c3                   	ret    

00000e09 <setuid>:
SYSCALL(setuid)
     e09:	b8 1b 00 00 00       	mov    $0x1b,%eax
     e0e:	cd 40                	int    $0x40
     e10:	c3                   	ret    

00000e11 <getppid>:
SYSCALL(getppid)
     e11:	b8 1c 00 00 00       	mov    $0x1c,%eax
     e16:	cd 40                	int    $0x40
     e18:	c3                   	ret    

00000e19 <getprocs>:
SYSCALL(getprocs)
     e19:	b8 1d 00 00 00       	mov    $0x1d,%eax
     e1e:	cd 40                	int    $0x40
     e20:	c3                   	ret    

00000e21 <setpriority>:
SYSCALL(setpriority)
     e21:	b8 1e 00 00 00       	mov    $0x1e,%eax
     e26:	cd 40                	int    $0x40
     e28:	c3                   	ret    

00000e29 <getpriority>:
SYSCALL(getpriority)
     e29:	b8 1f 00 00 00       	mov    $0x1f,%eax
     e2e:	cd 40                	int    $0x40
     e30:	c3                   	ret    

00000e31 <chmod>:
SYSCALL(chmod)
     e31:	b8 20 00 00 00       	mov    $0x20,%eax
     e36:	cd 40                	int    $0x40
     e38:	c3                   	ret    

00000e39 <chown>:
SYSCALL(chown)
     e39:	b8 21 00 00 00       	mov    $0x21,%eax
     e3e:	cd 40                	int    $0x40
     e40:	c3                   	ret    

00000e41 <chgrp>:
SYSCALL(chgrp)
     e41:	b8 22 00 00 00       	mov    $0x22,%eax
     e46:	cd 40                	int    $0x40
     e48:	c3                   	ret    
     e49:	66 90                	xchg   %ax,%ax
     e4b:	66 90                	xchg   %ax,%ax
     e4d:	66 90                	xchg   %ax,%ax
     e4f:	90                   	nop

00000e50 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     e50:	55                   	push   %ebp
     e51:	89 e5                	mov    %esp,%ebp
     e53:	57                   	push   %edi
     e54:	56                   	push   %esi
     e55:	53                   	push   %ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
     e56:	89 d3                	mov    %edx,%ebx
{
     e58:	83 ec 3c             	sub    $0x3c,%esp
     e5b:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
     e5e:	85 d2                	test   %edx,%edx
     e60:	0f 89 92 00 00 00    	jns    ef8 <printint+0xa8>
     e66:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     e6a:	0f 84 88 00 00 00    	je     ef8 <printint+0xa8>
    neg = 1;
     e70:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
     e77:	f7 db                	neg    %ebx
  } else {
    x = xx;
  }

  i = 0;
     e79:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     e80:	8d 75 d7             	lea    -0x29(%ebp),%esi
     e83:	eb 08                	jmp    e8d <printint+0x3d>
     e85:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
     e88:	89 7d c4             	mov    %edi,-0x3c(%ebp)
  }while((x /= base) != 0);
     e8b:	89 c3                	mov    %eax,%ebx
    buf[i++] = digits[x % base];
     e8d:	89 d8                	mov    %ebx,%eax
     e8f:	31 d2                	xor    %edx,%edx
     e91:	8b 7d c4             	mov    -0x3c(%ebp),%edi
     e94:	f7 f1                	div    %ecx
     e96:	83 c7 01             	add    $0x1,%edi
     e99:	0f b6 92 00 19 00 00 	movzbl 0x1900(%edx),%edx
     ea0:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
     ea3:	39 d9                	cmp    %ebx,%ecx
     ea5:	76 e1                	jbe    e88 <printint+0x38>
  if(neg)
     ea7:	8b 45 c0             	mov    -0x40(%ebp),%eax
     eaa:	85 c0                	test   %eax,%eax
     eac:	74 0d                	je     ebb <printint+0x6b>
    buf[i++] = '-';
     eae:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
     eb3:	ba 2d 00 00 00       	mov    $0x2d,%edx
    buf[i++] = digits[x % base];
     eb8:	89 7d c4             	mov    %edi,-0x3c(%ebp)
     ebb:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     ebe:	8b 7d bc             	mov    -0x44(%ebp),%edi
     ec1:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
     ec5:	eb 0f                	jmp    ed6 <printint+0x86>
     ec7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     ece:	66 90                	xchg   %ax,%ax
     ed0:	0f b6 13             	movzbl (%ebx),%edx
     ed3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
     ed6:	83 ec 04             	sub    $0x4,%esp
     ed9:	88 55 d7             	mov    %dl,-0x29(%ebp)
     edc:	6a 01                	push   $0x1
     ede:	56                   	push   %esi
     edf:	57                   	push   %edi
     ee0:	e8 7c fe ff ff       	call   d61 <write>

  while(--i >= 0)
     ee5:	83 c4 10             	add    $0x10,%esp
     ee8:	39 de                	cmp    %ebx,%esi
     eea:	75 e4                	jne    ed0 <printint+0x80>
    putc(fd, buf[i]);
}
     eec:	8d 65 f4             	lea    -0xc(%ebp),%esp
     eef:	5b                   	pop    %ebx
     ef0:	5e                   	pop    %esi
     ef1:	5f                   	pop    %edi
     ef2:	5d                   	pop    %ebp
     ef3:	c3                   	ret    
     ef4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
     ef8:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
     eff:	e9 75 ff ff ff       	jmp    e79 <printint+0x29>
     f04:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     f0f:	90                   	nop

00000f10 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     f10:	55                   	push   %ebp
     f11:	89 e5                	mov    %esp,%ebp
     f13:	57                   	push   %edi
     f14:	56                   	push   %esi
     f15:	53                   	push   %ebx
     f16:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     f19:	8b 75 0c             	mov    0xc(%ebp),%esi
     f1c:	0f b6 1e             	movzbl (%esi),%ebx
     f1f:	84 db                	test   %bl,%bl
     f21:	0f 84 b9 00 00 00    	je     fe0 <printf+0xd0>
  ap = (uint*)(void*)&fmt + 1;
     f27:	8d 45 10             	lea    0x10(%ebp),%eax
     f2a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
     f2d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
     f30:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
     f32:	89 45 d0             	mov    %eax,-0x30(%ebp)
     f35:	eb 38                	jmp    f6f <printf+0x5f>
     f37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f3e:	66 90                	xchg   %ax,%ax
     f40:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
     f43:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
     f48:	83 f8 25             	cmp    $0x25,%eax
     f4b:	74 17                	je     f64 <printf+0x54>
  write(fd, &c, 1);
     f4d:	83 ec 04             	sub    $0x4,%esp
     f50:	88 5d e7             	mov    %bl,-0x19(%ebp)
     f53:	6a 01                	push   $0x1
     f55:	57                   	push   %edi
     f56:	ff 75 08             	pushl  0x8(%ebp)
     f59:	e8 03 fe ff ff       	call   d61 <write>
     f5e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
     f61:	83 c4 10             	add    $0x10,%esp
     f64:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
     f67:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
     f6b:	84 db                	test   %bl,%bl
     f6d:	74 71                	je     fe0 <printf+0xd0>
    c = fmt[i] & 0xff;
     f6f:	0f be cb             	movsbl %bl,%ecx
     f72:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     f75:	85 d2                	test   %edx,%edx
     f77:	74 c7                	je     f40 <printf+0x30>
      }
    } else if(state == '%'){
     f79:	83 fa 25             	cmp    $0x25,%edx
     f7c:	75 e6                	jne    f64 <printf+0x54>
      if(c == 'd'){
     f7e:	83 f8 64             	cmp    $0x64,%eax
     f81:	0f 84 99 00 00 00    	je     1020 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     f87:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
     f8d:	83 f9 70             	cmp    $0x70,%ecx
     f90:	74 5e                	je     ff0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     f92:	83 f8 73             	cmp    $0x73,%eax
     f95:	0f 84 d5 00 00 00    	je     1070 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     f9b:	83 f8 63             	cmp    $0x63,%eax
     f9e:	0f 84 8c 00 00 00    	je     1030 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     fa4:	83 f8 25             	cmp    $0x25,%eax
     fa7:	0f 84 b3 00 00 00    	je     1060 <printf+0x150>
  write(fd, &c, 1);
     fad:	83 ec 04             	sub    $0x4,%esp
     fb0:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
     fb4:	6a 01                	push   $0x1
     fb6:	57                   	push   %edi
     fb7:	ff 75 08             	pushl  0x8(%ebp)
     fba:	e8 a2 fd ff ff       	call   d61 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
     fbf:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
     fc2:	83 c4 0c             	add    $0xc,%esp
     fc5:	6a 01                	push   $0x1
     fc7:	83 c6 01             	add    $0x1,%esi
     fca:	57                   	push   %edi
     fcb:	ff 75 08             	pushl  0x8(%ebp)
     fce:	e8 8e fd ff ff       	call   d61 <write>
  for(i = 0; fmt[i]; i++){
     fd3:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
     fd7:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     fda:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
     fdc:	84 db                	test   %bl,%bl
     fde:	75 8f                	jne    f6f <printf+0x5f>
    }
  }
}
     fe0:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fe3:	5b                   	pop    %ebx
     fe4:	5e                   	pop    %esi
     fe5:	5f                   	pop    %edi
     fe6:	5d                   	pop    %ebp
     fe7:	c3                   	ret    
     fe8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     fef:	90                   	nop
        printint(fd, *ap, 16, 0);
     ff0:	83 ec 0c             	sub    $0xc,%esp
     ff3:	b9 10 00 00 00       	mov    $0x10,%ecx
     ff8:	6a 00                	push   $0x0
     ffa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
     ffd:	8b 45 08             	mov    0x8(%ebp),%eax
    1000:	8b 13                	mov    (%ebx),%edx
    1002:	e8 49 fe ff ff       	call   e50 <printint>
        ap++;
    1007:	89 d8                	mov    %ebx,%eax
    1009:	83 c4 10             	add    $0x10,%esp
      state = 0;
    100c:	31 d2                	xor    %edx,%edx
        ap++;
    100e:	83 c0 04             	add    $0x4,%eax
    1011:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1014:	e9 4b ff ff ff       	jmp    f64 <printf+0x54>
    1019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    1020:	83 ec 0c             	sub    $0xc,%esp
    1023:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1028:	6a 01                	push   $0x1
    102a:	eb ce                	jmp    ffa <printf+0xea>
    102c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    1030:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    1033:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1036:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    1038:	6a 01                	push   $0x1
        ap++;
    103a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    103d:	57                   	push   %edi
    103e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    1041:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1044:	e8 18 fd ff ff       	call   d61 <write>
        ap++;
    1049:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    104c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    104f:	31 d2                	xor    %edx,%edx
    1051:	e9 0e ff ff ff       	jmp    f64 <printf+0x54>
    1056:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    105d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    1060:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1063:	83 ec 04             	sub    $0x4,%esp
    1066:	e9 5a ff ff ff       	jmp    fc5 <printf+0xb5>
    106b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    106f:	90                   	nop
        s = (char*)*ap;
    1070:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1073:	8b 18                	mov    (%eax),%ebx
        ap++;
    1075:	83 c0 04             	add    $0x4,%eax
    1078:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    107b:	85 db                	test   %ebx,%ebx
    107d:	74 17                	je     1096 <printf+0x186>
        while(*s != 0){
    107f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    1082:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    1084:	84 c0                	test   %al,%al
    1086:	0f 84 d8 fe ff ff    	je     f64 <printf+0x54>
    108c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    108f:	89 de                	mov    %ebx,%esi
    1091:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1094:	eb 1a                	jmp    10b0 <printf+0x1a0>
          s = "(null)";
    1096:	bb f8 18 00 00       	mov    $0x18f8,%ebx
        while(*s != 0){
    109b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    109e:	b8 28 00 00 00       	mov    $0x28,%eax
    10a3:	89 de                	mov    %ebx,%esi
    10a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
    10a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10af:	90                   	nop
  write(fd, &c, 1);
    10b0:	83 ec 04             	sub    $0x4,%esp
          s++;
    10b3:	83 c6 01             	add    $0x1,%esi
    10b6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    10b9:	6a 01                	push   $0x1
    10bb:	57                   	push   %edi
    10bc:	53                   	push   %ebx
    10bd:	e8 9f fc ff ff       	call   d61 <write>
        while(*s != 0){
    10c2:	0f b6 06             	movzbl (%esi),%eax
    10c5:	83 c4 10             	add    $0x10,%esp
    10c8:	84 c0                	test   %al,%al
    10ca:	75 e4                	jne    10b0 <printf+0x1a0>
    10cc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
    10cf:	31 d2                	xor    %edx,%edx
    10d1:	e9 8e fe ff ff       	jmp    f64 <printf+0x54>
    10d6:	66 90                	xchg   %ax,%ax
    10d8:	66 90                	xchg   %ax,%ax
    10da:	66 90                	xchg   %ax,%ax
    10dc:	66 90                	xchg   %ax,%ax
    10de:	66 90                	xchg   %ax,%ax

000010e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    10e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    10e1:	a1 1c 1d 00 00       	mov    0x1d1c,%eax
{
    10e6:	89 e5                	mov    %esp,%ebp
    10e8:	57                   	push   %edi
    10e9:	56                   	push   %esi
    10ea:	53                   	push   %ebx
    10eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    10ee:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
    10f0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    10f3:	39 c8                	cmp    %ecx,%eax
    10f5:	73 19                	jae    1110 <free+0x30>
    10f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10fe:	66 90                	xchg   %ax,%ax
    1100:	39 d1                	cmp    %edx,%ecx
    1102:	72 14                	jb     1118 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1104:	39 d0                	cmp    %edx,%eax
    1106:	73 10                	jae    1118 <free+0x38>
{
    1108:	89 d0                	mov    %edx,%eax
    110a:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    110c:	39 c8                	cmp    %ecx,%eax
    110e:	72 f0                	jb     1100 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1110:	39 d0                	cmp    %edx,%eax
    1112:	72 f4                	jb     1108 <free+0x28>
    1114:	39 d1                	cmp    %edx,%ecx
    1116:	73 f0                	jae    1108 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1118:	8b 73 fc             	mov    -0x4(%ebx),%esi
    111b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    111e:	39 fa                	cmp    %edi,%edx
    1120:	74 1e                	je     1140 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1122:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1125:	8b 50 04             	mov    0x4(%eax),%edx
    1128:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    112b:	39 f1                	cmp    %esi,%ecx
    112d:	74 28                	je     1157 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    112f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
    1131:	5b                   	pop    %ebx
  freep = p;
    1132:	a3 1c 1d 00 00       	mov    %eax,0x1d1c
}
    1137:	5e                   	pop    %esi
    1138:	5f                   	pop    %edi
    1139:	5d                   	pop    %ebp
    113a:	c3                   	ret    
    113b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    113f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
    1140:	03 72 04             	add    0x4(%edx),%esi
    1143:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1146:	8b 10                	mov    (%eax),%edx
    1148:	8b 12                	mov    (%edx),%edx
    114a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    114d:	8b 50 04             	mov    0x4(%eax),%edx
    1150:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1153:	39 f1                	cmp    %esi,%ecx
    1155:	75 d8                	jne    112f <free+0x4f>
    p->s.size += bp->s.size;
    1157:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    115a:	a3 1c 1d 00 00       	mov    %eax,0x1d1c
    p->s.size += bp->s.size;
    115f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1162:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1165:	89 10                	mov    %edx,(%eax)
}
    1167:	5b                   	pop    %ebx
    1168:	5e                   	pop    %esi
    1169:	5f                   	pop    %edi
    116a:	5d                   	pop    %ebp
    116b:	c3                   	ret    
    116c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001170 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1170:	55                   	push   %ebp
    1171:	89 e5                	mov    %esp,%ebp
    1173:	57                   	push   %edi
    1174:	56                   	push   %esi
    1175:	53                   	push   %ebx
    1176:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1179:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    117c:	8b 3d 1c 1d 00 00    	mov    0x1d1c,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1182:	8d 70 07             	lea    0x7(%eax),%esi
    1185:	c1 ee 03             	shr    $0x3,%esi
    1188:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    118b:	85 ff                	test   %edi,%edi
    118d:	0f 84 ad 00 00 00    	je     1240 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1193:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
    1195:	8b 4a 04             	mov    0x4(%edx),%ecx
    1198:	39 f1                	cmp    %esi,%ecx
    119a:	73 72                	jae    120e <malloc+0x9e>
    119c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    11a2:	bb 00 10 00 00       	mov    $0x1000,%ebx
    11a7:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    11aa:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    11b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    11b4:	eb 1b                	jmp    11d1 <malloc+0x61>
    11b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11bd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    11c0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    11c2:	8b 48 04             	mov    0x4(%eax),%ecx
    11c5:	39 f1                	cmp    %esi,%ecx
    11c7:	73 4f                	jae    1218 <malloc+0xa8>
    11c9:	8b 3d 1c 1d 00 00    	mov    0x1d1c,%edi
    11cf:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    11d1:	39 d7                	cmp    %edx,%edi
    11d3:	75 eb                	jne    11c0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    11d5:	83 ec 0c             	sub    $0xc,%esp
    11d8:	ff 75 e4             	pushl  -0x1c(%ebp)
    11db:	e8 e9 fb ff ff       	call   dc9 <sbrk>
  if(p == (char*)-1)
    11e0:	83 c4 10             	add    $0x10,%esp
    11e3:	83 f8 ff             	cmp    $0xffffffff,%eax
    11e6:	74 1c                	je     1204 <malloc+0x94>
  hp->s.size = nu;
    11e8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    11eb:	83 ec 0c             	sub    $0xc,%esp
    11ee:	83 c0 08             	add    $0x8,%eax
    11f1:	50                   	push   %eax
    11f2:	e8 e9 fe ff ff       	call   10e0 <free>
  return freep;
    11f7:	8b 15 1c 1d 00 00    	mov    0x1d1c,%edx
      if((p = morecore(nunits)) == 0)
    11fd:	83 c4 10             	add    $0x10,%esp
    1200:	85 d2                	test   %edx,%edx
    1202:	75 bc                	jne    11c0 <malloc+0x50>
        return 0;
  }
}
    1204:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1207:	31 c0                	xor    %eax,%eax
}
    1209:	5b                   	pop    %ebx
    120a:	5e                   	pop    %esi
    120b:	5f                   	pop    %edi
    120c:	5d                   	pop    %ebp
    120d:	c3                   	ret    
    if(p->s.size >= nunits){
    120e:	89 d0                	mov    %edx,%eax
    1210:	89 fa                	mov    %edi,%edx
    1212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1218:	39 ce                	cmp    %ecx,%esi
    121a:	74 54                	je     1270 <malloc+0x100>
        p->s.size -= nunits;
    121c:	29 f1                	sub    %esi,%ecx
    121e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1221:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1224:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    1227:	89 15 1c 1d 00 00    	mov    %edx,0x1d1c
}
    122d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1230:	83 c0 08             	add    $0x8,%eax
}
    1233:	5b                   	pop    %ebx
    1234:	5e                   	pop    %esi
    1235:	5f                   	pop    %edi
    1236:	5d                   	pop    %ebp
    1237:	c3                   	ret    
    1238:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    123f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
    1240:	c7 05 1c 1d 00 00 20 	movl   $0x1d20,0x1d1c
    1247:	1d 00 00 
    base.s.size = 0;
    124a:	bf 20 1d 00 00       	mov    $0x1d20,%edi
    base.s.ptr = freep = prevp = &base;
    124f:	c7 05 20 1d 00 00 20 	movl   $0x1d20,0x1d20
    1256:	1d 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1259:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
    125b:	c7 05 24 1d 00 00 00 	movl   $0x0,0x1d24
    1262:	00 00 00 
    if(p->s.size >= nunits){
    1265:	e9 32 ff ff ff       	jmp    119c <malloc+0x2c>
    126a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    1270:	8b 08                	mov    (%eax),%ecx
    1272:	89 0a                	mov    %ecx,(%edx)
    1274:	eb b1                	jmp    1227 <malloc+0xb7>
