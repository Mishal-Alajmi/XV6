
_p5-test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d. setuid\n", i++);
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
       f:	8d 7d af             	lea    -0x51(%ebp),%edi
      12:	53                   	push   %ebx
      13:	51                   	push   %ecx
      14:	83 ec 58             	sub    $0x58,%esp
  int rc, select, done;
  char buf[5];

  // test strings
  char *t0[] = {'\0'}; // dummy
  char *t1[] = {"testsetuid", '\0'};
      17:	c7 45 b4 ef 13 00 00 	movl   $0x13ef,-0x4c(%ebp)
      1e:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
      25:	8d 76 00             	lea    0x0(%esi),%esi

  while (1) {
    done = FALSE;
    printMenu();
      28:	e8 83 0a 00 00       	call   ab0 <printMenu>
    printf(1, "Enter test number: ");
      2d:	83 ec 08             	sub    $0x8,%esp
      30:	68 fa 13 00 00       	push   $0x13fa
      35:	6a 01                	push   $0x1
      37:	e8 d4 0f 00 00       	call   1010 <printf>
    gets(buf, 5);
      3c:	5e                   	pop    %esi
      3d:	58                   	pop    %eax
      3e:	6a 05                	push   $0x5
      40:	57                   	push   %edi
      41:	e8 1a 0c 00 00       	call   c60 <gets>
    if ((buf[0] == '\n') || (buf[0] == '\0')) continue;
      46:	0f b6 45 af          	movzbl -0x51(%ebp),%eax
      4a:	83 c4 10             	add    $0x10,%esp
      4d:	3c 0a                	cmp    $0xa,%al
      4f:	74 d7                	je     28 <main+0x28>
      51:	84 c0                	test   %al,%al
      53:	74 d3                	je     28 <main+0x28>
    select = atoi(buf);
      55:	83 ec 0c             	sub    $0xc,%esp
      58:	57                   	push   %edi
      59:	e8 d2 0c 00 00       	call   d30 <atoi>
    switch (select) {
      5e:	83 c4 10             	add    $0x10,%esp
      61:	83 f8 07             	cmp    $0x7,%eax
      64:	0f 87 e6 05 00 00    	ja     650 <main+0x650>
      6a:	ff 24 85 5c 1c 00 00 	jmp    *0x1c5c(,%eax,4)
      71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  printf(1, "\nExecuting exec test.\n\n");
      78:	83 ec 08             	sub    $0x8,%esp
      7b:	68 4d 15 00 00       	push   $0x154d
      80:	6a 01                	push   $0x1
      82:	e8 89 0f 00 00       	call   1010 <printf>
  if (!canRun(cmd[0])) {
      87:	8b 75 b4             	mov    -0x4c(%ebp),%esi
  uid = getuid();
      8a:	e8 72 0e 00 00       	call   f01 <getuid>
      8f:	89 c3                	mov    %eax,%ebx
  gid = getgid();
      91:	e8 5b 0e 00 00       	call   ef1 <getgid>
      96:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  check(stat(name, &st));
      99:	58                   	pop    %eax
      9a:	8d 45 cc             	lea    -0x34(%ebp),%eax
      9d:	5a                   	pop    %edx
      9e:	50                   	push   %eax
      9f:	56                   	push   %esi
      a0:	e8 3b 0c 00 00       	call   ce0 <stat>
      a5:	83 c4 10             	add    $0x10,%esp
      a8:	85 c0                	test   %eax,%eax
      aa:	0f 85 66 07 00 00    	jne    816 <main+0x816>
  if (uid == st.uid) {
      b0:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
      b4:	0f b6 55 e4          	movzbl -0x1c(%ebp),%edx
      b8:	39 d8                	cmp    %ebx,%eax
      ba:	0f 84 a7 05 00 00    	je     667 <main+0x667>
  if (gid == st.gid) {
      c0:	0f b7 45 e2          	movzwl -0x1e(%ebp),%eax
      c4:	3b 45 a4             	cmp    -0x5c(%ebp),%eax
      c7:	0f 84 8a 07 00 00    	je     857 <main+0x857>
  if (st.mode.flags.o_x) {
      cd:	80 e2 01             	and    $0x1,%dl
      d0:	0f 84 d9 06 00 00    	je     7af <main+0x7af>
  check(stat(cmd[0], &st));
      d6:	50                   	push   %eax
      d7:	50                   	push   %eax
      d8:	8d 45 cc             	lea    -0x34(%ebp),%eax
      db:	50                   	push   %eax
      dc:	ff 75 b4             	pushl  -0x4c(%ebp)
      df:	e8 fc 0b 00 00       	call   ce0 <stat>
      e4:	83 c4 10             	add    $0x10,%esp
      e7:	89 c6                	mov    %eax,%esi
      e9:	85 c0                	test   %eax,%eax
      eb:	0f 85 03 08 00 00    	jne    8f4 <main+0x8f4>
  uid = st.uid;
      f1:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
  for (i=0; i<NUMPERMSTOCHECK; i++) {
      f5:	83 3d f0 1f 00 00 00 	cmpl   $0x0,0x1ff0
      fc:	bb a0 1f 00 00       	mov    $0x1fa0,%ebx
  uid = st.uid;
     101:	66 89 45 a4          	mov    %ax,-0x5c(%ebp)
  gid = st.gid;
     105:	0f b7 45 e2          	movzwl -0x1e(%ebp),%eax
     109:	66 89 45 a2          	mov    %ax,-0x5e(%ebp)
  for (i=0; i<NUMPERMSTOCHECK; i++) {
     10d:	7f 45                	jg     154 <main+0x154>
     10f:	e9 fa 07 00 00       	jmp    90e <main+0x90e>
     114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(2, "The following test should not produce an error.\n");
     118:	83 ec 08             	sub    $0x8,%esp
     11b:	68 68 1b 00 00       	push   $0x1b68
     120:	6a 02                	push   $0x2
     122:	e8 e9 0e 00 00       	call   1010 <printf>
     127:	83 c4 10             	add    $0x10,%esp
    rc = fork();
     12a:	e8 0a 0d 00 00       	call   e39 <fork>
    if (rc < 0) {    // fork failed
     12f:	85 c0                	test   %eax,%eax
     131:	0f 88 9c 08 00 00    	js     9d3 <main+0x9d3>
    if (rc == 0) {   // child
     137:	0f 84 22 09 00 00    	je     a5f <main+0xa5f>
    wait();
     13d:	e8 07 0d 00 00       	call   e49 <wait>
  for (i=0; i<NUMPERMSTOCHECK; i++) {
     142:	83 c6 01             	add    $0x1,%esi
     145:	83 c3 10             	add    $0x10,%ebx
     148:	3b 35 f0 1f 00 00    	cmp    0x1ff0,%esi
     14e:	0f 8d ba 07 00 00    	jge    90e <main+0x90e>
    check(setuid(testperms[i][procuid]));
     154:	83 ec 0c             	sub    $0xc,%esp
     157:	ff 33                	pushl  (%ebx)
     159:	e8 ab 0d 00 00       	call   f09 <setuid>
     15e:	83 c4 10             	add    $0x10,%esp
     161:	85 c0                	test   %eax,%eax
     163:	0f 85 e8 07 00 00    	jne    951 <main+0x951>
    check(setgid(testperms[i][procgid]));
     169:	83 ec 0c             	sub    $0xc,%esp
     16c:	ff 73 04             	pushl  0x4(%ebx)
     16f:	e8 85 0d 00 00       	call   ef9 <setgid>
     174:	83 c4 10             	add    $0x10,%esp
     177:	85 c0                	test   %eax,%eax
     179:	0f 85 ec 07 00 00    	jne    96b <main+0x96b>
    check(chown(cmd[0], testperms[i][fileuid]));
     17f:	83 ec 08             	sub    $0x8,%esp
     182:	ff 73 08             	pushl  0x8(%ebx)
     185:	ff 75 b4             	pushl  -0x4c(%ebp)
     188:	e8 ac 0d 00 00       	call   f39 <chown>
     18d:	83 c4 10             	add    $0x10,%esp
     190:	85 c0                	test   %eax,%eax
     192:	0f 85 ed 07 00 00    	jne    985 <main+0x985>
    check(chgrp(cmd[0], testperms[i][filegid]));
     198:	83 ec 08             	sub    $0x8,%esp
     19b:	ff 73 0c             	pushl  0xc(%ebx)
     19e:	ff 75 b4             	pushl  -0x4c(%ebp)
     1a1:	e8 9b 0d 00 00       	call   f41 <chgrp>
     1a6:	83 c4 10             	add    $0x10,%esp
     1a9:	85 c0                	test   %eax,%eax
     1ab:	0f 85 ee 07 00 00    	jne    99f <main+0x99f>
    check(chmod(cmd[0], perms[i]));
     1b1:	83 ec 08             	sub    $0x8,%esp
     1b4:	ff 34 b5 e0 1f 00 00 	pushl  0x1fe0(,%esi,4)
     1bb:	ff 75 b4             	pushl  -0x4c(%ebp)
     1be:	e8 6e 0d 00 00       	call   f31 <chmod>
     1c3:	83 c4 10             	add    $0x10,%esp
     1c6:	85 c0                	test   %eax,%eax
     1c8:	0f 85 eb 07 00 00    	jne    9b9 <main+0x9b9>
    if (i != NUMPERMSTOCHECK-1)
     1ce:	a1 f0 1f 00 00       	mov    0x1ff0,%eax
     1d3:	83 e8 01             	sub    $0x1,%eax
     1d6:	39 f0                	cmp    %esi,%eax
     1d8:	0f 85 3a ff ff ff    	jne    118 <main+0x118>
      printf(2, "The following test should fail.\n");
     1de:	83 ec 08             	sub    $0x8,%esp
     1e1:	68 9c 1b 00 00       	push   $0x1b9c
     1e6:	6a 02                	push   $0x2
     1e8:	e8 23 0e 00 00       	call   1010 <printf>
     1ed:	83 c4 10             	add    $0x10,%esp
     1f0:	e9 35 ff ff ff       	jmp    12a <main+0x12a>
     1f5:	8d 76 00             	lea    0x0(%esi),%esi
  printf(1, "\nExecuting chgrp test.\n\n");
     1f8:	83 ec 08             	sub    $0x8,%esp
     1fb:	68 28 15 00 00       	push   $0x1528
     200:	6a 01                	push   $0x1
     202:	e8 09 0e 00 00       	call   1010 <printf>
  stat(cmd[0], &st);
     207:	58                   	pop    %eax
     208:	8d 45 cc             	lea    -0x34(%ebp),%eax
     20b:	5a                   	pop    %edx
     20c:	50                   	push   %eax
     20d:	ff 75 b4             	pushl  -0x4c(%ebp)
     210:	e8 cb 0a 00 00       	call   ce0 <stat>
  gid1 = st.gid;
     215:	0f b7 5d e2          	movzwl -0x1e(%ebp),%ebx
  rc = chgrp(cmd[0], gid1+1);
     219:	59                   	pop    %ecx
     21a:	5e                   	pop    %esi
     21b:	8d 43 01             	lea    0x1(%ebx),%eax
     21e:	50                   	push   %eax
     21f:	ff 75 b4             	pushl  -0x4c(%ebp)
     222:	e8 1a 0d 00 00       	call   f41 <chgrp>
  if (rc != 0) {
     227:	83 c4 10             	add    $0x10,%esp
     22a:	85 c0                	test   %eax,%eax
     22c:	0f 85 94 04 00 00    	jne    6c6 <main+0x6c6>
  stat(cmd[0], &st);
     232:	50                   	push   %eax
     233:	50                   	push   %eax
     234:	8d 45 cc             	lea    -0x34(%ebp),%eax
     237:	50                   	push   %eax
     238:	ff 75 b4             	pushl  -0x4c(%ebp)
     23b:	e8 a0 0a 00 00       	call   ce0 <stat>
  gid2 = st.gid;
     240:	0f b7 45 e2          	movzwl -0x1e(%ebp),%eax
  if (gid1 == gid2) {
     244:	83 c4 10             	add    $0x10,%esp
     247:	39 c3                	cmp    %eax,%ebx
     249:	0f 84 b1 05 00 00    	je     800 <main+0x800>
  chgrp(cmd[0], gid1);  // put back the original
     24f:	56                   	push   %esi
     250:	56                   	push   %esi
     251:	53                   	push   %ebx
     252:	ff 75 b4             	pushl  -0x4c(%ebp)
     255:	e8 e7 0c 00 00       	call   f41 <chgrp>
  printf(1, "Test Passed\n");
     25a:	eb 66                	jmp    2c2 <main+0x2c2>
     25c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  printf(1, "\nExecuting chown test.\n\n");
     260:	83 ec 08             	sub    $0x8,%esp
     263:	68 03 15 00 00       	push   $0x1503
     268:	6a 01                	push   $0x1
     26a:	e8 a1 0d 00 00       	call   1010 <printf>
  stat(cmd[0], &st);
     26f:	8d 45 cc             	lea    -0x34(%ebp),%eax
     272:	59                   	pop    %ecx
     273:	5b                   	pop    %ebx
     274:	50                   	push   %eax
     275:	ff 75 b4             	pushl  -0x4c(%ebp)
     278:	e8 63 0a 00 00       	call   ce0 <stat>
  uid1 = st.uid;
     27d:	0f b7 5d e0          	movzwl -0x20(%ebp),%ebx
  rc = chown(cmd[0], uid1+1);
     281:	5e                   	pop    %esi
     282:	58                   	pop    %eax
     283:	8d 43 01             	lea    0x1(%ebx),%eax
     286:	50                   	push   %eax
     287:	ff 75 b4             	pushl  -0x4c(%ebp)
     28a:	e8 aa 0c 00 00       	call   f39 <chown>
  if (rc != 0) {
     28f:	83 c4 10             	add    $0x10,%esp
     292:	85 c0                	test   %eax,%eax
     294:	0f 85 7c 04 00 00    	jne    716 <main+0x716>
  stat(cmd[0], &st);
     29a:	50                   	push   %eax
     29b:	50                   	push   %eax
     29c:	8d 45 cc             	lea    -0x34(%ebp),%eax
     29f:	50                   	push   %eax
     2a0:	ff 75 b4             	pushl  -0x4c(%ebp)
     2a3:	e8 38 0a 00 00       	call   ce0 <stat>
  uid2 = st.uid;
     2a8:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
  if (uid1 == uid2) {
     2ac:	83 c4 10             	add    $0x10,%esp
     2af:	39 c3                	cmp    %eax,%ebx
     2b1:	0f 84 33 05 00 00    	je     7ea <main+0x7ea>
  chown(cmd[0], uid1);  // put back the original
     2b7:	50                   	push   %eax
     2b8:	50                   	push   %eax
     2b9:	53                   	push   %ebx
     2ba:	ff 75 b4             	pushl  -0x4c(%ebp)
     2bd:	e8 77 0c 00 00       	call   f39 <chown>
  printf(1, "Test Passed\n");
     2c2:	5a                   	pop    %edx
     2c3:	59                   	pop    %ecx
     2c4:	68 39 14 00 00       	push   $0x1439
     2c9:	6a 01                	push   $0x1
     2cb:	e8 40 0d 00 00       	call   1010 <printf>
      case 2: doTest(doGidTest,    t0); break;
      case 3: doTest(doChmodTest,  t1); break;
      case 4: doTest(doChownTest,  t1); break;
      case 5: doTest(doChgrpTest,  t1); break;
      case 6: doTest(doExecTest,   t1); break;
      case 7: doTest(doSetuidTest, t1); break;
     2d0:	83 c4 10             	add    $0x10,%esp
     2d3:	e9 50 fd ff ff       	jmp    28 <main+0x28>
     2d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     2df:	90                   	nop
  printf(1, "\nExecuting chmod() test.\n\n");
     2e0:	83 ec 08             	sub    $0x8,%esp
     2e3:	68 88 14 00 00       	push   $0x1488
     2e8:	6a 01                	push   $0x1
     2ea:	e8 21 0d 00 00       	call   1010 <printf>
  check(stat(cmd[0], &st));
     2ef:	58                   	pop    %eax
     2f0:	8d 45 cc             	lea    -0x34(%ebp),%eax
     2f3:	5a                   	pop    %edx
     2f4:	50                   	push   %eax
     2f5:	ff 75 b4             	pushl  -0x4c(%ebp)
     2f8:	e8 e3 09 00 00       	call   ce0 <stat>
     2fd:	83 c4 10             	add    $0x10,%esp
     300:	89 c3                	mov    %eax,%ebx
     302:	85 c0                	test   %eax,%eax
     304:	0f 85 7c 03 00 00    	jne    686 <main+0x686>
  for (i=0; i<NUMPERMSTOCHECK; i++) {
     30a:	a1 f0 1f 00 00       	mov    0x1ff0,%eax
  mode = st.mode.asInt;
     30f:	8b 75 e4             	mov    -0x1c(%ebp),%esi
  for (i=0; i<NUMPERMSTOCHECK; i++) {
     312:	85 c0                	test   %eax,%eax
     314:	7f 3c                	jg     352 <main+0x352>
     316:	e9 97 03 00 00       	jmp    6b2 <main+0x6b2>
     31b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     31f:	90                   	nop
    check(stat(cmd[0], &st));
     320:	83 ec 08             	sub    $0x8,%esp
     323:	8d 45 cc             	lea    -0x34(%ebp),%eax
     326:	50                   	push   %eax
     327:	ff 75 b4             	pushl  -0x4c(%ebp)
     32a:	e8 b1 09 00 00       	call   ce0 <stat>
     32f:	83 c4 10             	add    $0x10,%esp
     332:	85 c0                	test   %eax,%eax
     334:	0f 85 4c 03 00 00    	jne    686 <main+0x686>
    if (mode == testmode) {
     33a:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
     33d:	0f 84 ea 04 00 00    	je     82d <main+0x82d>
  for (i=0; i<NUMPERMSTOCHECK; i++) {
     343:	83 c3 01             	add    $0x1,%ebx
     346:	3b 1d f0 1f 00 00    	cmp    0x1ff0,%ebx
     34c:	0f 8d 60 03 00 00    	jge    6b2 <main+0x6b2>
    check(chmod(cmd[0], perms[i]));
     352:	83 ec 08             	sub    $0x8,%esp
     355:	ff 34 9d e0 1f 00 00 	pushl  0x1fe0(,%ebx,4)
     35c:	ff 75 b4             	pushl  -0x4c(%ebp)
     35f:	e8 cd 0b 00 00       	call   f31 <chmod>
     364:	83 c4 10             	add    $0x10,%esp
     367:	85 c0                	test   %eax,%eax
     369:	74 b5                	je     320 <main+0x320>
     36b:	51                   	push   %ecx
     36c:	68 c7 14 00 00       	push   $0x14c7
     371:	68 b5 14 00 00       	push   $0x14b5
     376:	6a 02                	push   $0x2
     378:	e8 93 0c 00 00       	call   1010 <printf>
      case 3: doTest(doChmodTest,  t1); break;
     37d:	83 c4 10             	add    $0x10,%esp
     380:	e9 16 03 00 00       	jmp    69b <main+0x69b>
     385:	8d 76 00             	lea    0x0(%esi),%esi
  printf(1, "\nExecuting setgid() test.\n\n");
     388:	83 ec 08             	sub    $0x8,%esp
  int badgids[] = {32767+5, -41, ~0};  // 32767 is max value
     38b:	c7 45 cc 04 80 00 00 	movl   $0x8004,-0x34(%ebp)
  printf(1, "\nExecuting setgid() test.\n\n");
     392:	68 62 14 00 00       	push   $0x1462
     397:	6a 01                	push   $0x1
  int badgids[] = {32767+5, -41, ~0};  // 32767 is max value
     399:	c7 45 d0 d7 ff ff ff 	movl   $0xffffffd7,-0x30(%ebp)
     3a0:	c7 45 d4 ff ff ff ff 	movl   $0xffffffff,-0x2c(%ebp)
  printf(1, "\nExecuting setgid() test.\n\n");
     3a7:	e8 64 0c 00 00       	call   1010 <printf>
  startgid = gid = getgid();
     3ac:	e8 40 0b 00 00       	call   ef1 <getgid>
  testgid = ++gid;
     3b1:	8d 58 01             	lea    0x1(%eax),%ebx
  startgid = gid = getgid();
     3b4:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  rc = setgid(testgid);
     3b7:	89 1c 24             	mov    %ebx,(%esp)
     3ba:	e8 3a 0b 00 00       	call   ef9 <setgid>
  if (rc) {
     3bf:	83 c4 10             	add    $0x10,%esp
     3c2:	85 c0                	test   %eax,%eax
     3c4:	0f 85 74 03 00 00    	jne    73e <main+0x73e>
  gid = getgid();
     3ca:	e8 22 0b 00 00       	call   ef1 <getgid>
  if (gid != testgid) {
     3cf:	39 c3                	cmp    %eax,%ebx
     3d1:	0f 85 8f 03 00 00    	jne    766 <main+0x766>
     3d7:	8d 5d cc             	lea    -0x34(%ebp),%ebx
    rc = setgid(badgids[i]);
     3da:	8b 33                	mov    (%ebx),%esi
     3dc:	83 ec 0c             	sub    $0xc,%esp
     3df:	56                   	push   %esi
     3e0:	e8 14 0b 00 00       	call   ef9 <setgid>
    if (rc == 0) {
     3e5:	83 c4 10             	add    $0x10,%esp
     3e8:	85 c0                	test   %eax,%eax
     3ea:	0f 84 10 06 00 00    	je     a00 <main+0xa00>
    rc = getgid();
     3f0:	e8 fc 0a 00 00       	call   ef1 <getgid>
    if (badgids[i] == rc) {
     3f5:	39 c6                	cmp    %eax,%esi
     3f7:	0f 84 3e 06 00 00    	je     a3b <main+0xa3b>
     3fd:	83 c3 04             	add    $0x4,%ebx
  for (i=0; i<badgidcount; i++) {
     400:	8d 45 d8             	lea    -0x28(%ebp),%eax
     403:	39 d8                	cmp    %ebx,%eax
     405:	75 d3                	jne    3da <main+0x3da>
  setgid(startgid);
     407:	83 ec 0c             	sub    $0xc,%esp
     40a:	ff 75 a4             	pushl  -0x5c(%ebp)
     40d:	e8 e7 0a 00 00       	call   ef9 <setgid>
  printf(1, "Test Passed\n");
     412:	e9 ab fe ff ff       	jmp    2c2 <main+0x2c2>
     417:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     41e:	66 90                	xchg   %ax,%ax
  printf(1, "\nExecuting setuid() test.\n\n");
     420:	83 ec 08             	sub    $0x8,%esp
  int baduids[] = {32767+5, -41, ~0};  // 32767 is max value
     423:	c7 45 cc 04 80 00 00 	movl   $0x8004,-0x34(%ebp)
  printf(1, "\nExecuting setuid() test.\n\n");
     42a:	68 1d 14 00 00       	push   $0x141d
     42f:	6a 01                	push   $0x1
  int baduids[] = {32767+5, -41, ~0};  // 32767 is max value
     431:	c7 45 d0 d7 ff ff ff 	movl   $0xffffffd7,-0x30(%ebp)
     438:	c7 45 d4 ff ff ff ff 	movl   $0xffffffff,-0x2c(%ebp)
  printf(1, "\nExecuting setuid() test.\n\n");
     43f:	e8 cc 0b 00 00       	call   1010 <printf>
  startuid = uid = getuid();
     444:	e8 b8 0a 00 00       	call   f01 <getuid>
  testuid = ++uid;
     449:	8d 58 01             	lea    0x1(%eax),%ebx
  startuid = uid = getuid();
     44c:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  rc = setuid(testuid);
     44f:	89 1c 24             	mov    %ebx,(%esp)
     452:	e8 b2 0a 00 00       	call   f09 <setuid>
  if (rc) {
     457:	83 c4 10             	add    $0x10,%esp
     45a:	85 c0                	test   %eax,%eax
     45c:	0f 85 8c 02 00 00    	jne    6ee <main+0x6ee>
  uid = getuid();
     462:	e8 9a 0a 00 00       	call   f01 <getuid>
  if (uid != testuid) {
     467:	39 c3                	cmp    %eax,%ebx
     469:	0f 85 1a 03 00 00    	jne    789 <main+0x789>
     46f:	8d 5d cc             	lea    -0x34(%ebp),%ebx
    rc = setuid(baduids[i]);
     472:	8b 33                	mov    (%ebx),%esi
     474:	83 ec 0c             	sub    $0xc,%esp
     477:	56                   	push   %esi
     478:	e8 8c 0a 00 00       	call   f09 <setuid>
    if (rc == 0) {
     47d:	83 c4 10             	add    $0x10,%esp
     480:	85 c0                	test   %eax,%eax
     482:	0f 84 61 05 00 00    	je     9e9 <main+0x9e9>
    rc = getuid();
     488:	e8 74 0a 00 00       	call   f01 <getuid>
    if (baduids[i] == rc) {
     48d:	39 c6                	cmp    %eax,%esi
     48f:	0f 84 82 05 00 00    	je     a17 <main+0xa17>
     495:	83 c3 04             	add    $0x4,%ebx
  for (i=0; i<baduidcount; i++) {
     498:	8d 45 d8             	lea    -0x28(%ebp),%eax
     49b:	39 c3                	cmp    %eax,%ebx
     49d:	75 d3                	jne    472 <main+0x472>
  setuid(startuid);
     49f:	83 ec 0c             	sub    $0xc,%esp
     4a2:	ff 75 a4             	pushl  -0x5c(%ebp)
     4a5:	e8 5f 0a 00 00       	call   f09 <setuid>
  printf(1, "Test Passed\n");
     4aa:	e9 13 fe ff ff       	jmp    2c2 <main+0x2c2>
     4af:	90                   	nop
    }

    if (done) break;
  }

  printf(1, "\nDone for now\n");
     4b0:	83 ec 08             	sub    $0x8,%esp
     4b3:	68 0e 14 00 00       	push   $0x140e
     4b8:	6a 01                	push   $0x1
     4ba:	e8 51 0b 00 00       	call   1010 <printf>
  free(buf);
     4bf:	89 3c 24             	mov    %edi,(%esp)
     4c2:	e8 19 0d 00 00       	call   11e0 <free>
  exit();
     4c7:	e8 75 09 00 00       	call   e41 <exit>
     4cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  printf(1, "\nTesting the set uid bit.\n\n");
     4d0:	83 ec 08             	sub    $0x8,%esp
  char *test[] = {"UID match", "GID match", "Other", "Should Fail"};
     4d3:	c7 45 bc e5 13 00 00 	movl   $0x13e5,-0x44(%ebp)
  printf(1, "\nTesting the set uid bit.\n\n");
     4da:	68 d8 15 00 00       	push   $0x15d8
     4df:	6a 01                	push   $0x1
  char *test[] = {"UID match", "GID match", "Other", "Should Fail"};
     4e1:	c7 45 c0 bc 15 00 00 	movl   $0x15bc,-0x40(%ebp)
     4e8:	c7 45 c4 c6 15 00 00 	movl   $0x15c6,-0x3c(%ebp)
     4ef:	c7 45 c8 cc 15 00 00 	movl   $0x15cc,-0x38(%ebp)
  printf(1, "\nTesting the set uid bit.\n\n");
     4f6:	e8 15 0b 00 00       	call   1010 <printf>
  for (i=0; i<NUMPERMSTOCHECK; i++) {
     4fb:	a1 f0 1f 00 00       	mov    0x1ff0,%eax
     500:	83 c4 10             	add    $0x10,%esp
     503:	85 c0                	test   %eax,%eax
     505:	0f 8e a7 01 00 00    	jle    6b2 <main+0x6b2>
     50b:	bb a0 1f 00 00       	mov    $0x1fa0,%ebx
     510:	b8 e5 13 00 00       	mov    $0x13e5,%eax
     515:	31 f6                	xor    %esi,%esi
     517:	e9 de 00 00 00       	jmp    5fa <main+0x5fa>
     51c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    check(setgid(testperms[i][procgid]));
     520:	83 ec 0c             	sub    $0xc,%esp
     523:	ff 73 04             	pushl  0x4(%ebx)
     526:	e8 ce 09 00 00       	call   ef9 <setgid>
     52b:	83 c4 10             	add    $0x10,%esp
     52e:	85 c0                	test   %eax,%eax
     530:	0f 85 40 03 00 00    	jne    876 <main+0x876>
    printf(1, "Process uid: %d, gid: %d\n", getuid(), getgid());
     536:	e8 b6 09 00 00       	call   ef1 <getgid>
     53b:	89 45 a4             	mov    %eax,-0x5c(%ebp)
     53e:	e8 be 09 00 00       	call   f01 <getuid>
     543:	8b 55 a4             	mov    -0x5c(%ebp),%edx
     546:	52                   	push   %edx
     547:	50                   	push   %eax
     548:	68 08 16 00 00       	push   $0x1608
     54d:	6a 01                	push   $0x1
     54f:	e8 bc 0a 00 00       	call   1010 <printf>
    check(chown(cmd[0], testperms[i][fileuid]));
     554:	58                   	pop    %eax
     555:	5a                   	pop    %edx
     556:	ff 73 08             	pushl  0x8(%ebx)
     559:	ff 75 b4             	pushl  -0x4c(%ebp)
     55c:	e8 d8 09 00 00       	call   f39 <chown>
     561:	83 c4 10             	add    $0x10,%esp
     564:	85 c0                	test   %eax,%eax
     566:	0f 85 24 03 00 00    	jne    890 <main+0x890>
    check(chgrp(cmd[0], testperms[i][filegid]));
     56c:	83 ec 08             	sub    $0x8,%esp
     56f:	ff 73 0c             	pushl  0xc(%ebx)
     572:	ff 75 b4             	pushl  -0x4c(%ebp)
     575:	e8 c7 09 00 00       	call   f41 <chgrp>
     57a:	83 c4 10             	add    $0x10,%esp
     57d:	85 c0                	test   %eax,%eax
     57f:	0f 85 25 03 00 00    	jne    8aa <main+0x8aa>
    printf(1, "File uid: %d, gid: %d\n",
     585:	ff 73 0c             	pushl  0xc(%ebx)
     588:	ff 73 08             	pushl  0x8(%ebx)
     58b:	68 22 16 00 00       	push   $0x1622
     590:	6a 01                	push   $0x1
     592:	e8 79 0a 00 00       	call   1010 <printf>
    check(chmod(cmd[0], perms[i]));
     597:	58                   	pop    %eax
     598:	5a                   	pop    %edx
     599:	ff 34 b5 e0 1f 00 00 	pushl  0x1fe0(,%esi,4)
     5a0:	ff 75 b4             	pushl  -0x4c(%ebp)
     5a3:	e8 89 09 00 00       	call   f31 <chmod>
     5a8:	83 c4 10             	add    $0x10,%esp
     5ab:	85 c0                	test   %eax,%eax
     5ad:	0f 85 11 03 00 00    	jne    8c4 <main+0x8c4>
    printf(1, "perms set to %d for %s\n", perms[i], cmd[0]);
     5b3:	ff 75 b4             	pushl  -0x4c(%ebp)
     5b6:	ff 34 b5 e0 1f 00 00 	pushl  0x1fe0(,%esi,4)
     5bd:	68 39 16 00 00       	push   $0x1639
     5c2:	6a 01                	push   $0x1
     5c4:	e8 47 0a 00 00       	call   1010 <printf>
    rc = fork();
     5c9:	e8 6b 08 00 00       	call   e39 <fork>
    if (rc < 0) {    // fork failed
     5ce:	83 c4 10             	add    $0x10,%esp
     5d1:	85 c0                	test   %eax,%eax
     5d3:	0f 88 05 03 00 00    	js     8de <main+0x8de>
    if (rc == 0) {   // child
     5d9:	0f 84 80 04 00 00    	je     a5f <main+0xa5f>
    wait();
     5df:	e8 65 08 00 00       	call   e49 <wait>
  for (i=0; i<NUMPERMSTOCHECK; i++) {
     5e4:	83 c6 01             	add    $0x1,%esi
     5e7:	83 c3 10             	add    $0x10,%ebx
     5ea:	3b 35 f0 1f 00 00    	cmp    0x1ff0,%esi
     5f0:	0f 8d bc 00 00 00    	jge    6b2 <main+0x6b2>
     5f6:	8b 44 b5 bc          	mov    -0x44(%ebp,%esi,4),%eax
    printf(1, "Starting test: %s.\n", test[i]);
     5fa:	83 ec 04             	sub    $0x4,%esp
     5fd:	50                   	push   %eax
     5fe:	68 f4 15 00 00       	push   $0x15f4
     603:	6a 01                	push   $0x1
     605:	e8 06 0a 00 00       	call   1010 <printf>
    check(setuid(testperms[i][procuid]));
     60a:	58                   	pop    %eax
     60b:	ff 33                	pushl  (%ebx)
     60d:	e8 f7 08 00 00       	call   f09 <setuid>
     612:	83 c4 10             	add    $0x10,%esp
     615:	85 c0                	test   %eax,%eax
     617:	0f 84 03 ff ff ff    	je     520 <main+0x520>
     61d:	53                   	push   %ebx
     61e:	68 75 15 00 00       	push   $0x1575
     623:	68 b5 14 00 00       	push   $0x14b5
     628:	6a 02                	push   $0x2
     62a:	e8 e1 09 00 00       	call   1010 <printf>
      case 7: doTest(doSetuidTest, t1); break;
     62f:	83 c4 10             	add    $0x10,%esp
     632:	50                   	push   %eax
     633:	68 51 16 00 00       	push   $0x1651
     638:	68 50 14 00 00       	push   $0x1450
     63d:	6a 02                	push   $0x2
     63f:	e8 cc 09 00 00       	call   1010 <printf>
     644:	e8 f8 07 00 00       	call   e41 <exit>
     649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "Error:invalid test number.\n");
     650:	83 ec 08             	sub    $0x8,%esp
     653:	68 5e 16 00 00       	push   $0x165e
     658:	6a 01                	push   $0x1
     65a:	e8 b1 09 00 00       	call   1010 <printf>
     65f:	83 c4 10             	add    $0x10,%esp
     662:	e9 c1 f9 ff ff       	jmp    28 <main+0x28>
    if (st.mode.flags.u_x)
     667:	80 e2 40             	and    $0x40,%dl
     66a:	0f 85 66 fa ff ff    	jne    d6 <main+0xd6>
      printf(2, "UID match. Execute permission for user not set.\n");
     670:	52                   	push   %edx
     671:	52                   	push   %edx
     672:	68 38 1a 00 00       	push   $0x1a38
     677:	6a 02                	push   $0x2
     679:	e8 92 09 00 00       	call   1010 <printf>
      return FALSE;
     67e:	83 c4 10             	add    $0x10,%esp
     681:	e9 3a 01 00 00       	jmp    7c0 <main+0x7c0>
  check(stat(cmd[0], &st));
     686:	50                   	push   %eax
     687:	68 a3 14 00 00       	push   $0x14a3
     68c:	68 b5 14 00 00       	push   $0x14b5
     691:	6a 02                	push   $0x2
     693:	e8 78 09 00 00       	call   1010 <printf>
      case 3: doTest(doChmodTest,  t1); break;
     698:	83 c4 10             	add    $0x10,%esp
     69b:	50                   	push   %eax
     69c:	68 f7 14 00 00       	push   $0x14f7
     6a1:	68 50 14 00 00       	push   $0x1450
     6a6:	6a 02                	push   $0x2
     6a8:	e8 63 09 00 00       	call   1010 <printf>
     6ad:	e8 8f 07 00 00       	call   e41 <exit>
  chmod(cmd[0], 00755);  // total hack but necessary. sigh
     6b2:	53                   	push   %ebx
     6b3:	53                   	push   %ebx
     6b4:	68 ed 01 00 00       	push   $0x1ed
     6b9:	ff 75 b4             	pushl  -0x4c(%ebp)
     6bc:	e8 70 08 00 00       	call   f31 <chmod>
     6c1:	e9 fc fb ff ff       	jmp    2c2 <main+0x2c2>
    printf(2, "Error! chgrp() failed on setting new group.\n");
     6c6:	50                   	push   %eax
     6c7:	50                   	push   %eax
     6c8:	68 c8 19 00 00       	push   $0x19c8
     6cd:	6a 02                	push   $0x2
     6cf:	e8 3c 09 00 00       	call   1010 <printf>
      case 5: doTest(doChgrpTest,  t1); break;
     6d4:	83 c4 10             	add    $0x10,%esp
     6d7:	51                   	push   %ecx
     6d8:	68 41 15 00 00       	push   $0x1541
     6dd:	68 50 14 00 00       	push   $0x1450
     6e2:	6a 02                	push   $0x2
     6e4:	e8 27 09 00 00       	call   1010 <printf>
     6e9:	e8 53 07 00 00       	call   e41 <exit>
    printf(2, "setuid system call reports an error.\n");
     6ee:	53                   	push   %ebx
     6ef:	53                   	push   %ebx
     6f0:	68 7c 16 00 00       	push   $0x167c
     6f5:	6a 02                	push   $0x2
     6f7:	e8 14 09 00 00       	call   1010 <printf>
      case 1: doTest(doUidTest,    t0); break;
     6fc:	83 c4 10             	add    $0x10,%esp
     6ff:	50                   	push   %eax
     700:	68 46 14 00 00       	push   $0x1446
     705:	68 50 14 00 00       	push   $0x1450
     70a:	6a 02                	push   $0x2
     70c:	e8 ff 08 00 00       	call   1010 <printf>
     711:	e8 2b 07 00 00       	call   e41 <exit>
    printf(2, "Error! chown() failed on setting new owner. %d as rc.\n", rc);
     716:	52                   	push   %edx
     717:	50                   	push   %eax
     718:	68 50 19 00 00       	push   $0x1950
     71d:	6a 02                	push   $0x2
     71f:	e8 ec 08 00 00       	call   1010 <printf>
      case 4: doTest(doChownTest,  t1); break;
     724:	83 c4 10             	add    $0x10,%esp
     727:	57                   	push   %edi
     728:	68 1c 15 00 00       	push   $0x151c
     72d:	68 50 14 00 00       	push   $0x1450
     732:	6a 02                	push   $0x2
     734:	e8 d7 08 00 00       	call   1010 <printf>
     739:	e8 03 07 00 00       	call   e41 <exit>
    printf(2, "setgid system call reports an error.\n");
     73e:	50                   	push   %eax
     73f:	50                   	push   %eax
     740:	68 c8 17 00 00       	push   $0x17c8
     745:	6a 02                	push   $0x2
     747:	e8 c4 08 00 00       	call   1010 <printf>
      case 2: doTest(doGidTest,    t0); break;
     74c:	83 c4 10             	add    $0x10,%esp
     74f:	51                   	push   %ecx
     750:	68 7e 14 00 00       	push   $0x147e
     755:	68 50 14 00 00       	push   $0x1450
     75a:	6a 02                	push   $0x2
     75c:	e8 af 08 00 00       	call   1010 <printf>
     761:	e8 db 06 00 00       	call   e41 <exit>
    printf(2, "ERROR! setgid claims to have worked but really didn't!\n");
     766:	57                   	push   %edi
     767:	89 c6                	mov    %eax,%esi
     769:	57                   	push   %edi
     76a:	68 f0 17 00 00       	push   $0x17f0
     76f:	6a 02                	push   $0x2
     771:	e8 9a 08 00 00       	call   1010 <printf>
    printf(2, "gid should be %d but is instead %d\n", testgid, gid);
     776:	56                   	push   %esi
     777:	53                   	push   %ebx
     778:	68 28 18 00 00       	push   $0x1828
     77d:	6a 02                	push   $0x2
     77f:	e8 8c 08 00 00       	call   1010 <printf>
      case 2: doTest(doGidTest,    t0); break;
     784:	83 c4 20             	add    $0x20,%esp
     787:	eb c6                	jmp    74f <main+0x74f>
    printf(2, "ERROR! setuid claims to have worked but really didn't!\n");
     789:	51                   	push   %ecx
     78a:	89 c6                	mov    %eax,%esi
     78c:	51                   	push   %ecx
     78d:	68 a4 16 00 00       	push   $0x16a4
     792:	6a 02                	push   $0x2
     794:	e8 77 08 00 00       	call   1010 <printf>
    printf(2, "uid should be %d but is instead %d\n", testuid, uid);
     799:	56                   	push   %esi
     79a:	53                   	push   %ebx
     79b:	68 dc 16 00 00       	push   $0x16dc
     7a0:	6a 02                	push   $0x2
     7a2:	e8 69 08 00 00       	call   1010 <printf>
      case 1: doTest(doUidTest,    t0); break;
     7a7:	83 c4 20             	add    $0x20,%esp
     7aa:	e9 50 ff ff ff       	jmp    6ff <main+0x6ff>
  printf(2, "Execute permission for other not set.\n");
     7af:	50                   	push   %eax
     7b0:	50                   	push   %eax
     7b1:	68 a0 1a 00 00       	push   $0x1aa0
     7b6:	6a 02                	push   $0x2
     7b8:	e8 53 08 00 00       	call   1010 <printf>
  return FALSE;  // failure. Can't run
     7bd:	83 c4 10             	add    $0x10,%esp
    printf(2, "Unable to run %s. test aborted.\n", cmd[0]);
     7c0:	50                   	push   %eax
     7c1:	ff 75 b4             	pushl  -0x4c(%ebp)
     7c4:	68 c8 1a 00 00       	push   $0x1ac8
     7c9:	6a 02                	push   $0x2
     7cb:	e8 40 08 00 00       	call   1010 <printf>
      case 6: doTest(doExecTest,   t1); break;
     7d0:	83 c4 10             	add    $0x10,%esp
     7d3:	50                   	push   %eax
     7d4:	68 b1 15 00 00       	push   $0x15b1
     7d9:	68 50 14 00 00       	push   $0x1450
     7de:	6a 02                	push   $0x2
     7e0:	e8 2b 08 00 00       	call   1010 <printf>
     7e5:	e8 57 06 00 00       	call   e41 <exit>
    printf(2, "Error! test failed. Old uid: %d, new uid: uid2, should differ\n",
     7ea:	53                   	push   %ebx
     7eb:	53                   	push   %ebx
     7ec:	68 88 19 00 00       	push   $0x1988
     7f1:	6a 02                	push   $0x2
     7f3:	e8 18 08 00 00       	call   1010 <printf>
      case 4: doTest(doChownTest,  t1); break;
     7f8:	83 c4 10             	add    $0x10,%esp
     7fb:	e9 27 ff ff ff       	jmp    727 <main+0x727>
    printf(2, "Error! test failed. Old gid: %d, new gid: gid2, should differ\n",
     800:	53                   	push   %ebx
     801:	53                   	push   %ebx
     802:	68 f8 19 00 00       	push   $0x19f8
     807:	6a 02                	push   $0x2
     809:	e8 02 08 00 00       	call   1010 <printf>
      case 5: doTest(doChgrpTest,  t1); break;
     80e:	83 c4 10             	add    $0x10,%esp
     811:	e9 c1 fe ff ff       	jmp    6d7 <main+0x6d7>
  check(stat(name, &st));
     816:	51                   	push   %ecx
     817:	68 65 15 00 00       	push   $0x1565
     81c:	68 b5 14 00 00       	push   $0x14b5
     821:	6a 02                	push   $0x2
     823:	e8 e8 07 00 00       	call   1010 <printf>
     828:	83 c4 10             	add    $0x10,%esp
     82b:	eb 93                	jmp    7c0 <main+0x7c0>
      printf(2, "Error! Unable to test.\n");
     82d:	50                   	push   %eax
     82e:	50                   	push   %eax
     82f:	68 df 14 00 00       	push   $0x14df
     834:	6a 02                	push   $0x2
     836:	e8 d5 07 00 00       	call   1010 <printf>
      printf(2, "\tfile mode (%d) == testmode (%d) for file (%s) in test %d\n",
     83b:	58                   	pop    %eax
     83c:	5a                   	pop    %edx
     83d:	53                   	push   %ebx
     83e:	ff 75 b4             	pushl  -0x4c(%ebp)
     841:	56                   	push   %esi
     842:	56                   	push   %esi
     843:	68 14 19 00 00       	push   $0x1914
     848:	6a 02                	push   $0x2
     84a:	e8 c1 07 00 00       	call   1010 <printf>
      case 3: doTest(doChmodTest,  t1); break;
     84f:	83 c4 20             	add    $0x20,%esp
     852:	e9 44 fe ff ff       	jmp    69b <main+0x69b>
    if (st.mode.flags.g_x)
     857:	80 e2 08             	and    $0x8,%dl
     85a:	0f 85 76 f8 ff ff    	jne    d6 <main+0xd6>
      printf(2, "GID match. Execute permission for group not set.\n");
     860:	50                   	push   %eax
     861:	50                   	push   %eax
     862:	68 6c 1a 00 00       	push   $0x1a6c
     867:	6a 02                	push   $0x2
     869:	e8 a2 07 00 00       	call   1010 <printf>
      return FALSE;
     86e:	83 c4 10             	add    $0x10,%esp
     871:	e9 4a ff ff ff       	jmp    7c0 <main+0x7c0>
    check(setgid(testperms[i][procgid]));
     876:	51                   	push   %ecx
     877:	68 93 15 00 00       	push   $0x1593
     87c:	68 b5 14 00 00       	push   $0x14b5
     881:	6a 02                	push   $0x2
     883:	e8 88 07 00 00       	call   1010 <printf>
      case 7: doTest(doSetuidTest, t1); break;
     888:	83 c4 10             	add    $0x10,%esp
     88b:	e9 a2 fd ff ff       	jmp    632 <main+0x632>
    check(chown(cmd[0], testperms[i][fileuid]));
     890:	53                   	push   %ebx
     891:	68 18 1b 00 00       	push   $0x1b18
     896:	68 b5 14 00 00       	push   $0x14b5
     89b:	6a 02                	push   $0x2
     89d:	e8 6e 07 00 00       	call   1010 <printf>
      case 7: doTest(doSetuidTest, t1); break;
     8a2:	83 c4 10             	add    $0x10,%esp
     8a5:	e9 88 fd ff ff       	jmp    632 <main+0x632>
    check(chgrp(cmd[0], testperms[i][filegid]));
     8aa:	51                   	push   %ecx
     8ab:	68 40 1b 00 00       	push   $0x1b40
     8b0:	68 b5 14 00 00       	push   $0x14b5
     8b5:	6a 02                	push   $0x2
     8b7:	e8 54 07 00 00       	call   1010 <printf>
      case 7: doTest(doSetuidTest, t1); break;
     8bc:	83 c4 10             	add    $0x10,%esp
     8bf:	e9 6e fd ff ff       	jmp    632 <main+0x632>
    check(chmod(cmd[0], perms[i]));
     8c4:	50                   	push   %eax
     8c5:	68 c7 14 00 00       	push   $0x14c7
     8ca:	68 b5 14 00 00       	push   $0x14b5
     8cf:	6a 02                	push   $0x2
     8d1:	e8 3a 07 00 00       	call   1010 <printf>
      case 7: doTest(doSetuidTest, t1); break;
     8d6:	83 c4 10             	add    $0x10,%esp
     8d9:	e9 54 fd ff ff       	jmp    632 <main+0x632>
      printf(2, "The fork() system call failed. That's pretty catastrophic. Ending test\n");
     8de:	50                   	push   %eax
     8df:	50                   	push   %eax
     8e0:	68 c0 1b 00 00       	push   $0x1bc0
     8e5:	6a 02                	push   $0x2
     8e7:	e8 24 07 00 00       	call   1010 <printf>
      case 7: doTest(doSetuidTest, t1); break;
     8ec:	83 c4 10             	add    $0x10,%esp
     8ef:	e9 3e fd ff ff       	jmp    632 <main+0x632>
  check(stat(cmd[0], &st));
     8f4:	50                   	push   %eax
     8f5:	68 a3 14 00 00       	push   $0x14a3
     8fa:	68 b5 14 00 00       	push   $0x14b5
     8ff:	6a 02                	push   $0x2
     901:	e8 0a 07 00 00       	call   1010 <printf>
      case 6: doTest(doExecTest,   t1); break;
     906:	83 c4 10             	add    $0x10,%esp
     909:	e9 c5 fe ff ff       	jmp    7d3 <main+0x7d3>
  chown(cmd[0], uid);
     90e:	50                   	push   %eax
     90f:	50                   	push   %eax
  uid = st.uid;
     910:	0f b7 45 a4          	movzwl -0x5c(%ebp),%eax
  chown(cmd[0], uid);
     914:	50                   	push   %eax
     915:	ff 75 b4             	pushl  -0x4c(%ebp)
     918:	e8 1c 06 00 00       	call   f39 <chown>
  chgrp(cmd[0], gid);
     91d:	58                   	pop    %eax
  gid = st.gid;
     91e:	0f b7 45 a2          	movzwl -0x5e(%ebp),%eax
  chgrp(cmd[0], gid);
     922:	5a                   	pop    %edx
     923:	50                   	push   %eax
     924:	ff 75 b4             	pushl  -0x4c(%ebp)
     927:	e8 15 06 00 00       	call   f41 <chgrp>
  chmod(cmd[0], 00755);
     92c:	59                   	pop    %ecx
     92d:	5b                   	pop    %ebx
     92e:	68 ed 01 00 00       	push   $0x1ed
     933:	ff 75 b4             	pushl  -0x4c(%ebp)
     936:	e8 f6 05 00 00       	call   f31 <chmod>
  printf(1, "Requires user visually confirms PASS/FAIL\n");
     93b:	5e                   	pop    %esi
     93c:	58                   	pop    %eax
     93d:	68 ec 1a 00 00       	push   $0x1aec
     942:	6a 01                	push   $0x1
     944:	e8 c7 06 00 00       	call   1010 <printf>
      case 6: doTest(doExecTest,   t1); break;
     949:	83 c4 10             	add    $0x10,%esp
     94c:	e9 d7 f6 ff ff       	jmp    28 <main+0x28>
    check(setuid(testperms[i][procuid]));
     951:	56                   	push   %esi
     952:	68 75 15 00 00       	push   $0x1575
     957:	68 b5 14 00 00       	push   $0x14b5
     95c:	6a 02                	push   $0x2
     95e:	e8 ad 06 00 00       	call   1010 <printf>
      case 6: doTest(doExecTest,   t1); break;
     963:	83 c4 10             	add    $0x10,%esp
     966:	e9 68 fe ff ff       	jmp    7d3 <main+0x7d3>
    check(setgid(testperms[i][procgid]));
     96b:	53                   	push   %ebx
     96c:	68 93 15 00 00       	push   $0x1593
     971:	68 b5 14 00 00       	push   $0x14b5
     976:	6a 02                	push   $0x2
     978:	e8 93 06 00 00       	call   1010 <printf>
      case 6: doTest(doExecTest,   t1); break;
     97d:	83 c4 10             	add    $0x10,%esp
     980:	e9 4e fe ff ff       	jmp    7d3 <main+0x7d3>
    check(chown(cmd[0], testperms[i][fileuid]));
     985:	51                   	push   %ecx
     986:	68 18 1b 00 00       	push   $0x1b18
     98b:	68 b5 14 00 00       	push   $0x14b5
     990:	6a 02                	push   $0x2
     992:	e8 79 06 00 00       	call   1010 <printf>
      case 6: doTest(doExecTest,   t1); break;
     997:	83 c4 10             	add    $0x10,%esp
     99a:	e9 34 fe ff ff       	jmp    7d3 <main+0x7d3>
    check(chgrp(cmd[0], testperms[i][filegid]));
     99f:	52                   	push   %edx
     9a0:	68 40 1b 00 00       	push   $0x1b40
     9a5:	68 b5 14 00 00       	push   $0x14b5
     9aa:	6a 02                	push   $0x2
     9ac:	e8 5f 06 00 00       	call   1010 <printf>
      case 6: doTest(doExecTest,   t1); break;
     9b1:	83 c4 10             	add    $0x10,%esp
     9b4:	e9 1a fe ff ff       	jmp    7d3 <main+0x7d3>
    check(chmod(cmd[0], perms[i]));
     9b9:	50                   	push   %eax
     9ba:	68 c7 14 00 00       	push   $0x14c7
     9bf:	68 b5 14 00 00       	push   $0x14b5
     9c4:	6a 02                	push   $0x2
     9c6:	e8 45 06 00 00       	call   1010 <printf>
      case 6: doTest(doExecTest,   t1); break;
     9cb:	83 c4 10             	add    $0x10,%esp
     9ce:	e9 00 fe ff ff       	jmp    7d3 <main+0x7d3>
      printf(2, "The fork() system call failed. That's pretty catastrophic. Ending test\n");
     9d3:	50                   	push   %eax
     9d4:	50                   	push   %eax
     9d5:	68 c0 1b 00 00       	push   $0x1bc0
     9da:	6a 02                	push   $0x2
     9dc:	e8 2f 06 00 00       	call   1010 <printf>
      case 6: doTest(doExecTest,   t1); break;
     9e1:	83 c4 10             	add    $0x10,%esp
     9e4:	e9 ea fd ff ff       	jmp    7d3 <main+0x7d3>
      printf(2, "Tried to set the uid to a bad value (%d) and setuid()failed to fail. rc == %d\n",
     9e9:	6a 00                	push   $0x0
     9eb:	56                   	push   %esi
     9ec:	68 00 17 00 00       	push   $0x1700
     9f1:	6a 02                	push   $0x2
     9f3:	e8 18 06 00 00       	call   1010 <printf>
      case 1: doTest(doUidTest,    t0); break;
     9f8:	83 c4 10             	add    $0x10,%esp
     9fb:	e9 ff fc ff ff       	jmp    6ff <main+0x6ff>
      printf(2, "Tried to set the gid to a bad value (%d) and setgid()failed to fail. rc == %d\n",
     a00:	6a 00                	push   $0x0
     a02:	56                   	push   %esi
     a03:	68 4c 18 00 00       	push   $0x184c
     a08:	6a 02                	push   $0x2
     a0a:	e8 01 06 00 00       	call   1010 <printf>
      case 2: doTest(doGidTest,    t0); break;
     a0f:	83 c4 10             	add    $0x10,%esp
     a12:	e9 38 fd ff ff       	jmp    74f <main+0x74f>
      printf(2, "ERROR! Gave setuid() a bad value (%d) and it failed to fail. gid: %d\n",
     a17:	56                   	push   %esi
     a18:	56                   	push   %esi
     a19:	68 50 17 00 00       	push   $0x1750
     a1e:	6a 02                	push   $0x2
     a20:	e8 eb 05 00 00       	call   1010 <printf>
      printf(2, "Valid UIDs are in the range [0, 32767] only!\n");
     a25:	58                   	pop    %eax
     a26:	5a                   	pop    %edx
     a27:	68 98 17 00 00       	push   $0x1798
     a2c:	6a 02                	push   $0x2
     a2e:	e8 dd 05 00 00       	call   1010 <printf>
      case 1: doTest(doUidTest,    t0); break;
     a33:	83 c4 10             	add    $0x10,%esp
     a36:	e9 c4 fc ff ff       	jmp    6ff <main+0x6ff>
      printf(2, "ERROR! Gave setgid() a bad value (%d) and it failed to fail. gid: %d\n",
     a3b:	56                   	push   %esi
     a3c:	56                   	push   %esi
     a3d:	68 9c 18 00 00       	push   $0x189c
     a42:	6a 02                	push   $0x2
     a44:	e8 c7 05 00 00       	call   1010 <printf>
      printf(2, "Valid GIDs are in the range [0, 32767] only!\n");
     a49:	5b                   	pop    %ebx
     a4a:	5e                   	pop    %esi
     a4b:	68 e4 18 00 00       	push   $0x18e4
     a50:	6a 02                	push   $0x2
     a52:	e8 b9 05 00 00       	call   1010 <printf>
      case 2: doTest(doGidTest,    t0); break;
     a57:	83 c4 10             	add    $0x10,%esp
     a5a:	e9 f0 fc ff ff       	jmp    74f <main+0x74f>
      exec(cmd[0], cmd);
     a5f:	8d 45 b4             	lea    -0x4c(%ebp),%eax
     a62:	57                   	push   %edi
     a63:	57                   	push   %edi
     a64:	50                   	push   %eax
     a65:	ff 75 b4             	pushl  -0x4c(%ebp)
     a68:	e8 0c 04 00 00       	call   e79 <exec>
      if (i != NUMPERMSTOCHECK-1) printf(2, "**** exec call for %s **FAILED**.\n",  cmd[0]);
     a6d:	a1 f0 1f 00 00       	mov    0x1ff0,%eax
     a72:	83 c4 10             	add    $0x10,%esp
     a75:	83 e8 01             	sub    $0x1,%eax
     a78:	39 f0                	cmp    %esi,%eax
     a7a:	74 18                	je     a94 <main+0xa94>
     a7c:	56                   	push   %esi
     a7d:	ff 75 b4             	pushl  -0x4c(%ebp)
     a80:	68 08 1c 00 00       	push   $0x1c08
     a85:	6a 02                	push   $0x2
     a87:	e8 84 05 00 00       	call   1010 <printf>
     a8c:	83 c4 10             	add    $0x10,%esp
      exit();
     a8f:	e8 ad 03 00 00       	call   e41 <exit>
      else printf(2, "**** exec call for %s **FAILED as expected.\n", cmd[0]);
     a94:	50                   	push   %eax
     a95:	ff 75 b4             	pushl  -0x4c(%ebp)
     a98:	68 2c 1c 00 00       	push   $0x1c2c
     a9d:	6a 02                	push   $0x2
     a9f:	e8 6c 05 00 00       	call   1010 <printf>
     aa4:	83 c4 10             	add    $0x10,%esp
     aa7:	eb e6                	jmp    a8f <main+0xa8f>
     aa9:	66 90                	xchg   %ax,%ax
     aab:	66 90                	xchg   %ax,%ax
     aad:	66 90                	xchg   %ax,%ax
     aaf:	90                   	nop

00000ab0 <printMenu>:
{
     ab0:	55                   	push   %ebp
     ab1:	89 e5                	mov    %esp,%ebp
     ab3:	83 ec 10             	sub    $0x10,%esp
  printf(1, "\n");
     ab6:	68 f2 15 00 00       	push   $0x15f2
     abb:	6a 01                	push   $0x1
     abd:	e8 4e 05 00 00       	call   1010 <printf>
  printf(1, "%d. exit program\n", i++);
     ac2:	83 c4 0c             	add    $0xc,%esp
     ac5:	6a 00                	push   $0x0
     ac7:	68 78 13 00 00       	push   $0x1378
     acc:	6a 01                	push   $0x1
     ace:	e8 3d 05 00 00       	call   1010 <printf>
  printf(1, "%d. Proc UID\n", i++);
     ad3:	83 c4 0c             	add    $0xc,%esp
     ad6:	6a 01                	push   $0x1
     ad8:	68 8a 13 00 00       	push   $0x138a
     add:	6a 01                	push   $0x1
     adf:	e8 2c 05 00 00       	call   1010 <printf>
  printf(1, "%d. Proc GID\n", i++);
     ae4:	83 c4 0c             	add    $0xc,%esp
     ae7:	6a 02                	push   $0x2
     ae9:	68 98 13 00 00       	push   $0x1398
     aee:	6a 01                	push   $0x1
     af0:	e8 1b 05 00 00       	call   1010 <printf>
  printf(1, "%d. chmod()\n", i++);
     af5:	83 c4 0c             	add    $0xc,%esp
     af8:	6a 03                	push   $0x3
     afa:	68 a6 13 00 00       	push   $0x13a6
     aff:	6a 01                	push   $0x1
     b01:	e8 0a 05 00 00       	call   1010 <printf>
  printf(1, "%d. chown()\n", i++);
     b06:	83 c4 0c             	add    $0xc,%esp
     b09:	6a 04                	push   $0x4
     b0b:	68 b3 13 00 00       	push   $0x13b3
     b10:	6a 01                	push   $0x1
     b12:	e8 f9 04 00 00       	call   1010 <printf>
  printf(1, "%d. chgrp()\n", i++);
     b17:	83 c4 0c             	add    $0xc,%esp
     b1a:	6a 05                	push   $0x5
     b1c:	68 c0 13 00 00       	push   $0x13c0
     b21:	6a 01                	push   $0x1
     b23:	e8 e8 04 00 00       	call   1010 <printf>
  printf(1, "%d. exec()\n", i++);
     b28:	83 c4 0c             	add    $0xc,%esp
     b2b:	6a 06                	push   $0x6
     b2d:	68 cd 13 00 00       	push   $0x13cd
     b32:	6a 01                	push   $0x1
     b34:	e8 d7 04 00 00       	call   1010 <printf>
  printf(1, "%d. setuid\n", i++);
     b39:	83 c4 0c             	add    $0xc,%esp
     b3c:	6a 07                	push   $0x7
     b3e:	68 d9 13 00 00       	push   $0x13d9
     b43:	6a 01                	push   $0x1
     b45:	e8 c6 04 00 00       	call   1010 <printf>
}
     b4a:	83 c4 10             	add    $0x10,%esp
     b4d:	c9                   	leave  
     b4e:	c3                   	ret    
     b4f:	90                   	nop

00000b50 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     b50:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     b51:	31 d2                	xor    %edx,%edx
{
     b53:	89 e5                	mov    %esp,%ebp
     b55:	53                   	push   %ebx
     b56:	8b 45 08             	mov    0x8(%ebp),%eax
     b59:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
     b60:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
     b64:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     b67:	83 c2 01             	add    $0x1,%edx
     b6a:	84 c9                	test   %cl,%cl
     b6c:	75 f2                	jne    b60 <strcpy+0x10>
    ;
  return os;
}
     b6e:	5b                   	pop    %ebx
     b6f:	5d                   	pop    %ebp
     b70:	c3                   	ret    
     b71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b7f:	90                   	nop

00000b80 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     b80:	55                   	push   %ebp
     b81:	89 e5                	mov    %esp,%ebp
     b83:	56                   	push   %esi
     b84:	53                   	push   %ebx
     b85:	8b 5d 08             	mov    0x8(%ebp),%ebx
     b88:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(*p && *p == *q)
     b8b:	0f b6 13             	movzbl (%ebx),%edx
     b8e:	0f b6 0e             	movzbl (%esi),%ecx
     b91:	84 d2                	test   %dl,%dl
     b93:	74 1e                	je     bb3 <strcmp+0x33>
     b95:	b8 01 00 00 00       	mov    $0x1,%eax
     b9a:	38 ca                	cmp    %cl,%dl
     b9c:	74 09                	je     ba7 <strcmp+0x27>
     b9e:	eb 20                	jmp    bc0 <strcmp+0x40>
     ba0:	83 c0 01             	add    $0x1,%eax
     ba3:	38 ca                	cmp    %cl,%dl
     ba5:	75 19                	jne    bc0 <strcmp+0x40>
     ba7:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     bab:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
     baf:	84 d2                	test   %dl,%dl
     bb1:	75 ed                	jne    ba0 <strcmp+0x20>
     bb3:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
     bb5:	5b                   	pop    %ebx
     bb6:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
     bb7:	29 c8                	sub    %ecx,%eax
}
     bb9:	5d                   	pop    %ebp
     bba:	c3                   	ret    
     bbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     bbf:	90                   	nop
     bc0:	0f b6 c2             	movzbl %dl,%eax
     bc3:	5b                   	pop    %ebx
     bc4:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
     bc5:	29 c8                	sub    %ecx,%eax
}
     bc7:	5d                   	pop    %ebp
     bc8:	c3                   	ret    
     bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000bd0 <strlen>:

uint
strlen(char *s)
{
     bd0:	55                   	push   %ebp
     bd1:	89 e5                	mov    %esp,%ebp
     bd3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     bd6:	80 39 00             	cmpb   $0x0,(%ecx)
     bd9:	74 15                	je     bf0 <strlen+0x20>
     bdb:	31 d2                	xor    %edx,%edx
     bdd:	8d 76 00             	lea    0x0(%esi),%esi
     be0:	83 c2 01             	add    $0x1,%edx
     be3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     be7:	89 d0                	mov    %edx,%eax
     be9:	75 f5                	jne    be0 <strlen+0x10>
    ;
  return n;
}
     beb:	5d                   	pop    %ebp
     bec:	c3                   	ret    
     bed:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
     bf0:	31 c0                	xor    %eax,%eax
}
     bf2:	5d                   	pop    %ebp
     bf3:	c3                   	ret    
     bf4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     bff:	90                   	nop

00000c00 <memset>:

void*
memset(void *dst, int c, uint n)
{
     c00:	55                   	push   %ebp
     c01:	89 e5                	mov    %esp,%ebp
     c03:	57                   	push   %edi
     c04:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     c07:	8b 4d 10             	mov    0x10(%ebp),%ecx
     c0a:	8b 45 0c             	mov    0xc(%ebp),%eax
     c0d:	89 d7                	mov    %edx,%edi
     c0f:	fc                   	cld    
     c10:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     c12:	89 d0                	mov    %edx,%eax
     c14:	5f                   	pop    %edi
     c15:	5d                   	pop    %ebp
     c16:	c3                   	ret    
     c17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c1e:	66 90                	xchg   %ax,%ax

00000c20 <strchr>:

char*
strchr(const char *s, char c)
{
     c20:	55                   	push   %ebp
     c21:	89 e5                	mov    %esp,%ebp
     c23:	53                   	push   %ebx
     c24:	8b 45 08             	mov    0x8(%ebp),%eax
     c27:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
     c2a:	0f b6 18             	movzbl (%eax),%ebx
     c2d:	84 db                	test   %bl,%bl
     c2f:	74 1d                	je     c4e <strchr+0x2e>
     c31:	89 d1                	mov    %edx,%ecx
    if(*s == c)
     c33:	38 d3                	cmp    %dl,%bl
     c35:	75 0d                	jne    c44 <strchr+0x24>
     c37:	eb 17                	jmp    c50 <strchr+0x30>
     c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c40:	38 ca                	cmp    %cl,%dl
     c42:	74 0c                	je     c50 <strchr+0x30>
  for(; *s; s++)
     c44:	83 c0 01             	add    $0x1,%eax
     c47:	0f b6 10             	movzbl (%eax),%edx
     c4a:	84 d2                	test   %dl,%dl
     c4c:	75 f2                	jne    c40 <strchr+0x20>
      return (char*)s;
  return 0;
     c4e:	31 c0                	xor    %eax,%eax
}
     c50:	5b                   	pop    %ebx
     c51:	5d                   	pop    %ebp
     c52:	c3                   	ret    
     c53:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000c60 <gets>:

char*
gets(char *buf, int max)
{
     c60:	55                   	push   %ebp
     c61:	89 e5                	mov    %esp,%ebp
     c63:	57                   	push   %edi
     c64:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     c65:	31 f6                	xor    %esi,%esi
{
     c67:	53                   	push   %ebx
     c68:	89 f3                	mov    %esi,%ebx
     c6a:	83 ec 1c             	sub    $0x1c,%esp
     c6d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
     c70:	eb 2f                	jmp    ca1 <gets+0x41>
     c72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
     c78:	83 ec 04             	sub    $0x4,%esp
     c7b:	8d 45 e7             	lea    -0x19(%ebp),%eax
     c7e:	6a 01                	push   $0x1
     c80:	50                   	push   %eax
     c81:	6a 00                	push   $0x0
     c83:	e8 d1 01 00 00       	call   e59 <read>
    if(cc < 1)
     c88:	83 c4 10             	add    $0x10,%esp
     c8b:	85 c0                	test   %eax,%eax
     c8d:	7e 1c                	jle    cab <gets+0x4b>
      break;
    buf[i++] = c;
     c8f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     c93:	83 c7 01             	add    $0x1,%edi
     c96:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
     c99:	3c 0a                	cmp    $0xa,%al
     c9b:	74 23                	je     cc0 <gets+0x60>
     c9d:	3c 0d                	cmp    $0xd,%al
     c9f:	74 1f                	je     cc0 <gets+0x60>
  for(i=0; i+1 < max; ){
     ca1:	83 c3 01             	add    $0x1,%ebx
     ca4:	89 fe                	mov    %edi,%esi
     ca6:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     ca9:	7c cd                	jl     c78 <gets+0x18>
     cab:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
     cad:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
     cb0:	c6 03 00             	movb   $0x0,(%ebx)
}
     cb3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cb6:	5b                   	pop    %ebx
     cb7:	5e                   	pop    %esi
     cb8:	5f                   	pop    %edi
     cb9:	5d                   	pop    %ebp
     cba:	c3                   	ret    
     cbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     cbf:	90                   	nop
     cc0:	8b 75 08             	mov    0x8(%ebp),%esi
     cc3:	8b 45 08             	mov    0x8(%ebp),%eax
     cc6:	01 de                	add    %ebx,%esi
     cc8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
     cca:	c6 03 00             	movb   $0x0,(%ebx)
}
     ccd:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cd0:	5b                   	pop    %ebx
     cd1:	5e                   	pop    %esi
     cd2:	5f                   	pop    %edi
     cd3:	5d                   	pop    %ebp
     cd4:	c3                   	ret    
     cd5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ce0 <stat>:

int
stat(char *n, struct stat *st)
{
     ce0:	55                   	push   %ebp
     ce1:	89 e5                	mov    %esp,%ebp
     ce3:	56                   	push   %esi
     ce4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     ce5:	83 ec 08             	sub    $0x8,%esp
     ce8:	6a 00                	push   $0x0
     cea:	ff 75 08             	pushl  0x8(%ebp)
     ced:	e8 8f 01 00 00       	call   e81 <open>
  if(fd < 0)
     cf2:	83 c4 10             	add    $0x10,%esp
     cf5:	85 c0                	test   %eax,%eax
     cf7:	78 27                	js     d20 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     cf9:	83 ec 08             	sub    $0x8,%esp
     cfc:	ff 75 0c             	pushl  0xc(%ebp)
     cff:	89 c3                	mov    %eax,%ebx
     d01:	50                   	push   %eax
     d02:	e8 92 01 00 00       	call   e99 <fstat>
  close(fd);
     d07:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     d0a:	89 c6                	mov    %eax,%esi
  close(fd);
     d0c:	e8 58 01 00 00       	call   e69 <close>
  return r;
     d11:	83 c4 10             	add    $0x10,%esp
}
     d14:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d17:	89 f0                	mov    %esi,%eax
     d19:	5b                   	pop    %ebx
     d1a:	5e                   	pop    %esi
     d1b:	5d                   	pop    %ebp
     d1c:	c3                   	ret    
     d1d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     d20:	be ff ff ff ff       	mov    $0xffffffff,%esi
     d25:	eb ed                	jmp    d14 <stat+0x34>
     d27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d2e:	66 90                	xchg   %ax,%ax

00000d30 <atoi>:

#ifdef PDX_XV6
int
atoi(const char *s)
{
     d30:	55                   	push   %ebp
     d31:	89 e5                	mov    %esp,%ebp
     d33:	56                   	push   %esi
     d34:	8b 55 08             	mov    0x8(%ebp),%edx
     d37:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
     d38:	0f b6 0a             	movzbl (%edx),%ecx
     d3b:	80 f9 20             	cmp    $0x20,%cl
     d3e:	75 0b                	jne    d4b <atoi+0x1b>
     d40:	83 c2 01             	add    $0x1,%edx
     d43:	0f b6 0a             	movzbl (%edx),%ecx
     d46:	80 f9 20             	cmp    $0x20,%cl
     d49:	74 f5                	je     d40 <atoi+0x10>
  sign = (*s == '-') ? -1 : 1;
     d4b:	80 f9 2d             	cmp    $0x2d,%cl
     d4e:	74 40                	je     d90 <atoi+0x60>
     d50:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
     d55:	80 f9 2b             	cmp    $0x2b,%cl
     d58:	74 3b                	je     d95 <atoi+0x65>
    s++;
  while('0' <= *s && *s <= '9')
     d5a:	0f be 0a             	movsbl (%edx),%ecx
     d5d:	8d 41 d0             	lea    -0x30(%ecx),%eax
     d60:	3c 09                	cmp    $0x9,%al
     d62:	b8 00 00 00 00       	mov    $0x0,%eax
     d67:	77 1f                	ja     d88 <atoi+0x58>
     d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
     d70:	83 c2 01             	add    $0x1,%edx
     d73:	8d 04 80             	lea    (%eax,%eax,4),%eax
     d76:	8d 44 41 d0          	lea    -0x30(%ecx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     d7a:	0f be 0a             	movsbl (%edx),%ecx
     d7d:	8d 59 d0             	lea    -0x30(%ecx),%ebx
     d80:	80 fb 09             	cmp    $0x9,%bl
     d83:	76 eb                	jbe    d70 <atoi+0x40>
     d85:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
     d88:	5b                   	pop    %ebx
     d89:	5e                   	pop    %esi
     d8a:	5d                   	pop    %ebp
     d8b:	c3                   	ret    
     d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
     d90:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
     d95:	83 c2 01             	add    $0x1,%edx
     d98:	eb c0                	jmp    d5a <atoi+0x2a>
     d9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000da0 <atoo>:

int
atoo(const char *s)
{
     da0:	55                   	push   %ebp
     da1:	89 e5                	mov    %esp,%ebp
     da3:	56                   	push   %esi
     da4:	8b 55 08             	mov    0x8(%ebp),%edx
     da7:	53                   	push   %ebx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
     da8:	0f b6 0a             	movzbl (%edx),%ecx
     dab:	80 f9 20             	cmp    $0x20,%cl
     dae:	75 0b                	jne    dbb <atoo+0x1b>
     db0:	83 c2 01             	add    $0x1,%edx
     db3:	0f b6 0a             	movzbl (%edx),%ecx
     db6:	80 f9 20             	cmp    $0x20,%cl
     db9:	74 f5                	je     db0 <atoo+0x10>
  sign = (*s == '-') ? -1 : 1;
     dbb:	80 f9 2d             	cmp    $0x2d,%cl
     dbe:	74 40                	je     e00 <atoo+0x60>
     dc0:	be 01 00 00 00       	mov    $0x1,%esi
  if (*s == '+'  || *s == '-')
     dc5:	80 f9 2b             	cmp    $0x2b,%cl
     dc8:	74 3b                	je     e05 <atoo+0x65>
    s++;
  while('0' <= *s && *s <= '7')
     dca:	0f be 0a             	movsbl (%edx),%ecx
     dcd:	8d 41 d0             	lea    -0x30(%ecx),%eax
     dd0:	3c 07                	cmp    $0x7,%al
     dd2:	b8 00 00 00 00       	mov    $0x0,%eax
     dd7:	77 1c                	ja     df5 <atoo+0x55>
     dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*8 + *s++ - '0';
     de0:	83 c2 01             	add    $0x1,%edx
     de3:	8d 44 c1 d0          	lea    -0x30(%ecx,%eax,8),%eax
  while('0' <= *s && *s <= '7')
     de7:	0f be 0a             	movsbl (%edx),%ecx
     dea:	8d 59 d0             	lea    -0x30(%ecx),%ebx
     ded:	80 fb 07             	cmp    $0x7,%bl
     df0:	76 ee                	jbe    de0 <atoo+0x40>
     df2:	0f af c6             	imul   %esi,%eax
  return sign*n;
}
     df5:	5b                   	pop    %ebx
     df6:	5e                   	pop    %esi
     df7:	5d                   	pop    %ebp
     df8:	c3                   	ret    
     df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sign = (*s == '-') ? -1 : 1;
     e00:	be ff ff ff ff       	mov    $0xffffffff,%esi
    s++;
     e05:	83 c2 01             	add    $0x1,%edx
     e08:	eb c0                	jmp    dca <atoo+0x2a>
     e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000e10 <memmove>:
}
#endif // PDX_XV6

void*
memmove(void *vdst, void *vsrc, int n)
{
     e10:	55                   	push   %ebp
     e11:	89 e5                	mov    %esp,%ebp
     e13:	57                   	push   %edi
     e14:	8b 55 10             	mov    0x10(%ebp),%edx
     e17:	8b 45 08             	mov    0x8(%ebp),%eax
     e1a:	56                   	push   %esi
     e1b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     e1e:	85 d2                	test   %edx,%edx
     e20:	7e 13                	jle    e35 <memmove+0x25>
     e22:	01 c2                	add    %eax,%edx
  dst = vdst;
     e24:	89 c7                	mov    %eax,%edi
     e26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e2d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
     e30:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
     e31:	39 fa                	cmp    %edi,%edx
     e33:	75 fb                	jne    e30 <memmove+0x20>
  return vdst;
}
     e35:	5e                   	pop    %esi
     e36:	5f                   	pop    %edi
     e37:	5d                   	pop    %ebp
     e38:	c3                   	ret    

00000e39 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     e39:	b8 01 00 00 00       	mov    $0x1,%eax
     e3e:	cd 40                	int    $0x40
     e40:	c3                   	ret    

00000e41 <exit>:
SYSCALL(exit)
     e41:	b8 02 00 00 00       	mov    $0x2,%eax
     e46:	cd 40                	int    $0x40
     e48:	c3                   	ret    

00000e49 <wait>:
SYSCALL(wait)
     e49:	b8 03 00 00 00       	mov    $0x3,%eax
     e4e:	cd 40                	int    $0x40
     e50:	c3                   	ret    

00000e51 <pipe>:
SYSCALL(pipe)
     e51:	b8 04 00 00 00       	mov    $0x4,%eax
     e56:	cd 40                	int    $0x40
     e58:	c3                   	ret    

00000e59 <read>:
SYSCALL(read)
     e59:	b8 05 00 00 00       	mov    $0x5,%eax
     e5e:	cd 40                	int    $0x40
     e60:	c3                   	ret    

00000e61 <write>:
SYSCALL(write)
     e61:	b8 10 00 00 00       	mov    $0x10,%eax
     e66:	cd 40                	int    $0x40
     e68:	c3                   	ret    

00000e69 <close>:
SYSCALL(close)
     e69:	b8 15 00 00 00       	mov    $0x15,%eax
     e6e:	cd 40                	int    $0x40
     e70:	c3                   	ret    

00000e71 <kill>:
SYSCALL(kill)
     e71:	b8 06 00 00 00       	mov    $0x6,%eax
     e76:	cd 40                	int    $0x40
     e78:	c3                   	ret    

00000e79 <exec>:
SYSCALL(exec)
     e79:	b8 07 00 00 00       	mov    $0x7,%eax
     e7e:	cd 40                	int    $0x40
     e80:	c3                   	ret    

00000e81 <open>:
SYSCALL(open)
     e81:	b8 0f 00 00 00       	mov    $0xf,%eax
     e86:	cd 40                	int    $0x40
     e88:	c3                   	ret    

00000e89 <mknod>:
SYSCALL(mknod)
     e89:	b8 11 00 00 00       	mov    $0x11,%eax
     e8e:	cd 40                	int    $0x40
     e90:	c3                   	ret    

00000e91 <unlink>:
SYSCALL(unlink)
     e91:	b8 12 00 00 00       	mov    $0x12,%eax
     e96:	cd 40                	int    $0x40
     e98:	c3                   	ret    

00000e99 <fstat>:
SYSCALL(fstat)
     e99:	b8 08 00 00 00       	mov    $0x8,%eax
     e9e:	cd 40                	int    $0x40
     ea0:	c3                   	ret    

00000ea1 <link>:
SYSCALL(link)
     ea1:	b8 13 00 00 00       	mov    $0x13,%eax
     ea6:	cd 40                	int    $0x40
     ea8:	c3                   	ret    

00000ea9 <mkdir>:
SYSCALL(mkdir)
     ea9:	b8 14 00 00 00       	mov    $0x14,%eax
     eae:	cd 40                	int    $0x40
     eb0:	c3                   	ret    

00000eb1 <chdir>:
SYSCALL(chdir)
     eb1:	b8 09 00 00 00       	mov    $0x9,%eax
     eb6:	cd 40                	int    $0x40
     eb8:	c3                   	ret    

00000eb9 <dup>:
SYSCALL(dup)
     eb9:	b8 0a 00 00 00       	mov    $0xa,%eax
     ebe:	cd 40                	int    $0x40
     ec0:	c3                   	ret    

00000ec1 <getpid>:
SYSCALL(getpid)
     ec1:	b8 0b 00 00 00       	mov    $0xb,%eax
     ec6:	cd 40                	int    $0x40
     ec8:	c3                   	ret    

00000ec9 <sbrk>:
SYSCALL(sbrk)
     ec9:	b8 0c 00 00 00       	mov    $0xc,%eax
     ece:	cd 40                	int    $0x40
     ed0:	c3                   	ret    

00000ed1 <sleep>:
SYSCALL(sleep)
     ed1:	b8 0d 00 00 00       	mov    $0xd,%eax
     ed6:	cd 40                	int    $0x40
     ed8:	c3                   	ret    

00000ed9 <uptime>:
SYSCALL(uptime)
     ed9:	b8 0e 00 00 00       	mov    $0xe,%eax
     ede:	cd 40                	int    $0x40
     ee0:	c3                   	ret    

00000ee1 <halt>:
SYSCALL(halt)
     ee1:	b8 16 00 00 00       	mov    $0x16,%eax
     ee6:	cd 40                	int    $0x40
     ee8:	c3                   	ret    

00000ee9 <date>:
SYSCALL(date)
     ee9:	b8 17 00 00 00       	mov    $0x17,%eax
     eee:	cd 40                	int    $0x40
     ef0:	c3                   	ret    

00000ef1 <getgid>:
SYSCALL(getgid)
     ef1:	b8 18 00 00 00       	mov    $0x18,%eax
     ef6:	cd 40                	int    $0x40
     ef8:	c3                   	ret    

00000ef9 <setgid>:
SYSCALL(setgid)
     ef9:	b8 19 00 00 00       	mov    $0x19,%eax
     efe:	cd 40                	int    $0x40
     f00:	c3                   	ret    

00000f01 <getuid>:
SYSCALL(getuid)
     f01:	b8 1a 00 00 00       	mov    $0x1a,%eax
     f06:	cd 40                	int    $0x40
     f08:	c3                   	ret    

00000f09 <setuid>:
SYSCALL(setuid)
     f09:	b8 1b 00 00 00       	mov    $0x1b,%eax
     f0e:	cd 40                	int    $0x40
     f10:	c3                   	ret    

00000f11 <getppid>:
SYSCALL(getppid)
     f11:	b8 1c 00 00 00       	mov    $0x1c,%eax
     f16:	cd 40                	int    $0x40
     f18:	c3                   	ret    

00000f19 <getprocs>:
SYSCALL(getprocs)
     f19:	b8 1d 00 00 00       	mov    $0x1d,%eax
     f1e:	cd 40                	int    $0x40
     f20:	c3                   	ret    

00000f21 <setpriority>:
SYSCALL(setpriority)
     f21:	b8 1e 00 00 00       	mov    $0x1e,%eax
     f26:	cd 40                	int    $0x40
     f28:	c3                   	ret    

00000f29 <getpriority>:
SYSCALL(getpriority)
     f29:	b8 1f 00 00 00       	mov    $0x1f,%eax
     f2e:	cd 40                	int    $0x40
     f30:	c3                   	ret    

00000f31 <chmod>:
SYSCALL(chmod)
     f31:	b8 20 00 00 00       	mov    $0x20,%eax
     f36:	cd 40                	int    $0x40
     f38:	c3                   	ret    

00000f39 <chown>:
SYSCALL(chown)
     f39:	b8 21 00 00 00       	mov    $0x21,%eax
     f3e:	cd 40                	int    $0x40
     f40:	c3                   	ret    

00000f41 <chgrp>:
SYSCALL(chgrp)
     f41:	b8 22 00 00 00       	mov    $0x22,%eax
     f46:	cd 40                	int    $0x40
     f48:	c3                   	ret    
     f49:	66 90                	xchg   %ax,%ax
     f4b:	66 90                	xchg   %ax,%ax
     f4d:	66 90                	xchg   %ax,%ax
     f4f:	90                   	nop

00000f50 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     f50:	55                   	push   %ebp
     f51:	89 e5                	mov    %esp,%ebp
     f53:	57                   	push   %edi
     f54:	56                   	push   %esi
     f55:	53                   	push   %ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
     f56:	89 d3                	mov    %edx,%ebx
{
     f58:	83 ec 3c             	sub    $0x3c,%esp
     f5b:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
     f5e:	85 d2                	test   %edx,%edx
     f60:	0f 89 92 00 00 00    	jns    ff8 <printint+0xa8>
     f66:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     f6a:	0f 84 88 00 00 00    	je     ff8 <printint+0xa8>
    neg = 1;
     f70:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
     f77:	f7 db                	neg    %ebx
  } else {
    x = xx;
  }

  i = 0;
     f79:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     f80:	8d 75 d7             	lea    -0x29(%ebp),%esi
     f83:	eb 08                	jmp    f8d <printint+0x3d>
     f85:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
     f88:	89 7d c4             	mov    %edi,-0x3c(%ebp)
  }while((x /= base) != 0);
     f8b:	89 c3                	mov    %eax,%ebx
    buf[i++] = digits[x % base];
     f8d:	89 d8                	mov    %ebx,%eax
     f8f:	31 d2                	xor    %edx,%edx
     f91:	8b 7d c4             	mov    -0x3c(%ebp),%edi
     f94:	f7 f1                	div    %ecx
     f96:	83 c7 01             	add    $0x1,%edi
     f99:	0f b6 92 84 1c 00 00 	movzbl 0x1c84(%edx),%edx
     fa0:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
     fa3:	39 d9                	cmp    %ebx,%ecx
     fa5:	76 e1                	jbe    f88 <printint+0x38>
  if(neg)
     fa7:	8b 45 c0             	mov    -0x40(%ebp),%eax
     faa:	85 c0                	test   %eax,%eax
     fac:	74 0d                	je     fbb <printint+0x6b>
    buf[i++] = '-';
     fae:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
     fb3:	ba 2d 00 00 00       	mov    $0x2d,%edx
    buf[i++] = digits[x % base];
     fb8:	89 7d c4             	mov    %edi,-0x3c(%ebp)
     fbb:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     fbe:	8b 7d bc             	mov    -0x44(%ebp),%edi
     fc1:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
     fc5:	eb 0f                	jmp    fd6 <printint+0x86>
     fc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     fce:	66 90                	xchg   %ax,%ax
     fd0:	0f b6 13             	movzbl (%ebx),%edx
     fd3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
     fd6:	83 ec 04             	sub    $0x4,%esp
     fd9:	88 55 d7             	mov    %dl,-0x29(%ebp)
     fdc:	6a 01                	push   $0x1
     fde:	56                   	push   %esi
     fdf:	57                   	push   %edi
     fe0:	e8 7c fe ff ff       	call   e61 <write>

  while(--i >= 0)
     fe5:	83 c4 10             	add    $0x10,%esp
     fe8:	39 de                	cmp    %ebx,%esi
     fea:	75 e4                	jne    fd0 <printint+0x80>
    putc(fd, buf[i]);
}
     fec:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fef:	5b                   	pop    %ebx
     ff0:	5e                   	pop    %esi
     ff1:	5f                   	pop    %edi
     ff2:	5d                   	pop    %ebp
     ff3:	c3                   	ret    
     ff4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
     ff8:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
     fff:	e9 75 ff ff ff       	jmp    f79 <printint+0x29>
    1004:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    100b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    100f:	90                   	nop

00001010 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1010:	55                   	push   %ebp
    1011:	89 e5                	mov    %esp,%ebp
    1013:	57                   	push   %edi
    1014:	56                   	push   %esi
    1015:	53                   	push   %ebx
    1016:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1019:	8b 75 0c             	mov    0xc(%ebp),%esi
    101c:	0f b6 1e             	movzbl (%esi),%ebx
    101f:	84 db                	test   %bl,%bl
    1021:	0f 84 b9 00 00 00    	je     10e0 <printf+0xd0>
  ap = (uint*)(void*)&fmt + 1;
    1027:	8d 45 10             	lea    0x10(%ebp),%eax
    102a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    102d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    1030:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    1032:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1035:	eb 38                	jmp    106f <printf+0x5f>
    1037:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    103e:	66 90                	xchg   %ax,%ax
    1040:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    1043:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    1048:	83 f8 25             	cmp    $0x25,%eax
    104b:	74 17                	je     1064 <printf+0x54>
  write(fd, &c, 1);
    104d:	83 ec 04             	sub    $0x4,%esp
    1050:	88 5d e7             	mov    %bl,-0x19(%ebp)
    1053:	6a 01                	push   $0x1
    1055:	57                   	push   %edi
    1056:	ff 75 08             	pushl  0x8(%ebp)
    1059:	e8 03 fe ff ff       	call   e61 <write>
    105e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    1061:	83 c4 10             	add    $0x10,%esp
    1064:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
    1067:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    106b:	84 db                	test   %bl,%bl
    106d:	74 71                	je     10e0 <printf+0xd0>
    c = fmt[i] & 0xff;
    106f:	0f be cb             	movsbl %bl,%ecx
    1072:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1075:	85 d2                	test   %edx,%edx
    1077:	74 c7                	je     1040 <printf+0x30>
      }
    } else if(state == '%'){
    1079:	83 fa 25             	cmp    $0x25,%edx
    107c:	75 e6                	jne    1064 <printf+0x54>
      if(c == 'd'){
    107e:	83 f8 64             	cmp    $0x64,%eax
    1081:	0f 84 99 00 00 00    	je     1120 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1087:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    108d:	83 f9 70             	cmp    $0x70,%ecx
    1090:	74 5e                	je     10f0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1092:	83 f8 73             	cmp    $0x73,%eax
    1095:	0f 84 d5 00 00 00    	je     1170 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    109b:	83 f8 63             	cmp    $0x63,%eax
    109e:	0f 84 8c 00 00 00    	je     1130 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    10a4:	83 f8 25             	cmp    $0x25,%eax
    10a7:	0f 84 b3 00 00 00    	je     1160 <printf+0x150>
  write(fd, &c, 1);
    10ad:	83 ec 04             	sub    $0x4,%esp
    10b0:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    10b4:	6a 01                	push   $0x1
    10b6:	57                   	push   %edi
    10b7:	ff 75 08             	pushl  0x8(%ebp)
    10ba:	e8 a2 fd ff ff       	call   e61 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    10bf:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    10c2:	83 c4 0c             	add    $0xc,%esp
    10c5:	6a 01                	push   $0x1
    10c7:	83 c6 01             	add    $0x1,%esi
    10ca:	57                   	push   %edi
    10cb:	ff 75 08             	pushl  0x8(%ebp)
    10ce:	e8 8e fd ff ff       	call   e61 <write>
  for(i = 0; fmt[i]; i++){
    10d3:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    10d7:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    10da:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    10dc:	84 db                	test   %bl,%bl
    10de:	75 8f                	jne    106f <printf+0x5f>
    }
  }
}
    10e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10e3:	5b                   	pop    %ebx
    10e4:	5e                   	pop    %esi
    10e5:	5f                   	pop    %edi
    10e6:	5d                   	pop    %ebp
    10e7:	c3                   	ret    
    10e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10ef:	90                   	nop
        printint(fd, *ap, 16, 0);
    10f0:	83 ec 0c             	sub    $0xc,%esp
    10f3:	b9 10 00 00 00       	mov    $0x10,%ecx
    10f8:	6a 00                	push   $0x0
    10fa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    10fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1100:	8b 13                	mov    (%ebx),%edx
    1102:	e8 49 fe ff ff       	call   f50 <printint>
        ap++;
    1107:	89 d8                	mov    %ebx,%eax
    1109:	83 c4 10             	add    $0x10,%esp
      state = 0;
    110c:	31 d2                	xor    %edx,%edx
        ap++;
    110e:	83 c0 04             	add    $0x4,%eax
    1111:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1114:	e9 4b ff ff ff       	jmp    1064 <printf+0x54>
    1119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    1120:	83 ec 0c             	sub    $0xc,%esp
    1123:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1128:	6a 01                	push   $0x1
    112a:	eb ce                	jmp    10fa <printf+0xea>
    112c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    1130:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    1133:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1136:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    1138:	6a 01                	push   $0x1
        ap++;
    113a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    113d:	57                   	push   %edi
    113e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    1141:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1144:	e8 18 fd ff ff       	call   e61 <write>
        ap++;
    1149:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    114c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    114f:	31 d2                	xor    %edx,%edx
    1151:	e9 0e ff ff ff       	jmp    1064 <printf+0x54>
    1156:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    115d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    1160:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1163:	83 ec 04             	sub    $0x4,%esp
    1166:	e9 5a ff ff ff       	jmp    10c5 <printf+0xb5>
    116b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    116f:	90                   	nop
        s = (char*)*ap;
    1170:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1173:	8b 18                	mov    (%eax),%ebx
        ap++;
    1175:	83 c0 04             	add    $0x4,%eax
    1178:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    117b:	85 db                	test   %ebx,%ebx
    117d:	74 17                	je     1196 <printf+0x186>
        while(*s != 0){
    117f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    1182:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    1184:	84 c0                	test   %al,%al
    1186:	0f 84 d8 fe ff ff    	je     1064 <printf+0x54>
    118c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    118f:	89 de                	mov    %ebx,%esi
    1191:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1194:	eb 1a                	jmp    11b0 <printf+0x1a0>
          s = "(null)";
    1196:	bb 7c 1c 00 00       	mov    $0x1c7c,%ebx
        while(*s != 0){
    119b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    119e:	b8 28 00 00 00       	mov    $0x28,%eax
    11a3:	89 de                	mov    %ebx,%esi
    11a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
    11a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11af:	90                   	nop
  write(fd, &c, 1);
    11b0:	83 ec 04             	sub    $0x4,%esp
          s++;
    11b3:	83 c6 01             	add    $0x1,%esi
    11b6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    11b9:	6a 01                	push   $0x1
    11bb:	57                   	push   %edi
    11bc:	53                   	push   %ebx
    11bd:	e8 9f fc ff ff       	call   e61 <write>
        while(*s != 0){
    11c2:	0f b6 06             	movzbl (%esi),%eax
    11c5:	83 c4 10             	add    $0x10,%esp
    11c8:	84 c0                	test   %al,%al
    11ca:	75 e4                	jne    11b0 <printf+0x1a0>
    11cc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
    11cf:	31 d2                	xor    %edx,%edx
    11d1:	e9 8e fe ff ff       	jmp    1064 <printf+0x54>
    11d6:	66 90                	xchg   %ax,%ax
    11d8:	66 90                	xchg   %ax,%ax
    11da:	66 90                	xchg   %ax,%ax
    11dc:	66 90                	xchg   %ax,%ax
    11de:	66 90                	xchg   %ax,%ax

000011e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    11e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11e1:	a1 f4 1f 00 00       	mov    0x1ff4,%eax
{
    11e6:	89 e5                	mov    %esp,%ebp
    11e8:	57                   	push   %edi
    11e9:	56                   	push   %esi
    11ea:	53                   	push   %ebx
    11eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    11ee:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
    11f0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11f3:	39 c8                	cmp    %ecx,%eax
    11f5:	73 19                	jae    1210 <free+0x30>
    11f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11fe:	66 90                	xchg   %ax,%ax
    1200:	39 d1                	cmp    %edx,%ecx
    1202:	72 14                	jb     1218 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1204:	39 d0                	cmp    %edx,%eax
    1206:	73 10                	jae    1218 <free+0x38>
{
    1208:	89 d0                	mov    %edx,%eax
    120a:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    120c:	39 c8                	cmp    %ecx,%eax
    120e:	72 f0                	jb     1200 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1210:	39 d0                	cmp    %edx,%eax
    1212:	72 f4                	jb     1208 <free+0x28>
    1214:	39 d1                	cmp    %edx,%ecx
    1216:	73 f0                	jae    1208 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1218:	8b 73 fc             	mov    -0x4(%ebx),%esi
    121b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    121e:	39 fa                	cmp    %edi,%edx
    1220:	74 1e                	je     1240 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1222:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1225:	8b 50 04             	mov    0x4(%eax),%edx
    1228:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    122b:	39 f1                	cmp    %esi,%ecx
    122d:	74 28                	je     1257 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    122f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
    1231:	5b                   	pop    %ebx
  freep = p;
    1232:	a3 f4 1f 00 00       	mov    %eax,0x1ff4
}
    1237:	5e                   	pop    %esi
    1238:	5f                   	pop    %edi
    1239:	5d                   	pop    %ebp
    123a:	c3                   	ret    
    123b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    123f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
    1240:	03 72 04             	add    0x4(%edx),%esi
    1243:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1246:	8b 10                	mov    (%eax),%edx
    1248:	8b 12                	mov    (%edx),%edx
    124a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    124d:	8b 50 04             	mov    0x4(%eax),%edx
    1250:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1253:	39 f1                	cmp    %esi,%ecx
    1255:	75 d8                	jne    122f <free+0x4f>
    p->s.size += bp->s.size;
    1257:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    125a:	a3 f4 1f 00 00       	mov    %eax,0x1ff4
    p->s.size += bp->s.size;
    125f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1262:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1265:	89 10                	mov    %edx,(%eax)
}
    1267:	5b                   	pop    %ebx
    1268:	5e                   	pop    %esi
    1269:	5f                   	pop    %edi
    126a:	5d                   	pop    %ebp
    126b:	c3                   	ret    
    126c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001270 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1270:	55                   	push   %ebp
    1271:	89 e5                	mov    %esp,%ebp
    1273:	57                   	push   %edi
    1274:	56                   	push   %esi
    1275:	53                   	push   %ebx
    1276:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1279:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    127c:	8b 3d f4 1f 00 00    	mov    0x1ff4,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1282:	8d 70 07             	lea    0x7(%eax),%esi
    1285:	c1 ee 03             	shr    $0x3,%esi
    1288:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    128b:	85 ff                	test   %edi,%edi
    128d:	0f 84 ad 00 00 00    	je     1340 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1293:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
    1295:	8b 4a 04             	mov    0x4(%edx),%ecx
    1298:	39 f1                	cmp    %esi,%ecx
    129a:	73 72                	jae    130e <malloc+0x9e>
    129c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    12a2:	bb 00 10 00 00       	mov    $0x1000,%ebx
    12a7:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    12aa:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    12b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    12b4:	eb 1b                	jmp    12d1 <malloc+0x61>
    12b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12bd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    12c0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    12c2:	8b 48 04             	mov    0x4(%eax),%ecx
    12c5:	39 f1                	cmp    %esi,%ecx
    12c7:	73 4f                	jae    1318 <malloc+0xa8>
    12c9:	8b 3d f4 1f 00 00    	mov    0x1ff4,%edi
    12cf:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    12d1:	39 d7                	cmp    %edx,%edi
    12d3:	75 eb                	jne    12c0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    12d5:	83 ec 0c             	sub    $0xc,%esp
    12d8:	ff 75 e4             	pushl  -0x1c(%ebp)
    12db:	e8 e9 fb ff ff       	call   ec9 <sbrk>
  if(p == (char*)-1)
    12e0:	83 c4 10             	add    $0x10,%esp
    12e3:	83 f8 ff             	cmp    $0xffffffff,%eax
    12e6:	74 1c                	je     1304 <malloc+0x94>
  hp->s.size = nu;
    12e8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    12eb:	83 ec 0c             	sub    $0xc,%esp
    12ee:	83 c0 08             	add    $0x8,%eax
    12f1:	50                   	push   %eax
    12f2:	e8 e9 fe ff ff       	call   11e0 <free>
  return freep;
    12f7:	8b 15 f4 1f 00 00    	mov    0x1ff4,%edx
      if((p = morecore(nunits)) == 0)
    12fd:	83 c4 10             	add    $0x10,%esp
    1300:	85 d2                	test   %edx,%edx
    1302:	75 bc                	jne    12c0 <malloc+0x50>
        return 0;
  }
}
    1304:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1307:	31 c0                	xor    %eax,%eax
}
    1309:	5b                   	pop    %ebx
    130a:	5e                   	pop    %esi
    130b:	5f                   	pop    %edi
    130c:	5d                   	pop    %ebp
    130d:	c3                   	ret    
    if(p->s.size >= nunits){
    130e:	89 d0                	mov    %edx,%eax
    1310:	89 fa                	mov    %edi,%edx
    1312:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1318:	39 ce                	cmp    %ecx,%esi
    131a:	74 54                	je     1370 <malloc+0x100>
        p->s.size -= nunits;
    131c:	29 f1                	sub    %esi,%ecx
    131e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1321:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1324:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    1327:	89 15 f4 1f 00 00    	mov    %edx,0x1ff4
}
    132d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1330:	83 c0 08             	add    $0x8,%eax
}
    1333:	5b                   	pop    %ebx
    1334:	5e                   	pop    %esi
    1335:	5f                   	pop    %edi
    1336:	5d                   	pop    %ebp
    1337:	c3                   	ret    
    1338:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    133f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
    1340:	c7 05 f4 1f 00 00 f8 	movl   $0x1ff8,0x1ff4
    1347:	1f 00 00 
    base.s.size = 0;
    134a:	bf f8 1f 00 00       	mov    $0x1ff8,%edi
    base.s.ptr = freep = prevp = &base;
    134f:	c7 05 f8 1f 00 00 f8 	movl   $0x1ff8,0x1ff8
    1356:	1f 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1359:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
    135b:	c7 05 fc 1f 00 00 00 	movl   $0x0,0x1ffc
    1362:	00 00 00 
    if(p->s.size >= nunits){
    1365:	e9 32 ff ff ff       	jmp    129c <malloc+0x2c>
    136a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    1370:	8b 08                	mov    (%eax),%ecx
    1372:	89 0a                	mov    %ecx,(%edx)
    1374:	eb b1                	jmp    1327 <malloc+0xb7>
