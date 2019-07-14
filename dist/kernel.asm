
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 b0 10 00       	mov    $0x10b000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc b0 fd 10 80       	mov    $0x8010fdb0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 20 33 10 80       	mov    $0x80103320,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx
  initlock(&bcache.lock, "bcache");

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb f4 fd 10 80       	mov    $0x8010fdf4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 60 87 10 80       	push   $0x80108760
80100051:	68 c0 fd 10 80       	push   $0x8010fdc0
80100056:	e8 d5 57 00 00       	call   80105830 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	ba bc 44 11 80       	mov    $0x801144bc,%edx
  bcache.head.prev = &bcache.head;
80100063:	c7 05 0c 45 11 80 bc 	movl   $0x801144bc,0x8011450c
8010006a:	44 11 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 10 45 11 80 bc 	movl   $0x801144bc,0x80114510
80100074:	44 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	83 ec 08             	sub    $0x8,%esp
80100085:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc 44 11 80 	movl   $0x801144bc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 67 87 10 80       	push   $0x80108767
80100097:	50                   	push   %eax
80100098:	e8 83 56 00 00       	call   80105720 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 45 11 80       	mov    0x80114510,%eax
801000a2:	89 da                	mov    %ebx,%edx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a4:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 10 45 11 80    	mov    %ebx,0x80114510
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc 44 11 80       	cmp    $0x801144bc,%eax
801000bb:	75 c3                	jne    80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 7d 08             	mov    0x8(%ebp),%edi
801000dc:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&bcache.lock);
801000df:	68 c0 fd 10 80       	push   $0x8010fdc0
801000e4:	e8 a7 58 00 00       	call   80105990 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 45 11 80    	mov    0x80114510,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc 44 11 80    	cmp    $0x801144bc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc 44 11 80    	cmp    $0x801144bc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 7b 04             	cmp    0x4(%ebx),%edi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 73 08             	cmp    0x8(%ebx),%esi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c 45 11 80    	mov    0x8011450c,%ebx
80100126:	81 fb bc 44 11 80    	cmp    $0x801144bc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 70                	jmp    801001a0 <bread+0xd0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc 44 11 80    	cmp    $0x801144bc,%ebx
80100139:	74 65                	je     801001a0 <bread+0xd0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 7b 04             	mov    %edi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 73 08             	mov    %esi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 fd 10 80       	push   $0x8010fdc0
80100162:	e8 e9 58 00 00       	call   80105a50 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ee 55 00 00       	call   80105760 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 df 23 00 00       	call   80102570 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
8010019e:	66 90                	xchg   %ax,%ax
  panic("bget: no buffers");
801001a0:	83 ec 0c             	sub    $0xc,%esp
801001a3:	68 6e 87 10 80       	push   $0x8010876e
801001a8:	e8 e3 01 00 00       	call   80100390 <panic>
801001ad:	8d 76 00             	lea    0x0(%esi),%esi

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 3d 56 00 00       	call   80105800 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave  
  iderw(b);
801001d4:	e9 97 23 00 00       	jmp    80102570 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 7f 87 10 80       	push   $0x8010877f
801001e1:	e8 aa 01 00 00       	call   80100390 <panic>
801001e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001ed:	8d 76 00             	lea    0x0(%esi),%esi

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 fc 55 00 00       	call   80105800 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 ac 55 00 00       	call   801057c0 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 c0 fd 10 80 	movl   $0x8010fdc0,(%esp)
8010021b:	e8 70 57 00 00       	call   80105990 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2f                	jne    8010025f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 43 54             	mov    0x54(%ebx),%eax
80100233:	8b 53 50             	mov    0x50(%ebx),%edx
80100236:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100239:	8b 43 50             	mov    0x50(%ebx),%eax
8010023c:	8b 53 54             	mov    0x54(%ebx),%edx
8010023f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100242:	a1 10 45 11 80       	mov    0x80114510,%eax
    b->prev = &bcache.head;
80100247:	c7 43 50 bc 44 11 80 	movl   $0x801144bc,0x50(%ebx)
    b->next = bcache.head.next;
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100251:	a1 10 45 11 80       	mov    0x80114510,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100259:	89 1d 10 45 11 80    	mov    %ebx,0x80114510
  }
  
  release(&bcache.lock);
8010025f:	c7 45 08 c0 fd 10 80 	movl   $0x8010fdc0,0x8(%ebp)
}
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010026c:	e9 df 57 00 00       	jmp    80105a50 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 86 87 10 80       	push   $0x80108786
80100279:	e8 12 01 00 00       	call   80100390 <panic>
8010027e:	66 90                	xchg   %ax,%ax

80100280 <consoleread>:
#endif
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 28             	sub    $0x28,%esp
  uint target;
  int c;

  iunlock(ip);
80100289:	ff 75 08             	pushl  0x8(%ebp)
{
8010028c:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
8010028f:	e8 3c 17 00 00       	call   801019d0 <iunlock>
  target = n;
  acquire(&cons.lock);
80100294:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010029b:	e8 f0 56 00 00       	call   80105990 <acquire>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002a0:	8b 7d 0c             	mov    0xc(%ebp),%edi
  while(n > 0){
801002a3:	83 c4 10             	add    $0x10,%esp
801002a6:	31 c0                	xor    %eax,%eax
    *dst++ = c;
801002a8:	01 f7                	add    %esi,%edi
  while(n > 0){
801002aa:	85 f6                	test   %esi,%esi
801002ac:	0f 8e a0 00 00 00    	jle    80100352 <consoleread+0xd2>
801002b2:	89 f3                	mov    %esi,%ebx
    while(input.r == input.w){
801002b4:	8b 15 a0 47 11 80    	mov    0x801147a0,%edx
801002ba:	39 15 a4 47 11 80    	cmp    %edx,0x801147a4
801002c0:	74 29                	je     801002eb <consoleread+0x6b>
801002c2:	eb 5c                	jmp    80100320 <consoleread+0xa0>
801002c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      sleep(&input.r, &cons.lock);
801002c8:	83 ec 08             	sub    $0x8,%esp
801002cb:	68 20 c5 10 80       	push   $0x8010c520
801002d0:	68 a0 47 11 80       	push   $0x801147a0
801002d5:	e8 d6 48 00 00       	call   80104bb0 <sleep>
    while(input.r == input.w){
801002da:	8b 15 a0 47 11 80    	mov    0x801147a0,%edx
801002e0:	83 c4 10             	add    $0x10,%esp
801002e3:	3b 15 a4 47 11 80    	cmp    0x801147a4,%edx
801002e9:	75 35                	jne    80100320 <consoleread+0xa0>
      if(myproc()->killed){
801002eb:	e8 20 3c 00 00       	call   80103f10 <myproc>
801002f0:	8b 48 24             	mov    0x24(%eax),%ecx
801002f3:	85 c9                	test   %ecx,%ecx
801002f5:	74 d1                	je     801002c8 <consoleread+0x48>
        release(&cons.lock);
801002f7:	83 ec 0c             	sub    $0xc,%esp
801002fa:	68 20 c5 10 80       	push   $0x8010c520
801002ff:	e8 4c 57 00 00       	call   80105a50 <release>
        ilock(ip);
80100304:	5a                   	pop    %edx
80100305:	ff 75 08             	pushl  0x8(%ebp)
80100308:	e8 c3 15 00 00       	call   801018d0 <ilock>
        return -1;
8010030d:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100310:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100313:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100318:	5b                   	pop    %ebx
80100319:	5e                   	pop    %esi
8010031a:	5f                   	pop    %edi
8010031b:	5d                   	pop    %ebp
8010031c:	c3                   	ret    
8010031d:	8d 76 00             	lea    0x0(%esi),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100320:	8d 42 01             	lea    0x1(%edx),%eax
80100323:	a3 a0 47 11 80       	mov    %eax,0x801147a0
80100328:	89 d0                	mov    %edx,%eax
8010032a:	83 e0 7f             	and    $0x7f,%eax
8010032d:	0f be 80 20 47 11 80 	movsbl -0x7feeb8e0(%eax),%eax
    if(c == C('D')){  // EOF
80100334:	83 f8 04             	cmp    $0x4,%eax
80100337:	74 46                	je     8010037f <consoleread+0xff>
    *dst++ = c;
80100339:	89 da                	mov    %ebx,%edx
    --n;
8010033b:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
8010033e:	f7 da                	neg    %edx
80100340:	88 04 17             	mov    %al,(%edi,%edx,1)
    if(c == '\n')
80100343:	83 f8 0a             	cmp    $0xa,%eax
80100346:	74 31                	je     80100379 <consoleread+0xf9>
  while(n > 0){
80100348:	85 db                	test   %ebx,%ebx
8010034a:	0f 85 64 ff ff ff    	jne    801002b4 <consoleread+0x34>
80100350:	89 f0                	mov    %esi,%eax
  release(&cons.lock);
80100352:	83 ec 0c             	sub    $0xc,%esp
80100355:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100358:	68 20 c5 10 80       	push   $0x8010c520
8010035d:	e8 ee 56 00 00       	call   80105a50 <release>
  ilock(ip);
80100362:	58                   	pop    %eax
80100363:	ff 75 08             	pushl  0x8(%ebp)
80100366:	e8 65 15 00 00       	call   801018d0 <ilock>
  return target - n;
8010036b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010036e:	83 c4 10             	add    $0x10,%esp
}
80100371:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100374:	5b                   	pop    %ebx
80100375:	5e                   	pop    %esi
80100376:	5f                   	pop    %edi
80100377:	5d                   	pop    %ebp
80100378:	c3                   	ret    
80100379:	89 f0                	mov    %esi,%eax
8010037b:	29 d8                	sub    %ebx,%eax
8010037d:	eb d3                	jmp    80100352 <consoleread+0xd2>
      if(n < target){
8010037f:	89 f0                	mov    %esi,%eax
80100381:	29 d8                	sub    %ebx,%eax
80100383:	39 f3                	cmp    %esi,%ebx
80100385:	73 cb                	jae    80100352 <consoleread+0xd2>
        input.r--;
80100387:	89 15 a0 47 11 80    	mov    %edx,0x801147a0
8010038d:	eb c3                	jmp    80100352 <consoleread+0xd2>
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 54 c5 10 80 00 	movl   $0x0,0x8010c554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 f2 27 00 00       	call   80102ba0 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 8d 87 10 80       	push   $0x8010878d
801003b7:	e8 f4 02 00 00       	call   801006b0 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 eb 02 00 00       	call   801006b0 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 56 90 10 80 	movl   $0x80109056,(%esp)
801003cc:	e8 df 02 00 00       	call   801006b0 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	8d 45 08             	lea    0x8(%ebp),%eax
801003d4:	5a                   	pop    %edx
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 73 54 00 00       	call   80105850 <getcallerpcs>
  for(i=0; i<10; i++)
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 a1 87 10 80       	push   $0x801087a1
801003ed:	e8 be 02 00 00       	call   801006b0 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 c5 10 80 01 	movl   $0x1,0x8010c558
80100400:	00 00 00 
    ;
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010040c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100410 <consputc.part.0>:
consputc(int c)
80100410:	55                   	push   %ebp
80100411:	89 e5                	mov    %esp,%ebp
80100413:	57                   	push   %edi
80100414:	56                   	push   %esi
80100415:	53                   	push   %ebx
80100416:	89 c3                	mov    %eax,%ebx
80100418:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
8010041b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100420:	0f 84 ea 00 00 00    	je     80100510 <consputc.part.0+0x100>
    uartputc(c);
80100426:	83 ec 0c             	sub    $0xc,%esp
80100429:	50                   	push   %eax
8010042a:	e8 61 6f 00 00       	call   80107390 <uartputc>
8010042f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100432:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100437:	b8 0e 00 00 00       	mov    $0xe,%eax
8010043c:	89 fa                	mov    %edi,%edx
8010043e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010043f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100444:	89 ca                	mov    %ecx,%edx
80100446:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100447:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010044a:	89 fa                	mov    %edi,%edx
8010044c:	c1 e0 08             	shl    $0x8,%eax
8010044f:	89 c6                	mov    %eax,%esi
80100451:	b8 0f 00 00 00       	mov    $0xf,%eax
80100456:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100457:	89 ca                	mov    %ecx,%edx
80100459:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
8010045a:	0f b6 c0             	movzbl %al,%eax
8010045d:	09 f0                	or     %esi,%eax
  if(c == '\n')
8010045f:	83 fb 0a             	cmp    $0xa,%ebx
80100462:	0f 84 90 00 00 00    	je     801004f8 <consputc.part.0+0xe8>
  else if(c == BACKSPACE){
80100468:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010046e:	74 70                	je     801004e0 <consputc.part.0+0xd0>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100470:	0f b6 db             	movzbl %bl,%ebx
80100473:	8d 70 01             	lea    0x1(%eax),%esi
80100476:	80 cf 07             	or     $0x7,%bh
80100479:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
80100480:	80 
  if(pos < 0 || pos > 25*80)
80100481:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
80100487:	0f 8f f9 00 00 00    	jg     80100586 <consputc.part.0+0x176>
  if((pos/80) >= 24){  // Scroll up.
8010048d:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100493:	0f 8f a7 00 00 00    	jg     80100540 <consputc.part.0+0x130>
80100499:	89 f0                	mov    %esi,%eax
8010049b:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
801004a2:	88 45 e7             	mov    %al,-0x19(%ebp)
801004a5:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004a8:	bb d4 03 00 00       	mov    $0x3d4,%ebx
801004ad:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b2:	89 da                	mov    %ebx,%edx
801004b4:	ee                   	out    %al,(%dx)
801004b5:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801004ba:	89 f8                	mov    %edi,%eax
801004bc:	89 ca                	mov    %ecx,%edx
801004be:	ee                   	out    %al,(%dx)
801004bf:	b8 0f 00 00 00       	mov    $0xf,%eax
801004c4:	89 da                	mov    %ebx,%edx
801004c6:	ee                   	out    %al,(%dx)
801004c7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004cb:	89 ca                	mov    %ecx,%edx
801004cd:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004ce:	b8 20 07 00 00       	mov    $0x720,%eax
801004d3:	66 89 06             	mov    %ax,(%esi)
}
801004d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004d9:	5b                   	pop    %ebx
801004da:	5e                   	pop    %esi
801004db:	5f                   	pop    %edi
801004dc:	5d                   	pop    %ebp
801004dd:	c3                   	ret    
801004de:	66 90                	xchg   %ax,%ax
    if(pos > 0) --pos;
801004e0:	8d 70 ff             	lea    -0x1(%eax),%esi
801004e3:	85 c0                	test   %eax,%eax
801004e5:	75 9a                	jne    80100481 <consputc.part.0+0x71>
801004e7:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004ec:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
801004f0:	31 ff                	xor    %edi,%edi
801004f2:	eb b4                	jmp    801004a8 <consputc.part.0+0x98>
801004f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pos += 80 - pos%80;
801004f8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004fd:	f7 e2                	mul    %edx
801004ff:	c1 ea 06             	shr    $0x6,%edx
80100502:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100505:	c1 e0 04             	shl    $0x4,%eax
80100508:	8d 70 50             	lea    0x50(%eax),%esi
8010050b:	e9 71 ff ff ff       	jmp    80100481 <consputc.part.0+0x71>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100510:	83 ec 0c             	sub    $0xc,%esp
80100513:	6a 08                	push   $0x8
80100515:	e8 76 6e 00 00       	call   80107390 <uartputc>
8010051a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100521:	e8 6a 6e 00 00       	call   80107390 <uartputc>
80100526:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010052d:	e8 5e 6e 00 00       	call   80107390 <uartputc>
80100532:	83 c4 10             	add    $0x10,%esp
80100535:	e9 f8 fe ff ff       	jmp    80100432 <consputc.part.0+0x22>
8010053a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100540:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100543:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100546:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010054b:	68 60 0e 00 00       	push   $0xe60
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100550:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100557:	68 a0 80 0b 80       	push   $0x800b80a0
8010055c:	68 00 80 0b 80       	push   $0x800b8000
80100561:	e8 da 55 00 00       	call   80105b40 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100566:	b8 80 07 00 00       	mov    $0x780,%eax
8010056b:	83 c4 0c             	add    $0xc,%esp
8010056e:	29 d8                	sub    %ebx,%eax
80100570:	01 c0                	add    %eax,%eax
80100572:	50                   	push   %eax
80100573:	6a 00                	push   $0x0
80100575:	56                   	push   %esi
80100576:	e8 25 55 00 00       	call   80105aa0 <memset>
8010057b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010057e:	83 c4 10             	add    $0x10,%esp
80100581:	e9 22 ff ff ff       	jmp    801004a8 <consputc.part.0+0x98>
    panic("pos under/overflow");
80100586:	83 ec 0c             	sub    $0xc,%esp
80100589:	68 a5 87 10 80       	push   $0x801087a5
8010058e:	e8 fd fd ff ff       	call   80100390 <panic>
80100593:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010059a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801005a0 <printint>:
{
801005a0:	55                   	push   %ebp
801005a1:	89 e5                	mov    %esp,%ebp
801005a3:	57                   	push   %edi
801005a4:	56                   	push   %esi
801005a5:	53                   	push   %ebx
801005a6:	83 ec 2c             	sub    $0x2c,%esp
801005a9:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
801005ac:	85 c9                	test   %ecx,%ecx
801005ae:	74 04                	je     801005b4 <printint+0x14>
801005b0:	85 c0                	test   %eax,%eax
801005b2:	78 68                	js     8010061c <printint+0x7c>
    x = xx;
801005b4:	89 c1                	mov    %eax,%ecx
801005b6:	31 f6                	xor    %esi,%esi
  i = 0;
801005b8:	31 db                	xor    %ebx,%ebx
801005ba:	eb 04                	jmp    801005c0 <printint+0x20>
  }while((x /= base) != 0);
801005bc:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
801005be:	89 fb                	mov    %edi,%ebx
801005c0:	89 c8                	mov    %ecx,%eax
801005c2:	31 d2                	xor    %edx,%edx
801005c4:	8d 7b 01             	lea    0x1(%ebx),%edi
801005c7:	f7 75 d4             	divl   -0x2c(%ebp)
801005ca:	0f b6 92 d0 87 10 80 	movzbl -0x7fef7830(%edx),%edx
801005d1:	88 54 3d d7          	mov    %dl,-0x29(%ebp,%edi,1)
  }while((x /= base) != 0);
801005d5:	39 4d d4             	cmp    %ecx,-0x2c(%ebp)
801005d8:	76 e2                	jbe    801005bc <printint+0x1c>
  if(sign)
801005da:	85 f6                	test   %esi,%esi
801005dc:	75 32                	jne    80100610 <printint+0x70>
801005de:	0f be c2             	movsbl %dl,%eax
801005e1:	89 df                	mov    %ebx,%edi
  if(panicked){
801005e3:	8b 0d 58 c5 10 80    	mov    0x8010c558,%ecx
801005e9:	85 c9                	test   %ecx,%ecx
801005eb:	75 20                	jne    8010060d <printint+0x6d>
801005ed:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005f1:	e8 1a fe ff ff       	call   80100410 <consputc.part.0>
  while(--i >= 0)
801005f6:	8d 45 d7             	lea    -0x29(%ebp),%eax
801005f9:	39 d8                	cmp    %ebx,%eax
801005fb:	74 27                	je     80100624 <printint+0x84>
  if(panicked){
801005fd:	8b 15 58 c5 10 80    	mov    0x8010c558,%edx
    consputc(buf[i]);
80100603:	0f be 03             	movsbl (%ebx),%eax
  if(panicked){
80100606:	83 eb 01             	sub    $0x1,%ebx
80100609:	85 d2                	test   %edx,%edx
8010060b:	74 e4                	je     801005f1 <printint+0x51>
  asm volatile("cli");
8010060d:	fa                   	cli    
      ;
8010060e:	eb fe                	jmp    8010060e <printint+0x6e>
    buf[i++] = '-';
80100610:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
80100615:	b8 2d 00 00 00       	mov    $0x2d,%eax
8010061a:	eb c7                	jmp    801005e3 <printint+0x43>
    x = -xx;
8010061c:	f7 d8                	neg    %eax
8010061e:	89 ce                	mov    %ecx,%esi
80100620:	89 c1                	mov    %eax,%ecx
80100622:	eb 94                	jmp    801005b8 <printint+0x18>
}
80100624:	83 c4 2c             	add    $0x2c,%esp
80100627:	5b                   	pop    %ebx
80100628:	5e                   	pop    %esi
80100629:	5f                   	pop    %edi
8010062a:	5d                   	pop    %ebp
8010062b:	c3                   	ret    
8010062c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100630 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100630:	55                   	push   %ebp
80100631:	89 e5                	mov    %esp,%ebp
80100633:	57                   	push   %edi
80100634:	56                   	push   %esi
80100635:	53                   	push   %ebx
80100636:	83 ec 18             	sub    $0x18,%esp
80100639:	8b 7d 10             	mov    0x10(%ebp),%edi
8010063c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int i;

  iunlock(ip);
8010063f:	ff 75 08             	pushl  0x8(%ebp)
80100642:	e8 89 13 00 00       	call   801019d0 <iunlock>
  acquire(&cons.lock);
80100647:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010064e:	e8 3d 53 00 00       	call   80105990 <acquire>
  for(i = 0; i < n; i++)
80100653:	83 c4 10             	add    $0x10,%esp
80100656:	85 ff                	test   %edi,%edi
80100658:	7e 36                	jle    80100690 <consolewrite+0x60>
  if(panicked){
8010065a:	8b 0d 58 c5 10 80    	mov    0x8010c558,%ecx
80100660:	85 c9                	test   %ecx,%ecx
80100662:	75 21                	jne    80100685 <consolewrite+0x55>
    consputc(buf[i] & 0xff);
80100664:	0f b6 03             	movzbl (%ebx),%eax
80100667:	8d 73 01             	lea    0x1(%ebx),%esi
8010066a:	01 fb                	add    %edi,%ebx
8010066c:	e8 9f fd ff ff       	call   80100410 <consputc.part.0>
  for(i = 0; i < n; i++)
80100671:	39 de                	cmp    %ebx,%esi
80100673:	74 1b                	je     80100690 <consolewrite+0x60>
  if(panicked){
80100675:	8b 15 58 c5 10 80    	mov    0x8010c558,%edx
    consputc(buf[i] & 0xff);
8010067b:	0f b6 06             	movzbl (%esi),%eax
  if(panicked){
8010067e:	83 c6 01             	add    $0x1,%esi
80100681:	85 d2                	test   %edx,%edx
80100683:	74 e7                	je     8010066c <consolewrite+0x3c>
80100685:	fa                   	cli    
      ;
80100686:	eb fe                	jmp    80100686 <consolewrite+0x56>
80100688:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010068f:	90                   	nop
  release(&cons.lock);
80100690:	83 ec 0c             	sub    $0xc,%esp
80100693:	68 20 c5 10 80       	push   $0x8010c520
80100698:	e8 b3 53 00 00       	call   80105a50 <release>
  ilock(ip);
8010069d:	58                   	pop    %eax
8010069e:	ff 75 08             	pushl  0x8(%ebp)
801006a1:	e8 2a 12 00 00       	call   801018d0 <ilock>

  return n;
}
801006a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801006a9:	89 f8                	mov    %edi,%eax
801006ab:	5b                   	pop    %ebx
801006ac:	5e                   	pop    %esi
801006ad:	5f                   	pop    %edi
801006ae:	5d                   	pop    %ebp
801006af:	c3                   	ret    

801006b0 <cprintf>:
{
801006b0:	55                   	push   %ebp
801006b1:	89 e5                	mov    %esp,%ebp
801006b3:	57                   	push   %edi
801006b4:	56                   	push   %esi
801006b5:	53                   	push   %ebx
801006b6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006b9:	a1 54 c5 10 80       	mov    0x8010c554,%eax
801006be:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
801006c1:	85 c0                	test   %eax,%eax
801006c3:	0f 85 df 00 00 00    	jne    801007a8 <cprintf+0xf8>
  if (fmt == 0)
801006c9:	8b 45 08             	mov    0x8(%ebp),%eax
801006cc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006cf:	85 c0                	test   %eax,%eax
801006d1:	0f 84 5e 01 00 00    	je     80100835 <cprintf+0x185>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006d7:	0f b6 00             	movzbl (%eax),%eax
801006da:	85 c0                	test   %eax,%eax
801006dc:	74 32                	je     80100710 <cprintf+0x60>
  argp = (uint*)(void*)(&fmt + 1);
801006de:	8d 5d 0c             	lea    0xc(%ebp),%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e1:	31 f6                	xor    %esi,%esi
    if(c != '%'){
801006e3:	83 f8 25             	cmp    $0x25,%eax
801006e6:	74 40                	je     80100728 <cprintf+0x78>
  if(panicked){
801006e8:	8b 0d 58 c5 10 80    	mov    0x8010c558,%ecx
801006ee:	85 c9                	test   %ecx,%ecx
801006f0:	74 0b                	je     801006fd <cprintf+0x4d>
801006f2:	fa                   	cli    
      ;
801006f3:	eb fe                	jmp    801006f3 <cprintf+0x43>
801006f5:	8d 76 00             	lea    0x0(%esi),%esi
801006f8:	b8 25 00 00 00       	mov    $0x25,%eax
801006fd:	e8 0e fd ff ff       	call   80100410 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100702:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100705:	83 c6 01             	add    $0x1,%esi
80100708:	0f b6 04 30          	movzbl (%eax,%esi,1),%eax
8010070c:	85 c0                	test   %eax,%eax
8010070e:	75 d3                	jne    801006e3 <cprintf+0x33>
  if(locking)
80100710:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80100713:	85 db                	test   %ebx,%ebx
80100715:	0f 85 05 01 00 00    	jne    80100820 <cprintf+0x170>
}
8010071b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010071e:	5b                   	pop    %ebx
8010071f:	5e                   	pop    %esi
80100720:	5f                   	pop    %edi
80100721:	5d                   	pop    %ebp
80100722:	c3                   	ret    
80100723:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100727:	90                   	nop
    c = fmt[++i] & 0xff;
80100728:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010072b:	83 c6 01             	add    $0x1,%esi
8010072e:	0f b6 3c 30          	movzbl (%eax,%esi,1),%edi
    if(c == 0)
80100732:	85 ff                	test   %edi,%edi
80100734:	74 da                	je     80100710 <cprintf+0x60>
    switch(c){
80100736:	83 ff 70             	cmp    $0x70,%edi
80100739:	0f 84 7e 00 00 00    	je     801007bd <cprintf+0x10d>
8010073f:	7f 26                	jg     80100767 <cprintf+0xb7>
80100741:	83 ff 25             	cmp    $0x25,%edi
80100744:	0f 84 be 00 00 00    	je     80100808 <cprintf+0x158>
8010074a:	83 ff 64             	cmp    $0x64,%edi
8010074d:	75 46                	jne    80100795 <cprintf+0xe5>
      printint(*argp++, 10, 1);
8010074f:	8b 03                	mov    (%ebx),%eax
80100751:	8d 7b 04             	lea    0x4(%ebx),%edi
80100754:	b9 01 00 00 00       	mov    $0x1,%ecx
80100759:	ba 0a 00 00 00       	mov    $0xa,%edx
8010075e:	89 fb                	mov    %edi,%ebx
80100760:	e8 3b fe ff ff       	call   801005a0 <printint>
      break;
80100765:	eb 9b                	jmp    80100702 <cprintf+0x52>
    switch(c){
80100767:	83 ff 73             	cmp    $0x73,%edi
8010076a:	75 24                	jne    80100790 <cprintf+0xe0>
      if((s = (char*)*argp++) == 0)
8010076c:	8d 7b 04             	lea    0x4(%ebx),%edi
8010076f:	8b 1b                	mov    (%ebx),%ebx
80100771:	85 db                	test   %ebx,%ebx
80100773:	75 68                	jne    801007dd <cprintf+0x12d>
80100775:	b8 28 00 00 00       	mov    $0x28,%eax
        s = "(null)";
8010077a:	bb b8 87 10 80       	mov    $0x801087b8,%ebx
  if(panicked){
8010077f:	8b 15 58 c5 10 80    	mov    0x8010c558,%edx
80100785:	85 d2                	test   %edx,%edx
80100787:	74 4c                	je     801007d5 <cprintf+0x125>
80100789:	fa                   	cli    
      ;
8010078a:	eb fe                	jmp    8010078a <cprintf+0xda>
8010078c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100790:	83 ff 78             	cmp    $0x78,%edi
80100793:	74 28                	je     801007bd <cprintf+0x10d>
  if(panicked){
80100795:	8b 15 58 c5 10 80    	mov    0x8010c558,%edx
8010079b:	85 d2                	test   %edx,%edx
8010079d:	74 4c                	je     801007eb <cprintf+0x13b>
8010079f:	fa                   	cli    
      ;
801007a0:	eb fe                	jmp    801007a0 <cprintf+0xf0>
801007a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&cons.lock);
801007a8:	83 ec 0c             	sub    $0xc,%esp
801007ab:	68 20 c5 10 80       	push   $0x8010c520
801007b0:	e8 db 51 00 00       	call   80105990 <acquire>
801007b5:	83 c4 10             	add    $0x10,%esp
801007b8:	e9 0c ff ff ff       	jmp    801006c9 <cprintf+0x19>
      printint(*argp++, 16, 0);
801007bd:	8b 03                	mov    (%ebx),%eax
801007bf:	8d 7b 04             	lea    0x4(%ebx),%edi
801007c2:	31 c9                	xor    %ecx,%ecx
801007c4:	ba 10 00 00 00       	mov    $0x10,%edx
801007c9:	89 fb                	mov    %edi,%ebx
801007cb:	e8 d0 fd ff ff       	call   801005a0 <printint>
      break;
801007d0:	e9 2d ff ff ff       	jmp    80100702 <cprintf+0x52>
801007d5:	e8 36 fc ff ff       	call   80100410 <consputc.part.0>
      for(; *s; s++)
801007da:	83 c3 01             	add    $0x1,%ebx
801007dd:	0f be 03             	movsbl (%ebx),%eax
801007e0:	84 c0                	test   %al,%al
801007e2:	75 9b                	jne    8010077f <cprintf+0xcf>
      if((s = (char*)*argp++) == 0)
801007e4:	89 fb                	mov    %edi,%ebx
801007e6:	e9 17 ff ff ff       	jmp    80100702 <cprintf+0x52>
801007eb:	b8 25 00 00 00       	mov    $0x25,%eax
801007f0:	e8 1b fc ff ff       	call   80100410 <consputc.part.0>
  if(panicked){
801007f5:	a1 58 c5 10 80       	mov    0x8010c558,%eax
801007fa:	85 c0                	test   %eax,%eax
801007fc:	74 4a                	je     80100848 <cprintf+0x198>
801007fe:	fa                   	cli    
      ;
801007ff:	eb fe                	jmp    801007ff <cprintf+0x14f>
80100801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(panicked){
80100808:	8b 0d 58 c5 10 80    	mov    0x8010c558,%ecx
8010080e:	85 c9                	test   %ecx,%ecx
80100810:	0f 84 e2 fe ff ff    	je     801006f8 <cprintf+0x48>
80100816:	fa                   	cli    
      ;
80100817:	eb fe                	jmp    80100817 <cprintf+0x167>
80100819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&cons.lock);
80100820:	83 ec 0c             	sub    $0xc,%esp
80100823:	68 20 c5 10 80       	push   $0x8010c520
80100828:	e8 23 52 00 00       	call   80105a50 <release>
8010082d:	83 c4 10             	add    $0x10,%esp
}
80100830:	e9 e6 fe ff ff       	jmp    8010071b <cprintf+0x6b>
    panic("null fmt");
80100835:	83 ec 0c             	sub    $0xc,%esp
80100838:	68 bf 87 10 80       	push   $0x801087bf
8010083d:	e8 4e fb ff ff       	call   80100390 <panic>
80100842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100848:	89 f8                	mov    %edi,%eax
8010084a:	e8 c1 fb ff ff       	call   80100410 <consputc.part.0>
8010084f:	e9 ae fe ff ff       	jmp    80100702 <cprintf+0x52>
80100854:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010085b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010085f:	90                   	nop

80100860 <consoleintr>:
{
80100860:	55                   	push   %ebp
80100861:	89 e5                	mov    %esp,%ebp
80100863:	57                   	push   %edi
  int c, doprocdump = 0;
80100864:	31 ff                	xor    %edi,%edi
{
80100866:	56                   	push   %esi
  int free_l = 0;
80100867:	31 f6                	xor    %esi,%esi
{
80100869:	53                   	push   %ebx
8010086a:	83 ec 28             	sub    $0x28,%esp
8010086d:	8b 45 08             	mov    0x8(%ebp),%eax
  acquire(&cons.lock);
80100870:	68 20 c5 10 80       	push   $0x8010c520
{
80100875:	89 45 d8             	mov    %eax,-0x28(%ebp)
  acquire(&cons.lock);
80100878:	e8 13 51 00 00       	call   80105990 <acquire>
  int zombie_l = 0;
8010087d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((c = getc()) >= 0){
80100884:	83 c4 10             	add    $0x10,%esp
  int sleep_l = 0;
80100887:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  int ready_l = 0;
8010088e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  while((c = getc()) >= 0){
80100895:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100898:	ff d0                	call   *%eax
8010089a:	89 c3                	mov    %eax,%ebx
8010089c:	85 c0                	test   %eax,%eax
8010089e:	78 35                	js     801008d5 <consoleintr+0x75>
    switch(c){
801008a0:	83 fb 12             	cmp    $0x12,%ebx
801008a3:	0f 84 c7 01 00 00    	je     80100a70 <consoleintr+0x210>
801008a9:	7e 75                	jle    80100920 <consoleintr+0xc0>
801008ab:	83 fb 15             	cmp    $0x15,%ebx
801008ae:	0f 84 65 01 00 00    	je     80100a19 <consoleintr+0x1b9>
801008b4:	0f 8e 36 01 00 00    	jle    801009f0 <consoleintr+0x190>
801008ba:	83 fb 1a             	cmp    $0x1a,%ebx
801008bd:	0f 85 f5 00 00 00    	jne    801009b8 <consoleintr+0x158>
      zombie_l = 1;
801008c3:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  while((c = getc()) >= 0){
801008ca:	8b 45 d8             	mov    -0x28(%ebp),%eax
801008cd:	ff d0                	call   *%eax
801008cf:	89 c3                	mov    %eax,%ebx
801008d1:	85 c0                	test   %eax,%eax
801008d3:	79 cb                	jns    801008a0 <consoleintr+0x40>
  release(&cons.lock);
801008d5:	83 ec 0c             	sub    $0xc,%esp
801008d8:	68 20 c5 10 80       	push   $0x8010c520
801008dd:	e8 6e 51 00 00       	call   80105a50 <release>
  if(doprocdump) {
801008e2:	83 c4 10             	add    $0x10,%esp
801008e5:	85 ff                	test   %edi,%edi
801008e7:	0f 85 fc 01 00 00    	jne    80100ae9 <consoleintr+0x289>
  if(free_l)
801008ed:	85 f6                	test   %esi,%esi
801008ef:	0f 85 fe 01 00 00    	jne    80100af3 <consoleintr+0x293>
  if(ready_l)
801008f5:	8b 4d dc             	mov    -0x24(%ebp),%ecx
801008f8:	85 c9                	test   %ecx,%ecx
801008fa:	0f 85 df 01 00 00    	jne    80100adf <consoleintr+0x27f>
  if(sleep_l)
80100900:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100903:	85 d2                	test   %edx,%edx
80100905:	0f 85 ca 01 00 00    	jne    80100ad5 <consoleintr+0x275>
  if(zombie_l)
8010090b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010090e:	85 c0                	test   %eax,%eax
80100910:	0f 85 b3 01 00 00    	jne    80100ac9 <consoleintr+0x269>
}
80100916:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100919:	5b                   	pop    %ebx
8010091a:	5e                   	pop    %esi
8010091b:	5f                   	pop    %edi
8010091c:	5d                   	pop    %ebp
8010091d:	c3                   	ret    
8010091e:	66 90                	xchg   %ax,%ax
    switch(c){
80100920:	83 fb 08             	cmp    $0x8,%ebx
80100923:	0f 84 98 00 00 00    	je     801009c1 <consoleintr+0x161>
80100929:	83 fb 10             	cmp    $0x10,%ebx
8010092c:	0f 84 dd 00 00 00    	je     80100a0f <consoleintr+0x1af>
80100932:	83 fb 06             	cmp    $0x6,%ebx
80100935:	0f 84 ca 00 00 00    	je     80100a05 <consoleintr+0x1a5>
      if(c != 0 && input.e-input.r < INPUT_BUF){
8010093b:	85 db                	test   %ebx,%ebx
8010093d:	0f 84 52 ff ff ff    	je     80100895 <consoleintr+0x35>
80100943:	a1 a8 47 11 80       	mov    0x801147a8,%eax
80100948:	89 c2                	mov    %eax,%edx
8010094a:	2b 15 a0 47 11 80    	sub    0x801147a0,%edx
80100950:	83 fa 7f             	cmp    $0x7f,%edx
80100953:	0f 87 3c ff ff ff    	ja     80100895 <consoleintr+0x35>
        c = (c == '\r') ? '\n' : c;
80100959:	8d 48 01             	lea    0x1(%eax),%ecx
8010095c:	8b 15 58 c5 10 80    	mov    0x8010c558,%edx
80100962:	83 e0 7f             	and    $0x7f,%eax
        input.buf[input.e++ % INPUT_BUF] = c;
80100965:	89 0d a8 47 11 80    	mov    %ecx,0x801147a8
        c = (c == '\r') ? '\n' : c;
8010096b:	83 fb 0d             	cmp    $0xd,%ebx
8010096e:	0f 84 17 01 00 00    	je     80100a8b <consoleintr+0x22b>
        input.buf[input.e++ % INPUT_BUF] = c;
80100974:	88 98 20 47 11 80    	mov    %bl,-0x7feeb8e0(%eax)
  if(panicked){
8010097a:	85 d2                	test   %edx,%edx
8010097c:	0f 85 14 01 00 00    	jne    80100a96 <consoleintr+0x236>
80100982:	89 d8                	mov    %ebx,%eax
80100984:	e8 87 fa ff ff       	call   80100410 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100989:	83 fb 0a             	cmp    $0xa,%ebx
8010098c:	0f 84 18 01 00 00    	je     80100aaa <consoleintr+0x24a>
80100992:	83 fb 04             	cmp    $0x4,%ebx
80100995:	0f 84 0f 01 00 00    	je     80100aaa <consoleintr+0x24a>
8010099b:	a1 a0 47 11 80       	mov    0x801147a0,%eax
801009a0:	83 e8 80             	sub    $0xffffff80,%eax
801009a3:	39 05 a8 47 11 80    	cmp    %eax,0x801147a8
801009a9:	0f 85 e6 fe ff ff    	jne    80100895 <consoleintr+0x35>
801009af:	e9 fb 00 00 00       	jmp    80100aaf <consoleintr+0x24f>
801009b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
801009b8:	83 fb 7f             	cmp    $0x7f,%ebx
801009bb:	0f 85 7a ff ff ff    	jne    8010093b <consoleintr+0xdb>
      if(input.e != input.w){
801009c1:	a1 a8 47 11 80       	mov    0x801147a8,%eax
801009c6:	3b 05 a4 47 11 80    	cmp    0x801147a4,%eax
801009cc:	0f 84 c3 fe ff ff    	je     80100895 <consoleintr+0x35>
  if(panicked){
801009d2:	8b 1d 58 c5 10 80    	mov    0x8010c558,%ebx
        input.e--;
801009d8:	83 e8 01             	sub    $0x1,%eax
801009db:	a3 a8 47 11 80       	mov    %eax,0x801147a8
  if(panicked){
801009e0:	85 db                	test   %ebx,%ebx
801009e2:	0f 84 94 00 00 00    	je     80100a7c <consoleintr+0x21c>
801009e8:	fa                   	cli    
      ;
801009e9:	eb fe                	jmp    801009e9 <consoleintr+0x189>
801009eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801009ef:	90                   	nop
    switch(c){
801009f0:	83 fb 13             	cmp    $0x13,%ebx
801009f3:	0f 85 42 ff ff ff    	jne    8010093b <consoleintr+0xdb>
      sleep_l = 1;
801009f9:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
80100a00:	e9 90 fe ff ff       	jmp    80100895 <consoleintr+0x35>
      free_l = 1;
80100a05:	be 01 00 00 00       	mov    $0x1,%esi
80100a0a:	e9 86 fe ff ff       	jmp    80100895 <consoleintr+0x35>
      doprocdump = 1;
80100a0f:	bf 01 00 00 00       	mov    $0x1,%edi
80100a14:	e9 7c fe ff ff       	jmp    80100895 <consoleintr+0x35>
      while(input.e != input.w &&
80100a19:	a1 a8 47 11 80       	mov    0x801147a8,%eax
80100a1e:	3b 05 a4 47 11 80    	cmp    0x801147a4,%eax
80100a24:	0f 84 6b fe ff ff    	je     80100895 <consoleintr+0x35>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100a2a:	83 e8 01             	sub    $0x1,%eax
80100a2d:	89 c2                	mov    %eax,%edx
80100a2f:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100a32:	80 ba 20 47 11 80 0a 	cmpb   $0xa,-0x7feeb8e0(%edx)
80100a39:	0f 84 56 fe ff ff    	je     80100895 <consoleintr+0x35>
        input.e--;
80100a3f:	a3 a8 47 11 80       	mov    %eax,0x801147a8
  if(panicked){
80100a44:	a1 58 c5 10 80       	mov    0x8010c558,%eax
80100a49:	85 c0                	test   %eax,%eax
80100a4b:	74 03                	je     80100a50 <consoleintr+0x1f0>
80100a4d:	fa                   	cli    
      ;
80100a4e:	eb fe                	jmp    80100a4e <consoleintr+0x1ee>
80100a50:	b8 00 01 00 00       	mov    $0x100,%eax
80100a55:	e8 b6 f9 ff ff       	call   80100410 <consputc.part.0>
      while(input.e != input.w &&
80100a5a:	a1 a8 47 11 80       	mov    0x801147a8,%eax
80100a5f:	3b 05 a4 47 11 80    	cmp    0x801147a4,%eax
80100a65:	75 c3                	jne    80100a2a <consoleintr+0x1ca>
80100a67:	e9 29 fe ff ff       	jmp    80100895 <consoleintr+0x35>
80100a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ready_l = 1;
80100a70:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
80100a77:	e9 19 fe ff ff       	jmp    80100895 <consoleintr+0x35>
80100a7c:	b8 00 01 00 00       	mov    $0x100,%eax
80100a81:	e8 8a f9 ff ff       	call   80100410 <consputc.part.0>
80100a86:	e9 0a fe ff ff       	jmp    80100895 <consoleintr+0x35>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a8b:	c6 80 20 47 11 80 0a 	movb   $0xa,-0x7feeb8e0(%eax)
  if(panicked){
80100a92:	85 d2                	test   %edx,%edx
80100a94:	74 0a                	je     80100aa0 <consoleintr+0x240>
80100a96:	fa                   	cli    
      ;
80100a97:	eb fe                	jmp    80100a97 <consoleintr+0x237>
80100a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100aa0:	b8 0a 00 00 00       	mov    $0xa,%eax
80100aa5:	e8 66 f9 ff ff       	call   80100410 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100aaa:	a1 a8 47 11 80       	mov    0x801147a8,%eax
          wakeup(&input.r);
80100aaf:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100ab2:	a3 a4 47 11 80       	mov    %eax,0x801147a4
          wakeup(&input.r);
80100ab7:	68 a0 47 11 80       	push   $0x801147a0
80100abc:	e8 9f 44 00 00       	call   80104f60 <wakeup>
80100ac1:	83 c4 10             	add    $0x10,%esp
80100ac4:	e9 cc fd ff ff       	jmp    80100895 <consoleintr+0x35>
}
80100ac9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100acc:	5b                   	pop    %ebx
80100acd:	5e                   	pop    %esi
80100ace:	5f                   	pop    %edi
80100acf:	5d                   	pop    %ebp
      control_z();
80100ad0:	e9 1b 4a 00 00       	jmp    801054f0 <control_z>
      control_s();
80100ad5:	e8 86 49 00 00       	call   80105460 <control_s>
80100ada:	e9 2c fe ff ff       	jmp    8010090b <consoleintr+0xab>
      control_r();
80100adf:	e8 cc 48 00 00       	call   801053b0 <control_r>
80100ae4:	e9 17 fe ff ff       	jmp    80100900 <consoleintr+0xa0>
    procdump();  // now call procdump() wo. cons.lock held
80100ae9:	e8 52 46 00 00       	call   80105140 <procdump>
80100aee:	e9 fa fd ff ff       	jmp    801008ed <consoleintr+0x8d>
      control_f();
80100af3:	e8 58 48 00 00       	call   80105350 <control_f>
80100af8:	e9 f8 fd ff ff       	jmp    801008f5 <consoleintr+0x95>
80100afd:	8d 76 00             	lea    0x0(%esi),%esi

80100b00 <consoleinit>:

void
consoleinit(void)
{
80100b00:	55                   	push   %ebp
80100b01:	89 e5                	mov    %esp,%ebp
80100b03:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100b06:	68 c8 87 10 80       	push   $0x801087c8
80100b0b:	68 20 c5 10 80       	push   $0x8010c520
80100b10:	e8 1b 4d 00 00       	call   80105830 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100b15:	58                   	pop    %eax
80100b16:	5a                   	pop    %edx
80100b17:	6a 00                	push   $0x0
80100b19:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100b1b:	c7 05 6c 51 11 80 30 	movl   $0x80100630,0x8011516c
80100b22:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100b25:	c7 05 68 51 11 80 80 	movl   $0x80100280,0x80115168
80100b2c:	02 10 80 
  cons.locking = 1;
80100b2f:	c7 05 54 c5 10 80 01 	movl   $0x1,0x8010c554
80100b36:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100b39:	e8 e2 1b 00 00       	call   80102720 <ioapicenable>
}
80100b3e:	83 c4 10             	add    $0x10,%esp
80100b41:	c9                   	leave  
80100b42:	c3                   	ret    
80100b43:	66 90                	xchg   %ax,%ax
80100b45:	66 90                	xchg   %ax,%ax
80100b47:	66 90                	xchg   %ax,%ax
80100b49:	66 90                	xchg   %ax,%ax
80100b4b:	66 90                	xchg   %ax,%ax
80100b4d:	66 90                	xchg   %ax,%ax
80100b4f:	90                   	nop

80100b50 <exec>:
#endif


int
exec(char *path, char **argv)
{
80100b50:	55                   	push   %ebp
80100b51:	89 e5                	mov    %esp,%ebp
80100b53:	57                   	push   %edi
80100b54:	56                   	push   %esi
80100b55:	53                   	push   %ebx
80100b56:	81 ec 1c 01 00 00    	sub    $0x11c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100b5c:	e8 af 33 00 00       	call   80103f10 <myproc>
80100b61:	89 c6                	mov    %eax,%esi

  begin_op();
80100b63:	e8 a8 24 00 00       	call   80103010 <begin_op>

  if((ip = namei(path)) == 0){
80100b68:	83 ec 0c             	sub    $0xc,%esp
80100b6b:	ff 75 08             	pushl  0x8(%ebp)
80100b6e:	e8 3d 16 00 00       	call   801021b0 <namei>
80100b73:	83 c4 10             	add    $0x10,%esp
80100b76:	85 c0                	test   %eax,%eax
80100b78:	0f 84 b5 02 00 00    	je     80100e33 <exec+0x2e3>
#ifndef XV6_PDX
    cprintf("exec: fail\n");
#endif
    return -1;
  }
  ilock(ip);
80100b7e:	83 ec 0c             	sub    $0xc,%esp
80100b81:	89 c3                	mov    %eax,%ebx
80100b83:	50                   	push   %eax
80100b84:	e8 47 0d 00 00       	call   801018d0 <ilock>
  pgdir = 0;

#ifdef CS333_P5
  struct stat stat_obj;
  int flag = 0;
  stati(ip,&stat_obj);
80100b89:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
80100b8f:	5a                   	pop    %edx
80100b90:	59                   	pop    %ecx
80100b91:	50                   	push   %eax
80100b92:	53                   	push   %ebx
80100b93:	e8 08 10 00 00       	call   80101ba0 <stati>

  if(stat_obj.uid == curproc->uid)
80100b98:	0f b7 85 fc fe ff ff 	movzwl -0x104(%ebp),%eax
80100b9f:	83 c4 10             	add    $0x10,%esp
80100ba2:	3b 86 84 00 00 00    	cmp    0x84(%esi),%eax
80100ba8:	74 76                	je     80100c20 <exec+0xd0>
      flag = stat_obj.mode.flags.u_x;

  else if(stat_obj.gid == curproc->gid)
80100baa:	0f b7 85 fe fe ff ff 	movzwl -0x102(%ebp),%eax
80100bb1:	3b 86 80 00 00 00    	cmp    0x80(%esi),%eax
      flag = stat_obj.mode.flags.g_x;
80100bb7:	0f b6 85 00 ff ff ff 	movzbl -0x100(%ebp),%eax
  else if(stat_obj.gid == curproc->gid)
80100bbe:	74 50                	je     80100c10 <exec+0xc0>

  else 
      flag = stat_obj.mode.flags.o_x;
80100bc0:	83 e0 01             	and    $0x1,%eax

  if(flag == 0)
80100bc3:	85 c0                	test   %eax,%eax
80100bc5:	74 29                	je     80100bf0 <exec+0xa0>
      goto bad;
#endif

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100bc7:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100bcd:	6a 34                	push   $0x34
80100bcf:	6a 00                	push   $0x0
80100bd1:	50                   	push   %eax
80100bd2:	53                   	push   %ebx
80100bd3:	e8 18 10 00 00       	call   80101bf0 <readi>
80100bd8:	83 c4 10             	add    $0x10,%esp
80100bdb:	83 f8 34             	cmp    $0x34,%eax
80100bde:	75 10                	jne    80100bf0 <exec+0xa0>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100be0:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100be7:	45 4c 46 
80100bea:	74 44                	je     80100c30 <exec+0xe0>
80100bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100bf0:	83 ec 0c             	sub    $0xc,%esp
80100bf3:	53                   	push   %ebx
80100bf4:	e8 87 0f 00 00       	call   80101b80 <iunlockput>
    end_op();
80100bf9:	e8 82 24 00 00       	call   80103080 <end_op>
80100bfe:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100c01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100c06:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c09:	5b                   	pop    %ebx
80100c0a:	5e                   	pop    %esi
80100c0b:	5f                   	pop    %edi
80100c0c:	5d                   	pop    %ebp
80100c0d:	c3                   	ret    
80100c0e:	66 90                	xchg   %ax,%ax
      flag = stat_obj.mode.flags.g_x;
80100c10:	c0 e8 03             	shr    $0x3,%al
80100c13:	83 e0 01             	and    $0x1,%eax
80100c16:	eb ab                	jmp    80100bc3 <exec+0x73>
80100c18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c1f:	90                   	nop
      flag = stat_obj.mode.flags.u_x;
80100c20:	0f b6 85 00 ff ff ff 	movzbl -0x100(%ebp),%eax
80100c27:	c0 e8 06             	shr    $0x6,%al
80100c2a:	83 e0 01             	and    $0x1,%eax
80100c2d:	eb 94                	jmp    80100bc3 <exec+0x73>
80100c2f:	90                   	nop
  if((pgdir = setupkvm()) == 0)
80100c30:	e8 ab 78 00 00       	call   801084e0 <setupkvm>
80100c35:	89 85 e4 fe ff ff    	mov    %eax,-0x11c(%ebp)
80100c3b:	85 c0                	test   %eax,%eax
80100c3d:	74 b1                	je     80100bf0 <exec+0xa0>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c3f:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100c46:	00 
80100c47:	8b bd 40 ff ff ff    	mov    -0xc0(%ebp),%edi
80100c4d:	0f 84 dd 02 00 00    	je     80100f30 <exec+0x3e0>
80100c53:	31 c0                	xor    %eax,%eax
80100c55:	89 b5 dc fe ff ff    	mov    %esi,-0x124(%ebp)
  sz = 0;
80100c5b:	c7 85 e0 fe ff ff 00 	movl   $0x0,-0x120(%ebp)
80100c62:	00 00 00 
80100c65:	89 c6                	mov    %eax,%esi
80100c67:	e9 8a 00 00 00       	jmp    80100cf6 <exec+0x1a6>
80100c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100c70:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100c77:	75 6c                	jne    80100ce5 <exec+0x195>
    if(ph.memsz < ph.filesz)
80100c79:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100c7f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100c85:	0f 82 87 00 00 00    	jb     80100d12 <exec+0x1c2>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100c8b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100c91:	72 7f                	jb     80100d12 <exec+0x1c2>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100c93:	83 ec 04             	sub    $0x4,%esp
80100c96:	50                   	push   %eax
80100c97:	ff b5 e0 fe ff ff    	pushl  -0x120(%ebp)
80100c9d:	ff b5 e4 fe ff ff    	pushl  -0x11c(%ebp)
80100ca3:	e8 58 76 00 00       	call   80108300 <allocuvm>
80100ca8:	83 c4 10             	add    $0x10,%esp
80100cab:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
80100cb1:	85 c0                	test   %eax,%eax
80100cb3:	74 5d                	je     80100d12 <exec+0x1c2>
    if(ph.vaddr % PGSIZE != 0)
80100cb5:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100cbb:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100cc0:	75 50                	jne    80100d12 <exec+0x1c2>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100cc2:	83 ec 0c             	sub    $0xc,%esp
80100cc5:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100ccb:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100cd1:	53                   	push   %ebx
80100cd2:	50                   	push   %eax
80100cd3:	ff b5 e4 fe ff ff    	pushl  -0x11c(%ebp)
80100cd9:	e8 62 75 00 00       	call   80108240 <loaduvm>
80100cde:	83 c4 20             	add    $0x20,%esp
80100ce1:	85 c0                	test   %eax,%eax
80100ce3:	78 2d                	js     80100d12 <exec+0x1c2>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100ce5:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100cec:	83 c6 01             	add    $0x1,%esi
80100cef:	83 c7 20             	add    $0x20,%edi
80100cf2:	39 f0                	cmp    %esi,%eax
80100cf4:	7e 3a                	jle    80100d30 <exec+0x1e0>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100cf6:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100cfc:	6a 20                	push   $0x20
80100cfe:	57                   	push   %edi
80100cff:	50                   	push   %eax
80100d00:	53                   	push   %ebx
80100d01:	e8 ea 0e 00 00       	call   80101bf0 <readi>
80100d06:	83 c4 10             	add    $0x10,%esp
80100d09:	83 f8 20             	cmp    $0x20,%eax
80100d0c:	0f 84 5e ff ff ff    	je     80100c70 <exec+0x120>
    freevm(pgdir);
80100d12:	83 ec 0c             	sub    $0xc,%esp
80100d15:	ff b5 e4 fe ff ff    	pushl  -0x11c(%ebp)
80100d1b:	e8 40 77 00 00       	call   80108460 <freevm>
  if(ip){
80100d20:	83 c4 10             	add    $0x10,%esp
80100d23:	e9 c8 fe ff ff       	jmp    80100bf0 <exec+0xa0>
80100d28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100d2f:	90                   	nop
80100d30:	8b bd e0 fe ff ff    	mov    -0x120(%ebp),%edi
80100d36:	8b b5 dc fe ff ff    	mov    -0x124(%ebp),%esi
80100d3c:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100d42:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100d48:	8d 87 00 20 00 00    	lea    0x2000(%edi),%eax
80100d4e:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
  iunlockput(ip);
80100d54:	83 ec 0c             	sub    $0xc,%esp
80100d57:	53                   	push   %ebx
80100d58:	e8 23 0e 00 00       	call   80101b80 <iunlockput>
  end_op();
80100d5d:	e8 1e 23 00 00       	call   80103080 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d62:	83 c4 0c             	add    $0xc,%esp
80100d65:	ff b5 e0 fe ff ff    	pushl  -0x120(%ebp)
80100d6b:	57                   	push   %edi
80100d6c:	8b bd e4 fe ff ff    	mov    -0x11c(%ebp),%edi
80100d72:	57                   	push   %edi
80100d73:	e8 88 75 00 00       	call   80108300 <allocuvm>
80100d78:	83 c4 10             	add    $0x10,%esp
80100d7b:	89 c3                	mov    %eax,%ebx
80100d7d:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
80100d83:	85 c0                	test   %eax,%eax
80100d85:	0f 84 8d 00 00 00    	je     80100e18 <exec+0x2c8>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d8b:	83 ec 08             	sub    $0x8,%esp
80100d8e:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100d94:	50                   	push   %eax
80100d95:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80100d96:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d98:	e8 e3 77 00 00       	call   80108580 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100d9d:	8b 45 0c             	mov    0xc(%ebp),%eax
80100da0:	83 c4 10             	add    $0x10,%esp
80100da3:	8b 00                	mov    (%eax),%eax
80100da5:	85 c0                	test   %eax,%eax
80100da7:	0f 84 94 01 00 00    	je     80100f41 <exec+0x3f1>
80100dad:	89 b5 dc fe ff ff    	mov    %esi,-0x124(%ebp)
80100db3:	8b b5 e4 fe ff ff    	mov    -0x11c(%ebp),%esi
80100db9:	eb 24                	jmp    80100ddf <exec+0x28f>
80100dbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100dbf:	90                   	nop
80100dc0:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100dc3:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100dca:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100dcd:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100dd3:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100dd6:	85 c0                	test   %eax,%eax
80100dd8:	74 78                	je     80100e52 <exec+0x302>
    if(argc >= MAXARG)
80100dda:	83 ff 20             	cmp    $0x20,%edi
80100ddd:	74 39                	je     80100e18 <exec+0x2c8>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ddf:	83 ec 0c             	sub    $0xc,%esp
80100de2:	50                   	push   %eax
80100de3:	e8 c8 4e 00 00       	call   80105cb0 <strlen>
80100de8:	f7 d0                	not    %eax
80100dea:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100dec:	58                   	pop    %eax
80100ded:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100df0:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100df3:	ff 34 b8             	pushl  (%eax,%edi,4)
80100df6:	e8 b5 4e 00 00       	call   80105cb0 <strlen>
80100dfb:	83 c0 01             	add    $0x1,%eax
80100dfe:	50                   	push   %eax
80100dff:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e02:	ff 34 b8             	pushl  (%eax,%edi,4)
80100e05:	53                   	push   %ebx
80100e06:	56                   	push   %esi
80100e07:	e8 c4 78 00 00       	call   801086d0 <copyout>
80100e0c:	83 c4 20             	add    $0x20,%esp
80100e0f:	85 c0                	test   %eax,%eax
80100e11:	79 ad                	jns    80100dc0 <exec+0x270>
80100e13:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e17:	90                   	nop
    freevm(pgdir);
80100e18:	83 ec 0c             	sub    $0xc,%esp
80100e1b:	ff b5 e4 fe ff ff    	pushl  -0x11c(%ebp)
80100e21:	e8 3a 76 00 00       	call   80108460 <freevm>
80100e26:	83 c4 10             	add    $0x10,%esp
  return -1;
80100e29:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100e2e:	e9 d3 fd ff ff       	jmp    80100c06 <exec+0xb6>
    end_op();
80100e33:	e8 48 22 00 00       	call   80103080 <end_op>
    cprintf("exec: fail\n");
80100e38:	83 ec 0c             	sub    $0xc,%esp
80100e3b:	68 e1 87 10 80       	push   $0x801087e1
80100e40:	e8 6b f8 ff ff       	call   801006b0 <cprintf>
    return -1;
80100e45:	83 c4 10             	add    $0x10,%esp
80100e48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100e4d:	e9 b4 fd ff ff       	jmp    80100c06 <exec+0xb6>
80100e52:	8b b5 dc fe ff ff    	mov    -0x124(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e58:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100e5f:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100e61:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100e68:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e6c:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100e6e:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80100e71:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80100e77:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e79:	50                   	push   %eax
80100e7a:	52                   	push   %edx
80100e7b:	53                   	push   %ebx
80100e7c:	ff b5 e4 fe ff ff    	pushl  -0x11c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80100e82:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100e89:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e8c:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e92:	e8 39 78 00 00       	call   801086d0 <copyout>
80100e97:	83 c4 10             	add    $0x10,%esp
80100e9a:	85 c0                	test   %eax,%eax
80100e9c:	0f 88 76 ff ff ff    	js     80100e18 <exec+0x2c8>
  for(last=s=path; *s; s++)
80100ea2:	8b 45 08             	mov    0x8(%ebp),%eax
80100ea5:	8b 55 08             	mov    0x8(%ebp),%edx
80100ea8:	0f b6 00             	movzbl (%eax),%eax
80100eab:	84 c0                	test   %al,%al
80100ead:	74 18                	je     80100ec7 <exec+0x377>
80100eaf:	89 d1                	mov    %edx,%ecx
80100eb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(*s == '/')
80100eb8:	83 c1 01             	add    $0x1,%ecx
80100ebb:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100ebd:	0f b6 01             	movzbl (%ecx),%eax
    if(*s == '/')
80100ec0:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100ec3:	84 c0                	test   %al,%al
80100ec5:	75 f1                	jne    80100eb8 <exec+0x368>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100ec7:	83 ec 04             	sub    $0x4,%esp
80100eca:	8d 46 6c             	lea    0x6c(%esi),%eax
80100ecd:	6a 10                	push   $0x10
80100ecf:	52                   	push   %edx
80100ed0:	50                   	push   %eax
80100ed1:	e8 9a 4d 00 00       	call   80105c70 <safestrcpy>
  if(stat_obj.mode.flags.setuid == 1)
80100ed6:	83 c4 10             	add    $0x10,%esp
80100ed9:	f6 85 01 ff ff ff 02 	testb  $0x2,-0xff(%ebp)
80100ee0:	74 0d                	je     80100eef <exec+0x39f>
      curproc->uid = stat_obj.uid;
80100ee2:	0f b7 85 fc fe ff ff 	movzwl -0x104(%ebp),%eax
80100ee9:	89 86 84 00 00 00    	mov    %eax,0x84(%esi)
  curproc->pgdir = pgdir;
80100eef:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  oldpgdir = curproc->pgdir;
80100ef5:	8b 7e 04             	mov    0x4(%esi),%edi
  switchuvm(curproc);
80100ef8:	83 ec 0c             	sub    $0xc,%esp
  curproc->pgdir = pgdir;
80100efb:	89 46 04             	mov    %eax,0x4(%esi)
  curproc->sz = sz;
80100efe:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
80100f04:	89 06                	mov    %eax,(%esi)
  curproc->tf->eip = elf.entry;  // main
80100f06:	8b 46 18             	mov    0x18(%esi),%eax
80100f09:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100f0f:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100f12:	8b 46 18             	mov    0x18(%esi),%eax
80100f15:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100f18:	56                   	push   %esi
80100f19:	e8 92 71 00 00       	call   801080b0 <switchuvm>
  freevm(oldpgdir);
80100f1e:	89 3c 24             	mov    %edi,(%esp)
80100f21:	e8 3a 75 00 00       	call   80108460 <freevm>
  return 0;
80100f26:	83 c4 10             	add    $0x10,%esp
80100f29:	31 c0                	xor    %eax,%eax
80100f2b:	e9 d6 fc ff ff       	jmp    80100c06 <exec+0xb6>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100f30:	c7 85 e0 fe ff ff 00 	movl   $0x2000,-0x120(%ebp)
80100f37:	20 00 00 
80100f3a:	31 ff                	xor    %edi,%edi
80100f3c:	e9 13 fe ff ff       	jmp    80100d54 <exec+0x204>
  for(argc = 0; argv[argc]; argc++) {
80100f41:	8b 9d e0 fe ff ff    	mov    -0x120(%ebp),%ebx
80100f47:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100f4d:	e9 06 ff ff ff       	jmp    80100e58 <exec+0x308>
80100f52:	66 90                	xchg   %ax,%ax
80100f54:	66 90                	xchg   %ax,%ax
80100f56:	66 90                	xchg   %ax,%ax
80100f58:	66 90                	xchg   %ax,%ax
80100f5a:	66 90                	xchg   %ax,%ax
80100f5c:	66 90                	xchg   %ax,%ax
80100f5e:	66 90                	xchg   %ax,%ax

80100f60 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f60:	55                   	push   %ebp
80100f61:	89 e5                	mov    %esp,%ebp
80100f63:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100f66:	68 ed 87 10 80       	push   $0x801087ed
80100f6b:	68 c0 47 11 80       	push   $0x801147c0
80100f70:	e8 bb 48 00 00       	call   80105830 <initlock>
}
80100f75:	83 c4 10             	add    $0x10,%esp
80100f78:	c9                   	leave  
80100f79:	c3                   	ret    
80100f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f80 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f80:	55                   	push   %ebp
80100f81:	89 e5                	mov    %esp,%ebp
80100f83:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f84:	bb f4 47 11 80       	mov    $0x801147f4,%ebx
{
80100f89:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100f8c:	68 c0 47 11 80       	push   $0x801147c0
80100f91:	e8 fa 49 00 00       	call   80105990 <acquire>
80100f96:	83 c4 10             	add    $0x10,%esp
80100f99:	eb 10                	jmp    80100fab <filealloc+0x2b>
80100f9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f9f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100fa0:	83 c3 18             	add    $0x18,%ebx
80100fa3:	81 fb 54 51 11 80    	cmp    $0x80115154,%ebx
80100fa9:	74 25                	je     80100fd0 <filealloc+0x50>
    if(f->ref == 0){
80100fab:	8b 43 04             	mov    0x4(%ebx),%eax
80100fae:	85 c0                	test   %eax,%eax
80100fb0:	75 ee                	jne    80100fa0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100fb2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100fb5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100fbc:	68 c0 47 11 80       	push   $0x801147c0
80100fc1:	e8 8a 4a 00 00       	call   80105a50 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100fc6:	89 d8                	mov    %ebx,%eax
      return f;
80100fc8:	83 c4 10             	add    $0x10,%esp
}
80100fcb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fce:	c9                   	leave  
80100fcf:	c3                   	ret    
  release(&ftable.lock);
80100fd0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100fd3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100fd5:	68 c0 47 11 80       	push   $0x801147c0
80100fda:	e8 71 4a 00 00       	call   80105a50 <release>
}
80100fdf:	89 d8                	mov    %ebx,%eax
  return 0;
80100fe1:	83 c4 10             	add    $0x10,%esp
}
80100fe4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fe7:	c9                   	leave  
80100fe8:	c3                   	ret    
80100fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100ff0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100ff0:	55                   	push   %ebp
80100ff1:	89 e5                	mov    %esp,%ebp
80100ff3:	53                   	push   %ebx
80100ff4:	83 ec 10             	sub    $0x10,%esp
80100ff7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100ffa:	68 c0 47 11 80       	push   $0x801147c0
80100fff:	e8 8c 49 00 00       	call   80105990 <acquire>
  if(f->ref < 1)
80101004:	8b 43 04             	mov    0x4(%ebx),%eax
80101007:	83 c4 10             	add    $0x10,%esp
8010100a:	85 c0                	test   %eax,%eax
8010100c:	7e 1a                	jle    80101028 <filedup+0x38>
    panic("filedup");
  f->ref++;
8010100e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101011:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101014:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101017:	68 c0 47 11 80       	push   $0x801147c0
8010101c:	e8 2f 4a 00 00       	call   80105a50 <release>
  return f;
}
80101021:	89 d8                	mov    %ebx,%eax
80101023:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101026:	c9                   	leave  
80101027:	c3                   	ret    
    panic("filedup");
80101028:	83 ec 0c             	sub    $0xc,%esp
8010102b:	68 f4 87 10 80       	push   $0x801087f4
80101030:	e8 5b f3 ff ff       	call   80100390 <panic>
80101035:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010103c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101040 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101040:	55                   	push   %ebp
80101041:	89 e5                	mov    %esp,%ebp
80101043:	57                   	push   %edi
80101044:	56                   	push   %esi
80101045:	53                   	push   %ebx
80101046:	83 ec 28             	sub    $0x28,%esp
80101049:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
8010104c:	68 c0 47 11 80       	push   $0x801147c0
80101051:	e8 3a 49 00 00       	call   80105990 <acquire>
  if(f->ref < 1)
80101056:	8b 43 04             	mov    0x4(%ebx),%eax
80101059:	83 c4 10             	add    $0x10,%esp
8010105c:	85 c0                	test   %eax,%eax
8010105e:	0f 8e a3 00 00 00    	jle    80101107 <fileclose+0xc7>
    panic("fileclose");
  if(--f->ref > 0){
80101064:	83 e8 01             	sub    $0x1,%eax
80101067:	89 43 04             	mov    %eax,0x4(%ebx)
8010106a:	75 44                	jne    801010b0 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
8010106c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101070:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80101073:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80101075:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
8010107b:	8b 73 0c             	mov    0xc(%ebx),%esi
8010107e:	88 45 e7             	mov    %al,-0x19(%ebp)
80101081:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80101084:	68 c0 47 11 80       	push   $0x801147c0
  ff = *f;
80101089:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
8010108c:	e8 bf 49 00 00       	call   80105a50 <release>

  if(ff.type == FD_PIPE)
80101091:	83 c4 10             	add    $0x10,%esp
80101094:	83 ff 01             	cmp    $0x1,%edi
80101097:	74 2f                	je     801010c8 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80101099:	83 ff 02             	cmp    $0x2,%edi
8010109c:	74 4a                	je     801010e8 <fileclose+0xa8>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
8010109e:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010a1:	5b                   	pop    %ebx
801010a2:	5e                   	pop    %esi
801010a3:	5f                   	pop    %edi
801010a4:	5d                   	pop    %ebp
801010a5:	c3                   	ret    
801010a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801010ad:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ftable.lock);
801010b0:	c7 45 08 c0 47 11 80 	movl   $0x801147c0,0x8(%ebp)
}
801010b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010ba:	5b                   	pop    %ebx
801010bb:	5e                   	pop    %esi
801010bc:	5f                   	pop    %edi
801010bd:	5d                   	pop    %ebp
    release(&ftable.lock);
801010be:	e9 8d 49 00 00       	jmp    80105a50 <release>
801010c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801010c7:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
801010c8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
801010cc:	83 ec 08             	sub    $0x8,%esp
801010cf:	53                   	push   %ebx
801010d0:	56                   	push   %esi
801010d1:	e8 ea 26 00 00       	call   801037c0 <pipeclose>
801010d6:	83 c4 10             	add    $0x10,%esp
}
801010d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010dc:	5b                   	pop    %ebx
801010dd:	5e                   	pop    %esi
801010de:	5f                   	pop    %edi
801010df:	5d                   	pop    %ebp
801010e0:	c3                   	ret    
801010e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
801010e8:	e8 23 1f 00 00       	call   80103010 <begin_op>
    iput(ff.ip);
801010ed:	83 ec 0c             	sub    $0xc,%esp
801010f0:	ff 75 e0             	pushl  -0x20(%ebp)
801010f3:	e8 28 09 00 00       	call   80101a20 <iput>
    end_op();
801010f8:	83 c4 10             	add    $0x10,%esp
}
801010fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010fe:	5b                   	pop    %ebx
801010ff:	5e                   	pop    %esi
80101100:	5f                   	pop    %edi
80101101:	5d                   	pop    %ebp
    end_op();
80101102:	e9 79 1f 00 00       	jmp    80103080 <end_op>
    panic("fileclose");
80101107:	83 ec 0c             	sub    $0xc,%esp
8010110a:	68 fc 87 10 80       	push   $0x801087fc
8010110f:	e8 7c f2 ff ff       	call   80100390 <panic>
80101114:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010111b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010111f:	90                   	nop

80101120 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101120:	55                   	push   %ebp
80101121:	89 e5                	mov    %esp,%ebp
80101123:	53                   	push   %ebx
80101124:	83 ec 04             	sub    $0x4,%esp
80101127:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010112a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010112d:	75 31                	jne    80101160 <filestat+0x40>
    ilock(f->ip);
8010112f:	83 ec 0c             	sub    $0xc,%esp
80101132:	ff 73 10             	pushl  0x10(%ebx)
80101135:	e8 96 07 00 00       	call   801018d0 <ilock>
    stati(f->ip, st);
8010113a:	58                   	pop    %eax
8010113b:	5a                   	pop    %edx
8010113c:	ff 75 0c             	pushl  0xc(%ebp)
8010113f:	ff 73 10             	pushl  0x10(%ebx)
80101142:	e8 59 0a 00 00       	call   80101ba0 <stati>
    iunlock(f->ip);
80101147:	59                   	pop    %ecx
80101148:	ff 73 10             	pushl  0x10(%ebx)
8010114b:	e8 80 08 00 00       	call   801019d0 <iunlock>
    return 0;
80101150:	83 c4 10             	add    $0x10,%esp
80101153:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80101155:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101158:	c9                   	leave  
80101159:	c3                   	ret    
8010115a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80101160:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101165:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101168:	c9                   	leave  
80101169:	c3                   	ret    
8010116a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101170 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101170:	55                   	push   %ebp
80101171:	89 e5                	mov    %esp,%ebp
80101173:	57                   	push   %edi
80101174:	56                   	push   %esi
80101175:	53                   	push   %ebx
80101176:	83 ec 0c             	sub    $0xc,%esp
80101179:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010117c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010117f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101182:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101186:	74 60                	je     801011e8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101188:	8b 03                	mov    (%ebx),%eax
8010118a:	83 f8 01             	cmp    $0x1,%eax
8010118d:	74 41                	je     801011d0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010118f:	83 f8 02             	cmp    $0x2,%eax
80101192:	75 5b                	jne    801011ef <fileread+0x7f>
    ilock(f->ip);
80101194:	83 ec 0c             	sub    $0xc,%esp
80101197:	ff 73 10             	pushl  0x10(%ebx)
8010119a:	e8 31 07 00 00       	call   801018d0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010119f:	57                   	push   %edi
801011a0:	ff 73 14             	pushl  0x14(%ebx)
801011a3:	56                   	push   %esi
801011a4:	ff 73 10             	pushl  0x10(%ebx)
801011a7:	e8 44 0a 00 00       	call   80101bf0 <readi>
801011ac:	83 c4 20             	add    $0x20,%esp
801011af:	89 c6                	mov    %eax,%esi
801011b1:	85 c0                	test   %eax,%eax
801011b3:	7e 03                	jle    801011b8 <fileread+0x48>
      f->off += r;
801011b5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
801011b8:	83 ec 0c             	sub    $0xc,%esp
801011bb:	ff 73 10             	pushl  0x10(%ebx)
801011be:	e8 0d 08 00 00       	call   801019d0 <iunlock>
    return r;
801011c3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
801011c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011c9:	89 f0                	mov    %esi,%eax
801011cb:	5b                   	pop    %ebx
801011cc:	5e                   	pop    %esi
801011cd:	5f                   	pop    %edi
801011ce:	5d                   	pop    %ebp
801011cf:	c3                   	ret    
    return piperead(f->pipe, addr, n);
801011d0:	8b 43 0c             	mov    0xc(%ebx),%eax
801011d3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801011d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011d9:	5b                   	pop    %ebx
801011da:	5e                   	pop    %esi
801011db:	5f                   	pop    %edi
801011dc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
801011dd:	e9 8e 27 00 00       	jmp    80103970 <piperead>
801011e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801011e8:	be ff ff ff ff       	mov    $0xffffffff,%esi
801011ed:	eb d7                	jmp    801011c6 <fileread+0x56>
  panic("fileread");
801011ef:	83 ec 0c             	sub    $0xc,%esp
801011f2:	68 06 88 10 80       	push   $0x80108806
801011f7:	e8 94 f1 ff ff       	call   80100390 <panic>
801011fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101200 <filewrite>:

// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101200:	55                   	push   %ebp
80101201:	89 e5                	mov    %esp,%ebp
80101203:	57                   	push   %edi
80101204:	56                   	push   %esi
80101205:	53                   	push   %ebx
80101206:	83 ec 1c             	sub    $0x1c,%esp
80101209:	8b 45 0c             	mov    0xc(%ebp),%eax
8010120c:	8b 75 08             	mov    0x8(%ebp),%esi
8010120f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101212:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101215:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101219:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010121c:	0f 84 bb 00 00 00    	je     801012dd <filewrite+0xdd>
    return -1;
  if(f->type == FD_PIPE)
80101222:	8b 06                	mov    (%esi),%eax
80101224:	83 f8 01             	cmp    $0x1,%eax
80101227:	0f 84 bf 00 00 00    	je     801012ec <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010122d:	83 f8 02             	cmp    $0x2,%eax
80101230:	0f 85 c8 00 00 00    	jne    801012fe <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101236:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101239:	31 ff                	xor    %edi,%edi
    while(i < n){
8010123b:	85 c0                	test   %eax,%eax
8010123d:	7f 30                	jg     8010126f <filewrite+0x6f>
8010123f:	e9 94 00 00 00       	jmp    801012d8 <filewrite+0xd8>
80101244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101248:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010124b:	83 ec 0c             	sub    $0xc,%esp
8010124e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101251:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101254:	e8 77 07 00 00       	call   801019d0 <iunlock>
      end_op();
80101259:	e8 22 1e 00 00       	call   80103080 <end_op>

      if(r < 0)
        break;
      if(r != n1)
8010125e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101261:	83 c4 10             	add    $0x10,%esp
80101264:	39 c3                	cmp    %eax,%ebx
80101266:	75 60                	jne    801012c8 <filewrite+0xc8>
        panic("short filewrite");
      i += r;
80101268:	01 df                	add    %ebx,%edi
    while(i < n){
8010126a:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
8010126d:	7e 69                	jle    801012d8 <filewrite+0xd8>
      int n1 = n - i;
8010126f:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101272:	b8 00 06 00 00       	mov    $0x600,%eax
80101277:	29 fb                	sub    %edi,%ebx
      if(n1 > max)
80101279:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
8010127f:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101282:	e8 89 1d 00 00       	call   80103010 <begin_op>
      ilock(f->ip);
80101287:	83 ec 0c             	sub    $0xc,%esp
8010128a:	ff 76 10             	pushl  0x10(%esi)
8010128d:	e8 3e 06 00 00       	call   801018d0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101292:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101295:	53                   	push   %ebx
80101296:	ff 76 14             	pushl  0x14(%esi)
80101299:	01 f8                	add    %edi,%eax
8010129b:	50                   	push   %eax
8010129c:	ff 76 10             	pushl  0x10(%esi)
8010129f:	e8 4c 0a 00 00       	call   80101cf0 <writei>
801012a4:	83 c4 20             	add    $0x20,%esp
801012a7:	85 c0                	test   %eax,%eax
801012a9:	7f 9d                	jg     80101248 <filewrite+0x48>
      iunlock(f->ip);
801012ab:	83 ec 0c             	sub    $0xc,%esp
801012ae:	ff 76 10             	pushl  0x10(%esi)
801012b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801012b4:	e8 17 07 00 00       	call   801019d0 <iunlock>
      end_op();
801012b9:	e8 c2 1d 00 00       	call   80103080 <end_op>
      if(r < 0)
801012be:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801012c1:	83 c4 10             	add    $0x10,%esp
801012c4:	85 c0                	test   %eax,%eax
801012c6:	75 15                	jne    801012dd <filewrite+0xdd>
        panic("short filewrite");
801012c8:	83 ec 0c             	sub    $0xc,%esp
801012cb:	68 0f 88 10 80       	push   $0x8010880f
801012d0:	e8 bb f0 ff ff       	call   80100390 <panic>
801012d5:	8d 76 00             	lea    0x0(%esi),%esi
    }
    return i == n ? n : -1;
801012d8:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801012db:	74 05                	je     801012e2 <filewrite+0xe2>
    return -1;
801012dd:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  }
  panic("filewrite");
}
801012e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012e5:	89 f8                	mov    %edi,%eax
801012e7:	5b                   	pop    %ebx
801012e8:	5e                   	pop    %esi
801012e9:	5f                   	pop    %edi
801012ea:	5d                   	pop    %ebp
801012eb:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
801012ec:	8b 46 0c             	mov    0xc(%esi),%eax
801012ef:	89 45 08             	mov    %eax,0x8(%ebp)
}
801012f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012f5:	5b                   	pop    %ebx
801012f6:	5e                   	pop    %esi
801012f7:	5f                   	pop    %edi
801012f8:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801012f9:	e9 62 25 00 00       	jmp    80103860 <pipewrite>
  panic("filewrite");
801012fe:	83 ec 0c             	sub    $0xc,%esp
80101301:	68 15 88 10 80       	push   $0x80108815
80101306:	e8 85 f0 ff ff       	call   80100390 <panic>
8010130b:	66 90                	xchg   %ax,%ax
8010130d:	66 90                	xchg   %ax,%ax
8010130f:	90                   	nop

80101310 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101310:	55                   	push   %ebp
80101311:	89 e5                	mov    %esp,%ebp
80101313:	57                   	push   %edi
80101314:	56                   	push   %esi
80101315:	53                   	push   %ebx
80101316:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101319:	8b 0d c0 51 11 80    	mov    0x801151c0,%ecx
{
8010131f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101322:	85 c9                	test   %ecx,%ecx
80101324:	0f 84 87 00 00 00    	je     801013b1 <balloc+0xa1>
8010132a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101331:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101334:	83 ec 08             	sub    $0x8,%esp
80101337:	89 f0                	mov    %esi,%eax
80101339:	c1 f8 0c             	sar    $0xc,%eax
8010133c:	03 05 d8 51 11 80    	add    0x801151d8,%eax
80101342:	50                   	push   %eax
80101343:	ff 75 d8             	pushl  -0x28(%ebp)
80101346:	e8 85 ed ff ff       	call   801000d0 <bread>
8010134b:	83 c4 10             	add    $0x10,%esp
8010134e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101351:	a1 c0 51 11 80       	mov    0x801151c0,%eax
80101356:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101359:	31 c0                	xor    %eax,%eax
8010135b:	eb 2f                	jmp    8010138c <balloc+0x7c>
8010135d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101360:	89 c1                	mov    %eax,%ecx
80101362:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101367:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
8010136a:	83 e1 07             	and    $0x7,%ecx
8010136d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010136f:	89 c1                	mov    %eax,%ecx
80101371:	c1 f9 03             	sar    $0x3,%ecx
80101374:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101379:	89 fa                	mov    %edi,%edx
8010137b:	85 df                	test   %ebx,%edi
8010137d:	74 41                	je     801013c0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010137f:	83 c0 01             	add    $0x1,%eax
80101382:	83 c6 01             	add    $0x1,%esi
80101385:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010138a:	74 05                	je     80101391 <balloc+0x81>
8010138c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010138f:	77 cf                	ja     80101360 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101391:	83 ec 0c             	sub    $0xc,%esp
80101394:	ff 75 e4             	pushl  -0x1c(%ebp)
80101397:	e8 54 ee ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010139c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801013a3:	83 c4 10             	add    $0x10,%esp
801013a6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801013a9:	39 05 c0 51 11 80    	cmp    %eax,0x801151c0
801013af:	77 80                	ja     80101331 <balloc+0x21>
  }
  panic("balloc: out of blocks");
801013b1:	83 ec 0c             	sub    $0xc,%esp
801013b4:	68 1f 88 10 80       	push   $0x8010881f
801013b9:	e8 d2 ef ff ff       	call   80100390 <panic>
801013be:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801013c0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801013c3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801013c6:	09 da                	or     %ebx,%edx
801013c8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801013cc:	57                   	push   %edi
801013cd:	e8 1e 1e 00 00       	call   801031f0 <log_write>
        brelse(bp);
801013d2:	89 3c 24             	mov    %edi,(%esp)
801013d5:	e8 16 ee ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
801013da:	58                   	pop    %eax
801013db:	5a                   	pop    %edx
801013dc:	56                   	push   %esi
801013dd:	ff 75 d8             	pushl  -0x28(%ebp)
801013e0:	e8 eb ec ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
801013e5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
801013e8:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801013ea:	8d 40 5c             	lea    0x5c(%eax),%eax
801013ed:	68 00 02 00 00       	push   $0x200
801013f2:	6a 00                	push   $0x0
801013f4:	50                   	push   %eax
801013f5:	e8 a6 46 00 00       	call   80105aa0 <memset>
  log_write(bp);
801013fa:	89 1c 24             	mov    %ebx,(%esp)
801013fd:	e8 ee 1d 00 00       	call   801031f0 <log_write>
  brelse(bp);
80101402:	89 1c 24             	mov    %ebx,(%esp)
80101405:	e8 e6 ed ff ff       	call   801001f0 <brelse>
}
8010140a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010140d:	89 f0                	mov    %esi,%eax
8010140f:	5b                   	pop    %ebx
80101410:	5e                   	pop    %esi
80101411:	5f                   	pop    %edi
80101412:	5d                   	pop    %ebp
80101413:	c3                   	ret    
80101414:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010141b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010141f:	90                   	nop

80101420 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101420:	55                   	push   %ebp
80101421:	89 e5                	mov    %esp,%ebp
80101423:	57                   	push   %edi
80101424:	89 c7                	mov    %eax,%edi
80101426:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101427:	31 f6                	xor    %esi,%esi
{
80101429:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010142a:	bb 14 52 11 80       	mov    $0x80115214,%ebx
{
8010142f:	83 ec 28             	sub    $0x28,%esp
80101432:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101435:	68 e0 51 11 80       	push   $0x801151e0
8010143a:	e8 51 45 00 00       	call   80105990 <acquire>
8010143f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101442:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101445:	eb 1b                	jmp    80101462 <iget+0x42>
80101447:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010144e:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101450:	39 3b                	cmp    %edi,(%ebx)
80101452:	74 6c                	je     801014c0 <iget+0xa0>
80101454:	81 c3 90 00 00 00    	add    $0x90,%ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010145a:	81 fb 34 6e 11 80    	cmp    $0x80116e34,%ebx
80101460:	73 26                	jae    80101488 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101462:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101465:	85 c9                	test   %ecx,%ecx
80101467:	7f e7                	jg     80101450 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101469:	85 f6                	test   %esi,%esi
8010146b:	75 e7                	jne    80101454 <iget+0x34>
8010146d:	8d 83 90 00 00 00    	lea    0x90(%ebx),%eax
80101473:	85 c9                	test   %ecx,%ecx
80101475:	75 70                	jne    801014e7 <iget+0xc7>
80101477:	89 de                	mov    %ebx,%esi
80101479:	89 c3                	mov    %eax,%ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010147b:	81 fb 34 6e 11 80    	cmp    $0x80116e34,%ebx
80101481:	72 df                	jb     80101462 <iget+0x42>
80101483:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101487:	90                   	nop
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101488:	85 f6                	test   %esi,%esi
8010148a:	74 74                	je     80101500 <iget+0xe0>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010148c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010148f:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101491:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101494:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
8010149b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801014a2:	68 e0 51 11 80       	push   $0x801151e0
801014a7:	e8 a4 45 00 00       	call   80105a50 <release>

  return ip;
801014ac:	83 c4 10             	add    $0x10,%esp
}
801014af:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014b2:	89 f0                	mov    %esi,%eax
801014b4:	5b                   	pop    %ebx
801014b5:	5e                   	pop    %esi
801014b6:	5f                   	pop    %edi
801014b7:	5d                   	pop    %ebp
801014b8:	c3                   	ret    
801014b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801014c0:	39 53 04             	cmp    %edx,0x4(%ebx)
801014c3:	75 8f                	jne    80101454 <iget+0x34>
      release(&icache.lock);
801014c5:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
801014c8:	83 c1 01             	add    $0x1,%ecx
      return ip;
801014cb:	89 de                	mov    %ebx,%esi
      ip->ref++;
801014cd:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801014d0:	68 e0 51 11 80       	push   $0x801151e0
801014d5:	e8 76 45 00 00       	call   80105a50 <release>
      return ip;
801014da:	83 c4 10             	add    $0x10,%esp
}
801014dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014e0:	89 f0                	mov    %esi,%eax
801014e2:	5b                   	pop    %ebx
801014e3:	5e                   	pop    %esi
801014e4:	5f                   	pop    %edi
801014e5:	5d                   	pop    %ebp
801014e6:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801014e7:	3d 34 6e 11 80       	cmp    $0x80116e34,%eax
801014ec:	73 12                	jae    80101500 <iget+0xe0>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801014ee:	8b 48 08             	mov    0x8(%eax),%ecx
801014f1:	89 c3                	mov    %eax,%ebx
801014f3:	85 c9                	test   %ecx,%ecx
801014f5:	0f 8f 55 ff ff ff    	jg     80101450 <iget+0x30>
801014fb:	e9 6d ff ff ff       	jmp    8010146d <iget+0x4d>
    panic("iget: no inodes");
80101500:	83 ec 0c             	sub    $0xc,%esp
80101503:	68 35 88 10 80       	push   $0x80108835
80101508:	e8 83 ee ff ff       	call   80100390 <panic>
8010150d:	8d 76 00             	lea    0x0(%esi),%esi

80101510 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101510:	55                   	push   %ebp
80101511:	89 e5                	mov    %esp,%ebp
80101513:	57                   	push   %edi
80101514:	56                   	push   %esi
80101515:	89 c6                	mov    %eax,%esi
80101517:	53                   	push   %ebx
80101518:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010151b:	83 fa 09             	cmp    $0x9,%edx
8010151e:	0f 86 84 00 00 00    	jbe    801015a8 <bmap+0x98>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101524:	8d 5a f6             	lea    -0xa(%edx),%ebx

  if(bn < NINDIRECT){
80101527:	83 fb 7f             	cmp    $0x7f,%ebx
8010152a:	0f 87 98 00 00 00    	ja     801015c8 <bmap+0xb8>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101530:	8b 90 84 00 00 00    	mov    0x84(%eax),%edx
80101536:	8b 00                	mov    (%eax),%eax
80101538:	85 d2                	test   %edx,%edx
8010153a:	74 54                	je     80101590 <bmap+0x80>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010153c:	83 ec 08             	sub    $0x8,%esp
8010153f:	52                   	push   %edx
80101540:	50                   	push   %eax
80101541:	e8 8a eb ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101546:	83 c4 10             	add    $0x10,%esp
80101549:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
    bp = bread(ip->dev, addr);
8010154d:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
8010154f:	8b 1a                	mov    (%edx),%ebx
80101551:	85 db                	test   %ebx,%ebx
80101553:	74 1b                	je     80101570 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101555:	83 ec 0c             	sub    $0xc,%esp
80101558:	57                   	push   %edi
80101559:	e8 92 ec ff ff       	call   801001f0 <brelse>
    return addr;
8010155e:	83 c4 10             	add    $0x10,%esp
  }

  panic("bmap: out of range");
}
80101561:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101564:	89 d8                	mov    %ebx,%eax
80101566:	5b                   	pop    %ebx
80101567:	5e                   	pop    %esi
80101568:	5f                   	pop    %edi
80101569:	5d                   	pop    %ebp
8010156a:	c3                   	ret    
8010156b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010156f:	90                   	nop
      a[bn] = addr = balloc(ip->dev);
80101570:	8b 06                	mov    (%esi),%eax
80101572:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101575:	e8 96 fd ff ff       	call   80101310 <balloc>
8010157a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
8010157d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101580:	89 c3                	mov    %eax,%ebx
80101582:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80101584:	57                   	push   %edi
80101585:	e8 66 1c 00 00       	call   801031f0 <log_write>
8010158a:	83 c4 10             	add    $0x10,%esp
8010158d:	eb c6                	jmp    80101555 <bmap+0x45>
8010158f:	90                   	nop
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101590:	e8 7b fd ff ff       	call   80101310 <balloc>
80101595:	89 c2                	mov    %eax,%edx
80101597:	89 86 84 00 00 00    	mov    %eax,0x84(%esi)
8010159d:	8b 06                	mov    (%esi),%eax
8010159f:	eb 9b                	jmp    8010153c <bmap+0x2c>
801015a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((addr = ip->addrs[bn]) == 0)
801015a8:	8d 3c 90             	lea    (%eax,%edx,4),%edi
801015ab:	8b 5f 5c             	mov    0x5c(%edi),%ebx
801015ae:	85 db                	test   %ebx,%ebx
801015b0:	75 af                	jne    80101561 <bmap+0x51>
      ip->addrs[bn] = addr = balloc(ip->dev);
801015b2:	8b 00                	mov    (%eax),%eax
801015b4:	e8 57 fd ff ff       	call   80101310 <balloc>
801015b9:	89 47 5c             	mov    %eax,0x5c(%edi)
801015bc:	89 c3                	mov    %eax,%ebx
}
801015be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801015c1:	89 d8                	mov    %ebx,%eax
801015c3:	5b                   	pop    %ebx
801015c4:	5e                   	pop    %esi
801015c5:	5f                   	pop    %edi
801015c6:	5d                   	pop    %ebp
801015c7:	c3                   	ret    
  panic("bmap: out of range");
801015c8:	83 ec 0c             	sub    $0xc,%esp
801015cb:	68 45 88 10 80       	push   $0x80108845
801015d0:	e8 bb ed ff ff       	call   80100390 <panic>
801015d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801015dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801015e0 <readsb>:
{
801015e0:	55                   	push   %ebp
801015e1:	89 e5                	mov    %esp,%ebp
801015e3:	56                   	push   %esi
801015e4:	53                   	push   %ebx
801015e5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801015e8:	83 ec 08             	sub    $0x8,%esp
801015eb:	6a 01                	push   $0x1
801015ed:	ff 75 08             	pushl  0x8(%ebp)
801015f0:	e8 db ea ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801015f5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801015f8:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801015fa:	8d 40 5c             	lea    0x5c(%eax),%eax
801015fd:	6a 1c                	push   $0x1c
801015ff:	50                   	push   %eax
80101600:	56                   	push   %esi
80101601:	e8 3a 45 00 00       	call   80105b40 <memmove>
  brelse(bp);
80101606:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101609:	83 c4 10             	add    $0x10,%esp
}
8010160c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010160f:	5b                   	pop    %ebx
80101610:	5e                   	pop    %esi
80101611:	5d                   	pop    %ebp
  brelse(bp);
80101612:	e9 d9 eb ff ff       	jmp    801001f0 <brelse>
80101617:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010161e:	66 90                	xchg   %ax,%ax

80101620 <bfree>:
{
80101620:	55                   	push   %ebp
80101621:	89 e5                	mov    %esp,%ebp
80101623:	56                   	push   %esi
80101624:	89 c6                	mov    %eax,%esi
80101626:	53                   	push   %ebx
80101627:	89 d3                	mov    %edx,%ebx
  readsb(dev, &sb);
80101629:	83 ec 08             	sub    $0x8,%esp
8010162c:	68 c0 51 11 80       	push   $0x801151c0
80101631:	50                   	push   %eax
80101632:	e8 a9 ff ff ff       	call   801015e0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101637:	58                   	pop    %eax
80101638:	5a                   	pop    %edx
80101639:	89 da                	mov    %ebx,%edx
8010163b:	c1 ea 0c             	shr    $0xc,%edx
8010163e:	03 15 d8 51 11 80    	add    0x801151d8,%edx
80101644:	52                   	push   %edx
80101645:	56                   	push   %esi
80101646:	e8 85 ea ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010164b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010164d:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
80101650:	ba 01 00 00 00       	mov    $0x1,%edx
80101655:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101658:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010165e:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101661:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101663:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101668:	85 d1                	test   %edx,%ecx
8010166a:	74 25                	je     80101691 <bfree+0x71>
  bp->data[bi/8] &= ~m;
8010166c:	f7 d2                	not    %edx
8010166e:	89 c6                	mov    %eax,%esi
  log_write(bp);
80101670:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101673:	21 ca                	and    %ecx,%edx
80101675:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101679:	56                   	push   %esi
8010167a:	e8 71 1b 00 00       	call   801031f0 <log_write>
  brelse(bp);
8010167f:	89 34 24             	mov    %esi,(%esp)
80101682:	e8 69 eb ff ff       	call   801001f0 <brelse>
}
80101687:	83 c4 10             	add    $0x10,%esp
8010168a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010168d:	5b                   	pop    %ebx
8010168e:	5e                   	pop    %esi
8010168f:	5d                   	pop    %ebp
80101690:	c3                   	ret    
    panic("freeing free block");
80101691:	83 ec 0c             	sub    $0xc,%esp
80101694:	68 58 88 10 80       	push   $0x80108858
80101699:	e8 f2 ec ff ff       	call   80100390 <panic>
8010169e:	66 90                	xchg   %ax,%ax

801016a0 <iinit>:
{
801016a0:	55                   	push   %ebp
801016a1:	89 e5                	mov    %esp,%ebp
801016a3:	53                   	push   %ebx
801016a4:	bb 20 52 11 80       	mov    $0x80115220,%ebx
801016a9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801016ac:	68 6b 88 10 80       	push   $0x8010886b
801016b1:	68 e0 51 11 80       	push   $0x801151e0
801016b6:	e8 75 41 00 00       	call   80105830 <initlock>
  for(i = 0; i < NINODE; i++) {
801016bb:	83 c4 10             	add    $0x10,%esp
801016be:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801016c0:	83 ec 08             	sub    $0x8,%esp
801016c3:	68 72 88 10 80       	push   $0x80108872
801016c8:	53                   	push   %ebx
801016c9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801016cf:	e8 4c 40 00 00       	call   80105720 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801016d4:	83 c4 10             	add    $0x10,%esp
801016d7:	81 fb 40 6e 11 80    	cmp    $0x80116e40,%ebx
801016dd:	75 e1                	jne    801016c0 <iinit+0x20>
  readsb(dev, &sb);
801016df:	83 ec 08             	sub    $0x8,%esp
801016e2:	68 c0 51 11 80       	push   $0x801151c0
801016e7:	ff 75 08             	pushl  0x8(%ebp)
801016ea:	e8 f1 fe ff ff       	call   801015e0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801016ef:	ff 35 d8 51 11 80    	pushl  0x801151d8
801016f5:	ff 35 d4 51 11 80    	pushl  0x801151d4
801016fb:	ff 35 d0 51 11 80    	pushl  0x801151d0
80101701:	ff 35 cc 51 11 80    	pushl  0x801151cc
80101707:	ff 35 c8 51 11 80    	pushl  0x801151c8
8010170d:	ff 35 c4 51 11 80    	pushl  0x801151c4
80101713:	ff 35 c0 51 11 80    	pushl  0x801151c0
80101719:	68 d8 88 10 80       	push   $0x801088d8
8010171e:	e8 8d ef ff ff       	call   801006b0 <cprintf>
}
80101723:	83 c4 30             	add    $0x30,%esp
80101726:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101729:	c9                   	leave  
8010172a:	c3                   	ret    
8010172b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010172f:	90                   	nop

80101730 <ialloc>:
{
80101730:	55                   	push   %ebp
80101731:	89 e5                	mov    %esp,%ebp
80101733:	57                   	push   %edi
80101734:	56                   	push   %esi
80101735:	53                   	push   %ebx
80101736:	83 ec 1c             	sub    $0x1c,%esp
80101739:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010173c:	83 3d c8 51 11 80 01 	cmpl   $0x1,0x801151c8
{
80101743:	8b 75 08             	mov    0x8(%ebp),%esi
80101746:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101749:	0f 86 9f 00 00 00    	jbe    801017ee <ialloc+0xbe>
8010174f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101754:	eb 21                	jmp    80101777 <ialloc+0x47>
80101756:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010175d:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80101760:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101763:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101766:	57                   	push   %edi
80101767:	e8 84 ea ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010176c:	83 c4 10             	add    $0x10,%esp
8010176f:	3b 1d c8 51 11 80    	cmp    0x801151c8,%ebx
80101775:	73 77                	jae    801017ee <ialloc+0xbe>
    bp = bread(dev, IBLOCK(inum, sb));
80101777:	89 d8                	mov    %ebx,%eax
80101779:	83 ec 08             	sub    $0x8,%esp
8010177c:	c1 e8 03             	shr    $0x3,%eax
8010177f:	03 05 d4 51 11 80    	add    0x801151d4,%eax
80101785:	50                   	push   %eax
80101786:	56                   	push   %esi
80101787:	e8 44 e9 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010178c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010178f:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
80101791:	89 d8                	mov    %ebx,%eax
80101793:	83 e0 07             	and    $0x7,%eax
80101796:	c1 e0 06             	shl    $0x6,%eax
80101799:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010179d:	66 83 39 00          	cmpw   $0x0,(%ecx)
801017a1:	75 bd                	jne    80101760 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801017a3:	83 ec 04             	sub    $0x4,%esp
801017a6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801017a9:	6a 40                	push   $0x40
801017ab:	6a 00                	push   $0x0
801017ad:	51                   	push   %ecx
801017ae:	e8 ed 42 00 00       	call   80105aa0 <memset>
      dip->type = type;
801017b3:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801017b6:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
      dip->uid = UID;
801017ba:	c7 41 08 00 00 00 00 	movl   $0x0,0x8(%ecx)
      dip->type = type;
801017c1:	66 89 01             	mov    %ax,(%ecx)
      dip->mode.asInt = DEFAULT_MODE;
801017c4:	c7 41 0c ed 01 00 00 	movl   $0x1ed,0xc(%ecx)
      log_write(bp);   // mark it allocated on the disk
801017cb:	89 3c 24             	mov    %edi,(%esp)
801017ce:	e8 1d 1a 00 00       	call   801031f0 <log_write>
      brelse(bp);
801017d3:	89 3c 24             	mov    %edi,(%esp)
801017d6:	e8 15 ea ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
801017db:	83 c4 10             	add    $0x10,%esp
}
801017de:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801017e1:	89 da                	mov    %ebx,%edx
801017e3:	89 f0                	mov    %esi,%eax
}
801017e5:	5b                   	pop    %ebx
801017e6:	5e                   	pop    %esi
801017e7:	5f                   	pop    %edi
801017e8:	5d                   	pop    %ebp
      return iget(dev, inum);
801017e9:	e9 32 fc ff ff       	jmp    80101420 <iget>
  panic("ialloc: no inodes");
801017ee:	83 ec 0c             	sub    $0xc,%esp
801017f1:	68 78 88 10 80       	push   $0x80108878
801017f6:	e8 95 eb ff ff       	call   80100390 <panic>
801017fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801017ff:	90                   	nop

80101800 <iupdate>:
{
80101800:	55                   	push   %ebp
80101801:	89 e5                	mov    %esp,%ebp
80101803:	56                   	push   %esi
80101804:	53                   	push   %ebx
80101805:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101808:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010180b:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010180e:	83 ec 08             	sub    $0x8,%esp
80101811:	c1 e8 03             	shr    $0x3,%eax
80101814:	03 05 d4 51 11 80    	add    0x801151d4,%eax
8010181a:	50                   	push   %eax
8010181b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010181e:	e8 ad e8 ff ff       	call   801000d0 <bread>
  dip->uid = ip->uid;
80101823:	0f b7 53 2c          	movzwl 0x2c(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101827:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010182a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010182c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010182f:	83 e0 07             	and    $0x7,%eax
80101832:	c1 e0 06             	shl    $0x6,%eax
80101835:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->uid = ip->uid;
80101839:	66 89 50 08          	mov    %dx,0x8(%eax)
  dip->gid = ip->gid;
8010183d:	0f b7 53 2e          	movzwl 0x2e(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101841:	83 c0 14             	add    $0x14,%eax
  dip->gid = ip->gid;
80101844:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->mode.asInt = ip->mode.asInt;
80101848:	8b 53 30             	mov    0x30(%ebx),%edx
8010184b:	89 50 f8             	mov    %edx,-0x8(%eax)
  dip->type = ip->type;
8010184e:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
80101852:	66 89 50 ec          	mov    %dx,-0x14(%eax)
  dip->major = ip->major;
80101856:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
8010185a:	66 89 50 ee          	mov    %dx,-0x12(%eax)
  dip->minor = ip->minor;
8010185e:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
80101862:	66 89 50 f0          	mov    %dx,-0x10(%eax)
  dip->nlink = ip->nlink;
80101866:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
8010186a:	66 89 50 f2          	mov    %dx,-0xe(%eax)
  dip->size = ip->size;
8010186e:	8b 53 fc             	mov    -0x4(%ebx),%edx
80101871:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101874:	6a 2c                	push   $0x2c
80101876:	53                   	push   %ebx
80101877:	50                   	push   %eax
80101878:	e8 c3 42 00 00       	call   80105b40 <memmove>
  log_write(bp);
8010187d:	89 34 24             	mov    %esi,(%esp)
80101880:	e8 6b 19 00 00       	call   801031f0 <log_write>
  brelse(bp);
80101885:	89 75 08             	mov    %esi,0x8(%ebp)
80101888:	83 c4 10             	add    $0x10,%esp
}
8010188b:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010188e:	5b                   	pop    %ebx
8010188f:	5e                   	pop    %esi
80101890:	5d                   	pop    %ebp
  brelse(bp);
80101891:	e9 5a e9 ff ff       	jmp    801001f0 <brelse>
80101896:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010189d:	8d 76 00             	lea    0x0(%esi),%esi

801018a0 <idup>:
{
801018a0:	55                   	push   %ebp
801018a1:	89 e5                	mov    %esp,%ebp
801018a3:	53                   	push   %ebx
801018a4:	83 ec 10             	sub    $0x10,%esp
801018a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801018aa:	68 e0 51 11 80       	push   $0x801151e0
801018af:	e8 dc 40 00 00       	call   80105990 <acquire>
  ip->ref++;
801018b4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801018b8:	c7 04 24 e0 51 11 80 	movl   $0x801151e0,(%esp)
801018bf:	e8 8c 41 00 00       	call   80105a50 <release>
}
801018c4:	89 d8                	mov    %ebx,%eax
801018c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801018c9:	c9                   	leave  
801018ca:	c3                   	ret    
801018cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801018cf:	90                   	nop

801018d0 <ilock>:
{
801018d0:	55                   	push   %ebp
801018d1:	89 e5                	mov    %esp,%ebp
801018d3:	56                   	push   %esi
801018d4:	53                   	push   %ebx
801018d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801018d8:	85 db                	test   %ebx,%ebx
801018da:	0f 84 d7 00 00 00    	je     801019b7 <ilock+0xe7>
801018e0:	8b 53 08             	mov    0x8(%ebx),%edx
801018e3:	85 d2                	test   %edx,%edx
801018e5:	0f 8e cc 00 00 00    	jle    801019b7 <ilock+0xe7>
  acquiresleep(&ip->lock);
801018eb:	83 ec 0c             	sub    $0xc,%esp
801018ee:	8d 43 0c             	lea    0xc(%ebx),%eax
801018f1:	50                   	push   %eax
801018f2:	e8 69 3e 00 00       	call   80105760 <acquiresleep>
  if(ip->valid == 0){
801018f7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801018fa:	83 c4 10             	add    $0x10,%esp
801018fd:	85 c0                	test   %eax,%eax
801018ff:	74 0f                	je     80101910 <ilock+0x40>
}
80101901:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101904:	5b                   	pop    %ebx
80101905:	5e                   	pop    %esi
80101906:	5d                   	pop    %ebp
80101907:	c3                   	ret    
80101908:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010190f:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101910:	8b 43 04             	mov    0x4(%ebx),%eax
80101913:	83 ec 08             	sub    $0x8,%esp
80101916:	c1 e8 03             	shr    $0x3,%eax
80101919:	03 05 d4 51 11 80    	add    0x801151d4,%eax
8010191f:	50                   	push   %eax
80101920:	ff 33                	pushl  (%ebx)
80101922:	e8 a9 e7 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101927:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010192a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010192c:	8b 43 04             	mov    0x4(%ebx),%eax
8010192f:	83 e0 07             	and    $0x7,%eax
80101932:	c1 e0 06             	shl    $0x6,%eax
80101935:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->uid = dip->uid;
80101939:	0f b7 50 08          	movzwl 0x8(%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010193d:	83 c0 14             	add    $0x14,%eax
    ip->uid = dip->uid;
80101940:	66 89 93 88 00 00 00 	mov    %dx,0x88(%ebx)
    ip->gid = dip->gid;
80101947:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
8010194b:	66 89 93 8a 00 00 00 	mov    %dx,0x8a(%ebx)
    ip->mode.asInt = dip->mode.asInt;
80101952:	8b 50 f8             	mov    -0x8(%eax),%edx
80101955:	89 93 8c 00 00 00    	mov    %edx,0x8c(%ebx)
    ip->type = dip->type;
8010195b:	0f b7 50 ec          	movzwl -0x14(%eax),%edx
8010195f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101963:	0f b7 50 ee          	movzwl -0x12(%eax),%edx
80101967:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010196b:	0f b7 50 f0          	movzwl -0x10(%eax),%edx
8010196f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101973:	0f b7 50 f2          	movzwl -0xe(%eax),%edx
80101977:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010197b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010197e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101981:	6a 2c                	push   $0x2c
80101983:	50                   	push   %eax
80101984:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101987:	50                   	push   %eax
80101988:	e8 b3 41 00 00       	call   80105b40 <memmove>
    brelse(bp);
8010198d:	89 34 24             	mov    %esi,(%esp)
80101990:	e8 5b e8 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101995:	83 c4 10             	add    $0x10,%esp
80101998:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010199d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801019a4:	0f 85 57 ff ff ff    	jne    80101901 <ilock+0x31>
      panic("ilock: no type");
801019aa:	83 ec 0c             	sub    $0xc,%esp
801019ad:	68 90 88 10 80       	push   $0x80108890
801019b2:	e8 d9 e9 ff ff       	call   80100390 <panic>
    panic("ilock");
801019b7:	83 ec 0c             	sub    $0xc,%esp
801019ba:	68 8a 88 10 80       	push   $0x8010888a
801019bf:	e8 cc e9 ff ff       	call   80100390 <panic>
801019c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801019cf:	90                   	nop

801019d0 <iunlock>:
{
801019d0:	55                   	push   %ebp
801019d1:	89 e5                	mov    %esp,%ebp
801019d3:	56                   	push   %esi
801019d4:	53                   	push   %ebx
801019d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801019d8:	85 db                	test   %ebx,%ebx
801019da:	74 28                	je     80101a04 <iunlock+0x34>
801019dc:	83 ec 0c             	sub    $0xc,%esp
801019df:	8d 73 0c             	lea    0xc(%ebx),%esi
801019e2:	56                   	push   %esi
801019e3:	e8 18 3e 00 00       	call   80105800 <holdingsleep>
801019e8:	83 c4 10             	add    $0x10,%esp
801019eb:	85 c0                	test   %eax,%eax
801019ed:	74 15                	je     80101a04 <iunlock+0x34>
801019ef:	8b 43 08             	mov    0x8(%ebx),%eax
801019f2:	85 c0                	test   %eax,%eax
801019f4:	7e 0e                	jle    80101a04 <iunlock+0x34>
  releasesleep(&ip->lock);
801019f6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801019f9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801019fc:	5b                   	pop    %ebx
801019fd:	5e                   	pop    %esi
801019fe:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801019ff:	e9 bc 3d 00 00       	jmp    801057c0 <releasesleep>
    panic("iunlock");
80101a04:	83 ec 0c             	sub    $0xc,%esp
80101a07:	68 9f 88 10 80       	push   $0x8010889f
80101a0c:	e8 7f e9 ff ff       	call   80100390 <panic>
80101a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a1f:	90                   	nop

80101a20 <iput>:
{
80101a20:	55                   	push   %ebp
80101a21:	89 e5                	mov    %esp,%ebp
80101a23:	57                   	push   %edi
80101a24:	56                   	push   %esi
80101a25:	53                   	push   %ebx
80101a26:	83 ec 28             	sub    $0x28,%esp
80101a29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
80101a2c:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101a2f:	57                   	push   %edi
80101a30:	e8 2b 3d 00 00       	call   80105760 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101a35:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101a38:	83 c4 10             	add    $0x10,%esp
80101a3b:	85 d2                	test   %edx,%edx
80101a3d:	74 07                	je     80101a46 <iput+0x26>
80101a3f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101a44:	74 32                	je     80101a78 <iput+0x58>
  releasesleep(&ip->lock);
80101a46:	83 ec 0c             	sub    $0xc,%esp
80101a49:	57                   	push   %edi
80101a4a:	e8 71 3d 00 00       	call   801057c0 <releasesleep>
  acquire(&icache.lock);
80101a4f:	c7 04 24 e0 51 11 80 	movl   $0x801151e0,(%esp)
80101a56:	e8 35 3f 00 00       	call   80105990 <acquire>
  ip->ref--;
80101a5b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101a5f:	83 c4 10             	add    $0x10,%esp
80101a62:	c7 45 08 e0 51 11 80 	movl   $0x801151e0,0x8(%ebp)
}
80101a69:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a6c:	5b                   	pop    %ebx
80101a6d:	5e                   	pop    %esi
80101a6e:	5f                   	pop    %edi
80101a6f:	5d                   	pop    %ebp
  release(&icache.lock);
80101a70:	e9 db 3f 00 00       	jmp    80105a50 <release>
80101a75:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101a78:	83 ec 0c             	sub    $0xc,%esp
80101a7b:	68 e0 51 11 80       	push   $0x801151e0
80101a80:	e8 0b 3f 00 00       	call   80105990 <acquire>
    int r = ip->ref;
80101a85:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101a88:	c7 04 24 e0 51 11 80 	movl   $0x801151e0,(%esp)
80101a8f:	e8 bc 3f 00 00       	call   80105a50 <release>
    if(r == 1){
80101a94:	83 c4 10             	add    $0x10,%esp
80101a97:	83 fe 01             	cmp    $0x1,%esi
80101a9a:	75 aa                	jne    80101a46 <iput+0x26>
80101a9c:	8d 8b 84 00 00 00    	lea    0x84(%ebx),%ecx
80101aa2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101aa5:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101aa8:	89 cf                	mov    %ecx,%edi
80101aaa:	eb 0b                	jmp    80101ab7 <iput+0x97>
80101aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ab0:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101ab3:	39 fe                	cmp    %edi,%esi
80101ab5:	74 19                	je     80101ad0 <iput+0xb0>
    if(ip->addrs[i]){
80101ab7:	8b 16                	mov    (%esi),%edx
80101ab9:	85 d2                	test   %edx,%edx
80101abb:	74 f3                	je     80101ab0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101abd:	8b 03                	mov    (%ebx),%eax
80101abf:	e8 5c fb ff ff       	call   80101620 <bfree>
      ip->addrs[i] = 0;
80101ac4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101aca:	eb e4                	jmp    80101ab0 <iput+0x90>
80101acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101ad0:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80101ad6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101ad9:	85 c0                	test   %eax,%eax
80101adb:	75 33                	jne    80101b10 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101add:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101ae0:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101ae7:	53                   	push   %ebx
80101ae8:	e8 13 fd ff ff       	call   80101800 <iupdate>
      ip->type = 0;
80101aed:	31 c0                	xor    %eax,%eax
80101aef:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101af3:	89 1c 24             	mov    %ebx,(%esp)
80101af6:	e8 05 fd ff ff       	call   80101800 <iupdate>
      ip->valid = 0;
80101afb:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101b02:	83 c4 10             	add    $0x10,%esp
80101b05:	e9 3c ff ff ff       	jmp    80101a46 <iput+0x26>
80101b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101b10:	83 ec 08             	sub    $0x8,%esp
80101b13:	50                   	push   %eax
80101b14:	ff 33                	pushl  (%ebx)
80101b16:	e8 b5 e5 ff ff       	call   801000d0 <bread>
80101b1b:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101b1e:	83 c4 10             	add    $0x10,%esp
80101b21:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101b27:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101b2a:	8d 70 5c             	lea    0x5c(%eax),%esi
80101b2d:	89 cf                	mov    %ecx,%edi
80101b2f:	eb 0e                	jmp    80101b3f <iput+0x11f>
80101b31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b38:	83 c6 04             	add    $0x4,%esi
80101b3b:	39 f7                	cmp    %esi,%edi
80101b3d:	74 11                	je     80101b50 <iput+0x130>
      if(a[j])
80101b3f:	8b 16                	mov    (%esi),%edx
80101b41:	85 d2                	test   %edx,%edx
80101b43:	74 f3                	je     80101b38 <iput+0x118>
        bfree(ip->dev, a[j]);
80101b45:	8b 03                	mov    (%ebx),%eax
80101b47:	e8 d4 fa ff ff       	call   80101620 <bfree>
80101b4c:	eb ea                	jmp    80101b38 <iput+0x118>
80101b4e:	66 90                	xchg   %ax,%ax
    brelse(bp);
80101b50:	83 ec 0c             	sub    $0xc,%esp
80101b53:	ff 75 e4             	pushl  -0x1c(%ebp)
80101b56:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101b59:	e8 92 e6 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101b5e:	8b 93 84 00 00 00    	mov    0x84(%ebx),%edx
80101b64:	8b 03                	mov    (%ebx),%eax
80101b66:	e8 b5 fa ff ff       	call   80101620 <bfree>
    ip->addrs[NDIRECT] = 0;
80101b6b:	83 c4 10             	add    $0x10,%esp
80101b6e:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80101b75:	00 00 00 
80101b78:	e9 60 ff ff ff       	jmp    80101add <iput+0xbd>
80101b7d:	8d 76 00             	lea    0x0(%esi),%esi

80101b80 <iunlockput>:
{
80101b80:	55                   	push   %ebp
80101b81:	89 e5                	mov    %esp,%ebp
80101b83:	53                   	push   %ebx
80101b84:	83 ec 10             	sub    $0x10,%esp
80101b87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101b8a:	53                   	push   %ebx
80101b8b:	e8 40 fe ff ff       	call   801019d0 <iunlock>
  iput(ip);
80101b90:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101b93:	83 c4 10             	add    $0x10,%esp
}
80101b96:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101b99:	c9                   	leave  
  iput(ip);
80101b9a:	e9 81 fe ff ff       	jmp    80101a20 <iput>
80101b9f:	90                   	nop

80101ba0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101ba0:	55                   	push   %ebp
80101ba1:	89 e5                	mov    %esp,%ebp
80101ba3:	8b 55 08             	mov    0x8(%ebp),%edx
80101ba6:	8b 45 0c             	mov    0xc(%ebp),%eax
#ifdef CS333_P5
    st->uid = ip->uid;
80101ba9:	0f b7 8a 88 00 00 00 	movzwl 0x88(%edx),%ecx
80101bb0:	66 89 48 14          	mov    %cx,0x14(%eax)
    st->gid = ip->gid;
80101bb4:	0f b7 8a 8a 00 00 00 	movzwl 0x8a(%edx),%ecx
80101bbb:	66 89 48 16          	mov    %cx,0x16(%eax)
    st->mode.asInt = ip->mode.asInt;
80101bbf:	8b 8a 8c 00 00 00    	mov    0x8c(%edx),%ecx
80101bc5:	89 48 18             	mov    %ecx,0x18(%eax)
#endif
  st->dev = ip->dev;
80101bc8:	8b 0a                	mov    (%edx),%ecx
80101bca:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101bcd:	8b 4a 04             	mov    0x4(%edx),%ecx
80101bd0:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101bd3:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101bd7:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101bda:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101bde:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101be2:	8b 52 58             	mov    0x58(%edx),%edx
80101be5:	89 50 10             	mov    %edx,0x10(%eax)
}
80101be8:	5d                   	pop    %ebp
80101be9:	c3                   	ret    
80101bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101bf0 <readi>:

// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101bf0:	55                   	push   %ebp
80101bf1:	89 e5                	mov    %esp,%ebp
80101bf3:	57                   	push   %edi
80101bf4:	56                   	push   %esi
80101bf5:	53                   	push   %ebx
80101bf6:	83 ec 1c             	sub    $0x1c,%esp
80101bf9:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101bfc:	8b 45 08             	mov    0x8(%ebp),%eax
80101bff:	8b 75 10             	mov    0x10(%ebp),%esi
80101c02:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101c05:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101c08:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101c0d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101c10:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101c13:	0f 84 a7 00 00 00    	je     80101cc0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101c19:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c1c:	8b 40 58             	mov    0x58(%eax),%eax
80101c1f:	39 c6                	cmp    %eax,%esi
80101c21:	0f 87 ba 00 00 00    	ja     80101ce1 <readi+0xf1>
80101c27:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101c2a:	31 c9                	xor    %ecx,%ecx
80101c2c:	89 da                	mov    %ebx,%edx
80101c2e:	01 f2                	add    %esi,%edx
80101c30:	0f 92 c1             	setb   %cl
80101c33:	89 cf                	mov    %ecx,%edi
80101c35:	0f 82 a6 00 00 00    	jb     80101ce1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101c3b:	89 c1                	mov    %eax,%ecx
80101c3d:	29 f1                	sub    %esi,%ecx
80101c3f:	39 d0                	cmp    %edx,%eax
80101c41:	0f 43 cb             	cmovae %ebx,%ecx
80101c44:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c47:	85 c9                	test   %ecx,%ecx
80101c49:	74 67                	je     80101cb2 <readi+0xc2>
80101c4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c4f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c50:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101c53:	89 f2                	mov    %esi,%edx
80101c55:	c1 ea 09             	shr    $0x9,%edx
80101c58:	89 d8                	mov    %ebx,%eax
80101c5a:	e8 b1 f8 ff ff       	call   80101510 <bmap>
80101c5f:	83 ec 08             	sub    $0x8,%esp
80101c62:	50                   	push   %eax
80101c63:	ff 33                	pushl  (%ebx)
80101c65:	e8 66 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101c6a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101c6d:	b9 00 02 00 00       	mov    $0x200,%ecx
80101c72:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c75:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101c77:	89 f0                	mov    %esi,%eax
80101c79:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c7e:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101c80:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101c83:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101c85:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c89:	39 d9                	cmp    %ebx,%ecx
80101c8b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101c8e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c8f:	01 df                	add    %ebx,%edi
80101c91:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101c93:	50                   	push   %eax
80101c94:	ff 75 e0             	pushl  -0x20(%ebp)
80101c97:	e8 a4 3e 00 00       	call   80105b40 <memmove>
    brelse(bp);
80101c9c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101c9f:	89 14 24             	mov    %edx,(%esp)
80101ca2:	e8 49 e5 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ca7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101caa:	83 c4 10             	add    $0x10,%esp
80101cad:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101cb0:	77 9e                	ja     80101c50 <readi+0x60>
  }
  return n;
80101cb2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101cb5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cb8:	5b                   	pop    %ebx
80101cb9:	5e                   	pop    %esi
80101cba:	5f                   	pop    %edi
80101cbb:	5d                   	pop    %ebp
80101cbc:	c3                   	ret    
80101cbd:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101cc0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101cc4:	66 83 f8 09          	cmp    $0x9,%ax
80101cc8:	77 17                	ja     80101ce1 <readi+0xf1>
80101cca:	8b 04 c5 60 51 11 80 	mov    -0x7feeaea0(,%eax,8),%eax
80101cd1:	85 c0                	test   %eax,%eax
80101cd3:	74 0c                	je     80101ce1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101cd5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101cd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cdb:	5b                   	pop    %ebx
80101cdc:	5e                   	pop    %esi
80101cdd:	5f                   	pop    %edi
80101cde:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101cdf:	ff e0                	jmp    *%eax
      return -1;
80101ce1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ce6:	eb cd                	jmp    80101cb5 <readi+0xc5>
80101ce8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cef:	90                   	nop

80101cf0 <writei>:

// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101cf0:	55                   	push   %ebp
80101cf1:	89 e5                	mov    %esp,%ebp
80101cf3:	57                   	push   %edi
80101cf4:	56                   	push   %esi
80101cf5:	53                   	push   %ebx
80101cf6:	83 ec 1c             	sub    $0x1c,%esp
80101cf9:	8b 45 08             	mov    0x8(%ebp),%eax
80101cfc:	8b 75 0c             	mov    0xc(%ebp),%esi
80101cff:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101d02:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101d07:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101d0a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101d0d:	8b 75 10             	mov    0x10(%ebp),%esi
80101d10:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101d13:	0f 84 b7 00 00 00    	je     80101dd0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101d19:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101d1c:	39 70 58             	cmp    %esi,0x58(%eax)
80101d1f:	0f 82 e7 00 00 00    	jb     80101e0c <writei+0x11c>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101d25:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101d28:	89 f8                	mov    %edi,%eax
80101d2a:	01 f0                	add    %esi,%eax
80101d2c:	0f 82 da 00 00 00    	jb     80101e0c <writei+0x11c>
80101d32:	3d 00 14 01 00       	cmp    $0x11400,%eax
80101d37:	0f 87 cf 00 00 00    	ja     80101e0c <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d3d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101d44:	85 ff                	test   %edi,%edi
80101d46:	74 79                	je     80101dc1 <writei+0xd1>
80101d48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d4f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d50:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101d53:	89 f2                	mov    %esi,%edx
80101d55:	c1 ea 09             	shr    $0x9,%edx
80101d58:	89 f8                	mov    %edi,%eax
80101d5a:	e8 b1 f7 ff ff       	call   80101510 <bmap>
80101d5f:	83 ec 08             	sub    $0x8,%esp
80101d62:	50                   	push   %eax
80101d63:	ff 37                	pushl  (%edi)
80101d65:	e8 66 e3 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101d6a:	b9 00 02 00 00       	mov    $0x200,%ecx
80101d6f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101d72:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d75:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101d77:	89 f0                	mov    %esi,%eax
80101d79:	83 c4 0c             	add    $0xc,%esp
80101d7c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101d81:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101d83:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101d87:	39 d9                	cmp    %ebx,%ecx
80101d89:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101d8c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d8d:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101d8f:	ff 75 dc             	pushl  -0x24(%ebp)
80101d92:	50                   	push   %eax
80101d93:	e8 a8 3d 00 00       	call   80105b40 <memmove>
    log_write(bp);
80101d98:	89 3c 24             	mov    %edi,(%esp)
80101d9b:	e8 50 14 00 00       	call   801031f0 <log_write>
    brelse(bp);
80101da0:	89 3c 24             	mov    %edi,(%esp)
80101da3:	e8 48 e4 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101da8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101dab:	83 c4 10             	add    $0x10,%esp
80101dae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101db1:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101db4:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101db7:	77 97                	ja     80101d50 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101db9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101dbc:	3b 70 58             	cmp    0x58(%eax),%esi
80101dbf:	77 37                	ja     80101df8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101dc1:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101dc4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dc7:	5b                   	pop    %ebx
80101dc8:	5e                   	pop    %esi
80101dc9:	5f                   	pop    %edi
80101dca:	5d                   	pop    %ebp
80101dcb:	c3                   	ret    
80101dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101dd0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101dd4:	66 83 f8 09          	cmp    $0x9,%ax
80101dd8:	77 32                	ja     80101e0c <writei+0x11c>
80101dda:	8b 04 c5 64 51 11 80 	mov    -0x7feeae9c(,%eax,8),%eax
80101de1:	85 c0                	test   %eax,%eax
80101de3:	74 27                	je     80101e0c <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80101de5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101de8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101deb:	5b                   	pop    %ebx
80101dec:	5e                   	pop    %esi
80101ded:	5f                   	pop    %edi
80101dee:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101def:	ff e0                	jmp    *%eax
80101df1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101df8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101dfb:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101dfe:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101e01:	50                   	push   %eax
80101e02:	e8 f9 f9 ff ff       	call   80101800 <iupdate>
80101e07:	83 c4 10             	add    $0x10,%esp
80101e0a:	eb b5                	jmp    80101dc1 <writei+0xd1>
      return -1;
80101e0c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e11:	eb b1                	jmp    80101dc4 <writei+0xd4>
80101e13:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101e20 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
80101e20:	55                   	push   %ebp
80101e21:	89 e5                	mov    %esp,%ebp
80101e23:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101e26:	6a 0e                	push   $0xe
80101e28:	ff 75 0c             	pushl  0xc(%ebp)
80101e2b:	ff 75 08             	pushl  0x8(%ebp)
80101e2e:	e8 7d 3d 00 00       	call   80105bb0 <strncmp>
}
80101e33:	c9                   	leave  
80101e34:	c3                   	ret    
80101e35:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e40 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101e40:	55                   	push   %ebp
80101e41:	89 e5                	mov    %esp,%ebp
80101e43:	57                   	push   %edi
80101e44:	56                   	push   %esi
80101e45:	53                   	push   %ebx
80101e46:	83 ec 1c             	sub    $0x1c,%esp
80101e49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101e4c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101e51:	0f 85 85 00 00 00    	jne    80101edc <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101e57:	8b 53 58             	mov    0x58(%ebx),%edx
80101e5a:	31 ff                	xor    %edi,%edi
80101e5c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e5f:	85 d2                	test   %edx,%edx
80101e61:	74 3e                	je     80101ea1 <dirlookup+0x61>
80101e63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101e67:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e68:	6a 10                	push   $0x10
80101e6a:	57                   	push   %edi
80101e6b:	56                   	push   %esi
80101e6c:	53                   	push   %ebx
80101e6d:	e8 7e fd ff ff       	call   80101bf0 <readi>
80101e72:	83 c4 10             	add    $0x10,%esp
80101e75:	83 f8 10             	cmp    $0x10,%eax
80101e78:	75 55                	jne    80101ecf <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101e7a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e7f:	74 18                	je     80101e99 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101e81:	83 ec 04             	sub    $0x4,%esp
80101e84:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e87:	6a 0e                	push   $0xe
80101e89:	50                   	push   %eax
80101e8a:	ff 75 0c             	pushl  0xc(%ebp)
80101e8d:	e8 1e 3d 00 00       	call   80105bb0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101e92:	83 c4 10             	add    $0x10,%esp
80101e95:	85 c0                	test   %eax,%eax
80101e97:	74 17                	je     80101eb0 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e99:	83 c7 10             	add    $0x10,%edi
80101e9c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e9f:	72 c7                	jb     80101e68 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101ea1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101ea4:	31 c0                	xor    %eax,%eax
}
80101ea6:	5b                   	pop    %ebx
80101ea7:	5e                   	pop    %esi
80101ea8:	5f                   	pop    %edi
80101ea9:	5d                   	pop    %ebp
80101eaa:	c3                   	ret    
80101eab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101eaf:	90                   	nop
      if(poff)
80101eb0:	8b 45 10             	mov    0x10(%ebp),%eax
80101eb3:	85 c0                	test   %eax,%eax
80101eb5:	74 05                	je     80101ebc <dirlookup+0x7c>
        *poff = off;
80101eb7:	8b 45 10             	mov    0x10(%ebp),%eax
80101eba:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101ebc:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101ec0:	8b 03                	mov    (%ebx),%eax
80101ec2:	e8 59 f5 ff ff       	call   80101420 <iget>
}
80101ec7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101eca:	5b                   	pop    %ebx
80101ecb:	5e                   	pop    %esi
80101ecc:	5f                   	pop    %edi
80101ecd:	5d                   	pop    %ebp
80101ece:	c3                   	ret    
      panic("dirlookup read");
80101ecf:	83 ec 0c             	sub    $0xc,%esp
80101ed2:	68 b9 88 10 80       	push   $0x801088b9
80101ed7:	e8 b4 e4 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101edc:	83 ec 0c             	sub    $0xc,%esp
80101edf:	68 a7 88 10 80       	push   $0x801088a7
80101ee4:	e8 a7 e4 ff ff       	call   80100390 <panic>
80101ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101ef0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101ef0:	55                   	push   %ebp
80101ef1:	89 e5                	mov    %esp,%ebp
80101ef3:	57                   	push   %edi
80101ef4:	56                   	push   %esi
80101ef5:	53                   	push   %ebx
80101ef6:	89 c3                	mov    %eax,%ebx
80101ef8:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101efb:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101efe:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101f01:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101f04:	0f 84 86 01 00 00    	je     80102090 <namex+0x1a0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101f0a:	e8 01 20 00 00       	call   80103f10 <myproc>
  acquire(&icache.lock);
80101f0f:	83 ec 0c             	sub    $0xc,%esp
80101f12:	89 df                	mov    %ebx,%edi
    ip = idup(myproc()->cwd);
80101f14:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101f17:	68 e0 51 11 80       	push   $0x801151e0
80101f1c:	e8 6f 3a 00 00       	call   80105990 <acquire>
  ip->ref++;
80101f21:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101f25:	c7 04 24 e0 51 11 80 	movl   $0x801151e0,(%esp)
80101f2c:	e8 1f 3b 00 00       	call   80105a50 <release>
80101f31:	83 c4 10             	add    $0x10,%esp
80101f34:	eb 0d                	jmp    80101f43 <namex+0x53>
80101f36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f3d:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
80101f40:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
80101f43:	0f b6 07             	movzbl (%edi),%eax
80101f46:	3c 2f                	cmp    $0x2f,%al
80101f48:	74 f6                	je     80101f40 <namex+0x50>
  if(*path == 0)
80101f4a:	84 c0                	test   %al,%al
80101f4c:	0f 84 ee 00 00 00    	je     80102040 <namex+0x150>
  while(*path != '/' && *path != 0)
80101f52:	0f b6 07             	movzbl (%edi),%eax
80101f55:	84 c0                	test   %al,%al
80101f57:	0f 84 fb 00 00 00    	je     80102058 <namex+0x168>
80101f5d:	89 fb                	mov    %edi,%ebx
80101f5f:	3c 2f                	cmp    $0x2f,%al
80101f61:	0f 84 f1 00 00 00    	je     80102058 <namex+0x168>
80101f67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f6e:	66 90                	xchg   %ax,%ax
    path++;
80101f70:	83 c3 01             	add    $0x1,%ebx
  while(*path != '/' && *path != 0)
80101f73:	0f b6 03             	movzbl (%ebx),%eax
80101f76:	3c 2f                	cmp    $0x2f,%al
80101f78:	74 04                	je     80101f7e <namex+0x8e>
80101f7a:	84 c0                	test   %al,%al
80101f7c:	75 f2                	jne    80101f70 <namex+0x80>
  len = path - s;
80101f7e:	89 d8                	mov    %ebx,%eax
80101f80:	29 f8                	sub    %edi,%eax
  if(len >= DIRSIZ)
80101f82:	83 f8 0d             	cmp    $0xd,%eax
80101f85:	0f 8e 85 00 00 00    	jle    80102010 <namex+0x120>
    memmove(name, s, DIRSIZ);
80101f8b:	83 ec 04             	sub    $0x4,%esp
80101f8e:	6a 0e                	push   $0xe
80101f90:	57                   	push   %edi
    path++;
80101f91:	89 df                	mov    %ebx,%edi
    memmove(name, s, DIRSIZ);
80101f93:	ff 75 e4             	pushl  -0x1c(%ebp)
80101f96:	e8 a5 3b 00 00       	call   80105b40 <memmove>
80101f9b:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101f9e:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101fa1:	75 0d                	jne    80101fb0 <namex+0xc0>
80101fa3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101fa7:	90                   	nop
    path++;
80101fa8:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
80101fab:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101fae:	74 f8                	je     80101fa8 <namex+0xb8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101fb0:	83 ec 0c             	sub    $0xc,%esp
80101fb3:	56                   	push   %esi
80101fb4:	e8 17 f9 ff ff       	call   801018d0 <ilock>
    if(ip->type != T_DIR){
80101fb9:	83 c4 10             	add    $0x10,%esp
80101fbc:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101fc1:	0f 85 a1 00 00 00    	jne    80102068 <namex+0x178>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101fc7:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101fca:	85 d2                	test   %edx,%edx
80101fcc:	74 09                	je     80101fd7 <namex+0xe7>
80101fce:	80 3f 00             	cmpb   $0x0,(%edi)
80101fd1:	0f 84 d9 00 00 00    	je     801020b0 <namex+0x1c0>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101fd7:	83 ec 04             	sub    $0x4,%esp
80101fda:	6a 00                	push   $0x0
80101fdc:	ff 75 e4             	pushl  -0x1c(%ebp)
80101fdf:	56                   	push   %esi
80101fe0:	e8 5b fe ff ff       	call   80101e40 <dirlookup>
80101fe5:	83 c4 10             	add    $0x10,%esp
80101fe8:	89 c3                	mov    %eax,%ebx
80101fea:	85 c0                	test   %eax,%eax
80101fec:	74 7a                	je     80102068 <namex+0x178>
  iunlock(ip);
80101fee:	83 ec 0c             	sub    $0xc,%esp
80101ff1:	56                   	push   %esi
80101ff2:	e8 d9 f9 ff ff       	call   801019d0 <iunlock>
  iput(ip);
80101ff7:	89 34 24             	mov    %esi,(%esp)
80101ffa:	89 de                	mov    %ebx,%esi
80101ffc:	e8 1f fa ff ff       	call   80101a20 <iput>
  while(*path == '/')
80102001:	83 c4 10             	add    $0x10,%esp
80102004:	e9 3a ff ff ff       	jmp    80101f43 <namex+0x53>
80102009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102010:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102013:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
80102016:	89 4d dc             	mov    %ecx,-0x24(%ebp)
    memmove(name, s, len);
80102019:	83 ec 04             	sub    $0x4,%esp
8010201c:	50                   	push   %eax
8010201d:	57                   	push   %edi
    name[len] = 0;
8010201e:	89 df                	mov    %ebx,%edi
    memmove(name, s, len);
80102020:	ff 75 e4             	pushl  -0x1c(%ebp)
80102023:	e8 18 3b 00 00       	call   80105b40 <memmove>
    name[len] = 0;
80102028:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010202b:	83 c4 10             	add    $0x10,%esp
8010202e:	c6 00 00             	movb   $0x0,(%eax)
80102031:	e9 68 ff ff ff       	jmp    80101f9e <namex+0xae>
80102036:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010203d:	8d 76 00             	lea    0x0(%esi),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102040:	8b 45 e0             	mov    -0x20(%ebp),%eax
80102043:	85 c0                	test   %eax,%eax
80102045:	0f 85 85 00 00 00    	jne    801020d0 <namex+0x1e0>
    iput(ip);
    return 0;
  }
  return ip;
}
8010204b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010204e:	89 f0                	mov    %esi,%eax
80102050:	5b                   	pop    %ebx
80102051:	5e                   	pop    %esi
80102052:	5f                   	pop    %edi
80102053:	5d                   	pop    %ebp
80102054:	c3                   	ret    
80102055:	8d 76 00             	lea    0x0(%esi),%esi
  while(*path != '/' && *path != 0)
80102058:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010205b:	89 fb                	mov    %edi,%ebx
8010205d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102060:	31 c0                	xor    %eax,%eax
80102062:	eb b5                	jmp    80102019 <namex+0x129>
80102064:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80102068:	83 ec 0c             	sub    $0xc,%esp
8010206b:	56                   	push   %esi
8010206c:	e8 5f f9 ff ff       	call   801019d0 <iunlock>
  iput(ip);
80102071:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102074:	31 f6                	xor    %esi,%esi
  iput(ip);
80102076:	e8 a5 f9 ff ff       	call   80101a20 <iput>
      return 0;
8010207b:	83 c4 10             	add    $0x10,%esp
}
8010207e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102081:	89 f0                	mov    %esi,%eax
80102083:	5b                   	pop    %ebx
80102084:	5e                   	pop    %esi
80102085:	5f                   	pop    %edi
80102086:	5d                   	pop    %ebp
80102087:	c3                   	ret    
80102088:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010208f:	90                   	nop
    ip = iget(ROOTDEV, ROOTINO);
80102090:	ba 01 00 00 00       	mov    $0x1,%edx
80102095:	b8 01 00 00 00       	mov    $0x1,%eax
8010209a:	89 df                	mov    %ebx,%edi
8010209c:	e8 7f f3 ff ff       	call   80101420 <iget>
801020a1:	89 c6                	mov    %eax,%esi
801020a3:	e9 9b fe ff ff       	jmp    80101f43 <namex+0x53>
801020a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020af:	90                   	nop
      iunlock(ip);
801020b0:	83 ec 0c             	sub    $0xc,%esp
801020b3:	56                   	push   %esi
801020b4:	e8 17 f9 ff ff       	call   801019d0 <iunlock>
      return ip;
801020b9:	83 c4 10             	add    $0x10,%esp
}
801020bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020bf:	89 f0                	mov    %esi,%eax
801020c1:	5b                   	pop    %ebx
801020c2:	5e                   	pop    %esi
801020c3:	5f                   	pop    %edi
801020c4:	5d                   	pop    %ebp
801020c5:	c3                   	ret    
801020c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020cd:	8d 76 00             	lea    0x0(%esi),%esi
    iput(ip);
801020d0:	83 ec 0c             	sub    $0xc,%esp
801020d3:	56                   	push   %esi
    return 0;
801020d4:	31 f6                	xor    %esi,%esi
    iput(ip);
801020d6:	e8 45 f9 ff ff       	call   80101a20 <iput>
    return 0;
801020db:	83 c4 10             	add    $0x10,%esp
801020de:	e9 68 ff ff ff       	jmp    8010204b <namex+0x15b>
801020e3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801020f0 <dirlink>:
{
801020f0:	55                   	push   %ebp
801020f1:	89 e5                	mov    %esp,%ebp
801020f3:	57                   	push   %edi
801020f4:	56                   	push   %esi
801020f5:	53                   	push   %ebx
801020f6:	83 ec 20             	sub    $0x20,%esp
801020f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
801020fc:	6a 00                	push   $0x0
801020fe:	ff 75 0c             	pushl  0xc(%ebp)
80102101:	53                   	push   %ebx
80102102:	e8 39 fd ff ff       	call   80101e40 <dirlookup>
80102107:	83 c4 10             	add    $0x10,%esp
8010210a:	85 c0                	test   %eax,%eax
8010210c:	75 67                	jne    80102175 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
8010210e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102111:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102114:	85 ff                	test   %edi,%edi
80102116:	74 29                	je     80102141 <dirlink+0x51>
80102118:	31 ff                	xor    %edi,%edi
8010211a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010211d:	eb 09                	jmp    80102128 <dirlink+0x38>
8010211f:	90                   	nop
80102120:	83 c7 10             	add    $0x10,%edi
80102123:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102126:	73 19                	jae    80102141 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102128:	6a 10                	push   $0x10
8010212a:	57                   	push   %edi
8010212b:	56                   	push   %esi
8010212c:	53                   	push   %ebx
8010212d:	e8 be fa ff ff       	call   80101bf0 <readi>
80102132:	83 c4 10             	add    $0x10,%esp
80102135:	83 f8 10             	cmp    $0x10,%eax
80102138:	75 4e                	jne    80102188 <dirlink+0x98>
    if(de.inum == 0)
8010213a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010213f:	75 df                	jne    80102120 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102141:	83 ec 04             	sub    $0x4,%esp
80102144:	8d 45 da             	lea    -0x26(%ebp),%eax
80102147:	6a 0e                	push   $0xe
80102149:	ff 75 0c             	pushl  0xc(%ebp)
8010214c:	50                   	push   %eax
8010214d:	e8 be 3a 00 00       	call   80105c10 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102152:	6a 10                	push   $0x10
  de.inum = inum;
80102154:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102157:	57                   	push   %edi
80102158:	56                   	push   %esi
80102159:	53                   	push   %ebx
  de.inum = inum;
8010215a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010215e:	e8 8d fb ff ff       	call   80101cf0 <writei>
80102163:	83 c4 20             	add    $0x20,%esp
80102166:	83 f8 10             	cmp    $0x10,%eax
80102169:	75 2a                	jne    80102195 <dirlink+0xa5>
  return 0;
8010216b:	31 c0                	xor    %eax,%eax
}
8010216d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102170:	5b                   	pop    %ebx
80102171:	5e                   	pop    %esi
80102172:	5f                   	pop    %edi
80102173:	5d                   	pop    %ebp
80102174:	c3                   	ret    
    iput(ip);
80102175:	83 ec 0c             	sub    $0xc,%esp
80102178:	50                   	push   %eax
80102179:	e8 a2 f8 ff ff       	call   80101a20 <iput>
    return -1;
8010217e:	83 c4 10             	add    $0x10,%esp
80102181:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102186:	eb e5                	jmp    8010216d <dirlink+0x7d>
      panic("dirlink read");
80102188:	83 ec 0c             	sub    $0xc,%esp
8010218b:	68 c8 88 10 80       	push   $0x801088c8
80102190:	e8 fb e1 ff ff       	call   80100390 <panic>
    panic("dirlink");
80102195:	83 ec 0c             	sub    $0xc,%esp
80102198:	68 32 92 10 80       	push   $0x80109232
8010219d:	e8 ee e1 ff ff       	call   80100390 <panic>
801021a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801021b0 <namei>:

struct inode*
namei(char *path)
{
801021b0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
801021b1:	31 d2                	xor    %edx,%edx
{
801021b3:	89 e5                	mov    %esp,%ebp
801021b5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
801021b8:	8b 45 08             	mov    0x8(%ebp),%eax
801021bb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
801021be:	e8 2d fd ff ff       	call   80101ef0 <namex>
}
801021c3:	c9                   	leave  
801021c4:	c3                   	ret    
801021c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801021d0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801021d0:	55                   	push   %ebp
  return namex(path, 1, name);
801021d1:	ba 01 00 00 00       	mov    $0x1,%edx
{
801021d6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
801021d8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801021db:	8b 45 08             	mov    0x8(%ebp),%eax
}
801021de:	5d                   	pop    %ebp
  return namex(path, 1, name);
801021df:	e9 0c fd ff ff       	jmp    80101ef0 <namex>
801021e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801021ef:	90                   	nop

801021f0 <chmod>:


#ifdef CS333_P5
int
chmod(char * pathname,int mode)
{
801021f0:	55                   	push   %ebp
801021f1:	89 e5                	mov    %esp,%ebp
801021f3:	56                   	push   %esi
801021f4:	53                   	push   %ebx
801021f5:	83 ec 10             	sub    $0x10,%esp
801021f8:	8b 75 0c             	mov    0xc(%ebp),%esi
    begin_op();
801021fb:	e8 10 0e 00 00       	call   80103010 <begin_op>
  return namex(path, 0, name);
80102200:	8b 45 08             	mov    0x8(%ebp),%eax
80102203:	31 d2                	xor    %edx,%edx
80102205:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102208:	e8 e3 fc ff ff       	call   80101ef0 <namex>
    struct inode * chmod_ptr = namei(pathname);

    if(chmod_ptr == 0 || mode < 0 || mode > 1023){
8010220d:	85 c0                	test   %eax,%eax
8010220f:	74 3f                	je     80102250 <chmod+0x60>
80102211:	81 fe ff 03 00 00    	cmp    $0x3ff,%esi
80102217:	77 37                	ja     80102250 <chmod+0x60>
        end_op();
        cprintf("Either Invalid filename or invalid value\n");
        return -1;
    }

    ilock(chmod_ptr);
80102219:	83 ec 0c             	sub    $0xc,%esp
8010221c:	89 c3                	mov    %eax,%ebx
8010221e:	50                   	push   %eax
8010221f:	e8 ac f6 ff ff       	call   801018d0 <ilock>
    chmod_ptr->mode.asInt = mode;
80102224:	89 b3 8c 00 00 00    	mov    %esi,0x8c(%ebx)
    iupdate(chmod_ptr);
8010222a:	89 1c 24             	mov    %ebx,(%esp)
8010222d:	e8 ce f5 ff ff       	call   80101800 <iupdate>
    iunlock(chmod_ptr);
80102232:	89 1c 24             	mov    %ebx,(%esp)
80102235:	e8 96 f7 ff ff       	call   801019d0 <iunlock>
    end_op();
8010223a:	e8 41 0e 00 00       	call   80103080 <end_op>
    return 0;
8010223f:	83 c4 10             	add    $0x10,%esp
80102242:	31 c0                	xor    %eax,%eax
}
80102244:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102247:	5b                   	pop    %ebx
80102248:	5e                   	pop    %esi
80102249:	5d                   	pop    %ebp
8010224a:	c3                   	ret    
8010224b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010224f:	90                   	nop
        end_op();
80102250:	e8 2b 0e 00 00       	call   80103080 <end_op>
        cprintf("Either Invalid filename or invalid value\n");
80102255:	83 ec 0c             	sub    $0xc,%esp
80102258:	68 2c 89 10 80       	push   $0x8010892c
8010225d:	e8 4e e4 ff ff       	call   801006b0 <cprintf>
        return -1;
80102262:	83 c4 10             	add    $0x10,%esp
80102265:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010226a:	eb d8                	jmp    80102244 <chmod+0x54>
8010226c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102270 <chown>:

int
chown(char * pathname, int owner)
{
80102270:	55                   	push   %ebp
80102271:	89 e5                	mov    %esp,%ebp
80102273:	56                   	push   %esi
80102274:	53                   	push   %ebx
80102275:	83 ec 10             	sub    $0x10,%esp
80102278:	8b 75 0c             	mov    0xc(%ebp),%esi
    begin_op();
8010227b:	e8 90 0d 00 00       	call   80103010 <begin_op>
  return namex(path, 0, name);
80102280:	8b 45 08             	mov    0x8(%ebp),%eax
80102283:	31 d2                	xor    %edx,%edx
80102285:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102288:	e8 63 fc ff ff       	call   80101ef0 <namex>
    struct inode * chown_ptr = namei(pathname);

    if(chown_ptr == 0 || owner < 0 || owner > 32767){
8010228d:	85 c0                	test   %eax,%eax
8010228f:	74 3f                	je     801022d0 <chown+0x60>
80102291:	81 fe ff 7f 00 00    	cmp    $0x7fff,%esi
80102297:	77 37                	ja     801022d0 <chown+0x60>
        end_op();
        cprintf("Either Invalid filename or invalid value\n");
        return -1;
    }
    ilock(chown_ptr);
80102299:	83 ec 0c             	sub    $0xc,%esp
8010229c:	89 c3                	mov    %eax,%ebx
8010229e:	50                   	push   %eax
8010229f:	e8 2c f6 ff ff       	call   801018d0 <ilock>
    chown_ptr->uid = owner;
801022a4:	66 89 b3 88 00 00 00 	mov    %si,0x88(%ebx)
    iupdate(chown_ptr);
801022ab:	89 1c 24             	mov    %ebx,(%esp)
801022ae:	e8 4d f5 ff ff       	call   80101800 <iupdate>
    iunlock(chown_ptr);
801022b3:	89 1c 24             	mov    %ebx,(%esp)
801022b6:	e8 15 f7 ff ff       	call   801019d0 <iunlock>
    end_op();
801022bb:	e8 c0 0d 00 00       	call   80103080 <end_op>
    return 0;
801022c0:	83 c4 10             	add    $0x10,%esp
801022c3:	31 c0                	xor    %eax,%eax
}
801022c5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022c8:	5b                   	pop    %ebx
801022c9:	5e                   	pop    %esi
801022ca:	5d                   	pop    %ebp
801022cb:	c3                   	ret    
801022cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        end_op();
801022d0:	e8 ab 0d 00 00       	call   80103080 <end_op>
        cprintf("Either Invalid filename or invalid value\n");
801022d5:	83 ec 0c             	sub    $0xc,%esp
801022d8:	68 2c 89 10 80       	push   $0x8010892c
801022dd:	e8 ce e3 ff ff       	call   801006b0 <cprintf>
        return -1;
801022e2:	83 c4 10             	add    $0x10,%esp
801022e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801022ea:	eb d9                	jmp    801022c5 <chown+0x55>
801022ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801022f0 <chgrp>:

int
chgrp(char * pathname, int group)
{
801022f0:	55                   	push   %ebp
801022f1:	89 e5                	mov    %esp,%ebp
801022f3:	56                   	push   %esi
801022f4:	53                   	push   %ebx
801022f5:	83 ec 10             	sub    $0x10,%esp
801022f8:	8b 75 0c             	mov    0xc(%ebp),%esi
    begin_op();
801022fb:	e8 10 0d 00 00       	call   80103010 <begin_op>
  return namex(path, 0, name);
80102300:	8b 45 08             	mov    0x8(%ebp),%eax
80102303:	31 d2                	xor    %edx,%edx
80102305:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102308:	e8 e3 fb ff ff       	call   80101ef0 <namex>
    struct inode * chgrp_ptr = namei(pathname);

    if(chgrp_ptr == 0 || group < 0 || group > 32767){
8010230d:	85 c0                	test   %eax,%eax
8010230f:	74 3f                	je     80102350 <chgrp+0x60>
80102311:	81 fe ff 7f 00 00    	cmp    $0x7fff,%esi
80102317:	77 37                	ja     80102350 <chgrp+0x60>
        end_op();
        cprintf("Either Invalid filename or invalid value\n");
        return -1;
    }

    ilock(chgrp_ptr);
80102319:	83 ec 0c             	sub    $0xc,%esp
8010231c:	89 c3                	mov    %eax,%ebx
8010231e:	50                   	push   %eax
8010231f:	e8 ac f5 ff ff       	call   801018d0 <ilock>
    chgrp_ptr->gid = group;
80102324:	66 89 b3 8a 00 00 00 	mov    %si,0x8a(%ebx)
    iupdate(chgrp_ptr);
8010232b:	89 1c 24             	mov    %ebx,(%esp)
8010232e:	e8 cd f4 ff ff       	call   80101800 <iupdate>
    iunlock(chgrp_ptr);
80102333:	89 1c 24             	mov    %ebx,(%esp)
80102336:	e8 95 f6 ff ff       	call   801019d0 <iunlock>
    end_op();
8010233b:	e8 40 0d 00 00       	call   80103080 <end_op>
    return 0;
80102340:	83 c4 10             	add    $0x10,%esp
80102343:	31 c0                	xor    %eax,%eax

}
80102345:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102348:	5b                   	pop    %ebx
80102349:	5e                   	pop    %esi
8010234a:	5d                   	pop    %ebp
8010234b:	c3                   	ret    
8010234c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        end_op();
80102350:	e8 2b 0d 00 00       	call   80103080 <end_op>
        cprintf("Either Invalid filename or invalid value\n");
80102355:	83 ec 0c             	sub    $0xc,%esp
80102358:	68 2c 89 10 80       	push   $0x8010892c
8010235d:	e8 4e e3 ff ff       	call   801006b0 <cprintf>
        return -1;
80102362:	83 c4 10             	add    $0x10,%esp
80102365:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010236a:	eb d9                	jmp    80102345 <chgrp+0x55>
8010236c:	66 90                	xchg   %ax,%ax
8010236e:	66 90                	xchg   %ax,%ax

80102370 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102370:	55                   	push   %ebp
80102371:	89 e5                	mov    %esp,%ebp
80102373:	57                   	push   %edi
80102374:	56                   	push   %esi
80102375:	53                   	push   %ebx
80102376:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102379:	85 c0                	test   %eax,%eax
8010237b:	0f 84 b4 00 00 00    	je     80102435 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102381:	8b 70 08             	mov    0x8(%eax),%esi
80102384:	89 c3                	mov    %eax,%ebx
80102386:	81 fe cf 07 00 00    	cmp    $0x7cf,%esi
8010238c:	0f 87 96 00 00 00    	ja     80102428 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102392:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102397:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010239e:	66 90                	xchg   %ax,%ax
801023a0:	89 ca                	mov    %ecx,%edx
801023a2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801023a3:	83 e0 c0             	and    $0xffffffc0,%eax
801023a6:	3c 40                	cmp    $0x40,%al
801023a8:	75 f6                	jne    801023a0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801023aa:	31 ff                	xor    %edi,%edi
801023ac:	ba f6 03 00 00       	mov    $0x3f6,%edx
801023b1:	89 f8                	mov    %edi,%eax
801023b3:	ee                   	out    %al,(%dx)
801023b4:	b8 01 00 00 00       	mov    $0x1,%eax
801023b9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801023be:	ee                   	out    %al,(%dx)
801023bf:	ba f3 01 00 00       	mov    $0x1f3,%edx
801023c4:	89 f0                	mov    %esi,%eax
801023c6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
801023c7:	89 f0                	mov    %esi,%eax
801023c9:	ba f4 01 00 00       	mov    $0x1f4,%edx
801023ce:	c1 f8 08             	sar    $0x8,%eax
801023d1:	ee                   	out    %al,(%dx)
801023d2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801023d7:	89 f8                	mov    %edi,%eax
801023d9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801023da:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
801023de:	ba f6 01 00 00       	mov    $0x1f6,%edx
801023e3:	c1 e0 04             	shl    $0x4,%eax
801023e6:	83 e0 10             	and    $0x10,%eax
801023e9:	83 c8 e0             	or     $0xffffffe0,%eax
801023ec:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
801023ed:	f6 03 04             	testb  $0x4,(%ebx)
801023f0:	75 16                	jne    80102408 <idestart+0x98>
801023f2:	b8 20 00 00 00       	mov    $0x20,%eax
801023f7:	89 ca                	mov    %ecx,%edx
801023f9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
801023fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023fd:	5b                   	pop    %ebx
801023fe:	5e                   	pop    %esi
801023ff:	5f                   	pop    %edi
80102400:	5d                   	pop    %ebp
80102401:	c3                   	ret    
80102402:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102408:	b8 30 00 00 00       	mov    $0x30,%eax
8010240d:	89 ca                	mov    %ecx,%edx
8010240f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102410:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102415:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102418:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010241d:	fc                   	cld    
8010241e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102420:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102423:	5b                   	pop    %ebx
80102424:	5e                   	pop    %esi
80102425:	5f                   	pop    %edi
80102426:	5d                   	pop    %ebp
80102427:	c3                   	ret    
    panic("incorrect blockno");
80102428:	83 ec 0c             	sub    $0xc,%esp
8010242b:	68 5f 89 10 80       	push   $0x8010895f
80102430:	e8 5b df ff ff       	call   80100390 <panic>
    panic("idestart");
80102435:	83 ec 0c             	sub    $0xc,%esp
80102438:	68 56 89 10 80       	push   $0x80108956
8010243d:	e8 4e df ff ff       	call   80100390 <panic>
80102442:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102450 <ideinit>:
{
80102450:	55                   	push   %ebp
80102451:	89 e5                	mov    %esp,%ebp
80102453:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102456:	68 71 89 10 80       	push   $0x80108971
8010245b:	68 80 c5 10 80       	push   $0x8010c580
80102460:	e8 cb 33 00 00       	call   80105830 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102465:	58                   	pop    %eax
80102466:	a1 00 75 11 80       	mov    0x80117500,%eax
8010246b:	5a                   	pop    %edx
8010246c:	83 e8 01             	sub    $0x1,%eax
8010246f:	50                   	push   %eax
80102470:	6a 0e                	push   $0xe
80102472:	e8 a9 02 00 00       	call   80102720 <ioapicenable>
80102477:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010247a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010247f:	90                   	nop
80102480:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102481:	83 e0 c0             	and    $0xffffffc0,%eax
80102484:	3c 40                	cmp    $0x40,%al
80102486:	75 f8                	jne    80102480 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102488:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010248d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102492:	ee                   	out    %al,(%dx)
80102493:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102498:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010249d:	eb 06                	jmp    801024a5 <ideinit+0x55>
8010249f:	90                   	nop
  for(i=0; i<1000; i++){
801024a0:	83 e9 01             	sub    $0x1,%ecx
801024a3:	74 0f                	je     801024b4 <ideinit+0x64>
801024a5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801024a6:	84 c0                	test   %al,%al
801024a8:	74 f6                	je     801024a0 <ideinit+0x50>
      havedisk1 = 1;
801024aa:	c7 05 60 c5 10 80 01 	movl   $0x1,0x8010c560
801024b1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801024b4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801024b9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801024be:	ee                   	out    %al,(%dx)
}
801024bf:	c9                   	leave  
801024c0:	c3                   	ret    
801024c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801024c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801024cf:	90                   	nop

801024d0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801024d0:	55                   	push   %ebp
801024d1:	89 e5                	mov    %esp,%ebp
801024d3:	57                   	push   %edi
801024d4:	56                   	push   %esi
801024d5:	53                   	push   %ebx
801024d6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801024d9:	68 80 c5 10 80       	push   $0x8010c580
801024de:	e8 ad 34 00 00       	call   80105990 <acquire>

  if((b = idequeue) == 0){
801024e3:	8b 1d 64 c5 10 80    	mov    0x8010c564,%ebx
801024e9:	83 c4 10             	add    $0x10,%esp
801024ec:	85 db                	test   %ebx,%ebx
801024ee:	74 63                	je     80102553 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801024f0:	8b 43 58             	mov    0x58(%ebx),%eax
801024f3:	a3 64 c5 10 80       	mov    %eax,0x8010c564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801024f8:	8b 33                	mov    (%ebx),%esi
801024fa:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102500:	75 2f                	jne    80102531 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102502:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102507:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010250e:	66 90                	xchg   %ax,%ax
80102510:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102511:	89 c1                	mov    %eax,%ecx
80102513:	83 e1 c0             	and    $0xffffffc0,%ecx
80102516:	80 f9 40             	cmp    $0x40,%cl
80102519:	75 f5                	jne    80102510 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010251b:	a8 21                	test   $0x21,%al
8010251d:	75 12                	jne    80102531 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010251f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102522:	b9 80 00 00 00       	mov    $0x80,%ecx
80102527:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010252c:	fc                   	cld    
8010252d:	f3 6d                	rep insl (%dx),%es:(%edi)
8010252f:	8b 33                	mov    (%ebx),%esi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102531:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102534:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102537:	83 ce 02             	or     $0x2,%esi
8010253a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010253c:	53                   	push   %ebx
8010253d:	e8 1e 2a 00 00       	call   80104f60 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102542:	a1 64 c5 10 80       	mov    0x8010c564,%eax
80102547:	83 c4 10             	add    $0x10,%esp
8010254a:	85 c0                	test   %eax,%eax
8010254c:	74 05                	je     80102553 <ideintr+0x83>
    idestart(idequeue);
8010254e:	e8 1d fe ff ff       	call   80102370 <idestart>
    release(&idelock);
80102553:	83 ec 0c             	sub    $0xc,%esp
80102556:	68 80 c5 10 80       	push   $0x8010c580
8010255b:	e8 f0 34 00 00       	call   80105a50 <release>

  release(&idelock);
}
80102560:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102563:	5b                   	pop    %ebx
80102564:	5e                   	pop    %esi
80102565:	5f                   	pop    %edi
80102566:	5d                   	pop    %ebp
80102567:	c3                   	ret    
80102568:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010256f:	90                   	nop

80102570 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102570:	55                   	push   %ebp
80102571:	89 e5                	mov    %esp,%ebp
80102573:	53                   	push   %ebx
80102574:	83 ec 10             	sub    $0x10,%esp
80102577:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010257a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010257d:	50                   	push   %eax
8010257e:	e8 7d 32 00 00       	call   80105800 <holdingsleep>
80102583:	83 c4 10             	add    $0x10,%esp
80102586:	85 c0                	test   %eax,%eax
80102588:	0f 84 d3 00 00 00    	je     80102661 <iderw+0xf1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010258e:	8b 03                	mov    (%ebx),%eax
80102590:	83 e0 06             	and    $0x6,%eax
80102593:	83 f8 02             	cmp    $0x2,%eax
80102596:	0f 84 b8 00 00 00    	je     80102654 <iderw+0xe4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010259c:	8b 53 04             	mov    0x4(%ebx),%edx
8010259f:	85 d2                	test   %edx,%edx
801025a1:	74 0d                	je     801025b0 <iderw+0x40>
801025a3:	a1 60 c5 10 80       	mov    0x8010c560,%eax
801025a8:	85 c0                	test   %eax,%eax
801025aa:	0f 84 97 00 00 00    	je     80102647 <iderw+0xd7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801025b0:	83 ec 0c             	sub    $0xc,%esp
801025b3:	68 80 c5 10 80       	push   $0x8010c580
801025b8:	e8 d3 33 00 00       	call   80105990 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801025bd:	8b 15 64 c5 10 80    	mov    0x8010c564,%edx
  b->qnext = 0;
801025c3:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801025ca:	83 c4 10             	add    $0x10,%esp
801025cd:	85 d2                	test   %edx,%edx
801025cf:	75 09                	jne    801025da <iderw+0x6a>
801025d1:	eb 6d                	jmp    80102640 <iderw+0xd0>
801025d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801025d7:	90                   	nop
801025d8:	89 c2                	mov    %eax,%edx
801025da:	8b 42 58             	mov    0x58(%edx),%eax
801025dd:	85 c0                	test   %eax,%eax
801025df:	75 f7                	jne    801025d8 <iderw+0x68>
801025e1:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801025e4:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801025e6:	39 1d 64 c5 10 80    	cmp    %ebx,0x8010c564
801025ec:	74 42                	je     80102630 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801025ee:	8b 03                	mov    (%ebx),%eax
801025f0:	83 e0 06             	and    $0x6,%eax
801025f3:	83 f8 02             	cmp    $0x2,%eax
801025f6:	74 23                	je     8010261b <iderw+0xab>
801025f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025ff:	90                   	nop
    sleep(b, &idelock);
80102600:	83 ec 08             	sub    $0x8,%esp
80102603:	68 80 c5 10 80       	push   $0x8010c580
80102608:	53                   	push   %ebx
80102609:	e8 a2 25 00 00       	call   80104bb0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010260e:	8b 03                	mov    (%ebx),%eax
80102610:	83 c4 10             	add    $0x10,%esp
80102613:	83 e0 06             	and    $0x6,%eax
80102616:	83 f8 02             	cmp    $0x2,%eax
80102619:	75 e5                	jne    80102600 <iderw+0x90>
  }


  release(&idelock);
8010261b:	c7 45 08 80 c5 10 80 	movl   $0x8010c580,0x8(%ebp)
}
80102622:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102625:	c9                   	leave  
  release(&idelock);
80102626:	e9 25 34 00 00       	jmp    80105a50 <release>
8010262b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010262f:	90                   	nop
    idestart(b);
80102630:	89 d8                	mov    %ebx,%eax
80102632:	e8 39 fd ff ff       	call   80102370 <idestart>
80102637:	eb b5                	jmp    801025ee <iderw+0x7e>
80102639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102640:	ba 64 c5 10 80       	mov    $0x8010c564,%edx
80102645:	eb 9d                	jmp    801025e4 <iderw+0x74>
    panic("iderw: ide disk 1 not present");
80102647:	83 ec 0c             	sub    $0xc,%esp
8010264a:	68 a0 89 10 80       	push   $0x801089a0
8010264f:	e8 3c dd ff ff       	call   80100390 <panic>
    panic("iderw: nothing to do");
80102654:	83 ec 0c             	sub    $0xc,%esp
80102657:	68 8b 89 10 80       	push   $0x8010898b
8010265c:	e8 2f dd ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102661:	83 ec 0c             	sub    $0xc,%esp
80102664:	68 75 89 10 80       	push   $0x80108975
80102669:	e8 22 dd ff ff       	call   80100390 <panic>
8010266e:	66 90                	xchg   %ax,%ax

80102670 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102670:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102671:	c7 05 34 6e 11 80 00 	movl   $0xfec00000,0x80116e34
80102678:	00 c0 fe 
{
8010267b:	89 e5                	mov    %esp,%ebp
8010267d:	56                   	push   %esi
8010267e:	53                   	push   %ebx
  ioapic->reg = reg;
8010267f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102686:	00 00 00 
  return ioapic->data;
80102689:	8b 15 34 6e 11 80    	mov    0x80116e34,%edx
8010268f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102692:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102698:	8b 0d 34 6e 11 80    	mov    0x80116e34,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010269e:	0f b6 15 60 6f 11 80 	movzbl 0x80116f60,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801026a5:	c1 ee 10             	shr    $0x10,%esi
801026a8:	89 f0                	mov    %esi,%eax
801026aa:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
801026ad:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
801026b0:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801026b3:	39 c2                	cmp    %eax,%edx
801026b5:	74 16                	je     801026cd <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801026b7:	83 ec 0c             	sub    $0xc,%esp
801026ba:	68 c0 89 10 80       	push   $0x801089c0
801026bf:	e8 ec df ff ff       	call   801006b0 <cprintf>
801026c4:	8b 0d 34 6e 11 80    	mov    0x80116e34,%ecx
801026ca:	83 c4 10             	add    $0x10,%esp
801026cd:	83 c6 21             	add    $0x21,%esi
{
801026d0:	ba 10 00 00 00       	mov    $0x10,%edx
801026d5:	b8 20 00 00 00       	mov    $0x20,%eax
801026da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
801026e0:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801026e2:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
801026e4:	8b 0d 34 6e 11 80    	mov    0x80116e34,%ecx
801026ea:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801026ed:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
801026f3:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
801026f6:	8d 5a 01             	lea    0x1(%edx),%ebx
801026f9:	83 c2 02             	add    $0x2,%edx
801026fc:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
801026fe:	8b 0d 34 6e 11 80    	mov    0x80116e34,%ecx
80102704:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010270b:	39 f0                	cmp    %esi,%eax
8010270d:	75 d1                	jne    801026e0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010270f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102712:	5b                   	pop    %ebx
80102713:	5e                   	pop    %esi
80102714:	5d                   	pop    %ebp
80102715:	c3                   	ret    
80102716:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010271d:	8d 76 00             	lea    0x0(%esi),%esi

80102720 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102720:	55                   	push   %ebp
  ioapic->reg = reg;
80102721:	8b 0d 34 6e 11 80    	mov    0x80116e34,%ecx
{
80102727:	89 e5                	mov    %esp,%ebp
80102729:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010272c:	8d 50 20             	lea    0x20(%eax),%edx
8010272f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102733:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102735:	8b 0d 34 6e 11 80    	mov    0x80116e34,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010273b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010273e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102741:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102744:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102746:	a1 34 6e 11 80       	mov    0x80116e34,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010274b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010274e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102751:	5d                   	pop    %ebp
80102752:	c3                   	ret    
80102753:	66 90                	xchg   %ax,%ax
80102755:	66 90                	xchg   %ax,%ax
80102757:	66 90                	xchg   %ax,%ax
80102759:	66 90                	xchg   %ax,%ax
8010275b:	66 90                	xchg   %ax,%ax
8010275d:	66 90                	xchg   %ax,%ax
8010275f:	90                   	nop

80102760 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102760:	55                   	push   %ebp
80102761:	89 e5                	mov    %esp,%ebp
80102763:	53                   	push   %ebx
80102764:	83 ec 04             	sub    $0x4,%esp
80102767:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010276a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102770:	75 76                	jne    801027e8 <kfree+0x88>
80102772:	81 fb 28 7d 11 80    	cmp    $0x80117d28,%ebx
80102778:	72 6e                	jb     801027e8 <kfree+0x88>
8010277a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102780:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102785:	77 61                	ja     801027e8 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102787:	83 ec 04             	sub    $0x4,%esp
8010278a:	68 00 10 00 00       	push   $0x1000
8010278f:	6a 01                	push   $0x1
80102791:	53                   	push   %ebx
80102792:	e8 09 33 00 00       	call   80105aa0 <memset>

  if(kmem.use_lock)
80102797:	8b 15 74 6e 11 80    	mov    0x80116e74,%edx
8010279d:	83 c4 10             	add    $0x10,%esp
801027a0:	85 d2                	test   %edx,%edx
801027a2:	75 1c                	jne    801027c0 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801027a4:	a1 78 6e 11 80       	mov    0x80116e78,%eax
801027a9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801027ab:	a1 74 6e 11 80       	mov    0x80116e74,%eax
  kmem.freelist = r;
801027b0:	89 1d 78 6e 11 80    	mov    %ebx,0x80116e78
  if(kmem.use_lock)
801027b6:	85 c0                	test   %eax,%eax
801027b8:	75 1e                	jne    801027d8 <kfree+0x78>
    release(&kmem.lock);
}
801027ba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801027bd:	c9                   	leave  
801027be:	c3                   	ret    
801027bf:	90                   	nop
    acquire(&kmem.lock);
801027c0:	83 ec 0c             	sub    $0xc,%esp
801027c3:	68 40 6e 11 80       	push   $0x80116e40
801027c8:	e8 c3 31 00 00       	call   80105990 <acquire>
801027cd:	83 c4 10             	add    $0x10,%esp
801027d0:	eb d2                	jmp    801027a4 <kfree+0x44>
801027d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
801027d8:	c7 45 08 40 6e 11 80 	movl   $0x80116e40,0x8(%ebp)
}
801027df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801027e2:	c9                   	leave  
    release(&kmem.lock);
801027e3:	e9 68 32 00 00       	jmp    80105a50 <release>
    panic("kfree");
801027e8:	83 ec 0c             	sub    $0xc,%esp
801027eb:	68 f2 89 10 80       	push   $0x801089f2
801027f0:	e8 9b db ff ff       	call   80100390 <panic>
801027f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102800 <freerange>:
{
80102800:	55                   	push   %ebp
80102801:	89 e5                	mov    %esp,%ebp
80102803:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102804:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102807:	8b 75 0c             	mov    0xc(%ebp),%esi
8010280a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010280b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102811:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102817:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010281d:	39 de                	cmp    %ebx,%esi
8010281f:	72 23                	jb     80102844 <freerange+0x44>
80102821:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102828:	83 ec 0c             	sub    $0xc,%esp
8010282b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102831:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102837:	50                   	push   %eax
80102838:	e8 23 ff ff ff       	call   80102760 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010283d:	83 c4 10             	add    $0x10,%esp
80102840:	39 f3                	cmp    %esi,%ebx
80102842:	76 e4                	jbe    80102828 <freerange+0x28>
}
80102844:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102847:	5b                   	pop    %ebx
80102848:	5e                   	pop    %esi
80102849:	5d                   	pop    %ebp
8010284a:	c3                   	ret    
8010284b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010284f:	90                   	nop

80102850 <kinit1>:
{
80102850:	55                   	push   %ebp
80102851:	89 e5                	mov    %esp,%ebp
80102853:	56                   	push   %esi
80102854:	53                   	push   %ebx
80102855:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102858:	83 ec 08             	sub    $0x8,%esp
8010285b:	68 f8 89 10 80       	push   $0x801089f8
80102860:	68 40 6e 11 80       	push   $0x80116e40
80102865:	e8 c6 2f 00 00       	call   80105830 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010286a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010286d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102870:	c7 05 74 6e 11 80 00 	movl   $0x0,0x80116e74
80102877:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010287a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102880:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102886:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010288c:	39 de                	cmp    %ebx,%esi
8010288e:	72 1c                	jb     801028ac <kinit1+0x5c>
    kfree(p);
80102890:	83 ec 0c             	sub    $0xc,%esp
80102893:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102899:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010289f:	50                   	push   %eax
801028a0:	e8 bb fe ff ff       	call   80102760 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801028a5:	83 c4 10             	add    $0x10,%esp
801028a8:	39 de                	cmp    %ebx,%esi
801028aa:	73 e4                	jae    80102890 <kinit1+0x40>
}
801028ac:	8d 65 f8             	lea    -0x8(%ebp),%esp
801028af:	5b                   	pop    %ebx
801028b0:	5e                   	pop    %esi
801028b1:	5d                   	pop    %ebp
801028b2:	c3                   	ret    
801028b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801028c0 <kinit2>:
{
801028c0:	55                   	push   %ebp
801028c1:	89 e5                	mov    %esp,%ebp
801028c3:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
801028c4:	8b 45 08             	mov    0x8(%ebp),%eax
{
801028c7:	8b 75 0c             	mov    0xc(%ebp),%esi
801028ca:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801028cb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801028d1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801028d7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801028dd:	39 de                	cmp    %ebx,%esi
801028df:	72 23                	jb     80102904 <kinit2+0x44>
801028e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801028e8:	83 ec 0c             	sub    $0xc,%esp
801028eb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801028f1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801028f7:	50                   	push   %eax
801028f8:	e8 63 fe ff ff       	call   80102760 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801028fd:	83 c4 10             	add    $0x10,%esp
80102900:	39 de                	cmp    %ebx,%esi
80102902:	73 e4                	jae    801028e8 <kinit2+0x28>
  kmem.use_lock = 1;
80102904:	c7 05 74 6e 11 80 01 	movl   $0x1,0x80116e74
8010290b:	00 00 00 
}
8010290e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102911:	5b                   	pop    %ebx
80102912:	5e                   	pop    %esi
80102913:	5d                   	pop    %ebp
80102914:	c3                   	ret    
80102915:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010291c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102920 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102920:	55                   	push   %ebp
80102921:	89 e5                	mov    %esp,%ebp
80102923:	53                   	push   %ebx
80102924:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102927:	a1 74 6e 11 80       	mov    0x80116e74,%eax
8010292c:	85 c0                	test   %eax,%eax
8010292e:	75 20                	jne    80102950 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102930:	8b 1d 78 6e 11 80    	mov    0x80116e78,%ebx
  if(r)
80102936:	85 db                	test   %ebx,%ebx
80102938:	74 07                	je     80102941 <kalloc+0x21>
    kmem.freelist = r->next;
8010293a:	8b 03                	mov    (%ebx),%eax
8010293c:	a3 78 6e 11 80       	mov    %eax,0x80116e78
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102941:	89 d8                	mov    %ebx,%eax
80102943:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102946:	c9                   	leave  
80102947:	c3                   	ret    
80102948:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010294f:	90                   	nop
    acquire(&kmem.lock);
80102950:	83 ec 0c             	sub    $0xc,%esp
80102953:	68 40 6e 11 80       	push   $0x80116e40
80102958:	e8 33 30 00 00       	call   80105990 <acquire>
  r = kmem.freelist;
8010295d:	8b 1d 78 6e 11 80    	mov    0x80116e78,%ebx
  if(r)
80102963:	83 c4 10             	add    $0x10,%esp
80102966:	a1 74 6e 11 80       	mov    0x80116e74,%eax
8010296b:	85 db                	test   %ebx,%ebx
8010296d:	74 08                	je     80102977 <kalloc+0x57>
    kmem.freelist = r->next;
8010296f:	8b 13                	mov    (%ebx),%edx
80102971:	89 15 78 6e 11 80    	mov    %edx,0x80116e78
  if(kmem.use_lock)
80102977:	85 c0                	test   %eax,%eax
80102979:	74 c6                	je     80102941 <kalloc+0x21>
    release(&kmem.lock);
8010297b:	83 ec 0c             	sub    $0xc,%esp
8010297e:	68 40 6e 11 80       	push   $0x80116e40
80102983:	e8 c8 30 00 00       	call   80105a50 <release>
}
80102988:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
8010298a:	83 c4 10             	add    $0x10,%esp
}
8010298d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102990:	c9                   	leave  
80102991:	c3                   	ret    
80102992:	66 90                	xchg   %ax,%ax
80102994:	66 90                	xchg   %ax,%ax
80102996:	66 90                	xchg   %ax,%ax
80102998:	66 90                	xchg   %ax,%ax
8010299a:	66 90                	xchg   %ax,%ax
8010299c:	66 90                	xchg   %ax,%ax
8010299e:	66 90                	xchg   %ax,%ax

801029a0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029a0:	ba 64 00 00 00       	mov    $0x64,%edx
801029a5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801029a6:	a8 01                	test   $0x1,%al
801029a8:	0f 84 c2 00 00 00    	je     80102a70 <kbdgetc+0xd0>
{
801029ae:	55                   	push   %ebp
801029af:	ba 60 00 00 00       	mov    $0x60,%edx
801029b4:	89 e5                	mov    %esp,%ebp
801029b6:	53                   	push   %ebx
801029b7:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
801029b8:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
801029bb:	8b 1d b4 c5 10 80    	mov    0x8010c5b4,%ebx
801029c1:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
801029c7:	74 57                	je     80102a20 <kbdgetc+0x80>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801029c9:	89 d9                	mov    %ebx,%ecx
801029cb:	83 e1 40             	and    $0x40,%ecx
801029ce:	84 c0                	test   %al,%al
801029d0:	78 5e                	js     80102a30 <kbdgetc+0x90>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801029d2:	85 c9                	test   %ecx,%ecx
801029d4:	74 09                	je     801029df <kbdgetc+0x3f>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801029d6:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801029d9:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
801029dc:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
801029df:	0f b6 8a 20 8b 10 80 	movzbl -0x7fef74e0(%edx),%ecx
  shift ^= togglecode[data];
801029e6:	0f b6 82 20 8a 10 80 	movzbl -0x7fef75e0(%edx),%eax
  shift |= shiftcode[data];
801029ed:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
801029ef:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801029f1:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
801029f3:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
  c = charcode[shift & (CTL | SHIFT)][data];
801029f9:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801029fc:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801029ff:	8b 04 85 00 8a 10 80 	mov    -0x7fef7600(,%eax,4),%eax
80102a06:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102a0a:	74 0b                	je     80102a17 <kbdgetc+0x77>
    if('a' <= c && c <= 'z')
80102a0c:	8d 50 9f             	lea    -0x61(%eax),%edx
80102a0f:	83 fa 19             	cmp    $0x19,%edx
80102a12:	77 44                	ja     80102a58 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102a14:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102a17:	5b                   	pop    %ebx
80102a18:	5d                   	pop    %ebp
80102a19:	c3                   	ret    
80102a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    shift |= E0ESC;
80102a20:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102a23:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102a25:	89 1d b4 c5 10 80    	mov    %ebx,0x8010c5b4
}
80102a2b:	5b                   	pop    %ebx
80102a2c:	5d                   	pop    %ebp
80102a2d:	c3                   	ret    
80102a2e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102a30:	83 e0 7f             	and    $0x7f,%eax
80102a33:	85 c9                	test   %ecx,%ecx
80102a35:	0f 44 d0             	cmove  %eax,%edx
    return 0;
80102a38:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
80102a3a:	0f b6 8a 20 8b 10 80 	movzbl -0x7fef74e0(%edx),%ecx
80102a41:	83 c9 40             	or     $0x40,%ecx
80102a44:	0f b6 c9             	movzbl %cl,%ecx
80102a47:	f7 d1                	not    %ecx
80102a49:	21 d9                	and    %ebx,%ecx
}
80102a4b:	5b                   	pop    %ebx
80102a4c:	5d                   	pop    %ebp
    shift &= ~(shiftcode[data] | E0ESC);
80102a4d:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
}
80102a53:	c3                   	ret    
80102a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102a58:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102a5b:	8d 50 20             	lea    0x20(%eax),%edx
}
80102a5e:	5b                   	pop    %ebx
80102a5f:	5d                   	pop    %ebp
      c += 'a' - 'A';
80102a60:	83 f9 1a             	cmp    $0x1a,%ecx
80102a63:	0f 42 c2             	cmovb  %edx,%eax
}
80102a66:	c3                   	ret    
80102a67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a6e:	66 90                	xchg   %ax,%ax
    return -1;
80102a70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102a75:	c3                   	ret    
80102a76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a7d:	8d 76 00             	lea    0x0(%esi),%esi

80102a80 <kbdintr>:

void
kbdintr(void)
{
80102a80:	55                   	push   %ebp
80102a81:	89 e5                	mov    %esp,%ebp
80102a83:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102a86:	68 a0 29 10 80       	push   $0x801029a0
80102a8b:	e8 d0 dd ff ff       	call   80100860 <consoleintr>
}
80102a90:	83 c4 10             	add    $0x10,%esp
80102a93:	c9                   	leave  
80102a94:	c3                   	ret    
80102a95:	66 90                	xchg   %ax,%ax
80102a97:	66 90                	xchg   %ax,%ax
80102a99:	66 90                	xchg   %ax,%ax
80102a9b:	66 90                	xchg   %ax,%ax
80102a9d:	66 90                	xchg   %ax,%ax
80102a9f:	90                   	nop

80102aa0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102aa0:	a1 7c 6e 11 80       	mov    0x80116e7c,%eax
80102aa5:	85 c0                	test   %eax,%eax
80102aa7:	0f 84 cb 00 00 00    	je     80102b78 <lapicinit+0xd8>
  lapic[index] = value;
80102aad:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102ab4:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ab7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102aba:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102ac1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ac4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102ac7:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102ace:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102ad1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102ad4:	c7 80 80 03 00 00 40 	movl   $0xf4240,0x380(%eax)
80102adb:	42 0f 00 
  lapic[ID];  // wait for write to finish, by reading
80102ade:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102ae1:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102ae8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102aeb:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102aee:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102af5:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102af8:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102afb:	8b 50 30             	mov    0x30(%eax),%edx
80102afe:	c1 ea 10             	shr    $0x10,%edx
80102b01:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102b07:	75 77                	jne    80102b80 <lapicinit+0xe0>
  lapic[index] = value;
80102b09:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102b10:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b13:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b16:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102b1d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b20:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b23:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102b2a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b2d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b30:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102b37:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b3a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b3d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102b44:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b47:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b4a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102b51:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102b54:	8b 50 20             	mov    0x20(%eax),%edx
80102b57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b5e:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102b60:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102b66:	80 e6 10             	and    $0x10,%dh
80102b69:	75 f5                	jne    80102b60 <lapicinit+0xc0>
  lapic[index] = value;
80102b6b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102b72:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b75:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102b78:	c3                   	ret    
80102b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102b80:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102b87:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102b8a:	8b 50 20             	mov    0x20(%eax),%edx
80102b8d:	e9 77 ff ff ff       	jmp    80102b09 <lapicinit+0x69>
80102b92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102ba0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102ba0:	a1 7c 6e 11 80       	mov    0x80116e7c,%eax
80102ba5:	85 c0                	test   %eax,%eax
80102ba7:	74 07                	je     80102bb0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80102ba9:	8b 40 20             	mov    0x20(%eax),%eax
80102bac:	c1 e8 18             	shr    $0x18,%eax
80102baf:	c3                   	ret    
    return 0;
80102bb0:	31 c0                	xor    %eax,%eax
}
80102bb2:	c3                   	ret    
80102bb3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102bc0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102bc0:	a1 7c 6e 11 80       	mov    0x80116e7c,%eax
80102bc5:	85 c0                	test   %eax,%eax
80102bc7:	74 0d                	je     80102bd6 <lapiceoi+0x16>
  lapic[index] = value;
80102bc9:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102bd0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102bd3:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102bd6:	c3                   	ret    
80102bd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102bde:	66 90                	xchg   %ax,%ax

80102be0 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102be0:	c3                   	ret    
80102be1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102be8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102bef:	90                   	nop

80102bf0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102bf0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bf1:	b8 0f 00 00 00       	mov    $0xf,%eax
80102bf6:	ba 70 00 00 00       	mov    $0x70,%edx
80102bfb:	89 e5                	mov    %esp,%ebp
80102bfd:	53                   	push   %ebx
80102bfe:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102c01:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102c04:	ee                   	out    %al,(%dx)
80102c05:	b8 0a 00 00 00       	mov    $0xa,%eax
80102c0a:	ba 71 00 00 00       	mov    $0x71,%edx
80102c0f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102c10:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102c12:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102c15:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102c1b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102c1d:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80102c20:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102c22:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102c25:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102c28:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102c2e:	a1 7c 6e 11 80       	mov    0x80116e7c,%eax
80102c33:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102c39:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102c3c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102c43:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c46:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102c49:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102c50:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c53:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102c56:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102c5c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102c5f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102c65:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102c68:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102c6e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c71:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
    microdelay(200);
  }
}
80102c77:	5b                   	pop    %ebx
  lapic[ID];  // wait for write to finish, by reading
80102c78:	8b 40 20             	mov    0x20(%eax),%eax
}
80102c7b:	5d                   	pop    %ebp
80102c7c:	c3                   	ret    
80102c7d:	8d 76 00             	lea    0x0(%esi),%esi

80102c80 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80102c80:	55                   	push   %ebp
80102c81:	b8 0b 00 00 00       	mov    $0xb,%eax
80102c86:	ba 70 00 00 00       	mov    $0x70,%edx
80102c8b:	89 e5                	mov    %esp,%ebp
80102c8d:	57                   	push   %edi
80102c8e:	56                   	push   %esi
80102c8f:	53                   	push   %ebx
80102c90:	83 ec 4c             	sub    $0x4c,%esp
80102c93:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c94:	ba 71 00 00 00       	mov    $0x71,%edx
80102c99:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102c9a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c9d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102ca2:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102ca5:	8d 76 00             	lea    0x0(%esi),%esi
80102ca8:	31 c0                	xor    %eax,%eax
80102caa:	89 da                	mov    %ebx,%edx
80102cac:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cad:	b9 71 00 00 00       	mov    $0x71,%ecx
80102cb2:	89 ca                	mov    %ecx,%edx
80102cb4:	ec                   	in     (%dx),%al
80102cb5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cb8:	89 da                	mov    %ebx,%edx
80102cba:	b8 02 00 00 00       	mov    $0x2,%eax
80102cbf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cc0:	89 ca                	mov    %ecx,%edx
80102cc2:	ec                   	in     (%dx),%al
80102cc3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cc6:	89 da                	mov    %ebx,%edx
80102cc8:	b8 04 00 00 00       	mov    $0x4,%eax
80102ccd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cce:	89 ca                	mov    %ecx,%edx
80102cd0:	ec                   	in     (%dx),%al
80102cd1:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cd4:	89 da                	mov    %ebx,%edx
80102cd6:	b8 07 00 00 00       	mov    $0x7,%eax
80102cdb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cdc:	89 ca                	mov    %ecx,%edx
80102cde:	ec                   	in     (%dx),%al
80102cdf:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ce2:	89 da                	mov    %ebx,%edx
80102ce4:	b8 08 00 00 00       	mov    $0x8,%eax
80102ce9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cea:	89 ca                	mov    %ecx,%edx
80102cec:	ec                   	in     (%dx),%al
80102ced:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cef:	89 da                	mov    %ebx,%edx
80102cf1:	b8 09 00 00 00       	mov    $0x9,%eax
80102cf6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cf7:	89 ca                	mov    %ecx,%edx
80102cf9:	ec                   	in     (%dx),%al
80102cfa:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cfc:	89 da                	mov    %ebx,%edx
80102cfe:	b8 0a 00 00 00       	mov    $0xa,%eax
80102d03:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d04:	89 ca                	mov    %ecx,%edx
80102d06:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102d07:	84 c0                	test   %al,%al
80102d09:	78 9d                	js     80102ca8 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102d0b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102d0f:	89 fa                	mov    %edi,%edx
80102d11:	0f b6 fa             	movzbl %dl,%edi
80102d14:	89 f2                	mov    %esi,%edx
80102d16:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102d19:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102d1d:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d20:	89 da                	mov    %ebx,%edx
80102d22:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102d25:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102d28:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102d2c:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102d2f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102d32:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102d36:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102d39:	31 c0                	xor    %eax,%eax
80102d3b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d3c:	89 ca                	mov    %ecx,%edx
80102d3e:	ec                   	in     (%dx),%al
80102d3f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d42:	89 da                	mov    %ebx,%edx
80102d44:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102d47:	b8 02 00 00 00       	mov    $0x2,%eax
80102d4c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d4d:	89 ca                	mov    %ecx,%edx
80102d4f:	ec                   	in     (%dx),%al
80102d50:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d53:	89 da                	mov    %ebx,%edx
80102d55:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102d58:	b8 04 00 00 00       	mov    $0x4,%eax
80102d5d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d5e:	89 ca                	mov    %ecx,%edx
80102d60:	ec                   	in     (%dx),%al
80102d61:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d64:	89 da                	mov    %ebx,%edx
80102d66:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102d69:	b8 07 00 00 00       	mov    $0x7,%eax
80102d6e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d6f:	89 ca                	mov    %ecx,%edx
80102d71:	ec                   	in     (%dx),%al
80102d72:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d75:	89 da                	mov    %ebx,%edx
80102d77:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102d7a:	b8 08 00 00 00       	mov    $0x8,%eax
80102d7f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d80:	89 ca                	mov    %ecx,%edx
80102d82:	ec                   	in     (%dx),%al
80102d83:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d86:	89 da                	mov    %ebx,%edx
80102d88:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102d8b:	b8 09 00 00 00       	mov    $0x9,%eax
80102d90:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d91:	89 ca                	mov    %ecx,%edx
80102d93:	ec                   	in     (%dx),%al
80102d94:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102d97:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102d9a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102d9d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102da0:	6a 18                	push   $0x18
80102da2:	50                   	push   %eax
80102da3:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102da6:	50                   	push   %eax
80102da7:	e8 44 2d 00 00       	call   80105af0 <memcmp>
80102dac:	83 c4 10             	add    $0x10,%esp
80102daf:	85 c0                	test   %eax,%eax
80102db1:	0f 85 f1 fe ff ff    	jne    80102ca8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102db7:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102dbb:	75 78                	jne    80102e35 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102dbd:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102dc0:	89 c2                	mov    %eax,%edx
80102dc2:	83 e0 0f             	and    $0xf,%eax
80102dc5:	c1 ea 04             	shr    $0x4,%edx
80102dc8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102dcb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102dce:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102dd1:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102dd4:	89 c2                	mov    %eax,%edx
80102dd6:	83 e0 0f             	and    $0xf,%eax
80102dd9:	c1 ea 04             	shr    $0x4,%edx
80102ddc:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ddf:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102de2:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102de5:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102de8:	89 c2                	mov    %eax,%edx
80102dea:	83 e0 0f             	and    $0xf,%eax
80102ded:	c1 ea 04             	shr    $0x4,%edx
80102df0:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102df3:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102df6:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102df9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102dfc:	89 c2                	mov    %eax,%edx
80102dfe:	83 e0 0f             	and    $0xf,%eax
80102e01:	c1 ea 04             	shr    $0x4,%edx
80102e04:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102e07:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102e0a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102e0d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102e10:	89 c2                	mov    %eax,%edx
80102e12:	83 e0 0f             	and    $0xf,%eax
80102e15:	c1 ea 04             	shr    $0x4,%edx
80102e18:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102e1b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102e1e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102e21:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102e24:	89 c2                	mov    %eax,%edx
80102e26:	83 e0 0f             	and    $0xf,%eax
80102e29:	c1 ea 04             	shr    $0x4,%edx
80102e2c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102e2f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102e32:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102e35:	8b 75 08             	mov    0x8(%ebp),%esi
80102e38:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102e3b:	89 06                	mov    %eax,(%esi)
80102e3d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102e40:	89 46 04             	mov    %eax,0x4(%esi)
80102e43:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102e46:	89 46 08             	mov    %eax,0x8(%esi)
80102e49:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102e4c:	89 46 0c             	mov    %eax,0xc(%esi)
80102e4f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102e52:	89 46 10             	mov    %eax,0x10(%esi)
80102e55:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102e58:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102e5b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102e62:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e65:	5b                   	pop    %ebx
80102e66:	5e                   	pop    %esi
80102e67:	5f                   	pop    %edi
80102e68:	5d                   	pop    %ebp
80102e69:	c3                   	ret    
80102e6a:	66 90                	xchg   %ax,%ax
80102e6c:	66 90                	xchg   %ax,%ax
80102e6e:	66 90                	xchg   %ax,%ax

80102e70 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102e70:	8b 0d c8 6e 11 80    	mov    0x80116ec8,%ecx
80102e76:	85 c9                	test   %ecx,%ecx
80102e78:	0f 8e 8a 00 00 00    	jle    80102f08 <install_trans+0x98>
{
80102e7e:	55                   	push   %ebp
80102e7f:	89 e5                	mov    %esp,%ebp
80102e81:	57                   	push   %edi
80102e82:	56                   	push   %esi
80102e83:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102e84:	31 db                	xor    %ebx,%ebx
{
80102e86:	83 ec 0c             	sub    $0xc,%esp
80102e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102e90:	a1 b4 6e 11 80       	mov    0x80116eb4,%eax
80102e95:	83 ec 08             	sub    $0x8,%esp
80102e98:	01 d8                	add    %ebx,%eax
80102e9a:	83 c0 01             	add    $0x1,%eax
80102e9d:	50                   	push   %eax
80102e9e:	ff 35 c4 6e 11 80    	pushl  0x80116ec4
80102ea4:	e8 27 d2 ff ff       	call   801000d0 <bread>
80102ea9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102eab:	58                   	pop    %eax
80102eac:	5a                   	pop    %edx
80102ead:	ff 34 9d cc 6e 11 80 	pushl  -0x7fee9134(,%ebx,4)
80102eb4:	ff 35 c4 6e 11 80    	pushl  0x80116ec4
  for (tail = 0; tail < log.lh.n; tail++) {
80102eba:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102ebd:	e8 0e d2 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102ec2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102ec5:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102ec7:	8d 47 5c             	lea    0x5c(%edi),%eax
80102eca:	68 00 02 00 00       	push   $0x200
80102ecf:	50                   	push   %eax
80102ed0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102ed3:	50                   	push   %eax
80102ed4:	e8 67 2c 00 00       	call   80105b40 <memmove>
    bwrite(dbuf);  // write dst to disk
80102ed9:	89 34 24             	mov    %esi,(%esp)
80102edc:	e8 cf d2 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102ee1:	89 3c 24             	mov    %edi,(%esp)
80102ee4:	e8 07 d3 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102ee9:	89 34 24             	mov    %esi,(%esp)
80102eec:	e8 ff d2 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102ef1:	83 c4 10             	add    $0x10,%esp
80102ef4:	39 1d c8 6e 11 80    	cmp    %ebx,0x80116ec8
80102efa:	7f 94                	jg     80102e90 <install_trans+0x20>
  }
}
80102efc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102eff:	5b                   	pop    %ebx
80102f00:	5e                   	pop    %esi
80102f01:	5f                   	pop    %edi
80102f02:	5d                   	pop    %ebp
80102f03:	c3                   	ret    
80102f04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102f08:	c3                   	ret    
80102f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102f10 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102f10:	55                   	push   %ebp
80102f11:	89 e5                	mov    %esp,%ebp
80102f13:	53                   	push   %ebx
80102f14:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102f17:	ff 35 b4 6e 11 80    	pushl  0x80116eb4
80102f1d:	ff 35 c4 6e 11 80    	pushl  0x80116ec4
80102f23:	e8 a8 d1 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102f28:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102f2b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102f2d:	a1 c8 6e 11 80       	mov    0x80116ec8,%eax
80102f32:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102f35:	85 c0                	test   %eax,%eax
80102f37:	7e 19                	jle    80102f52 <write_head+0x42>
80102f39:	31 d2                	xor    %edx,%edx
80102f3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102f3f:	90                   	nop
    hb->block[i] = log.lh.block[i];
80102f40:	8b 0c 95 cc 6e 11 80 	mov    -0x7fee9134(,%edx,4),%ecx
80102f47:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102f4b:	83 c2 01             	add    $0x1,%edx
80102f4e:	39 d0                	cmp    %edx,%eax
80102f50:	75 ee                	jne    80102f40 <write_head+0x30>
  }
  bwrite(buf);
80102f52:	83 ec 0c             	sub    $0xc,%esp
80102f55:	53                   	push   %ebx
80102f56:	e8 55 d2 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102f5b:	89 1c 24             	mov    %ebx,(%esp)
80102f5e:	e8 8d d2 ff ff       	call   801001f0 <brelse>
}
80102f63:	83 c4 10             	add    $0x10,%esp
80102f66:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f69:	c9                   	leave  
80102f6a:	c3                   	ret    
80102f6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102f6f:	90                   	nop

80102f70 <initlog>:
{
80102f70:	55                   	push   %ebp
80102f71:	89 e5                	mov    %esp,%ebp
80102f73:	53                   	push   %ebx
80102f74:	83 ec 2c             	sub    $0x2c,%esp
80102f77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102f7a:	68 20 8c 10 80       	push   $0x80108c20
80102f7f:	68 80 6e 11 80       	push   $0x80116e80
80102f84:	e8 a7 28 00 00       	call   80105830 <initlock>
  readsb(dev, &sb);
80102f89:	58                   	pop    %eax
80102f8a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102f8d:	5a                   	pop    %edx
80102f8e:	50                   	push   %eax
80102f8f:	53                   	push   %ebx
80102f90:	e8 4b e6 ff ff       	call   801015e0 <readsb>
  log.start = sb.logstart;
80102f95:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102f98:	59                   	pop    %ecx
  log.dev = dev;
80102f99:	89 1d c4 6e 11 80    	mov    %ebx,0x80116ec4
  log.size = sb.nlog;
80102f9f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102fa2:	a3 b4 6e 11 80       	mov    %eax,0x80116eb4
  log.size = sb.nlog;
80102fa7:	89 15 b8 6e 11 80    	mov    %edx,0x80116eb8
  struct buf *buf = bread(log.dev, log.start);
80102fad:	5a                   	pop    %edx
80102fae:	50                   	push   %eax
80102faf:	53                   	push   %ebx
80102fb0:	e8 1b d1 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102fb5:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102fb8:	8b 48 5c             	mov    0x5c(%eax),%ecx
80102fbb:	89 0d c8 6e 11 80    	mov    %ecx,0x80116ec8
  for (i = 0; i < log.lh.n; i++) {
80102fc1:	85 c9                	test   %ecx,%ecx
80102fc3:	7e 1d                	jle    80102fe2 <initlog+0x72>
80102fc5:	31 d2                	xor    %edx,%edx
80102fc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fce:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102fd0:	8b 5c 90 60          	mov    0x60(%eax,%edx,4),%ebx
80102fd4:	89 1c 95 cc 6e 11 80 	mov    %ebx,-0x7fee9134(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102fdb:	83 c2 01             	add    $0x1,%edx
80102fde:	39 d1                	cmp    %edx,%ecx
80102fe0:	75 ee                	jne    80102fd0 <initlog+0x60>
  brelse(buf);
80102fe2:	83 ec 0c             	sub    $0xc,%esp
80102fe5:	50                   	push   %eax
80102fe6:	e8 05 d2 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102feb:	e8 80 fe ff ff       	call   80102e70 <install_trans>
  log.lh.n = 0;
80102ff0:	c7 05 c8 6e 11 80 00 	movl   $0x0,0x80116ec8
80102ff7:	00 00 00 
  write_head(); // clear the log
80102ffa:	e8 11 ff ff ff       	call   80102f10 <write_head>
}
80102fff:	83 c4 10             	add    $0x10,%esp
80103002:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103005:	c9                   	leave  
80103006:	c3                   	ret    
80103007:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010300e:	66 90                	xchg   %ax,%ax

80103010 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103010:	55                   	push   %ebp
80103011:	89 e5                	mov    %esp,%ebp
80103013:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80103016:	68 80 6e 11 80       	push   $0x80116e80
8010301b:	e8 70 29 00 00       	call   80105990 <acquire>
80103020:	83 c4 10             	add    $0x10,%esp
80103023:	eb 18                	jmp    8010303d <begin_op+0x2d>
80103025:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103028:	83 ec 08             	sub    $0x8,%esp
8010302b:	68 80 6e 11 80       	push   $0x80116e80
80103030:	68 80 6e 11 80       	push   $0x80116e80
80103035:	e8 76 1b 00 00       	call   80104bb0 <sleep>
8010303a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
8010303d:	a1 c0 6e 11 80       	mov    0x80116ec0,%eax
80103042:	85 c0                	test   %eax,%eax
80103044:	75 e2                	jne    80103028 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103046:	a1 bc 6e 11 80       	mov    0x80116ebc,%eax
8010304b:	8b 15 c8 6e 11 80    	mov    0x80116ec8,%edx
80103051:	83 c0 01             	add    $0x1,%eax
80103054:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103057:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
8010305a:	83 fa 1e             	cmp    $0x1e,%edx
8010305d:	7f c9                	jg     80103028 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
8010305f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80103062:	a3 bc 6e 11 80       	mov    %eax,0x80116ebc
      release(&log.lock);
80103067:	68 80 6e 11 80       	push   $0x80116e80
8010306c:	e8 df 29 00 00       	call   80105a50 <release>
      break;
    }
  }
}
80103071:	83 c4 10             	add    $0x10,%esp
80103074:	c9                   	leave  
80103075:	c3                   	ret    
80103076:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010307d:	8d 76 00             	lea    0x0(%esi),%esi

80103080 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103080:	55                   	push   %ebp
80103081:	89 e5                	mov    %esp,%ebp
80103083:	57                   	push   %edi
80103084:	56                   	push   %esi
80103085:	53                   	push   %ebx
80103086:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103089:	68 80 6e 11 80       	push   $0x80116e80
8010308e:	e8 fd 28 00 00       	call   80105990 <acquire>
  log.outstanding -= 1;
80103093:	a1 bc 6e 11 80       	mov    0x80116ebc,%eax
  if(log.committing)
80103098:	8b 35 c0 6e 11 80    	mov    0x80116ec0,%esi
8010309e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
801030a1:	8d 58 ff             	lea    -0x1(%eax),%ebx
801030a4:	89 1d bc 6e 11 80    	mov    %ebx,0x80116ebc
  if(log.committing)
801030aa:	85 f6                	test   %esi,%esi
801030ac:	0f 85 22 01 00 00    	jne    801031d4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
801030b2:	85 db                	test   %ebx,%ebx
801030b4:	0f 85 f6 00 00 00    	jne    801031b0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
801030ba:	c7 05 c0 6e 11 80 01 	movl   $0x1,0x80116ec0
801030c1:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
801030c4:	83 ec 0c             	sub    $0xc,%esp
801030c7:	68 80 6e 11 80       	push   $0x80116e80
801030cc:	e8 7f 29 00 00       	call   80105a50 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
801030d1:	8b 0d c8 6e 11 80    	mov    0x80116ec8,%ecx
801030d7:	83 c4 10             	add    $0x10,%esp
801030da:	85 c9                	test   %ecx,%ecx
801030dc:	7f 42                	jg     80103120 <end_op+0xa0>
    acquire(&log.lock);
801030de:	83 ec 0c             	sub    $0xc,%esp
801030e1:	68 80 6e 11 80       	push   $0x80116e80
801030e6:	e8 a5 28 00 00       	call   80105990 <acquire>
    wakeup(&log);
801030eb:	c7 04 24 80 6e 11 80 	movl   $0x80116e80,(%esp)
    log.committing = 0;
801030f2:	c7 05 c0 6e 11 80 00 	movl   $0x0,0x80116ec0
801030f9:	00 00 00 
    wakeup(&log);
801030fc:	e8 5f 1e 00 00       	call   80104f60 <wakeup>
    release(&log.lock);
80103101:	c7 04 24 80 6e 11 80 	movl   $0x80116e80,(%esp)
80103108:	e8 43 29 00 00       	call   80105a50 <release>
8010310d:	83 c4 10             	add    $0x10,%esp
}
80103110:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103113:	5b                   	pop    %ebx
80103114:	5e                   	pop    %esi
80103115:	5f                   	pop    %edi
80103116:	5d                   	pop    %ebp
80103117:	c3                   	ret    
80103118:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010311f:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103120:	a1 b4 6e 11 80       	mov    0x80116eb4,%eax
80103125:	83 ec 08             	sub    $0x8,%esp
80103128:	01 d8                	add    %ebx,%eax
8010312a:	83 c0 01             	add    $0x1,%eax
8010312d:	50                   	push   %eax
8010312e:	ff 35 c4 6e 11 80    	pushl  0x80116ec4
80103134:	e8 97 cf ff ff       	call   801000d0 <bread>
80103139:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010313b:	58                   	pop    %eax
8010313c:	5a                   	pop    %edx
8010313d:	ff 34 9d cc 6e 11 80 	pushl  -0x7fee9134(,%ebx,4)
80103144:	ff 35 c4 6e 11 80    	pushl  0x80116ec4
  for (tail = 0; tail < log.lh.n; tail++) {
8010314a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010314d:	e8 7e cf ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103152:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103155:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103157:	8d 40 5c             	lea    0x5c(%eax),%eax
8010315a:	68 00 02 00 00       	push   $0x200
8010315f:	50                   	push   %eax
80103160:	8d 46 5c             	lea    0x5c(%esi),%eax
80103163:	50                   	push   %eax
80103164:	e8 d7 29 00 00       	call   80105b40 <memmove>
    bwrite(to);  // write the log
80103169:	89 34 24             	mov    %esi,(%esp)
8010316c:	e8 3f d0 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103171:	89 3c 24             	mov    %edi,(%esp)
80103174:	e8 77 d0 ff ff       	call   801001f0 <brelse>
    brelse(to);
80103179:	89 34 24             	mov    %esi,(%esp)
8010317c:	e8 6f d0 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103181:	83 c4 10             	add    $0x10,%esp
80103184:	3b 1d c8 6e 11 80    	cmp    0x80116ec8,%ebx
8010318a:	7c 94                	jl     80103120 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
8010318c:	e8 7f fd ff ff       	call   80102f10 <write_head>
    install_trans(); // Now install writes to home locations
80103191:	e8 da fc ff ff       	call   80102e70 <install_trans>
    log.lh.n = 0;
80103196:	c7 05 c8 6e 11 80 00 	movl   $0x0,0x80116ec8
8010319d:	00 00 00 
    write_head();    // Erase the transaction from the log
801031a0:	e8 6b fd ff ff       	call   80102f10 <write_head>
801031a5:	e9 34 ff ff ff       	jmp    801030de <end_op+0x5e>
801031aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
801031b0:	83 ec 0c             	sub    $0xc,%esp
801031b3:	68 80 6e 11 80       	push   $0x80116e80
801031b8:	e8 a3 1d 00 00       	call   80104f60 <wakeup>
  release(&log.lock);
801031bd:	c7 04 24 80 6e 11 80 	movl   $0x80116e80,(%esp)
801031c4:	e8 87 28 00 00       	call   80105a50 <release>
801031c9:	83 c4 10             	add    $0x10,%esp
}
801031cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031cf:	5b                   	pop    %ebx
801031d0:	5e                   	pop    %esi
801031d1:	5f                   	pop    %edi
801031d2:	5d                   	pop    %ebp
801031d3:	c3                   	ret    
    panic("log.committing");
801031d4:	83 ec 0c             	sub    $0xc,%esp
801031d7:	68 24 8c 10 80       	push   $0x80108c24
801031dc:	e8 af d1 ff ff       	call   80100390 <panic>
801031e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031ef:	90                   	nop

801031f0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801031f0:	55                   	push   %ebp
801031f1:	89 e5                	mov    %esp,%ebp
801031f3:	53                   	push   %ebx
801031f4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801031f7:	8b 15 c8 6e 11 80    	mov    0x80116ec8,%edx
{
801031fd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103200:	83 fa 1d             	cmp    $0x1d,%edx
80103203:	0f 8f 94 00 00 00    	jg     8010329d <log_write+0xad>
80103209:	a1 b8 6e 11 80       	mov    0x80116eb8,%eax
8010320e:	83 e8 01             	sub    $0x1,%eax
80103211:	39 c2                	cmp    %eax,%edx
80103213:	0f 8d 84 00 00 00    	jge    8010329d <log_write+0xad>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103219:	a1 bc 6e 11 80       	mov    0x80116ebc,%eax
8010321e:	85 c0                	test   %eax,%eax
80103220:	0f 8e 84 00 00 00    	jle    801032aa <log_write+0xba>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103226:	83 ec 0c             	sub    $0xc,%esp
80103229:	68 80 6e 11 80       	push   $0x80116e80
8010322e:	e8 5d 27 00 00       	call   80105990 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103233:	8b 15 c8 6e 11 80    	mov    0x80116ec8,%edx
80103239:	83 c4 10             	add    $0x10,%esp
8010323c:	85 d2                	test   %edx,%edx
8010323e:	7e 51                	jle    80103291 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103240:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80103243:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103245:	3b 0d cc 6e 11 80    	cmp    0x80116ecc,%ecx
8010324b:	75 0c                	jne    80103259 <log_write+0x69>
8010324d:	eb 39                	jmp    80103288 <log_write+0x98>
8010324f:	90                   	nop
80103250:	39 0c 85 cc 6e 11 80 	cmp    %ecx,-0x7fee9134(,%eax,4)
80103257:	74 2f                	je     80103288 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80103259:	83 c0 01             	add    $0x1,%eax
8010325c:	39 c2                	cmp    %eax,%edx
8010325e:	75 f0                	jne    80103250 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80103260:	89 0c 95 cc 6e 11 80 	mov    %ecx,-0x7fee9134(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80103267:	83 c2 01             	add    $0x1,%edx
8010326a:	89 15 c8 6e 11 80    	mov    %edx,0x80116ec8
  b->flags |= B_DIRTY; // prevent eviction
80103270:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80103273:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80103276:	c7 45 08 80 6e 11 80 	movl   $0x80116e80,0x8(%ebp)
}
8010327d:	c9                   	leave  
  release(&log.lock);
8010327e:	e9 cd 27 00 00       	jmp    80105a50 <release>
80103283:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103287:	90                   	nop
  log.lh.block[i] = b->blockno;
80103288:	89 0c 85 cc 6e 11 80 	mov    %ecx,-0x7fee9134(,%eax,4)
  if (i == log.lh.n)
8010328f:	eb df                	jmp    80103270 <log_write+0x80>
  log.lh.block[i] = b->blockno;
80103291:	8b 43 08             	mov    0x8(%ebx),%eax
80103294:	a3 cc 6e 11 80       	mov    %eax,0x80116ecc
  if (i == log.lh.n)
80103299:	75 d5                	jne    80103270 <log_write+0x80>
8010329b:	eb ca                	jmp    80103267 <log_write+0x77>
    panic("too big a transaction");
8010329d:	83 ec 0c             	sub    $0xc,%esp
801032a0:	68 33 8c 10 80       	push   $0x80108c33
801032a5:	e8 e6 d0 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
801032aa:	83 ec 0c             	sub    $0xc,%esp
801032ad:	68 49 8c 10 80       	push   $0x80108c49
801032b2:	e8 d9 d0 ff ff       	call   80100390 <panic>
801032b7:	66 90                	xchg   %ax,%ax
801032b9:	66 90                	xchg   %ax,%ax
801032bb:	66 90                	xchg   %ax,%ax
801032bd:	66 90                	xchg   %ax,%ax
801032bf:	90                   	nop

801032c0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801032c0:	55                   	push   %ebp
801032c1:	89 e5                	mov    %esp,%ebp
801032c3:	53                   	push   %ebx
801032c4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801032c7:	e8 24 0c 00 00       	call   80103ef0 <cpuid>
801032cc:	89 c3                	mov    %eax,%ebx
801032ce:	e8 1d 0c 00 00       	call   80103ef0 <cpuid>
801032d3:	83 ec 04             	sub    $0x4,%esp
801032d6:	53                   	push   %ebx
801032d7:	50                   	push   %eax
801032d8:	68 64 8c 10 80       	push   $0x80108c64
801032dd:	e8 ce d3 ff ff       	call   801006b0 <cprintf>
  idtinit();       // load idt register
801032e2:	e8 a9 3c 00 00       	call   80106f90 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801032e7:	e8 84 0b 00 00       	call   80103e70 <mycpu>
801032ec:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801032ee:	b8 01 00 00 00       	mov    $0x1,%eax
801032f3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
801032fa:	e8 c1 11 00 00       	call   801044c0 <scheduler>
801032ff:	90                   	nop

80103300 <mpenter>:
{
80103300:	55                   	push   %ebp
80103301:	89 e5                	mov    %esp,%ebp
80103303:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103306:	e8 95 4d 00 00       	call   801080a0 <switchkvm>
  seginit();
8010330b:	e8 00 4d 00 00       	call   80108010 <seginit>
  lapicinit();
80103310:	e8 8b f7 ff ff       	call   80102aa0 <lapicinit>
  mpmain();
80103315:	e8 a6 ff ff ff       	call   801032c0 <mpmain>
8010331a:	66 90                	xchg   %ax,%ax
8010331c:	66 90                	xchg   %ax,%ax
8010331e:	66 90                	xchg   %ax,%ax

80103320 <main>:
{
80103320:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103324:	83 e4 f0             	and    $0xfffffff0,%esp
80103327:	ff 71 fc             	pushl  -0x4(%ecx)
8010332a:	55                   	push   %ebp
8010332b:	89 e5                	mov    %esp,%ebp
8010332d:	53                   	push   %ebx
8010332e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010332f:	83 ec 08             	sub    $0x8,%esp
80103332:	68 00 00 40 80       	push   $0x80400000
80103337:	68 28 7d 11 80       	push   $0x80117d28
8010333c:	e8 0f f5 ff ff       	call   80102850 <kinit1>
  kvmalloc();      // kernel page table
80103341:	e8 1a 52 00 00       	call   80108560 <kvmalloc>
  mpinit();        // detect other processors
80103346:	e8 85 01 00 00       	call   801034d0 <mpinit>
  lapicinit();     // interrupt controller
8010334b:	e8 50 f7 ff ff       	call   80102aa0 <lapicinit>
  seginit();       // segment descriptors
80103350:	e8 bb 4c 00 00       	call   80108010 <seginit>
  picinit();       // disable pic
80103355:	e8 46 03 00 00       	call   801036a0 <picinit>
  ioapicinit();    // another interrupt controller
8010335a:	e8 11 f3 ff ff       	call   80102670 <ioapicinit>
  consoleinit();   // console hardware
8010335f:	e8 9c d7 ff ff       	call   80100b00 <consoleinit>
  uartinit();      // serial port
80103364:	e8 67 3f 00 00       	call   801072d0 <uartinit>
  pinit();         // process table
80103369:	e8 e2 0a 00 00       	call   80103e50 <pinit>
  tvinit();        // trap vectors
8010336e:	e8 bd 3b 00 00       	call   80106f30 <tvinit>
  binit();         // buffer cache
80103373:	e8 c8 cc ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103378:	e8 e3 db ff ff       	call   80100f60 <fileinit>
  ideinit();       // disk 
8010337d:	e8 ce f0 ff ff       	call   80102450 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103382:	83 c4 0c             	add    $0xc,%esp
80103385:	68 8a 00 00 00       	push   $0x8a
8010338a:	68 8c c4 10 80       	push   $0x8010c48c
8010338f:	68 00 70 00 80       	push   $0x80007000
80103394:	e8 a7 27 00 00       	call   80105b40 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103399:	83 c4 10             	add    $0x10,%esp
8010339c:	69 05 00 75 11 80 b0 	imul   $0xb0,0x80117500,%eax
801033a3:	00 00 00 
801033a6:	05 80 6f 11 80       	add    $0x80116f80,%eax
801033ab:	3d 80 6f 11 80       	cmp    $0x80116f80,%eax
801033b0:	76 7e                	jbe    80103430 <main+0x110>
801033b2:	bb 80 6f 11 80       	mov    $0x80116f80,%ebx
801033b7:	eb 20                	jmp    801033d9 <main+0xb9>
801033b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033c0:	69 05 00 75 11 80 b0 	imul   $0xb0,0x80117500,%eax
801033c7:	00 00 00 
801033ca:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801033d0:	05 80 6f 11 80       	add    $0x80116f80,%eax
801033d5:	39 c3                	cmp    %eax,%ebx
801033d7:	73 57                	jae    80103430 <main+0x110>
    if(c == mycpu())  // We've started already.
801033d9:	e8 92 0a 00 00       	call   80103e70 <mycpu>
801033de:	39 d8                	cmp    %ebx,%eax
801033e0:	74 de                	je     801033c0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801033e2:	e8 39 f5 ff ff       	call   80102920 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
801033e7:	83 ec 08             	sub    $0x8,%esp
    *(void**)(code-8) = mpenter;
801033ea:	c7 05 f8 6f 00 80 00 	movl   $0x80103300,0x80006ff8
801033f1:	33 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801033f4:	c7 05 f4 6f 00 80 00 	movl   $0x10b000,0x80006ff4
801033fb:	b0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
801033fe:	05 00 10 00 00       	add    $0x1000,%eax
80103403:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103408:	0f b6 03             	movzbl (%ebx),%eax
8010340b:	68 00 70 00 00       	push   $0x7000
80103410:	50                   	push   %eax
80103411:	e8 da f7 ff ff       	call   80102bf0 <lapicstartap>
80103416:	83 c4 10             	add    $0x10,%esp
80103419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103420:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103426:	85 c0                	test   %eax,%eax
80103428:	74 f6                	je     80103420 <main+0x100>
8010342a:	eb 94                	jmp    801033c0 <main+0xa0>
8010342c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103430:	83 ec 08             	sub    $0x8,%esp
80103433:	68 00 00 00 8e       	push   $0x8e000000
80103438:	68 00 00 40 80       	push   $0x80400000
8010343d:	e8 7e f4 ff ff       	call   801028c0 <kinit2>
  userinit();      // first user process
80103442:	e8 f9 0a 00 00       	call   80103f40 <userinit>
  mpmain();        // finish this processor's setup
80103447:	e8 74 fe ff ff       	call   801032c0 <mpmain>
8010344c:	66 90                	xchg   %ax,%ax
8010344e:	66 90                	xchg   %ax,%ax

80103450 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103450:	55                   	push   %ebp
80103451:	89 e5                	mov    %esp,%ebp
80103453:	57                   	push   %edi
80103454:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103455:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010345b:	53                   	push   %ebx
  e = addr+len;
8010345c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010345f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103462:	39 de                	cmp    %ebx,%esi
80103464:	72 10                	jb     80103476 <mpsearch1+0x26>
80103466:	eb 50                	jmp    801034b8 <mpsearch1+0x68>
80103468:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010346f:	90                   	nop
80103470:	89 fe                	mov    %edi,%esi
80103472:	39 fb                	cmp    %edi,%ebx
80103474:	76 42                	jbe    801034b8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103476:	83 ec 04             	sub    $0x4,%esp
80103479:	8d 7e 10             	lea    0x10(%esi),%edi
8010347c:	6a 04                	push   $0x4
8010347e:	68 78 8c 10 80       	push   $0x80108c78
80103483:	56                   	push   %esi
80103484:	e8 67 26 00 00       	call   80105af0 <memcmp>
80103489:	83 c4 10             	add    $0x10,%esp
8010348c:	85 c0                	test   %eax,%eax
8010348e:	75 e0                	jne    80103470 <mpsearch1+0x20>
80103490:	89 f1                	mov    %esi,%ecx
80103492:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103498:	0f b6 11             	movzbl (%ecx),%edx
8010349b:	83 c1 01             	add    $0x1,%ecx
8010349e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
801034a0:	39 f9                	cmp    %edi,%ecx
801034a2:	75 f4                	jne    80103498 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801034a4:	84 c0                	test   %al,%al
801034a6:	75 c8                	jne    80103470 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801034a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801034ab:	89 f0                	mov    %esi,%eax
801034ad:	5b                   	pop    %ebx
801034ae:	5e                   	pop    %esi
801034af:	5f                   	pop    %edi
801034b0:	5d                   	pop    %ebp
801034b1:	c3                   	ret    
801034b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801034b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801034bb:	31 f6                	xor    %esi,%esi
}
801034bd:	5b                   	pop    %ebx
801034be:	89 f0                	mov    %esi,%eax
801034c0:	5e                   	pop    %esi
801034c1:	5f                   	pop    %edi
801034c2:	5d                   	pop    %ebp
801034c3:	c3                   	ret    
801034c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801034cf:	90                   	nop

801034d0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801034d0:	55                   	push   %ebp
801034d1:	89 e5                	mov    %esp,%ebp
801034d3:	57                   	push   %edi
801034d4:	56                   	push   %esi
801034d5:	53                   	push   %ebx
801034d6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801034d9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801034e0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801034e7:	c1 e0 08             	shl    $0x8,%eax
801034ea:	09 d0                	or     %edx,%eax
801034ec:	c1 e0 04             	shl    $0x4,%eax
801034ef:	75 1b                	jne    8010350c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801034f1:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801034f8:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801034ff:	c1 e0 08             	shl    $0x8,%eax
80103502:	09 d0                	or     %edx,%eax
80103504:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103507:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010350c:	ba 00 04 00 00       	mov    $0x400,%edx
80103511:	e8 3a ff ff ff       	call   80103450 <mpsearch1>
80103516:	89 c7                	mov    %eax,%edi
80103518:	85 c0                	test   %eax,%eax
8010351a:	0f 84 c0 00 00 00    	je     801035e0 <mpinit+0x110>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103520:	8b 5f 04             	mov    0x4(%edi),%ebx
80103523:	85 db                	test   %ebx,%ebx
80103525:	0f 84 d5 00 00 00    	je     80103600 <mpinit+0x130>
  if(memcmp(conf, "PCMP", 4) != 0)
8010352b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010352e:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103534:	6a 04                	push   $0x4
80103536:	68 95 8c 10 80       	push   $0x80108c95
8010353b:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010353c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
8010353f:	e8 ac 25 00 00       	call   80105af0 <memcmp>
80103544:	83 c4 10             	add    $0x10,%esp
80103547:	85 c0                	test   %eax,%eax
80103549:	0f 85 b1 00 00 00    	jne    80103600 <mpinit+0x130>
  if(conf->version != 1 && conf->version != 4)
8010354f:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103556:	3c 01                	cmp    $0x1,%al
80103558:	0f 95 c2             	setne  %dl
8010355b:	3c 04                	cmp    $0x4,%al
8010355d:	0f 95 c0             	setne  %al
80103560:	20 c2                	and    %al,%dl
80103562:	0f 85 98 00 00 00    	jne    80103600 <mpinit+0x130>
  if(sum((uchar*)conf, conf->length) != 0)
80103568:	0f b7 8b 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%ecx
  for(i=0; i<len; i++)
8010356f:	66 85 c9             	test   %cx,%cx
80103572:	74 21                	je     80103595 <mpinit+0xc5>
80103574:	89 d8                	mov    %ebx,%eax
80103576:	8d 34 19             	lea    (%ecx,%ebx,1),%esi
  sum = 0;
80103579:	31 d2                	xor    %edx,%edx
8010357b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010357f:	90                   	nop
    sum += addr[i];
80103580:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
80103587:	83 c0 01             	add    $0x1,%eax
8010358a:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
8010358c:	39 c6                	cmp    %eax,%esi
8010358e:	75 f0                	jne    80103580 <mpinit+0xb0>
80103590:	84 d2                	test   %dl,%dl
80103592:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103595:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103598:	85 c9                	test   %ecx,%ecx
8010359a:	74 64                	je     80103600 <mpinit+0x130>
8010359c:	84 d2                	test   %dl,%dl
8010359e:	75 60                	jne    80103600 <mpinit+0x130>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801035a0:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801035a6:	a3 7c 6e 11 80       	mov    %eax,0x80116e7c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801035ab:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
801035b2:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
801035b8:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801035bd:	01 d1                	add    %edx,%ecx
801035bf:	89 ce                	mov    %ecx,%esi
801035c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035c8:	39 c6                	cmp    %eax,%esi
801035ca:	76 4b                	jbe    80103617 <mpinit+0x147>
    switch(*p){
801035cc:	0f b6 10             	movzbl (%eax),%edx
801035cf:	80 fa 04             	cmp    $0x4,%dl
801035d2:	0f 87 bf 00 00 00    	ja     80103697 <mpinit+0x1c7>
801035d8:	ff 24 95 bc 8c 10 80 	jmp    *-0x7fef7344(,%edx,4)
801035df:	90                   	nop
  return mpsearch1(0xF0000, 0x10000);
801035e0:	ba 00 00 01 00       	mov    $0x10000,%edx
801035e5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801035ea:	e8 61 fe ff ff       	call   80103450 <mpsearch1>
801035ef:	89 c7                	mov    %eax,%edi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801035f1:	85 c0                	test   %eax,%eax
801035f3:	0f 85 27 ff ff ff    	jne    80103520 <mpinit+0x50>
801035f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80103600:	83 ec 0c             	sub    $0xc,%esp
80103603:	68 7d 8c 10 80       	push   $0x80108c7d
80103608:	e8 83 cd ff ff       	call   80100390 <panic>
8010360d:	8d 76 00             	lea    0x0(%esi),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103610:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103613:	39 c6                	cmp    %eax,%esi
80103615:	77 b5                	ja     801035cc <mpinit+0xfc>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103617:	85 db                	test   %ebx,%ebx
80103619:	74 6f                	je     8010368a <mpinit+0x1ba>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010361b:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
8010361f:	74 15                	je     80103636 <mpinit+0x166>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103621:	b8 70 00 00 00       	mov    $0x70,%eax
80103626:	ba 22 00 00 00       	mov    $0x22,%edx
8010362b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010362c:	ba 23 00 00 00       	mov    $0x23,%edx
80103631:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103632:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103635:	ee                   	out    %al,(%dx)
  }
}
80103636:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103639:	5b                   	pop    %ebx
8010363a:	5e                   	pop    %esi
8010363b:	5f                   	pop    %edi
8010363c:	5d                   	pop    %ebp
8010363d:	c3                   	ret    
8010363e:	66 90                	xchg   %ax,%ax
      if(ncpu < NCPU) {
80103640:	8b 15 00 75 11 80    	mov    0x80117500,%edx
80103646:	83 fa 07             	cmp    $0x7,%edx
80103649:	7f 1f                	jg     8010366a <mpinit+0x19a>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010364b:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103651:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103654:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103658:	88 91 80 6f 11 80    	mov    %dl,-0x7fee9080(%ecx)
        ncpu++;
8010365e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103661:	83 c2 01             	add    $0x1,%edx
80103664:	89 15 00 75 11 80    	mov    %edx,0x80117500
      p += sizeof(struct mpproc);
8010366a:	83 c0 14             	add    $0x14,%eax
      continue;
8010366d:	e9 56 ff ff ff       	jmp    801035c8 <mpinit+0xf8>
80103672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ioapicid = ioapic->apicno;
80103678:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010367c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010367f:	88 15 60 6f 11 80    	mov    %dl,0x80116f60
      continue;
80103685:	e9 3e ff ff ff       	jmp    801035c8 <mpinit+0xf8>
    panic("Didn't find a suitable machine");
8010368a:	83 ec 0c             	sub    $0xc,%esp
8010368d:	68 9c 8c 10 80       	push   $0x80108c9c
80103692:	e8 f9 cc ff ff       	call   80100390 <panic>
      ismp = 0;
80103697:	31 db                	xor    %ebx,%ebx
80103699:	e9 31 ff ff ff       	jmp    801035cf <mpinit+0xff>
8010369e:	66 90                	xchg   %ax,%ax

801036a0 <picinit>:
801036a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801036a5:	ba 21 00 00 00       	mov    $0x21,%edx
801036aa:	ee                   	out    %al,(%dx)
801036ab:	ba a1 00 00 00       	mov    $0xa1,%edx
801036b0:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801036b1:	c3                   	ret    
801036b2:	66 90                	xchg   %ax,%ax
801036b4:	66 90                	xchg   %ax,%ax
801036b6:	66 90                	xchg   %ax,%ax
801036b8:	66 90                	xchg   %ax,%ax
801036ba:	66 90                	xchg   %ax,%ax
801036bc:	66 90                	xchg   %ax,%ax
801036be:	66 90                	xchg   %ax,%ax

801036c0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801036c0:	55                   	push   %ebp
801036c1:	89 e5                	mov    %esp,%ebp
801036c3:	57                   	push   %edi
801036c4:	56                   	push   %esi
801036c5:	53                   	push   %ebx
801036c6:	83 ec 0c             	sub    $0xc,%esp
801036c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801036cc:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801036cf:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801036d5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801036db:	e8 a0 d8 ff ff       	call   80100f80 <filealloc>
801036e0:	89 03                	mov    %eax,(%ebx)
801036e2:	85 c0                	test   %eax,%eax
801036e4:	0f 84 a8 00 00 00    	je     80103792 <pipealloc+0xd2>
801036ea:	e8 91 d8 ff ff       	call   80100f80 <filealloc>
801036ef:	89 06                	mov    %eax,(%esi)
801036f1:	85 c0                	test   %eax,%eax
801036f3:	0f 84 87 00 00 00    	je     80103780 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801036f9:	e8 22 f2 ff ff       	call   80102920 <kalloc>
801036fe:	89 c7                	mov    %eax,%edi
80103700:	85 c0                	test   %eax,%eax
80103702:	0f 84 b0 00 00 00    	je     801037b8 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
80103708:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010370f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103712:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103715:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010371c:	00 00 00 
  p->nwrite = 0;
8010371f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103726:	00 00 00 
  p->nread = 0;
80103729:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103730:	00 00 00 
  initlock(&p->lock, "pipe");
80103733:	68 d0 8c 10 80       	push   $0x80108cd0
80103738:	50                   	push   %eax
80103739:	e8 f2 20 00 00       	call   80105830 <initlock>
  (*f0)->type = FD_PIPE;
8010373e:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103740:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103743:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103749:	8b 03                	mov    (%ebx),%eax
8010374b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010374f:	8b 03                	mov    (%ebx),%eax
80103751:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103755:	8b 03                	mov    (%ebx),%eax
80103757:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010375a:	8b 06                	mov    (%esi),%eax
8010375c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103762:	8b 06                	mov    (%esi),%eax
80103764:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103768:	8b 06                	mov    (%esi),%eax
8010376a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010376e:	8b 06                	mov    (%esi),%eax
80103770:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103773:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103776:	31 c0                	xor    %eax,%eax
}
80103778:	5b                   	pop    %ebx
80103779:	5e                   	pop    %esi
8010377a:	5f                   	pop    %edi
8010377b:	5d                   	pop    %ebp
8010377c:	c3                   	ret    
8010377d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
80103780:	8b 03                	mov    (%ebx),%eax
80103782:	85 c0                	test   %eax,%eax
80103784:	74 1e                	je     801037a4 <pipealloc+0xe4>
    fileclose(*f0);
80103786:	83 ec 0c             	sub    $0xc,%esp
80103789:	50                   	push   %eax
8010378a:	e8 b1 d8 ff ff       	call   80101040 <fileclose>
8010378f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103792:	8b 06                	mov    (%esi),%eax
80103794:	85 c0                	test   %eax,%eax
80103796:	74 0c                	je     801037a4 <pipealloc+0xe4>
    fileclose(*f1);
80103798:	83 ec 0c             	sub    $0xc,%esp
8010379b:	50                   	push   %eax
8010379c:	e8 9f d8 ff ff       	call   80101040 <fileclose>
801037a1:	83 c4 10             	add    $0x10,%esp
}
801037a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801037a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801037ac:	5b                   	pop    %ebx
801037ad:	5e                   	pop    %esi
801037ae:	5f                   	pop    %edi
801037af:	5d                   	pop    %ebp
801037b0:	c3                   	ret    
801037b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
801037b8:	8b 03                	mov    (%ebx),%eax
801037ba:	85 c0                	test   %eax,%eax
801037bc:	75 c8                	jne    80103786 <pipealloc+0xc6>
801037be:	eb d2                	jmp    80103792 <pipealloc+0xd2>

801037c0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801037c0:	55                   	push   %ebp
801037c1:	89 e5                	mov    %esp,%ebp
801037c3:	56                   	push   %esi
801037c4:	53                   	push   %ebx
801037c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801037c8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801037cb:	83 ec 0c             	sub    $0xc,%esp
801037ce:	53                   	push   %ebx
801037cf:	e8 bc 21 00 00       	call   80105990 <acquire>
  if(writable){
801037d4:	83 c4 10             	add    $0x10,%esp
801037d7:	85 f6                	test   %esi,%esi
801037d9:	74 65                	je     80103840 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
801037db:	83 ec 0c             	sub    $0xc,%esp
801037de:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
801037e4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801037eb:	00 00 00 
    wakeup(&p->nread);
801037ee:	50                   	push   %eax
801037ef:	e8 6c 17 00 00       	call   80104f60 <wakeup>
801037f4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801037f7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801037fd:	85 d2                	test   %edx,%edx
801037ff:	75 0a                	jne    8010380b <pipeclose+0x4b>
80103801:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103807:	85 c0                	test   %eax,%eax
80103809:	74 15                	je     80103820 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010380b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010380e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103811:	5b                   	pop    %ebx
80103812:	5e                   	pop    %esi
80103813:	5d                   	pop    %ebp
    release(&p->lock);
80103814:	e9 37 22 00 00       	jmp    80105a50 <release>
80103819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103820:	83 ec 0c             	sub    $0xc,%esp
80103823:	53                   	push   %ebx
80103824:	e8 27 22 00 00       	call   80105a50 <release>
    kfree((char*)p);
80103829:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010382c:	83 c4 10             	add    $0x10,%esp
}
8010382f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103832:	5b                   	pop    %ebx
80103833:	5e                   	pop    %esi
80103834:	5d                   	pop    %ebp
    kfree((char*)p);
80103835:	e9 26 ef ff ff       	jmp    80102760 <kfree>
8010383a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103840:	83 ec 0c             	sub    $0xc,%esp
80103843:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103849:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103850:	00 00 00 
    wakeup(&p->nwrite);
80103853:	50                   	push   %eax
80103854:	e8 07 17 00 00       	call   80104f60 <wakeup>
80103859:	83 c4 10             	add    $0x10,%esp
8010385c:	eb 99                	jmp    801037f7 <pipeclose+0x37>
8010385e:	66 90                	xchg   %ax,%ax

80103860 <pipewrite>:

int
pipewrite(struct pipe *p, char *addr, int n)
{
80103860:	55                   	push   %ebp
80103861:	89 e5                	mov    %esp,%ebp
80103863:	57                   	push   %edi
80103864:	56                   	push   %esi
80103865:	53                   	push   %ebx
80103866:	83 ec 28             	sub    $0x28,%esp
80103869:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010386c:	53                   	push   %ebx
8010386d:	e8 1e 21 00 00       	call   80105990 <acquire>
  for(i = 0; i < n; i++){
80103872:	8b 45 10             	mov    0x10(%ebp),%eax
80103875:	83 c4 10             	add    $0x10,%esp
80103878:	85 c0                	test   %eax,%eax
8010387a:	0f 8e c8 00 00 00    	jle    80103948 <pipewrite+0xe8>
80103880:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103883:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103889:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010388f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103892:	03 4d 10             	add    0x10(%ebp),%ecx
80103895:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103898:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010389e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
801038a4:	39 d0                	cmp    %edx,%eax
801038a6:	75 71                	jne    80103919 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
801038a8:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801038ae:	85 c0                	test   %eax,%eax
801038b0:	74 4e                	je     80103900 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801038b2:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
801038b8:	eb 3a                	jmp    801038f4 <pipewrite+0x94>
801038ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
801038c0:	83 ec 0c             	sub    $0xc,%esp
801038c3:	57                   	push   %edi
801038c4:	e8 97 16 00 00       	call   80104f60 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801038c9:	5a                   	pop    %edx
801038ca:	59                   	pop    %ecx
801038cb:	53                   	push   %ebx
801038cc:	56                   	push   %esi
801038cd:	e8 de 12 00 00       	call   80104bb0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801038d2:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801038d8:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801038de:	83 c4 10             	add    $0x10,%esp
801038e1:	05 00 02 00 00       	add    $0x200,%eax
801038e6:	39 c2                	cmp    %eax,%edx
801038e8:	75 36                	jne    80103920 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
801038ea:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801038f0:	85 c0                	test   %eax,%eax
801038f2:	74 0c                	je     80103900 <pipewrite+0xa0>
801038f4:	e8 17 06 00 00       	call   80103f10 <myproc>
801038f9:	8b 40 24             	mov    0x24(%eax),%eax
801038fc:	85 c0                	test   %eax,%eax
801038fe:	74 c0                	je     801038c0 <pipewrite+0x60>
        release(&p->lock);
80103900:	83 ec 0c             	sub    $0xc,%esp
80103903:	53                   	push   %ebx
80103904:	e8 47 21 00 00       	call   80105a50 <release>
        return -1;
80103909:	83 c4 10             	add    $0x10,%esp
8010390c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103911:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103914:	5b                   	pop    %ebx
80103915:	5e                   	pop    %esi
80103916:	5f                   	pop    %edi
80103917:	5d                   	pop    %ebp
80103918:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103919:	89 c2                	mov    %eax,%edx
8010391b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010391f:	90                   	nop
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103920:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103923:	8d 42 01             	lea    0x1(%edx),%eax
80103926:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010392c:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103932:	0f b6 0e             	movzbl (%esi),%ecx
80103935:	83 c6 01             	add    $0x1,%esi
80103938:	89 75 e4             	mov    %esi,-0x1c(%ebp)
8010393b:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
8010393f:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80103942:	0f 85 50 ff ff ff    	jne    80103898 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103948:	83 ec 0c             	sub    $0xc,%esp
8010394b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103951:	50                   	push   %eax
80103952:	e8 09 16 00 00       	call   80104f60 <wakeup>
  release(&p->lock);
80103957:	89 1c 24             	mov    %ebx,(%esp)
8010395a:	e8 f1 20 00 00       	call   80105a50 <release>
  return n;
8010395f:	83 c4 10             	add    $0x10,%esp
80103962:	8b 45 10             	mov    0x10(%ebp),%eax
80103965:	eb aa                	jmp    80103911 <pipewrite+0xb1>
80103967:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010396e:	66 90                	xchg   %ax,%ax

80103970 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103970:	55                   	push   %ebp
80103971:	89 e5                	mov    %esp,%ebp
80103973:	57                   	push   %edi
80103974:	56                   	push   %esi
80103975:	53                   	push   %ebx
80103976:	83 ec 18             	sub    $0x18,%esp
80103979:	8b 75 08             	mov    0x8(%ebp),%esi
8010397c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010397f:	56                   	push   %esi
80103980:	e8 0b 20 00 00       	call   80105990 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103985:	83 c4 10             	add    $0x10,%esp
80103988:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010398e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103994:	75 6a                	jne    80103a00 <piperead+0x90>
80103996:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010399c:	85 db                	test   %ebx,%ebx
8010399e:	0f 84 c4 00 00 00    	je     80103a68 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801039a4:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801039aa:	eb 2d                	jmp    801039d9 <piperead+0x69>
801039ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801039b0:	83 ec 08             	sub    $0x8,%esp
801039b3:	56                   	push   %esi
801039b4:	53                   	push   %ebx
801039b5:	e8 f6 11 00 00       	call   80104bb0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801039ba:	83 c4 10             	add    $0x10,%esp
801039bd:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801039c3:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801039c9:	75 35                	jne    80103a00 <piperead+0x90>
801039cb:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801039d1:	85 d2                	test   %edx,%edx
801039d3:	0f 84 8f 00 00 00    	je     80103a68 <piperead+0xf8>
    if(myproc()->killed){
801039d9:	e8 32 05 00 00       	call   80103f10 <myproc>
801039de:	8b 48 24             	mov    0x24(%eax),%ecx
801039e1:	85 c9                	test   %ecx,%ecx
801039e3:	74 cb                	je     801039b0 <piperead+0x40>
      release(&p->lock);
801039e5:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801039e8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801039ed:	56                   	push   %esi
801039ee:	e8 5d 20 00 00       	call   80105a50 <release>
      return -1;
801039f3:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801039f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801039f9:	89 d8                	mov    %ebx,%eax
801039fb:	5b                   	pop    %ebx
801039fc:	5e                   	pop    %esi
801039fd:	5f                   	pop    %edi
801039fe:	5d                   	pop    %ebp
801039ff:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103a00:	8b 45 10             	mov    0x10(%ebp),%eax
80103a03:	85 c0                	test   %eax,%eax
80103a05:	7e 61                	jle    80103a68 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103a07:	31 db                	xor    %ebx,%ebx
80103a09:	eb 13                	jmp    80103a1e <piperead+0xae>
80103a0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103a0f:	90                   	nop
80103a10:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103a16:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103a1c:	74 1f                	je     80103a3d <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103a1e:	8d 41 01             	lea    0x1(%ecx),%eax
80103a21:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103a27:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
80103a2d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103a32:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103a35:	83 c3 01             	add    $0x1,%ebx
80103a38:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103a3b:	75 d3                	jne    80103a10 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103a3d:	83 ec 0c             	sub    $0xc,%esp
80103a40:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103a46:	50                   	push   %eax
80103a47:	e8 14 15 00 00       	call   80104f60 <wakeup>
  release(&p->lock);
80103a4c:	89 34 24             	mov    %esi,(%esp)
80103a4f:	e8 fc 1f 00 00       	call   80105a50 <release>
  return i;
80103a54:	83 c4 10             	add    $0x10,%esp
}
80103a57:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a5a:	89 d8                	mov    %ebx,%eax
80103a5c:	5b                   	pop    %ebx
80103a5d:	5e                   	pop    %esi
80103a5e:	5f                   	pop    %edi
80103a5f:	5d                   	pop    %ebp
80103a60:	c3                   	ret    
80103a61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p->nread == p->nwrite)
80103a68:	31 db                	xor    %ebx,%ebx
80103a6a:	eb d1                	jmp    80103a3d <piperead+0xcd>
80103a6c:	66 90                	xchg   %ax,%ax
80103a6e:	66 90                	xchg   %ax,%ax

80103a70 <stateListRemove.isra.1>:
        ((*list).tail)->next = NULL;
    }
}

static int
stateListRemove(struct ptrs * list,struct proc * p)
80103a70:	55                   	push   %ebp
80103a71:	89 e5                	mov    %esp,%ebp
80103a73:	57                   	push   %edi
80103a74:	56                   	push   %esi
80103a75:	53                   	push   %ebx
{

    if((*list).head == NULL || (*list).tail == NULL || p == NULL){
80103a76:	8b 18                	mov    (%eax),%ebx
80103a78:	85 db                	test   %ebx,%ebx
80103a7a:	74 36                	je     80103ab2 <stateListRemove.isra.1+0x42>
80103a7c:	8b 32                	mov    (%edx),%esi
80103a7e:	85 c9                	test   %ecx,%ecx
80103a80:	74 30                	je     80103ab2 <stateListRemove.isra.1+0x42>
80103a82:	85 f6                	test   %esi,%esi
80103a84:	74 2c                	je     80103ab2 <stateListRemove.isra.1+0x42>
    }

    struct proc * current = (*list).head;
    struct proc * previous = 0;

    if(current == p){
80103a86:	39 cb                	cmp    %ecx,%ebx
80103a88:	74 76                	je     80103b00 <stateListRemove.isra.1+0x90>
        if(current == p){
            break;
        }
        
        previous = current;
        current = current->next;
80103a8a:	8b 83 90 00 00 00    	mov    0x90(%ebx),%eax
    while(current){
80103a90:	85 c0                	test   %eax,%eax
80103a92:	75 0e                	jne    80103aa2 <stateListRemove.isra.1+0x32>
80103a94:	eb 1c                	jmp    80103ab2 <stateListRemove.isra.1+0x42>
80103a96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a9d:	8d 76 00             	lea    0x0(%esi),%esi
80103aa0:	89 f8                	mov    %edi,%eax
        if(current == p){
80103aa2:	39 c1                	cmp    %eax,%ecx
80103aa4:	74 1a                	je     80103ac0 <stateListRemove.isra.1+0x50>
        current = current->next;
80103aa6:	8b b8 90 00 00 00    	mov    0x90(%eax),%edi
80103aac:	89 c3                	mov    %eax,%ebx
    while(current){
80103aae:	85 ff                	test   %edi,%edi
80103ab0:	75 ee                	jne    80103aa0 <stateListRemove.isra.1+0x30>

    // make sure p->next doesn't point to the list
    p->next = NULL;

    return 0;
}
80103ab2:	5b                   	pop    %ebx
        return -1;
80103ab3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103ab8:	5e                   	pop    %esi
80103ab9:	5f                   	pop    %edi
80103aba:	5d                   	pop    %ebp
80103abb:	c3                   	ret    
80103abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(current == (*list).tail){
80103ac0:	39 ce                	cmp    %ecx,%esi
80103ac2:	74 24                	je     80103ae8 <stateListRemove.isra.1+0x78>
        previous->next = current->next;
80103ac4:	8b 81 90 00 00 00    	mov    0x90(%ecx),%eax
80103aca:	89 83 90 00 00 00    	mov    %eax,0x90(%ebx)
    p->next = NULL;
80103ad0:	c7 81 90 00 00 00 00 	movl   $0x0,0x90(%ecx)
80103ad7:	00 00 00 
    return 0;
80103ada:	31 c0                	xor    %eax,%eax
}
80103adc:	5b                   	pop    %ebx
80103add:	5e                   	pop    %esi
80103ade:	5f                   	pop    %edi
80103adf:	5d                   	pop    %ebp
80103ae0:	c3                   	ret    
80103ae1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        (*list).tail = previous;
80103ae8:	89 1a                	mov    %ebx,(%edx)
        ((*list).tail)->next = NULL;
80103aea:	c7 83 90 00 00 00 00 	movl   $0x0,0x90(%ebx)
80103af1:	00 00 00 
80103af4:	eb da                	jmp    80103ad0 <stateListRemove.isra.1+0x60>
80103af6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103afd:	8d 76 00             	lea    0x0(%esi),%esi
        (*list).head = ((*list).head)->next;
80103b00:	8b 8b 90 00 00 00    	mov    0x90(%ebx),%ecx
80103b06:	89 08                	mov    %ecx,(%eax)
        return 0;
80103b08:	31 c0                	xor    %eax,%eax
        if((*list).tail == p){
80103b0a:	39 de                	cmp    %ebx,%esi
80103b0c:	75 ce                	jne    80103adc <stateListRemove.isra.1+0x6c>
            (*list).tail = NULL;
80103b0e:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
80103b14:	eb c6                	jmp    80103adc <stateListRemove.isra.1+0x6c>
80103b16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b1d:	8d 76 00             	lea    0x0(%esi),%esi

80103b20 <wakeup1>:
{
80103b20:	55                   	push   %ebp
80103b21:	89 e5                	mov    %esp,%ebp
80103b23:	57                   	push   %edi
80103b24:	56                   	push   %esi
80103b25:	53                   	push   %ebx
80103b26:	83 ec 0c             	sub    $0xc,%esp
  p = ptable.list[SLEEPING].head;
80103b29:	8b 1d 24 ed 10 80    	mov    0x8010ed24,%ebx
  while(p){
80103b2f:	85 db                	test   %ebx,%ebx
80103b31:	0f 84 88 00 00 00    	je     80103bbf <wakeup1+0x9f>
80103b37:	89 c7                	mov    %eax,%edi
80103b39:	eb 0b                	jmp    80103b46 <wakeup1+0x26>
80103b3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103b3f:	90                   	nop
80103b40:	89 f3                	mov    %esi,%ebx
80103b42:	85 f6                	test   %esi,%esi
80103b44:	74 79                	je     80103bbf <wakeup1+0x9f>
      if(p->state == SLEEPING && p->chan == chan){
80103b46:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80103b4a:	8b b3 90 00 00 00    	mov    0x90(%ebx),%esi
80103b50:	75 ee                	jne    80103b40 <wakeup1+0x20>
80103b52:	39 7b 20             	cmp    %edi,0x20(%ebx)
80103b55:	75 e9                	jne    80103b40 <wakeup1+0x20>
          rc = stateListRemove(&ptable.list[SLEEPING],p);
80103b57:	89 d9                	mov    %ebx,%ecx
80103b59:	ba 28 ed 10 80       	mov    $0x8010ed28,%edx
80103b5e:	b8 24 ed 10 80       	mov    $0x8010ed24,%eax
80103b63:	e8 08 ff ff ff       	call   80103a70 <stateListRemove.isra.1>
          if(rc < 0)
80103b68:	85 c0                	test   %eax,%eax
80103b6a:	0f 88 85 00 00 00    	js     80103bf5 <wakeup1+0xd5>
static void
assertState(struct proc* p,enum procstate state)
{


    if(p->state != state){
80103b70:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80103b74:	75 72                	jne    80103be8 <wakeup1+0xc8>
          stateListAdd(&ptable.ready[p->priority],p);
80103b76:	8b 83 94 00 00 00    	mov    0x94(%ebx),%eax
          p->state = RUNNABLE;
80103b7c:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
          stateListAdd(&ptable.ready[p->priority],p);
80103b83:	8d 14 c5 64 27 00 00 	lea    0x2764(,%eax,8),%edx
    if((*list).head == NULL){
80103b8a:	8b 8a e0 c5 10 80    	mov    -0x7fef3a20(%edx),%ecx
          stateListAdd(&ptable.ready[p->priority],p);
80103b90:	8d 82 e0 c5 10 80    	lea    -0x7fef3a20(%edx),%eax
    if((*list).head == NULL){
80103b96:	85 c9                	test   %ecx,%ecx
80103b98:	74 36                	je     80103bd0 <wakeup1+0xb0>
        ((*list).tail)->next = p;
80103b9a:	8b 50 04             	mov    0x4(%eax),%edx
80103b9d:	89 9a 90 00 00 00    	mov    %ebx,0x90(%edx)
        (*list).tail = ((*list).tail)->next;
80103ba3:	8b 50 04             	mov    0x4(%eax),%edx
80103ba6:	89 f3                	mov    %esi,%ebx
80103ba8:	8b 92 90 00 00 00    	mov    0x90(%edx),%edx
80103bae:	89 50 04             	mov    %edx,0x4(%eax)
        ((*list).tail)->next = NULL;
80103bb1:	c7 82 90 00 00 00 00 	movl   $0x0,0x90(%edx)
80103bb8:	00 00 00 
  while(p){
80103bbb:	85 f6                	test   %esi,%esi
80103bbd:	75 87                	jne    80103b46 <wakeup1+0x26>
}
80103bbf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103bc2:	5b                   	pop    %ebx
80103bc3:	5e                   	pop    %esi
80103bc4:	5f                   	pop    %edi
80103bc5:	5d                   	pop    %ebp
80103bc6:	c3                   	ret    
80103bc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103bce:	66 90                	xchg   %ax,%ax
        (*list).head = p;
80103bd0:	89 9a e0 c5 10 80    	mov    %ebx,-0x7fef3a20(%edx)
        (*list).tail = p;
80103bd6:	89 58 04             	mov    %ebx,0x4(%eax)
        p->next = NULL;
80103bd9:	c7 83 90 00 00 00 00 	movl   $0x0,0x90(%ebx)
80103be0:	00 00 00 
80103be3:	e9 58 ff ff ff       	jmp    80103b40 <wakeup1+0x20>
        panic("ASSERT FAILED: proc->state != state");
80103be8:	83 ec 0c             	sub    $0xc,%esp
80103beb:	68 08 8d 10 80       	push   $0x80108d08
80103bf0:	e8 9b c7 ff ff       	call   80100390 <panic>
                  panic("\n[SLEEPING->RUNNABLE]:oh no!! I'm panicking!");
80103bf5:	83 ec 0c             	sub    $0xc,%esp
80103bf8:	68 d8 8c 10 80       	push   $0x80108cd8
80103bfd:	e8 8e c7 ff ff       	call   80100390 <panic>
80103c02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103c10 <allocproc>:
{
80103c10:	55                   	push   %ebp
80103c11:	89 e5                	mov    %esp,%ebp
80103c13:	53                   	push   %ebx
80103c14:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103c17:	68 e0 c5 10 80       	push   $0x8010c5e0
80103c1c:	e8 6f 1d 00 00       	call   80105990 <acquire>
  p = ptable.list[UNUSED].head;
80103c21:	8b 1d 14 ed 10 80    	mov    0x8010ed14,%ebx
  if(p)
80103c27:	83 c4 10             	add    $0x10,%esp
80103c2a:	85 db                	test   %ebx,%ebx
80103c2c:	0f 84 3f 01 00 00    	je     80103d71 <allocproc+0x161>
  int rc = stateListRemove(&ptable.list[UNUSED],p);
80103c32:	89 d9                	mov    %ebx,%ecx
80103c34:	ba 18 ed 10 80       	mov    $0x8010ed18,%edx
80103c39:	b8 14 ed 10 80       	mov    $0x8010ed14,%eax
80103c3e:	e8 2d fe ff ff       	call   80103a70 <stateListRemove.isra.1>
  if(rc < 0)
80103c43:	85 c0                	test   %eax,%eax
80103c45:	0f 88 99 01 00 00    	js     80103de4 <allocproc+0x1d4>
    if(p->state != state){
80103c4b:	8b 4b 0c             	mov    0xc(%ebx),%ecx
80103c4e:	85 c9                	test   %ecx,%ecx
80103c50:	0f 85 81 01 00 00    	jne    80103dd7 <allocproc+0x1c7>
  p->state = EMBRYO;
80103c56:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
    if((*list).head == NULL){
80103c5d:	8b 15 1c ed 10 80    	mov    0x8010ed1c,%edx
80103c63:	85 d2                	test   %edx,%edx
80103c65:	0f 84 25 01 00 00    	je     80103d90 <allocproc+0x180>
        ((*list).tail)->next = p;
80103c6b:	a1 20 ed 10 80       	mov    0x8010ed20,%eax
80103c70:	89 98 90 00 00 00    	mov    %ebx,0x90(%eax)
        (*list).tail = ((*list).tail)->next;
80103c76:	a1 20 ed 10 80       	mov    0x8010ed20,%eax
80103c7b:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80103c81:	a3 20 ed 10 80       	mov    %eax,0x8010ed20
        ((*list).tail)->next = NULL;
80103c86:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
80103c8d:	00 00 00 
  p->pid = nextpid++;
80103c90:	a1 04 c0 10 80       	mov    0x8010c004,%eax
  release(&ptable.lock);
80103c95:	83 ec 0c             	sub    $0xc,%esp
  p->pid = nextpid++;
80103c98:	89 43 10             	mov    %eax,0x10(%ebx)
80103c9b:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80103c9e:	68 e0 c5 10 80       	push   $0x8010c5e0
  p->pid = nextpid++;
80103ca3:	89 15 04 c0 10 80    	mov    %edx,0x8010c004
  release(&ptable.lock);
80103ca9:	e8 a2 1d 00 00       	call   80105a50 <release>
  if((p->kstack = kalloc()) == 0){
80103cae:	e8 6d ec ff ff       	call   80102920 <kalloc>
80103cb3:	83 c4 10             	add    $0x10,%esp
80103cb6:	89 43 08             	mov    %eax,0x8(%ebx)
80103cb9:	85 c0                	test   %eax,%eax
80103cbb:	74 5b                	je     80103d18 <allocproc+0x108>
  sp -= sizeof *p->tf;
80103cbd:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  memset(p->context, 0, sizeof *p->context);
80103cc3:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103cc6:	05 9c 0f 00 00       	add    $0xf9c,%eax
  p->cpu_ticks_total = 0; // ini both cpu ticks to 0 if flag is turned on
80103ccb:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80103cd2:	00 00 00 
  p->cpu_ticks_in = 0;
80103cd5:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80103cdc:	00 00 00 
  sp -= sizeof *p->tf;
80103cdf:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103ce2:	c7 40 14 1f 6f 10 80 	movl   $0x80106f1f,0x14(%eax)
  p->context = (struct context*)sp;
80103ce9:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103cec:	6a 14                	push   $0x14
80103cee:	6a 00                	push   $0x0
80103cf0:	50                   	push   %eax
80103cf1:	e8 aa 1d 00 00       	call   80105aa0 <memset>
  p->context->eip = (uint)forkret;
80103cf6:	8b 43 1c             	mov    0x1c(%ebx),%eax
  return p;
80103cf9:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103cfc:	c7 40 10 00 3e 10 80 	movl   $0x80103e00,0x10(%eax)
  p->start_ticks = ticks;
80103d03:	a1 20 7d 11 80       	mov    0x80117d20,%eax
80103d08:	89 43 7c             	mov    %eax,0x7c(%ebx)
}
80103d0b:	89 d8                	mov    %ebx,%eax
80103d0d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d10:	c9                   	leave  
80103d11:	c3                   	ret    
80103d12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&ptable.lock);
80103d18:	83 ec 0c             	sub    $0xc,%esp
80103d1b:	68 e0 c5 10 80       	push   $0x8010c5e0
80103d20:	e8 6b 1c 00 00       	call   80105990 <acquire>
      int rc = stateListRemove(&ptable.list[EMBRYO],p);
80103d25:	89 d9                	mov    %ebx,%ecx
80103d27:	ba 20 ed 10 80       	mov    $0x8010ed20,%edx
80103d2c:	b8 1c ed 10 80       	mov    $0x8010ed1c,%eax
80103d31:	e8 3a fd ff ff       	call   80103a70 <stateListRemove.isra.1>
      if(rc < 0)
80103d36:	83 c4 10             	add    $0x10,%esp
80103d39:	85 c0                	test   %eax,%eax
80103d3b:	0f 88 b0 00 00 00    	js     80103df1 <allocproc+0x1e1>
    if(p->state != state){
80103d41:	83 7b 0c 01          	cmpl   $0x1,0xc(%ebx)
80103d45:	0f 85 8c 00 00 00    	jne    80103dd7 <allocproc+0x1c7>
      p->state = UNUSED;
80103d4b:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    if((*list).head == NULL){
80103d52:	a1 14 ed 10 80       	mov    0x8010ed14,%eax
80103d57:	85 c0                	test   %eax,%eax
80103d59:	75 55                	jne    80103db0 <allocproc+0x1a0>
        (*list).head = p;
80103d5b:	89 1d 14 ed 10 80    	mov    %ebx,0x8010ed14
        (*list).tail = p;
80103d61:	89 1d 18 ed 10 80    	mov    %ebx,0x8010ed18
        p->next = NULL;
80103d67:	c7 83 90 00 00 00 00 	movl   $0x0,0x90(%ebx)
80103d6e:	00 00 00 
      release(&ptable.lock);
80103d71:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80103d74:	31 db                	xor    %ebx,%ebx
      release(&ptable.lock);
80103d76:	68 e0 c5 10 80       	push   $0x8010c5e0
80103d7b:	e8 d0 1c 00 00       	call   80105a50 <release>
}
80103d80:	89 d8                	mov    %ebx,%eax
      return 0;
80103d82:	83 c4 10             	add    $0x10,%esp
}
80103d85:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d88:	c9                   	leave  
80103d89:	c3                   	ret    
80103d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        (*list).head = p;
80103d90:	89 1d 1c ed 10 80    	mov    %ebx,0x8010ed1c
        (*list).tail = p;
80103d96:	89 1d 20 ed 10 80    	mov    %ebx,0x8010ed20
        p->next = NULL;
80103d9c:	c7 83 90 00 00 00 00 	movl   $0x0,0x90(%ebx)
80103da3:	00 00 00 
80103da6:	e9 e5 fe ff ff       	jmp    80103c90 <allocproc+0x80>
80103dab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103daf:	90                   	nop
        ((*list).tail)->next = p;
80103db0:	a1 18 ed 10 80       	mov    0x8010ed18,%eax
80103db5:	89 98 90 00 00 00    	mov    %ebx,0x90(%eax)
        (*list).tail = ((*list).tail)->next;
80103dbb:	a1 18 ed 10 80       	mov    0x8010ed18,%eax
80103dc0:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80103dc6:	a3 18 ed 10 80       	mov    %eax,0x8010ed18
        ((*list).tail)->next = NULL;
80103dcb:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
80103dd2:	00 00 00 
80103dd5:	eb 9a                	jmp    80103d71 <allocproc+0x161>
        panic("ASSERT FAILED: proc->state != state");
80103dd7:	83 ec 0c             	sub    $0xc,%esp
80103dda:	68 08 8d 10 80       	push   $0x80108d08
80103ddf:	e8 ac c5 ff ff       	call   80100390 <panic>
      panic("\n[UNUSED->EMBRYO]:oh no!! I'm panicking!");
80103de4:	83 ec 0c             	sub    $0xc,%esp
80103de7:	68 2c 8d 10 80       	push   $0x80108d2c
80103dec:	e8 9f c5 ff ff       	call   80100390 <panic>
          panic("[EMBRYO->UNUSED]:oh no!! I'm panicking!");
80103df1:	83 ec 0c             	sub    $0xc,%esp
80103df4:	68 58 8d 10 80       	push   $0x80108d58
80103df9:	e8 92 c5 ff ff       	call   80100390 <panic>
80103dfe:	66 90                	xchg   %ax,%ax

80103e00 <forkret>:
{
80103e00:	55                   	push   %ebp
80103e01:	89 e5                	mov    %esp,%ebp
80103e03:	83 ec 14             	sub    $0x14,%esp
  release(&ptable.lock);
80103e06:	68 e0 c5 10 80       	push   $0x8010c5e0
80103e0b:	e8 40 1c 00 00       	call   80105a50 <release>
  if (first) {
80103e10:	a1 00 c0 10 80       	mov    0x8010c000,%eax
80103e15:	83 c4 10             	add    $0x10,%esp
80103e18:	85 c0                	test   %eax,%eax
80103e1a:	75 04                	jne    80103e20 <forkret+0x20>
}
80103e1c:	c9                   	leave  
80103e1d:	c3                   	ret    
80103e1e:	66 90                	xchg   %ax,%ax
    first = 0;
80103e20:	c7 05 00 c0 10 80 00 	movl   $0x0,0x8010c000
80103e27:	00 00 00 
    iinit(ROOTDEV);
80103e2a:	83 ec 0c             	sub    $0xc,%esp
80103e2d:	6a 01                	push   $0x1
80103e2f:	e8 6c d8 ff ff       	call   801016a0 <iinit>
    initlog(ROOTDEV);
80103e34:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103e3b:	e8 30 f1 ff ff       	call   80102f70 <initlog>
80103e40:	83 c4 10             	add    $0x10,%esp
}
80103e43:	c9                   	leave  
80103e44:	c3                   	ret    
80103e45:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103e50 <pinit>:
{
80103e50:	55                   	push   %ebp
80103e51:	89 e5                	mov    %esp,%ebp
80103e53:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103e56:	68 68 8f 10 80       	push   $0x80108f68
80103e5b:	68 e0 c5 10 80       	push   $0x8010c5e0
80103e60:	e8 cb 19 00 00       	call   80105830 <initlock>
}
80103e65:	83 c4 10             	add    $0x10,%esp
80103e68:	c9                   	leave  
80103e69:	c3                   	ret    
80103e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103e70 <mycpu>:
{
80103e70:	55                   	push   %ebp
80103e71:	89 e5                	mov    %esp,%ebp
80103e73:	56                   	push   %esi
80103e74:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103e75:	9c                   	pushf  
80103e76:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103e77:	f6 c4 02             	test   $0x2,%ah
80103e7a:	75 5d                	jne    80103ed9 <mycpu+0x69>
  apicid = lapicid();
80103e7c:	e8 1f ed ff ff       	call   80102ba0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103e81:	8b 35 00 75 11 80    	mov    0x80117500,%esi
80103e87:	85 f6                	test   %esi,%esi
80103e89:	7e 41                	jle    80103ecc <mycpu+0x5c>
    if (cpus[i].apicid == apicid) {
80103e8b:	0f b6 15 80 6f 11 80 	movzbl 0x80116f80,%edx
80103e92:	39 d0                	cmp    %edx,%eax
80103e94:	74 2f                	je     80103ec5 <mycpu+0x55>
  for (i = 0; i < ncpu; ++i) {
80103e96:	31 d2                	xor    %edx,%edx
80103e98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e9f:	90                   	nop
80103ea0:	83 c2 01             	add    $0x1,%edx
80103ea3:	39 f2                	cmp    %esi,%edx
80103ea5:	74 25                	je     80103ecc <mycpu+0x5c>
    if (cpus[i].apicid == apicid) {
80103ea7:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103ead:	0f b6 99 80 6f 11 80 	movzbl -0x7fee9080(%ecx),%ebx
80103eb4:	39 c3                	cmp    %eax,%ebx
80103eb6:	75 e8                	jne    80103ea0 <mycpu+0x30>
80103eb8:	8d 81 80 6f 11 80    	lea    -0x7fee9080(%ecx),%eax
}
80103ebe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ec1:	5b                   	pop    %ebx
80103ec2:	5e                   	pop    %esi
80103ec3:	5d                   	pop    %ebp
80103ec4:	c3                   	ret    
    if (cpus[i].apicid == apicid) {
80103ec5:	b8 80 6f 11 80       	mov    $0x80116f80,%eax
      return &cpus[i];
80103eca:	eb f2                	jmp    80103ebe <mycpu+0x4e>
  panic("unknown apicid\n");
80103ecc:	83 ec 0c             	sub    $0xc,%esp
80103ecf:	68 6f 8f 10 80       	push   $0x80108f6f
80103ed4:	e8 b7 c4 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
80103ed9:	83 ec 0c             	sub    $0xc,%esp
80103edc:	68 80 8d 10 80       	push   $0x80108d80
80103ee1:	e8 aa c4 ff ff       	call   80100390 <panic>
80103ee6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103eed:	8d 76 00             	lea    0x0(%esi),%esi

80103ef0 <cpuid>:
cpuid() {
80103ef0:	55                   	push   %ebp
80103ef1:	89 e5                	mov    %esp,%ebp
80103ef3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103ef6:	e8 75 ff ff ff       	call   80103e70 <mycpu>
}
80103efb:	c9                   	leave  
  return mycpu()-cpus;
80103efc:	2d 80 6f 11 80       	sub    $0x80116f80,%eax
80103f01:	c1 f8 04             	sar    $0x4,%eax
80103f04:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103f0a:	c3                   	ret    
80103f0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f0f:	90                   	nop

80103f10 <myproc>:
myproc(void) {
80103f10:	55                   	push   %ebp
80103f11:	89 e5                	mov    %esp,%ebp
80103f13:	53                   	push   %ebx
80103f14:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103f17:	e8 84 19 00 00       	call   801058a0 <pushcli>
  c = mycpu();
80103f1c:	e8 4f ff ff ff       	call   80103e70 <mycpu>
  p = c->proc;
80103f21:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f27:	e8 c4 19 00 00       	call   801058f0 <popcli>
}
80103f2c:	83 c4 04             	add    $0x4,%esp
80103f2f:	89 d8                	mov    %ebx,%eax
80103f31:	5b                   	pop    %ebx
80103f32:	5d                   	pop    %ebp
80103f33:	c3                   	ret    
80103f34:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f3f:	90                   	nop

80103f40 <userinit>:
{
80103f40:	55                   	push   %ebp
80103f41:	89 e5                	mov    %esp,%ebp
80103f43:	53                   	push   %ebx
80103f44:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103f47:	68 e0 c5 10 80       	push   $0x8010c5e0
80103f4c:	e8 3f 1a 00 00       	call   80105990 <acquire>
80103f51:	83 c4 10             	add    $0x10,%esp
    for(i = UNUSED; i <= ZOMBIE; i++){
80103f54:	31 c0                	xor    %eax,%eax
80103f56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f5d:	8d 76 00             	lea    0x0(%esi),%esi
        ptable.list[i].head = NULL;
80103f60:	c7 04 c5 14 ed 10 80 	movl   $0x0,-0x7fef12ec(,%eax,8)
80103f67:	00 00 00 00 
        ptable.list[i].tail = NULL;
80103f6b:	c7 04 c5 18 ed 10 80 	movl   $0x0,-0x7fef12e8(,%eax,8)
80103f72:	00 00 00 00 
    for(i = UNUSED; i <= ZOMBIE; i++){
80103f76:	83 c0 01             	add    $0x1,%eax
80103f79:	83 f8 06             	cmp    $0x6,%eax
80103f7c:	75 e2                	jne    80103f60 <userinit+0x20>
   for(i = 0; i <= MAXPRIO; i++){
80103f7e:	31 c0                	xor    %eax,%eax
        ptable.ready[i].head = NULL;
80103f80:	c7 04 c5 44 ed 10 80 	movl   $0x0,-0x7fef12bc(,%eax,8)
80103f87:	00 00 00 00 
        ptable.ready[i].tail = NULL;
80103f8b:	c7 04 c5 48 ed 10 80 	movl   $0x0,-0x7fef12b8(,%eax,8)
80103f92:	00 00 00 00 
   for(i = 0; i <= MAXPRIO; i++){
80103f96:	83 c0 01             	add    $0x1,%eax
80103f99:	83 f8 0b             	cmp    $0xb,%eax
80103f9c:	75 e2                	jne    80103f80 <userinit+0x40>
    for(p = ptable.proc; p < ptable.proc + NPROC; ++p){
80103f9e:	b8 14 c6 10 80       	mov    $0x8010c614,%eax
80103fa3:	eb 37                	jmp    80103fdc <userinit+0x9c>
80103fa5:	8d 76 00             	lea    0x0(%esi),%esi
        ((*list).tail)->next = p;
80103fa8:	8b 15 18 ed 10 80    	mov    0x8010ed18,%edx
80103fae:	89 82 90 00 00 00    	mov    %eax,0x90(%edx)
        (*list).tail = ((*list).tail)->next;
80103fb4:	8b 15 18 ed 10 80    	mov    0x8010ed18,%edx
    for(p = ptable.proc; p < ptable.proc + NPROC; ++p){
80103fba:	05 9c 00 00 00       	add    $0x9c,%eax
        (*list).tail = ((*list).tail)->next;
80103fbf:	8b 92 90 00 00 00    	mov    0x90(%edx),%edx
80103fc5:	89 15 18 ed 10 80    	mov    %edx,0x8010ed18
        ((*list).tail)->next = NULL;
80103fcb:	c7 82 90 00 00 00 00 	movl   $0x0,0x90(%edx)
80103fd2:	00 00 00 
    for(p = ptable.proc; p < ptable.proc + NPROC; ++p){
80103fd5:	3d 14 ed 10 80       	cmp    $0x8010ed14,%eax
80103fda:	74 2e                	je     8010400a <userinit+0xca>
        p->state = UNUSED;
80103fdc:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    if((*list).head == NULL){
80103fe3:	8b 1d 14 ed 10 80    	mov    0x8010ed14,%ebx
80103fe9:	85 db                	test   %ebx,%ebx
80103feb:	75 bb                	jne    80103fa8 <userinit+0x68>
        (*list).head = p;
80103fed:	a3 14 ed 10 80       	mov    %eax,0x8010ed14
        (*list).tail = p;
80103ff2:	a3 18 ed 10 80       	mov    %eax,0x8010ed18
    for(p = ptable.proc; p < ptable.proc + NPROC; ++p){
80103ff7:	05 9c 00 00 00       	add    $0x9c,%eax
        p->next = NULL;
80103ffc:	c7 40 f4 00 00 00 00 	movl   $0x0,-0xc(%eax)
    for(p = ptable.proc; p < ptable.proc + NPROC; ++p){
80104003:	3d 14 ed 10 80       	cmp    $0x8010ed14,%eax
80104008:	75 d2                	jne    80103fdc <userinit+0x9c>
  release(&ptable.lock);
8010400a:	83 ec 0c             	sub    $0xc,%esp
  ptable.PromoteAtTime = ticks + TICKS_TO_PROMOTE;
8010400d:	a1 20 7d 11 80       	mov    0x80117d20,%eax
  release(&ptable.lock);
80104012:	68 e0 c5 10 80       	push   $0x8010c5e0
  ptable.PromoteAtTime = ticks + TICKS_TO_PROMOTE;
80104017:	05 b8 0b 00 00       	add    $0xbb8,%eax
8010401c:	a3 9c ed 10 80       	mov    %eax,0x8010ed9c
  release(&ptable.lock);
80104021:	e8 2a 1a 00 00       	call   80105a50 <release>
  p = allocproc();
80104026:	e8 e5 fb ff ff       	call   80103c10 <allocproc>
8010402b:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010402d:	a3 c0 c5 10 80       	mov    %eax,0x8010c5c0
  if((p->pgdir = setupkvm()) == 0)
80104032:	e8 a9 44 00 00       	call   801084e0 <setupkvm>
80104037:	83 c4 10             	add    $0x10,%esp
8010403a:	89 43 04             	mov    %eax,0x4(%ebx)
8010403d:	85 c0                	test   %eax,%eax
8010403f:	0f 84 6d 01 00 00    	je     801041b2 <userinit+0x272>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104045:	83 ec 04             	sub    $0x4,%esp
80104048:	68 2c 00 00 00       	push   $0x2c
8010404d:	68 60 c4 10 80       	push   $0x8010c460
80104052:	50                   	push   %eax
80104053:	e8 68 41 00 00       	call   801081c0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80104058:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
8010405b:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80104061:	6a 4c                	push   $0x4c
80104063:	6a 00                	push   $0x0
80104065:	ff 73 18             	pushl  0x18(%ebx)
80104068:	e8 33 1a 00 00       	call   80105aa0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010406d:	8b 43 18             	mov    0x18(%ebx),%eax
80104070:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104075:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104078:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010407d:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104081:	8b 43 18             	mov    0x18(%ebx),%eax
80104084:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80104088:	8b 43 18             	mov    0x18(%ebx),%eax
8010408b:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010408f:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104093:	8b 43 18             	mov    0x18(%ebx),%eax
80104096:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010409a:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010409e:	8b 43 18             	mov    0x18(%ebx),%eax
801040a1:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801040a8:	8b 43 18             	mov    0x18(%ebx),%eax
801040ab:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801040b2:	8b 43 18             	mov    0x18(%ebx),%eax
801040b5:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801040bc:	8d 43 6c             	lea    0x6c(%ebx),%eax
801040bf:	6a 10                	push   $0x10
801040c1:	68 98 8f 10 80       	push   $0x80108f98
801040c6:	50                   	push   %eax
801040c7:	e8 a4 1b 00 00       	call   80105c70 <safestrcpy>
  p->cwd = namei("/");
801040cc:	c7 04 24 a1 8f 10 80 	movl   $0x80108fa1,(%esp)
801040d3:	e8 d8 e0 ff ff       	call   801021b0 <namei>
801040d8:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
801040db:	c7 04 24 e0 c5 10 80 	movl   $0x8010c5e0,(%esp)
801040e2:	e8 a9 18 00 00       	call   80105990 <acquire>
  int rc = stateListRemove(&ptable.list[EMBRYO],p);
801040e7:	89 d9                	mov    %ebx,%ecx
801040e9:	ba 20 ed 10 80       	mov    $0x8010ed20,%edx
801040ee:	b8 1c ed 10 80       	mov    $0x8010ed1c,%eax
801040f3:	e8 78 f9 ff ff       	call   80103a70 <stateListRemove.isra.1>
  if(rc < 0)
801040f8:	83 c4 10             	add    $0x10,%esp
801040fb:	85 c0                	test   %eax,%eax
801040fd:	0f 88 a2 00 00 00    	js     801041a5 <userinit+0x265>
    if(p->state != state){
80104103:	83 7b 0c 01          	cmpl   $0x1,0xc(%ebx)
80104107:	0f 85 8b 00 00 00    	jne    80104198 <userinit+0x258>
  p->state = RUNNABLE;
8010410d:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  p->priority = MAXPRIO;
80104114:	c7 83 94 00 00 00 0a 	movl   $0xa,0x94(%ebx)
8010411b:	00 00 00 
    if((*list).head == NULL){
8010411e:	a1 94 ed 10 80       	mov    0x8010ed94,%eax
80104123:	85 c0                	test   %eax,%eax
80104125:	74 59                	je     80104180 <userinit+0x240>
        ((*list).tail)->next = p;
80104127:	a1 98 ed 10 80       	mov    0x8010ed98,%eax
8010412c:	89 98 90 00 00 00    	mov    %ebx,0x90(%eax)
        (*list).tail = ((*list).tail)->next;
80104132:	a1 98 ed 10 80       	mov    0x8010ed98,%eax
80104137:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
8010413d:	a3 98 ed 10 80       	mov    %eax,0x8010ed98
        ((*list).tail)->next = NULL;
80104142:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
80104149:	00 00 00 
  release(&ptable.lock);
8010414c:	83 ec 0c             	sub    $0xc,%esp
  p->parent = p; // Set the first the first proc's parent  to itself 
8010414f:	89 5b 14             	mov    %ebx,0x14(%ebx)
  p->uid = UID; // Set the uid to the# default UID = 0
80104152:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80104159:	00 00 00 
  p->gid = GID; // Set the gid to the default GID = 0
8010415c:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
80104163:	00 00 00 
  release(&ptable.lock);
80104166:	68 e0 c5 10 80       	push   $0x8010c5e0
8010416b:	e8 e0 18 00 00       	call   80105a50 <release>
}
80104170:	83 c4 10             	add    $0x10,%esp
80104173:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104176:	c9                   	leave  
80104177:	c3                   	ret    
80104178:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010417f:	90                   	nop
        (*list).head = p;
80104180:	89 1d 94 ed 10 80    	mov    %ebx,0x8010ed94
        (*list).tail = p;
80104186:	89 1d 98 ed 10 80    	mov    %ebx,0x8010ed98
        p->next = NULL;
8010418c:	c7 83 90 00 00 00 00 	movl   $0x0,0x90(%ebx)
80104193:	00 00 00 
80104196:	eb b4                	jmp    8010414c <userinit+0x20c>
        panic("ASSERT FAILED: proc->state != state");
80104198:	83 ec 0c             	sub    $0xc,%esp
8010419b:	68 08 8d 10 80       	push   $0x80108d08
801041a0:	e8 eb c1 ff ff       	call   80100390 <panic>
      panic("\n[EMBRYO->RUNNABLE]:oh no!! I'm panicking!");
801041a5:	83 ec 0c             	sub    $0xc,%esp
801041a8:	68 a8 8d 10 80       	push   $0x80108da8
801041ad:	e8 de c1 ff ff       	call   80100390 <panic>
    panic("userinit: out of memory?");
801041b2:	83 ec 0c             	sub    $0xc,%esp
801041b5:	68 7f 8f 10 80       	push   $0x80108f7f
801041ba:	e8 d1 c1 ff ff       	call   80100390 <panic>
801041bf:	90                   	nop

801041c0 <growproc>:
{
801041c0:	55                   	push   %ebp
801041c1:	89 e5                	mov    %esp,%ebp
801041c3:	56                   	push   %esi
801041c4:	53                   	push   %ebx
801041c5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801041c8:	e8 d3 16 00 00       	call   801058a0 <pushcli>
  c = mycpu();
801041cd:	e8 9e fc ff ff       	call   80103e70 <mycpu>
  p = c->proc;
801041d2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801041d8:	e8 13 17 00 00       	call   801058f0 <popcli>
  sz = curproc->sz;
801041dd:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
801041df:	85 f6                	test   %esi,%esi
801041e1:	7f 1d                	jg     80104200 <growproc+0x40>
  } else if(n < 0){
801041e3:	75 3b                	jne    80104220 <growproc+0x60>
  switchuvm(curproc);
801041e5:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
801041e8:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801041ea:	53                   	push   %ebx
801041eb:	e8 c0 3e 00 00       	call   801080b0 <switchuvm>
  return 0;
801041f0:	83 c4 10             	add    $0x10,%esp
801041f3:	31 c0                	xor    %eax,%eax
}
801041f5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801041f8:	5b                   	pop    %ebx
801041f9:	5e                   	pop    %esi
801041fa:	5d                   	pop    %ebp
801041fb:	c3                   	ret    
801041fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104200:	83 ec 04             	sub    $0x4,%esp
80104203:	01 c6                	add    %eax,%esi
80104205:	56                   	push   %esi
80104206:	50                   	push   %eax
80104207:	ff 73 04             	pushl  0x4(%ebx)
8010420a:	e8 f1 40 00 00       	call   80108300 <allocuvm>
8010420f:	83 c4 10             	add    $0x10,%esp
80104212:	85 c0                	test   %eax,%eax
80104214:	75 cf                	jne    801041e5 <growproc+0x25>
      return -1;
80104216:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010421b:	eb d8                	jmp    801041f5 <growproc+0x35>
8010421d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104220:	83 ec 04             	sub    $0x4,%esp
80104223:	01 c6                	add    %eax,%esi
80104225:	56                   	push   %esi
80104226:	50                   	push   %eax
80104227:	ff 73 04             	pushl  0x4(%ebx)
8010422a:	e8 01 42 00 00       	call   80108430 <deallocuvm>
8010422f:	83 c4 10             	add    $0x10,%esp
80104232:	85 c0                	test   %eax,%eax
80104234:	75 af                	jne    801041e5 <growproc+0x25>
80104236:	eb de                	jmp    80104216 <growproc+0x56>
80104238:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010423f:	90                   	nop

80104240 <fork>:
{
80104240:	55                   	push   %ebp
80104241:	89 e5                	mov    %esp,%ebp
80104243:	57                   	push   %edi
80104244:	56                   	push   %esi
80104245:	53                   	push   %ebx
80104246:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104249:	e8 52 16 00 00       	call   801058a0 <pushcli>
  c = mycpu();
8010424e:	e8 1d fc ff ff       	call   80103e70 <mycpu>
  p = c->proc;
80104253:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104259:	e8 92 16 00 00       	call   801058f0 <popcli>
  if((np = allocproc()) == 0){
8010425e:	e8 ad f9 ff ff       	call   80103c10 <allocproc>
80104263:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104266:	85 c0                	test   %eax,%eax
80104268:	0f 84 1b 02 00 00    	je     80104489 <fork+0x249>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
8010426e:	83 ec 08             	sub    $0x8,%esp
80104271:	ff 33                	pushl  (%ebx)
80104273:	89 c7                	mov    %eax,%edi
80104275:	ff 73 04             	pushl  0x4(%ebx)
80104278:	e8 33 43 00 00       	call   801085b0 <copyuvm>
8010427d:	83 c4 10             	add    $0x10,%esp
80104280:	89 47 04             	mov    %eax,0x4(%edi)
80104283:	85 c0                	test   %eax,%eax
80104285:	0f 84 45 01 00 00    	je     801043d0 <fork+0x190>
  np->sz = curproc->sz;
8010428b:	8b 03                	mov    (%ebx),%eax
8010428d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  *np->tf = *curproc->tf;
80104290:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = curproc->sz;
80104295:	89 02                	mov    %eax,(%edx)
  *np->tf = *curproc->tf;
80104297:	8b 7a 18             	mov    0x18(%edx),%edi
  np->parent = curproc;
8010429a:	89 5a 14             	mov    %ebx,0x14(%edx)
  *np->tf = *curproc->tf;
8010429d:	8b 73 18             	mov    0x18(%ebx),%esi
801042a0:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
801042a2:	31 f6                	xor    %esi,%esi
  np->uid = curproc->uid;
801042a4:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
801042aa:	89 82 84 00 00 00    	mov    %eax,0x84(%edx)
  np->gid = curproc->gid;
801042b0:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
801042b6:	89 82 80 00 00 00    	mov    %eax,0x80(%edx)
  np->tf->eax = 0;
801042bc:	8b 42 18             	mov    0x18(%edx),%eax
801042bf:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
801042c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042cd:	8d 76 00             	lea    0x0(%esi),%esi
    if(curproc->ofile[i])
801042d0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
801042d4:	85 c0                	test   %eax,%eax
801042d6:	74 13                	je     801042eb <fork+0xab>
      np->ofile[i] = filedup(curproc->ofile[i]);
801042d8:	83 ec 0c             	sub    $0xc,%esp
801042db:	50                   	push   %eax
801042dc:	e8 0f cd ff ff       	call   80100ff0 <filedup>
801042e1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801042e4:	83 c4 10             	add    $0x10,%esp
801042e7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
801042eb:	83 c6 01             	add    $0x1,%esi
801042ee:	83 fe 10             	cmp    $0x10,%esi
801042f1:	75 dd                	jne    801042d0 <fork+0x90>
  np->cwd = idup(curproc->cwd);
801042f3:	83 ec 0c             	sub    $0xc,%esp
801042f6:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801042f9:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
801042fc:	e8 9f d5 ff ff       	call   801018a0 <idup>
80104301:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104304:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80104307:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010430a:	8d 47 6c             	lea    0x6c(%edi),%eax
8010430d:	6a 10                	push   $0x10
8010430f:	53                   	push   %ebx
80104310:	50                   	push   %eax
80104311:	e8 5a 19 00 00       	call   80105c70 <safestrcpy>
  pid = np->pid;
80104316:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80104319:	c7 04 24 e0 c5 10 80 	movl   $0x8010c5e0,(%esp)
80104320:	e8 6b 16 00 00       	call   80105990 <acquire>
int rc = stateListRemove(&ptable.list[EMBRYO],np);
80104325:	89 f9                	mov    %edi,%ecx
80104327:	ba 20 ed 10 80       	mov    $0x8010ed20,%edx
8010432c:	b8 1c ed 10 80       	mov    $0x8010ed1c,%eax
80104331:	e8 3a f7 ff ff       	call   80103a70 <stateListRemove.isra.1>
  if(rc < 0)
80104336:	83 c4 10             	add    $0x10,%esp
80104339:	85 c0                	test   %eax,%eax
8010433b:	0f 88 6c 01 00 00    	js     801044ad <fork+0x26d>
    if(p->state != state){
80104341:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104344:	83 78 0c 01          	cmpl   $0x1,0xc(%eax)
80104348:	0f 85 52 01 00 00    	jne    801044a0 <fork+0x260>
  np->state = RUNNABLE;
8010434e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  np->priority = MAXPRIO;
80104355:	c7 80 94 00 00 00 0a 	movl   $0xa,0x94(%eax)
8010435c:	00 00 00 
    if((*list).head == NULL){
8010435f:	8b 15 94 ed 10 80    	mov    0x8010ed94,%edx
80104365:	85 d2                	test   %edx,%edx
80104367:	74 47                	je     801043b0 <fork+0x170>
        ((*list).tail)->next = p;
80104369:	a1 98 ed 10 80       	mov    0x8010ed98,%eax
8010436e:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104371:	89 88 90 00 00 00    	mov    %ecx,0x90(%eax)
        (*list).tail = ((*list).tail)->next;
80104377:	a1 98 ed 10 80       	mov    0x8010ed98,%eax
8010437c:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80104382:	a3 98 ed 10 80       	mov    %eax,0x8010ed98
        ((*list).tail)->next = NULL;
80104387:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
8010438e:	00 00 00 
  release(&ptable.lock);
80104391:	83 ec 0c             	sub    $0xc,%esp
80104394:	68 e0 c5 10 80       	push   $0x8010c5e0
80104399:	e8 b2 16 00 00       	call   80105a50 <release>
  return pid;
8010439e:	89 d8                	mov    %ebx,%eax
801043a0:	83 c4 10             	add    $0x10,%esp
}
801043a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043a6:	5b                   	pop    %ebx
801043a7:	5e                   	pop    %esi
801043a8:	5f                   	pop    %edi
801043a9:	5d                   	pop    %ebp
801043aa:	c3                   	ret    
801043ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043af:	90                   	nop
        (*list).head = p;
801043b0:	a3 94 ed 10 80       	mov    %eax,0x8010ed94
        (*list).tail = p;
801043b5:	a3 98 ed 10 80       	mov    %eax,0x8010ed98
        p->next = NULL;
801043ba:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
801043c1:	00 00 00 
801043c4:	eb cb                	jmp    80104391 <fork+0x151>
801043c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043cd:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(np->kstack);
801043d0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801043d3:	83 ec 0c             	sub    $0xc,%esp
801043d6:	ff 77 08             	pushl  0x8(%edi)
801043d9:	e8 82 e3 ff ff       	call   80102760 <kfree>
    np->kstack = 0;
801043de:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    acquire(&ptable.lock);
801043e5:	c7 04 24 e0 c5 10 80 	movl   $0x8010c5e0,(%esp)
801043ec:	e8 9f 15 00 00       	call   80105990 <acquire>
    int rc = stateListRemove(&ptable.list[EMBRYO],np);
801043f1:	89 f9                	mov    %edi,%ecx
801043f3:	ba 20 ed 10 80       	mov    $0x8010ed20,%edx
801043f8:	b8 1c ed 10 80       	mov    $0x8010ed1c,%eax
801043fd:	e8 6e f6 ff ff       	call   80103a70 <stateListRemove.isra.1>
    if(rc < 0)
80104402:	83 c4 10             	add    $0x10,%esp
80104405:	85 c0                	test   %eax,%eax
80104407:	0f 88 86 00 00 00    	js     80104493 <fork+0x253>
    if(p->state != state){
8010440d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104410:	83 78 0c 01          	cmpl   $0x1,0xc(%eax)
80104414:	0f 85 86 00 00 00    	jne    801044a0 <fork+0x260>
    np->state = UNUSED;
8010441a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010441d:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    if((*list).head == NULL){
80104424:	8b 0d 14 ed 10 80    	mov    0x8010ed14,%ecx
8010442a:	85 c9                	test   %ecx,%ecx
8010442c:	74 45                	je     80104473 <fork+0x233>
        ((*list).tail)->next = p;
8010442e:	a1 18 ed 10 80       	mov    0x8010ed18,%eax
80104433:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104436:	89 88 90 00 00 00    	mov    %ecx,0x90(%eax)
        (*list).tail = ((*list).tail)->next;
8010443c:	a1 18 ed 10 80       	mov    0x8010ed18,%eax
80104441:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80104447:	a3 18 ed 10 80       	mov    %eax,0x8010ed18
        ((*list).tail)->next = NULL;
8010444c:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
80104453:	00 00 00 
    release(&ptable.lock);
80104456:	83 ec 0c             	sub    $0xc,%esp
80104459:	68 e0 c5 10 80       	push   $0x8010c5e0
8010445e:	e8 ed 15 00 00       	call   80105a50 <release>
    return -1;
80104463:	83 c4 10             	add    $0x10,%esp
}
80104466:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80104469:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010446e:	5b                   	pop    %ebx
8010446f:	5e                   	pop    %esi
80104470:	5f                   	pop    %edi
80104471:	5d                   	pop    %ebp
80104472:	c3                   	ret    
        (*list).head = p;
80104473:	a3 14 ed 10 80       	mov    %eax,0x8010ed14
        (*list).tail = p;
80104478:	a3 18 ed 10 80       	mov    %eax,0x8010ed18
        p->next = NULL;
8010447d:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
80104484:	00 00 00 
80104487:	eb cd                	jmp    80104456 <fork+0x216>
    return -1;
80104489:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010448e:	e9 10 ff ff ff       	jmp    801043a3 <fork+0x163>
        panic("[EMBRYO->UNUSED]:oh no!! I'm Panicking!");
80104493:	83 ec 0c             	sub    $0xc,%esp
80104496:	68 d4 8d 10 80       	push   $0x80108dd4
8010449b:	e8 f0 be ff ff       	call   80100390 <panic>
        panic("ASSERT FAILED: proc->state != state");
801044a0:	83 ec 0c             	sub    $0xc,%esp
801044a3:	68 08 8d 10 80       	push   $0x80108d08
801044a8:	e8 e3 be ff ff       	call   80100390 <panic>
      panic("\n[EMBRYO->RUNNABLE]:oh no!! I'm panicking!");
801044ad:	83 ec 0c             	sub    $0xc,%esp
801044b0:	68 a8 8d 10 80       	push   $0x80108da8
801044b5:	e8 d6 be ff ff       	call   80100390 <panic>
801044ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801044c0 <scheduler>:
{
801044c0:	55                   	push   %ebp
801044c1:	89 e5                	mov    %esp,%ebp
801044c3:	57                   	push   %edi
801044c4:	56                   	push   %esi
801044c5:	53                   	push   %ebx
801044c6:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
801044c9:	e8 a2 f9 ff ff       	call   80103e70 <mycpu>
  c->proc = 0;
801044ce:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
801044d5:	00 00 00 
  struct cpu *c = mycpu();
801044d8:	89 c6                	mov    %eax,%esi
            swtch(&(c->scheduler), p->context);
801044da:	8d 40 04             	lea    0x4(%eax),%eax
801044dd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  asm volatile("sti");
801044e0:	fb                   	sti    
    acquire(&ptable.lock);
801044e1:	83 ec 0c             	sub    $0xc,%esp
801044e4:	68 e0 c5 10 80       	push   $0x8010c5e0
801044e9:	e8 a2 14 00 00       	call   80105990 <acquire>
    if(ticks >= ptable.PromoteAtTime){
801044ee:	a1 20 7d 11 80       	mov    0x80117d20,%eax
801044f3:	83 c4 10             	add    $0x10,%esp
801044f6:	39 05 9c ed 10 80    	cmp    %eax,0x8010ed9c
801044fc:	0f 86 fe 00 00 00    	jbe    80104600 <scheduler+0x140>
80104502:	bf 44 ed 10 80       	mov    $0x8010ed44,%edi
        for(int i=0;i<MAXPRIO+1;++i){
80104507:	b8 01 00 00 00       	mov    $0x1,%eax
8010450c:	eb 60                	jmp    8010456e <scheduler+0xae>
8010450e:	66 90                	xchg   %ax,%ax
        ((*list).tail)->next = p;
80104510:	a1 38 ed 10 80       	mov    0x8010ed38,%eax
80104515:	89 98 90 00 00 00    	mov    %ebx,0x90(%eax)
        (*list).tail = ((*list).tail)->next;
8010451b:	a1 38 ed 10 80       	mov    0x8010ed38,%eax
80104520:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80104526:	a3 38 ed 10 80       	mov    %eax,0x8010ed38
        ((*list).tail)->next = NULL;
8010452b:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
80104532:	00 00 00 
            swtch(&(c->scheduler), p->context);
80104535:	83 ec 08             	sub    $0x8,%esp
80104538:	ff 73 1c             	pushl  0x1c(%ebx)
8010453b:	ff 75 e4             	pushl  -0x1c(%ebp)
8010453e:	e8 88 17 00 00       	call   80105ccb <swtch>
            switchkvm();
80104543:	e8 58 3b 00 00       	call   801080a0 <switchkvm>
            p->cpu_ticks_in = ticks;
80104548:	a1 20 7d 11 80       	mov    0x80117d20,%eax
            c->proc = 0;
8010454d:	83 c4 10             	add    $0x10,%esp
            p->cpu_ticks_in = ticks;
80104550:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
            idle = 0;  // not idle this timeslice
80104556:	31 c0                	xor    %eax,%eax
            c->proc = 0;
80104558:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
8010455f:	00 00 00 
80104562:	83 c7 08             	add    $0x8,%edi
    for(int i=0;i<MAXPRIO+1;++i){
80104565:	b9 9c ed 10 80       	mov    $0x8010ed9c,%ecx
8010456a:	39 f9                	cmp    %edi,%ecx
8010456c:	74 6a                	je     801045d8 <scheduler+0x118>
        if(ptable.ready[i].head){
8010456e:	8b 1f                	mov    (%edi),%ebx
80104570:	85 db                	test   %ebx,%ebx
80104572:	74 ee                	je     80104562 <scheduler+0xa2>
            int rc = stateListRemove(&ptable.ready[i],p);
80104574:	8d 57 04             	lea    0x4(%edi),%edx
80104577:	89 d9                	mov    %ebx,%ecx
80104579:	89 f8                	mov    %edi,%eax
8010457b:	e8 f0 f4 ff ff       	call   80103a70 <stateListRemove.isra.1>
            if(rc < 0)
80104580:	85 c0                	test   %eax,%eax
80104582:	0f 88 a0 01 00 00    	js     80104728 <scheduler+0x268>
            switchuvm(p);
80104588:	83 ec 0c             	sub    $0xc,%esp
            c->proc = p;
8010458b:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
            switchuvm(p);
80104591:	53                   	push   %ebx
80104592:	e8 19 3b 00 00       	call   801080b0 <switchuvm>
    if(p->state != state){
80104597:	83 c4 10             	add    $0x10,%esp
8010459a:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
8010459e:	0f 85 91 01 00 00    	jne    80104735 <scheduler+0x275>
            p->state = RUNNING;
801045a4:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
    if((*list).head == NULL){
801045ab:	a1 34 ed 10 80       	mov    0x8010ed34,%eax
801045b0:	85 c0                	test   %eax,%eax
801045b2:	0f 85 58 ff ff ff    	jne    80104510 <scheduler+0x50>
        (*list).head = p;
801045b8:	89 1d 34 ed 10 80    	mov    %ebx,0x8010ed34
        (*list).tail = p;
801045be:	89 1d 38 ed 10 80    	mov    %ebx,0x8010ed38
        p->next = NULL;
801045c4:	c7 83 90 00 00 00 00 	movl   $0x0,0x90(%ebx)
801045cb:	00 00 00 
801045ce:	e9 62 ff ff ff       	jmp    80104535 <scheduler+0x75>
801045d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045d7:	90                   	nop
    release(&ptable.lock);
801045d8:	83 ec 0c             	sub    $0xc,%esp
801045db:	89 45 e0             	mov    %eax,-0x20(%ebp)
801045de:	68 e0 c5 10 80       	push   $0x8010c5e0
801045e3:	e8 68 14 00 00       	call   80105a50 <release>
    if (idle) {
801045e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801045eb:	83 c4 10             	add    $0x10,%esp
801045ee:	85 c0                	test   %eax,%eax
801045f0:	0f 84 ea fe ff ff    	je     801044e0 <scheduler+0x20>
801045f6:	fb                   	sti    

// hlt() added by Noah Zentzis, Fall 2016.
static inline void
hlt()
{
  asm volatile("hlt");
801045f7:	f4                   	hlt    
801045f8:	e9 e3 fe ff ff       	jmp    801044e0 <scheduler+0x20>
801045fd:	8d 76 00             	lea    0x0(%esi),%esi
        for(int i=0;i<MAXPRIO+1;++i){
80104600:	31 ff                	xor    %edi,%edi
80104602:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            ptable.PromoteAtTime = ticks + TICKS_TO_PROMOTE;
80104608:	05 b8 0b 00 00       	add    $0xbb8,%eax
8010460d:	a3 9c ed 10 80       	mov    %eax,0x8010ed9c
            promoteQueue(&ptable.ready[i]);
80104612:	8b 1c fd 44 ed 10 80 	mov    -0x7fef12bc(,%edi,8),%ebx
    if((*readyList).head == NULL)
80104619:	85 db                	test   %ebx,%ebx
8010461b:	75 0d                	jne    8010462a <scheduler+0x16a>
8010461d:	eb 79                	jmp    80104698 <scheduler+0x1d8>
8010461f:	90                   	nop
        current = current->next;
80104620:	8b 9b 90 00 00 00    	mov    0x90(%ebx),%ebx
    while(current){
80104626:	85 db                	test   %ebx,%ebx
80104628:	74 6e                	je     80104698 <scheduler+0x1d8>
        if(current != NULL && current->priority < MAXPRIO){
8010462a:	8b 83 94 00 00 00    	mov    0x94(%ebx),%eax
80104630:	83 f8 09             	cmp    $0x9,%eax
80104633:	77 eb                	ja     80104620 <scheduler+0x160>
            stateListRemove(&ptable.ready[current->priority],current);
80104635:	8d 04 c5 44 ed 10 80 	lea    -0x7fef12bc(,%eax,8),%eax
8010463c:	89 d9                	mov    %ebx,%ecx
8010463e:	8d 50 04             	lea    0x4(%eax),%edx
80104641:	e8 2a f4 ff ff       	call   80103a70 <stateListRemove.isra.1>
            current->priority += 1;
80104646:	8b 83 94 00 00 00    	mov    0x94(%ebx),%eax
8010464c:	8d 50 01             	lea    0x1(%eax),%edx
8010464f:	89 93 94 00 00 00    	mov    %edx,0x94(%ebx)
            stateListAdd(&ptable.ready[current->priority],current);
80104655:	8d 14 c5 6c 27 00 00 	lea    0x276c(,%eax,8),%edx
8010465c:	8d 82 e0 c5 10 80    	lea    -0x7fef3a20(%edx),%eax
    if((*list).head == NULL){
80104662:	8b 92 e0 c5 10 80    	mov    -0x7fef3a20(%edx),%edx
80104668:	85 d2                	test   %edx,%edx
8010466a:	74 44                	je     801046b0 <scheduler+0x1f0>
        ((*list).tail)->next = p;
8010466c:	8b 50 04             	mov    0x4(%eax),%edx
8010466f:	89 9a 90 00 00 00    	mov    %ebx,0x90(%edx)
        (*list).tail = ((*list).tail)->next;
80104675:	8b 50 04             	mov    0x4(%eax),%edx
80104678:	8b 92 90 00 00 00    	mov    0x90(%edx),%edx
8010467e:	89 50 04             	mov    %edx,0x4(%eax)
        ((*list).tail)->next = NULL;
80104681:	c7 82 90 00 00 00 00 	movl   $0x0,0x90(%edx)
80104688:	00 00 00 
        current = current->next;
8010468b:	8b 9b 90 00 00 00    	mov    0x90(%ebx),%ebx
    while(current){
80104691:	85 db                	test   %ebx,%ebx
80104693:	75 95                	jne    8010462a <scheduler+0x16a>
80104695:	8d 76 00             	lea    0x0(%esi),%esi
        for(int i=0;i<MAXPRIO+1;++i){
80104698:	83 c7 01             	add    $0x1,%edi
8010469b:	83 ff 0b             	cmp    $0xb,%edi
8010469e:	74 27                	je     801046c7 <scheduler+0x207>
801046a0:	a1 20 7d 11 80       	mov    0x80117d20,%eax
801046a5:	e9 5e ff ff ff       	jmp    80104608 <scheduler+0x148>
801046aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046b0:	83 c7 01             	add    $0x1,%edi
        (*list).head = p;
801046b3:	89 18                	mov    %ebx,(%eax)
        (*list).tail = p;
801046b5:	89 58 04             	mov    %ebx,0x4(%eax)
        p->next = NULL;
801046b8:	c7 83 90 00 00 00 00 	movl   $0x0,0x90(%ebx)
801046bf:	00 00 00 
        for(int i=0;i<MAXPRIO+1;++i){
801046c2:	83 ff 0b             	cmp    $0xb,%edi
801046c5:	75 d9                	jne    801046a0 <scheduler+0x1e0>
        promoteProcess(&ptable.list[SLEEPING]);
801046c7:	a1 24 ed 10 80       	mov    0x8010ed24,%eax
    if((*list).head == NULL)
801046cc:	85 c0                	test   %eax,%eax
801046ce:	74 1e                	je     801046ee <scheduler+0x22e>
        if(current != NULL && current->priority < MAXPRIO)
801046d0:	8b 90 94 00 00 00    	mov    0x94(%eax),%edx
801046d6:	83 fa 09             	cmp    $0x9,%edx
801046d9:	77 09                	ja     801046e4 <scheduler+0x224>
            current->priority += 1;
801046db:	83 c2 01             	add    $0x1,%edx
801046de:	89 90 94 00 00 00    	mov    %edx,0x94(%eax)
        current = current->next;
801046e4:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
    while(current){
801046ea:	85 c0                	test   %eax,%eax
801046ec:	75 e2                	jne    801046d0 <scheduler+0x210>
        promoteProcess(&ptable.list[RUNNING]);
801046ee:	a1 34 ed 10 80       	mov    0x8010ed34,%eax
    if((*list).head == NULL)
801046f3:	85 c0                	test   %eax,%eax
801046f5:	0f 84 07 fe ff ff    	je     80104502 <scheduler+0x42>
801046fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046ff:	90                   	nop
        if(current != NULL && current->priority < MAXPRIO)
80104700:	8b 90 94 00 00 00    	mov    0x94(%eax),%edx
80104706:	83 fa 09             	cmp    $0x9,%edx
80104709:	77 09                	ja     80104714 <scheduler+0x254>
            current->priority += 1;
8010470b:	83 c2 01             	add    $0x1,%edx
8010470e:	89 90 94 00 00 00    	mov    %edx,0x94(%eax)
        current = current->next;
80104714:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
    while(current){
8010471a:	85 c0                	test   %eax,%eax
8010471c:	75 e2                	jne    80104700 <scheduler+0x240>
8010471e:	e9 df fd ff ff       	jmp    80104502 <scheduler+0x42>
80104723:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104727:	90                   	nop
                panic("\n[RUNNABLE->RUNNING]:oh no!! I'm panicking!");
80104728:	83 ec 0c             	sub    $0xc,%esp
8010472b:	68 fc 8d 10 80       	push   $0x80108dfc
80104730:	e8 5b bc ff ff       	call   80100390 <panic>
        panic("ASSERT FAILED: proc->state != state");
80104735:	83 ec 0c             	sub    $0xc,%esp
80104738:	68 08 8d 10 80       	push   $0x80108d08
8010473d:	e8 4e bc ff ff       	call   80100390 <panic>
80104742:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104750 <sched>:
{
80104750:	55                   	push   %ebp
80104751:	89 e5                	mov    %esp,%ebp
80104753:	56                   	push   %esi
80104754:	53                   	push   %ebx
  pushcli();
80104755:	e8 46 11 00 00       	call   801058a0 <pushcli>
  c = mycpu();
8010475a:	e8 11 f7 ff ff       	call   80103e70 <mycpu>
  p = c->proc;
8010475f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104765:	e8 86 11 00 00       	call   801058f0 <popcli>
  if(!holding(&ptable.lock))
8010476a:	83 ec 0c             	sub    $0xc,%esp
8010476d:	68 e0 c5 10 80       	push   $0x8010c5e0
80104772:	e8 d9 11 00 00       	call   80105950 <holding>
80104777:	83 c4 10             	add    $0x10,%esp
8010477a:	85 c0                	test   %eax,%eax
8010477c:	74 60                	je     801047de <sched+0x8e>
  if(mycpu()->ncli != 1)
8010477e:	e8 ed f6 ff ff       	call   80103e70 <mycpu>
80104783:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010478a:	75 79                	jne    80104805 <sched+0xb5>
  if(p->state == RUNNING)
8010478c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104790:	74 66                	je     801047f8 <sched+0xa8>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104792:	9c                   	pushf  
80104793:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104794:	f6 c4 02             	test   $0x2,%ah
80104797:	75 52                	jne    801047eb <sched+0x9b>
  p->cpu_ticks_total += (ticks - p->cpu_ticks_in);
80104799:	a1 20 7d 11 80       	mov    0x80117d20,%eax
8010479e:	03 83 88 00 00 00    	add    0x88(%ebx),%eax
  swtch(&p->context, mycpu()->scheduler);
801047a4:	83 c3 1c             	add    $0x1c,%ebx
  p->cpu_ticks_total += (ticks - p->cpu_ticks_in);
801047a7:	2b 43 70             	sub    0x70(%ebx),%eax
801047aa:	89 43 6c             	mov    %eax,0x6c(%ebx)
  intena = mycpu()->intena;
801047ad:	e8 be f6 ff ff       	call   80103e70 <mycpu>
801047b2:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
801047b8:	e8 b3 f6 ff ff       	call   80103e70 <mycpu>
801047bd:	83 ec 08             	sub    $0x8,%esp
801047c0:	ff 70 04             	pushl  0x4(%eax)
801047c3:	53                   	push   %ebx
801047c4:	e8 02 15 00 00       	call   80105ccb <swtch>
  mycpu()->intena = intena;
801047c9:	e8 a2 f6 ff ff       	call   80103e70 <mycpu>
}
801047ce:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
801047d1:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
801047d7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801047da:	5b                   	pop    %ebx
801047db:	5e                   	pop    %esi
801047dc:	5d                   	pop    %ebp
801047dd:	c3                   	ret    
    panic("sched ptable.lock");
801047de:	83 ec 0c             	sub    $0xc,%esp
801047e1:	68 a3 8f 10 80       	push   $0x80108fa3
801047e6:	e8 a5 bb ff ff       	call   80100390 <panic>
    panic("sched interruptible");
801047eb:	83 ec 0c             	sub    $0xc,%esp
801047ee:	68 cf 8f 10 80       	push   $0x80108fcf
801047f3:	e8 98 bb ff ff       	call   80100390 <panic>
    panic("sched running");
801047f8:	83 ec 0c             	sub    $0xc,%esp
801047fb:	68 c1 8f 10 80       	push   $0x80108fc1
80104800:	e8 8b bb ff ff       	call   80100390 <panic>
    panic("sched locks");
80104805:	83 ec 0c             	sub    $0xc,%esp
80104808:	68 b5 8f 10 80       	push   $0x80108fb5
8010480d:	e8 7e bb ff ff       	call   80100390 <panic>
80104812:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104820 <exit>:
{
80104820:	55                   	push   %ebp
80104821:	89 e5                	mov    %esp,%ebp
80104823:	57                   	push   %edi
80104824:	56                   	push   %esi
80104825:	53                   	push   %ebx
80104826:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80104829:	e8 72 10 00 00       	call   801058a0 <pushcli>
  c = mycpu();
8010482e:	e8 3d f6 ff ff       	call   80103e70 <mycpu>
  p = c->proc;
80104833:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104839:	e8 b2 10 00 00       	call   801058f0 <popcli>
  if(curproc == initproc)
8010483e:	8d 5e 28             	lea    0x28(%esi),%ebx
80104841:	8d 7e 68             	lea    0x68(%esi),%edi
80104844:	39 35 c0 c5 10 80    	cmp    %esi,0x8010c5c0
8010484a:	0f 84 fb 01 00 00    	je     80104a4b <exit+0x22b>
    if(curproc->ofile[fd]){
80104850:	8b 03                	mov    (%ebx),%eax
80104852:	85 c0                	test   %eax,%eax
80104854:	74 12                	je     80104868 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80104856:	83 ec 0c             	sub    $0xc,%esp
80104859:	50                   	push   %eax
8010485a:	e8 e1 c7 ff ff       	call   80101040 <fileclose>
      curproc->ofile[fd] = 0;
8010485f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104865:	83 c4 10             	add    $0x10,%esp
80104868:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
8010486b:	39 df                	cmp    %ebx,%edi
8010486d:	75 e1                	jne    80104850 <exit+0x30>
  begin_op();
8010486f:	e8 9c e7 ff ff       	call   80103010 <begin_op>
  iput(curproc->cwd);
80104874:	83 ec 0c             	sub    $0xc,%esp
80104877:	ff 76 68             	pushl  0x68(%esi)
8010487a:	e8 a1 d1 ff ff       	call   80101a20 <iput>
  end_op();
8010487f:	e8 fc e7 ff ff       	call   80103080 <end_op>
  curproc->cwd = 0;
80104884:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
8010488b:	c7 04 24 e0 c5 10 80 	movl   $0x8010c5e0,(%esp)
80104892:	e8 f9 10 00 00       	call   80105990 <acquire>
  wakeup1(curproc->parent);
80104897:	8b 46 14             	mov    0x14(%esi),%eax
8010489a:	e8 81 f2 ff ff       	call   80103b20 <wakeup1>
  embryo_p = ptable.list[EMBRYO].head;
8010489f:	8b 1d 1c ed 10 80    	mov    0x8010ed1c,%ebx
  while(embryo_p){
801048a5:	83 c4 10             	add    $0x10,%esp
801048a8:	85 db                	test   %ebx,%ebx
801048aa:	75 0e                	jne    801048ba <exit+0x9a>
801048ac:	eb 26                	jmp    801048d4 <exit+0xb4>
801048ae:	66 90                	xchg   %ax,%ax
      current = embryo_p->next;
801048b0:	8b 9b 90 00 00 00    	mov    0x90(%ebx),%ebx
  while(embryo_p){
801048b6:	85 db                	test   %ebx,%ebx
801048b8:	74 1a                	je     801048d4 <exit+0xb4>
      if(embryo_p->parent == curproc){
801048ba:	39 73 14             	cmp    %esi,0x14(%ebx)
801048bd:	75 f1                	jne    801048b0 <exit+0x90>
          embryo_p->parent = initproc;
801048bf:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
          if(embryo_p->state == ZOMBIE)
801048c4:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
          embryo_p->parent = initproc;
801048c8:	89 43 14             	mov    %eax,0x14(%ebx)
          if(embryo_p->state == ZOMBIE)
801048cb:	75 e3                	jne    801048b0 <exit+0x90>
              wakeup1(initproc);
801048cd:	e8 4e f2 ff ff       	call   80103b20 <wakeup1>
801048d2:	eb dc                	jmp    801048b0 <exit+0x90>
  for(int i=0;i<MAXPRIO+1;++i){
801048d4:	31 ff                	xor    %edi,%edi
801048d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048dd:	8d 76 00             	lea    0x0(%esi),%esi
      runnable_p = ptable.ready[i].head;
801048e0:	8b 1c fd 44 ed 10 80 	mov    -0x7fef12bc(,%edi,8),%ebx
      while(runnable_p){
801048e7:	85 db                	test   %ebx,%ebx
801048e9:	75 0f                	jne    801048fa <exit+0xda>
801048eb:	eb 33                	jmp    80104920 <exit+0x100>
801048ed:	8d 76 00             	lea    0x0(%esi),%esi
          current = runnable_p->next;
801048f0:	8b 9b 90 00 00 00    	mov    0x90(%ebx),%ebx
      while(runnable_p){
801048f6:	85 db                	test   %ebx,%ebx
801048f8:	74 26                	je     80104920 <exit+0x100>
          if(runnable_p->parent == curproc){
801048fa:	39 73 14             	cmp    %esi,0x14(%ebx)
801048fd:	75 f1                	jne    801048f0 <exit+0xd0>
              runnable_p->parent = initproc;
801048ff:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
              if(runnable_p->state == ZOMBIE)
80104904:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
              runnable_p->parent = initproc;
80104908:	89 43 14             	mov    %eax,0x14(%ebx)
              if(runnable_p->state == ZOMBIE)
8010490b:	75 e3                	jne    801048f0 <exit+0xd0>
                  wakeup1(initproc);
8010490d:	e8 0e f2 ff ff       	call   80103b20 <wakeup1>
          current = runnable_p->next;
80104912:	8b 9b 90 00 00 00    	mov    0x90(%ebx),%ebx
      while(runnable_p){
80104918:	85 db                	test   %ebx,%ebx
8010491a:	75 de                	jne    801048fa <exit+0xda>
8010491c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(int i=0;i<MAXPRIO+1;++i){
80104920:	83 c7 01             	add    $0x1,%edi
80104923:	83 ff 0b             	cmp    $0xb,%edi
80104926:	75 b8                	jne    801048e0 <exit+0xc0>
  running_p = ptable.list[RUNNING].head;
80104928:	8b 1d 34 ed 10 80    	mov    0x8010ed34,%ebx
  while(running_p){
8010492e:	85 db                	test   %ebx,%ebx
80104930:	75 10                	jne    80104942 <exit+0x122>
80104932:	eb 28                	jmp    8010495c <exit+0x13c>
80104934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      current = running_p->next;
80104938:	8b 9b 90 00 00 00    	mov    0x90(%ebx),%ebx
  while(running_p){
8010493e:	85 db                	test   %ebx,%ebx
80104940:	74 1a                	je     8010495c <exit+0x13c>
      if(running_p->parent == curproc){
80104942:	39 73 14             	cmp    %esi,0x14(%ebx)
80104945:	75 f1                	jne    80104938 <exit+0x118>
          running_p->parent = initproc;
80104947:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
          if(running_p->state == ZOMBIE)
8010494c:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
          running_p->parent = initproc;
80104950:	89 43 14             	mov    %eax,0x14(%ebx)
          if(running_p->state == ZOMBIE)
80104953:	75 e3                	jne    80104938 <exit+0x118>
              wakeup1(initproc);
80104955:	e8 c6 f1 ff ff       	call   80103b20 <wakeup1>
8010495a:	eb dc                	jmp    80104938 <exit+0x118>
  sleeping_p = ptable.list[SLEEPING].head;
8010495c:	8b 1d 24 ed 10 80    	mov    0x8010ed24,%ebx
  while(sleeping_p){
80104962:	85 db                	test   %ebx,%ebx
80104964:	75 14                	jne    8010497a <exit+0x15a>
80104966:	eb 2c                	jmp    80104994 <exit+0x174>
80104968:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010496f:	90                   	nop
      current = sleeping_p->next;
80104970:	8b 9b 90 00 00 00    	mov    0x90(%ebx),%ebx
  while(sleeping_p){
80104976:	85 db                	test   %ebx,%ebx
80104978:	74 1a                	je     80104994 <exit+0x174>
      if(sleeping_p->parent == curproc){
8010497a:	39 73 14             	cmp    %esi,0x14(%ebx)
8010497d:	75 f1                	jne    80104970 <exit+0x150>
          sleeping_p->parent = initproc;
8010497f:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
          if(sleeping_p->state == ZOMBIE)
80104984:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
          sleeping_p->parent = initproc;
80104988:	89 43 14             	mov    %eax,0x14(%ebx)
          if(sleeping_p->state == ZOMBIE)
8010498b:	75 e3                	jne    80104970 <exit+0x150>
              wakeup1(initproc);
8010498d:	e8 8e f1 ff ff       	call   80103b20 <wakeup1>
80104992:	eb dc                	jmp    80104970 <exit+0x150>
  zombie_p = ptable.list[ZOMBIE].head;
80104994:	8b 1d 3c ed 10 80    	mov    0x8010ed3c,%ebx
  while(zombie_p){
8010499a:	85 db                	test   %ebx,%ebx
8010499c:	75 0c                	jne    801049aa <exit+0x18a>
8010499e:	eb 24                	jmp    801049c4 <exit+0x1a4>
      current = zombie_p->next;
801049a0:	8b 9b 90 00 00 00    	mov    0x90(%ebx),%ebx
  while(zombie_p){
801049a6:	85 db                	test   %ebx,%ebx
801049a8:	74 1a                	je     801049c4 <exit+0x1a4>
      if(zombie_p->parent == curproc){
801049aa:	39 73 14             	cmp    %esi,0x14(%ebx)
801049ad:	75 f1                	jne    801049a0 <exit+0x180>
          zombie_p->parent = initproc;
801049af:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
          if(zombie_p->state == ZOMBIE)
801049b4:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
          zombie_p->parent = initproc;
801049b8:	89 43 14             	mov    %eax,0x14(%ebx)
          if(zombie_p->state == ZOMBIE)
801049bb:	75 e3                	jne    801049a0 <exit+0x180>
              wakeup1(initproc);
801049bd:	e8 5e f1 ff ff       	call   80103b20 <wakeup1>
801049c2:	eb dc                	jmp    801049a0 <exit+0x180>
  rc = stateListRemove(&ptable.list[RUNNING],curproc);
801049c4:	89 f1                	mov    %esi,%ecx
801049c6:	ba 38 ed 10 80       	mov    $0x8010ed38,%edx
801049cb:	b8 34 ed 10 80       	mov    $0x8010ed34,%eax
801049d0:	e8 9b f0 ff ff       	call   80103a70 <stateListRemove.isra.1>
  if(rc < 0)
801049d5:	85 c0                	test   %eax,%eax
801049d7:	78 4d                	js     80104a26 <exit+0x206>
    if(p->state != state){
801049d9:	83 7e 0c 04          	cmpl   $0x4,0xc(%esi)
801049dd:	75 79                	jne    80104a58 <exit+0x238>
  curproc->state = ZOMBIE;
801049df:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
    if((*list).head == NULL){
801049e6:	83 3d 3c ed 10 80 00 	cmpl   $0x0,0x8010ed3c
801049ed:	74 44                	je     80104a33 <exit+0x213>
        ((*list).tail)->next = p;
801049ef:	a1 40 ed 10 80       	mov    0x8010ed40,%eax
801049f4:	89 b0 90 00 00 00    	mov    %esi,0x90(%eax)
        (*list).tail = ((*list).tail)->next;
801049fa:	a1 40 ed 10 80       	mov    0x8010ed40,%eax
801049ff:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80104a05:	a3 40 ed 10 80       	mov    %eax,0x8010ed40
        ((*list).tail)->next = NULL;
80104a0a:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
80104a11:	00 00 00 
  sched();
80104a14:	e8 37 fd ff ff       	call   80104750 <sched>
  panic("zombie exit");
80104a19:	83 ec 0c             	sub    $0xc,%esp
80104a1c:	68 f0 8f 10 80       	push   $0x80108ff0
80104a21:	e8 6a b9 ff ff       	call   80100390 <panic>
      panic("[RUNNING->ZOMBIE]:oh no!! I'm panicking!");
80104a26:	83 ec 0c             	sub    $0xc,%esp
80104a29:	68 28 8e 10 80       	push   $0x80108e28
80104a2e:	e8 5d b9 ff ff       	call   80100390 <panic>
        (*list).head = p;
80104a33:	89 35 3c ed 10 80    	mov    %esi,0x8010ed3c
        (*list).tail = p;
80104a39:	89 35 40 ed 10 80    	mov    %esi,0x8010ed40
        p->next = NULL;
80104a3f:	c7 86 90 00 00 00 00 	movl   $0x0,0x90(%esi)
80104a46:	00 00 00 
80104a49:	eb c9                	jmp    80104a14 <exit+0x1f4>
    panic("init exiting");
80104a4b:	83 ec 0c             	sub    $0xc,%esp
80104a4e:	68 e3 8f 10 80       	push   $0x80108fe3
80104a53:	e8 38 b9 ff ff       	call   80100390 <panic>
        panic("ASSERT FAILED: proc->state != state");
80104a58:	83 ec 0c             	sub    $0xc,%esp
80104a5b:	68 08 8d 10 80       	push   $0x80108d08
80104a60:	e8 2b b9 ff ff       	call   80100390 <panic>
80104a65:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104a70 <yield>:
{
80104a70:	55                   	push   %ebp
80104a71:	89 e5                	mov    %esp,%ebp
80104a73:	53                   	push   %ebx
80104a74:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104a77:	e8 24 0e 00 00       	call   801058a0 <pushcli>
  c = mycpu();
80104a7c:	e8 ef f3 ff ff       	call   80103e70 <mycpu>
  p = c->proc;
80104a81:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104a87:	e8 64 0e 00 00       	call   801058f0 <popcli>
  acquire(&ptable.lock);  //DOC: yieldlock
80104a8c:	83 ec 0c             	sub    $0xc,%esp
80104a8f:	68 e0 c5 10 80       	push   $0x8010c5e0
80104a94:	e8 f7 0e 00 00       	call   80105990 <acquire>
  rc = stateListRemove(&ptable.list[RUNNING],curproc);
80104a99:	89 d9                	mov    %ebx,%ecx
80104a9b:	ba 38 ed 10 80       	mov    $0x8010ed38,%edx
80104aa0:	b8 34 ed 10 80       	mov    $0x8010ed34,%eax
80104aa5:	e8 c6 ef ff ff       	call   80103a70 <stateListRemove.isra.1>
  if(rc < 0)
80104aaa:	83 c4 10             	add    $0x10,%esp
80104aad:	85 c0                	test   %eax,%eax
80104aaf:	0f 88 e7 00 00 00    	js     80104b9c <yield+0x12c>
    if(p->state != state){
80104ab5:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104ab9:	0f 85 d0 00 00 00    	jne    80104b8f <yield+0x11f>
  curproc->budget -= new_budget;
80104abf:	8b 8b 98 00 00 00    	mov    0x98(%ebx),%ecx
  new_budget = (time_out - time_in);
80104ac5:	a1 20 7d 11 80       	mov    0x80117d20,%eax
  curproc->state = RUNNABLE;
80104aca:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  new_budget = (time_out - time_in);
80104ad1:	2b 83 8c 00 00 00    	sub    0x8c(%ebx),%eax
80104ad7:	8b 93 94 00 00 00    	mov    0x94(%ebx),%edx
  curproc->budget -= new_budget;
80104add:	29 c1                	sub    %eax,%ecx
80104adf:	89 8b 98 00 00 00    	mov    %ecx,0x98(%ebx)
  if(curproc->budget <= 0){
80104ae5:	75 49                	jne    80104b30 <yield+0xc0>
      curproc->budget = BUDGET;
80104ae7:	c7 83 98 00 00 00 2c 	movl   $0x12c,0x98(%ebx)
80104aee:	01 00 00 
      else if(curproc->priority > MAXPRIO)
80104af1:	83 fa 0a             	cmp    $0xa,%edx
80104af4:	0f 87 86 00 00 00    	ja     80104b80 <yield+0x110>
          curproc->priority -= 1;
80104afa:	8d 42 ff             	lea    -0x1(%edx),%eax
80104afd:	8d 14 d5 5c 27 00 00 	lea    0x275c(,%edx,8),%edx
80104b04:	89 83 94 00 00 00    	mov    %eax,0x94(%ebx)
    if((*list).head == NULL){
80104b0a:	8b 8a e0 c5 10 80    	mov    -0x7fef3a20(%edx),%ecx
      stateListAdd(&ptable.ready[curproc->priority],curproc);
80104b10:	8d 82 e0 c5 10 80    	lea    -0x7fef3a20(%edx),%eax
    if((*list).head == NULL){
80104b16:	85 c9                	test   %ecx,%ecx
80104b18:	75 2d                	jne    80104b47 <yield+0xd7>
        (*list).head = p;
80104b1a:	89 9a e0 c5 10 80    	mov    %ebx,-0x7fef3a20(%edx)
        (*list).tail = p;
80104b20:	89 58 04             	mov    %ebx,0x4(%eax)
        p->next = NULL;
80104b23:	c7 83 90 00 00 00 00 	movl   $0x0,0x90(%ebx)
80104b2a:	00 00 00 
80104b2d:	eb 37                	jmp    80104b66 <yield+0xf6>
80104b2f:	90                   	nop
  stateListAdd(&ptable.ready[curproc->priority],curproc);
80104b30:	8d 14 d5 64 27 00 00 	lea    0x2764(,%edx,8),%edx
    if((*list).head == NULL){
80104b37:	8b 8a e0 c5 10 80    	mov    -0x7fef3a20(%edx),%ecx
  stateListAdd(&ptable.ready[curproc->priority],curproc);
80104b3d:	8d 82 e0 c5 10 80    	lea    -0x7fef3a20(%edx),%eax
    if((*list).head == NULL){
80104b43:	85 c9                	test   %ecx,%ecx
80104b45:	74 d3                	je     80104b1a <yield+0xaa>
        ((*list).tail)->next = p;
80104b47:	8b 50 04             	mov    0x4(%eax),%edx
80104b4a:	89 9a 90 00 00 00    	mov    %ebx,0x90(%edx)
        (*list).tail = ((*list).tail)->next;
80104b50:	8b 50 04             	mov    0x4(%eax),%edx
80104b53:	8b 92 90 00 00 00    	mov    0x90(%edx),%edx
80104b59:	89 50 04             	mov    %edx,0x4(%eax)
        ((*list).tail)->next = NULL;
80104b5c:	c7 82 90 00 00 00 00 	movl   $0x0,0x90(%edx)
80104b63:	00 00 00 
  sched();
80104b66:	e8 e5 fb ff ff       	call   80104750 <sched>
  release(&ptable.lock);
80104b6b:	83 ec 0c             	sub    $0xc,%esp
80104b6e:	68 e0 c5 10 80       	push   $0x8010c5e0
80104b73:	e8 d8 0e 00 00       	call   80105a50 <release>
}
80104b78:	83 c4 10             	add    $0x10,%esp
80104b7b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b7e:	c9                   	leave  
80104b7f:	c3                   	ret    
80104b80:	ba ac 27 00 00       	mov    $0x27ac,%edx
          curproc->priority = MAXPRIO-1;
80104b85:	b8 09 00 00 00       	mov    $0x9,%eax
80104b8a:	e9 75 ff ff ff       	jmp    80104b04 <yield+0x94>
        panic("ASSERT FAILED: proc->state != state");
80104b8f:	83 ec 0c             	sub    $0xc,%esp
80104b92:	68 08 8d 10 80       	push   $0x80108d08
80104b97:	e8 f4 b7 ff ff       	call   80100390 <panic>
      panic("\n[RUNNING->RUNNABLE]:oh no!! I'm panicking!");
80104b9c:	83 ec 0c             	sub    $0xc,%esp
80104b9f:	68 54 8e 10 80       	push   $0x80108e54
80104ba4:	e8 e7 b7 ff ff       	call   80100390 <panic>
80104ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104bb0 <sleep>:
{
80104bb0:	55                   	push   %ebp
80104bb1:	89 e5                	mov    %esp,%ebp
80104bb3:	57                   	push   %edi
80104bb4:	56                   	push   %esi
80104bb5:	53                   	push   %ebx
80104bb6:	83 ec 0c             	sub    $0xc,%esp
80104bb9:	8b 7d 08             	mov    0x8(%ebp),%edi
80104bbc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80104bbf:	e8 dc 0c 00 00       	call   801058a0 <pushcli>
  c = mycpu();
80104bc4:	e8 a7 f2 ff ff       	call   80103e70 <mycpu>
  p = c->proc;
80104bc9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104bcf:	e8 1c 0d 00 00       	call   801058f0 <popcli>
  if(p == 0)
80104bd4:	85 db                	test   %ebx,%ebx
80104bd6:	0f 84 4c 01 00 00    	je     80104d28 <sleep+0x178>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104bdc:	81 fe e0 c5 10 80    	cmp    $0x8010c5e0,%esi
80104be2:	74 20                	je     80104c04 <sleep+0x54>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104be4:	83 ec 0c             	sub    $0xc,%esp
80104be7:	68 e0 c5 10 80       	push   $0x8010c5e0
80104bec:	e8 9f 0d 00 00       	call   80105990 <acquire>
    if (lk) release(lk);
80104bf1:	83 c4 10             	add    $0x10,%esp
80104bf4:	85 f6                	test   %esi,%esi
80104bf6:	74 0c                	je     80104c04 <sleep+0x54>
80104bf8:	83 ec 0c             	sub    $0xc,%esp
80104bfb:	56                   	push   %esi
80104bfc:	e8 4f 0e 00 00       	call   80105a50 <release>
80104c01:	83 c4 10             	add    $0x10,%esp
  rc = stateListRemove(&ptable.list[RUNNING],p);
80104c04:	89 d9                	mov    %ebx,%ecx
80104c06:	ba 38 ed 10 80       	mov    $0x8010ed38,%edx
80104c0b:	b8 34 ed 10 80       	mov    $0x8010ed34,%eax
80104c10:	e8 5b ee ff ff       	call   80103a70 <stateListRemove.isra.1>
  if(rc < 0)
80104c15:	85 c0                	test   %eax,%eax
80104c17:	0f 88 18 01 00 00    	js     80104d35 <sleep+0x185>
    if(p->state != state){
80104c1d:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104c21:	0f 85 f4 00 00 00    	jne    80104d1b <sleep+0x16b>
  p->chan = chan;
80104c27:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104c2a:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
    if((*list).head == NULL){
80104c31:	a1 24 ed 10 80       	mov    0x8010ed24,%eax
80104c36:	85 c0                	test   %eax,%eax
80104c38:	0f 84 c2 00 00 00    	je     80104d00 <sleep+0x150>
        ((*list).tail)->next = p;
80104c3e:	a1 28 ed 10 80       	mov    0x8010ed28,%eax
80104c43:	89 98 90 00 00 00    	mov    %ebx,0x90(%eax)
        (*list).tail = ((*list).tail)->next;
80104c49:	a1 28 ed 10 80       	mov    0x8010ed28,%eax
80104c4e:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80104c54:	a3 28 ed 10 80       	mov    %eax,0x8010ed28
        ((*list).tail)->next = NULL;
80104c59:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
80104c60:	00 00 00 
  if(p->priority <= MAXPRIO && p->budget <=0){
80104c63:	8b 93 94 00 00 00    	mov    0x94(%ebx),%edx
  p->budget -= new_ticks; 
80104c69:	8b 83 98 00 00 00    	mov    0x98(%ebx),%eax
80104c6f:	03 83 8c 00 00 00    	add    0x8c(%ebx),%eax
80104c75:	2b 05 20 7d 11 80    	sub    0x80117d20,%eax
80104c7b:	89 83 98 00 00 00    	mov    %eax,0x98(%ebx)
  if(p->priority <= MAXPRIO && p->budget <=0){
80104c81:	83 fa 0a             	cmp    $0xa,%edx
80104c84:	77 5a                	ja     80104ce0 <sleep+0x130>
80104c86:	85 c0                	test   %eax,%eax
80104c88:	75 4e                	jne    80104cd8 <sleep+0x128>
      p->budget = BUDGET;
80104c8a:	c7 83 98 00 00 00 2c 	movl   $0x12c,0x98(%ebx)
80104c91:	01 00 00 
      p->priority -= 1;
80104c94:	83 ea 01             	sub    $0x1,%edx
80104c97:	89 93 94 00 00 00    	mov    %edx,0x94(%ebx)
  sched();
80104c9d:	e8 ae fa ff ff       	call   80104750 <sched>
  p->chan = 0;
80104ca2:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  if(lk != &ptable.lock){  //DOC: sleeplock2
80104ca9:	81 fe e0 c5 10 80    	cmp    $0x8010c5e0,%esi
80104caf:	74 3f                	je     80104cf0 <sleep+0x140>
    release(&ptable.lock);
80104cb1:	83 ec 0c             	sub    $0xc,%esp
80104cb4:	68 e0 c5 10 80       	push   $0x8010c5e0
80104cb9:	e8 92 0d 00 00       	call   80105a50 <release>
    if (lk) acquire(lk);
80104cbe:	83 c4 10             	add    $0x10,%esp
80104cc1:	85 f6                	test   %esi,%esi
80104cc3:	74 2b                	je     80104cf0 <sleep+0x140>
80104cc5:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104cc8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ccb:	5b                   	pop    %ebx
80104ccc:	5e                   	pop    %esi
80104ccd:	5f                   	pop    %edi
80104cce:	5d                   	pop    %ebp
    if (lk) acquire(lk);
80104ccf:	e9 bc 0c 00 00       	jmp    80105990 <acquire>
80104cd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  } else if(p->priority >= MAXPRIO)
80104cd8:	83 fa 0a             	cmp    $0xa,%edx
80104cdb:	75 c0                	jne    80104c9d <sleep+0xed>
80104cdd:	8d 76 00             	lea    0x0(%esi),%esi
      p->priority = MAXPRIO-1;
80104ce0:	c7 83 94 00 00 00 09 	movl   $0x9,0x94(%ebx)
80104ce7:	00 00 00 
80104cea:	eb b1                	jmp    80104c9d <sleep+0xed>
80104cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80104cf0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104cf3:	5b                   	pop    %ebx
80104cf4:	5e                   	pop    %esi
80104cf5:	5f                   	pop    %edi
80104cf6:	5d                   	pop    %ebp
80104cf7:	c3                   	ret    
80104cf8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cff:	90                   	nop
        (*list).head = p;
80104d00:	89 1d 24 ed 10 80    	mov    %ebx,0x8010ed24
        (*list).tail = p;
80104d06:	89 1d 28 ed 10 80    	mov    %ebx,0x8010ed28
        p->next = NULL;
80104d0c:	c7 83 90 00 00 00 00 	movl   $0x0,0x90(%ebx)
80104d13:	00 00 00 
80104d16:	e9 48 ff ff ff       	jmp    80104c63 <sleep+0xb3>
        panic("ASSERT FAILED: proc->state != state");
80104d1b:	83 ec 0c             	sub    $0xc,%esp
80104d1e:	68 08 8d 10 80       	push   $0x80108d08
80104d23:	e8 68 b6 ff ff       	call   80100390 <panic>
    panic("sleep");
80104d28:	83 ec 0c             	sub    $0xc,%esp
80104d2b:	68 fc 8f 10 80       	push   $0x80108ffc
80104d30:	e8 5b b6 ff ff       	call   80100390 <panic>
      panic("\n[RUNNING->SLEEPING]:oh no!! I'm panicking!");
80104d35:	83 ec 0c             	sub    $0xc,%esp
80104d38:	68 80 8e 10 80       	push   $0x80108e80
80104d3d:	e8 4e b6 ff ff       	call   80100390 <panic>
80104d42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104d50 <wait>:
{
80104d50:	55                   	push   %ebp
80104d51:	89 e5                	mov    %esp,%ebp
80104d53:	57                   	push   %edi
            havekids = 1;
80104d54:	bf 01 00 00 00       	mov    $0x1,%edi
{
80104d59:	56                   	push   %esi
80104d5a:	53                   	push   %ebx
80104d5b:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80104d5e:	e8 3d 0b 00 00       	call   801058a0 <pushcli>
  c = mycpu();
80104d63:	e8 08 f1 ff ff       	call   80103e70 <mycpu>
  p = c->proc;
80104d68:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104d6e:	e8 7d 0b 00 00       	call   801058f0 <popcli>
  acquire(&ptable.lock);
80104d73:	83 ec 0c             	sub    $0xc,%esp
80104d76:	68 e0 c5 10 80       	push   $0x8010c5e0
80104d7b:	e8 10 0c 00 00       	call   80105990 <acquire>
80104d80:	83 c4 10             	add    $0x10,%esp
    embryo_p = ptable.list[EMBRYO].head;
80104d83:	a1 1c ed 10 80       	mov    0x8010ed1c,%eax
    havekids = 0;
80104d88:	31 d2                	xor    %edx,%edx
    while(embryo_p){
80104d8a:	85 c0                	test   %eax,%eax
80104d8c:	74 12                	je     80104da0 <wait+0x50>
80104d8e:	66 90                	xchg   %ax,%ax
            havekids = 1;
80104d90:	39 58 14             	cmp    %ebx,0x14(%eax)
        current = embryo_p->next;
80104d93:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
            havekids = 1;
80104d99:	0f 44 d7             	cmove  %edi,%edx
    while(embryo_p){
80104d9c:	85 c0                	test   %eax,%eax
80104d9e:	75 f0                	jne    80104d90 <wait+0x40>
    for(int i=0;i<MAXPRIO+1;++i){
80104da0:	31 c9                	xor    %ecx,%ecx
80104da2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        runnable_p = ptable.ready[i].head;
80104da8:	8b 04 cd 44 ed 10 80 	mov    -0x7fef12bc(,%ecx,8),%eax
        while(runnable_p){
80104daf:	85 c0                	test   %eax,%eax
80104db1:	74 15                	je     80104dc8 <wait+0x78>
80104db3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104db7:	90                   	nop
                havekids = 1;
80104db8:	39 58 14             	cmp    %ebx,0x14(%eax)
            current = runnable_p->next;
80104dbb:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
                havekids = 1;
80104dc1:	0f 44 d7             	cmove  %edi,%edx
        while(runnable_p){
80104dc4:	85 c0                	test   %eax,%eax
80104dc6:	75 f0                	jne    80104db8 <wait+0x68>
    for(int i=0;i<MAXPRIO+1;++i){
80104dc8:	83 c1 01             	add    $0x1,%ecx
80104dcb:	83 f9 0b             	cmp    $0xb,%ecx
80104dce:	75 d8                	jne    80104da8 <wait+0x58>
    running_p = ptable.list[RUNNING].head;
80104dd0:	a1 34 ed 10 80       	mov    0x8010ed34,%eax
    while(running_p){
80104dd5:	85 c0                	test   %eax,%eax
80104dd7:	74 17                	je     80104df0 <wait+0xa0>
80104dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            havekids = 1;
80104de0:	39 58 14             	cmp    %ebx,0x14(%eax)
        current = running_p->next;
80104de3:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
            havekids = 1;
80104de9:	0f 44 d7             	cmove  %edi,%edx
    while(running_p){
80104dec:	85 c0                	test   %eax,%eax
80104dee:	75 f0                	jne    80104de0 <wait+0x90>
    sleeping_p = ptable.list[SLEEPING].head;
80104df0:	a1 24 ed 10 80       	mov    0x8010ed24,%eax
    while(sleeping_p){
80104df5:	85 c0                	test   %eax,%eax
80104df7:	74 17                	je     80104e10 <wait+0xc0>
80104df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            havekids = 1;
80104e00:	39 58 14             	cmp    %ebx,0x14(%eax)
        current = sleeping_p->next;
80104e03:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
            havekids = 1;
80104e09:	0f 44 d7             	cmove  %edi,%edx
    while(sleeping_p){
80104e0c:	85 c0                	test   %eax,%eax
80104e0e:	75 f0                	jne    80104e00 <wait+0xb0>
    zombie_p = ptable.list[ZOMBIE].head;
80104e10:	8b 35 3c ed 10 80    	mov    0x8010ed3c,%esi
    while(zombie_p){
80104e16:	85 f6                	test   %esi,%esi
80104e18:	74 1d                	je     80104e37 <wait+0xe7>
        if(zombie_p->parent == curproc){
80104e1a:	3b 5e 14             	cmp    0x14(%esi),%ebx
80104e1d:	75 0e                	jne    80104e2d <wait+0xdd>
80104e1f:	eb 3f                	jmp    80104e60 <wait+0x110>
80104e21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e28:	39 5e 14             	cmp    %ebx,0x14(%esi)
80104e2b:	74 33                	je     80104e60 <wait+0x110>
        current = zombie_p->next;
80104e2d:	8b b6 90 00 00 00    	mov    0x90(%esi),%esi
    while(zombie_p){
80104e33:	85 f6                	test   %esi,%esi
80104e35:	75 f1                	jne    80104e28 <wait+0xd8>
    if(!havekids || curproc->killed){
80104e37:	85 d2                	test   %edx,%edx
80104e39:	0f 84 e6 00 00 00    	je     80104f25 <wait+0x1d5>
80104e3f:	8b 43 24             	mov    0x24(%ebx),%eax
80104e42:	85 c0                	test   %eax,%eax
80104e44:	0f 85 db 00 00 00    	jne    80104f25 <wait+0x1d5>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104e4a:	83 ec 08             	sub    $0x8,%esp
80104e4d:	68 e0 c5 10 80       	push   $0x8010c5e0
80104e52:	53                   	push   %ebx
80104e53:	e8 58 fd ff ff       	call   80104bb0 <sleep>
    havekids = 0;
80104e58:	83 c4 10             	add    $0x10,%esp
80104e5b:	e9 23 ff ff ff       	jmp    80104d83 <wait+0x33>
            kfree(zombie_p->kstack);
80104e60:	83 ec 0c             	sub    $0xc,%esp
            pid = zombie_p->pid;
80104e63:	8b 5e 10             	mov    0x10(%esi),%ebx
            kfree(zombie_p->kstack);
80104e66:	ff 76 08             	pushl  0x8(%esi)
80104e69:	e8 f2 d8 ff ff       	call   80102760 <kfree>
            zombie_p->kstack = 0;
80104e6e:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
            freevm(zombie_p->pgdir);
80104e75:	59                   	pop    %ecx
80104e76:	ff 76 04             	pushl  0x4(%esi)
80104e79:	e8 e2 35 00 00       	call   80108460 <freevm>
            zombie_p->name[0] = 0;
80104e7e:	c6 46 6c 00          	movb   $0x0,0x6c(%esi)
            rc = stateListRemove(&ptable.list[ZOMBIE],zombie_p);
80104e82:	89 f1                	mov    %esi,%ecx
80104e84:	ba 40 ed 10 80       	mov    $0x8010ed40,%edx
            zombie_p->pid = 0;
80104e89:	c7 46 10 00 00 00 00 	movl   $0x0,0x10(%esi)
            rc = stateListRemove(&ptable.list[ZOMBIE],zombie_p);
80104e90:	b8 3c ed 10 80       	mov    $0x8010ed3c,%eax
            zombie_p->parent = 0;
80104e95:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
            zombie_p->killed = 0;
80104e9c:	c7 46 24 00 00 00 00 	movl   $0x0,0x24(%esi)
            rc = stateListRemove(&ptable.list[ZOMBIE],zombie_p);
80104ea3:	e8 c8 eb ff ff       	call   80103a70 <stateListRemove.isra.1>
            if(rc < 0)
80104ea8:	83 c4 10             	add    $0x10,%esp
80104eab:	85 c0                	test   %eax,%eax
80104ead:	0f 88 89 00 00 00    	js     80104f3c <wait+0x1ec>
    if(p->state != state){
80104eb3:	83 7e 0c 05          	cmpl   $0x5,0xc(%esi)
80104eb7:	0f 85 8c 00 00 00    	jne    80104f49 <wait+0x1f9>
            zombie_p->state = UNUSED;
80104ebd:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    if((*list).head == NULL){
80104ec4:	8b 15 14 ed 10 80    	mov    0x8010ed14,%edx
80104eca:	85 d2                	test   %edx,%edx
80104ecc:	74 3f                	je     80104f0d <wait+0x1bd>
        ((*list).tail)->next = p;
80104ece:	a1 18 ed 10 80       	mov    0x8010ed18,%eax
80104ed3:	89 b0 90 00 00 00    	mov    %esi,0x90(%eax)
        (*list).tail = ((*list).tail)->next;
80104ed9:	a1 18 ed 10 80       	mov    0x8010ed18,%eax
80104ede:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80104ee4:	a3 18 ed 10 80       	mov    %eax,0x8010ed18
        ((*list).tail)->next = NULL;
80104ee9:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
80104ef0:	00 00 00 
            release(&ptable.lock);
80104ef3:	83 ec 0c             	sub    $0xc,%esp
80104ef6:	68 e0 c5 10 80       	push   $0x8010c5e0
80104efb:	e8 50 0b 00 00       	call   80105a50 <release>
            return pid;
80104f00:	89 d8                	mov    %ebx,%eax
80104f02:	83 c4 10             	add    $0x10,%esp
}
80104f05:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f08:	5b                   	pop    %ebx
80104f09:	5e                   	pop    %esi
80104f0a:	5f                   	pop    %edi
80104f0b:	5d                   	pop    %ebp
80104f0c:	c3                   	ret    
        (*list).head = p;
80104f0d:	89 35 14 ed 10 80    	mov    %esi,0x8010ed14
        (*list).tail = p;
80104f13:	89 35 18 ed 10 80    	mov    %esi,0x8010ed18
        p->next = NULL;
80104f19:	c7 86 90 00 00 00 00 	movl   $0x0,0x90(%esi)
80104f20:	00 00 00 
80104f23:	eb ce                	jmp    80104ef3 <wait+0x1a3>
      release(&ptable.lock);
80104f25:	83 ec 0c             	sub    $0xc,%esp
80104f28:	68 e0 c5 10 80       	push   $0x8010c5e0
80104f2d:	e8 1e 0b 00 00       	call   80105a50 <release>
      return -1;
80104f32:	83 c4 10             	add    $0x10,%esp
80104f35:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f3a:	eb c9                	jmp    80104f05 <wait+0x1b5>
                panic("[ZOMBIE->UNUSED]:oh no!! I'm panicking!");
80104f3c:	83 ec 0c             	sub    $0xc,%esp
80104f3f:	68 ac 8e 10 80       	push   $0x80108eac
80104f44:	e8 47 b4 ff ff       	call   80100390 <panic>
        panic("ASSERT FAILED: proc->state != state");
80104f49:	83 ec 0c             	sub    $0xc,%esp
80104f4c:	68 08 8d 10 80       	push   $0x80108d08
80104f51:	e8 3a b4 ff ff       	call   80100390 <panic>
80104f56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f5d:	8d 76 00             	lea    0x0(%esi),%esi

80104f60 <wakeup>:
{
80104f60:	55                   	push   %ebp
80104f61:	89 e5                	mov    %esp,%ebp
80104f63:	53                   	push   %ebx
80104f64:	83 ec 10             	sub    $0x10,%esp
80104f67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80104f6a:	68 e0 c5 10 80       	push   $0x8010c5e0
80104f6f:	e8 1c 0a 00 00       	call   80105990 <acquire>
  wakeup1(chan);
80104f74:	89 d8                	mov    %ebx,%eax
80104f76:	e8 a5 eb ff ff       	call   80103b20 <wakeup1>
  release(&ptable.lock);
80104f7b:	83 c4 10             	add    $0x10,%esp
80104f7e:	c7 45 08 e0 c5 10 80 	movl   $0x8010c5e0,0x8(%ebp)
}
80104f85:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f88:	c9                   	leave  
  release(&ptable.lock);
80104f89:	e9 c2 0a 00 00       	jmp    80105a50 <release>
80104f8e:	66 90                	xchg   %ax,%ax

80104f90 <kill>:
{
80104f90:	55                   	push   %ebp
80104f91:	89 e5                	mov    %esp,%ebp
80104f93:	56                   	push   %esi
80104f94:	53                   	push   %ebx
80104f95:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80104f98:	83 ec 0c             	sub    $0xc,%esp
80104f9b:	68 e0 c5 10 80       	push   $0x8010c5e0
80104fa0:	e8 eb 09 00 00       	call   80105990 <acquire>
  embryo_check = ptable.list[EMBRYO].head;
80104fa5:	a1 1c ed 10 80       	mov    0x8010ed1c,%eax
  while(embryo_check){
80104faa:	83 c4 10             	add    $0x10,%esp
80104fad:	85 c0                	test   %eax,%eax
80104faf:	75 11                	jne    80104fc2 <kill+0x32>
80104fb1:	eb 3d                	jmp    80104ff0 <kill+0x60>
80104fb3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fb7:	90                   	nop
      current = embryo_check->next;
80104fb8:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
  while(embryo_check){
80104fbe:	85 c0                	test   %eax,%eax
80104fc0:	74 2e                	je     80104ff0 <kill+0x60>
      if(embryo_check->pid == pid){
80104fc2:	39 58 10             	cmp    %ebx,0x10(%eax)
80104fc5:	75 f1                	jne    80104fb8 <kill+0x28>
          zombie_check->killed = 1;
80104fc7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  release(&ptable.lock);
80104fce:	83 ec 0c             	sub    $0xc,%esp
80104fd1:	68 e0 c5 10 80       	push   $0x8010c5e0
80104fd6:	e8 75 0a 00 00       	call   80105a50 <release>
  return -1;
80104fdb:	83 c4 10             	add    $0x10,%esp
80104fde:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fe3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104fe6:	5b                   	pop    %ebx
80104fe7:	5e                   	pop    %esi
80104fe8:	5d                   	pop    %ebp
80104fe9:	c3                   	ret    
80104fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while(embryo_check){
80104ff0:	31 d2                	xor    %edx,%edx
      runnable_check = ptable.ready[i].head;
80104ff2:	8b 04 d5 44 ed 10 80 	mov    -0x7fef12bc(,%edx,8),%eax
      while(runnable_check){
80104ff9:	85 c0                	test   %eax,%eax
80104ffb:	74 1a                	je     80105017 <kill+0x87>
          if(runnable_check->pid == pid){
80104ffd:	3b 58 10             	cmp    0x10(%eax),%ebx
80105000:	75 0b                	jne    8010500d <kill+0x7d>
80105002:	eb c3                	jmp    80104fc7 <kill+0x37>
80105004:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105008:	39 58 10             	cmp    %ebx,0x10(%eax)
8010500b:	74 ba                	je     80104fc7 <kill+0x37>
          current = runnable_check->next;
8010500d:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
      while(runnable_check){
80105013:	85 c0                	test   %eax,%eax
80105015:	75 f1                	jne    80105008 <kill+0x78>
  for(int i=0;i<MAXPRIO+1;++i){
80105017:	83 c2 01             	add    $0x1,%edx
8010501a:	83 fa 0b             	cmp    $0xb,%edx
8010501d:	75 d3                	jne    80104ff2 <kill+0x62>
  running_check = ptable.list[RUNNING].head;
8010501f:	a1 34 ed 10 80       	mov    0x8010ed34,%eax
  while(running_check){
80105024:	85 c0                	test   %eax,%eax
80105026:	74 17                	je     8010503f <kill+0xaf>
      if(running_check->pid == pid){
80105028:	3b 58 10             	cmp    0x10(%eax),%ebx
8010502b:	75 08                	jne    80105035 <kill+0xa5>
8010502d:	eb 98                	jmp    80104fc7 <kill+0x37>
8010502f:	90                   	nop
80105030:	39 58 10             	cmp    %ebx,0x10(%eax)
80105033:	74 92                	je     80104fc7 <kill+0x37>
      current = running_check->next;
80105035:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
  while(running_check){
8010503b:	85 c0                	test   %eax,%eax
8010503d:	75 f1                	jne    80105030 <kill+0xa0>
  sleeping_check = ptable.list[SLEEPING].head;
8010503f:	8b 35 24 ed 10 80    	mov    0x8010ed24,%esi
  while(sleeping_check){
80105045:	85 f6                	test   %esi,%esi
80105047:	74 16                	je     8010505f <kill+0xcf>
      if(sleeping_check->pid == pid){
80105049:	3b 5e 10             	cmp    0x10(%esi),%ebx
8010504c:	75 07                	jne    80105055 <kill+0xc5>
8010504e:	eb 38                	jmp    80105088 <kill+0xf8>
80105050:	39 5e 10             	cmp    %ebx,0x10(%esi)
80105053:	74 33                	je     80105088 <kill+0xf8>
      current = sleeping_check->next;
80105055:	8b b6 90 00 00 00    	mov    0x90(%esi),%esi
  while(sleeping_check){
8010505b:	85 f6                	test   %esi,%esi
8010505d:	75 f1                	jne    80105050 <kill+0xc0>
  zombie_check = ptable.list[ZOMBIE].head;
8010505f:	a1 3c ed 10 80       	mov    0x8010ed3c,%eax
  while(zombie_check){
80105064:	85 c0                	test   %eax,%eax
80105066:	75 16                	jne    8010507e <kill+0xee>
80105068:	e9 61 ff ff ff       	jmp    80104fce <kill+0x3e>
8010506d:	8d 76 00             	lea    0x0(%esi),%esi
      current = zombie_check->next;
80105070:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
  while(zombie_check){
80105076:	85 c0                	test   %eax,%eax
80105078:	0f 84 50 ff ff ff    	je     80104fce <kill+0x3e>
      if(zombie_check->pid == pid){
8010507e:	39 58 10             	cmp    %ebx,0x10(%eax)
80105081:	75 ed                	jne    80105070 <kill+0xe0>
80105083:	e9 3f ff ff ff       	jmp    80104fc7 <kill+0x37>
          sleeping_check->killed = 1;
80105088:	c7 46 24 01 00 00 00 	movl   $0x1,0x24(%esi)
          rc = stateListRemove(&ptable.list[SLEEPING],sleeping_check);
8010508f:	89 f1                	mov    %esi,%ecx
80105091:	ba 28 ed 10 80       	mov    $0x8010ed28,%edx
80105096:	b8 24 ed 10 80       	mov    $0x8010ed24,%eax
8010509b:	e8 d0 e9 ff ff       	call   80103a70 <stateListRemove.isra.1>
          if(rc < 0)
801050a0:	85 c0                	test   %eax,%eax
801050a2:	0f 88 82 00 00 00    	js     8010512a <kill+0x19a>
    if(p->state != state){
801050a8:	83 7e 0c 02          	cmpl   $0x2,0xc(%esi)
801050ac:	75 6f                	jne    8010511d <kill+0x18d>
          stateListAdd(&ptable.ready[sleeping_check->priority],sleeping_check);
801050ae:	8b 86 94 00 00 00    	mov    0x94(%esi),%eax
          sleeping_check->state = RUNNABLE;
801050b4:	c7 46 0c 03 00 00 00 	movl   $0x3,0xc(%esi)
          stateListAdd(&ptable.ready[sleeping_check->priority],sleeping_check);
801050bb:	8d 04 c5 64 27 00 00 	lea    0x2764(,%eax,8),%eax
    if((*list).head == NULL){
801050c2:	8b 88 e0 c5 10 80    	mov    -0x7fef3a20(%eax),%ecx
          stateListAdd(&ptable.ready[sleeping_check->priority],sleeping_check);
801050c8:	8d 90 e0 c5 10 80    	lea    -0x7fef3a20(%eax),%edx
    if((*list).head == NULL){
801050ce:	85 c9                	test   %ecx,%ecx
801050d0:	74 36                	je     80105108 <kill+0x178>
        ((*list).tail)->next = p;
801050d2:	8b 42 04             	mov    0x4(%edx),%eax
801050d5:	89 b0 90 00 00 00    	mov    %esi,0x90(%eax)
        (*list).tail = ((*list).tail)->next;
801050db:	8b 42 04             	mov    0x4(%edx),%eax
801050de:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
801050e4:	89 42 04             	mov    %eax,0x4(%edx)
        ((*list).tail)->next = NULL;
801050e7:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
801050ee:	00 00 00 
          release(&ptable.lock);
801050f1:	83 ec 0c             	sub    $0xc,%esp
801050f4:	68 e0 c5 10 80       	push   $0x8010c5e0
801050f9:	e8 52 09 00 00       	call   80105a50 <release>
          return 0;
801050fe:	83 c4 10             	add    $0x10,%esp
80105101:	31 c0                	xor    %eax,%eax
80105103:	e9 db fe ff ff       	jmp    80104fe3 <kill+0x53>
        (*list).head = p;
80105108:	89 b0 e0 c5 10 80    	mov    %esi,-0x7fef3a20(%eax)
        (*list).tail = p;
8010510e:	89 72 04             	mov    %esi,0x4(%edx)
        p->next = NULL;
80105111:	c7 86 90 00 00 00 00 	movl   $0x0,0x90(%esi)
80105118:	00 00 00 
8010511b:	eb d4                	jmp    801050f1 <kill+0x161>
        panic("ASSERT FAILED: proc->state != state");
8010511d:	83 ec 0c             	sub    $0xc,%esp
80105120:	68 08 8d 10 80       	push   $0x80108d08
80105125:	e8 66 b2 ff ff       	call   80100390 <panic>
              panic("[SLEEPING->RUNNABLE]:oh no!! I'm panicking!");
8010512a:	83 ec 0c             	sub    $0xc,%esp
8010512d:	68 d4 8e 10 80       	push   $0x80108ed4
80105132:	e8 59 b2 ff ff       	call   80100390 <panic>
80105137:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010513e:	66 90                	xchg   %ax,%ax

80105140 <procdump>:
{
80105140:	55                   	push   %ebp
80105141:	89 e5                	mov    %esp,%ebp
80105143:	57                   	push   %edi
80105144:	56                   	push   %esi
    cpu_milli_sec = p->cpu_ticks_total%1000;
80105145:	be d3 4d 62 10       	mov    $0x10624dd3,%esi
{
8010514a:	53                   	push   %ebx
8010514b:	bb 80 c6 10 80       	mov    $0x8010c680,%ebx
80105150:	83 ec 48             	sub    $0x48,%esp
  cprintf("PID\tName\tUID\tGID\tPPID\tPrio\tElapsed\t  CPU\tState\tSize\tPCs\n");
80105153:	68 00 8f 10 80       	push   $0x80108f00
80105158:	e8 53 b5 ff ff       	call   801006b0 <cprintf>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010515d:	83 c4 10             	add    $0x10,%esp
80105160:	eb 28                	jmp    8010518a <procdump+0x4a>
80105162:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("\n");
80105168:	83 ec 0c             	sub    $0xc,%esp
8010516b:	68 56 90 10 80       	push   $0x80109056
80105170:	e8 3b b5 ff ff       	call   801006b0 <cprintf>
80105175:	83 c4 10             	add    $0x10,%esp
80105178:	81 c3 9c 00 00 00    	add    $0x9c,%ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010517e:	81 fb 80 ed 10 80    	cmp    $0x8010ed80,%ebx
80105184:	0f 84 d6 00 00 00    	je     80105260 <procdump+0x120>
    if(p->state == UNUSED)
8010518a:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010518d:	85 c0                	test   %eax,%eax
8010518f:	74 e7                	je     80105178 <procdump+0x38>
      state = "???";
80105191:	ba 02 90 10 80       	mov    $0x80109002,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80105196:	83 f8 05             	cmp    $0x5,%eax
80105199:	77 11                	ja     801051ac <procdump+0x6c>
8010519b:	8b 14 85 f8 90 10 80 	mov    -0x7fef6f08(,%eax,4),%edx
      state = "???";
801051a2:	b8 02 90 10 80       	mov    $0x80109002,%eax
801051a7:	85 d2                	test   %edx,%edx
801051a9:	0f 44 d0             	cmove  %eax,%edx
    cpu_sec = p->cpu_ticks_total/1000;
801051ac:	8b 7b 1c             	mov    0x1c(%ebx),%edi
    cprintf("  %d\t%s\t%d\t%d\t%d\t%d\t %d.%d\t %d.%d\t%s %d\t%d\t", p->pid, p->name, p->uid, p->gid, p->parent->pid,p->priority, seconds, m_seconds,cpu_sec, cpu_milli_sec,state, p->sz);
801051af:	83 ec 0c             	sub    $0xc,%esp
    seconds = (ticks-p->start_ticks)/1000; 
801051b2:	8b 0d 20 7d 11 80    	mov    0x80117d20,%ecx
    cprintf("  %d\t%s\t%d\t%d\t%d\t%d\t %d.%d\t %d.%d\t%s %d\t%d\t", p->pid, p->name, p->uid, p->gid, p->parent->pid,p->priority, seconds, m_seconds,cpu_sec, cpu_milli_sec,state, p->sz);
801051b8:	ff 73 94             	pushl  -0x6c(%ebx)
    seconds = (ticks-p->start_ticks)/1000; 
801051bb:	2b 4b 10             	sub    0x10(%ebx),%ecx
    cprintf("  %d\t%s\t%d\t%d\t%d\t%d\t %d.%d\t %d.%d\t%s %d\t%d\t", p->pid, p->name, p->uid, p->gid, p->parent->pid,p->priority, seconds, m_seconds,cpu_sec, cpu_milli_sec,state, p->sz);
801051be:	52                   	push   %edx
    cpu_milli_sec = p->cpu_ticks_total%1000;
801051bf:	89 f8                	mov    %edi,%eax
801051c1:	f7 e6                	mul    %esi
801051c3:	c1 ea 06             	shr    $0x6,%edx
801051c6:	69 c2 e8 03 00 00    	imul   $0x3e8,%edx,%eax
801051cc:	29 c7                	sub    %eax,%edi
    m_seconds = (ticks-p->start_ticks)%1000;
801051ce:	89 c8                	mov    %ecx,%eax
    cprintf("  %d\t%s\t%d\t%d\t%d\t%d\t %d.%d\t %d.%d\t%s %d\t%d\t", p->pid, p->name, p->uid, p->gid, p->parent->pid,p->priority, seconds, m_seconds,cpu_sec, cpu_milli_sec,state, p->sz);
801051d0:	57                   	push   %edi
801051d1:	52                   	push   %edx
    m_seconds = (ticks-p->start_ticks)%1000;
801051d2:	f7 e6                	mul    %esi
801051d4:	c1 ea 06             	shr    $0x6,%edx
801051d7:	69 c2 e8 03 00 00    	imul   $0x3e8,%edx,%eax
801051dd:	29 c1                	sub    %eax,%ecx
    cprintf("  %d\t%s\t%d\t%d\t%d\t%d\t %d.%d\t %d.%d\t%s %d\t%d\t", p->pid, p->name, p->uid, p->gid, p->parent->pid,p->priority, seconds, m_seconds,cpu_sec, cpu_milli_sec,state, p->sz);
801051df:	8b 43 a8             	mov    -0x58(%ebx),%eax
801051e2:	51                   	push   %ecx
801051e3:	52                   	push   %edx
801051e4:	ff 73 28             	pushl  0x28(%ebx)
801051e7:	ff 70 10             	pushl  0x10(%eax)
801051ea:	ff 73 14             	pushl  0x14(%ebx)
801051ed:	ff 73 18             	pushl  0x18(%ebx)
801051f0:	53                   	push   %ebx
801051f1:	ff 73 a4             	pushl  -0x5c(%ebx)
801051f4:	68 3c 8f 10 80       	push   $0x80108f3c
801051f9:	e8 b2 b4 ff ff       	call   801006b0 <cprintf>
    if(p->state == SLEEPING){
801051fe:	83 c4 40             	add    $0x40,%esp
80105201:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80105205:	0f 85 5d ff ff ff    	jne    80105168 <procdump+0x28>
      getcallerpcs((uint*)p->context->ebp+2, pc);
8010520b:	83 ec 08             	sub    $0x8,%esp
8010520e:	8d 45 c0             	lea    -0x40(%ebp),%eax
80105211:	8d 7d c0             	lea    -0x40(%ebp),%edi
80105214:	50                   	push   %eax
80105215:	8b 43 b0             	mov    -0x50(%ebx),%eax
80105218:	8b 40 0c             	mov    0xc(%eax),%eax
8010521b:	83 c0 08             	add    $0x8,%eax
8010521e:	50                   	push   %eax
8010521f:	e8 2c 06 00 00       	call   80105850 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80105224:	83 c4 10             	add    $0x10,%esp
80105227:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010522e:	66 90                	xchg   %ax,%ax
80105230:	8b 07                	mov    (%edi),%eax
80105232:	85 c0                	test   %eax,%eax
80105234:	0f 84 2e ff ff ff    	je     80105168 <procdump+0x28>
        cprintf(" %p", pc[i]);
8010523a:	83 ec 08             	sub    $0x8,%esp
8010523d:	83 c7 04             	add    $0x4,%edi
80105240:	50                   	push   %eax
80105241:	68 a1 87 10 80       	push   $0x801087a1
80105246:	e8 65 b4 ff ff       	call   801006b0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
8010524b:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010524e:	83 c4 10             	add    $0x10,%esp
80105251:	39 f8                	cmp    %edi,%eax
80105253:	75 db                	jne    80105230 <procdump+0xf0>
80105255:	e9 0e ff ff ff       	jmp    80105168 <procdump+0x28>
8010525a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
80105260:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105263:	5b                   	pop    %ebx
80105264:	5e                   	pop    %esi
80105265:	5f                   	pop    %edi
80105266:	5d                   	pop    %ebp
80105267:	c3                   	ret    
80105268:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010526f:	90                   	nop

80105270 <getprocs>:
getprocs(uint max, struct uproc * table){
80105270:	55                   	push   %ebp
80105271:	89 e5                	mov    %esp,%ebp
80105273:	57                   	push   %edi
    int count = 0;
80105274:	31 ff                	xor    %edi,%edi
getprocs(uint max, struct uproc * table){
80105276:	56                   	push   %esi
80105277:	53                   	push   %ebx
    for(p = ptable.proc; p < &ptable.proc[NPROC] && count < max; ++p){
80105278:	bb 14 c6 10 80       	mov    $0x8010c614,%ebx
getprocs(uint max, struct uproc * table){
8010527d:	83 ec 18             	sub    $0x18,%esp
    acquire(&ptable.lock);
80105280:	68 e0 c5 10 80       	push   $0x8010c5e0
80105285:	e8 06 07 00 00       	call   80105990 <acquire>
8010528a:	83 c4 10             	add    $0x10,%esp
8010528d:	eb 5e                	jmp    801052ed <getprocs+0x7d>
8010528f:	90                   	nop
                table[count].ppid = p -> parent -> pid;
80105290:	8b 40 10             	mov    0x10(%eax),%eax
80105293:	89 46 0c             	mov    %eax,0xc(%esi)
            table[count].elapsed_ticks = ticks - p->start_ticks;
80105296:	a1 20 7d 11 80       	mov    0x80117d20,%eax
            safestrcpy(table[count].state, states[p->state], sizeof(table[count].state));
8010529b:	83 ec 04             	sub    $0x4,%esp
            ++count;
8010529e:	83 c7 01             	add    $0x1,%edi
            table[count].elapsed_ticks = ticks - p->start_ticks;
801052a1:	2b 43 7c             	sub    0x7c(%ebx),%eax
801052a4:	89 46 14             	mov    %eax,0x14(%esi)
            table[count].CPU_total_ticks = p->cpu_ticks_total;
801052a7:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
801052ad:	89 46 18             	mov    %eax,0x18(%esi)
            safestrcpy(table[count].state, states[p->state], sizeof(table[count].state));
801052b0:	8b 43 0c             	mov    0xc(%ebx),%eax
801052b3:	6a 20                	push   $0x20
801052b5:	ff 34 85 f8 90 10 80 	pushl  -0x7fef6f08(,%eax,4)
801052bc:	8d 46 1c             	lea    0x1c(%esi),%eax
801052bf:	50                   	push   %eax
801052c0:	e8 ab 09 00 00       	call   80105c70 <safestrcpy>
            table[count].size = p->sz;
801052c5:	8b 03                	mov    (%ebx),%eax
            safestrcpy(table[count].name, p->name, sizeof(table[count].name));
801052c7:	83 c4 0c             	add    $0xc,%esp
801052ca:	8d 56 40             	lea    0x40(%esi),%edx
            table[count].size = p->sz;
801052cd:	89 46 3c             	mov    %eax,0x3c(%esi)
            safestrcpy(table[count].name, p->name, sizeof(table[count].name));
801052d0:	8d 43 6c             	lea    0x6c(%ebx),%eax
801052d3:	6a 20                	push   $0x20
801052d5:	50                   	push   %eax
801052d6:	52                   	push   %edx
801052d7:	e8 94 09 00 00       	call   80105c70 <safestrcpy>
            ++count;
801052dc:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC] && count < max; ++p){
801052df:	81 c3 9c 00 00 00    	add    $0x9c,%ebx
801052e5:	81 fb 14 ed 10 80    	cmp    $0x8010ed14,%ebx
801052eb:	74 4b                	je     80105338 <getprocs+0xc8>
        if(max < count)
801052ed:	3b 7d 08             	cmp    0x8(%ebp),%edi
801052f0:	73 46                	jae    80105338 <getprocs+0xc8>
        if(p->state == RUNNABLE || p->state == RUNNING || p->state == SLEEPING){
801052f2:	8b 43 0c             	mov    0xc(%ebx),%eax
801052f5:	83 e8 02             	sub    $0x2,%eax
801052f8:	83 f8 02             	cmp    $0x2,%eax
801052fb:	77 e2                	ja     801052df <getprocs+0x6f>
            table[count].pid = p->pid;
801052fd:	8b 43 10             	mov    0x10(%ebx),%eax
80105300:	8d 14 7f             	lea    (%edi,%edi,2),%edx
80105303:	c1 e2 05             	shl    $0x5,%edx
80105306:	03 55 0c             	add    0xc(%ebp),%edx
80105309:	89 02                	mov    %eax,(%edx)
            table[count].gid = p->gid;
8010530b:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
            table[count].pid = p->pid;
80105311:	89 d6                	mov    %edx,%esi
            table[count].gid = p->gid;
80105313:	89 42 08             	mov    %eax,0x8(%edx)
            table[count].uid = p->uid;
80105316:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
8010531c:	89 42 04             	mov    %eax,0x4(%edx)
            if(p -> parent == 0){
8010531f:	8b 43 14             	mov    0x14(%ebx),%eax
80105322:	85 c0                	test   %eax,%eax
80105324:	0f 85 66 ff ff ff    	jne    80105290 <getprocs+0x20>
                table[count].ppid = p->pid;
8010532a:	8b 43 10             	mov    0x10(%ebx),%eax
8010532d:	e9 61 ff ff ff       	jmp    80105293 <getprocs+0x23>
80105332:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&ptable.lock);
80105338:	83 ec 0c             	sub    $0xc,%esp
8010533b:	68 e0 c5 10 80       	push   $0x8010c5e0
80105340:	e8 0b 07 00 00       	call   80105a50 <release>
}
80105345:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105348:	89 f8                	mov    %edi,%eax
8010534a:	5b                   	pop    %ebx
8010534b:	5e                   	pop    %esi
8010534c:	5f                   	pop    %edi
8010534d:	5d                   	pop    %ebp
8010534e:	c3                   	ret    
8010534f:	90                   	nop

80105350 <control_f>:
}


void
control_f()
{
80105350:	55                   	push   %ebp
80105351:	31 d2                	xor    %edx,%edx
80105353:	89 e5                	mov    %esp,%ebp
80105355:	83 ec 08             	sub    $0x8,%esp
    int counter = 0;
    struct proc * free_ptr = ptable.list[UNUSED].head; 
80105358:	a1 14 ed 10 80       	mov    0x8010ed14,%eax


    if(!free_ptr){
8010535d:	85 c0                	test   %eax,%eax
8010535f:	74 2f                	je     80105390 <control_f+0x40>
80105361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return;
    }

    while(free_ptr){
        counter += 1;
        free_ptr = free_ptr->next;
80105368:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
        counter += 1;
8010536e:	83 c2 01             	add    $0x1,%edx
    while(free_ptr){
80105371:	85 c0                	test   %eax,%eax
80105373:	75 f3                	jne    80105368 <control_f+0x18>
    }

    cprintf("Free List:\t%d Processes",counter,'\n');
80105375:	83 ec 04             	sub    $0x4,%esp
80105378:	6a 0a                	push   $0xa
8010537a:	52                   	push   %edx
8010537b:	68 1a 90 10 80       	push   $0x8010901a
80105380:	e8 2b b3 ff ff       	call   801006b0 <cprintf>
80105385:	83 c4 10             	add    $0x10,%esp
}
80105388:	c9                   	leave  
80105389:	c3                   	ret    
8010538a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cprintf("Free List is empty!",'\n');
80105390:	83 ec 08             	sub    $0x8,%esp
80105393:	6a 0a                	push   $0xa
80105395:	68 06 90 10 80       	push   $0x80109006
8010539a:	e8 11 b3 ff ff       	call   801006b0 <cprintf>
        return;
8010539f:	83 c4 10             	add    $0x10,%esp
}
801053a2:	c9                   	leave  
801053a3:	c3                   	ret    
801053a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801053ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801053af:	90                   	nop

801053b0 <control_r>:

void
control_r()
{
801053b0:	55                   	push   %ebp
801053b1:	89 e5                	mov    %esp,%ebp
801053b3:	56                   	push   %esi
    struct proc * ready_ptr;

    if(ptable.ready){
        cprintf("Number of Queues:%d\n",MAXPRIO);
        for(int i=MAXPRIO;i>=0;--i){
801053b4:	be 0a 00 00 00       	mov    $0xa,%esi
{
801053b9:	53                   	push   %ebx
        cprintf("Number of Queues:%d\n",MAXPRIO);
801053ba:	83 ec 08             	sub    $0x8,%esp
801053bd:	6a 0a                	push   $0xa
801053bf:	68 32 90 10 80       	push   $0x80109032
801053c4:	e8 e7 b2 ff ff       	call   801006b0 <cprintf>
801053c9:	83 c4 10             	add    $0x10,%esp
801053cc:	eb 1a                	jmp    801053e8 <control_r+0x38>
801053ce:	66 90                	xchg   %ax,%ax
            ready_ptr = ptable.ready[i].head;
            if(ready_ptr == NULL){
                cprintf("Queue is empty!\n");
801053d0:	83 ec 0c             	sub    $0xc,%esp
        for(int i=MAXPRIO;i>=0;--i){
801053d3:	83 ee 01             	sub    $0x1,%esi
                cprintf("Queue is empty!\n");
801053d6:	68 47 90 10 80       	push   $0x80109047
801053db:	e8 d0 b2 ff ff       	call   801006b0 <cprintf>
801053e0:	83 c4 10             	add    $0x10,%esp
        for(int i=MAXPRIO;i>=0;--i){
801053e3:	83 fe ff             	cmp    $0xffffffff,%esi
801053e6:	74 71                	je     80105459 <control_r+0xa9>
            ready_ptr = ptable.ready[i].head;
801053e8:	8b 1c f5 44 ed 10 80 	mov    -0x7fef12bc(,%esi,8),%ebx
            if(ready_ptr == NULL){
801053ef:	85 db                	test   %ebx,%ebx
801053f1:	74 dd                	je     801053d0 <control_r+0x20>
            }else{
            cprintf("Queue #%d:\t",i);
801053f3:	83 ec 08             	sub    $0x8,%esp
801053f6:	56                   	push   %esi
801053f7:	68 58 90 10 80       	push   $0x80109058
801053fc:	e8 af b2 ff ff       	call   801006b0 <cprintf>
            while(ready_ptr->next != NULL){
80105401:	8b 93 90 00 00 00    	mov    0x90(%ebx),%edx
80105407:	83 c4 10             	add    $0x10,%esp
8010540a:	85 d2                	test   %edx,%edx
8010540c:	74 2b                	je     80105439 <control_r+0x89>
8010540e:	66 90                	xchg   %ax,%ax
                cprintf("(%d,%d) ->",ready_ptr->pid,ready_ptr->budget);
80105410:	83 ec 04             	sub    $0x4,%esp
80105413:	ff b3 98 00 00 00    	pushl  0x98(%ebx)
80105419:	ff 73 10             	pushl  0x10(%ebx)
8010541c:	68 64 90 10 80       	push   $0x80109064
80105421:	e8 8a b2 ff ff       	call   801006b0 <cprintf>
                ready_ptr = ready_ptr->next;
80105426:	8b 9b 90 00 00 00    	mov    0x90(%ebx),%ebx
            while(ready_ptr->next != NULL){
8010542c:	83 c4 10             	add    $0x10,%esp
8010542f:	8b 83 90 00 00 00    	mov    0x90(%ebx),%eax
80105435:	85 c0                	test   %eax,%eax
80105437:	75 d7                	jne    80105410 <control_r+0x60>
            }
            }if(ready_ptr)
                cprintf("(%d,%d) ->",ready_ptr->pid,ready_ptr->budget,'\n');
80105439:	6a 0a                	push   $0xa
        for(int i=MAXPRIO;i>=0;--i){
8010543b:	83 ee 01             	sub    $0x1,%esi
                cprintf("(%d,%d) ->",ready_ptr->pid,ready_ptr->budget,'\n');
8010543e:	ff b3 98 00 00 00    	pushl  0x98(%ebx)
80105444:	ff 73 10             	pushl  0x10(%ebx)
80105447:	68 64 90 10 80       	push   $0x80109064
8010544c:	e8 5f b2 ff ff       	call   801006b0 <cprintf>
80105451:	83 c4 10             	add    $0x10,%esp
        for(int i=MAXPRIO;i>=0;--i){
80105454:	83 fe ff             	cmp    $0xffffffff,%esi
80105457:	75 8f                	jne    801053e8 <control_r+0x38>
        }
    }
}
80105459:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010545c:	5b                   	pop    %ebx
8010545d:	5e                   	pop    %esi
8010545e:	5d                   	pop    %ebp
8010545f:	c3                   	ret    

80105460 <control_s>:

void
control_s()
{
80105460:	55                   	push   %ebp
80105461:	89 e5                	mov    %esp,%ebp
80105463:	53                   	push   %ebx
80105464:	83 ec 04             	sub    $0x4,%esp
    struct proc * sleep_ptr = ptable.list[SLEEPING].head;
80105467:	8b 1d 24 ed 10 80    	mov    0x8010ed24,%ebx

    if(!sleep_ptr){
8010546d:	85 db                	test   %ebx,%ebx
8010546f:	74 67                	je     801054d8 <control_s+0x78>
        cprintf("Sleep List is empty!\n");
        return;
    }

    cprintf("Sleep List:\t");
80105471:	83 ec 0c             	sub    $0xc,%esp
80105474:	68 85 90 10 80       	push   $0x80109085
80105479:	e8 32 b2 ff ff       	call   801006b0 <cprintf>
8010547e:	83 c4 10             	add    $0x10,%esp
80105481:	eb 22                	jmp    801054a5 <control_s+0x45>
80105483:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105487:	90                   	nop
    while(sleep_ptr){
        if(sleep_ptr->next)
            cprintf("%d ->",sleep_ptr->pid,'\n');
80105488:	83 ec 04             	sub    $0x4,%esp
8010548b:	6a 0a                	push   $0xa
8010548d:	50                   	push   %eax
8010548e:	68 92 90 10 80       	push   $0x80109092
80105493:	e8 18 b2 ff ff       	call   801006b0 <cprintf>
        else
            cprintf("%d->",sleep_ptr->pid,'\n');
        sleep_ptr = sleep_ptr->next;
80105498:	8b 9b 90 00 00 00    	mov    0x90(%ebx),%ebx
8010549e:	83 c4 10             	add    $0x10,%esp
    while(sleep_ptr){
801054a1:	85 db                	test   %ebx,%ebx
801054a3:	74 2a                	je     801054cf <control_s+0x6f>
        if(sleep_ptr->next)
801054a5:	8b 93 90 00 00 00    	mov    0x90(%ebx),%edx
801054ab:	8b 43 10             	mov    0x10(%ebx),%eax
801054ae:	85 d2                	test   %edx,%edx
801054b0:	75 d6                	jne    80105488 <control_s+0x28>
            cprintf("%d->",sleep_ptr->pid,'\n');
801054b2:	83 ec 04             	sub    $0x4,%esp
801054b5:	6a 0a                	push   $0xa
801054b7:	50                   	push   %eax
801054b8:	68 98 90 10 80       	push   $0x80109098
801054bd:	e8 ee b1 ff ff       	call   801006b0 <cprintf>
        sleep_ptr = sleep_ptr->next;
801054c2:	8b 9b 90 00 00 00    	mov    0x90(%ebx),%ebx
            cprintf("%d->",sleep_ptr->pid,'\n');
801054c8:	83 c4 10             	add    $0x10,%esp
    while(sleep_ptr){
801054cb:	85 db                	test   %ebx,%ebx
801054cd:	75 d6                	jne    801054a5 <control_s+0x45>
    }
}
801054cf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801054d2:	c9                   	leave  
801054d3:	c3                   	ret    
801054d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf("Sleep List is empty!\n");
801054d8:	83 ec 0c             	sub    $0xc,%esp
801054db:	68 6f 90 10 80       	push   $0x8010906f
801054e0:	e8 cb b1 ff ff       	call   801006b0 <cprintf>
        return;
801054e5:	83 c4 10             	add    $0x10,%esp
}
801054e8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801054eb:	c9                   	leave  
801054ec:	c3                   	ret    
801054ed:	8d 76 00             	lea    0x0(%esi),%esi

801054f0 <control_z>:

void
control_z()
{
801054f0:	55                   	push   %ebp
801054f1:	89 e5                	mov    %esp,%ebp
801054f3:	53                   	push   %ebx
801054f4:	83 ec 04             	sub    $0x4,%esp
    struct proc * zombie_ptr = ptable.list[ZOMBIE].head;
801054f7:	8b 1d 3c ed 10 80    	mov    0x8010ed3c,%ebx

    if(!zombie_ptr){
801054fd:	85 db                	test   %ebx,%ebx
801054ff:	74 3f                	je     80105540 <control_z+0x50>
        cprintf("Zombie List is empty!\n");
        return;
    }

    cprintf("Zombie List:\t");
80105501:	83 ec 0c             	sub    $0xc,%esp
80105504:	68 b4 90 10 80       	push   $0x801090b4
80105509:	e8 a2 b1 ff ff       	call   801006b0 <cprintf>
8010550e:	83 c4 10             	add    $0x10,%esp
80105511:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(zombie_ptr){
        if(zombie_ptr->next)
            cprintf("(%d,%d)->",zombie_ptr->pid,zombie_ptr->parent->pid,'\n');
        else
            cprintf("(%d,%d)->",zombie_ptr->pid,zombie_ptr->parent->pid,'\n');
80105518:	6a 0a                	push   $0xa
8010551a:	8b 43 14             	mov    0x14(%ebx),%eax
8010551d:	ff 70 10             	pushl  0x10(%eax)
80105520:	ff 73 10             	pushl  0x10(%ebx)
80105523:	68 c2 90 10 80       	push   $0x801090c2
80105528:	e8 83 b1 ff ff       	call   801006b0 <cprintf>
        zombie_ptr = zombie_ptr->next;
8010552d:	8b 9b 90 00 00 00    	mov    0x90(%ebx),%ebx
    while(zombie_ptr){
80105533:	83 c4 10             	add    $0x10,%esp
80105536:	85 db                	test   %ebx,%ebx
80105538:	75 de                	jne    80105518 <control_z+0x28>
    }
}
8010553a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010553d:	c9                   	leave  
8010553e:	c3                   	ret    
8010553f:	90                   	nop
        cprintf("Zombie List is empty!\n");
80105540:	83 ec 0c             	sub    $0xc,%esp
80105543:	68 9d 90 10 80       	push   $0x8010909d
80105548:	e8 63 b1 ff ff       	call   801006b0 <cprintf>
        return;
8010554d:	83 c4 10             	add    $0x10,%esp
}
80105550:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105553:	c9                   	leave  
80105554:	c3                   	ret    
80105555:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010555c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105560 <setpriority>:
    }
    return 0;
}
int
setpriority(int pid,int priority)
{
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
80105563:	57                   	push   %edi
80105564:	56                   	push   %esi
80105565:	53                   	push   %ebx
80105566:	83 ec 0c             	sub    $0xc,%esp
80105569:	8b 75 08             	mov    0x8(%ebp),%esi
8010556c:	8b 7d 0c             	mov    0xc(%ebp),%edi
    struct proc * current;
    struct proc * sleeping_cur;
    struct proc * running_cur;
    if(pid < 0 || pid > NPROC)
8010556f:	83 fe 40             	cmp    $0x40,%esi
80105572:	0f 87 40 01 00 00    	ja     801056b8 <setpriority+0x158>
        return -1;
    if(priority < 0 || priority > MAXPRIO)
80105578:	83 ff 0a             	cmp    $0xa,%edi
8010557b:	0f 87 37 01 00 00    	ja     801056b8 <setpriority+0x158>
        return -1;
    acquire(&ptable.lock);
80105581:	83 ec 0c             	sub    $0xc,%esp
80105584:	68 e0 c5 10 80       	push   $0x8010c5e0
80105589:	e8 02 04 00 00       	call   80105990 <acquire>
8010558e:	83 c4 10             	add    $0x10,%esp
    for(int i=0;i<MAXPRIO+1;++i){
80105591:	31 c0                	xor    %eax,%eax
        current = ptable.ready[i].head;
80105593:	8b 1c c5 44 ed 10 80 	mov    -0x7fef12bc(,%eax,8),%ebx
        while(current){
8010559a:	85 db                	test   %ebx,%ebx
8010559c:	75 18                	jne    801055b6 <setpriority+0x56>
8010559e:	e9 9d 00 00 00       	jmp    80105640 <setpriority+0xe0>
801055a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801055a7:	90                   	nop
                assertState(current,RUNNABLE);
                stateListAdd(&ptable.ready[current->priority],current);
                release(&ptable.lock);
                return 0;
            }
            current = current->next;
801055a8:	8b 9b 90 00 00 00    	mov    0x90(%ebx),%ebx
        while(current){
801055ae:	85 db                	test   %ebx,%ebx
801055b0:	0f 84 8a 00 00 00    	je     80105640 <setpriority+0xe0>
            if(current->pid == pid){
801055b6:	3b 73 10             	cmp    0x10(%ebx),%esi
801055b9:	75 ed                	jne    801055a8 <setpriority+0x48>
                stateListRemove(&ptable.ready[current->priority],current);
801055bb:	8b 83 94 00 00 00    	mov    0x94(%ebx),%eax
801055c1:	89 d9                	mov    %ebx,%ecx
801055c3:	8d 04 c5 44 ed 10 80 	lea    -0x7fef12bc(,%eax,8),%eax
801055ca:	8d 50 04             	lea    0x4(%eax),%edx
801055cd:	e8 9e e4 ff ff       	call   80103a70 <stateListRemove.isra.1>
    if(p->state != state){
801055d2:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
                current->priority = priority;
801055d6:	89 bb 94 00 00 00    	mov    %edi,0x94(%ebx)
                current->budget = BUDGET;
801055dc:	c7 83 98 00 00 00 2c 	movl   $0x12c,0x98(%ebx)
801055e3:	01 00 00 
    if(p->state != state){
801055e6:	0f 85 d6 00 00 00    	jne    801056c2 <setpriority+0x162>
                stateListAdd(&ptable.ready[current->priority],current);
801055ec:	8d 14 fd 64 27 00 00 	lea    0x2764(,%edi,8),%edx
    if((*list).head == NULL){
801055f3:	8b 8a e0 c5 10 80    	mov    -0x7fef3a20(%edx),%ecx
                stateListAdd(&ptable.ready[current->priority],current);
801055f9:	8d 82 e0 c5 10 80    	lea    -0x7fef3a20(%edx),%eax
    if((*list).head == NULL){
801055ff:	85 c9                	test   %ecx,%ecx
80105601:	0f 84 99 00 00 00    	je     801056a0 <setpriority+0x140>
        ((*list).tail)->next = p;
80105607:	8b 50 04             	mov    0x4(%eax),%edx
8010560a:	89 9a 90 00 00 00    	mov    %ebx,0x90(%edx)
        (*list).tail = ((*list).tail)->next;
80105610:	8b 50 04             	mov    0x4(%eax),%edx
80105613:	8b 92 90 00 00 00    	mov    0x90(%edx),%edx
80105619:	89 50 04             	mov    %edx,0x4(%eax)
        ((*list).tail)->next = NULL;
8010561c:	c7 82 90 00 00 00 00 	movl   $0x0,0x90(%edx)
80105623:	00 00 00 
            release(&ptable.lock);
80105626:	83 ec 0c             	sub    $0xc,%esp
80105629:	68 e0 c5 10 80       	push   $0x8010c5e0
8010562e:	e8 1d 04 00 00       	call   80105a50 <release>
80105633:	83 c4 10             	add    $0x10,%esp
            return 0;
    }
    if(ptable.list[RUNNING].head){
        running_cur = ptable.list[RUNNING].head;
        if(findProc(running_cur,pid,priority) == 1)
            return 0;
80105636:	31 c0                	xor    %eax,%eax
    }
    release(&ptable.lock);
    return 0;

}
80105638:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010563b:	5b                   	pop    %ebx
8010563c:	5e                   	pop    %esi
8010563d:	5f                   	pop    %edi
8010563e:	5d                   	pop    %ebp
8010563f:	c3                   	ret    
    for(int i=0;i<MAXPRIO+1;++i){
80105640:	83 c0 01             	add    $0x1,%eax
80105643:	83 f8 0b             	cmp    $0xb,%eax
80105646:	0f 85 47 ff ff ff    	jne    80105593 <setpriority+0x33>
    if(ptable.list[SLEEPING].head){
8010564c:	a1 24 ed 10 80       	mov    0x8010ed24,%eax
80105651:	85 c0                	test   %eax,%eax
80105653:	74 12                	je     80105667 <setpriority+0x107>
80105655:	8d 76 00             	lea    0x0(%esi),%esi
        if(p->pid == pid){
80105658:	3b 70 10             	cmp    0x10(%eax),%esi
8010565b:	74 2a                	je     80105687 <setpriority+0x127>
        p = p->next;
8010565d:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
    while(p){
80105663:	85 c0                	test   %eax,%eax
80105665:	75 f1                	jne    80105658 <setpriority+0xf8>
    if(ptable.list[RUNNING].head){
80105667:	a1 34 ed 10 80       	mov    0x8010ed34,%eax
8010566c:	85 c0                	test   %eax,%eax
8010566e:	75 12                	jne    80105682 <setpriority+0x122>
80105670:	eb b4                	jmp    80105626 <setpriority+0xc6>
80105672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        p = p->next;
80105678:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
    while(p){
8010567e:	85 c0                	test   %eax,%eax
80105680:	74 a4                	je     80105626 <setpriority+0xc6>
        if(p->pid == pid){
80105682:	3b 70 10             	cmp    0x10(%eax),%esi
80105685:	75 f1                	jne    80105678 <setpriority+0x118>
            p->priority = priority;
80105687:	89 b8 94 00 00 00    	mov    %edi,0x94(%eax)
            p->budget = BUDGET;
8010568d:	c7 80 98 00 00 00 2c 	movl   $0x12c,0x98(%eax)
80105694:	01 00 00 
80105697:	eb 8d                	jmp    80105626 <setpriority+0xc6>
80105699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        (*list).head = p;
801056a0:	89 9a e0 c5 10 80    	mov    %ebx,-0x7fef3a20(%edx)
        (*list).tail = p;
801056a6:	89 58 04             	mov    %ebx,0x4(%eax)
        p->next = NULL;
801056a9:	c7 83 90 00 00 00 00 	movl   $0x0,0x90(%ebx)
801056b0:	00 00 00 
801056b3:	e9 6e ff ff ff       	jmp    80105626 <setpriority+0xc6>
        return -1;
801056b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056bd:	e9 76 ff ff ff       	jmp    80105638 <setpriority+0xd8>
        panic("ASSERT FAILED: proc->state != state");
801056c2:	83 ec 0c             	sub    $0xc,%esp
801056c5:	68 08 8d 10 80       	push   $0x80108d08
801056ca:	e8 c1 ac ff ff       	call   80100390 <panic>
801056cf:	90                   	nop

801056d0 <getpriority>:
int
getpriority(int pid)
{
801056d0:	55                   	push   %ebp
    struct proc * current;
    if(pid < 0 || pid > NPROC)
        return 0;
801056d1:	31 c0                	xor    %eax,%eax
{
801056d3:	89 e5                	mov    %esp,%ebp
801056d5:	8b 55 08             	mov    0x8(%ebp),%edx
    if(pid < 0 || pid > NPROC)
801056d8:	83 fa 40             	cmp    $0x40,%edx
801056db:	77 28                	ja     80105705 <getpriority+0x35>
    for(int i=0;i<MAXPRIO+1;++i){
801056dd:	31 c9                	xor    %ecx,%ecx
        current = ptable.ready[i].head;
801056df:	8b 04 cd 44 ed 10 80 	mov    -0x7fef12bc(,%ecx,8),%eax
        while(current){
801056e6:	85 c0                	test   %eax,%eax
801056e8:	75 10                	jne    801056fa <getpriority+0x2a>
801056ea:	eb 24                	jmp    80105710 <getpriority+0x40>
801056ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            if(current->pid == pid)
                return current->priority;
            current = current->next;
801056f0:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
        while(current){
801056f6:	85 c0                	test   %eax,%eax
801056f8:	74 16                	je     80105710 <getpriority+0x40>
            if(current->pid == pid)
801056fa:	3b 50 10             	cmp    0x10(%eax),%edx
801056fd:	75 f1                	jne    801056f0 <getpriority+0x20>
                return current->priority;
801056ff:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
        }
    }
    return -1;
}
80105705:	5d                   	pop    %ebp
80105706:	c3                   	ret    
80105707:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010570e:	66 90                	xchg   %ax,%ax
    for(int i=0;i<MAXPRIO+1;++i){
80105710:	83 c1 01             	add    $0x1,%ecx
80105713:	83 f9 0b             	cmp    $0xb,%ecx
80105716:	75 c7                	jne    801056df <getpriority+0xf>
    return -1;
80105718:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010571d:	5d                   	pop    %ebp
8010571e:	c3                   	ret    
8010571f:	90                   	nop

80105720 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80105720:	55                   	push   %ebp
80105721:	89 e5                	mov    %esp,%ebp
80105723:	53                   	push   %ebx
80105724:	83 ec 0c             	sub    $0xc,%esp
80105727:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010572a:	68 10 91 10 80       	push   $0x80109110
8010572f:	8d 43 04             	lea    0x4(%ebx),%eax
80105732:	50                   	push   %eax
80105733:	e8 f8 00 00 00       	call   80105830 <initlock>
  lk->name = name;
80105738:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010573b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80105741:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80105744:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010574b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010574e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105751:	c9                   	leave  
80105752:	c3                   	ret    
80105753:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010575a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105760 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80105760:	55                   	push   %ebp
80105761:	89 e5                	mov    %esp,%ebp
80105763:	56                   	push   %esi
80105764:	53                   	push   %ebx
80105765:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105768:	8d 73 04             	lea    0x4(%ebx),%esi
8010576b:	83 ec 0c             	sub    $0xc,%esp
8010576e:	56                   	push   %esi
8010576f:	e8 1c 02 00 00       	call   80105990 <acquire>
  while (lk->locked) {
80105774:	8b 13                	mov    (%ebx),%edx
80105776:	83 c4 10             	add    $0x10,%esp
80105779:	85 d2                	test   %edx,%edx
8010577b:	74 16                	je     80105793 <acquiresleep+0x33>
8010577d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80105780:	83 ec 08             	sub    $0x8,%esp
80105783:	56                   	push   %esi
80105784:	53                   	push   %ebx
80105785:	e8 26 f4 ff ff       	call   80104bb0 <sleep>
  while (lk->locked) {
8010578a:	8b 03                	mov    (%ebx),%eax
8010578c:	83 c4 10             	add    $0x10,%esp
8010578f:	85 c0                	test   %eax,%eax
80105791:	75 ed                	jne    80105780 <acquiresleep+0x20>
  }
  lk->locked = 1;
80105793:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80105799:	e8 72 e7 ff ff       	call   80103f10 <myproc>
8010579e:	8b 40 10             	mov    0x10(%eax),%eax
801057a1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801057a4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801057a7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801057aa:	5b                   	pop    %ebx
801057ab:	5e                   	pop    %esi
801057ac:	5d                   	pop    %ebp
  release(&lk->lk);
801057ad:	e9 9e 02 00 00       	jmp    80105a50 <release>
801057b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801057c0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
801057c3:	56                   	push   %esi
801057c4:	53                   	push   %ebx
801057c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801057c8:	8d 73 04             	lea    0x4(%ebx),%esi
801057cb:	83 ec 0c             	sub    $0xc,%esp
801057ce:	56                   	push   %esi
801057cf:	e8 bc 01 00 00       	call   80105990 <acquire>
  lk->locked = 0;
801057d4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801057da:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801057e1:	89 1c 24             	mov    %ebx,(%esp)
801057e4:	e8 77 f7 ff ff       	call   80104f60 <wakeup>
  release(&lk->lk);
801057e9:	89 75 08             	mov    %esi,0x8(%ebp)
801057ec:	83 c4 10             	add    $0x10,%esp
}
801057ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801057f2:	5b                   	pop    %ebx
801057f3:	5e                   	pop    %esi
801057f4:	5d                   	pop    %ebp
  release(&lk->lk);
801057f5:	e9 56 02 00 00       	jmp    80105a50 <release>
801057fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105800 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80105800:	55                   	push   %ebp
80105801:	89 e5                	mov    %esp,%ebp
80105803:	56                   	push   %esi
80105804:	53                   	push   %ebx
80105805:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
80105808:	8d 5e 04             	lea    0x4(%esi),%ebx
8010580b:	83 ec 0c             	sub    $0xc,%esp
8010580e:	53                   	push   %ebx
8010580f:	e8 7c 01 00 00       	call   80105990 <acquire>
  r = lk->locked;
80105814:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
80105816:	89 1c 24             	mov    %ebx,(%esp)
80105819:	e8 32 02 00 00       	call   80105a50 <release>
  return r;
}
8010581e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105821:	89 f0                	mov    %esi,%eax
80105823:	5b                   	pop    %ebx
80105824:	5e                   	pop    %esi
80105825:	5d                   	pop    %ebp
80105826:	c3                   	ret    
80105827:	66 90                	xchg   %ax,%ax
80105829:	66 90                	xchg   %ax,%ax
8010582b:	66 90                	xchg   %ax,%ax
8010582d:	66 90                	xchg   %ax,%ax
8010582f:	90                   	nop

80105830 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105830:	55                   	push   %ebp
80105831:	89 e5                	mov    %esp,%ebp
80105833:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80105836:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80105839:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010583f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80105842:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105849:	5d                   	pop    %ebp
8010584a:	c3                   	ret    
8010584b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010584f:	90                   	nop

80105850 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105850:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105851:	31 d2                	xor    %edx,%edx
{
80105853:	89 e5                	mov    %esp,%ebp
80105855:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80105856:	8b 45 08             	mov    0x8(%ebp),%eax
{
80105859:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010585c:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
8010585f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105860:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105866:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010586c:	77 1a                	ja     80105888 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010586e:	8b 58 04             	mov    0x4(%eax),%ebx
80105871:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80105874:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105877:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105879:	83 fa 0a             	cmp    $0xa,%edx
8010587c:	75 e2                	jne    80105860 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010587e:	5b                   	pop    %ebx
8010587f:	5d                   	pop    %ebp
80105880:	c3                   	ret    
80105881:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105888:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010588b:	8d 51 28             	lea    0x28(%ecx),%edx
8010588e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105890:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105896:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105899:	39 c2                	cmp    %eax,%edx
8010589b:	75 f3                	jne    80105890 <getcallerpcs+0x40>
}
8010589d:	5b                   	pop    %ebx
8010589e:	5d                   	pop    %ebp
8010589f:	c3                   	ret    

801058a0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
801058a3:	53                   	push   %ebx
801058a4:	83 ec 04             	sub    $0x4,%esp
801058a7:	9c                   	pushf  
801058a8:	5b                   	pop    %ebx
  asm volatile("cli");
801058a9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801058aa:	e8 c1 e5 ff ff       	call   80103e70 <mycpu>
801058af:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801058b5:	85 c0                	test   %eax,%eax
801058b7:	74 17                	je     801058d0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
801058b9:	e8 b2 e5 ff ff       	call   80103e70 <mycpu>
801058be:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801058c5:	83 c4 04             	add    $0x4,%esp
801058c8:	5b                   	pop    %ebx
801058c9:	5d                   	pop    %ebp
801058ca:	c3                   	ret    
801058cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801058cf:	90                   	nop
    mycpu()->intena = eflags & FL_IF;
801058d0:	e8 9b e5 ff ff       	call   80103e70 <mycpu>
801058d5:	81 e3 00 02 00 00    	and    $0x200,%ebx
801058db:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
801058e1:	eb d6                	jmp    801058b9 <pushcli+0x19>
801058e3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801058f0 <popcli>:

void
popcli(void)
{
801058f0:	55                   	push   %ebp
801058f1:	89 e5                	mov    %esp,%ebp
801058f3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801058f6:	9c                   	pushf  
801058f7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801058f8:	f6 c4 02             	test   $0x2,%ah
801058fb:	75 35                	jne    80105932 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801058fd:	e8 6e e5 ff ff       	call   80103e70 <mycpu>
80105902:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80105909:	78 34                	js     8010593f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010590b:	e8 60 e5 ff ff       	call   80103e70 <mycpu>
80105910:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105916:	85 d2                	test   %edx,%edx
80105918:	74 06                	je     80105920 <popcli+0x30>
    sti();
}
8010591a:	c9                   	leave  
8010591b:	c3                   	ret    
8010591c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105920:	e8 4b e5 ff ff       	call   80103e70 <mycpu>
80105925:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010592b:	85 c0                	test   %eax,%eax
8010592d:	74 eb                	je     8010591a <popcli+0x2a>
  asm volatile("sti");
8010592f:	fb                   	sti    
}
80105930:	c9                   	leave  
80105931:	c3                   	ret    
    panic("popcli - interruptible");
80105932:	83 ec 0c             	sub    $0xc,%esp
80105935:	68 1b 91 10 80       	push   $0x8010911b
8010593a:	e8 51 aa ff ff       	call   80100390 <panic>
    panic("popcli");
8010593f:	83 ec 0c             	sub    $0xc,%esp
80105942:	68 32 91 10 80       	push   $0x80109132
80105947:	e8 44 aa ff ff       	call   80100390 <panic>
8010594c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105950 <holding>:
{
80105950:	55                   	push   %ebp
80105951:	89 e5                	mov    %esp,%ebp
80105953:	56                   	push   %esi
80105954:	53                   	push   %ebx
80105955:	8b 75 08             	mov    0x8(%ebp),%esi
80105958:	31 db                	xor    %ebx,%ebx
  pushcli();
8010595a:	e8 41 ff ff ff       	call   801058a0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010595f:	8b 06                	mov    (%esi),%eax
80105961:	85 c0                	test   %eax,%eax
80105963:	75 0b                	jne    80105970 <holding+0x20>
  popcli();
80105965:	e8 86 ff ff ff       	call   801058f0 <popcli>
}
8010596a:	89 d8                	mov    %ebx,%eax
8010596c:	5b                   	pop    %ebx
8010596d:	5e                   	pop    %esi
8010596e:	5d                   	pop    %ebp
8010596f:	c3                   	ret    
  r = lock->locked && lock->cpu == mycpu();
80105970:	8b 5e 08             	mov    0x8(%esi),%ebx
80105973:	e8 f8 e4 ff ff       	call   80103e70 <mycpu>
80105978:	39 c3                	cmp    %eax,%ebx
8010597a:	0f 94 c3             	sete   %bl
  popcli();
8010597d:	e8 6e ff ff ff       	call   801058f0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80105982:	0f b6 db             	movzbl %bl,%ebx
}
80105985:	89 d8                	mov    %ebx,%eax
80105987:	5b                   	pop    %ebx
80105988:	5e                   	pop    %esi
80105989:	5d                   	pop    %ebp
8010598a:	c3                   	ret    
8010598b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010598f:	90                   	nop

80105990 <acquire>:
{
80105990:	55                   	push   %ebp
80105991:	89 e5                	mov    %esp,%ebp
80105993:	56                   	push   %esi
80105994:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80105995:	e8 06 ff ff ff       	call   801058a0 <pushcli>
  if(holding(lk))
8010599a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010599d:	83 ec 0c             	sub    $0xc,%esp
801059a0:	53                   	push   %ebx
801059a1:	e8 aa ff ff ff       	call   80105950 <holding>
801059a6:	83 c4 10             	add    $0x10,%esp
801059a9:	85 c0                	test   %eax,%eax
801059ab:	0f 85 83 00 00 00    	jne    80105a34 <acquire+0xa4>
801059b1:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
801059b3:	ba 01 00 00 00       	mov    $0x1,%edx
801059b8:	eb 09                	jmp    801059c3 <acquire+0x33>
801059ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801059c0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801059c3:	89 d0                	mov    %edx,%eax
801059c5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
801059c8:	85 c0                	test   %eax,%eax
801059ca:	75 f4                	jne    801059c0 <acquire+0x30>
  __sync_synchronize();
801059cc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801059d1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801059d4:	e8 97 e4 ff ff       	call   80103e70 <mycpu>
801059d9:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801059dc:	89 e8                	mov    %ebp,%eax
801059de:	66 90                	xchg   %ax,%ax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801059e0:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
801059e6:	81 fa fe ff ff 7f    	cmp    $0x7ffffffe,%edx
801059ec:	77 22                	ja     80105a10 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
801059ee:	8b 50 04             	mov    0x4(%eax),%edx
801059f1:	89 54 b3 0c          	mov    %edx,0xc(%ebx,%esi,4)
  for(i = 0; i < 10; i++){
801059f5:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
801059f8:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801059fa:	83 fe 0a             	cmp    $0xa,%esi
801059fd:	75 e1                	jne    801059e0 <acquire+0x50>
}
801059ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a02:	5b                   	pop    %ebx
80105a03:	5e                   	pop    %esi
80105a04:	5d                   	pop    %ebp
80105a05:	c3                   	ret    
80105a06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a0d:	8d 76 00             	lea    0x0(%esi),%esi
80105a10:	8d 44 b3 0c          	lea    0xc(%ebx,%esi,4),%eax
80105a14:	83 c3 34             	add    $0x34,%ebx
80105a17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a1e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105a20:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105a26:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105a29:	39 d8                	cmp    %ebx,%eax
80105a2b:	75 f3                	jne    80105a20 <acquire+0x90>
}
80105a2d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a30:	5b                   	pop    %ebx
80105a31:	5e                   	pop    %esi
80105a32:	5d                   	pop    %ebp
80105a33:	c3                   	ret    
    panic("acquire");
80105a34:	83 ec 0c             	sub    $0xc,%esp
80105a37:	68 39 91 10 80       	push   $0x80109139
80105a3c:	e8 4f a9 ff ff       	call   80100390 <panic>
80105a41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a4f:	90                   	nop

80105a50 <release>:
{
80105a50:	55                   	push   %ebp
80105a51:	89 e5                	mov    %esp,%ebp
80105a53:	53                   	push   %ebx
80105a54:	83 ec 10             	sub    $0x10,%esp
80105a57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80105a5a:	53                   	push   %ebx
80105a5b:	e8 f0 fe ff ff       	call   80105950 <holding>
80105a60:	83 c4 10             	add    $0x10,%esp
80105a63:	85 c0                	test   %eax,%eax
80105a65:	74 22                	je     80105a89 <release+0x39>
  lk->pcs[0] = 0;
80105a67:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105a6e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105a75:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80105a7a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105a80:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a83:	c9                   	leave  
  popcli();
80105a84:	e9 67 fe ff ff       	jmp    801058f0 <popcli>
    panic("release");
80105a89:	83 ec 0c             	sub    $0xc,%esp
80105a8c:	68 41 91 10 80       	push   $0x80109141
80105a91:	e8 fa a8 ff ff       	call   80100390 <panic>
80105a96:	66 90                	xchg   %ax,%ax
80105a98:	66 90                	xchg   %ax,%ax
80105a9a:	66 90                	xchg   %ax,%ax
80105a9c:	66 90                	xchg   %ax,%ax
80105a9e:	66 90                	xchg   %ax,%ax

80105aa0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105aa0:	55                   	push   %ebp
80105aa1:	89 e5                	mov    %esp,%ebp
80105aa3:	57                   	push   %edi
80105aa4:	8b 55 08             	mov    0x8(%ebp),%edx
80105aa7:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105aaa:	53                   	push   %ebx
  if ((int)dst%4 == 0 && n%4 == 0){
80105aab:	89 d0                	mov    %edx,%eax
80105aad:	09 c8                	or     %ecx,%eax
80105aaf:	a8 03                	test   $0x3,%al
80105ab1:	75 2d                	jne    80105ae0 <memset+0x40>
    c &= 0xFF;
80105ab3:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105ab7:	c1 e9 02             	shr    $0x2,%ecx
80105aba:	89 f8                	mov    %edi,%eax
80105abc:	89 fb                	mov    %edi,%ebx
80105abe:	c1 e0 18             	shl    $0x18,%eax
80105ac1:	c1 e3 10             	shl    $0x10,%ebx
80105ac4:	09 d8                	or     %ebx,%eax
80105ac6:	09 f8                	or     %edi,%eax
80105ac8:	c1 e7 08             	shl    $0x8,%edi
80105acb:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80105acd:	89 d7                	mov    %edx,%edi
80105acf:	fc                   	cld    
80105ad0:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80105ad2:	5b                   	pop    %ebx
80105ad3:	89 d0                	mov    %edx,%eax
80105ad5:	5f                   	pop    %edi
80105ad6:	5d                   	pop    %ebp
80105ad7:	c3                   	ret    
80105ad8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105adf:	90                   	nop
  asm volatile("cld; rep stosb" :
80105ae0:	89 d7                	mov    %edx,%edi
80105ae2:	8b 45 0c             	mov    0xc(%ebp),%eax
80105ae5:	fc                   	cld    
80105ae6:	f3 aa                	rep stos %al,%es:(%edi)
80105ae8:	5b                   	pop    %ebx
80105ae9:	89 d0                	mov    %edx,%eax
80105aeb:	5f                   	pop    %edi
80105aec:	5d                   	pop    %ebp
80105aed:	c3                   	ret    
80105aee:	66 90                	xchg   %ax,%ax

80105af0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105af0:	55                   	push   %ebp
80105af1:	89 e5                	mov    %esp,%ebp
80105af3:	56                   	push   %esi
80105af4:	8b 75 10             	mov    0x10(%ebp),%esi
80105af7:	8b 45 08             	mov    0x8(%ebp),%eax
80105afa:	53                   	push   %ebx
80105afb:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105afe:	85 f6                	test   %esi,%esi
80105b00:	74 22                	je     80105b24 <memcmp+0x34>
    if(*s1 != *s2)
80105b02:	0f b6 08             	movzbl (%eax),%ecx
80105b05:	0f b6 1a             	movzbl (%edx),%ebx
80105b08:	01 c6                	add    %eax,%esi
80105b0a:	38 cb                	cmp    %cl,%bl
80105b0c:	74 0c                	je     80105b1a <memcmp+0x2a>
80105b0e:	eb 20                	jmp    80105b30 <memcmp+0x40>
80105b10:	0f b6 08             	movzbl (%eax),%ecx
80105b13:	0f b6 1a             	movzbl (%edx),%ebx
80105b16:	38 d9                	cmp    %bl,%cl
80105b18:	75 16                	jne    80105b30 <memcmp+0x40>
      return *s1 - *s2;
    s1++, s2++;
80105b1a:	83 c0 01             	add    $0x1,%eax
80105b1d:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80105b20:	39 c6                	cmp    %eax,%esi
80105b22:	75 ec                	jne    80105b10 <memcmp+0x20>
  }

  return 0;
}
80105b24:	5b                   	pop    %ebx
  return 0;
80105b25:	31 c0                	xor    %eax,%eax
}
80105b27:	5e                   	pop    %esi
80105b28:	5d                   	pop    %ebp
80105b29:	c3                   	ret    
80105b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      return *s1 - *s2;
80105b30:	0f b6 c1             	movzbl %cl,%eax
80105b33:	29 d8                	sub    %ebx,%eax
}
80105b35:	5b                   	pop    %ebx
80105b36:	5e                   	pop    %esi
80105b37:	5d                   	pop    %ebp
80105b38:	c3                   	ret    
80105b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105b40 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105b40:	55                   	push   %ebp
80105b41:	89 e5                	mov    %esp,%ebp
80105b43:	57                   	push   %edi
80105b44:	8b 45 08             	mov    0x8(%ebp),%eax
80105b47:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105b4a:	56                   	push   %esi
80105b4b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105b4e:	39 c6                	cmp    %eax,%esi
80105b50:	73 26                	jae    80105b78 <memmove+0x38>
80105b52:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80105b55:	39 f8                	cmp    %edi,%eax
80105b57:	73 1f                	jae    80105b78 <memmove+0x38>
80105b59:	8d 51 ff             	lea    -0x1(%ecx),%edx
    s += n;
    d += n;
    while(n-- > 0)
80105b5c:	85 c9                	test   %ecx,%ecx
80105b5e:	74 0f                	je     80105b6f <memmove+0x2f>
      *--d = *--s;
80105b60:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80105b64:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80105b67:	83 ea 01             	sub    $0x1,%edx
80105b6a:	83 fa ff             	cmp    $0xffffffff,%edx
80105b6d:	75 f1                	jne    80105b60 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80105b6f:	5e                   	pop    %esi
80105b70:	5f                   	pop    %edi
80105b71:	5d                   	pop    %ebp
80105b72:	c3                   	ret    
80105b73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b77:	90                   	nop
80105b78:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
    while(n-- > 0)
80105b7b:	89 c7                	mov    %eax,%edi
80105b7d:	85 c9                	test   %ecx,%ecx
80105b7f:	74 ee                	je     80105b6f <memmove+0x2f>
80105b81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80105b88:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80105b89:	39 d6                	cmp    %edx,%esi
80105b8b:	75 fb                	jne    80105b88 <memmove+0x48>
}
80105b8d:	5e                   	pop    %esi
80105b8e:	5f                   	pop    %edi
80105b8f:	5d                   	pop    %ebp
80105b90:	c3                   	ret    
80105b91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b9f:	90                   	nop

80105ba0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80105ba0:	eb 9e                	jmp    80105b40 <memmove>
80105ba2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105bb0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80105bb0:	55                   	push   %ebp
80105bb1:	89 e5                	mov    %esp,%ebp
80105bb3:	57                   	push   %edi
80105bb4:	8b 7d 10             	mov    0x10(%ebp),%edi
80105bb7:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105bba:	56                   	push   %esi
80105bbb:	8b 75 0c             	mov    0xc(%ebp),%esi
80105bbe:	53                   	push   %ebx
  while(n > 0 && *p && *p == *q)
80105bbf:	85 ff                	test   %edi,%edi
80105bc1:	74 2f                	je     80105bf2 <strncmp+0x42>
80105bc3:	0f b6 11             	movzbl (%ecx),%edx
80105bc6:	0f b6 1e             	movzbl (%esi),%ebx
80105bc9:	84 d2                	test   %dl,%dl
80105bcb:	74 37                	je     80105c04 <strncmp+0x54>
80105bcd:	38 da                	cmp    %bl,%dl
80105bcf:	75 33                	jne    80105c04 <strncmp+0x54>
80105bd1:	01 f7                	add    %esi,%edi
80105bd3:	eb 13                	jmp    80105be8 <strncmp+0x38>
80105bd5:	8d 76 00             	lea    0x0(%esi),%esi
80105bd8:	0f b6 11             	movzbl (%ecx),%edx
80105bdb:	84 d2                	test   %dl,%dl
80105bdd:	74 21                	je     80105c00 <strncmp+0x50>
80105bdf:	0f b6 18             	movzbl (%eax),%ebx
80105be2:	89 c6                	mov    %eax,%esi
80105be4:	38 da                	cmp    %bl,%dl
80105be6:	75 1c                	jne    80105c04 <strncmp+0x54>
    n--, p++, q++;
80105be8:	8d 46 01             	lea    0x1(%esi),%eax
80105beb:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80105bee:	39 f8                	cmp    %edi,%eax
80105bf0:	75 e6                	jne    80105bd8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80105bf2:	5b                   	pop    %ebx
    return 0;
80105bf3:	31 c0                	xor    %eax,%eax
}
80105bf5:	5e                   	pop    %esi
80105bf6:	5f                   	pop    %edi
80105bf7:	5d                   	pop    %ebp
80105bf8:	c3                   	ret    
80105bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c00:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80105c04:	0f b6 c2             	movzbl %dl,%eax
80105c07:	29 d8                	sub    %ebx,%eax
}
80105c09:	5b                   	pop    %ebx
80105c0a:	5e                   	pop    %esi
80105c0b:	5f                   	pop    %edi
80105c0c:	5d                   	pop    %ebp
80105c0d:	c3                   	ret    
80105c0e:	66 90                	xchg   %ax,%ax

80105c10 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105c10:	55                   	push   %ebp
80105c11:	89 e5                	mov    %esp,%ebp
80105c13:	57                   	push   %edi
80105c14:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80105c17:	8b 4d 08             	mov    0x8(%ebp),%ecx
{
80105c1a:	56                   	push   %esi
80105c1b:	53                   	push   %ebx
80105c1c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  while(n-- > 0 && (*s++ = *t++) != 0)
80105c1f:	eb 1a                	jmp    80105c3b <strncpy+0x2b>
80105c21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c28:	83 c2 01             	add    $0x1,%edx
80105c2b:	0f b6 42 ff          	movzbl -0x1(%edx),%eax
80105c2f:	83 c1 01             	add    $0x1,%ecx
80105c32:	88 41 ff             	mov    %al,-0x1(%ecx)
80105c35:	84 c0                	test   %al,%al
80105c37:	74 09                	je     80105c42 <strncpy+0x32>
80105c39:	89 fb                	mov    %edi,%ebx
80105c3b:	8d 7b ff             	lea    -0x1(%ebx),%edi
80105c3e:	85 db                	test   %ebx,%ebx
80105c40:	7f e6                	jg     80105c28 <strncpy+0x18>
    ;
  while(n-- > 0)
80105c42:	89 ce                	mov    %ecx,%esi
80105c44:	85 ff                	test   %edi,%edi
80105c46:	7e 1b                	jle    80105c63 <strncpy+0x53>
80105c48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c4f:	90                   	nop
    *s++ = 0;
80105c50:	83 c6 01             	add    $0x1,%esi
80105c53:	c6 46 ff 00          	movb   $0x0,-0x1(%esi)
80105c57:	89 f2                	mov    %esi,%edx
80105c59:	f7 d2                	not    %edx
80105c5b:	01 ca                	add    %ecx,%edx
80105c5d:	01 da                	add    %ebx,%edx
  while(n-- > 0)
80105c5f:	85 d2                	test   %edx,%edx
80105c61:	7f ed                	jg     80105c50 <strncpy+0x40>
  return os;
}
80105c63:	5b                   	pop    %ebx
80105c64:	8b 45 08             	mov    0x8(%ebp),%eax
80105c67:	5e                   	pop    %esi
80105c68:	5f                   	pop    %edi
80105c69:	5d                   	pop    %ebp
80105c6a:	c3                   	ret    
80105c6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c6f:	90                   	nop

80105c70 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105c70:	55                   	push   %ebp
80105c71:	89 e5                	mov    %esp,%ebp
80105c73:	56                   	push   %esi
80105c74:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105c77:	8b 45 08             	mov    0x8(%ebp),%eax
80105c7a:	53                   	push   %ebx
80105c7b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80105c7e:	85 c9                	test   %ecx,%ecx
80105c80:	7e 26                	jle    80105ca8 <safestrcpy+0x38>
80105c82:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105c86:	89 c1                	mov    %eax,%ecx
80105c88:	eb 17                	jmp    80105ca1 <safestrcpy+0x31>
80105c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105c90:	83 c2 01             	add    $0x1,%edx
80105c93:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80105c97:	83 c1 01             	add    $0x1,%ecx
80105c9a:	88 59 ff             	mov    %bl,-0x1(%ecx)
80105c9d:	84 db                	test   %bl,%bl
80105c9f:	74 04                	je     80105ca5 <safestrcpy+0x35>
80105ca1:	39 f2                	cmp    %esi,%edx
80105ca3:	75 eb                	jne    80105c90 <safestrcpy+0x20>
    ;
  *s = 0;
80105ca5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105ca8:	5b                   	pop    %ebx
80105ca9:	5e                   	pop    %esi
80105caa:	5d                   	pop    %ebp
80105cab:	c3                   	ret    
80105cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105cb0 <strlen>:

int
strlen(const char *s)
{
80105cb0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105cb1:	31 c0                	xor    %eax,%eax
{
80105cb3:	89 e5                	mov    %esp,%ebp
80105cb5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105cb8:	80 3a 00             	cmpb   $0x0,(%edx)
80105cbb:	74 0c                	je     80105cc9 <strlen+0x19>
80105cbd:	8d 76 00             	lea    0x0(%esi),%esi
80105cc0:	83 c0 01             	add    $0x1,%eax
80105cc3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105cc7:	75 f7                	jne    80105cc0 <strlen+0x10>
    ;
  return n;
}
80105cc9:	5d                   	pop    %ebp
80105cca:	c3                   	ret    

80105ccb <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80105ccb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80105ccf:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80105cd3:	55                   	push   %ebp
  pushl %ebx
80105cd4:	53                   	push   %ebx
  pushl %esi
80105cd5:	56                   	push   %esi
  pushl %edi
80105cd6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105cd7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105cd9:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
80105cdb:	5f                   	pop    %edi
  popl %esi
80105cdc:	5e                   	pop    %esi
  popl %ebx
80105cdd:	5b                   	pop    %ebx
  popl %ebp
80105cde:	5d                   	pop    %ebp
  ret
80105cdf:	c3                   	ret    

80105ce0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105ce0:	55                   	push   %ebp
80105ce1:	89 e5                	mov    %esp,%ebp
80105ce3:	53                   	push   %ebx
80105ce4:	83 ec 04             	sub    $0x4,%esp
80105ce7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80105cea:	e8 21 e2 ff ff       	call   80103f10 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105cef:	8b 00                	mov    (%eax),%eax
80105cf1:	39 d8                	cmp    %ebx,%eax
80105cf3:	76 1b                	jbe    80105d10 <fetchint+0x30>
80105cf5:	8d 53 04             	lea    0x4(%ebx),%edx
80105cf8:	39 d0                	cmp    %edx,%eax
80105cfa:	72 14                	jb     80105d10 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80105cfc:	8b 45 0c             	mov    0xc(%ebp),%eax
80105cff:	8b 13                	mov    (%ebx),%edx
80105d01:	89 10                	mov    %edx,(%eax)
  return 0;
80105d03:	31 c0                	xor    %eax,%eax
}
80105d05:	83 c4 04             	add    $0x4,%esp
80105d08:	5b                   	pop    %ebx
80105d09:	5d                   	pop    %ebp
80105d0a:	c3                   	ret    
80105d0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d0f:	90                   	nop
    return -1;
80105d10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d15:	eb ee                	jmp    80105d05 <fetchint+0x25>
80105d17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d1e:	66 90                	xchg   %ax,%ax

80105d20 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105d20:	55                   	push   %ebp
80105d21:	89 e5                	mov    %esp,%ebp
80105d23:	53                   	push   %ebx
80105d24:	83 ec 04             	sub    $0x4,%esp
80105d27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80105d2a:	e8 e1 e1 ff ff       	call   80103f10 <myproc>

  if(addr >= curproc->sz)
80105d2f:	39 18                	cmp    %ebx,(%eax)
80105d31:	76 29                	jbe    80105d5c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80105d33:	8b 55 0c             	mov    0xc(%ebp),%edx
80105d36:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80105d38:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80105d3a:	39 d3                	cmp    %edx,%ebx
80105d3c:	73 1e                	jae    80105d5c <fetchstr+0x3c>
    if(*s == 0)
80105d3e:	80 3b 00             	cmpb   $0x0,(%ebx)
80105d41:	74 35                	je     80105d78 <fetchstr+0x58>
80105d43:	89 d8                	mov    %ebx,%eax
80105d45:	eb 0e                	jmp    80105d55 <fetchstr+0x35>
80105d47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d4e:	66 90                	xchg   %ax,%ax
80105d50:	80 38 00             	cmpb   $0x0,(%eax)
80105d53:	74 1b                	je     80105d70 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80105d55:	83 c0 01             	add    $0x1,%eax
80105d58:	39 c2                	cmp    %eax,%edx
80105d5a:	77 f4                	ja     80105d50 <fetchstr+0x30>
    return -1;
80105d5c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80105d61:	83 c4 04             	add    $0x4,%esp
80105d64:	5b                   	pop    %ebx
80105d65:	5d                   	pop    %ebp
80105d66:	c3                   	ret    
80105d67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d6e:	66 90                	xchg   %ax,%ax
80105d70:	83 c4 04             	add    $0x4,%esp
80105d73:	29 d8                	sub    %ebx,%eax
80105d75:	5b                   	pop    %ebx
80105d76:	5d                   	pop    %ebp
80105d77:	c3                   	ret    
    if(*s == 0)
80105d78:	31 c0                	xor    %eax,%eax
      return s - *pp;
80105d7a:	eb e5                	jmp    80105d61 <fetchstr+0x41>
80105d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d80 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105d80:	55                   	push   %ebp
80105d81:	89 e5                	mov    %esp,%ebp
80105d83:	56                   	push   %esi
80105d84:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105d85:	e8 86 e1 ff ff       	call   80103f10 <myproc>
80105d8a:	8b 55 08             	mov    0x8(%ebp),%edx
80105d8d:	8b 40 18             	mov    0x18(%eax),%eax
80105d90:	8b 40 44             	mov    0x44(%eax),%eax
80105d93:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105d96:	e8 75 e1 ff ff       	call   80103f10 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105d9b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105d9e:	8b 00                	mov    (%eax),%eax
80105da0:	39 c6                	cmp    %eax,%esi
80105da2:	73 1c                	jae    80105dc0 <argint+0x40>
80105da4:	8d 53 08             	lea    0x8(%ebx),%edx
80105da7:	39 d0                	cmp    %edx,%eax
80105da9:	72 15                	jb     80105dc0 <argint+0x40>
  *ip = *(int*)(addr);
80105dab:	8b 45 0c             	mov    0xc(%ebp),%eax
80105dae:	8b 53 04             	mov    0x4(%ebx),%edx
80105db1:	89 10                	mov    %edx,(%eax)
  return 0;
80105db3:	31 c0                	xor    %eax,%eax
}
80105db5:	5b                   	pop    %ebx
80105db6:	5e                   	pop    %esi
80105db7:	5d                   	pop    %ebp
80105db8:	c3                   	ret    
80105db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105dc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105dc5:	eb ee                	jmp    80105db5 <argint+0x35>
80105dc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dce:	66 90                	xchg   %ax,%ax

80105dd0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105dd0:	55                   	push   %ebp
80105dd1:	89 e5                	mov    %esp,%ebp
80105dd3:	56                   	push   %esi
80105dd4:	53                   	push   %ebx
80105dd5:	83 ec 10             	sub    $0x10,%esp
80105dd8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80105ddb:	e8 30 e1 ff ff       	call   80103f10 <myproc>

  if(argint(n, &i) < 0)
80105de0:	83 ec 08             	sub    $0x8,%esp
  struct proc *curproc = myproc();
80105de3:	89 c6                	mov    %eax,%esi
  if(argint(n, &i) < 0)
80105de5:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105de8:	50                   	push   %eax
80105de9:	ff 75 08             	pushl  0x8(%ebp)
80105dec:	e8 8f ff ff ff       	call   80105d80 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105df1:	83 c4 10             	add    $0x10,%esp
80105df4:	85 c0                	test   %eax,%eax
80105df6:	78 28                	js     80105e20 <argptr+0x50>
80105df8:	85 db                	test   %ebx,%ebx
80105dfa:	78 24                	js     80105e20 <argptr+0x50>
80105dfc:	8b 16                	mov    (%esi),%edx
80105dfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e01:	39 c2                	cmp    %eax,%edx
80105e03:	76 1b                	jbe    80105e20 <argptr+0x50>
80105e05:	01 c3                	add    %eax,%ebx
80105e07:	39 da                	cmp    %ebx,%edx
80105e09:	72 15                	jb     80105e20 <argptr+0x50>
    return -1;
  *pp = (char*)i;
80105e0b:	8b 55 0c             	mov    0xc(%ebp),%edx
80105e0e:	89 02                	mov    %eax,(%edx)
  return 0;
80105e10:	31 c0                	xor    %eax,%eax
}
80105e12:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105e15:	5b                   	pop    %ebx
80105e16:	5e                   	pop    %esi
80105e17:	5d                   	pop    %ebp
80105e18:	c3                   	ret    
80105e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105e20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e25:	eb eb                	jmp    80105e12 <argptr+0x42>
80105e27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e2e:	66 90                	xchg   %ax,%ax

80105e30 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105e30:	55                   	push   %ebp
80105e31:	89 e5                	mov    %esp,%ebp
80105e33:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105e36:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e39:	50                   	push   %eax
80105e3a:	ff 75 08             	pushl  0x8(%ebp)
80105e3d:	e8 3e ff ff ff       	call   80105d80 <argint>
80105e42:	83 c4 10             	add    $0x10,%esp
80105e45:	85 c0                	test   %eax,%eax
80105e47:	78 17                	js     80105e60 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80105e49:	83 ec 08             	sub    $0x8,%esp
80105e4c:	ff 75 0c             	pushl  0xc(%ebp)
80105e4f:	ff 75 f4             	pushl  -0xc(%ebp)
80105e52:	e8 c9 fe ff ff       	call   80105d20 <fetchstr>
80105e57:	83 c4 10             	add    $0x10,%esp
}
80105e5a:	c9                   	leave  
80105e5b:	c3                   	ret    
80105e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e60:	c9                   	leave  
    return -1;
80105e61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e66:	c3                   	ret    
80105e67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e6e:	66 90                	xchg   %ax,%ax

80105e70 <syscall>:
#endif // PRINT_SYSCALLS


void
syscall(void)
{
80105e70:	55                   	push   %ebp
80105e71:	89 e5                	mov    %esp,%ebp
80105e73:	53                   	push   %ebx
80105e74:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80105e77:	e8 94 e0 ff ff       	call   80103f10 <myproc>
80105e7c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80105e7e:	8b 40 18             	mov    0x18(%eax),%eax
80105e81:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105e84:	8d 50 ff             	lea    -0x1(%eax),%edx
80105e87:	83 fa 21             	cmp    $0x21,%edx
80105e8a:	77 1c                	ja     80105ea8 <syscall+0x38>
80105e8c:	8b 14 85 80 91 10 80 	mov    -0x7fef6e80(,%eax,4),%edx
80105e93:	85 d2                	test   %edx,%edx
80105e95:	74 11                	je     80105ea8 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80105e97:	ff d2                	call   *%edx
80105e99:	8b 53 18             	mov    0x18(%ebx),%edx
80105e9c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105e9f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ea2:	c9                   	leave  
80105ea3:	c3                   	ret    
80105ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105ea8:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105ea9:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80105eac:	50                   	push   %eax
80105ead:	ff 73 10             	pushl  0x10(%ebx)
80105eb0:	68 49 91 10 80       	push   $0x80109149
80105eb5:	e8 f6 a7 ff ff       	call   801006b0 <cprintf>
    curproc->tf->eax = -1;
80105eba:	8b 43 18             	mov    0x18(%ebx),%eax
80105ebd:	83 c4 10             	add    $0x10,%esp
80105ec0:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80105ec7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105eca:	c9                   	leave  
80105ecb:	c3                   	ret    
80105ecc:	66 90                	xchg   %ax,%ax
80105ece:	66 90                	xchg   %ax,%ax

80105ed0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105ed0:	55                   	push   %ebp
80105ed1:	89 e5                	mov    %esp,%ebp
80105ed3:	57                   	push   %edi
80105ed4:	56                   	push   %esi
80105ed5:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105ed6:	8d 5d da             	lea    -0x26(%ebp),%ebx
{
80105ed9:	83 ec 44             	sub    $0x44,%esp
80105edc:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80105edf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105ee2:	53                   	push   %ebx
80105ee3:	50                   	push   %eax
{
80105ee4:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80105ee7:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105eea:	e8 e1 c2 ff ff       	call   801021d0 <nameiparent>
80105eef:	83 c4 10             	add    $0x10,%esp
80105ef2:	85 c0                	test   %eax,%eax
80105ef4:	0f 84 46 01 00 00    	je     80106040 <create+0x170>
    return 0;
  ilock(dp);
80105efa:	83 ec 0c             	sub    $0xc,%esp
80105efd:	89 c6                	mov    %eax,%esi
80105eff:	50                   	push   %eax
80105f00:	e8 cb b9 ff ff       	call   801018d0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80105f05:	83 c4 0c             	add    $0xc,%esp
80105f08:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105f0b:	50                   	push   %eax
80105f0c:	53                   	push   %ebx
80105f0d:	56                   	push   %esi
80105f0e:	e8 2d bf ff ff       	call   80101e40 <dirlookup>
80105f13:	83 c4 10             	add    $0x10,%esp
80105f16:	89 c7                	mov    %eax,%edi
80105f18:	85 c0                	test   %eax,%eax
80105f1a:	74 54                	je     80105f70 <create+0xa0>
    iunlockput(dp);
80105f1c:	83 ec 0c             	sub    $0xc,%esp
80105f1f:	56                   	push   %esi
80105f20:	e8 5b bc ff ff       	call   80101b80 <iunlockput>
    ilock(ip);
80105f25:	89 3c 24             	mov    %edi,(%esp)
80105f28:	e8 a3 b9 ff ff       	call   801018d0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105f2d:	83 c4 10             	add    $0x10,%esp
80105f30:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80105f35:	75 19                	jne    80105f50 <create+0x80>
80105f37:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80105f3c:	75 12                	jne    80105f50 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105f3e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f41:	89 f8                	mov    %edi,%eax
80105f43:	5b                   	pop    %ebx
80105f44:	5e                   	pop    %esi
80105f45:	5f                   	pop    %edi
80105f46:	5d                   	pop    %ebp
80105f47:	c3                   	ret    
80105f48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f4f:	90                   	nop
    iunlockput(ip);
80105f50:	83 ec 0c             	sub    $0xc,%esp
80105f53:	57                   	push   %edi
    return 0;
80105f54:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80105f56:	e8 25 bc ff ff       	call   80101b80 <iunlockput>
    return 0;
80105f5b:	83 c4 10             	add    $0x10,%esp
}
80105f5e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f61:	89 f8                	mov    %edi,%eax
80105f63:	5b                   	pop    %ebx
80105f64:	5e                   	pop    %esi
80105f65:	5f                   	pop    %edi
80105f66:	5d                   	pop    %ebp
80105f67:	c3                   	ret    
80105f68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f6f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80105f70:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80105f74:	83 ec 08             	sub    $0x8,%esp
80105f77:	50                   	push   %eax
80105f78:	ff 36                	pushl  (%esi)
80105f7a:	e8 b1 b7 ff ff       	call   80101730 <ialloc>
80105f7f:	83 c4 10             	add    $0x10,%esp
80105f82:	89 c7                	mov    %eax,%edi
80105f84:	85 c0                	test   %eax,%eax
80105f86:	0f 84 cd 00 00 00    	je     80106059 <create+0x189>
  ilock(ip);
80105f8c:	83 ec 0c             	sub    $0xc,%esp
80105f8f:	50                   	push   %eax
80105f90:	e8 3b b9 ff ff       	call   801018d0 <ilock>
  ip->major = major;
80105f95:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80105f99:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80105f9d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80105fa1:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80105fa5:	b8 01 00 00 00       	mov    $0x1,%eax
80105faa:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80105fae:	89 3c 24             	mov    %edi,(%esp)
80105fb1:	e8 4a b8 ff ff       	call   80101800 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105fb6:	83 c4 10             	add    $0x10,%esp
80105fb9:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80105fbe:	74 30                	je     80105ff0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80105fc0:	83 ec 04             	sub    $0x4,%esp
80105fc3:	ff 77 04             	pushl  0x4(%edi)
80105fc6:	53                   	push   %ebx
80105fc7:	56                   	push   %esi
80105fc8:	e8 23 c1 ff ff       	call   801020f0 <dirlink>
80105fcd:	83 c4 10             	add    $0x10,%esp
80105fd0:	85 c0                	test   %eax,%eax
80105fd2:	78 78                	js     8010604c <create+0x17c>
  iunlockput(dp);
80105fd4:	83 ec 0c             	sub    $0xc,%esp
80105fd7:	56                   	push   %esi
80105fd8:	e8 a3 bb ff ff       	call   80101b80 <iunlockput>
  return ip;
80105fdd:	83 c4 10             	add    $0x10,%esp
}
80105fe0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105fe3:	89 f8                	mov    %edi,%eax
80105fe5:	5b                   	pop    %ebx
80105fe6:	5e                   	pop    %esi
80105fe7:	5f                   	pop    %edi
80105fe8:	5d                   	pop    %ebp
80105fe9:	c3                   	ret    
80105fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80105ff0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80105ff3:	66 83 46 56 01       	addw   $0x1,0x56(%esi)
    iupdate(dp);
80105ff8:	56                   	push   %esi
80105ff9:	e8 02 b8 ff ff       	call   80101800 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105ffe:	83 c4 0c             	add    $0xc,%esp
80106001:	ff 77 04             	pushl  0x4(%edi)
80106004:	68 28 92 10 80       	push   $0x80109228
80106009:	57                   	push   %edi
8010600a:	e8 e1 c0 ff ff       	call   801020f0 <dirlink>
8010600f:	83 c4 10             	add    $0x10,%esp
80106012:	85 c0                	test   %eax,%eax
80106014:	78 18                	js     8010602e <create+0x15e>
80106016:	83 ec 04             	sub    $0x4,%esp
80106019:	ff 76 04             	pushl  0x4(%esi)
8010601c:	68 27 92 10 80       	push   $0x80109227
80106021:	57                   	push   %edi
80106022:	e8 c9 c0 ff ff       	call   801020f0 <dirlink>
80106027:	83 c4 10             	add    $0x10,%esp
8010602a:	85 c0                	test   %eax,%eax
8010602c:	79 92                	jns    80105fc0 <create+0xf0>
      panic("create dots");
8010602e:	83 ec 0c             	sub    $0xc,%esp
80106031:	68 1b 92 10 80       	push   $0x8010921b
80106036:	e8 55 a3 ff ff       	call   80100390 <panic>
8010603b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010603f:	90                   	nop
}
80106040:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106043:	31 ff                	xor    %edi,%edi
}
80106045:	5b                   	pop    %ebx
80106046:	89 f8                	mov    %edi,%eax
80106048:	5e                   	pop    %esi
80106049:	5f                   	pop    %edi
8010604a:	5d                   	pop    %ebp
8010604b:	c3                   	ret    
    panic("create: dirlink");
8010604c:	83 ec 0c             	sub    $0xc,%esp
8010604f:	68 2a 92 10 80       	push   $0x8010922a
80106054:	e8 37 a3 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80106059:	83 ec 0c             	sub    $0xc,%esp
8010605c:	68 0c 92 10 80       	push   $0x8010920c
80106061:	e8 2a a3 ff ff       	call   80100390 <panic>
80106066:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010606d:	8d 76 00             	lea    0x0(%esi),%esi

80106070 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80106070:	55                   	push   %ebp
80106071:	89 e5                	mov    %esp,%ebp
80106073:	56                   	push   %esi
80106074:	89 d6                	mov    %edx,%esi
80106076:	53                   	push   %ebx
80106077:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80106079:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
8010607c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010607f:	50                   	push   %eax
80106080:	6a 00                	push   $0x0
80106082:	e8 f9 fc ff ff       	call   80105d80 <argint>
80106087:	83 c4 10             	add    $0x10,%esp
8010608a:	85 c0                	test   %eax,%eax
8010608c:	78 2a                	js     801060b8 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010608e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80106092:	77 24                	ja     801060b8 <argfd.constprop.0+0x48>
80106094:	e8 77 de ff ff       	call   80103f10 <myproc>
80106099:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010609c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
801060a0:	85 c0                	test   %eax,%eax
801060a2:	74 14                	je     801060b8 <argfd.constprop.0+0x48>
  if(pfd)
801060a4:	85 db                	test   %ebx,%ebx
801060a6:	74 02                	je     801060aa <argfd.constprop.0+0x3a>
    *pfd = fd;
801060a8:	89 13                	mov    %edx,(%ebx)
    *pf = f;
801060aa:	89 06                	mov    %eax,(%esi)
  return 0;
801060ac:	31 c0                	xor    %eax,%eax
}
801060ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801060b1:	5b                   	pop    %ebx
801060b2:	5e                   	pop    %esi
801060b3:	5d                   	pop    %ebp
801060b4:	c3                   	ret    
801060b5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801060b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060bd:	eb ef                	jmp    801060ae <argfd.constprop.0+0x3e>
801060bf:	90                   	nop

801060c0 <sys_dup>:
{
801060c0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
801060c1:	31 c0                	xor    %eax,%eax
{
801060c3:	89 e5                	mov    %esp,%ebp
801060c5:	56                   	push   %esi
801060c6:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
801060c7:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
801060ca:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
801060cd:	e8 9e ff ff ff       	call   80106070 <argfd.constprop.0>
801060d2:	85 c0                	test   %eax,%eax
801060d4:	78 1a                	js     801060f0 <sys_dup+0x30>
  if((fd=fdalloc(f)) < 0)
801060d6:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
801060d9:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801060db:	e8 30 de ff ff       	call   80103f10 <myproc>
    if(curproc->ofile[fd] == 0){
801060e0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801060e4:	85 d2                	test   %edx,%edx
801060e6:	74 18                	je     80106100 <sys_dup+0x40>
  for(fd = 0; fd < NOFILE; fd++){
801060e8:	83 c3 01             	add    $0x1,%ebx
801060eb:	83 fb 10             	cmp    $0x10,%ebx
801060ee:	75 f0                	jne    801060e0 <sys_dup+0x20>
}
801060f0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
801060f3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801060f8:	89 d8                	mov    %ebx,%eax
801060fa:	5b                   	pop    %ebx
801060fb:	5e                   	pop    %esi
801060fc:	5d                   	pop    %ebp
801060fd:	c3                   	ret    
801060fe:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80106100:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80106104:	83 ec 0c             	sub    $0xc,%esp
80106107:	ff 75 f4             	pushl  -0xc(%ebp)
8010610a:	e8 e1 ae ff ff       	call   80100ff0 <filedup>
  return fd;
8010610f:	83 c4 10             	add    $0x10,%esp
}
80106112:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106115:	89 d8                	mov    %ebx,%eax
80106117:	5b                   	pop    %ebx
80106118:	5e                   	pop    %esi
80106119:	5d                   	pop    %ebp
8010611a:	c3                   	ret    
8010611b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010611f:	90                   	nop

80106120 <sys_read>:
{
80106120:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106121:	31 c0                	xor    %eax,%eax
{
80106123:	89 e5                	mov    %esp,%ebp
80106125:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106128:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010612b:	e8 40 ff ff ff       	call   80106070 <argfd.constprop.0>
80106130:	85 c0                	test   %eax,%eax
80106132:	78 4c                	js     80106180 <sys_read+0x60>
80106134:	83 ec 08             	sub    $0x8,%esp
80106137:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010613a:	50                   	push   %eax
8010613b:	6a 02                	push   $0x2
8010613d:	e8 3e fc ff ff       	call   80105d80 <argint>
80106142:	83 c4 10             	add    $0x10,%esp
80106145:	85 c0                	test   %eax,%eax
80106147:	78 37                	js     80106180 <sys_read+0x60>
80106149:	83 ec 04             	sub    $0x4,%esp
8010614c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010614f:	ff 75 f0             	pushl  -0x10(%ebp)
80106152:	50                   	push   %eax
80106153:	6a 01                	push   $0x1
80106155:	e8 76 fc ff ff       	call   80105dd0 <argptr>
8010615a:	83 c4 10             	add    $0x10,%esp
8010615d:	85 c0                	test   %eax,%eax
8010615f:	78 1f                	js     80106180 <sys_read+0x60>
  return fileread(f, p, n);
80106161:	83 ec 04             	sub    $0x4,%esp
80106164:	ff 75 f0             	pushl  -0x10(%ebp)
80106167:	ff 75 f4             	pushl  -0xc(%ebp)
8010616a:	ff 75 ec             	pushl  -0x14(%ebp)
8010616d:	e8 fe af ff ff       	call   80101170 <fileread>
80106172:	83 c4 10             	add    $0x10,%esp
}
80106175:	c9                   	leave  
80106176:	c3                   	ret    
80106177:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010617e:	66 90                	xchg   %ax,%ax
80106180:	c9                   	leave  
    return -1;
80106181:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106186:	c3                   	ret    
80106187:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010618e:	66 90                	xchg   %ax,%ax

80106190 <sys_write>:
{
80106190:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106191:	31 c0                	xor    %eax,%eax
{
80106193:	89 e5                	mov    %esp,%ebp
80106195:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106198:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010619b:	e8 d0 fe ff ff       	call   80106070 <argfd.constprop.0>
801061a0:	85 c0                	test   %eax,%eax
801061a2:	78 4c                	js     801061f0 <sys_write+0x60>
801061a4:	83 ec 08             	sub    $0x8,%esp
801061a7:	8d 45 f0             	lea    -0x10(%ebp),%eax
801061aa:	50                   	push   %eax
801061ab:	6a 02                	push   $0x2
801061ad:	e8 ce fb ff ff       	call   80105d80 <argint>
801061b2:	83 c4 10             	add    $0x10,%esp
801061b5:	85 c0                	test   %eax,%eax
801061b7:	78 37                	js     801061f0 <sys_write+0x60>
801061b9:	83 ec 04             	sub    $0x4,%esp
801061bc:	8d 45 f4             	lea    -0xc(%ebp),%eax
801061bf:	ff 75 f0             	pushl  -0x10(%ebp)
801061c2:	50                   	push   %eax
801061c3:	6a 01                	push   $0x1
801061c5:	e8 06 fc ff ff       	call   80105dd0 <argptr>
801061ca:	83 c4 10             	add    $0x10,%esp
801061cd:	85 c0                	test   %eax,%eax
801061cf:	78 1f                	js     801061f0 <sys_write+0x60>
  return filewrite(f, p, n);
801061d1:	83 ec 04             	sub    $0x4,%esp
801061d4:	ff 75 f0             	pushl  -0x10(%ebp)
801061d7:	ff 75 f4             	pushl  -0xc(%ebp)
801061da:	ff 75 ec             	pushl  -0x14(%ebp)
801061dd:	e8 1e b0 ff ff       	call   80101200 <filewrite>
801061e2:	83 c4 10             	add    $0x10,%esp
}
801061e5:	c9                   	leave  
801061e6:	c3                   	ret    
801061e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061ee:	66 90                	xchg   %ax,%ax
801061f0:	c9                   	leave  
    return -1;
801061f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801061f6:	c3                   	ret    
801061f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061fe:	66 90                	xchg   %ax,%ax

80106200 <sys_close>:
{
80106200:	55                   	push   %ebp
80106201:	89 e5                	mov    %esp,%ebp
80106203:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80106206:	8d 55 f4             	lea    -0xc(%ebp),%edx
80106209:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010620c:	e8 5f fe ff ff       	call   80106070 <argfd.constprop.0>
80106211:	85 c0                	test   %eax,%eax
80106213:	78 2b                	js     80106240 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80106215:	e8 f6 dc ff ff       	call   80103f10 <myproc>
8010621a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
8010621d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80106220:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80106227:	00 
  fileclose(f);
80106228:	ff 75 f4             	pushl  -0xc(%ebp)
8010622b:	e8 10 ae ff ff       	call   80101040 <fileclose>
  return 0;
80106230:	83 c4 10             	add    $0x10,%esp
80106233:	31 c0                	xor    %eax,%eax
}
80106235:	c9                   	leave  
80106236:	c3                   	ret    
80106237:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010623e:	66 90                	xchg   %ax,%ax
80106240:	c9                   	leave  
    return -1;
80106241:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106246:	c3                   	ret    
80106247:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010624e:	66 90                	xchg   %ax,%ax

80106250 <sys_fstat>:
{
80106250:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80106251:	31 c0                	xor    %eax,%eax
{
80106253:	89 e5                	mov    %esp,%ebp
80106255:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80106258:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010625b:	e8 10 fe ff ff       	call   80106070 <argfd.constprop.0>
80106260:	85 c0                	test   %eax,%eax
80106262:	78 2c                	js     80106290 <sys_fstat+0x40>
80106264:	83 ec 04             	sub    $0x4,%esp
80106267:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010626a:	6a 1c                	push   $0x1c
8010626c:	50                   	push   %eax
8010626d:	6a 01                	push   $0x1
8010626f:	e8 5c fb ff ff       	call   80105dd0 <argptr>
80106274:	83 c4 10             	add    $0x10,%esp
80106277:	85 c0                	test   %eax,%eax
80106279:	78 15                	js     80106290 <sys_fstat+0x40>
  return filestat(f, st);
8010627b:	83 ec 08             	sub    $0x8,%esp
8010627e:	ff 75 f4             	pushl  -0xc(%ebp)
80106281:	ff 75 f0             	pushl  -0x10(%ebp)
80106284:	e8 97 ae ff ff       	call   80101120 <filestat>
80106289:	83 c4 10             	add    $0x10,%esp
}
8010628c:	c9                   	leave  
8010628d:	c3                   	ret    
8010628e:	66 90                	xchg   %ax,%ax
80106290:	c9                   	leave  
    return -1;
80106291:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106296:	c3                   	ret    
80106297:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010629e:	66 90                	xchg   %ax,%ax

801062a0 <sys_link>:
{
801062a0:	55                   	push   %ebp
801062a1:	89 e5                	mov    %esp,%ebp
801062a3:	57                   	push   %edi
801062a4:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801062a5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
801062a8:	53                   	push   %ebx
801062a9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801062ac:	50                   	push   %eax
801062ad:	6a 00                	push   $0x0
801062af:	e8 7c fb ff ff       	call   80105e30 <argstr>
801062b4:	83 c4 10             	add    $0x10,%esp
801062b7:	85 c0                	test   %eax,%eax
801062b9:	0f 88 fb 00 00 00    	js     801063ba <sys_link+0x11a>
801062bf:	83 ec 08             	sub    $0x8,%esp
801062c2:	8d 45 d0             	lea    -0x30(%ebp),%eax
801062c5:	50                   	push   %eax
801062c6:	6a 01                	push   $0x1
801062c8:	e8 63 fb ff ff       	call   80105e30 <argstr>
801062cd:	83 c4 10             	add    $0x10,%esp
801062d0:	85 c0                	test   %eax,%eax
801062d2:	0f 88 e2 00 00 00    	js     801063ba <sys_link+0x11a>
  begin_op();
801062d8:	e8 33 cd ff ff       	call   80103010 <begin_op>
  if((ip = namei(old)) == 0){
801062dd:	83 ec 0c             	sub    $0xc,%esp
801062e0:	ff 75 d4             	pushl  -0x2c(%ebp)
801062e3:	e8 c8 be ff ff       	call   801021b0 <namei>
801062e8:	83 c4 10             	add    $0x10,%esp
801062eb:	89 c3                	mov    %eax,%ebx
801062ed:	85 c0                	test   %eax,%eax
801062ef:	0f 84 e4 00 00 00    	je     801063d9 <sys_link+0x139>
  ilock(ip);
801062f5:	83 ec 0c             	sub    $0xc,%esp
801062f8:	50                   	push   %eax
801062f9:	e8 d2 b5 ff ff       	call   801018d0 <ilock>
  if(ip->type == T_DIR){
801062fe:	83 c4 10             	add    $0x10,%esp
80106301:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106306:	0f 84 b5 00 00 00    	je     801063c1 <sys_link+0x121>
  iupdate(ip);
8010630c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
8010630f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80106314:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80106317:	53                   	push   %ebx
80106318:	e8 e3 b4 ff ff       	call   80101800 <iupdate>
  iunlock(ip);
8010631d:	89 1c 24             	mov    %ebx,(%esp)
80106320:	e8 ab b6 ff ff       	call   801019d0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80106325:	58                   	pop    %eax
80106326:	5a                   	pop    %edx
80106327:	57                   	push   %edi
80106328:	ff 75 d0             	pushl  -0x30(%ebp)
8010632b:	e8 a0 be ff ff       	call   801021d0 <nameiparent>
80106330:	83 c4 10             	add    $0x10,%esp
80106333:	89 c6                	mov    %eax,%esi
80106335:	85 c0                	test   %eax,%eax
80106337:	74 5b                	je     80106394 <sys_link+0xf4>
  ilock(dp);
80106339:	83 ec 0c             	sub    $0xc,%esp
8010633c:	50                   	push   %eax
8010633d:	e8 8e b5 ff ff       	call   801018d0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80106342:	83 c4 10             	add    $0x10,%esp
80106345:	8b 03                	mov    (%ebx),%eax
80106347:	39 06                	cmp    %eax,(%esi)
80106349:	75 3d                	jne    80106388 <sys_link+0xe8>
8010634b:	83 ec 04             	sub    $0x4,%esp
8010634e:	ff 73 04             	pushl  0x4(%ebx)
80106351:	57                   	push   %edi
80106352:	56                   	push   %esi
80106353:	e8 98 bd ff ff       	call   801020f0 <dirlink>
80106358:	83 c4 10             	add    $0x10,%esp
8010635b:	85 c0                	test   %eax,%eax
8010635d:	78 29                	js     80106388 <sys_link+0xe8>
  iunlockput(dp);
8010635f:	83 ec 0c             	sub    $0xc,%esp
80106362:	56                   	push   %esi
80106363:	e8 18 b8 ff ff       	call   80101b80 <iunlockput>
  iput(ip);
80106368:	89 1c 24             	mov    %ebx,(%esp)
8010636b:	e8 b0 b6 ff ff       	call   80101a20 <iput>
  end_op();
80106370:	e8 0b cd ff ff       	call   80103080 <end_op>
  return 0;
80106375:	83 c4 10             	add    $0x10,%esp
80106378:	31 c0                	xor    %eax,%eax
}
8010637a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010637d:	5b                   	pop    %ebx
8010637e:	5e                   	pop    %esi
8010637f:	5f                   	pop    %edi
80106380:	5d                   	pop    %ebp
80106381:	c3                   	ret    
80106382:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80106388:	83 ec 0c             	sub    $0xc,%esp
8010638b:	56                   	push   %esi
8010638c:	e8 ef b7 ff ff       	call   80101b80 <iunlockput>
    goto bad;
80106391:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80106394:	83 ec 0c             	sub    $0xc,%esp
80106397:	53                   	push   %ebx
80106398:	e8 33 b5 ff ff       	call   801018d0 <ilock>
  ip->nlink--;
8010639d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801063a2:	89 1c 24             	mov    %ebx,(%esp)
801063a5:	e8 56 b4 ff ff       	call   80101800 <iupdate>
  iunlockput(ip);
801063aa:	89 1c 24             	mov    %ebx,(%esp)
801063ad:	e8 ce b7 ff ff       	call   80101b80 <iunlockput>
  end_op();
801063b2:	e8 c9 cc ff ff       	call   80103080 <end_op>
  return -1;
801063b7:	83 c4 10             	add    $0x10,%esp
801063ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063bf:	eb b9                	jmp    8010637a <sys_link+0xda>
    iunlockput(ip);
801063c1:	83 ec 0c             	sub    $0xc,%esp
801063c4:	53                   	push   %ebx
801063c5:	e8 b6 b7 ff ff       	call   80101b80 <iunlockput>
    end_op();
801063ca:	e8 b1 cc ff ff       	call   80103080 <end_op>
    return -1;
801063cf:	83 c4 10             	add    $0x10,%esp
801063d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063d7:	eb a1                	jmp    8010637a <sys_link+0xda>
    end_op();
801063d9:	e8 a2 cc ff ff       	call   80103080 <end_op>
    return -1;
801063de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063e3:	eb 95                	jmp    8010637a <sys_link+0xda>
801063e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801063ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801063f0 <sys_unlink>:
{
801063f0:	55                   	push   %ebp
801063f1:	89 e5                	mov    %esp,%ebp
801063f3:	57                   	push   %edi
801063f4:	56                   	push   %esi
  if(argstr(0, &path) < 0)
801063f5:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801063f8:	53                   	push   %ebx
801063f9:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
801063fc:	50                   	push   %eax
801063fd:	6a 00                	push   $0x0
801063ff:	e8 2c fa ff ff       	call   80105e30 <argstr>
80106404:	83 c4 10             	add    $0x10,%esp
80106407:	85 c0                	test   %eax,%eax
80106409:	0f 88 91 01 00 00    	js     801065a0 <sys_unlink+0x1b0>
  begin_op();
8010640f:	e8 fc cb ff ff       	call   80103010 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80106414:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80106417:	83 ec 08             	sub    $0x8,%esp
8010641a:	53                   	push   %ebx
8010641b:	ff 75 c0             	pushl  -0x40(%ebp)
8010641e:	e8 ad bd ff ff       	call   801021d0 <nameiparent>
80106423:	83 c4 10             	add    $0x10,%esp
80106426:	89 c6                	mov    %eax,%esi
80106428:	85 c0                	test   %eax,%eax
8010642a:	0f 84 7a 01 00 00    	je     801065aa <sys_unlink+0x1ba>
  ilock(dp);
80106430:	83 ec 0c             	sub    $0xc,%esp
80106433:	50                   	push   %eax
80106434:	e8 97 b4 ff ff       	call   801018d0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80106439:	58                   	pop    %eax
8010643a:	5a                   	pop    %edx
8010643b:	68 28 92 10 80       	push   $0x80109228
80106440:	53                   	push   %ebx
80106441:	e8 da b9 ff ff       	call   80101e20 <namecmp>
80106446:	83 c4 10             	add    $0x10,%esp
80106449:	85 c0                	test   %eax,%eax
8010644b:	0f 84 0f 01 00 00    	je     80106560 <sys_unlink+0x170>
80106451:	83 ec 08             	sub    $0x8,%esp
80106454:	68 27 92 10 80       	push   $0x80109227
80106459:	53                   	push   %ebx
8010645a:	e8 c1 b9 ff ff       	call   80101e20 <namecmp>
8010645f:	83 c4 10             	add    $0x10,%esp
80106462:	85 c0                	test   %eax,%eax
80106464:	0f 84 f6 00 00 00    	je     80106560 <sys_unlink+0x170>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010646a:	83 ec 04             	sub    $0x4,%esp
8010646d:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80106470:	50                   	push   %eax
80106471:	53                   	push   %ebx
80106472:	56                   	push   %esi
80106473:	e8 c8 b9 ff ff       	call   80101e40 <dirlookup>
80106478:	83 c4 10             	add    $0x10,%esp
8010647b:	89 c3                	mov    %eax,%ebx
8010647d:	85 c0                	test   %eax,%eax
8010647f:	0f 84 db 00 00 00    	je     80106560 <sys_unlink+0x170>
  ilock(ip);
80106485:	83 ec 0c             	sub    $0xc,%esp
80106488:	50                   	push   %eax
80106489:	e8 42 b4 ff ff       	call   801018d0 <ilock>
  if(ip->nlink < 1)
8010648e:	83 c4 10             	add    $0x10,%esp
80106491:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80106496:	0f 8e 37 01 00 00    	jle    801065d3 <sys_unlink+0x1e3>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010649c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801064a1:	8d 7d d8             	lea    -0x28(%ebp),%edi
801064a4:	74 6a                	je     80106510 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801064a6:	83 ec 04             	sub    $0x4,%esp
801064a9:	6a 10                	push   $0x10
801064ab:	6a 00                	push   $0x0
801064ad:	57                   	push   %edi
801064ae:	e8 ed f5 ff ff       	call   80105aa0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801064b3:	6a 10                	push   $0x10
801064b5:	ff 75 c4             	pushl  -0x3c(%ebp)
801064b8:	57                   	push   %edi
801064b9:	56                   	push   %esi
801064ba:	e8 31 b8 ff ff       	call   80101cf0 <writei>
801064bf:	83 c4 20             	add    $0x20,%esp
801064c2:	83 f8 10             	cmp    $0x10,%eax
801064c5:	0f 85 fb 00 00 00    	jne    801065c6 <sys_unlink+0x1d6>
  if(ip->type == T_DIR){
801064cb:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801064d0:	0f 84 aa 00 00 00    	je     80106580 <sys_unlink+0x190>
  iunlockput(dp);
801064d6:	83 ec 0c             	sub    $0xc,%esp
801064d9:	56                   	push   %esi
801064da:	e8 a1 b6 ff ff       	call   80101b80 <iunlockput>
  ip->nlink--;
801064df:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801064e4:	89 1c 24             	mov    %ebx,(%esp)
801064e7:	e8 14 b3 ff ff       	call   80101800 <iupdate>
  iunlockput(ip);
801064ec:	89 1c 24             	mov    %ebx,(%esp)
801064ef:	e8 8c b6 ff ff       	call   80101b80 <iunlockput>
  end_op();
801064f4:	e8 87 cb ff ff       	call   80103080 <end_op>
  return 0;
801064f9:	83 c4 10             	add    $0x10,%esp
801064fc:	31 c0                	xor    %eax,%eax
}
801064fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106501:	5b                   	pop    %ebx
80106502:	5e                   	pop    %esi
80106503:	5f                   	pop    %edi
80106504:	5d                   	pop    %ebp
80106505:	c3                   	ret    
80106506:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010650d:	8d 76 00             	lea    0x0(%esi),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80106510:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80106514:	76 90                	jbe    801064a6 <sys_unlink+0xb6>
80106516:	ba 20 00 00 00       	mov    $0x20,%edx
8010651b:	eb 0f                	jmp    8010652c <sys_unlink+0x13c>
8010651d:	8d 76 00             	lea    0x0(%esi),%esi
80106520:	83 c2 10             	add    $0x10,%edx
80106523:	39 53 58             	cmp    %edx,0x58(%ebx)
80106526:	0f 86 7a ff ff ff    	jbe    801064a6 <sys_unlink+0xb6>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010652c:	6a 10                	push   $0x10
8010652e:	52                   	push   %edx
8010652f:	57                   	push   %edi
80106530:	53                   	push   %ebx
80106531:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80106534:	e8 b7 b6 ff ff       	call   80101bf0 <readi>
80106539:	83 c4 10             	add    $0x10,%esp
8010653c:	8b 55 b4             	mov    -0x4c(%ebp),%edx
8010653f:	83 f8 10             	cmp    $0x10,%eax
80106542:	75 75                	jne    801065b9 <sys_unlink+0x1c9>
    if(de.inum != 0)
80106544:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80106549:	74 d5                	je     80106520 <sys_unlink+0x130>
    iunlockput(ip);
8010654b:	83 ec 0c             	sub    $0xc,%esp
8010654e:	53                   	push   %ebx
8010654f:	e8 2c b6 ff ff       	call   80101b80 <iunlockput>
    goto bad;
80106554:	83 c4 10             	add    $0x10,%esp
80106557:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010655e:	66 90                	xchg   %ax,%ax
  iunlockput(dp);
80106560:	83 ec 0c             	sub    $0xc,%esp
80106563:	56                   	push   %esi
80106564:	e8 17 b6 ff ff       	call   80101b80 <iunlockput>
  end_op();
80106569:	e8 12 cb ff ff       	call   80103080 <end_op>
  return -1;
8010656e:	83 c4 10             	add    $0x10,%esp
80106571:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106576:	eb 86                	jmp    801064fe <sys_unlink+0x10e>
80106578:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010657f:	90                   	nop
    iupdate(dp);
80106580:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80106583:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80106588:	56                   	push   %esi
80106589:	e8 72 b2 ff ff       	call   80101800 <iupdate>
8010658e:	83 c4 10             	add    $0x10,%esp
80106591:	e9 40 ff ff ff       	jmp    801064d6 <sys_unlink+0xe6>
80106596:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010659d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801065a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065a5:	e9 54 ff ff ff       	jmp    801064fe <sys_unlink+0x10e>
    end_op();
801065aa:	e8 d1 ca ff ff       	call   80103080 <end_op>
    return -1;
801065af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065b4:	e9 45 ff ff ff       	jmp    801064fe <sys_unlink+0x10e>
      panic("isdirempty: readi");
801065b9:	83 ec 0c             	sub    $0xc,%esp
801065bc:	68 4c 92 10 80       	push   $0x8010924c
801065c1:	e8 ca 9d ff ff       	call   80100390 <panic>
    panic("unlink: writei");
801065c6:	83 ec 0c             	sub    $0xc,%esp
801065c9:	68 5e 92 10 80       	push   $0x8010925e
801065ce:	e8 bd 9d ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
801065d3:	83 ec 0c             	sub    $0xc,%esp
801065d6:	68 3a 92 10 80       	push   $0x8010923a
801065db:	e8 b0 9d ff ff       	call   80100390 <panic>

801065e0 <sys_open>:

int
sys_open(void)
{
801065e0:	55                   	push   %ebp
801065e1:	89 e5                	mov    %esp,%ebp
801065e3:	57                   	push   %edi
801065e4:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801065e5:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801065e8:	53                   	push   %ebx
801065e9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801065ec:	50                   	push   %eax
801065ed:	6a 00                	push   $0x0
801065ef:	e8 3c f8 ff ff       	call   80105e30 <argstr>
801065f4:	83 c4 10             	add    $0x10,%esp
801065f7:	85 c0                	test   %eax,%eax
801065f9:	0f 88 8e 00 00 00    	js     8010668d <sys_open+0xad>
801065ff:	83 ec 08             	sub    $0x8,%esp
80106602:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106605:	50                   	push   %eax
80106606:	6a 01                	push   $0x1
80106608:	e8 73 f7 ff ff       	call   80105d80 <argint>
8010660d:	83 c4 10             	add    $0x10,%esp
80106610:	85 c0                	test   %eax,%eax
80106612:	78 79                	js     8010668d <sys_open+0xad>
    return -1;

  begin_op();
80106614:	e8 f7 c9 ff ff       	call   80103010 <begin_op>

  if(omode & O_CREATE){
80106619:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
8010661d:	75 79                	jne    80106698 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010661f:	83 ec 0c             	sub    $0xc,%esp
80106622:	ff 75 e0             	pushl  -0x20(%ebp)
80106625:	e8 86 bb ff ff       	call   801021b0 <namei>
8010662a:	83 c4 10             	add    $0x10,%esp
8010662d:	89 c6                	mov    %eax,%esi
8010662f:	85 c0                	test   %eax,%eax
80106631:	0f 84 7e 00 00 00    	je     801066b5 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80106637:	83 ec 0c             	sub    $0xc,%esp
8010663a:	50                   	push   %eax
8010663b:	e8 90 b2 ff ff       	call   801018d0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80106640:	83 c4 10             	add    $0x10,%esp
80106643:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80106648:	0f 84 c2 00 00 00    	je     80106710 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010664e:	e8 2d a9 ff ff       	call   80100f80 <filealloc>
80106653:	89 c7                	mov    %eax,%edi
80106655:	85 c0                	test   %eax,%eax
80106657:	74 23                	je     8010667c <sys_open+0x9c>
  struct proc *curproc = myproc();
80106659:	e8 b2 d8 ff ff       	call   80103f10 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010665e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80106660:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80106664:	85 d2                	test   %edx,%edx
80106666:	74 60                	je     801066c8 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80106668:	83 c3 01             	add    $0x1,%ebx
8010666b:	83 fb 10             	cmp    $0x10,%ebx
8010666e:	75 f0                	jne    80106660 <sys_open+0x80>
    if(f)
      fileclose(f);
80106670:	83 ec 0c             	sub    $0xc,%esp
80106673:	57                   	push   %edi
80106674:	e8 c7 a9 ff ff       	call   80101040 <fileclose>
80106679:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010667c:	83 ec 0c             	sub    $0xc,%esp
8010667f:	56                   	push   %esi
80106680:	e8 fb b4 ff ff       	call   80101b80 <iunlockput>
    end_op();
80106685:	e8 f6 c9 ff ff       	call   80103080 <end_op>
    return -1;
8010668a:	83 c4 10             	add    $0x10,%esp
8010668d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106692:	eb 6d                	jmp    80106701 <sys_open+0x121>
80106694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80106698:	83 ec 0c             	sub    $0xc,%esp
8010669b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010669e:	31 c9                	xor    %ecx,%ecx
801066a0:	ba 02 00 00 00       	mov    $0x2,%edx
801066a5:	6a 00                	push   $0x0
801066a7:	e8 24 f8 ff ff       	call   80105ed0 <create>
    if(ip == 0){
801066ac:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
801066af:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801066b1:	85 c0                	test   %eax,%eax
801066b3:	75 99                	jne    8010664e <sys_open+0x6e>
      end_op();
801066b5:	e8 c6 c9 ff ff       	call   80103080 <end_op>
      return -1;
801066ba:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801066bf:	eb 40                	jmp    80106701 <sys_open+0x121>
801066c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
801066c8:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801066cb:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
801066cf:	56                   	push   %esi
801066d0:	e8 fb b2 ff ff       	call   801019d0 <iunlock>
  end_op();
801066d5:	e8 a6 c9 ff ff       	call   80103080 <end_op>

  f->type = FD_INODE;
801066da:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801066e0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801066e3:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801066e6:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
801066e9:	89 d0                	mov    %edx,%eax
  f->off = 0;
801066eb:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801066f2:	f7 d0                	not    %eax
801066f4:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801066f7:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801066fa:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801066fd:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80106701:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106704:	89 d8                	mov    %ebx,%eax
80106706:	5b                   	pop    %ebx
80106707:	5e                   	pop    %esi
80106708:	5f                   	pop    %edi
80106709:	5d                   	pop    %ebp
8010670a:	c3                   	ret    
8010670b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010670f:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80106710:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106713:	85 c9                	test   %ecx,%ecx
80106715:	0f 84 33 ff ff ff    	je     8010664e <sys_open+0x6e>
8010671b:	e9 5c ff ff ff       	jmp    8010667c <sys_open+0x9c>

80106720 <sys_mkdir>:

int
sys_mkdir(void)
{
80106720:	55                   	push   %ebp
80106721:	89 e5                	mov    %esp,%ebp
80106723:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106726:	e8 e5 c8 ff ff       	call   80103010 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010672b:	83 ec 08             	sub    $0x8,%esp
8010672e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106731:	50                   	push   %eax
80106732:	6a 00                	push   $0x0
80106734:	e8 f7 f6 ff ff       	call   80105e30 <argstr>
80106739:	83 c4 10             	add    $0x10,%esp
8010673c:	85 c0                	test   %eax,%eax
8010673e:	78 30                	js     80106770 <sys_mkdir+0x50>
80106740:	83 ec 0c             	sub    $0xc,%esp
80106743:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106746:	31 c9                	xor    %ecx,%ecx
80106748:	ba 01 00 00 00       	mov    $0x1,%edx
8010674d:	6a 00                	push   $0x0
8010674f:	e8 7c f7 ff ff       	call   80105ed0 <create>
80106754:	83 c4 10             	add    $0x10,%esp
80106757:	85 c0                	test   %eax,%eax
80106759:	74 15                	je     80106770 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010675b:	83 ec 0c             	sub    $0xc,%esp
8010675e:	50                   	push   %eax
8010675f:	e8 1c b4 ff ff       	call   80101b80 <iunlockput>
  end_op();
80106764:	e8 17 c9 ff ff       	call   80103080 <end_op>
  return 0;
80106769:	83 c4 10             	add    $0x10,%esp
8010676c:	31 c0                	xor    %eax,%eax
}
8010676e:	c9                   	leave  
8010676f:	c3                   	ret    
    end_op();
80106770:	e8 0b c9 ff ff       	call   80103080 <end_op>
    return -1;
80106775:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010677a:	c9                   	leave  
8010677b:	c3                   	ret    
8010677c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106780 <sys_mknod>:

int
sys_mknod(void)
{
80106780:	55                   	push   %ebp
80106781:	89 e5                	mov    %esp,%ebp
80106783:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80106786:	e8 85 c8 ff ff       	call   80103010 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010678b:	83 ec 08             	sub    $0x8,%esp
8010678e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106791:	50                   	push   %eax
80106792:	6a 00                	push   $0x0
80106794:	e8 97 f6 ff ff       	call   80105e30 <argstr>
80106799:	83 c4 10             	add    $0x10,%esp
8010679c:	85 c0                	test   %eax,%eax
8010679e:	78 60                	js     80106800 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801067a0:	83 ec 08             	sub    $0x8,%esp
801067a3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801067a6:	50                   	push   %eax
801067a7:	6a 01                	push   $0x1
801067a9:	e8 d2 f5 ff ff       	call   80105d80 <argint>
  if((argstr(0, &path)) < 0 ||
801067ae:	83 c4 10             	add    $0x10,%esp
801067b1:	85 c0                	test   %eax,%eax
801067b3:	78 4b                	js     80106800 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801067b5:	83 ec 08             	sub    $0x8,%esp
801067b8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801067bb:	50                   	push   %eax
801067bc:	6a 02                	push   $0x2
801067be:	e8 bd f5 ff ff       	call   80105d80 <argint>
     argint(1, &major) < 0 ||
801067c3:	83 c4 10             	add    $0x10,%esp
801067c6:	85 c0                	test   %eax,%eax
801067c8:	78 36                	js     80106800 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801067ca:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801067ce:	83 ec 0c             	sub    $0xc,%esp
801067d1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801067d5:	ba 03 00 00 00       	mov    $0x3,%edx
801067da:	50                   	push   %eax
801067db:	8b 45 ec             	mov    -0x14(%ebp),%eax
801067de:	e8 ed f6 ff ff       	call   80105ed0 <create>
     argint(2, &minor) < 0 ||
801067e3:	83 c4 10             	add    $0x10,%esp
801067e6:	85 c0                	test   %eax,%eax
801067e8:	74 16                	je     80106800 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801067ea:	83 ec 0c             	sub    $0xc,%esp
801067ed:	50                   	push   %eax
801067ee:	e8 8d b3 ff ff       	call   80101b80 <iunlockput>
  end_op();
801067f3:	e8 88 c8 ff ff       	call   80103080 <end_op>
  return 0;
801067f8:	83 c4 10             	add    $0x10,%esp
801067fb:	31 c0                	xor    %eax,%eax
}
801067fd:	c9                   	leave  
801067fe:	c3                   	ret    
801067ff:	90                   	nop
    end_op();
80106800:	e8 7b c8 ff ff       	call   80103080 <end_op>
    return -1;
80106805:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010680a:	c9                   	leave  
8010680b:	c3                   	ret    
8010680c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106810 <sys_chdir>:

int
sys_chdir(void)
{
80106810:	55                   	push   %ebp
80106811:	89 e5                	mov    %esp,%ebp
80106813:	56                   	push   %esi
80106814:	53                   	push   %ebx
80106815:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106818:	e8 f3 d6 ff ff       	call   80103f10 <myproc>
8010681d:	89 c6                	mov    %eax,%esi

  begin_op();
8010681f:	e8 ec c7 ff ff       	call   80103010 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106824:	83 ec 08             	sub    $0x8,%esp
80106827:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010682a:	50                   	push   %eax
8010682b:	6a 00                	push   $0x0
8010682d:	e8 fe f5 ff ff       	call   80105e30 <argstr>
80106832:	83 c4 10             	add    $0x10,%esp
80106835:	85 c0                	test   %eax,%eax
80106837:	78 77                	js     801068b0 <sys_chdir+0xa0>
80106839:	83 ec 0c             	sub    $0xc,%esp
8010683c:	ff 75 f4             	pushl  -0xc(%ebp)
8010683f:	e8 6c b9 ff ff       	call   801021b0 <namei>
80106844:	83 c4 10             	add    $0x10,%esp
80106847:	89 c3                	mov    %eax,%ebx
80106849:	85 c0                	test   %eax,%eax
8010684b:	74 63                	je     801068b0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010684d:	83 ec 0c             	sub    $0xc,%esp
80106850:	50                   	push   %eax
80106851:	e8 7a b0 ff ff       	call   801018d0 <ilock>
  if(ip->type != T_DIR){
80106856:	83 c4 10             	add    $0x10,%esp
80106859:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010685e:	75 30                	jne    80106890 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106860:	83 ec 0c             	sub    $0xc,%esp
80106863:	53                   	push   %ebx
80106864:	e8 67 b1 ff ff       	call   801019d0 <iunlock>
  iput(curproc->cwd);
80106869:	58                   	pop    %eax
8010686a:	ff 76 68             	pushl  0x68(%esi)
8010686d:	e8 ae b1 ff ff       	call   80101a20 <iput>
  end_op();
80106872:	e8 09 c8 ff ff       	call   80103080 <end_op>
  curproc->cwd = ip;
80106877:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010687a:	83 c4 10             	add    $0x10,%esp
8010687d:	31 c0                	xor    %eax,%eax
}
8010687f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106882:	5b                   	pop    %ebx
80106883:	5e                   	pop    %esi
80106884:	5d                   	pop    %ebp
80106885:	c3                   	ret    
80106886:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010688d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80106890:	83 ec 0c             	sub    $0xc,%esp
80106893:	53                   	push   %ebx
80106894:	e8 e7 b2 ff ff       	call   80101b80 <iunlockput>
    end_op();
80106899:	e8 e2 c7 ff ff       	call   80103080 <end_op>
    return -1;
8010689e:	83 c4 10             	add    $0x10,%esp
801068a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801068a6:	eb d7                	jmp    8010687f <sys_chdir+0x6f>
801068a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068af:	90                   	nop
    end_op();
801068b0:	e8 cb c7 ff ff       	call   80103080 <end_op>
    return -1;
801068b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801068ba:	eb c3                	jmp    8010687f <sys_chdir+0x6f>
801068bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801068c0 <sys_exec>:

int
sys_exec(void)
{
801068c0:	55                   	push   %ebp
801068c1:	89 e5                	mov    %esp,%ebp
801068c3:	57                   	push   %edi
801068c4:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801068c5:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801068cb:	53                   	push   %ebx
801068cc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801068d2:	50                   	push   %eax
801068d3:	6a 00                	push   $0x0
801068d5:	e8 56 f5 ff ff       	call   80105e30 <argstr>
801068da:	83 c4 10             	add    $0x10,%esp
801068dd:	85 c0                	test   %eax,%eax
801068df:	0f 88 87 00 00 00    	js     8010696c <sys_exec+0xac>
801068e5:	83 ec 08             	sub    $0x8,%esp
801068e8:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801068ee:	50                   	push   %eax
801068ef:	6a 01                	push   $0x1
801068f1:	e8 8a f4 ff ff       	call   80105d80 <argint>
801068f6:	83 c4 10             	add    $0x10,%esp
801068f9:	85 c0                	test   %eax,%eax
801068fb:	78 6f                	js     8010696c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801068fd:	83 ec 04             	sub    $0x4,%esp
80106900:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
80106906:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106908:	68 80 00 00 00       	push   $0x80
8010690d:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80106913:	6a 00                	push   $0x0
80106915:	50                   	push   %eax
80106916:	e8 85 f1 ff ff       	call   80105aa0 <memset>
8010691b:	83 c4 10             	add    $0x10,%esp
8010691e:	66 90                	xchg   %ax,%ax
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106920:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106926:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
8010692d:	83 ec 08             	sub    $0x8,%esp
80106930:	57                   	push   %edi
80106931:	01 f0                	add    %esi,%eax
80106933:	50                   	push   %eax
80106934:	e8 a7 f3 ff ff       	call   80105ce0 <fetchint>
80106939:	83 c4 10             	add    $0x10,%esp
8010693c:	85 c0                	test   %eax,%eax
8010693e:	78 2c                	js     8010696c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80106940:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80106946:	85 c0                	test   %eax,%eax
80106948:	74 36                	je     80106980 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010694a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80106950:	83 ec 08             	sub    $0x8,%esp
80106953:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80106956:	52                   	push   %edx
80106957:	50                   	push   %eax
80106958:	e8 c3 f3 ff ff       	call   80105d20 <fetchstr>
8010695d:	83 c4 10             	add    $0x10,%esp
80106960:	85 c0                	test   %eax,%eax
80106962:	78 08                	js     8010696c <sys_exec+0xac>
  for(i=0;; i++){
80106964:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80106967:	83 fb 20             	cmp    $0x20,%ebx
8010696a:	75 b4                	jne    80106920 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010696c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010696f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106974:	5b                   	pop    %ebx
80106975:	5e                   	pop    %esi
80106976:	5f                   	pop    %edi
80106977:	5d                   	pop    %ebp
80106978:	c3                   	ret    
80106979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80106980:	83 ec 08             	sub    $0x8,%esp
80106983:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
      argv[i] = 0;
80106989:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80106990:	00 00 00 00 
  return exec(path, argv);
80106994:	50                   	push   %eax
80106995:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010699b:	e8 b0 a1 ff ff       	call   80100b50 <exec>
801069a0:	83 c4 10             	add    $0x10,%esp
}
801069a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801069a6:	5b                   	pop    %ebx
801069a7:	5e                   	pop    %esi
801069a8:	5f                   	pop    %edi
801069a9:	5d                   	pop    %ebp
801069aa:	c3                   	ret    
801069ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801069af:	90                   	nop

801069b0 <sys_pipe>:

int
sys_pipe(void)
{
801069b0:	55                   	push   %ebp
801069b1:	89 e5                	mov    %esp,%ebp
801069b3:	57                   	push   %edi
801069b4:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801069b5:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801069b8:	53                   	push   %ebx
801069b9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801069bc:	6a 08                	push   $0x8
801069be:	50                   	push   %eax
801069bf:	6a 00                	push   $0x0
801069c1:	e8 0a f4 ff ff       	call   80105dd0 <argptr>
801069c6:	83 c4 10             	add    $0x10,%esp
801069c9:	85 c0                	test   %eax,%eax
801069cb:	78 4a                	js     80106a17 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801069cd:	83 ec 08             	sub    $0x8,%esp
801069d0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801069d3:	50                   	push   %eax
801069d4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801069d7:	50                   	push   %eax
801069d8:	e8 e3 cc ff ff       	call   801036c0 <pipealloc>
801069dd:	83 c4 10             	add    $0x10,%esp
801069e0:	85 c0                	test   %eax,%eax
801069e2:	78 33                	js     80106a17 <sys_pipe+0x67>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801069e4:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801069e7:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801069e9:	e8 22 d5 ff ff       	call   80103f10 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801069ee:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
801069f0:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801069f4:	85 f6                	test   %esi,%esi
801069f6:	74 28                	je     80106a20 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
801069f8:	83 c3 01             	add    $0x1,%ebx
801069fb:	83 fb 10             	cmp    $0x10,%ebx
801069fe:	75 f0                	jne    801069f0 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80106a00:	83 ec 0c             	sub    $0xc,%esp
80106a03:	ff 75 e0             	pushl  -0x20(%ebp)
80106a06:	e8 35 a6 ff ff       	call   80101040 <fileclose>
    fileclose(wf);
80106a0b:	58                   	pop    %eax
80106a0c:	ff 75 e4             	pushl  -0x1c(%ebp)
80106a0f:	e8 2c a6 ff ff       	call   80101040 <fileclose>
    return -1;
80106a14:	83 c4 10             	add    $0x10,%esp
80106a17:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a1c:	eb 53                	jmp    80106a71 <sys_pipe+0xc1>
80106a1e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80106a20:	8d 73 08             	lea    0x8(%ebx),%esi
80106a23:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106a27:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80106a2a:	e8 e1 d4 ff ff       	call   80103f10 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106a2f:	31 d2                	xor    %edx,%edx
80106a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80106a38:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80106a3c:	85 c9                	test   %ecx,%ecx
80106a3e:	74 20                	je     80106a60 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
80106a40:	83 c2 01             	add    $0x1,%edx
80106a43:	83 fa 10             	cmp    $0x10,%edx
80106a46:	75 f0                	jne    80106a38 <sys_pipe+0x88>
      myproc()->ofile[fd0] = 0;
80106a48:	e8 c3 d4 ff ff       	call   80103f10 <myproc>
80106a4d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80106a54:	00 
80106a55:	eb a9                	jmp    80106a00 <sys_pipe+0x50>
80106a57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a5e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80106a60:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80106a64:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106a67:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106a69:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106a6c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80106a6f:	31 c0                	xor    %eax,%eax
}
80106a71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a74:	5b                   	pop    %ebx
80106a75:	5e                   	pop    %esi
80106a76:	5f                   	pop    %edi
80106a77:	5d                   	pop    %ebp
80106a78:	c3                   	ret    
80106a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106a80 <sys_chmod>:
int chown(char * filepath, int owner);
int chgrp(char * filepath, int group);

int
sys_chmod(void)
{
80106a80:	55                   	push   %ebp
80106a81:	89 e5                	mov    %esp,%ebp
80106a83:	83 ec 20             	sub    $0x20,%esp
    int mode;
    char * path;

    if(argstr(0,&path)<0 || argint(1,&mode)<0)
80106a86:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106a89:	50                   	push   %eax
80106a8a:	6a 00                	push   $0x0
80106a8c:	e8 9f f3 ff ff       	call   80105e30 <argstr>
80106a91:	83 c4 10             	add    $0x10,%esp
80106a94:	85 c0                	test   %eax,%eax
80106a96:	78 28                	js     80106ac0 <sys_chmod+0x40>
80106a98:	83 ec 08             	sub    $0x8,%esp
80106a9b:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106a9e:	50                   	push   %eax
80106a9f:	6a 01                	push   $0x1
80106aa1:	e8 da f2 ff ff       	call   80105d80 <argint>
80106aa6:	83 c4 10             	add    $0x10,%esp
80106aa9:	85 c0                	test   %eax,%eax
80106aab:	78 13                	js     80106ac0 <sys_chmod+0x40>
        return -1;

    return chmod(path,mode);
80106aad:	83 ec 08             	sub    $0x8,%esp
80106ab0:	ff 75 f0             	pushl  -0x10(%ebp)
80106ab3:	ff 75 f4             	pushl  -0xc(%ebp)
80106ab6:	e8 35 b7 ff ff       	call   801021f0 <chmod>
80106abb:	83 c4 10             	add    $0x10,%esp
}
80106abe:	c9                   	leave  
80106abf:	c3                   	ret    
80106ac0:	c9                   	leave  
        return -1;
80106ac1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ac6:	c3                   	ret    
80106ac7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ace:	66 90                	xchg   %ax,%ax

80106ad0 <sys_chown>:

int
sys_chown(void)
{
80106ad0:	55                   	push   %ebp
80106ad1:	89 e5                	mov    %esp,%ebp
80106ad3:	83 ec 20             	sub    $0x20,%esp
    int owner;
    char * path;

    if(argint(1,&owner)<0 || argstr(0,&path)<0)
80106ad6:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106ad9:	50                   	push   %eax
80106ada:	6a 01                	push   $0x1
80106adc:	e8 9f f2 ff ff       	call   80105d80 <argint>
80106ae1:	83 c4 10             	add    $0x10,%esp
80106ae4:	85 c0                	test   %eax,%eax
80106ae6:	78 28                	js     80106b10 <sys_chown+0x40>
80106ae8:	83 ec 08             	sub    $0x8,%esp
80106aeb:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106aee:	50                   	push   %eax
80106aef:	6a 00                	push   $0x0
80106af1:	e8 3a f3 ff ff       	call   80105e30 <argstr>
80106af6:	83 c4 10             	add    $0x10,%esp
80106af9:	85 c0                	test   %eax,%eax
80106afb:	78 13                	js     80106b10 <sys_chown+0x40>
        return -1;

    return chown(path,owner);
80106afd:	83 ec 08             	sub    $0x8,%esp
80106b00:	ff 75 f0             	pushl  -0x10(%ebp)
80106b03:	ff 75 f4             	pushl  -0xc(%ebp)
80106b06:	e8 65 b7 ff ff       	call   80102270 <chown>
80106b0b:	83 c4 10             	add    $0x10,%esp
}
80106b0e:	c9                   	leave  
80106b0f:	c3                   	ret    
80106b10:	c9                   	leave  
        return -1;
80106b11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b16:	c3                   	ret    
80106b17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b1e:	66 90                	xchg   %ax,%ax

80106b20 <sys_chgrp>:

int
sys_chgrp(void)
{
80106b20:	55                   	push   %ebp
80106b21:	89 e5                	mov    %esp,%ebp
80106b23:	83 ec 20             	sub    $0x20,%esp
    int group;
    char * path;

    if(argstr(0,&path)<0 || argint(1,&group)<0)
80106b26:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106b29:	50                   	push   %eax
80106b2a:	6a 00                	push   $0x0
80106b2c:	e8 ff f2 ff ff       	call   80105e30 <argstr>
80106b31:	83 c4 10             	add    $0x10,%esp
80106b34:	85 c0                	test   %eax,%eax
80106b36:	78 28                	js     80106b60 <sys_chgrp+0x40>
80106b38:	83 ec 08             	sub    $0x8,%esp
80106b3b:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106b3e:	50                   	push   %eax
80106b3f:	6a 01                	push   $0x1
80106b41:	e8 3a f2 ff ff       	call   80105d80 <argint>
80106b46:	83 c4 10             	add    $0x10,%esp
80106b49:	85 c0                	test   %eax,%eax
80106b4b:	78 13                	js     80106b60 <sys_chgrp+0x40>
        return -1;

    return chgrp(path,group);
80106b4d:	83 ec 08             	sub    $0x8,%esp
80106b50:	ff 75 f0             	pushl  -0x10(%ebp)
80106b53:	ff 75 f4             	pushl  -0xc(%ebp)
80106b56:	e8 95 b7 ff ff       	call   801022f0 <chgrp>
80106b5b:	83 c4 10             	add    $0x10,%esp
}
80106b5e:	c9                   	leave  
80106b5f:	c3                   	ret    
80106b60:	c9                   	leave  
        return -1;
80106b61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b66:	c3                   	ret    
80106b67:	66 90                	xchg   %ax,%ax
80106b69:	66 90                	xchg   %ax,%ax
80106b6b:	66 90                	xchg   %ax,%ax
80106b6d:	66 90                	xchg   %ax,%ax
80106b6f:	90                   	nop

80106b70 <sys_fork>:


int
sys_fork(void)
{
  return fork();
80106b70:	e9 cb d6 ff ff       	jmp    80104240 <fork>
80106b75:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106b80 <sys_exit>:
}

int
sys_exit(void)
{
80106b80:	55                   	push   %ebp
80106b81:	89 e5                	mov    %esp,%ebp
80106b83:	83 ec 08             	sub    $0x8,%esp
  exit();
80106b86:	e8 95 dc ff ff       	call   80104820 <exit>
  return 0;  // not reached
}
80106b8b:	31 c0                	xor    %eax,%eax
80106b8d:	c9                   	leave  
80106b8e:	c3                   	ret    
80106b8f:	90                   	nop

80106b90 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80106b90:	e9 bb e1 ff ff       	jmp    80104d50 <wait>
80106b95:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106ba0 <sys_kill>:
}

int
sys_kill(void)
{
80106ba0:	55                   	push   %ebp
80106ba1:	89 e5                	mov    %esp,%ebp
80106ba3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106ba6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106ba9:	50                   	push   %eax
80106baa:	6a 00                	push   $0x0
80106bac:	e8 cf f1 ff ff       	call   80105d80 <argint>
80106bb1:	83 c4 10             	add    $0x10,%esp
80106bb4:	85 c0                	test   %eax,%eax
80106bb6:	78 18                	js     80106bd0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106bb8:	83 ec 0c             	sub    $0xc,%esp
80106bbb:	ff 75 f4             	pushl  -0xc(%ebp)
80106bbe:	e8 cd e3 ff ff       	call   80104f90 <kill>
80106bc3:	83 c4 10             	add    $0x10,%esp
}
80106bc6:	c9                   	leave  
80106bc7:	c3                   	ret    
80106bc8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106bcf:	90                   	nop
80106bd0:	c9                   	leave  
    return -1;
80106bd1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106bd6:	c3                   	ret    
80106bd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106bde:	66 90                	xchg   %ax,%ax

80106be0 <sys_getpid>:

int
sys_getpid(void)
{
80106be0:	55                   	push   %ebp
80106be1:	89 e5                	mov    %esp,%ebp
80106be3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106be6:	e8 25 d3 ff ff       	call   80103f10 <myproc>
80106beb:	8b 40 10             	mov    0x10(%eax),%eax
}
80106bee:	c9                   	leave  
80106bef:	c3                   	ret    

80106bf0 <sys_sbrk>:

int
sys_sbrk(void)
{
80106bf0:	55                   	push   %ebp
80106bf1:	89 e5                	mov    %esp,%ebp
80106bf3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106bf4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106bf7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80106bfa:	50                   	push   %eax
80106bfb:	6a 00                	push   $0x0
80106bfd:	e8 7e f1 ff ff       	call   80105d80 <argint>
80106c02:	83 c4 10             	add    $0x10,%esp
80106c05:	85 c0                	test   %eax,%eax
80106c07:	78 27                	js     80106c30 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106c09:	e8 02 d3 ff ff       	call   80103f10 <myproc>
  if(growproc(n) < 0)
80106c0e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80106c11:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106c13:	ff 75 f4             	pushl  -0xc(%ebp)
80106c16:	e8 a5 d5 ff ff       	call   801041c0 <growproc>
80106c1b:	83 c4 10             	add    $0x10,%esp
80106c1e:	85 c0                	test   %eax,%eax
80106c20:	78 0e                	js     80106c30 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106c22:	89 d8                	mov    %ebx,%eax
80106c24:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106c27:	c9                   	leave  
80106c28:	c3                   	ret    
80106c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106c30:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106c35:	eb eb                	jmp    80106c22 <sys_sbrk+0x32>
80106c37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c3e:	66 90                	xchg   %ax,%ax

80106c40 <sys_sleep>:

int
sys_sleep(void)
{
80106c40:	55                   	push   %ebp
80106c41:	89 e5                	mov    %esp,%ebp
80106c43:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106c44:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106c47:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80106c4a:	50                   	push   %eax
80106c4b:	6a 00                	push   $0x0
80106c4d:	e8 2e f1 ff ff       	call   80105d80 <argint>
80106c52:	83 c4 10             	add    $0x10,%esp
80106c55:	85 c0                	test   %eax,%eax
80106c57:	78 41                	js     80106c9a <sys_sleep+0x5a>
    return -1;
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106c59:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80106c5c:	8b 1d 20 7d 11 80    	mov    0x80117d20,%ebx
  while(ticks - ticks0 < n){
80106c62:	85 d2                	test   %edx,%edx
80106c64:	75 28                	jne    80106c8e <sys_sleep+0x4e>
80106c66:	eb 40                	jmp    80106ca8 <sys_sleep+0x68>
80106c68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c6f:	90                   	nop
    if(myproc()->killed){
      return -1;
    }
    sleep(&ticks, (struct spinlock *)0);
80106c70:	83 ec 08             	sub    $0x8,%esp
80106c73:	6a 00                	push   $0x0
80106c75:	68 20 7d 11 80       	push   $0x80117d20
80106c7a:	e8 31 df ff ff       	call   80104bb0 <sleep>
  while(ticks - ticks0 < n){
80106c7f:	a1 20 7d 11 80       	mov    0x80117d20,%eax
80106c84:	83 c4 10             	add    $0x10,%esp
80106c87:	29 d8                	sub    %ebx,%eax
80106c89:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80106c8c:	73 1a                	jae    80106ca8 <sys_sleep+0x68>
    if(myproc()->killed){
80106c8e:	e8 7d d2 ff ff       	call   80103f10 <myproc>
80106c93:	8b 40 24             	mov    0x24(%eax),%eax
80106c96:	85 c0                	test   %eax,%eax
80106c98:	74 d6                	je     80106c70 <sys_sleep+0x30>
    return -1;
80106c9a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80106c9f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106ca2:	c9                   	leave  
80106ca3:	c3                   	ret    
80106ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return 0;
80106ca8:	31 c0                	xor    %eax,%eax
}
80106caa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106cad:	c9                   	leave  
80106cae:	c3                   	ret    
80106caf:	90                   	nop

80106cb0 <sys_uptime>:
{
  uint xticks;

  xticks = ticks;
  return xticks;
}
80106cb0:	a1 20 7d 11 80       	mov    0x80117d20,%eax
80106cb5:	c3                   	ret    
80106cb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106cbd:	8d 76 00             	lea    0x0(%esi),%esi

80106cc0 <sys_halt>:

#ifdef PDX_XV6
// Turn off the computer
int
sys_halt(void)
{
80106cc0:	55                   	push   %ebp
80106cc1:	89 e5                	mov    %esp,%ebp
80106cc3:	83 ec 14             	sub    $0x14,%esp
  cprintf("Shutting down ...\n");
80106cc6:	68 6d 92 10 80       	push   $0x8010926d
80106ccb:	e8 e0 99 ff ff       	call   801006b0 <cprintf>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106cd0:	b8 00 20 00 00       	mov    $0x2000,%eax
80106cd5:	ba 04 06 00 00       	mov    $0x604,%edx
80106cda:	66 ef                	out    %ax,(%dx)
  outw( 0x604, 0x0 | 0x2000);
  return 0;
}
80106cdc:	c9                   	leave  
80106cdd:	31 c0                	xor    %eax,%eax
80106cdf:	c3                   	ret    

80106ce0 <sys_date>:
#endif // PDX_XV6

#ifdef CS333_P1
int
sys_date(void)
{
80106ce0:	55                   	push   %ebp
80106ce1:	89 e5                	mov    %esp,%ebp
80106ce3:	83 ec 1c             	sub    $0x1c,%esp
    struct rtcdate *d;

    if(argptr(0, (void*)&d, sizeof(struct rtcdate)) < 0){
80106ce6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106ce9:	6a 18                	push   $0x18
80106ceb:	50                   	push   %eax
80106cec:	6a 00                	push   $0x0
80106cee:	e8 dd f0 ff ff       	call   80105dd0 <argptr>
80106cf3:	83 c4 10             	add    $0x10,%esp
80106cf6:	85 c0                	test   %eax,%eax
80106cf8:	78 16                	js     80106d10 <sys_date+0x30>
        return -1;
    } else{
        cmostime(d);
80106cfa:	83 ec 0c             	sub    $0xc,%esp
80106cfd:	ff 75 f4             	pushl  -0xc(%ebp)
80106d00:	e8 7b bf ff ff       	call   80102c80 <cmostime>
        return 0;
80106d05:	83 c4 10             	add    $0x10,%esp
80106d08:	31 c0                	xor    %eax,%eax
    }
}
80106d0a:	c9                   	leave  
80106d0b:	c3                   	ret    
80106d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106d10:	c9                   	leave  
        return -1;
80106d11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106d16:	c3                   	ret    
80106d17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d1e:	66 90                	xchg   %ax,%ax

80106d20 <sys_getuid>:
#endif

#ifdef CS333_P2
int
sys_getuid(void){
80106d20:	55                   	push   %ebp
80106d21:	89 e5                	mov    %esp,%ebp
80106d23:	83 ec 08             	sub    $0x8,%esp
    return myproc()->uid;
80106d26:	e8 e5 d1 ff ff       	call   80103f10 <myproc>
80106d2b:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
}
80106d31:	c9                   	leave  
80106d32:	c3                   	ret    
80106d33:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106d40 <sys_getgid>:

int
sys_getgid(void){
80106d40:	55                   	push   %ebp
80106d41:	89 e5                	mov    %esp,%ebp
80106d43:	83 ec 08             	sub    $0x8,%esp
    return myproc()->gid;
80106d46:	e8 c5 d1 ff ff       	call   80103f10 <myproc>
80106d4b:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
}
80106d51:	c9                   	leave  
80106d52:	c3                   	ret    
80106d53:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106d60 <sys_getppid>:

int
sys_getppid(void){
80106d60:	55                   	push   %ebp
80106d61:	89 e5                	mov    %esp,%ebp
80106d63:	83 ec 08             	sub    $0x8,%esp
    return myproc()->parent->pid;
80106d66:	e8 a5 d1 ff ff       	call   80103f10 <myproc>
80106d6b:	8b 40 14             	mov    0x14(%eax),%eax
80106d6e:	8b 40 10             	mov    0x10(%eax),%eax
}
80106d71:	c9                   	leave  
80106d72:	c3                   	ret    
80106d73:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106d80 <sys_setuid>:

int
sys_setuid(void){
80106d80:	55                   	push   %ebp
80106d81:	89 e5                	mov    %esp,%ebp
80106d83:	53                   	push   %ebx
    
    int uid;
    
    if(argint(0 ,&uid) < 0) 
80106d84:	8d 45 f4             	lea    -0xc(%ebp),%eax
sys_setuid(void){
80106d87:	83 ec 1c             	sub    $0x1c,%esp
    if(argint(0 ,&uid) < 0) 
80106d8a:	50                   	push   %eax
80106d8b:	6a 00                	push   $0x0
80106d8d:	e8 ee ef ff ff       	call   80105d80 <argint>
80106d92:	83 c4 10             	add    $0x10,%esp
80106d95:	85 c0                	test   %eax,%eax
80106d97:	78 27                	js     80106dc0 <sys_setuid+0x40>
       return -1;
    
    if(uid < 0 || uid > 32767)
80106d99:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80106d9c:	81 fb ff 7f 00 00    	cmp    $0x7fff,%ebx
80106da2:	77 1c                	ja     80106dc0 <sys_setuid+0x40>
       return -1;
    
    myproc()->uid = uid;
80106da4:	e8 67 d1 ff ff       	call   80103f10 <myproc>
80106da9:	89 98 84 00 00 00    	mov    %ebx,0x84(%eax)
    return 0;
80106daf:	31 c0                	xor    %eax,%eax
}
80106db1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106db4:	c9                   	leave  
80106db5:	c3                   	ret    
80106db6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106dbd:	8d 76 00             	lea    0x0(%esi),%esi
       return -1;
80106dc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106dc5:	eb ea                	jmp    80106db1 <sys_setuid+0x31>
80106dc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106dce:	66 90                	xchg   %ax,%ax

80106dd0 <sys_setgid>:

int
sys_setgid(void){
80106dd0:	55                   	push   %ebp
80106dd1:	89 e5                	mov    %esp,%ebp
80106dd3:	53                   	push   %ebx

    int gid;

    if(argint(0, &gid) < 0)
80106dd4:	8d 45 f4             	lea    -0xc(%ebp),%eax
sys_setgid(void){
80106dd7:	83 ec 1c             	sub    $0x1c,%esp
    if(argint(0, &gid) < 0)
80106dda:	50                   	push   %eax
80106ddb:	6a 00                	push   $0x0
80106ddd:	e8 9e ef ff ff       	call   80105d80 <argint>
80106de2:	83 c4 10             	add    $0x10,%esp
80106de5:	85 c0                	test   %eax,%eax
80106de7:	78 27                	js     80106e10 <sys_setgid+0x40>
        return -1;
    
    if(gid < 0 || gid > 32767)
80106de9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80106dec:	81 fb ff 7f 00 00    	cmp    $0x7fff,%ebx
80106df2:	77 1c                	ja     80106e10 <sys_setgid+0x40>
        return -1;

    myproc()->gid = gid;
80106df4:	e8 17 d1 ff ff       	call   80103f10 <myproc>
80106df9:	89 98 80 00 00 00    	mov    %ebx,0x80(%eax)
    return 0;
80106dff:	31 c0                	xor    %eax,%eax
}
80106e01:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106e04:	c9                   	leave  
80106e05:	c3                   	ret    
80106e06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e0d:	8d 76 00             	lea    0x0(%esi),%esi
        return -1;
80106e10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106e15:	eb ea                	jmp    80106e01 <sys_setgid+0x31>
80106e17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e1e:	66 90                	xchg   %ax,%ax

80106e20 <sys_getprocs>:


int
sys_getprocs(void){
80106e20:	55                   	push   %ebp
80106e21:	89 e5                	mov    %esp,%ebp
80106e23:	83 ec 20             	sub    $0x20,%esp
    int max;
    struct uproc * ptable;

    if(argint(0, &max)<0)
80106e26:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106e29:	50                   	push   %eax
80106e2a:	6a 00                	push   $0x0
80106e2c:	e8 4f ef ff ff       	call   80105d80 <argint>
80106e31:	83 c4 10             	add    $0x10,%esp
80106e34:	85 c0                	test   %eax,%eax
80106e36:	78 38                	js     80106e70 <sys_getprocs+0x50>
        return -1;

    if(argptr(1, (void*)&ptable, sizeof(struct uproc) * max) < 0)
80106e38:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106e3b:	83 ec 04             	sub    $0x4,%esp
80106e3e:	8d 04 40             	lea    (%eax,%eax,2),%eax
80106e41:	c1 e0 05             	shl    $0x5,%eax
80106e44:	50                   	push   %eax
80106e45:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106e48:	50                   	push   %eax
80106e49:	6a 01                	push   $0x1
80106e4b:	e8 80 ef ff ff       	call   80105dd0 <argptr>
80106e50:	83 c4 10             	add    $0x10,%esp
80106e53:	85 c0                	test   %eax,%eax
80106e55:	78 19                	js     80106e70 <sys_getprocs+0x50>
        return -1;
    
    return getprocs(max, ptable);
80106e57:	83 ec 08             	sub    $0x8,%esp
80106e5a:	ff 75 f4             	pushl  -0xc(%ebp)
80106e5d:	ff 75 f0             	pushl  -0x10(%ebp)
80106e60:	e8 0b e4 ff ff       	call   80105270 <getprocs>
80106e65:	83 c4 10             	add    $0x10,%esp
}
80106e68:	c9                   	leave  
80106e69:	c3                   	ret    
80106e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e70:	c9                   	leave  
        return -1;
80106e71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e76:	c3                   	ret    
80106e77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e7e:	66 90                	xchg   %ax,%ax

80106e80 <sys_setpriority>:
#endif

#ifdef CS333_P4
int
sys_setpriority(void)
{
80106e80:	55                   	push   %ebp
80106e81:	89 e5                	mov    %esp,%ebp
80106e83:	83 ec 20             	sub    $0x20,%esp
    int pid,priority;

    if(argint(0,&pid)<0)
80106e86:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106e89:	50                   	push   %eax
80106e8a:	6a 00                	push   $0x0
80106e8c:	e8 ef ee ff ff       	call   80105d80 <argint>
80106e91:	83 c4 10             	add    $0x10,%esp
80106e94:	85 c0                	test   %eax,%eax
80106e96:	78 28                	js     80106ec0 <sys_setpriority+0x40>
        return -1;
    if(argint(1,&priority)<0)
80106e98:	83 ec 08             	sub    $0x8,%esp
80106e9b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106e9e:	50                   	push   %eax
80106e9f:	6a 01                	push   $0x1
80106ea1:	e8 da ee ff ff       	call   80105d80 <argint>
80106ea6:	83 c4 10             	add    $0x10,%esp
80106ea9:	85 c0                	test   %eax,%eax
80106eab:	78 13                	js     80106ec0 <sys_setpriority+0x40>
        return -1;
    return setpriority(pid,priority);
80106ead:	83 ec 08             	sub    $0x8,%esp
80106eb0:	ff 75 f4             	pushl  -0xc(%ebp)
80106eb3:	ff 75 f0             	pushl  -0x10(%ebp)
80106eb6:	e8 a5 e6 ff ff       	call   80105560 <setpriority>
80106ebb:	83 c4 10             	add    $0x10,%esp
}
80106ebe:	c9                   	leave  
80106ebf:	c3                   	ret    
80106ec0:	c9                   	leave  
        return -1;
80106ec1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ec6:	c3                   	ret    
80106ec7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ece:	66 90                	xchg   %ax,%ax

80106ed0 <sys_getpriority>:

int
sys_getpriority(void)
{
80106ed0:	55                   	push   %ebp
80106ed1:	89 e5                	mov    %esp,%ebp
80106ed3:	83 ec 20             	sub    $0x20,%esp
    int pid;
    if(argint(0,&pid)<0)
80106ed6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106ed9:	50                   	push   %eax
80106eda:	6a 00                	push   $0x0
80106edc:	e8 9f ee ff ff       	call   80105d80 <argint>
80106ee1:	83 c4 10             	add    $0x10,%esp
80106ee4:	85 c0                	test   %eax,%eax
80106ee6:	78 18                	js     80106f00 <sys_getpriority+0x30>
        return -1;
    return getpriority(pid);
80106ee8:	83 ec 0c             	sub    $0xc,%esp
80106eeb:	ff 75 f4             	pushl  -0xc(%ebp)
80106eee:	e8 dd e7 ff ff       	call   801056d0 <getpriority>
80106ef3:	83 c4 10             	add    $0x10,%esp
}
80106ef6:	c9                   	leave  
80106ef7:	c3                   	ret    
80106ef8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106eff:	90                   	nop
80106f00:	c9                   	leave  
        return -1;
80106f01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106f06:	c3                   	ret    

80106f07 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106f07:	1e                   	push   %ds
  pushl %es
80106f08:	06                   	push   %es
  pushl %fs
80106f09:	0f a0                	push   %fs
  pushl %gs
80106f0b:	0f a8                	push   %gs
  pushal
80106f0d:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106f0e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106f12:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106f14:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106f16:	54                   	push   %esp
  call trap
80106f17:	e8 a4 00 00 00       	call   80106fc0 <trap>
  addl $4, %esp
80106f1c:	83 c4 04             	add    $0x4,%esp

80106f1f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106f1f:	61                   	popa   
  popl %gs
80106f20:	0f a9                	pop    %gs
  popl %fs
80106f22:	0f a1                	pop    %fs
  popl %es
80106f24:	07                   	pop    %es
  popl %ds
80106f25:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106f26:	83 c4 08             	add    $0x8,%esp
  iret
80106f29:	cf                   	iret   
80106f2a:	66 90                	xchg   %ax,%ax
80106f2c:	66 90                	xchg   %ax,%ax
80106f2e:	66 90                	xchg   %ax,%ax

80106f30 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80106f30:	31 c0                	xor    %eax,%eax
80106f32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106f38:	8b 14 85 08 c0 10 80 	mov    -0x7fef3ff8(,%eax,4),%edx
80106f3f:	c7 04 c5 22 75 11 80 	movl   $0x8e000008,-0x7fee8ade(,%eax,8)
80106f46:	08 00 00 8e 
80106f4a:	66 89 14 c5 20 75 11 	mov    %dx,-0x7fee8ae0(,%eax,8)
80106f51:	80 
80106f52:	c1 ea 10             	shr    $0x10,%edx
80106f55:	66 89 14 c5 26 75 11 	mov    %dx,-0x7fee8ada(,%eax,8)
80106f5c:	80 
  for(i = 0; i < 256; i++)
80106f5d:	83 c0 01             	add    $0x1,%eax
80106f60:	3d 00 01 00 00       	cmp    $0x100,%eax
80106f65:	75 d1                	jne    80106f38 <tvinit+0x8>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106f67:	a1 08 c1 10 80       	mov    0x8010c108,%eax
80106f6c:	c7 05 22 77 11 80 08 	movl   $0xef000008,0x80117722
80106f73:	00 00 ef 
80106f76:	66 a3 20 77 11 80    	mov    %ax,0x80117720
80106f7c:	c1 e8 10             	shr    $0x10,%eax
80106f7f:	66 a3 26 77 11 80    	mov    %ax,0x80117726

#ifndef PDX_XV6
  initlock(&tickslock, "time");
#endif // PDX_XV6
}
80106f85:	c3                   	ret    
80106f86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f8d:	8d 76 00             	lea    0x0(%esi),%esi

80106f90 <idtinit>:

void
idtinit(void)
{
80106f90:	55                   	push   %ebp
  pd[0] = size-1;
80106f91:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106f96:	89 e5                	mov    %esp,%ebp
80106f98:	83 ec 10             	sub    $0x10,%esp
80106f9b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106f9f:	b8 20 75 11 80       	mov    $0x80117520,%eax
80106fa4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106fa8:	c1 e8 10             	shr    $0x10,%eax
80106fab:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80106faf:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106fb2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106fb5:	c9                   	leave  
80106fb6:	c3                   	ret    
80106fb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fbe:	66 90                	xchg   %ax,%ax

80106fc0 <trap>:

void
trap(struct trapframe *tf)
{
80106fc0:	55                   	push   %ebp
80106fc1:	89 e5                	mov    %esp,%ebp
80106fc3:	57                   	push   %edi
80106fc4:	56                   	push   %esi
80106fc5:	53                   	push   %ebx
80106fc6:	83 ec 1c             	sub    $0x1c,%esp
80106fc9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80106fcc:	8b 47 30             	mov    0x30(%edi),%eax
80106fcf:	83 f8 40             	cmp    $0x40,%eax
80106fd2:	0f 84 d8 01 00 00    	je     801071b0 <trap+0x1f0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106fd8:	83 e8 20             	sub    $0x20,%eax
80106fdb:	83 f8 1f             	cmp    $0x1f,%eax
80106fde:	77 10                	ja     80106ff0 <trap+0x30>
80106fe0:	ff 24 85 20 93 10 80 	jmp    *-0x7fef6ce0(,%eax,4)
80106fe7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fee:	66 90                	xchg   %ax,%ax
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
    break;

  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80106ff0:	e8 1b cf ff ff       	call   80103f10 <myproc>
80106ff5:	8b 5f 38             	mov    0x38(%edi),%ebx
80106ff8:	85 c0                	test   %eax,%eax
80106ffa:	0f 84 1f 02 00 00    	je     8010721f <trap+0x25f>
80107000:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80107004:	0f 84 15 02 00 00    	je     8010721f <trap+0x25f>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010700a:	0f 20 d1             	mov    %cr2,%ecx
8010700d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107010:	e8 db ce ff ff       	call   80103ef0 <cpuid>
80107015:	8b 77 30             	mov    0x30(%edi),%esi
80107018:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010701b:	8b 47 34             	mov    0x34(%edi),%eax
8010701e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80107021:	e8 ea ce ff ff       	call   80103f10 <myproc>
80107026:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107029:	e8 e2 ce ff ff       	call   80103f10 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010702e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80107031:	8b 55 dc             	mov    -0x24(%ebp),%edx
80107034:	51                   	push   %ecx
80107035:	53                   	push   %ebx
80107036:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80107037:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010703a:	ff 75 e4             	pushl  -0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
8010703d:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107040:	56                   	push   %esi
80107041:	52                   	push   %edx
80107042:	ff 70 10             	pushl  0x10(%eax)
80107045:	68 d8 92 10 80       	push   $0x801092d8
8010704a:	e8 61 96 ff ff       	call   801006b0 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
8010704f:	83 c4 20             	add    $0x20,%esp
80107052:	e8 b9 ce ff ff       	call   80103f10 <myproc>
80107057:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010705e:	e8 ad ce ff ff       	call   80103f10 <myproc>
80107063:	85 c0                	test   %eax,%eax
80107065:	74 1d                	je     80107084 <trap+0xc4>
80107067:	e8 a4 ce ff ff       	call   80103f10 <myproc>
8010706c:	8b 50 24             	mov    0x24(%eax),%edx
8010706f:	85 d2                	test   %edx,%edx
80107071:	74 11                	je     80107084 <trap+0xc4>
80107073:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80107077:	83 e0 03             	and    $0x3,%eax
8010707a:	66 83 f8 03          	cmp    $0x3,%ax
8010707e:	0f 84 64 01 00 00    	je     801071e8 <trap+0x228>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80107084:	e8 87 ce ff ff       	call   80103f10 <myproc>
80107089:	85 c0                	test   %eax,%eax
8010708b:	74 0b                	je     80107098 <trap+0xd8>
8010708d:	e8 7e ce ff ff       	call   80103f10 <myproc>
80107092:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80107096:	74 38                	je     801070d0 <trap+0x110>
    tf->trapno == T_IRQ0+IRQ_TIMER)
#endif // PDX_XV6
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107098:	e8 73 ce ff ff       	call   80103f10 <myproc>
8010709d:	85 c0                	test   %eax,%eax
8010709f:	74 1d                	je     801070be <trap+0xfe>
801070a1:	e8 6a ce ff ff       	call   80103f10 <myproc>
801070a6:	8b 40 24             	mov    0x24(%eax),%eax
801070a9:	85 c0                	test   %eax,%eax
801070ab:	74 11                	je     801070be <trap+0xfe>
801070ad:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801070b1:	83 e0 03             	and    $0x3,%eax
801070b4:	66 83 f8 03          	cmp    $0x3,%ax
801070b8:	0f 84 1b 01 00 00    	je     801071d9 <trap+0x219>
    exit();
}
801070be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070c1:	5b                   	pop    %ebx
801070c2:	5e                   	pop    %esi
801070c3:	5f                   	pop    %edi
801070c4:	5d                   	pop    %ebp
801070c5:	c3                   	ret    
801070c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070cd:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
801070d0:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
801070d4:	75 c2                	jne    80107098 <trap+0xd8>
    tf->trapno == T_IRQ0+IRQ_TIMER && ticks%SCHED_INTERVAL==0)
801070d6:	8b 0d 20 7d 11 80    	mov    0x80117d20,%ecx
801070dc:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801070e1:	89 c8                	mov    %ecx,%eax
801070e3:	f7 e2                	mul    %edx
801070e5:	c1 ea 03             	shr    $0x3,%edx
801070e8:	8d 04 92             	lea    (%edx,%edx,4),%eax
801070eb:	01 c0                	add    %eax,%eax
801070ed:	39 c1                	cmp    %eax,%ecx
801070ef:	75 a7                	jne    80107098 <trap+0xd8>
    yield();
801070f1:	e8 7a d9 ff ff       	call   80104a70 <yield>
801070f6:	eb a0                	jmp    80107098 <trap+0xd8>
801070f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070ff:	90                   	nop
    if(cpuid() == 0){
80107100:	e8 eb cd ff ff       	call   80103ef0 <cpuid>
80107105:	85 c0                	test   %eax,%eax
80107107:	0f 84 eb 00 00 00    	je     801071f8 <trap+0x238>
    lapiceoi();
8010710d:	e8 ae ba ff ff       	call   80102bc0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107112:	e8 f9 cd ff ff       	call   80103f10 <myproc>
80107117:	85 c0                	test   %eax,%eax
80107119:	0f 85 48 ff ff ff    	jne    80107067 <trap+0xa7>
8010711f:	e9 60 ff ff ff       	jmp    80107084 <trap+0xc4>
80107124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80107128:	e8 53 b9 ff ff       	call   80102a80 <kbdintr>
    lapiceoi();
8010712d:	e8 8e ba ff ff       	call   80102bc0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107132:	e8 d9 cd ff ff       	call   80103f10 <myproc>
80107137:	85 c0                	test   %eax,%eax
80107139:	0f 85 28 ff ff ff    	jne    80107067 <trap+0xa7>
8010713f:	e9 40 ff ff ff       	jmp    80107084 <trap+0xc4>
80107144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80107148:	e8 73 02 00 00       	call   801073c0 <uartintr>
    lapiceoi();
8010714d:	e8 6e ba ff ff       	call   80102bc0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107152:	e8 b9 cd ff ff       	call   80103f10 <myproc>
80107157:	85 c0                	test   %eax,%eax
80107159:	0f 85 08 ff ff ff    	jne    80107067 <trap+0xa7>
8010715f:	e9 20 ff ff ff       	jmp    80107084 <trap+0xc4>
80107164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80107168:	8b 77 38             	mov    0x38(%edi),%esi
8010716b:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
8010716f:	e8 7c cd ff ff       	call   80103ef0 <cpuid>
80107174:	56                   	push   %esi
80107175:	53                   	push   %ebx
80107176:	50                   	push   %eax
80107177:	68 80 92 10 80       	push   $0x80109280
8010717c:	e8 2f 95 ff ff       	call   801006b0 <cprintf>
    lapiceoi();
80107181:	e8 3a ba ff ff       	call   80102bc0 <lapiceoi>
    break;
80107186:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107189:	e8 82 cd ff ff       	call   80103f10 <myproc>
8010718e:	85 c0                	test   %eax,%eax
80107190:	0f 85 d1 fe ff ff    	jne    80107067 <trap+0xa7>
80107196:	e9 e9 fe ff ff       	jmp    80107084 <trap+0xc4>
8010719b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010719f:	90                   	nop
    ideintr();
801071a0:	e8 2b b3 ff ff       	call   801024d0 <ideintr>
801071a5:	e9 63 ff ff ff       	jmp    8010710d <trap+0x14d>
801071aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
801071b0:	e8 5b cd ff ff       	call   80103f10 <myproc>
801071b5:	8b 58 24             	mov    0x24(%eax),%ebx
801071b8:	85 db                	test   %ebx,%ebx
801071ba:	75 5c                	jne    80107218 <trap+0x258>
    myproc()->tf = tf;
801071bc:	e8 4f cd ff ff       	call   80103f10 <myproc>
801071c1:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
801071c4:	e8 a7 ec ff ff       	call   80105e70 <syscall>
    if(myproc()->killed)
801071c9:	e8 42 cd ff ff       	call   80103f10 <myproc>
801071ce:	8b 48 24             	mov    0x24(%eax),%ecx
801071d1:	85 c9                	test   %ecx,%ecx
801071d3:	0f 84 e5 fe ff ff    	je     801070be <trap+0xfe>
}
801071d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801071dc:	5b                   	pop    %ebx
801071dd:	5e                   	pop    %esi
801071de:	5f                   	pop    %edi
801071df:	5d                   	pop    %ebp
      exit();
801071e0:	e9 3b d6 ff ff       	jmp    80104820 <exit>
801071e5:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
801071e8:	e8 33 d6 ff ff       	call   80104820 <exit>
801071ed:	e9 92 fe ff ff       	jmp    80107084 <trap+0xc4>
801071f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
// atom_inc() necessary for removal of tickslock
// other atomic ops added for completeness
static inline void
atom_inc(volatile int *num)
{
  asm volatile ( "lock incl %0" : "=m" (*num));
801071f8:	f0 ff 05 20 7d 11 80 	lock incl 0x80117d20
      wakeup(&ticks);
801071ff:	83 ec 0c             	sub    $0xc,%esp
80107202:	68 20 7d 11 80       	push   $0x80117d20
80107207:	e8 54 dd ff ff       	call   80104f60 <wakeup>
8010720c:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
8010720f:	e9 f9 fe ff ff       	jmp    8010710d <trap+0x14d>
80107214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      exit();
80107218:	e8 03 d6 ff ff       	call   80104820 <exit>
8010721d:	eb 9d                	jmp    801071bc <trap+0x1fc>
8010721f:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80107222:	e8 c9 cc ff ff       	call   80103ef0 <cpuid>
80107227:	83 ec 0c             	sub    $0xc,%esp
8010722a:	56                   	push   %esi
8010722b:	53                   	push   %ebx
8010722c:	50                   	push   %eax
8010722d:	ff 77 30             	pushl  0x30(%edi)
80107230:	68 a4 92 10 80       	push   $0x801092a4
80107235:	e8 76 94 ff ff       	call   801006b0 <cprintf>
      panic("trap");
8010723a:	83 c4 14             	add    $0x14,%esp
8010723d:	68 1b 93 10 80       	push   $0x8010931b
80107242:	e8 49 91 ff ff       	call   80100390 <panic>
80107247:	66 90                	xchg   %ax,%ax
80107249:	66 90                	xchg   %ax,%ax
8010724b:	66 90                	xchg   %ax,%ax
8010724d:	66 90                	xchg   %ax,%ax
8010724f:	90                   	nop

80107250 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80107250:	a1 a0 ed 10 80       	mov    0x8010eda0,%eax
80107255:	85 c0                	test   %eax,%eax
80107257:	74 17                	je     80107270 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80107259:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010725e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010725f:	a8 01                	test   $0x1,%al
80107261:	74 0d                	je     80107270 <uartgetc+0x20>
80107263:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107268:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80107269:	0f b6 c0             	movzbl %al,%eax
8010726c:	c3                   	ret    
8010726d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80107270:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107275:	c3                   	ret    
80107276:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010727d:	8d 76 00             	lea    0x0(%esi),%esi

80107280 <uartputc.part.0>:
uartputc(int c)
80107280:	55                   	push   %ebp
80107281:	89 e5                	mov    %esp,%ebp
80107283:	57                   	push   %edi
80107284:	89 c7                	mov    %eax,%edi
80107286:	56                   	push   %esi
80107287:	be fd 03 00 00       	mov    $0x3fd,%esi
8010728c:	53                   	push   %ebx
8010728d:	bb 80 00 00 00       	mov    $0x80,%ebx
80107292:	83 ec 0c             	sub    $0xc,%esp
80107295:	eb 1b                	jmp    801072b2 <uartputc.part.0+0x32>
80107297:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010729e:	66 90                	xchg   %ax,%ax
    microdelay(10);
801072a0:	83 ec 0c             	sub    $0xc,%esp
801072a3:	6a 0a                	push   $0xa
801072a5:	e8 36 b9 ff ff       	call   80102be0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801072aa:	83 c4 10             	add    $0x10,%esp
801072ad:	83 eb 01             	sub    $0x1,%ebx
801072b0:	74 07                	je     801072b9 <uartputc.part.0+0x39>
801072b2:	89 f2                	mov    %esi,%edx
801072b4:	ec                   	in     (%dx),%al
801072b5:	a8 20                	test   $0x20,%al
801072b7:	74 e7                	je     801072a0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801072b9:	ba f8 03 00 00       	mov    $0x3f8,%edx
801072be:	89 f8                	mov    %edi,%eax
801072c0:	ee                   	out    %al,(%dx)
}
801072c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072c4:	5b                   	pop    %ebx
801072c5:	5e                   	pop    %esi
801072c6:	5f                   	pop    %edi
801072c7:	5d                   	pop    %ebp
801072c8:	c3                   	ret    
801072c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801072d0 <uartinit>:
{
801072d0:	55                   	push   %ebp
801072d1:	31 c9                	xor    %ecx,%ecx
801072d3:	89 c8                	mov    %ecx,%eax
801072d5:	89 e5                	mov    %esp,%ebp
801072d7:	57                   	push   %edi
801072d8:	56                   	push   %esi
801072d9:	53                   	push   %ebx
801072da:	bb fa 03 00 00       	mov    $0x3fa,%ebx
801072df:	89 da                	mov    %ebx,%edx
801072e1:	83 ec 0c             	sub    $0xc,%esp
801072e4:	ee                   	out    %al,(%dx)
801072e5:	bf fb 03 00 00       	mov    $0x3fb,%edi
801072ea:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801072ef:	89 fa                	mov    %edi,%edx
801072f1:	ee                   	out    %al,(%dx)
801072f2:	b8 0c 00 00 00       	mov    $0xc,%eax
801072f7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801072fc:	ee                   	out    %al,(%dx)
801072fd:	be f9 03 00 00       	mov    $0x3f9,%esi
80107302:	89 c8                	mov    %ecx,%eax
80107304:	89 f2                	mov    %esi,%edx
80107306:	ee                   	out    %al,(%dx)
80107307:	b8 03 00 00 00       	mov    $0x3,%eax
8010730c:	89 fa                	mov    %edi,%edx
8010730e:	ee                   	out    %al,(%dx)
8010730f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80107314:	89 c8                	mov    %ecx,%eax
80107316:	ee                   	out    %al,(%dx)
80107317:	b8 01 00 00 00       	mov    $0x1,%eax
8010731c:	89 f2                	mov    %esi,%edx
8010731e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010731f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80107324:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80107325:	3c ff                	cmp    $0xff,%al
80107327:	74 56                	je     8010737f <uartinit+0xaf>
  uart = 1;
80107329:	c7 05 a0 ed 10 80 01 	movl   $0x1,0x8010eda0
80107330:	00 00 00 
80107333:	89 da                	mov    %ebx,%edx
80107335:	ec                   	in     (%dx),%al
80107336:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010733b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
8010733c:	83 ec 08             	sub    $0x8,%esp
8010733f:	be 76 00 00 00       	mov    $0x76,%esi
  for(p="xv6...\n"; *p; p++)
80107344:	bb a0 93 10 80       	mov    $0x801093a0,%ebx
  ioapicenable(IRQ_COM1, 0);
80107349:	6a 00                	push   $0x0
8010734b:	6a 04                	push   $0x4
8010734d:	e8 ce b3 ff ff       	call   80102720 <ioapicenable>
80107352:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80107355:	b8 78 00 00 00       	mov    $0x78,%eax
8010735a:	eb 08                	jmp    80107364 <uartinit+0x94>
8010735c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107360:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
  if(!uart)
80107364:	8b 15 a0 ed 10 80    	mov    0x8010eda0,%edx
8010736a:	85 d2                	test   %edx,%edx
8010736c:	74 08                	je     80107376 <uartinit+0xa6>
    uartputc(*p);
8010736e:	0f be c0             	movsbl %al,%eax
80107371:	e8 0a ff ff ff       	call   80107280 <uartputc.part.0>
  for(p="xv6...\n"; *p; p++)
80107376:	89 f0                	mov    %esi,%eax
80107378:	83 c3 01             	add    $0x1,%ebx
8010737b:	84 c0                	test   %al,%al
8010737d:	75 e1                	jne    80107360 <uartinit+0x90>
}
8010737f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107382:	5b                   	pop    %ebx
80107383:	5e                   	pop    %esi
80107384:	5f                   	pop    %edi
80107385:	5d                   	pop    %ebp
80107386:	c3                   	ret    
80107387:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010738e:	66 90                	xchg   %ax,%ax

80107390 <uartputc>:
{
80107390:	55                   	push   %ebp
  if(!uart)
80107391:	8b 15 a0 ed 10 80    	mov    0x8010eda0,%edx
{
80107397:	89 e5                	mov    %esp,%ebp
80107399:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
8010739c:	85 d2                	test   %edx,%edx
8010739e:	74 10                	je     801073b0 <uartputc+0x20>
}
801073a0:	5d                   	pop    %ebp
801073a1:	e9 da fe ff ff       	jmp    80107280 <uartputc.part.0>
801073a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073ad:	8d 76 00             	lea    0x0(%esi),%esi
801073b0:	5d                   	pop    %ebp
801073b1:	c3                   	ret    
801073b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801073c0 <uartintr>:

void
uartintr(void)
{
801073c0:	55                   	push   %ebp
801073c1:	89 e5                	mov    %esp,%ebp
801073c3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801073c6:	68 50 72 10 80       	push   $0x80107250
801073cb:	e8 90 94 ff ff       	call   80100860 <consoleintr>
}
801073d0:	83 c4 10             	add    $0x10,%esp
801073d3:	c9                   	leave  
801073d4:	c3                   	ret    

801073d5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801073d5:	6a 00                	push   $0x0
  pushl $0
801073d7:	6a 00                	push   $0x0
  jmp alltraps
801073d9:	e9 29 fb ff ff       	jmp    80106f07 <alltraps>

801073de <vector1>:
.globl vector1
vector1:
  pushl $0
801073de:	6a 00                	push   $0x0
  pushl $1
801073e0:	6a 01                	push   $0x1
  jmp alltraps
801073e2:	e9 20 fb ff ff       	jmp    80106f07 <alltraps>

801073e7 <vector2>:
.globl vector2
vector2:
  pushl $0
801073e7:	6a 00                	push   $0x0
  pushl $2
801073e9:	6a 02                	push   $0x2
  jmp alltraps
801073eb:	e9 17 fb ff ff       	jmp    80106f07 <alltraps>

801073f0 <vector3>:
.globl vector3
vector3:
  pushl $0
801073f0:	6a 00                	push   $0x0
  pushl $3
801073f2:	6a 03                	push   $0x3
  jmp alltraps
801073f4:	e9 0e fb ff ff       	jmp    80106f07 <alltraps>

801073f9 <vector4>:
.globl vector4
vector4:
  pushl $0
801073f9:	6a 00                	push   $0x0
  pushl $4
801073fb:	6a 04                	push   $0x4
  jmp alltraps
801073fd:	e9 05 fb ff ff       	jmp    80106f07 <alltraps>

80107402 <vector5>:
.globl vector5
vector5:
  pushl $0
80107402:	6a 00                	push   $0x0
  pushl $5
80107404:	6a 05                	push   $0x5
  jmp alltraps
80107406:	e9 fc fa ff ff       	jmp    80106f07 <alltraps>

8010740b <vector6>:
.globl vector6
vector6:
  pushl $0
8010740b:	6a 00                	push   $0x0
  pushl $6
8010740d:	6a 06                	push   $0x6
  jmp alltraps
8010740f:	e9 f3 fa ff ff       	jmp    80106f07 <alltraps>

80107414 <vector7>:
.globl vector7
vector7:
  pushl $0
80107414:	6a 00                	push   $0x0
  pushl $7
80107416:	6a 07                	push   $0x7
  jmp alltraps
80107418:	e9 ea fa ff ff       	jmp    80106f07 <alltraps>

8010741d <vector8>:
.globl vector8
vector8:
  pushl $8
8010741d:	6a 08                	push   $0x8
  jmp alltraps
8010741f:	e9 e3 fa ff ff       	jmp    80106f07 <alltraps>

80107424 <vector9>:
.globl vector9
vector9:
  pushl $0
80107424:	6a 00                	push   $0x0
  pushl $9
80107426:	6a 09                	push   $0x9
  jmp alltraps
80107428:	e9 da fa ff ff       	jmp    80106f07 <alltraps>

8010742d <vector10>:
.globl vector10
vector10:
  pushl $10
8010742d:	6a 0a                	push   $0xa
  jmp alltraps
8010742f:	e9 d3 fa ff ff       	jmp    80106f07 <alltraps>

80107434 <vector11>:
.globl vector11
vector11:
  pushl $11
80107434:	6a 0b                	push   $0xb
  jmp alltraps
80107436:	e9 cc fa ff ff       	jmp    80106f07 <alltraps>

8010743b <vector12>:
.globl vector12
vector12:
  pushl $12
8010743b:	6a 0c                	push   $0xc
  jmp alltraps
8010743d:	e9 c5 fa ff ff       	jmp    80106f07 <alltraps>

80107442 <vector13>:
.globl vector13
vector13:
  pushl $13
80107442:	6a 0d                	push   $0xd
  jmp alltraps
80107444:	e9 be fa ff ff       	jmp    80106f07 <alltraps>

80107449 <vector14>:
.globl vector14
vector14:
  pushl $14
80107449:	6a 0e                	push   $0xe
  jmp alltraps
8010744b:	e9 b7 fa ff ff       	jmp    80106f07 <alltraps>

80107450 <vector15>:
.globl vector15
vector15:
  pushl $0
80107450:	6a 00                	push   $0x0
  pushl $15
80107452:	6a 0f                	push   $0xf
  jmp alltraps
80107454:	e9 ae fa ff ff       	jmp    80106f07 <alltraps>

80107459 <vector16>:
.globl vector16
vector16:
  pushl $0
80107459:	6a 00                	push   $0x0
  pushl $16
8010745b:	6a 10                	push   $0x10
  jmp alltraps
8010745d:	e9 a5 fa ff ff       	jmp    80106f07 <alltraps>

80107462 <vector17>:
.globl vector17
vector17:
  pushl $17
80107462:	6a 11                	push   $0x11
  jmp alltraps
80107464:	e9 9e fa ff ff       	jmp    80106f07 <alltraps>

80107469 <vector18>:
.globl vector18
vector18:
  pushl $0
80107469:	6a 00                	push   $0x0
  pushl $18
8010746b:	6a 12                	push   $0x12
  jmp alltraps
8010746d:	e9 95 fa ff ff       	jmp    80106f07 <alltraps>

80107472 <vector19>:
.globl vector19
vector19:
  pushl $0
80107472:	6a 00                	push   $0x0
  pushl $19
80107474:	6a 13                	push   $0x13
  jmp alltraps
80107476:	e9 8c fa ff ff       	jmp    80106f07 <alltraps>

8010747b <vector20>:
.globl vector20
vector20:
  pushl $0
8010747b:	6a 00                	push   $0x0
  pushl $20
8010747d:	6a 14                	push   $0x14
  jmp alltraps
8010747f:	e9 83 fa ff ff       	jmp    80106f07 <alltraps>

80107484 <vector21>:
.globl vector21
vector21:
  pushl $0
80107484:	6a 00                	push   $0x0
  pushl $21
80107486:	6a 15                	push   $0x15
  jmp alltraps
80107488:	e9 7a fa ff ff       	jmp    80106f07 <alltraps>

8010748d <vector22>:
.globl vector22
vector22:
  pushl $0
8010748d:	6a 00                	push   $0x0
  pushl $22
8010748f:	6a 16                	push   $0x16
  jmp alltraps
80107491:	e9 71 fa ff ff       	jmp    80106f07 <alltraps>

80107496 <vector23>:
.globl vector23
vector23:
  pushl $0
80107496:	6a 00                	push   $0x0
  pushl $23
80107498:	6a 17                	push   $0x17
  jmp alltraps
8010749a:	e9 68 fa ff ff       	jmp    80106f07 <alltraps>

8010749f <vector24>:
.globl vector24
vector24:
  pushl $0
8010749f:	6a 00                	push   $0x0
  pushl $24
801074a1:	6a 18                	push   $0x18
  jmp alltraps
801074a3:	e9 5f fa ff ff       	jmp    80106f07 <alltraps>

801074a8 <vector25>:
.globl vector25
vector25:
  pushl $0
801074a8:	6a 00                	push   $0x0
  pushl $25
801074aa:	6a 19                	push   $0x19
  jmp alltraps
801074ac:	e9 56 fa ff ff       	jmp    80106f07 <alltraps>

801074b1 <vector26>:
.globl vector26
vector26:
  pushl $0
801074b1:	6a 00                	push   $0x0
  pushl $26
801074b3:	6a 1a                	push   $0x1a
  jmp alltraps
801074b5:	e9 4d fa ff ff       	jmp    80106f07 <alltraps>

801074ba <vector27>:
.globl vector27
vector27:
  pushl $0
801074ba:	6a 00                	push   $0x0
  pushl $27
801074bc:	6a 1b                	push   $0x1b
  jmp alltraps
801074be:	e9 44 fa ff ff       	jmp    80106f07 <alltraps>

801074c3 <vector28>:
.globl vector28
vector28:
  pushl $0
801074c3:	6a 00                	push   $0x0
  pushl $28
801074c5:	6a 1c                	push   $0x1c
  jmp alltraps
801074c7:	e9 3b fa ff ff       	jmp    80106f07 <alltraps>

801074cc <vector29>:
.globl vector29
vector29:
  pushl $0
801074cc:	6a 00                	push   $0x0
  pushl $29
801074ce:	6a 1d                	push   $0x1d
  jmp alltraps
801074d0:	e9 32 fa ff ff       	jmp    80106f07 <alltraps>

801074d5 <vector30>:
.globl vector30
vector30:
  pushl $0
801074d5:	6a 00                	push   $0x0
  pushl $30
801074d7:	6a 1e                	push   $0x1e
  jmp alltraps
801074d9:	e9 29 fa ff ff       	jmp    80106f07 <alltraps>

801074de <vector31>:
.globl vector31
vector31:
  pushl $0
801074de:	6a 00                	push   $0x0
  pushl $31
801074e0:	6a 1f                	push   $0x1f
  jmp alltraps
801074e2:	e9 20 fa ff ff       	jmp    80106f07 <alltraps>

801074e7 <vector32>:
.globl vector32
vector32:
  pushl $0
801074e7:	6a 00                	push   $0x0
  pushl $32
801074e9:	6a 20                	push   $0x20
  jmp alltraps
801074eb:	e9 17 fa ff ff       	jmp    80106f07 <alltraps>

801074f0 <vector33>:
.globl vector33
vector33:
  pushl $0
801074f0:	6a 00                	push   $0x0
  pushl $33
801074f2:	6a 21                	push   $0x21
  jmp alltraps
801074f4:	e9 0e fa ff ff       	jmp    80106f07 <alltraps>

801074f9 <vector34>:
.globl vector34
vector34:
  pushl $0
801074f9:	6a 00                	push   $0x0
  pushl $34
801074fb:	6a 22                	push   $0x22
  jmp alltraps
801074fd:	e9 05 fa ff ff       	jmp    80106f07 <alltraps>

80107502 <vector35>:
.globl vector35
vector35:
  pushl $0
80107502:	6a 00                	push   $0x0
  pushl $35
80107504:	6a 23                	push   $0x23
  jmp alltraps
80107506:	e9 fc f9 ff ff       	jmp    80106f07 <alltraps>

8010750b <vector36>:
.globl vector36
vector36:
  pushl $0
8010750b:	6a 00                	push   $0x0
  pushl $36
8010750d:	6a 24                	push   $0x24
  jmp alltraps
8010750f:	e9 f3 f9 ff ff       	jmp    80106f07 <alltraps>

80107514 <vector37>:
.globl vector37
vector37:
  pushl $0
80107514:	6a 00                	push   $0x0
  pushl $37
80107516:	6a 25                	push   $0x25
  jmp alltraps
80107518:	e9 ea f9 ff ff       	jmp    80106f07 <alltraps>

8010751d <vector38>:
.globl vector38
vector38:
  pushl $0
8010751d:	6a 00                	push   $0x0
  pushl $38
8010751f:	6a 26                	push   $0x26
  jmp alltraps
80107521:	e9 e1 f9 ff ff       	jmp    80106f07 <alltraps>

80107526 <vector39>:
.globl vector39
vector39:
  pushl $0
80107526:	6a 00                	push   $0x0
  pushl $39
80107528:	6a 27                	push   $0x27
  jmp alltraps
8010752a:	e9 d8 f9 ff ff       	jmp    80106f07 <alltraps>

8010752f <vector40>:
.globl vector40
vector40:
  pushl $0
8010752f:	6a 00                	push   $0x0
  pushl $40
80107531:	6a 28                	push   $0x28
  jmp alltraps
80107533:	e9 cf f9 ff ff       	jmp    80106f07 <alltraps>

80107538 <vector41>:
.globl vector41
vector41:
  pushl $0
80107538:	6a 00                	push   $0x0
  pushl $41
8010753a:	6a 29                	push   $0x29
  jmp alltraps
8010753c:	e9 c6 f9 ff ff       	jmp    80106f07 <alltraps>

80107541 <vector42>:
.globl vector42
vector42:
  pushl $0
80107541:	6a 00                	push   $0x0
  pushl $42
80107543:	6a 2a                	push   $0x2a
  jmp alltraps
80107545:	e9 bd f9 ff ff       	jmp    80106f07 <alltraps>

8010754a <vector43>:
.globl vector43
vector43:
  pushl $0
8010754a:	6a 00                	push   $0x0
  pushl $43
8010754c:	6a 2b                	push   $0x2b
  jmp alltraps
8010754e:	e9 b4 f9 ff ff       	jmp    80106f07 <alltraps>

80107553 <vector44>:
.globl vector44
vector44:
  pushl $0
80107553:	6a 00                	push   $0x0
  pushl $44
80107555:	6a 2c                	push   $0x2c
  jmp alltraps
80107557:	e9 ab f9 ff ff       	jmp    80106f07 <alltraps>

8010755c <vector45>:
.globl vector45
vector45:
  pushl $0
8010755c:	6a 00                	push   $0x0
  pushl $45
8010755e:	6a 2d                	push   $0x2d
  jmp alltraps
80107560:	e9 a2 f9 ff ff       	jmp    80106f07 <alltraps>

80107565 <vector46>:
.globl vector46
vector46:
  pushl $0
80107565:	6a 00                	push   $0x0
  pushl $46
80107567:	6a 2e                	push   $0x2e
  jmp alltraps
80107569:	e9 99 f9 ff ff       	jmp    80106f07 <alltraps>

8010756e <vector47>:
.globl vector47
vector47:
  pushl $0
8010756e:	6a 00                	push   $0x0
  pushl $47
80107570:	6a 2f                	push   $0x2f
  jmp alltraps
80107572:	e9 90 f9 ff ff       	jmp    80106f07 <alltraps>

80107577 <vector48>:
.globl vector48
vector48:
  pushl $0
80107577:	6a 00                	push   $0x0
  pushl $48
80107579:	6a 30                	push   $0x30
  jmp alltraps
8010757b:	e9 87 f9 ff ff       	jmp    80106f07 <alltraps>

80107580 <vector49>:
.globl vector49
vector49:
  pushl $0
80107580:	6a 00                	push   $0x0
  pushl $49
80107582:	6a 31                	push   $0x31
  jmp alltraps
80107584:	e9 7e f9 ff ff       	jmp    80106f07 <alltraps>

80107589 <vector50>:
.globl vector50
vector50:
  pushl $0
80107589:	6a 00                	push   $0x0
  pushl $50
8010758b:	6a 32                	push   $0x32
  jmp alltraps
8010758d:	e9 75 f9 ff ff       	jmp    80106f07 <alltraps>

80107592 <vector51>:
.globl vector51
vector51:
  pushl $0
80107592:	6a 00                	push   $0x0
  pushl $51
80107594:	6a 33                	push   $0x33
  jmp alltraps
80107596:	e9 6c f9 ff ff       	jmp    80106f07 <alltraps>

8010759b <vector52>:
.globl vector52
vector52:
  pushl $0
8010759b:	6a 00                	push   $0x0
  pushl $52
8010759d:	6a 34                	push   $0x34
  jmp alltraps
8010759f:	e9 63 f9 ff ff       	jmp    80106f07 <alltraps>

801075a4 <vector53>:
.globl vector53
vector53:
  pushl $0
801075a4:	6a 00                	push   $0x0
  pushl $53
801075a6:	6a 35                	push   $0x35
  jmp alltraps
801075a8:	e9 5a f9 ff ff       	jmp    80106f07 <alltraps>

801075ad <vector54>:
.globl vector54
vector54:
  pushl $0
801075ad:	6a 00                	push   $0x0
  pushl $54
801075af:	6a 36                	push   $0x36
  jmp alltraps
801075b1:	e9 51 f9 ff ff       	jmp    80106f07 <alltraps>

801075b6 <vector55>:
.globl vector55
vector55:
  pushl $0
801075b6:	6a 00                	push   $0x0
  pushl $55
801075b8:	6a 37                	push   $0x37
  jmp alltraps
801075ba:	e9 48 f9 ff ff       	jmp    80106f07 <alltraps>

801075bf <vector56>:
.globl vector56
vector56:
  pushl $0
801075bf:	6a 00                	push   $0x0
  pushl $56
801075c1:	6a 38                	push   $0x38
  jmp alltraps
801075c3:	e9 3f f9 ff ff       	jmp    80106f07 <alltraps>

801075c8 <vector57>:
.globl vector57
vector57:
  pushl $0
801075c8:	6a 00                	push   $0x0
  pushl $57
801075ca:	6a 39                	push   $0x39
  jmp alltraps
801075cc:	e9 36 f9 ff ff       	jmp    80106f07 <alltraps>

801075d1 <vector58>:
.globl vector58
vector58:
  pushl $0
801075d1:	6a 00                	push   $0x0
  pushl $58
801075d3:	6a 3a                	push   $0x3a
  jmp alltraps
801075d5:	e9 2d f9 ff ff       	jmp    80106f07 <alltraps>

801075da <vector59>:
.globl vector59
vector59:
  pushl $0
801075da:	6a 00                	push   $0x0
  pushl $59
801075dc:	6a 3b                	push   $0x3b
  jmp alltraps
801075de:	e9 24 f9 ff ff       	jmp    80106f07 <alltraps>

801075e3 <vector60>:
.globl vector60
vector60:
  pushl $0
801075e3:	6a 00                	push   $0x0
  pushl $60
801075e5:	6a 3c                	push   $0x3c
  jmp alltraps
801075e7:	e9 1b f9 ff ff       	jmp    80106f07 <alltraps>

801075ec <vector61>:
.globl vector61
vector61:
  pushl $0
801075ec:	6a 00                	push   $0x0
  pushl $61
801075ee:	6a 3d                	push   $0x3d
  jmp alltraps
801075f0:	e9 12 f9 ff ff       	jmp    80106f07 <alltraps>

801075f5 <vector62>:
.globl vector62
vector62:
  pushl $0
801075f5:	6a 00                	push   $0x0
  pushl $62
801075f7:	6a 3e                	push   $0x3e
  jmp alltraps
801075f9:	e9 09 f9 ff ff       	jmp    80106f07 <alltraps>

801075fe <vector63>:
.globl vector63
vector63:
  pushl $0
801075fe:	6a 00                	push   $0x0
  pushl $63
80107600:	6a 3f                	push   $0x3f
  jmp alltraps
80107602:	e9 00 f9 ff ff       	jmp    80106f07 <alltraps>

80107607 <vector64>:
.globl vector64
vector64:
  pushl $0
80107607:	6a 00                	push   $0x0
  pushl $64
80107609:	6a 40                	push   $0x40
  jmp alltraps
8010760b:	e9 f7 f8 ff ff       	jmp    80106f07 <alltraps>

80107610 <vector65>:
.globl vector65
vector65:
  pushl $0
80107610:	6a 00                	push   $0x0
  pushl $65
80107612:	6a 41                	push   $0x41
  jmp alltraps
80107614:	e9 ee f8 ff ff       	jmp    80106f07 <alltraps>

80107619 <vector66>:
.globl vector66
vector66:
  pushl $0
80107619:	6a 00                	push   $0x0
  pushl $66
8010761b:	6a 42                	push   $0x42
  jmp alltraps
8010761d:	e9 e5 f8 ff ff       	jmp    80106f07 <alltraps>

80107622 <vector67>:
.globl vector67
vector67:
  pushl $0
80107622:	6a 00                	push   $0x0
  pushl $67
80107624:	6a 43                	push   $0x43
  jmp alltraps
80107626:	e9 dc f8 ff ff       	jmp    80106f07 <alltraps>

8010762b <vector68>:
.globl vector68
vector68:
  pushl $0
8010762b:	6a 00                	push   $0x0
  pushl $68
8010762d:	6a 44                	push   $0x44
  jmp alltraps
8010762f:	e9 d3 f8 ff ff       	jmp    80106f07 <alltraps>

80107634 <vector69>:
.globl vector69
vector69:
  pushl $0
80107634:	6a 00                	push   $0x0
  pushl $69
80107636:	6a 45                	push   $0x45
  jmp alltraps
80107638:	e9 ca f8 ff ff       	jmp    80106f07 <alltraps>

8010763d <vector70>:
.globl vector70
vector70:
  pushl $0
8010763d:	6a 00                	push   $0x0
  pushl $70
8010763f:	6a 46                	push   $0x46
  jmp alltraps
80107641:	e9 c1 f8 ff ff       	jmp    80106f07 <alltraps>

80107646 <vector71>:
.globl vector71
vector71:
  pushl $0
80107646:	6a 00                	push   $0x0
  pushl $71
80107648:	6a 47                	push   $0x47
  jmp alltraps
8010764a:	e9 b8 f8 ff ff       	jmp    80106f07 <alltraps>

8010764f <vector72>:
.globl vector72
vector72:
  pushl $0
8010764f:	6a 00                	push   $0x0
  pushl $72
80107651:	6a 48                	push   $0x48
  jmp alltraps
80107653:	e9 af f8 ff ff       	jmp    80106f07 <alltraps>

80107658 <vector73>:
.globl vector73
vector73:
  pushl $0
80107658:	6a 00                	push   $0x0
  pushl $73
8010765a:	6a 49                	push   $0x49
  jmp alltraps
8010765c:	e9 a6 f8 ff ff       	jmp    80106f07 <alltraps>

80107661 <vector74>:
.globl vector74
vector74:
  pushl $0
80107661:	6a 00                	push   $0x0
  pushl $74
80107663:	6a 4a                	push   $0x4a
  jmp alltraps
80107665:	e9 9d f8 ff ff       	jmp    80106f07 <alltraps>

8010766a <vector75>:
.globl vector75
vector75:
  pushl $0
8010766a:	6a 00                	push   $0x0
  pushl $75
8010766c:	6a 4b                	push   $0x4b
  jmp alltraps
8010766e:	e9 94 f8 ff ff       	jmp    80106f07 <alltraps>

80107673 <vector76>:
.globl vector76
vector76:
  pushl $0
80107673:	6a 00                	push   $0x0
  pushl $76
80107675:	6a 4c                	push   $0x4c
  jmp alltraps
80107677:	e9 8b f8 ff ff       	jmp    80106f07 <alltraps>

8010767c <vector77>:
.globl vector77
vector77:
  pushl $0
8010767c:	6a 00                	push   $0x0
  pushl $77
8010767e:	6a 4d                	push   $0x4d
  jmp alltraps
80107680:	e9 82 f8 ff ff       	jmp    80106f07 <alltraps>

80107685 <vector78>:
.globl vector78
vector78:
  pushl $0
80107685:	6a 00                	push   $0x0
  pushl $78
80107687:	6a 4e                	push   $0x4e
  jmp alltraps
80107689:	e9 79 f8 ff ff       	jmp    80106f07 <alltraps>

8010768e <vector79>:
.globl vector79
vector79:
  pushl $0
8010768e:	6a 00                	push   $0x0
  pushl $79
80107690:	6a 4f                	push   $0x4f
  jmp alltraps
80107692:	e9 70 f8 ff ff       	jmp    80106f07 <alltraps>

80107697 <vector80>:
.globl vector80
vector80:
  pushl $0
80107697:	6a 00                	push   $0x0
  pushl $80
80107699:	6a 50                	push   $0x50
  jmp alltraps
8010769b:	e9 67 f8 ff ff       	jmp    80106f07 <alltraps>

801076a0 <vector81>:
.globl vector81
vector81:
  pushl $0
801076a0:	6a 00                	push   $0x0
  pushl $81
801076a2:	6a 51                	push   $0x51
  jmp alltraps
801076a4:	e9 5e f8 ff ff       	jmp    80106f07 <alltraps>

801076a9 <vector82>:
.globl vector82
vector82:
  pushl $0
801076a9:	6a 00                	push   $0x0
  pushl $82
801076ab:	6a 52                	push   $0x52
  jmp alltraps
801076ad:	e9 55 f8 ff ff       	jmp    80106f07 <alltraps>

801076b2 <vector83>:
.globl vector83
vector83:
  pushl $0
801076b2:	6a 00                	push   $0x0
  pushl $83
801076b4:	6a 53                	push   $0x53
  jmp alltraps
801076b6:	e9 4c f8 ff ff       	jmp    80106f07 <alltraps>

801076bb <vector84>:
.globl vector84
vector84:
  pushl $0
801076bb:	6a 00                	push   $0x0
  pushl $84
801076bd:	6a 54                	push   $0x54
  jmp alltraps
801076bf:	e9 43 f8 ff ff       	jmp    80106f07 <alltraps>

801076c4 <vector85>:
.globl vector85
vector85:
  pushl $0
801076c4:	6a 00                	push   $0x0
  pushl $85
801076c6:	6a 55                	push   $0x55
  jmp alltraps
801076c8:	e9 3a f8 ff ff       	jmp    80106f07 <alltraps>

801076cd <vector86>:
.globl vector86
vector86:
  pushl $0
801076cd:	6a 00                	push   $0x0
  pushl $86
801076cf:	6a 56                	push   $0x56
  jmp alltraps
801076d1:	e9 31 f8 ff ff       	jmp    80106f07 <alltraps>

801076d6 <vector87>:
.globl vector87
vector87:
  pushl $0
801076d6:	6a 00                	push   $0x0
  pushl $87
801076d8:	6a 57                	push   $0x57
  jmp alltraps
801076da:	e9 28 f8 ff ff       	jmp    80106f07 <alltraps>

801076df <vector88>:
.globl vector88
vector88:
  pushl $0
801076df:	6a 00                	push   $0x0
  pushl $88
801076e1:	6a 58                	push   $0x58
  jmp alltraps
801076e3:	e9 1f f8 ff ff       	jmp    80106f07 <alltraps>

801076e8 <vector89>:
.globl vector89
vector89:
  pushl $0
801076e8:	6a 00                	push   $0x0
  pushl $89
801076ea:	6a 59                	push   $0x59
  jmp alltraps
801076ec:	e9 16 f8 ff ff       	jmp    80106f07 <alltraps>

801076f1 <vector90>:
.globl vector90
vector90:
  pushl $0
801076f1:	6a 00                	push   $0x0
  pushl $90
801076f3:	6a 5a                	push   $0x5a
  jmp alltraps
801076f5:	e9 0d f8 ff ff       	jmp    80106f07 <alltraps>

801076fa <vector91>:
.globl vector91
vector91:
  pushl $0
801076fa:	6a 00                	push   $0x0
  pushl $91
801076fc:	6a 5b                	push   $0x5b
  jmp alltraps
801076fe:	e9 04 f8 ff ff       	jmp    80106f07 <alltraps>

80107703 <vector92>:
.globl vector92
vector92:
  pushl $0
80107703:	6a 00                	push   $0x0
  pushl $92
80107705:	6a 5c                	push   $0x5c
  jmp alltraps
80107707:	e9 fb f7 ff ff       	jmp    80106f07 <alltraps>

8010770c <vector93>:
.globl vector93
vector93:
  pushl $0
8010770c:	6a 00                	push   $0x0
  pushl $93
8010770e:	6a 5d                	push   $0x5d
  jmp alltraps
80107710:	e9 f2 f7 ff ff       	jmp    80106f07 <alltraps>

80107715 <vector94>:
.globl vector94
vector94:
  pushl $0
80107715:	6a 00                	push   $0x0
  pushl $94
80107717:	6a 5e                	push   $0x5e
  jmp alltraps
80107719:	e9 e9 f7 ff ff       	jmp    80106f07 <alltraps>

8010771e <vector95>:
.globl vector95
vector95:
  pushl $0
8010771e:	6a 00                	push   $0x0
  pushl $95
80107720:	6a 5f                	push   $0x5f
  jmp alltraps
80107722:	e9 e0 f7 ff ff       	jmp    80106f07 <alltraps>

80107727 <vector96>:
.globl vector96
vector96:
  pushl $0
80107727:	6a 00                	push   $0x0
  pushl $96
80107729:	6a 60                	push   $0x60
  jmp alltraps
8010772b:	e9 d7 f7 ff ff       	jmp    80106f07 <alltraps>

80107730 <vector97>:
.globl vector97
vector97:
  pushl $0
80107730:	6a 00                	push   $0x0
  pushl $97
80107732:	6a 61                	push   $0x61
  jmp alltraps
80107734:	e9 ce f7 ff ff       	jmp    80106f07 <alltraps>

80107739 <vector98>:
.globl vector98
vector98:
  pushl $0
80107739:	6a 00                	push   $0x0
  pushl $98
8010773b:	6a 62                	push   $0x62
  jmp alltraps
8010773d:	e9 c5 f7 ff ff       	jmp    80106f07 <alltraps>

80107742 <vector99>:
.globl vector99
vector99:
  pushl $0
80107742:	6a 00                	push   $0x0
  pushl $99
80107744:	6a 63                	push   $0x63
  jmp alltraps
80107746:	e9 bc f7 ff ff       	jmp    80106f07 <alltraps>

8010774b <vector100>:
.globl vector100
vector100:
  pushl $0
8010774b:	6a 00                	push   $0x0
  pushl $100
8010774d:	6a 64                	push   $0x64
  jmp alltraps
8010774f:	e9 b3 f7 ff ff       	jmp    80106f07 <alltraps>

80107754 <vector101>:
.globl vector101
vector101:
  pushl $0
80107754:	6a 00                	push   $0x0
  pushl $101
80107756:	6a 65                	push   $0x65
  jmp alltraps
80107758:	e9 aa f7 ff ff       	jmp    80106f07 <alltraps>

8010775d <vector102>:
.globl vector102
vector102:
  pushl $0
8010775d:	6a 00                	push   $0x0
  pushl $102
8010775f:	6a 66                	push   $0x66
  jmp alltraps
80107761:	e9 a1 f7 ff ff       	jmp    80106f07 <alltraps>

80107766 <vector103>:
.globl vector103
vector103:
  pushl $0
80107766:	6a 00                	push   $0x0
  pushl $103
80107768:	6a 67                	push   $0x67
  jmp alltraps
8010776a:	e9 98 f7 ff ff       	jmp    80106f07 <alltraps>

8010776f <vector104>:
.globl vector104
vector104:
  pushl $0
8010776f:	6a 00                	push   $0x0
  pushl $104
80107771:	6a 68                	push   $0x68
  jmp alltraps
80107773:	e9 8f f7 ff ff       	jmp    80106f07 <alltraps>

80107778 <vector105>:
.globl vector105
vector105:
  pushl $0
80107778:	6a 00                	push   $0x0
  pushl $105
8010777a:	6a 69                	push   $0x69
  jmp alltraps
8010777c:	e9 86 f7 ff ff       	jmp    80106f07 <alltraps>

80107781 <vector106>:
.globl vector106
vector106:
  pushl $0
80107781:	6a 00                	push   $0x0
  pushl $106
80107783:	6a 6a                	push   $0x6a
  jmp alltraps
80107785:	e9 7d f7 ff ff       	jmp    80106f07 <alltraps>

8010778a <vector107>:
.globl vector107
vector107:
  pushl $0
8010778a:	6a 00                	push   $0x0
  pushl $107
8010778c:	6a 6b                	push   $0x6b
  jmp alltraps
8010778e:	e9 74 f7 ff ff       	jmp    80106f07 <alltraps>

80107793 <vector108>:
.globl vector108
vector108:
  pushl $0
80107793:	6a 00                	push   $0x0
  pushl $108
80107795:	6a 6c                	push   $0x6c
  jmp alltraps
80107797:	e9 6b f7 ff ff       	jmp    80106f07 <alltraps>

8010779c <vector109>:
.globl vector109
vector109:
  pushl $0
8010779c:	6a 00                	push   $0x0
  pushl $109
8010779e:	6a 6d                	push   $0x6d
  jmp alltraps
801077a0:	e9 62 f7 ff ff       	jmp    80106f07 <alltraps>

801077a5 <vector110>:
.globl vector110
vector110:
  pushl $0
801077a5:	6a 00                	push   $0x0
  pushl $110
801077a7:	6a 6e                	push   $0x6e
  jmp alltraps
801077a9:	e9 59 f7 ff ff       	jmp    80106f07 <alltraps>

801077ae <vector111>:
.globl vector111
vector111:
  pushl $0
801077ae:	6a 00                	push   $0x0
  pushl $111
801077b0:	6a 6f                	push   $0x6f
  jmp alltraps
801077b2:	e9 50 f7 ff ff       	jmp    80106f07 <alltraps>

801077b7 <vector112>:
.globl vector112
vector112:
  pushl $0
801077b7:	6a 00                	push   $0x0
  pushl $112
801077b9:	6a 70                	push   $0x70
  jmp alltraps
801077bb:	e9 47 f7 ff ff       	jmp    80106f07 <alltraps>

801077c0 <vector113>:
.globl vector113
vector113:
  pushl $0
801077c0:	6a 00                	push   $0x0
  pushl $113
801077c2:	6a 71                	push   $0x71
  jmp alltraps
801077c4:	e9 3e f7 ff ff       	jmp    80106f07 <alltraps>

801077c9 <vector114>:
.globl vector114
vector114:
  pushl $0
801077c9:	6a 00                	push   $0x0
  pushl $114
801077cb:	6a 72                	push   $0x72
  jmp alltraps
801077cd:	e9 35 f7 ff ff       	jmp    80106f07 <alltraps>

801077d2 <vector115>:
.globl vector115
vector115:
  pushl $0
801077d2:	6a 00                	push   $0x0
  pushl $115
801077d4:	6a 73                	push   $0x73
  jmp alltraps
801077d6:	e9 2c f7 ff ff       	jmp    80106f07 <alltraps>

801077db <vector116>:
.globl vector116
vector116:
  pushl $0
801077db:	6a 00                	push   $0x0
  pushl $116
801077dd:	6a 74                	push   $0x74
  jmp alltraps
801077df:	e9 23 f7 ff ff       	jmp    80106f07 <alltraps>

801077e4 <vector117>:
.globl vector117
vector117:
  pushl $0
801077e4:	6a 00                	push   $0x0
  pushl $117
801077e6:	6a 75                	push   $0x75
  jmp alltraps
801077e8:	e9 1a f7 ff ff       	jmp    80106f07 <alltraps>

801077ed <vector118>:
.globl vector118
vector118:
  pushl $0
801077ed:	6a 00                	push   $0x0
  pushl $118
801077ef:	6a 76                	push   $0x76
  jmp alltraps
801077f1:	e9 11 f7 ff ff       	jmp    80106f07 <alltraps>

801077f6 <vector119>:
.globl vector119
vector119:
  pushl $0
801077f6:	6a 00                	push   $0x0
  pushl $119
801077f8:	6a 77                	push   $0x77
  jmp alltraps
801077fa:	e9 08 f7 ff ff       	jmp    80106f07 <alltraps>

801077ff <vector120>:
.globl vector120
vector120:
  pushl $0
801077ff:	6a 00                	push   $0x0
  pushl $120
80107801:	6a 78                	push   $0x78
  jmp alltraps
80107803:	e9 ff f6 ff ff       	jmp    80106f07 <alltraps>

80107808 <vector121>:
.globl vector121
vector121:
  pushl $0
80107808:	6a 00                	push   $0x0
  pushl $121
8010780a:	6a 79                	push   $0x79
  jmp alltraps
8010780c:	e9 f6 f6 ff ff       	jmp    80106f07 <alltraps>

80107811 <vector122>:
.globl vector122
vector122:
  pushl $0
80107811:	6a 00                	push   $0x0
  pushl $122
80107813:	6a 7a                	push   $0x7a
  jmp alltraps
80107815:	e9 ed f6 ff ff       	jmp    80106f07 <alltraps>

8010781a <vector123>:
.globl vector123
vector123:
  pushl $0
8010781a:	6a 00                	push   $0x0
  pushl $123
8010781c:	6a 7b                	push   $0x7b
  jmp alltraps
8010781e:	e9 e4 f6 ff ff       	jmp    80106f07 <alltraps>

80107823 <vector124>:
.globl vector124
vector124:
  pushl $0
80107823:	6a 00                	push   $0x0
  pushl $124
80107825:	6a 7c                	push   $0x7c
  jmp alltraps
80107827:	e9 db f6 ff ff       	jmp    80106f07 <alltraps>

8010782c <vector125>:
.globl vector125
vector125:
  pushl $0
8010782c:	6a 00                	push   $0x0
  pushl $125
8010782e:	6a 7d                	push   $0x7d
  jmp alltraps
80107830:	e9 d2 f6 ff ff       	jmp    80106f07 <alltraps>

80107835 <vector126>:
.globl vector126
vector126:
  pushl $0
80107835:	6a 00                	push   $0x0
  pushl $126
80107837:	6a 7e                	push   $0x7e
  jmp alltraps
80107839:	e9 c9 f6 ff ff       	jmp    80106f07 <alltraps>

8010783e <vector127>:
.globl vector127
vector127:
  pushl $0
8010783e:	6a 00                	push   $0x0
  pushl $127
80107840:	6a 7f                	push   $0x7f
  jmp alltraps
80107842:	e9 c0 f6 ff ff       	jmp    80106f07 <alltraps>

80107847 <vector128>:
.globl vector128
vector128:
  pushl $0
80107847:	6a 00                	push   $0x0
  pushl $128
80107849:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010784e:	e9 b4 f6 ff ff       	jmp    80106f07 <alltraps>

80107853 <vector129>:
.globl vector129
vector129:
  pushl $0
80107853:	6a 00                	push   $0x0
  pushl $129
80107855:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010785a:	e9 a8 f6 ff ff       	jmp    80106f07 <alltraps>

8010785f <vector130>:
.globl vector130
vector130:
  pushl $0
8010785f:	6a 00                	push   $0x0
  pushl $130
80107861:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80107866:	e9 9c f6 ff ff       	jmp    80106f07 <alltraps>

8010786b <vector131>:
.globl vector131
vector131:
  pushl $0
8010786b:	6a 00                	push   $0x0
  pushl $131
8010786d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80107872:	e9 90 f6 ff ff       	jmp    80106f07 <alltraps>

80107877 <vector132>:
.globl vector132
vector132:
  pushl $0
80107877:	6a 00                	push   $0x0
  pushl $132
80107879:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010787e:	e9 84 f6 ff ff       	jmp    80106f07 <alltraps>

80107883 <vector133>:
.globl vector133
vector133:
  pushl $0
80107883:	6a 00                	push   $0x0
  pushl $133
80107885:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010788a:	e9 78 f6 ff ff       	jmp    80106f07 <alltraps>

8010788f <vector134>:
.globl vector134
vector134:
  pushl $0
8010788f:	6a 00                	push   $0x0
  pushl $134
80107891:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107896:	e9 6c f6 ff ff       	jmp    80106f07 <alltraps>

8010789b <vector135>:
.globl vector135
vector135:
  pushl $0
8010789b:	6a 00                	push   $0x0
  pushl $135
8010789d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801078a2:	e9 60 f6 ff ff       	jmp    80106f07 <alltraps>

801078a7 <vector136>:
.globl vector136
vector136:
  pushl $0
801078a7:	6a 00                	push   $0x0
  pushl $136
801078a9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801078ae:	e9 54 f6 ff ff       	jmp    80106f07 <alltraps>

801078b3 <vector137>:
.globl vector137
vector137:
  pushl $0
801078b3:	6a 00                	push   $0x0
  pushl $137
801078b5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801078ba:	e9 48 f6 ff ff       	jmp    80106f07 <alltraps>

801078bf <vector138>:
.globl vector138
vector138:
  pushl $0
801078bf:	6a 00                	push   $0x0
  pushl $138
801078c1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801078c6:	e9 3c f6 ff ff       	jmp    80106f07 <alltraps>

801078cb <vector139>:
.globl vector139
vector139:
  pushl $0
801078cb:	6a 00                	push   $0x0
  pushl $139
801078cd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801078d2:	e9 30 f6 ff ff       	jmp    80106f07 <alltraps>

801078d7 <vector140>:
.globl vector140
vector140:
  pushl $0
801078d7:	6a 00                	push   $0x0
  pushl $140
801078d9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801078de:	e9 24 f6 ff ff       	jmp    80106f07 <alltraps>

801078e3 <vector141>:
.globl vector141
vector141:
  pushl $0
801078e3:	6a 00                	push   $0x0
  pushl $141
801078e5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801078ea:	e9 18 f6 ff ff       	jmp    80106f07 <alltraps>

801078ef <vector142>:
.globl vector142
vector142:
  pushl $0
801078ef:	6a 00                	push   $0x0
  pushl $142
801078f1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801078f6:	e9 0c f6 ff ff       	jmp    80106f07 <alltraps>

801078fb <vector143>:
.globl vector143
vector143:
  pushl $0
801078fb:	6a 00                	push   $0x0
  pushl $143
801078fd:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107902:	e9 00 f6 ff ff       	jmp    80106f07 <alltraps>

80107907 <vector144>:
.globl vector144
vector144:
  pushl $0
80107907:	6a 00                	push   $0x0
  pushl $144
80107909:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010790e:	e9 f4 f5 ff ff       	jmp    80106f07 <alltraps>

80107913 <vector145>:
.globl vector145
vector145:
  pushl $0
80107913:	6a 00                	push   $0x0
  pushl $145
80107915:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010791a:	e9 e8 f5 ff ff       	jmp    80106f07 <alltraps>

8010791f <vector146>:
.globl vector146
vector146:
  pushl $0
8010791f:	6a 00                	push   $0x0
  pushl $146
80107921:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107926:	e9 dc f5 ff ff       	jmp    80106f07 <alltraps>

8010792b <vector147>:
.globl vector147
vector147:
  pushl $0
8010792b:	6a 00                	push   $0x0
  pushl $147
8010792d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107932:	e9 d0 f5 ff ff       	jmp    80106f07 <alltraps>

80107937 <vector148>:
.globl vector148
vector148:
  pushl $0
80107937:	6a 00                	push   $0x0
  pushl $148
80107939:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010793e:	e9 c4 f5 ff ff       	jmp    80106f07 <alltraps>

80107943 <vector149>:
.globl vector149
vector149:
  pushl $0
80107943:	6a 00                	push   $0x0
  pushl $149
80107945:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010794a:	e9 b8 f5 ff ff       	jmp    80106f07 <alltraps>

8010794f <vector150>:
.globl vector150
vector150:
  pushl $0
8010794f:	6a 00                	push   $0x0
  pushl $150
80107951:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107956:	e9 ac f5 ff ff       	jmp    80106f07 <alltraps>

8010795b <vector151>:
.globl vector151
vector151:
  pushl $0
8010795b:	6a 00                	push   $0x0
  pushl $151
8010795d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107962:	e9 a0 f5 ff ff       	jmp    80106f07 <alltraps>

80107967 <vector152>:
.globl vector152
vector152:
  pushl $0
80107967:	6a 00                	push   $0x0
  pushl $152
80107969:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010796e:	e9 94 f5 ff ff       	jmp    80106f07 <alltraps>

80107973 <vector153>:
.globl vector153
vector153:
  pushl $0
80107973:	6a 00                	push   $0x0
  pushl $153
80107975:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010797a:	e9 88 f5 ff ff       	jmp    80106f07 <alltraps>

8010797f <vector154>:
.globl vector154
vector154:
  pushl $0
8010797f:	6a 00                	push   $0x0
  pushl $154
80107981:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107986:	e9 7c f5 ff ff       	jmp    80106f07 <alltraps>

8010798b <vector155>:
.globl vector155
vector155:
  pushl $0
8010798b:	6a 00                	push   $0x0
  pushl $155
8010798d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107992:	e9 70 f5 ff ff       	jmp    80106f07 <alltraps>

80107997 <vector156>:
.globl vector156
vector156:
  pushl $0
80107997:	6a 00                	push   $0x0
  pushl $156
80107999:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010799e:	e9 64 f5 ff ff       	jmp    80106f07 <alltraps>

801079a3 <vector157>:
.globl vector157
vector157:
  pushl $0
801079a3:	6a 00                	push   $0x0
  pushl $157
801079a5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801079aa:	e9 58 f5 ff ff       	jmp    80106f07 <alltraps>

801079af <vector158>:
.globl vector158
vector158:
  pushl $0
801079af:	6a 00                	push   $0x0
  pushl $158
801079b1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801079b6:	e9 4c f5 ff ff       	jmp    80106f07 <alltraps>

801079bb <vector159>:
.globl vector159
vector159:
  pushl $0
801079bb:	6a 00                	push   $0x0
  pushl $159
801079bd:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801079c2:	e9 40 f5 ff ff       	jmp    80106f07 <alltraps>

801079c7 <vector160>:
.globl vector160
vector160:
  pushl $0
801079c7:	6a 00                	push   $0x0
  pushl $160
801079c9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801079ce:	e9 34 f5 ff ff       	jmp    80106f07 <alltraps>

801079d3 <vector161>:
.globl vector161
vector161:
  pushl $0
801079d3:	6a 00                	push   $0x0
  pushl $161
801079d5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801079da:	e9 28 f5 ff ff       	jmp    80106f07 <alltraps>

801079df <vector162>:
.globl vector162
vector162:
  pushl $0
801079df:	6a 00                	push   $0x0
  pushl $162
801079e1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801079e6:	e9 1c f5 ff ff       	jmp    80106f07 <alltraps>

801079eb <vector163>:
.globl vector163
vector163:
  pushl $0
801079eb:	6a 00                	push   $0x0
  pushl $163
801079ed:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801079f2:	e9 10 f5 ff ff       	jmp    80106f07 <alltraps>

801079f7 <vector164>:
.globl vector164
vector164:
  pushl $0
801079f7:	6a 00                	push   $0x0
  pushl $164
801079f9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801079fe:	e9 04 f5 ff ff       	jmp    80106f07 <alltraps>

80107a03 <vector165>:
.globl vector165
vector165:
  pushl $0
80107a03:	6a 00                	push   $0x0
  pushl $165
80107a05:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80107a0a:	e9 f8 f4 ff ff       	jmp    80106f07 <alltraps>

80107a0f <vector166>:
.globl vector166
vector166:
  pushl $0
80107a0f:	6a 00                	push   $0x0
  pushl $166
80107a11:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107a16:	e9 ec f4 ff ff       	jmp    80106f07 <alltraps>

80107a1b <vector167>:
.globl vector167
vector167:
  pushl $0
80107a1b:	6a 00                	push   $0x0
  pushl $167
80107a1d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107a22:	e9 e0 f4 ff ff       	jmp    80106f07 <alltraps>

80107a27 <vector168>:
.globl vector168
vector168:
  pushl $0
80107a27:	6a 00                	push   $0x0
  pushl $168
80107a29:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80107a2e:	e9 d4 f4 ff ff       	jmp    80106f07 <alltraps>

80107a33 <vector169>:
.globl vector169
vector169:
  pushl $0
80107a33:	6a 00                	push   $0x0
  pushl $169
80107a35:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80107a3a:	e9 c8 f4 ff ff       	jmp    80106f07 <alltraps>

80107a3f <vector170>:
.globl vector170
vector170:
  pushl $0
80107a3f:	6a 00                	push   $0x0
  pushl $170
80107a41:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107a46:	e9 bc f4 ff ff       	jmp    80106f07 <alltraps>

80107a4b <vector171>:
.globl vector171
vector171:
  pushl $0
80107a4b:	6a 00                	push   $0x0
  pushl $171
80107a4d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107a52:	e9 b0 f4 ff ff       	jmp    80106f07 <alltraps>

80107a57 <vector172>:
.globl vector172
vector172:
  pushl $0
80107a57:	6a 00                	push   $0x0
  pushl $172
80107a59:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80107a5e:	e9 a4 f4 ff ff       	jmp    80106f07 <alltraps>

80107a63 <vector173>:
.globl vector173
vector173:
  pushl $0
80107a63:	6a 00                	push   $0x0
  pushl $173
80107a65:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80107a6a:	e9 98 f4 ff ff       	jmp    80106f07 <alltraps>

80107a6f <vector174>:
.globl vector174
vector174:
  pushl $0
80107a6f:	6a 00                	push   $0x0
  pushl $174
80107a71:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107a76:	e9 8c f4 ff ff       	jmp    80106f07 <alltraps>

80107a7b <vector175>:
.globl vector175
vector175:
  pushl $0
80107a7b:	6a 00                	push   $0x0
  pushl $175
80107a7d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107a82:	e9 80 f4 ff ff       	jmp    80106f07 <alltraps>

80107a87 <vector176>:
.globl vector176
vector176:
  pushl $0
80107a87:	6a 00                	push   $0x0
  pushl $176
80107a89:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80107a8e:	e9 74 f4 ff ff       	jmp    80106f07 <alltraps>

80107a93 <vector177>:
.globl vector177
vector177:
  pushl $0
80107a93:	6a 00                	push   $0x0
  pushl $177
80107a95:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80107a9a:	e9 68 f4 ff ff       	jmp    80106f07 <alltraps>

80107a9f <vector178>:
.globl vector178
vector178:
  pushl $0
80107a9f:	6a 00                	push   $0x0
  pushl $178
80107aa1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107aa6:	e9 5c f4 ff ff       	jmp    80106f07 <alltraps>

80107aab <vector179>:
.globl vector179
vector179:
  pushl $0
80107aab:	6a 00                	push   $0x0
  pushl $179
80107aad:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107ab2:	e9 50 f4 ff ff       	jmp    80106f07 <alltraps>

80107ab7 <vector180>:
.globl vector180
vector180:
  pushl $0
80107ab7:	6a 00                	push   $0x0
  pushl $180
80107ab9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80107abe:	e9 44 f4 ff ff       	jmp    80106f07 <alltraps>

80107ac3 <vector181>:
.globl vector181
vector181:
  pushl $0
80107ac3:	6a 00                	push   $0x0
  pushl $181
80107ac5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80107aca:	e9 38 f4 ff ff       	jmp    80106f07 <alltraps>

80107acf <vector182>:
.globl vector182
vector182:
  pushl $0
80107acf:	6a 00                	push   $0x0
  pushl $182
80107ad1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107ad6:	e9 2c f4 ff ff       	jmp    80106f07 <alltraps>

80107adb <vector183>:
.globl vector183
vector183:
  pushl $0
80107adb:	6a 00                	push   $0x0
  pushl $183
80107add:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107ae2:	e9 20 f4 ff ff       	jmp    80106f07 <alltraps>

80107ae7 <vector184>:
.globl vector184
vector184:
  pushl $0
80107ae7:	6a 00                	push   $0x0
  pushl $184
80107ae9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80107aee:	e9 14 f4 ff ff       	jmp    80106f07 <alltraps>

80107af3 <vector185>:
.globl vector185
vector185:
  pushl $0
80107af3:	6a 00                	push   $0x0
  pushl $185
80107af5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80107afa:	e9 08 f4 ff ff       	jmp    80106f07 <alltraps>

80107aff <vector186>:
.globl vector186
vector186:
  pushl $0
80107aff:	6a 00                	push   $0x0
  pushl $186
80107b01:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107b06:	e9 fc f3 ff ff       	jmp    80106f07 <alltraps>

80107b0b <vector187>:
.globl vector187
vector187:
  pushl $0
80107b0b:	6a 00                	push   $0x0
  pushl $187
80107b0d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107b12:	e9 f0 f3 ff ff       	jmp    80106f07 <alltraps>

80107b17 <vector188>:
.globl vector188
vector188:
  pushl $0
80107b17:	6a 00                	push   $0x0
  pushl $188
80107b19:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80107b1e:	e9 e4 f3 ff ff       	jmp    80106f07 <alltraps>

80107b23 <vector189>:
.globl vector189
vector189:
  pushl $0
80107b23:	6a 00                	push   $0x0
  pushl $189
80107b25:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80107b2a:	e9 d8 f3 ff ff       	jmp    80106f07 <alltraps>

80107b2f <vector190>:
.globl vector190
vector190:
  pushl $0
80107b2f:	6a 00                	push   $0x0
  pushl $190
80107b31:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107b36:	e9 cc f3 ff ff       	jmp    80106f07 <alltraps>

80107b3b <vector191>:
.globl vector191
vector191:
  pushl $0
80107b3b:	6a 00                	push   $0x0
  pushl $191
80107b3d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107b42:	e9 c0 f3 ff ff       	jmp    80106f07 <alltraps>

80107b47 <vector192>:
.globl vector192
vector192:
  pushl $0
80107b47:	6a 00                	push   $0x0
  pushl $192
80107b49:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80107b4e:	e9 b4 f3 ff ff       	jmp    80106f07 <alltraps>

80107b53 <vector193>:
.globl vector193
vector193:
  pushl $0
80107b53:	6a 00                	push   $0x0
  pushl $193
80107b55:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80107b5a:	e9 a8 f3 ff ff       	jmp    80106f07 <alltraps>

80107b5f <vector194>:
.globl vector194
vector194:
  pushl $0
80107b5f:	6a 00                	push   $0x0
  pushl $194
80107b61:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107b66:	e9 9c f3 ff ff       	jmp    80106f07 <alltraps>

80107b6b <vector195>:
.globl vector195
vector195:
  pushl $0
80107b6b:	6a 00                	push   $0x0
  pushl $195
80107b6d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107b72:	e9 90 f3 ff ff       	jmp    80106f07 <alltraps>

80107b77 <vector196>:
.globl vector196
vector196:
  pushl $0
80107b77:	6a 00                	push   $0x0
  pushl $196
80107b79:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80107b7e:	e9 84 f3 ff ff       	jmp    80106f07 <alltraps>

80107b83 <vector197>:
.globl vector197
vector197:
  pushl $0
80107b83:	6a 00                	push   $0x0
  pushl $197
80107b85:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80107b8a:	e9 78 f3 ff ff       	jmp    80106f07 <alltraps>

80107b8f <vector198>:
.globl vector198
vector198:
  pushl $0
80107b8f:	6a 00                	push   $0x0
  pushl $198
80107b91:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107b96:	e9 6c f3 ff ff       	jmp    80106f07 <alltraps>

80107b9b <vector199>:
.globl vector199
vector199:
  pushl $0
80107b9b:	6a 00                	push   $0x0
  pushl $199
80107b9d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107ba2:	e9 60 f3 ff ff       	jmp    80106f07 <alltraps>

80107ba7 <vector200>:
.globl vector200
vector200:
  pushl $0
80107ba7:	6a 00                	push   $0x0
  pushl $200
80107ba9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80107bae:	e9 54 f3 ff ff       	jmp    80106f07 <alltraps>

80107bb3 <vector201>:
.globl vector201
vector201:
  pushl $0
80107bb3:	6a 00                	push   $0x0
  pushl $201
80107bb5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80107bba:	e9 48 f3 ff ff       	jmp    80106f07 <alltraps>

80107bbf <vector202>:
.globl vector202
vector202:
  pushl $0
80107bbf:	6a 00                	push   $0x0
  pushl $202
80107bc1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107bc6:	e9 3c f3 ff ff       	jmp    80106f07 <alltraps>

80107bcb <vector203>:
.globl vector203
vector203:
  pushl $0
80107bcb:	6a 00                	push   $0x0
  pushl $203
80107bcd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107bd2:	e9 30 f3 ff ff       	jmp    80106f07 <alltraps>

80107bd7 <vector204>:
.globl vector204
vector204:
  pushl $0
80107bd7:	6a 00                	push   $0x0
  pushl $204
80107bd9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80107bde:	e9 24 f3 ff ff       	jmp    80106f07 <alltraps>

80107be3 <vector205>:
.globl vector205
vector205:
  pushl $0
80107be3:	6a 00                	push   $0x0
  pushl $205
80107be5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80107bea:	e9 18 f3 ff ff       	jmp    80106f07 <alltraps>

80107bef <vector206>:
.globl vector206
vector206:
  pushl $0
80107bef:	6a 00                	push   $0x0
  pushl $206
80107bf1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107bf6:	e9 0c f3 ff ff       	jmp    80106f07 <alltraps>

80107bfb <vector207>:
.globl vector207
vector207:
  pushl $0
80107bfb:	6a 00                	push   $0x0
  pushl $207
80107bfd:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107c02:	e9 00 f3 ff ff       	jmp    80106f07 <alltraps>

80107c07 <vector208>:
.globl vector208
vector208:
  pushl $0
80107c07:	6a 00                	push   $0x0
  pushl $208
80107c09:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107c0e:	e9 f4 f2 ff ff       	jmp    80106f07 <alltraps>

80107c13 <vector209>:
.globl vector209
vector209:
  pushl $0
80107c13:	6a 00                	push   $0x0
  pushl $209
80107c15:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80107c1a:	e9 e8 f2 ff ff       	jmp    80106f07 <alltraps>

80107c1f <vector210>:
.globl vector210
vector210:
  pushl $0
80107c1f:	6a 00                	push   $0x0
  pushl $210
80107c21:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107c26:	e9 dc f2 ff ff       	jmp    80106f07 <alltraps>

80107c2b <vector211>:
.globl vector211
vector211:
  pushl $0
80107c2b:	6a 00                	push   $0x0
  pushl $211
80107c2d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107c32:	e9 d0 f2 ff ff       	jmp    80106f07 <alltraps>

80107c37 <vector212>:
.globl vector212
vector212:
  pushl $0
80107c37:	6a 00                	push   $0x0
  pushl $212
80107c39:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107c3e:	e9 c4 f2 ff ff       	jmp    80106f07 <alltraps>

80107c43 <vector213>:
.globl vector213
vector213:
  pushl $0
80107c43:	6a 00                	push   $0x0
  pushl $213
80107c45:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107c4a:	e9 b8 f2 ff ff       	jmp    80106f07 <alltraps>

80107c4f <vector214>:
.globl vector214
vector214:
  pushl $0
80107c4f:	6a 00                	push   $0x0
  pushl $214
80107c51:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107c56:	e9 ac f2 ff ff       	jmp    80106f07 <alltraps>

80107c5b <vector215>:
.globl vector215
vector215:
  pushl $0
80107c5b:	6a 00                	push   $0x0
  pushl $215
80107c5d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107c62:	e9 a0 f2 ff ff       	jmp    80106f07 <alltraps>

80107c67 <vector216>:
.globl vector216
vector216:
  pushl $0
80107c67:	6a 00                	push   $0x0
  pushl $216
80107c69:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107c6e:	e9 94 f2 ff ff       	jmp    80106f07 <alltraps>

80107c73 <vector217>:
.globl vector217
vector217:
  pushl $0
80107c73:	6a 00                	push   $0x0
  pushl $217
80107c75:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80107c7a:	e9 88 f2 ff ff       	jmp    80106f07 <alltraps>

80107c7f <vector218>:
.globl vector218
vector218:
  pushl $0
80107c7f:	6a 00                	push   $0x0
  pushl $218
80107c81:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107c86:	e9 7c f2 ff ff       	jmp    80106f07 <alltraps>

80107c8b <vector219>:
.globl vector219
vector219:
  pushl $0
80107c8b:	6a 00                	push   $0x0
  pushl $219
80107c8d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107c92:	e9 70 f2 ff ff       	jmp    80106f07 <alltraps>

80107c97 <vector220>:
.globl vector220
vector220:
  pushl $0
80107c97:	6a 00                	push   $0x0
  pushl $220
80107c99:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107c9e:	e9 64 f2 ff ff       	jmp    80106f07 <alltraps>

80107ca3 <vector221>:
.globl vector221
vector221:
  pushl $0
80107ca3:	6a 00                	push   $0x0
  pushl $221
80107ca5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107caa:	e9 58 f2 ff ff       	jmp    80106f07 <alltraps>

80107caf <vector222>:
.globl vector222
vector222:
  pushl $0
80107caf:	6a 00                	push   $0x0
  pushl $222
80107cb1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107cb6:	e9 4c f2 ff ff       	jmp    80106f07 <alltraps>

80107cbb <vector223>:
.globl vector223
vector223:
  pushl $0
80107cbb:	6a 00                	push   $0x0
  pushl $223
80107cbd:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107cc2:	e9 40 f2 ff ff       	jmp    80106f07 <alltraps>

80107cc7 <vector224>:
.globl vector224
vector224:
  pushl $0
80107cc7:	6a 00                	push   $0x0
  pushl $224
80107cc9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80107cce:	e9 34 f2 ff ff       	jmp    80106f07 <alltraps>

80107cd3 <vector225>:
.globl vector225
vector225:
  pushl $0
80107cd3:	6a 00                	push   $0x0
  pushl $225
80107cd5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107cda:	e9 28 f2 ff ff       	jmp    80106f07 <alltraps>

80107cdf <vector226>:
.globl vector226
vector226:
  pushl $0
80107cdf:	6a 00                	push   $0x0
  pushl $226
80107ce1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107ce6:	e9 1c f2 ff ff       	jmp    80106f07 <alltraps>

80107ceb <vector227>:
.globl vector227
vector227:
  pushl $0
80107ceb:	6a 00                	push   $0x0
  pushl $227
80107ced:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107cf2:	e9 10 f2 ff ff       	jmp    80106f07 <alltraps>

80107cf7 <vector228>:
.globl vector228
vector228:
  pushl $0
80107cf7:	6a 00                	push   $0x0
  pushl $228
80107cf9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107cfe:	e9 04 f2 ff ff       	jmp    80106f07 <alltraps>

80107d03 <vector229>:
.globl vector229
vector229:
  pushl $0
80107d03:	6a 00                	push   $0x0
  pushl $229
80107d05:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107d0a:	e9 f8 f1 ff ff       	jmp    80106f07 <alltraps>

80107d0f <vector230>:
.globl vector230
vector230:
  pushl $0
80107d0f:	6a 00                	push   $0x0
  pushl $230
80107d11:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107d16:	e9 ec f1 ff ff       	jmp    80106f07 <alltraps>

80107d1b <vector231>:
.globl vector231
vector231:
  pushl $0
80107d1b:	6a 00                	push   $0x0
  pushl $231
80107d1d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107d22:	e9 e0 f1 ff ff       	jmp    80106f07 <alltraps>

80107d27 <vector232>:
.globl vector232
vector232:
  pushl $0
80107d27:	6a 00                	push   $0x0
  pushl $232
80107d29:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107d2e:	e9 d4 f1 ff ff       	jmp    80106f07 <alltraps>

80107d33 <vector233>:
.globl vector233
vector233:
  pushl $0
80107d33:	6a 00                	push   $0x0
  pushl $233
80107d35:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107d3a:	e9 c8 f1 ff ff       	jmp    80106f07 <alltraps>

80107d3f <vector234>:
.globl vector234
vector234:
  pushl $0
80107d3f:	6a 00                	push   $0x0
  pushl $234
80107d41:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107d46:	e9 bc f1 ff ff       	jmp    80106f07 <alltraps>

80107d4b <vector235>:
.globl vector235
vector235:
  pushl $0
80107d4b:	6a 00                	push   $0x0
  pushl $235
80107d4d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107d52:	e9 b0 f1 ff ff       	jmp    80106f07 <alltraps>

80107d57 <vector236>:
.globl vector236
vector236:
  pushl $0
80107d57:	6a 00                	push   $0x0
  pushl $236
80107d59:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107d5e:	e9 a4 f1 ff ff       	jmp    80106f07 <alltraps>

80107d63 <vector237>:
.globl vector237
vector237:
  pushl $0
80107d63:	6a 00                	push   $0x0
  pushl $237
80107d65:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107d6a:	e9 98 f1 ff ff       	jmp    80106f07 <alltraps>

80107d6f <vector238>:
.globl vector238
vector238:
  pushl $0
80107d6f:	6a 00                	push   $0x0
  pushl $238
80107d71:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107d76:	e9 8c f1 ff ff       	jmp    80106f07 <alltraps>

80107d7b <vector239>:
.globl vector239
vector239:
  pushl $0
80107d7b:	6a 00                	push   $0x0
  pushl $239
80107d7d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107d82:	e9 80 f1 ff ff       	jmp    80106f07 <alltraps>

80107d87 <vector240>:
.globl vector240
vector240:
  pushl $0
80107d87:	6a 00                	push   $0x0
  pushl $240
80107d89:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107d8e:	e9 74 f1 ff ff       	jmp    80106f07 <alltraps>

80107d93 <vector241>:
.globl vector241
vector241:
  pushl $0
80107d93:	6a 00                	push   $0x0
  pushl $241
80107d95:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107d9a:	e9 68 f1 ff ff       	jmp    80106f07 <alltraps>

80107d9f <vector242>:
.globl vector242
vector242:
  pushl $0
80107d9f:	6a 00                	push   $0x0
  pushl $242
80107da1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107da6:	e9 5c f1 ff ff       	jmp    80106f07 <alltraps>

80107dab <vector243>:
.globl vector243
vector243:
  pushl $0
80107dab:	6a 00                	push   $0x0
  pushl $243
80107dad:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107db2:	e9 50 f1 ff ff       	jmp    80106f07 <alltraps>

80107db7 <vector244>:
.globl vector244
vector244:
  pushl $0
80107db7:	6a 00                	push   $0x0
  pushl $244
80107db9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107dbe:	e9 44 f1 ff ff       	jmp    80106f07 <alltraps>

80107dc3 <vector245>:
.globl vector245
vector245:
  pushl $0
80107dc3:	6a 00                	push   $0x0
  pushl $245
80107dc5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107dca:	e9 38 f1 ff ff       	jmp    80106f07 <alltraps>

80107dcf <vector246>:
.globl vector246
vector246:
  pushl $0
80107dcf:	6a 00                	push   $0x0
  pushl $246
80107dd1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107dd6:	e9 2c f1 ff ff       	jmp    80106f07 <alltraps>

80107ddb <vector247>:
.globl vector247
vector247:
  pushl $0
80107ddb:	6a 00                	push   $0x0
  pushl $247
80107ddd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107de2:	e9 20 f1 ff ff       	jmp    80106f07 <alltraps>

80107de7 <vector248>:
.globl vector248
vector248:
  pushl $0
80107de7:	6a 00                	push   $0x0
  pushl $248
80107de9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107dee:	e9 14 f1 ff ff       	jmp    80106f07 <alltraps>

80107df3 <vector249>:
.globl vector249
vector249:
  pushl $0
80107df3:	6a 00                	push   $0x0
  pushl $249
80107df5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107dfa:	e9 08 f1 ff ff       	jmp    80106f07 <alltraps>

80107dff <vector250>:
.globl vector250
vector250:
  pushl $0
80107dff:	6a 00                	push   $0x0
  pushl $250
80107e01:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107e06:	e9 fc f0 ff ff       	jmp    80106f07 <alltraps>

80107e0b <vector251>:
.globl vector251
vector251:
  pushl $0
80107e0b:	6a 00                	push   $0x0
  pushl $251
80107e0d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107e12:	e9 f0 f0 ff ff       	jmp    80106f07 <alltraps>

80107e17 <vector252>:
.globl vector252
vector252:
  pushl $0
80107e17:	6a 00                	push   $0x0
  pushl $252
80107e19:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107e1e:	e9 e4 f0 ff ff       	jmp    80106f07 <alltraps>

80107e23 <vector253>:
.globl vector253
vector253:
  pushl $0
80107e23:	6a 00                	push   $0x0
  pushl $253
80107e25:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107e2a:	e9 d8 f0 ff ff       	jmp    80106f07 <alltraps>

80107e2f <vector254>:
.globl vector254
vector254:
  pushl $0
80107e2f:	6a 00                	push   $0x0
  pushl $254
80107e31:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107e36:	e9 cc f0 ff ff       	jmp    80106f07 <alltraps>

80107e3b <vector255>:
.globl vector255
vector255:
  pushl $0
80107e3b:	6a 00                	push   $0x0
  pushl $255
80107e3d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107e42:	e9 c0 f0 ff ff       	jmp    80106f07 <alltraps>
80107e47:	66 90                	xchg   %ax,%ax
80107e49:	66 90                	xchg   %ax,%ax
80107e4b:	66 90                	xchg   %ax,%ax
80107e4d:	66 90                	xchg   %ax,%ax
80107e4f:	90                   	nop

80107e50 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107e50:	55                   	push   %ebp
80107e51:	89 e5                	mov    %esp,%ebp
80107e53:	57                   	push   %edi
80107e54:	56                   	push   %esi
80107e55:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107e57:	c1 ea 16             	shr    $0x16,%edx
{
80107e5a:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
80107e5b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
80107e5e:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80107e61:	8b 07                	mov    (%edi),%eax
80107e63:	a8 01                	test   $0x1,%al
80107e65:	74 29                	je     80107e90 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107e67:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e6c:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107e72:	c1 ee 0a             	shr    $0xa,%esi
}
80107e75:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80107e78:	89 f2                	mov    %esi,%edx
80107e7a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107e80:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80107e83:	5b                   	pop    %ebx
80107e84:	5e                   	pop    %esi
80107e85:	5f                   	pop    %edi
80107e86:	5d                   	pop    %ebp
80107e87:	c3                   	ret    
80107e88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e8f:	90                   	nop
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107e90:	85 c9                	test   %ecx,%ecx
80107e92:	74 2c                	je     80107ec0 <walkpgdir+0x70>
80107e94:	e8 87 aa ff ff       	call   80102920 <kalloc>
80107e99:	89 c3                	mov    %eax,%ebx
80107e9b:	85 c0                	test   %eax,%eax
80107e9d:	74 21                	je     80107ec0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
80107e9f:	83 ec 04             	sub    $0x4,%esp
80107ea2:	68 00 10 00 00       	push   $0x1000
80107ea7:	6a 00                	push   $0x0
80107ea9:	50                   	push   %eax
80107eaa:	e8 f1 db ff ff       	call   80105aa0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107eaf:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107eb5:	83 c4 10             	add    $0x10,%esp
80107eb8:	83 c8 07             	or     $0x7,%eax
80107ebb:	89 07                	mov    %eax,(%edi)
80107ebd:	eb b3                	jmp    80107e72 <walkpgdir+0x22>
80107ebf:	90                   	nop
}
80107ec0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80107ec3:	31 c0                	xor    %eax,%eax
}
80107ec5:	5b                   	pop    %ebx
80107ec6:	5e                   	pop    %esi
80107ec7:	5f                   	pop    %edi
80107ec8:	5d                   	pop    %ebp
80107ec9:	c3                   	ret    
80107eca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107ed0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107ed0:	55                   	push   %ebp
80107ed1:	89 e5                	mov    %esp,%ebp
80107ed3:	57                   	push   %edi
80107ed4:	56                   	push   %esi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107ed5:	89 d6                	mov    %edx,%esi
{
80107ed7:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107ed8:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
{
80107ede:	83 ec 1c             	sub    $0x1c,%esp
80107ee1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107ee4:	8b 7d 08             	mov    0x8(%ebp),%edi
80107ee7:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107eeb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ef0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107ef3:	29 f7                	sub    %esi,%edi
80107ef5:	eb 21                	jmp    80107f18 <mappages+0x48>
80107ef7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107efe:	66 90                	xchg   %ax,%ax
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80107f00:	f6 00 01             	testb  $0x1,(%eax)
80107f03:	75 45                	jne    80107f4a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80107f05:	0b 5d 0c             	or     0xc(%ebp),%ebx
80107f08:	83 cb 01             	or     $0x1,%ebx
80107f0b:	89 18                	mov    %ebx,(%eax)
    if(a == last)
80107f0d:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80107f10:	74 2e                	je     80107f40 <mappages+0x70>
      break;
    a += PGSIZE;
80107f12:	81 c6 00 10 00 00    	add    $0x1000,%esi
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107f18:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107f1b:	b9 01 00 00 00       	mov    $0x1,%ecx
80107f20:	89 f2                	mov    %esi,%edx
80107f22:	8d 1c 3e             	lea    (%esi,%edi,1),%ebx
80107f25:	e8 26 ff ff ff       	call   80107e50 <walkpgdir>
80107f2a:	85 c0                	test   %eax,%eax
80107f2c:	75 d2                	jne    80107f00 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80107f2e:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107f31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107f36:	5b                   	pop    %ebx
80107f37:	5e                   	pop    %esi
80107f38:	5f                   	pop    %edi
80107f39:	5d                   	pop    %ebp
80107f3a:	c3                   	ret    
80107f3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107f3f:	90                   	nop
80107f40:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107f43:	31 c0                	xor    %eax,%eax
}
80107f45:	5b                   	pop    %ebx
80107f46:	5e                   	pop    %esi
80107f47:	5f                   	pop    %edi
80107f48:	5d                   	pop    %ebp
80107f49:	c3                   	ret    
      panic("remap");
80107f4a:	83 ec 0c             	sub    $0xc,%esp
80107f4d:	68 a8 93 10 80       	push   $0x801093a8
80107f52:	e8 39 84 ff ff       	call   80100390 <panic>
80107f57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107f5e:	66 90                	xchg   %ax,%ax

80107f60 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107f60:	55                   	push   %ebp
80107f61:	89 e5                	mov    %esp,%ebp
80107f63:	57                   	push   %edi
80107f64:	89 c7                	mov    %eax,%edi
80107f66:	56                   	push   %esi
80107f67:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107f68:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80107f6e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107f74:	83 ec 1c             	sub    $0x1c,%esp
80107f77:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107f7a:	39 d3                	cmp    %edx,%ebx
80107f7c:	73 5a                	jae    80107fd8 <deallocuvm.part.0+0x78>
80107f7e:	89 d6                	mov    %edx,%esi
80107f80:	eb 10                	jmp    80107f92 <deallocuvm.part.0+0x32>
80107f82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107f88:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107f8e:	39 de                	cmp    %ebx,%esi
80107f90:	76 46                	jbe    80107fd8 <deallocuvm.part.0+0x78>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107f92:	31 c9                	xor    %ecx,%ecx
80107f94:	89 da                	mov    %ebx,%edx
80107f96:	89 f8                	mov    %edi,%eax
80107f98:	e8 b3 fe ff ff       	call   80107e50 <walkpgdir>
    if(!pte)
80107f9d:	85 c0                	test   %eax,%eax
80107f9f:	74 47                	je     80107fe8 <deallocuvm.part.0+0x88>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80107fa1:	8b 10                	mov    (%eax),%edx
80107fa3:	f6 c2 01             	test   $0x1,%dl
80107fa6:	74 e0                	je     80107f88 <deallocuvm.part.0+0x28>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80107fa8:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107fae:	74 46                	je     80107ff6 <deallocuvm.part.0+0x96>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80107fb0:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80107fb3:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107fb9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80107fbc:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107fc2:	52                   	push   %edx
80107fc3:	e8 98 a7 ff ff       	call   80102760 <kfree>
      *pte = 0;
80107fc8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107fcb:	83 c4 10             	add    $0x10,%esp
80107fce:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80107fd4:	39 de                	cmp    %ebx,%esi
80107fd6:	77 ba                	ja     80107f92 <deallocuvm.part.0+0x32>
    }
  }
  return newsz;
}
80107fd8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107fdb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107fde:	5b                   	pop    %ebx
80107fdf:	5e                   	pop    %esi
80107fe0:	5f                   	pop    %edi
80107fe1:	5d                   	pop    %ebp
80107fe2:	c3                   	ret    
80107fe3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107fe7:	90                   	nop
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107fe8:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80107fee:	81 c3 00 00 40 00    	add    $0x400000,%ebx
80107ff4:	eb 98                	jmp    80107f8e <deallocuvm.part.0+0x2e>
        panic("kfree");
80107ff6:	83 ec 0c             	sub    $0xc,%esp
80107ff9:	68 f2 89 10 80       	push   $0x801089f2
80107ffe:	e8 8d 83 ff ff       	call   80100390 <panic>
80108003:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010800a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108010 <seginit>:
{
80108010:	55                   	push   %ebp
80108011:	89 e5                	mov    %esp,%ebp
80108013:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80108016:	e8 d5 be ff ff       	call   80103ef0 <cpuid>
  pd[0] = size-1;
8010801b:	ba 2f 00 00 00       	mov    $0x2f,%edx
80108020:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80108026:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010802a:	c7 80 f8 6f 11 80 ff 	movl   $0xffff,-0x7fee9008(%eax)
80108031:	ff 00 00 
80108034:	c7 80 fc 6f 11 80 00 	movl   $0xcf9a00,-0x7fee9004(%eax)
8010803b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010803e:	c7 80 00 70 11 80 ff 	movl   $0xffff,-0x7fee9000(%eax)
80108045:	ff 00 00 
80108048:	c7 80 04 70 11 80 00 	movl   $0xcf9200,-0x7fee8ffc(%eax)
8010804f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80108052:	c7 80 08 70 11 80 ff 	movl   $0xffff,-0x7fee8ff8(%eax)
80108059:	ff 00 00 
8010805c:	c7 80 0c 70 11 80 00 	movl   $0xcffa00,-0x7fee8ff4(%eax)
80108063:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80108066:	c7 80 10 70 11 80 ff 	movl   $0xffff,-0x7fee8ff0(%eax)
8010806d:	ff 00 00 
80108070:	c7 80 14 70 11 80 00 	movl   $0xcff200,-0x7fee8fec(%eax)
80108077:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010807a:	05 f0 6f 11 80       	add    $0x80116ff0,%eax
  pd[1] = (uint)p;
8010807f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80108083:	c1 e8 10             	shr    $0x10,%eax
80108086:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010808a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010808d:	0f 01 10             	lgdtl  (%eax)
}
80108090:	c9                   	leave  
80108091:	c3                   	ret    
80108092:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801080a0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801080a0:	a1 24 7d 11 80       	mov    0x80117d24,%eax
801080a5:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801080aa:	0f 22 d8             	mov    %eax,%cr3
}
801080ad:	c3                   	ret    
801080ae:	66 90                	xchg   %ax,%ax

801080b0 <switchuvm>:
{
801080b0:	55                   	push   %ebp
801080b1:	89 e5                	mov    %esp,%ebp
801080b3:	57                   	push   %edi
801080b4:	56                   	push   %esi
801080b5:	53                   	push   %ebx
801080b6:	83 ec 1c             	sub    $0x1c,%esp
801080b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
801080bc:	85 db                	test   %ebx,%ebx
801080be:	0f 84 cb 00 00 00    	je     8010818f <switchuvm+0xdf>
  if(p->kstack == 0)
801080c4:	8b 43 08             	mov    0x8(%ebx),%eax
801080c7:	85 c0                	test   %eax,%eax
801080c9:	0f 84 da 00 00 00    	je     801081a9 <switchuvm+0xf9>
  if(p->pgdir == 0)
801080cf:	8b 43 04             	mov    0x4(%ebx),%eax
801080d2:	85 c0                	test   %eax,%eax
801080d4:	0f 84 c2 00 00 00    	je     8010819c <switchuvm+0xec>
  pushcli();
801080da:	e8 c1 d7 ff ff       	call   801058a0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801080df:	e8 8c bd ff ff       	call   80103e70 <mycpu>
801080e4:	89 c6                	mov    %eax,%esi
801080e6:	e8 85 bd ff ff       	call   80103e70 <mycpu>
801080eb:	89 c7                	mov    %eax,%edi
801080ed:	e8 7e bd ff ff       	call   80103e70 <mycpu>
801080f2:	83 c7 08             	add    $0x8,%edi
801080f5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801080f8:	e8 73 bd ff ff       	call   80103e70 <mycpu>
801080fd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80108100:	ba 67 00 00 00       	mov    $0x67,%edx
80108105:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
8010810c:	83 c0 08             	add    $0x8,%eax
8010810f:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80108116:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010811b:	83 c1 08             	add    $0x8,%ecx
8010811e:	c1 e8 18             	shr    $0x18,%eax
80108121:	c1 e9 10             	shr    $0x10,%ecx
80108124:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
8010812a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80108130:	b9 99 40 00 00       	mov    $0x4099,%ecx
80108135:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010813c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80108141:	e8 2a bd ff ff       	call   80103e70 <mycpu>
80108146:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010814d:	e8 1e bd ff ff       	call   80103e70 <mycpu>
80108152:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80108156:	8b 73 08             	mov    0x8(%ebx),%esi
80108159:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010815f:	e8 0c bd ff ff       	call   80103e70 <mycpu>
80108164:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80108167:	e8 04 bd ff ff       	call   80103e70 <mycpu>
8010816c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80108170:	b8 28 00 00 00       	mov    $0x28,%eax
80108175:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80108178:	8b 43 04             	mov    0x4(%ebx),%eax
8010817b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80108180:	0f 22 d8             	mov    %eax,%cr3
}
80108183:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108186:	5b                   	pop    %ebx
80108187:	5e                   	pop    %esi
80108188:	5f                   	pop    %edi
80108189:	5d                   	pop    %ebp
  popcli();
8010818a:	e9 61 d7 ff ff       	jmp    801058f0 <popcli>
    panic("switchuvm: no process");
8010818f:	83 ec 0c             	sub    $0xc,%esp
80108192:	68 ae 93 10 80       	push   $0x801093ae
80108197:	e8 f4 81 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
8010819c:	83 ec 0c             	sub    $0xc,%esp
8010819f:	68 d9 93 10 80       	push   $0x801093d9
801081a4:	e8 e7 81 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
801081a9:	83 ec 0c             	sub    $0xc,%esp
801081ac:	68 c4 93 10 80       	push   $0x801093c4
801081b1:	e8 da 81 ff ff       	call   80100390 <panic>
801081b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801081bd:	8d 76 00             	lea    0x0(%esi),%esi

801081c0 <inituvm>:
{
801081c0:	55                   	push   %ebp
801081c1:	89 e5                	mov    %esp,%ebp
801081c3:	57                   	push   %edi
801081c4:	56                   	push   %esi
801081c5:	53                   	push   %ebx
801081c6:	83 ec 1c             	sub    $0x1c,%esp
801081c9:	8b 45 08             	mov    0x8(%ebp),%eax
801081cc:	8b 75 10             	mov    0x10(%ebp),%esi
801081cf:	8b 7d 0c             	mov    0xc(%ebp),%edi
801081d2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
801081d5:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801081db:	77 49                	ja     80108226 <inituvm+0x66>
  mem = kalloc();
801081dd:	e8 3e a7 ff ff       	call   80102920 <kalloc>
  memset(mem, 0, PGSIZE);
801081e2:	83 ec 04             	sub    $0x4,%esp
801081e5:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
801081ea:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801081ec:	6a 00                	push   $0x0
801081ee:	50                   	push   %eax
801081ef:	e8 ac d8 ff ff       	call   80105aa0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801081f4:	58                   	pop    %eax
801081f5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801081fb:	5a                   	pop    %edx
801081fc:	6a 06                	push   $0x6
801081fe:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108203:	31 d2                	xor    %edx,%edx
80108205:	50                   	push   %eax
80108206:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108209:	e8 c2 fc ff ff       	call   80107ed0 <mappages>
  memmove(mem, init, sz);
8010820e:	89 75 10             	mov    %esi,0x10(%ebp)
80108211:	83 c4 10             	add    $0x10,%esp
80108214:	89 7d 0c             	mov    %edi,0xc(%ebp)
80108217:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010821a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010821d:	5b                   	pop    %ebx
8010821e:	5e                   	pop    %esi
8010821f:	5f                   	pop    %edi
80108220:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80108221:	e9 1a d9 ff ff       	jmp    80105b40 <memmove>
    panic("inituvm: more than a page");
80108226:	83 ec 0c             	sub    $0xc,%esp
80108229:	68 ed 93 10 80       	push   $0x801093ed
8010822e:	e8 5d 81 ff ff       	call   80100390 <panic>
80108233:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010823a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108240 <loaduvm>:
{
80108240:	55                   	push   %ebp
80108241:	89 e5                	mov    %esp,%ebp
80108243:	57                   	push   %edi
80108244:	56                   	push   %esi
80108245:	53                   	push   %ebx
80108246:	83 ec 1c             	sub    $0x1c,%esp
80108249:	8b 45 0c             	mov    0xc(%ebp),%eax
8010824c:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
8010824f:	a9 ff 0f 00 00       	test   $0xfff,%eax
80108254:	0f 85 8d 00 00 00    	jne    801082e7 <loaduvm+0xa7>
8010825a:	01 f0                	add    %esi,%eax
  for(i = 0; i < sz; i += PGSIZE){
8010825c:	89 f3                	mov    %esi,%ebx
8010825e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108261:	8b 45 14             	mov    0x14(%ebp),%eax
80108264:	01 f0                	add    %esi,%eax
80108266:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80108269:	85 f6                	test   %esi,%esi
8010826b:	75 11                	jne    8010827e <loaduvm+0x3e>
8010826d:	eb 61                	jmp    801082d0 <loaduvm+0x90>
8010826f:	90                   	nop
80108270:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80108276:	89 f0                	mov    %esi,%eax
80108278:	29 d8                	sub    %ebx,%eax
8010827a:	39 c6                	cmp    %eax,%esi
8010827c:	76 52                	jbe    801082d0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010827e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80108281:	8b 45 08             	mov    0x8(%ebp),%eax
80108284:	31 c9                	xor    %ecx,%ecx
80108286:	29 da                	sub    %ebx,%edx
80108288:	e8 c3 fb ff ff       	call   80107e50 <walkpgdir>
8010828d:	85 c0                	test   %eax,%eax
8010828f:	74 49                	je     801082da <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80108291:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108293:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
80108296:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
8010829b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801082a0:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
801082a6:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801082a9:	29 d9                	sub    %ebx,%ecx
801082ab:	05 00 00 00 80       	add    $0x80000000,%eax
801082b0:	57                   	push   %edi
801082b1:	51                   	push   %ecx
801082b2:	50                   	push   %eax
801082b3:	ff 75 10             	pushl  0x10(%ebp)
801082b6:	e8 35 99 ff ff       	call   80101bf0 <readi>
801082bb:	83 c4 10             	add    $0x10,%esp
801082be:	39 f8                	cmp    %edi,%eax
801082c0:	74 ae                	je     80108270 <loaduvm+0x30>
}
801082c2:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801082c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801082ca:	5b                   	pop    %ebx
801082cb:	5e                   	pop    %esi
801082cc:	5f                   	pop    %edi
801082cd:	5d                   	pop    %ebp
801082ce:	c3                   	ret    
801082cf:	90                   	nop
801082d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801082d3:	31 c0                	xor    %eax,%eax
}
801082d5:	5b                   	pop    %ebx
801082d6:	5e                   	pop    %esi
801082d7:	5f                   	pop    %edi
801082d8:	5d                   	pop    %ebp
801082d9:	c3                   	ret    
      panic("loaduvm: address should exist");
801082da:	83 ec 0c             	sub    $0xc,%esp
801082dd:	68 07 94 10 80       	push   $0x80109407
801082e2:	e8 a9 80 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
801082e7:	83 ec 0c             	sub    $0xc,%esp
801082ea:	68 a8 94 10 80       	push   $0x801094a8
801082ef:	e8 9c 80 ff ff       	call   80100390 <panic>
801082f4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801082fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801082ff:	90                   	nop

80108300 <allocuvm>:
{
80108300:	55                   	push   %ebp
80108301:	89 e5                	mov    %esp,%ebp
80108303:	57                   	push   %edi
80108304:	56                   	push   %esi
80108305:	53                   	push   %ebx
80108306:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80108309:	8b 7d 10             	mov    0x10(%ebp),%edi
8010830c:	85 ff                	test   %edi,%edi
8010830e:	0f 88 bc 00 00 00    	js     801083d0 <allocuvm+0xd0>
  if(newsz < oldsz)
80108314:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80108317:	0f 82 a3 00 00 00    	jb     801083c0 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
8010831d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108320:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80108326:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010832c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010832f:	0f 86 8e 00 00 00    	jbe    801083c3 <allocuvm+0xc3>
80108335:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80108338:	8b 7d 08             	mov    0x8(%ebp),%edi
8010833b:	eb 42                	jmp    8010837f <allocuvm+0x7f>
8010833d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80108340:	83 ec 04             	sub    $0x4,%esp
80108343:	68 00 10 00 00       	push   $0x1000
80108348:	6a 00                	push   $0x0
8010834a:	50                   	push   %eax
8010834b:	e8 50 d7 ff ff       	call   80105aa0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80108350:	58                   	pop    %eax
80108351:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80108357:	5a                   	pop    %edx
80108358:	6a 06                	push   $0x6
8010835a:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010835f:	89 da                	mov    %ebx,%edx
80108361:	50                   	push   %eax
80108362:	89 f8                	mov    %edi,%eax
80108364:	e8 67 fb ff ff       	call   80107ed0 <mappages>
80108369:	83 c4 10             	add    $0x10,%esp
8010836c:	85 c0                	test   %eax,%eax
8010836e:	78 70                	js     801083e0 <allocuvm+0xe0>
  for(; a < newsz; a += PGSIZE){
80108370:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80108376:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80108379:	0f 86 a1 00 00 00    	jbe    80108420 <allocuvm+0x120>
    mem = kalloc();
8010837f:	e8 9c a5 ff ff       	call   80102920 <kalloc>
80108384:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80108386:	85 c0                	test   %eax,%eax
80108388:	75 b6                	jne    80108340 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
8010838a:	83 ec 0c             	sub    $0xc,%esp
8010838d:	68 25 94 10 80       	push   $0x80109425
80108392:	e8 19 83 ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80108397:	83 c4 10             	add    $0x10,%esp
8010839a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010839d:	39 45 10             	cmp    %eax,0x10(%ebp)
801083a0:	74 2e                	je     801083d0 <allocuvm+0xd0>
801083a2:	89 c1                	mov    %eax,%ecx
801083a4:	8b 55 10             	mov    0x10(%ebp),%edx
801083a7:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
801083aa:	31 ff                	xor    %edi,%edi
801083ac:	e8 af fb ff ff       	call   80107f60 <deallocuvm.part.0>
}
801083b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801083b4:	89 f8                	mov    %edi,%eax
801083b6:	5b                   	pop    %ebx
801083b7:	5e                   	pop    %esi
801083b8:	5f                   	pop    %edi
801083b9:	5d                   	pop    %ebp
801083ba:	c3                   	ret    
801083bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801083bf:	90                   	nop
    return oldsz;
801083c0:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
801083c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801083c6:	89 f8                	mov    %edi,%eax
801083c8:	5b                   	pop    %ebx
801083c9:	5e                   	pop    %esi
801083ca:	5f                   	pop    %edi
801083cb:	5d                   	pop    %ebp
801083cc:	c3                   	ret    
801083cd:	8d 76 00             	lea    0x0(%esi),%esi
801083d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801083d3:	31 ff                	xor    %edi,%edi
}
801083d5:	5b                   	pop    %ebx
801083d6:	89 f8                	mov    %edi,%eax
801083d8:	5e                   	pop    %esi
801083d9:	5f                   	pop    %edi
801083da:	5d                   	pop    %ebp
801083db:	c3                   	ret    
801083dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cprintf("allocuvm out of memory (2)\n");
801083e0:	83 ec 0c             	sub    $0xc,%esp
801083e3:	68 3d 94 10 80       	push   $0x8010943d
801083e8:	e8 c3 82 ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
801083ed:	83 c4 10             	add    $0x10,%esp
801083f0:	8b 45 0c             	mov    0xc(%ebp),%eax
801083f3:	39 45 10             	cmp    %eax,0x10(%ebp)
801083f6:	74 0d                	je     80108405 <allocuvm+0x105>
801083f8:	89 c1                	mov    %eax,%ecx
801083fa:	8b 55 10             	mov    0x10(%ebp),%edx
801083fd:	8b 45 08             	mov    0x8(%ebp),%eax
80108400:	e8 5b fb ff ff       	call   80107f60 <deallocuvm.part.0>
      kfree(mem);
80108405:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80108408:	31 ff                	xor    %edi,%edi
      kfree(mem);
8010840a:	56                   	push   %esi
8010840b:	e8 50 a3 ff ff       	call   80102760 <kfree>
      return 0;
80108410:	83 c4 10             	add    $0x10,%esp
}
80108413:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108416:	89 f8                	mov    %edi,%eax
80108418:	5b                   	pop    %ebx
80108419:	5e                   	pop    %esi
8010841a:	5f                   	pop    %edi
8010841b:	5d                   	pop    %ebp
8010841c:	c3                   	ret    
8010841d:	8d 76 00             	lea    0x0(%esi),%esi
80108420:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80108423:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108426:	5b                   	pop    %ebx
80108427:	5e                   	pop    %esi
80108428:	89 f8                	mov    %edi,%eax
8010842a:	5f                   	pop    %edi
8010842b:	5d                   	pop    %ebp
8010842c:	c3                   	ret    
8010842d:	8d 76 00             	lea    0x0(%esi),%esi

80108430 <deallocuvm>:
{
80108430:	55                   	push   %ebp
80108431:	89 e5                	mov    %esp,%ebp
80108433:	8b 55 0c             	mov    0xc(%ebp),%edx
80108436:	8b 4d 10             	mov    0x10(%ebp),%ecx
80108439:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010843c:	39 d1                	cmp    %edx,%ecx
8010843e:	73 10                	jae    80108450 <deallocuvm+0x20>
}
80108440:	5d                   	pop    %ebp
80108441:	e9 1a fb ff ff       	jmp    80107f60 <deallocuvm.part.0>
80108446:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010844d:	8d 76 00             	lea    0x0(%esi),%esi
80108450:	89 d0                	mov    %edx,%eax
80108452:	5d                   	pop    %ebp
80108453:	c3                   	ret    
80108454:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010845b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010845f:	90                   	nop

80108460 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80108460:	55                   	push   %ebp
80108461:	89 e5                	mov    %esp,%ebp
80108463:	57                   	push   %edi
80108464:	56                   	push   %esi
80108465:	53                   	push   %ebx
80108466:	83 ec 0c             	sub    $0xc,%esp
80108469:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010846c:	85 f6                	test   %esi,%esi
8010846e:	74 59                	je     801084c9 <freevm+0x69>
  if(newsz >= oldsz)
80108470:	31 c9                	xor    %ecx,%ecx
80108472:	ba 00 00 00 80       	mov    $0x80000000,%edx
80108477:	89 f0                	mov    %esi,%eax
80108479:	89 f3                	mov    %esi,%ebx
8010847b:	e8 e0 fa ff ff       	call   80107f60 <deallocuvm.part.0>
freevm(pde_t *pgdir)
80108480:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80108486:	eb 0f                	jmp    80108497 <freevm+0x37>
80108488:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010848f:	90                   	nop
80108490:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80108493:	39 df                	cmp    %ebx,%edi
80108495:	74 23                	je     801084ba <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80108497:	8b 03                	mov    (%ebx),%eax
80108499:	a8 01                	test   $0x1,%al
8010849b:	74 f3                	je     80108490 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010849d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
801084a2:	83 ec 0c             	sub    $0xc,%esp
801084a5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801084a8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801084ad:	50                   	push   %eax
801084ae:	e8 ad a2 ff ff       	call   80102760 <kfree>
801084b3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801084b6:	39 df                	cmp    %ebx,%edi
801084b8:	75 dd                	jne    80108497 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801084ba:	89 75 08             	mov    %esi,0x8(%ebp)
}
801084bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801084c0:	5b                   	pop    %ebx
801084c1:	5e                   	pop    %esi
801084c2:	5f                   	pop    %edi
801084c3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801084c4:	e9 97 a2 ff ff       	jmp    80102760 <kfree>
    panic("freevm: no pgdir");
801084c9:	83 ec 0c             	sub    $0xc,%esp
801084cc:	68 59 94 10 80       	push   $0x80109459
801084d1:	e8 ba 7e ff ff       	call   80100390 <panic>
801084d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801084dd:	8d 76 00             	lea    0x0(%esi),%esi

801084e0 <setupkvm>:
{
801084e0:	55                   	push   %ebp
801084e1:	89 e5                	mov    %esp,%ebp
801084e3:	56                   	push   %esi
801084e4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801084e5:	e8 36 a4 ff ff       	call   80102920 <kalloc>
801084ea:	89 c6                	mov    %eax,%esi
801084ec:	85 c0                	test   %eax,%eax
801084ee:	74 42                	je     80108532 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
801084f0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801084f3:	bb 20 c4 10 80       	mov    $0x8010c420,%ebx
  memset(pgdir, 0, PGSIZE);
801084f8:	68 00 10 00 00       	push   $0x1000
801084fd:	6a 00                	push   $0x0
801084ff:	50                   	push   %eax
80108500:	e8 9b d5 ff ff       	call   80105aa0 <memset>
80108505:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80108508:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010850b:	83 ec 08             	sub    $0x8,%esp
8010850e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80108511:	ff 73 0c             	pushl  0xc(%ebx)
80108514:	8b 13                	mov    (%ebx),%edx
80108516:	50                   	push   %eax
80108517:	29 c1                	sub    %eax,%ecx
80108519:	89 f0                	mov    %esi,%eax
8010851b:	e8 b0 f9 ff ff       	call   80107ed0 <mappages>
80108520:	83 c4 10             	add    $0x10,%esp
80108523:	85 c0                	test   %eax,%eax
80108525:	78 19                	js     80108540 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108527:	83 c3 10             	add    $0x10,%ebx
8010852a:	81 fb 60 c4 10 80    	cmp    $0x8010c460,%ebx
80108530:	75 d6                	jne    80108508 <setupkvm+0x28>
}
80108532:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108535:	89 f0                	mov    %esi,%eax
80108537:	5b                   	pop    %ebx
80108538:	5e                   	pop    %esi
80108539:	5d                   	pop    %ebp
8010853a:	c3                   	ret    
8010853b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010853f:	90                   	nop
      freevm(pgdir);
80108540:	83 ec 0c             	sub    $0xc,%esp
80108543:	56                   	push   %esi
      return 0;
80108544:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80108546:	e8 15 ff ff ff       	call   80108460 <freevm>
      return 0;
8010854b:	83 c4 10             	add    $0x10,%esp
}
8010854e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108551:	89 f0                	mov    %esi,%eax
80108553:	5b                   	pop    %ebx
80108554:	5e                   	pop    %esi
80108555:	5d                   	pop    %ebp
80108556:	c3                   	ret    
80108557:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010855e:	66 90                	xchg   %ax,%ax

80108560 <kvmalloc>:
{
80108560:	55                   	push   %ebp
80108561:	89 e5                	mov    %esp,%ebp
80108563:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80108566:	e8 75 ff ff ff       	call   801084e0 <setupkvm>
8010856b:	a3 24 7d 11 80       	mov    %eax,0x80117d24
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108570:	05 00 00 00 80       	add    $0x80000000,%eax
80108575:	0f 22 d8             	mov    %eax,%cr3
}
80108578:	c9                   	leave  
80108579:	c3                   	ret    
8010857a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108580 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108580:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108581:	31 c9                	xor    %ecx,%ecx
{
80108583:	89 e5                	mov    %esp,%ebp
80108585:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80108588:	8b 55 0c             	mov    0xc(%ebp),%edx
8010858b:	8b 45 08             	mov    0x8(%ebp),%eax
8010858e:	e8 bd f8 ff ff       	call   80107e50 <walkpgdir>
  if(pte == 0)
80108593:	85 c0                	test   %eax,%eax
80108595:	74 05                	je     8010859c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80108597:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010859a:	c9                   	leave  
8010859b:	c3                   	ret    
    panic("clearpteu");
8010859c:	83 ec 0c             	sub    $0xc,%esp
8010859f:	68 6a 94 10 80       	push   $0x8010946a
801085a4:	e8 e7 7d ff ff       	call   80100390 <panic>
801085a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801085b0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801085b0:	55                   	push   %ebp
801085b1:	89 e5                	mov    %esp,%ebp
801085b3:	57                   	push   %edi
801085b4:	56                   	push   %esi
801085b5:	53                   	push   %ebx
801085b6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801085b9:	e8 22 ff ff ff       	call   801084e0 <setupkvm>
801085be:	89 45 e0             	mov    %eax,-0x20(%ebp)
801085c1:	85 c0                	test   %eax,%eax
801085c3:	0f 84 a0 00 00 00    	je     80108669 <copyuvm+0xb9>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801085c9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801085cc:	85 c9                	test   %ecx,%ecx
801085ce:	0f 84 95 00 00 00    	je     80108669 <copyuvm+0xb9>
801085d4:	31 f6                	xor    %esi,%esi
801085d6:	eb 4e                	jmp    80108626 <copyuvm+0x76>
801085d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801085df:	90                   	nop
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801085e0:	83 ec 04             	sub    $0x4,%esp
801085e3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
801085e9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801085ec:	68 00 10 00 00       	push   $0x1000
801085f1:	57                   	push   %edi
801085f2:	50                   	push   %eax
801085f3:	e8 48 d5 ff ff       	call   80105b40 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
801085f8:	58                   	pop    %eax
801085f9:	5a                   	pop    %edx
801085fa:	53                   	push   %ebx
801085fb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801085fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108601:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108606:	81 c2 00 00 00 80    	add    $0x80000000,%edx
8010860c:	52                   	push   %edx
8010860d:	89 f2                	mov    %esi,%edx
8010860f:	e8 bc f8 ff ff       	call   80107ed0 <mappages>
80108614:	83 c4 10             	add    $0x10,%esp
80108617:	85 c0                	test   %eax,%eax
80108619:	78 39                	js     80108654 <copyuvm+0xa4>
  for(i = 0; i < sz; i += PGSIZE){
8010861b:	81 c6 00 10 00 00    	add    $0x1000,%esi
80108621:	39 75 0c             	cmp    %esi,0xc(%ebp)
80108624:	76 43                	jbe    80108669 <copyuvm+0xb9>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108626:	8b 45 08             	mov    0x8(%ebp),%eax
80108629:	31 c9                	xor    %ecx,%ecx
8010862b:	89 f2                	mov    %esi,%edx
8010862d:	e8 1e f8 ff ff       	call   80107e50 <walkpgdir>
80108632:	85 c0                	test   %eax,%eax
80108634:	74 3e                	je     80108674 <copyuvm+0xc4>
    if(!(*pte & PTE_P))
80108636:	8b 18                	mov    (%eax),%ebx
80108638:	f6 c3 01             	test   $0x1,%bl
8010863b:	74 44                	je     80108681 <copyuvm+0xd1>
    pa = PTE_ADDR(*pte);
8010863d:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
8010863f:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
80108645:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
8010864b:	e8 d0 a2 ff ff       	call   80102920 <kalloc>
80108650:	85 c0                	test   %eax,%eax
80108652:	75 8c                	jne    801085e0 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
80108654:	83 ec 0c             	sub    $0xc,%esp
80108657:	ff 75 e0             	pushl  -0x20(%ebp)
8010865a:	e8 01 fe ff ff       	call   80108460 <freevm>
  return 0;
8010865f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80108666:	83 c4 10             	add    $0x10,%esp
}
80108669:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010866c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010866f:	5b                   	pop    %ebx
80108670:	5e                   	pop    %esi
80108671:	5f                   	pop    %edi
80108672:	5d                   	pop    %ebp
80108673:	c3                   	ret    
      panic("copyuvm: pte should exist");
80108674:	83 ec 0c             	sub    $0xc,%esp
80108677:	68 74 94 10 80       	push   $0x80109474
8010867c:	e8 0f 7d ff ff       	call   80100390 <panic>
      panic("copyuvm: page not present");
80108681:	83 ec 0c             	sub    $0xc,%esp
80108684:	68 8e 94 10 80       	push   $0x8010948e
80108689:	e8 02 7d ff ff       	call   80100390 <panic>
8010868e:	66 90                	xchg   %ax,%ax

80108690 <uva2ka>:

// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108690:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108691:	31 c9                	xor    %ecx,%ecx
{
80108693:	89 e5                	mov    %esp,%ebp
80108695:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80108698:	8b 55 0c             	mov    0xc(%ebp),%edx
8010869b:	8b 45 08             	mov    0x8(%ebp),%eax
8010869e:	e8 ad f7 ff ff       	call   80107e50 <walkpgdir>
  if((*pte & PTE_P) == 0)
801086a3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801086a5:	c9                   	leave  
  if((*pte & PTE_U) == 0)
801086a6:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801086a8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
801086ad:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801086b0:	05 00 00 00 80       	add    $0x80000000,%eax
801086b5:	83 fa 05             	cmp    $0x5,%edx
801086b8:	ba 00 00 00 00       	mov    $0x0,%edx
801086bd:	0f 45 c2             	cmovne %edx,%eax
}
801086c0:	c3                   	ret    
801086c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801086c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801086cf:	90                   	nop

801086d0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801086d0:	55                   	push   %ebp
801086d1:	89 e5                	mov    %esp,%ebp
801086d3:	57                   	push   %edi
801086d4:	56                   	push   %esi
801086d5:	53                   	push   %ebx
801086d6:	83 ec 0c             	sub    $0xc,%esp
801086d9:	8b 75 14             	mov    0x14(%ebp),%esi
801086dc:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801086df:	85 f6                	test   %esi,%esi
801086e1:	75 38                	jne    8010871b <copyout+0x4b>
801086e3:	eb 6b                	jmp    80108750 <copyout+0x80>
801086e5:	8d 76 00             	lea    0x0(%esi),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801086e8:	8b 55 0c             	mov    0xc(%ebp),%edx
801086eb:	89 fb                	mov    %edi,%ebx
801086ed:	29 d3                	sub    %edx,%ebx
801086ef:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
801086f5:	39 f3                	cmp    %esi,%ebx
801086f7:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801086fa:	29 fa                	sub    %edi,%edx
801086fc:	83 ec 04             	sub    $0x4,%esp
801086ff:	01 c2                	add    %eax,%edx
80108701:	53                   	push   %ebx
80108702:	ff 75 10             	pushl  0x10(%ebp)
80108705:	52                   	push   %edx
80108706:	e8 35 d4 ff ff       	call   80105b40 <memmove>
    len -= n;
    buf += n;
8010870b:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
8010870e:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
  while(len > 0){
80108714:	83 c4 10             	add    $0x10,%esp
80108717:	29 de                	sub    %ebx,%esi
80108719:	74 35                	je     80108750 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
8010871b:	89 d7                	mov    %edx,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
8010871d:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80108720:	89 55 0c             	mov    %edx,0xc(%ebp)
80108723:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80108729:	57                   	push   %edi
8010872a:	ff 75 08             	pushl  0x8(%ebp)
8010872d:	e8 5e ff ff ff       	call   80108690 <uva2ka>
    if(pa0 == 0)
80108732:	83 c4 10             	add    $0x10,%esp
80108735:	85 c0                	test   %eax,%eax
80108737:	75 af                	jne    801086e8 <copyout+0x18>
  }
  return 0;
}
80108739:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010873c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80108741:	5b                   	pop    %ebx
80108742:	5e                   	pop    %esi
80108743:	5f                   	pop    %edi
80108744:	5d                   	pop    %ebp
80108745:	c3                   	ret    
80108746:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010874d:	8d 76 00             	lea    0x0(%esi),%esi
80108750:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80108753:	31 c0                	xor    %eax,%eax
}
80108755:	5b                   	pop    %ebx
80108756:	5e                   	pop    %esi
80108757:	5f                   	pop    %edi
80108758:	5d                   	pop    %ebp
80108759:	c3                   	ret    
