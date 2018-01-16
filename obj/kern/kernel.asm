
obj/kern/kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <video_init>:
#include "video.h"
//tmphack
//#include<dev/serial.h>
void
video_init(void)
{
  100000:	56                   	push   %esi
	unsigned pos;

	/* Get a pointer to the memory-mapped text display buffer. */
	cp = (uint16_t*) CGA_BUF;
	was = *cp;
	*cp = (uint16_t) 0xA55A;
  100001:	b8 5a a5 ff ff       	mov    $0xffffa55a,%eax
#include "video.h"
//tmphack
//#include<dev/serial.h>
void
video_init(void)
{
  100006:	53                   	push   %ebx
  100007:	83 ec 14             	sub    $0x14,%esp
	uint16_t was;
	unsigned pos;

	/* Get a pointer to the memory-mapped text display buffer. */
	cp = (uint16_t*) CGA_BUF;
	was = *cp;
  10000a:	0f b7 15 00 80 0b 00 	movzwl 0xb8000,%edx
	*cp = (uint16_t) 0xA55A;
  100011:	66 a3 00 80 0b 00    	mov    %ax,0xb8000
	if (*cp != 0xA55A) {
  100017:	0f b7 05 00 80 0b 00 	movzwl 0xb8000,%eax
  10001e:	66 3d 5a a5          	cmp    $0xa55a,%ax
  100022:	0f 84 98 00 00 00    	je     1000c0 <video_init+0xc0>
		cp = (uint16_t*) MONO_BUF;
		addr_6845 = MONO_BASE;
		dprintf("addr_6845:%x\n",addr_6845);
  100028:	c7 44 24 04 b4 03 00 	movl   $0x3b4,0x4(%esp)
  10002f:	00 
	/* Get a pointer to the memory-mapped text display buffer. */
	cp = (uint16_t*) CGA_BUF;
	was = *cp;
	*cp = (uint16_t) 0xA55A;
	if (*cp != 0xA55A) {
		cp = (uint16_t*) MONO_BUF;
  100030:	be 00 00 0b 00       	mov    $0xb0000,%esi
		addr_6845 = MONO_BASE;
		dprintf("addr_6845:%x\n",addr_6845);
  100035:	c7 04 24 60 ab 10 00 	movl   $0x10ab60,(%esp)
	cp = (uint16_t*) CGA_BUF;
	was = *cp;
	*cp = (uint16_t) 0xA55A;
	if (*cp != 0xA55A) {
		cp = (uint16_t*) MONO_BUF;
		addr_6845 = MONO_BASE;
  10003c:	c7 05 f0 03 98 00 b4 	movl   $0x3b4,0x9803f0
  100043:	03 00 00 
		dprintf("addr_6845:%x\n",addr_6845);
  100046:	e8 55 43 00 00       	call   1043a0 <dprintf>
		addr_6845 = CGA_BASE;
		dprintf("addr_6845:%x\n",addr_6845);
	}
	
	/* Extract cursor location */
	outb(addr_6845, 14);
  10004b:	a1 f0 03 98 00       	mov    0x9803f0,%eax
  100050:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
  100057:	00 
  100058:	89 04 24             	mov    %eax,(%esp)
  10005b:	e8 00 50 00 00       	call   105060 <outb>
	pos = inb(addr_6845 + 1) << 8;
  100060:	a1 f0 03 98 00       	mov    0x9803f0,%eax
  100065:	83 c0 01             	add    $0x1,%eax
  100068:	89 04 24             	mov    %eax,(%esp)
  10006b:	e8 c0 4f 00 00       	call   105030 <inb>
	outb(addr_6845, 15);
  100070:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
  100077:	00 
		dprintf("addr_6845:%x\n",addr_6845);
	}
	
	/* Extract cursor location */
	outb(addr_6845, 14);
	pos = inb(addr_6845 + 1) << 8;
  100078:	0f b6 d8             	movzbl %al,%ebx
	outb(addr_6845, 15);
  10007b:	a1 f0 03 98 00       	mov    0x9803f0,%eax
		dprintf("addr_6845:%x\n",addr_6845);
	}
	
	/* Extract cursor location */
	outb(addr_6845, 14);
	pos = inb(addr_6845 + 1) << 8;
  100080:	c1 e3 08             	shl    $0x8,%ebx
	outb(addr_6845, 15);
  100083:	89 04 24             	mov    %eax,(%esp)
  100086:	e8 d5 4f 00 00       	call   105060 <outb>
	pos |= inb(addr_6845 + 1);
  10008b:	a1 f0 03 98 00       	mov    0x9803f0,%eax
  100090:	83 c0 01             	add    $0x1,%eax
  100093:	89 04 24             	mov    %eax,(%esp)
  100096:	e8 95 4f 00 00       	call   105030 <inb>

	terminal.crt_buf = (uint16_t*) cp;
  10009b:	89 35 e4 03 98 00    	mov    %esi,0x9803e4
	terminal.crt_pos = pos;
	terminal.active_console = 0;
  1000a1:	c7 05 ec 03 98 00 00 	movl   $0x0,0x9803ec
  1000a8:	00 00 00 
	
	/* Extract cursor location */
	outb(addr_6845, 14);
	pos = inb(addr_6845 + 1) << 8;
	outb(addr_6845, 15);
	pos |= inb(addr_6845 + 1);
  1000ab:	0f b6 c0             	movzbl %al,%eax
  1000ae:	09 d8                	or     %ebx,%eax

	terminal.crt_buf = (uint16_t*) cp;
	terminal.crt_pos = pos;
  1000b0:	66 a3 e8 03 98 00    	mov    %ax,0x9803e8
	terminal.active_console = 0;
//  video_clear_screen();
}
  1000b6:	83 c4 14             	add    $0x14,%esp
  1000b9:	5b                   	pop    %ebx
  1000ba:	5e                   	pop    %esi
  1000bb:	c3                   	ret    
  1000bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if (*cp != 0xA55A) {
		cp = (uint16_t*) MONO_BUF;
		addr_6845 = MONO_BASE;
		dprintf("addr_6845:%x\n",addr_6845);
	} else {
		*cp = was;
  1000c0:	66 89 15 00 80 0b 00 	mov    %dx,0xb8000
	volatile uint16_t *cp;
	uint16_t was;
	unsigned pos;

	/* Get a pointer to the memory-mapped text display buffer. */
	cp = (uint16_t*) CGA_BUF;
  1000c7:	be 00 80 0b 00       	mov    $0xb8000,%esi
		addr_6845 = MONO_BASE;
		dprintf("addr_6845:%x\n",addr_6845);
	} else {
		*cp = was;
		addr_6845 = CGA_BASE;
		dprintf("addr_6845:%x\n",addr_6845);
  1000cc:	c7 44 24 04 d4 03 00 	movl   $0x3d4,0x4(%esp)
  1000d3:	00 
  1000d4:	c7 04 24 60 ab 10 00 	movl   $0x10ab60,(%esp)
		cp = (uint16_t*) MONO_BUF;
		addr_6845 = MONO_BASE;
		dprintf("addr_6845:%x\n",addr_6845);
	} else {
		*cp = was;
		addr_6845 = CGA_BASE;
  1000db:	c7 05 f0 03 98 00 d4 	movl   $0x3d4,0x9803f0
  1000e2:	03 00 00 
		dprintf("addr_6845:%x\n",addr_6845);
  1000e5:	e8 b6 42 00 00       	call   1043a0 <dprintf>
  1000ea:	e9 5c ff ff ff       	jmp    10004b <video_init+0x4b>
  1000ef:	90                   	nop

001000f0 <video_putc>:
//  video_clear_screen();
}

void
video_putc(int c)
{
  1000f0:	83 ec 1c             	sub    $0x1c,%esp
  1000f3:	8b 44 24 20          	mov    0x20(%esp),%eax

	// if no attribute given, then use black on white
	if (!(c & ~0xFF))
		c |= 0x0700;
  1000f7:	89 c2                	mov    %eax,%edx
  1000f9:	80 ce 07             	or     $0x7,%dh
  1000fc:	a9 00 ff ff ff       	test   $0xffffff00,%eax
  100101:	0f 44 c2             	cmove  %edx,%eax

	switch (c & 0xff) {
  100104:	0f b6 d0             	movzbl %al,%edx
  100107:	83 fa 09             	cmp    $0x9,%edx
  10010a:	0f 84 64 01 00 00    	je     100274 <video_putc+0x184>
  100110:	0f 8e fa 00 00 00    	jle    100210 <video_putc+0x120>
  100116:	83 fa 0a             	cmp    $0xa,%edx
  100119:	0f 84 92 00 00 00    	je     1001b1 <video_putc+0xc1>
  10011f:	83 fa 0d             	cmp    $0xd,%edx
  100122:	0f b7 0d e8 03 98 00 	movzwl 0x9803e8,%ecx
  100129:	0f 85 1e 01 00 00    	jne    10024d <video_putc+0x15d>
		break;
	case '\n':
		terminal.crt_pos += CRT_COLS;
		/* fallthru */
	case '\r':
		terminal.crt_pos -= (terminal.crt_pos % CRT_COLS);
  10012f:	0f b7 c1             	movzwl %cx,%eax
  100132:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  100138:	c1 e8 16             	shr    $0x16,%eax
  10013b:	8d 04 80             	lea    (%eax,%eax,4),%eax
  10013e:	c1 e0 04             	shl    $0x4,%eax
  100141:	66 a3 e8 03 98 00    	mov    %ax,0x9803e8
	default:
		terminal.crt_buf[terminal.crt_pos++] = c;		/* write the character */
		break;
	}

	if (terminal.crt_pos >= CRT_SIZE) {
  100147:	66 3d cf 07          	cmp    $0x7cf,%ax
  10014b:	77 73                	ja     1001c0 <video_putc+0xd0>
		terminal.crt_pos -= CRT_COLS;
	}


	/* move that little blinky thing */
	outb(addr_6845, 14);
  10014d:	a1 f0 03 98 00       	mov    0x9803f0,%eax
  100152:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
  100159:	00 
  10015a:	89 04 24             	mov    %eax,(%esp)
  10015d:	e8 fe 4e 00 00       	call   105060 <outb>
	outb(addr_6845 + 1, terminal.crt_pos >> 8);
  100162:	0f b6 05 e9 03 98 00 	movzbl 0x9803e9,%eax
  100169:	89 44 24 04          	mov    %eax,0x4(%esp)
  10016d:	a1 f0 03 98 00       	mov    0x9803f0,%eax
  100172:	83 c0 01             	add    $0x1,%eax
  100175:	89 04 24             	mov    %eax,(%esp)
  100178:	e8 e3 4e 00 00       	call   105060 <outb>
	outb(addr_6845, 15);
  10017d:	a1 f0 03 98 00       	mov    0x9803f0,%eax
  100182:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
  100189:	00 
  10018a:	89 04 24             	mov    %eax,(%esp)
  10018d:	e8 ce 4e 00 00       	call   105060 <outb>
	outb(addr_6845 + 1, terminal.crt_pos);
  100192:	0f b6 05 e8 03 98 00 	movzbl 0x9803e8,%eax
  100199:	89 44 24 04          	mov    %eax,0x4(%esp)
  10019d:	a1 f0 03 98 00       	mov    0x9803f0,%eax
  1001a2:	83 c0 01             	add    $0x1,%eax
  1001a5:	89 04 24             	mov    %eax,(%esp)
  1001a8:	e8 b3 4e 00 00       	call   105060 <outb>
       	  }
       outb(COM1+COM_TX, c);
       tmpcount++;
	  }
	*/
}
  1001ad:	83 c4 1c             	add    $0x1c,%esp
  1001b0:	c3                   	ret    
			terminal.crt_pos--;
			terminal.crt_buf[terminal.crt_pos] = (c & ~0xff) | ' ';
		}
		break;
	case '\n':
		terminal.crt_pos += CRT_COLS;
  1001b1:	0f b7 05 e8 03 98 00 	movzwl 0x9803e8,%eax
  1001b8:	8d 48 50             	lea    0x50(%eax),%ecx
  1001bb:	e9 6f ff ff ff       	jmp    10012f <video_putc+0x3f>
		break;
	}

	if (terminal.crt_pos >= CRT_SIZE) {
		int i;
		memmove(terminal.crt_buf, terminal.crt_buf + CRT_COLS,
  1001c0:	a1 e4 03 98 00       	mov    0x9803e4,%eax
  1001c5:	c7 44 24 08 00 0f 00 	movl   $0xf00,0x8(%esp)
  1001cc:	00 
  1001cd:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  1001d3:	89 54 24 04          	mov    %edx,0x4(%esp)
  1001d7:	89 04 24             	mov    %eax,(%esp)
  1001da:	e8 f1 3b 00 00       	call   103dd0 <memmove>
  1001df:	8b 15 e4 03 98 00    	mov    0x9803e4,%edx
			(CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
		for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i++)
  1001e5:	b8 80 07 00 00       	mov    $0x780,%eax
  1001ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			terminal.crt_buf[i] = 0x0700 | ' ';
  1001f0:	b9 20 07 00 00       	mov    $0x720,%ecx
  1001f5:	66 89 0c 42          	mov    %cx,(%edx,%eax,2)

	if (terminal.crt_pos >= CRT_SIZE) {
		int i;
		memmove(terminal.crt_buf, terminal.crt_buf + CRT_COLS,
			(CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
		for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i++)
  1001f9:	83 c0 01             	add    $0x1,%eax
  1001fc:	3d d0 07 00 00       	cmp    $0x7d0,%eax
  100201:	75 ed                	jne    1001f0 <video_putc+0x100>
			terminal.crt_buf[i] = 0x0700 | ' ';
		terminal.crt_pos -= CRT_COLS;
  100203:	66 83 2d e8 03 98 00 	subw   $0x50,0x9803e8
  10020a:	50 
  10020b:	e9 3d ff ff ff       	jmp    10014d <video_putc+0x5d>

	// if no attribute given, then use black on white
	if (!(c & ~0xFF))
		c |= 0x0700;

	switch (c & 0xff) {
  100210:	83 fa 08             	cmp    $0x8,%edx
  100213:	75 38                	jne    10024d <video_putc+0x15d>
	case '\b':
		if (terminal.crt_pos > 0) {
  100215:	0f b7 15 e8 03 98 00 	movzwl 0x9803e8,%edx
  10021c:	66 85 d2             	test   %dx,%dx
  10021f:	0f 84 28 ff ff ff    	je     10014d <video_putc+0x5d>
			terminal.crt_pos--;
			terminal.crt_buf[terminal.crt_pos] = (c & ~0xff) | ' ';
  100225:	8b 0d e4 03 98 00    	mov    0x9803e4,%ecx
		c |= 0x0700;

	switch (c & 0xff) {
	case '\b':
		if (terminal.crt_pos > 0) {
			terminal.crt_pos--;
  10022b:	83 ea 01             	sub    $0x1,%edx
			terminal.crt_buf[terminal.crt_pos] = (c & ~0xff) | ' ';
  10022e:	30 c0                	xor    %al,%al
		c |= 0x0700;

	switch (c & 0xff) {
	case '\b':
		if (terminal.crt_pos > 0) {
			terminal.crt_pos--;
  100230:	66 89 15 e8 03 98 00 	mov    %dx,0x9803e8
			terminal.crt_buf[terminal.crt_pos] = (c & ~0xff) | ' ';
  100237:	83 c8 20             	or     $0x20,%eax
  10023a:	0f b7 d2             	movzwl %dx,%edx
  10023d:	66 89 04 51          	mov    %ax,(%ecx,%edx,2)
  100241:	0f b7 05 e8 03 98 00 	movzwl 0x9803e8,%eax
  100248:	e9 fa fe ff ff       	jmp    100147 <video_putc+0x57>
		video_putc(' ');
		video_putc(' ');
		video_putc(' ');
		break;
	default:
		terminal.crt_buf[terminal.crt_pos++] = c;		/* write the character */
  10024d:	0f b7 15 e8 03 98 00 	movzwl 0x9803e8,%edx
  100254:	8d 4a 01             	lea    0x1(%edx),%ecx
  100257:	66 89 0d e8 03 98 00 	mov    %cx,0x9803e8
  10025e:	8b 0d e4 03 98 00    	mov    0x9803e4,%ecx
  100264:	66 89 04 51          	mov    %ax,(%ecx,%edx,2)
  100268:	0f b7 05 e8 03 98 00 	movzwl 0x9803e8,%eax
		break;
  10026f:	e9 d3 fe ff ff       	jmp    100147 <video_putc+0x57>
		/* fallthru */
	case '\r':
		terminal.crt_pos -= (terminal.crt_pos % CRT_COLS);
		break;
	case '\t':
		video_putc(' ');
  100274:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10027b:	e8 70 fe ff ff       	call   1000f0 <video_putc>
		video_putc(' ');
  100280:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  100287:	e8 64 fe ff ff       	call   1000f0 <video_putc>
		video_putc(' ');
  10028c:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  100293:	e8 58 fe ff ff       	call   1000f0 <video_putc>
		video_putc(' ');
  100298:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10029f:	e8 4c fe ff ff       	call   1000f0 <video_putc>
		video_putc(' ');
  1002a4:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1002ab:	e8 40 fe ff ff       	call   1000f0 <video_putc>
  1002b0:	0f b7 05 e8 03 98 00 	movzwl 0x9803e8,%eax
		break;
  1002b7:	e9 8b fe ff ff       	jmp    100147 <video_putc+0x57>
  1002bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001002c0 <video_set_cursor>:
	*/
}

void
video_set_cursor (int x, int y)
{
  1002c0:	8b 44 24 04          	mov    0x4(%esp),%eax
    terminal.crt_pos = x * CRT_COLS + y;
  1002c4:	8d 04 80             	lea    (%eax,%eax,4),%eax
  1002c7:	c1 e0 04             	shl    $0x4,%eax
  1002ca:	66 03 44 24 08       	add    0x8(%esp),%ax
  1002cf:	66 a3 e8 03 98 00    	mov    %ax,0x9803e8
  1002d5:	c3                   	ret    
  1002d6:	8d 76 00             	lea    0x0(%esi),%esi
  1002d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001002e0 <video_clear_screen>:
}

void
video_clear_screen ()
{
  1002e0:	8b 15 e4 03 98 00    	mov    0x9803e4,%edx
    int i;
    for (i = 0; i < CRT_SIZE; i++)
  1002e6:	31 c0                	xor    %eax,%eax
    {
        terminal.crt_buf[i] = ' ';
  1002e8:	b9 20 00 00 00       	mov    $0x20,%ecx
  1002ed:	66 89 0c 42          	mov    %cx,(%edx,%eax,2)

void
video_clear_screen ()
{
    int i;
    for (i = 0; i < CRT_SIZE; i++)
  1002f1:	83 c0 01             	add    $0x1,%eax
  1002f4:	3d d0 07 00 00       	cmp    $0x7d0,%eax
  1002f9:	75 ed                	jne    1002e8 <video_clear_screen+0x8>
    {
        terminal.crt_buf[i] = ' ';
    }
}
  1002fb:	f3 c3                	repz ret 
  1002fd:	66 90                	xchg   %ax,%ax
  1002ff:	90                   	nop

00100300 <cons_init>:
	uint32_t rpos, wpos;
} cons;

void
cons_init()
{
  100300:	83 ec 1c             	sub    $0x1c,%esp
	memset(&cons, 0x0, sizeof(cons));
  100303:	c7 44 24 08 08 02 00 	movl   $0x208,0x8(%esp)
  10030a:	00 
  10030b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100312:	00 
  100313:	c7 04 24 20 04 98 00 	movl   $0x980420,(%esp)
  10031a:	e8 51 3a 00 00       	call   103d70 <memset>
	serial_init();
  10031f:	e8 6c 03 00 00       	call   100690 <serial_init>
	video_init();
  100324:	e8 d7 fc ff ff       	call   100000 <video_init>
	spinlock_init(&cons_lk);
  100329:	c7 04 24 00 04 98 00 	movl   $0x980400,(%esp)
  100330:	e8 7b 55 00 00       	call   1058b0 <spinlock_init>
}
  100335:	83 c4 1c             	add    $0x1c,%esp
  100338:	c3                   	ret    
  100339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100340 <cons_intr>:

void
cons_intr(int (*proc)(void))
{
  100340:	53                   	push   %ebx
  100341:	83 ec 18             	sub    $0x18,%esp
	int c;


	spinlock_acquire(&cons_lk);
  100344:	c7 04 24 00 04 98 00 	movl   $0x980400,(%esp)
	spinlock_init(&cons_lk);
}

void
cons_intr(int (*proc)(void))
{
  10034b:	8b 5c 24 20          	mov    0x20(%esp),%ebx
	int c;


	spinlock_acquire(&cons_lk);
  10034f:	e8 1c 57 00 00       	call   105a70 <spinlock_acquire>
  100354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

	while ((c = (*proc)()) != -1) {
  100358:	ff d3                	call   *%ebx
  10035a:	83 f8 ff             	cmp    $0xffffffff,%eax
  10035d:	74 39                	je     100398 <cons_intr+0x58>
		if (c == 0)
  10035f:	85 c0                	test   %eax,%eax
  100361:	74 f5                	je     100358 <cons_intr+0x18>
			continue;
		cons.buf[cons.wpos++] = c;
  100363:	8b 0d 24 06 98 00    	mov    0x980624,%ecx
  100369:	8d 51 01             	lea    0x1(%ecx),%edx
		if (cons.wpos == CONSOLE_BUFFER_SIZE)
  10036c:	81 fa 00 02 00 00    	cmp    $0x200,%edx
	spinlock_acquire(&cons_lk);

	while ((c = (*proc)()) != -1) {
		if (c == 0)
			continue;
		cons.buf[cons.wpos++] = c;
  100372:	89 15 24 06 98 00    	mov    %edx,0x980624
  100378:	88 81 20 04 98 00    	mov    %al,0x980420(%ecx)
		if (cons.wpos == CONSOLE_BUFFER_SIZE)
  10037e:	75 d8                	jne    100358 <cons_intr+0x18>
			cons.wpos = 0;
  100380:	c7 05 24 06 98 00 00 	movl   $0x0,0x980624
  100387:	00 00 00 
	int c;


	spinlock_acquire(&cons_lk);

	while ((c = (*proc)()) != -1) {
  10038a:	ff d3                	call   *%ebx
  10038c:	83 f8 ff             	cmp    $0xffffffff,%eax
  10038f:	75 ce                	jne    10035f <cons_intr+0x1f>
  100391:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		cons.buf[cons.wpos++] = c;
		if (cons.wpos == CONSOLE_BUFFER_SIZE)
			cons.wpos = 0;
	}

	spinlock_release(&cons_lk);
  100398:	c7 44 24 20 00 04 98 	movl   $0x980400,0x20(%esp)
  10039f:	00 
}
  1003a0:	83 c4 18             	add    $0x18,%esp
  1003a3:	5b                   	pop    %ebx
		cons.buf[cons.wpos++] = c;
		if (cons.wpos == CONSOLE_BUFFER_SIZE)
			cons.wpos = 0;
	}

	spinlock_release(&cons_lk);
  1003a4:	e9 47 57 00 00       	jmp    105af0 <spinlock_release>
  1003a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001003b0 <cons_getc>:
}

char
cons_getc(void)
{
  1003b0:	53                   	push   %ebx
  1003b1:	83 ec 18             	sub    $0x18,%esp


  // poll for any pending input characters,
  // so that this function works even when interrupts are disabled
  // (e.g., when called from the kernel monitor).
  serial_intr();
  1003b4:	e8 e7 01 00 00       	call   1005a0 <serial_intr>
  keyboard_intr();
  1003b9:	e8 f2 04 00 00       	call   1008b0 <keyboard_intr>

  spinlock_acquire(&cons_lk);
  1003be:	c7 04 24 00 04 98 00 	movl   $0x980400,(%esp)
  1003c5:	e8 a6 56 00 00       	call   105a70 <spinlock_acquire>
  // grab the next character from the input buffer.
  if (cons.rpos != cons.wpos) {
  1003ca:	a1 20 06 98 00       	mov    0x980620,%eax
  1003cf:	3b 05 24 06 98 00    	cmp    0x980624,%eax
  1003d5:	74 39                	je     100410 <cons_getc+0x60>
    c = cons.buf[cons.rpos++];
  1003d7:	8d 50 01             	lea    0x1(%eax),%edx
  1003da:	0f b6 98 20 04 98 00 	movzbl 0x980420(%eax),%ebx
    if (cons.rpos == CONSOLE_BUFFER_SIZE)
  1003e1:	81 fa 00 02 00 00    	cmp    $0x200,%edx
  keyboard_intr();

  spinlock_acquire(&cons_lk);
  // grab the next character from the input buffer.
  if (cons.rpos != cons.wpos) {
    c = cons.buf[cons.rpos++];
  1003e7:	89 15 20 06 98 00    	mov    %edx,0x980620
    if (cons.rpos == CONSOLE_BUFFER_SIZE)
  1003ed:	75 0a                	jne    1003f9 <cons_getc+0x49>
      cons.rpos = 0;
  1003ef:	c7 05 20 06 98 00 00 	movl   $0x0,0x980620
  1003f6:	00 00 00 
      spinlock_release(&cons_lk);
  1003f9:	c7 04 24 00 04 98 00 	movl   $0x980400,(%esp)
  100400:	e8 eb 56 00 00       	call   105af0 <spinlock_release>
    return c;
  }

  spinlock_release(&cons_lk);
  return 0;
}
  100405:	83 c4 18             	add    $0x18,%esp
  100408:	89 d8                	mov    %ebx,%eax
  10040a:	5b                   	pop    %ebx
  10040b:	c3                   	ret    
  10040c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cons.rpos = 0;
      spinlock_release(&cons_lk);
    return c;
  }

  spinlock_release(&cons_lk);
  100410:	c7 04 24 00 04 98 00 	movl   $0x980400,(%esp)
  return 0;
  100417:	31 db                	xor    %ebx,%ebx
      cons.rpos = 0;
      spinlock_release(&cons_lk);
    return c;
  }

  spinlock_release(&cons_lk);
  100419:	e8 d2 56 00 00       	call   105af0 <spinlock_release>
  return 0;
}
  10041e:	83 c4 18             	add    $0x18,%esp
  100421:	89 d8                	mov    %ebx,%eax
  100423:	5b                   	pop    %ebx
  100424:	c3                   	ret    
  100425:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100430 <cons_putc>:

void
cons_putc(char c)
{
  100430:	53                   	push   %ebx
  100431:	83 ec 18             	sub    $0x18,%esp
	serial_putc(c);
  100434:	0f be 5c 24 20       	movsbl 0x20(%esp),%ebx
  100439:	89 1c 24             	mov    %ebx,(%esp)
  10043c:	e8 8f 01 00 00       	call   1005d0 <serial_putc>
  video_putc(c);
  100441:	89 5c 24 20          	mov    %ebx,0x20(%esp)
}
  100445:	83 c4 18             	add    $0x18,%esp
  100448:	5b                   	pop    %ebx

void
cons_putc(char c)
{
	serial_putc(c);
  video_putc(c);
  100449:	e9 a2 fc ff ff       	jmp    1000f0 <video_putc>
  10044e:	66 90                	xchg   %ax,%ax

00100450 <getchar>:
}

char
getchar(void)
{
  100450:	83 ec 0c             	sub    $0xc,%esp
  100453:	90                   	nop
  100454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char c;

  while ((c = cons_getc()) == 0)
  100458:	e8 53 ff ff ff       	call   1003b0 <cons_getc>
  10045d:	84 c0                	test   %al,%al
  10045f:	74 f7                	je     100458 <getchar+0x8>
    /* do nothing */;
  return c;
}
  100461:	83 c4 0c             	add    $0xc,%esp
  100464:	c3                   	ret    
  100465:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100470 <putchar>:

void
putchar(char c)
{
  100470:	53                   	push   %ebx
  100471:	83 ec 18             	sub    $0x18,%esp
}

void
cons_putc(char c)
{
	serial_putc(c);
  100474:	0f be 5c 24 20       	movsbl 0x20(%esp),%ebx
  100479:	89 1c 24             	mov    %ebx,(%esp)
  10047c:	e8 4f 01 00 00       	call   1005d0 <serial_putc>
  video_putc(c);
  100481:	89 5c 24 20          	mov    %ebx,0x20(%esp)

void
putchar(char c)
{
  cons_putc(c);
}
  100485:	83 c4 18             	add    $0x18,%esp
  100488:	5b                   	pop    %ebx

void
cons_putc(char c)
{
	serial_putc(c);
  video_putc(c);
  100489:	e9 62 fc ff ff       	jmp    1000f0 <video_putc>
  10048e:	66 90                	xchg   %ax,%ax

00100490 <readline>:
  cons_putc(c);
}

char *
readline(const char *prompt)
{
  100490:	56                   	push   %esi
  100491:	53                   	push   %ebx
  100492:	83 ec 14             	sub    $0x14,%esp
  100495:	8b 44 24 20          	mov    0x20(%esp),%eax
  int i;
  char c;

  if (prompt != NULL)
  100499:	85 c0                	test   %eax,%eax
  10049b:	74 10                	je     1004ad <readline+0x1d>
    dprintf("%s", prompt);
  10049d:	89 44 24 04          	mov    %eax,0x4(%esp)
  1004a1:	c7 04 24 6e ab 10 00 	movl   $0x10ab6e,(%esp)
  1004a8:	e8 f3 3e 00 00       	call   1043a0 <dprintf>
    } else if ((c == '\b' || c == '\x7f') && i > 0) {
      putchar('\b');
      i--;
    } else if (c >= ' ' && i < BUFLEN-1) {
      putchar(c);
      linebuf[i++] = c;
  1004ad:	31 db                	xor    %ebx,%ebx
  1004af:	90                   	nop
char
getchar(void)
{
  char c;

  while ((c = cons_getc()) == 0)
  1004b0:	e8 fb fe ff ff       	call   1003b0 <cons_getc>
  1004b5:	84 c0                	test   %al,%al
  1004b7:	74 f7                	je     1004b0 <readline+0x20>
    dprintf("%s", prompt);

  i = 0;
  while (1) {
    c = getchar();
    if (c < 0) {
  1004b9:	0f 88 92 00 00 00    	js     100551 <readline+0xc1>
      dprintf("read error: %e\n", c);
      return NULL;
    } else if ((c == '\b' || c == '\x7f') && i > 0) {
  1004bf:	3c 7f                	cmp    $0x7f,%al
  1004c1:	74 04                	je     1004c7 <readline+0x37>
  1004c3:	3c 08                	cmp    $0x8,%al
  1004c5:	75 21                	jne    1004e8 <readline+0x58>
  1004c7:	85 db                	test   %ebx,%ebx
  1004c9:	74 1d                	je     1004e8 <readline+0x58>
}

void
cons_putc(char c)
{
	serial_putc(c);
  1004cb:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    if (c < 0) {
      dprintf("read error: %e\n", c);
      return NULL;
    } else if ((c == '\b' || c == '\x7f') && i > 0) {
      putchar('\b');
      i--;
  1004d2:	83 eb 01             	sub    $0x1,%ebx
}

void
cons_putc(char c)
{
	serial_putc(c);
  1004d5:	e8 f6 00 00 00       	call   1005d0 <serial_putc>
  video_putc(c);
  1004da:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1004e1:	e8 0a fc ff ff       	call   1000f0 <video_putc>
    if (c < 0) {
      dprintf("read error: %e\n", c);
      return NULL;
    } else if ((c == '\b' || c == '\x7f') && i > 0) {
      putchar('\b');
      i--;
  1004e6:	eb c8                	jmp    1004b0 <readline+0x20>
    } else if (c >= ' ' && i < BUFLEN-1) {
  1004e8:	3c 1f                	cmp    $0x1f,%al
  1004ea:	7f 34                	jg     100520 <readline+0x90>
      putchar(c);
      linebuf[i++] = c;
    } else if (c == '\n' || c == '\r') {
  1004ec:	3c 0d                	cmp    $0xd,%al
  1004ee:	66 90                	xchg   %ax,%ax
  1004f0:	74 04                	je     1004f6 <readline+0x66>
  1004f2:	3c 0a                	cmp    $0xa,%al
  1004f4:	75 ba                	jne    1004b0 <readline+0x20>
}

void
cons_putc(char c)
{
	serial_putc(c);
  1004f6:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  1004fd:	e8 ce 00 00 00       	call   1005d0 <serial_putc>
  video_putc(c);
  100502:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  100509:	e8 e2 fb ff ff       	call   1000f0 <video_putc>
      putchar(c);
      linebuf[i++] = c;
    } else if (c == '\n' || c == '\r') {
      putchar('\n');
      linebuf[i] = 0;
      return linebuf;
  10050e:	b8 00 f0 13 00       	mov    $0x13f000,%eax
    } else if (c >= ' ' && i < BUFLEN-1) {
      putchar(c);
      linebuf[i++] = c;
    } else if (c == '\n' || c == '\r') {
      putchar('\n');
      linebuf[i] = 0;
  100513:	c6 83 00 f0 13 00 00 	movb   $0x0,0x13f000(%ebx)
      return linebuf;
    }
  }
}
  10051a:	83 c4 14             	add    $0x14,%esp
  10051d:	5b                   	pop    %ebx
  10051e:	5e                   	pop    %esi
  10051f:	c3                   	ret    
      dprintf("read error: %e\n", c);
      return NULL;
    } else if ((c == '\b' || c == '\x7f') && i > 0) {
      putchar('\b');
      i--;
    } else if (c >= ' ' && i < BUFLEN-1) {
  100520:	81 fb fe 03 00 00    	cmp    $0x3fe,%ebx
  100526:	7f c4                	jg     1004ec <readline+0x5c>
}

void
cons_putc(char c)
{
	serial_putc(c);
  100528:	0f be f0             	movsbl %al,%esi
    } else if ((c == '\b' || c == '\x7f') && i > 0) {
      putchar('\b');
      i--;
    } else if (c >= ' ' && i < BUFLEN-1) {
      putchar(c);
      linebuf[i++] = c;
  10052b:	83 c3 01             	add    $0x1,%ebx
}

void
cons_putc(char c)
{
	serial_putc(c);
  10052e:	89 34 24             	mov    %esi,(%esp)
  100531:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100535:	e8 96 00 00 00       	call   1005d0 <serial_putc>
  video_putc(c);
  10053a:	89 34 24             	mov    %esi,(%esp)
  10053d:	e8 ae fb ff ff       	call   1000f0 <video_putc>
    } else if ((c == '\b' || c == '\x7f') && i > 0) {
      putchar('\b');
      i--;
    } else if (c >= ' ' && i < BUFLEN-1) {
      putchar(c);
      linebuf[i++] = c;
  100542:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100546:	88 83 ff ef 13 00    	mov    %al,0x13efff(%ebx)
  10054c:	e9 5f ff ff ff       	jmp    1004b0 <readline+0x20>

  i = 0;
  while (1) {
    c = getchar();
    if (c < 0) {
      dprintf("read error: %e\n", c);
  100551:	0f be c0             	movsbl %al,%eax
  100554:	89 44 24 04          	mov    %eax,0x4(%esp)
  100558:	c7 04 24 71 ab 10 00 	movl   $0x10ab71,(%esp)
  10055f:	e8 3c 3e 00 00       	call   1043a0 <dprintf>
      putchar('\n');
      linebuf[i] = 0;
      return linebuf;
    }
  }
}
  100564:	83 c4 14             	add    $0x14,%esp
  i = 0;
  while (1) {
    c = getchar();
    if (c < 0) {
      dprintf("read error: %e\n", c);
      return NULL;
  100567:	31 c0                	xor    %eax,%eax
      putchar('\n');
      linebuf[i] = 0;
      return linebuf;
    }
  }
}
  100569:	5b                   	pop    %ebx
  10056a:	5e                   	pop    %esi
  10056b:	c3                   	ret    
  10056c:	66 90                	xchg   %ax,%ax
  10056e:	66 90                	xchg   %ax,%ax

00100570 <serial_proc_data>:
	inb(0x84);
}

static int
serial_proc_data(void)
{
  100570:	83 ec 1c             	sub    $0x1c,%esp
	if (!(inb(COM1+COM_LSR) & COM_LSR_DATA))
  100573:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
  10057a:	e8 b1 4a 00 00       	call   105030 <inb>
  10057f:	a8 01                	test   $0x1,%al
  100581:	74 15                	je     100598 <serial_proc_data+0x28>
		return -1;
	return inb(COM1+COM_RX);
  100583:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
  10058a:	e8 a1 4a 00 00       	call   105030 <inb>
  10058f:	0f b6 c0             	movzbl %al,%eax
}
  100592:	83 c4 1c             	add    $0x1c,%esp
  100595:	c3                   	ret    
  100596:	66 90                	xchg   %ax,%ax

static int
serial_proc_data(void)
{
	if (!(inb(COM1+COM_LSR) & COM_LSR_DATA))
		return -1;
  100598:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10059d:	eb f3                	jmp    100592 <serial_proc_data+0x22>
  10059f:	90                   	nop

001005a0 <serial_intr>:
}

void
serial_intr(void)
{
	if (serial_exists)
  1005a0:	80 3d 28 06 98 00 00 	cmpb   $0x0,0x980628
  1005a7:	75 07                	jne    1005b0 <serial_intr+0x10>
		cons_intr(serial_proc_data);
}
  1005a9:	c3                   	ret    
  1005aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	return inb(COM1+COM_RX);
}

void
serial_intr(void)
{
  1005b0:	83 ec 1c             	sub    $0x1c,%esp
	if (serial_exists)
		cons_intr(serial_proc_data);
  1005b3:	c7 04 24 70 05 10 00 	movl   $0x100570,(%esp)
  1005ba:	e8 81 fd ff ff       	call   100340 <cons_intr>
}
  1005bf:	83 c4 1c             	add    $0x1c,%esp
  1005c2:	c3                   	ret    
  1005c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1005c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001005d0 <serial_putc>:
		return 0;
}

void
serial_putc(char c)
{
  1005d0:	56                   	push   %esi
  1005d1:	53                   	push   %ebx
	if (!serial_exists)
  1005d2:	bb 01 32 00 00       	mov    $0x3201,%ebx
		return 0;
}

void
serial_putc(char c)
{
  1005d7:	83 ec 14             	sub    $0x14,%esp
	if (!serial_exists)
  1005da:	80 3d 28 06 98 00 00 	cmpb   $0x0,0x980628
		return 0;
}

void
serial_putc(char c)
{
  1005e1:	8b 74 24 20          	mov    0x20(%esp),%esi
	if (!serial_exists)
  1005e5:	75 3e                	jne    100625 <serial_putc+0x55>
  1005e7:	eb 67                	jmp    100650 <serial_putc+0x80>
  1005e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return;

	int i;
	for (i = 0;
	     !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800;
  1005f0:	83 eb 01             	sub    $0x1,%ebx
  1005f3:	74 40                	je     100635 <serial_putc+0x65>

// Stupid I/O delay routine necessitated by historical PC design flaws
static void
delay(void)
{
	inb(0x84);
  1005f5:	c7 04 24 84 00 00 00 	movl   $0x84,(%esp)
  1005fc:	e8 2f 4a 00 00       	call   105030 <inb>
	inb(0x84);
  100601:	c7 04 24 84 00 00 00 	movl   $0x84,(%esp)
  100608:	e8 23 4a 00 00       	call   105030 <inb>
	inb(0x84);
  10060d:	c7 04 24 84 00 00 00 	movl   $0x84,(%esp)
  100614:	e8 17 4a 00 00       	call   105030 <inb>
	inb(0x84);
  100619:	c7 04 24 84 00 00 00 	movl   $0x84,(%esp)
  100620:	e8 0b 4a 00 00       	call   105030 <inb>
	if (!serial_exists)
		return;

	int i;
	for (i = 0;
	     !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800;
  100625:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
  10062c:	e8 ff 49 00 00       	call   105030 <inb>
{
	if (!serial_exists)
		return;

	int i;
	for (i = 0;
  100631:	a8 20                	test   $0x20,%al
  100633:	74 bb                	je     1005f0 <serial_putc+0x20>
	int nl = '\n';
	/* POSIX requires newline on the serial line to
	 * be a CR-LF pair. Without this, you get a malformed output
	 * with clients like minicom or screen
	 */
	if (c == nl) {
  100635:	89 f0                	mov    %esi,%eax
  100637:	3c 0a                	cmp    $0xa,%al
  100639:	74 1d                	je     100658 <serial_putc+0x88>
	     !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800;
	     i++)
		delay();

	if (!serial_reformatnewline(c, COM1 + COM_TX))
		outb(COM1 + COM_TX, c);
  10063b:	89 f0                	mov    %esi,%eax
  10063d:	0f b6 f0             	movzbl %al,%esi
  100640:	89 74 24 04          	mov    %esi,0x4(%esp)
  100644:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
  10064b:	e8 10 4a 00 00       	call   105060 <outb>
}
  100650:	83 c4 14             	add    $0x14,%esp
  100653:	5b                   	pop    %ebx
  100654:	5e                   	pop    %esi
  100655:	c3                   	ret    
  100656:	66 90                	xchg   %ax,%ax
	/* POSIX requires newline on the serial line to
	 * be a CR-LF pair. Without this, you get a malformed output
	 * with clients like minicom or screen
	 */
	if (c == nl) {
		outb(p, cr);
  100658:	c7 44 24 04 0d 00 00 	movl   $0xd,0x4(%esp)
  10065f:	00 
  100660:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
  100667:	e8 f4 49 00 00       	call   105060 <outb>
		outb(p, nl);
  10066c:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
  100673:	00 
  100674:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
  10067b:	e8 e0 49 00 00       	call   105060 <outb>
	     i++)
		delay();

	if (!serial_reformatnewline(c, COM1 + COM_TX))
		outb(COM1 + COM_TX, c);
}
  100680:	83 c4 14             	add    $0x14,%esp
  100683:	5b                   	pop    %ebx
  100684:	5e                   	pop    %esi
  100685:	c3                   	ret    
  100686:	8d 76 00             	lea    0x0(%esi),%esi
  100689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100690 <serial_init>:

void
serial_init(void)
{
  100690:	83 ec 1c             	sub    $0x1c,%esp
	/* turn off interrupt */
	outb(COM1 + COM_IER, 0);
  100693:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10069a:	00 
  10069b:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
  1006a2:	e8 b9 49 00 00       	call   105060 <outb>

	/* set DLAB */
	outb(COM1 + COM_LCR, COM_LCR_DLAB);
  1006a7:	c7 44 24 04 80 00 00 	movl   $0x80,0x4(%esp)
  1006ae:	00 
  1006af:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
  1006b6:	e8 a5 49 00 00       	call   105060 <outb>

	/* set baud rate */
	outb(COM1 + COM_DLL, 0x0001 & 0xff);
  1006bb:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1006c2:	00 
  1006c3:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
  1006ca:	e8 91 49 00 00       	call   105060 <outb>
	outb(COM1 + COM_DLM, 0x0001 >> 8);
  1006cf:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1006d6:	00 
  1006d7:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
  1006de:	e8 7d 49 00 00       	call   105060 <outb>

	/* Set the line status.  */
	outb(COM1 + COM_LCR, COM_LCR_WLEN8 & ~COM_LCR_DLAB);
  1006e3:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
  1006ea:	00 
  1006eb:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
  1006f2:	e8 69 49 00 00       	call   105060 <outb>

	/* Enable the FIFO.  */
	outb(COM1 + COM_FCR, 0xc7);
  1006f7:	c7 44 24 04 c7 00 00 	movl   $0xc7,0x4(%esp)
  1006fe:	00 
  1006ff:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
  100706:	e8 55 49 00 00       	call   105060 <outb>

	/* Turn on DTR, RTS, and OUT2.  */
	outb(COM1 + COM_MCR, 0x0b);
  10070b:	c7 44 24 04 0b 00 00 	movl   $0xb,0x4(%esp)
  100712:	00 
  100713:	c7 04 24 fc 03 00 00 	movl   $0x3fc,(%esp)
  10071a:	e8 41 49 00 00       	call   105060 <outb>

	// Clear any preexisting overrun indications and interrupts
	// Serial COM1 doesn't exist if COM_LSR returns 0xFF
	serial_exists = (inb(COM1+COM_LSR) != 0xFF);
  10071f:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
  100726:	e8 05 49 00 00       	call   105030 <inb>
	(void) inb(COM1+COM_IIR);
  10072b:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
	/* Turn on DTR, RTS, and OUT2.  */
	outb(COM1 + COM_MCR, 0x0b);

	// Clear any preexisting overrun indications and interrupts
	// Serial COM1 doesn't exist if COM_LSR returns 0xFF
	serial_exists = (inb(COM1+COM_LSR) != 0xFF);
  100732:	3c ff                	cmp    $0xff,%al
  100734:	0f 95 05 28 06 98 00 	setne  0x980628
	(void) inb(COM1+COM_IIR);
  10073b:	e8 f0 48 00 00       	call   105030 <inb>
	(void) inb(COM1+COM_RX);
  100740:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
  100747:	e8 e4 48 00 00       	call   105030 <inb>
}
  10074c:	83 c4 1c             	add    $0x1c,%esp
  10074f:	c3                   	ret    

00100750 <serial_intenable>:

void
serial_intenable(void)
{
	if (serial_exists) {
  100750:	80 3d 28 06 98 00 00 	cmpb   $0x0,0x980628
  100757:	75 07                	jne    100760 <serial_intenable+0x10>
		outb(COM1+COM_IER, 1);
		//intr_enable(IRQ_SERIAL13);
		serial_intr();
	}
}
  100759:	c3                   	ret    
  10075a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	(void) inb(COM1+COM_RX);
}

void
serial_intenable(void)
{
  100760:	83 ec 1c             	sub    $0x1c,%esp
	if (serial_exists) {
		outb(COM1+COM_IER, 1);
  100763:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10076a:	00 
  10076b:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
  100772:	e8 e9 48 00 00       	call   105060 <outb>
}

void
serial_intr(void)
{
	if (serial_exists)
  100777:	80 3d 28 06 98 00 00 	cmpb   $0x0,0x980628
  10077e:	74 0c                	je     10078c <serial_intenable+0x3c>
		cons_intr(serial_proc_data);
  100780:	c7 04 24 70 05 10 00 	movl   $0x100570,(%esp)
  100787:	e8 b4 fb ff ff       	call   100340 <cons_intr>
	if (serial_exists) {
		outb(COM1+COM_IER, 1);
		//intr_enable(IRQ_SERIAL13);
		serial_intr();
	}
}
  10078c:	83 c4 1c             	add    $0x1c,%esp
  10078f:	c3                   	ret    

00100790 <kbd_proc_data>:
 * Get data from the keyboard.  If we finish a character, return it.  Else 0.
 * Return -1 if no data.
 */
static int
kbd_proc_data(void)
{
  100790:	53                   	push   %ebx
  100791:	83 ec 18             	sub    $0x18,%esp
  int c;
  uint8_t data;
  static uint32_t shift;

  if ((inb(KBSTATP) & KBS_DIB) == 0)
  100794:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
  10079b:	e8 90 48 00 00       	call   105030 <inb>
  1007a0:	a8 01                	test   $0x1,%al
  1007a2:	0f 84 f8 00 00 00    	je     1008a0 <kbd_proc_data+0x110>
    return -1;

  data = inb(KBDATAP);
  1007a8:	c7 04 24 60 00 00 00 	movl   $0x60,(%esp)
  1007af:	e8 7c 48 00 00       	call   105030 <inb>

  if (data == 0xE0) {
  1007b4:	3c e0                	cmp    $0xe0,%al
  static uint32_t shift;

  if ((inb(KBSTATP) & KBS_DIB) == 0)
    return -1;

  data = inb(KBDATAP);
  1007b6:	89 c2                	mov    %eax,%edx

  if (data == 0xE0) {
  1007b8:	0f 84 d2 00 00 00    	je     100890 <kbd_proc_data+0x100>
    // E0 escape character
    shift |= E0ESC;
    return 0;
  } else if (data & 0x80) {
  1007be:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
  1007c0:	8b 0d 00 f4 13 00    	mov    0x13f400,%ecx

  if (data == 0xE0) {
    // E0 escape character
    shift |= E0ESC;
    return 0;
  } else if (data & 0x80) {
  1007c6:	0f 88 94 00 00 00    	js     100860 <kbd_proc_data+0xd0>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if (shift & E0ESC) {
  1007cc:	f6 c1 40             	test   $0x40,%cl
  1007cf:	74 08                	je     1007d9 <kbd_proc_data+0x49>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
  1007d1:	89 c2                	mov    %eax,%edx
    shift &= ~E0ESC;
  1007d3:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if (shift & E0ESC) {
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
  1007d6:	83 ca 80             	or     $0xffffff80,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  1007d9:	0f b6 c2             	movzbl %dl,%eax
  1007dc:	0f b6 90 c0 ac 10 00 	movzbl 0x10acc0(%eax),%edx
  1007e3:	09 ca                	or     %ecx,%edx
  shift ^= togglecode[data];
  1007e5:	0f b6 88 c0 ab 10 00 	movzbl 0x10abc0(%eax),%ecx
  1007ec:	31 ca                	xor    %ecx,%edx

  c = charcode[shift & (CTL | SHIFT)][data];
  1007ee:	89 d1                	mov    %edx,%ecx
  1007f0:	83 e1 03             	and    $0x3,%ecx
  if (shift & CAPSLOCK) {
  1007f3:	f6 c2 08             	test   $0x8,%dl
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];

  c = charcode[shift & (CTL | SHIFT)][data];
  1007f6:	8b 0c 8d a0 ab 10 00 	mov    0x10aba0(,%ecx,4),%ecx
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  1007fd:	89 15 00 f4 13 00    	mov    %edx,0x13f400

  c = charcode[shift & (CTL | SHIFT)][data];
  100803:	0f b6 1c 01          	movzbl (%ecx,%eax,1),%ebx
  if (shift & CAPSLOCK) {
  100807:	74 23                	je     10082c <kbd_proc_data+0x9c>
    if ('a' <= c && c <= 'z')
  100809:	8d 43 9f             	lea    -0x61(%ebx),%eax
  10080c:	83 f8 19             	cmp    $0x19,%eax
  10080f:	77 0f                	ja     100820 <kbd_proc_data+0x90>
      c += 'A' - 'a';
  100811:	83 eb 20             	sub    $0x20,%ebx
  100814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dprintf("Rebooting!\n");
    outb(0x92, 0x3); // courtesy of Chris Frost
  }

  return c;
}
  100818:	83 c4 18             	add    $0x18,%esp
  10081b:	89 d8                	mov    %ebx,%eax
  10081d:	5b                   	pop    %ebx
  10081e:	c3                   	ret    
  10081f:	90                   	nop

  c = charcode[shift & (CTL | SHIFT)][data];
  if (shift & CAPSLOCK) {
    if ('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if ('A' <= c && c <= 'Z')
  100820:	8d 4b bf             	lea    -0x41(%ebx),%ecx
      c += 'a' - 'A';
  100823:	8d 43 20             	lea    0x20(%ebx),%eax
  100826:	83 f9 19             	cmp    $0x19,%ecx
  100829:	0f 46 d8             	cmovbe %eax,%ebx
  }

  // Process special keys
  // Ctrl-Alt-Del: reboot
  if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  10082c:	f7 d2                	not    %edx
  10082e:	83 e2 06             	and    $0x6,%edx
  100831:	75 e5                	jne    100818 <kbd_proc_data+0x88>
  100833:	81 fb e9 00 00 00    	cmp    $0xe9,%ebx
  100839:	75 dd                	jne    100818 <kbd_proc_data+0x88>
    dprintf("Rebooting!\n");
  10083b:	c7 04 24 81 ab 10 00 	movl   $0x10ab81,(%esp)
  100842:	e8 59 3b 00 00       	call   1043a0 <dprintf>
    outb(0x92, 0x3); // courtesy of Chris Frost
  100847:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
  10084e:	00 
  10084f:	c7 04 24 92 00 00 00 	movl   $0x92,(%esp)
  100856:	e8 05 48 00 00       	call   105060 <outb>
  10085b:	eb bb                	jmp    100818 <kbd_proc_data+0x88>
  10085d:	8d 76 00             	lea    0x0(%esi),%esi
    // E0 escape character
    shift |= E0ESC;
    return 0;
  } else if (data & 0x80) {
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
  100860:	83 e0 7f             	and    $0x7f,%eax
  100863:	f6 c1 40             	test   $0x40,%cl
  100866:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  100869:	31 db                	xor    %ebx,%ebx
    shift |= E0ESC;
    return 0;
  } else if (data & 0x80) {
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
  10086b:	0f b6 d2             	movzbl %dl,%edx
  10086e:	0f b6 82 c0 ac 10 00 	movzbl 0x10acc0(%edx),%eax
  100875:	83 c8 40             	or     $0x40,%eax
  100878:	0f b6 c0             	movzbl %al,%eax
  10087b:	f7 d0                	not    %eax
  10087d:	21 c8                	and    %ecx,%eax
  10087f:	a3 00 f4 13 00       	mov    %eax,0x13f400
    dprintf("Rebooting!\n");
    outb(0x92, 0x3); // courtesy of Chris Frost
  }

  return c;
}
  100884:	83 c4 18             	add    $0x18,%esp
  100887:	89 d8                	mov    %ebx,%eax
  100889:	5b                   	pop    %ebx
  10088a:	c3                   	ret    
  10088b:	90                   	nop
  10088c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  data = inb(KBDATAP);

  if (data == 0xE0) {
    // E0 escape character
    shift |= E0ESC;
    return 0;
  100890:	31 db                	xor    %ebx,%ebx

  data = inb(KBDATAP);

  if (data == 0xE0) {
    // E0 escape character
    shift |= E0ESC;
  100892:	83 0d 00 f4 13 00 40 	orl    $0x40,0x13f400
    dprintf("Rebooting!\n");
    outb(0x92, 0x3); // courtesy of Chris Frost
  }

  return c;
}
  100899:	83 c4 18             	add    $0x18,%esp
  10089c:	89 d8                	mov    %ebx,%eax
  10089e:	5b                   	pop    %ebx
  10089f:	c3                   	ret    
  int c;
  uint8_t data;
  static uint32_t shift;

  if ((inb(KBSTATP) & KBS_DIB) == 0)
    return -1;
  1008a0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  1008a5:	e9 6e ff ff ff       	jmp    100818 <kbd_proc_data+0x88>
  1008aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001008b0 <keyboard_intr>:
  return c;
}

void
keyboard_intr(void)
{
  1008b0:	83 ec 1c             	sub    $0x1c,%esp
  cons_intr(kbd_proc_data);
  1008b3:	c7 04 24 90 07 10 00 	movl   $0x100790,(%esp)
  1008ba:	e8 81 fa ff ff       	call   100340 <cons_intr>
}
  1008bf:	83 c4 1c             	add    $0x1c,%esp
  1008c2:	c3                   	ret    
  1008c3:	66 90                	xchg   %ax,%ax
  1008c5:	66 90                	xchg   %ax,%ax
  1008c7:	66 90                	xchg   %ax,%ax
  1008c9:	66 90                	xchg   %ax,%ax
  1008cb:	66 90                	xchg   %ax,%ax
  1008cd:	66 90                	xchg   %ax,%ax
  1008cf:	90                   	nop

001008d0 <devinit>:
void file_init(void);


void
devinit (uintptr_t mbi_addr)
{
  1008d0:	53                   	push   %ebx
  1008d1:	83 ec 18             	sub    $0x18,%esp
  1008d4:	8b 5c 24 20          	mov    0x20(%esp),%ebx
	seg_init (0);
  1008d8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1008df:	e8 bc 40 00 00       	call   1049a0 <seg_init>

	enable_sse ();
  1008e4:	e8 87 45 00 00       	call   104e70 <enable_sse>

	cons_init ();
  1008e9:	e8 12 fa ff ff       	call   100300 <cons_init>
  1008ee:	66 90                	xchg   %ax,%ax

	debug_init();
  1008f0:	e8 5b 37 00 00       	call   104050 <debug_init>
	KERN_INFO("[BSP KERN] cons initialized.\n");
  1008f5:	c7 04 24 c0 ad 10 00 	movl   $0x10adc0,(%esp)
  1008fc:	e8 ef 37 00 00       	call   1040f0 <debug_info>
	KERN_INFO("[BSP KERN] devinit mbi_adr: %d\n", mbi_addr);
  100901:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  100905:	c7 04 24 90 ae 10 00 	movl   $0x10ae90,(%esp)
  10090c:	e8 df 37 00 00       	call   1040f0 <debug_info>

	/* pcpu init codes */
	pcpu_init();
  100911:	e8 0a 54 00 00       	call   105d20 <pcpu_init>
	KERN_INFO("[BSP KERN] PCPU initialized\n");
  100916:	c7 04 24 de ad 10 00 	movl   $0x10adde,(%esp)
  10091d:	e8 ce 37 00 00       	call   1040f0 <debug_info>

	tsc_init();
  100922:	e8 39 12 00 00       	call   101b60 <tsc_init>
	KERN_INFO("[BSP KERN] TSC initialized\n");
  100927:	c7 04 24 fb ad 10 00 	movl   $0x10adfb,(%esp)
  10092e:	e8 bd 37 00 00       	call   1040f0 <debug_info>

	intr_init();
  100933:	e8 a8 05 00 00       	call   100ee0 <intr_init>
	KERN_INFO("[BSP KERN] INTR initialized\n");
  100938:	c7 04 24 17 ae 10 00 	movl   $0x10ae17,(%esp)
  10093f:	e8 ac 37 00 00       	call   1040f0 <debug_info>
	
	trap_init(0);
  100944:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10094b:	e8 70 76 00 00       	call   107fc0 <trap_init>

	pmmap_init (mbi_addr);
  100950:	89 1c 24             	mov    %ebx,(%esp)
  100953:	e8 38 01 00 00       	call   100a90 <pmmap_init>

	bufcache_init();      // buffer cache
  100958:	e8 e3 7a 00 00       	call   108440 <bufcache_init>
	file_init();          // file table
  10095d:	e8 1e 90 00 00       	call   109980 <file_init>
	inode_init();         // inode cache
  100962:	e8 b9 83 00 00       	call   108d20 <inode_init>
	ide_init ();
  100967:	e8 64 31 00 00       	call   103ad0 <ide_init>
	KERN_INFO("[BSP KERN] IDE disk driver initialized\n");
  10096c:	c7 44 24 20 b0 ae 10 	movl   $0x10aeb0,0x20(%esp)
  100973:	00 
}
  100974:	83 c4 18             	add    $0x18,%esp
  100977:	5b                   	pop    %ebx

	bufcache_init();      // buffer cache
	file_init();          // file table
	inode_init();         // inode cache
	ide_init ();
	KERN_INFO("[BSP KERN] IDE disk driver initialized\n");
  100978:	e9 73 37 00 00       	jmp    1040f0 <debug_info>
  10097d:	8d 76 00             	lea    0x0(%esi),%esi

00100980 <devinit_ap>:
}

void 
devinit_ap (void)
{
  100980:	53                   	push   %ebx
  100981:	83 ec 18             	sub    $0x18,%esp
	/* Figure out the current (booting) kernel stack) */
  	struct kstack *ks =
                (struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
  100984:	e8 37 44 00 00       	call   104dc0 <get_stack_pointer>

	KERN_ASSERT(ks != NULL);
  100989:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  10098e:	89 c3                	mov    %eax,%ebx
  100990:	0f 84 92 00 00 00    	je     100a28 <devinit_ap+0xa8>
	KERN_ASSERT(1 <= ks->cpu_idx && ks->cpu_idx < 8);
  100996:	8b 83 1c 01 00 00    	mov    0x11c(%ebx),%eax
  10099c:	8d 50 ff             	lea    -0x1(%eax),%edx
  10099f:	83 fa 06             	cmp    $0x6,%edx
  1009a2:	76 2a                	jbe    1009ce <devinit_ap+0x4e>
  1009a4:	c7 44 24 0c d8 ae 10 	movl   $0x10aed8,0xc(%esp)
  1009ab:	00 
  1009ac:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  1009b3:	00 
  1009b4:	c7 44 24 04 43 00 00 	movl   $0x43,0x4(%esp)
  1009bb:	00 
  1009bc:	c7 04 24 5c ae 10 00 	movl   $0x10ae5c,(%esp)
  1009c3:	e8 b8 37 00 00       	call   104180 <debug_panic>
  1009c8:	8b 83 1c 01 00 00    	mov    0x11c(%ebx),%eax

  	/* kernel stack for this cpu initialized */
  	seg_init(ks->cpu_idx);
  1009ce:	89 04 24             	mov    %eax,(%esp)
  1009d1:	e8 ca 3f 00 00       	call   1049a0 <seg_init>

  	pcpu_init();
  1009d6:	e8 45 53 00 00       	call   105d20 <pcpu_init>
  	KERN_INFO("[AP%d KERN] PCPU initialized\n", ks->cpu_idx);
  1009db:	8b 83 1c 01 00 00    	mov    0x11c(%ebx),%eax
  1009e1:	c7 04 24 6f ae 10 00 	movl   $0x10ae6f,(%esp)
  1009e8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009ec:	e8 ff 36 00 00       	call   1040f0 <debug_info>
	
	intr_init();
  1009f1:	e8 ea 04 00 00       	call   100ee0 <intr_init>
  	KERN_INFO("[AP%d KERN] INTR initialized.\n", ks->cpu_idx);
  1009f6:	8b 83 1c 01 00 00    	mov    0x11c(%ebx),%eax
  1009fc:	c7 04 24 fc ae 10 00 	movl   $0x10aefc,(%esp)
  100a03:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a07:	e8 e4 36 00 00       	call   1040f0 <debug_info>

	trap_init(ks->cpu_idx);
  100a0c:	8b 83 1c 01 00 00    	mov    0x11c(%ebx),%eax
  100a12:	89 04 24             	mov    %eax,(%esp)
  100a15:	e8 a6 75 00 00       	call   107fc0 <trap_init>

	paging_init_ap();
}
  100a1a:	83 c4 18             	add    $0x18,%esp
  100a1d:	5b                   	pop    %ebx
	intr_init();
  	KERN_INFO("[AP%d KERN] INTR initialized.\n", ks->cpu_idx);

	trap_init(ks->cpu_idx);

	paging_init_ap();
  100a1e:	e9 1d 5f 00 00       	jmp    106940 <paging_init_ap>
  100a23:	90                   	nop
  100a24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
	/* Figure out the current (booting) kernel stack) */
  	struct kstack *ks =
                (struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);

	KERN_ASSERT(ks != NULL);
  100a28:	c7 44 24 0c 34 ae 10 	movl   $0x10ae34,0xc(%esp)
  100a2f:	00 
  100a30:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  100a37:	00 
  100a38:	c7 44 24 04 42 00 00 	movl   $0x42,0x4(%esp)
  100a3f:	00 
  100a40:	c7 04 24 5c ae 10 00 	movl   $0x10ae5c,(%esp)
  100a47:	e8 34 37 00 00       	call   104180 <debug_panic>
  100a4c:	e9 45 ff ff ff       	jmp    100996 <devinit_ap+0x16>
  100a51:	66 90                	xchg   %ax,%ax
  100a53:	66 90                	xchg   %ax,%ax
  100a55:	66 90                	xchg   %ax,%ax
  100a57:	66 90                	xchg   %ax,%ax
  100a59:	66 90                	xchg   %ax,%ax
  100a5b:	66 90                	xchg   %ax,%ax
  100a5d:	66 90                	xchg   %ax,%ax
  100a5f:	90                   	nop

00100a60 <pmmap_alloc_slot>:
static int pmmap_nentries = 0;

struct pmmap *
pmmap_alloc_slot(void)
{
	if (unlikely(pmmap_slots_next_free == 128))
  100a60:	a1 40 f4 13 00       	mov    0x13f440,%eax
  100a65:	3d 80 00 00 00       	cmp    $0x80,%eax
  100a6a:	74 14                	je     100a80 <pmmap_alloc_slot+0x20>
		return NULL;
	return &pmmap_slots[pmmap_slots_next_free++];
  100a6c:	8d 50 01             	lea    0x1(%eax),%edx
  100a6f:	8d 04 80             	lea    (%eax,%eax,4),%eax
  100a72:	89 15 40 f4 13 00    	mov    %edx,0x13f440
  100a78:	8d 04 85 60 f4 13 00 	lea    0x13f460(,%eax,4),%eax
  100a7f:	c3                   	ret    

struct pmmap *
pmmap_alloc_slot(void)
{
	if (unlikely(pmmap_slots_next_free == 128))
		return NULL;
  100a80:	31 c0                	xor    %eax,%eax
	return &pmmap_slots[pmmap_slots_next_free++];
}
  100a82:	c3                   	ret    
  100a83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100a90 <pmmap_init>:
	}
}

void
pmmap_init(uintptr_t mbi_addr)
{
  100a90:	55                   	push   %ebp
  100a91:	57                   	push   %edi
  100a92:	56                   	push   %esi
  100a93:	53                   	push   %ebx
  100a94:	83 ec 3c             	sub    $0x3c,%esp
  100a97:	8b 7c 24 50          	mov    0x50(%esp),%edi
	KERN_INFO("\n");
  100a9b:	c7 04 24 04 c3 10 00 	movl   $0x10c304,(%esp)
  100aa2:	e8 49 36 00 00       	call   1040f0 <debug_info>

	mboot_info_t *mbi = (mboot_info_t *) mbi_addr;
	mboot_mmap_t *p = (mboot_mmap_t *) mbi->mmap_addr;

	SLIST_INIT(&pmmap_list);
  100aa7:	c7 05 3c f4 13 00 00 	movl   $0x0,0x13f43c
  100aae:	00 00 00 
	SLIST_INIT(&pmmap_sublist[PMMAP_NVS]);

	/*
	 * Copy memory map information from multiboot information mbi to pmmap.
	 */
	while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100ab1:	8b 5f 2c             	mov    0x2c(%edi),%ebx
pmmap_init(uintptr_t mbi_addr)
{
	KERN_INFO("\n");

	mboot_info_t *mbi = (mboot_info_t *) mbi_addr;
	mboot_mmap_t *p = (mboot_mmap_t *) mbi->mmap_addr;
  100ab4:	8b 47 30             	mov    0x30(%edi),%eax

	SLIST_INIT(&pmmap_list);
	SLIST_INIT(&pmmap_sublist[PMMAP_USABLE]);
  100ab7:	c7 05 2c f4 13 00 00 	movl   $0x0,0x13f42c
  100abe:	00 00 00 
	SLIST_INIT(&pmmap_sublist[PMMAP_RESV]);
  100ac1:	c7 05 30 f4 13 00 00 	movl   $0x0,0x13f430
  100ac8:	00 00 00 
	SLIST_INIT(&pmmap_sublist[PMMAP_NVS]);

	/*
	 * Copy memory map information from multiboot information mbi to pmmap.
	 */
	while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100acb:	85 db                	test   %ebx,%ebx
	mboot_mmap_t *p = (mboot_mmap_t *) mbi->mmap_addr;

	SLIST_INIT(&pmmap_list);
	SLIST_INIT(&pmmap_sublist[PMMAP_USABLE]);
	SLIST_INIT(&pmmap_sublist[PMMAP_RESV]);
	SLIST_INIT(&pmmap_sublist[PMMAP_ACPI]);
  100acd:	c7 05 34 f4 13 00 00 	movl   $0x0,0x13f434
  100ad4:	00 00 00 
	SLIST_INIT(&pmmap_sublist[PMMAP_NVS]);
  100ad7:	c7 05 38 f4 13 00 00 	movl   $0x0,0x13f438
  100ade:	00 00 00 

	/*
	 * Copy memory map information from multiboot information mbi to pmmap.
	 */
	while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100ae1:	0f 84 11 01 00 00    	je     100bf8 <pmmap_init+0x168>
  100ae7:	8d 70 18             	lea    0x18(%eax),%esi
  100aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		uintptr_t start,end;
		uint32_t type;

		if (p->base_addr_high != 0)	/* ignore address above 4G */
  100af0:	8b 48 08             	mov    0x8(%eax),%ecx
  100af3:	85 c9                	test   %ecx,%ecx
  100af5:	75 7c                	jne    100b73 <pmmap_init+0xe3>
			goto next;
		else
			start = p->base_addr_low;

		if (p->length_high != 0 ||
  100af7:	8b 50 10             	mov    0x10(%eax),%edx
		    p->length_low >= 0xffffffff - start)
			end = 0xffffffff;
  100afa:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
		uint32_t type;

		if (p->base_addr_high != 0)	/* ignore address above 4G */
			goto next;
		else
			start = p->base_addr_low;
  100aff:	8b 58 04             	mov    0x4(%eax),%ebx

		if (p->length_high != 0 ||
  100b02:	85 d2                	test   %edx,%edx
  100b04:	75 0f                	jne    100b15 <pmmap_init+0x85>
		    p->length_low >= 0xffffffff - start)
			end = 0xffffffff;
		else
			end = start + p->length_low;
  100b06:	8b 50 0c             	mov    0xc(%eax),%edx
  100b09:	89 d9                	mov    %ebx,%ecx
  100b0b:	f7 d1                	not    %ecx
  100b0d:	01 da                	add    %ebx,%edx
  100b0f:	39 48 0c             	cmp    %ecx,0xc(%eax)
  100b12:	0f 42 ea             	cmovb  %edx,%ebp

		type = p->type;
  100b15:	8b 50 14             	mov    0x14(%eax),%edx
static int pmmap_nentries = 0;

struct pmmap *
pmmap_alloc_slot(void)
{
	if (unlikely(pmmap_slots_next_free == 128))
  100b18:	a1 40 f4 13 00       	mov    0x13f440,%eax
  100b1d:	3d 80 00 00 00       	cmp    $0x80,%eax
  100b22:	0f 84 67 02 00 00    	je     100d8f <pmmap_init+0x2ff>
		return NULL;
	return &pmmap_slots[pmmap_slots_next_free++];
  100b28:	8d 48 01             	lea    0x1(%eax),%ecx
  100b2b:	8d 04 80             	lea    (%eax,%eax,4),%eax
  100b2e:	89 0d 40 f4 13 00    	mov    %ecx,0x13f440
  100b34:	8d 0c 85 60 f4 13 00 	lea    0x13f460(,%eax,4),%ecx
	if ((free_slot = pmmap_alloc_slot()) == NULL)
		KERN_PANIC("More than 128 E820 entries.\n");

	free_slot->start = start;
	free_slot->end = end;
	free_slot->type = type;
  100b3b:	89 51 08             	mov    %edx,0x8(%ecx)

	last_slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100b3e:	8b 15 3c f4 13 00    	mov    0x13f43c,%edx
	struct pmmap *free_slot, *slot, *last_slot;

	if ((free_slot = pmmap_alloc_slot()) == NULL)
		KERN_PANIC("More than 128 E820 entries.\n");

	free_slot->start = start;
  100b44:	89 19                	mov    %ebx,(%ecx)
	free_slot->end = end;
  100b46:	89 69 04             	mov    %ebp,0x4(%ecx)
	free_slot->type = type;

	last_slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100b49:	85 d2                	test   %edx,%edx
  100b4b:	0f 84 0e 02 00 00    	je     100d5f <pmmap_init+0x2cf>
		if (start < slot->start)
  100b51:	3b 1a                	cmp    (%edx),%ebx
  100b53:	73 11                	jae    100b66 <pmmap_init+0xd6>
  100b55:	e9 05 02 00 00       	jmp    100d5f <pmmap_init+0x2cf>
  100b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100b60:	3b 18                	cmp    (%eax),%ebx
  100b62:	72 09                	jb     100b6d <pmmap_init+0xdd>
  100b64:	89 c2                	mov    %eax,%edx
	free_slot->end = end;
	free_slot->type = type;

	last_slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100b66:	8b 42 0c             	mov    0xc(%edx),%eax
  100b69:	85 c0                	test   %eax,%eax
  100b6b:	75 f3                	jne    100b60 <pmmap_init+0xd0>
  {
		SLIST_INSERT_HEAD(&pmmap_list, free_slot, next);
  }
	else
  {
		SLIST_INSERT_AFTER(last_slot, free_slot, next);
  100b6d:	89 41 0c             	mov    %eax,0xc(%ecx)
  100b70:	89 4a 0c             	mov    %ecx,0xc(%edx)
	SLIST_INIT(&pmmap_sublist[PMMAP_NVS]);

	/*
	 * Copy memory map information from multiboot information mbi to pmmap.
	 */
	while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100b73:	89 f2                	mov    %esi,%edx

		pmmap_insert(start, end, type);
    //pmmap_dump();

	next:
		p = (mboot_mmap_t *) (((uint32_t) p) + sizeof(mboot_mmap_t)/* p->size */);
  100b75:	89 f0                	mov    %esi,%eax
	SLIST_INIT(&pmmap_sublist[PMMAP_NVS]);

	/*
	 * Copy memory map information from multiboot information mbi to pmmap.
	 */
	while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100b77:	2b 57 30             	sub    0x30(%edi),%edx
  100b7a:	83 c6 18             	add    $0x18,%esi
  100b7d:	3b 57 2c             	cmp    0x2c(%edi),%edx
  100b80:	0f 82 6a ff ff ff    	jb     100af0 <pmmap_init+0x60>
  100b86:	8b 1d 3c f4 13 00    	mov    0x13f43c,%ebx

static void
pmmap_merge(void)
{
	struct pmmap *slot, *next_slot;
	struct pmmap *last_slot[4] = { NULL, NULL, NULL, NULL };
  100b8c:	c7 44 24 20 00 00 00 	movl   $0x0,0x20(%esp)
  100b93:	00 
  100b94:	c7 44 24 24 00 00 00 	movl   $0x0,0x24(%esp)
  100b9b:	00 
  100b9c:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
  100ba3:	00 
	int sublist_nr;

	/*
	 * Step 1: Merge overlaped entries in pmmap_list.
	 */
	SLIST_FOREACH(slot, &pmmap_list, next) {
  100ba4:	85 db                	test   %ebx,%ebx

static void
pmmap_merge(void)
{
	struct pmmap *slot, *next_slot;
	struct pmmap *last_slot[4] = { NULL, NULL, NULL, NULL };
  100ba6:	c7 44 24 2c 00 00 00 	movl   $0x0,0x2c(%esp)
  100bad:	00 
	int sublist_nr;

	/*
	 * Step 1: Merge overlaped entries in pmmap_list.
	 */
	SLIST_FOREACH(slot, &pmmap_list, next) {
  100bae:	74 48                	je     100bf8 <pmmap_init+0x168>
		if ((next_slot = SLIST_NEXT(slot, next)) == NULL)
  100bb0:	8b 43 0c             	mov    0xc(%ebx),%eax
  100bb3:	85 c0                	test   %eax,%eax
  100bb5:	75 10                	jne    100bc7 <pmmap_init+0x137>
  100bb7:	eb 7b                	jmp    100c34 <pmmap_init+0x1a4>
  100bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100bc0:	8b 43 0c             	mov    0xc(%ebx),%eax
  100bc3:	85 c0                	test   %eax,%eax
  100bc5:	74 20                	je     100be7 <pmmap_init+0x157>
			break;
		if (slot->start <= next_slot->start &&
  100bc7:	8b 10                	mov    (%eax),%edx
  100bc9:	39 13                	cmp    %edx,(%ebx)
  100bcb:	77 13                	ja     100be0 <pmmap_init+0x150>
		    slot->end >= next_slot->start &&
  100bcd:	8b 4b 04             	mov    0x4(%ebx),%ecx
	 * Step 1: Merge overlaped entries in pmmap_list.
	 */
	SLIST_FOREACH(slot, &pmmap_list, next) {
		if ((next_slot = SLIST_NEXT(slot, next)) == NULL)
			break;
		if (slot->start <= next_slot->start &&
  100bd0:	39 ca                	cmp    %ecx,%edx
  100bd2:	77 0c                	ja     100be0 <pmmap_init+0x150>
		    slot->end >= next_slot->start &&
  100bd4:	8b 70 08             	mov    0x8(%eax),%esi
  100bd7:	39 73 08             	cmp    %esi,0x8(%ebx)
  100bda:	0f 84 8d 01 00 00    	je     100d6d <pmmap_init+0x2dd>
  100be0:	8b 5b 0c             	mov    0xc(%ebx),%ebx
	int sublist_nr;

	/*
	 * Step 1: Merge overlaped entries in pmmap_list.
	 */
	SLIST_FOREACH(slot, &pmmap_list, next) {
  100be3:	85 db                	test   %ebx,%ebx
  100be5:	75 d9                	jne    100bc0 <pmmap_init+0x130>

	/*
	 * Step 2: Create the specfic lists: pmmap_usable, pmmap_resv,
	 *         pmmap_acpi, pmmap_nvs.
	 */
	SLIST_FOREACH(slot, &pmmap_list, next) {
  100be7:	8b 1d 3c f4 13 00    	mov    0x13f43c,%ebx
  100bed:	85 db                	test   %ebx,%ebx
  100bef:	75 43                	jne    100c34 <pmmap_init+0x1a4>
  100bf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	SLIST_FOREACH(slot, &pmmap_list, next) {
		pmmap_nentries++;
	}

	/* Calculate the maximum page number */
	mem_npages = rounddown(max_usable_memory, PAGESIZE) / PAGESIZE;
  100bf8:	a1 28 f4 13 00       	mov    0x13f428,%eax
  100bfd:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  100c04:	00 
  100c05:	89 04 24             	mov    %eax,(%esp)
  100c08:	e8 63 41 00 00       	call   104d70 <rounddown>
  100c0d:	c1 e8 0c             	shr    $0xc,%eax
  100c10:	a3 24 f4 13 00       	mov    %eax,0x13f424
}
  100c15:	83 c4 3c             	add    $0x3c,%esp
  100c18:	5b                   	pop    %ebx
  100c19:	5e                   	pop    %esi
  100c1a:	5f                   	pop    %edi
  100c1b:	5d                   	pop    %ebp
  100c1c:	c3                   	ret    
  100c1d:	8d 76 00             	lea    0x0(%esi),%esi
	 */
	SLIST_FOREACH(slot, &pmmap_list, next) {
		sublist_nr = PMMAP_SUBLIST_NR(slot->type);
    KERN_ASSERT(sublist_nr != -1);
		if (last_slot[sublist_nr] != NULL)
			SLIST_INSERT_AFTER(last_slot[sublist_nr], slot,
  100c20:	8b 4a 10             	mov    0x10(%edx),%ecx
					   type_next);
		else
			SLIST_INSERT_HEAD(&pmmap_sublist[sublist_nr], slot,
					  type_next);
		last_slot[sublist_nr] = slot;
  100c23:	89 5c 84 20          	mov    %ebx,0x20(%esp,%eax,4)
	 */
	SLIST_FOREACH(slot, &pmmap_list, next) {
		sublist_nr = PMMAP_SUBLIST_NR(slot->type);
    KERN_ASSERT(sublist_nr != -1);
		if (last_slot[sublist_nr] != NULL)
			SLIST_INSERT_AFTER(last_slot[sublist_nr], slot,
  100c27:	89 4b 10             	mov    %ecx,0x10(%ebx)
  100c2a:	89 5a 10             	mov    %ebx,0x10(%edx)

	/*
	 * Step 2: Create the specfic lists: pmmap_usable, pmmap_resv,
	 *         pmmap_acpi, pmmap_nvs.
	 */
	SLIST_FOREACH(slot, &pmmap_list, next) {
  100c2d:	8b 5b 0c             	mov    0xc(%ebx),%ebx
  100c30:	85 db                	test   %ebx,%ebx
  100c32:	74 6c                	je     100ca0 <pmmap_init+0x210>
		sublist_nr = PMMAP_SUBLIST_NR(slot->type);
  100c34:	8b 53 08             	mov    0x8(%ebx),%edx
  100c37:	31 c0                	xor    %eax,%eax
  100c39:	83 fa 01             	cmp    $0x1,%edx
  100c3c:	74 3e                	je     100c7c <pmmap_init+0x1ec>
  100c3e:	83 fa 02             	cmp    $0x2,%edx
  100c41:	b0 01                	mov    $0x1,%al
  100c43:	74 37                	je     100c7c <pmmap_init+0x1ec>
  100c45:	83 fa 03             	cmp    $0x3,%edx
  100c48:	b0 02                	mov    $0x2,%al
  100c4a:	74 30                	je     100c7c <pmmap_init+0x1ec>
  100c4c:	83 fa 04             	cmp    $0x4,%edx
  100c4f:	b0 03                	mov    $0x3,%al
  100c51:	74 29                	je     100c7c <pmmap_init+0x1ec>
    KERN_ASSERT(sublist_nr != -1);
  100c53:	c7 44 24 0c 74 af 10 	movl   $0x10af74,0xc(%esp)
  100c5a:	00 
  100c5b:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  100c62:	00 
  100c63:	c7 44 24 04 71 00 00 	movl   $0x71,0x4(%esp)
  100c6a:	00 
  100c6b:	c7 04 24 63 af 10 00 	movl   $0x10af63,(%esp)
  100c72:	e8 09 35 00 00       	call   104180 <debug_panic>
	/*
	 * Step 2: Create the specfic lists: pmmap_usable, pmmap_resv,
	 *         pmmap_acpi, pmmap_nvs.
	 */
	SLIST_FOREACH(slot, &pmmap_list, next) {
		sublist_nr = PMMAP_SUBLIST_NR(slot->type);
  100c77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    KERN_ASSERT(sublist_nr != -1);
		if (last_slot[sublist_nr] != NULL)
  100c7c:	8b 54 84 20          	mov    0x20(%esp,%eax,4),%edx
  100c80:	85 d2                	test   %edx,%edx
  100c82:	75 9c                	jne    100c20 <pmmap_init+0x190>
			SLIST_INSERT_AFTER(last_slot[sublist_nr], slot,
					   type_next);
		else
			SLIST_INSERT_HEAD(&pmmap_sublist[sublist_nr], slot,
  100c84:	8b 14 85 2c f4 13 00 	mov    0x13f42c(,%eax,4),%edx
					  type_next);
		last_slot[sublist_nr] = slot;
  100c8b:	89 5c 84 20          	mov    %ebx,0x20(%esp,%eax,4)
    KERN_ASSERT(sublist_nr != -1);
		if (last_slot[sublist_nr] != NULL)
			SLIST_INSERT_AFTER(last_slot[sublist_nr], slot,
					   type_next);
		else
			SLIST_INSERT_HEAD(&pmmap_sublist[sublist_nr], slot,
  100c8f:	89 1c 85 2c f4 13 00 	mov    %ebx,0x13f42c(,%eax,4)
  100c96:	89 53 10             	mov    %edx,0x10(%ebx)

	/*
	 * Step 2: Create the specfic lists: pmmap_usable, pmmap_resv,
	 *         pmmap_acpi, pmmap_nvs.
	 */
	SLIST_FOREACH(slot, &pmmap_list, next) {
  100c99:	8b 5b 0c             	mov    0xc(%ebx),%ebx
  100c9c:	85 db                	test   %ebx,%ebx
  100c9e:	75 94                	jne    100c34 <pmmap_init+0x1a4>
  100ca0:	8b 44 24 20          	mov    0x20(%esp),%eax
  100ca4:	8b 1d 3c f4 13 00    	mov    0x13f43c,%ebx
			SLIST_INSERT_HEAD(&pmmap_sublist[sublist_nr], slot,
					  type_next);
		last_slot[sublist_nr] = slot;
	}

	if (last_slot[PMMAP_USABLE] != NULL)
  100caa:	85 c0                	test   %eax,%eax
  100cac:	74 08                	je     100cb6 <pmmap_init+0x226>
		max_usable_memory = last_slot[PMMAP_USABLE]->end;
  100cae:	8b 40 04             	mov    0x4(%eax),%eax
  100cb1:	a3 28 f4 13 00       	mov    %eax,0x13f428

static void
pmmap_dump(void)
{
	struct pmmap *slot;
	SLIST_FOREACH(slot, &pmmap_list, next) {
  100cb6:	85 db                	test   %ebx,%ebx
  100cb8:	0f 84 3a ff ff ff    	je     100bf8 <pmmap_init+0x168>
		KERN_INFO("BIOS-e820: 0x%08x - 0x%08x (%s)\n",
  100cbe:	be 22 af 10 00       	mov    $0x10af22,%esi
  100cc3:	90                   	nop
  100cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100cc8:	8b 43 08             	mov    0x8(%ebx),%eax
  100ccb:	bf 1b af 10 00       	mov    $0x10af1b,%edi
  100cd0:	83 f8 01             	cmp    $0x1,%eax
  100cd3:	74 1f                	je     100cf4 <pmmap_init+0x264>
  100cd5:	83 f8 02             	cmp    $0x2,%eax
  100cd8:	bf 2a af 10 00       	mov    $0x10af2a,%edi
  100cdd:	74 15                	je     100cf4 <pmmap_init+0x264>
  100cdf:	83 f8 03             	cmp    $0x3,%eax
  100ce2:	bf 33 af 10 00       	mov    $0x10af33,%edi
  100ce7:	74 0b                	je     100cf4 <pmmap_init+0x264>
  100ce9:	83 f8 04             	cmp    $0x4,%eax
  100cec:	bf 3d af 10 00       	mov    $0x10af3d,%edi
  100cf1:	0f 45 fe             	cmovne %esi,%edi
  100cf4:	8b 0b                	mov    (%ebx),%ecx
  100cf6:	8b 53 04             	mov    0x4(%ebx),%edx
  100cf9:	89 c8                	mov    %ecx,%eax
  100cfb:	39 d1                	cmp    %edx,%ecx
  100cfd:	74 0e                	je     100d0d <pmmap_init+0x27d>
  100cff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100d04:	83 fa ff             	cmp    $0xffffffff,%edx
  100d07:	8d 6a ff             	lea    -0x1(%edx),%ebp
  100d0a:	0f 45 c5             	cmovne %ebp,%eax
  100d0d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  100d11:	89 44 24 08          	mov    %eax,0x8(%esp)
  100d15:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100d19:	c7 04 24 88 af 10 00 	movl   $0x10af88,(%esp)
  100d20:	e8 cb 33 00 00       	call   1040f0 <debug_info>

static void
pmmap_dump(void)
{
	struct pmmap *slot;
	SLIST_FOREACH(slot, &pmmap_list, next) {
  100d25:	8b 5b 0c             	mov    0xc(%ebx),%ebx
  100d28:	85 db                	test   %ebx,%ebx
  100d2a:	75 9c                	jne    100cc8 <pmmap_init+0x238>
	pmmap_merge();
	pmmap_dump();

	/* count the number of pmmap entries */
	struct pmmap *slot;
	SLIST_FOREACH(slot, &pmmap_list, next) {
  100d2c:	a1 3c f4 13 00       	mov    0x13f43c,%eax
  100d31:	85 c0                	test   %eax,%eax
  100d33:	0f 84 bf fe ff ff    	je     100bf8 <pmmap_init+0x168>
  100d39:	8b 35 20 f4 13 00    	mov    0x13f420,%esi
  100d3f:	8d 56 01             	lea    0x1(%esi),%edx
  100d42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100d48:	8b 40 0c             	mov    0xc(%eax),%eax
		pmmap_nentries++;
  100d4b:	89 d1                	mov    %edx,%ecx
  100d4d:	83 c2 01             	add    $0x1,%edx
	pmmap_merge();
	pmmap_dump();

	/* count the number of pmmap entries */
	struct pmmap *slot;
	SLIST_FOREACH(slot, &pmmap_list, next) {
  100d50:	85 c0                	test   %eax,%eax
  100d52:	75 f4                	jne    100d48 <pmmap_init+0x2b8>
  100d54:	89 0d 20 f4 13 00    	mov    %ecx,0x13f420
  100d5a:	e9 99 fe ff ff       	jmp    100bf8 <pmmap_init+0x168>
		last_slot = slot;
	}

	if (last_slot == NULL)
  {
		SLIST_INSERT_HEAD(&pmmap_list, free_slot, next);
  100d5f:	89 51 0c             	mov    %edx,0xc(%ecx)
  100d62:	89 0d 3c f4 13 00    	mov    %ecx,0x13f43c
  100d68:	e9 06 fe ff ff       	jmp    100b73 <pmmap_init+0xe3>
		if ((next_slot = SLIST_NEXT(slot, next)) == NULL)
			break;
		if (slot->start <= next_slot->start &&
		    slot->end >= next_slot->start &&
		    slot->type == next_slot->type) {
			slot->end = max(slot->end, next_slot->end);
  100d6d:	8b 40 04             	mov    0x4(%eax),%eax
  100d70:	89 0c 24             	mov    %ecx,(%esp)
  100d73:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d77:	e8 d4 3f 00 00       	call   104d50 <max>
  100d7c:	89 43 04             	mov    %eax,0x4(%ebx)
			SLIST_REMOVE_AFTER(slot, next);
  100d7f:	8b 43 0c             	mov    0xc(%ebx),%eax
  100d82:	8b 40 0c             	mov    0xc(%eax),%eax
  100d85:	89 43 0c             	mov    %eax,0xc(%ebx)
  100d88:	89 c3                	mov    %eax,%ebx
  100d8a:	e9 54 fe ff ff       	jmp    100be3 <pmmap_init+0x153>
pmmap_insert(uintptr_t start, uintptr_t end, uint32_t type)
{
	struct pmmap *free_slot, *slot, *last_slot;

	if ((free_slot = pmmap_alloc_slot()) == NULL)
		KERN_PANIC("More than 128 E820 entries.\n");
  100d8f:	c7 44 24 08 46 af 10 	movl   $0x10af46,0x8(%esp)
  100d96:	00 
  100d97:	c7 44 24 04 3e 00 00 	movl   $0x3e,0x4(%esp)
  100d9e:	00 
  100d9f:	c7 04 24 63 af 10 00 	movl   $0x10af63,(%esp)
  100da6:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  100daa:	e8 d1 33 00 00       	call   104180 <debug_panic>

struct pmmap *
pmmap_alloc_slot(void)
{
	if (unlikely(pmmap_slots_next_free == 128))
		return NULL;
  100daf:	31 c9                	xor    %ecx,%ecx
  100db1:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  100db5:	e9 81 fd ff ff       	jmp    100b3b <pmmap_init+0xab>
  100dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100dc0 <get_size>:

int
get_size(void)
{
	return pmmap_nentries;
}
  100dc0:	a1 20 f4 13 00       	mov    0x13f420,%eax
  100dc5:	c3                   	ret    
  100dc6:	8d 76 00             	lea    0x0(%esi),%esi
  100dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100dd0 <get_mms>:
get_mms(int idx)
{
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100dd0:	a1 3c f4 13 00       	mov    0x13f43c,%eax
	return pmmap_nentries;
}

uint32_t
get_mms(int idx)
{
  100dd5:	8b 4c 24 04          	mov    0x4(%esp),%ecx
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100dd9:	85 c0                	test   %eax,%eax
  100ddb:	74 2b                	je     100e08 <get_mms+0x38>
}

uint32_t
get_mms(int idx)
{
	int i = 0;
  100ddd:	31 d2                	xor    %edx,%edx
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
		if (i == idx)
  100ddf:	85 c9                	test   %ecx,%ecx
  100de1:	75 09                	jne    100dec <get_mms+0x1c>
  100de3:	eb 13                	jmp    100df8 <get_mms+0x28>
  100de5:	8d 76 00             	lea    0x0(%esi),%esi
  100de8:	39 d1                	cmp    %edx,%ecx
  100dea:	74 0c                	je     100df8 <get_mms+0x28>
get_mms(int idx)
{
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100dec:	8b 40 0c             	mov    0xc(%eax),%eax
		if (i == idx)
			break;
		i++;
  100def:	83 c2 01             	add    $0x1,%edx
get_mms(int idx)
{
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100df2:	85 c0                	test   %eax,%eax
  100df4:	75 f2                	jne    100de8 <get_mms+0x18>
  100df6:	f3 c3                	repz ret 
		if (i == idx)
			break;
		i++;
	}

	if (slot == NULL || i == pmmap_nentries)
  100df8:	3b 15 20 f4 13 00    	cmp    0x13f420,%edx
  100dfe:	74 08                	je     100e08 <get_mms+0x38>
		return 0;

	return slot->start;
  100e00:	8b 00                	mov    (%eax),%eax
  100e02:	c3                   	ret    
  100e03:	90                   	nop
  100e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			break;
		i++;
	}

	if (slot == NULL || i == pmmap_nentries)
		return 0;
  100e08:	31 c0                	xor    %eax,%eax
  100e0a:	c3                   	ret    
  100e0b:	90                   	nop
  100e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00100e10 <get_mml>:
get_mml(int idx)
{
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100e10:	8b 15 3c f4 13 00    	mov    0x13f43c,%edx
	return slot->start;
}

uint32_t
get_mml(int idx)
{
  100e16:	8b 4c 24 04          	mov    0x4(%esp),%ecx
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100e1a:	85 d2                	test   %edx,%edx
  100e1c:	74 18                	je     100e36 <get_mml+0x26>
}

uint32_t
get_mml(int idx)
{
	int i = 0;
  100e1e:	31 c0                	xor    %eax,%eax
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
		if (i == idx)
  100e20:	85 c9                	test   %ecx,%ecx
  100e22:	75 08                	jne    100e2c <get_mml+0x1c>
  100e24:	eb 1a                	jmp    100e40 <get_mml+0x30>
  100e26:	66 90                	xchg   %ax,%ax
  100e28:	39 c1                	cmp    %eax,%ecx
  100e2a:	74 14                	je     100e40 <get_mml+0x30>
get_mml(int idx)
{
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100e2c:	8b 52 0c             	mov    0xc(%edx),%edx
		if (i == idx)
			break;
		i++;
  100e2f:	83 c0 01             	add    $0x1,%eax
get_mml(int idx)
{
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100e32:	85 d2                	test   %edx,%edx
  100e34:	75 f2                	jne    100e28 <get_mml+0x18>
			break;
		i++;
	}

	if (slot == NULL || i == pmmap_nentries)
		return 0;
  100e36:	31 c0                	xor    %eax,%eax
  100e38:	c3                   	ret    
  100e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		if (i == idx)
			break;
		i++;
	}

	if (slot == NULL || i == pmmap_nentries)
  100e40:	3b 05 20 f4 13 00    	cmp    0x13f420,%eax
  100e46:	74 ee                	je     100e36 <get_mml+0x26>
		return 0;

	return slot->end - slot->start;
  100e48:	8b 42 04             	mov    0x4(%edx),%eax
  100e4b:	2b 02                	sub    (%edx),%eax
  100e4d:	c3                   	ret    
  100e4e:	66 90                	xchg   %ax,%ax

00100e50 <is_usable>:
is_usable(int idx)
{
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100e50:	a1 3c f4 13 00       	mov    0x13f43c,%eax
	return slot->end - slot->start;
}

int
is_usable(int idx)
{
  100e55:	8b 4c 24 04          	mov    0x4(%esp),%ecx
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100e59:	85 c0                	test   %eax,%eax
  100e5b:	74 33                	je     100e90 <is_usable+0x40>
}

int
is_usable(int idx)
{
	int i = 0;
  100e5d:	31 d2                	xor    %edx,%edx
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
		if (i == idx)
  100e5f:	85 c9                	test   %ecx,%ecx
  100e61:	75 09                	jne    100e6c <is_usable+0x1c>
  100e63:	eb 13                	jmp    100e78 <is_usable+0x28>
  100e65:	8d 76 00             	lea    0x0(%esi),%esi
  100e68:	39 d1                	cmp    %edx,%ecx
  100e6a:	74 0c                	je     100e78 <is_usable+0x28>
is_usable(int idx)
{
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100e6c:	8b 40 0c             	mov    0xc(%eax),%eax
		if (i == idx)
			break;
		i++;
  100e6f:	83 c2 01             	add    $0x1,%edx
is_usable(int idx)
{
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100e72:	85 c0                	test   %eax,%eax
  100e74:	75 f2                	jne    100e68 <is_usable+0x18>
  100e76:	f3 c3                	repz ret 
		if (i == idx)
			break;
		i++;
	}

	if (slot == NULL || i == pmmap_nentries)
  100e78:	3b 15 20 f4 13 00    	cmp    0x13f420,%edx
  100e7e:	74 10                	je     100e90 <is_usable+0x40>
		return 0;

	return slot->type == MEM_RAM;
  100e80:	83 78 08 01          	cmpl   $0x1,0x8(%eax)
  100e84:	0f 94 c0             	sete   %al
  100e87:	0f b6 c0             	movzbl %al,%eax
  100e8a:	c3                   	ret    
  100e8b:	90                   	nop
  100e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			break;
		i++;
	}

	if (slot == NULL || i == pmmap_nentries)
		return 0;
  100e90:	31 c0                	xor    %eax,%eax
  100e92:	c3                   	ret    
  100e93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100ea0 <set_cr3>:
}

void
set_cr3(char **pdir)
{
	lcr3((uint32_t) pdir);
  100ea0:	e9 5b 41 00 00       	jmp    105000 <lcr3>
  100ea5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100eb0 <enable_paging>:
}

void
enable_paging(void)
{
  100eb0:	83 ec 1c             	sub    $0x1c,%esp
	/* enable global pages (Sec 4.10.2.4, Intel ASDM Vol3) */
	uint32_t cr4 = rcr4();
  100eb3:	e8 68 41 00 00       	call   105020 <rcr4>
	cr4 |= CR4_PGE;
  100eb8:	0c 80                	or     $0x80,%al
	lcr4(cr4);
  100eba:	89 04 24             	mov    %eax,(%esp)
  100ebd:	e8 4e 41 00 00       	call   105010 <lcr4>

	/* turn on paging */
	uint32_t cr0 = rcr0();
  100ec2:	e8 19 41 00 00       	call   104fe0 <rcr0>
	cr0 |= CR0_PE | CR0_PG | CR0_AM | CR0_WP | CR0_NE | CR0_MP;
	cr0 &= ~(CR0_EM | CR0_TS);
  100ec7:	83 e0 f3             	and    $0xfffffff3,%eax
  100eca:	0d 23 00 05 80       	or     $0x80050023,%eax
	lcr0(cr0);
  100ecf:	89 04 24             	mov    %eax,(%esp)
  100ed2:	e8 f9 40 00 00       	call   104fd0 <lcr0>
}
  100ed7:	83 c4 1c             	add    $0x1c,%esp
  100eda:	c3                   	ret    
  100edb:	66 90                	xchg   %ax,%ax
  100edd:	66 90                	xchg   %ax,%ax
  100edf:	90                   	nop

00100ee0 <intr_init>:
	asm volatile("lidt %0" : : "m" (idt_pd));
}

void
intr_init(void)
{
  100ee0:	56                   	push   %esi
  100ee1:	53                   	push   %ebx
  100ee2:	83 ec 34             	sub    $0x34,%esp
  pic_init();
  100ee5:	e8 16 09 00 00       	call   101800 <pic_init>

  uint32_t dummy, edx;
  cpuid(0x00000001, &dummy, &dummy, &dummy, &edx);
  100eea:	8d 44 24 2c          	lea    0x2c(%esp),%eax
  100eee:	89 44 24 10          	mov    %eax,0x10(%esp)
  100ef2:	8d 44 24 28          	lea    0x28(%esp),%eax
  100ef6:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100efa:	89 44 24 08          	mov    %eax,0x8(%esp)
  100efe:	89 44 24 04          	mov    %eax,0x4(%esp)
  100f02:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  100f09:	e8 82 3f 00 00       	call   104e90 <cpuid>
  using_apic = (edx & CPUID_FEATURE_APIC) ? TRUE : FALSE;
  100f0e:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  100f12:	c1 e8 09             	shr    $0x9,%eax
  100f15:	83 e0 01             	and    $0x1,%eax
  100f18:	a2 61 fe 13 00       	mov    %al,0x13fe61
  KERN_ASSERT(using_apic == TRUE);
  100f1d:	0f b6 05 61 fe 13 00 	movzbl 0x13fe61,%eax
  100f24:	3c 01                	cmp    $0x1,%al
  100f26:	74 24                	je     100f4c <intr_init+0x6c>
  100f28:	c7 44 24 0c a9 af 10 	movl   $0x10afa9,0xc(%esp)
  100f2f:	00 
  100f30:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  100f37:	00 
  100f38:	c7 44 24 04 5f 00 00 	movl   $0x5f,0x4(%esp)
  100f3f:	00 
  100f40:	c7 04 24 bc af 10 00 	movl   $0x10afbc,(%esp)
  100f47:	e8 34 32 00 00       	call   104180 <debug_panic>

	if (using_apic == TRUE){
  100f4c:	0f b6 05 61 fe 13 00 	movzbl 0x13fe61,%eax
  100f53:	3c 01                	cmp    $0x1,%al
  100f55:	0f 84 a1 06 00 00    	je     1015fc <intr_init+0x71c>
  100f5b:	bb 0e 20 10 00       	mov    $0x10200e,%ebx
	asm volatile("lidt %0" : : "m" (idt_pd));
}

void
intr_init(void)
{
  100f60:	31 c0                	xor    %eax,%eax
  100f62:	89 de                	mov    %ebx,%esi
  100f64:	89 d9                	mov    %ebx,%ecx
  100f66:	c1 ee 10             	shr    $0x10,%esi
  100f69:	89 f2                	mov    %esi,%edx
  100f6b:	90                   	nop
  100f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	/* check that T_IRQ0 is a multiple of 8 */
	KERN_ASSERT((T_IRQ0 & 7) == 0);

	/* install a default handler */
	for (i = 0; i < sizeof(idt)/sizeof(idt[0]); i++)
		SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);
  100f70:	66 89 0c c5 00 b0 9c 	mov    %cx,0x9cb000(,%eax,8)
  100f77:	00 
  100f78:	66 c7 04 c5 02 b0 9c 	movw   $0x8,0x9cb002(,%eax,8)
  100f7f:	00 08 00 
  100f82:	c6 04 c5 04 b0 9c 00 	movb   $0x0,0x9cb004(,%eax,8)
  100f89:	00 
  100f8a:	c6 04 c5 05 b0 9c 00 	movb   $0x8e,0x9cb005(,%eax,8)
  100f91:	8e 
  100f92:	66 89 14 c5 06 b0 9c 	mov    %dx,0x9cb006(,%eax,8)
  100f99:	00 

	/* check that T_IRQ0 is a multiple of 8 */
	KERN_ASSERT((T_IRQ0 & 7) == 0);

	/* install a default handler */
	for (i = 0; i < sizeof(idt)/sizeof(idt[0]); i++)
  100f9a:	83 c0 01             	add    $0x1,%eax
  100f9d:	3d 00 01 00 00       	cmp    $0x100,%eax
  100fa2:	75 cc                	jne    100f70 <intr_init+0x90>
		SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);

	SETGATE(idt[T_DIVIDE],            0, CPU_GDT_KCODE, &Xdivide,       0);
  100fa4:	b8 00 1f 10 00       	mov    $0x101f00,%eax
  100fa9:	ba 08 00 00 00       	mov    $0x8,%edx
  100fae:	66 a3 00 b0 9c 00    	mov    %ax,0x9cb000
  100fb4:	c1 e8 10             	shr    $0x10,%eax
	SETGATE(idt[T_DEBUG],             0, CPU_GDT_KCODE, &Xdebug,        0);
  100fb7:	b9 08 00 00 00       	mov    $0x8,%ecx

	/* install a default handler */
	for (i = 0; i < sizeof(idt)/sizeof(idt[0]); i++)
		SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);

	SETGATE(idt[T_DIVIDE],            0, CPU_GDT_KCODE, &Xdivide,       0);
  100fbc:	66 a3 06 b0 9c 00    	mov    %ax,0x9cb006
	SETGATE(idt[T_DEBUG],             0, CPU_GDT_KCODE, &Xdebug,        0);
  100fc2:	b8 0a 1f 10 00       	mov    $0x101f0a,%eax
  100fc7:	66 a3 08 b0 9c 00    	mov    %ax,0x9cb008
  100fcd:	c1 e8 10             	shr    $0x10,%eax
  100fd0:	66 a3 0e b0 9c 00    	mov    %ax,0x9cb00e
	SETGATE(idt[T_NMI],               0, CPU_GDT_KCODE, &Xnmi,          0);
  100fd6:	b8 14 1f 10 00       	mov    $0x101f14,%eax
  100fdb:	66 a3 10 b0 9c 00    	mov    %ax,0x9cb010
  100fe1:	c1 e8 10             	shr    $0x10,%eax
  100fe4:	66 a3 16 b0 9c 00    	mov    %ax,0x9cb016
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
  100fea:	b8 1e 1f 10 00       	mov    $0x101f1e,%eax
  100fef:	66 a3 18 b0 9c 00    	mov    %ax,0x9cb018
  100ff5:	c1 e8 10             	shr    $0x10,%eax
  100ff8:	66 a3 1e b0 9c 00    	mov    %ax,0x9cb01e
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
  100ffe:	b8 28 1f 10 00       	mov    $0x101f28,%eax
  101003:	66 a3 20 b0 9c 00    	mov    %ax,0x9cb020
  101009:	c1 e8 10             	shr    $0x10,%eax
  10100c:	66 a3 26 b0 9c 00    	mov    %ax,0x9cb026
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
  101012:	b8 32 1f 10 00       	mov    $0x101f32,%eax

	/* install a default handler */
	for (i = 0; i < sizeof(idt)/sizeof(idt[0]); i++)
		SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);

	SETGATE(idt[T_DIVIDE],            0, CPU_GDT_KCODE, &Xdivide,       0);
  101017:	66 89 15 02 b0 9c 00 	mov    %dx,0x9cb002
	SETGATE(idt[T_DEBUG],             0, CPU_GDT_KCODE, &Xdebug,        0);
	SETGATE(idt[T_NMI],               0, CPU_GDT_KCODE, &Xnmi,          0);
  10101e:	ba 08 00 00 00       	mov    $0x8,%edx
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
  101023:	66 a3 28 b0 9c 00    	mov    %ax,0x9cb028
  101029:	c1 e8 10             	shr    $0x10,%eax
	/* install a default handler */
	for (i = 0; i < sizeof(idt)/sizeof(idt[0]); i++)
		SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);

	SETGATE(idt[T_DIVIDE],            0, CPU_GDT_KCODE, &Xdivide,       0);
	SETGATE(idt[T_DEBUG],             0, CPU_GDT_KCODE, &Xdebug,        0);
  10102c:	66 89 0d 0a b0 9c 00 	mov    %cx,0x9cb00a
	SETGATE(idt[T_NMI],               0, CPU_GDT_KCODE, &Xnmi,          0);
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
  101033:	b9 08 00 00 00       	mov    $0x8,%ecx
	for (i = 0; i < sizeof(idt)/sizeof(idt[0]); i++)
		SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);

	SETGATE(idt[T_DIVIDE],            0, CPU_GDT_KCODE, &Xdivide,       0);
	SETGATE(idt[T_DEBUG],             0, CPU_GDT_KCODE, &Xdebug,        0);
	SETGATE(idt[T_NMI],               0, CPU_GDT_KCODE, &Xnmi,          0);
  101038:	66 89 15 12 b0 9c 00 	mov    %dx,0x9cb012
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
  10103f:	ba 08 00 00 00       	mov    $0x8,%edx
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
  101044:	66 a3 2e b0 9c 00    	mov    %ax,0x9cb02e
	SETGATE(idt[T_ILLOP],             0, CPU_GDT_KCODE, &Xillop,        0);
  10104a:	b8 3c 1f 10 00       	mov    $0x101f3c,%eax
		SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);

	SETGATE(idt[T_DIVIDE],            0, CPU_GDT_KCODE, &Xdivide,       0);
	SETGATE(idt[T_DEBUG],             0, CPU_GDT_KCODE, &Xdebug,        0);
	SETGATE(idt[T_NMI],               0, CPU_GDT_KCODE, &Xnmi,          0);
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
  10104f:	66 89 0d 1a b0 9c 00 	mov    %cx,0x9cb01a
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
  101056:	b9 08 00 00 00       	mov    $0x8,%ecx

	SETGATE(idt[T_DIVIDE],            0, CPU_GDT_KCODE, &Xdivide,       0);
	SETGATE(idt[T_DEBUG],             0, CPU_GDT_KCODE, &Xdebug,        0);
	SETGATE(idt[T_NMI],               0, CPU_GDT_KCODE, &Xnmi,          0);
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
  10105b:	66 89 15 22 b0 9c 00 	mov    %dx,0x9cb022
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
	SETGATE(idt[T_ILLOP],             0, CPU_GDT_KCODE, &Xillop,        0);
  101062:	ba 08 00 00 00       	mov    $0x8,%edx
  101067:	66 a3 30 b0 9c 00    	mov    %ax,0x9cb030
  10106d:	c1 e8 10             	shr    $0x10,%eax
	SETGATE(idt[T_DIVIDE],            0, CPU_GDT_KCODE, &Xdivide,       0);
	SETGATE(idt[T_DEBUG],             0, CPU_GDT_KCODE, &Xdebug,        0);
	SETGATE(idt[T_NMI],               0, CPU_GDT_KCODE, &Xnmi,          0);
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
  101070:	66 89 0d 2a b0 9c 00 	mov    %cx,0x9cb02a
	SETGATE(idt[T_ILLOP],             0, CPU_GDT_KCODE, &Xillop,        0);
	SETGATE(idt[T_DEVICE],            0, CPU_GDT_KCODE, &Xdevice,       0);
  101077:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_DEBUG],             0, CPU_GDT_KCODE, &Xdebug,        0);
	SETGATE(idt[T_NMI],               0, CPU_GDT_KCODE, &Xnmi,          0);
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
	SETGATE(idt[T_ILLOP],             0, CPU_GDT_KCODE, &Xillop,        0);
  10107c:	66 89 15 32 b0 9c 00 	mov    %dx,0x9cb032
	SETGATE(idt[T_DEVICE],            0, CPU_GDT_KCODE, &Xdevice,       0);
	SETGATE(idt[T_DBLFLT],            0, CPU_GDT_KCODE, &Xdblflt,       0);
  101083:	ba 08 00 00 00       	mov    $0x8,%edx

	/* install a default handler */
	for (i = 0; i < sizeof(idt)/sizeof(idt[0]); i++)
		SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);

	SETGATE(idt[T_DIVIDE],            0, CPU_GDT_KCODE, &Xdivide,       0);
  101088:	c6 05 04 b0 9c 00 00 	movb   $0x0,0x9cb004
  10108f:	c6 05 05 b0 9c 00 8e 	movb   $0x8e,0x9cb005
	SETGATE(idt[T_DEBUG],             0, CPU_GDT_KCODE, &Xdebug,        0);
  101096:	c6 05 0c b0 9c 00 00 	movb   $0x0,0x9cb00c
  10109d:	c6 05 0d b0 9c 00 8e 	movb   $0x8e,0x9cb00d
	SETGATE(idt[T_NMI],               0, CPU_GDT_KCODE, &Xnmi,          0);
  1010a4:	c6 05 14 b0 9c 00 00 	movb   $0x0,0x9cb014
  1010ab:	c6 05 15 b0 9c 00 8e 	movb   $0x8e,0x9cb015
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
  1010b2:	c6 05 1c b0 9c 00 00 	movb   $0x0,0x9cb01c
  1010b9:	c6 05 1d b0 9c 00 ee 	movb   $0xee,0x9cb01d
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
  1010c0:	c6 05 24 b0 9c 00 00 	movb   $0x0,0x9cb024
  1010c7:	c6 05 25 b0 9c 00 ee 	movb   $0xee,0x9cb025
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
  1010ce:	c6 05 2c b0 9c 00 00 	movb   $0x0,0x9cb02c
  1010d5:	c6 05 2d b0 9c 00 8e 	movb   $0x8e,0x9cb02d
	SETGATE(idt[T_ILLOP],             0, CPU_GDT_KCODE, &Xillop,        0);
  1010dc:	c6 05 34 b0 9c 00 00 	movb   $0x0,0x9cb034
  1010e3:	c6 05 35 b0 9c 00 8e 	movb   $0x8e,0x9cb035
  1010ea:	66 a3 36 b0 9c 00    	mov    %ax,0x9cb036
	SETGATE(idt[T_DEVICE],            0, CPU_GDT_KCODE, &Xdevice,       0);
  1010f0:	b8 46 1f 10 00       	mov    $0x101f46,%eax
  1010f5:	66 a3 38 b0 9c 00    	mov    %ax,0x9cb038
  1010fb:	c1 e8 10             	shr    $0x10,%eax
  1010fe:	66 a3 3e b0 9c 00    	mov    %ax,0x9cb03e
	SETGATE(idt[T_DBLFLT],            0, CPU_GDT_KCODE, &Xdblflt,       0);
  101104:	b8 50 1f 10 00       	mov    $0x101f50,%eax
  101109:	66 a3 40 b0 9c 00    	mov    %ax,0x9cb040
  10110f:	c1 e8 10             	shr    $0x10,%eax
  101112:	66 a3 46 b0 9c 00    	mov    %ax,0x9cb046
	SETGATE(idt[T_TSS],               0, CPU_GDT_KCODE, &Xtss,          0);
  101118:	b8 62 1f 10 00       	mov    $0x101f62,%eax
  10111d:	66 a3 50 b0 9c 00    	mov    %ax,0x9cb050
  101123:	c1 e8 10             	shr    $0x10,%eax
  101126:	66 a3 56 b0 9c 00    	mov    %ax,0x9cb056
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
  10112c:	b8 6a 1f 10 00       	mov    $0x101f6a,%eax
  101131:	66 a3 58 b0 9c 00    	mov    %ax,0x9cb058
  101137:	c1 e8 10             	shr    $0x10,%eax
  10113a:	66 a3 5e b0 9c 00    	mov    %ax,0x9cb05e
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
  101140:	b8 72 1f 10 00       	mov    $0x101f72,%eax
  101145:	66 a3 60 b0 9c 00    	mov    %ax,0x9cb060
  10114b:	c1 e8 10             	shr    $0x10,%eax
  10114e:	66 a3 66 b0 9c 00    	mov    %ax,0x9cb066
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
  101154:	b8 7a 1f 10 00       	mov    $0x101f7a,%eax
	SETGATE(idt[T_NMI],               0, CPU_GDT_KCODE, &Xnmi,          0);
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
	SETGATE(idt[T_ILLOP],             0, CPU_GDT_KCODE, &Xillop,        0);
	SETGATE(idt[T_DEVICE],            0, CPU_GDT_KCODE, &Xdevice,       0);
  101159:	66 89 0d 3a b0 9c 00 	mov    %cx,0x9cb03a
	SETGATE(idt[T_DBLFLT],            0, CPU_GDT_KCODE, &Xdblflt,       0);
	SETGATE(idt[T_TSS],               0, CPU_GDT_KCODE, &Xtss,          0);
  101160:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
  101165:	66 a3 68 b0 9c 00    	mov    %ax,0x9cb068
  10116b:	c1 e8 10             	shr    $0x10,%eax
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
	SETGATE(idt[T_ILLOP],             0, CPU_GDT_KCODE, &Xillop,        0);
	SETGATE(idt[T_DEVICE],            0, CPU_GDT_KCODE, &Xdevice,       0);
	SETGATE(idt[T_DBLFLT],            0, CPU_GDT_KCODE, &Xdblflt,       0);
  10116e:	66 89 15 42 b0 9c 00 	mov    %dx,0x9cb042
	SETGATE(idt[T_TSS],               0, CPU_GDT_KCODE, &Xtss,          0);
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
  101175:	ba 08 00 00 00       	mov    $0x8,%edx
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
	SETGATE(idt[T_ILLOP],             0, CPU_GDT_KCODE, &Xillop,        0);
	SETGATE(idt[T_DEVICE],            0, CPU_GDT_KCODE, &Xdevice,       0);
	SETGATE(idt[T_DBLFLT],            0, CPU_GDT_KCODE, &Xdblflt,       0);
	SETGATE(idt[T_TSS],               0, CPU_GDT_KCODE, &Xtss,          0);
  10117a:	66 89 0d 52 b0 9c 00 	mov    %cx,0x9cb052
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
  101181:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
  101186:	66 a3 6e b0 9c 00    	mov    %ax,0x9cb06e
	SETGATE(idt[T_PGFLT],             0, CPU_GDT_KCODE, &Xpgflt,        0);
  10118c:	b8 82 1f 10 00       	mov    $0x101f82,%eax
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
	SETGATE(idt[T_ILLOP],             0, CPU_GDT_KCODE, &Xillop,        0);
	SETGATE(idt[T_DEVICE],            0, CPU_GDT_KCODE, &Xdevice,       0);
	SETGATE(idt[T_DBLFLT],            0, CPU_GDT_KCODE, &Xdblflt,       0);
	SETGATE(idt[T_TSS],               0, CPU_GDT_KCODE, &Xtss,          0);
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
  101191:	66 89 15 5a b0 9c 00 	mov    %dx,0x9cb05a
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
  101198:	ba 08 00 00 00       	mov    $0x8,%edx
	SETGATE(idt[T_ILLOP],             0, CPU_GDT_KCODE, &Xillop,        0);
	SETGATE(idt[T_DEVICE],            0, CPU_GDT_KCODE, &Xdevice,       0);
	SETGATE(idt[T_DBLFLT],            0, CPU_GDT_KCODE, &Xdblflt,       0);
	SETGATE(idt[T_TSS],               0, CPU_GDT_KCODE, &Xtss,          0);
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
  10119d:	66 89 0d 62 b0 9c 00 	mov    %cx,0x9cb062
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
	SETGATE(idt[T_PGFLT],             0, CPU_GDT_KCODE, &Xpgflt,        0);
  1011a4:	b9 08 00 00 00       	mov    $0x8,%ecx
  1011a9:	66 a3 70 b0 9c 00    	mov    %ax,0x9cb070
  1011af:	c1 e8 10             	shr    $0x10,%eax
	SETGATE(idt[T_DEVICE],            0, CPU_GDT_KCODE, &Xdevice,       0);
	SETGATE(idt[T_DBLFLT],            0, CPU_GDT_KCODE, &Xdblflt,       0);
	SETGATE(idt[T_TSS],               0, CPU_GDT_KCODE, &Xtss,          0);
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
  1011b2:	66 89 15 6a b0 9c 00 	mov    %dx,0x9cb06a
	SETGATE(idt[T_PGFLT],             0, CPU_GDT_KCODE, &Xpgflt,        0);
	SETGATE(idt[T_FPERR],             0, CPU_GDT_KCODE, &Xfperr,        0);
  1011b9:	ba 08 00 00 00       	mov    $0x8,%edx
	SETGATE(idt[T_DBLFLT],            0, CPU_GDT_KCODE, &Xdblflt,       0);
	SETGATE(idt[T_TSS],               0, CPU_GDT_KCODE, &Xtss,          0);
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
	SETGATE(idt[T_PGFLT],             0, CPU_GDT_KCODE, &Xpgflt,        0);
  1011be:	66 89 0d 72 b0 9c 00 	mov    %cx,0x9cb072
	SETGATE(idt[T_FPERR],             0, CPU_GDT_KCODE, &Xfperr,        0);
	SETGATE(idt[T_ALIGN],             0, CPU_GDT_KCODE, &Xalign,        0);
  1011c5:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_NMI],               0, CPU_GDT_KCODE, &Xnmi,          0);
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
	SETGATE(idt[T_ILLOP],             0, CPU_GDT_KCODE, &Xillop,        0);
	SETGATE(idt[T_DEVICE],            0, CPU_GDT_KCODE, &Xdevice,       0);
  1011ca:	c6 05 3c b0 9c 00 00 	movb   $0x0,0x9cb03c
  1011d1:	c6 05 3d b0 9c 00 8e 	movb   $0x8e,0x9cb03d
	SETGATE(idt[T_DBLFLT],            0, CPU_GDT_KCODE, &Xdblflt,       0);
  1011d8:	c6 05 44 b0 9c 00 00 	movb   $0x0,0x9cb044
  1011df:	c6 05 45 b0 9c 00 8e 	movb   $0x8e,0x9cb045
	SETGATE(idt[T_TSS],               0, CPU_GDT_KCODE, &Xtss,          0);
  1011e6:	c6 05 54 b0 9c 00 00 	movb   $0x0,0x9cb054
  1011ed:	c6 05 55 b0 9c 00 8e 	movb   $0x8e,0x9cb055
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
  1011f4:	c6 05 5c b0 9c 00 00 	movb   $0x0,0x9cb05c
  1011fb:	c6 05 5d b0 9c 00 8e 	movb   $0x8e,0x9cb05d
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
  101202:	c6 05 64 b0 9c 00 00 	movb   $0x0,0x9cb064
  101209:	c6 05 65 b0 9c 00 8e 	movb   $0x8e,0x9cb065
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
  101210:	c6 05 6c b0 9c 00 00 	movb   $0x0,0x9cb06c
  101217:	c6 05 6d b0 9c 00 8e 	movb   $0x8e,0x9cb06d
	SETGATE(idt[T_PGFLT],             0, CPU_GDT_KCODE, &Xpgflt,        0);
  10121e:	c6 05 74 b0 9c 00 00 	movb   $0x0,0x9cb074
  101225:	66 a3 76 b0 9c 00    	mov    %ax,0x9cb076
	SETGATE(idt[T_FPERR],             0, CPU_GDT_KCODE, &Xfperr,        0);
  10122b:	b8 94 1f 10 00       	mov    $0x101f94,%eax
  101230:	66 a3 80 b0 9c 00    	mov    %ax,0x9cb080
  101236:	c1 e8 10             	shr    $0x10,%eax
  101239:	66 a3 86 b0 9c 00    	mov    %ax,0x9cb086
	SETGATE(idt[T_ALIGN],             0, CPU_GDT_KCODE, &Xalign,        0);
  10123f:	b8 9e 1f 10 00       	mov    $0x101f9e,%eax
  101244:	66 a3 88 b0 9c 00    	mov    %ax,0x9cb088
  10124a:	c1 e8 10             	shr    $0x10,%eax
  10124d:	66 a3 8e b0 9c 00    	mov    %ax,0x9cb08e
	SETGATE(idt[T_MCHK],              0, CPU_GDT_KCODE, &Xmchk,         0);
  101253:	b8 a2 1f 10 00       	mov    $0x101fa2,%eax
  101258:	66 a3 90 b0 9c 00    	mov    %ax,0x9cb090
  10125e:	c1 e8 10             	shr    $0x10,%eax
  101261:	66 a3 96 b0 9c 00    	mov    %ax,0x9cb096

	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
  101267:	b8 a8 1f 10 00       	mov    $0x101fa8,%eax
  10126c:	66 a3 00 b1 9c 00    	mov    %ax,0x9cb100
  101272:	c1 e8 10             	shr    $0x10,%eax
  101275:	66 a3 06 b1 9c 00    	mov    %ax,0x9cb106
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
  10127b:	b8 ae 1f 10 00       	mov    $0x101fae,%eax
  101280:	66 a3 08 b1 9c 00    	mov    %ax,0x9cb108
  101286:	c1 e8 10             	shr    $0x10,%eax
  101289:	66 a3 0e b1 9c 00    	mov    %ax,0x9cb10e
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
  10128f:	b8 b4 1f 10 00       	mov    $0x101fb4,%eax
	SETGATE(idt[T_TSS],               0, CPU_GDT_KCODE, &Xtss,          0);
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
	SETGATE(idt[T_PGFLT],             0, CPU_GDT_KCODE, &Xpgflt,        0);
	SETGATE(idt[T_FPERR],             0, CPU_GDT_KCODE, &Xfperr,        0);
  101294:	66 89 15 82 b0 9c 00 	mov    %dx,0x9cb082
	SETGATE(idt[T_ALIGN],             0, CPU_GDT_KCODE, &Xalign,        0);
	SETGATE(idt[T_MCHK],              0, CPU_GDT_KCODE, &Xmchk,         0);
  10129b:	ba 08 00 00 00       	mov    $0x8,%edx

	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
  1012a0:	66 a3 10 b1 9c 00    	mov    %ax,0x9cb110
  1012a6:	c1 e8 10             	shr    $0x10,%eax
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
	SETGATE(idt[T_PGFLT],             0, CPU_GDT_KCODE, &Xpgflt,        0);
	SETGATE(idt[T_FPERR],             0, CPU_GDT_KCODE, &Xfperr,        0);
	SETGATE(idt[T_ALIGN],             0, CPU_GDT_KCODE, &Xalign,        0);
  1012a9:	66 89 0d 8a b0 9c 00 	mov    %cx,0x9cb08a
	SETGATE(idt[T_MCHK],              0, CPU_GDT_KCODE, &Xmchk,         0);

	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
  1012b0:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
	SETGATE(idt[T_PGFLT],             0, CPU_GDT_KCODE, &Xpgflt,        0);
	SETGATE(idt[T_FPERR],             0, CPU_GDT_KCODE, &Xfperr,        0);
	SETGATE(idt[T_ALIGN],             0, CPU_GDT_KCODE, &Xalign,        0);
	SETGATE(idt[T_MCHK],              0, CPU_GDT_KCODE, &Xmchk,         0);
  1012b5:	66 89 15 92 b0 9c 00 	mov    %dx,0x9cb092

	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
  1012bc:	ba 08 00 00 00       	mov    $0x8,%edx
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
  1012c1:	66 a3 16 b1 9c 00    	mov    %ax,0x9cb116
	SETGATE(idt[T_IRQ0+IRQ_SERIAL24], 0, CPU_GDT_KCODE, &Xirq_serial2,  0);
  1012c7:	b8 ba 1f 10 00       	mov    $0x101fba,%eax
	SETGATE(idt[T_PGFLT],             0, CPU_GDT_KCODE, &Xpgflt,        0);
	SETGATE(idt[T_FPERR],             0, CPU_GDT_KCODE, &Xfperr,        0);
	SETGATE(idt[T_ALIGN],             0, CPU_GDT_KCODE, &Xalign,        0);
	SETGATE(idt[T_MCHK],              0, CPU_GDT_KCODE, &Xmchk,         0);

	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
  1012cc:	66 89 0d 02 b1 9c 00 	mov    %cx,0x9cb102
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
  1012d3:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_FPERR],             0, CPU_GDT_KCODE, &Xfperr,        0);
	SETGATE(idt[T_ALIGN],             0, CPU_GDT_KCODE, &Xalign,        0);
	SETGATE(idt[T_MCHK],              0, CPU_GDT_KCODE, &Xmchk,         0);

	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
  1012d8:	66 89 15 0a b1 9c 00 	mov    %dx,0x9cb10a
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL24], 0, CPU_GDT_KCODE, &Xirq_serial2,  0);
  1012df:	ba 08 00 00 00       	mov    $0x8,%edx
  1012e4:	66 a3 18 b1 9c 00    	mov    %ax,0x9cb118
  1012ea:	c1 e8 10             	shr    $0x10,%eax
	SETGATE(idt[T_ALIGN],             0, CPU_GDT_KCODE, &Xalign,        0);
	SETGATE(idt[T_MCHK],              0, CPU_GDT_KCODE, &Xmchk,         0);

	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
  1012ed:	66 89 0d 12 b1 9c 00 	mov    %cx,0x9cb112
	SETGATE(idt[T_IRQ0+IRQ_SERIAL24], 0, CPU_GDT_KCODE, &Xirq_serial2,  0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL13], 0, CPU_GDT_KCODE, &Xirq_serial1,  0);
  1012f4:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_DBLFLT],            0, CPU_GDT_KCODE, &Xdblflt,       0);
	SETGATE(idt[T_TSS],               0, CPU_GDT_KCODE, &Xtss,          0);
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
	SETGATE(idt[T_PGFLT],             0, CPU_GDT_KCODE, &Xpgflt,        0);
  1012f9:	c6 05 75 b0 9c 00 8e 	movb   $0x8e,0x9cb075
	SETGATE(idt[T_FPERR],             0, CPU_GDT_KCODE, &Xfperr,        0);
  101300:	c6 05 84 b0 9c 00 00 	movb   $0x0,0x9cb084
  101307:	c6 05 85 b0 9c 00 8e 	movb   $0x8e,0x9cb085
	SETGATE(idt[T_ALIGN],             0, CPU_GDT_KCODE, &Xalign,        0);
  10130e:	c6 05 8c b0 9c 00 00 	movb   $0x0,0x9cb08c
  101315:	c6 05 8d b0 9c 00 8e 	movb   $0x8e,0x9cb08d
	SETGATE(idt[T_MCHK],              0, CPU_GDT_KCODE, &Xmchk,         0);
  10131c:	c6 05 94 b0 9c 00 00 	movb   $0x0,0x9cb094
  101323:	c6 05 95 b0 9c 00 8e 	movb   $0x8e,0x9cb095

	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
  10132a:	c6 05 04 b1 9c 00 00 	movb   $0x0,0x9cb104
  101331:	c6 05 05 b1 9c 00 8e 	movb   $0x8e,0x9cb105
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
  101338:	c6 05 0c b1 9c 00 00 	movb   $0x0,0x9cb10c
  10133f:	c6 05 0d b1 9c 00 8e 	movb   $0x8e,0x9cb10d
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
  101346:	c6 05 14 b1 9c 00 00 	movb   $0x0,0x9cb114
  10134d:	c6 05 15 b1 9c 00 8e 	movb   $0x8e,0x9cb115
	SETGATE(idt[T_IRQ0+IRQ_SERIAL24], 0, CPU_GDT_KCODE, &Xirq_serial2,  0);
  101354:	66 89 15 1a b1 9c 00 	mov    %dx,0x9cb11a
	SETGATE(idt[T_IRQ0+IRQ_SERIAL13], 0, CPU_GDT_KCODE, &Xirq_serial1,  0);
	SETGATE(idt[T_IRQ0+IRQ_LPT2],     0, CPU_GDT_KCODE, &Xirq_lpt,      0);
  10135b:	ba 08 00 00 00       	mov    $0x8,%edx
	SETGATE(idt[T_MCHK],              0, CPU_GDT_KCODE, &Xmchk,         0);

	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL24], 0, CPU_GDT_KCODE, &Xirq_serial2,  0);
  101360:	66 a3 1e b1 9c 00    	mov    %ax,0x9cb11e
	SETGATE(idt[T_IRQ0+IRQ_SERIAL13], 0, CPU_GDT_KCODE, &Xirq_serial1,  0);
  101366:	b8 c0 1f 10 00       	mov    $0x101fc0,%eax
  10136b:	66 a3 20 b1 9c 00    	mov    %ax,0x9cb120
  101371:	c1 e8 10             	shr    $0x10,%eax
  101374:	66 a3 26 b1 9c 00    	mov    %ax,0x9cb126
	SETGATE(idt[T_IRQ0+IRQ_LPT2],     0, CPU_GDT_KCODE, &Xirq_lpt,      0);
  10137a:	b8 c6 1f 10 00       	mov    $0x101fc6,%eax
  10137f:	66 a3 28 b1 9c 00    	mov    %ax,0x9cb128
  101385:	c1 e8 10             	shr    $0x10,%eax
  101388:	66 a3 2e b1 9c 00    	mov    %ax,0x9cb12e
	SETGATE(idt[T_IRQ0+IRQ_FLOPPY],   0, CPU_GDT_KCODE, &Xirq_floppy,   0);
  10138e:	b8 cc 1f 10 00       	mov    $0x101fcc,%eax
  101393:	66 a3 30 b1 9c 00    	mov    %ax,0x9cb130
  101399:	c1 e8 10             	shr    $0x10,%eax
  10139c:	66 a3 36 b1 9c 00    	mov    %ax,0x9cb136
	SETGATE(idt[T_IRQ0+IRQ_SPURIOUS], 0, CPU_GDT_KCODE, &Xirq_spurious, 0);
  1013a2:	b8 d2 1f 10 00       	mov    $0x101fd2,%eax
  1013a7:	66 a3 38 b1 9c 00    	mov    %ax,0x9cb138
  1013ad:	c1 e8 10             	shr    $0x10,%eax
  1013b0:	66 a3 3e b1 9c 00    	mov    %ax,0x9cb13e
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
  1013b6:	b8 d8 1f 10 00       	mov    $0x101fd8,%eax
  1013bb:	66 a3 40 b1 9c 00    	mov    %ax,0x9cb140
  1013c1:	c1 e8 10             	shr    $0x10,%eax
  1013c4:	66 a3 46 b1 9c 00    	mov    %ax,0x9cb146
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
  1013ca:	b8 de 1f 10 00       	mov    $0x101fde,%eax

	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL24], 0, CPU_GDT_KCODE, &Xirq_serial2,  0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL13], 0, CPU_GDT_KCODE, &Xirq_serial1,  0);
  1013cf:	66 89 0d 22 b1 9c 00 	mov    %cx,0x9cb122
	SETGATE(idt[T_IRQ0+IRQ_LPT2],     0, CPU_GDT_KCODE, &Xirq_lpt,      0);
	SETGATE(idt[T_IRQ0+IRQ_FLOPPY],   0, CPU_GDT_KCODE, &Xirq_floppy,   0);
  1013d6:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL24], 0, CPU_GDT_KCODE, &Xirq_serial2,  0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL13], 0, CPU_GDT_KCODE, &Xirq_serial1,  0);
	SETGATE(idt[T_IRQ0+IRQ_LPT2],     0, CPU_GDT_KCODE, &Xirq_lpt,      0);
  1013db:	66 89 15 2a b1 9c 00 	mov    %dx,0x9cb12a
	SETGATE(idt[T_IRQ0+IRQ_FLOPPY],   0, CPU_GDT_KCODE, &Xirq_floppy,   0);
	SETGATE(idt[T_IRQ0+IRQ_SPURIOUS], 0, CPU_GDT_KCODE, &Xirq_spurious, 0);
  1013e2:	ba 08 00 00 00       	mov    $0x8,%edx
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
  1013e7:	66 a3 48 b1 9c 00    	mov    %ax,0x9cb148
  1013ed:	c1 e8 10             	shr    $0x10,%eax
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL24], 0, CPU_GDT_KCODE, &Xirq_serial2,  0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL13], 0, CPU_GDT_KCODE, &Xirq_serial1,  0);
	SETGATE(idt[T_IRQ0+IRQ_LPT2],     0, CPU_GDT_KCODE, &Xirq_lpt,      0);
	SETGATE(idt[T_IRQ0+IRQ_FLOPPY],   0, CPU_GDT_KCODE, &Xirq_floppy,   0);
  1013f0:	66 89 0d 32 b1 9c 00 	mov    %cx,0x9cb132
	SETGATE(idt[T_IRQ0+IRQ_SPURIOUS], 0, CPU_GDT_KCODE, &Xirq_spurious, 0);
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
  1013f7:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL24], 0, CPU_GDT_KCODE, &Xirq_serial2,  0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL13], 0, CPU_GDT_KCODE, &Xirq_serial1,  0);
	SETGATE(idt[T_IRQ0+IRQ_LPT2],     0, CPU_GDT_KCODE, &Xirq_lpt,      0);
	SETGATE(idt[T_IRQ0+IRQ_FLOPPY],   0, CPU_GDT_KCODE, &Xirq_floppy,   0);
	SETGATE(idt[T_IRQ0+IRQ_SPURIOUS], 0, CPU_GDT_KCODE, &Xirq_spurious, 0);
  1013fc:	66 89 15 3a b1 9c 00 	mov    %dx,0x9cb13a
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
  101403:	ba 08 00 00 00       	mov    $0x8,%edx
  101408:	66 a3 4e b1 9c 00    	mov    %ax,0x9cb14e
	SETGATE(idt[T_IRQ0+10],           0, CPU_GDT_KCODE, &Xirq10,        0);
  10140e:	b8 e4 1f 10 00       	mov    $0x101fe4,%eax
	SETGATE(idt[T_IRQ0+IRQ_SERIAL24], 0, CPU_GDT_KCODE, &Xirq_serial2,  0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL13], 0, CPU_GDT_KCODE, &Xirq_serial1,  0);
	SETGATE(idt[T_IRQ0+IRQ_LPT2],     0, CPU_GDT_KCODE, &Xirq_lpt,      0);
	SETGATE(idt[T_IRQ0+IRQ_FLOPPY],   0, CPU_GDT_KCODE, &Xirq_floppy,   0);
	SETGATE(idt[T_IRQ0+IRQ_SPURIOUS], 0, CPU_GDT_KCODE, &Xirq_spurious, 0);
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
  101413:	66 89 0d 42 b1 9c 00 	mov    %cx,0x9cb142
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
	SETGATE(idt[T_IRQ0+10],           0, CPU_GDT_KCODE, &Xirq10,        0);
  10141a:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_IRQ0+IRQ_SERIAL13], 0, CPU_GDT_KCODE, &Xirq_serial1,  0);
	SETGATE(idt[T_IRQ0+IRQ_LPT2],     0, CPU_GDT_KCODE, &Xirq_lpt,      0);
	SETGATE(idt[T_IRQ0+IRQ_FLOPPY],   0, CPU_GDT_KCODE, &Xirq_floppy,   0);
	SETGATE(idt[T_IRQ0+IRQ_SPURIOUS], 0, CPU_GDT_KCODE, &Xirq_spurious, 0);
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
  10141f:	66 89 15 4a b1 9c 00 	mov    %dx,0x9cb14a
	SETGATE(idt[T_IRQ0+10],           0, CPU_GDT_KCODE, &Xirq10,        0);
	SETGATE(idt[T_IRQ0+11],           0, CPU_GDT_KCODE, &Xirq11,        0);
  101426:	ba 08 00 00 00       	mov    $0x8,%edx
	SETGATE(idt[T_MCHK],              0, CPU_GDT_KCODE, &Xmchk,         0);

	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL24], 0, CPU_GDT_KCODE, &Xirq_serial2,  0);
  10142b:	c6 05 1c b1 9c 00 00 	movb   $0x0,0x9cb11c
  101432:	c6 05 1d b1 9c 00 8e 	movb   $0x8e,0x9cb11d
	SETGATE(idt[T_IRQ0+IRQ_SERIAL13], 0, CPU_GDT_KCODE, &Xirq_serial1,  0);
  101439:	c6 05 24 b1 9c 00 00 	movb   $0x0,0x9cb124
  101440:	c6 05 25 b1 9c 00 8e 	movb   $0x8e,0x9cb125
	SETGATE(idt[T_IRQ0+IRQ_LPT2],     0, CPU_GDT_KCODE, &Xirq_lpt,      0);
  101447:	c6 05 2c b1 9c 00 00 	movb   $0x0,0x9cb12c
  10144e:	c6 05 2d b1 9c 00 8e 	movb   $0x8e,0x9cb12d
	SETGATE(idt[T_IRQ0+IRQ_FLOPPY],   0, CPU_GDT_KCODE, &Xirq_floppy,   0);
  101455:	c6 05 34 b1 9c 00 00 	movb   $0x0,0x9cb134
  10145c:	c6 05 35 b1 9c 00 8e 	movb   $0x8e,0x9cb135
	SETGATE(idt[T_IRQ0+IRQ_SPURIOUS], 0, CPU_GDT_KCODE, &Xirq_spurious, 0);
  101463:	c6 05 3c b1 9c 00 00 	movb   $0x0,0x9cb13c
  10146a:	c6 05 3d b1 9c 00 8e 	movb   $0x8e,0x9cb13d
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
  101471:	c6 05 44 b1 9c 00 00 	movb   $0x0,0x9cb144
  101478:	c6 05 45 b1 9c 00 8e 	movb   $0x8e,0x9cb145
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
  10147f:	c6 05 4c b1 9c 00 00 	movb   $0x0,0x9cb14c
  101486:	c6 05 4d b1 9c 00 8e 	movb   $0x8e,0x9cb14d
	SETGATE(idt[T_IRQ0+10],           0, CPU_GDT_KCODE, &Xirq10,        0);
  10148d:	66 a3 50 b1 9c 00    	mov    %ax,0x9cb150
  101493:	c1 e8 10             	shr    $0x10,%eax
  101496:	66 a3 56 b1 9c 00    	mov    %ax,0x9cb156
	SETGATE(idt[T_IRQ0+11],           0, CPU_GDT_KCODE, &Xirq11,        0);
  10149c:	b8 ea 1f 10 00       	mov    $0x101fea,%eax
  1014a1:	66 a3 58 b1 9c 00    	mov    %ax,0x9cb158
  1014a7:	c1 e8 10             	shr    $0x10,%eax
  1014aa:	66 a3 5e b1 9c 00    	mov    %ax,0x9cb15e
	SETGATE(idt[T_IRQ0+IRQ_MOUSE],    0, CPU_GDT_KCODE, &Xirq_mouse,    0);
  1014b0:	b8 f0 1f 10 00       	mov    $0x101ff0,%eax
  1014b5:	66 a3 60 b1 9c 00    	mov    %ax,0x9cb160
  1014bb:	c1 e8 10             	shr    $0x10,%eax
  1014be:	66 a3 66 b1 9c 00    	mov    %ax,0x9cb166
	SETGATE(idt[T_IRQ0+IRQ_COPROCESSOR], 0, CPU_GDT_KCODE, &Xirq_coproc, 0);
  1014c4:	b8 f6 1f 10 00       	mov    $0x101ff6,%eax
  1014c9:	66 a3 68 b1 9c 00    	mov    %ax,0x9cb168
  1014cf:	c1 e8 10             	shr    $0x10,%eax
  1014d2:	66 a3 6e b1 9c 00    	mov    %ax,0x9cb16e
	SETGATE(idt[T_IRQ0+IRQ_IDE1],     0, CPU_GDT_KCODE, &Xirq_ide1,     0);
  1014d8:	b8 fc 1f 10 00       	mov    $0x101ffc,%eax
  1014dd:	66 a3 70 b1 9c 00    	mov    %ax,0x9cb170
  1014e3:	c1 e8 10             	shr    $0x10,%eax
  1014e6:	66 a3 76 b1 9c 00    	mov    %ax,0x9cb176
	SETGATE(idt[T_IRQ0+IRQ_IDE2],     0, CPU_GDT_KCODE, &Xirq_ide2,     0);
  1014ec:	b8 02 20 10 00       	mov    $0x102002,%eax
	SETGATE(idt[T_IRQ0+IRQ_LPT2],     0, CPU_GDT_KCODE, &Xirq_lpt,      0);
	SETGATE(idt[T_IRQ0+IRQ_FLOPPY],   0, CPU_GDT_KCODE, &Xirq_floppy,   0);
	SETGATE(idt[T_IRQ0+IRQ_SPURIOUS], 0, CPU_GDT_KCODE, &Xirq_spurious, 0);
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
	SETGATE(idt[T_IRQ0+10],           0, CPU_GDT_KCODE, &Xirq10,        0);
  1014f1:	66 89 0d 52 b1 9c 00 	mov    %cx,0x9cb152
	SETGATE(idt[T_IRQ0+11],           0, CPU_GDT_KCODE, &Xirq11,        0);
	SETGATE(idt[T_IRQ0+IRQ_MOUSE],    0, CPU_GDT_KCODE, &Xirq_mouse,    0);
  1014f8:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_IRQ0+IRQ_COPROCESSOR], 0, CPU_GDT_KCODE, &Xirq_coproc, 0);
	SETGATE(idt[T_IRQ0+IRQ_IDE1],     0, CPU_GDT_KCODE, &Xirq_ide1,     0);
	SETGATE(idt[T_IRQ0+IRQ_IDE2],     0, CPU_GDT_KCODE, &Xirq_ide2,     0);
  1014fd:	66 a3 78 b1 9c 00    	mov    %ax,0x9cb178
  101503:	c1 e8 10             	shr    $0x10,%eax
	SETGATE(idt[T_IRQ0+IRQ_FLOPPY],   0, CPU_GDT_KCODE, &Xirq_floppy,   0);
	SETGATE(idt[T_IRQ0+IRQ_SPURIOUS], 0, CPU_GDT_KCODE, &Xirq_spurious, 0);
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
	SETGATE(idt[T_IRQ0+10],           0, CPU_GDT_KCODE, &Xirq10,        0);
	SETGATE(idt[T_IRQ0+11],           0, CPU_GDT_KCODE, &Xirq11,        0);
  101506:	66 89 15 5a b1 9c 00 	mov    %dx,0x9cb15a
	SETGATE(idt[T_IRQ0+IRQ_MOUSE],    0, CPU_GDT_KCODE, &Xirq_mouse,    0);
	SETGATE(idt[T_IRQ0+IRQ_COPROCESSOR], 0, CPU_GDT_KCODE, &Xirq_coproc, 0);
  10150d:	ba 08 00 00 00       	mov    $0x8,%edx
	SETGATE(idt[T_IRQ0+IRQ_SPURIOUS], 0, CPU_GDT_KCODE, &Xirq_spurious, 0);
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
	SETGATE(idt[T_IRQ0+10],           0, CPU_GDT_KCODE, &Xirq10,        0);
	SETGATE(idt[T_IRQ0+11],           0, CPU_GDT_KCODE, &Xirq11,        0);
	SETGATE(idt[T_IRQ0+IRQ_MOUSE],    0, CPU_GDT_KCODE, &Xirq_mouse,    0);
  101512:	66 89 0d 62 b1 9c 00 	mov    %cx,0x9cb162
	SETGATE(idt[T_IRQ0+IRQ_COPROCESSOR], 0, CPU_GDT_KCODE, &Xirq_coproc, 0);
	SETGATE(idt[T_IRQ0+IRQ_IDE1],     0, CPU_GDT_KCODE, &Xirq_ide1,     0);
  101519:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_IRQ0+IRQ_IDE2],     0, CPU_GDT_KCODE, &Xirq_ide2,     0);
  10151e:	66 a3 7e b1 9c 00    	mov    %ax,0x9cb17e

	// Use DPL=3 here because system calls are explicitly invoked
	// by the user process (with "int $T_SYSCALL").
	SETGATE(idt[T_SYSCALL],           0, CPU_GDT_KCODE, &Xsyscall,      3);
  101524:	b8 08 20 10 00       	mov    $0x102008,%eax
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
	SETGATE(idt[T_IRQ0+10],           0, CPU_GDT_KCODE, &Xirq10,        0);
	SETGATE(idt[T_IRQ0+11],           0, CPU_GDT_KCODE, &Xirq11,        0);
	SETGATE(idt[T_IRQ0+IRQ_MOUSE],    0, CPU_GDT_KCODE, &Xirq_mouse,    0);
	SETGATE(idt[T_IRQ0+IRQ_COPROCESSOR], 0, CPU_GDT_KCODE, &Xirq_coproc, 0);
  101529:	66 89 15 6a b1 9c 00 	mov    %dx,0x9cb16a
	SETGATE(idt[T_IRQ0+IRQ_IDE1],     0, CPU_GDT_KCODE, &Xirq_ide1,     0);
	SETGATE(idt[T_IRQ0+IRQ_IDE2],     0, CPU_GDT_KCODE, &Xirq_ide2,     0);
  101530:	ba 08 00 00 00       	mov    $0x8,%edx
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
	SETGATE(idt[T_IRQ0+10],           0, CPU_GDT_KCODE, &Xirq10,        0);
	SETGATE(idt[T_IRQ0+11],           0, CPU_GDT_KCODE, &Xirq11,        0);
	SETGATE(idt[T_IRQ0+IRQ_MOUSE],    0, CPU_GDT_KCODE, &Xirq_mouse,    0);
	SETGATE(idt[T_IRQ0+IRQ_COPROCESSOR], 0, CPU_GDT_KCODE, &Xirq_coproc, 0);
	SETGATE(idt[T_IRQ0+IRQ_IDE1],     0, CPU_GDT_KCODE, &Xirq_ide1,     0);
  101535:	66 89 0d 72 b1 9c 00 	mov    %cx,0x9cb172
	SETGATE(idt[T_IRQ0+IRQ_IDE2],     0, CPU_GDT_KCODE, &Xirq_ide2,     0);

	// Use DPL=3 here because system calls are explicitly invoked
	// by the user process (with "int $T_SYSCALL").
	SETGATE(idt[T_SYSCALL],           0, CPU_GDT_KCODE, &Xsyscall,      3);
  10153c:	b9 08 00 00 00       	mov    $0x8,%ecx
  101541:	66 a3 80 b1 9c 00    	mov    %ax,0x9cb180
  101547:	c1 e8 10             	shr    $0x10,%eax
	SETGATE(idt[T_IRQ0+10],           0, CPU_GDT_KCODE, &Xirq10,        0);
	SETGATE(idt[T_IRQ0+11],           0, CPU_GDT_KCODE, &Xirq11,        0);
	SETGATE(idt[T_IRQ0+IRQ_MOUSE],    0, CPU_GDT_KCODE, &Xirq_mouse,    0);
	SETGATE(idt[T_IRQ0+IRQ_COPROCESSOR], 0, CPU_GDT_KCODE, &Xirq_coproc, 0);
	SETGATE(idt[T_IRQ0+IRQ_IDE1],     0, CPU_GDT_KCODE, &Xirq_ide1,     0);
	SETGATE(idt[T_IRQ0+IRQ_IDE2],     0, CPU_GDT_KCODE, &Xirq_ide2,     0);
  10154a:	66 89 15 7a b1 9c 00 	mov    %dx,0x9cb17a

	// Use DPL=3 here because system calls are explicitly invoked
	// by the user process (with "int $T_SYSCALL").
	SETGATE(idt[T_SYSCALL],           0, CPU_GDT_KCODE, &Xsyscall,      3);
  101551:	66 89 0d 82 b1 9c 00 	mov    %cx,0x9cb182
	SETGATE(idt[T_IRQ0+IRQ_LPT2],     0, CPU_GDT_KCODE, &Xirq_lpt,      0);
	SETGATE(idt[T_IRQ0+IRQ_FLOPPY],   0, CPU_GDT_KCODE, &Xirq_floppy,   0);
	SETGATE(idt[T_IRQ0+IRQ_SPURIOUS], 0, CPU_GDT_KCODE, &Xirq_spurious, 0);
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
	SETGATE(idt[T_IRQ0+10],           0, CPU_GDT_KCODE, &Xirq10,        0);
  101558:	c6 05 54 b1 9c 00 00 	movb   $0x0,0x9cb154
  10155f:	c6 05 55 b1 9c 00 8e 	movb   $0x8e,0x9cb155
	SETGATE(idt[T_IRQ0+11],           0, CPU_GDT_KCODE, &Xirq11,        0);
  101566:	c6 05 5c b1 9c 00 00 	movb   $0x0,0x9cb15c
  10156d:	c6 05 5d b1 9c 00 8e 	movb   $0x8e,0x9cb15d
	SETGATE(idt[T_IRQ0+IRQ_MOUSE],    0, CPU_GDT_KCODE, &Xirq_mouse,    0);
  101574:	c6 05 64 b1 9c 00 00 	movb   $0x0,0x9cb164
  10157b:	c6 05 65 b1 9c 00 8e 	movb   $0x8e,0x9cb165
	SETGATE(idt[T_IRQ0+IRQ_COPROCESSOR], 0, CPU_GDT_KCODE, &Xirq_coproc, 0);
  101582:	c6 05 6c b1 9c 00 00 	movb   $0x0,0x9cb16c
  101589:	c6 05 6d b1 9c 00 8e 	movb   $0x8e,0x9cb16d
	SETGATE(idt[T_IRQ0+IRQ_IDE1],     0, CPU_GDT_KCODE, &Xirq_ide1,     0);
  101590:	c6 05 74 b1 9c 00 00 	movb   $0x0,0x9cb174
  101597:	c6 05 75 b1 9c 00 8e 	movb   $0x8e,0x9cb175
	SETGATE(idt[T_IRQ0+IRQ_IDE2],     0, CPU_GDT_KCODE, &Xirq_ide2,     0);
  10159e:	c6 05 7c b1 9c 00 00 	movb   $0x0,0x9cb17c
  1015a5:	c6 05 7d b1 9c 00 8e 	movb   $0x8e,0x9cb17d

	// Use DPL=3 here because system calls are explicitly invoked
	// by the user process (with "int $T_SYSCALL").
	SETGATE(idt[T_SYSCALL],           0, CPU_GDT_KCODE, &Xsyscall,      3);
  1015ac:	c6 05 84 b1 9c 00 00 	movb   $0x0,0x9cb184
  1015b3:	c6 05 85 b1 9c 00 ee 	movb   $0xee,0x9cb185
  1015ba:	66 a3 86 b1 9c 00    	mov    %ax,0x9cb186

	/* default */
	SETGATE(idt[T_DEFAULT],           0, CPU_GDT_KCODE, &Xdefault,      0);
  1015c0:	66 89 1d f0 b7 9c 00 	mov    %bx,0x9cb7f0
  1015c7:	bb 08 00 00 00       	mov    $0x8,%ebx
  1015cc:	66 89 1d f2 b7 9c 00 	mov    %bx,0x9cb7f2
  1015d3:	c6 05 f4 b7 9c 00 00 	movb   $0x0,0x9cb7f4
  1015da:	c6 05 f5 b7 9c 00 8e 	movb   $0x8e,0x9cb7f5
  1015e1:	66 89 35 f6 b7 9c 00 	mov    %si,0x9cb7f6

	asm volatile("lidt %0" : : "m" (idt_pd));
  1015e8:	0f 01 1d 00 03 11 00 	lidtl  0x110300
		}
		lapic_init();
	}

	intr_init_idt();
	intr_inited = TRUE;
  1015ef:	c6 05 60 fe 13 00 01 	movb   $0x1,0x13fe60
}
  1015f6:	83 c4 34             	add    $0x34,%esp
  1015f9:	5b                   	pop    %ebx
  1015fa:	5e                   	pop    %esi
  1015fb:	c3                   	ret    
  cpuid(0x00000001, &dummy, &dummy, &dummy, &edx);
  using_apic = (edx & CPUID_FEATURE_APIC) ? TRUE : FALSE;
  KERN_ASSERT(using_apic == TRUE);

	if (using_apic == TRUE){
		if(pcpu_onboot()){
  1015fc:	e8 7f 1f 00 00       	call   103580 <pcpu_onboot>
  101601:	85 c0                	test   %eax,%eax
  101603:	75 10                	jne    101615 <intr_init+0x735>
			ioapic_init();
		}
		lapic_init();
  101605:	e8 36 0d 00 00       	call   102340 <lapic_init>
  10160a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101610:	e9 46 f9 ff ff       	jmp    100f5b <intr_init+0x7b>
  using_apic = (edx & CPUID_FEATURE_APIC) ? TRUE : FALSE;
  KERN_ASSERT(using_apic == TRUE);

	if (using_apic == TRUE){
		if(pcpu_onboot()){
			ioapic_init();
  101615:	e8 46 12 00 00       	call   102860 <ioapic_init>
  10161a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101620:	eb e3                	jmp    101605 <intr_init+0x725>
  101622:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  101629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101630 <intr_enable>:
	intr_inited = TRUE;
}

void
intr_enable(uint8_t irq, int cpunum)
{
  101630:	56                   	push   %esi
  101631:	53                   	push   %ebx
  101632:	83 ec 14             	sub    $0x14,%esp
  101635:	8b 5c 24 24          	mov    0x24(%esp),%ebx
  101639:	8b 74 24 20          	mov    0x20(%esp),%esi
    KERN_ASSERT(cpunum == 0xff || (0 <= cpunum && cpunum < pcpu_ncpu()));
  10163d:	81 fb ff 00 00 00    	cmp    $0xff,%ebx
  101643:	74 0d                	je     101652 <intr_enable+0x22>
  101645:	85 db                	test   %ebx,%ebx
  101647:	78 77                	js     1016c0 <intr_enable+0x90>
  101649:	e8 12 1f 00 00       	call   103560 <pcpu_ncpu>
  10164e:	39 c3                	cmp    %eax,%ebx
  101650:	7d 6e                	jge    1016c0 <intr_enable+0x90>

    if (irq >= 24)
  101652:	89 f0                	mov    %esi,%eax
  101654:	3c 17                	cmp    $0x17,%al
  101656:	77 61                	ja     1016b9 <intr_enable+0x89>
        return;

    if (using_apic == TRUE) {
  101658:	0f b6 05 61 fe 13 00 	movzbl 0x13fe61,%eax
  10165f:	3c 01                	cmp    $0x1,%al
  101661:	74 1d                	je     101680 <intr_enable+0x50>
        ioapic_enable(irq, (cpunum == 0xff) ?
                          0xff : pcpu_cpu_lapicid(cpunum), 0, 0);
    } else {
        KERN_ASSERT(irq < 16);
  101663:	89 f0                	mov    %esi,%eax
  101665:	3c 0f                	cmp    $0xf,%al
  101667:	0f 87 83 00 00 00    	ja     1016f0 <intr_enable+0xc0>
        pic_enable(irq);
  10166d:	89 f0                	mov    %esi,%eax
  10166f:	0f b6 f0             	movzbl %al,%esi
  101672:	89 74 24 20          	mov    %esi,0x20(%esp)
    }
}
  101676:	83 c4 14             	add    $0x14,%esp
  101679:	5b                   	pop    %ebx
  10167a:	5e                   	pop    %esi
    if (using_apic == TRUE) {
        ioapic_enable(irq, (cpunum == 0xff) ?
                          0xff : pcpu_cpu_lapicid(cpunum), 0, 0);
    } else {
        KERN_ASSERT(irq < 16);
        pic_enable(irq);
  10167b:	e9 20 03 00 00       	jmp    1019a0 <pic_enable>

    if (irq >= 24)
        return;

    if (using_apic == TRUE) {
        ioapic_enable(irq, (cpunum == 0xff) ?
  101680:	81 fb ff 00 00 00    	cmp    $0xff,%ebx
  101686:	b8 ff 00 00 00       	mov    $0xff,%eax
  10168b:	74 0b                	je     101698 <intr_enable+0x68>
                          0xff : pcpu_cpu_lapicid(cpunum), 0, 0);
  10168d:	89 1c 24             	mov    %ebx,(%esp)
  101690:	e8 1b 1f 00 00       	call   1035b0 <pcpu_cpu_lapicid>

    if (irq >= 24)
        return;

    if (using_apic == TRUE) {
        ioapic_enable(irq, (cpunum == 0xff) ?
  101695:	0f b6 c0             	movzbl %al,%eax
  101698:	89 44 24 04          	mov    %eax,0x4(%esp)
  10169c:	89 f0                	mov    %esi,%eax
  10169e:	0f b6 f0             	movzbl %al,%esi
  1016a1:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1016a8:	00 
  1016a9:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  1016b0:	00 
  1016b1:	89 34 24             	mov    %esi,(%esp)
  1016b4:	e8 b7 12 00 00       	call   102970 <ioapic_enable>
                          0xff : pcpu_cpu_lapicid(cpunum), 0, 0);
    } else {
        KERN_ASSERT(irq < 16);
        pic_enable(irq);
    }
}
  1016b9:	83 c4 14             	add    $0x14,%esp
  1016bc:	5b                   	pop    %ebx
  1016bd:	5e                   	pop    %esi
  1016be:	c3                   	ret    
  1016bf:	90                   	nop
}

void
intr_enable(uint8_t irq, int cpunum)
{
    KERN_ASSERT(cpunum == 0xff || (0 <= cpunum && cpunum < pcpu_ncpu()));
  1016c0:	c7 44 24 0c d8 af 10 	movl   $0x10afd8,0xc(%esp)
  1016c7:	00 
  1016c8:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  1016cf:	00 
  1016d0:	c7 44 24 04 6f 00 00 	movl   $0x6f,0x4(%esp)
  1016d7:	00 
  1016d8:	c7 04 24 bc af 10 00 	movl   $0x10afbc,(%esp)
  1016df:	e8 9c 2a 00 00       	call   104180 <debug_panic>
  1016e4:	e9 69 ff ff ff       	jmp    101652 <intr_enable+0x22>
  1016e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    if (using_apic == TRUE) {
        ioapic_enable(irq, (cpunum == 0xff) ?
                          0xff : pcpu_cpu_lapicid(cpunum), 0, 0);
    } else {
        KERN_ASSERT(irq < 16);
  1016f0:	c7 44 24 0c cc af 10 	movl   $0x10afcc,0xc(%esp)
  1016f7:	00 
  1016f8:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  1016ff:	00 
  101700:	c7 44 24 04 78 00 00 	movl   $0x78,0x4(%esp)
  101707:	00 
  101708:	c7 04 24 bc af 10 00 	movl   $0x10afbc,(%esp)
  10170f:	e8 6c 2a 00 00       	call   104180 <debug_panic>
  101714:	e9 54 ff ff ff       	jmp    10166d <intr_enable+0x3d>
  101719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00101720 <intr_enable_lapicid>:
    }
}

void
intr_enable_lapicid(uint8_t irq, int lapic_id)
{
  101720:	53                   	push   %ebx
  101721:	83 ec 18             	sub    $0x18,%esp
  101724:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  101728:	8b 54 24 24          	mov    0x24(%esp),%edx
    if (irq > 24)
  10172c:	80 fb 18             	cmp    $0x18,%bl
  10172f:	77 4f                	ja     101780 <intr_enable_lapicid+0x60>
        return;

    if (using_apic == TRUE) {
  101731:	0f b6 05 61 fe 13 00 	movzbl 0x13fe61,%eax
  101738:	3c 01                	cmp    $0x1,%al
  10173a:	74 1c                	je     101758 <intr_enable_lapicid+0x38>
        ioapic_enable(irq, (lapic_id == 0xff) ?
                          0xff : lapic_id, 0, 0);
    } else {
        KERN_ASSERT(irq < 16);
  10173c:	80 fb 0f             	cmp    $0xf,%bl
  10173f:	77 47                	ja     101788 <intr_enable_lapicid+0x68>
        pic_enable(irq);
  101741:	0f b6 db             	movzbl %bl,%ebx
  101744:	89 5c 24 20          	mov    %ebx,0x20(%esp)
    }
}
  101748:	83 c4 18             	add    $0x18,%esp
  10174b:	5b                   	pop    %ebx
    if (using_apic == TRUE) {
        ioapic_enable(irq, (lapic_id == 0xff) ?
                          0xff : lapic_id, 0, 0);
    } else {
        KERN_ASSERT(irq < 16);
        pic_enable(irq);
  10174c:	e9 4f 02 00 00       	jmp    1019a0 <pic_enable>
  101751:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
    if (irq > 24)
        return;

    if (using_apic == TRUE) {
        ioapic_enable(irq, (lapic_id == 0xff) ?
  101758:	0f b6 d2             	movzbl %dl,%edx
  10175b:	0f b6 db             	movzbl %bl,%ebx
  10175e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  101765:	00 
  101766:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  10176d:	00 
  10176e:	89 54 24 04          	mov    %edx,0x4(%esp)
  101772:	89 1c 24             	mov    %ebx,(%esp)
  101775:	e8 f6 11 00 00       	call   102970 <ioapic_enable>
  10177a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                          0xff : lapic_id, 0, 0);
    } else {
        KERN_ASSERT(irq < 16);
        pic_enable(irq);
    }
}
  101780:	83 c4 18             	add    $0x18,%esp
  101783:	5b                   	pop    %ebx
  101784:	c3                   	ret    
  101785:	8d 76 00             	lea    0x0(%esi),%esi

    if (using_apic == TRUE) {
        ioapic_enable(irq, (lapic_id == 0xff) ?
                          0xff : lapic_id, 0, 0);
    } else {
        KERN_ASSERT(irq < 16);
  101788:	c7 44 24 0c cc af 10 	movl   $0x10afcc,0xc(%esp)
  10178f:	00 
        pic_enable(irq);
  101790:	0f b6 db             	movzbl %bl,%ebx

    if (using_apic == TRUE) {
        ioapic_enable(irq, (lapic_id == 0xff) ?
                          0xff : lapic_id, 0, 0);
    } else {
        KERN_ASSERT(irq < 16);
  101793:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  10179a:	00 
  10179b:	c7 44 24 04 87 00 00 	movl   $0x87,0x4(%esp)
  1017a2:	00 
  1017a3:	c7 04 24 bc af 10 00 	movl   $0x10afbc,(%esp)
  1017aa:	e8 d1 29 00 00       	call   104180 <debug_panic>
        pic_enable(irq);
  1017af:	89 5c 24 20          	mov    %ebx,0x20(%esp)
    }
}
  1017b3:	83 c4 18             	add    $0x18,%esp
  1017b6:	5b                   	pop    %ebx
    if (using_apic == TRUE) {
        ioapic_enable(irq, (lapic_id == 0xff) ?
                          0xff : lapic_id, 0, 0);
    } else {
        KERN_ASSERT(irq < 16);
        pic_enable(irq);
  1017b7:	e9 e4 01 00 00       	jmp    1019a0 <pic_enable>
  1017bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001017c0 <intr_eoi>:
}

void
intr_eoi(void)
{
  if (using_apic == TRUE)
  1017c0:	0f b6 05 61 fe 13 00 	movzbl 0x13fe61,%eax
  1017c7:	3c 01                	cmp    $0x1,%al
  1017c9:	74 05                	je     1017d0 <intr_eoi+0x10>
    lapic_eoi();
  else
	  pic_eoi();
  1017cb:	e9 f0 01 00 00       	jmp    1019c0 <pic_eoi>

void
intr_eoi(void)
{
  if (using_apic == TRUE)
    lapic_eoi();
  1017d0:	e9 5b 0e 00 00       	jmp    102630 <lapic_eoi>
  1017d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1017d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001017e0 <intr_local_enable>:
}

void
intr_local_enable(void)
{
	sti();
  1017e0:	e9 1b 36 00 00       	jmp    104e00 <sti>
  1017e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1017e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001017f0 <intr_local_disable>:
}

void
intr_local_disable(void)
{
	cli();
  1017f0:	e9 fb 35 00 00       	jmp    104df0 <cli>
  1017f5:	66 90                	xchg   %ax,%ax
  1017f7:	66 90                	xchg   %ax,%ax
  1017f9:	66 90                	xchg   %ax,%ax
  1017fb:	66 90                	xchg   %ax,%ax
  1017fd:	66 90                	xchg   %ax,%ax
  1017ff:	90                   	nop

00101800 <pic_init>:

/* Initialize the 8259A interrupt controllers. */
void
pic_init(void)
{
	if (pic_inited == TRUE)		// only do once on bootstrap CPU
  101800:	80 3d 62 fe 13 00 01 	cmpb   $0x1,0x13fe62
  101807:	0f 84 4d 01 00 00    	je     10195a <pic_init+0x15a>
static bool pic_inited = FALSE;

/* Initialize the 8259A interrupt controllers. */
void
pic_init(void)
{
  10180d:	83 ec 1c             	sub    $0x1c,%esp
	if (pic_inited == TRUE)		// only do once on bootstrap CPU
		return;
	pic_inited = TRUE;

	/* mask all interrupts */
	outb(IO_PIC1+1, 0xff);
  101810:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
  101817:	00 
  101818:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
void
pic_init(void)
{
	if (pic_inited == TRUE)		// only do once on bootstrap CPU
		return;
	pic_inited = TRUE;
  10181f:	c6 05 62 fe 13 00 01 	movb   $0x1,0x13fe62

	/* mask all interrupts */
	outb(IO_PIC1+1, 0xff);
  101826:	e8 35 38 00 00       	call   105060 <outb>
	outb(IO_PIC2+1, 0xff);
  10182b:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
  101832:	00 
  101833:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  10183a:	e8 21 38 00 00       	call   105060 <outb>

	// ICW1:  0001g0hi
	//    g:  0 = edge triggering, 1 = level triggering
	//    h:  0 = cascaded PICs, 1 = master only
	//    i:  0 = no ICW4, 1 = ICW4 required
	outb(IO_PIC1, 0x11);
  10183f:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
  101846:	00 
  101847:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10184e:	e8 0d 38 00 00       	call   105060 <outb>

	// ICW2:  Vector offset
	outb(IO_PIC1+1, T_IRQ0);
  101853:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  10185a:	00 
  10185b:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  101862:	e8 f9 37 00 00       	call   105060 <outb>

	// ICW3:  bit mask of IR lines connected to slave PICs (master PIC),
	//        3-bit No of IR line at which slave connects to master(slave PIC).
	outb(IO_PIC1+1, 1<<IRQ_SLAVE);
  101867:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
  10186e:	00 
  10186f:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  101876:	e8 e5 37 00 00       	call   105060 <outb>
	//    m:  0 = slave PIC, 1 = master PIC
	//	  (ignored when b is 0, as the master/slave role
	//	  can be hardwired).
	//    a:  1 = Automatic EOI mode
	//    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
	outb(IO_PIC1+1, 0x1);
  10187b:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  101882:	00 
  101883:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  10188a:	e8 d1 37 00 00       	call   105060 <outb>

	// Set up slave (8259A-2)
	outb(IO_PIC2, 0x11);			// ICW1
  10188f:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
  101896:	00 
  101897:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
  10189e:	e8 bd 37 00 00       	call   105060 <outb>
	outb(IO_PIC2+1, T_IRQ0 + 8);		// ICW2
  1018a3:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
  1018aa:	00 
  1018ab:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  1018b2:	e8 a9 37 00 00       	call   105060 <outb>
	outb(IO_PIC2+1, IRQ_SLAVE);		// ICW3
  1018b7:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  1018be:	00 
  1018bf:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  1018c6:	e8 95 37 00 00       	call   105060 <outb>
	// NB Automatic EOI mode doesn't tend to work on the slave.
	// Linux source code says it's "to be investigated".
	outb(IO_PIC2+1, 0x01);			// ICW4
  1018cb:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1018d2:	00 
  1018d3:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  1018da:	e8 81 37 00 00       	call   105060 <outb>

	// OCW3:  0ef01prs
	//   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
	//    p:  0 = no polling, 1 = polling mode
	//   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
	outb(IO_PIC1, 0x68);             /* clear specific mask */
  1018df:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
  1018e6:	00 
  1018e7:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1018ee:	e8 6d 37 00 00       	call   105060 <outb>
	outb(IO_PIC1, 0x0a);             /* read IRR by default */
  1018f3:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
  1018fa:	00 
  1018fb:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  101902:	e8 59 37 00 00       	call   105060 <outb>

	outb(IO_PIC2, 0x68);               /* OCW3 */
  101907:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
  10190e:	00 
  10190f:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
  101916:	e8 45 37 00 00       	call   105060 <outb>
	outb(IO_PIC2, 0x0a);               /* OCW3 */
  10191b:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
  101922:	00 
  101923:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
  10192a:	e8 31 37 00 00       	call   105060 <outb>

	// mask all interrupts
	outb(IO_PIC1+1, 0xFF);
  10192f:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
  101936:	00 
  101937:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  10193e:	e8 1d 37 00 00       	call   105060 <outb>
	outb(IO_PIC2+1, 0xFF);
  101943:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
  10194a:	00 
  10194b:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  101952:	e8 09 37 00 00       	call   105060 <outb>
}
  101957:	83 c4 1c             	add    $0x1c,%esp
  10195a:	f3 c3                	repz ret 
  10195c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00101960 <pic_setmask>:

void
pic_setmask(uint16_t mask)
{
  101960:	53                   	push   %ebx
  101961:	83 ec 18             	sub    $0x18,%esp
  101964:	8b 5c 24 20          	mov    0x20(%esp),%ebx
	irqmask = mask;
	outb(IO_PIC1+1, (char)mask);
  101968:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  10196f:	0f b6 c3             	movzbl %bl,%eax
  101972:	89 44 24 04          	mov    %eax,0x4(%esp)
}

void
pic_setmask(uint16_t mask)
{
	irqmask = mask;
  101976:	66 89 1d 06 03 11 00 	mov    %bx,0x110306
	outb(IO_PIC1+1, (char)mask);
	outb(IO_PIC2+1, (char)(mask >> 8));
  10197d:	0f b6 df             	movzbl %bh,%ebx

void
pic_setmask(uint16_t mask)
{
	irqmask = mask;
	outb(IO_PIC1+1, (char)mask);
  101980:	e8 db 36 00 00       	call   105060 <outb>
	outb(IO_PIC2+1, (char)(mask >> 8));
  101985:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  101989:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  101990:	e8 cb 36 00 00       	call   105060 <outb>
}
  101995:	83 c4 18             	add    $0x18,%esp
  101998:	5b                   	pop    %ebx
  101999:	c3                   	ret    
  10199a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001019a0 <pic_enable>:

void
pic_enable(int irq)
{
	pic_setmask(irqmask & ~(1 << irq));
  1019a0:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1019a4:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
  1019a9:	d3 c0                	rol    %cl,%eax
  1019ab:	66 23 05 06 03 11 00 	and    0x110306,%ax
  1019b2:	0f b7 c0             	movzwl %ax,%eax
  1019b5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1019b9:	eb a5                	jmp    101960 <pic_setmask>
  1019bb:	90                   	nop
  1019bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001019c0 <pic_eoi>:
}

void
pic_eoi(void)
{
  1019c0:	83 ec 1c             	sub    $0x1c,%esp
	// OCW2: rse00xxx
	//   r: rotate
	//   s: specific
	//   e: end-of-interrupt
	// xxx: specific interrupt line
	outb(IO_PIC1, 0x20);
  1019c3:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  1019ca:	00 
  1019cb:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1019d2:	e8 89 36 00 00       	call   105060 <outb>
	outb(IO_PIC2, 0x20);
  1019d7:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  1019de:	00 
  1019df:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
  1019e6:	e8 75 36 00 00       	call   105060 <outb>
}
  1019eb:	83 c4 1c             	add    $0x1c,%esp
  1019ee:	c3                   	ret    
  1019ef:	90                   	nop

001019f0 <pic_reset>:

void
pic_reset(void)
{
  1019f0:	83 ec 1c             	sub    $0x1c,%esp
	// mask all interrupts
	outb(IO_PIC1+1, 0x00);
  1019f3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1019fa:	00 
  1019fb:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  101a02:	e8 59 36 00 00       	call   105060 <outb>
	outb(IO_PIC2+1, 0x00);
  101a07:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  101a0e:	00 
  101a0f:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  101a16:	e8 45 36 00 00       	call   105060 <outb>

	// ICW1:  0001g0hi
	//    g:  0 = edge triggering, 1 = level triggering
	//    h:  0 = cascaded PICs, 1 = master only
	//    i:  0 = no ICW4, 1 = ICW4 required
	outb(IO_PIC1, 0x11);
  101a1b:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
  101a22:	00 
  101a23:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  101a2a:	e8 31 36 00 00       	call   105060 <outb>

	// ICW2:  Vector offset
	outb(IO_PIC1+1, T_IRQ0);
  101a2f:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  101a36:	00 
  101a37:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  101a3e:	e8 1d 36 00 00       	call   105060 <outb>

	// ICW3:  bit mask of IR lines connected to slave PICs (master PIC),
	//        3-bit No of IR line at which slave connects to master(slave PIC).
	outb(IO_PIC1+1, 1<<IRQ_SLAVE);
  101a43:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
  101a4a:	00 
  101a4b:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  101a52:	e8 09 36 00 00       	call   105060 <outb>
	//    m:  0 = slave PIC, 1 = master PIC
	//	  (ignored when b is 0, as the master/slave role
	//	  can be hardwired).
	//    a:  1 = Automatic EOI mode
	//    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
	outb(IO_PIC1+1, 0x3);
  101a57:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
  101a5e:	00 
  101a5f:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  101a66:	e8 f5 35 00 00       	call   105060 <outb>

	// Set up slave (8259A-2)
	outb(IO_PIC2, 0x11);			// ICW1
  101a6b:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
  101a72:	00 
  101a73:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
  101a7a:	e8 e1 35 00 00       	call   105060 <outb>
	outb(IO_PIC2+1, T_IRQ0 + 8);		// ICW2
  101a7f:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
  101a86:	00 
  101a87:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  101a8e:	e8 cd 35 00 00       	call   105060 <outb>
	outb(IO_PIC2+1, IRQ_SLAVE);		// ICW3
  101a93:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  101a9a:	00 
  101a9b:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  101aa2:	e8 b9 35 00 00       	call   105060 <outb>
	// NB Automatic EOI mode doesn't tend to work on the slave.
	// Linux source code says it's "to be investigated".
	outb(IO_PIC2+1, 0x01);			// ICW4
  101aa7:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  101aae:	00 
  101aaf:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  101ab6:	e8 a5 35 00 00       	call   105060 <outb>

	// OCW3:  0ef01prs
	//   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
	//    p:  0 = no polling, 1 = polling mode
	//   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
	outb(IO_PIC1, 0x68);             /* clear specific mask */
  101abb:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
  101ac2:	00 
  101ac3:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  101aca:	e8 91 35 00 00       	call   105060 <outb>
	outb(IO_PIC1, 0x0a);             /* read IRR by default */
  101acf:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
  101ad6:	00 
  101ad7:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  101ade:	e8 7d 35 00 00       	call   105060 <outb>

	outb(IO_PIC2, 0x68);               /* OCW3 */
  101ae3:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
  101aea:	00 
  101aeb:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
  101af2:	e8 69 35 00 00       	call   105060 <outb>
	outb(IO_PIC2, 0x0a);               /* OCW3 */
  101af7:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
  101afe:	00 
  101aff:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
  101b06:	e8 55 35 00 00       	call   105060 <outb>
}
  101b0b:	83 c4 1c             	add    $0x1c,%esp
  101b0e:	c3                   	ret    
  101b0f:	90                   	nop

00101b10 <timer_hw_init>:

// Initialize the programmable interval timer.

void
timer_hw_init(void)
{
  101b10:	83 ec 1c             	sub    $0x1c,%esp
	outb(PIT_CONTROL, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  101b13:	c7 44 24 04 34 00 00 	movl   $0x34,0x4(%esp)
  101b1a:	00 
  101b1b:	c7 04 24 43 00 00 00 	movl   $0x43,(%esp)
  101b22:	e8 39 35 00 00       	call   105060 <outb>
	outb(PIT_CHANNEL0, LOW8(LATCH));
  101b27:	c7 44 24 04 9c 00 00 	movl   $0x9c,0x4(%esp)
  101b2e:	00 
  101b2f:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
  101b36:	e8 25 35 00 00       	call   105060 <outb>
	outb(PIT_CHANNEL0, HIGH8(LATCH));
  101b3b:	c7 44 24 04 2e 00 00 	movl   $0x2e,0x4(%esp)
  101b42:	00 
  101b43:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
  101b4a:	e8 11 35 00 00       	call   105060 <outb>
}
  101b4f:	83 c4 1c             	add    $0x1c,%esp
  101b52:	c3                   	ret    
  101b53:	66 90                	xchg   %ax,%ax
  101b55:	66 90                	xchg   %ax,%ax
  101b57:	66 90                	xchg   %ax,%ax
  101b59:	66 90                	xchg   %ax,%ax
  101b5b:	66 90                	xchg   %ax,%ax
  101b5d:	66 90                	xchg   %ax,%ax
  101b5f:	90                   	nop

00101b60 <tsc_init>:
	return delta / ms;
}

int
tsc_init(void)
{
  101b60:	55                   	push   %ebp
  101b61:	57                   	push   %edi
  101b62:	56                   	push   %esi
  101b63:	53                   	push   %ebx
  101b64:	83 ec 4c             	sub    $0x4c,%esp
	uint64_t ret;
	int i;

	timer_hw_init();
  101b67:	e8 a4 ff ff ff       	call   101b10 <timer_hw_init>

	tsc_per_ms = 0;
  101b6c:	c7 05 00 b8 9c 00 00 	movl   $0x0,0x9cb800
  101b73:	00 00 00 

	/*
	 * XXX: If TSC calibration fails frequently, try to increase the
	 *      upperbound of loop condition, e.g. alternating 3 to 10.
	 */
	for (i = 0; i < 10; i++) {
  101b76:	c7 44 24 34 00 00 00 	movl   $0x0,0x34(%esp)
  101b7d:	00 
	uint64_t ret;
	int i;

	timer_hw_init();

	tsc_per_ms = 0;
  101b7e:	c7 05 04 b8 9c 00 00 	movl   $0x0,0x9cb804
  101b85:	00 00 00 
{
	uint64_t tsc, t1, t2, delta, tscmin, tscmax;;
	int pitcnt;

	/* Set the Gate high, disable speaker */
	outb(0x61, (inb(0x61) & ~0x02) | 0x01);
  101b88:	c7 04 24 61 00 00 00 	movl   $0x61,(%esp)
	outb(0x42, latch & 0xff);
	outb(0x42, latch >> 8);

	tsc = t1 = t2 = rdtsc();

	pitcnt = 0;
  101b8f:	31 ff                	xor    %edi,%edi
	tscmax = 0;
  101b91:	31 ed                	xor    %ebp,%ebp
{
	uint64_t tsc, t1, t2, delta, tscmin, tscmax;;
	int pitcnt;

	/* Set the Gate high, disable speaker */
	outb(0x61, (inb(0x61) & ~0x02) | 0x01);
  101b93:	e8 98 34 00 00       	call   105030 <inb>
  101b98:	c7 04 24 61 00 00 00 	movl   $0x61,(%esp)
  101b9f:	25 fc 00 00 00       	and    $0xfc,%eax
  101ba4:	83 c8 01             	or     $0x1,%eax
  101ba7:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bab:	e8 b0 34 00 00       	call   105060 <outb>
	/*
	 * Setup CTC channel 2 for mode 0, (interrupt on terminal
	 * count mode), binary count. Set the latch register to 50ms
	 * (LSB then MSB) to begin countdown.
	 */
	outb(0x43, 0xb0);
  101bb0:	c7 44 24 04 b0 00 00 	movl   $0xb0,0x4(%esp)
  101bb7:	00 
  101bb8:	c7 04 24 43 00 00 00 	movl   $0x43,(%esp)
  101bbf:	e8 9c 34 00 00       	call   105060 <outb>
	outb(0x42, latch & 0xff);
  101bc4:	c7 44 24 04 9b 00 00 	movl   $0x9b,0x4(%esp)
  101bcb:	00 
  101bcc:	c7 04 24 42 00 00 00 	movl   $0x42,(%esp)
  101bd3:	e8 88 34 00 00       	call   105060 <outb>
	outb(0x42, latch >> 8);
  101bd8:	c7 44 24 04 2e 00 00 	movl   $0x2e,0x4(%esp)
  101bdf:	00 
  101be0:	c7 04 24 42 00 00 00 	movl   $0x42,(%esp)
  101be7:	e8 74 34 00 00       	call   105060 <outb>

	tsc = t1 = t2 = rdtsc();
  101bec:	e8 6f 32 00 00       	call   104e60 <rdtsc>

	pitcnt = 0;
	tscmax = 0;
  101bf1:	c7 44 24 30 00 00 00 	movl   $0x0,0x30(%esp)
  101bf8:	00 
	tscmin = ~(uint64_t) 0x0;
  101bf9:	c7 44 24 2c ff ff ff 	movl   $0xffffffff,0x2c(%esp)
  101c00:	ff 
  101c01:	c7 44 24 24 ff ff ff 	movl   $0xffffffff,0x24(%esp)
  101c08:	ff 
	 */
	outb(0x43, 0xb0);
	outb(0x42, latch & 0xff);
	outb(0x42, latch >> 8);

	tsc = t1 = t2 = rdtsc();
  101c09:	89 c3                	mov    %eax,%ebx
  101c0b:	89 44 24 38          	mov    %eax,0x38(%esp)
  101c0f:	89 f8                	mov    %edi,%eax
  101c11:	89 de                	mov    %ebx,%esi
  101c13:	89 54 24 3c          	mov    %edx,0x3c(%esp)
  101c17:	89 d7                	mov    %edx,%edi
  101c19:	89 44 24 28          	mov    %eax,0x28(%esp)
  101c1d:	eb 43                	jmp    101c62 <tsc_init+0x102>
  101c1f:	90                   	nop

	pitcnt = 0;
	tscmax = 0;
	tscmin = ~(uint64_t) 0x0;
	while ((inb(0x61) & 0x20) == 0) {
		t2 = rdtsc();
  101c20:	e8 3b 32 00 00       	call   104e60 <rdtsc>
		delta = t2 - tsc;
  101c25:	89 c1                	mov    %eax,%ecx
  101c27:	89 d3                	mov    %edx,%ebx
  101c29:	29 f1                	sub    %esi,%ecx
  101c2b:	19 fb                	sbb    %edi,%ebx
  101c2d:	89 ce                	mov    %ecx,%esi
  101c2f:	39 5c 24 24          	cmp    %ebx,0x24(%esp)
  101c33:	89 df                	mov    %ebx,%edi
  101c35:	72 10                	jb     101c47 <tsc_init+0xe7>
  101c37:	77 06                	ja     101c3f <tsc_init+0xdf>
  101c39:	39 4c 24 2c          	cmp    %ecx,0x2c(%esp)
  101c3d:	76 08                	jbe    101c47 <tsc_init+0xe7>
  101c3f:	89 74 24 2c          	mov    %esi,0x2c(%esp)
  101c43:	89 7c 24 24          	mov    %edi,0x24(%esp)
  101c47:	39 fd                	cmp    %edi,%ebp
  101c49:	77 0e                	ja     101c59 <tsc_init+0xf9>
  101c4b:	72 06                	jb     101c53 <tsc_init+0xf3>
  101c4d:	39 74 24 30          	cmp    %esi,0x30(%esp)
  101c51:	73 06                	jae    101c59 <tsc_init+0xf9>
  101c53:	89 74 24 30          	mov    %esi,0x30(%esp)
  101c57:	89 fd                	mov    %edi,%ebp
		tsc = t2;
		if (delta < tscmin)
			tscmin = delta;
		if (delta > tscmax)
			tscmax = delta;
		pitcnt++;
  101c59:	83 44 24 28 01       	addl   $0x1,0x28(%esp)
	tscmax = 0;
	tscmin = ~(uint64_t) 0x0;
	while ((inb(0x61) & 0x20) == 0) {
		t2 = rdtsc();
		delta = t2 - tsc;
		tsc = t2;
  101c5e:	89 c6                	mov    %eax,%esi
  101c60:	89 d7                	mov    %edx,%edi
	tsc = t1 = t2 = rdtsc();

	pitcnt = 0;
	tscmax = 0;
	tscmin = ~(uint64_t) 0x0;
	while ((inb(0x61) & 0x20) == 0) {
  101c62:	c7 04 24 61 00 00 00 	movl   $0x61,(%esp)
  101c69:	e8 c2 33 00 00       	call   105030 <inb>
  101c6e:	a8 20                	test   $0x20,%al
  101c70:	74 ae                	je     101c20 <tsc_init+0xc0>
  101c72:	8b 44 24 28          	mov    0x28(%esp),%eax
  101c76:	89 f3                	mov    %esi,%ebx
  101c78:	89 fe                	mov    %edi,%esi
	 * times, then we have been hit by a massive SMI
	 *
	 * If the maximum is 10 times larger than the minimum,
	 * then we got hit by an SMI as well.
	 */
	KERN_DEBUG("pitcnt=%u, tscmin=%llu, tscmax=%llu\n",
  101c7a:	89 6c 24 1c          	mov    %ebp,0x1c(%esp)
  101c7e:	c7 44 24 08 10 b0 10 	movl   $0x10b010,0x8(%esp)
  101c85:	00 
  101c86:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
  101c8d:	00 
  101c8e:	89 c7                	mov    %eax,%edi
  101c90:	8b 44 24 30          	mov    0x30(%esp),%eax
  101c94:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  101c98:	c7 04 24 35 b0 10 00 	movl   $0x10b035,(%esp)
  101c9f:	89 44 24 18          	mov    %eax,0x18(%esp)
  101ca3:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  101ca7:	89 44 24 10          	mov    %eax,0x10(%esp)
  101cab:	8b 44 24 24          	mov    0x24(%esp),%eax
  101caf:	89 44 24 14          	mov    %eax,0x14(%esp)
  101cb3:	e8 78 24 00 00       	call   104130 <debug_normal>
		   pitcnt, tscmin, tscmax);
	if (pitcnt < loopmin || tscmax > 10 * tscmin)
  101cb8:	81 ff e7 03 00 00    	cmp    $0x3e7,%edi
  101cbe:	0f 8f 94 00 00 00    	jg     101d58 <tsc_init+0x1f8>
	 */
	for (i = 0; i < 10; i++) {
		ret = tsc_calibrate(CAL_LATCH, CAL_MS, CAL_PIT_LOOPS);
		if (ret != ~(uint64_t) 0x0)
			break;
		KERN_DEBUG("[%d] Retry to calibrate TSC.\n", i+1);
  101cc4:	83 44 24 34 01       	addl   $0x1,0x34(%esp)
  101cc9:	8b 7c 24 34          	mov    0x34(%esp),%edi
  101ccd:	c7 44 24 08 8c b0 10 	movl   $0x10b08c,0x8(%esp)
  101cd4:	00 
  101cd5:	c7 44 24 04 55 00 00 	movl   $0x55,0x4(%esp)
  101cdc:	00 
  101cdd:	c7 04 24 35 b0 10 00 	movl   $0x10b035,(%esp)
  101ce4:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  101ce8:	e8 43 24 00 00       	call   104130 <debug_normal>

	/*
	 * XXX: If TSC calibration fails frequently, try to increase the
	 *      upperbound of loop condition, e.g. alternating 3 to 10.
	 */
	for (i = 0; i < 10; i++) {
  101ced:	83 ff 0a             	cmp    $0xa,%edi
  101cf0:	0f 85 92 fe ff ff    	jne    101b88 <tsc_init+0x28>
			break;
		KERN_DEBUG("[%d] Retry to calibrate TSC.\n", i+1);
	}

	if (ret == ~(uint64_t) 0x0) {
		KERN_DEBUG("TSC calibration failed.\n");
  101cf6:	c7 44 24 08 59 b0 10 	movl   $0x10b059,0x8(%esp)
  101cfd:	00 
  101cfe:	c7 44 24 04 59 00 00 	movl   $0x59,0x4(%esp)
  101d05:	00 
  101d06:	c7 04 24 35 b0 10 00 	movl   $0x10b035,(%esp)
  101d0d:	e8 1e 24 00 00       	call   104130 <debug_normal>
		KERN_DEBUG("Assume TSC freq = 1 GHz.\n");
  101d12:	c7 44 24 08 72 b0 10 	movl   $0x10b072,0x8(%esp)
  101d19:	00 
  101d1a:	c7 44 24 04 5a 00 00 	movl   $0x5a,0x4(%esp)
  101d21:	00 
  101d22:	c7 04 24 35 b0 10 00 	movl   $0x10b035,(%esp)
  101d29:	e8 02 24 00 00       	call   104130 <debug_normal>
		tsc_per_ms = 1000000;
  101d2e:	c7 05 00 b8 9c 00 40 	movl   $0xf4240,0x9cb800
  101d35:	42 0f 00 
  101d38:	c7 05 04 b8 9c 00 00 	movl   $0x0,0x9cb804
  101d3f:	00 00 00 

		timer_hw_init();
  101d42:	e8 c9 fd ff ff       	call   101b10 <timer_hw_init>
		KERN_DEBUG("TSC freq = %llu Hz.\n", tsc_per_ms*1000);

		timer_hw_init();
		return 0;
	}
}
  101d47:	83 c4 4c             	add    $0x4c,%esp
		KERN_DEBUG("TSC calibration failed.\n");
		KERN_DEBUG("Assume TSC freq = 1 GHz.\n");
		tsc_per_ms = 1000000;

		timer_hw_init();
		return 1;
  101d4a:	b8 01 00 00 00       	mov    $0x1,%eax
		KERN_DEBUG("TSC freq = %llu Hz.\n", tsc_per_ms*1000);

		timer_hw_init();
		return 0;
	}
}
  101d4f:	5b                   	pop    %ebx
  101d50:	5e                   	pop    %esi
  101d51:	5f                   	pop    %edi
  101d52:	5d                   	pop    %ebp
  101d53:	c3                   	ret    
  101d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	 * If the maximum is 10 times larger than the minimum,
	 * then we got hit by an SMI as well.
	 */
	KERN_DEBUG("pitcnt=%u, tscmin=%llu, tscmax=%llu\n",
		   pitcnt, tscmin, tscmax);
	if (pitcnt < loopmin || tscmax > 10 * tscmin)
  101d58:	6b 7c 24 24 0a       	imul   $0xa,0x24(%esp),%edi
  101d5d:	b8 0a 00 00 00       	mov    $0xa,%eax
  101d62:	f7 64 24 2c          	mull   0x2c(%esp)
  101d66:	01 fa                	add    %edi,%edx
  101d68:	39 d5                	cmp    %edx,%ebp
  101d6a:	0f 87 54 ff ff ff    	ja     101cc4 <tsc_init+0x164>
  101d70:	72 0a                	jb     101d7c <tsc_init+0x21c>
  101d72:	39 44 24 30          	cmp    %eax,0x30(%esp)
  101d76:	0f 87 48 ff ff ff    	ja     101cc4 <tsc_init+0x164>
		return ~(uint64_t) 0x0;

	/* Calculate the PIT value */
	delta = t2 - t1;
  101d7c:	89 d8                	mov    %ebx,%eax
  101d7e:	89 f2                	mov    %esi,%edx
  101d80:	2b 44 24 38          	sub    0x38(%esp),%eax
  101d84:	1b 54 24 3c          	sbb    0x3c(%esp),%edx
	return delta / ms;
  101d88:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
  101d8f:	00 
  101d90:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  101d97:	00 
  101d98:	89 04 24             	mov    %eax,(%esp)
  101d9b:	89 54 24 04          	mov    %edx,0x4(%esp)
  101d9f:	e8 2c 8b 00 00       	call   10a8d0 <__udivdi3>

		timer_hw_init();
		return 1;
	} else {
		tsc_per_ms = ret;
		KERN_DEBUG("TSC freq = %llu Hz.\n", tsc_per_ms*1000);
  101da4:	c7 44 24 08 44 b0 10 	movl   $0x10b044,0x8(%esp)
  101dab:	00 
  101dac:	c7 44 24 04 61 00 00 	movl   $0x61,0x4(%esp)
  101db3:	00 
  101db4:	c7 04 24 35 b0 10 00 	movl   $0x10b035,(%esp)
		tsc_per_ms = 1000000;

		timer_hw_init();
		return 1;
	} else {
		tsc_per_ms = ret;
  101dbb:	a3 00 b8 9c 00       	mov    %eax,0x9cb800
  101dc0:	89 15 04 b8 9c 00    	mov    %edx,0x9cb804
		KERN_DEBUG("TSC freq = %llu Hz.\n", tsc_per_ms*1000);
  101dc6:	a1 00 b8 9c 00       	mov    0x9cb800,%eax
  101dcb:	8b 15 04 b8 9c 00    	mov    0x9cb804,%edx
  101dd1:	69 ca e8 03 00 00    	imul   $0x3e8,%edx,%ecx
  101dd7:	ba e8 03 00 00       	mov    $0x3e8,%edx
  101ddc:	f7 e2                	mul    %edx
  101dde:	01 ca                	add    %ecx,%edx
  101de0:	89 44 24 0c          	mov    %eax,0xc(%esp)
  101de4:	89 54 24 10          	mov    %edx,0x10(%esp)
  101de8:	e8 43 23 00 00       	call   104130 <debug_normal>

		timer_hw_init();
  101ded:	e8 1e fd ff ff       	call   101b10 <timer_hw_init>
		return 0;
	}
}
  101df2:	83 c4 4c             	add    $0x4c,%esp
	} else {
		tsc_per_ms = ret;
		KERN_DEBUG("TSC freq = %llu Hz.\n", tsc_per_ms*1000);

		timer_hw_init();
		return 0;
  101df5:	31 c0                	xor    %eax,%eax
	}
}
  101df7:	5b                   	pop    %ebx
  101df8:	5e                   	pop    %esi
  101df9:	5f                   	pop    %edi
  101dfa:	5d                   	pop    %ebp
  101dfb:	c3                   	ret    
  101dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00101e00 <delay>:
/*
 * Wait for ms millisecond.
 */
void
delay(uint32_t ms)
{
  101e00:	57                   	push   %edi
  101e01:	56                   	push   %esi
  101e02:	53                   	push   %ebx
  101e03:	83 ec 10             	sub    $0x10,%esp
	volatile uint64_t ticks = tsc_per_ms * ms;
  101e06:	a1 00 b8 9c 00       	mov    0x9cb800,%eax
  101e0b:	8b 15 04 b8 9c 00    	mov    0x9cb804,%edx
/*
 * Wait for ms millisecond.
 */
void
delay(uint32_t ms)
{
  101e11:	8b 4c 24 20          	mov    0x20(%esp),%ecx
	volatile uint64_t ticks = tsc_per_ms * ms;
  101e15:	89 d3                	mov    %edx,%ebx
  101e17:	0f af d9             	imul   %ecx,%ebx
  101e1a:	f7 e1                	mul    %ecx
  101e1c:	01 da                	add    %ebx,%edx
  101e1e:	89 04 24             	mov    %eax,(%esp)
  101e21:	89 54 24 04          	mov    %edx,0x4(%esp)
	volatile uint64_t start = rdtsc();
  101e25:	e8 36 30 00 00       	call   104e60 <rdtsc>
  101e2a:	89 44 24 08          	mov    %eax,0x8(%esp)
  101e2e:	89 54 24 0c          	mov    %edx,0xc(%esp)
  101e32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	while (rdtsc() < start + ticks);
  101e38:	e8 23 30 00 00       	call   104e60 <rdtsc>
  101e3d:	8b 74 24 08          	mov    0x8(%esp),%esi
  101e41:	8b 7c 24 0c          	mov    0xc(%esp),%edi
  101e45:	8b 0c 24             	mov    (%esp),%ecx
  101e48:	8b 5c 24 04          	mov    0x4(%esp),%ebx
  101e4c:	01 f1                	add    %esi,%ecx
  101e4e:	11 fb                	adc    %edi,%ebx
  101e50:	39 da                	cmp    %ebx,%edx
  101e52:	76 0c                	jbe    101e60 <delay+0x60>
}
  101e54:	83 c4 10             	add    $0x10,%esp
  101e57:	5b                   	pop    %ebx
  101e58:	5e                   	pop    %esi
  101e59:	5f                   	pop    %edi
  101e5a:	c3                   	ret    
  101e5b:	90                   	nop
  101e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
void
delay(uint32_t ms)
{
	volatile uint64_t ticks = tsc_per_ms * ms;
	volatile uint64_t start = rdtsc();
	while (rdtsc() < start + ticks);
  101e60:	72 d6                	jb     101e38 <delay+0x38>
  101e62:	39 c8                	cmp    %ecx,%eax
  101e64:	72 d2                	jb     101e38 <delay+0x38>
}
  101e66:	83 c4 10             	add    $0x10,%esp
  101e69:	5b                   	pop    %ebx
  101e6a:	5e                   	pop    %esi
  101e6b:	5f                   	pop    %edi
  101e6c:	c3                   	ret    
  101e6d:	8d 76 00             	lea    0x0(%esi),%esi

00101e70 <udelay>:
/*
 * Wait for us microsecond.
 */
void
udelay(uint32_t us)
{
  101e70:	57                   	push   %edi
  101e71:	56                   	push   %esi
  101e72:	53                   	push   %ebx
  101e73:	83 ec 20             	sub    $0x20,%esp
    volatile uint64_t ticks = tsc_per_ms / 1000 * us;
  101e76:	8b 0d 00 b8 9c 00    	mov    0x9cb800,%ecx
  101e7c:	8b 1d 04 b8 9c 00    	mov    0x9cb804,%ebx
  101e82:	c7 44 24 08 e8 03 00 	movl   $0x3e8,0x8(%esp)
  101e89:	00 
/*
 * Wait for us microsecond.
 */
void
udelay(uint32_t us)
{
  101e8a:	8b 74 24 30          	mov    0x30(%esp),%esi
    volatile uint64_t ticks = tsc_per_ms / 1000 * us;
  101e8e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  101e95:	00 
  101e96:	89 0c 24             	mov    %ecx,(%esp)
  101e99:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  101e9d:	e8 2e 8a 00 00       	call   10a8d0 <__udivdi3>
  101ea2:	89 d1                	mov    %edx,%ecx
  101ea4:	0f af ce             	imul   %esi,%ecx
  101ea7:	f7 e6                	mul    %esi
  101ea9:	01 ca                	add    %ecx,%edx
  101eab:	89 44 24 10          	mov    %eax,0x10(%esp)
  101eaf:	89 54 24 14          	mov    %edx,0x14(%esp)
    volatile uint64_t start = rdtsc();
  101eb3:	e8 a8 2f 00 00       	call   104e60 <rdtsc>
  101eb8:	89 44 24 18          	mov    %eax,0x18(%esp)
  101ebc:	89 54 24 1c          	mov    %edx,0x1c(%esp)
    while (rdtsc() < start + ticks);
  101ec0:	e8 9b 2f 00 00       	call   104e60 <rdtsc>
  101ec5:	8b 74 24 18          	mov    0x18(%esp),%esi
  101ec9:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
  101ecd:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  101ed1:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  101ed5:	01 f1                	add    %esi,%ecx
  101ed7:	11 fb                	adc    %edi,%ebx
  101ed9:	39 da                	cmp    %ebx,%edx
  101edb:	76 0b                	jbe    101ee8 <udelay+0x78>
}
  101edd:	83 c4 20             	add    $0x20,%esp
  101ee0:	5b                   	pop    %ebx
  101ee1:	5e                   	pop    %esi
  101ee2:	5f                   	pop    %edi
  101ee3:	c3                   	ret    
  101ee4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
void
udelay(uint32_t us)
{
    volatile uint64_t ticks = tsc_per_ms / 1000 * us;
    volatile uint64_t start = rdtsc();
    while (rdtsc() < start + ticks);
  101ee8:	72 d6                	jb     101ec0 <udelay+0x50>
  101eea:	39 c8                	cmp    %ecx,%eax
  101eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101ef0:	72 ce                	jb     101ec0 <udelay+0x50>
}
  101ef2:	83 c4 20             	add    $0x20,%esp
  101ef5:	5b                   	pop    %ebx
  101ef6:	5e                   	pop    %esi
  101ef7:	5f                   	pop    %edi
  101ef8:	c3                   	ret    
  101ef9:	66 90                	xchg   %ax,%ax
  101efb:	66 90                	xchg   %ax,%ax
  101efd:	66 90                	xchg   %ax,%ax
  101eff:	90                   	nop

00101f00 <Xdivide>:
	jmp _alltraps

.text

/* exceptions  */
TRAPHANDLER_NOEC(Xdivide,	T_DIVIDE)
  101f00:	6a 00                	push   $0x0
  101f02:	6a 00                	push   $0x0
  101f04:	e9 17 01 00 00       	jmp    102020 <_alltraps>
  101f09:	90                   	nop

00101f0a <Xdebug>:
TRAPHANDLER_NOEC(Xdebug,	T_DEBUG)
  101f0a:	6a 00                	push   $0x0
  101f0c:	6a 01                	push   $0x1
  101f0e:	e9 0d 01 00 00       	jmp    102020 <_alltraps>
  101f13:	90                   	nop

00101f14 <Xnmi>:
TRAPHANDLER_NOEC(Xnmi,		T_NMI)
  101f14:	6a 00                	push   $0x0
  101f16:	6a 02                	push   $0x2
  101f18:	e9 03 01 00 00       	jmp    102020 <_alltraps>
  101f1d:	90                   	nop

00101f1e <Xbrkpt>:
TRAPHANDLER_NOEC(Xbrkpt,	T_BRKPT)
  101f1e:	6a 00                	push   $0x0
  101f20:	6a 03                	push   $0x3
  101f22:	e9 f9 00 00 00       	jmp    102020 <_alltraps>
  101f27:	90                   	nop

00101f28 <Xoflow>:
TRAPHANDLER_NOEC(Xoflow,	T_OFLOW)
  101f28:	6a 00                	push   $0x0
  101f2a:	6a 04                	push   $0x4
  101f2c:	e9 ef 00 00 00       	jmp    102020 <_alltraps>
  101f31:	90                   	nop

00101f32 <Xbound>:
TRAPHANDLER_NOEC(Xbound,	T_BOUND)
  101f32:	6a 00                	push   $0x0
  101f34:	6a 05                	push   $0x5
  101f36:	e9 e5 00 00 00       	jmp    102020 <_alltraps>
  101f3b:	90                   	nop

00101f3c <Xillop>:
TRAPHANDLER_NOEC(Xillop,	T_ILLOP)
  101f3c:	6a 00                	push   $0x0
  101f3e:	6a 06                	push   $0x6
  101f40:	e9 db 00 00 00       	jmp    102020 <_alltraps>
  101f45:	90                   	nop

00101f46 <Xdevice>:
TRAPHANDLER_NOEC(Xdevice,	T_DEVICE)
  101f46:	6a 00                	push   $0x0
  101f48:	6a 07                	push   $0x7
  101f4a:	e9 d1 00 00 00       	jmp    102020 <_alltraps>
  101f4f:	90                   	nop

00101f50 <Xdblflt>:
TRAPHANDLER     (Xdblflt,	T_DBLFLT)
  101f50:	6a 08                	push   $0x8
  101f52:	e9 c9 00 00 00       	jmp    102020 <_alltraps>
  101f57:	90                   	nop

00101f58 <Xcoproc>:
TRAPHANDLER_NOEC(Xcoproc,	T_COPROC)
  101f58:	6a 00                	push   $0x0
  101f5a:	6a 09                	push   $0x9
  101f5c:	e9 bf 00 00 00       	jmp    102020 <_alltraps>
  101f61:	90                   	nop

00101f62 <Xtss>:
TRAPHANDLER     (Xtss,		T_TSS)
  101f62:	6a 0a                	push   $0xa
  101f64:	e9 b7 00 00 00       	jmp    102020 <_alltraps>
  101f69:	90                   	nop

00101f6a <Xsegnp>:
TRAPHANDLER     (Xsegnp,	T_SEGNP)
  101f6a:	6a 0b                	push   $0xb
  101f6c:	e9 af 00 00 00       	jmp    102020 <_alltraps>
  101f71:	90                   	nop

00101f72 <Xstack>:
TRAPHANDLER     (Xstack,	T_STACK)
  101f72:	6a 0c                	push   $0xc
  101f74:	e9 a7 00 00 00       	jmp    102020 <_alltraps>
  101f79:	90                   	nop

00101f7a <Xgpflt>:
TRAPHANDLER     (Xgpflt,	T_GPFLT)
  101f7a:	6a 0d                	push   $0xd
  101f7c:	e9 9f 00 00 00       	jmp    102020 <_alltraps>
  101f81:	90                   	nop

00101f82 <Xpgflt>:
TRAPHANDLER     (Xpgflt,	T_PGFLT)
  101f82:	6a 0e                	push   $0xe
  101f84:	e9 97 00 00 00       	jmp    102020 <_alltraps>
  101f89:	90                   	nop

00101f8a <Xres>:
TRAPHANDLER_NOEC(Xres,		T_RES)
  101f8a:	6a 00                	push   $0x0
  101f8c:	6a 0f                	push   $0xf
  101f8e:	e9 8d 00 00 00       	jmp    102020 <_alltraps>
  101f93:	90                   	nop

00101f94 <Xfperr>:
TRAPHANDLER_NOEC(Xfperr,	T_FPERR)
  101f94:	6a 00                	push   $0x0
  101f96:	6a 10                	push   $0x10
  101f98:	e9 83 00 00 00       	jmp    102020 <_alltraps>
  101f9d:	90                   	nop

00101f9e <Xalign>:
TRAPHANDLER     (Xalign,	T_ALIGN)
  101f9e:	6a 11                	push   $0x11
  101fa0:	eb 7e                	jmp    102020 <_alltraps>

00101fa2 <Xmchk>:
TRAPHANDLER_NOEC(Xmchk,		T_MCHK)
  101fa2:	6a 00                	push   $0x0
  101fa4:	6a 12                	push   $0x12
  101fa6:	eb 78                	jmp    102020 <_alltraps>

00101fa8 <Xirq_timer>:

/* ISA interrupts  */
TRAPHANDLER_NOEC(Xirq_timer,	T_IRQ0 + IRQ_TIMER)
  101fa8:	6a 00                	push   $0x0
  101faa:	6a 20                	push   $0x20
  101fac:	eb 72                	jmp    102020 <_alltraps>

00101fae <Xirq_kbd>:
TRAPHANDLER_NOEC(Xirq_kbd,	T_IRQ0 + IRQ_KBD)
  101fae:	6a 00                	push   $0x0
  101fb0:	6a 21                	push   $0x21
  101fb2:	eb 6c                	jmp    102020 <_alltraps>

00101fb4 <Xirq_slave>:
TRAPHANDLER_NOEC(Xirq_slave,	T_IRQ0 + IRQ_SLAVE)
  101fb4:	6a 00                	push   $0x0
  101fb6:	6a 22                	push   $0x22
  101fb8:	eb 66                	jmp    102020 <_alltraps>

00101fba <Xirq_serial2>:
TRAPHANDLER_NOEC(Xirq_serial2,	T_IRQ0 + IRQ_SERIAL24)
  101fba:	6a 00                	push   $0x0
  101fbc:	6a 23                	push   $0x23
  101fbe:	eb 60                	jmp    102020 <_alltraps>

00101fc0 <Xirq_serial1>:
TRAPHANDLER_NOEC(Xirq_serial1,	T_IRQ0 + IRQ_SERIAL13)
  101fc0:	6a 00                	push   $0x0
  101fc2:	6a 24                	push   $0x24
  101fc4:	eb 5a                	jmp    102020 <_alltraps>

00101fc6 <Xirq_lpt>:
TRAPHANDLER_NOEC(Xirq_lpt,	T_IRQ0 + IRQ_LPT2)
  101fc6:	6a 00                	push   $0x0
  101fc8:	6a 25                	push   $0x25
  101fca:	eb 54                	jmp    102020 <_alltraps>

00101fcc <Xirq_floppy>:
TRAPHANDLER_NOEC(Xirq_floppy,	T_IRQ0 + IRQ_FLOPPY)
  101fcc:	6a 00                	push   $0x0
  101fce:	6a 26                	push   $0x26
  101fd0:	eb 4e                	jmp    102020 <_alltraps>

00101fd2 <Xirq_spurious>:
TRAPHANDLER_NOEC(Xirq_spurious,	T_IRQ0 + IRQ_SPURIOUS)
  101fd2:	6a 00                	push   $0x0
  101fd4:	6a 27                	push   $0x27
  101fd6:	eb 48                	jmp    102020 <_alltraps>

00101fd8 <Xirq_rtc>:
TRAPHANDLER_NOEC(Xirq_rtc,	T_IRQ0 + IRQ_RTC)
  101fd8:	6a 00                	push   $0x0
  101fda:	6a 28                	push   $0x28
  101fdc:	eb 42                	jmp    102020 <_alltraps>

00101fde <Xirq9>:
TRAPHANDLER_NOEC(Xirq9,		T_IRQ0 + 9)
  101fde:	6a 00                	push   $0x0
  101fe0:	6a 29                	push   $0x29
  101fe2:	eb 3c                	jmp    102020 <_alltraps>

00101fe4 <Xirq10>:
TRAPHANDLER_NOEC(Xirq10,	T_IRQ0 + 10)
  101fe4:	6a 00                	push   $0x0
  101fe6:	6a 2a                	push   $0x2a
  101fe8:	eb 36                	jmp    102020 <_alltraps>

00101fea <Xirq11>:
TRAPHANDLER_NOEC(Xirq11,	T_IRQ0 + 11)
  101fea:	6a 00                	push   $0x0
  101fec:	6a 2b                	push   $0x2b
  101fee:	eb 30                	jmp    102020 <_alltraps>

00101ff0 <Xirq_mouse>:
TRAPHANDLER_NOEC(Xirq_mouse,	T_IRQ0 + IRQ_MOUSE)
  101ff0:	6a 00                	push   $0x0
  101ff2:	6a 2c                	push   $0x2c
  101ff4:	eb 2a                	jmp    102020 <_alltraps>

00101ff6 <Xirq_coproc>:
TRAPHANDLER_NOEC(Xirq_coproc,	T_IRQ0 + IRQ_COPROCESSOR)
  101ff6:	6a 00                	push   $0x0
  101ff8:	6a 2d                	push   $0x2d
  101ffa:	eb 24                	jmp    102020 <_alltraps>

00101ffc <Xirq_ide1>:
TRAPHANDLER_NOEC(Xirq_ide1,	T_IRQ0 + IRQ_IDE1)
  101ffc:	6a 00                	push   $0x0
  101ffe:	6a 2e                	push   $0x2e
  102000:	eb 1e                	jmp    102020 <_alltraps>

00102002 <Xirq_ide2>:
TRAPHANDLER_NOEC(Xirq_ide2,	T_IRQ0 + IRQ_IDE2)
  102002:	6a 00                	push   $0x0
  102004:	6a 2f                	push   $0x2f
  102006:	eb 18                	jmp    102020 <_alltraps>

00102008 <Xsyscall>:

/* syscall */
TRAPHANDLER_NOEC(Xsyscall,	T_SYSCALL)
  102008:	6a 00                	push   $0x0
  10200a:	6a 30                	push   $0x30
  10200c:	eb 12                	jmp    102020 <_alltraps>

0010200e <Xdefault>:

/* default ? */
TRAPHANDLER     (Xdefault,	T_DEFAULT)
  10200e:	68 fe 00 00 00       	push   $0xfe
  102013:	eb 0b                	jmp    102020 <_alltraps>
  102015:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102020 <_alltraps>:

.globl	_alltraps
.type	_alltraps,@function
.p2align 4, 0x90		/* 16-byte alignment, nop filled */
_alltraps:
  cli			# make sure there is no nested trap
  102020:	fa                   	cli    

	cld
  102021:	fc                   	cld    

	pushl %ds		# build context
  102022:	1e                   	push   %ds
	pushl %es
  102023:	06                   	push   %es
	pushal
  102024:	60                   	pusha  

	movl $CPU_GDT_KDATA,%eax # load kernel's data segment
  102025:	b8 10 00 00 00       	mov    $0x10,%eax
	movw %ax,%ds
  10202a:	8e d8                	mov    %eax,%ds
	movw %ax,%es
  10202c:	8e c0                	mov    %eax,%es

	pushl %esp		# pass pointer to this trapframe
  10202e:	54                   	push   %esp
	call trap		# and call trap (does not return)
  10202f:	e8 dc 5d 00 00       	call   107e10 <trap>

1:	hlt			# should never get here; just spin...
  102034:	f4                   	hlt    
  102035:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102040 <trap_return>:
//
.globl	trap_return
.type	trap_return,@function
.p2align 4, 0x90		/* 16-byte alignment, nop filled */
trap_return:
	movl	4(%esp),%esp	// reset stack pointer to point to trap frame
  102040:	8b 64 24 04          	mov    0x4(%esp),%esp
	popal			// restore general-purpose registers except esp
  102044:	61                   	popa   
	popl	%es		// restore data segment registers
  102045:	07                   	pop    %es
	popl	%ds
  102046:	1f                   	pop    %ds
	addl	$8,%esp		// skip tf_trapno and tf_errcode
  102047:	83 c4 08             	add    $0x8,%esp
	iret			// return from trap handler
  10204a:	cf                   	iret   
  10204b:	66 90                	xchg   %ax,%ax
  10204d:	66 90                	xchg   %ax,%ax
  10204f:	90                   	nop

00102050 <acpi_probe_rsdp_aux>:
	return sum;
}

static acpi_rsdp_t *
acpi_probe_rsdp_aux(uint8_t *addr, int length)
{
  102050:	56                   	push   %esi
	uint8_t *e, *p;

	/* debug("Search %08x ~ %08x for RSDP\n", addr, addr+length); */
	e = addr + length;
  102051:	8d 34 10             	lea    (%eax,%edx,1),%esi
	for (p = addr; p < e; p += 16) {
  102054:	39 f0                	cmp    %esi,%eax
	return sum;
}

static acpi_rsdp_t *
acpi_probe_rsdp_aux(uint8_t *addr, int length)
{
  102056:	53                   	push   %ebx
	uint8_t *e, *p;

	/* debug("Search %08x ~ %08x for RSDP\n", addr, addr+length); */
	e = addr + length;
	for (p = addr; p < e; p += 16) {
  102057:	72 0e                	jb     102067 <acpi_probe_rsdp_aux+0x17>
  102059:	eb 3d                	jmp    102098 <acpi_probe_rsdp_aux+0x48>
  10205b:	90                   	nop
  10205c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102060:	83 c0 10             	add    $0x10,%eax
  102063:	39 c6                	cmp    %eax,%esi
  102065:	76 31                	jbe    102098 <acpi_probe_rsdp_aux+0x48>
		if (*(uint32_t *)p == ACPI_RSDP_SIG1 &&
  102067:	81 38 52 53 44 20    	cmpl   $0x20445352,(%eax)
  10206d:	75 f1                	jne    102060 <acpi_probe_rsdp_aux+0x10>
  10206f:	81 78 04 50 54 52 20 	cmpl   $0x20525450,0x4(%eax)
  102076:	75 e8                	jne    102060 <acpi_probe_rsdp_aux+0x10>
  102078:	31 d2                	xor    %edx,%edx
  10207a:	31 c9                	xor    %ecx,%ecx
  10207c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {

		sum += addr[i];
  102080:	0f b6 1c 08          	movzbl (%eax,%ecx,1),%ebx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  102084:	83 c1 01             	add    $0x1,%ecx

		sum += addr[i];
  102087:	01 da                	add    %ebx,%edx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  102089:	83 f9 24             	cmp    $0x24,%ecx
  10208c:	75 f2                	jne    102080 <acpi_probe_rsdp_aux+0x30>

	/* debug("Search %08x ~ %08x for RSDP\n", addr, addr+length); */
	e = addr + length;
	for (p = addr; p < e; p += 16) {
		if (*(uint32_t *)p == ACPI_RSDP_SIG1 &&
		    *(uint32_t *)(p + 4) == ACPI_RSDP_SIG2 &&
  10208e:	84 d2                	test   %dl,%dl
  102090:	75 ce                	jne    102060 <acpi_probe_rsdp_aux+0x10>
			return (acpi_rsdp_t *)p;
		}
	}

	return NULL;
}
  102092:	5b                   	pop    %ebx
  102093:	5e                   	pop    %esi
  102094:	c3                   	ret    
  102095:	8d 76 00             	lea    0x0(%esi),%esi
			/* debug("RSDP is at %08x\n", p); */
			return (acpi_rsdp_t *)p;
		}
	}

	return NULL;
  102098:	31 c0                	xor    %eax,%eax
}
  10209a:	5b                   	pop    %ebx
  10209b:	5e                   	pop    %esi
  10209c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1020a0:	c3                   	ret    
  1020a1:	eb 0d                	jmp    1020b0 <acpi_probe_rsdp>
  1020a3:	90                   	nop
  1020a4:	90                   	nop
  1020a5:	90                   	nop
  1020a6:	90                   	nop
  1020a7:	90                   	nop
  1020a8:	90                   	nop
  1020a9:	90                   	nop
  1020aa:	90                   	nop
  1020ab:	90                   	nop
  1020ac:	90                   	nop
  1020ad:	90                   	nop
  1020ae:	90                   	nop
  1020af:	90                   	nop

001020b0 <acpi_probe_rsdp>:
	uint8_t *bda;
	uint32_t p;
	acpi_rsdp_t *rsdp;

	bda = (uint8_t *) 0x400;
	if ((p = ((bda[0x0F] << 8) | bda[0x0E]) << 4)) {
  1020b0:	0f b6 05 0f 04 00 00 	movzbl 0x40f,%eax
  1020b7:	0f b6 15 0e 04 00 00 	movzbl 0x40e,%edx
  1020be:	c1 e0 08             	shl    $0x8,%eax
  1020c1:	09 d0                	or     %edx,%eax
  1020c3:	c1 e0 04             	shl    $0x4,%eax
  1020c6:	85 c0                	test   %eax,%eax
  1020c8:	74 16                	je     1020e0 <acpi_probe_rsdp+0x30>
		/* debug("Search RSDP from %08x\n", p); */
		if ((rsdp = acpi_probe_rsdp_aux((uint8_t *) p, 1024)))
  1020ca:	ba 00 04 00 00       	mov    $0x400,%edx
  1020cf:	e8 7c ff ff ff       	call   102050 <acpi_probe_rsdp_aux>
  1020d4:	85 c0                	test   %eax,%eax
  1020d6:	74 08                	je     1020e0 <acpi_probe_rsdp+0x30>
			return rsdp;
	}

	/* debug("Search RSDP from 0xE0000\n"); */
	return acpi_probe_rsdp_aux((uint8_t *) 0xE0000, 0x1FFFF);
}
  1020d8:	f3 c3                	repz ret 
  1020da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		if ((rsdp = acpi_probe_rsdp_aux((uint8_t *) p, 1024)))
			return rsdp;
	}

	/* debug("Search RSDP from 0xE0000\n"); */
	return acpi_probe_rsdp_aux((uint8_t *) 0xE0000, 0x1FFFF);
  1020e0:	ba ff ff 01 00       	mov    $0x1ffff,%edx
  1020e5:	b8 00 00 0e 00       	mov    $0xe0000,%eax
  1020ea:	e9 61 ff ff ff       	jmp    102050 <acpi_probe_rsdp_aux>
  1020ef:	90                   	nop

001020f0 <acpi_probe_rsdt>:
}

acpi_rsdt_t *
acpi_probe_rsdt(acpi_rsdp_t *rsdp)
{
  1020f0:	56                   	push   %esi
  1020f1:	53                   	push   %ebx
  1020f2:	83 ec 14             	sub    $0x14,%esp
  1020f5:	8b 5c 24 20          	mov    0x20(%esp),%ebx
	KERN_ASSERT(rsdp != NULL);
  1020f9:	85 db                	test   %ebx,%ebx
  1020fb:	74 40                	je     10213d <acpi_probe_rsdt+0x4d>

	acpi_rsdt_t *rsdt = (acpi_rsdt_t *)(rsdp->rsdt_addr);
  1020fd:	8b 73 10             	mov    0x10(%ebx),%esi
	/* KERN_DEBUG("rsdp->rsdt_addr = %08x\n", rsdt); */
	if (rsdt == NULL)
		return NULL;
  102100:	31 c0                	xor    %eax,%eax
{
	KERN_ASSERT(rsdp != NULL);

	acpi_rsdt_t *rsdt = (acpi_rsdt_t *)(rsdp->rsdt_addr);
	/* KERN_DEBUG("rsdp->rsdt_addr = %08x\n", rsdt); */
	if (rsdt == NULL)
  102102:	85 f6                	test   %esi,%esi
  102104:	74 2d                	je     102133 <acpi_probe_rsdt+0x43>
		return NULL;
	if (rsdt->sig == ACPI_RSDT_SIG &&
  102106:	81 3e 52 53 44 54    	cmpl   $0x54445352,(%esi)
  10210c:	75 25                	jne    102133 <acpi_probe_rsdt+0x43>
	    sum((uint8_t *)rsdt, rsdt->length) == 0) {
  10210e:	8b 5e 04             	mov    0x4(%esi),%ebx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  102111:	85 db                	test   %ebx,%ebx
  102113:	7e 24                	jle    102139 <acpi_probe_rsdt+0x49>
  102115:	01 f3                	add    %esi,%ebx
  102117:	89 f0                	mov    %esi,%eax
static uint8_t
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
  102119:	31 d2                	xor    %edx,%edx
  10211b:	90                   	nop
  10211c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	for (i = 0; i < len; i++) {

		sum += addr[i];
  102120:	0f b6 08             	movzbl (%eax),%ecx
  102123:	83 c0 01             	add    $0x1,%eax
  102126:	01 ca                	add    %ecx,%edx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  102128:	39 d8                	cmp    %ebx,%eax
  10212a:	75 f4                	jne    102120 <acpi_probe_rsdt+0x30>
	KERN_ASSERT(rsdp != NULL);

	acpi_rsdt_t *rsdt = (acpi_rsdt_t *)(rsdp->rsdt_addr);
	/* KERN_DEBUG("rsdp->rsdt_addr = %08x\n", rsdt); */
	if (rsdt == NULL)
		return NULL;
  10212c:	31 c0                	xor    %eax,%eax
  10212e:	84 d2                	test   %dl,%dl
  102130:	0f 44 c6             	cmove  %esi,%eax
		/* debug("RSDT is at %08x\n", rsdt); */
		return rsdt;
	}

	return NULL;
}
  102133:	83 c4 14             	add    $0x14,%esp
  102136:	5b                   	pop    %ebx
  102137:	5e                   	pop    %esi
  102138:	c3                   	ret    
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  102139:	89 f0                	mov    %esi,%eax
  10213b:	eb f6                	jmp    102133 <acpi_probe_rsdt+0x43>
}

acpi_rsdt_t *
acpi_probe_rsdt(acpi_rsdp_t *rsdp)
{
	KERN_ASSERT(rsdp != NULL);
  10213d:	c7 44 24 0c aa b0 10 	movl   $0x10b0aa,0xc(%esp)
  102144:	00 
  102145:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  10214c:	00 
  10214d:	c7 44 24 04 3c 00 00 	movl   $0x3c,0x4(%esp)
  102154:	00 
  102155:	c7 04 24 b7 b0 10 00 	movl   $0x10b0b7,(%esp)
  10215c:	e8 1f 20 00 00       	call   104180 <debug_panic>
  102161:	eb 9a                	jmp    1020fd <acpi_probe_rsdt+0xd>
  102163:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102170 <acpi_probe_rsdt_ent>:
	return NULL;
}

acpi_sdt_hdr_t *
acpi_probe_rsdt_ent(acpi_rsdt_t *rsdt, const uint32_t sig)
{
  102170:	55                   	push   %ebp
  102171:	57                   	push   %edi
  102172:	56                   	push   %esi
  102173:	53                   	push   %ebx
  102174:	83 ec 2c             	sub    $0x2c,%esp
  102177:	8b 5c 24 40          	mov    0x40(%esp),%ebx
  10217b:	8b 6c 24 44          	mov    0x44(%esp),%ebp
	KERN_ASSERT(rsdt != NULL);
  10217f:	85 db                	test   %ebx,%ebx
  102181:	74 67                	je     1021ea <acpi_probe_rsdt_ent+0x7a>

	uint8_t * p = (uint8_t *)(&rsdt->ent[0]),
		* e = (uint8_t *)rsdt + rsdt->length;
  102183:	8b 43 04             	mov    0x4(%ebx),%eax
  102186:	01 d8                	add    %ebx,%eax
  102188:	89 c7                	mov    %eax,%edi
  10218a:	89 44 24 1c          	mov    %eax,0x1c(%esp)
acpi_sdt_hdr_t *
acpi_probe_rsdt_ent(acpi_rsdt_t *rsdt, const uint32_t sig)
{
	KERN_ASSERT(rsdt != NULL);

	uint8_t * p = (uint8_t *)(&rsdt->ent[0]),
  10218e:	8d 43 24             	lea    0x24(%ebx),%eax
		* e = (uint8_t *)rsdt + rsdt->length;

	/* debug("RSDT->entry is at %08x\n", rsdt->ent); */

	int i;
	for (i = 0; p < e; i++) {
  102191:	39 c7                	cmp    %eax,%edi
  102193:	77 11                	ja     1021a6 <acpi_probe_rsdt_ent+0x36>
  102195:	eb 49                	jmp    1021e0 <acpi_probe_rsdt_ent+0x70>
  102197:	90                   	nop
  102198:	8d 43 04             	lea    0x4(%ebx),%eax
  10219b:	83 c3 28             	add    $0x28,%ebx
  10219e:	39 5c 24 1c          	cmp    %ebx,0x1c(%esp)
  1021a2:	76 3c                	jbe    1021e0 <acpi_probe_rsdt_ent+0x70>
  1021a4:	89 c3                	mov    %eax,%ebx
		acpi_sdt_hdr_t *hdr = (acpi_sdt_hdr_t *)(rsdt->ent[i]);
  1021a6:	8b 7b 24             	mov    0x24(%ebx),%edi
		/* debug("RSDT entry (%08x): addr = %08x, sig = %08x, length = %x\n", &rsdt->ent[i], hdr, hdr->sig, hdr->length); */
		if (hdr->sig == sig &&
  1021a9:	39 2f                	cmp    %ebp,(%edi)
  1021ab:	75 eb                	jne    102198 <acpi_probe_rsdt_ent+0x28>
		    sum((uint8_t *)hdr, hdr->length) == 0) {
  1021ad:	8b 77 04             	mov    0x4(%edi),%esi
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  1021b0:	85 f6                	test   %esi,%esi
  1021b2:	7e 1c                	jle    1021d0 <acpi_probe_rsdt_ent+0x60>
  1021b4:	01 fe                	add    %edi,%esi
  1021b6:	89 f8                	mov    %edi,%eax
static uint8_t
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
  1021b8:	31 d2                	xor    %edx,%edx
  1021ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	for (i = 0; i < len; i++) {

		sum += addr[i];
  1021c0:	0f b6 08             	movzbl (%eax),%ecx
  1021c3:	83 c0 01             	add    $0x1,%eax
  1021c6:	01 ca                	add    %ecx,%edx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  1021c8:	39 f0                	cmp    %esi,%eax
  1021ca:	75 f4                	jne    1021c0 <acpi_probe_rsdt_ent+0x50>

	int i;
	for (i = 0; p < e; i++) {
		acpi_sdt_hdr_t *hdr = (acpi_sdt_hdr_t *)(rsdt->ent[i]);
		/* debug("RSDT entry (%08x): addr = %08x, sig = %08x, length = %x\n", &rsdt->ent[i], hdr, hdr->sig, hdr->length); */
		if (hdr->sig == sig &&
  1021cc:	84 d2                	test   %dl,%dl
  1021ce:	75 c8                	jne    102198 <acpi_probe_rsdt_ent+0x28>
		}
		p = (uint8_t *)(&rsdt->ent[i+1]);
	}

	return NULL;
}
  1021d0:	83 c4 2c             	add    $0x2c,%esp

	/* debug("RSDT->entry is at %08x\n", rsdt->ent); */

	int i;
	for (i = 0; p < e; i++) {
		acpi_sdt_hdr_t *hdr = (acpi_sdt_hdr_t *)(rsdt->ent[i]);
  1021d3:	89 f8                	mov    %edi,%eax
		}
		p = (uint8_t *)(&rsdt->ent[i+1]);
	}

	return NULL;
}
  1021d5:	5b                   	pop    %ebx
  1021d6:	5e                   	pop    %esi
  1021d7:	5f                   	pop    %edi
  1021d8:	5d                   	pop    %ebp
  1021d9:	c3                   	ret    
  1021da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1021e0:	83 c4 2c             	add    $0x2c,%esp
			return hdr;
		}
		p = (uint8_t *)(&rsdt->ent[i+1]);
	}

	return NULL;
  1021e3:	31 c0                	xor    %eax,%eax
}
  1021e5:	5b                   	pop    %ebx
  1021e6:	5e                   	pop    %esi
  1021e7:	5f                   	pop    %edi
  1021e8:	5d                   	pop    %ebp
  1021e9:	c3                   	ret    
}

acpi_sdt_hdr_t *
acpi_probe_rsdt_ent(acpi_rsdt_t *rsdt, const uint32_t sig)
{
	KERN_ASSERT(rsdt != NULL);
  1021ea:	c7 44 24 0c c7 b0 10 	movl   $0x10b0c7,0xc(%esp)
  1021f1:	00 
  1021f2:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  1021f9:	00 
  1021fa:	c7 44 24 04 4e 00 00 	movl   $0x4e,0x4(%esp)
  102201:	00 
  102202:	c7 04 24 b7 b0 10 00 	movl   $0x10b0b7,(%esp)
  102209:	e8 72 1f 00 00       	call   104180 <debug_panic>
  10220e:	e9 70 ff ff ff       	jmp    102183 <acpi_probe_rsdt_ent+0x13>
  102213:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102220 <acpi_probe_xsdt>:
	return NULL;
}

acpi_xsdt_t *
acpi_probe_xsdt(acpi_rsdp_t *rsdp)
{
  102220:	56                   	push   %esi
  102221:	53                   	push   %ebx
  102222:	83 ec 14             	sub    $0x14,%esp
  102225:	8b 5c 24 20          	mov    0x20(%esp),%ebx
	KERN_ASSERT(rsdp != NULL);
  102229:	85 db                	test   %ebx,%ebx
  10222b:	74 39                	je     102266 <acpi_probe_xsdt+0x46>

	acpi_xsdt_t *xsdt  = (acpi_xsdt_t *)(uintptr_t) rsdp->xsdt_addr;
  10222d:	8b 5b 18             	mov    0x18(%ebx),%ebx
	/* debug("rsdp->xsdt_addr = %08x\n", xsdt); */
	if (xsdt == NULL)
		return NULL;
  102230:	31 c0                	xor    %eax,%eax
{
	KERN_ASSERT(rsdp != NULL);

	acpi_xsdt_t *xsdt  = (acpi_xsdt_t *)(uintptr_t) rsdp->xsdt_addr;
	/* debug("rsdp->xsdt_addr = %08x\n", xsdt); */
	if (xsdt == NULL)
  102232:	85 db                	test   %ebx,%ebx
  102234:	74 26                	je     10225c <acpi_probe_xsdt+0x3c>
		return NULL;
	if (xsdt->sig == ACPI_XSDT_SIG &&
  102236:	81 3b 58 53 44 54    	cmpl   $0x54445358,(%ebx)
  10223c:	75 1e                	jne    10225c <acpi_probe_xsdt+0x3c>
	    sum((uint8_t *)xsdt, xsdt->length) == 0) {
  10223e:	8b 73 04             	mov    0x4(%ebx),%esi
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  102241:	85 f6                	test   %esi,%esi
  102243:	7e 1d                	jle    102262 <acpi_probe_xsdt+0x42>
static uint8_t
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
  102245:	31 d2                	xor    %edx,%edx
  102247:	90                   	nop
	for (i = 0; i < len; i++) {

		sum += addr[i];
  102248:	0f b6 0c 18          	movzbl (%eax,%ebx,1),%ecx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  10224c:	83 c0 01             	add    $0x1,%eax

		sum += addr[i];
  10224f:	01 ca                	add    %ecx,%edx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  102251:	39 c6                	cmp    %eax,%esi
  102253:	75 f3                	jne    102248 <acpi_probe_xsdt+0x28>
	KERN_ASSERT(rsdp != NULL);

	acpi_xsdt_t *xsdt  = (acpi_xsdt_t *)(uintptr_t) rsdp->xsdt_addr;
	/* debug("rsdp->xsdt_addr = %08x\n", xsdt); */
	if (xsdt == NULL)
		return NULL;
  102255:	31 c0                	xor    %eax,%eax
  102257:	84 d2                	test   %dl,%dl
  102259:	0f 44 c3             	cmove  %ebx,%eax
		/* debug("XSDT is at %08x\n", xsdt); */
		return xsdt;
	}

	return NULL;
}
  10225c:	83 c4 14             	add    $0x14,%esp
  10225f:	5b                   	pop    %ebx
  102260:	5e                   	pop    %esi
  102261:	c3                   	ret    
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  102262:	89 d8                	mov    %ebx,%eax
  102264:	eb f6                	jmp    10225c <acpi_probe_xsdt+0x3c>
}

acpi_xsdt_t *
acpi_probe_xsdt(acpi_rsdp_t *rsdp)
{
	KERN_ASSERT(rsdp != NULL);
  102266:	c7 44 24 0c aa b0 10 	movl   $0x10b0aa,0xc(%esp)
  10226d:	00 
  10226e:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  102275:	00 
  102276:	c7 44 24 04 66 00 00 	movl   $0x66,0x4(%esp)
  10227d:	00 
  10227e:	c7 04 24 b7 b0 10 00 	movl   $0x10b0b7,(%esp)
  102285:	e8 f6 1e 00 00       	call   104180 <debug_panic>
  10228a:	eb a1                	jmp    10222d <acpi_probe_xsdt+0xd>
  10228c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00102290 <acpi_probe_xsdt_ent>:
	return NULL;
}

acpi_sdt_hdr_t *
acpi_probe_xsdt_ent(acpi_xsdt_t *xsdt, const uint32_t sig)
{
  102290:	55                   	push   %ebp
  102291:	57                   	push   %edi
  102292:	56                   	push   %esi
  102293:	53                   	push   %ebx
  102294:	83 ec 2c             	sub    $0x2c,%esp
  102297:	8b 74 24 40          	mov    0x40(%esp),%esi
  10229b:	8b 6c 24 44          	mov    0x44(%esp),%ebp
	KERN_ASSERT(xsdt != NULL);
  10229f:	85 f6                	test   %esi,%esi
  1022a1:	74 5f                	je     102302 <acpi_probe_xsdt_ent+0x72>

	uint8_t * p = (uint8_t *)(&xsdt->ent[0]),
		* e = (uint8_t *)xsdt + xsdt->length;
  1022a3:	8b 46 04             	mov    0x4(%esi),%eax
  1022a6:	01 f0                	add    %esi,%eax
  1022a8:	89 c7                	mov    %eax,%edi
  1022aa:	89 44 24 1c          	mov    %eax,0x1c(%esp)
acpi_sdt_hdr_t *
acpi_probe_xsdt_ent(acpi_xsdt_t *xsdt, const uint32_t sig)
{
	KERN_ASSERT(xsdt != NULL);

	uint8_t * p = (uint8_t *)(&xsdt->ent[0]),
  1022ae:	8d 46 24             	lea    0x24(%esi),%eax
		* e = (uint8_t *)xsdt + xsdt->length;

	int i;
	for (i = 0; p < e; i++) {
  1022b1:	39 c7                	cmp    %eax,%edi
  1022b3:	77 11                	ja     1022c6 <acpi_probe_xsdt_ent+0x36>
  1022b5:	eb 41                	jmp    1022f8 <acpi_probe_xsdt_ent+0x68>
  1022b7:	90                   	nop
  1022b8:	8d 46 08             	lea    0x8(%esi),%eax
  1022bb:	83 c6 2c             	add    $0x2c,%esi
  1022be:	39 74 24 1c          	cmp    %esi,0x1c(%esp)
  1022c2:	76 34                	jbe    1022f8 <acpi_probe_xsdt_ent+0x68>
  1022c4:	89 c6                	mov    %eax,%esi
		acpi_sdt_hdr_t *hdr =
			(acpi_sdt_hdr_t *)(uintptr_t) (xsdt->ent[i]);
  1022c6:	8b 5e 24             	mov    0x24(%esi),%ebx
		/* debug("probe XSDT entry %d at %08x\n", i, hdr); */
		if (hdr->sig == sig &&
  1022c9:	39 2b                	cmp    %ebp,(%ebx)
  1022cb:	75 eb                	jne    1022b8 <acpi_probe_xsdt_ent+0x28>
		    sum((uint8_t *)hdr, hdr->length) == 0) {
  1022cd:	8b 7b 04             	mov    0x4(%ebx),%edi
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  1022d0:	85 ff                	test   %edi,%edi
  1022d2:	7e 15                	jle    1022e9 <acpi_probe_xsdt_ent+0x59>
static uint8_t
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
  1022d4:	31 d2                	xor    %edx,%edx
	for (i = 0; i < len; i++) {
  1022d6:	31 c0                	xor    %eax,%eax

		sum += addr[i];
  1022d8:	0f b6 0c 18          	movzbl (%eax,%ebx,1),%ecx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  1022dc:	83 c0 01             	add    $0x1,%eax

		sum += addr[i];
  1022df:	01 ca                	add    %ecx,%edx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  1022e1:	39 c7                	cmp    %eax,%edi
  1022e3:	75 f3                	jne    1022d8 <acpi_probe_xsdt_ent+0x48>
	int i;
	for (i = 0; p < e; i++) {
		acpi_sdt_hdr_t *hdr =
			(acpi_sdt_hdr_t *)(uintptr_t) (xsdt->ent[i]);
		/* debug("probe XSDT entry %d at %08x\n", i, hdr); */
		if (hdr->sig == sig &&
  1022e5:	84 d2                	test   %dl,%dl
  1022e7:	75 cf                	jne    1022b8 <acpi_probe_xsdt_ent+0x28>
		}
		p = (uint8_t *)(&xsdt->ent[i+1]);
	}

	return NULL;
}
  1022e9:	83 c4 2c             	add    $0x2c,%esp
	uint8_t * p = (uint8_t *)(&xsdt->ent[0]),
		* e = (uint8_t *)xsdt + xsdt->length;

	int i;
	for (i = 0; p < e; i++) {
		acpi_sdt_hdr_t *hdr =
  1022ec:	89 d8                	mov    %ebx,%eax
		}
		p = (uint8_t *)(&xsdt->ent[i+1]);
	}

	return NULL;
}
  1022ee:	5b                   	pop    %ebx
  1022ef:	5e                   	pop    %esi
  1022f0:	5f                   	pop    %edi
  1022f1:	5d                   	pop    %ebp
  1022f2:	c3                   	ret    
  1022f3:	90                   	nop
  1022f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1022f8:	83 c4 2c             	add    $0x2c,%esp
			return hdr;
		}
		p = (uint8_t *)(&xsdt->ent[i+1]);
	}

	return NULL;
  1022fb:	31 c0                	xor    %eax,%eax
}
  1022fd:	5b                   	pop    %ebx
  1022fe:	5e                   	pop    %esi
  1022ff:	5f                   	pop    %edi
  102300:	5d                   	pop    %ebp
  102301:	c3                   	ret    
}

acpi_sdt_hdr_t *
acpi_probe_xsdt_ent(acpi_xsdt_t *xsdt, const uint32_t sig)
{
	KERN_ASSERT(xsdt != NULL);
  102302:	c7 44 24 0c d4 b0 10 	movl   $0x10b0d4,0xc(%esp)
  102309:	00 
  10230a:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  102311:	00 
  102312:	c7 44 24 04 78 00 00 	movl   $0x78,0x4(%esp)
  102319:	00 
  10231a:	c7 04 24 b7 b0 10 00 	movl   $0x10b0b7,(%esp)
  102321:	e8 5a 1e 00 00       	call   104180 <debug_panic>
  102326:	e9 78 ff ff ff       	jmp    1022a3 <acpi_probe_xsdt_ent+0x13>
  10232b:	66 90                	xchg   %ax,%ax
  10232d:	66 90                	xchg   %ax,%ax
  10232f:	90                   	nop

00102330 <lapic_register>:
}

void
lapic_register(uintptr_t lapic_addr)
{
	lapic = (lapic_t *) lapic_addr;
  102330:	8b 44 24 04          	mov    0x4(%esp),%eax
  102334:	a3 08 b8 9c 00       	mov    %eax,0x9cb808
  102339:	c3                   	ret    
  10233a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102340 <lapic_init>:
/*
 * Initialize local APIC.
 */
void
lapic_init()
{
  102340:	55                   	push   %ebp
  102341:	57                   	push   %edi
  102342:	56                   	push   %esi
  102343:	53                   	push   %ebx
  102344:	83 ec 2c             	sub    $0x2c,%esp
	if (!lapic)
  102347:	a1 08 b8 9c 00       	mov    0x9cb808,%eax
  10234c:	85 c0                	test   %eax,%eax
  10234e:	0f 84 b4 02 00 00    	je     102608 <lapic_init+0x2c8>

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  102354:	c7 80 f0 00 00 00 27 	movl   $0x127,0xf0(%eax)
  10235b:	01 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  10235e:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  102361:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
  102368:	00 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  10236b:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  10236e:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
  102375:	00 02 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  102378:	8b 50 20             	mov    0x20(%eax),%edx
	 * Calibrate the internal timer of LAPIC using TSC.
	 * XXX: TSC should be already calibrated before here.
	 */
	uint32_t lapic_ticks_per_ms;
	int i;
	for (i = 0; i < 5; i++) {
  10237b:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  102382:	00 

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  102383:	c7 80 80 03 00 00 ff 	movl   $0xffffffff,0x380(%eax)
  10238a:	ff ff ff 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  10238d:	8b 40 20             	mov    0x20(%eax),%eax
	outb(0x42, latch & 0xff);
	outb(0x42, latch >> 8);

	timer = timer1 = timer2 = lapic_read(LAPIC_TCCR);

	pitcnt = 0;
  102390:	31 db                	xor    %ebx,%ebx
	int pitcnt;

	lapic_write(LAPIC_TICR, ~(uint32_t) 0x0);

	/* Set the Gate high, disable speaker */
	outb(0x61, (inb(0x61) & ~0x02) | 0x01);
  102392:	c7 04 24 61 00 00 00 	movl   $0x61,(%esp)
	outb(0x42, latch >> 8);

	timer = timer1 = timer2 = lapic_read(LAPIC_TCCR);

	pitcnt = 0;
	timermax = 0;
  102399:	31 ed                	xor    %ebp,%ebp
	timermin = ~(uint32_t) 0x0;
  10239b:	bf ff ff ff ff       	mov    $0xffffffff,%edi
	int pitcnt;

	lapic_write(LAPIC_TICR, ~(uint32_t) 0x0);

	/* Set the Gate high, disable speaker */
	outb(0x61, (inb(0x61) & ~0x02) | 0x01);
  1023a0:	e8 8b 2c 00 00       	call   105030 <inb>
  1023a5:	c7 04 24 61 00 00 00 	movl   $0x61,(%esp)
  1023ac:	25 fc 00 00 00       	and    $0xfc,%eax
  1023b1:	83 c8 01             	or     $0x1,%eax
  1023b4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1023b8:	e8 a3 2c 00 00       	call   105060 <outb>
	/*
	 * Setup CTC channel 2* for mode 0, (interrupt on terminal
	 * count mode), binary count. Set the latch register to 50ms
	 * (LSB then MSB) to begin countdown.
	 */
	outb(0x43, 0xb0);
  1023bd:	c7 44 24 04 b0 00 00 	movl   $0xb0,0x4(%esp)
  1023c4:	00 
  1023c5:	c7 04 24 43 00 00 00 	movl   $0x43,(%esp)
  1023cc:	e8 8f 2c 00 00       	call   105060 <outb>
	outb(0x42, latch & 0xff);
  1023d1:	c7 44 24 04 9b 00 00 	movl   $0x9b,0x4(%esp)
  1023d8:	00 
  1023d9:	c7 04 24 42 00 00 00 	movl   $0x42,(%esp)
  1023e0:	e8 7b 2c 00 00       	call   105060 <outb>
	outb(0x42, latch >> 8);
  1023e5:	c7 44 24 04 2e 00 00 	movl   $0x2e,0x4(%esp)
  1023ec:	00 
  1023ed:	c7 04 24 42 00 00 00 	movl   $0x42,(%esp)
  1023f4:	e8 67 2c 00 00       	call   105060 <outb>
 * Read the index'th local APIC register.
 */
static uint32_t
lapic_read(int index)
{
	return lapic[index];
  1023f9:	a1 08 b8 9c 00       	mov    0x9cb808,%eax
  1023fe:	8b 80 90 03 00 00    	mov    0x390(%eax),%eax
  102404:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  102408:	89 c6                	mov    %eax,%esi
  10240a:	eb 20                	jmp    10242c <lapic_init+0xec>
  10240c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102410:	a1 08 b8 9c 00       	mov    0x9cb808,%eax
  102415:	8b 80 90 03 00 00    	mov    0x390(%eax),%eax
	pitcnt = 0;
	timermax = 0;
	timermin = ~(uint32_t) 0x0;
	while ((inb(0x61) & 0x20) == 0) {
		timer2 = lapic_read(LAPIC_TCCR);
		delta = timer - timer2;
  10241b:	29 c6                	sub    %eax,%esi
  10241d:	39 f7                	cmp    %esi,%edi
  10241f:	0f 47 fe             	cmova  %esi,%edi
  102422:	39 f5                	cmp    %esi,%ebp
  102424:	0f 42 ee             	cmovb  %esi,%ebp
		timer = timer2;
		if (delta < timermin)
			timermin = delta;
		if (delta > timermax)
			timermax = delta;
		pitcnt++;
  102427:	83 c3 01             	add    $0x1,%ebx
	timermax = 0;
	timermin = ~(uint32_t) 0x0;
	while ((inb(0x61) & 0x20) == 0) {
		timer2 = lapic_read(LAPIC_TCCR);
		delta = timer - timer2;
		timer = timer2;
  10242a:	89 c6                	mov    %eax,%esi
	timer = timer1 = timer2 = lapic_read(LAPIC_TCCR);

	pitcnt = 0;
	timermax = 0;
	timermin = ~(uint32_t) 0x0;
	while ((inb(0x61) & 0x20) == 0) {
  10242c:	c7 04 24 61 00 00 00 	movl   $0x61,(%esp)
  102433:	e8 f8 2b 00 00       	call   105030 <inb>
  102438:	a8 20                	test   $0x20,%al
  10243a:	74 d4                	je     102410 <lapic_init+0xd0>
	 * times, then we have been hit by a massive SMI
	 *
	 * If the maximum is 10 times larger than the minimum,
	 * then we got hit by an SMI as well.
	 */
	if (pitcnt < loopmin || timermax > 10 * timermin)
  10243c:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
  102442:	7f 3c                	jg     102480 <lapic_init+0x140>
	for (i = 0; i < 5; i++) {
		lapic_ticks_per_ms =
			lapic_calibrate_timer(CAL_LATCH, CAL_MS, CAL_PIT_LOOPS);
		if (lapic_ticks_per_ms != ~(uint32_t) 0x0)
			break;
		KERN_DEBUG("[%d] Retry to calibrate internal timer of LAPIC.\n", i);
  102444:	8b 44 24 18          	mov    0x18(%esp),%eax
  102448:	c7 44 24 08 94 b1 10 	movl   $0x10b194,0x8(%esp)
  10244f:	00 
  102450:	c7 44 24 04 80 00 00 	movl   $0x80,0x4(%esp)
  102457:	00 
  102458:	c7 04 24 ea b0 10 00 	movl   $0x10b0ea,(%esp)
  10245f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102463:	e8 c8 1c 00 00       	call   104130 <debug_normal>
	 * Calibrate the internal timer of LAPIC using TSC.
	 * XXX: TSC should be already calibrated before here.
	 */
	uint32_t lapic_ticks_per_ms;
	int i;
	for (i = 0; i < 5; i++) {
  102468:	83 44 24 18 01       	addl   $0x1,0x18(%esp)
  10246d:	83 7c 24 18 05       	cmpl   $0x5,0x18(%esp)
  102472:	74 6c                	je     1024e0 <lapic_init+0x1a0>
  102474:	a1 08 b8 9c 00       	mov    0x9cb808,%eax
  102479:	e9 05 ff ff ff       	jmp    102383 <lapic_init+0x43>
  10247e:	66 90                	xchg   %ax,%ax
	 * times, then we have been hit by a massive SMI
	 *
	 * If the maximum is 10 times larger than the minimum,
	 * then we got hit by an SMI as well.
	 */
	if (pitcnt < loopmin || timermax > 10 * timermin)
  102480:	8d 04 bf             	lea    (%edi,%edi,4),%eax
  102483:	01 c0                	add    %eax,%eax
  102485:	39 e8                	cmp    %ebp,%eax
  102487:	72 bb                	jb     102444 <lapic_init+0x104>
		return ~(uint32_t) 0x0;

	/* Calculate the PIT value */
	delta = timer1 - timer2;
  102489:	8b 6c 24 1c          	mov    0x1c(%esp),%ebp
	/* do_div(delta, ms); */
	return delta/ms;
  10248d:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
	if (lapic_ticks_per_ms == ~(uint32_t) 0x0) {
		KERN_WARN("Failed to calibrate internal timer of LAPIC.\n");
		KERN_DEBUG("Assume LAPIC timer freq = 0.5 GHz.\n");
		lapic_ticks_per_ms = 500000;
	} else
		KERN_DEBUG("LAPIC timer freq = %llu Hz.\n",
  102492:	c7 44 24 08 fb b0 10 	movl   $0x10b0fb,0x8(%esp)
  102499:	00 
  10249a:	c7 44 24 04 88 00 00 	movl   $0x88,0x4(%esp)
  1024a1:	00 
  1024a2:	c7 04 24 ea b0 10 00 	movl   $0x10b0ea,(%esp)
	 */
	if (pitcnt < loopmin || timermax > 10 * timermin)
		return ~(uint32_t) 0x0;

	/* Calculate the PIT value */
	delta = timer1 - timer2;
  1024a9:	29 f5                	sub    %esi,%ebp
	/* do_div(delta, ms); */
	return delta/ms;
  1024ab:	89 e8                	mov    %ebp,%eax
  1024ad:	f7 e2                	mul    %edx
	if (lapic_ticks_per_ms == ~(uint32_t) 0x0) {
		KERN_WARN("Failed to calibrate internal timer of LAPIC.\n");
		KERN_DEBUG("Assume LAPIC timer freq = 0.5 GHz.\n");
		lapic_ticks_per_ms = 500000;
	} else
		KERN_DEBUG("LAPIC timer freq = %llu Hz.\n",
  1024af:	b8 e8 03 00 00       	mov    $0x3e8,%eax
		return ~(uint32_t) 0x0;

	/* Calculate the PIT value */
	delta = timer1 - timer2;
	/* do_div(delta, ms); */
	return delta/ms;
  1024b4:	89 d3                	mov    %edx,%ebx
  1024b6:	c1 eb 03             	shr    $0x3,%ebx
	if (lapic_ticks_per_ms == ~(uint32_t) 0x0) {
		KERN_WARN("Failed to calibrate internal timer of LAPIC.\n");
		KERN_DEBUG("Assume LAPIC timer freq = 0.5 GHz.\n");
		lapic_ticks_per_ms = 500000;
	} else
		KERN_DEBUG("LAPIC timer freq = %llu Hz.\n",
  1024b9:	f7 e3                	mul    %ebx
  1024bb:	69 db e8 03 00 00    	imul   $0x3e8,%ebx,%ebx
  1024c1:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1024c5:	89 54 24 10          	mov    %edx,0x10(%esp)
  1024c9:	e8 62 1c 00 00       	call   104130 <debug_normal>
  1024ce:	89 d8                	mov    %ebx,%eax
  1024d0:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
  1024d5:	f7 e2                	mul    %edx
  1024d7:	89 d3                	mov    %edx,%ebx
  1024d9:	c1 eb 06             	shr    $0x6,%ebx
  1024dc:	eb 3f                	jmp    10251d <lapic_init+0x1dd>
  1024de:	66 90                	xchg   %ax,%ax
		if (lapic_ticks_per_ms != ~(uint32_t) 0x0)
			break;
		KERN_DEBUG("[%d] Retry to calibrate internal timer of LAPIC.\n", i);
	}
	if (lapic_ticks_per_ms == ~(uint32_t) 0x0) {
		KERN_WARN("Failed to calibrate internal timer of LAPIC.\n");
  1024e0:	c7 44 24 08 40 b1 10 	movl   $0x10b140,0x8(%esp)
  1024e7:	00 
  1024e8:	bb 20 a1 07 00       	mov    $0x7a120,%ebx
  1024ed:	c7 44 24 04 83 00 00 	movl   $0x83,0x4(%esp)
  1024f4:	00 
  1024f5:	c7 04 24 ea b0 10 00 	movl   $0x10b0ea,(%esp)
  1024fc:	e8 4f 1d 00 00       	call   104250 <debug_warn>
		KERN_DEBUG("Assume LAPIC timer freq = 0.5 GHz.\n");
  102501:	c7 44 24 08 70 b1 10 	movl   $0x10b170,0x8(%esp)
  102508:	00 
  102509:	c7 44 24 04 84 00 00 	movl   $0x84,0x4(%esp)
  102510:	00 
  102511:	c7 04 24 ea b0 10 00 	movl   $0x10b0ea,(%esp)
  102518:	e8 13 1c 00 00       	call   104130 <debug_normal>
		lapic_ticks_per_ms = 500000;
	} else
		KERN_DEBUG("LAPIC timer freq = %llu Hz.\n",
			   (uint64_t) lapic_ticks_per_ms * 1000);
	uint32_t ticr = lapic_ticks_per_ms * 1000 / LAPIC_TIMER_INTR_FREQ;
	KERN_DEBUG("Set LAPIC TICR = %x.\n", ticr);
  10251d:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  102521:	c7 44 24 08 18 b1 10 	movl   $0x10b118,0x8(%esp)
  102528:	00 
  102529:	c7 44 24 04 8a 00 00 	movl   $0x8a,0x4(%esp)
  102530:	00 
  102531:	c7 04 24 ea b0 10 00 	movl   $0x10b0ea,(%esp)
  102538:	e8 f3 1b 00 00       	call   104130 <debug_normal>

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  10253d:	a1 08 b8 9c 00       	mov    0x9cb808,%eax
  102542:	89 98 80 03 00 00    	mov    %ebx,0x380(%eax)
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  102548:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  10254b:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
  102552:	00 01 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  102555:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  102558:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
  10255f:	00 01 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  102562:	8b 50 20             	mov    0x20(%eax),%edx
 * Read the index'th local APIC register.
 */
static uint32_t
lapic_read(int index)
{
	return lapic[index];
  102565:	8b 50 30             	mov    0x30(%eax),%edx
	lapic_write(LAPIC_LINT0, LAPIC_LINT_MASKED);
	lapic_write(LAPIC_LINT1, LAPIC_LINT_MASKED);

	// Disable performance counter overflow interrupts
	// on machines that provide that interrupt entry.
	if (((lapic_read(LAPIC_VER)>>16) & 0xFF) >= 4)
  102568:	c1 ea 10             	shr    $0x10,%edx
  10256b:	80 fa 03             	cmp    $0x3,%dl
  10256e:	76 0d                	jbe    10257d <lapic_init+0x23d>

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  102570:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
  102577:	00 01 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  10257a:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  10257d:	c7 80 e0 00 00 00 00 	movl   $0xf0000000,0xe0(%eax)
  102584:	00 00 f0 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  102587:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  10258a:	c7 80 d0 00 00 00 00 	movl   $0x0,0xd0(%eax)
  102591:	00 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  102594:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  102597:	c7 80 70 03 00 00 32 	movl   $0x32,0x370(%eax)
  10259e:	00 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1025a1:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1025a4:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  1025ab:	00 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1025ae:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1025b1:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  1025b8:	00 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1025bb:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1025be:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  1025c5:	00 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1025c8:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1025cb:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
  1025d2:	00 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1025d5:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1025d8:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
  1025df:	85 08 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1025e2:	8b 50 20             	mov    0x20(%eax),%edx
  1025e5:	8d 76 00             	lea    0x0(%esi),%esi
 * Read the index'th local APIC register.
 */
static uint32_t
lapic_read(int index)
{
	return lapic[index];
  1025e8:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx

	// Send an Init Level De-Assert to synchronise arbitration ID's.
	lapic_write(LAPIC_ICRHI, 0);
	lapic_write(LAPIC_ICRLO,
		    LAPIC_ICRLO_BCAST | LAPIC_ICRLO_INIT | LAPIC_ICRLO_LEVEL);
	while(lapic_read(LAPIC_ICRLO) & LAPIC_ICRLO_DELIVS)
  1025ee:	80 e6 10             	and    $0x10,%dh
  1025f1:	75 f5                	jne    1025e8 <lapic_init+0x2a8>

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1025f3:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
  1025fa:	00 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1025fd:	8b 40 20             	mov    0x20(%eax),%eax
	while(lapic_read(LAPIC_ICRLO) & LAPIC_ICRLO_DELIVS)
		;

	// Enable interrupts on the APIC (but not on the processor).
	lapic_write(LAPIC_TPR, 0);
}
  102600:	83 c4 2c             	add    $0x2c,%esp
  102603:	5b                   	pop    %ebx
  102604:	5e                   	pop    %esi
  102605:	5f                   	pop    %edi
  102606:	5d                   	pop    %ebp
  102607:	c3                   	ret    
 */
void
lapic_init()
{
	if (!lapic)
		KERN_PANIC("NO LAPIC");
  102608:	c7 44 24 08 e1 b0 10 	movl   $0x10b0e1,0x8(%esp)
  10260f:	00 
  102610:	c7 44 24 04 6a 00 00 	movl   $0x6a,0x4(%esp)
  102617:	00 
  102618:	c7 04 24 ea b0 10 00 	movl   $0x10b0ea,(%esp)
  10261f:	e8 5c 1b 00 00       	call   104180 <debug_panic>
  102624:	a1 08 b8 9c 00       	mov    0x9cb808,%eax
  102629:	e9 26 fd ff ff       	jmp    102354 <lapic_init+0x14>
  10262e:	66 90                	xchg   %ax,%ax

00102630 <lapic_eoi>:
 * Ackownledge the end of interrupts.
 */
void
lapic_eoi(void)
{
	if (lapic)
  102630:	a1 08 b8 9c 00       	mov    0x9cb808,%eax
  102635:	85 c0                	test   %eax,%eax
  102637:	74 0d                	je     102646 <lapic_eoi+0x16>

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  102639:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  102640:	00 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  102643:	8b 40 20             	mov    0x20(%eax),%eax
  102646:	f3 c3                	repz ret 
  102648:	90                   	nop
  102649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102650 <lapic_startcpu>:
 * Start additional processor running bootstrap code at addr.
 * See Appendix B of MultiProcessor Specification.
 */
void
lapic_startcpu(lapicid_t apicid, uintptr_t addr)
{
  102650:	56                   	push   %esi
  102651:	53                   	push   %ebx
  102652:	83 ec 14             	sub    $0x14,%esp
  102655:	8b 5c 24 24          	mov    0x24(%esp),%ebx
	uint16_t *wrv;

	// "The BSP must initialize CMOS shutdown code to 0AH
	// and the warm reset vector (DWORD based at 40:67) to point at
	// the AP startup code prior to the [universal startup algorithm]."
	outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  102659:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
  102660:	00 
 * Start additional processor running bootstrap code at addr.
 * See Appendix B of MultiProcessor Specification.
 */
void
lapic_startcpu(lapicid_t apicid, uintptr_t addr)
{
  102661:	8b 74 24 20          	mov    0x20(%esp),%esi
	uint16_t *wrv;

	// "The BSP must initialize CMOS shutdown code to 0AH
	// and the warm reset vector (DWORD based at 40:67) to point at
	// the AP startup code prior to the [universal startup algorithm]."
	outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  102665:	c7 04 24 70 00 00 00 	movl   $0x70,(%esp)
  10266c:	e8 ef 29 00 00       	call   105060 <outb>
	outb(IO_RTC+1, 0x0A);
  102671:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
  102678:	00 
  102679:	c7 04 24 71 00 00 00 	movl   $0x71,(%esp)
	wrv[0] = 0;
	wrv[1] = addr >> 4;

	// "Universal startup algorithm."
	// Send INIT (level-triggered) interrupt to reset other CPU.
	lapic_write(LAPIC_ICRHI, apicid<<24);
  102680:	c1 e6 18             	shl    $0x18,%esi

	// "The BSP must initialize CMOS shutdown code to 0AH
	// and the warm reset vector (DWORD based at 40:67) to point at
	// the AP startup code prior to the [universal startup algorithm]."
	outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
	outb(IO_RTC+1, 0x0A);
  102683:	e8 d8 29 00 00       	call   105060 <outb>
	wrv = (uint16_t*)(0x40<<4 | 0x67);  // Warm reset vector
	wrv[0] = 0;
  102688:	31 c0                	xor    %eax,%eax
  10268a:	66 a3 67 04 00 00    	mov    %ax,0x467
	wrv[1] = addr >> 4;
  102690:	89 d8                	mov    %ebx,%eax
  102692:	c1 e8 04             	shr    $0x4,%eax
  102695:	66 a3 69 04 00 00    	mov    %ax,0x469

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  10269b:	a1 08 b8 9c 00       	mov    0x9cb808,%eax
	// when it is in the halted state due to an INIT.  So the second
	// should be ignored, but it is part of the official Intel algorithm.
	// Bochs complains about the second one.  Too bad for Bochs.
	for (i = 0; i < 2; i++) {
		lapic_write(LAPIC_ICRHI, apicid<<24);
		lapic_write(LAPIC_ICRLO, LAPIC_ICRLO_STARTUP | (addr>>12));
  1026a0:	c1 eb 0c             	shr    $0xc,%ebx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1026a3:	89 b0 10 03 00 00    	mov    %esi,0x310(%eax)
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1026a9:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1026ac:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
  1026b3:	c5 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1026b6:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1026b9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
  1026c0:	85 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1026c3:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1026c6:	89 b0 10 03 00 00    	mov    %esi,0x310(%eax)
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1026cc:	8b 50 20             	mov    0x20(%eax),%edx
	// when it is in the halted state due to an INIT.  So the second
	// should be ignored, but it is part of the official Intel algorithm.
	// Bochs complains about the second one.  Too bad for Bochs.
	for (i = 0; i < 2; i++) {
		lapic_write(LAPIC_ICRHI, apicid<<24);
		lapic_write(LAPIC_ICRLO, LAPIC_ICRLO_STARTUP | (addr>>12));
  1026cf:	89 da                	mov    %ebx,%edx
  1026d1:	80 ce 06             	or     $0x6,%dh

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1026d4:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1026da:	8b 58 20             	mov    0x20(%eax),%ebx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1026dd:	89 b0 10 03 00 00    	mov    %esi,0x310(%eax)
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1026e3:	8b 48 20             	mov    0x20(%eax),%ecx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1026e6:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1026ec:	8b 40 20             	mov    0x20(%eax),%eax
	for (i = 0; i < 2; i++) {
		lapic_write(LAPIC_ICRHI, apicid<<24);
		lapic_write(LAPIC_ICRLO, LAPIC_ICRLO_STARTUP | (addr>>12));
		microdelay(200);
	}
}
  1026ef:	83 c4 14             	add    $0x14,%esp
  1026f2:	5b                   	pop    %ebx
  1026f3:	5e                   	pop    %esi
  1026f4:	c3                   	ret    
  1026f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1026f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102700 <lapic_read_debug>:
 * Read the index'th local APIC register.
 */
static uint32_t
lapic_read(int index)
{
	return lapic[index];
  102700:	a1 08 b8 9c 00       	mov    0x9cb808,%eax
  102705:	8b 54 24 04          	mov    0x4(%esp),%edx
  102709:	8d 04 90             	lea    (%eax,%edx,4),%eax
  10270c:	8b 00                	mov    (%eax),%eax

uint32_t
lapic_read_debug(int index)
{
	return lapic_read(index);
}
  10270e:	c3                   	ret    
  10270f:	90                   	nop

00102710 <lapic_send_ipi>:
 * Send an IPI.
 */
void
lapic_send_ipi(lapicid_t apicid, uint8_t vector,
	       uint32_t deliver_mode, uint32_t shorthand_mode)
{
  102710:	55                   	push   %ebp
  102711:	57                   	push   %edi
  102712:	56                   	push   %esi
  102713:	53                   	push   %ebx
  102714:	83 ec 1c             	sub    $0x1c,%esp
  102717:	8b 5c 24 38          	mov    0x38(%esp),%ebx
  10271b:	8b 6c 24 30          	mov    0x30(%esp),%ebp
  10271f:	8b 7c 24 34          	mov    0x34(%esp),%edi
  102723:	8b 74 24 3c          	mov    0x3c(%esp),%esi
	KERN_ASSERT(deliver_mode != LAPIC_ICRLO_INIT &&
  102727:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
  10272d:	74 51                	je     102780 <lapic_send_ipi+0x70>
  10272f:	81 fb 00 05 00 00    	cmp    $0x500,%ebx
  102735:	74 49                	je     102780 <lapic_send_ipi+0x70>
		    deliver_mode != LAPIC_ICRLO_STARTUP);
	KERN_ASSERT(vector >= T_IPI0);
  102737:	89 f8                	mov    %edi,%eax
  102739:	3c 3e                	cmp    $0x3e,%al
  10273b:	77 08                	ja     102745 <lapic_send_ipi+0x35>
  10273d:	eb 6b                	jmp    1027aa <lapic_send_ipi+0x9a>
  10273f:	90                   	nop

	while (lapic_read(LAPIC_ICRLO) & LAPIC_ICRLO_DELIVS)
		pause();
  102740:	e8 fb 26 00 00       	call   104e40 <pause>
 * Read the index'th local APIC register.
 */
static uint32_t
lapic_read(int index)
{
	return lapic[index];
  102745:	a1 08 b8 9c 00       	mov    0x9cb808,%eax
  10274a:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
{
	KERN_ASSERT(deliver_mode != LAPIC_ICRLO_INIT &&
		    deliver_mode != LAPIC_ICRLO_STARTUP);
	KERN_ASSERT(vector >= T_IPI0);

	while (lapic_read(LAPIC_ICRLO) & LAPIC_ICRLO_DELIVS)
  102750:	80 e6 10             	and    $0x10,%dh
  102753:	75 eb                	jne    102740 <lapic_send_ipi+0x30>
		pause();

	if (shorthand_mode == LAPIC_ICRLO_NOBCAST)
  102755:	85 f6                	test   %esi,%esi
  102757:	75 0c                	jne    102765 <lapic_send_ipi+0x55>
		lapic_write(LAPIC_ICRHI, (apicid << LAPIC_ICRHI_DEST_SHIFT) &
  102759:	c1 e5 18             	shl    $0x18,%ebp

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  10275c:	89 a8 10 03 00 00    	mov    %ebp,0x310(%eax)
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  102762:	8b 50 20             	mov    0x20(%eax),%edx
	if (shorthand_mode == LAPIC_ICRLO_NOBCAST)
		lapic_write(LAPIC_ICRHI, (apicid << LAPIC_ICRHI_DEST_SHIFT) &
			    LAPIC_ICRHI_DEST_MASK);

	lapic_write(LAPIC_ICRLO, shorthand_mode | /* LAPIC_ICRLO_LEVEL | */
		    deliver_mode | (vector & LAPIC_ICRLO_VECTOR));
  102765:	89 f9                	mov    %edi,%ecx
  102767:	0f b6 f9             	movzbl %cl,%edi

	if (shorthand_mode == LAPIC_ICRLO_NOBCAST)
		lapic_write(LAPIC_ICRHI, (apicid << LAPIC_ICRHI_DEST_SHIFT) &
			    LAPIC_ICRHI_DEST_MASK);

	lapic_write(LAPIC_ICRLO, shorthand_mode | /* LAPIC_ICRLO_LEVEL | */
  10276a:	09 f7                	or     %esi,%edi
		    deliver_mode | (vector & LAPIC_ICRLO_VECTOR));
  10276c:	09 df                	or     %ebx,%edi

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  10276e:	89 b8 00 03 00 00    	mov    %edi,0x300(%eax)
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  102774:	8b 40 20             	mov    0x20(%eax),%eax

	lapic_write(LAPIC_ICRLO, shorthand_mode | /* LAPIC_ICRLO_LEVEL | */
		    deliver_mode | (vector & LAPIC_ICRLO_VECTOR));

	/* KERN_DEBUG("IPI %d has been sent to processor %d.\n", vector, apicid); */
}
  102777:	83 c4 1c             	add    $0x1c,%esp
  10277a:	5b                   	pop    %ebx
  10277b:	5e                   	pop    %esi
  10277c:	5f                   	pop    %edi
  10277d:	5d                   	pop    %ebp
  10277e:	c3                   	ret    
  10277f:	90                   	nop
 */
void
lapic_send_ipi(lapicid_t apicid, uint8_t vector,
	       uint32_t deliver_mode, uint32_t shorthand_mode)
{
	KERN_ASSERT(deliver_mode != LAPIC_ICRLO_INIT &&
  102780:	c7 44 24 0c c8 b1 10 	movl   $0x10b1c8,0xc(%esp)
  102787:	00 
  102788:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  10278f:	00 
  102790:	c7 44 24 04 f3 00 00 	movl   $0xf3,0x4(%esp)
  102797:	00 
  102798:	c7 04 24 ea b0 10 00 	movl   $0x10b0ea,(%esp)
  10279f:	e8 dc 19 00 00       	call   104180 <debug_panic>
		    deliver_mode != LAPIC_ICRLO_STARTUP);
	KERN_ASSERT(vector >= T_IPI0);
  1027a4:	89 f8                	mov    %edi,%eax
  1027a6:	3c 3e                	cmp    $0x3e,%al
  1027a8:	77 9b                	ja     102745 <lapic_send_ipi+0x35>
  1027aa:	c7 44 24 0c 2e b1 10 	movl   $0x10b12e,0xc(%esp)
  1027b1:	00 
  1027b2:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  1027b9:	00 
  1027ba:	c7 44 24 04 f4 00 00 	movl   $0xf4,0x4(%esp)
  1027c1:	00 
  1027c2:	c7 04 24 ea b0 10 00 	movl   $0x10b0ea,(%esp)
  1027c9:	e8 b2 19 00 00       	call   104180 <debug_panic>
  1027ce:	e9 72 ff ff ff       	jmp    102745 <lapic_send_ipi+0x35>
  1027d3:	66 90                	xchg   %ax,%ax
  1027d5:	66 90                	xchg   %ax,%ax
  1027d7:	66 90                	xchg   %ax,%ax
  1027d9:	66 90                	xchg   %ax,%ax
  1027db:	66 90                	xchg   %ax,%ax
  1027dd:	66 90                	xchg   %ax,%ax
  1027df:	90                   	nop

001027e0 <ioapic_register>:
	base->data = data;
}

void
ioapic_register(uintptr_t addr, lapicid_t id, int g)
{
  1027e0:	83 ec 1c             	sub    $0x1c,%esp
	if (ioapic_num >= MAX_IOAPIC) {
  1027e3:	a1 64 fe 13 00       	mov    0x13fe64,%eax
	base->data = data;
}

void
ioapic_register(uintptr_t addr, lapicid_t id, int g)
{
  1027e8:	8b 54 24 24          	mov    0x24(%esp),%edx
	if (ioapic_num >= MAX_IOAPIC) {
  1027ec:	83 f8 0f             	cmp    $0xf,%eax
  1027ef:	7f 3f                	jg     102830 <ioapic_register+0x50>
		KERN_WARN("CertiKOS cannot manipulate more than %d IOAPICs.\n",
			  MAX_IOAPIC);
		return;
	}

	ioapics[ioapic_num] = (ioapic_t *) addr;
  1027f1:	a1 64 fe 13 00       	mov    0x13fe64,%eax
  1027f6:	8b 4c 24 20          	mov    0x20(%esp),%ecx
  1027fa:	89 0c 85 80 b8 9c 00 	mov    %ecx,0x9cb880(,%eax,4)
	ioapicid[ioapic_num] = id;
  102801:	a1 64 fe 13 00       	mov    0x13fe64,%eax
  102806:	88 90 20 b8 9c 00    	mov    %dl,0x9cb820(%eax)
	gsi[ioapic_num] = g;
  10280c:	8b 54 24 28          	mov    0x28(%esp),%edx
  102810:	a1 64 fe 13 00       	mov    0x13fe64,%eax
  102815:	89 14 85 40 b8 9c 00 	mov    %edx,0x9cb840(,%eax,4)

	ioapic_num++;
  10281c:	a1 64 fe 13 00       	mov    0x13fe64,%eax
  102821:	83 c0 01             	add    $0x1,%eax
  102824:	a3 64 fe 13 00       	mov    %eax,0x13fe64
}
  102829:	83 c4 1c             	add    $0x1c,%esp
  10282c:	c3                   	ret    
  10282d:	8d 76 00             	lea    0x0(%esi),%esi

void
ioapic_register(uintptr_t addr, lapicid_t id, int g)
{
	if (ioapic_num >= MAX_IOAPIC) {
		KERN_WARN("CertiKOS cannot manipulate more than %d IOAPICs.\n",
  102830:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  102837:	00 
  102838:	c7 44 24 08 10 b2 10 	movl   $0x10b210,0x8(%esp)
  10283f:	00 
  102840:	c7 44 24 04 26 00 00 	movl   $0x26,0x4(%esp)
  102847:	00 
  102848:	c7 04 24 89 b2 10 00 	movl   $0x10b289,(%esp)
  10284f:	e8 fc 19 00 00       	call   104250 <debug_warn>
	ioapics[ioapic_num] = (ioapic_t *) addr;
	ioapicid[ioapic_num] = id;
	gsi[ioapic_num] = g;

	ioapic_num++;
}
  102854:	83 c4 1c             	add    $0x1c,%esp
  102857:	c3                   	ret    
  102858:	90                   	nop
  102859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102860 <ioapic_init>:

void
ioapic_init(void)
{
  102860:	57                   	push   %edi
	/* KERN_ASSERT(ioapics != NULL); */

	int i;

	for (i = 0; i < ioapic_num; i++) {
  102861:	31 ff                	xor    %edi,%edi
	ioapic_num++;
}

void
ioapic_init(void)
{
  102863:	56                   	push   %esi
  102864:	53                   	push   %ebx
  102865:	83 ec 20             	sub    $0x20,%esp
	/* KERN_ASSERT(ioapics != NULL); */

	int i;

	for (i = 0; i < ioapic_num; i++) {
  102868:	a1 64 fe 13 00       	mov    0x13fe64,%eax
  10286d:	85 c0                	test   %eax,%eax
  10286f:	0f 8e bf 00 00 00    	jle    102934 <ioapic_init+0xd4>
  102875:	8d 76 00             	lea    0x0(%esi),%esi
		/* debug("Initialize IOAPIC %x\n", ioapicid[i]); */

		volatile ioapic_t *ioapic = ioapics[i];
  102878:	8b 1c bd 80 b8 9c 00 	mov    0x9cb880(,%edi,4),%ebx

		KERN_ASSERT(ioapic != NULL);
  10287f:	85 db                	test   %ebx,%ebx
  102881:	0f 84 b4 00 00 00    	je     10293b <ioapic_init+0xdb>

static uint32_t
ioapic_read(ioapic_t *base, int reg)
{
	/* KERN_DEBUG("ioapic_read: base=%x, reg=%x\n", base, reg); */
	base->reg = reg;
  102887:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
	return base->data;
  10288d:	8b 43 10             	mov    0x10(%ebx),%eax

		volatile ioapic_t *ioapic = ioapics[i];

		KERN_ASSERT(ioapic != NULL);

		lapicid_t id = ioapic_read(ioapic, IOAPIC_ID) >> 24;
  102890:	c1 e8 18             	shr    $0x18,%eax

		if (id == 0) {
  102893:	84 c0                	test   %al,%al

		volatile ioapic_t *ioapic = ioapics[i];

		KERN_ASSERT(ioapic != NULL);

		lapicid_t id = ioapic_read(ioapic, IOAPIC_ID) >> 24;
  102895:	0f b6 d0             	movzbl %al,%edx

		if (id == 0) {
  102898:	75 1a                	jne    1028b4 <ioapic_init+0x54>
			// I/O APIC ID not initialized yet - have to do it ourselves.
			ioapic_write(ioapic, IOAPIC_ID, ioapicid[i] << 24);
  10289a:	0f b6 87 20 b8 9c 00 	movzbl 0x9cb820(%edi),%eax

static void
ioapic_write(ioapic_t *base, int reg, uint32_t data)
{
	/* KERN_DEBUG("ioapic_write: base=%x, reg=%x, data@%x\n", base, reg, data); */
	base->reg = reg;
  1028a1:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

		lapicid_t id = ioapic_read(ioapic, IOAPIC_ID) >> 24;

		if (id == 0) {
			// I/O APIC ID not initialized yet - have to do it ourselves.
			ioapic_write(ioapic, IOAPIC_ID, ioapicid[i] << 24);
  1028a7:	c1 e0 18             	shl    $0x18,%eax
static void
ioapic_write(ioapic_t *base, int reg, uint32_t data)
{
	/* KERN_DEBUG("ioapic_write: base=%x, reg=%x, data@%x\n", base, reg, data); */
	base->reg = reg;
	base->data = data;
  1028aa:	89 43 10             	mov    %eax,0x10(%ebx)
		lapicid_t id = ioapic_read(ioapic, IOAPIC_ID) >> 24;

		if (id == 0) {
			// I/O APIC ID not initialized yet - have to do it ourselves.
			ioapic_write(ioapic, IOAPIC_ID, ioapicid[i] << 24);
			id = ioapicid[i];
  1028ad:	0f b6 97 20 b8 9c 00 	movzbl 0x9cb820(%edi),%edx
		}

		if (id != ioapicid[i])
  1028b4:	0f b6 87 20 b8 9c 00 	movzbl 0x9cb820(%edi),%eax
  1028bb:	38 d0                	cmp    %dl,%al
  1028bd:	74 2b                	je     1028ea <ioapic_init+0x8a>
			KERN_WARN("ioapic_init: id %d != ioapicid %d\n",
  1028bf:	0f b6 87 20 b8 9c 00 	movzbl 0x9cb820(%edi),%eax
  1028c6:	89 54 24 0c          	mov    %edx,0xc(%esp)
  1028ca:	c7 44 24 08 44 b2 10 	movl   $0x10b244,0x8(%esp)
  1028d1:	00 
  1028d2:	c7 44 24 04 49 00 00 	movl   $0x49,0x4(%esp)
  1028d9:	00 
  1028da:	89 44 24 10          	mov    %eax,0x10(%esp)
  1028de:	c7 04 24 89 b2 10 00 	movl   $0x10b289,(%esp)
  1028e5:	e8 66 19 00 00       	call   104250 <debug_warn>

static uint32_t
ioapic_read(ioapic_t *base, int reg)
{
	/* KERN_DEBUG("ioapic_read: base=%x, reg=%x\n", base, reg); */
	base->reg = reg;
  1028ea:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
	return base->data;
  1028f0:	8b 43 10             	mov    0x10(%ebx),%eax

		if (id != ioapicid[i])
			KERN_WARN("ioapic_init: id %d != ioapicid %d\n",
				  id, ioapicid[i]);

		int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;
  1028f3:	ba 10 00 00 00       	mov    $0x10,%edx
  1028f8:	c1 e8 10             	shr    $0x10,%eax
  1028fb:	0f b6 f0             	movzbl %al,%esi

		// Mark all interrupts edge-triggered, active high, disabled,
		// and not routed to any CPUs.
		int j;
		for (j = 0; j <= maxintr; j++){
  1028fe:	31 c0                	xor    %eax,%eax
  102900:	8d 48 20             	lea    0x20(%eax),%ecx
  102903:	83 c0 01             	add    $0x1,%eax
			ioapic_write(ioapic, IOAPIC_TABLE + 2 * j,
				     IOAPIC_INT_DISABLED | (T_IRQ0 + j));
  102906:	81 c9 00 00 01 00    	or     $0x10000,%ecx

static void
ioapic_write(ioapic_t *base, int reg, uint32_t data)
{
	/* KERN_DEBUG("ioapic_write: base=%x, reg=%x, data@%x\n", base, reg, data); */
	base->reg = reg;
  10290c:	89 13                	mov    %edx,(%ebx)
	base->data = data;
  10290e:	89 4b 10             	mov    %ecx,0x10(%ebx)
  102911:	8d 4a 01             	lea    0x1(%edx),%ecx
  102914:	83 c2 02             	add    $0x2,%edx
		int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;

		// Mark all interrupts edge-triggered, active high, disabled,
		// and not routed to any CPUs.
		int j;
		for (j = 0; j <= maxintr; j++){
  102917:	39 c6                	cmp    %eax,%esi

static void
ioapic_write(ioapic_t *base, int reg, uint32_t data)
{
	/* KERN_DEBUG("ioapic_write: base=%x, reg=%x, data@%x\n", base, reg, data); */
	base->reg = reg;
  102919:	89 0b                	mov    %ecx,(%ebx)
	base->data = data;
  10291b:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
		int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;

		// Mark all interrupts edge-triggered, active high, disabled,
		// and not routed to any CPUs.
		int j;
		for (j = 0; j <= maxintr; j++){
  102922:	7d dc                	jge    102900 <ioapic_init+0xa0>
{
	/* KERN_ASSERT(ioapics != NULL); */

	int i;

	for (i = 0; i < ioapic_num; i++) {
  102924:	a1 64 fe 13 00       	mov    0x13fe64,%eax
  102929:	83 c7 01             	add    $0x1,%edi
  10292c:	39 f8                	cmp    %edi,%eax
  10292e:	0f 8f 44 ff ff ff    	jg     102878 <ioapic_init+0x18>
				     IOAPIC_INT_DISABLED | (T_IRQ0 + j));
			ioapic_write(ioapic, IOAPIC_TABLE + 2 * j + 1, 0);
		}

	}
}
  102934:	83 c4 20             	add    $0x20,%esp
  102937:	5b                   	pop    %ebx
  102938:	5e                   	pop    %esi
  102939:	5f                   	pop    %edi
  10293a:	c3                   	ret    
	for (i = 0; i < ioapic_num; i++) {
		/* debug("Initialize IOAPIC %x\n", ioapicid[i]); */

		volatile ioapic_t *ioapic = ioapics[i];

		KERN_ASSERT(ioapic != NULL);
  10293b:	c7 44 24 0c 9b b2 10 	movl   $0x10b29b,0xc(%esp)
  102942:	00 
  102943:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  10294a:	00 
  10294b:	c7 44 24 04 3d 00 00 	movl   $0x3d,0x4(%esp)
  102952:	00 
  102953:	c7 04 24 89 b2 10 00 	movl   $0x10b289,(%esp)
  10295a:	e8 21 18 00 00       	call   104180 <debug_panic>
  10295f:	e9 23 ff ff ff       	jmp    102887 <ioapic_init+0x27>
  102964:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10296a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00102970 <ioapic_enable>:

// extern bool pcpu_is_smp(void);

void
ioapic_enable(uint8_t irq, lapicid_t apicid, bool trigger_mode, bool polarity)
{
  102970:	55                   	push   %ebp
  102971:	57                   	push   %edi
  102972:	56                   	push   %esi
  102973:	53                   	push   %ebx
  102974:	83 ec 18             	sub    $0x18,%esp
  102977:	8b 44 24 30          	mov    0x30(%esp),%eax
  10297b:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
  10297f:	8b 6c 24 34          	mov    0x34(%esp),%ebp
  102983:	89 44 24 04          	mov    %eax,0x4(%esp)
  102987:	8b 44 24 38          	mov    0x38(%esp),%eax
  10298b:	89 44 24 08          	mov    %eax,0x8(%esp)
	// Mark interrupt edge-triggered, active high,
	// enabled, and routed to the given APIC ID,

	int i;

	for (i = 0; i < ioapic_num; i++) {
  10298f:	a1 64 fe 13 00       	mov    0x13fe64,%eax
  102994:	85 c0                	test   %eax,%eax
  102996:	0f 8e df 00 00 00    	jle    102a7b <ioapic_enable+0x10b>
  10299c:	89 f8                	mov    %edi,%eax
  10299e:	0f b6 d8             	movzbl %al,%ebx
  1029a1:	31 c0                	xor    %eax,%eax
  1029a3:	90                   	nop
  1029a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		ioapic_t *ioapic = ioapics[i];
  1029a8:	8b 14 85 80 b8 9c 00 	mov    0x9cb880(,%eax,4),%edx

static uint32_t
ioapic_read(ioapic_t *base, int reg)
{
	/* KERN_DEBUG("ioapic_read: base=%x, reg=%x\n", base, reg); */
	base->reg = reg;
  1029af:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
	return base->data;
  1029b5:	8b 72 10             	mov    0x10(%edx),%esi

	for (i = 0; i < ioapic_num; i++) {
		ioapic_t *ioapic = ioapics[i];
		int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;

		if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
  1029b8:	8b 0c 85 40 b8 9c 00 	mov    0x9cb840(,%eax,4),%ecx
  1029bf:	39 d9                	cmp    %ebx,%ecx
  1029c1:	7f 19                	jg     1029dc <ioapic_enable+0x6c>
  1029c3:	8b 0c 85 40 b8 9c 00 	mov    0x9cb840(,%eax,4),%ecx

	int i;

	for (i = 0; i < ioapic_num; i++) {
		ioapic_t *ioapic = ioapics[i];
		int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;
  1029ca:	c1 ee 10             	shr    $0x10,%esi

		if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
  1029cd:	89 0c 24             	mov    %ecx,(%esp)

	int i;

	for (i = 0; i < ioapic_num; i++) {
		ioapic_t *ioapic = ioapics[i];
		int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;
  1029d0:	89 f1                	mov    %esi,%ecx
  1029d2:	0f b6 f1             	movzbl %cl,%esi

		if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
  1029d5:	03 34 24             	add    (%esp),%esi
  1029d8:	39 de                	cmp    %ebx,%esi
  1029da:	7d 24                	jge    102a00 <ioapic_enable+0x90>
	// Mark interrupt edge-triggered, active high,
	// enabled, and routed to the given APIC ID,

	int i;

	for (i = 0; i < ioapic_num; i++) {
  1029dc:	8b 15 64 fe 13 00    	mov    0x13fe64,%edx
  1029e2:	83 c0 01             	add    $0x1,%eax
  1029e5:	39 c2                	cmp    %eax,%edx
  1029e7:	7f bf                	jg     1029a8 <ioapic_enable+0x38>
				     apicid << 24);
			break;
		}
	}

	if (i == ioapic_num)
  1029e9:	8b 15 64 fe 13 00    	mov    0x13fe64,%edx
  1029ef:	39 d0                	cmp    %edx,%eax
  1029f1:	74 5b                	je     102a4e <ioapic_enable+0xde>
		KERN_PANIC("Cannot enable IRQ %d on IOAPIC.\n", irq);
}
  1029f3:	83 c4 18             	add    $0x18,%esp
  1029f6:	5b                   	pop    %ebx
  1029f7:	5e                   	pop    %esi
  1029f8:	5f                   	pop    %edi
  1029f9:	5d                   	pop    %ebp
  1029fa:	c3                   	ret    
  1029fb:	90                   	nop
  1029fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;

		if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
			ioapic_write(ioapic,
				     IOAPIC_TABLE + 2 * (irq - gsi[i]),
				     ((trigger_mode << 15) | (polarity << 13) | (T_IRQ0 + irq)));
  102a00:	89 e9                	mov    %ebp,%ecx
		ioapic_t *ioapic = ioapics[i];
		int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;

		if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
			ioapic_write(ioapic,
				     IOAPIC_TABLE + 2 * (irq - gsi[i]),
  102a02:	89 de                	mov    %ebx,%esi
				     ((trigger_mode << 15) | (polarity << 13) | (T_IRQ0 + irq)));
  102a04:	0f b6 e9             	movzbl %cl,%ebp
  102a07:	0f b6 4c 24 08       	movzbl 0x8(%esp),%ecx
  102a0c:	c1 e5 0f             	shl    $0xf,%ebp
  102a0f:	c1 e1 0d             	shl    $0xd,%ecx
  102a12:	09 cd                	or     %ecx,%ebp
  102a14:	8d 4b 20             	lea    0x20(%ebx),%ecx
  102a17:	09 cd                	or     %ecx,%ebp
		ioapic_t *ioapic = ioapics[i];
		int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;

		if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
			ioapic_write(ioapic,
				     IOAPIC_TABLE + 2 * (irq - gsi[i]),
  102a19:	8b 0c 85 40 b8 9c 00 	mov    0x9cb840(,%eax,4),%ecx
  102a20:	29 ce                	sub    %ecx,%esi
	for (i = 0; i < ioapic_num; i++) {
		ioapic_t *ioapic = ioapics[i];
		int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;

		if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
			ioapic_write(ioapic,
  102a22:	8d 4c 36 10          	lea    0x10(%esi,%esi,1),%ecx

static void
ioapic_write(ioapic_t *base, int reg, uint32_t data)
{
	/* KERN_DEBUG("ioapic_write: base=%x, reg=%x, data@%x\n", base, reg, data); */
	base->reg = reg;
  102a26:	89 0a                	mov    %ecx,(%edx)
				     IOAPIC_TABLE + 2 * (irq - gsi[i]),
				     ((trigger_mode << 15) | (polarity << 13) | (T_IRQ0 + irq)));

			ioapic_write(ioapic,
				     IOAPIC_TABLE + 2 * (irq - gsi[i]) + 1,
				     apicid << 24);
  102a28:	8b 4c 24 04          	mov    0x4(%esp),%ecx
static void
ioapic_write(ioapic_t *base, int reg, uint32_t data)
{
	/* KERN_DEBUG("ioapic_write: base=%x, reg=%x, data@%x\n", base, reg, data); */
	base->reg = reg;
	base->data = data;
  102a2c:	89 6a 10             	mov    %ebp,0x10(%edx)
			ioapic_write(ioapic,
				     IOAPIC_TABLE + 2 * (irq - gsi[i]),
				     ((trigger_mode << 15) | (polarity << 13) | (T_IRQ0 + irq)));

			ioapic_write(ioapic,
				     IOAPIC_TABLE + 2 * (irq - gsi[i]) + 1,
  102a2f:	8b 34 85 40 b8 9c 00 	mov    0x9cb840(,%eax,4),%esi
				     apicid << 24);
  102a36:	c1 e1 18             	shl    $0x18,%ecx
			ioapic_write(ioapic,
				     IOAPIC_TABLE + 2 * (irq - gsi[i]),
				     ((trigger_mode << 15) | (polarity << 13) | (T_IRQ0 + irq)));

			ioapic_write(ioapic,
				     IOAPIC_TABLE + 2 * (irq - gsi[i]) + 1,
  102a39:	29 f3                	sub    %esi,%ebx
		if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
			ioapic_write(ioapic,
				     IOAPIC_TABLE + 2 * (irq - gsi[i]),
				     ((trigger_mode << 15) | (polarity << 13) | (T_IRQ0 + irq)));

			ioapic_write(ioapic,
  102a3b:	8d 5c 1b 11          	lea    0x11(%ebx,%ebx,1),%ebx

static void
ioapic_write(ioapic_t *base, int reg, uint32_t data)
{
	/* KERN_DEBUG("ioapic_write: base=%x, reg=%x, data@%x\n", base, reg, data); */
	base->reg = reg;
  102a3f:	89 1a                	mov    %ebx,(%edx)
	base->data = data;
  102a41:	89 4a 10             	mov    %ecx,0x10(%edx)
				     apicid << 24);
			break;
		}
	}

	if (i == ioapic_num)
  102a44:	8b 15 64 fe 13 00    	mov    0x13fe64,%edx
  102a4a:	39 d0                	cmp    %edx,%eax
  102a4c:	75 a5                	jne    1029f3 <ioapic_enable+0x83>
		KERN_PANIC("Cannot enable IRQ %d on IOAPIC.\n", irq);
  102a4e:	89 f8                	mov    %edi,%eax
  102a50:	0f b6 f8             	movzbl %al,%edi
  102a53:	89 7c 24 38          	mov    %edi,0x38(%esp)
  102a57:	c7 44 24 34 68 b2 10 	movl   $0x10b268,0x34(%esp)
  102a5e:	00 
  102a5f:	c7 44 24 30 75 00 00 	movl   $0x75,0x30(%esp)
  102a66:	00 
  102a67:	c7 44 24 2c 89 b2 10 	movl   $0x10b289,0x2c(%esp)
  102a6e:	00 
}
  102a6f:	83 c4 18             	add    $0x18,%esp
  102a72:	5b                   	pop    %ebx
  102a73:	5e                   	pop    %esi
  102a74:	5f                   	pop    %edi
  102a75:	5d                   	pop    %ebp
			break;
		}
	}

	if (i == ioapic_num)
		KERN_PANIC("Cannot enable IRQ %d on IOAPIC.\n", irq);
  102a76:	e9 05 17 00 00       	jmp    104180 <debug_panic>
	// Mark interrupt edge-triggered, active high,
	// enabled, and routed to the given APIC ID,

	int i;

	for (i = 0; i < ioapic_num; i++) {
  102a7b:	31 c0                	xor    %eax,%eax
  102a7d:	e9 67 ff ff ff       	jmp    1029e9 <ioapic_enable+0x79>
  102a82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102a90 <ioapic_number>:
}

int
ioapic_number(void)
{
	return ioapic_num;
  102a90:	a1 64 fe 13 00       	mov    0x13fe64,%eax
}
  102a95:	c3                   	ret    
  102a96:	8d 76 00             	lea    0x0(%esi),%esi
  102a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102aa0 <ioapic_get>:

ioapic_t *
ioapic_get(uint32_t idx)
{
  102aa0:	8b 44 24 04          	mov    0x4(%esp),%eax
	if (idx >= ioapic_num)
  102aa4:	8b 15 64 fe 13 00    	mov    0x13fe64,%edx
  102aaa:	39 c2                	cmp    %eax,%edx
  102aac:	76 0a                	jbe    102ab8 <ioapic_get+0x18>
		return NULL;
	return ioapics[idx];
  102aae:	8b 04 85 80 b8 9c 00 	mov    0x9cb880(,%eax,4),%eax
  102ab5:	c3                   	ret    
  102ab6:	66 90                	xchg   %ax,%ax

ioapic_t *
ioapic_get(uint32_t idx)
{
	if (idx >= ioapic_num)
		return NULL;
  102ab8:	31 c0                	xor    %eax,%eax
	return ioapics[idx];
}
  102aba:	c3                   	ret    
  102abb:	66 90                	xchg   %ax,%ax
  102abd:	66 90                	xchg   %ax,%ax
  102abf:	90                   	nop

00102ac0 <pcpu_mp_init_cpu>:
	pcpu_print_cpuinfo(get_pcpu_idx(), cpuinfo);
}

static void
pcpu_mp_init_cpu(uint32_t idx, uint8_t lapic_id, bool is_bsp)
{
  102ac0:	56                   	push   %esi
  102ac1:	89 d6                	mov    %edx,%esi
  102ac3:	53                   	push   %ebx
  102ac4:	89 cb                	mov    %ecx,%ebx
  102ac6:	83 ec 24             	sub    $0x24,%esp
	KERN_ASSERT((is_bsp == TRUE && idx == 0) || (is_bsp == FALSE));
  102ac9:	80 f9 01             	cmp    $0x1,%cl
  102acc:	75 22                	jne    102af0 <pcpu_mp_init_cpu+0x30>
  102ace:	85 c0                	test   %eax,%eax
  102ad0:	75 1e                	jne    102af0 <pcpu_mp_init_cpu+0x30>

	if (idx >= NUM_CPUS)
	return;

	struct pcpuinfo *info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(idx);
  102ad2:	89 04 24             	mov    %eax,(%esp)
  102ad5:	e8 16 32 00 00       	call   105cf0 <get_pcpu_arch_info_pointer>

	info->lapicid = lapic_id;
  102ada:	89 f2                	mov    %esi,%edx
  102adc:	0f b6 f2             	movzbl %dl,%esi
  102adf:	89 30                	mov    %esi,(%eax)
	info->bsp = is_bsp;
  102ae1:	88 58 04             	mov    %bl,0x4(%eax)
}
  102ae4:	83 c4 24             	add    $0x24,%esp
  102ae7:	5b                   	pop    %ebx
  102ae8:	5e                   	pop    %esi
  102ae9:	c3                   	ret    
  102aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}

static void
pcpu_mp_init_cpu(uint32_t idx, uint8_t lapic_id, bool is_bsp)
{
	KERN_ASSERT((is_bsp == TRUE && idx == 0) || (is_bsp == FALSE));
  102af0:	84 db                	test   %bl,%bl
  102af2:	75 0c                	jne    102b00 <pcpu_mp_init_cpu+0x40>

	if (idx >= NUM_CPUS)
  102af4:	83 f8 07             	cmp    $0x7,%eax
  102af7:	76 d9                	jbe    102ad2 <pcpu_mp_init_cpu+0x12>

	struct pcpuinfo *info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(idx);

	info->lapicid = lapic_id;
	info->bsp = is_bsp;
}
  102af9:	83 c4 24             	add    $0x24,%esp
  102afc:	5b                   	pop    %ebx
  102afd:	5e                   	pop    %esi
  102afe:	c3                   	ret    
  102aff:	90                   	nop
}

static void
pcpu_mp_init_cpu(uint32_t idx, uint8_t lapic_id, bool is_bsp)
{
	KERN_ASSERT((is_bsp == TRUE && idx == 0) || (is_bsp == FALSE));
  102b00:	c7 44 24 0c ac b2 10 	movl   $0x10b2ac,0xc(%esp)
  102b07:	00 
  102b08:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  102b0f:	00 
  102b10:	c7 44 24 04 a6 00 00 	movl   $0xa6,0x4(%esp)
  102b17:	00 
  102b18:	c7 04 24 c4 b4 10 00 	movl   $0x10b4c4,(%esp)
  102b1f:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  102b23:	e8 58 16 00 00       	call   104180 <debug_panic>
  102b28:	8b 44 24 1c          	mov    0x1c(%esp),%eax

	if (idx >= NUM_CPUS)
  102b2c:	83 f8 07             	cmp    $0x7,%eax
  102b2f:	77 c8                	ja     102af9 <pcpu_mp_init_cpu+0x39>
  102b31:	eb 9f                	jmp    102ad2 <pcpu_mp_init_cpu+0x12>
  102b33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102b40 <mpsearch1>:
}

/* Look for an MP structure in the len bytes at addr. */
static struct mp *
mpsearch1(uint8_t * addr, int len)
{
  102b40:	57                   	push   %edi
  102b41:	89 c7                	mov    %eax,%edi
  102b43:	56                   	push   %esi
  102b44:	53                   	push   %ebx
	uint8_t *e, *p;

	e = addr + len;
  102b45:	8d 34 10             	lea    (%eax,%edx,1),%esi
}

/* Look for an MP structure in the len bytes at addr. */
static struct mp *
mpsearch1(uint8_t * addr, int len)
{
  102b48:	83 ec 10             	sub    $0x10,%esp
	uint8_t *e, *p;

	e = addr + len;
	for (p = addr; p < e; p += sizeof(struct mp))
  102b4b:	39 f0                	cmp    %esi,%eax
  102b4d:	73 3a                	jae    102b89 <mpsearch1+0x49>
  102b4f:	90                   	nop
		if (memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  102b50:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  102b57:	00 
  102b58:	c7 44 24 04 d7 b4 10 	movl   $0x10b4d7,0x4(%esp)
  102b5f:	00 
  102b60:	89 3c 24             	mov    %edi,(%esp)
  102b63:	e8 48 14 00 00       	call   103fb0 <memcmp>
  102b68:	85 c0                	test   %eax,%eax
  102b6a:	75 16                	jne    102b82 <mpsearch1+0x42>
  102b6c:	31 c9                	xor    %ecx,%ecx
  102b6e:	31 d2                	xor    %edx,%edx
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++)
		sum += addr[i];
  102b70:	0f b6 1c 17          	movzbl (%edi,%edx,1),%ebx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++)
  102b74:	83 c2 01             	add    $0x1,%edx
		sum += addr[i];
  102b77:	01 d9                	add    %ebx,%ecx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++)
  102b79:	83 fa 10             	cmp    $0x10,%edx
  102b7c:	75 f2                	jne    102b70 <mpsearch1+0x30>
{
	uint8_t *e, *p;

	e = addr + len;
	for (p = addr; p < e; p += sizeof(struct mp))
		if (memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  102b7e:	84 c9                	test   %cl,%cl
  102b80:	74 10                	je     102b92 <mpsearch1+0x52>
mpsearch1(uint8_t * addr, int len)
{
	uint8_t *e, *p;

	e = addr + len;
	for (p = addr; p < e; p += sizeof(struct mp))
  102b82:	83 c7 10             	add    $0x10,%edi
  102b85:	39 fe                	cmp    %edi,%esi
  102b87:	77 c7                	ja     102b50 <mpsearch1+0x10>
		if (memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
			return (struct mp *) p;
	return 0;
}
  102b89:	83 c4 10             	add    $0x10,%esp

	e = addr + len;
	for (p = addr; p < e; p += sizeof(struct mp))
		if (memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
			return (struct mp *) p;
	return 0;
  102b8c:	31 c0                	xor    %eax,%eax
}
  102b8e:	5b                   	pop    %ebx
  102b8f:	5e                   	pop    %esi
  102b90:	5f                   	pop    %edi
  102b91:	c3                   	ret    
  102b92:	83 c4 10             	add    $0x10,%esp
  102b95:	89 f8                	mov    %edi,%eax
  102b97:	5b                   	pop    %ebx
  102b98:	5e                   	pop    %esi
  102b99:	5f                   	pop    %edi
  102b9a:	c3                   	ret    
  102b9b:	90                   	nop
  102b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00102ba0 <pcpu_mp_init>:
	acpi_xsdt_t *xsdt;
	acpi_madt_t *madt;
	uint32_t ap_idx = 1;
	bool found_bsp=FALSE;

	if (mp_inited == TRUE)
  102ba0:	80 3d 69 fe 13 00 01 	cmpb   $0x1,0x13fe69
		return TRUE;
  102ba7:	b8 01 00 00 00       	mov    $0x1,%eax
	acpi_xsdt_t *xsdt;
	acpi_madt_t *madt;
	uint32_t ap_idx = 1;
	bool found_bsp=FALSE;

	if (mp_inited == TRUE)
  102bac:	0f 84 59 01 00 00    	je     102d0b <pcpu_mp_init+0x16b>
 * multiple processors initialization method using ACPI
 */

bool
pcpu_mp_init(void)
{
  102bb2:	55                   	push   %ebp
  102bb3:	57                   	push   %edi
  102bb4:	56                   	push   %esi
  102bb5:	53                   	push   %ebx
  102bb6:	83 ec 2c             	sub    $0x2c,%esp
	bool found_bsp=FALSE;

	if (mp_inited == TRUE)
		return TRUE;

	KERN_INFO("\n");
  102bb9:	c7 04 24 04 c3 10 00 	movl   $0x10c304,(%esp)
  102bc0:	e8 2b 15 00 00       	call   1040f0 <debug_info>

	if ((rsdp = acpi_probe_rsdp()) == NULL) {
  102bc5:	e8 e6 f4 ff ff       	call   1020b0 <acpi_probe_rsdp>
  102bca:	85 c0                	test   %eax,%eax
  102bcc:	89 c3                	mov    %eax,%ebx
  102bce:	0f 84 bc 01 00 00    	je     102d90 <pcpu_mp_init+0x1f0>
		KERN_DEBUG("Not found RSDP.\n");
		goto fallback;
	}

	xsdt = NULL;
	if ((xsdt = acpi_probe_xsdt(rsdp)) == NULL &&
  102bd4:	89 04 24             	mov    %eax,(%esp)
  102bd7:	e8 44 f6 ff ff       	call   102220 <acpi_probe_xsdt>
  102bdc:	85 c0                	test   %eax,%eax
  102bde:	0f 84 1d 04 00 00    	je     103001 <pcpu_mp_init+0x461>
		goto fallback;
	}

	if ((madt =
	     (xsdt != NULL) ?
	     (acpi_madt_t *) acpi_probe_xsdt_ent(xsdt, ACPI_MADT_SIG) :
  102be4:	c7 44 24 04 41 50 49 	movl   $0x43495041,0x4(%esp)
  102beb:	43 
  102bec:	89 04 24             	mov    %eax,(%esp)
  102bef:	e8 9c f6 ff ff       	call   102290 <acpi_probe_xsdt_ent>
  102bf4:	89 c7                	mov    %eax,%edi
	    (rsdt = acpi_probe_rsdt(rsdp)) == NULL) {
		KERN_DEBUG("Not found either RSDT or XSDT.\n");
		goto fallback;
	}

	if ((madt =
  102bf6:	85 ff                	test   %edi,%edi
  102bf8:	0f 84 8a 03 00 00    	je     102f88 <pcpu_mp_init+0x3e8>
		goto fallback;
	}

	ismp = TRUE;

	lapic_register(madt->lapic_addr);
  102bfe:	8b 47 24             	mov    0x24(%edi),%eax

	ncpu = 0;

	p = (uint8_t *)madt->ent;
  102c01:	8d 5f 2c             	lea    0x2c(%edi),%ebx
	uint8_t *p, *e;
	acpi_rsdp_t *rsdp;
	acpi_rsdt_t *rsdt;
	acpi_xsdt_t *xsdt;
	acpi_madt_t *madt;
	uint32_t ap_idx = 1;
  102c04:	bd 01 00 00 00       	mov    $0x1,%ebp
	     (acpi_madt_t *) acpi_probe_rsdt_ent(rsdt, ACPI_MADT_SIG)) == NULL) {
		KERN_DEBUG("Not found MADT.\n");
		goto fallback;
	}

	ismp = TRUE;
  102c09:	c6 05 68 fe 13 00 01 	movb   $0x1,0x13fe68

	lapic_register(madt->lapic_addr);
  102c10:	89 04 24             	mov    %eax,(%esp)
  102c13:	e8 18 f7 ff ff       	call   102330 <lapic_register>

	ncpu = 0;

	p = (uint8_t *)madt->ent;
	e = (uint8_t *)madt + madt->length;
  102c18:	8b 77 04             	mov    0x4(%edi),%esi

	ismp = TRUE;

	lapic_register(madt->lapic_addr);

	ncpu = 0;
  102c1b:	c7 05 6c fe 13 00 00 	movl   $0x0,0x13fe6c
  102c22:	00 00 00 
	acpi_rsdp_t *rsdp;
	acpi_rsdt_t *rsdt;
	acpi_xsdt_t *xsdt;
	acpi_madt_t *madt;
	uint32_t ap_idx = 1;
	bool found_bsp=FALSE;
  102c25:	c6 44 24 1c 00       	movb   $0x0,0x1c(%esp)
	lapic_register(madt->lapic_addr);

	ncpu = 0;

	p = (uint8_t *)madt->ent;
	e = (uint8_t *)madt + madt->length;
  102c2a:	01 fe                	add    %edi,%esi

	while (p < e) {
  102c2c:	39 f3                	cmp    %esi,%ebx
  102c2e:	72 47                	jb     102c77 <pcpu_mp_init+0xd7>
  102c30:	eb 6e                	jmp    102ca0 <pcpu_mp_init+0x100>
  102c32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		case ACPI_MADT_APIC_IOAPIC:
			;
			acpi_madt_ioapic_t *
				ioapic_ent = (acpi_madt_ioapic_t *)hdr;

			KERN_INFO("\tIOAPIC: APIC id = %x, base = %x\n",
  102c38:	8b 43 04             	mov    0x4(%ebx),%eax
  102c3b:	89 44 24 08          	mov    %eax,0x8(%esp)
  102c3f:	0f b6 43 02          	movzbl 0x2(%ebx),%eax
  102c43:	c7 04 24 00 b3 10 00 	movl   $0x10b300,(%esp)
  102c4a:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c4e:	e8 9d 14 00 00       	call   1040f0 <debug_info>
				  ioapic_ent->ioapic_id, ioapic_ent->ioapic_addr);

			ioapic_register(ioapic_ent->ioapic_addr,
  102c53:	8b 43 08             	mov    0x8(%ebx),%eax
  102c56:	89 44 24 08          	mov    %eax,0x8(%esp)
  102c5a:	0f b6 43 02          	movzbl 0x2(%ebx),%eax
  102c5e:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c62:	8b 43 04             	mov    0x4(%ebx),%eax
  102c65:	89 04 24             	mov    %eax,(%esp)
  102c68:	e8 73 fb ff ff       	call   1027e0 <ioapic_register>
			KERN_INFO("\tUnhandled ACPI entry (type=%x)\n",
				  hdr->type);
			break;
		}

		p += hdr->length;
  102c6d:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
  102c71:	01 c3                	add    %eax,%ebx
	ncpu = 0;

	p = (uint8_t *)madt->ent;
	e = (uint8_t *)madt + madt->length;

	while (p < e) {
  102c73:	39 de                	cmp    %ebx,%esi
  102c75:	76 29                	jbe    102ca0 <pcpu_mp_init+0x100>
		acpi_madt_apic_hdr_t * hdr = (acpi_madt_apic_hdr_t *) p;

		switch (hdr->type) {
  102c77:	0f b6 03             	movzbl (%ebx),%eax
  102c7a:	84 c0                	test   %al,%al
  102c7c:	0f 84 8e 00 00 00    	je     102d10 <pcpu_mp_init+0x170>
  102c82:	3c 01                	cmp    $0x1,%al
  102c84:	74 b2                	je     102c38 <pcpu_mp_init+0x98>

			break;

		default:
			;
			KERN_INFO("\tUnhandled ACPI entry (type=%x)\n",
  102c86:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c8a:	c7 04 24 24 b3 10 00 	movl   $0x10b324,(%esp)
  102c91:	e8 5a 14 00 00       	call   1040f0 <debug_info>
				  hdr->type);
			break;
		}

		p += hdr->length;
  102c96:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
  102c9a:	01 c3                	add    %eax,%ebx
	ncpu = 0;

	p = (uint8_t *)madt->ent;
	e = (uint8_t *)madt + madt->length;

	while (p < e) {
  102c9c:	39 de                	cmp    %ebx,%esi
  102c9e:	77 d7                	ja     102c77 <pcpu_mp_init+0xd7>
	/*
	 * Force NMI and 8259 signals to APIC when PIC mode
	 * is not implemented.
	 *
	 */
	if ((madt->flags & APIC_MADT_PCAT_COMPAT) == 0) {
  102ca0:	f6 47 28 01          	testb  $0x1,0x28(%edi)
  102ca4:	75 36                	jne    102cdc <pcpu_mp_init+0x13c>
		outb(0x22, 0x70);
  102ca6:	c7 44 24 04 70 00 00 	movl   $0x70,0x4(%esp)
  102cad:	00 
  102cae:	c7 04 24 22 00 00 00 	movl   $0x22,(%esp)
  102cb5:	e8 a6 23 00 00       	call   105060 <outb>
		outb(0x23, inb(0x23) | 1);
  102cba:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
  102cc1:	e8 6a 23 00 00       	call   105030 <inb>
  102cc6:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
  102ccd:	83 c8 01             	or     $0x1,%eax
  102cd0:	0f b6 c0             	movzbl %al,%eax
  102cd3:	89 44 24 04          	mov    %eax,0x4(%esp)
  102cd7:	e8 84 23 00 00       	call   105060 <outb>
	}

	/*
	 * Copy AP boot code to 0x8000.
	 */
	memmove((uint8_t *)0x8000,
  102cdc:	c7 44 24 08 62 00 00 	movl   $0x62,0x8(%esp)
  102ce3:	00 
  102ce4:	c7 44 24 04 04 ee 13 	movl   $0x13ee04,0x4(%esp)
  102ceb:	00 
  102cec:	c7 04 24 00 80 00 00 	movl   $0x8000,(%esp)
  102cf3:	e8 d8 10 00 00       	call   103dd0 <memmove>
	       _binary___obj_kern_init_boot_ap_start,
		(size_t)_binary___obj_kern_init_boot_ap_size);

	mp_inited = TRUE;

	return TRUE;
  102cf8:	b8 01 00 00 00       	mov    $0x1,%eax
	 */
	memmove((uint8_t *)0x8000,
	       _binary___obj_kern_init_boot_ap_start,
		(size_t)_binary___obj_kern_init_boot_ap_size);

	mp_inited = TRUE;
  102cfd:	c6 05 69 fe 13 00 01 	movb   $0x1,0x13fe69
		ismp = 0;
		ncpu = 1;
		return FALSE;
	} else
		return TRUE;
}
  102d04:	83 c4 2c             	add    $0x2c,%esp
  102d07:	5b                   	pop    %ebx
  102d08:	5e                   	pop    %esi
  102d09:	5f                   	pop    %edi
  102d0a:	5d                   	pop    %ebp
  102d0b:	f3 c3                	repz ret 
  102d0d:	8d 76 00             	lea    0x0(%esi),%esi
		case ACPI_MADT_APIC_LAPIC:
			;
			acpi_madt_lapic_t *
				lapic_ent = (acpi_madt_lapic_t *) hdr;

			if (!(lapic_ent->flags & ACPI_APIC_ENABLED)) {
  102d10:	f6 43 04 01          	testb  $0x1,0x4(%ebx)
  102d14:	0f 84 53 ff ff ff    	je     102c6d <pcpu_mp_init+0xcd>
				/* KERN_DEBUG("CPU is disabled.\n"); */
				break;
			}

			KERN_INFO("\tCPU%d: APIC id = %x, ",
  102d1a:	0f b6 43 03          	movzbl 0x3(%ebx),%eax
  102d1e:	c7 04 24 fe b4 10 00 	movl   $0x10b4fe,(%esp)
  102d25:	89 44 24 08          	mov    %eax,0x8(%esp)
  102d29:	a1 6c fe 13 00       	mov    0x13fe6c,%eax
  102d2e:	89 44 24 04          	mov    %eax,0x4(%esp)
  102d32:	e8 b9 13 00 00       	call   1040f0 <debug_info>
				  ncpu, lapic_ent->lapic_id);

			//according to acpi p.138, section 5.2.12.1,
			//"platform firmware should list the boot processor as the first processor entry in the MADT"
			if (!found_bsp) {
  102d37:	80 7c 24 1c 00       	cmpb   $0x0,0x1c(%esp)
  102d3c:	75 32                	jne    102d70 <pcpu_mp_init+0x1d0>
				found_bsp=TRUE;
				KERN_INFO("BSP\n");
  102d3e:	c7 04 24 15 b5 10 00 	movl   $0x10b515,(%esp)
  102d45:	e8 a6 13 00 00       	call   1040f0 <debug_info>
				pcpu_mp_init_cpu(0, lapic_ent->lapic_id, TRUE);
  102d4a:	0f b6 53 03          	movzbl 0x3(%ebx),%edx
  102d4e:	b9 01 00 00 00       	mov    $0x1,%ecx
  102d53:	31 c0                	xor    %eax,%eax
  102d55:	e8 66 fd ff ff       	call   102ac0 <pcpu_mp_init_cpu>
				  ncpu, lapic_ent->lapic_id);

			//according to acpi p.138, section 5.2.12.1,
			//"platform firmware should list the boot processor as the first processor entry in the MADT"
			if (!found_bsp) {
				found_bsp=TRUE;
  102d5a:	c6 44 24 1c 01       	movb   $0x1,0x1c(%esp)
				pcpu_mp_init_cpu
					(ap_idx, lapic_ent->lapic_id, FALSE);
				ap_idx++;
			}

			ncpu++;
  102d5f:	83 05 6c fe 13 00 01 	addl   $0x1,0x13fe6c

			break;
  102d66:	e9 02 ff ff ff       	jmp    102c6d <pcpu_mp_init+0xcd>
  102d6b:	90                   	nop
  102d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			if (!found_bsp) {
				found_bsp=TRUE;
				KERN_INFO("BSP\n");
				pcpu_mp_init_cpu(0, lapic_ent->lapic_id, TRUE);
			} else {
				KERN_INFO("AP\n");
  102d70:	c7 04 24 1a b5 10 00 	movl   $0x10b51a,(%esp)
  102d77:	e8 74 13 00 00       	call   1040f0 <debug_info>
				pcpu_mp_init_cpu
					(ap_idx, lapic_ent->lapic_id, FALSE);
  102d7c:	0f b6 53 03          	movzbl 0x3(%ebx),%edx
  102d80:	89 e8                	mov    %ebp,%eax
  102d82:	31 c9                	xor    %ecx,%ecx
				ap_idx++;
  102d84:	83 c5 01             	add    $0x1,%ebp
				KERN_INFO("BSP\n");
				pcpu_mp_init_cpu(0, lapic_ent->lapic_id, TRUE);
			} else {
				KERN_INFO("AP\n");
				pcpu_mp_init_cpu
					(ap_idx, lapic_ent->lapic_id, FALSE);
  102d87:	e8 34 fd ff ff       	call   102ac0 <pcpu_mp_init_cpu>
  102d8c:	eb d1                	jmp    102d5f <pcpu_mp_init+0x1bf>
  102d8e:	66 90                	xchg   %ax,%ax
		return TRUE;

	KERN_INFO("\n");

	if ((rsdp = acpi_probe_rsdp()) == NULL) {
		KERN_DEBUG("Not found RSDP.\n");
  102d90:	c7 44 24 08 dc b4 10 	movl   $0x10b4dc,0x8(%esp)
  102d97:	00 
  102d98:	c7 44 24 04 67 01 00 	movl   $0x167,0x4(%esp)
  102d9f:	00 
  102da0:	c7 04 24 c4 b4 10 00 	movl   $0x10b4c4,(%esp)
  102da7:	e8 84 13 00 00       	call   104130 <debug_normal>
	mp_inited = TRUE;

	return TRUE;

 fallback:
	KERN_DEBUG("Use the fallback multiprocessor initialization.\n");
  102dac:	c7 44 24 08 48 b3 10 	movl   $0x10b348,0x8(%esp)
  102db3:	00 
  102db4:	c7 44 24 04 d3 01 00 	movl   $0x1d3,0x4(%esp)
  102dbb:	00 
  102dbc:	c7 04 24 c4 b4 10 00 	movl   $0x10b4c4,(%esp)
  102dc3:	e8 68 13 00 00       	call   104130 <debug_normal>
	struct mpconf  *conf;
	struct mpproc  *proc;
	struct mpioapic *mpio;
	uint32_t ap_idx = 1;

	if (mp_inited == TRUE)
  102dc8:	80 3d 69 fe 13 00 01 	cmpb   $0x1,0x13fe69
  102dcf:	0f 84 27 01 00 00    	je     102efc <pcpu_mp_init+0x35c>
	uint8_t          *bda;
	uint32_t            p;
	struct mp      *mp;

	bda = (uint8_t *) 0x400;
	if ((p = ((bda[0x0F] << 8) | bda[0x0E]) << 4)) {
  102dd5:	0f b6 05 0f 04 00 00 	movzbl 0x40f,%eax
  102ddc:	0f b6 15 0e 04 00 00 	movzbl 0x40e,%edx
  102de3:	c1 e0 08             	shl    $0x8,%eax
  102de6:	09 d0                	or     %edx,%eax
  102de8:	c1 e0 04             	shl    $0x4,%eax
  102deb:	85 c0                	test   %eax,%eax
  102ded:	75 1b                	jne    102e0a <pcpu_mp_init+0x26a>
		if ((mp = mpsearch1((uint8_t *) p, 1024)))
			return mp;
	} else {
		p = ((bda[0x14] << 8) | bda[0x13]) * 1024;
  102def:	0f b6 05 14 04 00 00 	movzbl 0x414,%eax
  102df6:	0f b6 15 13 04 00 00 	movzbl 0x413,%edx
  102dfd:	c1 e0 08             	shl    $0x8,%eax
  102e00:	09 d0                	or     %edx,%eax
  102e02:	c1 e0 0a             	shl    $0xa,%eax
		if ((mp = mpsearch1((uint8_t *) p - 1024, 1024)))
  102e05:	2d 00 04 00 00       	sub    $0x400,%eax
	uint32_t            p;
	struct mp      *mp;

	bda = (uint8_t *) 0x400;
	if ((p = ((bda[0x0F] << 8) | bda[0x0E]) << 4)) {
		if ((mp = mpsearch1((uint8_t *) p, 1024)))
  102e0a:	ba 00 04 00 00       	mov    $0x400,%edx
  102e0f:	e8 2c fd ff ff       	call   102b40 <mpsearch1>
  102e14:	85 c0                	test   %eax,%eax
  102e16:	89 c7                	mov    %eax,%edi
  102e18:	0f 84 83 02 00 00    	je     1030a1 <pcpu_mp_init+0x501>
static struct mpconf *
mpconfig(struct mp **pmp) {
	struct mpconf  *conf;
	struct mp      *mp;

	if ((mp = mpsearch()) == 0 || mp->physaddr == 0)
  102e1e:	8b 5f 04             	mov    0x4(%edi),%ebx
  102e21:	85 db                	test   %ebx,%ebx
  102e23:	0f 84 25 02 00 00    	je     10304e <pcpu_mp_init+0x4ae>
		return 0;
	conf = (struct mpconf *) mp->physaddr;
	if (memcmp(conf, "PCMP", 4) != 0)
  102e29:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  102e30:	00 
  102e31:	c7 44 24 04 1e b5 10 	movl   $0x10b51e,0x4(%esp)
  102e38:	00 
  102e39:	89 1c 24             	mov    %ebx,(%esp)
  102e3c:	e8 6f 11 00 00       	call   103fb0 <memcmp>
  102e41:	85 c0                	test   %eax,%eax
  102e43:	0f 85 05 02 00 00    	jne    10304e <pcpu_mp_init+0x4ae>
		return 0;
	if (conf->version != 1 && conf->version != 4)
  102e49:	0f b6 43 06          	movzbl 0x6(%ebx),%eax
  102e4d:	3c 04                	cmp    $0x4,%al
  102e4f:	0f 85 f1 01 00 00    	jne    103046 <pcpu_mp_init+0x4a6>
		return 0;
	if (sum((uint8_t *) conf, conf->length) != 0)
  102e55:	0f b7 73 04          	movzwl 0x4(%ebx),%esi
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++)
  102e59:	85 f6                	test   %esi,%esi
  102e5b:	74 20                	je     102e7d <pcpu_mp_init+0x2dd>
static uint8_t
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
  102e5d:	31 d2                	xor    %edx,%edx
	for (i = 0; i < len; i++)
  102e5f:	31 c0                	xor    %eax,%eax
  102e61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		sum += addr[i];
  102e68:	0f b6 0c 03          	movzbl (%ebx,%eax,1),%ecx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++)
  102e6c:	83 c0 01             	add    $0x1,%eax
		sum += addr[i];
  102e6f:	01 ca                	add    %ecx,%edx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++)
  102e71:	39 c6                	cmp    %eax,%esi
  102e73:	7f f3                	jg     102e68 <pcpu_mp_init+0x2c8>
	conf = (struct mpconf *) mp->physaddr;
	if (memcmp(conf, "PCMP", 4) != 0)
		return 0;
	if (conf->version != 1 && conf->version != 4)
		return 0;
	if (sum((uint8_t *) conf, conf->length) != 0)
  102e75:	84 d2                	test   %dl,%dl
  102e77:	0f 85 d1 01 00 00    	jne    10304e <pcpu_mp_init+0x4ae>

	ismp = 1;

	ncpu = 0;

	lapic_register((uintptr_t) conf->lapicaddr);
  102e7d:	8b 43 24             	mov    0x24(%ebx),%eax

	for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length;
  102e80:	8d 6b 2c             	lea    0x2c(%ebx),%ebp
		return TRUE;

	if ((conf = mpconfig(&mp)) == 0) /* not SMP */
		return FALSE;

	ismp = 1;
  102e83:	c6 05 68 fe 13 00 01 	movb   $0x1,0x13fe68

	ncpu = 0;
  102e8a:	c7 05 6c fe 13 00 00 	movl   $0x0,0x13fe6c
  102e91:	00 00 00 

	lapic_register((uintptr_t) conf->lapicaddr);
  102e94:	89 04 24             	mov    %eax,(%esp)
  102e97:	e8 94 f4 ff ff       	call   102330 <lapic_register>

	for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length;
  102e9c:	0f b7 53 04          	movzwl 0x4(%ebx),%edx
  102ea0:	01 d3                	add    %edx,%ebx
  102ea2:	39 dd                	cmp    %ebx,%ebp
  102ea4:	73 29                	jae    102ecf <pcpu_mp_init+0x32f>
	uint8_t *p, *e;
	struct mp      *mp;
	struct mpconf  *conf;
	struct mpproc  *proc;
	struct mpioapic *mpio;
	uint32_t ap_idx = 1;
  102ea6:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  102ead:	00 
  102eae:	66 90                	xchg   %ax,%ax

	lapic_register((uintptr_t) conf->lapicaddr);

	for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length;
	     p < e;) {
		switch (*p) {
  102eb0:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
  102eb4:	3c 04                	cmp    $0x4,%al
  102eb6:	0f 87 a4 00 00 00    	ja     102f60 <pcpu_mp_init+0x3c0>
  102ebc:	ff 24 85 a0 b5 10 00 	jmp    *0x10b5a0(,%eax,4)
  102ec3:	90                   	nop
  102ec4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
					mpio->apicno, 0);
			continue;
		case MPBUS:
		case MPIOINTR:
		case MPLINTR:
			p += 8;
  102ec8:	83 c5 08             	add    $0x8,%ebp

	ncpu = 0;

	lapic_register((uintptr_t) conf->lapicaddr);

	for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length;
  102ecb:	39 eb                	cmp    %ebp,%ebx
  102ecd:	77 e1                	ja     102eb0 <pcpu_mp_init+0x310>
		default:
			KERN_WARN("mpinit: unknown config type %x\n", *p);
		}
	}

	if (mp->imcrp) {
  102ecf:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
  102ed3:	0f 85 8d 01 00 00    	jne    103066 <pcpu_mp_init+0x4c6>
	}

	/*
	 * Copy AP boot code to 0x8000.
	 */
	memcpy((uint8_t *)0x8000,
  102ed9:	c7 44 24 08 62 00 00 	movl   $0x62,0x8(%esp)
  102ee0:	00 
  102ee1:	c7 44 24 04 04 ee 13 	movl   $0x13ee04,0x4(%esp)
  102ee8:	00 
  102ee9:	c7 04 24 00 80 00 00 	movl   $0x8000,(%esp)
  102ef0:	e8 4b 0f 00 00       	call   103e40 <memcpy>
	       _binary___obj_kern_init_boot_ap_start,
	       (size_t)_binary___obj_kern_init_boot_ap_size);

	mp_inited = TRUE;
  102ef5:	c6 05 69 fe 13 00 01 	movb   $0x1,0x13fe69
	if (mp_init_fallback() == FALSE) {
		ismp = 0;
		ncpu = 1;
		return FALSE;
	} else
		return TRUE;
  102efc:	b8 01 00 00 00       	mov    $0x1,%eax
  102f01:	e9 fe fd ff ff       	jmp    102d04 <pcpu_mp_init+0x164>
  102f06:	66 90                	xchg   %ax,%ax
	     p < e;) {
		switch (*p) {
		case MPPROC:
			proc = (struct mpproc *) p;
			p += sizeof(struct mpproc);
			if (!(proc->flags & MPENAB))
  102f08:	f6 45 03 01          	testb  $0x1,0x3(%ebp)
	for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length;
	     p < e;) {
		switch (*p) {
		case MPPROC:
			proc = (struct mpproc *) p;
			p += sizeof(struct mpproc);
  102f0c:	8d 75 14             	lea    0x14(%ebp),%esi
			if (!(proc->flags & MPENAB))
  102f0f:	0f 85 9b 00 00 00    	jne    102fb0 <pcpu_mp_init+0x410>
	for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length;
	     p < e;) {
		switch (*p) {
		case MPPROC:
			proc = (struct mpproc *) p;
			p += sizeof(struct mpproc);
  102f15:	89 f5                	mov    %esi,%ebp
  102f17:	eb b2                	jmp    102ecb <pcpu_mp_init+0x32b>
  102f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			continue;
		case MPIOAPIC:
			mpio = (struct mpioapic *) p;
			p += sizeof(struct mpioapic);

			KERN_INFO("\tIOAPIC: APIC id = %x, base = %x\n",
  102f20:	8b 45 04             	mov    0x4(%ebp),%eax
			}
			ncpu++;
			continue;
		case MPIOAPIC:
			mpio = (struct mpioapic *) p;
			p += sizeof(struct mpioapic);
  102f23:	8d 75 08             	lea    0x8(%ebp),%esi

			KERN_INFO("\tIOAPIC: APIC id = %x, base = %x\n",
  102f26:	89 44 24 08          	mov    %eax,0x8(%esp)
  102f2a:	0f b6 45 01          	movzbl 0x1(%ebp),%eax
  102f2e:	c7 04 24 00 b3 10 00 	movl   $0x10b300,(%esp)
  102f35:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f39:	e8 b2 11 00 00       	call   1040f0 <debug_info>
				  mpio->apicno, mpio->addr);

			ioapic_register((uintptr_t) mpio->addr,
  102f3e:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  102f45:	00 
  102f46:	0f b6 45 01          	movzbl 0x1(%ebp),%eax
  102f4a:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f4e:	8b 45 04             	mov    0x4(%ebp),%eax
			}
			ncpu++;
			continue;
		case MPIOAPIC:
			mpio = (struct mpioapic *) p;
			p += sizeof(struct mpioapic);
  102f51:	89 f5                	mov    %esi,%ebp

			KERN_INFO("\tIOAPIC: APIC id = %x, base = %x\n",
				  mpio->apicno, mpio->addr);

			ioapic_register((uintptr_t) mpio->addr,
  102f53:	89 04 24             	mov    %eax,(%esp)
  102f56:	e8 85 f8 ff ff       	call   1027e0 <ioapic_register>
  102f5b:	e9 6b ff ff ff       	jmp    102ecb <pcpu_mp_init+0x32b>
		case MPIOINTR:
		case MPLINTR:
			p += 8;
			continue;
		default:
			KERN_WARN("mpinit: unknown config type %x\n", *p);
  102f60:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102f64:	c7 44 24 08 7c b3 10 	movl   $0x10b37c,0x8(%esp)
  102f6b:	00 
  102f6c:	c7 44 24 04 3c 01 00 	movl   $0x13c,0x4(%esp)
  102f73:	00 
  102f74:	c7 04 24 c4 b4 10 00 	movl   $0x10b4c4,(%esp)
  102f7b:	e8 d0 12 00 00       	call   104250 <debug_warn>
  102f80:	e9 46 ff ff ff       	jmp    102ecb <pcpu_mp_init+0x32b>
  102f85:	8d 76 00             	lea    0x0(%esi),%esi

	if ((madt =
	     (xsdt != NULL) ?
	     (acpi_madt_t *) acpi_probe_xsdt_ent(xsdt, ACPI_MADT_SIG) :
	     (acpi_madt_t *) acpi_probe_rsdt_ent(rsdt, ACPI_MADT_SIG)) == NULL) {
		KERN_DEBUG("Not found MADT.\n");
  102f88:	c7 44 24 08 ed b4 10 	movl   $0x10b4ed,0x8(%esp)
  102f8f:	00 
  102f90:	c7 44 24 04 76 01 00 	movl   $0x176,0x4(%esp)
  102f97:	00 
  102f98:	c7 04 24 c4 b4 10 00 	movl   $0x10b4c4,(%esp)
  102f9f:	e8 8c 11 00 00       	call   104130 <debug_normal>
		goto fallback;
  102fa4:	e9 03 fe ff ff       	jmp    102dac <pcpu_mp_init+0x20c>
  102fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			proc = (struct mpproc *) p;
			p += sizeof(struct mpproc);
			if (!(proc->flags & MPENAB))
				continue;

			KERN_INFO("\tCPU%d: APIC id = %x, ",
  102fb0:	0f b6 45 01          	movzbl 0x1(%ebp),%eax
  102fb4:	c7 04 24 fe b4 10 00 	movl   $0x10b4fe,(%esp)
  102fbb:	89 44 24 08          	mov    %eax,0x8(%esp)
  102fbf:	a1 6c fe 13 00       	mov    0x13fe6c,%eax
  102fc4:	89 44 24 04          	mov    %eax,0x4(%esp)
  102fc8:	e8 23 11 00 00       	call   1040f0 <debug_info>
				  ncpu, proc->apicid);

			if (proc->flags & MPBOOT) {
  102fcd:	f6 45 03 02          	testb  $0x2,0x3(%ebp)
  102fd1:	75 55                	jne    103028 <pcpu_mp_init+0x488>
				KERN_INFO("BSP.\n");
				pcpu_mp_init_cpu(0, proc->apicid, TRUE);
			} else {
				KERN_INFO("AP.\n");
  102fd3:	c7 04 24 29 b5 10 00 	movl   $0x10b529,(%esp)
  102fda:	e8 11 11 00 00       	call   1040f0 <debug_info>
				pcpu_mp_init_cpu(ap_idx, proc->apicid, FALSE);
  102fdf:	0f b6 55 01          	movzbl 0x1(%ebp),%edx
  102fe3:	31 c9                	xor    %ecx,%ecx
  102fe5:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  102fe9:	e8 d2 fa ff ff       	call   102ac0 <pcpu_mp_init_cpu>
				ap_idx++;
  102fee:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
			}
			ncpu++;
  102ff3:	83 05 6c fe 13 00 01 	addl   $0x1,0x13fe6c
	for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length;
	     p < e;) {
		switch (*p) {
		case MPPROC:
			proc = (struct mpproc *) p;
			p += sizeof(struct mpproc);
  102ffa:	89 f5                	mov    %esi,%ebp
  102ffc:	e9 ca fe ff ff       	jmp    102ecb <pcpu_mp_init+0x32b>
		KERN_DEBUG("Not found RSDP.\n");
		goto fallback;
	}

	xsdt = NULL;
	if ((xsdt = acpi_probe_xsdt(rsdp)) == NULL &&
  103001:	89 1c 24             	mov    %ebx,(%esp)
  103004:	e8 e7 f0 ff ff       	call   1020f0 <acpi_probe_rsdt>
  103009:	85 c0                	test   %eax,%eax
  10300b:	0f 84 ab 00 00 00    	je     1030bc <pcpu_mp_init+0x51c>
		goto fallback;
	}

	if ((madt =
	     (xsdt != NULL) ?
	     (acpi_madt_t *) acpi_probe_xsdt_ent(xsdt, ACPI_MADT_SIG) :
  103011:	c7 44 24 04 41 50 49 	movl   $0x43495041,0x4(%esp)
  103018:	43 
  103019:	89 04 24             	mov    %eax,(%esp)
  10301c:	e8 4f f1 ff ff       	call   102170 <acpi_probe_rsdt_ent>
  103021:	89 c7                	mov    %eax,%edi
  103023:	e9 ce fb ff ff       	jmp    102bf6 <pcpu_mp_init+0x56>

			KERN_INFO("\tCPU%d: APIC id = %x, ",
				  ncpu, proc->apicid);

			if (proc->flags & MPBOOT) {
				KERN_INFO("BSP.\n");
  103028:	c7 04 24 23 b5 10 00 	movl   $0x10b523,(%esp)
  10302f:	e8 bc 10 00 00       	call   1040f0 <debug_info>
				pcpu_mp_init_cpu(0, proc->apicid, TRUE);
  103034:	0f b6 55 01          	movzbl 0x1(%ebp),%edx
  103038:	b9 01 00 00 00       	mov    $0x1,%ecx
  10303d:	31 c0                	xor    %eax,%eax
  10303f:	e8 7c fa ff ff       	call   102ac0 <pcpu_mp_init_cpu>
  103044:	eb ad                	jmp    102ff3 <pcpu_mp_init+0x453>
	if ((mp = mpsearch()) == 0 || mp->physaddr == 0)
		return 0;
	conf = (struct mpconf *) mp->physaddr;
	if (memcmp(conf, "PCMP", 4) != 0)
		return 0;
	if (conf->version != 1 && conf->version != 4)
  103046:	3c 01                	cmp    $0x1,%al
  103048:	0f 84 07 fe ff ff    	je     102e55 <pcpu_mp_init+0x2b5>
	return TRUE;

 fallback:
	KERN_DEBUG("Use the fallback multiprocessor initialization.\n");
	if (mp_init_fallback() == FALSE) {
		ismp = 0;
  10304e:	c6 05 68 fe 13 00 00 	movb   $0x0,0x13fe68
		ncpu = 1;
		return FALSE;
  103055:	31 c0                	xor    %eax,%eax

 fallback:
	KERN_DEBUG("Use the fallback multiprocessor initialization.\n");
	if (mp_init_fallback() == FALSE) {
		ismp = 0;
		ncpu = 1;
  103057:	c7 05 6c fe 13 00 01 	movl   $0x1,0x13fe6c
  10305e:	00 00 00 
		return FALSE;
  103061:	e9 9e fc ff ff       	jmp    102d04 <pcpu_mp_init+0x164>
			KERN_WARN("mpinit: unknown config type %x\n", *p);
		}
	}

	if (mp->imcrp) {
		outb(0x22, 0x70);
  103066:	c7 44 24 04 70 00 00 	movl   $0x70,0x4(%esp)
  10306d:	00 
  10306e:	c7 04 24 22 00 00 00 	movl   $0x22,(%esp)
  103075:	e8 e6 1f 00 00       	call   105060 <outb>
		outb(0x23, inb(0x23) | 1);
  10307a:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
  103081:	e8 aa 1f 00 00       	call   105030 <inb>
  103086:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
  10308d:	83 c8 01             	or     $0x1,%eax
  103090:	0f b6 c0             	movzbl %al,%eax
  103093:	89 44 24 04          	mov    %eax,0x4(%esp)
  103097:	e8 c4 1f 00 00       	call   105060 <outb>
  10309c:	e9 38 fe ff ff       	jmp    102ed9 <pcpu_mp_init+0x339>
	} else {
		p = ((bda[0x14] << 8) | bda[0x13]) * 1024;
		if ((mp = mpsearch1((uint8_t *) p - 1024, 1024)))
			return mp;
	}
	return mpsearch1((uint8_t *) 0xF0000, 0x10000);
  1030a1:	ba 00 00 01 00       	mov    $0x10000,%edx
  1030a6:	b8 00 00 0f 00       	mov    $0xf0000,%eax
  1030ab:	e8 90 fa ff ff       	call   102b40 <mpsearch1>
static struct mpconf *
mpconfig(struct mp **pmp) {
	struct mpconf  *conf;
	struct mp      *mp;

	if ((mp = mpsearch()) == 0 || mp->physaddr == 0)
  1030b0:	85 c0                	test   %eax,%eax
	} else {
		p = ((bda[0x14] << 8) | bda[0x13]) * 1024;
		if ((mp = mpsearch1((uint8_t *) p - 1024, 1024)))
			return mp;
	}
	return mpsearch1((uint8_t *) 0xF0000, 0x10000);
  1030b2:	89 c7                	mov    %eax,%edi
static struct mpconf *
mpconfig(struct mp **pmp) {
	struct mpconf  *conf;
	struct mp      *mp;

	if ((mp = mpsearch()) == 0 || mp->physaddr == 0)
  1030b4:	0f 85 64 fd ff ff    	jne    102e1e <pcpu_mp_init+0x27e>
  1030ba:	eb 92                	jmp    10304e <pcpu_mp_init+0x4ae>
	}

	xsdt = NULL;
	if ((xsdt = acpi_probe_xsdt(rsdp)) == NULL &&
	    (rsdt = acpi_probe_rsdt(rsdp)) == NULL) {
		KERN_DEBUG("Not found either RSDT or XSDT.\n");
  1030bc:	c7 44 24 08 e0 b2 10 	movl   $0x10b2e0,0x8(%esp)
  1030c3:	00 
  1030c4:	c7 44 24 04 6e 01 00 	movl   $0x16e,0x4(%esp)
  1030cb:	00 
  1030cc:	c7 04 24 c4 b4 10 00 	movl   $0x10b4c4,(%esp)
  1030d3:	e8 58 10 00 00       	call   104130 <debug_normal>
		goto fallback;
  1030d8:	e9 cf fc ff ff       	jmp    102dac <pcpu_mp_init+0x20c>
  1030dd:	8d 76 00             	lea    0x0(%esi),%esi

001030e0 <pcpu_init_cpu>:
	return 0;
}

void
pcpu_init_cpu(void)
{
  1030e0:	55                   	push   %ebp
  1030e1:	57                   	push   %edi
  1030e2:	56                   	push   %esi
  1030e3:	53                   	push   %ebx
  1030e4:	81 ec 9c 00 00 00    	sub    $0x9c,%esp
}

static void
pcpu_identify(void)
{
	int cpu_idx = get_pcpu_idx();
  1030ea:	e8 11 2b 00 00       	call   105c00 <get_pcpu_idx>
	struct pcpuinfo *cpuinfo = (struct pcpuinfo*) get_pcpu_arch_info_pointer(cpu_idx);
	uint32_t eax, ebx, ecx, edx;

	int i, j;
	uint8_t *desc;
	uint32_t *regs[4] = { &eax, &ebx, &ecx, &edx };
  1030ef:	8d 6c 24 78          	lea    0x78(%esp),%ebp
  1030f3:	8d 5c 24 7c          	lea    0x7c(%esp),%ebx

static void
pcpu_identify(void)
{
	int cpu_idx = get_pcpu_idx();
	struct pcpuinfo *cpuinfo = (struct pcpuinfo*) get_pcpu_arch_info_pointer(cpu_idx);
  1030f7:	89 04 24             	mov    %eax,(%esp)
  1030fa:	e8 f1 2b 00 00       	call   105cf0 <get_pcpu_arch_info_pointer>
		[0x66] = {  8, 64 },
		[0x67] = { 16, 64 },
		[0x68] = { 32, 64 }
	};

	cpuid(0x0, &eax, &ebx, &ecx, &edx);
  1030ff:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  103103:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
  103107:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
	struct pcpuinfo *cpuinfo = (struct pcpuinfo*) get_pcpu_arch_info_pointer(cpu_idx);
	uint32_t eax, ebx, ecx, edx;

	int i, j;
	uint8_t *desc;
	uint32_t *regs[4] = { &eax, &ebx, &ecx, &edx };
  10310e:	89 ac 24 88 00 00 00 	mov    %ebp,0x88(%esp)
  103115:	89 9c 24 8c 00 00 00 	mov    %ebx,0x8c(%esp)

static void
pcpu_identify(void)
{
	int cpu_idx = get_pcpu_idx();
	struct pcpuinfo *cpuinfo = (struct pcpuinfo*) get_pcpu_arch_info_pointer(cpu_idx);
  10311c:	89 c7                	mov    %eax,%edi
	uint32_t eax, ebx, ecx, edx;

	int i, j;
	uint8_t *desc;
	uint32_t *regs[4] = { &eax, &ebx, &ecx, &edx };
  10311e:	8d 44 24 70          	lea    0x70(%esp),%eax
  103122:	89 84 24 80 00 00 00 	mov    %eax,0x80(%esp)
  103129:	8d 44 24 74          	lea    0x74(%esp),%eax
  10312d:	89 84 24 84 00 00 00 	mov    %eax,0x84(%esp)
		[0x66] = {  8, 64 },
		[0x67] = { 16, 64 },
		[0x68] = { 32, 64 }
	};

	cpuid(0x0, &eax, &ebx, &ecx, &edx);
  103134:	89 44 24 08          	mov    %eax,0x8(%esp)
  103138:	8d 44 24 70          	lea    0x70(%esp),%eax
  10313c:	89 44 24 04          	mov    %eax,0x4(%esp)
  103140:	e8 4b 1d 00 00       	call   104e90 <cpuid>
	cpuinfo->cpuid_high = eax;
  103145:	8b 44 24 70          	mov    0x70(%esp),%eax
	((uint32_t *) cpuinfo->vendor)[0] = ebx;
	((uint32_t *) cpuinfo->vendor)[1] = edx;
	((uint32_t *) cpuinfo->vendor)[2] = ecx;
	cpuinfo->vendor[12] = '\0';
  103149:	c6 47 18 00          	movb   $0x0,0x18(%edi)
		[0x67] = { 16, 64 },
		[0x68] = { 32, 64 }
	};

	cpuid(0x0, &eax, &ebx, &ecx, &edx);
	cpuinfo->cpuid_high = eax;
  10314d:	89 47 08             	mov    %eax,0x8(%edi)
	((uint32_t *) cpuinfo->vendor)[0] = ebx;
  103150:	8b 44 24 74          	mov    0x74(%esp),%eax
  103154:	89 47 0c             	mov    %eax,0xc(%edi)
	((uint32_t *) cpuinfo->vendor)[1] = edx;
  103157:	8b 44 24 7c          	mov    0x7c(%esp),%eax
  10315b:	89 47 10             	mov    %eax,0x10(%edi)
	((uint32_t *) cpuinfo->vendor)[2] = ecx;
  10315e:	8b 44 24 78          	mov    0x78(%esp),%eax
  103162:	89 47 14             	mov    %eax,0x14(%edi)
	cpuinfo->vendor[12] = '\0';

	if (strncmp(cpuinfo->vendor, "GenuineIntel", 20) == 0)
  103165:	8d 47 0c             	lea    0xc(%edi),%eax
  103168:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
  10316f:	00 
  103170:	c7 44 24 04 63 b5 10 	movl   $0x10b563,0x4(%esp)
  103177:	00 
  103178:	89 04 24             	mov    %eax,(%esp)
  10317b:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  10317f:	e8 cc 0c 00 00       	call   103e50 <strncmp>
  103184:	85 c0                	test   %eax,%eax
  103186:	0f 85 44 03 00 00    	jne    1034d0 <pcpu_init_cpu+0x3f0>
		cpuinfo->cpu_vendor = INTEL;
  10318c:	c7 47 20 01 00 00 00 	movl   $0x1,0x20(%edi)
	else if (strncmp(cpuinfo->vendor, "AuthenticAMD", 20) == 0)
		cpuinfo->cpu_vendor = AMD;
	else
		cpuinfo->cpu_vendor = UNKNOWN_CPU;

	cpuid(0x1, &eax, &ebx, &ecx, &edx);
  103193:	8d 44 24 74          	lea    0x74(%esp),%eax
  103197:	89 44 24 08          	mov    %eax,0x8(%esp)
  10319b:	8d 44 24 70          	lea    0x70(%esp),%eax
  10319f:	89 44 24 04          	mov    %eax,0x4(%esp)
  1031a3:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  1031a7:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
  1031ab:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1031b2:	e8 d9 1c 00 00       	call   104e90 <cpuid>
	cpuinfo->family = (eax >> 8) & 0xf;
  1031b7:	8b 44 24 70          	mov    0x70(%esp),%eax
  1031bb:	89 c2                	mov    %eax,%edx
  1031bd:	c1 ea 08             	shr    $0x8,%edx
  1031c0:	83 e2 0f             	and    $0xf,%edx
  1031c3:	88 57 24             	mov    %dl,0x24(%edi)
	cpuinfo->model = (eax >> 4) & 0xf;
  1031c6:	89 c2                	mov    %eax,%edx
  1031c8:	c1 ea 04             	shr    $0x4,%edx
  1031cb:	83 e2 0f             	and    $0xf,%edx
  1031ce:	88 57 25             	mov    %dl,0x25(%edi)
	cpuinfo->step = eax & 0xf;
  1031d1:	89 c2                	mov    %eax,%edx
  1031d3:	83 e2 0f             	and    $0xf,%edx
  1031d6:	88 57 26             	mov    %dl,0x26(%edi)
	cpuinfo->ext_family = (eax >> 20) & 0xff;
  1031d9:	89 c2                	mov    %eax,%edx
	cpuinfo->ext_model = (eax >> 16) & 0xff;
  1031db:	c1 e8 10             	shr    $0x10,%eax
  1031de:	88 47 28             	mov    %al,0x28(%edi)
	cpuinfo->brand_idx = ebx & 0xff;
  1031e1:	8b 44 24 74          	mov    0x74(%esp),%eax

	cpuid(0x1, &eax, &ebx, &ecx, &edx);
	cpuinfo->family = (eax >> 8) & 0xf;
	cpuinfo->model = (eax >> 4) & 0xf;
	cpuinfo->step = eax & 0xf;
	cpuinfo->ext_family = (eax >> 20) & 0xff;
  1031e5:	c1 ea 14             	shr    $0x14,%edx
  1031e8:	88 57 27             	mov    %dl,0x27(%edi)
	cpuinfo->ext_model = (eax >> 16) & 0xff;
	cpuinfo->brand_idx = ebx & 0xff;
	cpuinfo->clflush_size = (ebx >> 8) & 0xff;
  1031eb:	89 c2                	mov    %eax,%edx
  1031ed:	c1 ea 08             	shr    $0x8,%edx
	cpuinfo->family = (eax >> 8) & 0xf;
	cpuinfo->model = (eax >> 4) & 0xf;
	cpuinfo->step = eax & 0xf;
	cpuinfo->ext_family = (eax >> 20) & 0xff;
	cpuinfo->ext_model = (eax >> 16) & 0xff;
	cpuinfo->brand_idx = ebx & 0xff;
  1031f0:	88 47 29             	mov    %al,0x29(%edi)
	cpuinfo->clflush_size = (ebx >> 8) & 0xff;
  1031f3:	88 57 2a             	mov    %dl,0x2a(%edi)
	cpuinfo->max_cpu_id = (ebx >> 16) &0xff;
  1031f6:	89 c2                	mov    %eax,%edx
	cpuinfo->apic_id = (ebx >> 24) & 0xff;
  1031f8:	c1 e8 18             	shr    $0x18,%eax
  1031fb:	88 47 2c             	mov    %al,0x2c(%edi)
	cpuinfo->feature1 = ecx;
  1031fe:	8b 44 24 78          	mov    0x78(%esp),%eax
	cpuinfo->step = eax & 0xf;
	cpuinfo->ext_family = (eax >> 20) & 0xff;
	cpuinfo->ext_model = (eax >> 16) & 0xff;
	cpuinfo->brand_idx = ebx & 0xff;
	cpuinfo->clflush_size = (ebx >> 8) & 0xff;
	cpuinfo->max_cpu_id = (ebx >> 16) &0xff;
  103202:	c1 ea 10             	shr    $0x10,%edx
  103205:	88 57 2b             	mov    %dl,0x2b(%edi)
	cpuinfo->apic_id = (ebx >> 24) & 0xff;
	cpuinfo->feature1 = ecx;
  103208:	89 47 30             	mov    %eax,0x30(%edi)
	cpuinfo->feature2 = edx;
  10320b:	8b 44 24 7c          	mov    0x7c(%esp),%eax
  10320f:	89 47 34             	mov    %eax,0x34(%edi)

	switch (cpuinfo->cpu_vendor) {
  103212:	8b 47 20             	mov    0x20(%edi),%eax
  103215:	83 f8 01             	cmp    $0x1,%eax
  103218:	0f 84 a2 01 00 00    	je     1033c0 <pcpu_init_cpu+0x2e0>
  10321e:	83 f8 02             	cmp    $0x2,%eax
  103221:	0f 84 59 01 00 00    	je     103380 <pcpu_init_cpu+0x2a0>
		cpuid(0x80000005, &eax, &ebx, &ecx, &edx);
		cpuinfo->l1_cache_size = (ecx & 0xff000000) >> 24;
		cpuinfo->l1_cache_line_size = (ecx & 0x000000ff);
		break;
	default:
		cpuinfo->l1_cache_size = 0;
  103227:	c7 47 38 00 00 00 00 	movl   $0x0,0x38(%edi)
		cpuinfo->l1_cache_line_size = 0;
  10322e:	c7 47 3c 00 00 00 00 	movl   $0x0,0x3c(%edi)
		break;
	}

	cpuid(0x80000000, &eax, &ebx, &ecx, &edx);
  103235:	8d 44 24 74          	lea    0x74(%esp),%eax
lapicid_t pcpu_cpu_lapicid(int cpu_idx);

static gcc_inline void
pcpu_print_cpuinfo(uint32_t cpu_idx, struct pcpuinfo *cpuinfo)
{
	KERN_INFO("CPU%d: %s, FAMILY %d(%d), MODEL %d(%d), STEP %d, "
  103239:	be 47 b5 10 00       	mov    $0x10b547,%esi
		cpuinfo->l1_cache_size = 0;
		cpuinfo->l1_cache_line_size = 0;
		break;
	}

	cpuid(0x80000000, &eax, &ebx, &ecx, &edx);
  10323e:	89 44 24 08          	mov    %eax,0x8(%esp)
  103242:	8d 44 24 70          	lea    0x70(%esp),%eax
  103246:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  10324a:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
lapicid_t pcpu_cpu_lapicid(int cpu_idx);

static gcc_inline void
pcpu_print_cpuinfo(uint32_t cpu_idx, struct pcpuinfo *cpuinfo)
{
	KERN_INFO("CPU%d: %s, FAMILY %d(%d), MODEL %d(%d), STEP %d, "
  10324e:	bd 2e b5 10 00       	mov    $0x10b52e,%ebp
		cpuinfo->l1_cache_size = 0;
		cpuinfo->l1_cache_line_size = 0;
		break;
	}

	cpuid(0x80000000, &eax, &ebx, &ecx, &edx);
  103253:	89 44 24 04          	mov    %eax,0x4(%esp)
  103257:	c7 04 24 00 00 00 80 	movl   $0x80000000,(%esp)
  10325e:	e8 2d 1c 00 00       	call   104e90 <cpuid>
	cpuinfo->cpuid_exthigh = eax;
  103263:	8b 44 24 70          	mov    0x70(%esp),%eax
  103267:	89 47 40             	mov    %eax,0x40(%edi)

	pcpu_print_cpuinfo(get_pcpu_idx(), cpuinfo);
  10326a:	e8 91 29 00 00       	call   105c00 <get_pcpu_idx>
lapicid_t pcpu_cpu_lapicid(int cpu_idx);

static gcc_inline void
pcpu_print_cpuinfo(uint32_t cpu_idx, struct pcpuinfo *cpuinfo)
{
	KERN_INFO("CPU%d: %s, FAMILY %d(%d), MODEL %d(%d), STEP %d, "
  10326f:	8b 5f 38             	mov    0x38(%edi),%ebx
  103272:	ba 05 c3 10 00       	mov    $0x10c305,%edx
  103277:	b9 3f b5 10 00       	mov    $0x10b53f,%ecx
  10327c:	c7 44 24 58 5d b5 10 	movl   $0x10b55d,0x58(%esp)
  103283:	00 
  103284:	89 5c 24 64          	mov    %ebx,0x64(%esp)
  103288:	bb 37 b5 10 00       	mov    $0x10b537,%ebx
	}

	cpuid(0x80000000, &eax, &ebx, &ecx, &edx);
	cpuinfo->cpuid_exthigh = eax;

	pcpu_print_cpuinfo(get_pcpu_idx(), cpuinfo);
  10328d:	89 44 24 60          	mov    %eax,0x60(%esp)
lapicid_t pcpu_cpu_lapicid(int cpu_idx);

static gcc_inline void
pcpu_print_cpuinfo(uint32_t cpu_idx, struct pcpuinfo *cpuinfo)
{
	KERN_INFO("CPU%d: %s, FAMILY %d(%d), MODEL %d(%d), STEP %d, "
  103291:	8b 47 30             	mov    0x30(%edi),%eax
  103294:	a9 00 00 80 00       	test   $0x800000,%eax
  103299:	0f 44 ea             	cmove  %edx,%ebp
  10329c:	a9 00 00 10 00       	test   $0x100000,%eax
  1032a1:	0f 44 da             	cmove  %edx,%ebx
  1032a4:	a9 00 00 08 00       	test   $0x80000,%eax
  1032a9:	89 5c 24 6c          	mov    %ebx,0x6c(%esp)
  1032ad:	8b 5f 34             	mov    0x34(%edi),%ebx
  1032b0:	0f 44 ca             	cmove  %edx,%ecx
  1032b3:	f6 c4 02             	test   $0x2,%ah
  1032b6:	0f 44 f2             	cmove  %edx,%esi
  1032b9:	a8 01                	test   $0x1,%al
  1032bb:	89 74 24 68          	mov    %esi,0x68(%esp)
  1032bf:	be 4f b5 10 00       	mov    $0x10b54f,%esi
  1032c4:	89 5c 24 54          	mov    %ebx,0x54(%esp)
  1032c8:	0f 44 f2             	cmove  %edx,%esi
  1032cb:	bb 56 b5 10 00       	mov    $0x10b556,%ebx
  1032d0:	f7 44 24 54 00 00 00 	testl  $0x4000000,0x54(%esp)
  1032d7:	04 
  1032d8:	0f 44 da             	cmove  %edx,%ebx
  1032db:	f7 44 24 54 00 00 00 	testl  $0x2000000,0x54(%esp)
  1032e2:	02 
  1032e3:	0f 45 54 24 58       	cmovne 0x58(%esp),%edx
  1032e8:	89 54 24 58          	mov    %edx,0x58(%esp)
  1032ec:	8b 57 3c             	mov    0x3c(%edi),%edx
  1032ef:	89 4c 24 38          	mov    %ecx,0x38(%esp)
  1032f3:	8b 4c 24 68          	mov    0x68(%esp),%ecx
  1032f7:	89 5c 24 2c          	mov    %ebx,0x2c(%esp)
  1032fb:	8b 5c 24 54          	mov    0x54(%esp),%ebx
  1032ff:	89 6c 24 40          	mov    %ebp,0x40(%esp)
  103303:	89 54 24 48          	mov    %edx,0x48(%esp)
  103307:	8b 54 24 64          	mov    0x64(%esp),%edx
  10330b:	89 4c 24 34          	mov    %ecx,0x34(%esp)
  10330f:	89 74 24 30          	mov    %esi,0x30(%esp)
  103313:	89 5c 24 24          	mov    %ebx,0x24(%esp)
  103317:	89 54 24 44          	mov    %edx,0x44(%esp)
  10331b:	8b 54 24 6c          	mov    0x6c(%esp),%edx
  10331f:	89 44 24 20          	mov    %eax,0x20(%esp)
  103323:	89 54 24 3c          	mov    %edx,0x3c(%esp)
  103327:	8b 54 24 58          	mov    0x58(%esp),%edx
  10332b:	89 54 24 28          	mov    %edx,0x28(%esp)
  10332f:	0f b6 47 26          	movzbl 0x26(%edi),%eax
  103333:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  103337:	0f b6 47 28          	movzbl 0x28(%edi),%eax
  10333b:	89 44 24 18          	mov    %eax,0x18(%esp)
  10333f:	0f b6 47 25          	movzbl 0x25(%edi),%eax
  103343:	8b 5c 24 5c          	mov    0x5c(%esp),%ebx
  103347:	89 44 24 14          	mov    %eax,0x14(%esp)
  10334b:	0f b6 47 27          	movzbl 0x27(%edi),%eax
  10334f:	89 44 24 10          	mov    %eax,0x10(%esp)
  103353:	0f b6 47 24          	movzbl 0x24(%edi),%eax
  103357:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  10335b:	c7 04 24 9c b3 10 00 	movl   $0x10b39c,(%esp)
  103362:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103366:	8b 44 24 60          	mov    0x60(%esp),%eax
  10336a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10336e:	e8 7d 0d 00 00       	call   1040f0 <debug_info>

void
pcpu_init_cpu(void)
{
	pcpu_identify();
}
  103373:	81 c4 9c 00 00 00    	add    $0x9c,%esp
  103379:	5b                   	pop    %ebx
  10337a:	5e                   	pop    %esi
  10337b:	5f                   	pop    %edi
  10337c:	5d                   	pop    %ebp
  10337d:	c3                   	ret    
  10337e:	66 90                	xchg   %ax,%ax
			1024;
		cpuinfo->l1_cache_line_size = ((ebx & 0x00000fff)) + 1;

		break;
	case AMD:
		cpuid(0x80000005, &eax, &ebx, &ecx, &edx);
  103380:	8d 44 24 74          	lea    0x74(%esp),%eax
  103384:	89 44 24 08          	mov    %eax,0x8(%esp)
  103388:	8d 44 24 70          	lea    0x70(%esp),%eax
  10338c:	89 44 24 04          	mov    %eax,0x4(%esp)
  103390:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  103394:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
  103398:	c7 04 24 05 00 00 80 	movl   $0x80000005,(%esp)
  10339f:	e8 ec 1a 00 00       	call   104e90 <cpuid>
		cpuinfo->l1_cache_size = (ecx & 0xff000000) >> 24;
  1033a4:	8b 44 24 78          	mov    0x78(%esp),%eax
  1033a8:	89 c2                	mov    %eax,%edx
		cpuinfo->l1_cache_line_size = (ecx & 0x000000ff);
  1033aa:	25 ff 00 00 00       	and    $0xff,%eax
		cpuinfo->l1_cache_line_size = ((ebx & 0x00000fff)) + 1;

		break;
	case AMD:
		cpuid(0x80000005, &eax, &ebx, &ecx, &edx);
		cpuinfo->l1_cache_size = (ecx & 0xff000000) >> 24;
  1033af:	c1 ea 18             	shr    $0x18,%edx
  1033b2:	89 57 38             	mov    %edx,0x38(%edi)
		cpuinfo->l1_cache_line_size = (ecx & 0x000000ff);
  1033b5:	89 47 3c             	mov    %eax,0x3c(%edi)
  1033b8:	e9 78 fe ff ff       	jmp    103235 <pcpu_init_cpu+0x155>
  1033bd:	8d 76 00             	lea    0x0(%esi),%esi
	cpuinfo->feature2 = edx;

	switch (cpuinfo->cpu_vendor) {
	case INTEL:
		/* try cpuid 2 first */
		cpuid(0x00000002, &eax, &ebx, &ecx, &edx);
  1033c0:	8d 44 24 74          	lea    0x74(%esp),%eax
  1033c4:	89 44 24 08          	mov    %eax,0x8(%esp)
  1033c8:	8d 44 24 70          	lea    0x70(%esp),%eax
  1033cc:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  1033d0:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
  1033d4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1033d8:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1033df:	e8 ac 1a 00 00       	call   104e90 <cpuid>
		i = eax & 0x000000ff;
  1033e4:	0f b6 74 24 70       	movzbl 0x70(%esp),%esi
		while (i--)
  1033e9:	85 f6                	test   %esi,%esi
  1033eb:	74 2c                	je     103419 <pcpu_init_cpu+0x339>
  1033ed:	8d 76 00             	lea    0x0(%esi),%esi
			cpuid(0x00000002, &eax, &ebx, &ecx, &edx);
  1033f0:	8d 44 24 74          	lea    0x74(%esp),%eax
  1033f4:	89 44 24 08          	mov    %eax,0x8(%esp)
  1033f8:	8d 44 24 70          	lea    0x70(%esp),%eax
  1033fc:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  103400:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
  103404:	89 44 24 04          	mov    %eax,0x4(%esp)
  103408:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  10340f:	e8 7c 1a 00 00       	call   104e90 <cpuid>
	switch (cpuinfo->cpu_vendor) {
	case INTEL:
		/* try cpuid 2 first */
		cpuid(0x00000002, &eax, &ebx, &ecx, &edx);
		i = eax & 0x000000ff;
		while (i--)
  103414:	83 ee 01             	sub    $0x1,%esi
  103417:	75 d7                	jne    1033f0 <pcpu_init_cpu+0x310>
  103419:	8d 84 24 80 00 00 00 	lea    0x80(%esp),%eax
  103420:	89 44 24 54          	mov    %eax,0x54(%esp)
			cpuid(0x00000002, &eax, &ebx, &ecx, &edx);

		for (i = 0; i < 4; i++) {
			desc = (uint8_t *) regs[i];
  103424:	8b 44 24 54          	mov    0x54(%esp),%eax
  103428:	8b 10                	mov    (%eax),%edx
			for (j = 0; j < 4; j++) {
  10342a:	31 c0                	xor    %eax,%eax
				cpuinfo->l1_cache_size =
					intel_cache_info[desc[j]][0];
  10342c:	0f b6 0c 02          	movzbl (%edx,%eax,1),%ecx
			cpuid(0x00000002, &eax, &ebx, &ecx, &edx);

		for (i = 0; i < 4; i++) {
			desc = (uint8_t *) regs[i];
			for (j = 0; j < 4; j++) {
				cpuinfo->l1_cache_size =
  103430:	8b 0c cd c0 b5 10 00 	mov    0x10b5c0(,%ecx,8),%ecx
  103437:	89 4f 38             	mov    %ecx,0x38(%edi)
					intel_cache_info[desc[j]][0];
				cpuinfo->l1_cache_line_size =
					intel_cache_info[desc[j]][1];
  10343a:	0f b6 34 02          	movzbl (%edx,%eax,1),%esi
		while (i--)
			cpuid(0x00000002, &eax, &ebx, &ecx, &edx);

		for (i = 0; i < 4; i++) {
			desc = (uint8_t *) regs[i];
			for (j = 0; j < 4; j++) {
  10343e:	83 c0 01             	add    $0x1,%eax
  103441:	83 f8 04             	cmp    $0x4,%eax
				cpuinfo->l1_cache_size =
					intel_cache_info[desc[j]][0];
				cpuinfo->l1_cache_line_size =
  103444:	8b 34 f5 c4 b5 10 00 	mov    0x10b5c4(,%esi,8),%esi
  10344b:	89 77 3c             	mov    %esi,0x3c(%edi)
		while (i--)
			cpuid(0x00000002, &eax, &ebx, &ecx, &edx);

		for (i = 0; i < 4; i++) {
			desc = (uint8_t *) regs[i];
			for (j = 0; j < 4; j++) {
  10344e:	75 dc                	jne    10342c <pcpu_init_cpu+0x34c>
  103450:	83 44 24 54 04       	addl   $0x4,0x54(%esp)
		cpuid(0x00000002, &eax, &ebx, &ecx, &edx);
		i = eax & 0x000000ff;
		while (i--)
			cpuid(0x00000002, &eax, &ebx, &ecx, &edx);

		for (i = 0; i < 4; i++) {
  103455:	8d 84 24 90 00 00 00 	lea    0x90(%esp),%eax
  10345c:	39 44 24 54          	cmp    %eax,0x54(%esp)
  103460:	75 c2                	jne    103424 <pcpu_init_cpu+0x344>
					intel_cache_info[desc[j]][1];
			}
		}

		/* try cpuid 4 if no cache info are got by cpuid 2 */
		if (cpuinfo->l1_cache_size && cpuinfo->l1_cache_line_size)
  103462:	85 c9                	test   %ecx,%ecx
  103464:	0f 85 e6 00 00 00    	jne    103550 <pcpu_init_cpu+0x470>
		while (i--)
			cpuid(0x00000002, &eax, &ebx, &ecx, &edx);

		for (i = 0; i < 4; i++) {
			desc = (uint8_t *) regs[i];
			for (j = 0; j < 4; j++) {
  10346a:	31 f6                	xor    %esi,%esi
		/* try cpuid 4 if no cache info are got by cpuid 2 */
		if (cpuinfo->l1_cache_size && cpuinfo->l1_cache_line_size)
			break;

		for (i = 0; i < 3; i++) {
			cpuid_subleaf(0x00000004, i, &eax, &ebx, &ecx, &edx);
  10346c:	8d 44 24 74          	lea    0x74(%esp),%eax
  103470:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103474:	8d 44 24 70          	lea    0x70(%esp),%eax
  103478:	89 44 24 08          	mov    %eax,0x8(%esp)
  10347c:	89 5c 24 14          	mov    %ebx,0x14(%esp)
  103480:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  103484:	89 74 24 04          	mov    %esi,0x4(%esp)
  103488:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  10348f:	e8 3c 1a 00 00       	call   104ed0 <cpuid_subleaf>
			if ((eax & 0xf) == 1 && ((eax & 0xe0) >> 5) == 1)
  103494:	8b 44 24 70          	mov    0x70(%esp),%eax
  103498:	89 c2                	mov    %eax,%edx
  10349a:	83 e2 0f             	and    $0xf,%edx
  10349d:	83 fa 01             	cmp    $0x1,%edx
  1034a0:	74 5e                	je     103500 <pcpu_init_cpu+0x420>

		/* try cpuid 4 if no cache info are got by cpuid 2 */
		if (cpuinfo->l1_cache_size && cpuinfo->l1_cache_line_size)
			break;

		for (i = 0; i < 3; i++) {
  1034a2:	83 c6 01             	add    $0x1,%esi
  1034a5:	83 fe 03             	cmp    $0x3,%esi
  1034a8:	75 c2                	jne    10346c <pcpu_init_cpu+0x38c>
			if ((eax & 0xf) == 1 && ((eax & 0xe0) >> 5) == 1)
				break;
		}

		if (i == 3) {
			KERN_WARN("Cannot determine L1 cache size.\n");
  1034aa:	c7 44 24 08 0c b4 10 	movl   $0x10b40c,0x8(%esp)
  1034b1:	00 
  1034b2:	c7 44 24 04 85 00 00 	movl   $0x85,0x4(%esp)
  1034b9:	00 
  1034ba:	c7 04 24 c4 b4 10 00 	movl   $0x10b4c4,(%esp)
  1034c1:	e8 8a 0d 00 00       	call   104250 <debug_warn>
  1034c6:	e9 6a fd ff ff       	jmp    103235 <pcpu_init_cpu+0x155>
  1034cb:	90                   	nop
  1034cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	((uint32_t *) cpuinfo->vendor)[2] = ecx;
	cpuinfo->vendor[12] = '\0';

	if (strncmp(cpuinfo->vendor, "GenuineIntel", 20) == 0)
		cpuinfo->cpu_vendor = INTEL;
	else if (strncmp(cpuinfo->vendor, "AuthenticAMD", 20) == 0)
  1034d0:	8b 44 24 5c          	mov    0x5c(%esp),%eax
  1034d4:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
  1034db:	00 
  1034dc:	c7 44 24 04 70 b5 10 	movl   $0x10b570,0x4(%esp)
  1034e3:	00 
  1034e4:	89 04 24             	mov    %eax,(%esp)
  1034e7:	e8 64 09 00 00       	call   103e50 <strncmp>
		cpuinfo->cpu_vendor = AMD;
  1034ec:	83 f8 01             	cmp    $0x1,%eax
  1034ef:	19 c0                	sbb    %eax,%eax
  1034f1:	83 e0 02             	and    $0x2,%eax
  1034f4:	89 47 20             	mov    %eax,0x20(%edi)
  1034f7:	e9 97 fc ff ff       	jmp    103193 <pcpu_init_cpu+0xb3>
  1034fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		if (cpuinfo->l1_cache_size && cpuinfo->l1_cache_line_size)
			break;

		for (i = 0; i < 3; i++) {
			cpuid_subleaf(0x00000004, i, &eax, &ebx, &ecx, &edx);
			if ((eax & 0xf) == 1 && ((eax & 0xe0) >> 5) == 1)
  103500:	25 e0 00 00 00       	and    $0xe0,%eax
  103505:	83 f8 20             	cmp    $0x20,%eax
  103508:	75 98                	jne    1034a2 <pcpu_init_cpu+0x3c2>
			KERN_WARN("Cannot determine L1 cache size.\n");
			break;
		}

		cpuinfo->l1_cache_size =
			(((ebx & 0xffc00000) >> 22) + 1) *	/* ways */
  10350a:	8b 74 24 74          	mov    0x74(%esp),%esi
			(((ebx & 0x003ff000) >> 12) + 1) *	/* partitions */
			(((ebx & 0x00000fff)) + 1) *		/* line size */
			(ecx + 1) /				/* sets */
  10350e:	8b 54 24 78          	mov    0x78(%esp),%edx
		}

		cpuinfo->l1_cache_size =
			(((ebx & 0xffc00000) >> 22) + 1) *	/* ways */
			(((ebx & 0x003ff000) >> 12) + 1) *	/* partitions */
			(((ebx & 0x00000fff)) + 1) *		/* line size */
  103512:	89 f1                	mov    %esi,%ecx
			KERN_WARN("Cannot determine L1 cache size.\n");
			break;
		}

		cpuinfo->l1_cache_size =
			(((ebx & 0xffc00000) >> 22) + 1) *	/* ways */
  103514:	89 f0                	mov    %esi,%eax
			(((ebx & 0x003ff000) >> 12) + 1) *	/* partitions */
			(((ebx & 0x00000fff)) + 1) *		/* line size */
  103516:	81 e1 ff 0f 00 00    	and    $0xfff,%ecx
			(ecx + 1) /				/* sets */
  10351c:	83 c2 01             	add    $0x1,%edx
			KERN_WARN("Cannot determine L1 cache size.\n");
			break;
		}

		cpuinfo->l1_cache_size =
			(((ebx & 0xffc00000) >> 22) + 1) *	/* ways */
  10351f:	c1 e8 16             	shr    $0x16,%eax
			(((ebx & 0x003ff000) >> 12) + 1) *	/* partitions */
			(((ebx & 0x00000fff)) + 1) *		/* line size */
  103522:	83 c1 01             	add    $0x1,%ecx
			KERN_WARN("Cannot determine L1 cache size.\n");
			break;
		}

		cpuinfo->l1_cache_size =
			(((ebx & 0xffc00000) >> 22) + 1) *	/* ways */
  103525:	83 c0 01             	add    $0x1,%eax
			(((ebx & 0x003ff000) >> 12) + 1) *	/* partitions */
  103528:	81 e6 00 f0 3f 00    	and    $0x3ff000,%esi
			KERN_WARN("Cannot determine L1 cache size.\n");
			break;
		}

		cpuinfo->l1_cache_size =
			(((ebx & 0xffc00000) >> 22) + 1) *	/* ways */
  10352e:	0f af c1             	imul   %ecx,%eax
			(((ebx & 0x003ff000) >> 12) + 1) *	/* partitions */
			(((ebx & 0x00000fff)) + 1) *		/* line size */
			(ecx + 1) /				/* sets */
			1024;
		cpuinfo->l1_cache_line_size = ((ebx & 0x00000fff)) + 1;
  103531:	89 4f 3c             	mov    %ecx,0x3c(%edi)
			break;
		}

		cpuinfo->l1_cache_size =
			(((ebx & 0xffc00000) >> 22) + 1) *	/* ways */
			(((ebx & 0x003ff000) >> 12) + 1) *	/* partitions */
  103534:	0f af c2             	imul   %edx,%eax
  103537:	89 f2                	mov    %esi,%edx
  103539:	c1 ea 0c             	shr    $0xc,%edx
  10353c:	83 c2 01             	add    $0x1,%edx
			(((ebx & 0x00000fff)) + 1) *		/* line size */
  10353f:	0f af c2             	imul   %edx,%eax
			(ecx + 1) /				/* sets */
  103542:	c1 e8 0a             	shr    $0xa,%eax
  103545:	89 47 38             	mov    %eax,0x38(%edi)
  103548:	e9 e8 fc ff ff       	jmp    103235 <pcpu_init_cpu+0x155>
  10354d:	8d 76 00             	lea    0x0(%esi),%esi
					intel_cache_info[desc[j]][1];
			}
		}

		/* try cpuid 4 if no cache info are got by cpuid 2 */
		if (cpuinfo->l1_cache_size && cpuinfo->l1_cache_line_size)
  103550:	85 f6                	test   %esi,%esi
  103552:	0f 85 dd fc ff ff    	jne    103235 <pcpu_init_cpu+0x155>
  103558:	e9 0d ff ff ff       	jmp    10346a <pcpu_init_cpu+0x38a>
  10355d:	8d 76 00             	lea    0x0(%esi),%esi

00103560 <pcpu_ncpu>:

uint32_t
pcpu_ncpu(void)
{
	return ncpu;
}
  103560:	a1 6c fe 13 00       	mov    0x13fe6c,%eax
  103565:	c3                   	ret    
  103566:	8d 76 00             	lea    0x0(%esi),%esi
  103569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103570 <pcpu_is_smp>:

bool
pcpu_is_smp(void)
{
	return ismp;
}
  103570:	0f b6 05 68 fe 13 00 	movzbl 0x13fe68,%eax
  103577:	c3                   	ret    
  103578:	90                   	nop
  103579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103580 <pcpu_onboot>:

bool
pcpu_onboot(void)
{
  103580:	83 ec 1c             	sub    $0x1c,%esp
	int cpu_idx = get_pcpu_idx();
  103583:	e8 78 26 00 00       	call   105c00 <get_pcpu_idx>
	struct pcpuinfo* arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  103588:	89 04 24             	mov    %eax,(%esp)
  10358b:	e8 60 27 00 00       	call   105cf0 <get_pcpu_arch_info_pointer>
	return (mp_inited == TRUE) ?
  103590:	80 3d 69 fe 13 00 01 	cmpb   $0x1,0x13fe69
  103597:	74 0f                	je     1035a8 <pcpu_onboot+0x28>
		arch_info->bsp : (get_pcpu_idx() == 0);
  103599:	e8 62 26 00 00       	call   105c00 <get_pcpu_idx>
  10359e:	85 c0                	test   %eax,%eax
  1035a0:	0f 94 c0             	sete   %al
}
  1035a3:	83 c4 1c             	add    $0x1c,%esp
  1035a6:	c3                   	ret    
  1035a7:	90                   	nop
bool
pcpu_onboot(void)
{
	int cpu_idx = get_pcpu_idx();
	struct pcpuinfo* arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
	return (mp_inited == TRUE) ?
  1035a8:	0f b6 40 04          	movzbl 0x4(%eax),%eax
		arch_info->bsp : (get_pcpu_idx() == 0);
}
  1035ac:	83 c4 1c             	add    $0x1c,%esp
  1035af:	c3                   	ret    

001035b0 <pcpu_cpu_lapicid>:

lapicid_t
pcpu_cpu_lapicid(int cpu_idx)
{
  1035b0:	56                   	push   %esi
  1035b1:	53                   	push   %ebx
  1035b2:	83 ec 14             	sub    $0x14,%esp
  1035b5:	8b 5c 24 20          	mov    0x20(%esp),%ebx
	struct pcpuinfo* arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  1035b9:	89 1c 24             	mov    %ebx,(%esp)
  1035bc:	e8 2f 27 00 00       	call   105cf0 <get_pcpu_arch_info_pointer>
	KERN_ASSERT(0 <= cpu_idx && cpu_idx < ncpu);
  1035c1:	85 db                	test   %ebx,%ebx
}

lapicid_t
pcpu_cpu_lapicid(int cpu_idx)
{
	struct pcpuinfo* arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  1035c3:	89 c6                	mov    %eax,%esi
	KERN_ASSERT(0 <= cpu_idx && cpu_idx < ncpu);
  1035c5:	78 08                	js     1035cf <pcpu_cpu_lapicid+0x1f>
  1035c7:	3b 1d 6c fe 13 00    	cmp    0x13fe6c,%ebx
  1035cd:	72 24                	jb     1035f3 <pcpu_cpu_lapicid+0x43>
  1035cf:	c7 44 24 0c 30 b4 10 	movl   $0x10b430,0xc(%esp)
  1035d6:	00 
  1035d7:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  1035de:	00 
  1035df:	c7 44 24 04 19 02 00 	movl   $0x219,0x4(%esp)
  1035e6:	00 
  1035e7:	c7 04 24 c4 b4 10 00 	movl   $0x10b4c4,(%esp)
  1035ee:	e8 8d 0b 00 00       	call   104180 <debug_panic>
	return arch_info->lapicid;
  1035f3:	8b 06                	mov    (%esi),%eax
}
  1035f5:	83 c4 14             	add    $0x14,%esp
  1035f8:	5b                   	pop    %ebx
  1035f9:	5e                   	pop    %esi
  1035fa:	c3                   	ret    
  1035fb:	90                   	nop
  1035fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103600 <pcpu_boot_ap>:
		return TRUE;
}

int
pcpu_boot_ap(uint32_t cpu_idx, void (*f)(void), uintptr_t stack_addr)
{
  103600:	56                   	push   %esi
  103601:	53                   	push   %ebx
  103602:	83 ec 14             	sub    $0x14,%esp
  103605:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  103609:	8b 74 24 24          	mov    0x24(%esp),%esi
	KERN_ASSERT(cpu_idx > 0 && cpu_idx < pcpu_ncpu());
  10360d:	85 db                	test   %ebx,%ebx
  10360f:	74 57                	je     103668 <pcpu_boot_ap+0x68>
  103611:	3b 1d 6c fe 13 00    	cmp    0x13fe6c,%ebx
  103617:	73 4f                	jae    103668 <pcpu_boot_ap+0x68>
	KERN_ASSERT(get_pcpu_inited_info(cpu_idx) == TRUE);
  103619:	89 1c 24             	mov    %ebx,(%esp)
  10361c:	e8 df 26 00 00       	call   105d00 <get_pcpu_inited_info>
  103621:	3c 01                	cmp    $0x1,%al
  103623:	74 24                	je     103649 <pcpu_boot_ap+0x49>
  103625:	c7 44 24 0c 78 b4 10 	movl   $0x10b478,0xc(%esp)
  10362c:	00 
  10362d:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  103634:	00 
  103635:	c7 44 24 04 e0 01 00 	movl   $0x1e0,0x4(%esp)
  10363c:	00 
  10363d:	c7 04 24 c4 b4 10 00 	movl   $0x10b4c4,(%esp)
  103644:	e8 37 0b 00 00       	call   104180 <debug_panic>
	KERN_ASSERT(f != NULL);
  103649:	85 f6                	test   %esi,%esi
  10364b:	0f 84 d7 00 00 00    	je     103728 <pcpu_boot_ap+0x128>

	/* avoid being called by AP */
	if (pcpu_onboot() == FALSE)
  103651:	e8 2a ff ff ff       	call   103580 <pcpu_onboot>
		return 1;
  103656:	ba 01 00 00 00       	mov    $0x1,%edx
	KERN_ASSERT(cpu_idx > 0 && cpu_idx < pcpu_ncpu());
	KERN_ASSERT(get_pcpu_inited_info(cpu_idx) == TRUE);
	KERN_ASSERT(f != NULL);

	/* avoid being called by AP */
	if (pcpu_onboot() == FALSE)
  10365b:	84 c0                	test   %al,%al
  10365d:	75 31                	jne    103690 <pcpu_boot_ap+0x90>
		pause();

	KERN_ASSERT(get_pcpu_boot_info(cpu_idx) == TRUE);

	return 0;
}
  10365f:	83 c4 14             	add    $0x14,%esp
  103662:	89 d0                	mov    %edx,%eax
  103664:	5b                   	pop    %ebx
  103665:	5e                   	pop    %esi
  103666:	c3                   	ret    
  103667:	90                   	nop
}

int
pcpu_boot_ap(uint32_t cpu_idx, void (*f)(void), uintptr_t stack_addr)
{
	KERN_ASSERT(cpu_idx > 0 && cpu_idx < pcpu_ncpu());
  103668:	c7 44 24 0c 50 b4 10 	movl   $0x10b450,0xc(%esp)
  10366f:	00 
  103670:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  103677:	00 
  103678:	c7 44 24 04 df 01 00 	movl   $0x1df,0x4(%esp)
  10367f:	00 
  103680:	c7 04 24 c4 b4 10 00 	movl   $0x10b4c4,(%esp)
  103687:	e8 f4 0a 00 00       	call   104180 <debug_panic>
  10368c:	eb 8b                	jmp    103619 <pcpu_boot_ap+0x19>
  10368e:	66 90                	xchg   %ax,%ax

	/* avoid being called by AP */
	if (pcpu_onboot() == FALSE)
		return 1;

	if (get_pcpu_boot_info(cpu_idx) == TRUE)
  103690:	89 1c 24             	mov    %ebx,(%esp)
  103693:	e8 e8 25 00 00       	call   105c80 <get_pcpu_boot_info>
  103698:	3c 01                	cmp    $0x1,%al
  10369a:	74 7d                	je     103719 <pcpu_boot_ap+0x119>
		return 0;

	extern void kern_init_ap(void);		/* defined in sys/kern/init.c */
	uint8_t *boot = (uint8_t *) PCPU_AP_START_ADDR;
	*(uintptr_t *) (boot - 4) = stack_addr + PAGE_SIZE;
  10369c:	8b 44 24 28          	mov    0x28(%esp),%eax
	*(uintptr_t *) (boot - 8) = (uintptr_t) f;
  1036a0:	89 35 f8 7f 00 00    	mov    %esi,0x7ff8
	*(uintptr_t *) (boot - 12) = (uintptr_t) kern_init_ap;
  1036a6:	c7 05 f4 7f 00 00 80 	movl   $0x105e80,0x7ff4
  1036ad:	5e 10 00 
	if (get_pcpu_boot_info(cpu_idx) == TRUE)
		return 0;

	extern void kern_init_ap(void);		/* defined in sys/kern/init.c */
	uint8_t *boot = (uint8_t *) PCPU_AP_START_ADDR;
	*(uintptr_t *) (boot - 4) = stack_addr + PAGE_SIZE;
  1036b0:	05 00 10 00 00       	add    $0x1000,%eax
  1036b5:	a3 fc 7f 00 00       	mov    %eax,0x7ffc
	*(uintptr_t *) (boot - 8) = (uintptr_t) f;
	*(uintptr_t *) (boot - 12) = (uintptr_t) kern_init_ap;
	lapic_startcpu(pcpu_cpu_lapicid(cpu_idx), (uintptr_t) boot);
  1036ba:	89 1c 24             	mov    %ebx,(%esp)
  1036bd:	e8 ee fe ff ff       	call   1035b0 <pcpu_cpu_lapicid>
  1036c2:	c7 44 24 04 00 80 00 	movl   $0x8000,0x4(%esp)
  1036c9:	00 
  1036ca:	0f b6 c0             	movzbl %al,%eax
  1036cd:	89 04 24             	mov    %eax,(%esp)
  1036d0:	e8 7b ef ff ff       	call   102650 <lapic_startcpu>

	/* wait until the processor is intialized */
	while (get_pcpu_boot_info(cpu_idx) == FALSE)
  1036d5:	eb 06                	jmp    1036dd <pcpu_boot_ap+0xdd>
  1036d7:	90                   	nop
		pause();
  1036d8:	e8 63 17 00 00       	call   104e40 <pause>
	*(uintptr_t *) (boot - 8) = (uintptr_t) f;
	*(uintptr_t *) (boot - 12) = (uintptr_t) kern_init_ap;
	lapic_startcpu(pcpu_cpu_lapicid(cpu_idx), (uintptr_t) boot);

	/* wait until the processor is intialized */
	while (get_pcpu_boot_info(cpu_idx) == FALSE)
  1036dd:	89 1c 24             	mov    %ebx,(%esp)
  1036e0:	e8 9b 25 00 00       	call   105c80 <get_pcpu_boot_info>
  1036e5:	84 c0                	test   %al,%al
  1036e7:	74 ef                	je     1036d8 <pcpu_boot_ap+0xd8>
		pause();

	KERN_ASSERT(get_pcpu_boot_info(cpu_idx) == TRUE);
  1036e9:	89 1c 24             	mov    %ebx,(%esp)
  1036ec:	e8 8f 25 00 00       	call   105c80 <get_pcpu_boot_info>
  1036f1:	3c 01                	cmp    $0x1,%al
  1036f3:	74 24                	je     103719 <pcpu_boot_ap+0x119>
  1036f5:	c7 44 24 0c a0 b4 10 	movl   $0x10b4a0,0xc(%esp)
  1036fc:	00 
  1036fd:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  103704:	00 
  103705:	c7 44 24 04 f5 01 00 	movl   $0x1f5,0x4(%esp)
  10370c:	00 
  10370d:	c7 04 24 c4 b4 10 00 	movl   $0x10b4c4,(%esp)
  103714:	e8 67 0a 00 00       	call   104180 <debug_panic>

	return 0;
}
  103719:	83 c4 14             	add    $0x14,%esp
	while (get_pcpu_boot_info(cpu_idx) == FALSE)
		pause();

	KERN_ASSERT(get_pcpu_boot_info(cpu_idx) == TRUE);

	return 0;
  10371c:	31 d2                	xor    %edx,%edx
}
  10371e:	89 d0                	mov    %edx,%eax
  103720:	5b                   	pop    %ebx
  103721:	5e                   	pop    %esi
  103722:	c3                   	ret    
  103723:	90                   	nop
  103724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
pcpu_boot_ap(uint32_t cpu_idx, void (*f)(void), uintptr_t stack_addr)
{
	KERN_ASSERT(cpu_idx > 0 && cpu_idx < pcpu_ncpu());
	KERN_ASSERT(get_pcpu_inited_info(cpu_idx) == TRUE);
	KERN_ASSERT(f != NULL);
  103728:	c7 44 24 0c 7d b5 10 	movl   $0x10b57d,0xc(%esp)
  10372f:	00 
  103730:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  103737:	00 
  103738:	c7 44 24 04 e1 01 00 	movl   $0x1e1,0x4(%esp)
  10373f:	00 
  103740:	c7 04 24 c4 b4 10 00 	movl   $0x10b4c4,(%esp)
  103747:	e8 34 0a 00 00       	call   104180 <debug_panic>
  10374c:	e9 00 ff ff ff       	jmp    103651 <pcpu_boot_ap+0x51>
  103751:	66 90                	xchg   %ax,%ax
  103753:	66 90                	xchg   %ax,%ax
  103755:	66 90                	xchg   %ax,%ax
  103757:	66 90                	xchg   %ax,%ax
  103759:	66 90                	xchg   %ax,%ax
  10375b:	66 90                	xchg   %ax,%ax
  10375d:	66 90                	xchg   %ax,%ax
  10375f:	90                   	nop

00103760 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
  103760:	53                   	push   %ebx

static uint32_t
ioapicread(int32_t reg)
{
  ioapic->reg = reg;
  return ioapic->data;
  103761:	ba 10 00 00 00       	mov    $0x10,%edx
{
  int32_t i, id, maxintr;

  //if(!ismp) return;      // is multi-processor?

  ioapic = (volatile struct ioapic*)IOAPIC;
  103766:	c7 05 c0 b8 9c 00 00 	movl   $0xfec00000,0x9cb8c0
  10376d:	00 c0 fe 
};

static uint32_t
ioapicread(int32_t reg)
{
  ioapic->reg = reg;
  103770:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
  103777:	00 00 00 
  return ioapic->data;
  10377a:	8b 1d 10 00 c0 fe    	mov    0xfec00010,%ebx
};

static uint32_t
ioapicread(int32_t reg)
{
  ioapic->reg = reg;
  103780:	c7 05 00 00 c0 fe 00 	movl   $0x0,0xfec00000
  103787:	00 00 00 
  return ioapic->data;
  10378a:	a1 10 00 c0 fe       	mov    0xfec00010,%eax
  //  if(id != ioapicid)
  //    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  10378f:	31 c0                	xor    %eax,%eax
  int32_t i, id, maxintr;

  //if(!ismp) return;      // is multi-processor?

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  103791:	c1 eb 10             	shr    $0x10,%ebx
  103794:	0f b6 db             	movzbl %bl,%ebx
  103797:	90                   	nop
  103798:	8d 48 20             	lea    0x20(%eax),%ecx
  //  if(id != ioapicid)
  //    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  10379b:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
  10379e:	81 c9 00 00 01 00    	or     $0x10000,%ecx
}

static void
ioapicwrite(int32_t reg, uint32_t data)
{
  ioapic->reg = reg;
  1037a4:	89 15 00 00 c0 fe    	mov    %edx,0xfec00000
  ioapic->data = data;
  1037aa:	89 0d 10 00 c0 fe    	mov    %ecx,0xfec00010
  1037b0:	8d 4a 01             	lea    0x1(%edx),%ecx
  1037b3:	83 c2 02             	add    $0x2,%edx
  //  if(id != ioapicid)
  //    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  1037b6:	39 c3                	cmp    %eax,%ebx
}

static void
ioapicwrite(int32_t reg, uint32_t data)
{
  ioapic->reg = reg;
  1037b8:	89 0d 00 00 c0 fe    	mov    %ecx,0xfec00000
  ioapic->data = data;
  1037be:	c7 05 10 00 c0 fe 00 	movl   $0x0,0xfec00010
  1037c5:	00 00 00 
  //  if(id != ioapicid)
  //    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  1037c8:	7d ce                	jge    103798 <ioapicinit+0x38>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
  1037ca:	5b                   	pop    %ebx
  1037cb:	c3                   	ret    
  1037cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001037d0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
  1037d0:	53                   	push   %ebx
  1037d1:	8b 44 24 08          	mov    0x8(%esp),%eax
  1037d5:	8b 54 24 0c          	mov    0xc(%esp),%edx
  //if(!ismp) return;        // is multi-processor?

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  1037d9:	8d 58 20             	lea    0x20(%eax),%ebx
  1037dc:	8d 4c 00 10          	lea    0x10(%eax,%eax,1),%ecx
}

static void
ioapicwrite(int32_t reg, uint32_t data)
{
  ioapic->reg = reg;
  1037e0:	a1 c0 b8 9c 00       	mov    0x9cb8c0,%eax

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
  1037e5:	c1 e2 18             	shl    $0x18,%edx
}

static void
ioapicwrite(int32_t reg, uint32_t data)
{
  ioapic->reg = reg;
  1037e8:	89 08                	mov    %ecx,(%eax)

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
  1037ea:	83 c1 01             	add    $0x1,%ecx

static void
ioapicwrite(int32_t reg, uint32_t data)
{
  ioapic->reg = reg;
  ioapic->data = data;
  1037ed:	89 58 10             	mov    %ebx,0x10(%eax)
}

static void
ioapicwrite(int32_t reg, uint32_t data)
{
  ioapic->reg = reg;
  1037f0:	89 08                	mov    %ecx,(%eax)
  ioapic->data = data;
  1037f2:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
  1037f5:	5b                   	pop    %ebx
  1037f6:	c3                   	ret    
  1037f7:	66 90                	xchg   %ax,%ax
  1037f9:	66 90                	xchg   %ax,%ax
  1037fb:	66 90                	xchg   %ax,%ax
  1037fd:	66 90                	xchg   %ax,%ax
  1037ff:	90                   	nop

00103800 <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(uint16_t mask)
{
  103800:	53                   	push   %ebx
  103801:	89 c3                	mov    %eax,%ebx
  103803:	83 ec 18             	sub    $0x18,%esp
  irqmask = mask;
  outb(IO_PIC1+1, mask);
  outb(IO_PIC2+1, mask >> 8);
  103806:	0f b6 df             	movzbl %bh,%ebx
static uint16_t irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(uint16_t mask)
{
  irqmask = mask;
  103809:	66 a3 08 03 11 00    	mov    %ax,0x110308
  outb(IO_PIC1+1, mask);
  10380f:	0f b6 c0             	movzbl %al,%eax
  103812:	89 44 24 04          	mov    %eax,0x4(%esp)
  103816:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  10381d:	e8 3e 18 00 00       	call   105060 <outb>
  outb(IO_PIC2+1, mask >> 8);
  103822:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  103826:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  10382d:	e8 2e 18 00 00       	call   105060 <outb>
}
  103832:	83 c4 18             	add    $0x18,%esp
  103835:	5b                   	pop    %ebx
  103836:	c3                   	ret    
  103837:	89 f6                	mov    %esi,%esi
  103839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103840 <picenable>:

void
picenable(int32_t irq)
{
  picsetmask(irqmask & ~(1<<irq));
  103840:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  103844:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
  103849:	d3 c0                	rol    %cl,%eax
  10384b:	66 23 05 08 03 11 00 	and    0x110308,%ax
  103852:	0f b7 c0             	movzwl %ax,%eax
  103855:	eb a9                	jmp    103800 <picsetmask>
  103857:	89 f6                	mov    %esi,%esi
  103859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103860 <picinit>:
}

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
  103860:	83 ec 1c             	sub    $0x1c,%esp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  103863:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
  10386a:	00 
  10386b:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  103872:	e8 e9 17 00 00       	call   105060 <outb>
  outb(IO_PIC2+1, 0xFF);
  103877:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
  10387e:	00 
  10387f:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  103886:	e8 d5 17 00 00       	call   105060 <outb>

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
  10388b:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
  103892:	00 
  103893:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10389a:	e8 c1 17 00 00       	call   105060 <outb>

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
  10389f:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  1038a6:	00 
  1038a7:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  1038ae:	e8 ad 17 00 00       	call   105060 <outb>

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
  1038b3:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
  1038ba:	00 
  1038bb:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  1038c2:	e8 99 17 00 00       	call   105060 <outb>
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
  1038c7:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
  1038ce:	00 
  1038cf:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  1038d6:	e8 85 17 00 00       	call   105060 <outb>

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
  1038db:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
  1038e2:	00 
  1038e3:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
  1038ea:	e8 71 17 00 00       	call   105060 <outb>
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
  1038ef:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
  1038f6:	00 
  1038f7:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  1038fe:	e8 5d 17 00 00       	call   105060 <outb>
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
  103903:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  10390a:	00 
  10390b:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  103912:	e8 49 17 00 00       	call   105060 <outb>
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
  103917:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
  10391e:	00 
  10391f:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  103926:	e8 35 17 00 00       	call   105060 <outb>

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
  10392b:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
  103932:	00 
  103933:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10393a:	e8 21 17 00 00       	call   105060 <outb>
  outb(IO_PIC1, 0x0a);             // read IRR by default
  10393f:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
  103946:	00 
  103947:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10394e:	e8 0d 17 00 00       	call   105060 <outb>

  outb(IO_PIC2, 0x68);             // OCW3
  103953:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
  10395a:	00 
  10395b:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
  103962:	e8 f9 16 00 00       	call   105060 <outb>
  outb(IO_PIC2, 0x0a);             // OCW3
  103967:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
  10396e:	00 
  10396f:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
  103976:	e8 e5 16 00 00       	call   105060 <outb>

  if(irqmask != 0xFFFF)
  10397b:	0f b7 05 08 03 11 00 	movzwl 0x110308,%eax
  103982:	66 83 f8 ff          	cmp    $0xffff,%ax
  103986:	74 08                	je     103990 <picinit+0x130>
    picsetmask(irqmask);
}
  103988:	83 c4 1c             	add    $0x1c,%esp

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
    picsetmask(irqmask);
  10398b:	e9 70 fe ff ff       	jmp    103800 <picsetmask>
}
  103990:	83 c4 1c             	add    $0x1c,%esp
  103993:	c3                   	ret    
  103994:	66 90                	xchg   %ax,%ax
  103996:	66 90                	xchg   %ax,%ax
  103998:	66 90                	xchg   %ax,%ax
  10399a:	66 90                	xchg   %ax,%ax
  10399c:	66 90                	xchg   %ax,%ax
  10399e:	66 90                	xchg   %ax,%ax

001039a0 <ide_start>:
/**
 * Start the request for b.  Caller must hold ide_lk.
 */
static void
ide_start(struct buf *b)
{
  1039a0:	53                   	push   %ebx
  1039a1:	89 c3                	mov    %eax,%ebx
  1039a3:	83 ec 18             	sub    $0x18,%esp
  if(b == 0)
  1039a6:	85 c0                	test   %eax,%eax
  1039a8:	0f 84 f6 00 00 00    	je     103aa4 <ide_start+0x104>
  1039ae:	66 90                	xchg   %ax,%ax
static int
ide_wait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
  1039b0:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
  1039b7:	e8 74 16 00 00       	call   105030 <inb>
  1039bc:	83 e0 c0             	and    $0xffffffc0,%eax
  1039bf:	3c 40                	cmp    $0x40,%al
  1039c1:	75 ed                	jne    1039b0 <ide_start+0x10>
{
  if(b == 0)
    KERN_PANIC("ide_start");

  ide_wait(0);
  outb(0x3f6, 0);  // generate interrupt
  1039c3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1039ca:	00 
  1039cb:	c7 04 24 f6 03 00 00 	movl   $0x3f6,(%esp)
  1039d2:	e8 89 16 00 00       	call   105060 <outb>
  outb(0x1f2, 1);  // number of sectors
  1039d7:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1039de:	00 
  1039df:	c7 04 24 f2 01 00 00 	movl   $0x1f2,(%esp)
  1039e6:	e8 75 16 00 00       	call   105060 <outb>
  1039eb:	0f b6 43 08          	movzbl 0x8(%ebx),%eax
  outb(0x1f3, b->sector & 0xff);
  1039ef:	c7 04 24 f3 01 00 00 	movl   $0x1f3,(%esp)
  1039f6:	89 44 24 04          	mov    %eax,0x4(%esp)
  1039fa:	e8 61 16 00 00       	call   105060 <outb>
  1039ff:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  outb(0x1f4, (b->sector >> 8) & 0xff);
  103a03:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
  103a0a:	89 44 24 04          	mov    %eax,0x4(%esp)
  103a0e:	e8 4d 16 00 00       	call   105060 <outb>
  103a13:	0f b6 43 0a          	movzbl 0xa(%ebx),%eax
  outb(0x1f5, (b->sector >> 16) & 0xff);
  103a17:	c7 04 24 f5 01 00 00 	movl   $0x1f5,(%esp)
  103a1e:	89 44 24 04          	mov    %eax,0x4(%esp)
  103a22:	e8 39 16 00 00       	call   105060 <outb>
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
  103a27:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
  103a2b:	0f b6 53 0b          	movzbl 0xb(%ebx),%edx
  103a2f:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
  103a36:	83 e0 01             	and    $0x1,%eax
  103a39:	83 e2 0f             	and    $0xf,%edx
  103a3c:	c1 e0 04             	shl    $0x4,%eax
  103a3f:	09 d0                	or     %edx,%eax
  103a41:	83 c8 e0             	or     $0xffffffe0,%eax
  103a44:	0f b6 c0             	movzbl %al,%eax
  103a47:	89 44 24 04          	mov    %eax,0x4(%esp)
  103a4b:	e8 10 16 00 00       	call   105060 <outb>
  if(b->flags & B_DIRTY){
  103a50:	f6 03 04             	testb  $0x4,(%ebx)
  103a53:	75 1b                	jne    103a70 <ide_start+0xd0>
    outb(0x1f7, IDE_CMD_WRITE);
    outsl(0x1f0, b->data, 512/4);
  } else {
    outb(0x1f7, IDE_CMD_READ);
  103a55:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  103a5c:	00 
  103a5d:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
  103a64:	e8 f7 15 00 00       	call   105060 <outb>
  }
}
  103a69:	83 c4 18             	add    $0x18,%esp
  103a6c:	5b                   	pop    %ebx
  103a6d:	c3                   	ret    
  103a6e:	66 90                	xchg   %ax,%ax
  outb(0x1f3, b->sector & 0xff);
  outb(0x1f4, (b->sector >> 8) & 0xff);
  outb(0x1f5, (b->sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, IDE_CMD_WRITE);
  103a70:	c7 44 24 04 30 00 00 	movl   $0x30,0x4(%esp)
  103a77:	00 
    outsl(0x1f0, b->data, 512/4);
  103a78:	83 c3 18             	add    $0x18,%ebx
  outb(0x1f3, b->sector & 0xff);
  outb(0x1f4, (b->sector >> 8) & 0xff);
  outb(0x1f5, (b->sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, IDE_CMD_WRITE);
  103a7b:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
  103a82:	e8 d9 15 00 00       	call   105060 <outb>
    outsl(0x1f0, b->data, 512/4);
  103a87:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  103a8b:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
  103a92:	00 
  103a93:	c7 04 24 f0 01 00 00 	movl   $0x1f0,(%esp)
  103a9a:	e8 f1 15 00 00       	call   105090 <outsl>
  } else {
    outb(0x1f7, IDE_CMD_READ);
  }
}
  103a9f:	83 c4 18             	add    $0x18,%esp
  103aa2:	5b                   	pop    %ebx
  103aa3:	c3                   	ret    
 */
static void
ide_start(struct buf *b)
{
  if(b == 0)
    KERN_PANIC("ide_start");
  103aa4:	c7 44 24 08 b8 bd 10 	movl   $0x10bdb8,0x8(%esp)
  103aab:	00 
  103aac:	c7 44 24 04 43 00 00 	movl   $0x43,0x4(%esp)
  103ab3:	00 
  103ab4:	c7 04 24 c2 bd 10 00 	movl   $0x10bdc2,(%esp)
  103abb:	e8 c0 06 00 00       	call   104180 <debug_panic>
  103ac0:	e9 eb fe ff ff       	jmp    1039b0 <ide_start+0x10>
  103ac5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103ad0 <ide_init>:
  return 0;
}

void
ide_init(void)
{
  103ad0:	53                   	push   %ebx
  103ad1:	83 ec 18             	sub    $0x18,%esp
  int i;

  spinlock_init(&ide_lk);
  103ad4:	c7 04 24 78 fe 13 00 	movl   $0x13fe78,(%esp)
  103adb:	e8 d0 1d 00 00       	call   1058b0 <spinlock_init>
  picenable(IRQ_IDE1);
  103ae0:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  103ae7:	e8 54 fd ff ff       	call   103840 <picenable>
  ioapicenable(IRQ_IDE1, pcpu_ncpu() - 1);
  103aec:	e8 6f fa ff ff       	call   103560 <pcpu_ncpu>
  103af1:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  103af8:	83 e8 01             	sub    $0x1,%eax
  103afb:	89 44 24 04          	mov    %eax,0x4(%esp)
  103aff:	e8 cc fc ff ff       	call   1037d0 <ioapicenable>
  103b04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static int
ide_wait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
  103b08:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
  103b0f:	e8 1c 15 00 00       	call   105030 <inb>
  103b14:	83 e0 c0             	and    $0xffffffc0,%eax
  103b17:	3c 40                	cmp    $0x40,%al
  103b19:	75 ed                	jne    103b08 <ide_init+0x38>
  picenable(IRQ_IDE1);
  ioapicenable(IRQ_IDE1, pcpu_ncpu() - 1);
  ide_wait(0);
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  103b1b:	c7 44 24 04 f0 00 00 	movl   $0xf0,0x4(%esp)
  103b22:	00 
  103b23:	bb e8 03 00 00       	mov    $0x3e8,%ebx
  103b28:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
  103b2f:	e8 2c 15 00 00       	call   105060 <outb>
  103b34:	eb 07                	jmp    103b3d <ide_init+0x6d>
  103b36:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
  103b38:	83 eb 01             	sub    $0x1,%ebx
  103b3b:	74 1a                	je     103b57 <ide_init+0x87>
    if(inb(0x1f7) != 0){
  103b3d:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
  103b44:	e8 e7 14 00 00       	call   105030 <inb>
  103b49:	84 c0                	test   %al,%al
  103b4b:	74 eb                	je     103b38 <ide_init+0x68>
      havedisk1 = 1;
  103b4d:	c7 05 70 fe 13 00 01 	movl   $0x1,0x13fe70
  103b54:	00 00 00 
      break;
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
  103b57:	c7 44 24 04 e0 00 00 	movl   $0xe0,0x4(%esp)
  103b5e:	00 
  103b5f:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
  103b66:	e8 f5 14 00 00       	call   105060 <outb>
}
  103b6b:	83 c4 18             	add    $0x18,%esp
  103b6e:	5b                   	pop    %ebx
  103b6f:	c3                   	ret    

00103b70 <ide_intr>:
/**
 * Interrupt handler.
 */
void
ide_intr(void)
{
  103b70:	53                   	push   %ebx
  103b71:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  spinlock_acquire(&ide_lk);
  103b74:	c7 04 24 78 fe 13 00 	movl   $0x13fe78,(%esp)
  103b7b:	e8 f0 1e 00 00       	call   105a70 <spinlock_acquire>
  if((b = idequeue) == 0){
  103b80:	8b 1d 74 fe 13 00    	mov    0x13fe74,%ebx
  103b86:	85 db                	test   %ebx,%ebx
  103b88:	74 7e                	je     103c08 <ide_intr+0x98>
    spinlock_release(&ide_lk);
    KERN_INFO("spurious IDE interrupt\n");
    return;
  }
  idequeue = b->qnext;
  103b8a:	8b 43 14             	mov    0x14(%ebx),%eax
  103b8d:	a3 74 fe 13 00       	mov    %eax,0x13fe74
  103b92:	8b 03                	mov    (%ebx),%eax

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && ide_wait(1) >= 0)
  103b94:	a8 04                	test   $0x4,%al
  103b96:	74 30                	je     103bc8 <ide_intr+0x58>
    insl(0x1f0, b->data, 512/4);
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
  103b98:	83 e0 fb             	and    $0xfffffffb,%eax
  103b9b:	83 c8 02             	or     $0x2,%eax
  103b9e:	89 03                	mov    %eax,(%ebx)
  thread_wakeup(b);
  103ba0:	89 1c 24             	mov    %ebx,(%esp)
  103ba3:	e8 c8 36 00 00       	call   107270 <thread_wakeup>
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
  103ba8:	a1 74 fe 13 00       	mov    0x13fe74,%eax
  103bad:	85 c0                	test   %eax,%eax
  103baf:	74 05                	je     103bb6 <ide_intr+0x46>
    ide_start(idequeue);
  103bb1:	e8 ea fd ff ff       	call   1039a0 <ide_start>

  spinlock_release(&ide_lk);
  103bb6:	c7 04 24 78 fe 13 00 	movl   $0x13fe78,(%esp)
  103bbd:	e8 2e 1f 00 00       	call   105af0 <spinlock_release>
}
  103bc2:	83 c4 18             	add    $0x18,%esp
  103bc5:	5b                   	pop    %ebx
  103bc6:	c3                   	ret    
  103bc7:	90                   	nop
static int
ide_wait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
  103bc8:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
  103bcf:	e8 5c 14 00 00       	call   105030 <inb>
  103bd4:	89 c2                	mov    %eax,%edx
  103bd6:	83 e2 c0             	and    $0xffffffc0,%edx
  103bd9:	80 fa 40             	cmp    $0x40,%dl
  103bdc:	75 ea                	jne    103bc8 <ide_intr+0x58>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
  103bde:	a8 21                	test   $0x21,%al
  103be0:	75 40                	jne    103c22 <ide_intr+0xb2>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && ide_wait(1) >= 0)
    insl(0x1f0, b->data, 512/4);
  103be2:	8d 43 18             	lea    0x18(%ebx),%eax
  103be5:	89 44 24 04          	mov    %eax,0x4(%esp)
  103be9:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
  103bf0:	00 
  103bf1:	c7 04 24 f0 01 00 00 	movl   $0x1f0,(%esp)
  103bf8:	e8 43 14 00 00       	call   105040 <insl>
  103bfd:	8b 03                	mov    (%ebx),%eax
  103bff:	eb 97                	jmp    103b98 <ide_intr+0x28>
  103c01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct buf *b;

  // First queued buffer is the active request.
  spinlock_acquire(&ide_lk);
  if((b = idequeue) == 0){
    spinlock_release(&ide_lk);
  103c08:	c7 04 24 78 fe 13 00 	movl   $0x13fe78,(%esp)
  103c0f:	e8 dc 1e 00 00       	call   105af0 <spinlock_release>
    KERN_INFO("spurious IDE interrupt\n");
  103c14:	c7 04 24 d6 bd 10 00 	movl   $0x10bdd6,(%esp)
  103c1b:	e8 d0 04 00 00       	call   1040f0 <debug_info>
    return;
  103c20:	eb a0                	jmp    103bc2 <ide_intr+0x52>
  103c22:	8b 03                	mov    (%ebx),%eax
  103c24:	e9 6f ff ff ff       	jmp    103b98 <ide_intr+0x28>
  103c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103c30 <ide_rw>:
 * If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
 * Else if B_VALID is not set, read buf from disk, set B_VALID.
 */
void
ide_rw(struct buf *b)
{
  103c30:	53                   	push   %ebx
  103c31:	83 ec 18             	sub    $0x18,%esp
  103c34:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  103c38:	8b 03                	mov    (%ebx),%eax
  struct buf **pp;
  //KERN_INFO("  !! ide_rw\n");

  if(!(b->flags & B_BUSY))
  103c3a:	a8 01                	test   $0x1,%al
  103c3c:	0f 84 9e 00 00 00    	je     103ce0 <ide_rw+0xb0>
    KERN_PANIC("ide_rw: buf not busy");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
  103c42:	83 e0 06             	and    $0x6,%eax
  103c45:	83 f8 02             	cmp    $0x2,%eax
  103c48:	0f 84 bc 00 00 00    	je     103d0a <ide_rw+0xda>
    KERN_PANIC("ide_rw: nothing to do");
  if(b->dev != 0 && !havedisk1)
  103c4e:	8b 53 04             	mov    0x4(%ebx),%edx
  103c51:	85 d2                	test   %edx,%edx
  103c53:	74 0d                	je     103c62 <ide_rw+0x32>
  103c55:	a1 70 fe 13 00       	mov    0x13fe70,%eax
  103c5a:	85 c0                	test   %eax,%eax
  103c5c:	0f 84 ce 00 00 00    	je     103d30 <ide_rw+0x100>
    KERN_PANIC("ide_rw: ide disk 1 not present");

  spinlock_acquire(&ide_lk);  //DOC:acquire-lock
  103c62:	c7 04 24 78 fe 13 00 	movl   $0x13fe78,(%esp)
  103c69:	e8 02 1e 00 00       	call   105a70 <spinlock_acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
  103c6e:	a1 74 fe 13 00       	mov    0x13fe74,%eax
    KERN_PANIC("ide_rw: ide disk 1 not present");

  spinlock_acquire(&ide_lk);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  103c73:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
  103c7a:	85 c0                	test   %eax,%eax
  103c7c:	75 0c                	jne    103c8a <ide_rw+0x5a>
  103c7e:	e9 ce 00 00 00       	jmp    103d51 <ide_rw+0x121>
  103c83:	90                   	nop
  103c84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103c88:	89 d0                	mov    %edx,%eax
  103c8a:	8b 50 14             	mov    0x14(%eax),%edx
  103c8d:	85 d2                	test   %edx,%edx
  103c8f:	75 f7                	jne    103c88 <ide_rw+0x58>
  103c91:	83 c0 14             	add    $0x14,%eax
    ;
  *pp = b;
  103c94:	89 18                	mov    %ebx,(%eax)
  
  // Start disk if necessary.
  if(idequeue == b)
  103c96:	39 1d 74 fe 13 00    	cmp    %ebx,0x13fe74
  103c9c:	0f 84 b9 00 00 00    	je     103d5b <ide_rw+0x12b>
    ide_start(b);
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
  103ca2:	8b 03                	mov    (%ebx),%eax
  103ca4:	83 e0 06             	and    $0x6,%eax
  103ca7:	83 f8 02             	cmp    $0x2,%eax
  103caa:	74 1e                	je     103cca <ide_rw+0x9a>
  103cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    thread_sleep(b, &ide_lk);
  103cb0:	c7 44 24 04 78 fe 13 	movl   $0x13fe78,0x4(%esp)
  103cb7:	00 
  103cb8:	89 1c 24             	mov    %ebx,(%esp)
  103cbb:	e8 c0 34 00 00       	call   107180 <thread_sleep>
  // Start disk if necessary.
  if(idequeue == b)
    ide_start(b);
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
  103cc0:	8b 13                	mov    (%ebx),%edx
  103cc2:	83 e2 06             	and    $0x6,%edx
  103cc5:	83 fa 02             	cmp    $0x2,%edx
  103cc8:	75 e6                	jne    103cb0 <ide_rw+0x80>
    thread_sleep(b, &ide_lk);
  }

  spinlock_release(&ide_lk);
  103cca:	c7 44 24 20 78 fe 13 	movl   $0x13fe78,0x20(%esp)
  103cd1:	00 
}
  103cd2:	83 c4 18             	add    $0x18,%esp
  103cd5:	5b                   	pop    %ebx
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    thread_sleep(b, &ide_lk);
  }

  spinlock_release(&ide_lk);
  103cd6:	e9 15 1e 00 00       	jmp    105af0 <spinlock_release>
  103cdb:	90                   	nop
  103cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  struct buf **pp;
  //KERN_INFO("  !! ide_rw\n");

  if(!(b->flags & B_BUSY))
    KERN_PANIC("ide_rw: buf not busy");
  103ce0:	c7 44 24 08 ee bd 10 	movl   $0x10bdee,0x8(%esp)
  103ce7:	00 
  103ce8:	c7 44 24 04 81 00 00 	movl   $0x81,0x4(%esp)
  103cef:	00 
  103cf0:	c7 04 24 c2 bd 10 00 	movl   $0x10bdc2,(%esp)
  103cf7:	e8 84 04 00 00       	call   104180 <debug_panic>
  103cfc:	8b 03                	mov    (%ebx),%eax
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
  103cfe:	83 e0 06             	and    $0x6,%eax
  103d01:	83 f8 02             	cmp    $0x2,%eax
  103d04:	0f 85 44 ff ff ff    	jne    103c4e <ide_rw+0x1e>
    KERN_PANIC("ide_rw: nothing to do");
  103d0a:	c7 44 24 08 03 be 10 	movl   $0x10be03,0x8(%esp)
  103d11:	00 
  103d12:	c7 44 24 04 83 00 00 	movl   $0x83,0x4(%esp)
  103d19:	00 
  103d1a:	c7 04 24 c2 bd 10 00 	movl   $0x10bdc2,(%esp)
  103d21:	e8 5a 04 00 00       	call   104180 <debug_panic>
  103d26:	e9 23 ff ff ff       	jmp    103c4e <ide_rw+0x1e>
  103d2b:	90                   	nop
  103d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(b->dev != 0 && !havedisk1)
    KERN_PANIC("ide_rw: ide disk 1 not present");
  103d30:	c7 44 24 08 1c be 10 	movl   $0x10be1c,0x8(%esp)
  103d37:	00 
  103d38:	c7 44 24 04 85 00 00 	movl   $0x85,0x4(%esp)
  103d3f:	00 
  103d40:	c7 04 24 c2 bd 10 00 	movl   $0x10bdc2,(%esp)
  103d47:	e8 34 04 00 00       	call   104180 <debug_panic>
  103d4c:	e9 11 ff ff ff       	jmp    103c62 <ide_rw+0x32>

  spinlock_acquire(&ide_lk);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
  103d51:	b8 74 fe 13 00       	mov    $0x13fe74,%eax
  103d56:	e9 39 ff ff ff       	jmp    103c94 <ide_rw+0x64>
    ;
  *pp = b;
  
  // Start disk if necessary.
  if(idequeue == b)
    ide_start(b);
  103d5b:	89 d8                	mov    %ebx,%eax
  103d5d:	e8 3e fc ff ff       	call   1039a0 <ide_start>
  103d62:	e9 3b ff ff ff       	jmp    103ca2 <ide_rw+0x72>
  103d67:	66 90                	xchg   %ax,%ax
  103d69:	66 90                	xchg   %ax,%ax
  103d6b:	66 90                	xchg   %ax,%ax
  103d6d:	66 90                	xchg   %ax,%ax
  103d6f:	90                   	nop

00103d70 <memset>:
#include "string.h"
#include "types.h"

void *
memset(void *v, int c, size_t n)
{
  103d70:	57                   	push   %edi
  103d71:	56                   	push   %esi
  103d72:	53                   	push   %ebx
  103d73:	8b 4c 24 18          	mov    0x18(%esp),%ecx
  103d77:	8b 7c 24 10          	mov    0x10(%esp),%edi
    if (n == 0)
  103d7b:	85 c9                	test   %ecx,%ecx
  103d7d:	74 14                	je     103d93 <memset+0x23>
        return v;
    if ((int)v%4 == 0 && n%4 == 0) {
  103d7f:	f7 c7 03 00 00 00    	test   $0x3,%edi
  103d85:	75 05                	jne    103d8c <memset+0x1c>
  103d87:	f6 c1 03             	test   $0x3,%cl
  103d8a:	74 14                	je     103da0 <memset+0x30>
        c = (c<<24)|(c<<16)|(c<<8)|c;
        asm volatile("cld; rep stosl\n"
                 :: "D" (v), "a" (c), "c" (n/4)
                 : "cc", "memory");
    } else
        asm volatile("cld; rep stosb\n"
  103d8c:	8b 44 24 14          	mov    0x14(%esp),%eax
  103d90:	fc                   	cld    
  103d91:	f3 aa                	rep stos %al,%es:(%edi)
                 :: "D" (v), "a" (c), "c" (n)
                 : "cc", "memory");
    return v;
}
  103d93:	89 f8                	mov    %edi,%eax
  103d95:	5b                   	pop    %ebx
  103d96:	5e                   	pop    %esi
  103d97:	5f                   	pop    %edi
  103d98:	c3                   	ret    
  103d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
memset(void *v, int c, size_t n)
{
    if (n == 0)
        return v;
    if ((int)v%4 == 0 && n%4 == 0) {
        c &= 0xFF;
  103da0:	0f b6 54 24 14       	movzbl 0x14(%esp),%edx
        c = (c<<24)|(c<<16)|(c<<8)|c;
        asm volatile("cld; rep stosl\n"
                 :: "D" (v), "a" (c), "c" (n/4)
  103da5:	c1 e9 02             	shr    $0x2,%ecx
{
    if (n == 0)
        return v;
    if ((int)v%4 == 0 && n%4 == 0) {
        c &= 0xFF;
        c = (c<<24)|(c<<16)|(c<<8)|c;
  103da8:	89 d0                	mov    %edx,%eax
  103daa:	89 d6                	mov    %edx,%esi
  103dac:	c1 e0 18             	shl    $0x18,%eax
  103daf:	89 d3                	mov    %edx,%ebx
  103db1:	c1 e6 10             	shl    $0x10,%esi
  103db4:	09 f0                	or     %esi,%eax
  103db6:	c1 e3 08             	shl    $0x8,%ebx
  103db9:	09 d0                	or     %edx,%eax
  103dbb:	09 d8                	or     %ebx,%eax
        asm volatile("cld; rep stosl\n"
  103dbd:	fc                   	cld    
  103dbe:	f3 ab                	rep stos %eax,%es:(%edi)
    } else
        asm volatile("cld; rep stosb\n"
                 :: "D" (v), "a" (c), "c" (n)
                 : "cc", "memory");
    return v;
}
  103dc0:	89 f8                	mov    %edi,%eax
  103dc2:	5b                   	pop    %ebx
  103dc3:	5e                   	pop    %esi
  103dc4:	5f                   	pop    %edi
  103dc5:	c3                   	ret    
  103dc6:	8d 76 00             	lea    0x0(%esi),%esi
  103dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103dd0 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  103dd0:	57                   	push   %edi
  103dd1:	56                   	push   %esi
  103dd2:	8b 44 24 0c          	mov    0xc(%esp),%eax
  103dd6:	8b 74 24 10          	mov    0x10(%esp),%esi
  103dda:	8b 4c 24 14          	mov    0x14(%esp),%ecx
    const char *s;
    char *d;

    s = src;
    d = dst;
    if (s < d && s + n > d) {
  103dde:	39 c6                	cmp    %eax,%esi
  103de0:	73 26                	jae    103e08 <memmove+0x38>
  103de2:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
  103de5:	39 d0                	cmp    %edx,%eax
  103de7:	73 1f                	jae    103e08 <memmove+0x38>
        s += n;
        d += n;
  103de9:	8d 3c 08             	lea    (%eax,%ecx,1),%edi
  103dec:	89 d6                	mov    %edx,%esi
  103dee:	09 fe                	or     %edi,%esi
        if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
  103df0:	83 e6 03             	and    $0x3,%esi
  103df3:	74 33                	je     103e28 <memmove+0x58>
            asm volatile("std; rep movsl\n"
                     :: "D" (d-4), "S" (s-4), "c" (n/4)
                     : "cc", "memory");
        else
            asm volatile("std; rep movsb\n"
                     :: "D" (d-1), "S" (s-1), "c" (n)
  103df5:	83 ef 01             	sub    $0x1,%edi
  103df8:	8d 72 ff             	lea    -0x1(%edx),%esi
        if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
            asm volatile("std; rep movsl\n"
                     :: "D" (d-4), "S" (s-4), "c" (n/4)
                     : "cc", "memory");
        else
            asm volatile("std; rep movsb\n"
  103dfb:	fd                   	std    
  103dfc:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
                     :: "D" (d-1), "S" (s-1), "c" (n)
                     : "cc", "memory");
        // Some versions of GCC rely on DF being clear
        asm volatile("cld" ::: "cc");
  103dfe:	fc                   	cld    
            asm volatile("cld; rep movsb\n"
                     :: "D" (d), "S" (s), "c" (n)
                     : "cc", "memory");
    }
    return dst;
}
  103dff:	5e                   	pop    %esi
  103e00:	5f                   	pop    %edi
  103e01:	c3                   	ret    
  103e02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103e08:	89 f2                	mov    %esi,%edx
  103e0a:	09 c2                	or     %eax,%edx
                     :: "D" (d-1), "S" (s-1), "c" (n)
                     : "cc", "memory");
        // Some versions of GCC rely on DF being clear
        asm volatile("cld" ::: "cc");
    } else {
        if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
  103e0c:	83 e2 03             	and    $0x3,%edx
  103e0f:	75 0f                	jne    103e20 <memmove+0x50>
  103e11:	f6 c1 03             	test   $0x3,%cl
  103e14:	75 0a                	jne    103e20 <memmove+0x50>
            asm volatile("cld; rep movsl\n"
                     :: "D" (d), "S" (s), "c" (n/4)
  103e16:	c1 e9 02             	shr    $0x2,%ecx
                     : "cc", "memory");
        // Some versions of GCC rely on DF being clear
        asm volatile("cld" ::: "cc");
    } else {
        if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
            asm volatile("cld; rep movsl\n"
  103e19:	89 c7                	mov    %eax,%edi
  103e1b:	fc                   	cld    
  103e1c:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  103e1e:	eb 05                	jmp    103e25 <memmove+0x55>
                     :: "D" (d), "S" (s), "c" (n/4)
                     : "cc", "memory");
        else
            asm volatile("cld; rep movsb\n"
  103e20:	89 c7                	mov    %eax,%edi
  103e22:	fc                   	cld    
  103e23:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
                     :: "D" (d), "S" (s), "c" (n)
                     : "cc", "memory");
    }
    return dst;
}
  103e25:	5e                   	pop    %esi
  103e26:	5f                   	pop    %edi
  103e27:	c3                   	ret    
    s = src;
    d = dst;
    if (s < d && s + n > d) {
        s += n;
        d += n;
        if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
  103e28:	f6 c1 03             	test   $0x3,%cl
  103e2b:	75 c8                	jne    103df5 <memmove+0x25>
            asm volatile("std; rep movsl\n"
                     :: "D" (d-4), "S" (s-4), "c" (n/4)
  103e2d:	83 ef 04             	sub    $0x4,%edi
  103e30:	8d 72 fc             	lea    -0x4(%edx),%esi
  103e33:	c1 e9 02             	shr    $0x2,%ecx
    d = dst;
    if (s < d && s + n > d) {
        s += n;
        d += n;
        if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
            asm volatile("std; rep movsl\n"
  103e36:	fd                   	std    
  103e37:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  103e39:	eb c3                	jmp    103dfe <memmove+0x2e>
  103e3b:	90                   	nop
  103e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103e40 <memcpy>:
}

void *
memcpy(void *dst, const void *src, size_t n)
{
	return memmove(dst, src, n);
  103e40:	eb 8e                	jmp    103dd0 <memmove>
  103e42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103e50 <strncmp>:
}

int
strncmp(const char *p, const char *q, size_t n)
{
  103e50:	56                   	push   %esi
  103e51:	53                   	push   %ebx
  103e52:	8b 74 24 14          	mov    0x14(%esp),%esi
  103e56:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  103e5a:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	while (n > 0 && *p && *p == *q)
  103e5e:	85 f6                	test   %esi,%esi
  103e60:	74 30                	je     103e92 <strncmp+0x42>
  103e62:	0f b6 01             	movzbl (%ecx),%eax
  103e65:	84 c0                	test   %al,%al
  103e67:	74 2e                	je     103e97 <strncmp+0x47>
  103e69:	0f b6 13             	movzbl (%ebx),%edx
  103e6c:	38 d0                	cmp    %dl,%al
  103e6e:	75 3e                	jne    103eae <strncmp+0x5e>
  103e70:	8d 51 01             	lea    0x1(%ecx),%edx
  103e73:	01 ce                	add    %ecx,%esi
  103e75:	eb 14                	jmp    103e8b <strncmp+0x3b>
  103e77:	90                   	nop
  103e78:	0f b6 02             	movzbl (%edx),%eax
  103e7b:	84 c0                	test   %al,%al
  103e7d:	74 29                	je     103ea8 <strncmp+0x58>
  103e7f:	0f b6 19             	movzbl (%ecx),%ebx
  103e82:	83 c2 01             	add    $0x1,%edx
  103e85:	38 d8                	cmp    %bl,%al
  103e87:	75 17                	jne    103ea0 <strncmp+0x50>
		n--, p++, q++;
  103e89:	89 cb                	mov    %ecx,%ebx
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
  103e8b:	39 f2                	cmp    %esi,%edx
		n--, p++, q++;
  103e8d:	8d 4b 01             	lea    0x1(%ebx),%ecx
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
  103e90:	75 e6                	jne    103e78 <strncmp+0x28>
		n--, p++, q++;
	if (n == 0)
		return 0;
  103e92:	31 c0                	xor    %eax,%eax
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
}
  103e94:	5b                   	pop    %ebx
  103e95:	5e                   	pop    %esi
  103e96:	c3                   	ret    
  103e97:	0f b6 1b             	movzbl (%ebx),%ebx
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
  103e9a:	31 c0                	xor    %eax,%eax
  103e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		n--, p++, q++;
	if (n == 0)
		return 0;
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  103ea0:	0f b6 d3             	movzbl %bl,%edx
  103ea3:	29 d0                	sub    %edx,%eax
}
  103ea5:	5b                   	pop    %ebx
  103ea6:	5e                   	pop    %esi
  103ea7:	c3                   	ret    
  103ea8:	0f b6 5b 01          	movzbl 0x1(%ebx),%ebx
  103eac:	eb f2                	jmp    103ea0 <strncmp+0x50>
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
  103eae:	89 d3                	mov    %edx,%ebx
  103eb0:	eb ee                	jmp    103ea0 <strncmp+0x50>
  103eb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103ec0 <strnlen>:
		return (int) ((unsigned char) *p - (unsigned char) *q);
}

int
strnlen(const char *s, size_t size)
{
  103ec0:	53                   	push   %ebx
  103ec1:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  103ec5:	8b 5c 24 08          	mov    0x8(%esp),%ebx
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  103ec9:	85 c9                	test   %ecx,%ecx
  103ecb:	74 25                	je     103ef2 <strnlen+0x32>
  103ecd:	80 3b 00             	cmpb   $0x0,(%ebx)
  103ed0:	74 20                	je     103ef2 <strnlen+0x32>
  103ed2:	ba 01 00 00 00       	mov    $0x1,%edx
  103ed7:	eb 11                	jmp    103eea <strnlen+0x2a>
  103ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103ee0:	83 c2 01             	add    $0x1,%edx
  103ee3:	80 7c 13 ff 00       	cmpb   $0x0,-0x1(%ebx,%edx,1)
  103ee8:	74 06                	je     103ef0 <strnlen+0x30>
  103eea:	39 ca                	cmp    %ecx,%edx
		n++;
  103eec:	89 d0                	mov    %edx,%eax
int
strnlen(const char *s, size_t size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  103eee:	75 f0                	jne    103ee0 <strnlen+0x20>
		n++;
	return n;
}
  103ef0:	5b                   	pop    %ebx
  103ef1:	c3                   	ret    
int
strnlen(const char *s, size_t size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  103ef2:	31 c0                	xor    %eax,%eax
		n++;
	return n;
}
  103ef4:	5b                   	pop    %ebx
  103ef5:	c3                   	ret    
  103ef6:	8d 76 00             	lea    0x0(%esi),%esi
  103ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103f00 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  103f00:	53                   	push   %ebx
  103f01:	8b 54 24 08          	mov    0x8(%esp),%edx
  103f05:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  while (*p && *p == *q)
  103f09:	0f b6 02             	movzbl (%edx),%eax
  103f0c:	84 c0                	test   %al,%al
  103f0e:	74 2d                	je     103f3d <strcmp+0x3d>
  103f10:	0f b6 19             	movzbl (%ecx),%ebx
  103f13:	38 d8                	cmp    %bl,%al
  103f15:	74 0f                	je     103f26 <strcmp+0x26>
  103f17:	eb 2b                	jmp    103f44 <strcmp+0x44>
  103f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103f20:	38 c8                	cmp    %cl,%al
  103f22:	75 15                	jne    103f39 <strcmp+0x39>
    p++, q++;
  103f24:	89 d9                	mov    %ebx,%ecx
  103f26:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while (*p && *p == *q)
  103f29:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  103f2c:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
  while (*p && *p == *q)
  103f2f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
  103f33:	84 c0                	test   %al,%al
  103f35:	75 e9                	jne    103f20 <strcmp+0x20>
  103f37:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (int) ((unsigned char) *p - (unsigned char) *q);
  103f39:	29 c8                	sub    %ecx,%eax
}
  103f3b:	5b                   	pop    %ebx
  103f3c:	c3                   	ret    
  103f3d:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
  while (*p && *p == *q)
  103f40:	31 c0                	xor    %eax,%eax
  103f42:	eb f5                	jmp    103f39 <strcmp+0x39>
  103f44:	0f b6 cb             	movzbl %bl,%ecx
  103f47:	eb f0                	jmp    103f39 <strcmp+0x39>
  103f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103f50 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  103f50:	53                   	push   %ebx
  103f51:	8b 44 24 08          	mov    0x8(%esp),%eax
  103f55:	8b 54 24 0c          	mov    0xc(%esp),%edx
  for (; *s; s++)
  103f59:	0f b6 18             	movzbl (%eax),%ebx
  103f5c:	84 db                	test   %bl,%bl
  103f5e:	74 16                	je     103f76 <strchr+0x26>
    if (*s == c)
  103f60:	38 d3                	cmp    %dl,%bl
  103f62:	89 d1                	mov    %edx,%ecx
  103f64:	75 06                	jne    103f6c <strchr+0x1c>
  103f66:	eb 10                	jmp    103f78 <strchr+0x28>
  103f68:	38 ca                	cmp    %cl,%dl
  103f6a:	74 0c                	je     103f78 <strchr+0x28>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  for (; *s; s++)
  103f6c:	83 c0 01             	add    $0x1,%eax
  103f6f:	0f b6 10             	movzbl (%eax),%edx
  103f72:	84 d2                	test   %dl,%dl
  103f74:	75 f2                	jne    103f68 <strchr+0x18>
    if (*s == c)
      return (char *) s;
  return 0;
  103f76:	31 c0                	xor    %eax,%eax
}
  103f78:	5b                   	pop    %ebx
  103f79:	c3                   	ret    
  103f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103f80 <memzero>:

void *
memzero(void *v, size_t n)
{
  103f80:	83 ec 0c             	sub    $0xc,%esp
	return memset(v, 0, n);
  103f83:	8b 44 24 14          	mov    0x14(%esp),%eax
  103f87:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  103f8e:	00 
  103f8f:	89 44 24 08          	mov    %eax,0x8(%esp)
  103f93:	8b 44 24 10          	mov    0x10(%esp),%eax
  103f97:	89 04 24             	mov    %eax,(%esp)
  103f9a:	e8 d1 fd ff ff       	call   103d70 <memset>
}
  103f9f:	83 c4 0c             	add    $0xc,%esp
  103fa2:	c3                   	ret    
  103fa3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103fb0 <memcmp>:

memcmp(const void *v1, const void *v2, size_t n)
{
  103fb0:	57                   	push   %edi
  103fb1:	56                   	push   %esi
  103fb2:	53                   	push   %ebx
  103fb3:	8b 44 24 18          	mov    0x18(%esp),%eax
  103fb7:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  103fbb:	8b 74 24 14          	mov    0x14(%esp),%esi
        const uint8_t *s1 = (const uint8_t *) v1;
        const uint8_t *s2 = (const uint8_t *) v2;

        while (n-- > 0) {
  103fbf:	85 c0                	test   %eax,%eax
  103fc1:	8d 78 ff             	lea    -0x1(%eax),%edi
  103fc4:	74 26                	je     103fec <memcmp+0x3c>
                if (*s1 != *s2)
  103fc6:	0f b6 03             	movzbl (%ebx),%eax
  103fc9:	31 d2                	xor    %edx,%edx
  103fcb:	0f b6 0e             	movzbl (%esi),%ecx
  103fce:	38 c8                	cmp    %cl,%al
  103fd0:	74 16                	je     103fe8 <memcmp+0x38>
  103fd2:	eb 24                	jmp    103ff8 <memcmp+0x48>
  103fd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103fd8:	0f b6 44 13 01       	movzbl 0x1(%ebx,%edx,1),%eax
  103fdd:	83 c2 01             	add    $0x1,%edx
  103fe0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
  103fe4:	38 c8                	cmp    %cl,%al
  103fe6:	75 10                	jne    103ff8 <memcmp+0x48>
memcmp(const void *v1, const void *v2, size_t n)
{
        const uint8_t *s1 = (const uint8_t *) v1;
        const uint8_t *s2 = (const uint8_t *) v2;

        while (n-- > 0) {
  103fe8:	39 fa                	cmp    %edi,%edx
  103fea:	75 ec                	jne    103fd8 <memcmp+0x28>
                        return (int) *s1 - (int) *s2;
                s1++, s2++;
        }

        return 0;
}
  103fec:	5b                   	pop    %ebx
                if (*s1 != *s2)
                        return (int) *s1 - (int) *s2;
                s1++, s2++;
        }

        return 0;
  103fed:	31 c0                	xor    %eax,%eax
}
  103fef:	5e                   	pop    %esi
  103ff0:	5f                   	pop    %edi
  103ff1:	c3                   	ret    
  103ff2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103ff8:	5b                   	pop    %ebx
        const uint8_t *s1 = (const uint8_t *) v1;
        const uint8_t *s2 = (const uint8_t *) v2;

        while (n-- > 0) {
                if (*s1 != *s2)
                        return (int) *s1 - (int) *s2;
  103ff9:	29 c8                	sub    %ecx,%eax
                s1++, s2++;
        }

        return 0;
}
  103ffb:	5e                   	pop    %esi
  103ffc:	5f                   	pop    %edi
  103ffd:	c3                   	ret    
  103ffe:	66 90                	xchg   %ax,%ax

00104000 <strncpy>:

// NEW
char*
strncpy(char *s, const char *t, int n)
{
  104000:	56                   	push   %esi
  104001:	53                   	push   %ebx
  104002:	8b 44 24 0c          	mov    0xc(%esp),%eax
  104006:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  10400a:	8b 4c 24 14          	mov    0x14(%esp),%ecx
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
  10400e:	89 c2                	mov    %eax,%edx
  104010:	eb 19                	jmp    10402b <strncpy+0x2b>
  104012:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104018:	83 c3 01             	add    $0x1,%ebx
  10401b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
  10401f:	83 c2 01             	add    $0x1,%edx
  104022:	84 c9                	test   %cl,%cl
  104024:	88 4a ff             	mov    %cl,-0x1(%edx)
  104027:	74 09                	je     104032 <strncpy+0x32>
  104029:	89 f1                	mov    %esi,%ecx
  10402b:	85 c9                	test   %ecx,%ecx
  10402d:	8d 71 ff             	lea    -0x1(%ecx),%esi
  104030:	7f e6                	jg     104018 <strncpy+0x18>
    ;
  while(n-- > 0)
  104032:	31 c9                	xor    %ecx,%ecx
  104034:	85 f6                	test   %esi,%esi
  104036:	7e 0f                	jle    104047 <strncpy+0x47>
    *s++ = 0;
  104038:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
  10403c:	89 f3                	mov    %esi,%ebx
  10403e:	83 c1 01             	add    $0x1,%ecx
  104041:	29 cb                	sub    %ecx,%ebx
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
  104043:	85 db                	test   %ebx,%ebx
  104045:	7f f1                	jg     104038 <strncpy+0x38>
    *s++ = 0;
  return os;
}
  104047:	5b                   	pop    %ebx
  104048:	5e                   	pop    %esi
  104049:	c3                   	ret    
  10404a:	66 90                	xchg   %ax,%ax
  10404c:	66 90                	xchg   %ax,%ax
  10404e:	66 90                	xchg   %ax,%ax

00104050 <debug_init>:
static spinlock_t debug_lk;
static spinlock_t serial_lk;

void
debug_init(void)
{
  104050:	83 ec 1c             	sub    $0x1c,%esp
  spinlock_init(&debug_lk);
  104053:	c7 04 24 88 fe 13 00 	movl   $0x13fe88,(%esp)
  10405a:	e8 51 18 00 00       	call   1058b0 <spinlock_init>
	spinlock_init(&serial_lk);
  10405f:	c7 04 24 80 fe 13 00 	movl   $0x13fe80,(%esp)
  104066:	e8 45 18 00 00       	call   1058b0 <spinlock_init>
}
  10406b:	83 c4 1c             	add    $0x1c,%esp
  10406e:	c3                   	ret    
  10406f:	90                   	nop

00104070 <debug_lock>:


void
debug_lock(void)
{
  104070:	83 ec 1c             	sub    $0x1c,%esp
  spinlock_acquire(&debug_lk);
  104073:	c7 04 24 88 fe 13 00 	movl   $0x13fe88,(%esp)
  10407a:	e8 f1 19 00 00       	call   105a70 <spinlock_acquire>
}
  10407f:	83 c4 1c             	add    $0x1c,%esp
  104082:	c3                   	ret    
  104083:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104090 <debug_unlock>:

void
debug_unlock(void)
{
  104090:	83 ec 1c             	sub    $0x1c,%esp
  spinlock_release(&debug_lk);
  104093:	c7 04 24 88 fe 13 00 	movl   $0x13fe88,(%esp)
  10409a:	e8 51 1a 00 00       	call   105af0 <spinlock_release>
}
  10409f:	83 c4 1c             	add    $0x1c,%esp
  1040a2:	c3                   	ret    
  1040a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1040a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001040b0 <serial_lock>:

void
serial_lock(void)
{
  1040b0:	83 ec 1c             	sub    $0x1c,%esp
  spinlock_acquire(&serial_lk);
  1040b3:	c7 04 24 80 fe 13 00 	movl   $0x13fe80,(%esp)
  1040ba:	e8 b1 19 00 00       	call   105a70 <spinlock_acquire>
}
  1040bf:	83 c4 1c             	add    $0x1c,%esp
  1040c2:	c3                   	ret    
  1040c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1040c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001040d0 <serial_unlock>:

void
serial_unlock(void)
{
  1040d0:	83 ec 1c             	sub    $0x1c,%esp
  spinlock_release(&serial_lk);
  1040d3:	c7 04 24 80 fe 13 00 	movl   $0x13fe80,(%esp)
  1040da:	e8 11 1a 00 00       	call   105af0 <spinlock_release>
}
  1040df:	83 c4 1c             	add    $0x1c,%esp
  1040e2:	c3                   	ret    
  1040e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1040e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001040f0 <debug_info>:


void
debug_info(const char *fmt, ...)
{
  1040f0:	83 ec 1c             	sub    $0x1c,%esp


void
debug_lock(void)
{
  spinlock_acquire(&debug_lk);
  1040f3:	c7 04 24 88 fe 13 00 	movl   $0x13fe88,(%esp)
  1040fa:	e8 71 19 00 00       	call   105a70 <spinlock_acquire>
{
#ifdef DEBUG_MSG
  debug_lock();

	va_list ap;
	va_start(ap, fmt);
  1040ff:	8d 44 24 24          	lea    0x24(%esp),%eax
	vdprintf(fmt, ap);
  104103:	89 44 24 04          	mov    %eax,0x4(%esp)
  104107:	8b 44 24 20          	mov    0x20(%esp),%eax
  10410b:	89 04 24             	mov    %eax,(%esp)
  10410e:	e8 fd 01 00 00       	call   104310 <vdprintf>
}

void
debug_unlock(void)
{
  spinlock_release(&debug_lk);
  104113:	c7 04 24 88 fe 13 00 	movl   $0x13fe88,(%esp)
  10411a:	e8 d1 19 00 00       	call   105af0 <spinlock_release>
	vdprintf(fmt, ap);
	va_end(ap);

  debug_unlock();
#endif
}
  10411f:	83 c4 1c             	add    $0x1c,%esp
  104122:	c3                   	ret    
  104123:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104130 <debug_normal>:

#ifdef DEBUG_MSG

void
debug_normal(const char *file, int line, const char *fmt, ...)
{
  104130:	83 ec 1c             	sub    $0x1c,%esp


void
debug_lock(void)
{
  spinlock_acquire(&debug_lk);
  104133:	c7 04 24 88 fe 13 00 	movl   $0x13fe88,(%esp)
  10413a:	e8 31 19 00 00       	call   105a70 <spinlock_acquire>
void
debug_normal(const char *file, int line, const char *fmt, ...)
{
  debug_lock();

	dprintf("[D] %s:%d: ", file, line);
  10413f:	8b 44 24 24          	mov    0x24(%esp),%eax
  104143:	c7 04 24 3b be 10 00 	movl   $0x10be3b,(%esp)
  10414a:	89 44 24 08          	mov    %eax,0x8(%esp)
  10414e:	8b 44 24 20          	mov    0x20(%esp),%eax
  104152:	89 44 24 04          	mov    %eax,0x4(%esp)
  104156:	e8 45 02 00 00       	call   1043a0 <dprintf>

	va_list ap;
	va_start(ap, fmt);
  10415b:	8d 44 24 2c          	lea    0x2c(%esp),%eax
	vdprintf(fmt, ap);
  10415f:	89 44 24 04          	mov    %eax,0x4(%esp)
  104163:	8b 44 24 28          	mov    0x28(%esp),%eax
  104167:	89 04 24             	mov    %eax,(%esp)
  10416a:	e8 a1 01 00 00       	call   104310 <vdprintf>
}

void
debug_unlock(void)
{
  spinlock_release(&debug_lk);
  10416f:	c7 04 24 88 fe 13 00 	movl   $0x13fe88,(%esp)
  104176:	e8 75 19 00 00       	call   105af0 <spinlock_release>
	va_start(ap, fmt);
	vdprintf(fmt, ap);
	va_end(ap);
	
  debug_unlock();
}
  10417b:	83 c4 1c             	add    $0x1c,%esp
  10417e:	c3                   	ret    
  10417f:	90                   	nop

00104180 <debug_panic>:
		eips[i] = 0;
}

gcc_noinline void
debug_panic(const char *file, int line, const char *fmt,...)
{
  104180:	56                   	push   %esi
  104181:	53                   	push   %ebx
  104182:	83 ec 44             	sub    $0x44,%esp


void
debug_lock(void)
{
  spinlock_acquire(&debug_lk);
  104185:	c7 04 24 88 fe 13 00 	movl   $0x13fe88,(%esp)
  10418c:	e8 df 18 00 00       	call   105a70 <spinlock_acquire>
	uintptr_t eips[DEBUG_TRACEFRAMES];
	va_list ap;

  debug_lock();

	dprintf("[P] %s:%d: ", file, line);
  104191:	8b 44 24 54          	mov    0x54(%esp),%eax
  104195:	c7 04 24 47 be 10 00 	movl   $0x10be47,(%esp)
  10419c:	89 44 24 08          	mov    %eax,0x8(%esp)
  1041a0:	8b 44 24 50          	mov    0x50(%esp),%eax
  1041a4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1041a8:	e8 f3 01 00 00       	call   1043a0 <dprintf>

	va_start(ap, fmt);
  1041ad:	8d 44 24 5c          	lea    0x5c(%esp),%eax
	vdprintf(fmt, ap);
  1041b1:	89 44 24 04          	mov    %eax,0x4(%esp)
  1041b5:	8b 44 24 58          	mov    0x58(%esp),%eax
  1041b9:	89 04 24             	mov    %eax,(%esp)
  1041bc:	e8 4f 01 00 00       	call   104310 <vdprintf>
	va_end(ap);

	debug_trace(read_ebp(), eips);
  1041c1:	e8 0a 0c 00 00       	call   104dd0 <read_ebp>
debug_trace(uintptr_t ebp, uintptr_t *eips)
{
	int i;
	uintptr_t *frame = (uintptr_t *) ebp;

	for (i = 0; i < DEBUG_TRACEFRAMES && frame; i++) {
  1041c6:	31 d2                	xor    %edx,%edx
  1041c8:	85 c0                	test   %eax,%eax
  1041ca:	75 11                	jne    1041dd <debug_panic+0x5d>
  1041cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1041d0:	eb 26                	jmp    1041f8 <debug_panic+0x78>
  1041d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1041d8:	83 fa 09             	cmp    $0x9,%edx
  1041db:	7f 10                	jg     1041ed <debug_panic+0x6d>
		eips[i] = frame[1];		/* saved %eip */
  1041dd:	8b 48 04             	mov    0x4(%eax),%ecx
		frame = (uintptr_t *) frame[0];	/* saved %ebp */
  1041e0:	8b 00                	mov    (%eax),%eax
{
	int i;
	uintptr_t *frame = (uintptr_t *) ebp;

	for (i = 0; i < DEBUG_TRACEFRAMES && frame; i++) {
		eips[i] = frame[1];		/* saved %eip */
  1041e2:	89 4c 94 18          	mov    %ecx,0x18(%esp,%edx,4)
debug_trace(uintptr_t ebp, uintptr_t *eips)
{
	int i;
	uintptr_t *frame = (uintptr_t *) ebp;

	for (i = 0; i < DEBUG_TRACEFRAMES && frame; i++) {
  1041e6:	83 c2 01             	add    $0x1,%edx
  1041e9:	85 c0                	test   %eax,%eax
  1041eb:	75 eb                	jne    1041d8 <debug_panic+0x58>
		eips[i] = frame[1];		/* saved %eip */
		frame = (uintptr_t *) frame[0];	/* saved %ebp */
	}
	for (; i < DEBUG_TRACEFRAMES; i++)
  1041ed:	83 fa 09             	cmp    $0x9,%edx
  1041f0:	7f 16                	jg     104208 <debug_panic+0x88>
  1041f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		eips[i] = 0;
  1041f8:	c7 44 94 18 00 00 00 	movl   $0x0,0x18(%esp,%edx,4)
  1041ff:	00 

	for (i = 0; i < DEBUG_TRACEFRAMES && frame; i++) {
		eips[i] = frame[1];		/* saved %eip */
		frame = (uintptr_t *) frame[0];	/* saved %ebp */
	}
	for (; i < DEBUG_TRACEFRAMES; i++)
  104200:	83 c2 01             	add    $0x1,%edx
  104203:	83 fa 09             	cmp    $0x9,%edx
  104206:	7e f0                	jle    1041f8 <debug_panic+0x78>
  104208:	8d 5c 24 18          	lea    0x18(%esp),%ebx
  10420c:	8d 74 24 40          	lea    0x40(%esp),%esi
	va_start(ap, fmt);
	vdprintf(fmt, ap);
	va_end(ap);

	debug_trace(read_ebp(), eips);
	for (i = 0; i < DEBUG_TRACEFRAMES && eips[i] != 0; i++)
  104210:	8b 03                	mov    (%ebx),%eax
  104212:	85 c0                	test   %eax,%eax
  104214:	74 17                	je     10422d <debug_panic+0xad>
		dprintf("\tfrom 0x%08x\n", eips[i]);
  104216:	89 44 24 04          	mov    %eax,0x4(%esp)
  10421a:	83 c3 04             	add    $0x4,%ebx
  10421d:	c7 04 24 53 be 10 00 	movl   $0x10be53,(%esp)
  104224:	e8 77 01 00 00       	call   1043a0 <dprintf>
	va_start(ap, fmt);
	vdprintf(fmt, ap);
	va_end(ap);

	debug_trace(read_ebp(), eips);
	for (i = 0; i < DEBUG_TRACEFRAMES && eips[i] != 0; i++)
  104229:	39 f3                	cmp    %esi,%ebx
  10422b:	75 e3                	jne    104210 <debug_panic+0x90>
		dprintf("\tfrom 0x%08x\n", eips[i]);

	dprintf("Kernel Panic !!!\n");
  10422d:	c7 04 24 61 be 10 00 	movl   $0x10be61,(%esp)
  104234:	e8 67 01 00 00       	call   1043a0 <dprintf>
}

void
debug_unlock(void)
{
  spinlock_release(&debug_lk);
  104239:	c7 04 24 88 fe 13 00 	movl   $0x13fe88,(%esp)
  104240:	e8 ab 18 00 00       	call   105af0 <spinlock_release>

	dprintf("Kernel Panic !!!\n");

  debug_unlock();
	//intr_local_disable();
	halt();
  104245:	e8 e6 0b 00 00       	call   104e30 <halt>
}
  10424a:	83 c4 44             	add    $0x44,%esp
  10424d:	5b                   	pop    %ebx
  10424e:	5e                   	pop    %esi
  10424f:	c3                   	ret    

00104250 <debug_warn>:

void
debug_warn(const char *file, int line, const char *fmt,...)
{
  104250:	83 ec 1c             	sub    $0x1c,%esp


void
debug_lock(void)
{
  spinlock_acquire(&debug_lk);
  104253:	c7 04 24 88 fe 13 00 	movl   $0x13fe88,(%esp)
  10425a:	e8 11 18 00 00       	call   105a70 <spinlock_acquire>
void
debug_warn(const char *file, int line, const char *fmt,...)
{
  debug_lock();

	dprintf("[W] %s:%d: ", file, line);
  10425f:	8b 44 24 24          	mov    0x24(%esp),%eax
  104263:	c7 04 24 73 be 10 00 	movl   $0x10be73,(%esp)
  10426a:	89 44 24 08          	mov    %eax,0x8(%esp)
  10426e:	8b 44 24 20          	mov    0x20(%esp),%eax
  104272:	89 44 24 04          	mov    %eax,0x4(%esp)
  104276:	e8 25 01 00 00       	call   1043a0 <dprintf>

	va_list ap;
	va_start(ap, fmt);
  10427b:	8d 44 24 2c          	lea    0x2c(%esp),%eax
	vdprintf(fmt, ap);
  10427f:	89 44 24 04          	mov    %eax,0x4(%esp)
  104283:	8b 44 24 28          	mov    0x28(%esp),%eax
  104287:	89 04 24             	mov    %eax,(%esp)
  10428a:	e8 81 00 00 00       	call   104310 <vdprintf>
}

void
debug_unlock(void)
{
  spinlock_release(&debug_lk);
  10428f:	c7 04 24 88 fe 13 00 	movl   $0x13fe88,(%esp)
  104296:	e8 55 18 00 00       	call   105af0 <spinlock_release>
	va_start(ap, fmt);
	vdprintf(fmt, ap);
	va_end(ap);

  debug_unlock();
}
  10429b:	83 c4 1c             	add    $0x1c,%esp
  10429e:	c3                   	ret    
  10429f:	90                   	nop

001042a0 <putch>:
    }
}

static void
putch (int ch, struct dprintbuf *b)
{
  1042a0:	56                   	push   %esi
  1042a1:	53                   	push   %ebx
  1042a2:	83 ec 14             	sub    $0x14,%esp
  1042a5:	8b 74 24 24          	mov    0x24(%esp),%esi
    b->buf[b->idx++] = ch;
  1042a9:	8b 4c 24 20          	mov    0x20(%esp),%ecx
  1042ad:	8b 16                	mov    (%esi),%edx
  1042af:	8d 42 01             	lea    0x1(%edx),%eax
    if (b->idx == CONSOLE_BUFFER_SIZE - 1)
  1042b2:	3d ff 01 00 00       	cmp    $0x1ff,%eax
}

static void
putch (int ch, struct dprintbuf *b)
{
    b->buf[b->idx++] = ch;
  1042b7:	89 06                	mov    %eax,(%esi)
  1042b9:	88 4c 16 08          	mov    %cl,0x8(%esi,%edx,1)
    if (b->idx == CONSOLE_BUFFER_SIZE - 1)
  1042bd:	74 11                	je     1042d0 <putch+0x30>
    {
        b->buf[b->idx] = 0;
        cputs (b->buf);
        b->idx = 0;
    }
    b->cnt++;
  1042bf:	83 46 04 01          	addl   $0x1,0x4(%esi)
}
  1042c3:	83 c4 14             	add    $0x14,%esp
  1042c6:	5b                   	pop    %ebx
  1042c7:	5e                   	pop    %esi
  1042c8:	c3                   	ret    
  1042c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
};

static void
cputs (const char *str)
{
    while (*str)
  1042d0:	0f be 46 08          	movsbl 0x8(%esi),%eax
{
    b->buf[b->idx++] = ch;
    if (b->idx == CONSOLE_BUFFER_SIZE - 1)
    {
        b->buf[b->idx] = 0;
        cputs (b->buf);
  1042d4:	8d 5e 08             	lea    0x8(%esi),%ebx
putch (int ch, struct dprintbuf *b)
{
    b->buf[b->idx++] = ch;
    if (b->idx == CONSOLE_BUFFER_SIZE - 1)
    {
        b->buf[b->idx] = 0;
  1042d7:	c6 86 07 02 00 00 00 	movb   $0x0,0x207(%esi)
};

static void
cputs (const char *str)
{
    while (*str)
  1042de:	84 c0                	test   %al,%al
  1042e0:	74 18                	je     1042fa <putch+0x5a>
  1042e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    {
        cons_putc (*str);
  1042e8:	89 04 24             	mov    %eax,(%esp)
        str += 1;
  1042eb:	83 c3 01             	add    $0x1,%ebx
static void
cputs (const char *str)
{
    while (*str)
    {
        cons_putc (*str);
  1042ee:	e8 3d c1 ff ff       	call   100430 <cons_putc>
};

static void
cputs (const char *str)
{
    while (*str)
  1042f3:	0f be 03             	movsbl (%ebx),%eax
  1042f6:	84 c0                	test   %al,%al
  1042f8:	75 ee                	jne    1042e8 <putch+0x48>
    b->buf[b->idx++] = ch;
    if (b->idx == CONSOLE_BUFFER_SIZE - 1)
    {
        b->buf[b->idx] = 0;
        cputs (b->buf);
        b->idx = 0;
  1042fa:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
    }
    b->cnt++;
  104300:	83 46 04 01          	addl   $0x1,0x4(%esi)
}
  104304:	83 c4 14             	add    $0x14,%esp
  104307:	5b                   	pop    %ebx
  104308:	5e                   	pop    %esi
  104309:	c3                   	ret    
  10430a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104310 <vdprintf>:

int
vdprintf (const char *fmt, va_list ap)
{
  104310:	53                   	push   %ebx
  104311:	81 ec 28 02 00 00    	sub    $0x228,%esp

    serial_lock();
  104317:	e8 94 fd ff ff       	call   1040b0 <serial_lock>
    struct dprintbuf b;

    b.idx = 0;
    b.cnt = 0;
    vprintfmt ((void*) putch, &b, fmt, ap);
  10431c:	8b 84 24 34 02 00 00 	mov    0x234(%esp),%eax
};

static void
cputs (const char *str)
{
    while (*str)
  104323:	8d 5c 24 20          	lea    0x20(%esp),%ebx
    serial_lock();
    struct dprintbuf b;

    b.idx = 0;
    b.cnt = 0;
    vprintfmt ((void*) putch, &b, fmt, ap);
  104327:	c7 04 24 a0 42 10 00 	movl   $0x1042a0,(%esp)
{

    serial_lock();
    struct dprintbuf b;

    b.idx = 0;
  10432e:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  104335:	00 
    b.cnt = 0;
  104336:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  10433d:	00 
    vprintfmt ((void*) putch, &b, fmt, ap);
  10433e:	89 44 24 0c          	mov    %eax,0xc(%esp)
  104342:	8b 84 24 30 02 00 00 	mov    0x230(%esp),%eax
  104349:	89 44 24 08          	mov    %eax,0x8(%esp)
  10434d:	8d 44 24 18          	lea    0x18(%esp),%eax
  104351:	89 44 24 04          	mov    %eax,0x4(%esp)
  104355:	e8 c6 01 00 00       	call   104520 <vprintfmt>

    b.buf[b.idx] = 0;
  10435a:	8b 44 24 18          	mov    0x18(%esp),%eax
  10435e:	c6 44 04 20 00       	movb   $0x0,0x20(%esp,%eax,1)
};

static void
cputs (const char *str)
{
    while (*str)
  104363:	0f be 44 24 20       	movsbl 0x20(%esp),%eax
  104368:	84 c0                	test   %al,%al
  10436a:	74 16                	je     104382 <vdprintf+0x72>
  10436c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    {
        cons_putc (*str);
  104370:	89 04 24             	mov    %eax,(%esp)
        str += 1;
  104373:	83 c3 01             	add    $0x1,%ebx
static void
cputs (const char *str)
{
    while (*str)
    {
        cons_putc (*str);
  104376:	e8 b5 c0 ff ff       	call   100430 <cons_putc>
};

static void
cputs (const char *str)
{
    while (*str)
  10437b:	0f be 03             	movsbl (%ebx),%eax
  10437e:	84 c0                	test   %al,%al
  104380:	75 ee                	jne    104370 <vdprintf+0x60>
    b.cnt = 0;
    vprintfmt ((void*) putch, &b, fmt, ap);

    b.buf[b.idx] = 0;
    cputs (b.buf);
    serial_unlock();
  104382:	e8 49 fd ff ff       	call   1040d0 <serial_unlock>

    return b.cnt;
  104387:	8b 44 24 1c          	mov    0x1c(%esp),%eax
}
  10438b:	81 c4 28 02 00 00    	add    $0x228,%esp
  104391:	5b                   	pop    %ebx
  104392:	c3                   	ret    
  104393:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001043a0 <dprintf>:

int
dprintf (const char *fmt, ...)
{
  1043a0:	83 ec 1c             	sub    $0x1c,%esp
    va_list ap;
    int cnt;

    va_start(ap, fmt);
  1043a3:	8d 44 24 24          	lea    0x24(%esp),%eax
    cnt = vdprintf (fmt, ap);
  1043a7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1043ab:	8b 44 24 20          	mov    0x20(%esp),%eax
  1043af:	89 04 24             	mov    %eax,(%esp)
  1043b2:	e8 59 ff ff ff       	call   104310 <vdprintf>
    va_end(ap);

    return cnt;
}
  1043b7:	83 c4 1c             	add    $0x1c,%esp
  1043ba:	c3                   	ret    
  1043bb:	66 90                	xchg   %ax,%ax
  1043bd:	66 90                	xchg   %ax,%ax
  1043bf:	90                   	nop

001043c0 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(putch_t putch, void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  1043c0:	55                   	push   %ebp
  1043c1:	57                   	push   %edi
  1043c2:	89 d7                	mov    %edx,%edi
  1043c4:	56                   	push   %esi
  1043c5:	89 c6                	mov    %eax,%esi
  1043c7:	53                   	push   %ebx
  1043c8:	83 ec 3c             	sub    $0x3c,%esp
  1043cb:	8b 44 24 50          	mov    0x50(%esp),%eax
  1043cf:	8b 4c 24 58          	mov    0x58(%esp),%ecx
  1043d3:	8b 5c 24 5c          	mov    0x5c(%esp),%ebx
  1043d7:	8b 6c 24 60          	mov    0x60(%esp),%ebp
  1043db:	89 44 24 20          	mov    %eax,0x20(%esp)
  1043df:	8b 44 24 54          	mov    0x54(%esp),%eax
	/* first recursively print all preceding (more significant) digits */
	if (num >= base) {
  1043e3:	89 ca                	mov    %ecx,%edx
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(putch_t putch, void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  1043e5:	89 4c 24 28          	mov    %ecx,0x28(%esp)
	/* first recursively print all preceding (more significant) digits */
	if (num >= base) {
  1043e9:	31 c9                	xor    %ecx,%ecx
  1043eb:	89 54 24 18          	mov    %edx,0x18(%esp)
  1043ef:	39 c1                	cmp    %eax,%ecx
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(putch_t putch, void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  1043f1:	89 44 24 24          	mov    %eax,0x24(%esp)
	/* first recursively print all preceding (more significant) digits */
	if (num >= base) {
  1043f5:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
  1043f9:	0f 83 a9 00 00 00    	jae    1044a8 <printnum+0xe8>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  1043ff:	8b 44 24 28          	mov    0x28(%esp),%eax
  104403:	83 eb 01             	sub    $0x1,%ebx
  104406:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  10440a:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  10440e:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  104412:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  104416:	89 44 24 08          	mov    %eax,0x8(%esp)
  10441a:	8b 44 24 18          	mov    0x18(%esp),%eax
  10441e:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  104422:	89 54 24 0c          	mov    %edx,0xc(%esp)
  104426:	89 5c 24 2c          	mov    %ebx,0x2c(%esp)
  10442a:	89 44 24 08          	mov    %eax,0x8(%esp)
  10442e:	8b 44 24 20          	mov    0x20(%esp),%eax
  104432:	89 4c 24 28          	mov    %ecx,0x28(%esp)
  104436:	89 04 24             	mov    %eax,(%esp)
  104439:	8b 44 24 24          	mov    0x24(%esp),%eax
  10443d:	89 44 24 04          	mov    %eax,0x4(%esp)
  104441:	e8 8a 64 00 00       	call   10a8d0 <__udivdi3>
  104446:	8b 4c 24 28          	mov    0x28(%esp),%ecx
  10444a:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
  10444e:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  104452:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  104456:	89 04 24             	mov    %eax,(%esp)
  104459:	89 f0                	mov    %esi,%eax
  10445b:	89 54 24 04          	mov    %edx,0x4(%esp)
  10445f:	89 fa                	mov    %edi,%edx
  104461:	e8 5a ff ff ff       	call   1043c0 <printnum>
		while (--width > 0)
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  104466:	8b 44 24 18          	mov    0x18(%esp),%eax
  10446a:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  10446e:	89 7c 24 54          	mov    %edi,0x54(%esp)
  104472:	89 44 24 08          	mov    %eax,0x8(%esp)
  104476:	8b 44 24 20          	mov    0x20(%esp),%eax
  10447a:	89 54 24 0c          	mov    %edx,0xc(%esp)
  10447e:	89 04 24             	mov    %eax,(%esp)
  104481:	8b 44 24 24          	mov    0x24(%esp),%eax
  104485:	89 44 24 04          	mov    %eax,0x4(%esp)
  104489:	e8 72 65 00 00       	call   10aa00 <__umoddi3>
  10448e:	0f be 80 7f be 10 00 	movsbl 0x10be7f(%eax),%eax
  104495:	89 44 24 50          	mov    %eax,0x50(%esp)
}
  104499:	83 c4 3c             	add    $0x3c,%esp
		while (--width > 0)
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  10449c:	89 f0                	mov    %esi,%eax
}
  10449e:	5b                   	pop    %ebx
  10449f:	5e                   	pop    %esi
  1044a0:	5f                   	pop    %edi
  1044a1:	5d                   	pop    %ebp
		while (--width > 0)
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  1044a2:	ff e0                	jmp    *%eax
  1044a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static void
printnum(putch_t putch, void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
	/* first recursively print all preceding (more significant) digits */
	if (num >= base) {
  1044a8:	76 1e                	jbe    1044c8 <printnum+0x108>
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		/* print any needed pad characters before first digit */
		while (--width > 0)
  1044aa:	83 eb 01             	sub    $0x1,%ebx
  1044ad:	85 db                	test   %ebx,%ebx
  1044af:	7e b5                	jle    104466 <printnum+0xa6>
  1044b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			putch(padc, putdat);
  1044b8:	89 7c 24 04          	mov    %edi,0x4(%esp)
  1044bc:	89 2c 24             	mov    %ebp,(%esp)
  1044bf:	ff d6                	call   *%esi
	/* first recursively print all preceding (more significant) digits */
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		/* print any needed pad characters before first digit */
		while (--width > 0)
  1044c1:	83 eb 01             	sub    $0x1,%ebx
  1044c4:	75 f2                	jne    1044b8 <printnum+0xf8>
  1044c6:	eb 9e                	jmp    104466 <printnum+0xa6>
static void
printnum(putch_t putch, void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
	/* first recursively print all preceding (more significant) digits */
	if (num >= base) {
  1044c8:	8b 44 24 20          	mov    0x20(%esp),%eax
  1044cc:	39 44 24 28          	cmp    %eax,0x28(%esp)
  1044d0:	0f 86 29 ff ff ff    	jbe    1043ff <printnum+0x3f>
  1044d6:	eb d2                	jmp    1044aa <printnum+0xea>
  1044d8:	90                   	nop
  1044d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001044e0 <getuint>:
 * depending on the lflag parameter.
 */
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
  1044e0:	83 fa 01             	cmp    $0x1,%edx
  1044e3:	7e 13                	jle    1044f8 <getuint+0x18>
		return va_arg(*ap, unsigned long long);
  1044e5:	8b 10                	mov    (%eax),%edx
  1044e7:	8d 4a 08             	lea    0x8(%edx),%ecx
  1044ea:	89 08                	mov    %ecx,(%eax)
  1044ec:	8b 02                	mov    (%edx),%eax
  1044ee:	8b 52 04             	mov    0x4(%edx),%edx
  1044f1:	c3                   	ret    
  1044f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	else if (lflag)
  1044f8:	85 d2                	test   %edx,%edx
		return va_arg(*ap, unsigned long);
  1044fa:	8b 10                	mov    (%eax),%edx
  1044fc:	8d 4a 04             	lea    0x4(%edx),%ecx
  1044ff:	89 08                	mov    %ecx,(%eax)
  104501:	8b 02                	mov    (%edx),%eax
  104503:	ba 00 00 00 00       	mov    $0x0,%edx
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, unsigned long long);
	else if (lflag)
  104508:	75 06                	jne    104510 <getuint+0x30>
		return va_arg(*ap, unsigned long);
	else
		return va_arg(*ap, unsigned int);
}
  10450a:	f3 c3                	repz ret 
  10450c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104510:	f3 c3                	repz ret 
  104512:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104520 <vprintfmt>:
		return va_arg(*ap, int);
}

void
vprintfmt(putch_t putch, void *putdat, const char *fmt, va_list ap)
{
  104520:	55                   	push   %ebp
  104521:	57                   	push   %edi
  104522:	56                   	push   %esi
  104523:	53                   	push   %ebx
  104524:	83 ec 3c             	sub    $0x3c,%esp
  104527:	8b 7c 24 50          	mov    0x50(%esp),%edi
  10452b:	8b 74 24 54          	mov    0x54(%esp),%esi
  10452f:	8b 6c 24 58          	mov    0x58(%esp),%ebp
  104533:	eb 12                	jmp    104547 <vprintfmt+0x27>
  104535:	8d 76 00             	lea    0x0(%esi),%esi
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
  104538:	85 c0                	test   %eax,%eax
  10453a:	74 64                	je     1045a0 <vprintfmt+0x80>
				return;
			putch(ch, putdat);
  10453c:	89 74 24 04          	mov    %esi,0x4(%esp)
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  104540:	89 dd                	mov    %ebx,%ebp
			if (ch == '\0')
				return;
			putch(ch, putdat);
  104542:	89 04 24             	mov    %eax,(%esp)
  104545:	ff d7                	call   *%edi
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  104547:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
  10454b:	8d 5d 01             	lea    0x1(%ebp),%ebx
  10454e:	83 f8 25             	cmp    $0x25,%eax
  104551:	75 e5                	jne    104538 <vprintfmt+0x18>
  104553:	8b 44 24 5c          	mov    0x5c(%esp),%eax
  104557:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  10455c:	c6 44 24 2b 20       	movb   $0x20,0x2b(%esp)
  104561:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  104568:	00 
  104569:	c7 44 24 20 ff ff ff 	movl   $0xffffffff,0x20(%esp)
  104570:	ff 
  104571:	89 44 24 24          	mov    %eax,0x24(%esp)
  104575:	c7 44 24 2c 00 00 00 	movl   $0x0,0x2c(%esp)
  10457c:	00 
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  10457d:	0f b6 03             	movzbl (%ebx),%eax
  104580:	8d 6b 01             	lea    0x1(%ebx),%ebp
  104583:	0f b6 c8             	movzbl %al,%ecx
  104586:	83 e8 23             	sub    $0x23,%eax
  104589:	3c 55                	cmp    $0x55,%al
  10458b:	0f 87 7a 02 00 00    	ja     10480b <vprintfmt+0x2eb>
  104591:	0f b6 c0             	movzbl %al,%eax
  104594:	ff 24 85 98 be 10 00 	jmp    *0x10be98(,%eax,4)
  10459b:	90                   	nop
  10459c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  1045a0:	83 c4 3c             	add    $0x3c,%esp
  1045a3:	5b                   	pop    %ebx
  1045a4:	5e                   	pop    %esi
  1045a5:	5f                   	pop    %edi
  1045a6:	5d                   	pop    %ebp
  1045a7:	c3                   	ret    
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  1045a8:	89 eb                	mov    %ebp,%ebx
			padc = '-';
			goto reswitch;

			// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  1045aa:	c6 44 24 2b 30       	movb   $0x30,0x2b(%esp)
  1045af:	eb cc                	jmp    10457d <vprintfmt+0x5d>
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
				precision = precision * 10 + ch - '0';
				ch = *fmt;
  1045b1:	0f be 43 01          	movsbl 0x1(%ebx),%eax
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
				precision = precision * 10 + ch - '0';
  1045b5:	8d 51 d0             	lea    -0x30(%ecx),%edx
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  1045b8:	89 eb                	mov    %ebp,%ebx
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
  1045ba:	8d 48 d0             	lea    -0x30(%eax),%ecx
  1045bd:	83 f9 09             	cmp    $0x9,%ecx
  1045c0:	0f 87 06 02 00 00    	ja     1047cc <vprintfmt+0x2ac>
  1045c6:	66 90                	xchg   %ax,%ax
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  1045c8:	83 c3 01             	add    $0x1,%ebx
				precision = precision * 10 + ch - '0';
  1045cb:	8d 14 92             	lea    (%edx,%edx,4),%edx
  1045ce:	8d 54 50 d0          	lea    -0x30(%eax,%edx,2),%edx
				ch = *fmt;
  1045d2:	0f be 03             	movsbl (%ebx),%eax
				if (ch < '0' || ch > '9')
  1045d5:	8d 48 d0             	lea    -0x30(%eax),%ecx
  1045d8:	83 f9 09             	cmp    $0x9,%ecx
  1045db:	76 eb                	jbe    1045c8 <vprintfmt+0xa8>
  1045dd:	e9 ea 01 00 00       	jmp    1047cc <vprintfmt+0x2ac>
			lflag++;
			goto reswitch;

			// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  1045e2:	8b 54 24 24          	mov    0x24(%esp),%edx
  1045e6:	89 74 24 04          	mov    %esi,0x4(%esp)
  1045ea:	89 d0                	mov    %edx,%eax
  1045ec:	83 c0 04             	add    $0x4,%eax
  1045ef:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  1045f3:	8b 02                	mov    (%edx),%eax
  1045f5:	89 04 24             	mov    %eax,(%esp)
  1045f8:	ff d7                	call   *%edi
			break;
  1045fa:	e9 48 ff ff ff       	jmp    104547 <vprintfmt+0x27>
 */
static long long
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, long long);
  1045ff:	8b 54 24 24          	mov    0x24(%esp),%edx
 * because of sign extension
 */
static long long
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
  104603:	83 7c 24 2c 01       	cmpl   $0x1,0x2c(%esp)
		return va_arg(*ap, long long);
  104608:	89 d0                	mov    %edx,%eax
 * because of sign extension
 */
static long long
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
  10460a:	0f 8e db 02 00 00    	jle    1048eb <vprintfmt+0x3cb>
		return va_arg(*ap, long long);
  104610:	83 c0 08             	add    $0x8,%eax
  104613:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  104617:	89 d0                	mov    %edx,%eax
  104619:	8b 52 04             	mov    0x4(%edx),%edx
  10461c:	8b 00                	mov    (%eax),%eax
			break;

			// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
			if ((long long) num < 0) {
  10461e:	85 d2                	test   %edx,%edx
  104620:	bb 0a 00 00 00       	mov    $0xa,%ebx
  104625:	0f 88 cf 02 00 00    	js     1048fa <vprintfmt+0x3da>
  10462b:	90                   	nop
  10462c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
			base = 16;
		number:
			printnum(putch, putdat, num, base, width, padc);
  104630:	0f be 4c 24 2b       	movsbl 0x2b(%esp),%ecx
  104635:	89 04 24             	mov    %eax,(%esp)
  104638:	89 f8                	mov    %edi,%eax
  10463a:	89 54 24 04          	mov    %edx,0x4(%esp)
  10463e:	89 f2                	mov    %esi,%edx
  104640:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  104644:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  104648:	8b 4c 24 20          	mov    0x20(%esp),%ecx
  10464c:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  104650:	e8 6b fd ff ff       	call   1043c0 <printnum>
			break;
  104655:	e9 ed fe ff ff       	jmp    104547 <vprintfmt+0x27>
				width = precision, precision = -1;
			goto reswitch;

			// long flag (doubled for long long)
		case 'l':
			lflag++;
  10465a:	83 44 24 2c 01       	addl   $0x1,0x2c(%esp)
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  10465f:	89 eb                	mov    %ebp,%ebx
			goto reswitch;

			// long flag (doubled for long long)
		case 'l':
			lflag++;
			goto reswitch;
  104661:	e9 17 ff ff ff       	jmp    10457d <vprintfmt+0x5d>
  104666:	8b 44 24 24          	mov    0x24(%esp),%eax

			// (unsigned) octal
		case 'o':
			num = getuint(&ap, lflag);
			base = 8;
			goto number;
  10466a:	bb 08 00 00 00       	mov    $0x8,%ebx
			base = 10;
			goto number;

			// (unsigned) octal
		case 'o':
			num = getuint(&ap, lflag);
  10466f:	8b 54 24 2c          	mov    0x2c(%esp),%edx
  104673:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  104677:	8d 44 24 5c          	lea    0x5c(%esp),%eax
  10467b:	e8 60 fe ff ff       	call   1044e0 <getuint>
			base = 8;
			goto number;
  104680:	eb ae                	jmp    104630 <vprintfmt+0x110>
  104682:	8b 44 24 24          	mov    0x24(%esp),%eax
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
				(uintptr_t) va_arg(ap, void *);
			base = 16;
			goto number;
  104686:	bb 10 00 00 00       	mov    $0x10,%ebx
			base = 8;
			goto number;

			// pointer
		case 'p':
			putch('0', putdat);
  10468b:	89 74 24 04          	mov    %esi,0x4(%esp)
  10468f:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  104696:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  10469a:	ff d7                	call   *%edi
			putch('x', putdat);
  10469c:	89 74 24 04          	mov    %esi,0x4(%esp)
  1046a0:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  1046a7:	ff d7                	call   *%edi
			num = (unsigned long long)
				(uintptr_t) va_arg(ap, void *);
  1046a9:	8b 44 24 5c          	mov    0x5c(%esp),%eax
  1046ad:	8d 50 04             	lea    0x4(%eax),%edx
  1046b0:	89 54 24 5c          	mov    %edx,0x5c(%esp)

			// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  1046b4:	31 d2                	xor    %edx,%edx
  1046b6:	8b 00                	mov    (%eax),%eax
				(uintptr_t) va_arg(ap, void *);
			base = 16;
			goto number;
  1046b8:	e9 73 ff ff ff       	jmp    104630 <vprintfmt+0x110>
			putch(va_arg(ap, int), putdat);
			break;

			// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  1046bd:	8b 4c 24 24          	mov    0x24(%esp),%ecx
  1046c1:	89 c8                	mov    %ecx,%eax
  1046c3:	83 c0 04             	add    $0x4,%eax
  1046c6:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  1046ca:	8b 09                	mov    (%ecx),%ecx
				p = "(null)";
  1046cc:	b8 90 be 10 00       	mov    $0x10be90,%eax
  1046d1:	85 c9                	test   %ecx,%ecx
  1046d3:	0f 44 c8             	cmove  %eax,%ecx
			if (width > 0 && padc != '-')
  1046d6:	80 7c 24 2b 2d       	cmpb   $0x2d,0x2b(%esp)
  1046db:	0f 85 96 01 00 00    	jne    104877 <vprintfmt+0x357>
				for (width -= strnlen(p, precision);
				     width > 0;
				     width--)
					putch(padc, putdat);
			for (;
			     (ch = *p++) != '\0' &&
  1046e1:	0f be 01             	movsbl (%ecx),%eax
  1046e4:	8d 59 01             	lea    0x1(%ecx),%ebx
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision);
				     width > 0;
				     width--)
					putch(padc, putdat);
			for (;
  1046e7:	85 c0                	test   %eax,%eax
  1046e9:	0f 84 5b 01 00 00    	je     10484a <vprintfmt+0x32a>
  1046ef:	89 74 24 54          	mov    %esi,0x54(%esp)
  1046f3:	89 de                	mov    %ebx,%esi
  1046f5:	89 d3                	mov    %edx,%ebx
  1046f7:	89 6c 24 58          	mov    %ebp,0x58(%esp)
  1046fb:	8b 6c 24 20          	mov    0x20(%esp),%ebp
  1046ff:	eb 26                	jmp    104727 <vprintfmt+0x207>
  104701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
				     (precision < 0 || --precision >= 0);
			     width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
  104708:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  10470c:	89 04 24             	mov    %eax,(%esp)
  10470f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  104713:	ff d7                	call   *%edi
				for (width -= strnlen(p, precision);
				     width > 0;
				     width--)
					putch(padc, putdat);
			for (;
			     (ch = *p++) != '\0' &&
  104715:	83 c6 01             	add    $0x1,%esi
  104718:	0f be 46 ff          	movsbl -0x1(%esi),%eax
				     (precision < 0 || --precision >= 0);
			     width--)
  10471c:	83 ed 01             	sub    $0x1,%ebp
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision);
				     width > 0;
				     width--)
					putch(padc, putdat);
			for (;
  10471f:	85 c0                	test   %eax,%eax
  104721:	0f 84 17 01 00 00    	je     10483e <vprintfmt+0x31e>
			     (ch = *p++) != '\0' &&
  104727:	85 db                	test   %ebx,%ebx
  104729:	78 0c                	js     104737 <vprintfmt+0x217>
				     (precision < 0 || --precision >= 0);
  10472b:	83 eb 01             	sub    $0x1,%ebx
  10472e:	83 fb ff             	cmp    $0xffffffff,%ebx
  104731:	0f 84 07 01 00 00    	je     10483e <vprintfmt+0x31e>
			     width--)
				if (altflag && (ch < ' ' || ch > '~'))
  104737:	8b 54 24 18          	mov    0x18(%esp),%edx
  10473b:	85 d2                	test   %edx,%edx
  10473d:	74 c9                	je     104708 <vprintfmt+0x1e8>
  10473f:	8d 48 e0             	lea    -0x20(%eax),%ecx
  104742:	83 f9 5e             	cmp    $0x5e,%ecx
  104745:	76 c1                	jbe    104708 <vprintfmt+0x1e8>
					putch('?', putdat);
  104747:	8b 44 24 54          	mov    0x54(%esp),%eax
  10474b:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  104752:	89 44 24 04          	mov    %eax,0x4(%esp)
  104756:	ff d7                	call   *%edi
  104758:	eb bb                	jmp    104715 <vprintfmt+0x1f5>
  10475a:	8b 44 24 24          	mov    0x24(%esp),%eax

			// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
			base = 10;
			goto number;
  10475e:	bb 0a 00 00 00       	mov    $0xa,%ebx
			base = 10;
			goto number;

			// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  104763:	8b 54 24 2c          	mov    0x2c(%esp),%edx
  104767:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  10476b:	8d 44 24 5c          	lea    0x5c(%esp),%eax
  10476f:	e8 6c fd ff ff       	call   1044e0 <getuint>
			base = 10;
			goto number;
  104774:	e9 b7 fe ff ff       	jmp    104630 <vprintfmt+0x110>
  104779:	8b 44 24 24          	mov    0x24(%esp),%eax
			base = 16;
			goto number;

			// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  10477d:	bb 10 00 00 00       	mov    $0x10,%ebx
  104782:	8b 54 24 2c          	mov    0x2c(%esp),%edx
  104786:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  10478a:	8d 44 24 5c          	lea    0x5c(%esp),%eax
  10478e:	e8 4d fd ff ff       	call   1044e0 <getuint>
  104793:	e9 98 fe ff ff       	jmp    104630 <vprintfmt+0x110>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  104798:	89 eb                	mov    %ebp,%ebx
			if (width < 0)
				width = 0;
			goto reswitch;

		case '#':
			altflag = 1;
  10479a:	c7 44 24 18 01 00 00 	movl   $0x1,0x18(%esp)
  1047a1:	00 
			goto reswitch;
  1047a2:	e9 d6 fd ff ff       	jmp    10457d <vprintfmt+0x5d>
  1047a7:	8b 44 24 24          	mov    0x24(%esp),%eax
			printnum(putch, putdat, num, base, width, padc);
			break;

			// escaped '%' character
		case '%':
			putch(ch, putdat);
  1047ab:	89 74 24 04          	mov    %esi,0x4(%esp)
  1047af:	89 0c 24             	mov    %ecx,(%esp)
  1047b2:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  1047b6:	ff d7                	call   *%edi
			break;
  1047b8:	e9 8a fd ff ff       	jmp    104547 <vprintfmt+0x27>
					break;
			}
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  1047bd:	8b 44 24 24          	mov    0x24(%esp),%eax
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  1047c1:	89 eb                	mov    %ebp,%ebx
					break;
			}
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  1047c3:	8b 10                	mov    (%eax),%edx
  1047c5:	83 c0 04             	add    $0x4,%eax
  1047c8:	89 44 24 24          	mov    %eax,0x24(%esp)
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  1047cc:	8b 6c 24 20          	mov    0x20(%esp),%ebp
  1047d0:	85 ed                	test   %ebp,%ebp
  1047d2:	0f 89 a5 fd ff ff    	jns    10457d <vprintfmt+0x5d>
				width = precision, precision = -1;
  1047d8:	89 54 24 20          	mov    %edx,0x20(%esp)
  1047dc:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  1047e1:	e9 97 fd ff ff       	jmp    10457d <vprintfmt+0x5d>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  1047e6:	89 eb                	mov    %ebp,%ebx

			// flag to pad on the right
		case '-':
			padc = '-';
  1047e8:	c6 44 24 2b 2d       	movb   $0x2d,0x2b(%esp)
  1047ed:	e9 8b fd ff ff       	jmp    10457d <vprintfmt+0x5d>
  1047f2:	8b 4c 24 20          	mov    0x20(%esp),%ecx
  1047f6:	b8 00 00 00 00       	mov    $0x0,%eax
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  1047fb:	89 eb                	mov    %ebp,%ebx
  1047fd:	85 c9                	test   %ecx,%ecx
  1047ff:	0f 49 c1             	cmovns %ecx,%eax
  104802:	89 44 24 20          	mov    %eax,0x20(%esp)
  104806:	e9 72 fd ff ff       	jmp    10457d <vprintfmt+0x5d>
  10480b:	8b 44 24 24          	mov    0x24(%esp),%eax
			break;

			// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
			for (fmt--; fmt[-1] != '%'; fmt--)
  10480f:	89 dd                	mov    %ebx,%ebp
			putch(ch, putdat);
			break;

			// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  104811:	89 74 24 04          	mov    %esi,0x4(%esp)
  104815:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  10481c:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  104820:	ff d7                	call   *%edi
			for (fmt--; fmt[-1] != '%'; fmt--)
  104822:	80 7b ff 25          	cmpb   $0x25,-0x1(%ebx)
  104826:	0f 84 1b fd ff ff    	je     104547 <vprintfmt+0x27>
  10482c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104830:	83 ed 01             	sub    $0x1,%ebp
  104833:	80 7d ff 25          	cmpb   $0x25,-0x1(%ebp)
  104837:	75 f7                	jne    104830 <vprintfmt+0x310>
  104839:	e9 09 fd ff ff       	jmp    104547 <vprintfmt+0x27>
  10483e:	89 6c 24 20          	mov    %ebp,0x20(%esp)
  104842:	8b 74 24 54          	mov    0x54(%esp),%esi
  104846:	8b 6c 24 58          	mov    0x58(%esp),%ebp
			     width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  10484a:	8b 44 24 20          	mov    0x20(%esp),%eax
  10484e:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  104852:	85 c0                	test   %eax,%eax
  104854:	0f 8e ed fc ff ff    	jle    104547 <vprintfmt+0x27>
  10485a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
				putch(' ', putdat);
  104860:	89 74 24 04          	mov    %esi,0x4(%esp)
  104864:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10486b:	ff d7                	call   *%edi
			     width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  10486d:	83 eb 01             	sub    $0x1,%ebx
  104870:	75 ee                	jne    104860 <vprintfmt+0x340>
  104872:	e9 d0 fc ff ff       	jmp    104547 <vprintfmt+0x27>

			// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
  104877:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  10487b:	85 db                	test   %ebx,%ebx
  10487d:	0f 8e 5e fe ff ff    	jle    1046e1 <vprintfmt+0x1c1>
				for (width -= strnlen(p, precision);
  104883:	89 54 24 04          	mov    %edx,0x4(%esp)
  104887:	89 0c 24             	mov    %ecx,(%esp)
  10488a:	89 54 24 2c          	mov    %edx,0x2c(%esp)
  10488e:	89 4c 24 24          	mov    %ecx,0x24(%esp)
  104892:	e8 29 f6 ff ff       	call   103ec0 <strnlen>
  104897:	8b 4c 24 24          	mov    0x24(%esp),%ecx
  10489b:	8b 54 24 2c          	mov    0x2c(%esp),%edx
  10489f:	29 44 24 20          	sub    %eax,0x20(%esp)
  1048a3:	8b 44 24 20          	mov    0x20(%esp),%eax
  1048a7:	85 c0                	test   %eax,%eax
  1048a9:	0f 8e 32 fe ff ff    	jle    1046e1 <vprintfmt+0x1c1>
  1048af:	0f be 5c 24 2b       	movsbl 0x2b(%esp),%ebx
  1048b4:	89 6c 24 58          	mov    %ebp,0x58(%esp)
  1048b8:	89 c5                	mov    %eax,%ebp
  1048ba:	89 4c 24 20          	mov    %ecx,0x20(%esp)
  1048be:	89 54 24 24          	mov    %edx,0x24(%esp)
  1048c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
				     width > 0;
				     width--)
					putch(padc, putdat);
  1048c8:	89 74 24 04          	mov    %esi,0x4(%esp)
  1048cc:	89 1c 24             	mov    %ebx,(%esp)
  1048cf:	ff d7                	call   *%edi
			// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision);
  1048d1:	83 ed 01             	sub    $0x1,%ebp
  1048d4:	75 f2                	jne    1048c8 <vprintfmt+0x3a8>
  1048d6:	8b 4c 24 20          	mov    0x20(%esp),%ecx
  1048da:	8b 54 24 24          	mov    0x24(%esp),%edx
  1048de:	89 6c 24 20          	mov    %ebp,0x20(%esp)
  1048e2:	8b 6c 24 58          	mov    0x58(%esp),%ebp
  1048e6:	e9 f6 fd ff ff       	jmp    1046e1 <vprintfmt+0x1c1>
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, long long);
	else if (lflag)
		return va_arg(*ap, long);
  1048eb:	83 c0 04             	add    $0x4,%eax
  1048ee:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  1048f2:	8b 02                	mov    (%edx),%eax
	else
		return va_arg(*ap, int);
  1048f4:	99                   	cltd   
  1048f5:	e9 24 fd ff ff       	jmp    10461e <vprintfmt+0xfe>
  1048fa:	89 44 24 18          	mov    %eax,0x18(%esp)
  1048fe:	89 54 24 1c          	mov    %edx,0x1c(%esp)

			// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
			if ((long long) num < 0) {
				putch('-', putdat);
  104902:	89 74 24 04          	mov    %esi,0x4(%esp)
  104906:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  10490d:	ff d7                	call   *%edi
				num = -(long long) num;
  10490f:	8b 44 24 18          	mov    0x18(%esp),%eax
  104913:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  104917:	f7 d8                	neg    %eax
  104919:	83 d2 00             	adc    $0x0,%edx
  10491c:	f7 da                	neg    %edx
  10491e:	e9 0d fd ff ff       	jmp    104630 <vprintfmt+0x110>
  104923:	66 90                	xchg   %ax,%ax
  104925:	66 90                	xchg   %ax,%ax
  104927:	66 90                	xchg   %ax,%ax
  104929:	66 90                	xchg   %ax,%ax
  10492b:	66 90                	xchg   %ax,%ax
  10492d:	66 90                	xchg   %ax,%ax
  10492f:	90                   	nop

00104930 <kstack_switch>:
#include "seg.h"

#define offsetof(type, member)	__builtin_offsetof(type, member)

void kstack_switch(uint32_t pid)
{
  104930:	53                   	push   %ebx
  104931:	83 ec 18             	sub    $0x18,%esp
  104934:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  int cpu_idx = get_pcpu_idx();
  104938:	e8 c3 12 00 00       	call   105c00 <get_pcpu_idx>

  struct kstack *ks = (struct kstack *) get_pcpu_kstack_pointer(cpu_idx);
  10493d:	89 04 24             	mov    %eax,(%esp)
  104940:	e8 fb 12 00 00       	call   105c40 <get_pcpu_kstack_pointer>

  /*
   * Switch to the new TSS.
   */
  ks->tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  104945:	89 da                	mov    %ebx,%edx
  ks->tss.ts_ss0 = CPU_GDT_KDATA;
  ks->gdt[CPU_GDT_TSS >> 3] =
  104947:	b9 eb 00 00 00       	mov    $0xeb,%ecx
  struct kstack *ks = (struct kstack *) get_pcpu_kstack_pointer(cpu_idx);

  /*
   * Switch to the new TSS.
   */
  ks->tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  10494c:	c1 e2 0c             	shl    $0xc,%edx
  10494f:	81 c2 00 a0 98 00    	add    $0x98a000,%edx
  ks->tss.ts_ss0 = CPU_GDT_KDATA;
  ks->gdt[CPU_GDT_TSS >> 3] =
          SEGDESC16(STS_T32A,
  104955:	c1 e3 0c             	shl    $0xc,%ebx
  struct kstack *ks = (struct kstack *) get_pcpu_kstack_pointer(cpu_idx);

  /*
   * Switch to the new TSS.
   */
  ks->tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  104958:	89 50 34             	mov    %edx,0x34(%eax)
  ks->tss.ts_ss0 = CPU_GDT_KDATA;
  10495b:	ba 10 00 00 00       	mov    $0x10,%edx
  104960:	66 89 50 38          	mov    %dx,0x38(%eax)
  ks->gdt[CPU_GDT_TSS >> 3] =
          SEGDESC16(STS_T32A,
  104964:	89 da                	mov    %ebx,%edx
  104966:	81 c2 30 90 98 00    	add    $0x989030,%edx
  /*
   * Switch to the new TSS.
   */
  ks->tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  ks->tss.ts_ss0 = CPU_GDT_KDATA;
  ks->gdt[CPU_GDT_TSS >> 3] =
  10496c:	66 89 48 28          	mov    %cx,0x28(%eax)
          SEGDESC16(STS_T32A,
  104970:	89 d1                	mov    %edx,%ecx
  /*
   * Switch to the new TSS.
   */
  ks->tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  ks->tss.ts_ss0 = CPU_GDT_KDATA;
  ks->gdt[CPU_GDT_TSS >> 3] =
  104972:	66 89 50 2a          	mov    %dx,0x2a(%eax)
          SEGDESC16(STS_T32A,
  104976:	c1 e9 10             	shr    $0x10,%ecx
  104979:	c1 ea 18             	shr    $0x18,%edx
  /*
   * Switch to the new TSS.
   */
  ks->tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  ks->tss.ts_ss0 = CPU_GDT_KDATA;
  ks->gdt[CPU_GDT_TSS >> 3] =
  10497c:	88 48 2c             	mov    %cl,0x2c(%eax)
  10497f:	c6 40 2e 40          	movb   $0x40,0x2e(%eax)
  104983:	88 50 2f             	mov    %dl,0x2f(%eax)
          SEGDESC16(STS_T32A,
                    (uint32_t) (&(proc_kstack[pid].tss)), sizeof(tss_t) - 1, 0);
  ks->gdt[CPU_GDT_TSS >> 3].sd_s = 0;
  104986:	c6 40 2d 89          	movb   $0x89,0x2d(%eax)
  ltr(CPU_GDT_TSS);
  10498a:	c7 44 24 20 28 00 00 	movl   $0x28,0x20(%esp)
  104991:	00 

}
  104992:	83 c4 18             	add    $0x18,%esp
  104995:	5b                   	pop    %ebx
  ks->tss.ts_ss0 = CPU_GDT_KDATA;
  ks->gdt[CPU_GDT_TSS >> 3] =
          SEGDESC16(STS_T32A,
                    (uint32_t) (&(proc_kstack[pid].tss)), sizeof(tss_t) - 1, 0);
  ks->gdt[CPU_GDT_TSS >> 3].sd_s = 0;
  ltr(CPU_GDT_TSS);
  104996:	e9 25 06 00 00       	jmp    104fc0 <ltr>
  10499b:	90                   	nop
  10499c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001049a0 <seg_init>:

}

void seg_init (int cpu_idx)
{
  1049a0:	55                   	push   %ebp
  1049a1:	57                   	push   %edi
  1049a2:	56                   	push   %esi
  1049a3:	53                   	push   %ebx
  1049a4:	83 ec 2c             	sub    $0x2c,%esp
  1049a7:	8b 5c 24 40          	mov    0x40(%esp),%ebx

	/* clear BSS */

	if (cpu_idx == 0){
  1049ab:	85 db                	test   %ebx,%ebx
  1049ad:	0f 84 c5 01 00 00    	je     104b78 <seg_init+0x1d8>
    memzero(edata, ((uint8_t *) (&bsp_kstack[0])) - edata);
    memzero(((uint8_t *) (&bsp_kstack[0])) + 4096, end - ((uint8_t *) (&bsp_kstack[0])) - 4096);
	}

  /* setup GDT */
  bsp_kstack[cpu_idx].gdt[0] = SEGDESC_NULL;
  1049b3:	89 d8                	mov    %ebx,%eax
  /* 0x08: kernel code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
  1049b5:	31 ff                	xor    %edi,%edi
    memzero(edata, ((uint8_t *) (&bsp_kstack[0])) - edata);
    memzero(((uint8_t *) (&bsp_kstack[0])) + 4096, end - ((uint8_t *) (&bsp_kstack[0])) - 4096);
	}

  /* setup GDT */
  bsp_kstack[cpu_idx].gdt[0] = SEGDESC_NULL;
  1049b7:	c1 e0 0c             	shl    $0xc,%eax
  /* 0x08: kernel code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KCODE >> 3] =
  1049ba:	ba ff ff ff ff       	mov    $0xffffffff,%edx
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
  1049bf:	be ff ff ff ff       	mov    $0xffffffff,%esi
	}

  /* setup GDT */
  bsp_kstack[cpu_idx].gdt[0] = SEGDESC_NULL;
  /* 0x08: kernel code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KCODE >> 3] =
  1049c4:	31 c9                	xor    %ecx,%ecx
  1049c6:	66 89 90 08 10 98 00 	mov    %dx,0x981008(%eax)
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UCODE >> 3] =
  1049cd:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  bsp_kstack[cpu_idx].gdt[0] = SEGDESC_NULL;
  /* 0x08: kernel code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
  1049d2:	66 89 b0 10 10 98 00 	mov    %si,0x981010(%eax)
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x00000000, 0xffffffff, 3);
  /* 0x20: user data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
  1049d9:	be ff ff ff ff       	mov    $0xffffffff,%esi
  bsp_kstack[cpu_idx].gdt[0] = SEGDESC_NULL;
  /* 0x08: kernel code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
  1049de:	66 89 b8 12 10 98 00 	mov    %di,0x981012(%eax)
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x00000000, 0xffffffff, 3);
  /* 0x20: user data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
  1049e5:	31 ff                	xor    %edi,%edi
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UCODE >> 3] =
  1049e7:	66 89 90 18 10 98 00 	mov    %dx,0x981018(%eax)
  /* 0x20: user data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  1049ee:	8d 90 30 10 98 00    	lea    0x981030(%eax),%edx
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x00000000, 0xffffffff, 3);
  /* 0x20: user data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
  1049f4:	66 89 b0 20 10 98 00 	mov    %si,0x981020(%eax)
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  1049fb:	89 c6                	mov    %eax,%esi
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x00000000, 0xffffffff, 3);
  /* 0x20: user data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
  1049fd:	66 89 b8 22 10 98 00 	mov    %di,0x981022(%eax)
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  bsp_kstack[cpu_idx].tss.ts_ss0 = CPU_GDT_KDATA;
  bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  104a04:	bf eb 00 00 00       	mov    $0xeb,%edi
  /* 0x20: user data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  104a09:	81 c6 00 20 98 00    	add    $0x982000,%esi
	}

  /* setup GDT */
  bsp_kstack[cpu_idx].gdt[0] = SEGDESC_NULL;
  /* 0x08: kernel code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KCODE >> 3] =
  104a0f:	66 89 88 0a 10 98 00 	mov    %cx,0x98100a(%eax)
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UCODE >> 3] =
  104a16:	31 c9                	xor    %ecx,%ecx
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  bsp_kstack[cpu_idx].tss.ts_ss0 = CPU_GDT_KDATA;
  bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  104a18:	66 89 b8 28 10 98 00 	mov    %di,0x981028(%eax)
          SEGDESC16(STS_T32A,
  104a1f:	89 d7                	mov    %edx,%edi
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UCODE >> 3] =
  104a21:	66 89 88 1a 10 98 00 	mov    %cx,0x98101a(%eax)

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  bsp_kstack[cpu_idx].tss.ts_ss0 = CPU_GDT_KDATA;
  bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
          SEGDESC16(STS_T32A,
  104a28:	c1 ef 10             	shr    $0x10,%edi
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  bsp_kstack[cpu_idx].tss.ts_ss0 = CPU_GDT_KDATA;
  104a2b:	b9 10 00 00 00       	mov    $0x10,%ecx
  /* 0x20: user data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  104a30:	89 b0 34 10 98 00    	mov    %esi,0x981034(%eax)
  bsp_kstack[cpu_idx].tss.ts_ss0 = CPU_GDT_KDATA;
  bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
          SEGDESC16(STS_T32A,
  104a36:	89 d6                	mov    %edx,%esi
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  bsp_kstack[cpu_idx].tss.ts_ss0 = CPU_GDT_KDATA;
  104a38:	66 89 88 38 10 98 00 	mov    %cx,0x981038(%eax)
  bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
          SEGDESC16(STS_T32A,
  104a3f:	c1 ee 18             	shr    $0x18,%esi
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  bsp_kstack[cpu_idx].tss.ts_ss0 = CPU_GDT_KDATA;
  bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  104a42:	89 f9                	mov    %edi,%ecx
  104a44:	88 88 2c 10 98 00    	mov    %cl,0x98102c(%eax)
  104a4a:	89 f1                	mov    %esi,%ecx
    memzero(edata, ((uint8_t *) (&bsp_kstack[0])) - edata);
    memzero(((uint8_t *) (&bsp_kstack[0])) + 4096, end - ((uint8_t *) (&bsp_kstack[0])) - 4096);
	}

  /* setup GDT */
  bsp_kstack[cpu_idx].gdt[0] = SEGDESC_NULL;
  104a4c:	8d a8 00 10 98 00    	lea    0x981000(%eax),%ebp
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  bsp_kstack[cpu_idx].tss.ts_ss0 = CPU_GDT_KDATA;
  bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  104a52:	66 89 90 2a 10 98 00 	mov    %dx,0x98102a(%eax)
  104a59:	88 88 2f 10 98 00    	mov    %cl,0x98102f(%eax)
    memzero(edata, ((uint8_t *) (&bsp_kstack[0])) - edata);
    memzero(((uint8_t *) (&bsp_kstack[0])) + 4096, end - ((uint8_t *) (&bsp_kstack[0])) - 4096);
	}

  /* setup GDT */
  bsp_kstack[cpu_idx].gdt[0] = SEGDESC_NULL;
  104a5f:	c7 80 00 10 98 00 00 	movl   $0x0,0x981000(%eax)
  104a66:	00 00 00 
  104a69:	c7 80 04 10 98 00 00 	movl   $0x0,0x981004(%eax)
  104a70:	00 00 00 
  /* 0x08: kernel code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KCODE >> 3] =
  104a73:	c6 80 0c 10 98 00 00 	movb   $0x0,0x98100c(%eax)
  104a7a:	c6 80 0d 10 98 00 9a 	movb   $0x9a,0x98100d(%eax)
  104a81:	c6 80 0e 10 98 00 cf 	movb   $0xcf,0x98100e(%eax)
  104a88:	c6 80 0f 10 98 00 00 	movb   $0x0,0x98100f(%eax)
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
  104a8f:	c6 80 14 10 98 00 00 	movb   $0x0,0x981014(%eax)
  104a96:	c6 80 15 10 98 00 92 	movb   $0x92,0x981015(%eax)
  104a9d:	c6 80 16 10 98 00 cf 	movb   $0xcf,0x981016(%eax)
  104aa4:	c6 80 17 10 98 00 00 	movb   $0x0,0x981017(%eax)
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UCODE >> 3] =
  104aab:	c6 80 1c 10 98 00 00 	movb   $0x0,0x98101c(%eax)
  104ab2:	c6 80 1d 10 98 00 fa 	movb   $0xfa,0x98101d(%eax)
  104ab9:	c6 80 1e 10 98 00 cf 	movb   $0xcf,0x98101e(%eax)
  104ac0:	c6 80 1f 10 98 00 00 	movb   $0x0,0x98101f(%eax)
          SEGDESC32(STA_X | STA_R, 0x00000000, 0xffffffff, 3);
  /* 0x20: user data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
  104ac7:	c6 80 24 10 98 00 00 	movb   $0x0,0x981024(%eax)
  104ace:	c6 80 25 10 98 00 f2 	movb   $0xf2,0x981025(%eax)
  104ad5:	c6 80 26 10 98 00 cf 	movb   $0xcf,0x981026(%eax)
  104adc:	c6 80 27 10 98 00 00 	movb   $0x0,0x981027(%eax)
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  bsp_kstack[cpu_idx].tss.ts_ss0 = CPU_GDT_KDATA;
  bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  104ae3:	c6 80 2e 10 98 00 40 	movb   $0x40,0x98102e(%eax)
          SEGDESC16(STS_T32A,
                    (uint32_t) (&(bsp_kstack[cpu_idx].tss)), sizeof(tss_t) - 1, 0);
  bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3].sd_s = 0;
  104aea:	c6 80 2d 10 98 00 89 	movb   $0x89,0x98102d(%eax)

  /* other fields */
  /* Set the KSTACK_MAGIC value when we initialize the kstack */
  bsp_kstack[cpu_idx].magic = KSTACK_MAGIC;
  104af1:	c7 80 20 11 98 00 32 	movl   $0x98765432,0x981120(%eax)
  104af8:	54 76 98 

  pseudodesc_t gdt_desc = {
  104afb:	b8 2f 00 00 00       	mov    $0x2f,%eax
  104b00:	66 89 44 24 1a       	mov    %ax,0x1a(%esp)
          .pd_lim   = sizeof(bsp_kstack[cpu_idx].gdt) - 1,
          .pd_base  = (uint32_t) (bsp_kstack[cpu_idx].gdt)
  104b05:	89 6c 24 1c          	mov    %ebp,0x1c(%esp)
  };
  asm volatile("lgdt %0" :: "m" (gdt_desc));
  104b09:	0f 01 54 24 1a       	lgdtl  0x1a(%esp)
  asm volatile("movw %%ax,%%gs" :: "a" (CPU_GDT_KDATA));
  104b0e:	b8 10 00 00 00       	mov    $0x10,%eax
  104b13:	8e e8                	mov    %eax,%gs
  asm volatile("movw %%ax,%%fs" :: "a" (CPU_GDT_KDATA));
  104b15:	8e e0                	mov    %eax,%fs
  asm volatile("movw %%ax,%%es" :: "a" (CPU_GDT_KDATA));
  104b17:	8e c0                	mov    %eax,%es
  asm volatile("movw %%ax,%%ds" :: "a" (CPU_GDT_KDATA));
  104b19:	8e d8                	mov    %eax,%ds
  asm volatile("movw %%ax,%%ss" :: "a" (CPU_GDT_KDATA));
  104b1b:	8e d0                	mov    %eax,%ss
  /* reload %cs */
  asm volatile("ljmp %0,$1f\n 1:\n" :: "i" (CPU_GDT_KCODE));
  104b1d:	ea 24 4b 10 00 08 00 	ljmp   $0x8,$0x104b24

	/*
	 * Load a null LDT.
	 */
	lldt (0);
  104b24:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104b2b:	e8 b0 02 00 00       	call   104de0 <lldt>

	/*
	 * Load the bootstrap TSS.
	 */
	ltr (CPU_GDT_TSS);
  104b30:	c7 04 24 28 00 00 00 	movl   $0x28,(%esp)
  104b37:	e8 84 04 00 00       	call   104fc0 <ltr>

	/*
	 * Load IDT.
	 */
	extern pseudodesc_t idt_pd;
	asm volatile("lidt %0" : : "m" (idt_pd));
  104b3c:	0f 01 1d 00 03 11 00 	lidtl  0x110300

	/*
	 * Initialize all TSS structures for processes.
	 */

	if (cpu_idx == 0){
  104b43:	85 db                	test   %ebx,%ebx
  104b45:	75 28                	jne    104b6f <seg_init+0x1cf>
		memzero(&(bsp_kstack[1]), sizeof(struct kstack) * 7);
  104b47:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
  104b4e:	00 
  104b4f:	c7 04 24 00 20 98 00 	movl   $0x982000,(%esp)
  104b56:	e8 25 f4 ff ff       	call   103f80 <memzero>
		memzero(proc_kstack, sizeof(struct kstack) * 64);
  104b5b:	c7 44 24 04 00 00 04 	movl   $0x40000,0x4(%esp)
  104b62:	00 
  104b63:	c7 04 24 00 90 98 00 	movl   $0x989000,(%esp)
  104b6a:	e8 11 f4 ff ff       	call   103f80 <memzero>
	}
	
}
  104b6f:	83 c4 2c             	add    $0x2c,%esp
  104b72:	5b                   	pop    %ebx
  104b73:	5e                   	pop    %esi
  104b74:	5f                   	pop    %edi
  104b75:	5d                   	pop    %ebp
  104b76:	c3                   	ret    
  104b77:	90                   	nop

	/* clear BSS */

	if (cpu_idx == 0){
		extern uint8_t end[], edata[];
    memzero(edata, ((uint8_t *) (&bsp_kstack[0])) - edata);
  104b78:	b8 00 10 98 00       	mov    $0x981000,%eax
  104b7d:	2d 66 ee 13 00       	sub    $0x13ee66,%eax
  104b82:	89 44 24 04          	mov    %eax,0x4(%esp)
  104b86:	c7 04 24 66 ee 13 00 	movl   $0x13ee66,(%esp)
  104b8d:	e8 ee f3 ff ff       	call   103f80 <memzero>
    memzero(((uint8_t *) (&bsp_kstack[0])) + 4096, end - ((uint8_t *) (&bsp_kstack[0])) - 4096);
  104b92:	b8 d0 42 e1 00       	mov    $0xe142d0,%eax
  104b97:	2d 00 10 98 00       	sub    $0x981000,%eax
  104b9c:	89 44 24 04          	mov    %eax,0x4(%esp)
  104ba0:	c7 04 24 00 20 98 00 	movl   $0x982000,(%esp)
  104ba7:	e8 d4 f3 ff ff       	call   103f80 <memzero>
  104bac:	e9 02 fe ff ff       	jmp    1049b3 <seg_init+0x13>
  104bb1:	eb 0d                	jmp    104bc0 <seg_init_proc>
  104bb3:	90                   	nop
  104bb4:	90                   	nop
  104bb5:	90                   	nop
  104bb6:	90                   	nop
  104bb7:	90                   	nop
  104bb8:	90                   	nop
  104bb9:	90                   	nop
  104bba:	90                   	nop
  104bbb:	90                   	nop
  104bbc:	90                   	nop
  104bbd:	90                   	nop
  104bbe:	90                   	nop
  104bbf:	90                   	nop

00104bc0 <seg_init_proc>:
	
}

/* initialize the kernel stack for each process */
void
seg_init_proc(int cpu_idx, int pid){
  104bc0:	57                   	push   %edi

  /* setup GDT */
  proc_kstack[pid].gdt[0] = SEGDESC_NULL;
  /* 0x08: kernel code */
  proc_kstack[pid].gdt[CPU_GDT_KCODE >> 3] =
  104bc1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
	
}

/* initialize the kernel stack for each process */
void
seg_init_proc(int cpu_idx, int pid){
  104bc6:	56                   	push   %esi
  proc_kstack[pid].gdt[0] = SEGDESC_NULL;
  /* 0x08: kernel code */
  proc_kstack[pid].gdt[CPU_GDT_KCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  proc_kstack[pid].gdt[CPU_GDT_KDATA >> 3] =
  104bc7:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
	
}

/* initialize the kernel stack for each process */
void
seg_init_proc(int cpu_idx, int pid){
  104bcc:	53                   	push   %ebx
  proc_kstack[pid].gdt[0] = SEGDESC_NULL;
  /* 0x08: kernel code */
  proc_kstack[pid].gdt[CPU_GDT_KCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  proc_kstack[pid].gdt[CPU_GDT_KDATA >> 3] =
  104bcd:	31 f6                	xor    %esi,%esi
	
}

/* initialize the kernel stack for each process */
void
seg_init_proc(int cpu_idx, int pid){
  104bcf:	83 ec 10             	sub    $0x10,%esp
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  proc_kstack[pid].gdt[CPU_GDT_KDATA >> 3] =
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  proc_kstack[pid].gdt[CPU_GDT_UCODE >> 3] =
  104bd2:	bf ff ff ff ff       	mov    $0xffffffff,%edi
	
}

/* initialize the kernel stack for each process */
void
seg_init_proc(int cpu_idx, int pid){
  104bd7:	8b 54 24 24          	mov    0x24(%esp),%edx

  /* setup GDT */
  proc_kstack[pid].gdt[0] = SEGDESC_NULL;
  104bdb:	89 d3                	mov    %edx,%ebx
  /* 0x08: kernel code */
  proc_kstack[pid].gdt[CPU_GDT_KCODE >> 3] =
  104bdd:	31 d2                	xor    %edx,%edx
/* initialize the kernel stack for each process */
void
seg_init_proc(int cpu_idx, int pid){

  /* setup GDT */
  proc_kstack[pid].gdt[0] = SEGDESC_NULL;
  104bdf:	c1 e3 0c             	shl    $0xc,%ebx
  /* 0x08: kernel code */
  proc_kstack[pid].gdt[CPU_GDT_KCODE >> 3] =
  104be2:	66 89 83 08 90 98 00 	mov    %ax,0x989008(%ebx)
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  proc_kstack[pid].gdt[CPU_GDT_KDATA >> 3] =
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  proc_kstack[pid].gdt[CPU_GDT_UCODE >> 3] =
  104be9:	31 c0                	xor    %eax,%eax
  104beb:	66 89 83 1a 90 98 00 	mov    %ax,0x98901a(%ebx)
          SEGDESC32(STA_X | STA_R, 0x00000000, 0xffffffff, 3);
  /* 0x20: user data */
  proc_kstack[pid].gdt[CPU_GDT_UDATA >> 3] =
  104bf2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104bf7:	66 89 83 20 90 98 00 	mov    %ax,0x989020(%ebx)
  104bfe:	31 c0                	xor    %eax,%eax
seg_init_proc(int cpu_idx, int pid){

  /* setup GDT */
  proc_kstack[pid].gdt[0] = SEGDESC_NULL;
  /* 0x08: kernel code */
  proc_kstack[pid].gdt[CPU_GDT_KCODE >> 3] =
  104c00:	66 89 93 0a 90 98 00 	mov    %dx,0x98900a(%ebx)
  /* 0x20: user data */
  proc_kstack[pid].gdt[CPU_GDT_UDATA >> 3] =
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  proc_kstack[pid].tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  104c07:	89 da                	mov    %ebx,%edx
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  proc_kstack[pid].gdt[CPU_GDT_UCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x00000000, 0xffffffff, 3);
  /* 0x20: user data */
  proc_kstack[pid].gdt[CPU_GDT_UDATA >> 3] =
  104c09:	66 89 83 22 90 98 00 	mov    %ax,0x989022(%ebx)
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  proc_kstack[pid].tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  proc_kstack[pid].tss.ts_ss0 = CPU_GDT_KDATA;
  104c10:	b8 10 00 00 00       	mov    $0x10,%eax
  /* 0x20: user data */
  proc_kstack[pid].gdt[CPU_GDT_UDATA >> 3] =
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  proc_kstack[pid].tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  104c15:	81 c2 00 a0 98 00    	add    $0x98a000,%edx
  proc_kstack[pid].tss.ts_ss0 = CPU_GDT_KDATA;
  104c1b:	66 89 83 38 90 98 00 	mov    %ax,0x989038(%ebx)
  proc_kstack[pid].tss.ts_iomb = offsetof(tss_t, ts_iopm);
  104c22:	b8 68 00 00 00       	mov    $0x68,%eax
  proc_kstack[pid].gdt[0] = SEGDESC_NULL;
  /* 0x08: kernel code */
  proc_kstack[pid].gdt[CPU_GDT_KCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  proc_kstack[pid].gdt[CPU_GDT_KDATA >> 3] =
  104c27:	66 89 8b 10 90 98 00 	mov    %cx,0x989010(%ebx)
  /* 0x20: user data */
  proc_kstack[pid].gdt[CPU_GDT_UDATA >> 3] =
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  proc_kstack[pid].tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  104c2e:	89 93 34 90 98 00    	mov    %edx,0x989034(%ebx)
  proc_kstack[pid].gdt[0] = SEGDESC_NULL;
  /* 0x08: kernel code */
  proc_kstack[pid].gdt[CPU_GDT_KCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  proc_kstack[pid].gdt[CPU_GDT_KDATA >> 3] =
  104c34:	66 89 b3 12 90 98 00 	mov    %si,0x989012(%ebx)
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  proc_kstack[pid].gdt[CPU_GDT_UCODE >> 3] =
  104c3b:	66 89 bb 18 90 98 00 	mov    %di,0x989018(%ebx)
/* initialize the kernel stack for each process */
void
seg_init_proc(int cpu_idx, int pid){

  /* setup GDT */
  proc_kstack[pid].gdt[0] = SEGDESC_NULL;
  104c42:	c7 83 00 90 98 00 00 	movl   $0x0,0x989000(%ebx)
  104c49:	00 00 00 
  104c4c:	c7 83 04 90 98 00 00 	movl   $0x0,0x989004(%ebx)
  104c53:	00 00 00 
  /* 0x08: kernel code */
  proc_kstack[pid].gdt[CPU_GDT_KCODE >> 3] =
  104c56:	c6 83 0c 90 98 00 00 	movb   $0x0,0x98900c(%ebx)
  104c5d:	c6 83 0d 90 98 00 9a 	movb   $0x9a,0x98900d(%ebx)
  104c64:	c6 83 0e 90 98 00 cf 	movb   $0xcf,0x98900e(%ebx)
  104c6b:	c6 83 0f 90 98 00 00 	movb   $0x0,0x98900f(%ebx)
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  proc_kstack[pid].gdt[CPU_GDT_KDATA >> 3] =
  104c72:	c6 83 14 90 98 00 00 	movb   $0x0,0x989014(%ebx)
  104c79:	c6 83 15 90 98 00 92 	movb   $0x92,0x989015(%ebx)
  104c80:	c6 83 16 90 98 00 cf 	movb   $0xcf,0x989016(%ebx)
  104c87:	c6 83 17 90 98 00 00 	movb   $0x0,0x989017(%ebx)
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  proc_kstack[pid].gdt[CPU_GDT_UCODE >> 3] =
  104c8e:	c6 83 1c 90 98 00 00 	movb   $0x0,0x98901c(%ebx)
  104c95:	c6 83 1d 90 98 00 fa 	movb   $0xfa,0x98901d(%ebx)
  104c9c:	c6 83 1e 90 98 00 cf 	movb   $0xcf,0x98901e(%ebx)
  104ca3:	c6 83 1f 90 98 00 00 	movb   $0x0,0x98901f(%ebx)
          SEGDESC32(STA_X | STA_R, 0x00000000, 0xffffffff, 3);
  /* 0x20: user data */
  proc_kstack[pid].gdt[CPU_GDT_UDATA >> 3] =
  104caa:	c6 83 24 90 98 00 00 	movb   $0x0,0x989024(%ebx)
  104cb1:	c6 83 25 90 98 00 f2 	movb   $0xf2,0x989025(%ebx)
  104cb8:	c6 83 26 90 98 00 cf 	movb   $0xcf,0x989026(%ebx)
  104cbf:	c6 83 27 90 98 00 00 	movb   $0x0,0x989027(%ebx)
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  proc_kstack[pid].tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  proc_kstack[pid].tss.ts_ss0 = CPU_GDT_KDATA;
  proc_kstack[pid].tss.ts_iomb = offsetof(tss_t, ts_iopm);
  104cc6:	66 89 83 96 90 98 00 	mov    %ax,0x989096(%ebx)
  memzero (proc_kstack[pid].tss.ts_iopm, sizeof(uint8_t) * 128);
  104ccd:	8d 83 98 90 98 00    	lea    0x989098(%ebx),%eax
  104cd3:	c7 44 24 04 80 00 00 	movl   $0x80,0x4(%esp)
  104cda:	00 
  104cdb:	89 04 24             	mov    %eax,(%esp)
  104cde:	e8 9d f2 ff ff       	call   103f80 <memzero>
  proc_kstack[pid].tss.ts_iopm[128] = 0xff;

  proc_kstack[pid].gdt[CPU_GDT_TSS >> 3] =
  104ce3:	b8 eb 00 00 00       	mov    $0xeb,%eax
          SEGDESC16(STS_T32A,
  104ce8:	8d 93 30 90 98 00    	lea    0x989030(%ebx),%edx
  proc_kstack[pid].tss.ts_ss0 = CPU_GDT_KDATA;
  proc_kstack[pid].tss.ts_iomb = offsetof(tss_t, ts_iopm);
  memzero (proc_kstack[pid].tss.ts_iopm, sizeof(uint8_t) * 128);
  proc_kstack[pid].tss.ts_iopm[128] = 0xff;

  proc_kstack[pid].gdt[CPU_GDT_TSS >> 3] =
  104cee:	66 89 83 28 90 98 00 	mov    %ax,0x989028(%ebx)
  proc_kstack[pid].gdt[CPU_GDT_TSS >> 3].sd_s = 0;

  /* other fields */
  proc_kstack[pid].magic = KSTACK_MAGIC;

  proc_kstack[pid].cpu_idx = cpu_idx;
  104cf5:	8b 44 24 20          	mov    0x20(%esp),%eax
  proc_kstack[pid].tss.ts_iomb = offsetof(tss_t, ts_iopm);
  memzero (proc_kstack[pid].tss.ts_iopm, sizeof(uint8_t) * 128);
  proc_kstack[pid].tss.ts_iopm[128] = 0xff;

  proc_kstack[pid].gdt[CPU_GDT_TSS >> 3] =
          SEGDESC16(STS_T32A,
  104cf9:	89 d6                	mov    %edx,%esi
  104cfb:	c1 ee 10             	shr    $0x10,%esi
  proc_kstack[pid].tss.ts_ss0 = CPU_GDT_KDATA;
  proc_kstack[pid].tss.ts_iomb = offsetof(tss_t, ts_iopm);
  memzero (proc_kstack[pid].tss.ts_iopm, sizeof(uint8_t) * 128);
  proc_kstack[pid].tss.ts_iopm[128] = 0xff;

  proc_kstack[pid].gdt[CPU_GDT_TSS >> 3] =
  104cfe:	66 89 93 2a 90 98 00 	mov    %dx,0x98902a(%ebx)
  104d05:	89 f1                	mov    %esi,%ecx
          SEGDESC16(STS_T32A,
  104d07:	c1 ea 18             	shr    $0x18,%edx
  /* setup TSS */
  proc_kstack[pid].tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  proc_kstack[pid].tss.ts_ss0 = CPU_GDT_KDATA;
  proc_kstack[pid].tss.ts_iomb = offsetof(tss_t, ts_iopm);
  memzero (proc_kstack[pid].tss.ts_iopm, sizeof(uint8_t) * 128);
  proc_kstack[pid].tss.ts_iopm[128] = 0xff;
  104d0a:	c6 83 18 91 98 00 ff 	movb   $0xff,0x989118(%ebx)

  proc_kstack[pid].gdt[CPU_GDT_TSS >> 3] =
  104d11:	88 8b 2c 90 98 00    	mov    %cl,0x98902c(%ebx)
  104d17:	c6 83 2e 90 98 00 40 	movb   $0x40,0x98902e(%ebx)
  104d1e:	88 93 2f 90 98 00    	mov    %dl,0x98902f(%ebx)
          SEGDESC16(STS_T32A,
                    (uint32_t) (&(proc_kstack[pid].tss)), sizeof(tss_t) - 1, 0);
  proc_kstack[pid].gdt[CPU_GDT_TSS >> 3].sd_s = 0;
  104d24:	c6 83 2d 90 98 00 89 	movb   $0x89,0x98902d(%ebx)

  /* other fields */
  proc_kstack[pid].magic = KSTACK_MAGIC;
  104d2b:	c7 83 20 91 98 00 32 	movl   $0x98765432,0x989120(%ebx)
  104d32:	54 76 98 

  proc_kstack[pid].cpu_idx = cpu_idx;
  104d35:	89 83 1c 91 98 00    	mov    %eax,0x98911c(%ebx)

}
  104d3b:	83 c4 10             	add    $0x10,%esp
  104d3e:	5b                   	pop    %ebx
  104d3f:	5e                   	pop    %esi
  104d40:	5f                   	pop    %edi
  104d41:	c3                   	ret    
  104d42:	66 90                	xchg   %ax,%ax
  104d44:	66 90                	xchg   %ax,%ax
  104d46:	66 90                	xchg   %ax,%ax
  104d48:	66 90                	xchg   %ax,%ax
  104d4a:	66 90                	xchg   %ax,%ax
  104d4c:	66 90                	xchg   %ax,%ax
  104d4e:	66 90                	xchg   %ax,%ax

00104d50 <max>:
#include "types.h"

uint32_t
max(uint32_t a, uint32_t b)
{
  104d50:	8b 44 24 04          	mov    0x4(%esp),%eax
  104d54:	8b 54 24 08          	mov    0x8(%esp),%edx
	return (a > b) ? a : b;
  104d58:	39 c2                	cmp    %eax,%edx
  104d5a:	0f 43 c2             	cmovae %edx,%eax
}
  104d5d:	c3                   	ret    
  104d5e:	66 90                	xchg   %ax,%ax

00104d60 <min>:

uint32_t
min(uint32_t a, uint32_t b)
{
  104d60:	8b 44 24 04          	mov    0x4(%esp),%eax
  104d64:	8b 54 24 08          	mov    0x8(%esp),%edx
	return (a < b) ? a : b;
  104d68:	39 c2                	cmp    %eax,%edx
  104d6a:	0f 46 c2             	cmovbe %edx,%eax
}
  104d6d:	c3                   	ret    
  104d6e:	66 90                	xchg   %ax,%ax

00104d70 <rounddown>:

uint32_t
rounddown(uint32_t a, uint32_t n)
{
  104d70:	8b 4c 24 04          	mov    0x4(%esp),%ecx
	return a - a % n;
  104d74:	31 d2                	xor    %edx,%edx
  104d76:	89 c8                	mov    %ecx,%eax
  104d78:	f7 74 24 08          	divl   0x8(%esp)
  104d7c:	89 c8                	mov    %ecx,%eax
  104d7e:	29 d0                	sub    %edx,%eax
}
  104d80:	c3                   	ret    
  104d81:	eb 0d                	jmp    104d90 <roundup>
  104d83:	90                   	nop
  104d84:	90                   	nop
  104d85:	90                   	nop
  104d86:	90                   	nop
  104d87:	90                   	nop
  104d88:	90                   	nop
  104d89:	90                   	nop
  104d8a:	90                   	nop
  104d8b:	90                   	nop
  104d8c:	90                   	nop
  104d8d:	90                   	nop
  104d8e:	90                   	nop
  104d8f:	90                   	nop

00104d90 <roundup>:

uint32_t
roundup(uint32_t a, uint32_t n)
{
  104d90:	53                   	push   %ebx
  104d91:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
}

uint32_t
rounddown(uint32_t a, uint32_t n)
{
	return a - a % n;
  104d95:	31 d2                	xor    %edx,%edx
}

uint32_t
roundup(uint32_t a, uint32_t n)
{
	return rounddown(a+n-1, n);
  104d97:	8d 4b ff             	lea    -0x1(%ebx),%ecx
  104d9a:	03 4c 24 08          	add    0x8(%esp),%ecx
}

uint32_t
rounddown(uint32_t a, uint32_t n)
{
	return a - a % n;
  104d9e:	89 c8                	mov    %ecx,%eax
  104da0:	f7 f3                	div    %ebx
  104da2:	89 c8                	mov    %ecx,%eax

uint32_t
roundup(uint32_t a, uint32_t n)
{
	return rounddown(a+n-1, n);
}
  104da4:	5b                   	pop    %ebx
}

uint32_t
rounddown(uint32_t a, uint32_t n)
{
	return a - a % n;
  104da5:	29 d0                	sub    %edx,%eax

uint32_t
roundup(uint32_t a, uint32_t n)
{
	return rounddown(a+n-1, n);
}
  104da7:	c3                   	ret    
  104da8:	66 90                	xchg   %ax,%ax
  104daa:	66 90                	xchg   %ax,%ax
  104dac:	66 90                	xchg   %ax,%ax
  104dae:	66 90                	xchg   %ax,%ax

00104db0 <get_stack_base>:

gcc_inline uintptr_t
get_stack_base(void)
{
        uint32_t ebp;
        __asm __volatile("movl %%ebp,%0" : "=rm" (ebp));
  104db0:	89 e8                	mov    %ebp,%eax
        return ebp;
}
  104db2:	c3                   	ret    
  104db3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104dc0 <get_stack_pointer>:

gcc_inline uintptr_t
get_stack_pointer(void)
{
        uint32_t esp;
        __asm __volatile("movl %%esp,%0" : "=rm" (esp));
  104dc0:	89 e0                	mov    %esp,%eax
        return esp;
}
  104dc2:	c3                   	ret    
  104dc3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104dd0 <read_ebp>:

gcc_inline uint32_t
read_ebp(void)
{
	uint32_t ebp;
	__asm __volatile("movl %%ebp,%0" : "=rm" (ebp));
  104dd0:	89 e8                	mov    %ebp,%eax
	return ebp;
}
  104dd2:	c3                   	ret    
  104dd3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104de0 <lldt>:

gcc_inline void
lldt(uint16_t sel)
{
	__asm __volatile("lldt %0" : : "r" (sel));
  104de0:	8b 44 24 04          	mov    0x4(%esp),%eax
  104de4:	0f 00 d0             	lldt   %ax
  104de7:	c3                   	ret    
  104de8:	90                   	nop
  104de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104df0 <cli>:
}

gcc_inline void
cli(void)
{
	__asm __volatile("cli":::"memory");
  104df0:	fa                   	cli    
  104df1:	c3                   	ret    
  104df2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104e00 <sti>:
}

gcc_inline void
sti(void)
{
	__asm __volatile("sti;nop");
  104e00:	fb                   	sti    
  104e01:	90                   	nop
  104e02:	c3                   	ret    
  104e03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104e10 <rdmsr>:

gcc_inline uint64_t
rdmsr(uint32_t msr)
{
	uint64_t rv;
	__asm __volatile("rdmsr" : "=A" (rv) : "c" (msr));
  104e10:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  104e14:	0f 32                	rdmsr  
	return rv;
}
  104e16:	c3                   	ret    
  104e17:	89 f6                	mov    %esi,%esi
  104e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104e20 <wrmsr>:

gcc_inline void
wrmsr(uint32_t msr, uint64_t newval)
{
        __asm __volatile("wrmsr" : : "A" (newval), "c" (msr));
  104e20:	8b 44 24 08          	mov    0x8(%esp),%eax
  104e24:	8b 54 24 0c          	mov    0xc(%esp),%edx
  104e28:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  104e2c:	0f 30                	wrmsr  
  104e2e:	c3                   	ret    
  104e2f:	90                   	nop

00104e30 <halt>:
}

gcc_inline void
halt(void)
{
	__asm __volatile("hlt");
  104e30:	f4                   	hlt    
  104e31:	c3                   	ret    
  104e32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104e40 <pause>:
}

gcc_inline void
pause(void)
{
        __asm __volatile("pause":::"memory");
  104e40:	f3 90                	pause  
  104e42:	c3                   	ret    
  104e43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104e50 <xchg>:
}

gcc_inline uint32_t
xchg(volatile uint32_t *addr, uint32_t newval)
{
  104e50:	8b 54 24 04          	mov    0x4(%esp),%edx
        uint32_t result;

        __asm __volatile("lock; xchgl %0, %1" :
  104e54:	8b 44 24 08          	mov    0x8(%esp),%eax
  104e58:	f0 87 02             	lock xchg %eax,(%edx)
                         "+m" (*addr), "=a" (result) :
                         "1" (newval) :
                         "cc");

        return result;
}
  104e5b:	c3                   	ret    
  104e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104e60 <rdtsc>:
gcc_inline uint64_t
rdtsc(void)
{
	uint64_t rv;

	__asm __volatile("rdtsc" : "=A" (rv));
  104e60:	0f 31                	rdtsc  
	return (rv);
}
  104e62:	c3                   	ret    
  104e63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104e70 <enable_sse>:

gcc_inline uint32_t
rcr4(void)
{
	uint32_t cr4;
	__asm __volatile("movl %%cr4,%0" : "=r" (cr4));
  104e70:	0f 20 e0             	mov    %cr4,%eax
enable_sse(void)
{
	uint32_t cr0, cr4;

	cr4 = rcr4() | CR4_OSFXSR | CR4_OSXMMEXCPT;
	FENCE();
  104e73:	0f ae f0             	mfence 
gcc_inline void
enable_sse(void)
{
	uint32_t cr0, cr4;

	cr4 = rcr4() | CR4_OSFXSR | CR4_OSXMMEXCPT;
  104e76:	80 cc 06             	or     $0x6,%ah
}

gcc_inline void
lcr4(uint32_t val)
{
	__asm __volatile("movl %0,%%cr4" : : "r" (val));
  104e79:	0f 22 e0             	mov    %eax,%cr4

gcc_inline uint32_t
rcr0(void)
{
	uint32_t val;
	__asm __volatile("movl %%cr0,%0" : "=r" (val));
  104e7c:	0f 20 c0             	mov    %cr0,%eax
	cr4 = rcr4() | CR4_OSFXSR | CR4_OSXMMEXCPT;
	FENCE();
	lcr4(cr4);

	cr0 = rcr0() | CR0_MP;
	FENCE();
  104e7f:	0f ae f0             	mfence 
  104e82:	c3                   	ret    
  104e83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104e90 <cpuid>:
}

gcc_inline void
cpuid(uint32_t info,
      uint32_t *eaxp, uint32_t *ebxp, uint32_t *ecxp, uint32_t *edxp)
{
  104e90:	55                   	push   %ebp
  104e91:	57                   	push   %edi
  104e92:	56                   	push   %esi
  104e93:	53                   	push   %ebx
  104e94:	8b 44 24 14          	mov    0x14(%esp),%eax
  104e98:	8b 7c 24 18          	mov    0x18(%esp),%edi
  104e9c:	8b 6c 24 1c          	mov    0x1c(%esp),%ebp
  104ea0:	8b 74 24 24          	mov    0x24(%esp),%esi
	uint32_t eax, ebx, ecx, edx;
	__asm __volatile("cpuid"
  104ea4:	0f a2                	cpuid  
			 : "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
			 : "a" (info));
	if (eaxp)
  104ea6:	85 ff                	test   %edi,%edi
  104ea8:	74 02                	je     104eac <cpuid+0x1c>
		*eaxp = eax;
  104eaa:	89 07                	mov    %eax,(%edi)
	if (ebxp)
  104eac:	85 ed                	test   %ebp,%ebp
  104eae:	74 03                	je     104eb3 <cpuid+0x23>
		*ebxp = ebx;
  104eb0:	89 5d 00             	mov    %ebx,0x0(%ebp)
	if (ecxp)
  104eb3:	8b 44 24 20          	mov    0x20(%esp),%eax
  104eb7:	85 c0                	test   %eax,%eax
  104eb9:	74 06                	je     104ec1 <cpuid+0x31>
		*ecxp = ecx;
  104ebb:	8b 44 24 20          	mov    0x20(%esp),%eax
  104ebf:	89 08                	mov    %ecx,(%eax)
	if (edxp)
  104ec1:	85 f6                	test   %esi,%esi
  104ec3:	74 02                	je     104ec7 <cpuid+0x37>
		*edxp = edx;
  104ec5:	89 16                	mov    %edx,(%esi)
}
  104ec7:	5b                   	pop    %ebx
  104ec8:	5e                   	pop    %esi
  104ec9:	5f                   	pop    %edi
  104eca:	5d                   	pop    %ebp
  104ecb:	c3                   	ret    
  104ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104ed0 <cpuid_subleaf>:

gcc_inline void
cpuid_subleaf(uint32_t leaf, uint32_t subleaf,
              uint32_t *eaxp, uint32_t *ebxp, uint32_t *ecxp, uint32_t *edxp)
{
  104ed0:	55                   	push   %ebp
  104ed1:	57                   	push   %edi
  104ed2:	56                   	push   %esi
  104ed3:	53                   	push   %ebx
  104ed4:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
  104ed8:	8b 6c 24 20          	mov    0x20(%esp),%ebp
  104edc:	8b 74 24 28          	mov    0x28(%esp),%esi
        uint32_t eax, ebx, ecx, edx;
        asm volatile("cpuid"
  104ee0:	8b 4c 24 18          	mov    0x18(%esp),%ecx
  104ee4:	8b 44 24 14          	mov    0x14(%esp),%eax
  104ee8:	0f a2                	cpuid  
                     : "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
                     : "a" (leaf), "c" (subleaf));
        if (eaxp)
  104eea:	85 ff                	test   %edi,%edi
  104eec:	74 02                	je     104ef0 <cpuid_subleaf+0x20>
                *eaxp = eax;
  104eee:	89 07                	mov    %eax,(%edi)
        if (ebxp)
  104ef0:	85 ed                	test   %ebp,%ebp
  104ef2:	74 03                	je     104ef7 <cpuid_subleaf+0x27>
                *ebxp = ebx;
  104ef4:	89 5d 00             	mov    %ebx,0x0(%ebp)
        if (ecxp)
  104ef7:	8b 44 24 24          	mov    0x24(%esp),%eax
  104efb:	85 c0                	test   %eax,%eax
  104efd:	74 06                	je     104f05 <cpuid_subleaf+0x35>
                *ecxp = ecx;
  104eff:	8b 44 24 24          	mov    0x24(%esp),%eax
  104f03:	89 08                	mov    %ecx,(%eax)
        if (edxp)
  104f05:	85 f6                	test   %esi,%esi
  104f07:	74 02                	je     104f0b <cpuid_subleaf+0x3b>
                *edxp = edx;
  104f09:	89 16                	mov    %edx,(%esi)
}
  104f0b:	5b                   	pop    %ebx
  104f0c:	5e                   	pop    %esi
  104f0d:	5f                   	pop    %edi
  104f0e:	5d                   	pop    %ebp
  104f0f:	c3                   	ret    

00104f10 <vendor>:


gcc_inline cpu_vendor
vendor()
{
  104f10:	53                   	push   %ebx
gcc_inline void
cpuid(uint32_t info,
      uint32_t *eaxp, uint32_t *ebxp, uint32_t *ecxp, uint32_t *edxp)
{
	uint32_t eax, ebx, ecx, edx;
	__asm __volatile("cpuid"
  104f11:	31 c0                	xor    %eax,%eax
}


gcc_inline cpu_vendor
vendor()
{
  104f13:	83 ec 28             	sub    $0x28,%esp
gcc_inline void
cpuid(uint32_t info,
      uint32_t *eaxp, uint32_t *ebxp, uint32_t *ecxp, uint32_t *edxp)
{
	uint32_t eax, ebx, ecx, edx;
	__asm __volatile("cpuid"
  104f16:	0f a2                	cpuid  
{
    uint32_t eax, ebx, ecx, edx;
    char cpuvendor[13];

    cpuid(0x0, &eax, &ebx, &ecx, &edx);
    ((uint32_t *) cpuvendor)[0] = ebx;
  104f18:	89 5c 24 13          	mov    %ebx,0x13(%esp)
    ((uint32_t *) cpuvendor)[1] = edx;
    ((uint32_t *) cpuvendor)[2] = ecx;
    cpuvendor[12] = '\0';

    if (strncmp(cpuvendor, "GenuineIntel", 20) == 0)
  104f1c:	8d 5c 24 13          	lea    0x13(%esp),%ebx
  104f20:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
  104f27:	00 
  104f28:	c7 44 24 04 63 b5 10 	movl   $0x10b563,0x4(%esp)
  104f2f:	00 
  104f30:	89 1c 24             	mov    %ebx,(%esp)
    uint32_t eax, ebx, ecx, edx;
    char cpuvendor[13];

    cpuid(0x0, &eax, &ebx, &ecx, &edx);
    ((uint32_t *) cpuvendor)[0] = ebx;
    ((uint32_t *) cpuvendor)[1] = edx;
  104f33:	89 54 24 17          	mov    %edx,0x17(%esp)
    ((uint32_t *) cpuvendor)[2] = ecx;
  104f37:	89 4c 24 1b          	mov    %ecx,0x1b(%esp)
    cpuvendor[12] = '\0';
  104f3b:	c6 44 24 1f 00       	movb   $0x0,0x1f(%esp)

    if (strncmp(cpuvendor, "GenuineIntel", 20) == 0)
  104f40:	e8 0b ef ff ff       	call   103e50 <strncmp>
        return INTEL;
  104f45:	ba 01 00 00 00       	mov    $0x1,%edx
    ((uint32_t *) cpuvendor)[0] = ebx;
    ((uint32_t *) cpuvendor)[1] = edx;
    ((uint32_t *) cpuvendor)[2] = ecx;
    cpuvendor[12] = '\0';

    if (strncmp(cpuvendor, "GenuineIntel", 20) == 0)
  104f4a:	85 c0                	test   %eax,%eax
  104f4c:	74 20                	je     104f6e <vendor+0x5e>
        return INTEL;
    else if (strncmp(cpuvendor, "AuthenticAMD", 20) == 0)
  104f4e:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
  104f55:	00 
  104f56:	c7 44 24 04 70 b5 10 	movl   $0x10b570,0x4(%esp)
  104f5d:	00 
  104f5e:	89 1c 24             	mov    %ebx,(%esp)
  104f61:	e8 ea ee ff ff       	call   103e50 <strncmp>
        return AMD;
  104f66:	83 f8 01             	cmp    $0x1,%eax
  104f69:	19 d2                	sbb    %edx,%edx
  104f6b:	83 e2 02             	and    $0x2,%edx
    else
        return UNKNOWN_CPU;
}
  104f6e:	83 c4 28             	add    $0x28,%esp
  104f71:	89 d0                	mov    %edx,%eax
  104f73:	5b                   	pop    %ebx
  104f74:	c3                   	ret    
  104f75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104f80 <rcr3>:

gcc_inline uint32_t
rcr3(void)
{
    uint32_t val;
    __asm __volatile("movl %%cr3,%0" : "=r" (val));
  104f80:	0f 20 d8             	mov    %cr3,%eax
    return val;
}
  104f83:	c3                   	ret    
  104f84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104f8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00104f90 <outl>:

gcc_inline void
outl(int port, uint32_t data)
{
	__asm __volatile("outl %0,%w1" : : "a" (data), "d" (port));
  104f90:	8b 44 24 08          	mov    0x8(%esp),%eax
  104f94:	8b 54 24 04          	mov    0x4(%esp),%edx
  104f98:	ef                   	out    %eax,(%dx)
  104f99:	c3                   	ret    
  104f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104fa0 <inl>:

gcc_inline uint32_t
inl(int port)
{
	uint32_t data;
	__asm __volatile("inl %w1,%0" : "=a" (data) : "d" (port));
  104fa0:	8b 54 24 04          	mov    0x4(%esp),%edx
  104fa4:	ed                   	in     (%dx),%eax
	return data;
}
  104fa5:	c3                   	ret    
  104fa6:	8d 76 00             	lea    0x0(%esi),%esi
  104fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104fb0 <smp_wmb>:

gcc_inline void
smp_wmb(void)
{
	__asm __volatile("":::"memory");
  104fb0:	c3                   	ret    
  104fb1:	eb 0d                	jmp    104fc0 <ltr>
  104fb3:	90                   	nop
  104fb4:	90                   	nop
  104fb5:	90                   	nop
  104fb6:	90                   	nop
  104fb7:	90                   	nop
  104fb8:	90                   	nop
  104fb9:	90                   	nop
  104fba:	90                   	nop
  104fbb:	90                   	nop
  104fbc:	90                   	nop
  104fbd:	90                   	nop
  104fbe:	90                   	nop
  104fbf:	90                   	nop

00104fc0 <ltr>:


gcc_inline void
ltr(uint16_t sel)
{
	__asm __volatile("ltr %0" : : "r" (sel));
  104fc0:	8b 44 24 04          	mov    0x4(%esp),%eax
  104fc4:	0f 00 d8             	ltr    %ax
  104fc7:	c3                   	ret    
  104fc8:	90                   	nop
  104fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104fd0 <lcr0>:
}

gcc_inline void
lcr0(uint32_t val)
{
	__asm __volatile("movl %0,%%cr0" : : "r" (val));
  104fd0:	8b 44 24 04          	mov    0x4(%esp),%eax
  104fd4:	0f 22 c0             	mov    %eax,%cr0
  104fd7:	c3                   	ret    
  104fd8:	90                   	nop
  104fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104fe0 <rcr0>:

gcc_inline uint32_t
rcr0(void)
{
	uint32_t val;
	__asm __volatile("movl %%cr0,%0" : "=r" (val));
  104fe0:	0f 20 c0             	mov    %cr0,%eax
	return val;
}
  104fe3:	c3                   	ret    
  104fe4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104fea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00104ff0 <rcr2>:

gcc_inline uint32_t
rcr2(void)
{
	uint32_t val;
	__asm __volatile("movl %%cr2,%0" : "=r" (val));
  104ff0:	0f 20 d0             	mov    %cr2,%eax
	return val;
}
  104ff3:	c3                   	ret    
  104ff4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104ffa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105000 <lcr3>:

gcc_inline void
lcr3(uint32_t val)
{
	__asm __volatile("movl %0,%%cr3" : : "r" (val));
  105000:	8b 44 24 04          	mov    0x4(%esp),%eax
  105004:	0f 22 d8             	mov    %eax,%cr3
  105007:	c3                   	ret    
  105008:	90                   	nop
  105009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00105010 <lcr4>:
}

gcc_inline void
lcr4(uint32_t val)
{
	__asm __volatile("movl %0,%%cr4" : : "r" (val));
  105010:	8b 44 24 04          	mov    0x4(%esp),%eax
  105014:	0f 22 e0             	mov    %eax,%cr4
  105017:	c3                   	ret    
  105018:	90                   	nop
  105019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00105020 <rcr4>:

gcc_inline uint32_t
rcr4(void)
{
	uint32_t cr4;
	__asm __volatile("movl %%cr4,%0" : "=r" (cr4));
  105020:	0f 20 e0             	mov    %cr4,%eax
	return cr4;
}
  105023:	c3                   	ret    
  105024:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10502a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105030 <inb>:

gcc_inline uint8_t
inb(int port)
{
	uint8_t data;
	__asm __volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  105030:	8b 54 24 04          	mov    0x4(%esp),%edx
  105034:	ec                   	in     (%dx),%al
	return data;
}
  105035:	c3                   	ret    
  105036:	8d 76 00             	lea    0x0(%esi),%esi
  105039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105040 <insl>:

gcc_inline void
insl(int port, void *addr, int cnt)
{
  105040:	57                   	push   %edi
	__asm __volatile("cld\n\trepne\n\tinsl"                 :
  105041:	8b 7c 24 0c          	mov    0xc(%esp),%edi
  105045:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  105049:	8b 54 24 08          	mov    0x8(%esp),%edx
  10504d:	fc                   	cld    
  10504e:	f2 6d                	repnz insl (%dx),%es:(%edi)
			 "=D" (addr), "=c" (cnt)                :
			 "d" (port), "0" (addr), "1" (cnt)      :
			 "memory", "cc");
}
  105050:	5f                   	pop    %edi
  105051:	c3                   	ret    
  105052:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105060 <outb>:

gcc_inline void
outb(int port, uint8_t data)
{
	__asm __volatile("outb %0,%w1" : : "a" (data), "d" (port));
  105060:	8b 44 24 08          	mov    0x8(%esp),%eax
  105064:	8b 54 24 04          	mov    0x4(%esp),%edx
  105068:	ee                   	out    %al,(%dx)
  105069:	c3                   	ret    
  10506a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00105070 <outsw>:
}

gcc_inline void
outsw(int port, const void *addr, int cnt)
{
  105070:	56                   	push   %esi
	__asm __volatile("cld\n\trepne\n\toutsw"                :
  105071:	8b 74 24 0c          	mov    0xc(%esp),%esi
  105075:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  105079:	8b 54 24 08          	mov    0x8(%esp),%edx
  10507d:	fc                   	cld    
  10507e:	f2 66 6f             	repnz outsw %ds:(%esi),(%dx)
			 "=S" (addr), "=c" (cnt)                :
			 "d" (port), "0" (addr), "1" (cnt)      :
			 "cc");
}
  105081:	5e                   	pop    %esi
  105082:	c3                   	ret    
  105083:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105090 <outsl>:

gcc_inline void
outsl(int port, const void *addr, int cnt)
{
  105090:	56                   	push   %esi
	__asm __volatile("cld\n\trepne\n\toutsl"                :
  105091:	8b 74 24 0c          	mov    0xc(%esp),%esi
  105095:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  105099:	8b 54 24 08          	mov    0x8(%esp),%edx
  10509d:	fc                   	cld    
  10509e:	f2 6f                	repnz outsl %ds:(%esi),(%dx)
			 "=S" (addr), "=c" (cnt)                :
			 "d" (port), "0" (addr), "1" (cnt)      :
			 "cc");
}
  1050a0:	5e                   	pop    %esi
  1050a1:	c3                   	ret    
  1050a2:	66 90                	xchg   %ax,%ax
  1050a4:	66 90                	xchg   %ax,%ax
  1050a6:	66 90                	xchg   %ax,%ax
  1050a8:	66 90                	xchg   %ax,%ax
  1050aa:	66 90                	xchg   %ax,%ax
  1050ac:	66 90                	xchg   %ax,%ax
  1050ae:	66 90                	xchg   %ax,%ax

001050b0 <mon_help>:

/***** Implementations of basic kernel monitor commands *****/

int
mon_help (int argc, char **argv, struct Trapframe *tf)
{
  1050b0:	83 ec 1c             	sub    $0x1c,%esp
	int i;

	for (i = 0; i < NCOMMANDS; i++)
		dprintf("%s - %s\n", commands[i].name, commands[i].desc);
  1050b3:	c7 44 24 08 f0 bf 10 	movl   $0x10bff0,0x8(%esp)
  1050ba:	00 
  1050bb:	c7 44 24 04 0e c0 10 	movl   $0x10c00e,0x4(%esp)
  1050c2:	00 
  1050c3:	c7 04 24 13 c0 10 00 	movl   $0x10c013,(%esp)
  1050ca:	e8 d1 f2 ff ff       	call   1043a0 <dprintf>
  1050cf:	c7 44 24 08 b8 c0 10 	movl   $0x10c0b8,0x8(%esp)
  1050d6:	00 
  1050d7:	c7 44 24 04 1c c0 10 	movl   $0x10c01c,0x4(%esp)
  1050de:	00 
  1050df:	c7 04 24 13 c0 10 00 	movl   $0x10c013,(%esp)
  1050e6:	e8 b5 f2 ff ff       	call   1043a0 <dprintf>
	return 0;
}
  1050eb:	31 c0                	xor    %eax,%eax
  1050ed:	83 c4 1c             	add    $0x1c,%esp
  1050f0:	c3                   	ret    
  1050f1:	eb 0d                	jmp    105100 <mon_kerninfo>
  1050f3:	90                   	nop
  1050f4:	90                   	nop
  1050f5:	90                   	nop
  1050f6:	90                   	nop
  1050f7:	90                   	nop
  1050f8:	90                   	nop
  1050f9:	90                   	nop
  1050fa:	90                   	nop
  1050fb:	90                   	nop
  1050fc:	90                   	nop
  1050fd:	90                   	nop
  1050fe:	90                   	nop
  1050ff:	90                   	nop

00105100 <mon_kerninfo>:

int
mon_kerninfo (int argc, char **argv, struct Trapframe *tf)
{
  105100:	83 ec 1c             	sub    $0x1c,%esp
	extern uint8_t start[], etext[], edata[], end[];

	dprintf("Special kernel symbols:\n");
  105103:	c7 04 24 25 c0 10 00 	movl   $0x10c025,(%esp)
  10510a:	e8 91 f2 ff ff       	call   1043a0 <dprintf>
	dprintf("  start  %08x\n", start);
  10510f:	c7 44 24 04 a4 5e 10 	movl   $0x105ea4,0x4(%esp)
  105116:	00 
  105117:	c7 04 24 3e c0 10 00 	movl   $0x10c03e,(%esp)
  10511e:	e8 7d f2 ff ff       	call   1043a0 <dprintf>
	dprintf("  etext  %08x\n", etext);
  105123:	c7 44 24 04 57 ab 10 	movl   $0x10ab57,0x4(%esp)
  10512a:	00 
  10512b:	c7 04 24 4d c0 10 00 	movl   $0x10c04d,(%esp)
  105132:	e8 69 f2 ff ff       	call   1043a0 <dprintf>
	dprintf("  edata  %08x\n", edata);
  105137:	c7 44 24 04 66 ee 13 	movl   $0x13ee66,0x4(%esp)
  10513e:	00 
  10513f:	c7 04 24 5c c0 10 00 	movl   $0x10c05c,(%esp)
  105146:	e8 55 f2 ff ff       	call   1043a0 <dprintf>
	dprintf("  end    %08x\n", end);
  10514b:	c7 44 24 04 d0 52 e1 	movl   $0xe152d0,0x4(%esp)
  105152:	00 
  105153:	c7 04 24 6b c0 10 00 	movl   $0x10c06b,(%esp)
  10515a:	e8 41 f2 ff ff       	call   1043a0 <dprintf>
	dprintf("Kernel executable memory footprint: %dKB\n",
		ROUNDUP(end - start, 1024) / 1024);
  10515f:	ba d0 52 e1 00       	mov    $0xe152d0,%edx
  105164:	81 ea a5 5a 10 00    	sub    $0x105aa5,%edx
  10516a:	89 d1                	mov    %edx,%ecx
  10516c:	c1 f9 1f             	sar    $0x1f,%ecx
  10516f:	c1 e9 16             	shr    $0x16,%ecx
  105172:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
  105175:	25 ff 03 00 00       	and    $0x3ff,%eax
  10517a:	29 c8                	sub    %ecx,%eax
  10517c:	29 c2                	sub    %eax,%edx
	dprintf("Special kernel symbols:\n");
	dprintf("  start  %08x\n", start);
	dprintf("  etext  %08x\n", etext);
	dprintf("  edata  %08x\n", edata);
	dprintf("  end    %08x\n", end);
	dprintf("Kernel executable memory footprint: %dKB\n",
  10517e:	85 d2                	test   %edx,%edx
  105180:	8d 82 ff 03 00 00    	lea    0x3ff(%edx),%eax
  105186:	0f 48 d0             	cmovs  %eax,%edx
  105189:	c1 fa 0a             	sar    $0xa,%edx
  10518c:	89 54 24 04          	mov    %edx,0x4(%esp)
  105190:	c7 04 24 e0 c0 10 00 	movl   $0x10c0e0,(%esp)
  105197:	e8 04 f2 ff ff       	call   1043a0 <dprintf>
		ROUNDUP(end - start, 1024) / 1024);
	return 0;
}
  10519c:	31 c0                	xor    %eax,%eax
  10519e:	83 c4 1c             	add    $0x1c,%esp
  1051a1:	c3                   	ret    
  1051a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1051a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001051b0 <monitor>:
	return 0;
}

void
monitor (struct Trapframe *tf)
{
  1051b0:	55                   	push   %ebp
  1051b1:	57                   	push   %edi
  1051b2:	56                   	push   %esi
  1051b3:	53                   	push   %ebx
  1051b4:	83 ec 5c             	sub    $0x5c,%esp
	char *buf;

	dprintf("\n****************************************\n\n");
  1051b7:	c7 04 24 0c c1 10 00 	movl   $0x10c10c,(%esp)
  1051be:	8d 7c 24 10          	lea    0x10(%esp),%edi
  1051c2:	e8 d9 f1 ff ff       	call   1043a0 <dprintf>
	dprintf("Welcome to the mCertiKOS kernel monitor!\n");
  1051c7:	c7 04 24 38 c1 10 00 	movl   $0x10c138,(%esp)
  1051ce:	e8 cd f1 ff ff       	call   1043a0 <dprintf>
	dprintf("\n****************************************\n\n");
  1051d3:	c7 04 24 0c c1 10 00 	movl   $0x10c10c,(%esp)
  1051da:	e8 c1 f1 ff ff       	call   1043a0 <dprintf>
	dprintf("Type 'help' for a list of commands.\n");
  1051df:	c7 04 24 64 c1 10 00 	movl   $0x10c164,(%esp)
  1051e6:	e8 b5 f1 ff ff       	call   1043a0 <dprintf>
  1051eb:	90                   	nop
  1051ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

	while (1)
	{
		buf = (char *) readline ("$> ");
  1051f0:	c7 04 24 7a c0 10 00 	movl   $0x10c07a,(%esp)
  1051f7:	e8 94 b2 ff ff       	call   100490 <readline>
		if (buf != NULL)
  1051fc:	85 c0                	test   %eax,%eax
	dprintf("\n****************************************\n\n");
	dprintf("Type 'help' for a list of commands.\n");

	while (1)
	{
		buf = (char *) readline ("$> ");
  1051fe:	89 c3                	mov    %eax,%ebx
		if (buf != NULL)
  105200:	74 ee                	je     1051f0 <monitor+0x40>
	char *argv[MAXARGS];
	int i;

	// Parse the command buffer into whitespace-separated arguments
	argc = 0;
	argv[argc] = 0;
  105202:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  105209:	00 
  10520a:	0f be 00             	movsbl (%eax),%eax
	int argc;
	char *argv[MAXARGS];
	int i;

	// Parse the command buffer into whitespace-separated arguments
	argc = 0;
  10520d:	31 ed                	xor    %ebp,%ebp
  10520f:	90                   	nop
	argv[argc] = 0;
	while (1)
	{
		// gobble whitespace
		while (*buf && strchr (WHITESPACE, *buf))
  105210:	84 c0                	test   %al,%al
  105212:	75 5c                	jne    105270 <monitor+0xc0>
			buf++;
	}
	argv[argc] = 0;

	// Lookup and invoke the command
	if (argc == 0)
  105214:	85 ed                	test   %ebp,%ebp
		}
		argv[argc++] = buf;
		while (*buf && !strchr (WHITESPACE, *buf))
			buf++;
	}
	argv[argc] = 0;
  105216:	c7 44 ac 10 00 00 00 	movl   $0x0,0x10(%esp,%ebp,4)
  10521d:	00 

	// Lookup and invoke the command
	if (argc == 0)
  10521e:	74 d0                	je     1051f0 <monitor+0x40>
		return 0;
	for (i = 0; i < NCOMMANDS; i++)
	{
		if (strcmp (argv[0], commands[i].name) == 0)
  105220:	8b 44 24 10          	mov    0x10(%esp),%eax
  105224:	c7 44 24 04 0e c0 10 	movl   $0x10c00e,0x4(%esp)
  10522b:	00 
  10522c:	89 04 24             	mov    %eax,(%esp)
  10522f:	e8 cc ec ff ff       	call   103f00 <strcmp>
  105234:	85 c0                	test   %eax,%eax
  105236:	0f 84 b9 00 00 00    	je     1052f5 <monitor+0x145>
  10523c:	8b 44 24 10          	mov    0x10(%esp),%eax
  105240:	c7 44 24 04 1c c0 10 	movl   $0x10c01c,0x4(%esp)
  105247:	00 
  105248:	89 04 24             	mov    %eax,(%esp)
  10524b:	e8 b0 ec ff ff       	call   103f00 <strcmp>
  105250:	85 c0                	test   %eax,%eax
  105252:	0f 84 ca 00 00 00    	je     105322 <monitor+0x172>
			return commands[i].func (argc, argv, tf);
	}
	dprintf("Unknown command '%s'\n", argv[0]);
  105258:	8b 44 24 10          	mov    0x10(%esp),%eax
  10525c:	c7 04 24 a0 c0 10 00 	movl   $0x10c0a0,(%esp)
  105263:	89 44 24 04          	mov    %eax,0x4(%esp)
  105267:	e8 34 f1 ff ff       	call   1043a0 <dprintf>
  10526c:	eb 82                	jmp    1051f0 <monitor+0x40>
  10526e:	66 90                	xchg   %ax,%ax
	argc = 0;
	argv[argc] = 0;
	while (1)
	{
		// gobble whitespace
		while (*buf && strchr (WHITESPACE, *buf))
  105270:	89 44 24 04          	mov    %eax,0x4(%esp)
  105274:	c7 04 24 7e c0 10 00 	movl   $0x10c07e,(%esp)
  10527b:	e8 d0 ec ff ff       	call   103f50 <strchr>
  105280:	85 c0                	test   %eax,%eax
  105282:	75 44                	jne    1052c8 <monitor+0x118>
			*buf++ = 0;
		if (*buf == 0)
  105284:	80 3b 00             	cmpb   $0x0,(%ebx)
  105287:	74 8b                	je     105214 <monitor+0x64>
			break;

		// save and scan past next arg
		if (argc == MAXARGS - 1)
  105289:	83 fd 0f             	cmp    $0xf,%ebp
  10528c:	74 4e                	je     1052dc <monitor+0x12c>
		{
			dprintf("Too many arguments (max %d)\n", MAXARGS);
			return 0;
		}
		argv[argc++] = buf;
  10528e:	89 5c ac 10          	mov    %ebx,0x10(%esp,%ebp,4)
		while (*buf && !strchr (WHITESPACE, *buf))
  105292:	0f be 03             	movsbl (%ebx),%eax
		if (argc == MAXARGS - 1)
		{
			dprintf("Too many arguments (max %d)\n", MAXARGS);
			return 0;
		}
		argv[argc++] = buf;
  105295:	8d 75 01             	lea    0x1(%ebp),%esi
		while (*buf && !strchr (WHITESPACE, *buf))
  105298:	84 c0                	test   %al,%al
  10529a:	75 0e                	jne    1052aa <monitor+0xfa>
  10529c:	eb 23                	jmp    1052c1 <monitor+0x111>
  10529e:	66 90                	xchg   %ax,%ax
			buf++;
  1052a0:	83 c3 01             	add    $0x1,%ebx
		{
			dprintf("Too many arguments (max %d)\n", MAXARGS);
			return 0;
		}
		argv[argc++] = buf;
		while (*buf && !strchr (WHITESPACE, *buf))
  1052a3:	0f be 03             	movsbl (%ebx),%eax
  1052a6:	84 c0                	test   %al,%al
  1052a8:	74 17                	je     1052c1 <monitor+0x111>
  1052aa:	89 44 24 04          	mov    %eax,0x4(%esp)
  1052ae:	c7 04 24 7e c0 10 00 	movl   $0x10c07e,(%esp)
  1052b5:	e8 96 ec ff ff       	call   103f50 <strchr>
  1052ba:	85 c0                	test   %eax,%eax
  1052bc:	74 e2                	je     1052a0 <monitor+0xf0>
  1052be:	0f be 03             	movsbl (%ebx),%eax
	argv[argc] = 0;
	while (1)
	{
		// gobble whitespace
		while (*buf && strchr (WHITESPACE, *buf))
			*buf++ = 0;
  1052c1:	89 f5                	mov    %esi,%ebp
  1052c3:	e9 48 ff ff ff       	jmp    105210 <monitor+0x60>
  1052c8:	89 ee                	mov    %ebp,%esi
  1052ca:	0f be 43 01          	movsbl 0x1(%ebx),%eax
  1052ce:	83 c3 01             	add    $0x1,%ebx
  1052d1:	c6 43 ff 00          	movb   $0x0,-0x1(%ebx)
  1052d5:	89 f5                	mov    %esi,%ebp
  1052d7:	e9 34 ff ff ff       	jmp    105210 <monitor+0x60>
			break;

		// save and scan past next arg
		if (argc == MAXARGS - 1)
		{
			dprintf("Too many arguments (max %d)\n", MAXARGS);
  1052dc:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  1052e3:	00 
  1052e4:	c7 04 24 83 c0 10 00 	movl   $0x10c083,(%esp)
  1052eb:	e8 b0 f0 ff ff       	call   1043a0 <dprintf>
  1052f0:	e9 fb fe ff ff       	jmp    1051f0 <monitor+0x40>
	// Lookup and invoke the command
	if (argc == 0)
		return 0;
	for (i = 0; i < NCOMMANDS; i++)
	{
		if (strcmp (argv[0], commands[i].name) == 0)
  1052f5:	31 c0                	xor    %eax,%eax
			return commands[i].func (argc, argv, tf);
  1052f7:	8b 4c 24 70          	mov    0x70(%esp),%ecx
  1052fb:	8d 14 00             	lea    (%eax,%eax,1),%edx
  1052fe:	01 d0                	add    %edx,%eax
  105300:	89 7c 24 04          	mov    %edi,0x4(%esp)
  105304:	89 2c 24             	mov    %ebp,(%esp)
  105307:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  10530b:	ff 14 85 94 c1 10 00 	call   *0x10c194(,%eax,4)

	while (1)
	{
		buf = (char *) readline ("$> ");
		if (buf != NULL)
			if (runcmd (buf, tf) < 0)
  105312:	85 c0                	test   %eax,%eax
  105314:	0f 89 d6 fe ff ff    	jns    1051f0 <monitor+0x40>
				break;
	}
}
  10531a:	83 c4 5c             	add    $0x5c,%esp
  10531d:	5b                   	pop    %ebx
  10531e:	5e                   	pop    %esi
  10531f:	5f                   	pop    %edi
  105320:	5d                   	pop    %ebp
  105321:	c3                   	ret    
	argv[argc] = 0;

	// Lookup and invoke the command
	if (argc == 0)
		return 0;
	for (i = 0; i < NCOMMANDS; i++)
  105322:	b0 01                	mov    $0x1,%al
  105324:	eb d1                	jmp    1052f7 <monitor+0x147>
  105326:	66 90                	xchg   %ax,%ax
  105328:	66 90                	xchg   %ax,%ax
  10532a:	66 90                	xchg   %ax,%ax
  10532c:	66 90                	xchg   %ax,%ax
  10532e:	66 90                	xchg   %ax,%ax

00105330 <pt_copyin>:
extern void alloc_page(unsigned int pid, unsigned int vaddr, unsigned int perm);
extern unsigned int get_ptbl_entry_by_va(unsigned int pid, unsigned int vaddr);

size_t
pt_copyin(uint32_t pmap_id, uintptr_t uva, void *kva, size_t len)
{
  105330:	55                   	push   %ebp
	if (!(VM_USERLO <= uva && uva + len <= VM_USERHI))
		return 0;
  105331:	31 c0                	xor    %eax,%eax
extern void alloc_page(unsigned int pid, unsigned int vaddr, unsigned int perm);
extern unsigned int get_ptbl_entry_by_va(unsigned int pid, unsigned int vaddr);

size_t
pt_copyin(uint32_t pmap_id, uintptr_t uva, void *kva, size_t len)
{
  105333:	57                   	push   %edi
  105334:	56                   	push   %esi
  105335:	53                   	push   %ebx
  105336:	83 ec 1c             	sub    $0x1c,%esp
  105339:	8b 74 24 34          	mov    0x34(%esp),%esi
  10533d:	8b 7c 24 38          	mov    0x38(%esp),%edi
  105341:	8b 5c 24 3c          	mov    0x3c(%esp),%ebx
	if (!(VM_USERLO <= uva && uva + len <= VM_USERHI))
  105345:	81 fe ff ff ff 3f    	cmp    $0x3fffffff,%esi
  10534b:	0f 86 bb 00 00 00    	jbe    10540c <pt_copyin+0xdc>
  105351:	8d 14 1e             	lea    (%esi,%ebx,1),%edx
  105354:	81 fa 00 00 00 f0    	cmp    $0xf0000000,%edx
  10535a:	0f 87 ac 00 00 00    	ja     10540c <pt_copyin+0xdc>
		return 0;

	if ((uintptr_t) kva + len > VM_USERHI)
  105360:	8d 14 1f             	lea    (%edi,%ebx,1),%edx
  105363:	81 fa 00 00 00 f0    	cmp    $0xf0000000,%edx
  105369:	0f 87 9d 00 00 00    	ja     10540c <pt_copyin+0xdc>
		return 0;

	size_t copied = 0;

	while (len) {
  10536f:	85 db                	test   %ebx,%ebx
  105371:	0f 84 95 00 00 00    	je     10540c <pt_copyin+0xdc>
  105377:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  10537e:	00 
  10537f:	eb 42                	jmp    1053c3 <pt_copyin+0x93>
  105381:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		if ((uva_pa & PTE_P) == 0) {
			alloc_page(pmap_id, uva, PTE_P | PTE_U | PTE_W);
			uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
		}

		uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  105388:	89 f2                	mov    %esi,%edx

		size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
			len : PAGESIZE - uva_pa % PAGESIZE;
  10538a:	b9 00 10 00 00       	mov    $0x1000,%ecx
		if ((uva_pa & PTE_P) == 0) {
			alloc_page(pmap_id, uva, PTE_P | PTE_U | PTE_W);
			uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
		}

		uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  10538f:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
  105395:	25 00 f0 ff ff       	and    $0xfffff000,%eax

		size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
			len : PAGESIZE - uva_pa % PAGESIZE;
  10539a:	29 d1                	sub    %edx,%ecx
  10539c:	01 d0                	add    %edx,%eax
			uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
		}

		uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);

		size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  10539e:	39 d9                	cmp    %ebx,%ecx
			len : PAGESIZE - uva_pa % PAGESIZE;
  1053a0:	89 ca                	mov    %ecx,%edx
			uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
		}

		uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);

		size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  1053a2:	0f 47 d3             	cmova  %ebx,%edx
  1053a5:	89 d5                	mov    %edx,%ebp
			len : PAGESIZE - uva_pa % PAGESIZE;

		memcpy(kva, (void *) uva_pa, size);
  1053a7:	89 3c 24             	mov    %edi,(%esp)

		len -= size;
		uva += size;
  1053aa:	01 ee                	add    %ebp,%esi
		kva += size;
  1053ac:	01 ef                	add    %ebp,%edi
		uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);

		size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
			len : PAGESIZE - uva_pa % PAGESIZE;

		memcpy(kva, (void *) uva_pa, size);
  1053ae:	89 54 24 08          	mov    %edx,0x8(%esp)
  1053b2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1053b6:	e8 85 ea ff ff       	call   103e40 <memcpy>

		len -= size;
		uva += size;
		kva += size;
		copied += size;
  1053bb:	01 6c 24 0c          	add    %ebp,0xc(%esp)
	if ((uintptr_t) kva + len > VM_USERHI)
		return 0;

	size_t copied = 0;

	while (len) {
  1053bf:	29 eb                	sub    %ebp,%ebx
  1053c1:	74 45                	je     105408 <pt_copyin+0xd8>
		uintptr_t uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
  1053c3:	8b 44 24 30          	mov    0x30(%esp),%eax
  1053c7:	89 74 24 04          	mov    %esi,0x4(%esp)
  1053cb:	89 04 24             	mov    %eax,(%esp)
  1053ce:	e8 bd 11 00 00       	call   106590 <get_ptbl_entry_by_va>

		if ((uva_pa & PTE_P) == 0) {
  1053d3:	a8 01                	test   $0x1,%al
  1053d5:	75 b1                	jne    105388 <pt_copyin+0x58>
			alloc_page(pmap_id, uva, PTE_P | PTE_U | PTE_W);
  1053d7:	8b 44 24 30          	mov    0x30(%esp),%eax
  1053db:	c7 44 24 08 07 00 00 	movl   $0x7,0x8(%esp)
  1053e2:	00 
  1053e3:	89 74 24 04          	mov    %esi,0x4(%esp)
  1053e7:	89 04 24             	mov    %eax,(%esp)
  1053ea:	e8 81 15 00 00       	call   106970 <alloc_page>
			uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
  1053ef:	8b 44 24 30          	mov    0x30(%esp),%eax
  1053f3:	89 74 24 04          	mov    %esi,0x4(%esp)
  1053f7:	89 04 24             	mov    %eax,(%esp)
  1053fa:	e8 91 11 00 00       	call   106590 <get_ptbl_entry_by_va>
  1053ff:	eb 87                	jmp    105388 <pt_copyin+0x58>
  105401:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		memcpy(kva, (void *) uva_pa, size);

		len -= size;
		uva += size;
		kva += size;
		copied += size;
  105408:	8b 44 24 0c          	mov    0xc(%esp),%eax
	}

	return copied;
}
  10540c:	83 c4 1c             	add    $0x1c,%esp
  10540f:	5b                   	pop    %ebx
  105410:	5e                   	pop    %esi
  105411:	5f                   	pop    %edi
  105412:	5d                   	pop    %ebp
  105413:	c3                   	ret    
  105414:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10541a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105420 <pt_copyout>:

size_t
pt_copyout(void *kva, uint32_t pmap_id, uintptr_t uva, size_t len)
{
  105420:	55                   	push   %ebp
	if (!(VM_USERLO <= uva && uva + len <= VM_USERHI))
		return 0;
  105421:	31 c0                	xor    %eax,%eax
	return copied;
}

size_t
pt_copyout(void *kva, uint32_t pmap_id, uintptr_t uva, size_t len)
{
  105423:	57                   	push   %edi
  105424:	56                   	push   %esi
  105425:	53                   	push   %ebx
  105426:	83 ec 1c             	sub    $0x1c,%esp
  105429:	8b 74 24 38          	mov    0x38(%esp),%esi
  10542d:	8b 7c 24 30          	mov    0x30(%esp),%edi
  105431:	8b 5c 24 3c          	mov    0x3c(%esp),%ebx
	if (!(VM_USERLO <= uva && uva + len <= VM_USERHI))
  105435:	81 fe ff ff ff 3f    	cmp    $0x3fffffff,%esi
  10543b:	0f 86 bb 00 00 00    	jbe    1054fc <pt_copyout+0xdc>
  105441:	8d 14 1e             	lea    (%esi,%ebx,1),%edx
  105444:	81 fa 00 00 00 f0    	cmp    $0xf0000000,%edx
  10544a:	0f 87 ac 00 00 00    	ja     1054fc <pt_copyout+0xdc>
		return 0;

	if ((uintptr_t) kva + len > VM_USERHI)
  105450:	8d 14 1f             	lea    (%edi,%ebx,1),%edx
  105453:	81 fa 00 00 00 f0    	cmp    $0xf0000000,%edx
  105459:	0f 87 9d 00 00 00    	ja     1054fc <pt_copyout+0xdc>
		return 0;

	size_t copied = 0;

	while (len) {
  10545f:	85 db                	test   %ebx,%ebx
  105461:	0f 84 95 00 00 00    	je     1054fc <pt_copyout+0xdc>
  105467:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  10546e:	00 
  10546f:	eb 42                	jmp    1054b3 <pt_copyout+0x93>
  105471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		if ((uva_pa & PTE_P) == 0) {
			alloc_page(pmap_id, uva, PTE_P | PTE_U | PTE_W);
			uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
		}

		uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  105478:	89 f2                	mov    %esi,%edx

		size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
			len : PAGESIZE - uva_pa % PAGESIZE;
  10547a:	b9 00 10 00 00       	mov    $0x1000,%ecx
		if ((uva_pa & PTE_P) == 0) {
			alloc_page(pmap_id, uva, PTE_P | PTE_U | PTE_W);
			uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
		}

		uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  10547f:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
  105485:	25 00 f0 ff ff       	and    $0xfffff000,%eax

		size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
			len : PAGESIZE - uva_pa % PAGESIZE;
  10548a:	29 d1                	sub    %edx,%ecx
  10548c:	01 d0                	add    %edx,%eax
			uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
		}

		uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);

		size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  10548e:	39 d9                	cmp    %ebx,%ecx
			len : PAGESIZE - uva_pa % PAGESIZE;
  105490:	89 ca                	mov    %ecx,%edx
			uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
		}

		uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);

		size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  105492:	0f 47 d3             	cmova  %ebx,%edx
  105495:	89 d5                	mov    %edx,%ebp
			len : PAGESIZE - uva_pa % PAGESIZE;

		memcpy((void *) uva_pa, kva, size);
  105497:	89 7c 24 04          	mov    %edi,0x4(%esp)

		len -= size;
		uva += size;
  10549b:	01 ee                	add    %ebp,%esi
		kva += size;
  10549d:	01 ef                	add    %ebp,%edi
		uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);

		size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
			len : PAGESIZE - uva_pa % PAGESIZE;

		memcpy((void *) uva_pa, kva, size);
  10549f:	89 54 24 08          	mov    %edx,0x8(%esp)
  1054a3:	89 04 24             	mov    %eax,(%esp)
  1054a6:	e8 95 e9 ff ff       	call   103e40 <memcpy>

		len -= size;
		uva += size;
		kva += size;
		copied += size;
  1054ab:	01 6c 24 0c          	add    %ebp,0xc(%esp)
	if ((uintptr_t) kva + len > VM_USERHI)
		return 0;

	size_t copied = 0;

	while (len) {
  1054af:	29 eb                	sub    %ebp,%ebx
  1054b1:	74 45                	je     1054f8 <pt_copyout+0xd8>
		uintptr_t uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
  1054b3:	8b 44 24 34          	mov    0x34(%esp),%eax
  1054b7:	89 74 24 04          	mov    %esi,0x4(%esp)
  1054bb:	89 04 24             	mov    %eax,(%esp)
  1054be:	e8 cd 10 00 00       	call   106590 <get_ptbl_entry_by_va>

		if ((uva_pa & PTE_P) == 0) {
  1054c3:	a8 01                	test   $0x1,%al
  1054c5:	75 b1                	jne    105478 <pt_copyout+0x58>
			alloc_page(pmap_id, uva, PTE_P | PTE_U | PTE_W);
  1054c7:	8b 44 24 34          	mov    0x34(%esp),%eax
  1054cb:	c7 44 24 08 07 00 00 	movl   $0x7,0x8(%esp)
  1054d2:	00 
  1054d3:	89 74 24 04          	mov    %esi,0x4(%esp)
  1054d7:	89 04 24             	mov    %eax,(%esp)
  1054da:	e8 91 14 00 00       	call   106970 <alloc_page>
			uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
  1054df:	8b 44 24 34          	mov    0x34(%esp),%eax
  1054e3:	89 74 24 04          	mov    %esi,0x4(%esp)
  1054e7:	89 04 24             	mov    %eax,(%esp)
  1054ea:	e8 a1 10 00 00       	call   106590 <get_ptbl_entry_by_va>
  1054ef:	eb 87                	jmp    105478 <pt_copyout+0x58>
  1054f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		memcpy((void *) uva_pa, kva, size);

		len -= size;
		uva += size;
		kva += size;
		copied += size;
  1054f8:	8b 44 24 0c          	mov    0xc(%esp),%eax
	}

	return copied;
}
  1054fc:	83 c4 1c             	add    $0x1c,%esp
  1054ff:	5b                   	pop    %ebx
  105500:	5e                   	pop    %esi
  105501:	5f                   	pop    %edi
  105502:	5d                   	pop    %ebp
  105503:	c3                   	ret    
  105504:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10550a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105510 <pt_memset>:

size_t
pt_memset(uint32_t pmap_id, uintptr_t va, char c, size_t len)
{
  105510:	55                   	push   %ebp
  105511:	57                   	push   %edi
  105512:	56                   	push   %esi
  105513:	53                   	push   %ebx
  105514:	83 ec 1c             	sub    $0x1c,%esp
  105517:	8b 5c 24 3c          	mov    0x3c(%esp),%ebx
  10551b:	8b 74 24 34          	mov    0x34(%esp),%esi
  10551f:	8b 44 24 38          	mov    0x38(%esp),%eax
        size_t set = 0;

	while (len) {
  105523:	85 db                	test   %ebx,%ebx
  105525:	0f 84 86 00 00 00    	je     1055b1 <pt_memset+0xa1>
  10552b:	0f be c0             	movsbl %al,%eax
}

size_t
pt_memset(uint32_t pmap_id, uintptr_t va, char c, size_t len)
{
        size_t set = 0;
  10552e:	31 ff                	xor    %edi,%edi
  105530:	89 44 24 0c          	mov    %eax,0xc(%esp)
  105534:	eb 3d                	jmp    105573 <pt_memset+0x63>
  105536:	66 90                	xchg   %ax,%ax
		if ((pa & PTE_P) == 0) {
			alloc_page(pmap_id, va, PTE_P | PTE_U | PTE_W);
			pa = get_ptbl_entry_by_va(pmap_id, va);
		}

		pa = (pa & 0xfffff000) + (va % PAGESIZE);
  105538:	89 f2                	mov    %esi,%edx

		size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
			len : PAGESIZE - pa % PAGESIZE;
  10553a:	b9 00 10 00 00       	mov    $0x1000,%ecx
		if ((pa & PTE_P) == 0) {
			alloc_page(pmap_id, va, PTE_P | PTE_U | PTE_W);
			pa = get_ptbl_entry_by_va(pmap_id, va);
		}

		pa = (pa & 0xfffff000) + (va % PAGESIZE);
  10553f:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
  105545:	25 00 f0 ff ff       	and    $0xfffff000,%eax

		size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
			len : PAGESIZE - pa % PAGESIZE;
  10554a:	29 d1                	sub    %edx,%ecx
  10554c:	01 d0                	add    %edx,%eax
			pa = get_ptbl_entry_by_va(pmap_id, va);
		}

		pa = (pa & 0xfffff000) + (va % PAGESIZE);

		size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
  10554e:	39 d9                	cmp    %ebx,%ecx
			len : PAGESIZE - pa % PAGESIZE;
  105550:	89 ca                	mov    %ecx,%edx

		memset((void *) pa, c, size);
  105552:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
			pa = get_ptbl_entry_by_va(pmap_id, va);
		}

		pa = (pa & 0xfffff000) + (va % PAGESIZE);

		size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
  105556:	0f 47 d3             	cmova  %ebx,%edx
  105559:	89 d5                	mov    %edx,%ebp
			len : PAGESIZE - pa % PAGESIZE;

		memset((void *) pa, c, size);
  10555b:	89 54 24 08          	mov    %edx,0x8(%esp)

		len -= size;
		va += size;
  10555f:	01 ee                	add    %ebp,%esi
		set += size;
  105561:	01 ef                	add    %ebp,%edi
		pa = (pa & 0xfffff000) + (va % PAGESIZE);

		size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
			len : PAGESIZE - pa % PAGESIZE;

		memset((void *) pa, c, size);
  105563:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  105567:	89 04 24             	mov    %eax,(%esp)
  10556a:	e8 01 e8 ff ff       	call   103d70 <memset>
size_t
pt_memset(uint32_t pmap_id, uintptr_t va, char c, size_t len)
{
        size_t set = 0;

	while (len) {
  10556f:	29 eb                	sub    %ebp,%ebx
  105571:	74 45                	je     1055b8 <pt_memset+0xa8>
		uintptr_t pa = get_ptbl_entry_by_va(pmap_id, va);
  105573:	8b 44 24 30          	mov    0x30(%esp),%eax
  105577:	89 74 24 04          	mov    %esi,0x4(%esp)
  10557b:	89 04 24             	mov    %eax,(%esp)
  10557e:	e8 0d 10 00 00       	call   106590 <get_ptbl_entry_by_va>

		if ((pa & PTE_P) == 0) {
  105583:	a8 01                	test   $0x1,%al
  105585:	75 b1                	jne    105538 <pt_memset+0x28>
			alloc_page(pmap_id, va, PTE_P | PTE_U | PTE_W);
  105587:	8b 44 24 30          	mov    0x30(%esp),%eax
  10558b:	c7 44 24 08 07 00 00 	movl   $0x7,0x8(%esp)
  105592:	00 
  105593:	89 74 24 04          	mov    %esi,0x4(%esp)
  105597:	89 04 24             	mov    %eax,(%esp)
  10559a:	e8 d1 13 00 00       	call   106970 <alloc_page>
			pa = get_ptbl_entry_by_va(pmap_id, va);
  10559f:	8b 44 24 30          	mov    0x30(%esp),%eax
  1055a3:	89 74 24 04          	mov    %esi,0x4(%esp)
  1055a7:	89 04 24             	mov    %eax,(%esp)
  1055aa:	e8 e1 0f 00 00       	call   106590 <get_ptbl_entry_by_va>
  1055af:	eb 87                	jmp    105538 <pt_memset+0x28>
}

size_t
pt_memset(uint32_t pmap_id, uintptr_t va, char c, size_t len)
{
        size_t set = 0;
  1055b1:	31 ff                	xor    %edi,%edi
  1055b3:	90                   	nop
  1055b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		va += size;
		set += size;
	}

	return set;
}
  1055b8:	83 c4 1c             	add    $0x1c,%esp
  1055bb:	89 f8                	mov    %edi,%eax
  1055bd:	5b                   	pop    %ebx
  1055be:	5e                   	pop    %esi
  1055bf:	5f                   	pop    %edi
  1055c0:	5d                   	pop    %ebp
  1055c1:	c3                   	ret    
  1055c2:	66 90                	xchg   %ax,%ax
  1055c4:	66 90                	xchg   %ax,%ax
  1055c6:	66 90                	xchg   %ax,%ax
  1055c8:	66 90                	xchg   %ax,%ax
  1055ca:	66 90                	xchg   %ax,%ax
  1055cc:	66 90                	xchg   %ax,%ax
  1055ce:	66 90                	xchg   %ax,%ax

001055d0 <elf_load>:
/*
 * Load elf execution file exe to the virtual address space pmap.
 */
void
elf_load (void *exe_ptr, int pid)
{
  1055d0:	55                   	push   %ebp
  1055d1:	57                   	push   %edi
  1055d2:	56                   	push   %esi
  1055d3:	53                   	push   %ebx
  1055d4:	83 ec 3c             	sub    $0x3c,%esp
	char *strtab;
	uintptr_t exe = (uintptr_t) exe_ptr;

	eh = (elfhdr *) exe;

	KERN_ASSERT(eh->e_magic == ELF_MAGIC);
  1055d7:	8b 44 24 50          	mov    0x50(%esp),%eax
/*
 * Load elf execution file exe to the virtual address space pmap.
 */
void
elf_load (void *exe_ptr, int pid)
{
  1055db:	8b 7c 24 54          	mov    0x54(%esp),%edi
	char *strtab;
	uintptr_t exe = (uintptr_t) exe_ptr;

	eh = (elfhdr *) exe;

	KERN_ASSERT(eh->e_magic == ELF_MAGIC);
  1055df:	81 38 7f 45 4c 46    	cmpl   $0x464c457f,(%eax)
  1055e5:	74 24                	je     10560b <elf_load+0x3b>
  1055e7:	c7 44 24 0c a4 c1 10 	movl   $0x10c1a4,0xc(%esp)
  1055ee:	00 
  1055ef:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  1055f6:	00 
  1055f7:	c7 44 24 04 1e 00 00 	movl   $0x1e,0x4(%esp)
  1055fe:	00 
  1055ff:	c7 04 24 bd c1 10 00 	movl   $0x10c1bd,(%esp)
  105606:	e8 75 eb ff ff       	call   104180 <debug_panic>
	KERN_ASSERT(eh->e_shstrndx != ELF_SHN_UNDEF);
  10560b:	8b 44 24 50          	mov    0x50(%esp),%eax
  10560f:	0f b7 40 32          	movzwl 0x32(%eax),%eax
  105613:	66 85 c0             	test   %ax,%ax
  105616:	0f 84 dc 01 00 00    	je     1057f8 <elf_load+0x228>

	sh = (sechdr *) ((uintptr_t) eh + eh->e_shoff);
	esh = sh + eh->e_shnum;

	strtab = (char *) (exe + sh[eh->e_shstrndx].sh_offset);
	KERN_ASSERT(sh[eh->e_shstrndx].sh_type == ELF_SHT_STRTAB);
  10561c:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  105620:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105623:	8d 04 c1             	lea    (%ecx,%eax,8),%eax
  105626:	03 41 20             	add    0x20(%ecx),%eax
  105629:	83 78 04 03          	cmpl   $0x3,0x4(%eax)
  10562d:	74 24                	je     105653 <elf_load+0x83>
  10562f:	c7 44 24 0c ec c1 10 	movl   $0x10c1ec,0xc(%esp)
  105636:	00 
  105637:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  10563e:	00 
  10563f:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
  105646:	00 
  105647:	c7 04 24 bd c1 10 00 	movl   $0x10c1bd,(%esp)
  10564e:	e8 2d eb ff ff       	call   104180 <debug_panic>

	ph = (proghdr *) ((uintptr_t) eh + eh->e_phoff);
  105653:	8b 44 24 50          	mov    0x50(%esp),%eax
  105657:	8b 68 1c             	mov    0x1c(%eax),%ebp
  10565a:	01 c5                	add    %eax,%ebp
	eph = ph + eh->e_phnum;
  10565c:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  105660:	c1 e0 05             	shl    $0x5,%eax
  105663:	01 e8                	add    %ebp,%eax

	for (; ph < eph; ph++)
  105665:	39 c5                	cmp    %eax,%ebp

	strtab = (char *) (exe + sh[eh->e_shstrndx].sh_offset);
	KERN_ASSERT(sh[eh->e_shstrndx].sh_type == ELF_SHT_STRTAB);

	ph = (proghdr *) ((uintptr_t) eh + eh->e_phoff);
	eph = ph + eh->e_phnum;
  105667:	89 44 24 28          	mov    %eax,0x28(%esp)

	for (; ph < eph; ph++)
  10566b:	72 18                	jb     105685 <elf_load+0xb5>
  10566d:	e9 7e 01 00 00       	jmp    1057f0 <elf_load+0x220>
  105672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105678:	83 c5 20             	add    $0x20,%ebp
  10567b:	39 6c 24 28          	cmp    %ebp,0x28(%esp)
  10567f:	0f 86 6b 01 00 00    	jbe    1057f0 <elf_load+0x220>
	{
		uintptr_t fa;
		uint32_t va, zva, eva, perm;

		if (ph->p_type != ELF_PROG_LOAD)
  105685:	83 7d 00 01          	cmpl   $0x1,0x0(%ebp)
  105689:	75 ed                	jne    105678 <elf_load+0xa8>
			continue;

		fa = (uintptr_t) eh + rounddown (ph->p_offset, PAGESIZE);
  10568b:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  105692:	00 
  105693:	8b 45 04             	mov    0x4(%ebp),%eax
  105696:	89 04 24             	mov    %eax,(%esp)
  105699:	e8 d2 f6 ff ff       	call   104d70 <rounddown>
		va = rounddown (ph->p_va, PAGESIZE);
  10569e:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  1056a5:	00 
		uint32_t va, zva, eva, perm;

		if (ph->p_type != ELF_PROG_LOAD)
			continue;

		fa = (uintptr_t) eh + rounddown (ph->p_offset, PAGESIZE);
  1056a6:	03 44 24 50          	add    0x50(%esp),%eax
  1056aa:	89 c3                	mov    %eax,%ebx
		va = rounddown (ph->p_va, PAGESIZE);
  1056ac:	8b 45 08             	mov    0x8(%ebp),%eax
  1056af:	89 04 24             	mov    %eax,(%esp)
  1056b2:	e8 b9 f6 ff ff       	call   104d70 <rounddown>
		zva = ph->p_va + ph->p_filesz;
  1056b7:	8b 55 10             	mov    0x10(%ebp),%edx

		if (ph->p_type != ELF_PROG_LOAD)
			continue;

		fa = (uintptr_t) eh + rounddown (ph->p_offset, PAGESIZE);
		va = rounddown (ph->p_va, PAGESIZE);
  1056ba:	89 c6                	mov    %eax,%esi
		zva = ph->p_va + ph->p_filesz;
  1056bc:	8b 45 08             	mov    0x8(%ebp),%eax
		eva = roundup (ph->p_va + ph->p_memsz, PAGESIZE);
  1056bf:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  1056c6:	00 
		if (ph->p_type != ELF_PROG_LOAD)
			continue;

		fa = (uintptr_t) eh + rounddown (ph->p_offset, PAGESIZE);
		va = rounddown (ph->p_va, PAGESIZE);
		zva = ph->p_va + ph->p_filesz;
  1056c7:	01 c2                	add    %eax,%edx
		eva = roundup (ph->p_va + ph->p_memsz, PAGESIZE);
  1056c9:	03 45 14             	add    0x14(%ebp),%eax
		if (ph->p_type != ELF_PROG_LOAD)
			continue;

		fa = (uintptr_t) eh + rounddown (ph->p_offset, PAGESIZE);
		va = rounddown (ph->p_va, PAGESIZE);
		zva = ph->p_va + ph->p_filesz;
  1056cc:	89 54 24 1c          	mov    %edx,0x1c(%esp)
		eva = roundup (ph->p_va + ph->p_memsz, PAGESIZE);
  1056d0:	89 04 24             	mov    %eax,(%esp)
  1056d3:	e8 b8 f6 ff ff       	call   104d90 <roundup>
  1056d8:	89 c1                	mov    %eax,%ecx
  1056da:	89 44 24 24          	mov    %eax,0x24(%esp)

		perm = PTE_U | PTE_P;
		if (ph->p_flags & ELF_PROG_FLAG_WRITE)
  1056de:	8b 45 18             	mov    0x18(%ebp),%eax
  1056e1:	83 e0 02             	and    $0x2,%eax
		fa = (uintptr_t) eh + rounddown (ph->p_offset, PAGESIZE);
		va = rounddown (ph->p_va, PAGESIZE);
		zva = ph->p_va + ph->p_filesz;
		eva = roundup (ph->p_va + ph->p_memsz, PAGESIZE);

		perm = PTE_U | PTE_P;
  1056e4:	83 f8 01             	cmp    $0x1,%eax
  1056e7:	19 c0                	sbb    %eax,%eax
  1056e9:	89 44 24 20          	mov    %eax,0x20(%esp)
  1056ed:	83 64 24 20 fe       	andl   $0xfffffffe,0x20(%esp)
  1056f2:	83 44 24 20 07       	addl   $0x7,0x20(%esp)
		if (ph->p_flags & ELF_PROG_FLAG_WRITE)
			perm |= PTE_W;

		for (; va < eva; va += PAGESIZE, fa += PAGESIZE)
  1056f7:	39 ce                	cmp    %ecx,%esi
  1056f9:	0f 83 79 ff ff ff    	jae    105678 <elf_load+0xa8>
  1056ff:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  105703:	89 6c 24 2c          	mov    %ebp,0x2c(%esp)
  105707:	89 f5                	mov    %esi,%ebp
  105709:	29 f2                	sub    %esi,%edx
  10570b:	89 d6                	mov    %edx,%esi
  10570d:	eb 4a                	jmp    105759 <elf_load+0x189>
  10570f:	90                   	nop
			if (va < rounddown (zva, PAGESIZE))
			{
				/* copy a complete page */
				pt_copyout ((void *) fa, pid, va, PAGESIZE);
			}
			else if (va < zva && ph->p_filesz)
  105710:	39 6c 24 1c          	cmp    %ebp,0x1c(%esp)
  105714:	76 0b                	jbe    105721 <elf_load+0x151>
  105716:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  10571a:	8b 40 10             	mov    0x10(%eax),%eax
  10571d:	85 c0                	test   %eax,%eax
  10571f:	75 7f                	jne    1057a0 <elf_load+0x1d0>
				pt_copyout ((void *) fa, pid, va, zva - va);
			}
			else
			{
				/* zero a page */
				pt_memset (pid, va, 0, PAGESIZE);
  105721:	c7 44 24 0c 00 10 00 	movl   $0x1000,0xc(%esp)
  105728:	00 
  105729:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  105730:	00 
  105731:	89 6c 24 04          	mov    %ebp,0x4(%esp)
  105735:	89 3c 24             	mov    %edi,(%esp)
  105738:	e8 d3 fd ff ff       	call   105510 <pt_memset>

		perm = PTE_U | PTE_P;
		if (ph->p_flags & ELF_PROG_FLAG_WRITE)
			perm |= PTE_W;

		for (; va < eva; va += PAGESIZE, fa += PAGESIZE)
  10573d:	81 c5 00 10 00 00    	add    $0x1000,%ebp
  105743:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  105749:	81 ee 00 10 00 00    	sub    $0x1000,%esi
  10574f:	39 6c 24 24          	cmp    %ebp,0x24(%esp)
  105753:	0f 86 7f 00 00 00    	jbe    1057d8 <elf_load+0x208>
		{
			alloc_page (pid, va, perm);
  105759:	8b 44 24 20          	mov    0x20(%esp),%eax
  10575d:	89 6c 24 04          	mov    %ebp,0x4(%esp)
  105761:	89 3c 24             	mov    %edi,(%esp)
  105764:	89 44 24 08          	mov    %eax,0x8(%esp)
  105768:	e8 03 12 00 00       	call   106970 <alloc_page>

			if (va < rounddown (zva, PAGESIZE))
  10576d:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  105771:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  105778:	00 
  105779:	89 04 24             	mov    %eax,(%esp)
  10577c:	e8 ef f5 ff ff       	call   104d70 <rounddown>
  105781:	39 c5                	cmp    %eax,%ebp
  105783:	73 8b                	jae    105710 <elf_load+0x140>
			{
				/* copy a complete page */
				pt_copyout ((void *) fa, pid, va, PAGESIZE);
  105785:	c7 44 24 0c 00 10 00 	movl   $0x1000,0xc(%esp)
  10578c:	00 
  10578d:	89 6c 24 08          	mov    %ebp,0x8(%esp)
  105791:	89 7c 24 04          	mov    %edi,0x4(%esp)
  105795:	89 1c 24             	mov    %ebx,(%esp)
  105798:	e8 83 fc ff ff       	call   105420 <pt_copyout>
  10579d:	eb 9e                	jmp    10573d <elf_load+0x16d>
  10579f:	90                   	nop
			}
			else if (va < zva && ph->p_filesz)
			{
				/* copy a partial page */
				pt_memset (pid, va, 0, PAGESIZE);
  1057a0:	c7 44 24 0c 00 10 00 	movl   $0x1000,0xc(%esp)
  1057a7:	00 
  1057a8:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  1057af:	00 
  1057b0:	89 6c 24 04          	mov    %ebp,0x4(%esp)
  1057b4:	89 3c 24             	mov    %edi,(%esp)
  1057b7:	e8 54 fd ff ff       	call   105510 <pt_memset>
				pt_copyout ((void *) fa, pid, va, zva - va);
  1057bc:	89 74 24 0c          	mov    %esi,0xc(%esp)
  1057c0:	89 6c 24 08          	mov    %ebp,0x8(%esp)
  1057c4:	89 7c 24 04          	mov    %edi,0x4(%esp)
  1057c8:	89 1c 24             	mov    %ebx,(%esp)
  1057cb:	e8 50 fc ff ff       	call   105420 <pt_copyout>
  1057d0:	e9 68 ff ff ff       	jmp    10573d <elf_load+0x16d>
  1057d5:	8d 76 00             	lea    0x0(%esi),%esi
  1057d8:	8b 6c 24 2c          	mov    0x2c(%esp),%ebp
	KERN_ASSERT(sh[eh->e_shstrndx].sh_type == ELF_SHT_STRTAB);

	ph = (proghdr *) ((uintptr_t) eh + eh->e_phoff);
	eph = ph + eh->e_phnum;

	for (; ph < eph; ph++)
  1057dc:	83 c5 20             	add    $0x20,%ebp
  1057df:	39 6c 24 28          	cmp    %ebp,0x28(%esp)
  1057e3:	0f 87 9c fe ff ff    	ja     105685 <elf_load+0xb5>
  1057e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
				pt_memset (pid, va, 0, PAGESIZE);
			}
		}
	}

}
  1057f0:	83 c4 3c             	add    $0x3c,%esp
  1057f3:	5b                   	pop    %ebx
  1057f4:	5e                   	pop    %esi
  1057f5:	5f                   	pop    %edi
  1057f6:	5d                   	pop    %ebp
  1057f7:	c3                   	ret    
	uintptr_t exe = (uintptr_t) exe_ptr;

	eh = (elfhdr *) exe;

	KERN_ASSERT(eh->e_magic == ELF_MAGIC);
	KERN_ASSERT(eh->e_shstrndx != ELF_SHN_UNDEF);
  1057f8:	c7 44 24 0c cc c1 10 	movl   $0x10c1cc,0xc(%esp)
  1057ff:	00 
  105800:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  105807:	00 
  105808:	c7 44 24 04 1f 00 00 	movl   $0x1f,0x4(%esp)
  10580f:	00 
  105810:	c7 04 24 bd c1 10 00 	movl   $0x10c1bd,(%esp)
  105817:	e8 64 e9 ff ff       	call   104180 <debug_panic>
  10581c:	8b 44 24 50          	mov    0x50(%esp),%eax
  105820:	0f b7 40 32          	movzwl 0x32(%eax),%eax
  105824:	e9 f3 fd ff ff       	jmp    10561c <elf_load+0x4c>
  105829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00105830 <elf_entry>:

}

uintptr_t
elf_entry (void *exe_ptr)
{
  105830:	53                   	push   %ebx
  105831:	83 ec 18             	sub    $0x18,%esp
  105834:	8b 5c 24 20          	mov    0x20(%esp),%ebx
	uintptr_t exe = (uintptr_t) exe_ptr;
	elfhdr *eh = (elfhdr *) exe;
	KERN_ASSERT(eh->e_magic == ELF_MAGIC);
  105838:	81 3b 7f 45 4c 46    	cmpl   $0x464c457f,(%ebx)
  10583e:	74 24                	je     105864 <elf_entry+0x34>
  105840:	c7 44 24 0c a4 c1 10 	movl   $0x10c1a4,0xc(%esp)
  105847:	00 
  105848:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  10584f:	00 
  105850:	c7 44 24 04 59 00 00 	movl   $0x59,0x4(%esp)
  105857:	00 
  105858:	c7 04 24 bd c1 10 00 	movl   $0x10c1bd,(%esp)
  10585f:	e8 1c e9 ff ff       	call   104180 <debug_panic>
	return (uintptr_t) eh->e_entry;
  105864:	8b 43 18             	mov    0x18(%ebx),%eax
}
  105867:	83 c4 18             	add    $0x18,%esp
  10586a:	5b                   	pop    %ebx
  10586b:	c3                   	ret    
  10586c:	66 90                	xchg   %ax,%ax
  10586e:	66 90                	xchg   %ax,%ax

00105870 <get_kstack_pointer>:

#include "kstack.h"

uintptr_t*
get_kstack_pointer(void)
{
  105870:	83 ec 0c             	sub    $0xc,%esp
	struct kstack *ks =
                (struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
  105873:	e8 48 f5 ff ff       	call   104dc0 <get_stack_pointer>
	
	return (uintptr_t *) ks;
}
  105878:	83 c4 0c             	add    $0xc,%esp

uintptr_t*
get_kstack_pointer(void)
{
	struct kstack *ks =
                (struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
  10587b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
	
	return (uintptr_t *) ks;
}
  105880:	c3                   	ret    
  105881:	eb 0d                	jmp    105890 <get_kstack_cpu_idx>
  105883:	90                   	nop
  105884:	90                   	nop
  105885:	90                   	nop
  105886:	90                   	nop
  105887:	90                   	nop
  105888:	90                   	nop
  105889:	90                   	nop
  10588a:	90                   	nop
  10588b:	90                   	nop
  10588c:	90                   	nop
  10588d:	90                   	nop
  10588e:	90                   	nop
  10588f:	90                   	nop

00105890 <get_kstack_cpu_idx>:


int 
get_kstack_cpu_idx(void)
{
  105890:	83 ec 0c             	sub    $0xc,%esp

uintptr_t*
get_kstack_pointer(void)
{
	struct kstack *ks =
                (struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
  105893:	e8 28 f5 ff ff       	call   104dc0 <get_stack_pointer>
  105898:	25 00 f0 ff ff       	and    $0xfffff000,%eax
get_kstack_cpu_idx(void)
{

	struct kstack *ks = (struct kstack *) get_kstack_pointer();
	
	return ks->cpu_idx;
  10589d:	8b 80 1c 01 00 00    	mov    0x11c(%eax),%eax
}
  1058a3:	83 c4 0c             	add    $0xc,%esp
  1058a6:	c3                   	ret    
  1058a7:	66 90                	xchg   %ax,%ax
  1058a9:	66 90                	xchg   %ax,%ax
  1058ab:	66 90                	xchg   %ax,%ax
  1058ad:	66 90                	xchg   %ax,%ax
  1058af:	90                   	nop

001058b0 <spinlock_init>:
#include "spinlock.h"


void gcc_inline
spinlock_init(spinlock_t *lk)
{
  1058b0:	8b 44 24 04          	mov    0x4(%esp),%eax
	lk->lock_holder = NUM_CPUS + 1;
  1058b4:	c7 00 09 00 00 00    	movl   $0x9,(%eax)
	lk->lock = 0;
  1058ba:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  1058c1:	c3                   	ret    
  1058c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1058c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001058d0 <spinlock_holding>:
}


bool gcc_inline
spinlock_holding(spinlock_t *lock)
{
  1058d0:	56                   	push   %esi
	if(!lock->lock) return FALSE;
  1058d1:	31 c0                	xor    %eax,%eax
}


bool gcc_inline
spinlock_holding(spinlock_t *lock)
{
  1058d3:	53                   	push   %ebx
  1058d4:	83 ec 14             	sub    $0x14,%esp
  1058d7:	8b 5c 24 20          	mov    0x20(%esp),%ebx
	if(!lock->lock) return FALSE;
  1058db:	8b 53 04             	mov    0x4(%ebx),%edx
  1058de:	85 d2                	test   %edx,%edx
  1058e0:	75 06                	jne    1058e8 <spinlock_holding+0x18>

	struct kstack *kstack =
		(struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
	KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
	return lock->lock_holder == kstack->cpu_idx;
}
  1058e2:	83 c4 14             	add    $0x14,%esp
  1058e5:	5b                   	pop    %ebx
  1058e6:	5e                   	pop    %esi
  1058e7:	c3                   	ret    
spinlock_holding(spinlock_t *lock)
{
	if(!lock->lock) return FALSE;

	struct kstack *kstack =
		(struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
  1058e8:	e8 d3 f4 ff ff       	call   104dc0 <get_stack_pointer>
  1058ed:	89 c6                	mov    %eax,%esi
  1058ef:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
	KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  1058f5:	81 be 20 01 00 00 32 	cmpl   $0x98765432,0x120(%esi)
  1058fc:	54 76 98 
  1058ff:	74 24                	je     105925 <spinlock_holding+0x55>
  105901:	c7 44 24 0c 19 c2 10 	movl   $0x10c219,0xc(%esp)
  105908:	00 
  105909:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  105910:	00 
  105911:	c7 44 24 04 18 00 00 	movl   $0x18,0x4(%esp)
  105918:	00 
  105919:	c7 04 24 37 c2 10 00 	movl   $0x10c237,(%esp)
  105920:	e8 5b e8 ff ff       	call   104180 <debug_panic>
	return lock->lock_holder == kstack->cpu_idx;
  105925:	8b 86 1c 01 00 00    	mov    0x11c(%esi),%eax
  10592b:	39 03                	cmp    %eax,(%ebx)
  10592d:	0f 94 c0             	sete   %al
}
  105930:	83 c4 14             	add    $0x14,%esp
  105933:	5b                   	pop    %ebx
  105934:	5e                   	pop    %esi
  105935:	c3                   	ret    
  105936:	8d 76 00             	lea    0x0(%esi),%esi
  105939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105940 <spinlock_acquire_A>:

#else

void gcc_inline
spinlock_acquire_A(spinlock_t *lk)
{
  105940:	56                   	push   %esi
  105941:	53                   	push   %ebx
  105942:	83 ec 14             	sub    $0x14,%esp
  105945:	8b 74 24 20          	mov    0x20(%esp),%esi
  105949:	8d 5e 04             	lea    0x4(%esi),%ebx
	while(xchg(&lk->lock, 1) != 0)
  10594c:	eb 07                	jmp    105955 <spinlock_acquire_A+0x15>
  10594e:	66 90                	xchg   %ax,%ax
		pause();
  105950:	e8 eb f4 ff ff       	call   104e40 <pause>
#else

void gcc_inline
spinlock_acquire_A(spinlock_t *lk)
{
	while(xchg(&lk->lock, 1) != 0)
  105955:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10595c:	00 
  10595d:	89 1c 24             	mov    %ebx,(%esp)
  105960:	e8 eb f4 ff ff       	call   104e50 <xchg>
  105965:	85 c0                	test   %eax,%eax
  105967:	75 e7                	jne    105950 <spinlock_acquire_A+0x10>
		pause();

	struct kstack *kstack =
		(struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
  105969:	e8 52 f4 ff ff       	call   104dc0 <get_stack_pointer>
  10596e:	89 c3                	mov    %eax,%ebx
  105970:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
	KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  105976:	81 bb 20 01 00 00 32 	cmpl   $0x98765432,0x120(%ebx)
  10597d:	54 76 98 
  105980:	74 24                	je     1059a6 <spinlock_acquire_A+0x66>
  105982:	c7 44 24 0c 19 c2 10 	movl   $0x10c219,0xc(%esp)
  105989:	00 
  10598a:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  105991:	00 
  105992:	c7 44 24 04 37 00 00 	movl   $0x37,0x4(%esp)
  105999:	00 
  10599a:	c7 04 24 37 c2 10 00 	movl   $0x10c237,(%esp)
  1059a1:	e8 da e7 ff ff       	call   104180 <debug_panic>
	lk->lock_holder = kstack->cpu_idx;
  1059a6:	8b 83 1c 01 00 00    	mov    0x11c(%ebx),%eax
  1059ac:	89 06                	mov    %eax,(%esi)
}
  1059ae:	83 c4 14             	add    $0x14,%esp
  1059b1:	5b                   	pop    %ebx
  1059b2:	5e                   	pop    %esi
  1059b3:	c3                   	ret    
  1059b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1059ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001059c0 <spinlock_try_acquire_A>:

#endif

int gcc_inline
spinlock_try_acquire_A(spinlock_t *lk)
{
  1059c0:	57                   	push   %edi
  1059c1:	56                   	push   %esi
  1059c2:	53                   	push   %ebx
  1059c3:	83 ec 10             	sub    $0x10,%esp
  1059c6:	8b 74 24 20          	mov    0x20(%esp),%esi
	uint32_t old_val = xchg(&lk->lock, 1);
  1059ca:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1059d1:	00 
  1059d2:	8d 46 04             	lea    0x4(%esi),%eax
  1059d5:	89 04 24             	mov    %eax,(%esp)
  1059d8:	e8 73 f4 ff ff       	call   104e50 <xchg>
	if(old_val == 0) {
  1059dd:	85 c0                	test   %eax,%eax
#endif

int gcc_inline
spinlock_try_acquire_A(spinlock_t *lk)
{
	uint32_t old_val = xchg(&lk->lock, 1);
  1059df:	89 c3                	mov    %eax,%ebx
	if(old_val == 0) {
  1059e1:	74 0d                	je     1059f0 <spinlock_try_acquire_A+0x30>
			(struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
		KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
		lk->lock_holder = kstack->cpu_idx;
	}
	return old_val;
}
  1059e3:	83 c4 10             	add    $0x10,%esp
  1059e6:	89 d8                	mov    %ebx,%eax
  1059e8:	5b                   	pop    %ebx
  1059e9:	5e                   	pop    %esi
  1059ea:	5f                   	pop    %edi
  1059eb:	c3                   	ret    
  1059ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
spinlock_try_acquire_A(spinlock_t *lk)
{
	uint32_t old_val = xchg(&lk->lock, 1);
	if(old_val == 0) {
		struct kstack *kstack =
			(struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
  1059f0:	e8 cb f3 ff ff       	call   104dc0 <get_stack_pointer>
  1059f5:	89 c7                	mov    %eax,%edi
  1059f7:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
		KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  1059fd:	81 bf 20 01 00 00 32 	cmpl   $0x98765432,0x120(%edi)
  105a04:	54 76 98 
  105a07:	74 24                	je     105a2d <spinlock_try_acquire_A+0x6d>
  105a09:	c7 44 24 0c 19 c2 10 	movl   $0x10c219,0xc(%esp)
  105a10:	00 
  105a11:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  105a18:	00 
  105a19:	c7 44 24 04 44 00 00 	movl   $0x44,0x4(%esp)
  105a20:	00 
  105a21:	c7 04 24 37 c2 10 00 	movl   $0x10c237,(%esp)
  105a28:	e8 53 e7 ff ff       	call   104180 <debug_panic>
		lk->lock_holder = kstack->cpu_idx;
  105a2d:	8b 87 1c 01 00 00    	mov    0x11c(%edi),%eax
  105a33:	89 06                	mov    %eax,(%esi)
	}
	return old_val;
}
  105a35:	83 c4 10             	add    $0x10,%esp
  105a38:	89 d8                	mov    %ebx,%eax
  105a3a:	5b                   	pop    %ebx
  105a3b:	5e                   	pop    %esi
  105a3c:	5f                   	pop    %edi
  105a3d:	c3                   	ret    
  105a3e:	66 90                	xchg   %ax,%ax

00105a40 <spinlock_release_A>:

void gcc_inline
spinlock_release_A(spinlock_t *lk)
{
  105a40:	83 ec 1c             	sub    $0x1c,%esp
  105a43:	8b 44 24 20          	mov    0x20(%esp),%eax
	lk->lock_holder = NUM_CPUS + 1;
  105a47:	c7 00 09 00 00 00    	movl   $0x9,(%eax)
	xchg(&lk->lock, 0);
  105a4d:	83 c0 04             	add    $0x4,%eax
  105a50:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  105a57:	00 
  105a58:	89 04 24             	mov    %eax,(%esp)
  105a5b:	e8 f0 f3 ff ff       	call   104e50 <xchg>
}
  105a60:	83 c4 1c             	add    $0x1c,%esp
  105a63:	c3                   	ret    
  105a64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105a6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105a70 <spinlock_acquire>:

#else

void gcc_inline
spinlock_acquire(spinlock_t *lk)
{
  105a70:	56                   	push   %esi
  105a71:	53                   	push   %ebx
  105a72:	83 ec 14             	sub    $0x14,%esp
  105a75:	8b 74 24 20          	mov    0x20(%esp),%esi
  105a79:	8d 5e 04             	lea    0x4(%esi),%ebx
  105a7c:	eb 07                	jmp    105a85 <spinlock_acquire+0x15>
  105a7e:	66 90                	xchg   %ax,%ax

void gcc_inline
spinlock_acquire_A(spinlock_t *lk)
{
	while(xchg(&lk->lock, 1) != 0)
		pause();
  105a80:	e8 bb f3 ff ff       	call   104e40 <pause>
#else

void gcc_inline
spinlock_acquire_A(spinlock_t *lk)
{
	while(xchg(&lk->lock, 1) != 0)
  105a85:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  105a8c:	00 
  105a8d:	89 1c 24             	mov    %ebx,(%esp)
  105a90:	e8 bb f3 ff ff       	call   104e50 <xchg>
  105a95:	85 c0                	test   %eax,%eax
  105a97:	75 e7                	jne    105a80 <spinlock_acquire+0x10>
		pause();

	struct kstack *kstack =
		(struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
  105a99:	e8 22 f3 ff ff       	call   104dc0 <get_stack_pointer>
  105a9e:	89 c3                	mov    %eax,%ebx
  105aa0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
	KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  105aa6:	81 bb 20 01 00 00 32 	cmpl   $0x98765432,0x120(%ebx)
  105aad:	54 76 98 
  105ab0:	74 24                	je     105ad6 <spinlock_acquire+0x66>
  105ab2:	c7 44 24 0c 19 c2 10 	movl   $0x10c219,0xc(%esp)
  105ab9:	00 
  105aba:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  105ac1:	00 
  105ac2:	c7 44 24 04 37 00 00 	movl   $0x37,0x4(%esp)
  105ac9:	00 
  105aca:	c7 04 24 37 c2 10 00 	movl   $0x10c237,(%esp)
  105ad1:	e8 aa e6 ff ff       	call   104180 <debug_panic>
	lk->lock_holder = kstack->cpu_idx;
  105ad6:	8b 83 1c 01 00 00    	mov    0x11c(%ebx),%eax
  105adc:	89 06                	mov    %eax,(%esi)

void gcc_inline
spinlock_acquire(spinlock_t *lk)
{
  spinlock_acquire_A(lk);
}
  105ade:	83 c4 14             	add    $0x14,%esp
  105ae1:	5b                   	pop    %ebx
  105ae2:	5e                   	pop    %esi
  105ae3:	c3                   	ret    
  105ae4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105aea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105af0 <spinlock_release>:

void gcc_inline
spinlock_release(spinlock_t *lk)
{
  105af0:	83 ec 1c             	sub    $0x1c,%esp
  105af3:	8b 44 24 20          	mov    0x20(%esp),%eax
}

void gcc_inline
spinlock_release_A(spinlock_t *lk)
{
	lk->lock_holder = NUM_CPUS + 1;
  105af7:	c7 00 09 00 00 00    	movl   $0x9,(%eax)
	xchg(&lk->lock, 0);
  105afd:	83 c0 04             	add    $0x4,%eax
  105b00:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  105b07:	00 
  105b08:	89 04 24             	mov    %eax,(%esp)
  105b0b:	e8 40 f3 ff ff       	call   104e50 <xchg>

void gcc_inline
spinlock_release(spinlock_t *lk)
{
  spinlock_release_A(lk);
}
  105b10:	83 c4 1c             	add    $0x1c,%esp
  105b13:	c3                   	ret    
  105b14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105b1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105b20 <spinlock_try_acquire>:

int gcc_inline
spinlock_try_acquire(spinlock_t *lk)
{
  105b20:	57                   	push   %edi
  105b21:	56                   	push   %esi
  105b22:	53                   	push   %ebx
  105b23:	83 ec 10             	sub    $0x10,%esp
  105b26:	8b 74 24 20          	mov    0x20(%esp),%esi
#endif

int gcc_inline
spinlock_try_acquire_A(spinlock_t *lk)
{
	uint32_t old_val = xchg(&lk->lock, 1);
  105b2a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  105b31:	00 
  105b32:	8d 46 04             	lea    0x4(%esi),%eax
  105b35:	89 04 24             	mov    %eax,(%esp)
  105b38:	e8 13 f3 ff ff       	call   104e50 <xchg>
	if(old_val == 0) {
  105b3d:	85 c0                	test   %eax,%eax
#endif

int gcc_inline
spinlock_try_acquire_A(spinlock_t *lk)
{
	uint32_t old_val = xchg(&lk->lock, 1);
  105b3f:	89 c3                	mov    %eax,%ebx
	if(old_val == 0) {
  105b41:	74 0d                	je     105b50 <spinlock_try_acquire+0x30>

int gcc_inline
spinlock_try_acquire(spinlock_t *lk)
{
  return spinlock_try_acquire_A(lk);
}
  105b43:	83 c4 10             	add    $0x10,%esp
  105b46:	89 d8                	mov    %ebx,%eax
  105b48:	5b                   	pop    %ebx
  105b49:	5e                   	pop    %esi
  105b4a:	5f                   	pop    %edi
  105b4b:	c3                   	ret    
  105b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
spinlock_try_acquire_A(spinlock_t *lk)
{
	uint32_t old_val = xchg(&lk->lock, 1);
	if(old_val == 0) {
		struct kstack *kstack =
			(struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
  105b50:	e8 6b f2 ff ff       	call   104dc0 <get_stack_pointer>
  105b55:	89 c7                	mov    %eax,%edi
  105b57:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
		KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  105b5d:	81 bf 20 01 00 00 32 	cmpl   $0x98765432,0x120(%edi)
  105b64:	54 76 98 
  105b67:	74 24                	je     105b8d <spinlock_try_acquire+0x6d>
  105b69:	c7 44 24 0c 19 c2 10 	movl   $0x10c219,0xc(%esp)
  105b70:	00 
  105b71:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  105b78:	00 
  105b79:	c7 44 24 04 44 00 00 	movl   $0x44,0x4(%esp)
  105b80:	00 
  105b81:	c7 04 24 37 c2 10 00 	movl   $0x10c237,(%esp)
  105b88:	e8 f3 e5 ff ff       	call   104180 <debug_panic>
		lk->lock_holder = kstack->cpu_idx;
  105b8d:	8b 87 1c 01 00 00    	mov    0x11c(%edi),%eax
  105b93:	89 06                	mov    %eax,(%esi)

int gcc_inline
spinlock_try_acquire(spinlock_t *lk)
{
  return spinlock_try_acquire_A(lk);
}
  105b95:	83 c4 10             	add    $0x10,%esp
  105b98:	89 d8                	mov    %ebx,%eax
  105b9a:	5b                   	pop    %ebx
  105b9b:	5e                   	pop    %esi
  105b9c:	5f                   	pop    %edi
  105b9d:	c3                   	ret    
  105b9e:	66 90                	xchg   %ax,%ax

00105ba0 <pcpu_set_zero>:

struct pcpu pcpu[NUM_CPUS];

extern int get_kstack_cpu_idx(void);

void pcpu_set_zero(){
  105ba0:	83 ec 1c             	sub    $0x1c,%esp
    memzero(pcpu, sizeof(struct pcpu) * NUM_CPUS);
  105ba3:	c7 44 24 04 80 02 00 	movl   $0x280,0x4(%esp)
  105baa:	00 
  105bab:	c7 04 24 e0 b8 9c 00 	movl   $0x9cb8e0,(%esp)
  105bb2:	e8 c9 e3 ff ff       	call   103f80 <memzero>
}
  105bb7:	83 c4 1c             	add    $0x1c,%esp
  105bba:	c3                   	ret    
  105bbb:	90                   	nop
  105bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00105bc0 <pcpu_fields_init>:

void
pcpu_fields_init(int cpu_idx){
  105bc0:	8b 54 24 04          	mov    0x4(%esp),%edx
    pcpu[cpu_idx].inited = TRUE;
  105bc4:	8d 04 92             	lea    (%edx,%edx,4),%eax
  105bc7:	c1 e0 04             	shl    $0x4,%eax
  105bca:	c6 80 e0 b8 9c 00 01 	movb   $0x1,0x9cb8e0(%eax)
    pcpu[cpu_idx].cpu_idx = cpu_idx;
  105bd1:	89 90 2c b9 9c 00    	mov    %edx,0x9cb92c(%eax)
  105bd7:	c3                   	ret    
  105bd8:	90                   	nop
  105bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00105be0 <pcpu_cur>:
}

struct pcpu *
pcpu_cur(void)
{
  105be0:	83 ec 0c             	sub    $0xc,%esp
    int cpu_idx = get_kstack_cpu_idx();
  105be3:	e8 a8 fc ff ff       	call   105890 <get_kstack_cpu_idx>
    return &pcpu[cpu_idx];
}
  105be8:	83 c4 0c             	add    $0xc,%esp

struct pcpu *
pcpu_cur(void)
{
    int cpu_idx = get_kstack_cpu_idx();
    return &pcpu[cpu_idx];
  105beb:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105bee:	c1 e0 04             	shl    $0x4,%eax
  105bf1:	05 e0 b8 9c 00       	add    $0x9cb8e0,%eax
}
  105bf6:	c3                   	ret    
  105bf7:	89 f6                	mov    %esi,%esi
  105bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105c00 <get_pcpu_idx>:

int
get_pcpu_idx(void)
{
  105c00:	83 ec 0c             	sub    $0xc,%esp
}

struct pcpu *
pcpu_cur(void)
{
    int cpu_idx = get_kstack_cpu_idx();
  105c03:	e8 88 fc ff ff       	call   105890 <get_kstack_cpu_idx>
}

int
get_pcpu_idx(void)
{
    return pcpu_cur()->cpu_idx;
  105c08:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105c0b:	c1 e0 04             	shl    $0x4,%eax
  105c0e:	8b 80 2c b9 9c 00    	mov    0x9cb92c(%eax),%eax
}
  105c14:	83 c4 0c             	add    $0xc,%esp
  105c17:	c3                   	ret    
  105c18:	90                   	nop
  105c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00105c20 <set_pcpu_idx>:

void
set_pcpu_idx(int index, int cpu_idx)
{
  105c20:	8b 44 24 04          	mov    0x4(%esp),%eax
    pcpu[index].cpu_idx = cpu_idx;
  105c24:	8b 54 24 08          	mov    0x8(%esp),%edx
  105c28:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105c2b:	c1 e0 04             	shl    $0x4,%eax
  105c2e:	89 90 2c b9 9c 00    	mov    %edx,0x9cb92c(%eax)
  105c34:	c3                   	ret    
  105c35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  105c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105c40 <get_pcpu_kstack_pointer>:
}

uintptr_t*
get_pcpu_kstack_pointer(int cpu_idx)
{
  105c40:	8b 44 24 04          	mov    0x4(%esp),%eax
    return pcpu[cpu_idx].kstack;
  105c44:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105c47:	c1 e0 04             	shl    $0x4,%eax
  105c4a:	8b 80 e4 b8 9c 00    	mov    0x9cb8e4(%eax),%eax
}
  105c50:	c3                   	ret    
  105c51:	eb 0d                	jmp    105c60 <set_pcpu_kstack_pointer>
  105c53:	90                   	nop
  105c54:	90                   	nop
  105c55:	90                   	nop
  105c56:	90                   	nop
  105c57:	90                   	nop
  105c58:	90                   	nop
  105c59:	90                   	nop
  105c5a:	90                   	nop
  105c5b:	90                   	nop
  105c5c:	90                   	nop
  105c5d:	90                   	nop
  105c5e:	90                   	nop
  105c5f:	90                   	nop

00105c60 <set_pcpu_kstack_pointer>:

void
set_pcpu_kstack_pointer(int cpu_idx, uintptr_t* ks)
{
  105c60:	8b 44 24 04          	mov    0x4(%esp),%eax
    pcpu[cpu_idx].kstack = ks;
  105c64:	8b 54 24 08          	mov    0x8(%esp),%edx
  105c68:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105c6b:	c1 e0 04             	shl    $0x4,%eax
  105c6e:	89 90 e4 b8 9c 00    	mov    %edx,0x9cb8e4(%eax)
  105c74:	c3                   	ret    
  105c75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  105c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105c80 <get_pcpu_boot_info>:
}

volatile bool
get_pcpu_boot_info(int cpu_idx)
{
  105c80:	8b 44 24 04          	mov    0x4(%esp),%eax
    return pcpu[cpu_idx].booted;
  105c84:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105c87:	c1 e0 04             	shl    $0x4,%eax
  105c8a:	05 e0 b8 9c 00       	add    $0x9cb8e0,%eax
  105c8f:	0f b6 40 01          	movzbl 0x1(%eax),%eax
}
  105c93:	c3                   	ret    
  105c94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105c9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105ca0 <set_pcpu_boot_info>:

void
set_pcpu_boot_info(int cpu_idx, volatile bool boot_info)
{
  105ca0:	83 ec 04             	sub    $0x4,%esp
  105ca3:	8b 54 24 0c          	mov    0xc(%esp),%edx
  105ca7:	8b 44 24 08          	mov    0x8(%esp),%eax
  105cab:	88 14 24             	mov    %dl,(%esp)
    pcpu[cpu_idx].booted = boot_info;
  105cae:	0f b6 14 24          	movzbl (%esp),%edx
  105cb2:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105cb5:	c1 e0 04             	shl    $0x4,%eax
  105cb8:	88 90 e1 b8 9c 00    	mov    %dl,0x9cb8e1(%eax)
}
  105cbe:	83 c4 04             	add    $0x4,%esp
  105cc1:	c3                   	ret    
  105cc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105cd0 <get_pcpu_cpu_vendor>:

cpu_vendor
get_pcpu_cpu_vendor(int cpu_idx)
{
  105cd0:	8b 44 24 04          	mov    0x4(%esp),%eax
    return (pcpu[cpu_idx].arch_info).cpu_vendor;
  105cd4:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105cd7:	c1 e0 04             	shl    $0x4,%eax
  105cda:	8b 80 08 b9 9c 00    	mov    0x9cb908(%eax),%eax
}
  105ce0:	c3                   	ret    
  105ce1:	eb 0d                	jmp    105cf0 <get_pcpu_arch_info_pointer>
  105ce3:	90                   	nop
  105ce4:	90                   	nop
  105ce5:	90                   	nop
  105ce6:	90                   	nop
  105ce7:	90                   	nop
  105ce8:	90                   	nop
  105ce9:	90                   	nop
  105cea:	90                   	nop
  105ceb:	90                   	nop
  105cec:	90                   	nop
  105ced:	90                   	nop
  105cee:	90                   	nop
  105cef:	90                   	nop

00105cf0 <get_pcpu_arch_info_pointer>:

uintptr_t*
get_pcpu_arch_info_pointer(int cpu_idx)
{
  105cf0:	8b 44 24 04          	mov    0x4(%esp),%eax
    return (uintptr_t *) &(pcpu[cpu_idx].arch_info);
  105cf4:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105cf7:	c1 e0 04             	shl    $0x4,%eax
  105cfa:	05 e8 b8 9c 00       	add    $0x9cb8e8,%eax
}
  105cff:	c3                   	ret    

00105d00 <get_pcpu_inited_info>:

bool
get_pcpu_inited_info(int cpu_idx)
{
  105d00:	8b 44 24 04          	mov    0x4(%esp),%eax
    return pcpu[cpu_idx].inited;
  105d04:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105d07:	c1 e0 04             	shl    $0x4,%eax
  105d0a:	0f b6 80 e0 b8 9c 00 	movzbl 0x9cb8e0(%eax),%eax
}
  105d11:	c3                   	ret    
  105d12:	66 90                	xchg   %ax,%ax
  105d14:	66 90                	xchg   %ax,%ax
  105d16:	66 90                	xchg   %ax,%ax
  105d18:	66 90                	xchg   %ax,%ax
  105d1a:	66 90                	xchg   %ax,%ax
  105d1c:	66 90                	xchg   %ax,%ax
  105d1e:	66 90                	xchg   %ax,%ax

00105d20 <pcpu_init>:

static bool pcpu_inited = FALSE;

void
pcpu_init(void)
{
  105d20:	57                   	push   %edi
  105d21:	56                   	push   %esi
  105d22:	53                   	push   %ebx
  105d23:	83 ec 10             	sub    $0x10,%esp
    struct kstack *ks =
                (struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
  105d26:	e8 95 f0 ff ff       	call   104dc0 <get_stack_pointer>
  105d2b:	89 c7                	mov    %eax,%edi
  105d2d:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
	  int cpu_idx = ks->cpu_idx;
  105d33:	8b b7 1c 01 00 00    	mov    0x11c(%edi),%esi
    int i;

	  if (cpu_idx == 0){
  105d39:	85 f6                	test   %esi,%esi
  105d3b:	75 32                	jne    105d6f <pcpu_init+0x4f>
        if (pcpu_inited == TRUE)
  105d3d:	80 3d 90 fe 13 00 01 	cmpb   $0x1,0x13fe90
  105d44:	74 62                	je     105da8 <pcpu_init+0x88>
            return;

        pcpu_set_zero();
  105d46:	e8 55 fe ff ff       	call   105ba0 <pcpu_set_zero>
        /*
        * Probe SMP.
        */
        pcpu_mp_init();

        for (i = 0; i < NUM_CPUS; i++) {
  105d4b:	31 db                	xor    %ebx,%ebx
        pcpu_set_zero();

        /*
        * Probe SMP.
        */
        pcpu_mp_init();
  105d4d:	e8 4e ce ff ff       	call   102ba0 <pcpu_mp_init>
  105d52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

        for (i = 0; i < NUM_CPUS; i++) {
            pcpu_fields_init(i);
  105d58:	89 1c 24             	mov    %ebx,(%esp)
        /*
        * Probe SMP.
        */
        pcpu_mp_init();

        for (i = 0; i < NUM_CPUS; i++) {
  105d5b:	83 c3 01             	add    $0x1,%ebx
            pcpu_fields_init(i);
  105d5e:	e8 5d fe ff ff       	call   105bc0 <pcpu_fields_init>
        /*
        * Probe SMP.
        */
        pcpu_mp_init();

        for (i = 0; i < NUM_CPUS; i++) {
  105d63:	83 fb 08             	cmp    $0x8,%ebx
  105d66:	75 f0                	jne    105d58 <pcpu_init+0x38>
            pcpu_fields_init(i);
        }

        pcpu_inited = TRUE;
  105d68:	c6 05 90 fe 13 00 01 	movb   $0x1,0x13fe90
	  }

    set_pcpu_idx(cpu_idx, cpu_idx);
  105d6f:	89 74 24 04          	mov    %esi,0x4(%esp)
  105d73:	89 34 24             	mov    %esi,(%esp)
  105d76:	e8 a5 fe ff ff       	call   105c20 <set_pcpu_idx>
    set_pcpu_kstack_pointer(cpu_idx, (uintptr_t *) ks);
  105d7b:	89 7c 24 04          	mov    %edi,0x4(%esp)
  105d7f:	89 34 24             	mov    %esi,(%esp)
  105d82:	e8 d9 fe ff ff       	call   105c60 <set_pcpu_kstack_pointer>
    set_pcpu_boot_info(cpu_idx, TRUE);
  105d87:	89 34 24             	mov    %esi,(%esp)
  105d8a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  105d91:	00 
  105d92:	e8 09 ff ff ff       	call   105ca0 <set_pcpu_boot_info>
    pcpu_init_cpu();
}
  105d97:	83 c4 10             	add    $0x10,%esp
  105d9a:	5b                   	pop    %ebx
  105d9b:	5e                   	pop    %esi
  105d9c:	5f                   	pop    %edi
	  }

    set_pcpu_idx(cpu_idx, cpu_idx);
    set_pcpu_kstack_pointer(cpu_idx, (uintptr_t *) ks);
    set_pcpu_boot_info(cpu_idx, TRUE);
    pcpu_init_cpu();
  105d9d:	e9 3e d3 ff ff       	jmp    1030e0 <pcpu_init_cpu>
  105da2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
  105da8:	83 c4 10             	add    $0x10,%esp
  105dab:	5b                   	pop    %ebx
  105dac:	5e                   	pop    %esi
  105dad:	5f                   	pop    %edi
  105dae:	c3                   	ret    
  105daf:	90                   	nop

00105db0 <kern_init>:
    cpu_booted ++;    
}

void
kern_init (uintptr_t mbi_addr)
{
  105db0:	56                   	push   %esi
  105db1:	53                   	push   %ebx
  105db2:	83 ec 14             	sub    $0x14,%esp
    thread_init(mbi_addr);
  105db5:	8b 44 24 20          	mov    0x20(%esp),%eax
  105db9:	89 04 24             	mov    %eax,(%esp)
  105dbc:	e8 ef 11 00 00       	call   106fb0 <thread_init>

    KERN_INFO("[BSP KERN] Kernel initialized.\n");
  105dc1:	c7 04 24 4c c2 10 00 	movl   $0x10c24c,(%esp)
  105dc8:	e8 23 e3 ff ff       	call   1040f0 <debug_info>
extern uint8_t _binary___obj_user_idle_idle_start[];

static void
kern_main (void)
{
    KERN_INFO("[BSP KERN] In kernel main.\n\n");
  105dcd:	c7 04 24 e9 c2 10 00 	movl   $0x10c2e9,(%esp)
  105dd4:	e8 17 e3 ff ff       	call   1040f0 <debug_info>
    
    KERN_INFO("[BSP KERN] Number of CPUs in this system: %d. \n", pcpu_ncpu());
  105dd9:	e8 82 d7 ff ff       	call   103560 <pcpu_ncpu>
  105dde:	c7 04 24 6c c2 10 00 	movl   $0x10c26c,(%esp)
  105de5:	89 44 24 04          	mov    %eax,0x4(%esp)
  105de9:	e8 02 e3 ff ff       	call   1040f0 <debug_info>

    int cpu_idx = get_pcpu_idx();
  105dee:	e8 0d fe ff ff       	call   105c00 <get_pcpu_idx>
    }

    all_ready = TRUE;
    */
    
    pid = proc_create (_binary___obj_user_idle_idle_start, 1000);
  105df3:	c7 44 24 04 e8 03 00 	movl   $0x3e8,0x4(%esp)
  105dfa:	00 
  105dfb:	c7 04 24 14 03 11 00 	movl   $0x110314,(%esp)
{
    KERN_INFO("[BSP KERN] In kernel main.\n\n");
    
    KERN_INFO("[BSP KERN] Number of CPUs in this system: %d. \n", pcpu_ncpu());

    int cpu_idx = get_pcpu_idx();
  105e02:	89 c6                	mov    %eax,%esi
    }

    all_ready = TRUE;
    */
    
    pid = proc_create (_binary___obj_user_idle_idle_start, 1000);
  105e04:	e8 37 15 00 00       	call   107340 <proc_create>
    KERN_INFO("CPU%d: process idle %d is created.\n", cpu_idx, pid);
  105e09:	89 74 24 04          	mov    %esi,0x4(%esp)
  105e0d:	c7 04 24 9c c2 10 00 	movl   $0x10c29c,(%esp)
    }

    all_ready = TRUE;
    */
    
    pid = proc_create (_binary___obj_user_idle_idle_start, 1000);
  105e14:	89 c3                	mov    %eax,%ebx
    KERN_INFO("CPU%d: process idle %d is created.\n", cpu_idx, pid);
  105e16:	89 44 24 08          	mov    %eax,0x8(%esp)
  105e1a:	e8 d1 e2 ff ff       	call   1040f0 <debug_info>
    tqueue_remove (NUM_IDS, pid);
  105e1f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  105e23:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
  105e2a:	e8 51 10 00 00       	call   106e80 <tqueue_remove>
    tcb_set_state (pid, TSTATE_RUN);
  105e2f:	89 1c 24             	mov    %ebx,(%esp)
  105e32:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  105e39:	00 
  105e3a:	e8 a1 0c 00 00       	call   106ae0 <tcb_set_state>
    set_curid (pid);
  105e3f:	89 1c 24             	mov    %ebx,(%esp)
  105e42:	e8 49 11 00 00       	call   106f90 <set_curid>
    kctx_switch (0, pid); 
  105e47:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  105e4b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  105e52:	e8 c9 0b 00 00       	call   106a20 <kctx_switch>

    KERN_PANIC("kern_main_ap() should never reach here.\n");
  105e57:	c7 44 24 08 c0 c2 10 	movl   $0x10c2c0,0x8(%esp)
  105e5e:	00 
  105e5f:	c7 44 24 04 3c 00 00 	movl   $0x3c,0x4(%esp)
  105e66:	00 
  105e67:	c7 04 24 06 c3 10 00 	movl   $0x10c306,(%esp)
  105e6e:	e8 0d e3 ff ff       	call   104180 <debug_panic>
    thread_init(mbi_addr);

    KERN_INFO("[BSP KERN] Kernel initialized.\n");

    kern_main ();
}
  105e73:	83 c4 14             	add    $0x14,%esp
  105e76:	5b                   	pop    %ebx
  105e77:	5e                   	pop    %esi
  105e78:	c3                   	ret    
  105e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00105e80 <kern_init_ap>:

void 
kern_init_ap(void (*f)(void))
{
  105e80:	53                   	push   %ebx
  105e81:	83 ec 08             	sub    $0x8,%esp
  105e84:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	devinit_ap();
  105e88:	e8 f3 aa ff ff       	call   100980 <devinit_ap>
	f();
}
  105e8d:	83 c4 08             	add    $0x8,%esp

void 
kern_init_ap(void (*f)(void))
{
	devinit_ap();
	f();
  105e90:	89 d8                	mov    %ebx,%eax
}
  105e92:	5b                   	pop    %ebx

void 
kern_init_ap(void (*f)(void))
{
	devinit_ap();
	f();
  105e93:	ff e0                	jmp    *%eax
  105e95:	66 90                	xchg   %ax,%ax
  105e97:	90                   	nop
  105e98:	02 b0 ad 1b 03 00    	add    0x31bad(%eax),%dh
  105e9e:	00 00                	add    %al,(%eax)
  105ea0:	fb                   	sti    
  105ea1:	4f                   	dec    %edi
  105ea2:	52                   	push   %edx
  105ea3:	e4                   	.byte 0xe4

00105ea4 <start>:
	.long	CHECKSUM

	/* this is the entry of the kernel */
	.globl	start
start:
  cli
  105ea4:	fa                   	cli    

	/* check whether the bootloader provide multiboot information */
	cmpl    $MULTIBOOT_BOOTLOADER_MAGIC, %eax
  105ea5:	3d 02 b0 ad 2b       	cmp    $0x2badb002,%eax
	jne     spin
  105eaa:	75 27                	jne    105ed3 <spin>
	movl	%ebx, multiboot_ptr
  105eac:	89 1d d4 5e 10 00    	mov    %ebx,0x105ed4

	/* tell BIOS to warmboot next time */
	movw	$0x1234,0x472
  105eb2:	66 c7 05 72 04 00 00 	movw   $0x1234,0x472
  105eb9:	34 12 

	/* clear EFLAGS */
	pushl	$0x2
  105ebb:	6a 02                	push   $0x2
	popfl
  105ebd:	9d                   	popf   

	/* prepare the kernel stack  */
	movl	$0x0,%ebp
  105ebe:	bd 00 00 00 00       	mov    $0x0,%ebp
	movl	$(bsp_kstack+4096),%esp
  105ec3:	bc 00 20 98 00       	mov    $0x982000,%esp

	/* jump to the C code */
	push	multiboot_ptr
  105ec8:	ff 35 d4 5e 10 00    	pushl  0x105ed4
	call	kern_init
  105ece:	e8 dd fe ff ff       	call   105db0 <kern_init>

00105ed3 <spin>:

	/* should not be here */
spin:
	hlt
  105ed3:	f4                   	hlt    

00105ed4 <multiboot_ptr>:
  105ed4:	00 00                	add    %al,(%eax)
  105ed6:	00 00                	add    %al,(%eax)
  105ed8:	66 90                	xchg   %ax,%ax
  105eda:	66 90                	xchg   %ax,%ax
  105edc:	66 90                	xchg   %ax,%ax
  105ede:	66 90                	xchg   %ax,%ax

00105ee0 <mem_spinlock_init>:
static struct ATStruct AT[1 << 20];



void 
mem_spinlock_init(void){
  105ee0:	83 ec 1c             	sub    $0x1c,%esp
	spinlock_init(&mem_lk);
  105ee3:	c7 04 24 a4 fe 93 00 	movl   $0x93fea4,(%esp)
  105eea:	e8 c1 f9 ff ff       	call   1058b0 <spinlock_init>
}
  105eef:	83 c4 1c             	add    $0x1c,%esp
  105ef2:	c3                   	ret    
  105ef3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105f00 <mem_lock>:

void
mem_lock(void){
  105f00:	83 ec 1c             	sub    $0x1c,%esp
	spinlock_acquire(&mem_lk);
  105f03:	c7 04 24 a4 fe 93 00 	movl   $0x93fea4,(%esp)
  105f0a:	e8 61 fb ff ff       	call   105a70 <spinlock_acquire>
}
  105f0f:	83 c4 1c             	add    $0x1c,%esp
  105f12:	c3                   	ret    
  105f13:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105f20 <mem_unlock>:

void
mem_unlock(void){
  105f20:	83 ec 1c             	sub    $0x1c,%esp
	spinlock_release(&mem_lk);
  105f23:	c7 04 24 a4 fe 93 00 	movl   $0x93fea4,(%esp)
  105f2a:	e8 c1 fb ff ff       	call   105af0 <spinlock_release>
}
  105f2f:	83 c4 1c             	add    $0x1c,%esp
  105f32:	c3                   	ret    
  105f33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105f40 <get_nps>:
//The getter function for NUM_PAGES.
unsigned int gcc_inline
get_nps(void)
{
	return NUM_PAGES;
}
  105f40:	a1 a0 fe 93 00       	mov    0x93fea0,%eax
  105f45:	c3                   	ret    
  105f46:	8d 76 00             	lea    0x0(%esi),%esi
  105f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105f50 <set_nps>:

//The setter function for NUM_PAGES.
void gcc_inline
set_nps(unsigned int nps)
{
	NUM_PAGES = nps;
  105f50:	8b 44 24 04          	mov    0x4(%esp),%eax
  105f54:	a3 a0 fe 93 00       	mov    %eax,0x93fea0
  105f59:	c3                   	ret    
  105f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00105f60 <at_is_norm>:
{
	unsigned int tperm;

	tperm = AT[page_index].perm;

	if (tperm == 0) {
  105f60:	8b 44 24 04          	mov    0x4(%esp),%eax
  105f64:	83 3c c5 a0 fe 13 00 	cmpl   $0x1,0x13fea0(,%eax,8)
  105f6b:	01 
  105f6c:	0f 97 c0             	seta   %al
  105f6f:	0f b6 c0             	movzbl %al,%eax
		else
			tperm = 1;
	}

	return tperm;
}
  105f72:	c3                   	ret    
  105f73:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105f80 <at_set_perm>:
 * Sets the permission of the page with given index.
 * It also marks the page as unallocated.
 */
void
at_set_perm(unsigned int page_index, unsigned int norm_val)
{
  105f80:	8b 44 24 04          	mov    0x4(%esp),%eax
	AT[page_index].perm = norm_val;
  105f84:	8b 54 24 08          	mov    0x8(%esp),%edx
	AT[page_index].allocated = 0;
  105f88:	c7 04 c5 a4 fe 13 00 	movl   $0x0,0x13fea4(,%eax,8)
  105f8f:	00 00 00 00 
 * It also marks the page as unallocated.
 */
void
at_set_perm(unsigned int page_index, unsigned int norm_val)
{
	AT[page_index].perm = norm_val;
  105f93:	89 14 c5 a0 fe 13 00 	mov    %edx,0x13fea0(,%eax,8)
	AT[page_index].allocated = 0;
  105f9a:	c3                   	ret    
  105f9b:	90                   	nop
  105f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00105fa0 <at_is_allocated>:
at_is_allocated(unsigned int page_index)
{
	unsigned int allocated;

	allocated = AT[page_index].allocated;
	if (allocated == 0)
  105fa0:	8b 44 24 04          	mov    0x4(%esp),%eax
  105fa4:	8b 04 c5 a4 fe 13 00 	mov    0x13fea4(,%eax,8),%eax
  105fab:	85 c0                	test   %eax,%eax
  105fad:	0f 95 c0             	setne  %al
  105fb0:	0f b6 c0             	movzbl %al,%eax
		allocated = 0;
	else
		allocated = 1;

	return allocated;
}
  105fb3:	c3                   	ret    
  105fb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105fba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105fc0 <at_set_allocated>:
 * Set the flag of the page with given index to the given value.
 */
void
at_set_allocated(unsigned int page_index, unsigned int allocated)
{
	AT[page_index].allocated = allocated;
  105fc0:	8b 54 24 08          	mov    0x8(%esp),%edx
  105fc4:	8b 44 24 04          	mov    0x4(%esp),%eax
  105fc8:	89 14 c5 a4 fe 13 00 	mov    %edx,0x13fea4(,%eax,8)
  105fcf:	c3                   	ret    

00105fd0 <pmem_init>:
 *    information available in the physical memory map table.
 *    Review import.h in the current directory for the list of avaiable getter and setter functions.
 */
void
pmem_init(unsigned int mbi_addr)
{
  105fd0:	55                   	push   %ebp
  105fd1:	57                   	push   %edi
  105fd2:	56                   	push   %esi
  105fd3:	53                   	push   %ebx
  105fd4:	83 ec 2c             	sub    $0x2c,%esp
	unsigned int i, j, isnorm, maxs, size, flag;
	unsigned int s, l;

  //Calls the lower layer initializatin primitives.
  //The parameter mbi_addr shell not be used in the further code.
	devinit(mbi_addr);
  105fd7:	8b 44 24 40          	mov    0x40(%esp),%eax
  105fdb:	89 04 24             	mov    %eax,(%esp)
  105fde:	e8 ed a8 ff ff       	call   1008d0 <devinit>


	mem_spinlock_init();
  105fe3:	e8 f8 fe ff ff       	call   105ee0 <mem_spinlock_init>
   * Calculate the number of actual number of avaiable physical pages and store it into the local varaible nps.
   * Hint: Think of it as the highest address possible in the ranges of the memory map table,
   *       divided by the page size.
   */
	i = 0;
	size = get_size();
  105fe8:	e8 d3 ad ff ff       	call   100dc0 <get_size>
	nps = 0;
	while (i < size) {
  105fed:	85 c0                	test   %eax,%eax
   * Calculate the number of actual number of avaiable physical pages and store it into the local varaible nps.
   * Hint: Think of it as the highest address possible in the ranges of the memory map table,
   *       divided by the page size.
   */
	i = 0;
	size = get_size();
  105fef:	89 c7                	mov    %eax,%edi
	nps = 0;
	while (i < size) {
  105ff1:	74 6e                	je     106061 <pmem_init+0x91>
  /**
   * Calculate the number of actual number of avaiable physical pages and store it into the local varaible nps.
   * Hint: Think of it as the highest address possible in the ranges of the memory map table,
   *       divided by the page size.
   */
	i = 0;
  105ff3:	31 f6                	xor    %esi,%esi
	size = get_size();
	nps = 0;
  105ff5:	31 db                	xor    %ebx,%ebx
  105ff7:	90                   	nop
	while (i < size) {
		s = get_mms(i);
  105ff8:	89 34 24             	mov    %esi,(%esp)
  105ffb:	e8 d0 ad ff ff       	call   100dd0 <get_mms>
		l = get_mml(i);
  106000:	89 34 24             	mov    %esi,(%esp)
   */
	i = 0;
	size = get_size();
	nps = 0;
	while (i < size) {
		s = get_mms(i);
  106003:	89 c5                	mov    %eax,%ebp
		l = get_mml(i);
  106005:	e8 06 ae ff ff       	call   100e10 <get_mml>
		maxs = (s + l) / PAGESIZE + 1;
  10600a:	01 e8                	add    %ebp,%eax
  10600c:	c1 e8 0c             	shr    $0xc,%eax
  10600f:	83 c0 01             	add    $0x1,%eax
  106012:	39 c3                	cmp    %eax,%ebx
  106014:	0f 42 d8             	cmovb  %eax,%ebx
		if (maxs > nps)
			nps = maxs;
		i++;
  106017:	83 c6 01             	add    $0x1,%esi
   *       divided by the page size.
   */
	i = 0;
	size = get_size();
	nps = 0;
	while (i < size) {
  10601a:	39 fe                	cmp    %edi,%esi
  10601c:	75 da                	jne    105ff8 <pmem_init+0x28>
		if (maxs > nps)
			nps = maxs;
		i++;
	}

	set_nps(nps); // Setting the value computed above to NUM_PAGES.
  10601e:	89 1c 24             	mov    %ebx,(%esp)
  106021:	bd 01 00 00 00       	mov    $0x1,%ebp
  106026:	31 f6                	xor    %esi,%esi
  106028:	e8 23 ff ff ff       	call   105f50 <set_nps>
  10602d:	eb 03                	jmp    106032 <pmem_init+0x62>
  10602f:	90                   	nop
   *    But the ranges in the momory map table may not cover the entire available address space.
   *    That means there may be some gaps between the ranges.
   *    You should still set the permission of those pages in allocation table to 0.
   */
	i = 0;
	while (i < nps) {
  106030:	89 c5                	mov    %eax,%ebp
  106032:	8d 86 00 00 fc ff    	lea    -0x40000(%esi),%eax
		if (i < VM_USERLO_PI || i >= VM_USERHI_PI) {
  106038:	3d ff ff 0a 00       	cmp    $0xaffff,%eax
  10603d:	76 36                	jbe    106075 <pmem_init+0xa5>
			at_set_perm(i, 1);
  10603f:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  106046:	00 
  106047:	89 34 24             	mov    %esi,(%esp)
  10604a:	e8 31 ff ff ff       	call   105f80 <at_set_perm>
  10604f:	83 c6 01             	add    $0x1,%esi
   *    But the ranges in the momory map table may not cover the entire available address space.
   *    That means there may be some gaps between the ranges.
   *    You should still set the permission of those pages in allocation table to 0.
   */
	i = 0;
	while (i < nps) {
  106052:	39 dd                	cmp    %ebx,%ebp
  106054:	8d 45 01             	lea    0x1(%ebp),%eax
  106057:	72 d7                	jb     106030 <pmem_init+0x60>
				at_set_perm(i, 0);
		}
		i++;
	}

}
  106059:	83 c4 2c             	add    $0x2c,%esp
  10605c:	5b                   	pop    %ebx
  10605d:	5e                   	pop    %esi
  10605e:	5f                   	pop    %edi
  10605f:	5d                   	pop    %ebp
  106060:	c3                   	ret    
		if (maxs > nps)
			nps = maxs;
		i++;
	}

	set_nps(nps); // Setting the value computed above to NUM_PAGES.
  106061:	c7 44 24 40 00 00 00 	movl   $0x0,0x40(%esp)
  106068:	00 
				at_set_perm(i, 0);
		}
		i++;
	}

}
  106069:	83 c4 2c             	add    $0x2c,%esp
  10606c:	5b                   	pop    %ebx
  10606d:	5e                   	pop    %esi
  10606e:	5f                   	pop    %edi
  10606f:	5d                   	pop    %ebp
		if (maxs > nps)
			nps = maxs;
		i++;
	}

	set_nps(nps); // Setting the value computed above to NUM_PAGES.
  106070:	e9 db fe ff ff       	jmp    105f50 <set_nps>
  106075:	89 f0                	mov    %esi,%eax
  106077:	c1 e0 0c             	shl    $0xc,%eax
  10607a:	89 44 24 0c          	mov    %eax,0xc(%esp)
			isnorm = 0;
			while (j < size && flag == 0) {
				s = get_mms(j);
				l = get_mml(j);
				isnorm = is_usable(j);
				if (s <= i * PAGESIZE && l + s >= (i + 1) * PAGESIZE) {
  10607e:	89 e8                	mov    %ebp,%eax
  106080:	c1 e0 0c             	shl    $0xc,%eax
  106083:	89 44 24 10          	mov    %eax,0x10(%esp)
  106087:	31 c0                	xor    %eax,%eax
  106089:	89 5c 24 14          	mov    %ebx,0x14(%esp)
  10608d:	89 c3                	mov    %eax,%ebx
  10608f:	89 6c 24 18          	mov    %ebp,0x18(%esp)
  106093:	89 74 24 1c          	mov    %esi,0x1c(%esp)
  106097:	eb 1c                	jmp    1060b5 <pmem_init+0xe5>
  106099:	8d 54 35 00          	lea    0x0(%ebp,%esi,1),%edx
  10609d:	3b 54 24 10          	cmp    0x10(%esp),%edx
  1060a1:	0f 93 c2             	setae  %dl
  1060a4:	0f b6 ca             	movzbl %dl,%ecx
  1060a7:	83 f2 01             	xor    $0x1,%edx
					flag = 1;
				}
				j++;
  1060aa:	83 c3 01             	add    $0x1,%ebx
			at_set_perm(i, 1);
		} else {
			j = 0;
			flag = 0;
			isnorm = 0;
			while (j < size && flag == 0) {
  1060ad:	84 d2                	test   %dl,%dl
  1060af:	74 2f                	je     1060e0 <pmem_init+0x110>
  1060b1:	39 df                	cmp    %ebx,%edi
  1060b3:	76 2b                	jbe    1060e0 <pmem_init+0x110>
				s = get_mms(j);
  1060b5:	89 1c 24             	mov    %ebx,(%esp)
  1060b8:	e8 13 ad ff ff       	call   100dd0 <get_mms>
				l = get_mml(j);
  1060bd:	89 1c 24             	mov    %ebx,(%esp)
		} else {
			j = 0;
			flag = 0;
			isnorm = 0;
			while (j < size && flag == 0) {
				s = get_mms(j);
  1060c0:	89 c6                	mov    %eax,%esi
				l = get_mml(j);
  1060c2:	e8 49 ad ff ff       	call   100e10 <get_mml>
				isnorm = is_usable(j);
  1060c7:	89 1c 24             	mov    %ebx,(%esp)
			j = 0;
			flag = 0;
			isnorm = 0;
			while (j < size && flag == 0) {
				s = get_mms(j);
				l = get_mml(j);
  1060ca:	89 c5                	mov    %eax,%ebp
				isnorm = is_usable(j);
  1060cc:	e8 7f ad ff ff       	call   100e50 <is_usable>
				if (s <= i * PAGESIZE && l + s >= (i + 1) * PAGESIZE) {
  1060d1:	39 74 24 0c          	cmp    %esi,0xc(%esp)
  1060d5:	73 c2                	jae    106099 <pmem_init+0xc9>
  1060d7:	ba 01 00 00 00       	mov    $0x1,%edx
  1060dc:	31 c9                	xor    %ecx,%ecx
  1060de:	eb ca                	jmp    1060aa <pmem_init+0xda>
					flag = 1;
				}
				j++;
			}
			if (flag == 1 && isnorm == 1)
  1060e0:	83 f8 01             	cmp    $0x1,%eax
  1060e3:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  1060e7:	8b 6c 24 18          	mov    0x18(%esp),%ebp
  1060eb:	8b 74 24 1c          	mov    0x1c(%esp),%esi
  1060ef:	75 19                	jne    10610a <pmem_init+0x13a>
  1060f1:	85 c9                	test   %ecx,%ecx
  1060f3:	74 15                	je     10610a <pmem_init+0x13a>
				at_set_perm(i, 2);
  1060f5:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  1060fc:	00 
  1060fd:	89 34 24             	mov    %esi,(%esp)
  106100:	e8 7b fe ff ff       	call   105f80 <at_set_perm>
  106105:	e9 45 ff ff ff       	jmp    10604f <pmem_init+0x7f>
			else
				at_set_perm(i, 0);
  10610a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  106111:	00 
  106112:	89 34 24             	mov    %esi,(%esp)
  106115:	e8 66 fe ff ff       	call   105f80 <at_set_perm>
  10611a:	e9 30 ff ff ff       	jmp    10604f <pmem_init+0x7f>
  10611f:	90                   	nop

00106120 <palloc>:
 * 2. Optimize the code with the memorization techniques so that you do not have to
 *    scan the allocation table from scratch every time.
 */
unsigned int
palloc()
{
  106120:	57                   	push   %edi
  106121:	56                   	push   %esi
  106122:	53                   	push   %ebx
  106123:	83 ec 10             	sub    $0x10,%esp
    unsigned int palloc_index;
    unsigned int palloc_cur_at;
    unsigned int palloc_is_norm;
    unsigned int palloc_free_index;

    mem_lock();
  106126:	e8 d5 fd ff ff       	call   105f00 <mem_lock>

    tnps = get_nps();
  10612b:	e8 10 fe ff ff       	call   105f40 <get_nps>
  106130:	89 c6                	mov    %eax,%esi
    palloc_index = last_palloc_index + 1;
  106132:	a1 0c 03 11 00       	mov    0x11030c,%eax
    palloc_free_index = tnps;
    while( palloc_index < tnps && palloc_free_index == tnps )
  106137:	89 f7                	mov    %esi,%edi
    unsigned int palloc_free_index;

    mem_lock();

    tnps = get_nps();
    palloc_index = last_palloc_index + 1;
  106139:	8d 58 01             	lea    0x1(%eax),%ebx
    palloc_free_index = tnps;
    while( palloc_index < tnps && palloc_free_index == tnps )
  10613c:	39 de                	cmp    %ebx,%esi
  10613e:	77 13                	ja     106153 <palloc+0x33>
  106140:	eb 66                	jmp    1061a8 <palloc+0x88>
  106142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        {
            palloc_cur_at = at_is_allocated(palloc_index);
            if (palloc_cur_at == 0)
                palloc_free_index = palloc_index;
        }
        palloc_index ++;
  106148:	83 c3 01             	add    $0x1,%ebx
    mem_lock();

    tnps = get_nps();
    palloc_index = last_palloc_index + 1;
    palloc_free_index = tnps;
    while( palloc_index < tnps && palloc_free_index == tnps )
  10614b:	39 f7                	cmp    %esi,%edi
  10614d:	75 29                	jne    106178 <palloc+0x58>
  10614f:	39 de                	cmp    %ebx,%esi
  106151:	76 25                	jbe    106178 <palloc+0x58>
    {
        palloc_is_norm = at_is_norm(palloc_index);
  106153:	89 1c 24             	mov    %ebx,(%esp)
  106156:	e8 05 fe ff ff       	call   105f60 <at_is_norm>
        if (palloc_is_norm == 1)
  10615b:	83 f8 01             	cmp    $0x1,%eax
  10615e:	75 e8                	jne    106148 <palloc+0x28>
        {
            palloc_cur_at = at_is_allocated(palloc_index);
  106160:	89 1c 24             	mov    %ebx,(%esp)
  106163:	e8 38 fe ff ff       	call   105fa0 <at_is_allocated>
  106168:	85 c0                	test   %eax,%eax
  10616a:	0f 44 fb             	cmove  %ebx,%edi
            if (palloc_cur_at == 0)
                palloc_free_index = palloc_index;
        }
        palloc_index ++;
  10616d:	83 c3 01             	add    $0x1,%ebx
    mem_lock();

    tnps = get_nps();
    palloc_index = last_palloc_index + 1;
    palloc_free_index = tnps;
    while( palloc_index < tnps && palloc_free_index == tnps )
  106170:	39 f7                	cmp    %esi,%edi
  106172:	74 db                	je     10614f <palloc+0x2f>
  106174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            if (palloc_cur_at == 0)
                palloc_free_index = palloc_index;
        }
        palloc_index ++;
    }
    if (palloc_free_index == tnps)
  106178:	39 f7                	cmp    %esi,%edi
  10617a:	74 2c                	je     1061a8 <palloc+0x88>
      palloc_free_index = 0;
    else
    {
      at_set_allocated(palloc_free_index, 1);
  10617c:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  106183:	00 
  106184:	89 3c 24             	mov    %edi,(%esp)
  106187:	e8 34 fe ff ff       	call   105fc0 <at_set_allocated>
  10618c:	89 f8                	mov    %edi,%eax
  10618e:	31 d2                	xor    %edx,%edx
  106190:	f7 f6                	div    %esi
    }
    last_palloc_index = palloc_free_index % tnps;
  106192:	89 15 0c 03 11 00    	mov    %edx,0x11030c

    mem_unlock();
  106198:	e8 83 fd ff ff       	call   105f20 <mem_unlock>

    return palloc_free_index;
} 
  10619d:	83 c4 10             	add    $0x10,%esp
  1061a0:	89 f8                	mov    %edi,%eax
  1061a2:	5b                   	pop    %ebx
  1061a3:	5e                   	pop    %esi
  1061a4:	5f                   	pop    %edi
  1061a5:	c3                   	ret    
  1061a6:	66 90                	xchg   %ax,%ax
  1061a8:	31 d2                	xor    %edx,%edx
                palloc_free_index = palloc_index;
        }
        palloc_index ++;
    }
    if (palloc_free_index == tnps)
      palloc_free_index = 0;
  1061aa:	31 ff                	xor    %edi,%edi
  1061ac:	eb e4                	jmp    106192 <palloc+0x72>
  1061ae:	66 90                	xchg   %ax,%ax

001061b0 <pfree>:
 *
 * Hint: Simple.
 */
void
pfree(unsigned int pfree_index)
{
  1061b0:	53                   	push   %ebx
  1061b1:	83 ec 18             	sub    $0x18,%esp
  1061b4:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  mem_lock();
  1061b8:	e8 43 fd ff ff       	call   105f00 <mem_lock>
	at_set_allocated(pfree_index, 0);
  1061bd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1061c4:	00 
  1061c5:	89 1c 24             	mov    %ebx,(%esp)
  1061c8:	e8 f3 fd ff ff       	call   105fc0 <at_set_allocated>
  mem_unlock();
}
  1061cd:	83 c4 18             	add    $0x18,%esp
  1061d0:	5b                   	pop    %ebx
void
pfree(unsigned int pfree_index)
{
  mem_lock();
	at_set_allocated(pfree_index, 0);
  mem_unlock();
  1061d1:	e9 4a fd ff ff       	jmp    105f20 <mem_unlock>
  1061d6:	66 90                	xchg   %ax,%ax
  1061d8:	66 90                	xchg   %ax,%ax
  1061da:	66 90                	xchg   %ax,%ax
  1061dc:	66 90                	xchg   %ax,%ax
  1061de:	66 90                	xchg   %ax,%ax

001061e0 <container_init>:
/**
 * Initializes the container data for the root process (the one with index 0).
 * The root process is the one that gets spawned first by the kernel.
 */
void container_init(unsigned int mbi_addr)
{
  1061e0:	55                   	push   %ebp
  1061e1:	57                   	push   %edi
  1061e2:	56                   	push   %esi
  1061e3:	53                   	push   %ebx
  1061e4:	83 ec 1c             	sub    $0x1c,%esp
  unsigned int real_quota;
  unsigned int nps, i, norm, used;

  pmem_init(mbi_addr);
  1061e7:	8b 44 24 30          	mov    0x30(%esp),%eax
  1061eb:	89 04 24             	mov    %eax,(%esp)
  1061ee:	e8 dd fd ff ff       	call   105fd0 <pmem_init>
  /**
   * compute the available quota and store it into the variable real_quota.
   * It should be the number of the unallocated pages with the normal permission
   * in the physical memory allocation table.
   */
  nps = get_nps();
  1061f3:	e8 48 fd ff ff       	call   105f40 <get_nps>
  i = 1;
  while (i < nps) {
  1061f8:	83 f8 01             	cmp    $0x1,%eax
  /**
   * compute the available quota and store it into the variable real_quota.
   * It should be the number of the unallocated pages with the normal permission
   * in the physical memory allocation table.
   */
  nps = get_nps();
  1061fb:	89 c5                	mov    %eax,%ebp
  i = 1;
  while (i < nps) {
  1061fd:	0f 86 8d 00 00 00    	jbe    106290 <container_init+0xb0>
   * compute the available quota and store it into the variable real_quota.
   * It should be the number of the unallocated pages with the normal permission
   * in the physical memory allocation table.
   */
  nps = get_nps();
  i = 1;
  106203:	bb 01 00 00 00       	mov    $0x1,%ebx
{
  unsigned int real_quota;
  unsigned int nps, i, norm, used;

  pmem_init(mbi_addr);
  real_quota = 0;
  106208:	31 ff                	xor    %edi,%edi
  10620a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
   * in the physical memory allocation table.
   */
  nps = get_nps();
  i = 1;
  while (i < nps) {
    norm = at_is_norm(i);
  106210:	89 1c 24             	mov    %ebx,(%esp)
  106213:	e8 48 fd ff ff       	call   105f60 <at_is_norm>
    used = at_is_allocated(i);
  106218:	89 1c 24             	mov    %ebx,(%esp)
   * in the physical memory allocation table.
   */
  nps = get_nps();
  i = 1;
  while (i < nps) {
    norm = at_is_norm(i);
  10621b:	89 c6                	mov    %eax,%esi
    used = at_is_allocated(i);
  10621d:	e8 7e fd ff ff       	call   105fa0 <at_is_allocated>
    if (norm == 1 && used == 0)
  106222:	85 c0                	test   %eax,%eax
  106224:	75 0b                	jne    106231 <container_init+0x51>
  106226:	83 fe 01             	cmp    $0x1,%esi
  106229:	0f 94 c0             	sete   %al
      real_quota++;
  10622c:	3c 01                	cmp    $0x1,%al
  10622e:	83 df ff             	sbb    $0xffffffff,%edi
    i++;
  106231:	83 c3 01             	add    $0x1,%ebx
   * It should be the number of the unallocated pages with the normal permission
   * in the physical memory allocation table.
   */
  nps = get_nps();
  i = 1;
  while (i < nps) {
  106234:	39 eb                	cmp    %ebp,%ebx
  106236:	75 d8                	jne    106210 <container_init+0x30>
  106238:	89 fb                	mov    %edi,%ebx
    used = at_is_allocated(i);
    if (norm == 1 && used == 0)
      real_quota++;
    i++;
  }
  KERN_DEBUG("\nreal quota: %d\n\n", real_quota);
  10623a:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  10623e:	c7 44 24 08 17 c3 10 	movl   $0x10c317,0x8(%esp)
  106245:	00 
  106246:	c7 44 24 04 2a 00 00 	movl   $0x2a,0x4(%esp)
  10624d:	00 
  10624e:	c7 04 24 2c c3 10 00 	movl   $0x10c32c,(%esp)
  106255:	e8 d6 de ff ff       	call   104130 <debug_normal>

  CONTAINER[0].quota = real_quota;
  10625a:	89 1d c0 fe 93 00    	mov    %ebx,0x93fec0
  CONTAINER[0].usage = 0;
  106260:	c7 05 c4 fe 93 00 00 	movl   $0x0,0x93fec4
  106267:	00 00 00 
  CONTAINER[0].parent = 0;
  10626a:	c7 05 c8 fe 93 00 00 	movl   $0x0,0x93fec8
  106271:	00 00 00 
  CONTAINER[0].nchildren = 0;
  106274:	c7 05 cc fe 93 00 00 	movl   $0x0,0x93fecc
  10627b:	00 00 00 
  CONTAINER[0].used = 1;
  10627e:	c7 05 d0 fe 93 00 01 	movl   $0x1,0x93fed0
  106285:	00 00 00 
}
  106288:	83 c4 1c             	add    $0x1c,%esp
  10628b:	5b                   	pop    %ebx
  10628c:	5e                   	pop    %esi
  10628d:	5f                   	pop    %edi
  10628e:	5d                   	pop    %ebp
  10628f:	c3                   	ret    
   * It should be the number of the unallocated pages with the normal permission
   * in the physical memory allocation table.
   */
  nps = get_nps();
  i = 1;
  while (i < nps) {
  106290:	31 db                	xor    %ebx,%ebx
{
  unsigned int real_quota;
  unsigned int nps, i, norm, used;

  pmem_init(mbi_addr);
  real_quota = 0;
  106292:	31 ff                	xor    %edi,%edi
  106294:	eb a4                	jmp    10623a <container_init+0x5a>
  106296:	8d 76 00             	lea    0x0(%esi),%esi
  106299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001062a0 <container_get_parent>:
}


// get the id of parent process of process # [id]
unsigned int container_get_parent(unsigned int id)
{
  1062a0:	8b 44 24 04          	mov    0x4(%esp),%eax
  return CONTAINER[id].parent;
  1062a4:	8d 04 80             	lea    (%eax,%eax,4),%eax
  1062a7:	8b 04 85 c8 fe 93 00 	mov    0x93fec8(,%eax,4),%eax
}
  1062ae:	c3                   	ret    
  1062af:	90                   	nop

001062b0 <container_get_nchildren>:


// get the number of children of process # [id]
unsigned int container_get_nchildren(unsigned int id)
{
  1062b0:	8b 44 24 04          	mov    0x4(%esp),%eax
  return CONTAINER[id].nchildren;
  1062b4:	8d 04 80             	lea    (%eax,%eax,4),%eax
  1062b7:	8b 04 85 cc fe 93 00 	mov    0x93fecc(,%eax,4),%eax
}
  1062be:	c3                   	ret    
  1062bf:	90                   	nop

001062c0 <container_get_quota>:


// get the maximum memory quota of process # [id]
unsigned int container_get_quota(unsigned int id)
{
  1062c0:	8b 44 24 04          	mov    0x4(%esp),%eax
  return CONTAINER[id].quota;
  1062c4:	8d 04 80             	lea    (%eax,%eax,4),%eax
  1062c7:	8b 04 85 c0 fe 93 00 	mov    0x93fec0(,%eax,4),%eax
}
  1062ce:	c3                   	ret    
  1062cf:	90                   	nop

001062d0 <container_get_usage>:


// get the current memory usage of process # [id]
unsigned int container_get_usage(unsigned int id)
{
  1062d0:	8b 44 24 04          	mov    0x4(%esp),%eax
  return CONTAINER[id].usage;
  1062d4:	8d 04 80             	lea    (%eax,%eax,4),%eax
  1062d7:	8b 04 85 c4 fe 93 00 	mov    0x93fec4(,%eax,4),%eax
}
  1062de:	c3                   	ret    
  1062df:	90                   	nop

001062e0 <container_can_consume>:


// determines whether the process # [id] can consume extra
// [n] pages of memory. If so, returns 1, o.w., returns 0.
unsigned int container_can_consume(unsigned int id, unsigned int n)
{
  1062e0:	8b 44 24 04          	mov    0x4(%esp),%eax
  if (CONTAINER[id].usage + n > CONTAINER[id].quota) return 0;
  1062e4:	8d 14 80             	lea    (%eax,%eax,4),%edx
  1062e7:	c1 e2 02             	shl    $0x2,%edx
  1062ea:	8b 82 c4 fe 93 00    	mov    0x93fec4(%edx),%eax
  1062f0:	03 44 24 08          	add    0x8(%esp),%eax
  1062f4:	3b 82 c0 fe 93 00    	cmp    0x93fec0(%edx),%eax
  1062fa:	0f 96 c0             	setbe  %al
  1062fd:	0f b6 c0             	movzbl %al,%eax
  return 1;
}
  106300:	c3                   	ret    
  106301:	eb 0d                	jmp    106310 <container_split>
  106303:	90                   	nop
  106304:	90                   	nop
  106305:	90                   	nop
  106306:	90                   	nop
  106307:	90                   	nop
  106308:	90                   	nop
  106309:	90                   	nop
  10630a:	90                   	nop
  10630b:	90                   	nop
  10630c:	90                   	nop
  10630d:	90                   	nop
  10630e:	90                   	nop
  10630f:	90                   	nop

00106310 <container_split>:
 * dedicates [quota] pages of memory for a new child process.
 * you can assume it is safe to allocate [quota] pages (i.e., the check is already done outside before calling this function)
 * returns the container index for the new child process.
 */
unsigned int container_split(unsigned int id, unsigned int quota)
{
  106310:	55                   	push   %ebp
  106311:	57                   	push   %edi
  106312:	56                   	push   %esi
  106313:	53                   	push   %ebx
  106314:	8b 54 24 14          	mov    0x14(%esp),%edx
  106318:	8b 6c 24 18          	mov    0x18(%esp),%ebp
  unsigned int child, nc;

  nc = CONTAINER[id].nchildren;
  10631c:	8d 04 92             	lea    (%edx,%edx,4),%eax
  10631f:	8d 0c 85 c0 fe 93 00 	lea    0x93fec0(,%eax,4),%ecx
  child = id * MAX_CHILDREN + 1 + nc; //container index for the child process
  106326:	8b 41 0c             	mov    0xc(%ecx),%eax
  106329:	8d 78 01             	lea    0x1(%eax),%edi
  10632c:	8d 04 52             	lea    (%edx,%edx,2),%eax
  10632f:	01 f8                	add    %edi,%eax

  /**
   * update the container structure of both parent and child process appropriately.
   */
  CONTAINER[child].used = 1;
  106331:	8d 34 80             	lea    (%eax,%eax,4),%esi
  106334:	c1 e6 02             	shl    $0x2,%esi
  CONTAINER[child].quota = quota;
  106337:	89 ae c0 fe 93 00    	mov    %ebp,0x93fec0(%esi)
  child = id * MAX_CHILDREN + 1 + nc; //container index for the child process

  /**
   * update the container structure of both parent and child process appropriately.
   */
  CONTAINER[child].used = 1;
  10633d:	c7 86 d0 fe 93 00 01 	movl   $0x1,0x93fed0(%esi)
  106344:	00 00 00 
  CONTAINER[child].quota = quota;
  CONTAINER[child].usage = 0;
  106347:	c7 86 c4 fe 93 00 00 	movl   $0x0,0x93fec4(%esi)
  10634e:	00 00 00 
  CONTAINER[child].parent = id;
  106351:	89 96 c8 fe 93 00    	mov    %edx,0x93fec8(%esi)
  CONTAINER[child].nchildren = 0;
  106357:	c7 86 cc fe 93 00 00 	movl   $0x0,0x93fecc(%esi)
  10635e:	00 00 00 

  CONTAINER[id].usage += quota;
  106361:	01 69 04             	add    %ebp,0x4(%ecx)
  CONTAINER[id].nchildren = nc + 1;
  106364:	89 79 0c             	mov    %edi,0xc(%ecx)

  return child;
}
  106367:	5b                   	pop    %ebx
  106368:	5e                   	pop    %esi
  106369:	5f                   	pop    %edi
  10636a:	5d                   	pop    %ebp
  10636b:	c3                   	ret    
  10636c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106370 <container_alloc>:
 * allocates one more page for process # [id], given that its usage would not exceed the quota.
 * the container structure should be updated accordingly after the allocation.
 * returns the page index of the allocated page, or 0 in the case of failure.
 */
unsigned int container_alloc(unsigned int id)
{
  106370:	8b 44 24 04          	mov    0x4(%esp),%eax
  unsigned int u, q, i;
  u = CONTAINER[id].usage;
  106374:	8d 04 80             	lea    (%eax,%eax,4),%eax
  106377:	c1 e0 02             	shl    $0x2,%eax
  10637a:	8b 88 c4 fe 93 00    	mov    0x93fec4(%eax),%ecx
  q = CONTAINER[id].quota;
  if (u == q) return 0;
  106380:	3b 88 c0 fe 93 00    	cmp    0x93fec0(%eax),%ecx
  106386:	74 10                	je     106398 <container_alloc+0x28>

  CONTAINER[id].usage = u + 1;
  106388:	83 c1 01             	add    $0x1,%ecx
  10638b:	89 88 c4 fe 93 00    	mov    %ecx,0x93fec4(%eax)
  i = palloc();
  106391:	e9 8a fd ff ff       	jmp    106120 <palloc>
  106396:	66 90                	xchg   %ax,%ax
  return i;
}
  106398:	31 c0                	xor    %eax,%eax
  10639a:	c3                   	ret    
  10639b:	90                   	nop
  10639c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001063a0 <container_free>:

// frees the physical page and reduces the usage by 1.
void container_free(unsigned int id, unsigned int page_index)
{
  1063a0:	53                   	push   %ebx
  1063a1:	83 ec 18             	sub    $0x18,%esp
  1063a4:	8b 5c 24 24          	mov    0x24(%esp),%ebx
  if (at_is_allocated(page_index)) {
  1063a8:	89 1c 24             	mov    %ebx,(%esp)
  1063ab:	e8 f0 fb ff ff       	call   105fa0 <at_is_allocated>
  1063b0:	85 c0                	test   %eax,%eax
  1063b2:	75 0c                	jne    1063c0 <container_free+0x20>
    pfree(page_index);
    if (CONTAINER[id].usage > 0)
      CONTAINER[id].usage -= 1;
  }
}
  1063b4:	83 c4 18             	add    $0x18,%esp
  1063b7:	5b                   	pop    %ebx
  1063b8:	c3                   	ret    
  1063b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

// frees the physical page and reduces the usage by 1.
void container_free(unsigned int id, unsigned int page_index)
{
  if (at_is_allocated(page_index)) {
    pfree(page_index);
  1063c0:	89 1c 24             	mov    %ebx,(%esp)
  1063c3:	e8 e8 fd ff ff       	call   1061b0 <pfree>
    if (CONTAINER[id].usage > 0)
  1063c8:	8b 44 24 20          	mov    0x20(%esp),%eax
  1063cc:	8d 04 80             	lea    (%eax,%eax,4),%eax
  1063cf:	8d 04 85 c0 fe 93 00 	lea    0x93fec0(,%eax,4),%eax
  1063d6:	8b 50 04             	mov    0x4(%eax),%edx
  1063d9:	85 d2                	test   %edx,%edx
  1063db:	7e d7                	jle    1063b4 <container_free+0x14>
      CONTAINER[id].usage -= 1;
  1063dd:	83 ea 01             	sub    $0x1,%edx
  1063e0:	89 50 04             	mov    %edx,0x4(%eax)
  }
}
  1063e3:	83 c4 18             	add    $0x18,%esp
  1063e6:	5b                   	pop    %ebx
  1063e7:	c3                   	ret    
  1063e8:	66 90                	xchg   %ax,%ax
  1063ea:	66 90                	xchg   %ax,%ax
  1063ec:	66 90                	xchg   %ax,%ax
  1063ee:	66 90                	xchg   %ax,%ax

001063f0 <pt_spinlock_init>:
 */
unsigned int IDPTbl[1024][1024] gcc_aligned(PAGESIZE);



void pt_spinlock_init(){
  1063f0:	83 ec 1c             	sub    $0x1c,%esp
	spinlock_init(&pt_lk);
  1063f3:	c7 04 24 c0 03 94 00 	movl   $0x9403c0,(%esp)
  1063fa:	e8 b1 f4 ff ff       	call   1058b0 <spinlock_init>
}
  1063ff:	83 c4 1c             	add    $0x1c,%esp
  106402:	c3                   	ret    
  106403:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  106409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106410 <pt_spinlock_acquire>:

void pt_spinlock_acquire(){
  106410:	83 ec 1c             	sub    $0x1c,%esp
	spinlock_acquire(&pt_lk);
  106413:	c7 04 24 c0 03 94 00 	movl   $0x9403c0,(%esp)
  10641a:	e8 51 f6 ff ff       	call   105a70 <spinlock_acquire>
}
  10641f:	83 c4 1c             	add    $0x1c,%esp
  106422:	c3                   	ret    
  106423:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  106429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106430 <pt_spinlock_release>:

void pt_spinlock_release(){
  106430:	83 ec 1c             	sub    $0x1c,%esp
	spinlock_release(&pt_lk);
  106433:	c7 04 24 c0 03 94 00 	movl   $0x9403c0,(%esp)
  10643a:	e8 b1 f6 ff ff       	call   105af0 <spinlock_release>
}
  10643f:	83 c4 1c             	add    $0x1c,%esp
  106442:	c3                   	ret    
  106443:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  106449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106450 <set_pdir_base>:

// sets the CR3 register with the start address of the page structure for process # [index]
void set_pdir_base(unsigned int index)
{
  106450:	8b 44 24 04          	mov    0x4(%esp),%eax
	  set_cr3(PDirPool[index]);
  106454:	c1 e0 0c             	shl    $0xc,%eax
  106457:	05 00 c0 dc 00       	add    $0xdcc000,%eax
  10645c:	89 44 24 04          	mov    %eax,0x4(%esp)
  106460:	e9 3b aa ff ff       	jmp    100ea0 <set_cr3>
  106465:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  106469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106470 <get_pdir_entry>:
}

// returns the page directory entry # [pde_index] of the process # [proc_index]
// this can be used to test whether the page directory entry is mapped
unsigned int get_pdir_entry(unsigned int proc_index, unsigned int pde_index)
{
  106470:	8b 44 24 04          	mov    0x4(%esp),%eax
    unsigned int pde;
    pde = (unsigned int)PDirPool[proc_index][pde_index];
  106474:	c1 e0 0a             	shl    $0xa,%eax
  106477:	03 44 24 08          	add    0x8(%esp),%eax
    return pde;
  10647b:	8b 04 85 00 c0 dc 00 	mov    0xdcc000(,%eax,4),%eax
}   
  106482:	c3                   	ret    
  106483:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  106489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106490 <set_pdir_entry>:

// sets specified page directory entry with the start address of physical page # [page_index].
// you should also set the permissions PTE_P, PTE_W, and PTE_U
void set_pdir_entry(unsigned int proc_index, unsigned int pde_index, unsigned int page_index)
{
  106490:	8b 44 24 04          	mov    0x4(%esp),%eax
  106494:	8b 54 24 0c          	mov    0xc(%esp),%edx
    PDirPool[proc_index][pde_index] = (char *)(page_index * PAGESIZE + PT_PERM_PTU);
  106498:	c1 e0 0a             	shl    $0xa,%eax
  10649b:	03 44 24 08          	add    0x8(%esp),%eax
  10649f:	c1 e2 0c             	shl    $0xc,%edx
  1064a2:	83 c2 07             	add    $0x7,%edx
  1064a5:	89 14 85 00 c0 dc 00 	mov    %edx,0xdcc000(,%eax,4)
  1064ac:	c3                   	ret    
  1064ad:	8d 76 00             	lea    0x0(%esi),%esi

001064b0 <set_pdir_entry_identity>:
// sets the page directory entry # [pde_index] for the process # [proc_index]
// with the initial address of page directory # [pde_index] in IDPTbl
// you should also set the permissions PTE_P, PTE_W, and PTE_U
// this will be used to map the page directory entry to identity page table.
void set_pdir_entry_identity(unsigned int proc_index, unsigned int pde_index)
{   
  1064b0:	8b 44 24 04          	mov    0x4(%esp),%eax
  1064b4:	8b 54 24 08          	mov    0x8(%esp),%edx
    PDirPool[proc_index][pde_index] = ((char *)(IDPTbl[pde_index])) + PT_PERM_PTU;
  1064b8:	c1 e0 0a             	shl    $0xa,%eax
  1064bb:	01 d0                	add    %edx,%eax
  1064bd:	c1 e2 0c             	shl    $0xc,%edx
  1064c0:	81 c2 07 c0 9c 00    	add    $0x9cc007,%edx
  1064c6:	89 14 85 00 c0 dc 00 	mov    %edx,0xdcc000(,%eax,4)
  1064cd:	c3                   	ret    
  1064ce:	66 90                	xchg   %ax,%ax

001064d0 <rmv_pdir_entry>:
}   

// removes specified page directory entry (set the page directory entry to 0).
// don't forget to cast the value to (char *).
void rmv_pdir_entry(unsigned int proc_index, unsigned int pde_index)
{
  1064d0:	8b 44 24 04          	mov    0x4(%esp),%eax
    PDirPool[proc_index][pde_index] = (char *)PT_PERM_UP;
  1064d4:	c1 e0 0a             	shl    $0xa,%eax
  1064d7:	03 44 24 08          	add    0x8(%esp),%eax
  1064db:	c7 04 85 00 c0 dc 00 	movl   $0x0,0xdcc000(,%eax,4)
  1064e2:	00 00 00 00 
  1064e6:	c3                   	ret    
  1064e7:	89 f6                	mov    %esi,%esi
  1064e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001064f0 <get_ptbl_entry>:
}   

// returns the specified page table entry.
// do not forget that the permission info is also stored in the page directory entries.
unsigned int get_ptbl_entry(unsigned int proc_index, unsigned int pde_index, unsigned int pte_index)
{   
  1064f0:	8b 44 24 04          	mov    0x4(%esp),%eax
    unsigned int addr;
    addr = ((unsigned int)PDirPool[proc_index][pde_index] & 0xfffff000) + pte_index * 4;
    return *((unsigned int *) addr);
  1064f4:	8b 54 24 0c          	mov    0xc(%esp),%edx
// returns the specified page table entry.
// do not forget that the permission info is also stored in the page directory entries.
unsigned int get_ptbl_entry(unsigned int proc_index, unsigned int pde_index, unsigned int pte_index)
{   
    unsigned int addr;
    addr = ((unsigned int)PDirPool[proc_index][pde_index] & 0xfffff000) + pte_index * 4;
  1064f8:	c1 e0 0a             	shl    $0xa,%eax
  1064fb:	03 44 24 08          	add    0x8(%esp),%eax
  1064ff:	8b 04 85 00 c0 dc 00 	mov    0xdcc000(,%eax,4),%eax
  106506:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    return *((unsigned int *) addr);
  10650b:	8b 04 90             	mov    (%eax,%edx,4),%eax
}
  10650e:	c3                   	ret    
  10650f:	90                   	nop

00106510 <set_ptbl_entry>:

// sets specified page table entry with the start address of physical page # [page_index]
// you should also set the given permission
void set_ptbl_entry(unsigned int proc_index, unsigned int pde_index, unsigned int pte_index, unsigned int page_index, unsigned int perm)
{   
  106510:	8b 54 24 04          	mov    0x4(%esp),%edx
  106514:	8b 44 24 10          	mov    0x10(%esp),%eax
    unsigned int addr;
    addr = ((unsigned int)PDirPool[proc_index][pde_index] & 0xfffff000) + pte_index * 4;
    *((unsigned int *) addr) = page_index * PAGESIZE + perm;
  106518:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
// sets specified page table entry with the start address of physical page # [page_index]
// you should also set the given permission
void set_ptbl_entry(unsigned int proc_index, unsigned int pde_index, unsigned int pte_index, unsigned int page_index, unsigned int perm)
{   
    unsigned int addr;
    addr = ((unsigned int)PDirPool[proc_index][pde_index] & 0xfffff000) + pte_index * 4;
  10651c:	c1 e2 0a             	shl    $0xa,%edx
  10651f:	03 54 24 08          	add    0x8(%esp),%edx
    *((unsigned int *) addr) = page_index * PAGESIZE + perm;
  106523:	c1 e0 0c             	shl    $0xc,%eax
  106526:	03 44 24 14          	add    0x14(%esp),%eax
// sets specified page table entry with the start address of physical page # [page_index]
// you should also set the given permission
void set_ptbl_entry(unsigned int proc_index, unsigned int pde_index, unsigned int pte_index, unsigned int page_index, unsigned int perm)
{   
    unsigned int addr;
    addr = ((unsigned int)PDirPool[proc_index][pde_index] & 0xfffff000) + pte_index * 4;
  10652a:	8b 14 95 00 c0 dc 00 	mov    0xdcc000(,%edx,4),%edx
  106531:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
    *((unsigned int *) addr) = page_index * PAGESIZE + perm;
  106537:	89 04 8a             	mov    %eax,(%edx,%ecx,4)
  10653a:	c3                   	ret    
  10653b:	90                   	nop
  10653c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106540 <set_ptbl_entry_identity>:
}   

// sets the specified page table entry in IDPTbl as the identity map.
// you should also set the given permission
void set_ptbl_entry_identity(unsigned int pde_index, unsigned int pte_index, unsigned int perm)
{
  106540:	8b 44 24 04          	mov    0x4(%esp),%eax
    IDPTbl[pde_index][pte_index] = (pde_index * 1024 + pte_index) * PAGESIZE + perm;
  106544:	c1 e0 0a             	shl    $0xa,%eax
  106547:	03 44 24 08          	add    0x8(%esp),%eax
  10654b:	89 c2                	mov    %eax,%edx
  10654d:	c1 e2 0c             	shl    $0xc,%edx
  106550:	03 54 24 0c          	add    0xc(%esp),%edx
  106554:	89 14 85 00 c0 9c 00 	mov    %edx,0x9cc000(,%eax,4)
  10655b:	c3                   	ret    
  10655c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106560 <rmv_ptbl_entry>:
}

// sets the specified page table entry to 0
void rmv_ptbl_entry(unsigned int proc_index, unsigned int pde_index, unsigned int pte_index)
{
  106560:	8b 44 24 04          	mov    0x4(%esp),%eax
    unsigned int addr;
    addr = ((unsigned int)PDirPool[proc_index][pde_index] & 0xfffff000) + pte_index * 4;
    *((unsigned int *) addr) = 0;
  106564:	8b 54 24 0c          	mov    0xc(%esp),%edx

// sets the specified page table entry to 0
void rmv_ptbl_entry(unsigned int proc_index, unsigned int pde_index, unsigned int pte_index)
{
    unsigned int addr;
    addr = ((unsigned int)PDirPool[proc_index][pde_index] & 0xfffff000) + pte_index * 4;
  106568:	c1 e0 0a             	shl    $0xa,%eax
  10656b:	03 44 24 08          	add    0x8(%esp),%eax
  10656f:	8b 04 85 00 c0 dc 00 	mov    0xdcc000(,%eax,4),%eax
  106576:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    *((unsigned int *) addr) = 0;
  10657b:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
  106582:	c3                   	ret    
  106583:	66 90                	xchg   %ax,%ax
  106585:	66 90                	xchg   %ax,%ax
  106587:	66 90                	xchg   %ax,%ax
  106589:	66 90                	xchg   %ax,%ax
  10658b:	66 90                	xchg   %ax,%ax
  10658d:	66 90                	xchg   %ax,%ax
  10658f:	90                   	nop

00106590 <get_ptbl_entry_by_va>:
 * Returns the page table entry corresponding to the virtual address,
 * according to the page structure of process # [proc_index].
 * Returns 0 if the mapping does not exist.
 */
unsigned int get_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
  106590:	57                   	push   %edi
  106591:	56                   	push   %esi
  106592:	53                   	push   %ebx
  106593:	83 ec 10             	sub    $0x10,%esp
  106596:	8b 74 24 24          	mov    0x24(%esp),%esi
  10659a:	8b 5c 24 20          	mov    0x20(%esp),%ebx
    unsigned int pde_index;
    unsigned int pte_index;
    unsigned int ptbl_entry;
    unsigned int pde;
    pde_index = vaddr / (4096 * 1024);
  10659e:	89 f7                	mov    %esi,%edi
  1065a0:	c1 ef 16             	shr    $0x16,%edi
    pde = get_pdir_entry(proc_index, pde_index);
  1065a3:	89 7c 24 04          	mov    %edi,0x4(%esp)
  1065a7:	89 1c 24             	mov    %ebx,(%esp)
  1065aa:	e8 c1 fe ff ff       	call   106470 <get_pdir_entry>
    if (pde == 0)
      return 0;
  1065af:	31 d2                	xor    %edx,%edx
    unsigned int pte_index;
    unsigned int ptbl_entry;
    unsigned int pde;
    pde_index = vaddr / (4096 * 1024);
    pde = get_pdir_entry(proc_index, pde_index);
    if (pde == 0)
  1065b1:	85 c0                	test   %eax,%eax
  1065b3:	74 1b                	je     1065d0 <get_ptbl_entry_by_va+0x40>
      return 0;
    pte_index = (vaddr / 4096) % 1024;
  1065b5:	c1 ee 0c             	shr    $0xc,%esi
  1065b8:	81 e6 ff 03 00 00    	and    $0x3ff,%esi
    ptbl_entry = get_ptbl_entry(proc_index, pde_index, pte_index);
  1065be:	89 74 24 08          	mov    %esi,0x8(%esp)
  1065c2:	89 7c 24 04          	mov    %edi,0x4(%esp)
  1065c6:	89 1c 24             	mov    %ebx,(%esp)
  1065c9:	e8 22 ff ff ff       	call   1064f0 <get_ptbl_entry>
  1065ce:	89 c2                	mov    %eax,%edx
    return ptbl_entry;
}         
  1065d0:	83 c4 10             	add    $0x10,%esp
  1065d3:	89 d0                	mov    %edx,%eax
  1065d5:	5b                   	pop    %ebx
  1065d6:	5e                   	pop    %esi
  1065d7:	5f                   	pop    %edi
  1065d8:	c3                   	ret    
  1065d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001065e0 <get_pdir_entry_by_va>:
unsigned int get_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
    unsigned int pde_index;
    unsigned int page_index;
    pde_index = vaddr / (4096 * 1024);
    page_index = get_pdir_entry(proc_index, pde_index);
  1065e0:	c1 6c 24 08 16       	shrl   $0x16,0x8(%esp)
  1065e5:	e9 86 fe ff ff       	jmp    106470 <get_pdir_entry>
  1065ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001065f0 <rmv_ptbl_entry_by_va>:
    return page_index;
}

// removes the page table entry for the given virtual address
void rmv_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
  1065f0:	83 ec 1c             	sub    $0x1c,%esp
  1065f3:	8b 54 24 24          	mov    0x24(%esp),%edx
    unsigned int pde_index;
    unsigned int pte_index;
    pde_index = vaddr / (4096 * 1024);
    pte_index = (vaddr / 4096) % 1024;
  1065f7:	89 d0                	mov    %edx,%eax
  1065f9:	c1 e8 0c             	shr    $0xc,%eax
  1065fc:	25 ff 03 00 00       	and    $0x3ff,%eax
    rmv_ptbl_entry(proc_index, pde_index, pte_index);
  106601:	89 44 24 08          	mov    %eax,0x8(%esp)
  106605:	8b 44 24 20          	mov    0x20(%esp),%eax
// removes the page table entry for the given virtual address
void rmv_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
    unsigned int pde_index;
    unsigned int pte_index;
    pde_index = vaddr / (4096 * 1024);
  106609:	c1 ea 16             	shr    $0x16,%edx
    pte_index = (vaddr / 4096) % 1024;
    rmv_ptbl_entry(proc_index, pde_index, pte_index);
  10660c:	89 54 24 04          	mov    %edx,0x4(%esp)
  106610:	89 04 24             	mov    %eax,(%esp)
  106613:	e8 48 ff ff ff       	call   106560 <rmv_ptbl_entry>
}
  106618:	83 c4 1c             	add    $0x1c,%esp
  10661b:	c3                   	ret    
  10661c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106620 <rmv_pdir_entry_by_va>:
// removes the page directory entry for the given virtual address
void rmv_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
    unsigned int pde_index;
    pde_index = vaddr / (4096 * 1024);
    rmv_pdir_entry(proc_index, pde_index);
  106620:	c1 6c 24 08 16       	shrl   $0x16,0x8(%esp)
  106625:	e9 a6 fe ff ff       	jmp    1064d0 <rmv_pdir_entry>
  10662a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106630 <set_ptbl_entry_by_va>:
}

// maps the virtual address [vaddr] to the physical page # [page_index] with permission [perm]
// you do not need to worry about the page directory entry. just map the page table entry.
void set_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr, unsigned int page_index, unsigned int perm)
{
  106630:	83 ec 2c             	sub    $0x2c,%esp
    unsigned int pde_index;
    unsigned int pte_index;
    pde_index = vaddr / (4096 * 1024);
    pte_index = (vaddr / 4096) % 1024;
    set_ptbl_entry(proc_index, pde_index, pte_index, page_index, perm);
  106633:	8b 44 24 3c          	mov    0x3c(%esp),%eax
}

// maps the virtual address [vaddr] to the physical page # [page_index] with permission [perm]
// you do not need to worry about the page directory entry. just map the page table entry.
void set_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr, unsigned int page_index, unsigned int perm)
{
  106637:	8b 54 24 34          	mov    0x34(%esp),%edx
    unsigned int pde_index;
    unsigned int pte_index;
    pde_index = vaddr / (4096 * 1024);
    pte_index = (vaddr / 4096) % 1024;
    set_ptbl_entry(proc_index, pde_index, pte_index, page_index, perm);
  10663b:	89 44 24 10          	mov    %eax,0x10(%esp)
  10663f:	8b 44 24 38          	mov    0x38(%esp),%eax
  106643:	89 44 24 0c          	mov    %eax,0xc(%esp)
void set_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr, unsigned int page_index, unsigned int perm)
{
    unsigned int pde_index;
    unsigned int pte_index;
    pde_index = vaddr / (4096 * 1024);
    pte_index = (vaddr / 4096) % 1024;
  106647:	89 d0                	mov    %edx,%eax
  106649:	c1 e8 0c             	shr    $0xc,%eax
  10664c:	25 ff 03 00 00       	and    $0x3ff,%eax
    set_ptbl_entry(proc_index, pde_index, pte_index, page_index, perm);
  106651:	89 44 24 08          	mov    %eax,0x8(%esp)
  106655:	8b 44 24 30          	mov    0x30(%esp),%eax
// you do not need to worry about the page directory entry. just map the page table entry.
void set_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr, unsigned int page_index, unsigned int perm)
{
    unsigned int pde_index;
    unsigned int pte_index;
    pde_index = vaddr / (4096 * 1024);
  106659:	c1 ea 16             	shr    $0x16,%edx
    pte_index = (vaddr / 4096) % 1024;
    set_ptbl_entry(proc_index, pde_index, pte_index, page_index, perm);
  10665c:	89 54 24 04          	mov    %edx,0x4(%esp)
  106660:	89 04 24             	mov    %eax,(%esp)
  106663:	e8 a8 fe ff ff       	call   106510 <set_ptbl_entry>
}
  106668:	83 c4 2c             	add    $0x2c,%esp
  10666b:	c3                   	ret    
  10666c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106670 <set_pdir_entry_by_va>:

// registers the mapping from [vaddr] to physical page # [page_index] in the page directory
void set_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr, unsigned int page_index)
{
  106670:	8b 44 24 08          	mov    0x8(%esp),%eax
    unsigned int pde_index;
    pde_index = vaddr / (4096 * 1024);
  106674:	c1 e8 16             	shr    $0x16,%eax
    set_pdir_entry(proc_index, pde_index, page_index);
  106677:	89 44 24 08          	mov    %eax,0x8(%esp)
  10667b:	e9 10 fe ff ff       	jmp    106490 <set_pdir_entry>

00106680 <idptbl_init>:

// initializes the identity page table
// the permission for the kernel memory should be PTE_P, PTE_W, and PTE_G,
// while the permission for the rest should be PTE_P and PTE_W.
void idptbl_init(unsigned int mbi_adr)
{
  106680:	57                   	push   %edi
    unsigned int i, j;
    unsigned int perm;
    container_init(mbi_adr);

    i = 0;
  106681:	31 ff                	xor    %edi,%edi

// initializes the identity page table
// the permission for the kernel memory should be PTE_P, PTE_W, and PTE_G,
// while the permission for the rest should be PTE_P and PTE_W.
void idptbl_init(unsigned int mbi_adr)
{
  106683:	56                   	push   %esi
  106684:	53                   	push   %ebx
  106685:	83 ec 10             	sub    $0x10,%esp
    unsigned int i, j;
    unsigned int perm;
    container_init(mbi_adr);
  106688:	8b 44 24 20          	mov    0x20(%esp),%eax
  10668c:	89 04 24             	mov    %eax,(%esp)
  10668f:	e8 4c fb ff ff       	call   1061e0 <container_init>
  106694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  106698:	8d 87 00 ff ff ff    	lea    -0x100(%edi),%eax

    i = 0;
    while(i < 1024)
    {
      if (i < 256 || i >= 960)
        perm = PTE_P | PTE_W | PTE_G;
  10669e:	3d c0 02 00 00       	cmp    $0x2c0,%eax
  1066a3:	19 f6                	sbb    %esi,%esi
      else
        perm = PTE_P | PTE_W;
      j = 0;
  1066a5:	31 db                	xor    %ebx,%ebx

    i = 0;
    while(i < 1024)
    {
      if (i < 256 || i >= 960)
        perm = PTE_P | PTE_W | PTE_G;
  1066a7:	81 e6 00 ff ff ff    	and    $0xffffff00,%esi
  1066ad:	81 c6 03 01 00 00    	add    $0x103,%esi
  1066b3:	90                   	nop
  1066b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      else
        perm = PTE_P | PTE_W;
      j = 0;
      while(j < 1024)
      {
        set_ptbl_entry_identity(i, j, perm);
  1066b8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
        j ++;
  1066bc:	83 c3 01             	add    $0x1,%ebx
      else
        perm = PTE_P | PTE_W;
      j = 0;
      while(j < 1024)
      {
        set_ptbl_entry_identity(i, j, perm);
  1066bf:	89 74 24 08          	mov    %esi,0x8(%esp)
  1066c3:	89 3c 24             	mov    %edi,(%esp)
  1066c6:	e8 75 fe ff ff       	call   106540 <set_ptbl_entry_identity>
      if (i < 256 || i >= 960)
        perm = PTE_P | PTE_W | PTE_G;
      else
        perm = PTE_P | PTE_W;
      j = 0;
      while(j < 1024)
  1066cb:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
  1066d1:	75 e5                	jne    1066b8 <idptbl_init+0x38>
      {
        set_ptbl_entry_identity(i, j, perm);
        j ++;
      }
      i ++;
  1066d3:	83 c7 01             	add    $0x1,%edi
    unsigned int i, j;
    unsigned int perm;
    container_init(mbi_adr);

    i = 0;
    while(i < 1024)
  1066d6:	81 ff 00 04 00 00    	cmp    $0x400,%edi
  1066dc:	75 ba                	jne    106698 <idptbl_init+0x18>
        set_ptbl_entry_identity(i, j, perm);
        j ++;
      }
      i ++;
    }
}
  1066de:	83 c4 10             	add    $0x10,%esp
  1066e1:	5b                   	pop    %ebx
  1066e2:	5e                   	pop    %esi
  1066e3:	5f                   	pop    %edi
  1066e4:	c3                   	ret    
  1066e5:	66 90                	xchg   %ax,%ax
  1066e7:	66 90                	xchg   %ax,%ax
  1066e9:	66 90                	xchg   %ax,%ax
  1066eb:	66 90                	xchg   %ax,%ax
  1066ed:	66 90                	xchg   %ax,%ax
  1066ef:	90                   	nop

001066f0 <pdir_init>:
 * For each process from id 0 to NUM_IDS -1,
 * set the page directory entries sothat the kernel portion of the map as identity map,
 * and the rest of page directories are unmmaped.
 */
void pdir_init(unsigned int mbi_adr)
{
  1066f0:	56                   	push   %esi
    unsigned int i, j;
    idptbl_init(mbi_adr);

    i = 0;
  1066f1:	31 f6                	xor    %esi,%esi
 * For each process from id 0 to NUM_IDS -1,
 * set the page directory entries sothat the kernel portion of the map as identity map,
 * and the rest of page directories are unmmaped.
 */
void pdir_init(unsigned int mbi_adr)
{
  1066f3:	53                   	push   %ebx
  1066f4:	83 ec 14             	sub    $0x14,%esp
    unsigned int i, j;
    idptbl_init(mbi_adr);
  1066f7:	8b 44 24 20          	mov    0x20(%esp),%eax
  1066fb:	89 04 24             	mov    %eax,(%esp)
  1066fe:	e8 7d ff ff ff       	call   106680 <idptbl_init>
  106703:	90                   	nop
  106704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 * For each process from id 0 to NUM_IDS -1,
 * set the page directory entries sothat the kernel portion of the map as identity map,
 * and the rest of page directories are unmmaped.
 */
void pdir_init(unsigned int mbi_adr)
{
  106708:	31 db                	xor    %ebx,%ebx
  10670a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  106710:	8d 83 00 ff ff ff    	lea    -0x100(%ebx),%eax
    while(i < NUM_IDS)
    {
        j = 0;
        while(j < 1024)    
        {
            if (j < 256 || j >= 960)    
  106716:	3d bf 02 00 00       	cmp    $0x2bf,%eax
              set_pdir_entry_identity(i, j);
  10671b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  10671f:	89 34 24             	mov    %esi,(%esp)
    while(i < NUM_IDS)
    {
        j = 0;
        while(j < 1024)    
        {
            if (j < 256 || j >= 960)    
  106722:	77 1e                	ja     106742 <pdir_init+0x52>
              set_pdir_entry_identity(i, j);
            else
              rmv_pdir_entry(i, j);
  106724:	e8 a7 fd ff ff       	call   1064d0 <rmv_pdir_entry>
            j++;
  106729:	83 c3 01             	add    $0x1,%ebx

    i = 0;
    while(i < NUM_IDS)
    {
        j = 0;
        while(j < 1024)    
  10672c:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
  106732:	75 dc                	jne    106710 <pdir_init+0x20>
              set_pdir_entry_identity(i, j);
            else
              rmv_pdir_entry(i, j);
            j++;
        }
        i++;
  106734:	83 c6 01             	add    $0x1,%esi
{
    unsigned int i, j;
    idptbl_init(mbi_adr);

    i = 0;
    while(i < NUM_IDS)
  106737:	83 fe 40             	cmp    $0x40,%esi
  10673a:	75 cc                	jne    106708 <pdir_init+0x18>
              rmv_pdir_entry(i, j);
            j++;
        }
        i++;
    }
}
  10673c:	83 c4 14             	add    $0x14,%esp
  10673f:	5b                   	pop    %ebx
  106740:	5e                   	pop    %esi
  106741:	c3                   	ret    
    {
        j = 0;
        while(j < 1024)    
        {
            if (j < 256 || j >= 960)    
              set_pdir_entry_identity(i, j);
  106742:	e8 69 fd ff ff       	call   1064b0 <set_pdir_entry_identity>
  106747:	eb e0                	jmp    106729 <pdir_init+0x39>
  106749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00106750 <alloc_ptbl>:
 * and clears (set to 0) the whole page table entries for this newly mapped page table.
 * It returns the page index of the newly allocated physical page.
 * In the case when there's no physical page available, it returns 0.
 */
unsigned int alloc_ptbl(unsigned int proc_index, unsigned int vadr)
{
  106750:	55                   	push   %ebp
  106751:	57                   	push   %edi
  106752:	56                   	push   %esi
  106753:	53                   	push   %ebx
  106754:	83 ec 1c             	sub    $0x1c,%esp
  106757:	8b 74 24 30          	mov    0x30(%esp),%esi
  unsigned int i;
  unsigned int pi;
  unsigned int pde_index;
  pi = container_alloc(proc_index);
  10675b:	89 34 24             	mov    %esi,(%esp)
  10675e:	e8 0d fc ff ff       	call   106370 <container_alloc>
  if (pi != 0)
  106763:	85 c0                	test   %eax,%eax
unsigned int alloc_ptbl(unsigned int proc_index, unsigned int vadr)
{
  unsigned int i;
  unsigned int pi;
  unsigned int pde_index;
  pi = container_alloc(proc_index);
  106765:	89 c5                	mov    %eax,%ebp
  if (pi != 0)
  106767:	75 0f                	jne    106778 <alloc_ptbl+0x28>
      rmv_ptbl_entry(proc_index, pde_index, i);
      i ++;
    }     
  }       
  return pi;
}
  106769:	83 c4 1c             	add    $0x1c,%esp
  10676c:	89 e8                	mov    %ebp,%eax
  10676e:	5b                   	pop    %ebx
  10676f:	5e                   	pop    %esi
  106770:	5f                   	pop    %edi
  106771:	5d                   	pop    %ebp
  106772:	c3                   	ret    
  106773:	90                   	nop
  106774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  unsigned int pi;
  unsigned int pde_index;
  pi = container_alloc(proc_index);
  if (pi != 0)
  {
    set_pdir_entry_by_va(proc_index, vadr, pi);
  106778:	89 44 24 08          	mov    %eax,0x8(%esp)
  10677c:	8b 44 24 34          	mov    0x34(%esp),%eax
    pde_index = vadr / (4096 * 1024);
    i = 0;
  106780:	31 db                	xor    %ebx,%ebx
  unsigned int pi;
  unsigned int pde_index;
  pi = container_alloc(proc_index);
  if (pi != 0)
  {
    set_pdir_entry_by_va(proc_index, vadr, pi);
  106782:	89 34 24             	mov    %esi,(%esp)
  106785:	89 44 24 04          	mov    %eax,0x4(%esp)
  106789:	e8 e2 fe ff ff       	call   106670 <set_pdir_entry_by_va>
    pde_index = vadr / (4096 * 1024);
  10678e:	8b 7c 24 34          	mov    0x34(%esp),%edi
  106792:	c1 ef 16             	shr    $0x16,%edi
  106795:	8d 76 00             	lea    0x0(%esi),%esi
    i = 0;
    while (i < 1024)        
    {
      rmv_ptbl_entry(proc_index, pde_index, i);
  106798:	89 5c 24 08          	mov    %ebx,0x8(%esp)
      i ++;
  10679c:	83 c3 01             	add    $0x1,%ebx
    set_pdir_entry_by_va(proc_index, vadr, pi);
    pde_index = vadr / (4096 * 1024);
    i = 0;
    while (i < 1024)        
    {
      rmv_ptbl_entry(proc_index, pde_index, i);
  10679f:	89 7c 24 04          	mov    %edi,0x4(%esp)
  1067a3:	89 34 24             	mov    %esi,(%esp)
  1067a6:	e8 b5 fd ff ff       	call   106560 <rmv_ptbl_entry>
  if (pi != 0)
  {
    set_pdir_entry_by_va(proc_index, vadr, pi);
    pde_index = vadr / (4096 * 1024);
    i = 0;
    while (i < 1024)        
  1067ab:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
  1067b1:	75 e5                	jne    106798 <alloc_ptbl+0x48>
      rmv_ptbl_entry(proc_index, pde_index, i);
      i ++;
    }     
  }       
  return pi;
}
  1067b3:	83 c4 1c             	add    $0x1c,%esp
  1067b6:	89 e8                	mov    %ebp,%eax
  1067b8:	5b                   	pop    %ebx
  1067b9:	5e                   	pop    %esi
  1067ba:	5f                   	pop    %edi
  1067bb:	5d                   	pop    %ebp
  1067bc:	c3                   	ret    
  1067bd:	8d 76 00             	lea    0x0(%esi),%esi

001067c0 <free_ptbl>:

// Reverse operation of alloc_ptbl.
// Removes corresponding page directory entry,
// and frees the page for the page table entries (with container_free).
void free_ptbl(unsigned int proc_index, unsigned int vadr)
{
  1067c0:	57                   	push   %edi
  1067c1:	56                   	push   %esi
  1067c2:	53                   	push   %ebx
  1067c3:	83 ec 10             	sub    $0x10,%esp
  1067c6:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  1067ca:	8b 74 24 24          	mov    0x24(%esp),%esi
  unsigned int pde;
  pde = get_pdir_entry_by_va(proc_index, vadr);
  1067ce:	89 1c 24             	mov    %ebx,(%esp)
  1067d1:	89 74 24 04          	mov    %esi,0x4(%esp)
  1067d5:	e8 06 fe ff ff       	call   1065e0 <get_pdir_entry_by_va>
  rmv_pdir_entry_by_va(proc_index, vadr);
  1067da:	89 74 24 04          	mov    %esi,0x4(%esp)
  1067de:	89 1c 24             	mov    %ebx,(%esp)
// Removes corresponding page directory entry,
// and frees the page for the page table entries (with container_free).
void free_ptbl(unsigned int proc_index, unsigned int vadr)
{
  unsigned int pde;
  pde = get_pdir_entry_by_va(proc_index, vadr);
  1067e1:	89 c7                	mov    %eax,%edi
  rmv_pdir_entry_by_va(proc_index, vadr);
  1067e3:	e8 38 fe ff ff       	call   106620 <rmv_pdir_entry_by_va>
  container_free(proc_index, pde / PAGESIZE);
  1067e8:	c1 ef 0c             	shr    $0xc,%edi
  1067eb:	89 7c 24 24          	mov    %edi,0x24(%esp)
  1067ef:	89 5c 24 20          	mov    %ebx,0x20(%esp)
}
  1067f3:	83 c4 10             	add    $0x10,%esp
  1067f6:	5b                   	pop    %ebx
  1067f7:	5e                   	pop    %esi
  1067f8:	5f                   	pop    %edi
void free_ptbl(unsigned int proc_index, unsigned int vadr)
{
  unsigned int pde;
  pde = get_pdir_entry_by_va(proc_index, vadr);
  rmv_pdir_entry_by_va(proc_index, vadr);
  container_free(proc_index, pde / PAGESIZE);
  1067f9:	e9 a2 fb ff ff       	jmp    1063a0 <container_free>
  1067fe:	66 90                	xchg   %ax,%ax

00106800 <pdir_init_kern>:
/**
 * Sets the entire page map for process 0 as identity map.
 * Note that part of the task is already completed by pdir_init.
 */
void pdir_init_kern(unsigned int mbi_adr)
{
  106800:	53                   	push   %ebx
    unsigned int i;
    pdir_init(mbi_adr);
    
    i = 256;
  106801:	bb 00 01 00 00       	mov    $0x100,%ebx
/**
 * Sets the entire page map for process 0 as identity map.
 * Note that part of the task is already completed by pdir_init.
 */
void pdir_init_kern(unsigned int mbi_adr)
{
  106806:	83 ec 18             	sub    $0x18,%esp
    unsigned int i;
    pdir_init(mbi_adr);
  106809:	8b 44 24 20          	mov    0x20(%esp),%eax
  10680d:	89 04 24             	mov    %eax,(%esp)
  106810:	e8 db fe ff ff       	call   1066f0 <pdir_init>
  106815:	8d 76 00             	lea    0x0(%esi),%esi
    
    i = 256;
    while(i < 960)
    {
        set_pdir_entry_identity(0, i);
  106818:	89 5c 24 04          	mov    %ebx,0x4(%esp)
        i ++;
  10681c:	83 c3 01             	add    $0x1,%ebx
    pdir_init(mbi_adr);
    
    i = 256;
    while(i < 960)
    {
        set_pdir_entry_identity(0, i);
  10681f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  106826:	e8 85 fc ff ff       	call   1064b0 <set_pdir_entry_identity>
{
    unsigned int i;
    pdir_init(mbi_adr);
    
    i = 256;
    while(i < 960)
  10682b:	81 fb c0 03 00 00    	cmp    $0x3c0,%ebx
  106831:	75 e5                	jne    106818 <pdir_init_kern+0x18>
    {
        set_pdir_entry_identity(0, i);
        i ++;
    }
}
  106833:	83 c4 18             	add    $0x18,%esp
  106836:	5b                   	pop    %ebx
  106837:	c3                   	ret    
  106838:	90                   	nop
  106839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00106840 <map_page>:
 * In the case of error (when the allocation fails), it returns the constant MagicNumber defined in lib/x86.h,
 * and when the page table is not set up , it returns the physical page index for the newly alloacted page table,
 * otherwise, it returns 0.
 */
unsigned int map_page(unsigned int proc_index, unsigned int vadr, unsigned int page_index, unsigned int perm)
{   
  106840:	57                   	push   %edi
  unsigned int pdir_entry; 
  unsigned int result;
  pdir_entry = get_pdir_entry_by_va(proc_index, vadr);
  if (pdir_entry != 0)
    result = 0;
  106841:	31 ff                	xor    %edi,%edi
 * In the case of error (when the allocation fails), it returns the constant MagicNumber defined in lib/x86.h,
 * and when the page table is not set up , it returns the physical page index for the newly alloacted page table,
 * otherwise, it returns 0.
 */
unsigned int map_page(unsigned int proc_index, unsigned int vadr, unsigned int page_index, unsigned int perm)
{   
  106843:	56                   	push   %esi
  106844:	53                   	push   %ebx
  106845:	83 ec 10             	sub    $0x10,%esp
  106848:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  10684c:	8b 74 24 24          	mov    0x24(%esp),%esi
  unsigned int pdir_entry; 
  unsigned int result;
  pdir_entry = get_pdir_entry_by_va(proc_index, vadr);
  106850:	89 1c 24             	mov    %ebx,(%esp)
  106853:	89 74 24 04          	mov    %esi,0x4(%esp)
  106857:	e8 84 fd ff ff       	call   1065e0 <get_pdir_entry_by_va>
  if (pdir_entry != 0)
  10685c:	85 c0                	test   %eax,%eax
  10685e:	74 28                	je     106888 <map_page+0x48>
    result = alloc_ptbl(proc_index, vadr);
    if (result == 0)
      result = MagicNumber;
  }
  if (result != MagicNumber)
    set_ptbl_entry_by_va(proc_index, vadr, page_index, perm);
  106860:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  106864:	89 74 24 04          	mov    %esi,0x4(%esp)
  106868:	89 1c 24             	mov    %ebx,(%esp)
  10686b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10686f:	8b 44 24 28          	mov    0x28(%esp),%eax
  106873:	89 44 24 08          	mov    %eax,0x8(%esp)
  106877:	e8 b4 fd ff ff       	call   106630 <set_ptbl_entry_by_va>
  return result;
}
  10687c:	83 c4 10             	add    $0x10,%esp
  10687f:	89 f8                	mov    %edi,%eax
  106881:	5b                   	pop    %ebx
  106882:	5e                   	pop    %esi
  106883:	5f                   	pop    %edi
  106884:	c3                   	ret    
  106885:	8d 76 00             	lea    0x0(%esi),%esi
  pdir_entry = get_pdir_entry_by_va(proc_index, vadr);
  if (pdir_entry != 0)
    result = 0;
  else
  {
    result = alloc_ptbl(proc_index, vadr);
  106888:	89 74 24 04          	mov    %esi,0x4(%esp)
  10688c:	89 1c 24             	mov    %ebx,(%esp)
  10688f:	e8 bc fe ff ff       	call   106750 <alloc_ptbl>
    if (result == 0)
  106894:	85 c0                	test   %eax,%eax
  pdir_entry = get_pdir_entry_by_va(proc_index, vadr);
  if (pdir_entry != 0)
    result = 0;
  else
  {
    result = alloc_ptbl(proc_index, vadr);
  106896:	89 c7                	mov    %eax,%edi
    if (result == 0)
  106898:	75 0e                	jne    1068a8 <map_page+0x68>
      result = MagicNumber;
  }
  if (result != MagicNumber)
    set_ptbl_entry_by_va(proc_index, vadr, page_index, perm);
  return result;
}
  10689a:	83 c4 10             	add    $0x10,%esp
    result = 0;
  else
  {
    result = alloc_ptbl(proc_index, vadr);
    if (result == 0)
      result = MagicNumber;
  10689d:	bf 01 00 10 00       	mov    $0x100001,%edi
  }
  if (result != MagicNumber)
    set_ptbl_entry_by_va(proc_index, vadr, page_index, perm);
  return result;
}
  1068a2:	89 f8                	mov    %edi,%eax
  1068a4:	5b                   	pop    %ebx
  1068a5:	5e                   	pop    %esi
  1068a6:	5f                   	pop    %edi
  1068a7:	c3                   	ret    
  {
    result = alloc_ptbl(proc_index, vadr);
    if (result == 0)
      result = MagicNumber;
  }
  if (result != MagicNumber)
  1068a8:	3d 01 00 10 00       	cmp    $0x100001,%eax
  1068ad:	74 cd                	je     10687c <map_page+0x3c>
  1068af:	eb af                	jmp    106860 <map_page+0x20>
  1068b1:	eb 0d                	jmp    1068c0 <unmap_page>
  1068b3:	90                   	nop
  1068b4:	90                   	nop
  1068b5:	90                   	nop
  1068b6:	90                   	nop
  1068b7:	90                   	nop
  1068b8:	90                   	nop
  1068b9:	90                   	nop
  1068ba:	90                   	nop
  1068bb:	90                   	nop
  1068bc:	90                   	nop
  1068bd:	90                   	nop
  1068be:	90                   	nop
  1068bf:	90                   	nop

001068c0 <unmap_page>:
 * Nothing should be done if the mapping no longer exists.
 * You do not need to unmap the page table from the page directory.
 * It should return the corresponding page table entry.
 */
unsigned int unmap_page(unsigned int proc_index, unsigned int vadr)
{
  1068c0:	56                   	push   %esi
  1068c1:	53                   	push   %ebx
  1068c2:	83 ec 14             	sub    $0x14,%esp
  1068c5:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  1068c9:	8b 74 24 24          	mov    0x24(%esp),%esi
  unsigned int ptbl_entry;
  unsigned int count;
  ptbl_entry = get_ptbl_entry_by_va(proc_index, vadr);
  1068cd:	89 1c 24             	mov    %ebx,(%esp)
  1068d0:	89 74 24 04          	mov    %esi,0x4(%esp)
  1068d4:	e8 b7 fc ff ff       	call   106590 <get_ptbl_entry_by_va>
  if (ptbl_entry != 0)
  1068d9:	85 c0                	test   %eax,%eax
  1068db:	74 14                	je     1068f1 <unmap_page+0x31>
    rmv_ptbl_entry_by_va(proc_index, vadr);
  1068dd:	89 74 24 04          	mov    %esi,0x4(%esp)
  1068e1:	89 1c 24             	mov    %ebx,(%esp)
  1068e4:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1068e8:	e8 03 fd ff ff       	call   1065f0 <rmv_ptbl_entry_by_va>
  1068ed:	8b 44 24 0c          	mov    0xc(%esp),%eax
  return ptbl_entry;
}   
  1068f1:	83 c4 14             	add    $0x14,%esp
  1068f4:	5b                   	pop    %ebx
  1068f5:	5e                   	pop    %esi
  1068f6:	c3                   	ret    
  1068f7:	66 90                	xchg   %ax,%ax
  1068f9:	66 90                	xchg   %ax,%ax
  1068fb:	66 90                	xchg   %ax,%ax
  1068fd:	66 90                	xchg   %ax,%ax
  1068ff:	90                   	nop

00106900 <paging_init>:
 * Initializes the page structures,
 * move to the page structure # 0 (kernel).
 * and turn on the paging.
 */
void paging_init(unsigned int mbi_addr)
{
  106900:	53                   	push   %ebx
  106901:	83 ec 18             	sub    $0x18,%esp
  106904:	8b 5c 24 20          	mov    0x20(%esp),%ebx
	pt_spinlock_init();
  106908:	e8 e3 fa ff ff       	call   1063f0 <pt_spinlock_init>
	pdir_init_kern(mbi_addr);
  10690d:	89 1c 24             	mov    %ebx,(%esp)
  106910:	e8 eb fe ff ff       	call   106800 <pdir_init_kern>
	pt_spinlock_acquire();
  106915:	e8 f6 fa ff ff       	call   106410 <pt_spinlock_acquire>
	set_pdir_base(0);
  10691a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  106921:	e8 2a fb ff ff       	call   106450 <set_pdir_base>
	enable_paging();
  106926:	e8 85 a5 ff ff       	call   100eb0 <enable_paging>
	pt_spinlock_release();
}
  10692b:	83 c4 18             	add    $0x18,%esp
  10692e:	5b                   	pop    %ebx
	pt_spinlock_init();
	pdir_init_kern(mbi_addr);
	pt_spinlock_acquire();
	set_pdir_base(0);
	enable_paging();
	pt_spinlock_release();
  10692f:	e9 fc fa ff ff       	jmp    106430 <pt_spinlock_release>
  106934:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10693a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00106940 <paging_init_ap>:
}

void paging_init_ap(void)
{
  106940:	83 ec 1c             	sub    $0x1c,%esp
	pt_spinlock_acquire();
  106943:	e8 c8 fa ff ff       	call   106410 <pt_spinlock_acquire>
	set_pdir_base(0);
  106948:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10694f:	e8 fc fa ff ff       	call   106450 <set_pdir_base>
	enable_paging();
  106954:	e8 57 a5 ff ff       	call   100eb0 <enable_paging>
	pt_spinlock_release();
}
  106959:	83 c4 1c             	add    $0x1c,%esp
void paging_init_ap(void)
{
	pt_spinlock_acquire();
	set_pdir_base(0);
	enable_paging();
	pt_spinlock_release();
  10695c:	e9 cf fa ff ff       	jmp    106430 <pt_spinlock_release>
  106961:	66 90                	xchg   %ax,%ax
  106963:	66 90                	xchg   %ax,%ax
  106965:	66 90                	xchg   %ax,%ax
  106967:	66 90                	xchg   %ax,%ax
  106969:	66 90                	xchg   %ax,%ax
  10696b:	66 90                	xchg   %ax,%ax
  10696d:	66 90                	xchg   %ax,%ax
  10696f:	90                   	nop

00106970 <alloc_page>:
 * It should return the physical page index registered in the page directory, i.e., the
 * return value from map_page.
 * In the case of error, it should return the MagicNumber.
 */
unsigned int alloc_page (unsigned int proc_index, unsigned int vaddr, unsigned int perm)
{
  106970:	56                   	push   %esi

	pt_spinlock_acquire();
	pi = container_alloc (proc_index);

	if (pi == 0)
		result = MagicNumber;
  106971:	be 01 00 10 00       	mov    $0x100001,%esi
 * It should return the physical page index registered in the page directory, i.e., the
 * return value from map_page.
 * In the case of error, it should return the MagicNumber.
 */
unsigned int alloc_page (unsigned int proc_index, unsigned int vaddr, unsigned int perm)
{
  106976:	53                   	push   %ebx
  106977:	83 ec 14             	sub    $0x14,%esp
  10697a:	8b 5c 24 20          	mov    0x20(%esp),%ebx
	unsigned int pi;
	unsigned int result;

	pt_spinlock_acquire();
  10697e:	e8 8d fa ff ff       	call   106410 <pt_spinlock_acquire>
	pi = container_alloc (proc_index);
  106983:	89 1c 24             	mov    %ebx,(%esp)
  106986:	e8 e5 f9 ff ff       	call   106370 <container_alloc>

	if (pi == 0)
  10698b:	85 c0                	test   %eax,%eax
  10698d:	75 11                	jne    1069a0 <alloc_page+0x30>
		result = MagicNumber;
	else
		result = map_page (proc_index, vaddr, pi, perm);


	pt_spinlock_release();
  10698f:	e8 9c fa ff ff       	call   106430 <pt_spinlock_release>
	return result;
}
  106994:	83 c4 14             	add    $0x14,%esp
  106997:	89 f0                	mov    %esi,%eax
  106999:	5b                   	pop    %ebx
  10699a:	5e                   	pop    %esi
  10699b:	c3                   	ret    
  10699c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	pi = container_alloc (proc_index);

	if (pi == 0)
		result = MagicNumber;
	else
		result = map_page (proc_index, vaddr, pi, perm);
  1069a0:	8b 54 24 28          	mov    0x28(%esp),%edx
  1069a4:	89 44 24 08          	mov    %eax,0x8(%esp)
  1069a8:	8b 44 24 24          	mov    0x24(%esp),%eax
  1069ac:	89 1c 24             	mov    %ebx,(%esp)
  1069af:	89 54 24 0c          	mov    %edx,0xc(%esp)
  1069b3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1069b7:	e8 84 fe ff ff       	call   106840 <map_page>
  1069bc:	89 c6                	mov    %eax,%esi


	pt_spinlock_release();
  1069be:	e8 6d fa ff ff       	call   106430 <pt_spinlock_release>
	return result;
}
  1069c3:	83 c4 14             	add    $0x14,%esp
  1069c6:	89 f0                	mov    %esi,%eax
  1069c8:	5b                   	pop    %ebx
  1069c9:	5e                   	pop    %esi
  1069ca:	c3                   	ret    
  1069cb:	90                   	nop
  1069cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001069d0 <alloc_mem_quota>:
 * Designate some memory quota for the next child process.
 */
unsigned int alloc_mem_quota (unsigned int id, unsigned int quota)
{
	unsigned int child;
  child = container_split (id, quota);
  1069d0:	e9 3b f9 ff ff       	jmp    106310 <container_split>
  1069d5:	66 90                	xchg   %ax,%ax
  1069d7:	66 90                	xchg   %ax,%ax
  1069d9:	66 90                	xchg   %ax,%ax
  1069db:	66 90                	xchg   %ax,%ax
  1069dd:	66 90                	xchg   %ax,%ax
  1069df:	90                   	nop

001069e0 <kctx_set_esp>:

//places to save the [NUM_IDS] kernel thread states.
struct kctx kctx_pool[NUM_IDS];

void kctx_set_esp(unsigned int pid, void *esp)
{
  1069e0:	8b 44 24 04          	mov    0x4(%esp),%eax
	kctx_pool[pid].esp = esp;
  1069e4:	8b 54 24 08          	mov    0x8(%esp),%edx
  1069e8:	8d 04 40             	lea    (%eax,%eax,2),%eax
  1069eb:	89 14 c5 00 c0 e0 00 	mov    %edx,0xe0c000(,%eax,8)
  1069f2:	c3                   	ret    
  1069f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1069f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106a00 <kctx_set_eip>:
}

void kctx_set_eip(unsigned int pid, void *eip)
{
  106a00:	8b 44 24 04          	mov    0x4(%esp),%eax
	kctx_pool[pid].eip = eip;
  106a04:	8b 54 24 08          	mov    0x8(%esp),%edx
  106a08:	8d 04 40             	lea    (%eax,%eax,2),%eax
  106a0b:	89 14 c5 14 c0 e0 00 	mov    %edx,0xe0c014(,%eax,8)
  106a12:	c3                   	ret    
  106a13:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  106a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106a20 <kctx_switch>:
/**
 * Saves the states for thread # [from_pid] and restores the states
 * for thread # [to_pid].
 */
void kctx_switch(unsigned int from_pid, unsigned int to_pid)
{
  106a20:	8b 44 24 04          	mov    0x4(%esp),%eax
  106a24:	8b 54 24 08          	mov    0x8(%esp),%edx
  //  KERN_INFO("kctx_switch: %d --> %d\n", from_pid, to_pid);
  cswitch(&kctx_pool[from_pid], &kctx_pool[to_pid]);
  106a28:	8d 04 40             	lea    (%eax,%eax,2),%eax
  106a2b:	8d 14 52             	lea    (%edx,%edx,2),%edx
  106a2e:	8d 14 d5 00 c0 e0 00 	lea    0xe0c000(,%edx,8),%edx
  106a35:	8d 04 c5 00 c0 e0 00 	lea    0xe0c000(,%eax,8),%eax
  106a3c:	89 54 24 08          	mov    %edx,0x8(%esp)
  106a40:	89 44 24 04          	mov    %eax,0x4(%esp)
  106a44:	e9 00 00 00 00       	jmp    106a49 <cswitch>

00106a49 <cswitch>:
 * void cswitch(struct kctx *from, struct kctx *to);
 */

	.globl cswitch
cswitch:
	movl	  4(%esp), %eax	/* %eax <- from */
  106a49:	8b 44 24 04          	mov    0x4(%esp),%eax
	movl	  8(%esp), %edx	/* %edx <- to */
  106a4d:	8b 54 24 08          	mov    0x8(%esp),%edx

	/* save the old kernel context */
  movl    0(%esp), %ecx
  106a51:	8b 0c 24             	mov    (%esp),%ecx
  movl    %ecx, 20(%eax)
  106a54:	89 48 14             	mov    %ecx,0x14(%eax)
	movl    %ebp, 16(%eax)
  106a57:	89 68 10             	mov    %ebp,0x10(%eax)
	movl    %ebx, 12(%eax)
  106a5a:	89 58 0c             	mov    %ebx,0xc(%eax)
	movl    %esi, 8(%eax)
  106a5d:	89 70 08             	mov    %esi,0x8(%eax)
	movl    %edi, 4(%eax)
  106a60:	89 78 04             	mov    %edi,0x4(%eax)
	movl    %esp, 0(%eax)
  106a63:	89 20                	mov    %esp,(%eax)

	/* load the new kernel context */
	movl    0(%edx), %esp
  106a65:	8b 22                	mov    (%edx),%esp
	movl    4(%edx), %edi
  106a67:	8b 7a 04             	mov    0x4(%edx),%edi
	movl    8(%edx), %esi
  106a6a:	8b 72 08             	mov    0x8(%edx),%esi
	movl    12(%edx), %ebx
  106a6d:	8b 5a 0c             	mov    0xc(%edx),%ebx
	movl    16(%edx), %ebp
  106a70:	8b 6a 10             	mov    0x10(%edx),%ebp
	movl    20(%edx), %ecx
  106a73:	8b 4a 14             	mov    0x14(%edx),%ecx
	movl	  %ecx, 0(%esp)
  106a76:	89 0c 24             	mov    %ecx,(%esp)

	xor     %eax, %eax
  106a79:	31 c0                	xor    %eax,%eax
	ret
  106a7b:	c3                   	ret    
  106a7c:	66 90                	xchg   %ax,%ax
  106a7e:	66 90                	xchg   %ax,%ax

00106a80 <kctx_new>:
 * Don't forget the stack is going down from high address to low.
 * We do not care about the rest of states when a new thread starts.
 * The function returns the child thread (process) id.
 */
unsigned int kctx_new(void *entry, unsigned int id, unsigned int quota)
{
  106a80:	53                   	push   %ebx
  106a81:	83 ec 18             	sub    $0x18,%esp
  unsigned int pid;
  pid = alloc_mem_quota(id, quota);
  106a84:	8b 44 24 28          	mov    0x28(%esp),%eax
  106a88:	89 44 24 04          	mov    %eax,0x4(%esp)
  106a8c:	8b 44 24 24          	mov    0x24(%esp),%eax
  106a90:	89 04 24             	mov    %eax,(%esp)
  106a93:	e8 38 ff ff ff       	call   1069d0 <alloc_mem_quota>
  106a98:	89 c3                	mov    %eax,%ebx
  kctx_set_esp(pid, proc_kstack[pid].kstack_hi);
  106a9a:	c1 e0 0c             	shl    $0xc,%eax
  106a9d:	05 00 a0 98 00       	add    $0x98a000,%eax
  106aa2:	89 44 24 04          	mov    %eax,0x4(%esp)
  106aa6:	89 1c 24             	mov    %ebx,(%esp)
  106aa9:	e8 32 ff ff ff       	call   1069e0 <kctx_set_esp>
  kctx_set_eip(pid, entry);
  106aae:	8b 44 24 20          	mov    0x20(%esp),%eax
  106ab2:	89 1c 24             	mov    %ebx,(%esp)
  106ab5:	89 44 24 04          	mov    %eax,0x4(%esp)
  106ab9:	e8 42 ff ff ff       	call   106a00 <kctx_set_eip>

  return pid;
}
  106abe:	83 c4 18             	add    $0x18,%esp
  106ac1:	89 d8                	mov    %ebx,%eax
  106ac3:	5b                   	pop    %ebx
  106ac4:	c3                   	ret    
  106ac5:	66 90                	xchg   %ax,%ax
  106ac7:	66 90                	xchg   %ax,%ax
  106ac9:	66 90                	xchg   %ax,%ax
  106acb:	66 90                	xchg   %ax,%ax
  106acd:	66 90                	xchg   %ax,%ax
  106acf:	90                   	nop

00106ad0 <tcb_get_state>:
struct TCB TCBPool[NUM_IDS];


unsigned int tcb_get_state(unsigned int pid)
{
	return TCBPool[pid].state;
  106ad0:	6b 44 24 04 54       	imul   $0x54,0x4(%esp),%eax
  106ad5:	8b 80 00 c6 e0 00    	mov    0xe0c600(%eax),%eax
}
  106adb:	c3                   	ret    
  106adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106ae0 <tcb_set_state>:

void tcb_set_state(unsigned int pid, unsigned int state)
{
  //KERN_INFO("_____0_____ tcb_set_state: %d -> %d\n", pid, state);
  TCBPool[pid].state = state;
  106ae0:	6b 44 24 04 54       	imul   $0x54,0x4(%esp),%eax
  106ae5:	8b 54 24 08          	mov    0x8(%esp),%edx
  106ae9:	89 90 00 c6 e0 00    	mov    %edx,0xe0c600(%eax)
  106aef:	c3                   	ret    

00106af0 <tcb_get_prev>:
}

unsigned int tcb_get_prev(unsigned int pid)
{
	return TCBPool[pid].prev;
  106af0:	6b 44 24 04 54       	imul   $0x54,0x4(%esp),%eax
  106af5:	8b 80 04 c6 e0 00    	mov    0xe0c604(%eax),%eax
}
  106afb:	c3                   	ret    
  106afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106b00 <tcb_set_prev>:

void tcb_set_prev(unsigned int pid, unsigned int prev_pid)
{
	TCBPool[pid].prev = prev_pid;
  106b00:	6b 44 24 04 54       	imul   $0x54,0x4(%esp),%eax
  106b05:	8b 54 24 08          	mov    0x8(%esp),%edx
  106b09:	89 90 04 c6 e0 00    	mov    %edx,0xe0c604(%eax)
  106b0f:	c3                   	ret    

00106b10 <tcb_get_next>:
}

unsigned int tcb_get_next(unsigned int pid)
{
	return TCBPool[pid].next;
  106b10:	6b 44 24 04 54       	imul   $0x54,0x4(%esp),%eax
  106b15:	8b 80 08 c6 e0 00    	mov    0xe0c608(%eax),%eax
}
  106b1b:	c3                   	ret    
  106b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106b20 <tcb_set_next>:

void tcb_set_next(unsigned int pid, unsigned int next_pid)
{
	TCBPool[pid].next = next_pid;
  106b20:	6b 44 24 04 54       	imul   $0x54,0x4(%esp),%eax
  106b25:	8b 54 24 08          	mov    0x8(%esp),%edx
  106b29:	89 90 08 c6 e0 00    	mov    %edx,0xe0c608(%eax)
  106b2f:	c3                   	ret    

00106b30 <tcb_init_at_id>:
}

void tcb_init_at_id(unsigned int pid)
{
  106b30:	53                   	push   %ebx
  106b31:	83 ec 18             	sub    $0x18,%esp
	TCBPool[pid].state = TSTATE_DEAD;
  106b34:	6b 5c 24 20 54       	imul   $0x54,0x20(%esp),%ebx
	TCBPool[pid].prev = NUM_IDS;
	TCBPool[pid].next = NUM_IDS;
	TCBPool[pid].channel = 0;
	memzero(TCBPool[pid].openfiles, sizeof (TCBPool[pid].openfiles));
  106b39:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  106b40:	00 
  106b41:	8d 83 10 c6 e0 00    	lea    0xe0c610(%ebx),%eax
  106b47:	89 04 24             	mov    %eax,(%esp)
	TCBPool[pid].next = next_pid;
}

void tcb_init_at_id(unsigned int pid)
{
	TCBPool[pid].state = TSTATE_DEAD;
  106b4a:	c7 83 00 c6 e0 00 03 	movl   $0x3,0xe0c600(%ebx)
  106b51:	00 00 00 
	TCBPool[pid].prev = NUM_IDS;
  106b54:	c7 83 04 c6 e0 00 40 	movl   $0x40,0xe0c604(%ebx)
  106b5b:	00 00 00 
	TCBPool[pid].next = NUM_IDS;
  106b5e:	c7 83 08 c6 e0 00 40 	movl   $0x40,0xe0c608(%ebx)
  106b65:	00 00 00 
	TCBPool[pid].channel = 0;
  106b68:	c7 83 0c c6 e0 00 00 	movl   $0x0,0xe0c60c(%ebx)
  106b6f:	00 00 00 
	memzero(TCBPool[pid].openfiles, sizeof (TCBPool[pid].openfiles));
  106b72:	e8 09 d4 ff ff       	call   103f80 <memzero>
	//	memzero(TCBPool[pid].cwd, sizeof *(TCBPool[pid].cwd));
	TCBPool[pid].cwd = namei("/");
  106b77:	c7 04 24 4d c3 10 00 	movl   $0x10c34d,(%esp)
  106b7e:	e8 bd 2d 00 00       	call   109940 <namei>
  106b83:	89 83 50 c6 e0 00    	mov    %eax,0xe0c650(%ebx)
}
  106b89:	83 c4 18             	add    $0x18,%esp
  106b8c:	5b                   	pop    %ebx
  106b8d:	c3                   	ret    
  106b8e:	66 90                	xchg   %ax,%ax

00106b90 <tcb_get_chan>:

/*** NEW ***/

void* tcb_get_chan(unsigned int pid)
{
  return TCBPool[pid].channel;
  106b90:	6b 44 24 04 54       	imul   $0x54,0x4(%esp),%eax
  106b95:	8b 80 0c c6 e0 00    	mov    0xe0c60c(%eax),%eax
}
  106b9b:	c3                   	ret    
  106b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106ba0 <tcb_set_chan>:

void tcb_set_chan(unsigned int pid, void *chan)
{
  TCBPool[pid].channel = chan;
  106ba0:	6b 44 24 04 54       	imul   $0x54,0x4(%esp),%eax
  106ba5:	8b 54 24 08          	mov    0x8(%esp),%edx
  106ba9:	89 90 0c c6 e0 00    	mov    %edx,0xe0c60c(%eax)
  106baf:	c3                   	ret    

00106bb0 <tcb_get_openfiles>:
}

struct file** tcb_get_openfiles(unsigned int pid)
{
  return TCBPool[pid].openfiles;
  106bb0:	6b 44 24 04 54       	imul   $0x54,0x4(%esp),%eax
  106bb5:	05 10 c6 e0 00       	add    $0xe0c610,%eax
}
  106bba:	c3                   	ret    
  106bbb:	90                   	nop
  106bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106bc0 <tcb_set_openfiles>:

void tcb_set_openfiles(unsigned int pid, int fd, struct file* f)
{
  106bc0:	8b 44 24 04          	mov    0x4(%esp),%eax
  (TCBPool[pid].openfiles)[fd] = f;
  106bc4:	8d 14 80             	lea    (%eax,%eax,4),%edx
  106bc7:	8d 04 90             	lea    (%eax,%edx,4),%eax
  106bca:	8b 54 24 0c          	mov    0xc(%esp),%edx
  106bce:	03 44 24 08          	add    0x8(%esp),%eax
  106bd2:	89 14 85 10 c6 e0 00 	mov    %edx,0xe0c610(,%eax,4)
  106bd9:	c3                   	ret    
  106bda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106be0 <tcb_get_cwd>:
}

struct inode* tcb_get_cwd(unsigned int pid)
{
  return TCBPool[pid].cwd;
  106be0:	6b 44 24 04 54       	imul   $0x54,0x4(%esp),%eax
  106be5:	8b 80 50 c6 e0 00    	mov    0xe0c650(%eax),%eax
}
  106beb:	c3                   	ret    
  106bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106bf0 <tcb_set_cwd>:

void tcb_set_cwd(unsigned int pid, struct inode* d)
{
  TCBPool[pid].cwd = d;
  106bf0:	6b 44 24 04 54       	imul   $0x54,0x4(%esp),%eax
  106bf5:	8b 54 24 08          	mov    0x8(%esp),%edx
  106bf9:	89 90 50 c6 e0 00    	mov    %edx,0xe0c650(%eax)
  106bff:	c3                   	ret    

00106c00 <tcb_init>:
/**
 * Initializes the TCB for all NUM_IDS threads with the
 * state TSTATE_DEAD, and with two indices being NUM_IDS (which represents NULL).
 */
void tcb_init(unsigned int mbi_addr)
{
  106c00:	53                   	push   %ebx
	unsigned int pid;

	paging_init(mbi_addr);

	pid = 0;
  106c01:	31 db                	xor    %ebx,%ebx
/**
 * Initializes the TCB for all NUM_IDS threads with the
 * state TSTATE_DEAD, and with two indices being NUM_IDS (which represents NULL).
 */
void tcb_init(unsigned int mbi_addr)
{
  106c03:	83 ec 18             	sub    $0x18,%esp
	unsigned int pid;

	paging_init(mbi_addr);
  106c06:	8b 44 24 20          	mov    0x20(%esp),%eax
  106c0a:	89 04 24             	mov    %eax,(%esp)
  106c0d:	e8 ee fc ff ff       	call   106900 <paging_init>
  106c12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

	pid = 0;

  while (pid < NUM_IDS) {
    tcb_init_at_id(pid);
  106c18:	89 1c 24             	mov    %ebx,(%esp)
    pid++;
  106c1b:	83 c3 01             	add    $0x1,%ebx
	paging_init(mbi_addr);

	pid = 0;

  while (pid < NUM_IDS) {
    tcb_init_at_id(pid);
  106c1e:	e8 0d ff ff ff       	call   106b30 <tcb_init_at_id>

	paging_init(mbi_addr);

	pid = 0;

  while (pid < NUM_IDS) {
  106c23:	83 fb 40             	cmp    $0x40,%ebx
  106c26:	75 f0                	jne    106c18 <tcb_init+0x18>
    tcb_init_at_id(pid);
    pid++;
  }
}
  106c28:	83 c4 18             	add    $0x18,%esp
  106c2b:	5b                   	pop    %ebx
  106c2c:	c3                   	ret    
  106c2d:	66 90                	xchg   %ax,%ax
  106c2f:	90                   	nop

00106c30 <tqueue_get_head>:
 * and are scheduled in a round-robin manner.
 */
struct TQueue TQueuePool[NUM_CPUS][NUM_IDS + 1];

unsigned int tqueue_get_head(unsigned int chid)
{
  106c30:	83 ec 0c             	sub    $0xc,%esp
	return TQueuePool[get_pcpu_idx()][chid].head;
  106c33:	e8 c8 ef ff ff       	call   105c00 <get_pcpu_idx>
  106c38:	89 c2                	mov    %eax,%edx
  106c3a:	c1 e2 06             	shl    $0x6,%edx
  106c3d:	01 d0                	add    %edx,%eax
  106c3f:	03 44 24 10          	add    0x10(%esp),%eax
  106c43:	8b 04 c5 20 db e0 00 	mov    0xe0db20(,%eax,8),%eax
}
  106c4a:	83 c4 0c             	add    $0xc,%esp
  106c4d:	c3                   	ret    
  106c4e:	66 90                	xchg   %ax,%ax

00106c50 <tqueue_set_head>:

void tqueue_set_head(unsigned int chid, unsigned int head)
{
  106c50:	83 ec 0c             	sub    $0xc,%esp
	TQueuePool[get_pcpu_idx()][chid].head = head;
  106c53:	e8 a8 ef ff ff       	call   105c00 <get_pcpu_idx>
  106c58:	89 c2                	mov    %eax,%edx
  106c5a:	c1 e2 06             	shl    $0x6,%edx
  106c5d:	01 d0                	add    %edx,%eax
  106c5f:	8b 54 24 14          	mov    0x14(%esp),%edx
  106c63:	03 44 24 10          	add    0x10(%esp),%eax
  106c67:	89 14 c5 20 db e0 00 	mov    %edx,0xe0db20(,%eax,8)
}
  106c6e:	83 c4 0c             	add    $0xc,%esp
  106c71:	c3                   	ret    
  106c72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106c80 <tqueue_get_tail>:

unsigned int tqueue_get_tail(unsigned int chid)
{
  106c80:	83 ec 0c             	sub    $0xc,%esp
	return TQueuePool[get_pcpu_idx()][chid].tail;
  106c83:	e8 78 ef ff ff       	call   105c00 <get_pcpu_idx>
  106c88:	89 c2                	mov    %eax,%edx
  106c8a:	c1 e2 06             	shl    $0x6,%edx
  106c8d:	01 d0                	add    %edx,%eax
  106c8f:	03 44 24 10          	add    0x10(%esp),%eax
  106c93:	8b 04 c5 24 db e0 00 	mov    0xe0db24(,%eax,8),%eax
}
  106c9a:	83 c4 0c             	add    $0xc,%esp
  106c9d:	c3                   	ret    
  106c9e:	66 90                	xchg   %ax,%ax

00106ca0 <tqueue_set_tail>:

void tqueue_set_tail(unsigned int chid, unsigned int tail)
{
  106ca0:	83 ec 0c             	sub    $0xc,%esp
	TQueuePool[get_pcpu_idx()][chid].tail = tail;
  106ca3:	e8 58 ef ff ff       	call   105c00 <get_pcpu_idx>
  106ca8:	89 c2                	mov    %eax,%edx
  106caa:	c1 e2 06             	shl    $0x6,%edx
  106cad:	01 d0                	add    %edx,%eax
  106caf:	8b 54 24 14          	mov    0x14(%esp),%edx
  106cb3:	03 44 24 10          	add    0x10(%esp),%eax
  106cb7:	89 14 c5 24 db e0 00 	mov    %edx,0xe0db24(,%eax,8)
}
  106cbe:	83 c4 0c             	add    $0xc,%esp
  106cc1:	c3                   	ret    
  106cc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106cd0 <tqueue_init_at_id>:

void tqueue_init_at_id(unsigned int cpu_idx, unsigned int chid)
{
  106cd0:	8b 44 24 04          	mov    0x4(%esp),%eax
	TQueuePool[cpu_idx][chid].head = NUM_IDS;
  106cd4:	89 c2                	mov    %eax,%edx
  106cd6:	c1 e2 06             	shl    $0x6,%edx
  106cd9:	01 d0                	add    %edx,%eax
  106cdb:	03 44 24 08          	add    0x8(%esp),%eax
  106cdf:	c7 04 c5 20 db e0 00 	movl   $0x40,0xe0db20(,%eax,8)
  106ce6:	40 00 00 00 
	TQueuePool[cpu_idx][chid].tail = NUM_IDS;
  106cea:	c7 04 c5 24 db e0 00 	movl   $0x40,0xe0db24(,%eax,8)
  106cf1:	40 00 00 00 
  106cf5:	c3                   	ret    
  106cf6:	66 90                	xchg   %ax,%ax
  106cf8:	66 90                	xchg   %ax,%ax
  106cfa:	66 90                	xchg   %ax,%ax
  106cfc:	66 90                	xchg   %ax,%ax
  106cfe:	66 90                	xchg   %ax,%ax

00106d00 <tqueue_init>:
/**
 * Initializes all the thread queues with
 * tqueue_init_at_id.
 */
void tqueue_init(unsigned int mbi_addr)
{
  106d00:	56                   	push   %esi
	unsigned int cpu_idx, chid;

	tcb_init(mbi_addr);

	chid = 0;
	cpu_idx = 0;
  106d01:	31 f6                	xor    %esi,%esi
/**
 * Initializes all the thread queues with
 * tqueue_init_at_id.
 */
void tqueue_init(unsigned int mbi_addr)
{
  106d03:	53                   	push   %ebx
  106d04:	83 ec 14             	sub    $0x14,%esp
	unsigned int cpu_idx, chid;

	tcb_init(mbi_addr);
  106d07:	8b 44 24 20          	mov    0x20(%esp),%eax
  106d0b:	89 04 24             	mov    %eax,(%esp)
  106d0e:	e8 ed fe ff ff       	call   106c00 <tcb_init>
  106d13:	90                   	nop
  106d14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
/**
 * Initializes all the thread queues with
 * tqueue_init_at_id.
 */
void tqueue_init(unsigned int mbi_addr)
{
  106d18:	31 db                	xor    %ebx,%ebx
  106d1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

	chid = 0;
	cpu_idx = 0;
	while (cpu_idx < NUM_CPUS) {
		while (chid <= NUM_IDS) {
			tqueue_init_at_id(cpu_idx, chid);
  106d20:	89 5c 24 04          	mov    %ebx,0x4(%esp)
			chid++;
  106d24:	83 c3 01             	add    $0x1,%ebx

	chid = 0;
	cpu_idx = 0;
	while (cpu_idx < NUM_CPUS) {
		while (chid <= NUM_IDS) {
			tqueue_init_at_id(cpu_idx, chid);
  106d27:	89 34 24             	mov    %esi,(%esp)
  106d2a:	e8 a1 ff ff ff       	call   106cd0 <tqueue_init_at_id>
	tcb_init(mbi_addr);

	chid = 0;
	cpu_idx = 0;
	while (cpu_idx < NUM_CPUS) {
		while (chid <= NUM_IDS) {
  106d2f:	83 fb 41             	cmp    $0x41,%ebx
  106d32:	75 ec                	jne    106d20 <tqueue_init+0x20>
			tqueue_init_at_id(cpu_idx, chid);
			chid++;
		}
		chid = 0;
		cpu_idx++;
  106d34:	83 c6 01             	add    $0x1,%esi

	tcb_init(mbi_addr);

	chid = 0;
	cpu_idx = 0;
	while (cpu_idx < NUM_CPUS) {
  106d37:	83 fe 08             	cmp    $0x8,%esi
  106d3a:	75 dc                	jne    106d18 <tqueue_init+0x18>
			chid++;
		}
		chid = 0;
		cpu_idx++;
	}
}
  106d3c:	83 c4 14             	add    $0x14,%esp
  106d3f:	5b                   	pop    %ebx
  106d40:	5e                   	pop    %esi
  106d41:	c3                   	ret    
  106d42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106d50 <tqueue_enqueue>:
 * Recall that the doubly linked list is index based.
 * So you only need to insert the index.
 * Hint: there are multiple cases in this function.
 */
void tqueue_enqueue(unsigned int chid, unsigned int pid)
{
  106d50:	57                   	push   %edi
  106d51:	56                   	push   %esi
  106d52:	53                   	push   %ebx
  106d53:	83 ec 10             	sub    $0x10,%esp
  106d56:	8b 7c 24 20          	mov    0x20(%esp),%edi
  106d5a:	8b 5c 24 24          	mov    0x24(%esp),%ebx
	unsigned int tail;

	tail = tqueue_get_tail(chid);
  106d5e:	89 3c 24             	mov    %edi,(%esp)
  106d61:	e8 1a ff ff ff       	call   106c80 <tqueue_get_tail>

	if (tail == NUM_IDS) {
  106d66:	83 f8 40             	cmp    $0x40,%eax
 */
void tqueue_enqueue(unsigned int chid, unsigned int pid)
{
	unsigned int tail;

	tail = tqueue_get_tail(chid);
  106d69:	89 c6                	mov    %eax,%esi

	if (tail == NUM_IDS) {
  106d6b:	74 3b                	je     106da8 <tqueue_enqueue+0x58>
		tcb_set_prev(pid, NUM_IDS);
		tcb_set_next(pid, NUM_IDS);
		tqueue_set_head(chid, pid);
		tqueue_set_tail(chid, pid);
	} else {
		tcb_set_next(tail, pid);
  106d6d:	89 04 24             	mov    %eax,(%esp)
  106d70:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  106d74:	e8 a7 fd ff ff       	call   106b20 <tcb_set_next>
		tcb_set_prev(pid, tail);
  106d79:	89 74 24 04          	mov    %esi,0x4(%esp)
  106d7d:	89 1c 24             	mov    %ebx,(%esp)
  106d80:	e8 7b fd ff ff       	call   106b00 <tcb_set_prev>
		tcb_set_next(pid, NUM_IDS);
  106d85:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  106d8c:	00 
  106d8d:	89 1c 24             	mov    %ebx,(%esp)
  106d90:	e8 8b fd ff ff       	call   106b20 <tcb_set_next>
		tqueue_set_tail(chid, pid);
  106d95:	89 5c 24 24          	mov    %ebx,0x24(%esp)
  106d99:	89 7c 24 20          	mov    %edi,0x20(%esp)
	}
}
  106d9d:	83 c4 10             	add    $0x10,%esp
  106da0:	5b                   	pop    %ebx
  106da1:	5e                   	pop    %esi
  106da2:	5f                   	pop    %edi
		tqueue_set_tail(chid, pid);
	} else {
		tcb_set_next(tail, pid);
		tcb_set_prev(pid, tail);
		tcb_set_next(pid, NUM_IDS);
		tqueue_set_tail(chid, pid);
  106da3:	e9 f8 fe ff ff       	jmp    106ca0 <tqueue_set_tail>
	unsigned int tail;

	tail = tqueue_get_tail(chid);

	if (tail == NUM_IDS) {
		tcb_set_prev(pid, NUM_IDS);
  106da8:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  106daf:	00 
  106db0:	89 1c 24             	mov    %ebx,(%esp)
  106db3:	e8 48 fd ff ff       	call   106b00 <tcb_set_prev>
		tcb_set_next(pid, NUM_IDS);
  106db8:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  106dbf:	00 
  106dc0:	89 1c 24             	mov    %ebx,(%esp)
  106dc3:	e8 58 fd ff ff       	call   106b20 <tcb_set_next>
		tqueue_set_head(chid, pid);
  106dc8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  106dcc:	89 3c 24             	mov    %edi,(%esp)
  106dcf:	e8 7c fe ff ff       	call   106c50 <tqueue_set_head>
  106dd4:	eb bf                	jmp    106d95 <tqueue_enqueue+0x45>
  106dd6:	8d 76 00             	lea    0x0(%esi),%esi
  106dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106de0 <tqueue_dequeue>:
 * Reverse action of tqueue_enqueue, i.g., pops a TCB from the head of specified queue.
 * It returns the poped thread's id, or NUM_IDS if the queue is empty.
 * Hint: there are mutiple cases in this function.
 */
unsigned int tqueue_dequeue(unsigned int chid)
{
  106de0:	57                   	push   %edi
  106de1:	56                   	push   %esi
  106de2:	53                   	push   %ebx
  106de3:	83 ec 10             	sub    $0x10,%esp
  106de6:	8b 74 24 20          	mov    0x20(%esp),%esi
	unsigned int head, next, pid;

	pid = NUM_IDS;
	head = tqueue_get_head(chid);
  106dea:	89 34 24             	mov    %esi,(%esp)
  106ded:	e8 3e fe ff ff       	call   106c30 <tqueue_get_head>

	if (head != NUM_IDS) {
  106df2:	83 f8 40             	cmp    $0x40,%eax
unsigned int tqueue_dequeue(unsigned int chid)
{
	unsigned int head, next, pid;

	pid = NUM_IDS;
	head = tqueue_get_head(chid);
  106df5:	89 c3                	mov    %eax,%ebx

	if (head != NUM_IDS) {
  106df7:	75 0f                	jne    106e08 <tqueue_dequeue+0x28>
    tcb_set_prev(pid, NUM_IDS);
    tcb_set_next(pid, NUM_IDS);
	}

	return pid;
}
  106df9:	83 c4 10             	add    $0x10,%esp
  106dfc:	89 d8                	mov    %ebx,%eax
  106dfe:	5b                   	pop    %ebx
  106dff:	5e                   	pop    %esi
  106e00:	5f                   	pop    %edi
  106e01:	c3                   	ret    
  106e02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	pid = NUM_IDS;
	head = tqueue_get_head(chid);

	if (head != NUM_IDS) {
		pid = head;
		next = tcb_get_next(head);
  106e08:	89 04 24             	mov    %eax,(%esp)
  106e0b:	e8 00 fd ff ff       	call   106b10 <tcb_get_next>

		if(next == NUM_IDS) {
			tqueue_set_head(chid, NUM_IDS);
  106e10:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  106e17:	00 

	if (head != NUM_IDS) {
		pid = head;
		next = tcb_get_next(head);

		if(next == NUM_IDS) {
  106e18:	83 f8 40             	cmp    $0x40,%eax
	pid = NUM_IDS;
	head = tqueue_get_head(chid);

	if (head != NUM_IDS) {
		pid = head;
		next = tcb_get_next(head);
  106e1b:	89 c7                	mov    %eax,%edi

		if(next == NUM_IDS) {
  106e1d:	74 41                	je     106e60 <tqueue_dequeue+0x80>
			tqueue_set_head(chid, NUM_IDS);
			tqueue_set_tail(chid, NUM_IDS);
		} else {
			tcb_set_prev(next, NUM_IDS);
  106e1f:	89 04 24             	mov    %eax,(%esp)
  106e22:	e8 d9 fc ff ff       	call   106b00 <tcb_set_prev>
			tqueue_set_head(chid, next);
  106e27:	89 7c 24 04          	mov    %edi,0x4(%esp)
  106e2b:	89 34 24             	mov    %esi,(%esp)
  106e2e:	e8 1d fe ff ff       	call   106c50 <tqueue_set_head>
		}
    tcb_set_prev(pid, NUM_IDS);
  106e33:	89 1c 24             	mov    %ebx,(%esp)
  106e36:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  106e3d:	00 
  106e3e:	e8 bd fc ff ff       	call   106b00 <tcb_set_prev>
    tcb_set_next(pid, NUM_IDS);
  106e43:	89 1c 24             	mov    %ebx,(%esp)
  106e46:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  106e4d:	00 
  106e4e:	e8 cd fc ff ff       	call   106b20 <tcb_set_next>
	}

	return pid;
}
  106e53:	83 c4 10             	add    $0x10,%esp
  106e56:	89 d8                	mov    %ebx,%eax
  106e58:	5b                   	pop    %ebx
  106e59:	5e                   	pop    %esi
  106e5a:	5f                   	pop    %edi
  106e5b:	c3                   	ret    
  106e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if (head != NUM_IDS) {
		pid = head;
		next = tcb_get_next(head);

		if(next == NUM_IDS) {
			tqueue_set_head(chid, NUM_IDS);
  106e60:	89 34 24             	mov    %esi,(%esp)
  106e63:	e8 e8 fd ff ff       	call   106c50 <tqueue_set_head>
			tqueue_set_tail(chid, NUM_IDS);
  106e68:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  106e6f:	00 
  106e70:	89 34 24             	mov    %esi,(%esp)
  106e73:	e8 28 fe ff ff       	call   106ca0 <tqueue_set_tail>
  106e78:	eb b9                	jmp    106e33 <tqueue_dequeue+0x53>
  106e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106e80 <tqueue_remove>:
/**
 * Removes the TCB #pid from the queue #chid.
 * Hint: there are many cases in this function.
 */
void tqueue_remove(unsigned int chid, unsigned int pid)
{
  106e80:	55                   	push   %ebp
  106e81:	57                   	push   %edi
  106e82:	56                   	push   %esi
  106e83:	53                   	push   %ebx
  106e84:	83 ec 1c             	sub    $0x1c,%esp
  106e87:	8b 5c 24 34          	mov    0x34(%esp),%ebx
  106e8b:	8b 6c 24 30          	mov    0x30(%esp),%ebp
	unsigned int prev, next;

	prev = tcb_get_prev(pid);
  106e8f:	89 1c 24             	mov    %ebx,(%esp)
  106e92:	e8 59 fc ff ff       	call   106af0 <tcb_get_prev>
	next = tcb_get_next(pid);
  106e97:	89 1c 24             	mov    %ebx,(%esp)
 */
void tqueue_remove(unsigned int chid, unsigned int pid)
{
	unsigned int prev, next;

	prev = tcb_get_prev(pid);
  106e9a:	89 c7                	mov    %eax,%edi
	next = tcb_get_next(pid);
  106e9c:	e8 6f fc ff ff       	call   106b10 <tcb_get_next>

	if (prev == NUM_IDS) {
  106ea1:	83 ff 40             	cmp    $0x40,%edi
void tqueue_remove(unsigned int chid, unsigned int pid)
{
	unsigned int prev, next;

	prev = tcb_get_prev(pid);
	next = tcb_get_next(pid);
  106ea4:	89 c6                	mov    %eax,%esi

	if (prev == NUM_IDS) {
  106ea6:	74 50                	je     106ef8 <tqueue_remove+0x78>
		} else {
			tcb_set_prev(next, NUM_IDS);
			tqueue_set_head(chid, next);
		}
	} else {
		if (next == NUM_IDS) {
  106ea8:	83 f8 40             	cmp    $0x40,%eax
  106eab:	0f 84 8f 00 00 00    	je     106f40 <tqueue_remove+0xc0>
			tcb_set_next(prev, NUM_IDS);
			tqueue_set_tail(chid, prev);
		} else {
			if (prev != next)
  106eb1:	39 c7                	cmp    %eax,%edi
  106eb3:	74 0c                	je     106ec1 <tqueue_remove+0x41>
				tcb_set_next(prev, next);
  106eb5:	89 44 24 04          	mov    %eax,0x4(%esp)
  106eb9:	89 3c 24             	mov    %edi,(%esp)
  106ebc:	e8 5f fc ff ff       	call   106b20 <tcb_set_next>
			tcb_set_prev(next, prev);
  106ec1:	89 7c 24 04          	mov    %edi,0x4(%esp)
  106ec5:	89 34 24             	mov    %esi,(%esp)
  106ec8:	e8 33 fc ff ff       	call   106b00 <tcb_set_prev>
		}
	}
  tcb_set_prev(pid, NUM_IDS);
  106ecd:	89 1c 24             	mov    %ebx,(%esp)
  106ed0:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  106ed7:	00 
  106ed8:	e8 23 fc ff ff       	call   106b00 <tcb_set_prev>
  tcb_set_next(pid, NUM_IDS);
  106edd:	89 5c 24 30          	mov    %ebx,0x30(%esp)
  106ee1:	c7 44 24 34 40 00 00 	movl   $0x40,0x34(%esp)
  106ee8:	00 
}
  106ee9:	83 c4 1c             	add    $0x1c,%esp
  106eec:	5b                   	pop    %ebx
  106eed:	5e                   	pop    %esi
  106eee:	5f                   	pop    %edi
  106eef:	5d                   	pop    %ebp
				tcb_set_next(prev, next);
			tcb_set_prev(next, prev);
		}
	}
  tcb_set_prev(pid, NUM_IDS);
  tcb_set_next(pid, NUM_IDS);
  106ef0:	e9 2b fc ff ff       	jmp    106b20 <tcb_set_next>
  106ef5:	8d 76 00             	lea    0x0(%esi),%esi

	prev = tcb_get_prev(pid);
	next = tcb_get_next(pid);

	if (prev == NUM_IDS) {
		if (next == NUM_IDS) {
  106ef8:	83 f8 40             	cmp    $0x40,%eax
			tqueue_set_head(chid, NUM_IDS);
  106efb:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  106f02:	00 

	prev = tcb_get_prev(pid);
	next = tcb_get_next(pid);

	if (prev == NUM_IDS) {
		if (next == NUM_IDS) {
  106f03:	74 1b                	je     106f20 <tqueue_remove+0xa0>
			tqueue_set_head(chid, NUM_IDS);
			tqueue_set_tail(chid, NUM_IDS);
		} else {
			tcb_set_prev(next, NUM_IDS);
  106f05:	89 04 24             	mov    %eax,(%esp)
  106f08:	e8 f3 fb ff ff       	call   106b00 <tcb_set_prev>
			tqueue_set_head(chid, next);
  106f0d:	89 74 24 04          	mov    %esi,0x4(%esp)
  106f11:	89 2c 24             	mov    %ebp,(%esp)
  106f14:	e8 37 fd ff ff       	call   106c50 <tqueue_set_head>
  106f19:	eb b2                	jmp    106ecd <tqueue_remove+0x4d>
  106f1b:	90                   	nop
  106f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	prev = tcb_get_prev(pid);
	next = tcb_get_next(pid);

	if (prev == NUM_IDS) {
		if (next == NUM_IDS) {
			tqueue_set_head(chid, NUM_IDS);
  106f20:	89 2c 24             	mov    %ebp,(%esp)
  106f23:	e8 28 fd ff ff       	call   106c50 <tqueue_set_head>
			tqueue_set_tail(chid, NUM_IDS);
  106f28:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  106f2f:	00 
  106f30:	89 2c 24             	mov    %ebp,(%esp)
  106f33:	e8 68 fd ff ff       	call   106ca0 <tqueue_set_tail>
  106f38:	eb 93                	jmp    106ecd <tqueue_remove+0x4d>
  106f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			tcb_set_prev(next, NUM_IDS);
			tqueue_set_head(chid, next);
		}
	} else {
		if (next == NUM_IDS) {
			tcb_set_next(prev, NUM_IDS);
  106f40:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  106f47:	00 
  106f48:	89 3c 24             	mov    %edi,(%esp)
  106f4b:	e8 d0 fb ff ff       	call   106b20 <tcb_set_next>
			tqueue_set_tail(chid, prev);
  106f50:	89 7c 24 04          	mov    %edi,0x4(%esp)
  106f54:	89 2c 24             	mov    %ebp,(%esp)
  106f57:	e8 44 fd ff ff       	call   106ca0 <tqueue_set_tail>
  106f5c:	e9 6c ff ff ff       	jmp    106ecd <tqueue_remove+0x4d>
  106f61:	66 90                	xchg   %ax,%ax
  106f63:	66 90                	xchg   %ax,%ax
  106f65:	66 90                	xchg   %ax,%ax
  106f67:	66 90                	xchg   %ax,%ax
  106f69:	66 90                	xchg   %ax,%ax
  106f6b:	66 90                	xchg   %ax,%ax
  106f6d:	66 90                	xchg   %ax,%ax
  106f6f:	90                   	nop

00106f70 <get_curid>:
#include <pcpu/PCPUIntro/export.h>

unsigned int CURID[NUM_CPUS];

unsigned int get_curid(void)
{
  106f70:	83 ec 0c             	sub    $0xc,%esp
	return CURID[get_pcpu_idx()];
  106f73:	e8 88 ec ff ff       	call   105c00 <get_pcpu_idx>
  106f78:	8b 04 85 60 eb e0 00 	mov    0xe0eb60(,%eax,4),%eax
}
  106f7f:	83 c4 0c             	add    $0xc,%esp
  106f82:	c3                   	ret    
  106f83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  106f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106f90 <set_curid>:

void set_curid(unsigned int curid)
{
  106f90:	83 ec 0c             	sub    $0xc,%esp
	CURID[get_pcpu_idx()] = curid;
  106f93:	e8 68 ec ff ff       	call   105c00 <get_pcpu_idx>
  106f98:	8b 54 24 10          	mov    0x10(%esp),%edx
  106f9c:	89 14 85 60 eb e0 00 	mov    %edx,0xe0eb60(,%eax,4)
}
  106fa3:	83 c4 0c             	add    $0xc,%esp
  106fa6:	c3                   	ret    
  106fa7:	66 90                	xchg   %ax,%ax
  106fa9:	66 90                	xchg   %ax,%ax
  106fab:	66 90                	xchg   %ax,%ax
  106fad:	66 90                	xchg   %ax,%ax
  106faf:	90                   	nop

00106fb0 <thread_init>:
unsigned int sched_ticks[NUM_CPUS];

void thread_init(unsigned int mbi_addr)
{
  unsigned int i;
  for(i = 0; i < NUM_CPUS; i++) {
  106fb0:	31 c0                	xor    %eax,%eax
  106fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sched_ticks[i] = 0;
  106fb8:	c7 04 85 80 eb e0 00 	movl   $0x0,0xe0eb80(,%eax,4)
  106fbf:	00 00 00 00 
unsigned int sched_ticks[NUM_CPUS];

void thread_init(unsigned int mbi_addr)
{
  unsigned int i;
  for(i = 0; i < NUM_CPUS; i++) {
  106fc3:	83 c0 01             	add    $0x1,%eax
  106fc6:	83 f8 08             	cmp    $0x8,%eax
  106fc9:	75 ed                	jne    106fb8 <thread_init+0x8>
static spinlock_t sched_lk;

unsigned int sched_ticks[NUM_CPUS];

void thread_init(unsigned int mbi_addr)
{
  106fcb:	83 ec 1c             	sub    $0x1c,%esp
  unsigned int i;
  for(i = 0; i < NUM_CPUS; i++) {
    sched_ticks[i] = 0;
  }

  spinlock_init(&sched_lk);
  106fce:	c7 04 24 c8 03 94 00 	movl   $0x9403c8,(%esp)
  106fd5:	e8 d6 e8 ff ff       	call   1058b0 <spinlock_init>
  tqueue_init(mbi_addr);
  106fda:	8b 44 24 20          	mov    0x20(%esp),%eax
  106fde:	89 04 24             	mov    %eax,(%esp)
  106fe1:	e8 1a fd ff ff       	call   106d00 <tqueue_init>
  set_curid(0);
  106fe6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  106fed:	e8 9e ff ff ff       	call   106f90 <set_curid>
  tcb_set_state(0, TSTATE_RUN);
  106ff2:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  106ff9:	00 
  106ffa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  107001:	e8 da fa ff ff       	call   106ae0 <tcb_set_state>
}
  107006:	83 c4 1c             	add    $0x1c,%esp
  107009:	c3                   	ret    
  10700a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107010 <thread_spawn>:
 * Allocates new child thread context, set the state of the new child thread
 * as ready, and pushes it to the ready queue.
 * It returns the child thread id.
 */
unsigned int thread_spawn(void *entry, unsigned int id, unsigned int quota)
{
  107010:	53                   	push   %ebx
  107011:	83 ec 18             	sub    $0x18,%esp
  unsigned int pid;

  spinlock_acquire(&sched_lk);
  107014:	c7 04 24 c8 03 94 00 	movl   $0x9403c8,(%esp)
  10701b:	e8 50 ea ff ff       	call   105a70 <spinlock_acquire>

  pid = kctx_new(entry, id, quota);
  107020:	8b 44 24 28          	mov    0x28(%esp),%eax
  107024:	89 44 24 08          	mov    %eax,0x8(%esp)
  107028:	8b 44 24 24          	mov    0x24(%esp),%eax
  10702c:	89 44 24 04          	mov    %eax,0x4(%esp)
  107030:	8b 44 24 20          	mov    0x20(%esp),%eax
  107034:	89 04 24             	mov    %eax,(%esp)
  107037:	e8 44 fa ff ff       	call   106a80 <kctx_new>
  tcb_set_state(pid, TSTATE_READY);
  10703c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  107043:	00 
{
  unsigned int pid;

  spinlock_acquire(&sched_lk);

  pid = kctx_new(entry, id, quota);
  107044:	89 c3                	mov    %eax,%ebx
  tcb_set_state(pid, TSTATE_READY);
  107046:	89 04 24             	mov    %eax,(%esp)
  107049:	e8 92 fa ff ff       	call   106ae0 <tcb_set_state>
  tqueue_enqueue(NUM_IDS, pid);
  10704e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  107052:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
  107059:	e8 f2 fc ff ff       	call   106d50 <tqueue_enqueue>
	
  spinlock_release(&sched_lk);
  10705e:	c7 04 24 c8 03 94 00 	movl   $0x9403c8,(%esp)
  107065:	e8 86 ea ff ff       	call   105af0 <spinlock_release>
  
  return pid;
}
  10706a:	83 c4 18             	add    $0x18,%esp
  10706d:	89 d8                	mov    %ebx,%eax
  10706f:	5b                   	pop    %ebx
  107070:	c3                   	ret    
  107071:	eb 0d                	jmp    107080 <thread_yield>
  107073:	90                   	nop
  107074:	90                   	nop
  107075:	90                   	nop
  107076:	90                   	nop
  107077:	90                   	nop
  107078:	90                   	nop
  107079:	90                   	nop
  10707a:	90                   	nop
  10707b:	90                   	nop
  10707c:	90                   	nop
  10707d:	90                   	nop
  10707e:	90                   	nop
  10707f:	90                   	nop

00107080 <thread_yield>:
 * current thread id, then switches to the new kernel context.
 * Hint: if you are the only thread that is ready to run,
 * do you need to switch to yourself?
 */
void thread_yield(void)
{
  107080:	56                   	push   %esi
  107081:	53                   	push   %ebx
  107082:	83 ec 14             	sub    $0x14,%esp
  unsigned int old_cur_pid;
  unsigned int new_cur_pid;

  spinlock_acquire(&sched_lk);
  107085:	c7 04 24 c8 03 94 00 	movl   $0x9403c8,(%esp)
  10708c:	e8 df e9 ff ff       	call   105a70 <spinlock_acquire>

  old_cur_pid = get_curid();
  107091:	e8 da fe ff ff       	call   106f70 <get_curid>
  tcb_set_state(old_cur_pid, TSTATE_READY);
  107096:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10709d:	00 
  unsigned int old_cur_pid;
  unsigned int new_cur_pid;

  spinlock_acquire(&sched_lk);

  old_cur_pid = get_curid();
  10709e:	89 c3                	mov    %eax,%ebx
  tcb_set_state(old_cur_pid, TSTATE_READY);
  1070a0:	89 04 24             	mov    %eax,(%esp)
  1070a3:	e8 38 fa ff ff       	call   106ae0 <tcb_set_state>
  tqueue_enqueue(NUM_IDS, old_cur_pid);
  1070a8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1070ac:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
  1070b3:	e8 98 fc ff ff       	call   106d50 <tqueue_enqueue>

  new_cur_pid = tqueue_dequeue(NUM_IDS);
  1070b8:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
  1070bf:	e8 1c fd ff ff       	call   106de0 <tqueue_dequeue>
  tcb_set_state(new_cur_pid, TSTATE_RUN);
  1070c4:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1070cb:	00 

  old_cur_pid = get_curid();
  tcb_set_state(old_cur_pid, TSTATE_READY);
  tqueue_enqueue(NUM_IDS, old_cur_pid);

  new_cur_pid = tqueue_dequeue(NUM_IDS);
  1070cc:	89 c6                	mov    %eax,%esi
  tcb_set_state(new_cur_pid, TSTATE_RUN);
  1070ce:	89 04 24             	mov    %eax,(%esp)
  1070d1:	e8 0a fa ff ff       	call   106ae0 <tcb_set_state>
  set_curid(new_cur_pid);
  1070d6:	89 34 24             	mov    %esi,(%esp)
  1070d9:	e8 b2 fe ff ff       	call   106f90 <set_curid>

  if (old_cur_pid != new_cur_pid){
  1070de:	39 f3                	cmp    %esi,%ebx
    spinlock_release(&sched_lk);
  1070e0:	c7 04 24 c8 03 94 00 	movl   $0x9403c8,(%esp)

  new_cur_pid = tqueue_dequeue(NUM_IDS);
  tcb_set_state(new_cur_pid, TSTATE_RUN);
  set_curid(new_cur_pid);

  if (old_cur_pid != new_cur_pid){
  1070e7:	74 17                	je     107100 <thread_yield+0x80>
    spinlock_release(&sched_lk);
  1070e9:	e8 02 ea ff ff       	call   105af0 <spinlock_release>
    kctx_switch(old_cur_pid, new_cur_pid);
  1070ee:	89 74 24 04          	mov    %esi,0x4(%esp)
  1070f2:	89 1c 24             	mov    %ebx,(%esp)
  1070f5:	e8 26 f9 ff ff       	call   106a20 <kctx_switch>
  }
  else {
    spinlock_release(&sched_lk);
  }
}
  1070fa:	83 c4 14             	add    $0x14,%esp
  1070fd:	5b                   	pop    %ebx
  1070fe:	5e                   	pop    %esi
  1070ff:	c3                   	ret    
  if (old_cur_pid != new_cur_pid){
    spinlock_release(&sched_lk);
    kctx_switch(old_cur_pid, new_cur_pid);
  }
  else {
    spinlock_release(&sched_lk);
  107100:	e8 eb e9 ff ff       	call   105af0 <spinlock_release>
  }
}
  107105:	83 c4 14             	add    $0x14,%esp
  107108:	5b                   	pop    %ebx
  107109:	5e                   	pop    %esi
  10710a:	c3                   	ret    
  10710b:	90                   	nop
  10710c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00107110 <sched_update>:

void sched_update(void)
{
  107110:	83 ec 1c             	sub    $0x1c,%esp
  spinlock_acquire(&sched_lk);
  107113:	c7 04 24 c8 03 94 00 	movl   $0x9403c8,(%esp)
  10711a:	e8 51 e9 ff ff       	call   105a70 <spinlock_acquire>
  sched_ticks[get_pcpu_idx()] += (1000 / LAPIC_TIMER_INTR_FREQ);
  10711f:	e8 dc ea ff ff       	call   105c00 <get_pcpu_idx>
  107124:	83 04 85 80 eb e0 00 	addl   $0x1,0xe0eb80(,%eax,4)
  10712b:	01 
  if (sched_ticks[get_pcpu_idx()] > SCHED_SLICE) {
  10712c:	e8 cf ea ff ff       	call   105c00 <get_pcpu_idx>
  107131:	83 3c 85 80 eb e0 00 	cmpl   $0x5,0xe0eb80(,%eax,4)
  107138:	05 
  107139:	77 15                	ja     107150 <sched_update+0x40>
    sched_ticks[get_pcpu_idx()] = 0;
    spinlock_release(&sched_lk);
    thread_yield();
  }
  else{
    spinlock_release(&sched_lk);
  10713b:	c7 04 24 c8 03 94 00 	movl   $0x9403c8,(%esp)
  107142:	e8 a9 e9 ff ff       	call   105af0 <spinlock_release>
  }
}
  107147:	83 c4 1c             	add    $0x1c,%esp
  10714a:	c3                   	ret    
  10714b:	90                   	nop
  10714c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
void sched_update(void)
{
  spinlock_acquire(&sched_lk);
  sched_ticks[get_pcpu_idx()] += (1000 / LAPIC_TIMER_INTR_FREQ);
  if (sched_ticks[get_pcpu_idx()] > SCHED_SLICE) {
    sched_ticks[get_pcpu_idx()] = 0;
  107150:	e8 ab ea ff ff       	call   105c00 <get_pcpu_idx>
    spinlock_release(&sched_lk);
  107155:	c7 04 24 c8 03 94 00 	movl   $0x9403c8,(%esp)
void sched_update(void)
{
  spinlock_acquire(&sched_lk);
  sched_ticks[get_pcpu_idx()] += (1000 / LAPIC_TIMER_INTR_FREQ);
  if (sched_ticks[get_pcpu_idx()] > SCHED_SLICE) {
    sched_ticks[get_pcpu_idx()] = 0;
  10715c:	c7 04 85 80 eb e0 00 	movl   $0x0,0xe0eb80(,%eax,4)
  107163:	00 00 00 00 
    spinlock_release(&sched_lk);
  107167:	e8 84 e9 ff ff       	call   105af0 <spinlock_release>
    thread_yield();
  }
  else{
    spinlock_release(&sched_lk);
  }
}
  10716c:	83 c4 1c             	add    $0x1c,%esp
  spinlock_acquire(&sched_lk);
  sched_ticks[get_pcpu_idx()] += (1000 / LAPIC_TIMER_INTR_FREQ);
  if (sched_ticks[get_pcpu_idx()] > SCHED_SLICE) {
    sched_ticks[get_pcpu_idx()] = 0;
    spinlock_release(&sched_lk);
    thread_yield();
  10716f:	e9 0c ff ff ff       	jmp    107080 <thread_yield>
  107174:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10717a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00107180 <thread_sleep>:
/**
 * Atomically release lock and sleep on chan.
 * Reacquires lock when awakened.
 */
void thread_sleep (void *chan, spinlock_t *lk)
{
  107180:	57                   	push   %edi
  107181:	56                   	push   %esi
  107182:	53                   	push   %ebx
  107183:	83 ec 10             	sub    $0x10,%esp
  107186:	8b 74 24 24          	mov    0x24(%esp),%esi
  10718a:	8b 7c 24 20          	mov    0x20(%esp),%edi
  unsigned int pid;
  unsigned int new_pid;

  if (lk == 0)
  10718e:	85 f6                	test   %esi,%esi
  107190:	0f 84 b2 00 00 00    	je     107248 <thread_sleep+0xc8>
  // change the current thread's state and then switch.
  // Once we hold sched_lk, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with sched_lk locked),
  // so it's okay to release lock.
  spinlock_acquire(&sched_lk);
  107196:	c7 04 24 c8 03 94 00 	movl   $0x9403c8,(%esp)
  10719d:	e8 ce e8 ff ff       	call   105a70 <spinlock_acquire>
  spinlock_release(lk);
  1071a2:	89 34 24             	mov    %esi,(%esp)
  1071a5:	e8 46 e9 ff ff       	call   105af0 <spinlock_release>

  // Go to sleep.
  pid = get_curid();
  1071aa:	e8 c1 fd ff ff       	call   106f70 <get_curid>
  tcb_set_chan(pid, chan);
  1071af:	89 7c 24 04          	mov    %edi,0x4(%esp)
  // so it's okay to release lock.
  spinlock_acquire(&sched_lk);
  spinlock_release(lk);

  // Go to sleep.
  pid = get_curid();
  1071b3:	89 c3                	mov    %eax,%ebx
  tcb_set_chan(pid, chan);
  1071b5:	89 04 24             	mov    %eax,(%esp)
  1071b8:	e8 e3 f9 ff ff       	call   106ba0 <tcb_set_chan>
  tcb_set_state(pid, TSTATE_SLEEP);
  1071bd:	89 1c 24             	mov    %ebx,(%esp)
  1071c0:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  1071c7:	00 
  1071c8:	e8 13 f9 ff ff       	call   106ae0 <tcb_set_state>

  // Context switch.
  new_pid = tqueue_dequeue(NUM_IDS);
  1071cd:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
  1071d4:	e8 07 fc ff ff       	call   106de0 <tqueue_dequeue>
  tcb_set_state(new_pid, TSTATE_RUN);
  1071d9:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1071e0:	00 
  pid = get_curid();
  tcb_set_chan(pid, chan);
  tcb_set_state(pid, TSTATE_SLEEP);

  // Context switch.
  new_pid = tqueue_dequeue(NUM_IDS);
  1071e1:	89 c7                	mov    %eax,%edi
  tcb_set_state(new_pid, TSTATE_RUN);
  1071e3:	89 04 24             	mov    %eax,(%esp)
  1071e6:	e8 f5 f8 ff ff       	call   106ae0 <tcb_set_state>
  set_curid(new_pid);
  1071eb:	89 3c 24             	mov    %edi,(%esp)
  1071ee:	e8 9d fd ff ff       	call   106f90 <set_curid>

  spinlock_release(&sched_lk);
  1071f3:	c7 04 24 c8 03 94 00 	movl   $0x9403c8,(%esp)
  1071fa:	e8 f1 e8 ff ff       	call   105af0 <spinlock_release>
  kctx_switch(pid, new_pid);
  1071ff:	89 7c 24 04          	mov    %edi,0x4(%esp)
  107203:	89 1c 24             	mov    %ebx,(%esp)
  107206:	e8 15 f8 ff ff       	call   106a20 <kctx_switch>
  spinlock_acquire(&sched_lk);
  10720b:	c7 04 24 c8 03 94 00 	movl   $0x9403c8,(%esp)
  107212:	e8 59 e8 ff ff       	call   105a70 <spinlock_acquire>
  
  // Tidy up.
  tcb_set_chan(pid, 0);
  107217:	89 1c 24             	mov    %ebx,(%esp)
  10721a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  107221:	00 
  107222:	e8 79 f9 ff ff       	call   106ba0 <tcb_set_chan>

  // Reacquire original lock.
  spinlock_release(&sched_lk);
  107227:	c7 04 24 c8 03 94 00 	movl   $0x9403c8,(%esp)
  10722e:	e8 bd e8 ff ff       	call   105af0 <spinlock_release>
  spinlock_acquire(lk);
  107233:	89 74 24 20          	mov    %esi,0x20(%esp)
}
  107237:	83 c4 10             	add    $0x10,%esp
  10723a:	5b                   	pop    %ebx
  10723b:	5e                   	pop    %esi
  10723c:	5f                   	pop    %edi
  // Tidy up.
  tcb_set_chan(pid, 0);

  // Reacquire original lock.
  spinlock_release(&sched_lk);
  spinlock_acquire(lk);
  10723d:	e9 2e e8 ff ff       	jmp    105a70 <spinlock_acquire>
  107242:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  unsigned int pid;
  unsigned int new_pid;

  if (lk == 0)
    KERN_PANIC("sleep without lock");
  107248:	c7 44 24 08 4f c3 10 	movl   $0x10c34f,0x8(%esp)
  10724f:	00 
  107250:	c7 44 24 04 6a 00 00 	movl   $0x6a,0x4(%esp)
  107257:	00 
  107258:	c7 04 24 62 c3 10 00 	movl   $0x10c362,(%esp)
  10725f:	e8 1c cf ff ff       	call   104180 <debug_panic>
  107264:	e9 2d ff ff ff       	jmp    107196 <thread_sleep+0x16>
  107269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00107270 <thread_wakeup>:

/**
 * Wake up all processes sleeping on chan.
 */
void thread_wakeup (void *chan)
{
  107270:	56                   	push   %esi
  107271:	53                   	push   %ebx
  unsigned int pid;
  spinlock_acquire(&sched_lk);

  for (pid = 0; pid < NUM_IDS; pid++)
  107272:	31 db                	xor    %ebx,%ebx

/**
 * Wake up all processes sleeping on chan.
 */
void thread_wakeup (void *chan)
{
  107274:	83 ec 14             	sub    $0x14,%esp
  unsigned int pid;
  spinlock_acquire(&sched_lk);
  107277:	c7 04 24 c8 03 94 00 	movl   $0x9403c8,(%esp)

/**
 * Wake up all processes sleeping on chan.
 */
void thread_wakeup (void *chan)
{
  10727e:	8b 74 24 20          	mov    0x20(%esp),%esi
  unsigned int pid;
  spinlock_acquire(&sched_lk);
  107282:	e8 e9 e7 ff ff       	call   105a70 <spinlock_acquire>
  107287:	eb 0f                	jmp    107298 <thread_wakeup+0x28>
  107289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for (pid = 0; pid < NUM_IDS; pid++)
  107290:	83 c3 01             	add    $0x1,%ebx
  107293:	83 fb 40             	cmp    $0x40,%ebx
  107296:	74 48                	je     1072e0 <thread_wakeup+0x70>
    if (tcb_get_state(pid) == TSTATE_SLEEP && tcb_get_chan(pid) == chan) {
  107298:	89 1c 24             	mov    %ebx,(%esp)
  10729b:	e8 30 f8 ff ff       	call   106ad0 <tcb_get_state>
  1072a0:	83 f8 02             	cmp    $0x2,%eax
  1072a3:	75 eb                	jne    107290 <thread_wakeup+0x20>
  1072a5:	89 1c 24             	mov    %ebx,(%esp)
  1072a8:	e8 e3 f8 ff ff       	call   106b90 <tcb_get_chan>
  1072ad:	39 f0                	cmp    %esi,%eax
  1072af:	75 df                	jne    107290 <thread_wakeup+0x20>
      tcb_set_state(pid, TSTATE_READY);
  1072b1:	89 1c 24             	mov    %ebx,(%esp)
  1072b4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1072bb:	00 
  1072bc:	e8 1f f8 ff ff       	call   106ae0 <tcb_set_state>
      tqueue_enqueue(NUM_IDS, pid);
  1072c1:	89 5c 24 04          	mov    %ebx,0x4(%esp)
void thread_wakeup (void *chan)
{
  unsigned int pid;
  spinlock_acquire(&sched_lk);

  for (pid = 0; pid < NUM_IDS; pid++)
  1072c5:	83 c3 01             	add    $0x1,%ebx
    if (tcb_get_state(pid) == TSTATE_SLEEP && tcb_get_chan(pid) == chan) {
      tcb_set_state(pid, TSTATE_READY);
      tqueue_enqueue(NUM_IDS, pid);
  1072c8:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
  1072cf:	e8 7c fa ff ff       	call   106d50 <tqueue_enqueue>
void thread_wakeup (void *chan)
{
  unsigned int pid;
  spinlock_acquire(&sched_lk);

  for (pid = 0; pid < NUM_IDS; pid++)
  1072d4:	83 fb 40             	cmp    $0x40,%ebx
  1072d7:	75 bf                	jne    107298 <thread_wakeup+0x28>
  1072d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (tcb_get_state(pid) == TSTATE_SLEEP && tcb_get_chan(pid) == chan) {
      tcb_set_state(pid, TSTATE_READY);
      tqueue_enqueue(NUM_IDS, pid);
    }

  spinlock_release(&sched_lk);
  1072e0:	c7 44 24 20 c8 03 94 	movl   $0x9403c8,0x20(%esp)
  1072e7:	00 
}
  1072e8:	83 c4 14             	add    $0x14,%esp
  1072eb:	5b                   	pop    %ebx
  1072ec:	5e                   	pop    %esi
    if (tcb_get_state(pid) == TSTATE_SLEEP && tcb_get_chan(pid) == chan) {
      tcb_set_state(pid, TSTATE_READY);
      tqueue_enqueue(NUM_IDS, pid);
    }

  spinlock_release(&sched_lk);
  1072ed:	e9 fe e7 ff ff       	jmp    105af0 <spinlock_release>
  1072f2:	66 90                	xchg   %ax,%ax
  1072f4:	66 90                	xchg   %ax,%ax
  1072f6:	66 90                	xchg   %ax,%ax
  1072f8:	66 90                	xchg   %ax,%ax
  1072fa:	66 90                	xchg   %ax,%ax
  1072fc:	66 90                	xchg   %ax,%ax
  1072fe:	66 90                	xchg   %ax,%ax

00107300 <proc_start_user>:
#include "import.h"

extern tf_t uctx_pool[NUM_IDS];

void proc_start_user(void)
{
  107300:	53                   	push   %ebx
  107301:	83 ec 18             	sub    $0x18,%esp
  unsigned int cur_pid = get_curid();
  107304:	e8 67 fc ff ff       	call   106f70 <get_curid>
  107309:	89 c3                	mov    %eax,%ebx
  static int first = TRUE;
  kstack_switch(cur_pid);
  10730b:	89 04 24             	mov    %eax,(%esp)
  10730e:	e8 1d d6 ff ff       	call   104930 <kstack_switch>
  set_pdir_base(cur_pid);
  107313:	89 1c 24             	mov    %ebx,(%esp)
  107316:	e8 35 f1 ff ff       	call   106450 <set_pdir_base>

  trap_return((void *) &uctx_pool[cur_pid]);
  10731b:	89 d8                	mov    %ebx,%eax
  10731d:	c1 e0 06             	shl    $0x6,%eax
  107320:	8d 84 98 a0 eb e0 00 	lea    0xe0eba0(%eax,%ebx,4),%eax
  107327:	89 04 24             	mov    %eax,(%esp)
  10732a:	e8 11 ad ff ff       	call   102040 <trap_return>
}
  10732f:	83 c4 18             	add    $0x18,%esp
  107332:	5b                   	pop    %ebx
  107333:	c3                   	ret    
  107334:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10733a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00107340 <proc_create>:

unsigned int proc_create(void *elf_addr, unsigned int quota)
{
  107340:	57                   	push   %edi
  107341:	56                   	push   %esi
  107342:	53                   	push   %ebx
  107343:	83 ec 10             	sub    $0x10,%esp
  107346:	8b 7c 24 20          	mov    0x20(%esp),%edi
  unsigned int pid, id;

  id = get_curid();
  10734a:	e8 21 fc ff ff       	call   106f70 <get_curid>
  pid = thread_spawn((void *) proc_start_user, id, quota);
  10734f:	8b 54 24 24          	mov    0x24(%esp),%edx
  107353:	c7 04 24 00 73 10 00 	movl   $0x107300,(%esp)
  10735a:	89 54 24 08          	mov    %edx,0x8(%esp)
  10735e:	89 44 24 04          	mov    %eax,0x4(%esp)
  107362:	e8 a9 fc ff ff       	call   107010 <thread_spawn>

  elf_load(elf_addr, pid);
  107367:	89 3c 24             	mov    %edi,(%esp)
unsigned int proc_create(void *elf_addr, unsigned int quota)
{
  unsigned int pid, id;

  id = get_curid();
  pid = thread_spawn((void *) proc_start_user, id, quota);
  10736a:	89 c6                	mov    %eax,%esi

  elf_load(elf_addr, pid);
  10736c:	89 44 24 04          	mov    %eax,0x4(%esp)
  107370:	e8 5b e2 ff ff       	call   1055d0 <elf_load>

  uctx_pool[pid].es = CPU_GDT_UDATA | 3;
  107375:	89 f0                	mov    %esi,%eax
  uctx_pool[pid].ds = CPU_GDT_UDATA | 3;
  107377:	ba 23 00 00 00       	mov    $0x23,%edx
  id = get_curid();
  pid = thread_spawn((void *) proc_start_user, id, quota);

  elf_load(elf_addr, pid);

  uctx_pool[pid].es = CPU_GDT_UDATA | 3;
  10737c:	c1 e0 06             	shl    $0x6,%eax
  uctx_pool[pid].ds = CPU_GDT_UDATA | 3;
  uctx_pool[pid].cs = CPU_GDT_UCODE | 3;
  10737f:	b9 1b 00 00 00       	mov    $0x1b,%ecx
  id = get_curid();
  pid = thread_spawn((void *) proc_start_user, id, quota);

  elf_load(elf_addr, pid);

  uctx_pool[pid].es = CPU_GDT_UDATA | 3;
  107384:	8d 1c b0             	lea    (%eax,%esi,4),%ebx
  107387:	b8 23 00 00 00       	mov    $0x23,%eax
  10738c:	66 89 83 c0 eb e0 00 	mov    %ax,0xe0ebc0(%ebx)
  uctx_pool[pid].ds = CPU_GDT_UDATA | 3;
  uctx_pool[pid].cs = CPU_GDT_UCODE | 3;
  uctx_pool[pid].ss = CPU_GDT_UDATA | 3;
  107393:	b8 23 00 00 00       	mov    $0x23,%eax
  uctx_pool[pid].esp = VM_USERHI;
  uctx_pool[pid].eflags = FL_IF;
  uctx_pool[pid].eip = elf_entry(elf_addr);
  107398:	89 3c 24             	mov    %edi,(%esp)
  pid = thread_spawn((void *) proc_start_user, id, quota);

  elf_load(elf_addr, pid);

  uctx_pool[pid].es = CPU_GDT_UDATA | 3;
  uctx_pool[pid].ds = CPU_GDT_UDATA | 3;
  10739b:	66 89 93 c4 eb e0 00 	mov    %dx,0xe0ebc4(%ebx)
  uctx_pool[pid].cs = CPU_GDT_UCODE | 3;
  1073a2:	66 89 8b d4 eb e0 00 	mov    %cx,0xe0ebd4(%ebx)
  uctx_pool[pid].ss = CPU_GDT_UDATA | 3;
  1073a9:	66 89 83 e0 eb e0 00 	mov    %ax,0xe0ebe0(%ebx)
  uctx_pool[pid].esp = VM_USERHI;
  1073b0:	c7 83 dc eb e0 00 00 	movl   $0xf0000000,0xe0ebdc(%ebx)
  1073b7:	00 00 f0 
  uctx_pool[pid].eflags = FL_IF;
  1073ba:	c7 83 d8 eb e0 00 00 	movl   $0x200,0xe0ebd8(%ebx)
  1073c1:	02 00 00 
  uctx_pool[pid].eip = elf_entry(elf_addr);
  1073c4:	e8 67 e4 ff ff       	call   105830 <elf_entry>
  1073c9:	89 83 d0 eb e0 00    	mov    %eax,0xe0ebd0(%ebx)

  seg_init_proc(get_pcpu_idx(), pid);
  1073cf:	e8 2c e8 ff ff       	call   105c00 <get_pcpu_idx>
  1073d4:	89 74 24 04          	mov    %esi,0x4(%esp)
  1073d8:	89 04 24             	mov    %eax,(%esp)
  1073db:	e8 e0 d7 ff ff       	call   104bc0 <seg_init_proc>
  
  return pid;
}
  1073e0:	83 c4 10             	add    $0x10,%esp
  1073e3:	89 f0                	mov    %esi,%eax
  1073e5:	5b                   	pop    %ebx
  1073e6:	5e                   	pop    %esi
  1073e7:	5f                   	pop    %edi
  1073e8:	c3                   	ret    
  1073e9:	66 90                	xchg   %ax,%ax
  1073eb:	66 90                	xchg   %ax,%ax
  1073ed:	66 90                	xchg   %ax,%ax
  1073ef:	90                   	nop

001073f0 <syscall_get_arg1>:

#include "import.h"

unsigned int syscall_get_arg1(tf_t *tf)
{
  return tf -> regs.eax;
  1073f0:	8b 44 24 04          	mov    0x4(%esp),%eax
  1073f4:	8b 40 1c             	mov    0x1c(%eax),%eax
}
  1073f7:	c3                   	ret    
  1073f8:	90                   	nop
  1073f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00107400 <syscall_get_arg2>:

unsigned int syscall_get_arg2(tf_t *tf)
{
  return tf -> regs.ebx;
  107400:	8b 44 24 04          	mov    0x4(%esp),%eax
  107404:	8b 40 10             	mov    0x10(%eax),%eax
}
  107407:	c3                   	ret    
  107408:	90                   	nop
  107409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00107410 <syscall_get_arg3>:

unsigned int syscall_get_arg3(tf_t *tf)
{
  return tf -> regs.ecx;
  107410:	8b 44 24 04          	mov    0x4(%esp),%eax
  107414:	8b 40 18             	mov    0x18(%eax),%eax
}
  107417:	c3                   	ret    
  107418:	90                   	nop
  107419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00107420 <syscall_get_arg4>:

unsigned int syscall_get_arg4(tf_t *tf)
{
  107420:	83 ec 0c             	sub    $0xc,%esp
	unsigned int cur_pid;
	unsigned int arg4;

	cur_pid = get_curid();
  107423:	e8 48 fb ff ff       	call   106f70 <get_curid>
	arg4 = tf -> regs.edx;

	return arg4;
  107428:	8b 44 24 10          	mov    0x10(%esp),%eax
  10742c:	8b 40 14             	mov    0x14(%eax),%eax
}
  10742f:	83 c4 0c             	add    $0xc,%esp
  107432:	c3                   	ret    
  107433:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  107439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00107440 <syscall_get_arg5>:

unsigned int syscall_get_arg5(tf_t *tf)
{
  107440:	83 ec 0c             	sub    $0xc,%esp
	unsigned int cur_pid;
	unsigned int arg5;

	cur_pid = get_curid();
  107443:	e8 28 fb ff ff       	call   106f70 <get_curid>
	arg5 = tf -> regs.esi;

	return arg5;
  107448:	8b 44 24 10          	mov    0x10(%esp),%eax
  10744c:	8b 40 04             	mov    0x4(%eax),%eax
}
  10744f:	83 c4 0c             	add    $0xc,%esp
  107452:	c3                   	ret    
  107453:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  107459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00107460 <syscall_get_arg6>:

unsigned int syscall_get_arg6(tf_t *tf)
{
  107460:	83 ec 0c             	sub    $0xc,%esp
	unsigned int cur_pid;
	unsigned int arg6;

	cur_pid = get_curid();
  107463:	e8 08 fb ff ff       	call   106f70 <get_curid>
	arg6 = tf -> regs.edi;

	return arg6;
  107468:	8b 44 24 10          	mov    0x10(%esp),%eax
  10746c:	8b 00                	mov    (%eax),%eax
}
  10746e:	83 c4 0c             	add    $0xc,%esp
  107471:	c3                   	ret    
  107472:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00107480 <syscall_set_errno>:

void syscall_set_errno(tf_t *tf, unsigned int errno)
{
  tf -> regs.eax = errno;
  107480:	8b 54 24 08          	mov    0x8(%esp),%edx
  107484:	8b 44 24 04          	mov    0x4(%esp),%eax
  107488:	89 50 1c             	mov    %edx,0x1c(%eax)
  10748b:	c3                   	ret    
  10748c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00107490 <syscall_set_retval1>:
}

void syscall_set_retval1(tf_t *tf, unsigned int retval)
{
  tf -> regs.ebx = retval;
  107490:	8b 54 24 08          	mov    0x8(%esp),%edx
  107494:	8b 44 24 04          	mov    0x4(%esp),%eax
  107498:	89 50 10             	mov    %edx,0x10(%eax)
  10749b:	c3                   	ret    
  10749c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001074a0 <syscall_set_retval2>:
}

void syscall_set_retval2(tf_t *tf, unsigned int retval)
{
  tf -> regs.ecx = retval;
  1074a0:	8b 54 24 08          	mov    0x8(%esp),%edx
  1074a4:	8b 44 24 04          	mov    0x4(%esp),%eax
  1074a8:	89 50 18             	mov    %edx,0x18(%eax)
  1074ab:	c3                   	ret    
  1074ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001074b0 <syscall_set_retval3>:
}

void syscall_set_retval3(tf_t *tf, unsigned int retval)
{
  tf -> regs.edx = retval;
  1074b0:	8b 54 24 08          	mov    0x8(%esp),%edx
  1074b4:	8b 44 24 04          	mov    0x4(%esp),%eax
  1074b8:	89 50 14             	mov    %edx,0x14(%eax)
  1074bb:	c3                   	ret    
  1074bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001074c0 <syscall_set_retval4>:
}

void syscall_set_retval4(tf_t *tf, unsigned int retval)
{
  tf -> regs.esi = retval;
  1074c0:	8b 54 24 08          	mov    0x8(%esp),%edx
  1074c4:	8b 44 24 04          	mov    0x4(%esp),%eax
  1074c8:	89 50 04             	mov    %edx,0x4(%eax)
  1074cb:	c3                   	ret    
  1074cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001074d0 <syscall_set_retval5>:
}

void syscall_set_retval5(tf_t *tf, unsigned int retval)
{
  tf -> regs.edi = retval;
  1074d0:	8b 54 24 08          	mov    0x8(%esp),%edx
  1074d4:	8b 44 24 04          	mov    0x4(%esp),%eax
  1074d8:	89 10                	mov    %edx,(%eax)
  1074da:	c3                   	ret    
  1074db:	66 90                	xchg   %ax,%ax
  1074dd:	66 90                	xchg   %ax,%ax
  1074df:	90                   	nop

001074e0 <sys_puts>:
/**
 * Copies a string from user into buffer and prints it to the screen.
 * This is called by the user level "printf" library as a system call.
 */
void sys_puts(tf_t *tf)
{
  1074e0:	55                   	push   %ebp
  1074e1:	57                   	push   %edi
  1074e2:	56                   	push   %esi
  1074e3:	53                   	push   %ebx
  1074e4:	83 ec 2c             	sub    $0x2c,%esp
  unsigned int cur_pid;
  unsigned int str_uva, str_len;
  unsigned int remain, cur_pos, nbytes;

  cur_pid = get_curid();
  1074e7:	e8 84 fa ff ff       	call   106f70 <get_curid>
  1074ec:	89 44 24 18          	mov    %eax,0x18(%esp)
  1074f0:	89 c7                	mov    %eax,%edi
  str_uva = syscall_get_arg2(tf);
  1074f2:	8b 44 24 40          	mov    0x40(%esp),%eax
  1074f6:	89 04 24             	mov    %eax,(%esp)
  1074f9:	e8 02 ff ff ff       	call   107400 <syscall_get_arg2>
  1074fe:	89 c6                	mov    %eax,%esi
  str_len = syscall_get_arg3(tf);
  107500:	8b 44 24 40          	mov    0x40(%esp),%eax
  107504:	89 04 24             	mov    %eax,(%esp)
  107507:	e8 04 ff ff ff       	call   107410 <syscall_get_arg3>

  if (!(VM_USERLO <= str_uva && str_uva + str_len <= VM_USERHI)) {
  10750c:	81 fe ff ff ff 3f    	cmp    $0x3fffffff,%esi
  107512:	0f 86 a0 00 00 00    	jbe    1075b8 <sys_puts+0xd8>
  107518:	89 c3                	mov    %eax,%ebx
  10751a:	8d 04 30             	lea    (%eax,%esi,1),%eax
  10751d:	3d 00 00 00 f0       	cmp    $0xf0000000,%eax
  107522:	0f 87 90 00 00 00    	ja     1075b8 <sys_puts+0xd8>
  107528:	89 f8                	mov    %edi,%eax
  10752a:	c1 e0 0c             	shl    $0xc,%eax
  }

  remain = str_len;
  cur_pos = str_uva;

  while (remain) {
  10752d:	85 db                	test   %ebx,%ebx
  10752f:	8d b8 e0 03 94 00    	lea    0x9403e0(%eax),%edi
		  cur_pos, sys_buf[cur_pid], nbytes) != nbytes) {
      syscall_set_errno(tf, E_MEM);
      return;
    }

    sys_buf[cur_pid][nbytes] = '\0';
  107535:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  }

  remain = str_len;
  cur_pos = str_uva;

  while (remain) {
  107539:	75 27                	jne    107562 <sys_puts+0x82>
  10753b:	e9 98 00 00 00       	jmp    1075d8 <sys_puts+0xf8>
		  cur_pos, sys_buf[cur_pid], nbytes) != nbytes) {
      syscall_set_errno(tf, E_MEM);
      return;
    }

    sys_buf[cur_pid][nbytes] = '\0';
  107540:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    KERN_INFO("%s", sys_buf[cur_pid]);

    remain -= nbytes;
    cur_pos += nbytes;
  107544:	01 ee                	add    %ebp,%esi
      syscall_set_errno(tf, E_MEM);
      return;
    }

    sys_buf[cur_pid][nbytes] = '\0';
    KERN_INFO("%s", sys_buf[cur_pid]);
  107546:	89 7c 24 04          	mov    %edi,0x4(%esp)
  10754a:	c7 04 24 6e ab 10 00 	movl   $0x10ab6e,(%esp)
		  cur_pos, sys_buf[cur_pid], nbytes) != nbytes) {
      syscall_set_errno(tf, E_MEM);
      return;
    }

    sys_buf[cur_pid][nbytes] = '\0';
  107551:	c6 84 05 e0 03 94 00 	movb   $0x0,0x9403e0(%ebp,%eax,1)
  107558:	00 
    KERN_INFO("%s", sys_buf[cur_pid]);
  107559:	e8 92 cb ff ff       	call   1040f0 <debug_info>
  }

  remain = str_len;
  cur_pos = str_uva;

  while (remain) {
  10755e:	29 eb                	sub    %ebp,%ebx
  107560:	74 76                	je     1075d8 <sys_puts+0xf8>
    if (remain < PAGESIZE - 1)
      nbytes = remain;
    else
      nbytes = PAGESIZE - 1;

    if (pt_copyin(cur_pid,
  107562:	8b 44 24 18          	mov    0x18(%esp),%eax

  while (remain) {
    if (remain < PAGESIZE - 1)
      nbytes = remain;
    else
      nbytes = PAGESIZE - 1;
  107566:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
  10756c:	ba ff 0f 00 00       	mov    $0xfff,%edx
  107571:	0f 42 d3             	cmovb  %ebx,%edx

    if (pt_copyin(cur_pid,
  107574:	89 54 24 0c          	mov    %edx,0xc(%esp)
  107578:	89 7c 24 08          	mov    %edi,0x8(%esp)
  10757c:	89 74 24 04          	mov    %esi,0x4(%esp)
  107580:	89 04 24             	mov    %eax,(%esp)
  107583:	89 54 24 14          	mov    %edx,0x14(%esp)
  107587:	e8 a4 dd ff ff       	call   105330 <pt_copyin>
  10758c:	8b 54 24 14          	mov    0x14(%esp),%edx
  107590:	39 d0                	cmp    %edx,%eax
  107592:	89 c5                	mov    %eax,%ebp
  107594:	74 aa                	je     107540 <sys_puts+0x60>
		  cur_pos, sys_buf[cur_pid], nbytes) != nbytes) {
      syscall_set_errno(tf, E_MEM);
  107596:	8b 44 24 40          	mov    0x40(%esp),%eax
  10759a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1075a1:	00 
  1075a2:	89 04 24             	mov    %eax,(%esp)
  1075a5:	e8 d6 fe ff ff       	call   107480 <syscall_set_errno>
    remain -= nbytes;
    cur_pos += nbytes;
  }

  syscall_set_errno(tf, E_SUCC);
}
  1075aa:	83 c4 2c             	add    $0x2c,%esp
  1075ad:	5b                   	pop    %ebx
  1075ae:	5e                   	pop    %esi
  1075af:	5f                   	pop    %edi
  1075b0:	5d                   	pop    %ebp
  1075b1:	c3                   	ret    
  1075b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  cur_pid = get_curid();
  str_uva = syscall_get_arg2(tf);
  str_len = syscall_get_arg3(tf);

  if (!(VM_USERLO <= str_uva && str_uva + str_len <= VM_USERHI)) {
    syscall_set_errno(tf, E_INVAL_ADDR);
  1075b8:	8b 44 24 40          	mov    0x40(%esp),%eax
  1075bc:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
  1075c3:	00 
  1075c4:	89 04 24             	mov    %eax,(%esp)
  1075c7:	e8 b4 fe ff ff       	call   107480 <syscall_set_errno>
    remain -= nbytes;
    cur_pos += nbytes;
  }

  syscall_set_errno(tf, E_SUCC);
}
  1075cc:	83 c4 2c             	add    $0x2c,%esp
  1075cf:	5b                   	pop    %ebx
  1075d0:	5e                   	pop    %esi
  1075d1:	5f                   	pop    %edi
  1075d2:	5d                   	pop    %ebp
  1075d3:	c3                   	ret    
  1075d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

    remain -= nbytes;
    cur_pos += nbytes;
  }

  syscall_set_errno(tf, E_SUCC);
  1075d8:	8b 44 24 40          	mov    0x40(%esp),%eax
  1075dc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1075e3:	00 
  1075e4:	89 04 24             	mov    %eax,(%esp)
  1075e7:	e8 94 fe ff ff       	call   107480 <syscall_set_errno>
}
  1075ec:	83 c4 2c             	add    $0x2c,%esp
  1075ef:	5b                   	pop    %ebx
  1075f0:	5e                   	pop    %esi
  1075f1:	5f                   	pop    %edi
  1075f2:	5d                   	pop    %ebp
  1075f3:	c3                   	ret    
  1075f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1075fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00107600 <sys_spawn>:
 * NUM_IDS with the error number E_INVAL_PID. The same error case apply
 * when the proc_create fails.
 * Otherwise, you mark it as successful, and return the new child process id.
 */
void sys_spawn(tf_t *tf)
{
  107600:	55                   	push   %ebp
  107601:	57                   	push   %edi
  107602:	56                   	push   %esi
  unsigned int qok, nc, curid;

  elf_id = syscall_get_arg2(tf);
  quota = syscall_get_arg3(tf);

  qok = container_can_consume(curid, quota);
  107603:	31 f6                	xor    %esi,%esi
 * NUM_IDS with the error number E_INVAL_PID. The same error case apply
 * when the proc_create fails.
 * Otherwise, you mark it as successful, and return the new child process id.
 */
void sys_spawn(tf_t *tf)
{
  107605:	53                   	push   %ebx
  107606:	83 ec 1c             	sub    $0x1c,%esp
  107609:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  unsigned int new_pid;
  unsigned int elf_id, quota;
  void *elf_addr;
  unsigned int qok, nc, curid;

  elf_id = syscall_get_arg2(tf);
  10760d:	89 1c 24             	mov    %ebx,(%esp)
  107610:	e8 eb fd ff ff       	call   107400 <syscall_get_arg2>
  quota = syscall_get_arg3(tf);
  107615:	89 1c 24             	mov    %ebx,(%esp)
  unsigned int new_pid;
  unsigned int elf_id, quota;
  void *elf_addr;
  unsigned int qok, nc, curid;

  elf_id = syscall_get_arg2(tf);
  107618:	89 c7                	mov    %eax,%edi
  quota = syscall_get_arg3(tf);
  10761a:	e8 f1 fd ff ff       	call   107410 <syscall_get_arg3>

  qok = container_can_consume(curid, quota);
  10761f:	89 34 24             	mov    %esi,(%esp)
  107622:	89 44 24 04          	mov    %eax,0x4(%esp)
  unsigned int elf_id, quota;
  void *elf_addr;
  unsigned int qok, nc, curid;

  elf_id = syscall_get_arg2(tf);
  quota = syscall_get_arg3(tf);
  107626:	89 c5                	mov    %eax,%ebp

  qok = container_can_consume(curid, quota);
  107628:	e8 b3 ec ff ff       	call   1062e0 <container_can_consume>
  nc = container_get_nchildren(curid);
  10762d:	89 34 24             	mov    %esi,(%esp)
  unsigned int qok, nc, curid;

  elf_id = syscall_get_arg2(tf);
  quota = syscall_get_arg3(tf);

  qok = container_can_consume(curid, quota);
  107630:	89 44 24 0c          	mov    %eax,0xc(%esp)
  nc = container_get_nchildren(curid);
  107634:	e8 77 ec ff ff       	call   1062b0 <container_get_nchildren>
  107639:	89 c6                	mov    %eax,%esi
  curid = get_curid();
  10763b:	e8 30 f9 ff ff       	call   106f70 <get_curid>
  if (qok == 0) {
  107640:	8b 54 24 0c          	mov    0xc(%esp),%edx
  107644:	85 d2                	test   %edx,%edx
  107646:	74 78                	je     1076c0 <sys_spawn+0xc0>
    syscall_set_errno(tf, E_EXCEEDS_QUOTA);
    syscall_set_retval1(tf, NUM_IDS);
    return;
  }
  else if (NUM_IDS < curid * MAX_CHILDREN + 1 + MAX_CHILDREN) {
  107648:	8d 44 40 04          	lea    0x4(%eax,%eax,2),%eax
  10764c:	83 f8 40             	cmp    $0x40,%eax
  10764f:	0f 87 ab 00 00 00    	ja     107700 <sys_spawn+0x100>
    syscall_set_errno(tf, E_MAX_NUM_CHILDEN_REACHED);
    syscall_set_retval1(tf, NUM_IDS);
    return;
  }
  else if (nc == MAX_CHILDREN) {
  107655:	83 fe 03             	cmp    $0x3,%esi
  107658:	0f 84 d2 00 00 00    	je     107730 <sys_spawn+0x130>
    syscall_set_errno(tf, E_INVAL_CHILD_ID);
    syscall_set_retval1(tf, NUM_IDS);
    return;
  }

  if (elf_id == 1) {
  10765e:	83 ff 01             	cmp    $0x1,%edi
  107661:	0f 84 91 00 00 00    	je     1076f8 <sys_spawn+0xf8>
    elf_addr = _binary___obj_user_pingpong_ping_start;
  } else if (elf_id == 2) {
  107667:	83 ff 02             	cmp    $0x2,%edi
  10766a:	0f 84 a0 00 00 00    	je     107710 <sys_spawn+0x110>
    elf_addr = _binary___obj_user_pingpong_pong_start;
  } else if (elf_id == 3) {
  107670:	83 ff 03             	cmp    $0x3,%edi
  107673:	0f 84 a7 00 00 00    	je     107720 <sys_spawn+0x120>
    elf_addr = _binary___obj_user_pingpong_ding_start;
  } else if (elf_id == 4) {
  107679:	83 ff 04             	cmp    $0x4,%edi
    elf_addr = _binary___obj_user_fstest_fstest_start;
  10767c:	b8 b0 e3 12 00       	mov    $0x12e3b0,%eax
    elf_addr = _binary___obj_user_pingpong_ping_start;
  } else if (elf_id == 2) {
    elf_addr = _binary___obj_user_pingpong_pong_start;
  } else if (elf_id == 3) {
    elf_addr = _binary___obj_user_pingpong_ding_start;
  } else if (elf_id == 4) {
  107681:	75 65                	jne    1076e8 <sys_spawn+0xe8>
    syscall_set_errno(tf, E_INVAL_PID);
    syscall_set_retval1(tf, NUM_IDS);
    return;
  }

  new_pid = proc_create(elf_addr, quota);
  107683:	89 6c 24 04          	mov    %ebp,0x4(%esp)
  107687:	89 04 24             	mov    %eax,(%esp)
  10768a:	e8 b1 fc ff ff       	call   107340 <proc_create>

  if (new_pid == NUM_IDS) {
  10768f:	83 f8 40             	cmp    $0x40,%eax
    syscall_set_errno(tf, E_INVAL_PID);
    syscall_set_retval1(tf, NUM_IDS);
    return;
  }

  new_pid = proc_create(elf_addr, quota);
  107692:	89 c6                	mov    %eax,%esi

  if (new_pid == NUM_IDS) {
  107694:	74 52                	je     1076e8 <sys_spawn+0xe8>
    syscall_set_errno(tf, E_INVAL_PID);
    syscall_set_retval1(tf, NUM_IDS);
  } else {
    syscall_set_errno(tf, E_SUCC);
  107696:	89 1c 24             	mov    %ebx,(%esp)
  107699:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1076a0:	00 
  1076a1:	e8 da fd ff ff       	call   107480 <syscall_set_errno>
    syscall_set_retval1(tf, new_pid);
  1076a6:	89 74 24 04          	mov    %esi,0x4(%esp)
  1076aa:	89 1c 24             	mov    %ebx,(%esp)
  1076ad:	e8 de fd ff ff       	call   107490 <syscall_set_retval1>
  }
}
  1076b2:	83 c4 1c             	add    $0x1c,%esp
  1076b5:	5b                   	pop    %ebx
  1076b6:	5e                   	pop    %esi
  1076b7:	5f                   	pop    %edi
  1076b8:	5d                   	pop    %ebp
  1076b9:	c3                   	ret    
  1076ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  qok = container_can_consume(curid, quota);
  nc = container_get_nchildren(curid);
  curid = get_curid();
  if (qok == 0) {
    syscall_set_errno(tf, E_EXCEEDS_QUOTA);
  1076c0:	c7 44 24 04 17 00 00 	movl   $0x17,0x4(%esp)
  1076c7:	00 
  } else if (elf_id == 3) {
    elf_addr = _binary___obj_user_pingpong_ding_start;
  } else if (elf_id == 4) {
    elf_addr = _binary___obj_user_fstest_fstest_start;
  } else {
    syscall_set_errno(tf, E_INVAL_PID);
  1076c8:	89 1c 24             	mov    %ebx,(%esp)
  1076cb:	e8 b0 fd ff ff       	call   107480 <syscall_set_errno>
    syscall_set_retval1(tf, NUM_IDS);
  1076d0:	89 1c 24             	mov    %ebx,(%esp)
  1076d3:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  1076da:	00 
  1076db:	e8 b0 fd ff ff       	call   107490 <syscall_set_retval1>
    syscall_set_retval1(tf, NUM_IDS);
  } else {
    syscall_set_errno(tf, E_SUCC);
    syscall_set_retval1(tf, new_pid);
  }
}
  1076e0:	83 c4 1c             	add    $0x1c,%esp
  1076e3:	5b                   	pop    %ebx
  1076e4:	5e                   	pop    %esi
  1076e5:	5f                   	pop    %edi
  1076e6:	5d                   	pop    %ebp
  1076e7:	c3                   	ret    
  } else if (elf_id == 3) {
    elf_addr = _binary___obj_user_pingpong_ding_start;
  } else if (elf_id == 4) {
    elf_addr = _binary___obj_user_fstest_fstest_start;
  } else {
    syscall_set_errno(tf, E_INVAL_PID);
  1076e8:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
  1076ef:	00 
  1076f0:	eb d6                	jmp    1076c8 <sys_spawn+0xc8>
  1076f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    syscall_set_retval1(tf, NUM_IDS);
    return;
  }

  if (elf_id == 1) {
    elf_addr = _binary___obj_user_pingpong_ping_start;
  1076f8:	b8 e4 7b 11 00       	mov    $0x117be4,%eax
  1076fd:	eb 84                	jmp    107683 <sys_spawn+0x83>
  1076ff:	90                   	nop
    syscall_set_errno(tf, E_EXCEEDS_QUOTA);
    syscall_set_retval1(tf, NUM_IDS);
    return;
  }
  else if (NUM_IDS < curid * MAX_CHILDREN + 1 + MAX_CHILDREN) {
    syscall_set_errno(tf, E_MAX_NUM_CHILDEN_REACHED);
  107700:	c7 44 24 04 18 00 00 	movl   $0x18,0x4(%esp)
  107707:	00 
  107708:	eb be                	jmp    1076c8 <sys_spawn+0xc8>
  10770a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }

  if (elf_id == 1) {
    elf_addr = _binary___obj_user_pingpong_ping_start;
  } else if (elf_id == 2) {
    elf_addr = _binary___obj_user_pingpong_pong_start;
  107710:	b8 48 f4 11 00       	mov    $0x11f448,%eax
  107715:	e9 69 ff ff ff       	jmp    107683 <sys_spawn+0x83>
  10771a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  } else if (elf_id == 3) {
    elf_addr = _binary___obj_user_pingpong_ding_start;
  107720:	b8 64 6c 12 00       	mov    $0x126c64,%eax
  107725:	e9 59 ff ff ff       	jmp    107683 <sys_spawn+0x83>
  10772a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    syscall_set_errno(tf, E_MAX_NUM_CHILDEN_REACHED);
    syscall_set_retval1(tf, NUM_IDS);
    return;
  }
  else if (nc == MAX_CHILDREN) {
    syscall_set_errno(tf, E_INVAL_CHILD_ID);
  107730:	c7 44 24 04 19 00 00 	movl   $0x19,0x4(%esp)
  107737:	00 
  107738:	eb 8e                	jmp    1076c8 <sys_spawn+0xc8>
  10773a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107740 <sys_yield>:
 * The user level library function sys_yield (defined in user/include/syscall.h)
 * does not take any argument and does not have any return values.
 * Do not forget to set the error number as E_SUCC.
 */
void sys_yield(tf_t *tf)
{
  107740:	83 ec 1c             	sub    $0x1c,%esp
  thread_yield();
  107743:	e8 38 f9 ff ff       	call   107080 <thread_yield>
  syscall_set_errno(tf, E_SUCC);
  107748:	8b 44 24 20          	mov    0x20(%esp),%eax
  10774c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  107753:	00 
  107754:	89 04 24             	mov    %eax,(%esp)
  107757:	e8 24 fd ff ff       	call   107480 <syscall_set_errno>
}
  10775c:	83 c4 1c             	add    $0x1c,%esp
  10775f:	c3                   	ret    

00107760 <sys_produce>:

void sys_produce(tf_t *tf)
{
  107760:	56                   	push   %esi
  107761:	53                   	push   %ebx
  unsigned int i;
  for(i = 0; i < 5; i++) {
  107762:	31 db                	xor    %ebx,%ebx
  thread_yield();
  syscall_set_errno(tf, E_SUCC);
}

void sys_produce(tf_t *tf)
{
  107764:	83 ec 24             	sub    $0x24,%esp
  unsigned int i;
  for(i = 0; i < 5; i++) {
    intr_local_disable();
  107767:	e8 84 a0 ff ff       	call   1017f0 <intr_local_disable>
    KERN_DEBUG("CPU %d: Process %d: Produced %d\n", get_pcpu_idx(), get_curid(), i);
  10776c:	e8 ff f7 ff ff       	call   106f70 <get_curid>
  107771:	89 c6                	mov    %eax,%esi
  107773:	e8 88 e4 ff ff       	call   105c00 <get_pcpu_idx>
  107778:	89 5c 24 14          	mov    %ebx,0x14(%esp)
}

void sys_produce(tf_t *tf)
{
  unsigned int i;
  for(i = 0; i < 5; i++) {
  10777c:	83 c3 01             	add    $0x1,%ebx
    intr_local_disable();
    KERN_DEBUG("CPU %d: Process %d: Produced %d\n", get_pcpu_idx(), get_curid(), i);
  10777f:	89 74 24 10          	mov    %esi,0x10(%esp)
  107783:	c7 44 24 08 a0 c3 10 	movl   $0x10c3a0,0x8(%esp)
  10778a:	00 
  10778b:	c7 44 24 04 96 00 00 	movl   $0x96,0x4(%esp)
  107792:	00 
  107793:	c7 04 24 80 c3 10 00 	movl   $0x10c380,(%esp)
  10779a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10779e:	e8 8d c9 ff ff       	call   104130 <debug_normal>
    intr_local_enable();
  1077a3:	e8 38 a0 ff ff       	call   1017e0 <intr_local_enable>
}

void sys_produce(tf_t *tf)
{
  unsigned int i;
  for(i = 0; i < 5; i++) {
  1077a8:	83 fb 05             	cmp    $0x5,%ebx
  1077ab:	75 ba                	jne    107767 <sys_produce+0x7>
    intr_local_disable();
    KERN_DEBUG("CPU %d: Process %d: Produced %d\n", get_pcpu_idx(), get_curid(), i);
    intr_local_enable();
  }
  syscall_set_errno(tf, E_SUCC);
  1077ad:	8b 44 24 30          	mov    0x30(%esp),%eax
  1077b1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1077b8:	00 
  1077b9:	89 04 24             	mov    %eax,(%esp)
  1077bc:	e8 bf fc ff ff       	call   107480 <syscall_set_errno>
}
  1077c1:	83 c4 24             	add    $0x24,%esp
  1077c4:	5b                   	pop    %ebx
  1077c5:	5e                   	pop    %esi
  1077c6:	c3                   	ret    
  1077c7:	89 f6                	mov    %esi,%esi
  1077c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001077d0 <sys_consume>:

void sys_consume(tf_t *tf)
{
  1077d0:	56                   	push   %esi
  1077d1:	53                   	push   %ebx
  unsigned int i;
  for(i = 0; i < 5; i++) {
  1077d2:	31 db                	xor    %ebx,%ebx
  }
  syscall_set_errno(tf, E_SUCC);
}

void sys_consume(tf_t *tf)
{
  1077d4:	83 ec 24             	sub    $0x24,%esp
  unsigned int i;
  for(i = 0; i < 5; i++) {
    intr_local_disable();
  1077d7:	e8 14 a0 ff ff       	call   1017f0 <intr_local_disable>
    KERN_DEBUG("CPU %d: Process %d: Consumed %d\n", get_pcpu_idx(), get_curid(), i);
  1077dc:	e8 8f f7 ff ff       	call   106f70 <get_curid>
  1077e1:	89 c6                	mov    %eax,%esi
  1077e3:	e8 18 e4 ff ff       	call   105c00 <get_pcpu_idx>
  1077e8:	89 5c 24 14          	mov    %ebx,0x14(%esp)
}

void sys_consume(tf_t *tf)
{
  unsigned int i;
  for(i = 0; i < 5; i++) {
  1077ec:	83 c3 01             	add    $0x1,%ebx
    intr_local_disable();
    KERN_DEBUG("CPU %d: Process %d: Consumed %d\n", get_pcpu_idx(), get_curid(), i);
  1077ef:	89 74 24 10          	mov    %esi,0x10(%esp)
  1077f3:	c7 44 24 08 c4 c3 10 	movl   $0x10c3c4,0x8(%esp)
  1077fa:	00 
  1077fb:	c7 44 24 04 a1 00 00 	movl   $0xa1,0x4(%esp)
  107802:	00 
  107803:	c7 04 24 80 c3 10 00 	movl   $0x10c380,(%esp)
  10780a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10780e:	e8 1d c9 ff ff       	call   104130 <debug_normal>
    intr_local_enable();
  107813:	e8 c8 9f ff ff       	call   1017e0 <intr_local_enable>
}

void sys_consume(tf_t *tf)
{
  unsigned int i;
  for(i = 0; i < 5; i++) {
  107818:	83 fb 05             	cmp    $0x5,%ebx
  10781b:	75 ba                	jne    1077d7 <sys_consume+0x7>
    intr_local_disable();
    KERN_DEBUG("CPU %d: Process %d: Consumed %d\n", get_pcpu_idx(), get_curid(), i);
    intr_local_enable();
  }
  syscall_set_errno(tf, E_SUCC);
  10781d:	8b 44 24 30          	mov    0x30(%esp),%eax
  107821:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  107828:	00 
  107829:	89 04 24             	mov    %eax,(%esp)
  10782c:	e8 4f fc ff ff       	call   107480 <syscall_set_errno>
}
  107831:	83 c4 24             	add    $0x24,%esp
  107834:	5b                   	pop    %ebx
  107835:	5e                   	pop    %esi
  107836:	c3                   	ret    
  107837:	66 90                	xchg   %ax,%ax
  107839:	66 90                	xchg   %ax,%ax
  10783b:	66 90                	xchg   %ax,%ax
  10783d:	66 90                	xchg   %ax,%ax
  10783f:	90                   	nop

00107840 <syscall_dispatch>:

#include "import.h"
#include <kern/fs/sysfile.h>

void syscall_dispatch(tf_t *tf)
{
  107840:	53                   	push   %ebx
  107841:	83 ec 18             	sub    $0x18,%esp
  107844:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  unsigned int nr;

  nr = syscall_get_arg1(tf);
  107848:	89 1c 24             	mov    %ebx,(%esp)
  10784b:	e8 a0 fb ff ff       	call   1073f0 <syscall_get_arg1>

  switch (nr) {
  107850:	83 f8 0d             	cmp    $0xd,%eax
  107853:	0f 87 f7 00 00 00    	ja     107950 <syscall_dispatch+0x110>
  107859:	ff 24 85 e8 c3 10 00 	jmp    *0x10c3e8(,%eax,4)
    break;
  case SYS_link:
    sys_link(tf);
    break;
  case SYS_unlink:
    sys_unlink(tf);
  107860:	89 5c 24 20          	mov    %ebx,0x20(%esp)
    sys_fstat(tf);
    break;
  default:
    syscall_set_errno(E_INVAL_CALLNR);
  }
}
  107864:	83 c4 18             	add    $0x18,%esp
  107867:	5b                   	pop    %ebx
    break;
  case SYS_link:
    sys_link(tf);
    break;
  case SYS_unlink:
    sys_unlink(tf);
  107868:	e9 a3 2a 00 00       	jmp    10a310 <sys_unlink>
  10786d:	8d 76 00             	lea    0x0(%esi),%esi
    break;
  case SYS_stat:
    sys_fstat(tf);
  107870:	89 5c 24 20          	mov    %ebx,0x20(%esp)
    break;
  default:
    syscall_set_errno(E_INVAL_CALLNR);
  }
}
  107874:	83 c4 18             	add    $0x18,%esp
  107877:	5b                   	pop    %ebx
    break;
  case SYS_unlink:
    sys_unlink(tf);
    break;
  case SYS_stat:
    sys_fstat(tf);
  107878:	e9 73 28 00 00       	jmp    10a0f0 <sys_fstat>
  10787d:	8d 76 00             	lea    0x0(%esi),%esi
     *   None.
     *
     * Error:
     *   E_MEM
     */
    sys_puts(tf);
  107880:	89 5c 24 20          	mov    %ebx,0x20(%esp)
    sys_fstat(tf);
    break;
  default:
    syscall_set_errno(E_INVAL_CALLNR);
  }
}
  107884:	83 c4 18             	add    $0x18,%esp
  107887:	5b                   	pop    %ebx
     *   None.
     *
     * Error:
     *   E_MEM
     */
    sys_puts(tf);
  107888:	e9 53 fc ff ff       	jmp    1074e0 <sys_puts>
  10788d:	8d 76 00             	lea    0x0(%esi),%esi
     *   the process ID of the process
     *
     * Error:
     *   E_INVAL_ADDR, E_INVAL_PID
     */
    sys_spawn(tf);
  107890:	89 5c 24 20          	mov    %ebx,0x20(%esp)
    sys_fstat(tf);
    break;
  default:
    syscall_set_errno(E_INVAL_CALLNR);
  }
}
  107894:	83 c4 18             	add    $0x18,%esp
  107897:	5b                   	pop    %ebx
     *   the process ID of the process
     *
     * Error:
     *   E_INVAL_ADDR, E_INVAL_PID
     */
    sys_spawn(tf);
  107898:	e9 63 fd ff ff       	jmp    107600 <sys_spawn>
  10789d:	8d 76 00             	lea    0x0(%esi),%esi
     *   None.
     *
     * Error:
     *   None.
     */
    sys_yield(tf);
  1078a0:	89 5c 24 20          	mov    %ebx,0x20(%esp)
    sys_fstat(tf);
    break;
  default:
    syscall_set_errno(E_INVAL_CALLNR);
  }
}
  1078a4:	83 c4 18             	add    $0x18,%esp
  1078a7:	5b                   	pop    %ebx
     *   None.
     *
     * Error:
     *   None.
     */
    sys_yield(tf);
  1078a8:	e9 93 fe ff ff       	jmp    107740 <sys_yield>
  1078ad:	8d 76 00             	lea    0x0(%esi),%esi
    break;
  case SYS_produce:
    intr_local_enable();
  1078b0:	e8 2b 9f ff ff       	call   1017e0 <intr_local_enable>
    sys_produce(tf);
  1078b5:	89 1c 24             	mov    %ebx,(%esp)
  1078b8:	e8 a3 fe ff ff       	call   107760 <sys_produce>
    sys_fstat(tf);
    break;
  default:
    syscall_set_errno(E_INVAL_CALLNR);
  }
}
  1078bd:	83 c4 18             	add    $0x18,%esp
  1078c0:	5b                   	pop    %ebx
    sys_yield(tf);
    break;
  case SYS_produce:
    intr_local_enable();
    sys_produce(tf);
    intr_local_disable();
  1078c1:	e9 2a 9f ff ff       	jmp    1017f0 <intr_local_disable>
  1078c6:	66 90                	xchg   %ax,%ax
    break;
  case SYS_consume:
    intr_local_enable();
  1078c8:	e8 13 9f ff ff       	call   1017e0 <intr_local_enable>
    sys_consume(tf);
  1078cd:	89 1c 24             	mov    %ebx,(%esp)
  1078d0:	e8 fb fe ff ff       	call   1077d0 <sys_consume>
    sys_fstat(tf);
    break;
  default:
    syscall_set_errno(E_INVAL_CALLNR);
  }
}
  1078d5:	83 c4 18             	add    $0x18,%esp
  1078d8:	5b                   	pop    %ebx
    intr_local_disable();
    break;
  case SYS_consume:
    intr_local_enable();
    sys_consume(tf);
    intr_local_disable();
  1078d9:	e9 12 9f ff ff       	jmp    1017f0 <intr_local_disable>
  1078de:	66 90                	xchg   %ax,%ax
    break;

  /** Filesystem calls **/
  case SYS_open:
    sys_open(tf);
  1078e0:	89 5c 24 20          	mov    %ebx,0x20(%esp)
    sys_fstat(tf);
    break;
  default:
    syscall_set_errno(E_INVAL_CALLNR);
  }
}
  1078e4:	83 c4 18             	add    $0x18,%esp
  1078e7:	5b                   	pop    %ebx
    intr_local_disable();
    break;

  /** Filesystem calls **/
  case SYS_open:
    sys_open(tf);
  1078e8:	e9 73 2c 00 00       	jmp    10a560 <sys_open>
  1078ed:	8d 76 00             	lea    0x0(%esi),%esi
    break;
  case SYS_close:
    sys_close(tf);
  1078f0:	89 5c 24 20          	mov    %ebx,0x20(%esp)
    sys_fstat(tf);
    break;
  default:
    syscall_set_errno(E_INVAL_CALLNR);
  }
}
  1078f4:	83 c4 18             	add    $0x18,%esp
  1078f7:	5b                   	pop    %ebx
  /** Filesystem calls **/
  case SYS_open:
    sys_open(tf);
    break;
  case SYS_close:
    sys_close(tf);
  1078f8:	e9 53 27 00 00       	jmp    10a050 <sys_close>
  1078fd:	8d 76 00             	lea    0x0(%esi),%esi
    break;
  case SYS_read:
    sys_read(tf);
  107900:	89 5c 24 20          	mov    %ebx,0x20(%esp)
    sys_fstat(tf);
    break;
  default:
    syscall_set_errno(E_INVAL_CALLNR);
  }
}
  107904:	83 c4 18             	add    $0x18,%esp
  107907:	5b                   	pop    %ebx
    break;
  case SYS_close:
    sys_close(tf);
    break;
  case SYS_read:
    sys_read(tf);
  107908:	e9 c3 25 00 00       	jmp    109ed0 <sys_read>
  10790d:	8d 76 00             	lea    0x0(%esi),%esi
    break;
  case SYS_write:
    sys_write(tf);
  107910:	89 5c 24 20          	mov    %ebx,0x20(%esp)
    sys_fstat(tf);
    break;
  default:
    syscall_set_errno(E_INVAL_CALLNR);
  }
}
  107914:	83 c4 18             	add    $0x18,%esp
  107917:	5b                   	pop    %ebx
    break;
  case SYS_read:
    sys_read(tf);
    break;
  case SYS_write:
    sys_write(tf);
  107918:	e9 73 26 00 00       	jmp    109f90 <sys_write>
  10791d:	8d 76 00             	lea    0x0(%esi),%esi
    break;
  case SYS_mkdir:
    sys_mkdir(tf);
  107920:	89 5c 24 20          	mov    %ebx,0x20(%esp)
    sys_fstat(tf);
    break;
  default:
    syscall_set_errno(E_INVAL_CALLNR);
  }
}
  107924:	83 c4 18             	add    $0x18,%esp
  107927:	5b                   	pop    %ebx
    break;
  case SYS_write:
    sys_write(tf);
    break;
  case SYS_mkdir:
    sys_mkdir(tf);
  107928:	e9 33 2e 00 00       	jmp    10a760 <sys_mkdir>
  10792d:	8d 76 00             	lea    0x0(%esi),%esi
    break;
  case SYS_chdir:
    sys_chdir(tf);
  107930:	89 5c 24 20          	mov    %ebx,0x20(%esp)
    sys_fstat(tf);
    break;
  default:
    syscall_set_errno(E_INVAL_CALLNR);
  }
}
  107934:	83 c4 18             	add    $0x18,%esp
  107937:	5b                   	pop    %ebx
    break;
  case SYS_mkdir:
    sys_mkdir(tf);
    break;
  case SYS_chdir:
    sys_chdir(tf);
  107938:	e9 c3 2e 00 00       	jmp    10a800 <sys_chdir>
  10793d:	8d 76 00             	lea    0x0(%esi),%esi
    break;
  case SYS_link:
    sys_link(tf);
  107940:	89 5c 24 20          	mov    %ebx,0x20(%esp)
    sys_fstat(tf);
    break;
  default:
    syscall_set_errno(E_INVAL_CALLNR);
  }
}
  107944:	83 c4 18             	add    $0x18,%esp
  107947:	5b                   	pop    %ebx
    break;
  case SYS_chdir:
    sys_chdir(tf);
    break;
  case SYS_link:
    sys_link(tf);
  107948:	e9 53 28 00 00       	jmp    10a1a0 <sys_link>
  10794d:	8d 76 00             	lea    0x0(%esi),%esi
    break;
  case SYS_stat:
    sys_fstat(tf);
    break;
  default:
    syscall_set_errno(E_INVAL_CALLNR);
  107950:	c7 44 24 20 03 00 00 	movl   $0x3,0x20(%esp)
  107957:	00 
  }
}
  107958:	83 c4 18             	add    $0x18,%esp
  10795b:	5b                   	pop    %ebx
    break;
  case SYS_stat:
    sys_fstat(tf);
    break;
  default:
    syscall_set_errno(E_INVAL_CALLNR);
  10795c:	e9 1f fb ff ff       	jmp    107480 <syscall_set_errno>
  107961:	66 90                	xchg   %ax,%ax
  107963:	66 90                	xchg   %ax,%ax
  107965:	66 90                	xchg   %ax,%ax
  107967:	66 90                	xchg   %ax,%ax
  107969:	66 90                	xchg   %ax,%ax
  10796b:	66 90                	xchg   %ax,%ax
  10796d:	66 90                	xchg   %ax,%ax
  10796f:	90                   	nop

00107970 <trap_dump>:
#include "import.h"

void ide_intr(void);

static void trap_dump(tf_t *tf)
{
  107970:	53                   	push   %ebx
  107971:	89 c3                	mov    %eax,%ebx
  107973:	83 ec 28             	sub    $0x28,%esp
	if (tf == NULL)
  107976:	85 c0                	test   %eax,%eax
  107978:	0f 84 e9 02 00 00    	je     107c67 <trap_dump+0x2f7>
		return;

	uintptr_t base = (uintptr_t) tf;

	KERN_DEBUG("trapframe at %x\n", base);
  10797e:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107982:	c7 44 24 08 20 c4 10 	movl   $0x10c420,0x8(%esp)
  107989:	00 
  10798a:	c7 44 24 04 17 00 00 	movl   $0x17,0x4(%esp)
  107991:	00 
  107992:	c7 04 24 a4 c5 10 00 	movl   $0x10c5a4,(%esp)
  107999:	e8 92 c7 ff ff       	call   104130 <debug_normal>
	KERN_DEBUG("\t%08x:\tedi:   \t\t%08x\n", &tf->regs.edi, tf->regs.edi);
  10799e:	8b 03                	mov    (%ebx),%eax
  1079a0:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  1079a4:	c7 44 24 08 31 c4 10 	movl   $0x10c431,0x8(%esp)
  1079ab:	00 
  1079ac:	c7 44 24 04 18 00 00 	movl   $0x18,0x4(%esp)
  1079b3:	00 
  1079b4:	89 44 24 10          	mov    %eax,0x10(%esp)
  1079b8:	c7 04 24 a4 c5 10 00 	movl   $0x10c5a4,(%esp)
  1079bf:	e8 6c c7 ff ff       	call   104130 <debug_normal>
	KERN_DEBUG("\t%08x:\tesi:   \t\t%08x\n", &tf->regs.esi, tf->regs.esi);
  1079c4:	8b 43 04             	mov    0x4(%ebx),%eax
  1079c7:	c7 44 24 08 47 c4 10 	movl   $0x10c447,0x8(%esp)
  1079ce:	00 
  1079cf:	c7 44 24 04 19 00 00 	movl   $0x19,0x4(%esp)
  1079d6:	00 
  1079d7:	c7 04 24 a4 c5 10 00 	movl   $0x10c5a4,(%esp)
  1079de:	89 44 24 10          	mov    %eax,0x10(%esp)
  1079e2:	8d 43 04             	lea    0x4(%ebx),%eax
  1079e5:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1079e9:	e8 42 c7 ff ff       	call   104130 <debug_normal>
	KERN_DEBUG("\t%08x:\tebp:   \t\t%08x\n", &tf->regs.ebp, tf->regs.ebp);
  1079ee:	8b 43 08             	mov    0x8(%ebx),%eax
  1079f1:	c7 44 24 08 5d c4 10 	movl   $0x10c45d,0x8(%esp)
  1079f8:	00 
  1079f9:	c7 44 24 04 1a 00 00 	movl   $0x1a,0x4(%esp)
  107a00:	00 
  107a01:	c7 04 24 a4 c5 10 00 	movl   $0x10c5a4,(%esp)
  107a08:	89 44 24 10          	mov    %eax,0x10(%esp)
  107a0c:	8d 43 08             	lea    0x8(%ebx),%eax
  107a0f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107a13:	e8 18 c7 ff ff       	call   104130 <debug_normal>
	KERN_DEBUG("\t%08x:\tesp:   \t\t%08x\n", &tf->regs.oesp, tf->regs.oesp);
  107a18:	8b 43 0c             	mov    0xc(%ebx),%eax
  107a1b:	c7 44 24 08 73 c4 10 	movl   $0x10c473,0x8(%esp)
  107a22:	00 
  107a23:	c7 44 24 04 1b 00 00 	movl   $0x1b,0x4(%esp)
  107a2a:	00 
  107a2b:	c7 04 24 a4 c5 10 00 	movl   $0x10c5a4,(%esp)
  107a32:	89 44 24 10          	mov    %eax,0x10(%esp)
  107a36:	8d 43 0c             	lea    0xc(%ebx),%eax
  107a39:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107a3d:	e8 ee c6 ff ff       	call   104130 <debug_normal>
	KERN_DEBUG("\t%08x:\tebx:   \t\t%08x\n", &tf->regs.ebx, tf->regs.ebx);
  107a42:	8b 43 10             	mov    0x10(%ebx),%eax
  107a45:	c7 44 24 08 89 c4 10 	movl   $0x10c489,0x8(%esp)
  107a4c:	00 
  107a4d:	c7 44 24 04 1c 00 00 	movl   $0x1c,0x4(%esp)
  107a54:	00 
  107a55:	c7 04 24 a4 c5 10 00 	movl   $0x10c5a4,(%esp)
  107a5c:	89 44 24 10          	mov    %eax,0x10(%esp)
  107a60:	8d 43 10             	lea    0x10(%ebx),%eax
  107a63:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107a67:	e8 c4 c6 ff ff       	call   104130 <debug_normal>
	KERN_DEBUG("\t%08x:\tedx:   \t\t%08x\n", &tf->regs.edx, tf->regs.edx);
  107a6c:	8b 43 14             	mov    0x14(%ebx),%eax
  107a6f:	c7 44 24 08 9f c4 10 	movl   $0x10c49f,0x8(%esp)
  107a76:	00 
  107a77:	c7 44 24 04 1d 00 00 	movl   $0x1d,0x4(%esp)
  107a7e:	00 
  107a7f:	c7 04 24 a4 c5 10 00 	movl   $0x10c5a4,(%esp)
  107a86:	89 44 24 10          	mov    %eax,0x10(%esp)
  107a8a:	8d 43 14             	lea    0x14(%ebx),%eax
  107a8d:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107a91:	e8 9a c6 ff ff       	call   104130 <debug_normal>
	KERN_DEBUG("\t%08x:\tecx:   \t\t%08x\n", &tf->regs.ecx, tf->regs.ecx);
  107a96:	8b 43 18             	mov    0x18(%ebx),%eax
  107a99:	c7 44 24 08 b5 c4 10 	movl   $0x10c4b5,0x8(%esp)
  107aa0:	00 
  107aa1:	c7 44 24 04 1e 00 00 	movl   $0x1e,0x4(%esp)
  107aa8:	00 
  107aa9:	c7 04 24 a4 c5 10 00 	movl   $0x10c5a4,(%esp)
  107ab0:	89 44 24 10          	mov    %eax,0x10(%esp)
  107ab4:	8d 43 18             	lea    0x18(%ebx),%eax
  107ab7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107abb:	e8 70 c6 ff ff       	call   104130 <debug_normal>
	KERN_DEBUG("\t%08x:\teax:   \t\t%08x\n", &tf->regs.eax, tf->regs.eax);
  107ac0:	8b 43 1c             	mov    0x1c(%ebx),%eax
  107ac3:	c7 44 24 08 cb c4 10 	movl   $0x10c4cb,0x8(%esp)
  107aca:	00 
  107acb:	c7 44 24 04 1f 00 00 	movl   $0x1f,0x4(%esp)
  107ad2:	00 
  107ad3:	c7 04 24 a4 c5 10 00 	movl   $0x10c5a4,(%esp)
  107ada:	89 44 24 10          	mov    %eax,0x10(%esp)
  107ade:	8d 43 1c             	lea    0x1c(%ebx),%eax
  107ae1:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107ae5:	e8 46 c6 ff ff       	call   104130 <debug_normal>
	KERN_DEBUG("\t%08x:\tes:    \t\t%08x\n", &tf->es, tf->es);
  107aea:	0f b7 43 20          	movzwl 0x20(%ebx),%eax
  107aee:	c7 44 24 08 e1 c4 10 	movl   $0x10c4e1,0x8(%esp)
  107af5:	00 
  107af6:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  107afd:	00 
  107afe:	c7 04 24 a4 c5 10 00 	movl   $0x10c5a4,(%esp)
  107b05:	89 44 24 10          	mov    %eax,0x10(%esp)
  107b09:	8d 43 20             	lea    0x20(%ebx),%eax
  107b0c:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107b10:	e8 1b c6 ff ff       	call   104130 <debug_normal>
	KERN_DEBUG("\t%08x:\tds:    \t\t%08x\n", &tf->ds, tf->ds);
  107b15:	0f b7 43 24          	movzwl 0x24(%ebx),%eax
  107b19:	c7 44 24 08 f7 c4 10 	movl   $0x10c4f7,0x8(%esp)
  107b20:	00 
  107b21:	c7 44 24 04 21 00 00 	movl   $0x21,0x4(%esp)
  107b28:	00 
  107b29:	c7 04 24 a4 c5 10 00 	movl   $0x10c5a4,(%esp)
  107b30:	89 44 24 10          	mov    %eax,0x10(%esp)
  107b34:	8d 43 24             	lea    0x24(%ebx),%eax
  107b37:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107b3b:	e8 f0 c5 ff ff       	call   104130 <debug_normal>
	KERN_DEBUG("\t%08x:\ttrapno:\t\t%08x\n", &tf->trapno, tf->trapno);
  107b40:	8b 43 28             	mov    0x28(%ebx),%eax
  107b43:	c7 44 24 08 0d c5 10 	movl   $0x10c50d,0x8(%esp)
  107b4a:	00 
  107b4b:	c7 44 24 04 22 00 00 	movl   $0x22,0x4(%esp)
  107b52:	00 
  107b53:	c7 04 24 a4 c5 10 00 	movl   $0x10c5a4,(%esp)
  107b5a:	89 44 24 10          	mov    %eax,0x10(%esp)
  107b5e:	8d 43 28             	lea    0x28(%ebx),%eax
  107b61:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107b65:	e8 c6 c5 ff ff       	call   104130 <debug_normal>
	KERN_DEBUG("\t%08x:\terr:   \t\t%08x\n", &tf->err, tf->err);
  107b6a:	8b 43 2c             	mov    0x2c(%ebx),%eax
  107b6d:	c7 44 24 08 23 c5 10 	movl   $0x10c523,0x8(%esp)
  107b74:	00 
  107b75:	c7 44 24 04 23 00 00 	movl   $0x23,0x4(%esp)
  107b7c:	00 
  107b7d:	c7 04 24 a4 c5 10 00 	movl   $0x10c5a4,(%esp)
  107b84:	89 44 24 10          	mov    %eax,0x10(%esp)
  107b88:	8d 43 2c             	lea    0x2c(%ebx),%eax
  107b8b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107b8f:	e8 9c c5 ff ff       	call   104130 <debug_normal>
	KERN_DEBUG("\t%08x:\teip:   \t\t%08x\n", &tf->eip, tf->eip);
  107b94:	8b 43 30             	mov    0x30(%ebx),%eax
  107b97:	c7 44 24 08 39 c5 10 	movl   $0x10c539,0x8(%esp)
  107b9e:	00 
  107b9f:	c7 44 24 04 24 00 00 	movl   $0x24,0x4(%esp)
  107ba6:	00 
  107ba7:	c7 04 24 a4 c5 10 00 	movl   $0x10c5a4,(%esp)
  107bae:	89 44 24 10          	mov    %eax,0x10(%esp)
  107bb2:	8d 43 30             	lea    0x30(%ebx),%eax
  107bb5:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107bb9:	e8 72 c5 ff ff       	call   104130 <debug_normal>
	KERN_DEBUG("\t%08x:\tcs:    \t\t%08x\n", &tf->cs, tf->cs);
  107bbe:	0f b7 43 34          	movzwl 0x34(%ebx),%eax
  107bc2:	c7 44 24 08 4f c5 10 	movl   $0x10c54f,0x8(%esp)
  107bc9:	00 
  107bca:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
  107bd1:	00 
  107bd2:	c7 04 24 a4 c5 10 00 	movl   $0x10c5a4,(%esp)
  107bd9:	89 44 24 10          	mov    %eax,0x10(%esp)
  107bdd:	8d 43 34             	lea    0x34(%ebx),%eax
  107be0:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107be4:	e8 47 c5 ff ff       	call   104130 <debug_normal>
	KERN_DEBUG("\t%08x:\teflags:\t\t%08x\n", &tf->eflags, tf->eflags);
  107be9:	8b 43 38             	mov    0x38(%ebx),%eax
  107bec:	c7 44 24 08 65 c5 10 	movl   $0x10c565,0x8(%esp)
  107bf3:	00 
  107bf4:	c7 44 24 04 26 00 00 	movl   $0x26,0x4(%esp)
  107bfb:	00 
  107bfc:	c7 04 24 a4 c5 10 00 	movl   $0x10c5a4,(%esp)
  107c03:	89 44 24 10          	mov    %eax,0x10(%esp)
  107c07:	8d 43 38             	lea    0x38(%ebx),%eax
  107c0a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107c0e:	e8 1d c5 ff ff       	call   104130 <debug_normal>
	KERN_DEBUG("\t%08x:\tesp:   \t\t%08x\n", &tf->esp, tf->esp);
  107c13:	8b 43 3c             	mov    0x3c(%ebx),%eax
  107c16:	c7 44 24 08 73 c4 10 	movl   $0x10c473,0x8(%esp)
  107c1d:	00 
  107c1e:	c7 44 24 04 27 00 00 	movl   $0x27,0x4(%esp)
  107c25:	00 
  107c26:	c7 04 24 a4 c5 10 00 	movl   $0x10c5a4,(%esp)
  107c2d:	89 44 24 10          	mov    %eax,0x10(%esp)
  107c31:	8d 43 3c             	lea    0x3c(%ebx),%eax
	KERN_DEBUG("\t%08x:\tss:    \t\t%08x\n", &tf->ss, tf->ss);
  107c34:	83 c3 40             	add    $0x40,%ebx
	KERN_DEBUG("\t%08x:\ttrapno:\t\t%08x\n", &tf->trapno, tf->trapno);
	KERN_DEBUG("\t%08x:\terr:   \t\t%08x\n", &tf->err, tf->err);
	KERN_DEBUG("\t%08x:\teip:   \t\t%08x\n", &tf->eip, tf->eip);
	KERN_DEBUG("\t%08x:\tcs:    \t\t%08x\n", &tf->cs, tf->cs);
	KERN_DEBUG("\t%08x:\teflags:\t\t%08x\n", &tf->eflags, tf->eflags);
	KERN_DEBUG("\t%08x:\tesp:   \t\t%08x\n", &tf->esp, tf->esp);
  107c37:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107c3b:	e8 f0 c4 ff ff       	call   104130 <debug_normal>
	KERN_DEBUG("\t%08x:\tss:    \t\t%08x\n", &tf->ss, tf->ss);
  107c40:	0f b7 03             	movzwl (%ebx),%eax
  107c43:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  107c47:	c7 44 24 08 7b c5 10 	movl   $0x10c57b,0x8(%esp)
  107c4e:	00 
  107c4f:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
  107c56:	00 
  107c57:	89 44 24 10          	mov    %eax,0x10(%esp)
  107c5b:	c7 04 24 a4 c5 10 00 	movl   $0x10c5a4,(%esp)
  107c62:	e8 c9 c4 ff ff       	call   104130 <debug_normal>
}
  107c67:	83 c4 28             	add    $0x28,%esp
  107c6a:	5b                   	pop    %ebx
  107c6b:	c3                   	ret    
  107c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00107c70 <default_exception_handler>:

void default_exception_handler(tf_t *tf)
{
  107c70:	53                   	push   %ebx
  107c71:	83 ec 28             	sub    $0x28,%esp
  107c74:	8b 5c 24 30          	mov    0x30(%esp),%ebx
	unsigned int cur_pid;

	cur_pid = get_curid();
  107c78:	e8 f3 f2 ff ff       	call   106f70 <get_curid>
	trap_dump(tf);
  107c7d:	89 d8                	mov    %ebx,%eax
  107c7f:	e8 ec fc ff ff       	call   107970 <trap_dump>

	KERN_PANIC("Trap %d @ 0x%08x.\n", tf -> trapno, tf -> eip);
  107c84:	8b 43 30             	mov    0x30(%ebx),%eax
  107c87:	89 44 24 10          	mov    %eax,0x10(%esp)
  107c8b:	8b 43 28             	mov    0x28(%ebx),%eax
  107c8e:	c7 44 24 08 91 c5 10 	movl   $0x10c591,0x8(%esp)
  107c95:	00 
  107c96:	c7 44 24 04 32 00 00 	movl   $0x32,0x4(%esp)
  107c9d:	00 
  107c9e:	c7 04 24 a4 c5 10 00 	movl   $0x10c5a4,(%esp)
  107ca5:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107ca9:	e8 d2 c4 ff ff       	call   104180 <debug_panic>
}
  107cae:	83 c4 28             	add    $0x28,%esp
  107cb1:	5b                   	pop    %ebx
  107cb2:	c3                   	ret    
  107cb3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  107cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00107cc0 <pgflt_handler>:

void pgflt_handler(tf_t *tf)
{
  107cc0:	55                   	push   %ebp
  107cc1:	57                   	push   %edi
  107cc2:	56                   	push   %esi
  107cc3:	53                   	push   %ebx
  107cc4:	83 ec 2c             	sub    $0x2c,%esp
  107cc7:	8b 74 24 40          	mov    0x40(%esp),%esi
	unsigned int cur_pid;
	unsigned int errno;
	unsigned int fault_va;

	cur_pid = get_curid();
  107ccb:	e8 a0 f2 ff ff       	call   106f70 <get_curid>
	errno = tf -> err;
  107cd0:	8b 5e 2c             	mov    0x2c(%esi),%ebx
{
	unsigned int cur_pid;
	unsigned int errno;
	unsigned int fault_va;

	cur_pid = get_curid();
  107cd3:	89 c5                	mov    %eax,%ebp
	errno = tf -> err;
	fault_va = rcr2();
  107cd5:	e8 16 d3 ff ff       	call   104ff0 <rcr2>

  //Uncomment this line if you need to see the information of the sequence of page faults occured.
	//KERN_DEBUG("Page fault: VA 0x%08x, errno 0x%08x, process %d, EIP 0x%08x.\n", fault_va, errno, cur_pid, tf -> eip);

	if (errno & PFE_PR) {
  107cda:	f6 c3 01             	test   $0x1,%bl
	unsigned int errno;
	unsigned int fault_va;

	cur_pid = get_curid();
	errno = tf -> err;
	fault_va = rcr2();
  107cdd:	89 c7                	mov    %eax,%edi

  //Uncomment this line if you need to see the information of the sequence of page faults occured.
	//KERN_DEBUG("Page fault: VA 0x%08x, errno 0x%08x, process %d, EIP 0x%08x.\n", fault_va, errno, cur_pid, tf -> eip);

	if (errno & PFE_PR) {
  107cdf:	75 27                	jne    107d08 <pgflt_handler+0x48>
		trap_dump(tf);
		KERN_PANIC("Permission denied: va = 0x%08x, errno = 0x%08x.\n", fault_va, errno);
		return;
	}

	if (alloc_page(cur_pid, fault_va, PTE_W | PTE_U | PTE_P) == MagicNumber)
  107ce1:	c7 44 24 08 07 00 00 	movl   $0x7,0x8(%esp)
  107ce8:	00 
  107ce9:	89 44 24 04          	mov    %eax,0x4(%esp)
  107ced:	89 2c 24             	mov    %ebp,(%esp)
  107cf0:	e8 7b ec ff ff       	call   106970 <alloc_page>
  107cf5:	3d 01 00 10 00       	cmp    $0x100001,%eax
  107cfa:	74 44                	je     107d40 <pgflt_handler+0x80>
    KERN_PANIC("Page allocation failed: va = 0x%08x, errno = 0x%08x.\n", fault_va, errno);

}
  107cfc:	83 c4 2c             	add    $0x2c,%esp
  107cff:	5b                   	pop    %ebx
  107d00:	5e                   	pop    %esi
  107d01:	5f                   	pop    %edi
  107d02:	5d                   	pop    %ebp
  107d03:	c3                   	ret    
  107d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  //Uncomment this line if you need to see the information of the sequence of page faults occured.
	//KERN_DEBUG("Page fault: VA 0x%08x, errno 0x%08x, process %d, EIP 0x%08x.\n", fault_va, errno, cur_pid, tf -> eip);

	if (errno & PFE_PR) {
		trap_dump(tf);
  107d08:	89 f0                	mov    %esi,%eax
  107d0a:	e8 61 fc ff ff       	call   107970 <trap_dump>
		KERN_PANIC("Permission denied: va = 0x%08x, errno = 0x%08x.\n", fault_va, errno);
  107d0f:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  107d13:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  107d17:	c7 44 24 08 cc c5 10 	movl   $0x10c5cc,0x8(%esp)
  107d1e:	00 
  107d1f:	c7 44 24 04 44 00 00 	movl   $0x44,0x4(%esp)
  107d26:	00 
  107d27:	c7 04 24 a4 c5 10 00 	movl   $0x10c5a4,(%esp)
  107d2e:	e8 4d c4 ff ff       	call   104180 <debug_panic>
	}

	if (alloc_page(cur_pid, fault_va, PTE_W | PTE_U | PTE_P) == MagicNumber)
    KERN_PANIC("Page allocation failed: va = 0x%08x, errno = 0x%08x.\n", fault_va, errno);

}
  107d33:	83 c4 2c             	add    $0x2c,%esp
  107d36:	5b                   	pop    %ebx
  107d37:	5e                   	pop    %esi
  107d38:	5f                   	pop    %edi
  107d39:	5d                   	pop    %ebp
  107d3a:	c3                   	ret    
  107d3b:	90                   	nop
  107d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		KERN_PANIC("Permission denied: va = 0x%08x, errno = 0x%08x.\n", fault_va, errno);
		return;
	}

	if (alloc_page(cur_pid, fault_va, PTE_W | PTE_U | PTE_P) == MagicNumber)
    KERN_PANIC("Page allocation failed: va = 0x%08x, errno = 0x%08x.\n", fault_va, errno);
  107d40:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  107d44:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  107d48:	c7 44 24 08 00 c6 10 	movl   $0x10c600,0x8(%esp)
  107d4f:	00 
  107d50:	c7 44 24 04 49 00 00 	movl   $0x49,0x4(%esp)
  107d57:	00 
  107d58:	c7 04 24 a4 c5 10 00 	movl   $0x10c5a4,(%esp)
  107d5f:	e8 1c c4 ff ff       	call   104180 <debug_panic>

}
  107d64:	83 c4 2c             	add    $0x2c,%esp
  107d67:	5b                   	pop    %ebx
  107d68:	5e                   	pop    %esi
  107d69:	5f                   	pop    %edi
  107d6a:	5d                   	pop    %ebp
  107d6b:	c3                   	ret    
  107d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00107d70 <exception_handler>:
/**
 * We currently only handle the page fault exception.
 * All other exceptions should be routed to the default exception handler.
 */
void exception_handler(tf_t *tf)
{
  107d70:	53                   	push   %ebx
  107d71:	83 ec 08             	sub    $0x8,%esp
  107d74:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	unsigned int cur_pid;
	unsigned int trapno;

	cur_pid = get_curid();
  107d78:	e8 f3 f1 ff ff       	call   106f70 <get_curid>
	trapno = tf -> trapno;

	if (trapno == T_PGFLT)
  107d7d:	83 7b 28 0e          	cmpl   $0xe,0x28(%ebx)
		pgflt_handler(tf);
  107d81:	89 5c 24 10          	mov    %ebx,0x10(%esp)
	unsigned int trapno;

	cur_pid = get_curid();
	trapno = tf -> trapno;

	if (trapno == T_PGFLT)
  107d85:	74 09                	je     107d90 <exception_handler+0x20>
		pgflt_handler(tf);
	else
		default_exception_handler(tf);
}
  107d87:	83 c4 08             	add    $0x8,%esp
  107d8a:	5b                   	pop    %ebx
	trapno = tf -> trapno;

	if (trapno == T_PGFLT)
		pgflt_handler(tf);
	else
		default_exception_handler(tf);
  107d8b:	e9 e0 fe ff ff       	jmp    107c70 <default_exception_handler>
}
  107d90:	83 c4 08             	add    $0x8,%esp
  107d93:	5b                   	pop    %ebx

	cur_pid = get_curid();
	trapno = tf -> trapno;

	if (trapno == T_PGFLT)
		pgflt_handler(tf);
  107d94:	e9 27 ff ff ff       	jmp    107cc0 <pgflt_handler>
  107d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00107da0 <interrupt_handler>:
/**
 * Any interrupt request except the spurious or timer should be
 * routed to the default interrupt handler.
 */
void interrupt_handler (tf_t *tf)
{
  107da0:	53                   	push   %ebx
  107da1:	83 ec 08             	sub    $0x8,%esp
  107da4:	8b 5c 24 10          	mov    0x10(%esp),%ebx
    unsigned int cur_pid;
    unsigned int trapno;

    cur_pid = get_curid ();
  107da8:	e8 c3 f1 ff ff       	call   106f70 <get_curid>

    trapno = tf -> trapno;

    switch (trapno)
  107dad:	8b 43 28             	mov    0x28(%ebx),%eax
  107db0:	83 f8 27             	cmp    $0x27,%eax
  107db3:	74 20                	je     107dd5 <interrupt_handler+0x35>
  107db5:	76 39                	jbe    107df0 <interrupt_handler+0x50>
  107db7:	83 f8 2e             	cmp    $0x2e,%eax
  107dba:	75 14                	jne    107dd0 <interrupt_handler+0x30>
  107dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          break;
      case T_IRQ0 + IRQ_TIMER:
          timer_intr_handler ();
          break;
      case T_IRQ0 + IRQ_IDE1:
	ide_intr();
  107dc0:	e8 ab bd ff ff       	call   103b70 <ide_intr>
      case T_IRQ0 + IRQ_IDE2:
	break;
      default:
          default_intr_handler ();
    }
}
  107dc5:	83 c4 08             	add    $0x8,%esp
  107dc8:	5b                   	pop    %ebx
      case T_IRQ0 + IRQ_TIMER:
          timer_intr_handler ();
          break;
      case T_IRQ0 + IRQ_IDE1:
	ide_intr();
	intr_eoi();
  107dc9:	e9 f2 99 ff ff       	jmp    1017c0 <intr_eoi>
  107dce:	66 90                	xchg   %ax,%ax

    cur_pid = get_curid ();

    trapno = tf -> trapno;

    switch (trapno)
  107dd0:	83 f8 2f             	cmp    $0x2f,%eax
  107dd3:	75 0b                	jne    107de0 <interrupt_handler+0x40>
      case T_IRQ0 + IRQ_IDE2:
	break;
      default:
          default_intr_handler ();
    }
}
  107dd5:	83 c4 08             	add    $0x8,%esp
  107dd8:	5b                   	pop    %ebx
  107dd9:	c3                   	ret    
  107dda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  107de0:	83 c4 08             	add    $0x8,%esp
  107de3:	5b                   	pop    %ebx
    return 0;
}

static int default_intr_handler (void)
{
    intr_eoi ();
  107de4:	e9 d7 99 ff ff       	jmp    1017c0 <intr_eoi>
  107de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    cur_pid = get_curid ();

    trapno = tf -> trapno;

    switch (trapno)
  107df0:	83 f8 20             	cmp    $0x20,%eax
  107df3:	75 eb                	jne    107de0 <interrupt_handler+0x40>
    return 0;
}

static int timer_intr_handler (void)
{
    intr_eoi ();
  107df5:	e8 c6 99 ff ff       	call   1017c0 <intr_eoi>
      case T_IRQ0 + IRQ_IDE2:
	break;
      default:
          default_intr_handler ();
    }
}
  107dfa:	83 c4 08             	add    $0x8,%esp
  107dfd:	5b                   	pop    %ebx
}

static int timer_intr_handler (void)
{
    intr_eoi ();
    sched_update();
  107dfe:	e9 0d f3 ff ff       	jmp    107110 <sched_update>
  107e03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  107e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00107e10 <trap>:
          default_intr_handler ();
    }
}

void trap (tf_t *tf)
{
  107e10:	56                   	push   %esi
  107e11:	53                   	push   %ebx
  107e12:	83 ec 24             	sub    $0x24,%esp
  107e15:	8b 5c 24 30          	mov    0x30(%esp),%ebx
    unsigned int cur_pid;
    unsigned int in_kernel;

    cur_pid = get_curid ();
  107e19:	e8 52 f1 ff ff       	call   106f70 <get_curid>
    set_pdir_base (0); //switch to the kernel's page table.
  107e1e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
void trap (tf_t *tf)
{
    unsigned int cur_pid;
    unsigned int in_kernel;

    cur_pid = get_curid ();
  107e25:	89 c6                	mov    %eax,%esi
    set_pdir_base (0); //switch to the kernel's page table.
  107e27:	e8 24 e6 ff ff       	call   106450 <set_pdir_base>

    trap_cb_t f;

    f = TRAP_HANDLER[get_pcpu_idx()][tf->trapno];
  107e2c:	e8 cf dd ff ff       	call   105c00 <get_pcpu_idx>
  107e31:	8b 4b 28             	mov    0x28(%ebx),%ecx
  107e34:	c1 e0 08             	shl    $0x8,%eax
  107e37:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  107e3a:	8b 04 95 00 90 9c 00 	mov    0x9c9000(,%edx,4),%eax

    if (f){
  107e41:	85 c0                	test   %eax,%eax
  107e43:	74 23                	je     107e68 <trap+0x58>
            f(tf);
  107e45:	89 1c 24             	mov    %ebx,(%esp)
  107e48:	ff d0                	call   *%eax
    } else {
            KERN_WARN("No handler for user trap 0x%x, process %d, eip 0x%08x. \n",
                            tf->trapno, cur_pid, tf->eip);
    }

    kstack_switch(cur_pid);
  107e4a:	89 34 24             	mov    %esi,(%esp)
  107e4d:	e8 de ca ff ff       	call   104930 <kstack_switch>
    set_pdir_base(cur_pid);
  107e52:	89 34 24             	mov    %esi,(%esp)
  107e55:	e8 f6 e5 ff ff       	call   106450 <set_pdir_base>
	  trap_return((void *) tf);
  107e5a:	89 5c 24 30          	mov    %ebx,0x30(%esp)
}
  107e5e:	83 c4 24             	add    $0x24,%esp
  107e61:	5b                   	pop    %ebx
  107e62:	5e                   	pop    %esi
                            tf->trapno, cur_pid, tf->eip);
    }

    kstack_switch(cur_pid);
    set_pdir_base(cur_pid);
	  trap_return((void *) tf);
  107e63:	e9 d8 a1 ff ff       	jmp    102040 <trap_return>
    f = TRAP_HANDLER[get_pcpu_idx()][tf->trapno];

    if (f){
            f(tf);
    } else {
            KERN_WARN("No handler for user trap 0x%x, process %d, eip 0x%08x. \n",
  107e68:	8b 43 30             	mov    0x30(%ebx),%eax
  107e6b:	89 74 24 10          	mov    %esi,0x10(%esp)
  107e6f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  107e73:	c7 44 24 08 38 c6 10 	movl   $0x10c638,0x8(%esp)
  107e7a:	00 
  107e7b:	89 44 24 14          	mov    %eax,0x14(%esp)
  107e7f:	c7 44 24 04 a3 00 00 	movl   $0xa3,0x4(%esp)
  107e86:	00 
  107e87:	c7 04 24 a4 c5 10 00 	movl   $0x10c5a4,(%esp)
  107e8e:	e8 bd c3 ff ff       	call   104250 <debug_warn>
  107e93:	eb b5                	jmp    107e4a <trap+0x3a>
  107e95:	66 90                	xchg   %ax,%ax
  107e97:	66 90                	xchg   %ax,%ax
  107e99:	66 90                	xchg   %ax,%ax
  107e9b:	66 90                	xchg   %ax,%ax
  107e9d:	66 90                	xchg   %ax,%ax
  107e9f:	90                   	nop

00107ea0 <trap_init_array>:

int inited = FALSE;

void
trap_init_array(void)
{
  107ea0:	83 ec 1c             	sub    $0x1c,%esp
  KERN_ASSERT(inited == FALSE);
  107ea3:	a1 e0 03 98 00       	mov    0x9803e0,%eax
  107ea8:	85 c0                	test   %eax,%eax
  107eaa:	74 24                	je     107ed0 <trap_init_array+0x30>
  107eac:	c7 44 24 0c 71 c6 10 	movl   $0x10c671,0xc(%esp)
  107eb3:	00 
  107eb4:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  107ebb:	00 
  107ebc:	c7 44 24 04 0b 00 00 	movl   $0xb,0x4(%esp)
  107ec3:	00 
  107ec4:	c7 04 24 ec c6 10 00 	movl   $0x10c6ec,(%esp)
  107ecb:	e8 b0 c2 ff ff       	call   104180 <debug_panic>
  memzero(&(TRAP_HANDLER), sizeof(trap_cb_t) * 8 * 256);
  107ed0:	c7 44 24 04 00 20 00 	movl   $0x2000,0x4(%esp)
  107ed7:	00 
  107ed8:	c7 04 24 00 90 9c 00 	movl   $0x9c9000,(%esp)
  107edf:	e8 9c c0 ff ff       	call   103f80 <memzero>
  inited = TRUE;
  107ee4:	c7 05 e0 03 98 00 01 	movl   $0x1,0x9803e0
  107eeb:	00 00 00 
}
  107eee:	83 c4 1c             	add    $0x1c,%esp
  107ef1:	c3                   	ret    
  107ef2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00107f00 <trap_handler_register>:

void
trap_handler_register(int cpu_idx, int trapno, trap_cb_t cb)
{
  107f00:	57                   	push   %edi
  107f01:	56                   	push   %esi
  107f02:	53                   	push   %ebx
  107f03:	83 ec 10             	sub    $0x10,%esp
  107f06:	8b 7c 24 20          	mov    0x20(%esp),%edi
  107f0a:	8b 74 24 24          	mov    0x24(%esp),%esi
  107f0e:	8b 5c 24 28          	mov    0x28(%esp),%ebx
  KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
  107f12:	83 ff 07             	cmp    $0x7,%edi
  107f15:	77 21                	ja     107f38 <trap_handler_register+0x38>
  KERN_ASSERT(0 <= trapno && trapno < 256);
  107f17:	81 fe ff 00 00 00    	cmp    $0xff,%esi
  107f1d:	77 45                	ja     107f64 <trap_handler_register+0x64>
  KERN_ASSERT(cb != NULL);
  107f1f:	85 db                	test   %ebx,%ebx
  107f21:	74 69                	je     107f8c <trap_handler_register+0x8c>

  TRAP_HANDLER[cpu_idx][trapno] = cb;
  107f23:	c1 e7 08             	shl    $0x8,%edi
  107f26:	01 fe                	add    %edi,%esi
  107f28:	89 1c b5 00 90 9c 00 	mov    %ebx,0x9c9000(,%esi,4)
}
  107f2f:	83 c4 10             	add    $0x10,%esp
  107f32:	5b                   	pop    %ebx
  107f33:	5e                   	pop    %esi
  107f34:	5f                   	pop    %edi
  107f35:	c3                   	ret    
  107f36:	66 90                	xchg   %ax,%ax
}

void
trap_handler_register(int cpu_idx, int trapno, trap_cb_t cb)
{
  KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
  107f38:	c7 44 24 0c 81 c6 10 	movl   $0x10c681,0xc(%esp)
  107f3f:	00 
  107f40:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  107f47:	00 
  107f48:	c7 44 24 04 13 00 00 	movl   $0x13,0x4(%esp)
  107f4f:	00 
  107f50:	c7 04 24 ec c6 10 00 	movl   $0x10c6ec,(%esp)
  107f57:	e8 24 c2 ff ff       	call   104180 <debug_panic>
  KERN_ASSERT(0 <= trapno && trapno < 256);
  107f5c:	81 fe ff 00 00 00    	cmp    $0xff,%esi
  107f62:	76 bb                	jbe    107f1f <trap_handler_register+0x1f>
  107f64:	c7 44 24 0c 9d c6 10 	movl   $0x10c69d,0xc(%esp)
  107f6b:	00 
  107f6c:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  107f73:	00 
  107f74:	c7 44 24 04 14 00 00 	movl   $0x14,0x4(%esp)
  107f7b:	00 
  107f7c:	c7 04 24 ec c6 10 00 	movl   $0x10c6ec,(%esp)
  107f83:	e8 f8 c1 ff ff       	call   104180 <debug_panic>
  KERN_ASSERT(cb != NULL);
  107f88:	85 db                	test   %ebx,%ebx
  107f8a:	75 97                	jne    107f23 <trap_handler_register+0x23>
  107f8c:	c7 44 24 0c b9 c6 10 	movl   $0x10c6b9,0xc(%esp)
  107f93:	00 
  107f94:	c7 44 24 08 3f ae 10 	movl   $0x10ae3f,0x8(%esp)
  107f9b:	00 
  107f9c:	c7 44 24 04 15 00 00 	movl   $0x15,0x4(%esp)
  107fa3:	00 
  107fa4:	c7 04 24 ec c6 10 00 	movl   $0x10c6ec,(%esp)
  107fab:	e8 d0 c1 ff ff       	call   104180 <debug_panic>
  107fb0:	e9 6e ff ff ff       	jmp    107f23 <trap_handler_register+0x23>
  107fb5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  107fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00107fc0 <trap_init>:

  TRAP_HANDLER[cpu_idx][trapno] = cb;
}

void
trap_init(unsigned int cpu_idx){
  107fc0:	53                   	push   %ebx
  107fc1:	83 ec 18             	sub    $0x18,%esp
  107fc4:	8b 5c 24 20          	mov    0x20(%esp),%ebx

  if (cpu_idx == 0){
  107fc8:	85 db                	test   %ebx,%ebx
  107fca:	0f 84 58 04 00 00    	je     108428 <trap_init+0x468>
  }

  if (cpu_idx == 0){
    KERN_INFO("[BSP KERN] Register exception handlers ... \n");
  } else {
    KERN_INFO("[AP%d KERN] Register exception handlers ... \n", cpu_idx);
  107fd0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  107fd4:	c7 04 24 ec c7 10 00 	movl   $0x10c7ec,(%esp)
  107fdb:	e8 10 c1 ff ff       	call   1040f0 <debug_info>
  }
  
  trap_handler_register(cpu_idx, T_GPFLT, exception_handler);
  107fe0:	c7 44 24 08 70 7d 10 	movl   $0x107d70,0x8(%esp)
  107fe7:	00 
  107fe8:	c7 44 24 04 0d 00 00 	movl   $0xd,0x4(%esp)
  107fef:	00 
  107ff0:	89 1c 24             	mov    %ebx,(%esp)
  107ff3:	e8 08 ff ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_PGFLT, exception_handler);
  107ff8:	c7 44 24 08 70 7d 10 	movl   $0x107d70,0x8(%esp)
  107fff:	00 
  108000:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
  108007:	00 
  108008:	89 1c 24             	mov    %ebx,(%esp)
  10800b:	e8 f0 fe ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_SYSCALL, syscall_dispatch);
  108010:	c7 44 24 08 40 78 10 	movl   $0x107840,0x8(%esp)
  108017:	00 
  108018:	c7 44 24 04 30 00 00 	movl   $0x30,0x4(%esp)
  10801f:	00 
  108020:	89 1c 24             	mov    %ebx,(%esp)
  108023:	e8 d8 fe ff ff       	call   107f00 <trap_handler_register>
  /* use default handler to handle other exceptions */
  trap_handler_register(cpu_idx, T_DIVIDE, exception_handler);
  108028:	c7 44 24 08 70 7d 10 	movl   $0x107d70,0x8(%esp)
  10802f:	00 
  108030:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  108037:	00 
  108038:	89 1c 24             	mov    %ebx,(%esp)
  10803b:	e8 c0 fe ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_DEBUG, exception_handler);
  108040:	c7 44 24 08 70 7d 10 	movl   $0x107d70,0x8(%esp)
  108047:	00 
  108048:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10804f:	00 
  108050:	89 1c 24             	mov    %ebx,(%esp)
  108053:	e8 a8 fe ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_NMI, exception_handler);
  108058:	c7 44 24 08 70 7d 10 	movl   $0x107d70,0x8(%esp)
  10805f:	00 
  108060:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  108067:	00 
  108068:	89 1c 24             	mov    %ebx,(%esp)
  10806b:	e8 90 fe ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_BRKPT, exception_handler);
  108070:	c7 44 24 08 70 7d 10 	movl   $0x107d70,0x8(%esp)
  108077:	00 
  108078:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
  10807f:	00 
  108080:	89 1c 24             	mov    %ebx,(%esp)
  108083:	e8 78 fe ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_OFLOW, exception_handler);
  108088:	c7 44 24 08 70 7d 10 	movl   $0x107d70,0x8(%esp)
  10808f:	00 
  108090:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
  108097:	00 
  108098:	89 1c 24             	mov    %ebx,(%esp)
  10809b:	e8 60 fe ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_BOUND, exception_handler);
  1080a0:	c7 44 24 08 70 7d 10 	movl   $0x107d70,0x8(%esp)
  1080a7:	00 
  1080a8:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
  1080af:	00 
  1080b0:	89 1c 24             	mov    %ebx,(%esp)
  1080b3:	e8 48 fe ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_ILLOP, exception_handler);
  1080b8:	c7 44 24 08 70 7d 10 	movl   $0x107d70,0x8(%esp)
  1080bf:	00 
  1080c0:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
  1080c7:	00 
  1080c8:	89 1c 24             	mov    %ebx,(%esp)
  1080cb:	e8 30 fe ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_DEVICE, exception_handler);
  1080d0:	c7 44 24 08 70 7d 10 	movl   $0x107d70,0x8(%esp)
  1080d7:	00 
  1080d8:	c7 44 24 04 07 00 00 	movl   $0x7,0x4(%esp)
  1080df:	00 
  1080e0:	89 1c 24             	mov    %ebx,(%esp)
  1080e3:	e8 18 fe ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_DBLFLT, exception_handler);
  1080e8:	c7 44 24 08 70 7d 10 	movl   $0x107d70,0x8(%esp)
  1080ef:	00 
  1080f0:	c7 44 24 04 08 00 00 	movl   $0x8,0x4(%esp)
  1080f7:	00 
  1080f8:	89 1c 24             	mov    %ebx,(%esp)
  1080fb:	e8 00 fe ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_COPROC, exception_handler);
  108100:	c7 44 24 08 70 7d 10 	movl   $0x107d70,0x8(%esp)
  108107:	00 
  108108:	c7 44 24 04 09 00 00 	movl   $0x9,0x4(%esp)
  10810f:	00 
  108110:	89 1c 24             	mov    %ebx,(%esp)
  108113:	e8 e8 fd ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_TSS, exception_handler);
  108118:	c7 44 24 08 70 7d 10 	movl   $0x107d70,0x8(%esp)
  10811f:	00 
  108120:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
  108127:	00 
  108128:	89 1c 24             	mov    %ebx,(%esp)
  10812b:	e8 d0 fd ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_SEGNP, exception_handler);
  108130:	c7 44 24 08 70 7d 10 	movl   $0x107d70,0x8(%esp)
  108137:	00 
  108138:	c7 44 24 04 0b 00 00 	movl   $0xb,0x4(%esp)
  10813f:	00 
  108140:	89 1c 24             	mov    %ebx,(%esp)
  108143:	e8 b8 fd ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_STACK, exception_handler);
  108148:	c7 44 24 08 70 7d 10 	movl   $0x107d70,0x8(%esp)
  10814f:	00 
  108150:	c7 44 24 04 0c 00 00 	movl   $0xc,0x4(%esp)
  108157:	00 
  108158:	89 1c 24             	mov    %ebx,(%esp)
  10815b:	e8 a0 fd ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_RES, exception_handler);
  108160:	c7 44 24 08 70 7d 10 	movl   $0x107d70,0x8(%esp)
  108167:	00 
  108168:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
  10816f:	00 
  108170:	89 1c 24             	mov    %ebx,(%esp)
  108173:	e8 88 fd ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_FPERR, exception_handler);
  108178:	c7 44 24 08 70 7d 10 	movl   $0x107d70,0x8(%esp)
  10817f:	00 
  108180:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  108187:	00 
  108188:	89 1c 24             	mov    %ebx,(%esp)
  10818b:	e8 70 fd ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_ALIGN, exception_handler);
  108190:	c7 44 24 08 70 7d 10 	movl   $0x107d70,0x8(%esp)
  108197:	00 
  108198:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
  10819f:	00 
  1081a0:	89 1c 24             	mov    %ebx,(%esp)
  1081a3:	e8 58 fd ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_MCHK, exception_handler);
  1081a8:	c7 44 24 08 70 7d 10 	movl   $0x107d70,0x8(%esp)
  1081af:	00 
  1081b0:	c7 44 24 04 12 00 00 	movl   $0x12,0x4(%esp)
  1081b7:	00 
  1081b8:	89 1c 24             	mov    %ebx,(%esp)
  1081bb:	e8 40 fd ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_SIMD, exception_handler);
  1081c0:	c7 44 24 08 70 7d 10 	movl   $0x107d70,0x8(%esp)
  1081c7:	00 
  1081c8:	c7 44 24 04 13 00 00 	movl   $0x13,0x4(%esp)
  1081cf:	00 
  1081d0:	89 1c 24             	mov    %ebx,(%esp)
  1081d3:	e8 28 fd ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_SECEV, exception_handler);
  1081d8:	c7 44 24 08 70 7d 10 	movl   $0x107d70,0x8(%esp)
  1081df:	00 
  1081e0:	c7 44 24 04 1e 00 00 	movl   $0x1e,0x4(%esp)
  1081e7:	00 
  1081e8:	89 1c 24             	mov    %ebx,(%esp)
  1081eb:	e8 10 fd ff ff       	call   107f00 <trap_handler_register>

  if (cpu_idx == 0){
  1081f0:	85 db                	test   %ebx,%ebx
  1081f2:	0f 85 20 01 00 00    	jne    108318 <trap_init+0x358>
    KERN_INFO("[BSP KERN] Done.\n");
  1081f8:	c7 04 24 c4 c6 10 00 	movl   $0x10c6c4,(%esp)
  1081ff:	e8 ec be ff ff       	call   1040f0 <debug_info>
    KERN_INFO("[AP%d KERN] Done.\n", cpu_idx);
  }


  if (cpu_idx == 0){
    KERN_INFO("[BSP KERN] Register interrupt handlers ... \n");
  108204:	c7 04 24 3c c7 10 00 	movl   $0x10c73c,(%esp)
  10820b:	e8 e0 be ff ff       	call   1040f0 <debug_info>
  } else {
    KERN_INFO("[AP%d KERN] Register interrupt handlers ... \n", cpu_idx);
  }
        
  trap_handler_register(cpu_idx, T_IRQ0+IRQ_SPURIOUS, interrupt_handler);
  108210:	c7 44 24 08 a0 7d 10 	movl   $0x107da0,0x8(%esp)
  108217:	00 
  108218:	c7 44 24 04 27 00 00 	movl   $0x27,0x4(%esp)
  10821f:	00 
  108220:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  108227:	e8 d4 fc ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_IRQ0+IRQ_TIMER, interrupt_handler);
  10822c:	c7 44 24 08 a0 7d 10 	movl   $0x107da0,0x8(%esp)
  108233:	00 
  108234:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  10823b:	00 
  10823c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  108243:	e8 b8 fc ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_IRQ0+IRQ_KBD, interrupt_handler);
  108248:	c7 44 24 08 a0 7d 10 	movl   $0x107da0,0x8(%esp)
  10824f:	00 
  108250:	c7 44 24 04 21 00 00 	movl   $0x21,0x4(%esp)
  108257:	00 
  108258:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10825f:	e8 9c fc ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_IRQ0+IRQ_SERIAL13, interrupt_handler);
  108264:	c7 44 24 08 a0 7d 10 	movl   $0x107da0,0x8(%esp)
  10826b:	00 
  10826c:	c7 44 24 04 24 00 00 	movl   $0x24,0x4(%esp)
  108273:	00 
  108274:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10827b:	e8 80 fc ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_IRQ0+IRQ_IDE1, interrupt_handler);
  108280:	c7 44 24 08 a0 7d 10 	movl   $0x107da0,0x8(%esp)
  108287:	00 
  108288:	c7 44 24 04 2e 00 00 	movl   $0x2e,0x4(%esp)
  10828f:	00 
  108290:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  108297:	e8 64 fc ff ff       	call   107f00 <trap_handler_register>

  if (cpu_idx == 0){
    KERN_INFO("[BSP KERN] Done.\n");
  10829c:	c7 04 24 c4 c6 10 00 	movl   $0x10c6c4,(%esp)
  1082a3:	e8 48 be ff ff       	call   1040f0 <debug_info>
  } else {
    KERN_INFO("[AP%d KERN] Done.\n", cpu_idx);
  }

  if (cpu_idx == 0){
    KERN_INFO("[BSP KERN] Enabling interrupts ... \n");
  1082a8:	c7 04 24 6c c7 10 00 	movl   $0x10c76c,(%esp)
  1082af:	e8 3c be ff ff       	call   1040f0 <debug_info>
  } else {
    KERN_INFO("[AP%d KERN] Enabling interrupts ... \n", cpu_idx);
  }

  /* enable interrupts */
  intr_enable (IRQ_TIMER, cpu_idx);
  1082b4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1082bb:	00 
  1082bc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1082c3:	e8 68 93 ff ff       	call   101630 <intr_enable>
  intr_enable (IRQ_KBD, cpu_idx);
  1082c8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1082cf:	00 
  1082d0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1082d7:	e8 54 93 ff ff       	call   101630 <intr_enable>
  intr_enable (IRQ_SERIAL13, cpu_idx);
  1082dc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1082e3:	00 
  1082e4:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  1082eb:	e8 40 93 ff ff       	call   101630 <intr_enable>
  intr_enable (IRQ_IDE1, cpu_idx);
  1082f0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1082f7:	00 
  1082f8:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  1082ff:	e8 2c 93 ff ff       	call   101630 <intr_enable>

  if (cpu_idx == 0){
    KERN_INFO("[BSP KERN] Done.\n");
  108304:	c7 44 24 20 c4 c6 10 	movl   $0x10c6c4,0x20(%esp)
  10830b:	00 
  } else {
    KERN_INFO("[AP%d KERN] Done.\n", cpu_idx);
  }

}
  10830c:	83 c4 18             	add    $0x18,%esp
  10830f:	5b                   	pop    %ebx
  intr_enable (IRQ_KBD, cpu_idx);
  intr_enable (IRQ_SERIAL13, cpu_idx);
  intr_enable (IRQ_IDE1, cpu_idx);

  if (cpu_idx == 0){
    KERN_INFO("[BSP KERN] Done.\n");
  108310:	e9 db bd ff ff       	jmp    1040f0 <debug_info>
  108315:	8d 76 00             	lea    0x0(%esi),%esi
  trap_handler_register(cpu_idx, T_SECEV, exception_handler);

  if (cpu_idx == 0){
    KERN_INFO("[BSP KERN] Done.\n");
  } else {
    KERN_INFO("[AP%d KERN] Done.\n", cpu_idx);
  108318:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  10831c:	c7 04 24 d6 c6 10 00 	movl   $0x10c6d6,(%esp)
  108323:	e8 c8 bd ff ff       	call   1040f0 <debug_info>


  if (cpu_idx == 0){
    KERN_INFO("[BSP KERN] Register interrupt handlers ... \n");
  } else {
    KERN_INFO("[AP%d KERN] Register interrupt handlers ... \n", cpu_idx);
  108328:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  10832c:	c7 04 24 94 c7 10 00 	movl   $0x10c794,(%esp)
  108333:	e8 b8 bd ff ff       	call   1040f0 <debug_info>
  }
        
  trap_handler_register(cpu_idx, T_IRQ0+IRQ_SPURIOUS, interrupt_handler);
  108338:	89 1c 24             	mov    %ebx,(%esp)
  10833b:	c7 44 24 08 a0 7d 10 	movl   $0x107da0,0x8(%esp)
  108342:	00 
  108343:	c7 44 24 04 27 00 00 	movl   $0x27,0x4(%esp)
  10834a:	00 
  10834b:	e8 b0 fb ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_IRQ0+IRQ_TIMER, interrupt_handler);
  108350:	89 1c 24             	mov    %ebx,(%esp)
  108353:	c7 44 24 08 a0 7d 10 	movl   $0x107da0,0x8(%esp)
  10835a:	00 
  10835b:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  108362:	00 
  108363:	e8 98 fb ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_IRQ0+IRQ_KBD, interrupt_handler);
  108368:	89 1c 24             	mov    %ebx,(%esp)
  10836b:	c7 44 24 08 a0 7d 10 	movl   $0x107da0,0x8(%esp)
  108372:	00 
  108373:	c7 44 24 04 21 00 00 	movl   $0x21,0x4(%esp)
  10837a:	00 
  10837b:	e8 80 fb ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_IRQ0+IRQ_SERIAL13, interrupt_handler);
  108380:	89 1c 24             	mov    %ebx,(%esp)
  108383:	c7 44 24 08 a0 7d 10 	movl   $0x107da0,0x8(%esp)
  10838a:	00 
  10838b:	c7 44 24 04 24 00 00 	movl   $0x24,0x4(%esp)
  108392:	00 
  108393:	e8 68 fb ff ff       	call   107f00 <trap_handler_register>
  trap_handler_register(cpu_idx, T_IRQ0+IRQ_IDE1, interrupt_handler);
  108398:	89 1c 24             	mov    %ebx,(%esp)
  10839b:	c7 44 24 08 a0 7d 10 	movl   $0x107da0,0x8(%esp)
  1083a2:	00 
  1083a3:	c7 44 24 04 2e 00 00 	movl   $0x2e,0x4(%esp)
  1083aa:	00 
  1083ab:	e8 50 fb ff ff       	call   107f00 <trap_handler_register>

  if (cpu_idx == 0){
    KERN_INFO("[BSP KERN] Done.\n");
  } else {
    KERN_INFO("[AP%d KERN] Done.\n", cpu_idx);
  1083b0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1083b4:	c7 04 24 d6 c6 10 00 	movl   $0x10c6d6,(%esp)
  1083bb:	e8 30 bd ff ff       	call   1040f0 <debug_info>
  }

  if (cpu_idx == 0){
    KERN_INFO("[BSP KERN] Enabling interrupts ... \n");
  } else {
    KERN_INFO("[AP%d KERN] Enabling interrupts ... \n", cpu_idx);
  1083c0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1083c4:	c7 04 24 c4 c7 10 00 	movl   $0x10c7c4,(%esp)
  1083cb:	e8 20 bd ff ff       	call   1040f0 <debug_info>
  }

  /* enable interrupts */
  intr_enable (IRQ_TIMER, cpu_idx);
  1083d0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1083d4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1083db:	e8 50 92 ff ff       	call   101630 <intr_enable>
  intr_enable (IRQ_KBD, cpu_idx);
  1083e0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1083e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1083eb:	e8 40 92 ff ff       	call   101630 <intr_enable>
  intr_enable (IRQ_SERIAL13, cpu_idx);
  1083f0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1083f4:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  1083fb:	e8 30 92 ff ff       	call   101630 <intr_enable>
  intr_enable (IRQ_IDE1, cpu_idx);
  108400:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  108404:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  10840b:	e8 20 92 ff ff       	call   101630 <intr_enable>

  if (cpu_idx == 0){
    KERN_INFO("[BSP KERN] Done.\n");
  } else {
    KERN_INFO("[AP%d KERN] Done.\n", cpu_idx);
  108410:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  108414:	c7 04 24 d6 c6 10 00 	movl   $0x10c6d6,(%esp)
  10841b:	e8 d0 bc ff ff       	call   1040f0 <debug_info>
  }

}
  108420:	83 c4 18             	add    $0x18,%esp
  108423:	5b                   	pop    %ebx
  108424:	c3                   	ret    
  108425:	8d 76 00             	lea    0x0(%esi),%esi

void
trap_init(unsigned int cpu_idx){

  if (cpu_idx == 0){
    trap_init_array();
  108428:	e8 73 fa ff ff       	call   107ea0 <trap_init_array>
  }

  if (cpu_idx == 0){
    KERN_INFO("[BSP KERN] Register exception handlers ... \n");
  10842d:	c7 04 24 0c c7 10 00 	movl   $0x10c70c,(%esp)
  108434:	e8 b7 bc ff ff       	call   1040f0 <debug_info>
  108439:	e9 a2 fb ff ff       	jmp    107fe0 <trap_init+0x20>
  10843e:	66 90                	xchg   %ax,%ax

00108440 <bufcache_init>:
  // head.next is most recently used.
  struct buf head;
} bcache;

void bufcache_init(void)
{
  108440:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *b;

  spinlock_init(&bcache.lock);
  108443:	c7 04 24 a0 fc e0 00 	movl   $0xe0fca0,(%esp)
  10844a:	e8 61 d4 ff ff       	call   1058b0 <spinlock_init>
  
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  10844f:	b9 98 11 e1 00       	mov    $0xe11198,%ecx
  for (b = bcache.buf; b < bcache.buf+NBUF; b++){
  108454:	b8 a8 fc e0 00       	mov    $0xe0fca8,%eax
  struct buf *b;

  spinlock_init(&bcache.lock);
  
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  108459:	c7 05 a4 11 e1 00 98 	movl   $0xe11198,0xe111a4
  108460:	11 e1 00 
  bcache.head.next = &bcache.head;
  108463:	c7 05 a8 11 e1 00 98 	movl   $0xe11198,0xe111a8
  10846a:	11 e1 00 
  10846d:	eb 05                	jmp    108474 <bufcache_init+0x34>
  10846f:	90                   	nop
  108470:	89 c1                	mov    %eax,%ecx
  for (b = bcache.buf; b < bcache.buf+NBUF; b++){
  108472:	89 d0                	mov    %edx,%eax
    b->next = bcache.head.next;
  108474:	89 48 10             	mov    %ecx,0x10(%eax)
    b->prev = &bcache.head;
  108477:	c7 40 0c 98 11 e1 00 	movl   $0xe11198,0xc(%eax)
    b->dev = -1;
  10847e:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
  108485:	8b 15 a8 11 e1 00    	mov    0xe111a8,%edx
  10848b:	89 42 0c             	mov    %eax,0xc(%edx)
  spinlock_init(&bcache.lock);
  
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for (b = bcache.buf; b < bcache.buf+NBUF; b++){
  10848e:	8d 90 18 02 00 00    	lea    0x218(%eax),%edx
  108494:	81 fa 98 11 e1 00    	cmp    $0xe11198,%edx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  10849a:	a3 a8 11 e1 00       	mov    %eax,0xe111a8
  spinlock_init(&bcache.lock);
  
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for (b = bcache.buf; b < bcache.buf+NBUF; b++){
  10849f:	75 cf                	jne    108470 <bufcache_init+0x30>
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
  1084a1:	83 c4 1c             	add    $0x1c,%esp
  1084a4:	c3                   	ret    
  1084a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1084a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001084b0 <bufcache_read>:

/**
 * Return a B_BUSY buf with the contents of the indicated disk sector.
 */
struct buf* bufcache_read(uint32_t dev, uint32_t sector)
{
  1084b0:	55                   	push   %ebp
  1084b1:	57                   	push   %edi
  1084b2:	56                   	push   %esi
  1084b3:	53                   	push   %ebx
  1084b4:	83 ec 1c             	sub    $0x1c,%esp
 */
static struct buf* bufcache_get(uint32_t dev, uint32_t sector)
{
  struct buf *b;

  spinlock_acquire(&bcache.lock);
  1084b7:	c7 04 24 a0 fc e0 00 	movl   $0xe0fca0,(%esp)

/**
 * Return a B_BUSY buf with the contents of the indicated disk sector.
 */
struct buf* bufcache_read(uint32_t dev, uint32_t sector)
{
  1084be:	8b 74 24 30          	mov    0x30(%esp),%esi
  1084c2:	8b 6c 24 34          	mov    0x34(%esp),%ebp
 */
static struct buf* bufcache_get(uint32_t dev, uint32_t sector)
{
  struct buf *b;

  spinlock_acquire(&bcache.lock);
  1084c6:	e8 a5 d5 ff ff       	call   105a70 <spinlock_acquire>

 loop:
  // Is the sector already cached?
  for (b = bcache.head.next; b != &bcache.head; b = b->next){
  1084cb:	8b 1d a8 11 e1 00    	mov    0xe111a8,%ebx
  1084d1:	81 fb 98 11 e1 00    	cmp    $0xe11198,%ebx
  1084d7:	75 12                	jne    1084eb <bufcache_read+0x3b>
  1084d9:	eb 3d                	jmp    108518 <bufcache_read+0x68>
  1084db:	90                   	nop
  1084dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1084e0:	8b 5b 10             	mov    0x10(%ebx),%ebx
  1084e3:	81 fb 98 11 e1 00    	cmp    $0xe11198,%ebx
  1084e9:	74 2d                	je     108518 <bufcache_read+0x68>
    if (b->dev == dev && b->sector == sector){
  1084eb:	3b 73 04             	cmp    0x4(%ebx),%esi
  1084ee:	75 f0                	jne    1084e0 <bufcache_read+0x30>
  1084f0:	3b 6b 08             	cmp    0x8(%ebx),%ebp
  1084f3:	75 eb                	jne    1084e0 <bufcache_read+0x30>
      if (!(b->flags & B_BUSY)){
  1084f5:	8b 03                	mov    (%ebx),%eax
  1084f7:	a8 01                	test   $0x1,%al
  1084f9:	0f 84 8c 00 00 00    	je     10858b <bufcache_read+0xdb>
        b->flags |= B_BUSY;
        spinlock_release(&bcache.lock);
        return b;
      }
      thread_sleep(b, &bcache.lock);
  1084ff:	c7 44 24 04 a0 fc e0 	movl   $0xe0fca0,0x4(%esp)
  108506:	00 
  108507:	89 1c 24             	mov    %ebx,(%esp)
  10850a:	e8 71 ec ff ff       	call   107180 <thread_sleep>
  10850f:	eb ba                	jmp    1084cb <bufcache_read+0x1b>
  108511:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      goto loop;
    }
  }
  
  // Not cached; recycle some non-busy and clean buffer.
  for (b = bcache.head.prev; b != &bcache.head; b = b->prev){
  108518:	8b 1d a4 11 e1 00    	mov    0xe111a4,%ebx
  10851e:	81 fb 98 11 e1 00    	cmp    $0xe11198,%ebx
  108524:	75 0d                	jne    108533 <bufcache_read+0x83>
  108526:	eb 30                	jmp    108558 <bufcache_read+0xa8>
  108528:	8b 5b 0c             	mov    0xc(%ebx),%ebx
  10852b:	81 fb 98 11 e1 00    	cmp    $0xe11198,%ebx
  108531:	74 25                	je     108558 <bufcache_read+0xa8>
    if ((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
  108533:	f6 03 05             	testb  $0x5,(%ebx)
  108536:	75 f0                	jne    108528 <bufcache_read+0x78>
      b->dev = dev;
  108538:	89 73 04             	mov    %esi,0x4(%ebx)
      b->sector = sector;
      b->flags = B_BUSY;
      spinlock_release(&bcache.lock);
  10853b:	89 df                	mov    %ebx,%edi
  
  // Not cached; recycle some non-busy and clean buffer.
  for (b = bcache.head.prev; b != &bcache.head; b = b->prev){
    if ((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
      b->dev = dev;
      b->sector = sector;
  10853d:	89 6b 08             	mov    %ebp,0x8(%ebx)
      b->flags = B_BUSY;
  108540:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
      spinlock_release(&bcache.lock);
  108546:	c7 04 24 a0 fc e0 00 	movl   $0xe0fca0,(%esp)
  10854d:	e8 9e d5 ff ff       	call   105af0 <spinlock_release>
  108552:	eb 20                	jmp    108574 <bufcache_read+0xc4>
  108554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return b;
    }
  }
  KERN_PANIC("bufcache_get: no buffers");
  108558:	c7 44 24 08 1a c8 10 	movl   $0x10c81a,0x8(%esp)
  10855f:	00 
  108560:	c7 44 24 04 5b 00 00 	movl   $0x5b,0x4(%esp)
  108567:	00 
  108568:	c7 04 24 33 c8 10 00 	movl   $0x10c833,(%esp)
  10856f:	e8 0c bc ff ff       	call   104180 <debug_panic>
struct buf* bufcache_read(uint32_t dev, uint32_t sector)
{
  struct buf *b;

  b = bufcache_get(dev, sector);
  if (!(b->flags & B_VALID)){
  108574:	f6 07 02             	testb  $0x2,(%edi)
  108577:	75 08                	jne    108581 <bufcache_read+0xd1>
    ide_rw(b);
  108579:	89 3c 24             	mov    %edi,(%esp)
  10857c:	e8 af b6 ff ff       	call   103c30 <ide_rw>
  }
  return b;
}
  108581:	83 c4 1c             	add    $0x1c,%esp
  108584:	89 f8                	mov    %edi,%eax
  108586:	5b                   	pop    %ebx
  108587:	5e                   	pop    %esi
  108588:	5f                   	pop    %edi
  108589:	5d                   	pop    %ebp
  10858a:	c3                   	ret    
 loop:
  // Is the sector already cached?
  for (b = bcache.head.next; b != &bcache.head; b = b->next){
    if (b->dev == dev && b->sector == sector){
      if (!(b->flags & B_BUSY)){
        b->flags |= B_BUSY;
  10858b:	83 c8 01             	or     $0x1,%eax
        spinlock_release(&bcache.lock);
  10858e:	89 df                	mov    %ebx,%edi
 loop:
  // Is the sector already cached?
  for (b = bcache.head.next; b != &bcache.head; b = b->next){
    if (b->dev == dev && b->sector == sector){
      if (!(b->flags & B_BUSY)){
        b->flags |= B_BUSY;
  108590:	89 03                	mov    %eax,(%ebx)
        spinlock_release(&bcache.lock);
  108592:	c7 04 24 a0 fc e0 00 	movl   $0xe0fca0,(%esp)
  108599:	e8 52 d5 ff ff       	call   105af0 <spinlock_release>
  10859e:	eb d4                	jmp    108574 <bufcache_read+0xc4>

001085a0 <bufcache_write>:

/**
 * Write b's contents to disk.  Must be B_BUSY.
 */
void bufcache_write(struct buf *b)
{
  1085a0:	53                   	push   %ebx
  1085a1:	83 ec 18             	sub    $0x18,%esp
  1085a4:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  1085a8:	8b 03                	mov    (%ebx),%eax
  if((b->flags & B_BUSY) == 0)
  1085aa:	a8 01                	test   $0x1,%al
  1085ac:	75 1e                	jne    1085cc <bufcache_write+0x2c>
    KERN_PANIC("bwrite");
  1085ae:	c7 44 24 08 46 c8 10 	movl   $0x10c846,0x8(%esp)
  1085b5:	00 
  1085b6:	c7 44 24 04 72 00 00 	movl   $0x72,0x4(%esp)
  1085bd:	00 
  1085be:	c7 04 24 33 c8 10 00 	movl   $0x10c833,(%esp)
  1085c5:	e8 b6 bb ff ff       	call   104180 <debug_panic>
  1085ca:	8b 03                	mov    (%ebx),%eax

  b->flags |= B_DIRTY;
  1085cc:	83 c8 04             	or     $0x4,%eax
  1085cf:	89 03                	mov    %eax,(%ebx)
  ide_rw(b);
  1085d1:	89 5c 24 20          	mov    %ebx,0x20(%esp)
}
  1085d5:	83 c4 18             	add    $0x18,%esp
  1085d8:	5b                   	pop    %ebx
{
  if((b->flags & B_BUSY) == 0)
    KERN_PANIC("bwrite");

  b->flags |= B_DIRTY;
  ide_rw(b);
  1085d9:	e9 52 b6 ff ff       	jmp    103c30 <ide_rw>
  1085de:	66 90                	xchg   %ax,%ax

001085e0 <bufcache_release>:
/**
 * Release a B_BUSY buffer.
 * Move to the head of the MRU list.
 */
void bufcache_release(struct buf *b)
{
  1085e0:	53                   	push   %ebx
  1085e1:	83 ec 18             	sub    $0x18,%esp
  1085e4:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  if((b->flags & B_BUSY) == 0)
  1085e8:	f6 03 01             	testb  $0x1,(%ebx)
  1085eb:	75 1c                	jne    108609 <bufcache_release+0x29>
    KERN_PANIC("brelse");
  1085ed:	c7 44 24 08 4d c8 10 	movl   $0x10c84d,0x8(%esp)
  1085f4:	00 
  1085f5:	c7 44 24 04 7f 00 00 	movl   $0x7f,0x4(%esp)
  1085fc:	00 
  1085fd:	c7 04 24 33 c8 10 00 	movl   $0x10c833,(%esp)
  108604:	e8 77 bb ff ff       	call   104180 <debug_panic>

  spinlock_acquire(&bcache.lock);
  108609:	c7 04 24 a0 fc e0 00 	movl   $0xe0fca0,(%esp)
  108610:	e8 5b d4 ff ff       	call   105a70 <spinlock_acquire>

  b->next->prev = b->prev;
  108615:	8b 43 10             	mov    0x10(%ebx),%eax
  108618:	8b 53 0c             	mov    0xc(%ebx),%edx
  10861b:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
  10861e:	8b 53 0c             	mov    0xc(%ebx),%edx
  108621:	89 42 10             	mov    %eax,0x10(%edx)
  b->next = bcache.head.next;
  108624:	a1 a8 11 e1 00       	mov    0xe111a8,%eax
  b->prev = &bcache.head;
  108629:	c7 43 0c 98 11 e1 00 	movl   $0xe11198,0xc(%ebx)

  spinlock_acquire(&bcache.lock);

  b->next->prev = b->prev;
  b->prev->next = b->next;
  b->next = bcache.head.next;
  108630:	89 43 10             	mov    %eax,0x10(%ebx)
  b->prev = &bcache.head;
  bcache.head.next->prev = b;
  108633:	a1 a8 11 e1 00       	mov    0xe111a8,%eax
  108638:	89 58 0c             	mov    %ebx,0xc(%eax)
  bcache.head.next = b;
  10863b:	89 1d a8 11 e1 00    	mov    %ebx,0xe111a8

  b->flags &= ~B_BUSY;
  108641:	83 23 fe             	andl   $0xfffffffe,(%ebx)
  thread_wakeup(b);
  108644:	89 1c 24             	mov    %ebx,(%esp)
  108647:	e8 24 ec ff ff       	call   107270 <thread_wakeup>

  spinlock_release(&bcache.lock);
  10864c:	c7 44 24 20 a0 fc e0 	movl   $0xe0fca0,0x20(%esp)
  108653:	00 
}
  108654:	83 c4 18             	add    $0x18,%esp
  108657:	5b                   	pop    %ebx
  bcache.head.next = b;

  b->flags &= ~B_BUSY;
  thread_wakeup(b);

  spinlock_release(&bcache.lock);
  108658:	e9 93 d4 ff ff       	jmp    105af0 <spinlock_release>
  10865d:	66 90                	xchg   %ax,%ax
  10865f:	90                   	nop

00108660 <install_trans>:
}

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
  108660:	57                   	push   %edi
  108661:	56                   	push   %esi
  108662:	53                   	push   %ebx
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
  108663:	31 db                	xor    %ebx,%ebx
}

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
  108665:	83 ec 10             	sub    $0x10,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
  108668:	a1 d8 13 e1 00       	mov    0xe113d8,%eax
  10866d:	85 c0                	test   %eax,%eax
  10866f:	7e 7b                	jle    1086ec <install_trans+0x8c>
  108671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bufcache_read(log.dev, log.start+tail+1); // read log block
  108678:	a1 c8 13 e1 00       	mov    0xe113c8,%eax
  10867d:	01 d8                	add    %ebx,%eax
  10867f:	83 c0 01             	add    $0x1,%eax
  108682:	89 44 24 04          	mov    %eax,0x4(%esp)
  108686:	a1 d4 13 e1 00       	mov    0xe113d4,%eax
  10868b:	89 04 24             	mov    %eax,(%esp)
  10868e:	e8 1d fe ff ff       	call   1084b0 <bufcache_read>
  108693:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bufcache_read(log.dev, log.lh.sector[tail]); // read dst
  108695:	8b 04 9d dc 13 e1 00 	mov    0xe113dc(,%ebx,4),%eax
static void 
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
  10869c:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bufcache_read(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bufcache_read(log.dev, log.lh.sector[tail]); // read dst
  10869f:	89 44 24 04          	mov    %eax,0x4(%esp)
  1086a3:	a1 d4 13 e1 00       	mov    0xe113d4,%eax
  1086a8:	89 04 24             	mov    %eax,(%esp)
  1086ab:	e8 00 fe ff ff       	call   1084b0 <bufcache_read>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
  1086b0:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  1086b7:	00 
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bufcache_read(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bufcache_read(log.dev, log.lh.sector[tail]); // read dst
  1086b8:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
  1086ba:	8d 47 18             	lea    0x18(%edi),%eax
  1086bd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1086c1:	8d 46 18             	lea    0x18(%esi),%eax
  1086c4:	89 04 24             	mov    %eax,(%esp)
  1086c7:	e8 04 b7 ff ff       	call   103dd0 <memmove>
    bufcache_write(dbuf);  // write dst to disk
  1086cc:	89 34 24             	mov    %esi,(%esp)
  1086cf:	e8 cc fe ff ff       	call   1085a0 <bufcache_write>
    bufcache_release(lbuf); 
  1086d4:	89 3c 24             	mov    %edi,(%esp)
  1086d7:	e8 04 ff ff ff       	call   1085e0 <bufcache_release>
    bufcache_release(dbuf);
  1086dc:	89 34 24             	mov    %esi,(%esp)
  1086df:	e8 fc fe ff ff       	call   1085e0 <bufcache_release>
static void 
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
  1086e4:	39 1d d8 13 e1 00    	cmp    %ebx,0xe113d8
  1086ea:	7f 8c                	jg     108678 <install_trans+0x18>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bufcache_write(dbuf);  // write dst to disk
    bufcache_release(lbuf); 
    bufcache_release(dbuf);
  }
}
  1086ec:	83 c4 10             	add    $0x10,%esp
  1086ef:	5b                   	pop    %ebx
  1086f0:	5e                   	pop    %esi
  1086f1:	5f                   	pop    %edi
  1086f2:	c3                   	ret    
  1086f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1086f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00108700 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  108700:	57                   	push   %edi
  108701:	56                   	push   %esi
  108702:	53                   	push   %ebx
  108703:	83 ec 10             	sub    $0x10,%esp
  struct buf *buf = bufcache_read(log.dev, log.start);
  108706:	a1 c8 13 e1 00       	mov    0xe113c8,%eax
  10870b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10870f:	a1 d4 13 e1 00       	mov    0xe113d4,%eax
  108714:	89 04 24             	mov    %eax,(%esp)
  108717:	e8 94 fd ff ff       	call   1084b0 <bufcache_read>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
  10871c:	31 d2                	xor    %edx,%edx
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bufcache_read(log.dev, log.start);
  10871e:	89 c7                	mov    %eax,%edi
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  108720:	a1 d8 13 e1 00       	mov    0xe113d8,%eax
  108725:	8d 77 18             	lea    0x18(%edi),%esi
  108728:	89 47 18             	mov    %eax,0x18(%edi)
  for (i = 0; i < log.lh.n; i++) {
  10872b:	8b 1d d8 13 e1 00    	mov    0xe113d8,%ebx
  108731:	85 db                	test   %ebx,%ebx
  108733:	7e 15                	jle    10874a <write_head+0x4a>
  108735:	8d 76 00             	lea    0x0(%esi),%esi
    hb->sector[i] = log.lh.sector[i];
  108738:	8b 0c 95 dc 13 e1 00 	mov    0xe113dc(,%edx,4),%ecx
  10873f:	89 4c 96 04          	mov    %ecx,0x4(%esi,%edx,4)
{
  struct buf *buf = bufcache_read(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
  108743:	83 c2 01             	add    $0x1,%edx
  108746:	39 da                	cmp    %ebx,%edx
  108748:	75 ee                	jne    108738 <write_head+0x38>
    hb->sector[i] = log.lh.sector[i];
  }
  bufcache_write(buf);
  10874a:	89 3c 24             	mov    %edi,(%esp)
  10874d:	e8 4e fe ff ff       	call   1085a0 <bufcache_write>
  bufcache_release(buf);
  108752:	89 3c 24             	mov    %edi,(%esp)
  108755:	e8 86 fe ff ff       	call   1085e0 <bufcache_release>
}
  10875a:	83 c4 10             	add    $0x10,%esp
  10875d:	5b                   	pop    %ebx
  10875e:	5e                   	pop    %esi
  10875f:	5f                   	pop    %edi
  108760:	c3                   	ret    
  108761:	eb 0d                	jmp    108770 <log_init>
  108763:	90                   	nop
  108764:	90                   	nop
  108765:	90                   	nop
  108766:	90                   	nop
  108767:	90                   	nop
  108768:	90                   	nop
  108769:	90                   	nop
  10876a:	90                   	nop
  10876b:	90                   	nop
  10876c:	90                   	nop
  10876d:	90                   	nop
  10876e:	90                   	nop
  10876f:	90                   	nop

00108770 <log_init>:

static void recover_from_log(void);

void
log_init(void)
{
  108770:	56                   	push   %esi
  108771:	53                   	push   %ebx
  108772:	83 ec 24             	sub    $0x24,%esp
  if (sizeof(struct logheader) >= BSIZE)
    KERN_PANIC("log_init: too big logheader");

  struct superblock sb;
  spinlock_init(&log.lock);
  108775:	c7 04 24 c0 13 e1 00 	movl   $0xe113c0,(%esp)
  10877c:	e8 2f d1 ff ff       	call   1058b0 <spinlock_init>
  read_superblock(ROOTDEV, &sb);
  108781:	8d 44 24 10          	lea    0x10(%esp),%eax
  108785:	89 44 24 04          	mov    %eax,0x4(%esp)
  108789:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  108790:	e8 6b 02 00 00       	call   108a00 <read_superblock>
  log.start = sb.size - sb.nlog;
  108795:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  108799:	8b 44 24 10          	mov    0x10(%esp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bufcache_read(log.dev, log.start);
  10879d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  struct superblock sb;
  spinlock_init(&log.lock);
  read_superblock(ROOTDEV, &sb);
  log.start = sb.size - sb.nlog;
  log.size = sb.nlog;
  log.dev = ROOTDEV;
  1087a4:	c7 05 d4 13 e1 00 01 	movl   $0x1,0xe113d4
  1087ab:	00 00 00 

  struct superblock sb;
  spinlock_init(&log.lock);
  read_superblock(ROOTDEV, &sb);
  log.start = sb.size - sb.nlog;
  log.size = sb.nlog;
  1087ae:	89 15 cc 13 e1 00    	mov    %edx,0xe113cc
    KERN_PANIC("log_init: too big logheader");

  struct superblock sb;
  spinlock_init(&log.lock);
  read_superblock(ROOTDEV, &sb);
  log.start = sb.size - sb.nlog;
  1087b4:	29 d0                	sub    %edx,%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bufcache_read(log.dev, log.start);
  1087b6:	89 44 24 04          	mov    %eax,0x4(%esp)
    KERN_PANIC("log_init: too big logheader");

  struct superblock sb;
  spinlock_init(&log.lock);
  read_superblock(ROOTDEV, &sb);
  log.start = sb.size - sb.nlog;
  1087ba:	a3 c8 13 e1 00       	mov    %eax,0xe113c8

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bufcache_read(log.dev, log.start);
  1087bf:	e8 ec fc ff ff       	call   1084b0 <bufcache_read>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
  1087c4:	31 d2                	xor    %edx,%edx
read_head(void)
{
  struct buf *buf = bufcache_read(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  1087c6:	8b 58 18             	mov    0x18(%eax),%ebx
  1087c9:	8d 70 18             	lea    0x18(%eax),%esi
  for (i = 0; i < log.lh.n; i++) {
  1087cc:	85 db                	test   %ebx,%ebx
read_head(void)
{
  struct buf *buf = bufcache_read(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  1087ce:	89 1d d8 13 e1 00    	mov    %ebx,0xe113d8
  for (i = 0; i < log.lh.n; i++) {
  1087d4:	7e 14                	jle    1087ea <log_init+0x7a>
  1087d6:	66 90                	xchg   %ax,%ax
    log.lh.sector[i] = lh->sector[i];
  1087d8:	8b 4c 96 04          	mov    0x4(%esi,%edx,4),%ecx
  1087dc:	89 0c 95 dc 13 e1 00 	mov    %ecx,0xe113dc(,%edx,4)
{
  struct buf *buf = bufcache_read(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
  1087e3:	83 c2 01             	add    $0x1,%edx
  1087e6:	39 da                	cmp    %ebx,%edx
  1087e8:	75 ee                	jne    1087d8 <log_init+0x68>
    log.lh.sector[i] = lh->sector[i];
  }
  bufcache_release(buf);
  1087ea:	89 04 24             	mov    %eax,(%esp)
  1087ed:	e8 ee fd ff ff       	call   1085e0 <bufcache_release>

static void
recover_from_log(void)
{
  read_head();      
  install_trans(); // if committed, copy from log to disk
  1087f2:	e8 69 fe ff ff       	call   108660 <install_trans>
  log.lh.n = 0;
  1087f7:	c7 05 d8 13 e1 00 00 	movl   $0x0,0xe113d8
  1087fe:	00 00 00 
  write_head(); // clear the log
  108801:	e8 fa fe ff ff       	call   108700 <write_head>
  read_superblock(ROOTDEV, &sb);
  log.start = sb.size - sb.nlog;
  log.size = sb.nlog;
  log.dev = ROOTDEV;
  recover_from_log();
}
  108806:	83 c4 24             	add    $0x24,%esp
  108809:	5b                   	pop    %ebx
  10880a:	5e                   	pop    %esi
  10880b:	c3                   	ret    
  10880c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00108810 <begin_trans>:
  write_head(); // clear the log
}

void
begin_trans(void)
{
  108810:	83 ec 1c             	sub    $0x1c,%esp
  spinlock_acquire(&log.lock);
  108813:	c7 04 24 c0 13 e1 00 	movl   $0xe113c0,(%esp)
  10881a:	e8 51 d2 ff ff       	call   105a70 <spinlock_acquire>
  while (log.busy) {
  10881f:	8b 15 d0 13 e1 00    	mov    0xe113d0,%edx
  108825:	85 d2                	test   %edx,%edx
  108827:	74 24                	je     10884d <begin_trans+0x3d>
  108829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    thread_sleep(&log, &log.lock);
  108830:	c7 44 24 04 c0 13 e1 	movl   $0xe113c0,0x4(%esp)
  108837:	00 
  108838:	c7 04 24 c0 13 e1 00 	movl   $0xe113c0,(%esp)
  10883f:	e8 3c e9 ff ff       	call   107180 <thread_sleep>

void
begin_trans(void)
{
  spinlock_acquire(&log.lock);
  while (log.busy) {
  108844:	a1 d0 13 e1 00       	mov    0xe113d0,%eax
  108849:	85 c0                	test   %eax,%eax
  10884b:	75 e3                	jne    108830 <begin_trans+0x20>
    thread_sleep(&log, &log.lock);
  }
  log.busy = 1;
  spinlock_release(&log.lock);
  10884d:	c7 04 24 c0 13 e1 00 	movl   $0xe113c0,(%esp)
{
  spinlock_acquire(&log.lock);
  while (log.busy) {
    thread_sleep(&log, &log.lock);
  }
  log.busy = 1;
  108854:	c7 05 d0 13 e1 00 01 	movl   $0x1,0xe113d0
  10885b:	00 00 00 
  spinlock_release(&log.lock);
  10885e:	e8 8d d2 ff ff       	call   105af0 <spinlock_release>
}
  108863:	83 c4 1c             	add    $0x1c,%esp
  108866:	c3                   	ret    
  108867:	89 f6                	mov    %esi,%esi
  108869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00108870 <commit_trans>:

void
commit_trans(void)
{
  108870:	83 ec 1c             	sub    $0x1c,%esp
  if (log.lh.n > 0) {
  108873:	a1 d8 13 e1 00       	mov    0xe113d8,%eax
  108878:	85 c0                	test   %eax,%eax
  10887a:	7e 19                	jle    108895 <commit_trans+0x25>
    write_head();    // Write header to disk -- the real commit
  10887c:	e8 7f fe ff ff       	call   108700 <write_head>
    install_trans(); // Now install writes to home locations
  108881:	e8 da fd ff ff       	call   108660 <install_trans>
    log.lh.n = 0; 
  108886:	c7 05 d8 13 e1 00 00 	movl   $0x0,0xe113d8
  10888d:	00 00 00 
    write_head();    // Erase the transaction from the log
  108890:	e8 6b fe ff ff       	call   108700 <write_head>
  }
  
  spinlock_acquire(&log.lock);
  108895:	c7 04 24 c0 13 e1 00 	movl   $0xe113c0,(%esp)
  10889c:	e8 cf d1 ff ff       	call   105a70 <spinlock_acquire>
  log.busy = 0;
  thread_wakeup(&log);
  1088a1:	c7 04 24 c0 13 e1 00 	movl   $0xe113c0,(%esp)
    log.lh.n = 0; 
    write_head();    // Erase the transaction from the log
  }
  
  spinlock_acquire(&log.lock);
  log.busy = 0;
  1088a8:	c7 05 d0 13 e1 00 00 	movl   $0x0,0xe113d0
  1088af:	00 00 00 
  thread_wakeup(&log);
  1088b2:	e8 b9 e9 ff ff       	call   107270 <thread_wakeup>
  spinlock_release(&log.lock);
  1088b7:	c7 04 24 c0 13 e1 00 	movl   $0xe113c0,(%esp)
  1088be:	e8 2d d2 ff ff       	call   105af0 <spinlock_release>
}
  1088c3:	83 c4 1c             	add    $0x1c,%esp
  1088c6:	c3                   	ret    
  1088c7:	89 f6                	mov    %esi,%esi
  1088c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001088d0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   bufcache_release(bp)
void
log_write(struct buf *b)
{
  1088d0:	57                   	push   %edi
  1088d1:	56                   	push   %esi
  1088d2:	53                   	push   %ebx
  1088d3:	83 ec 20             	sub    $0x20,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
  1088d6:	a1 d8 13 e1 00       	mov    0xe113d8,%eax
//   modify bp->data[]
//   log_write(bp)
//   bufcache_release(bp)
void
log_write(struct buf *b)
{
  1088db:	8b 74 24 30          	mov    0x30(%esp),%esi
  1088df:	8b 15 cc 13 e1 00    	mov    0xe113cc,%edx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
  1088e5:	83 f8 09             	cmp    $0x9,%eax
  1088e8:	0f 8f aa 00 00 00    	jg     108998 <log_write+0xc8>
  1088ee:	8d 4a ff             	lea    -0x1(%edx),%ecx
  1088f1:	39 c8                	cmp    %ecx,%eax
  1088f3:	0f 8d 9f 00 00 00    	jge    108998 <log_write+0xc8>
    KERN_PANIC("too big a transaction. %d < %d <= %d", log.size, log.lh.n, LOGSIZE);
  if (!log.busy)
  1088f9:	a1 d0 13 e1 00       	mov    0xe113d0,%eax
  1088fe:	85 c0                	test   %eax,%eax
  108900:	0f 84 cb 00 00 00    	je     1089d1 <log_write+0x101>
    KERN_PANIC("write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
  108906:	8b 15 d8 13 e1 00    	mov    0xe113d8,%edx
  10890c:	31 db                	xor    %ebx,%ebx
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
  10890e:	8b 46 08             	mov    0x8(%esi),%eax
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    KERN_PANIC("too big a transaction. %d < %d <= %d", log.size, log.lh.n, LOGSIZE);
  if (!log.busy)
    KERN_PANIC("write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
  108911:	85 d2                	test   %edx,%edx
  108913:	7e 1b                	jle    108930 <log_write+0x60>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
  108915:	39 05 dc 13 e1 00    	cmp    %eax,0xe113dc
  10891b:	75 0c                	jne    108929 <log_write+0x59>
  10891d:	eb 11                	jmp    108930 <log_write+0x60>
  10891f:	90                   	nop
  108920:	39 04 9d dc 13 e1 00 	cmp    %eax,0xe113dc(,%ebx,4)
  108927:	74 07                	je     108930 <log_write+0x60>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    KERN_PANIC("too big a transaction. %d < %d <= %d", log.size, log.lh.n, LOGSIZE);
  if (!log.busy)
    KERN_PANIC("write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
  108929:	83 c3 01             	add    $0x1,%ebx
  10892c:	39 d3                	cmp    %edx,%ebx
  10892e:	75 f0                	jne    108920 <log_write+0x50>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
      break;
  }
  log.lh.sector[i] = b->sector;
  108930:	89 04 9d dc 13 e1 00 	mov    %eax,0xe113dc(,%ebx,4)
  struct buf *lbuf = bufcache_read(b->dev, log.start+i+1);
  108937:	a1 c8 13 e1 00       	mov    0xe113c8,%eax
  10893c:	01 d8                	add    %ebx,%eax
  10893e:	83 c0 01             	add    $0x1,%eax
  108941:	89 44 24 04          	mov    %eax,0x4(%esp)
  108945:	8b 46 04             	mov    0x4(%esi),%eax
  108948:	89 04 24             	mov    %eax,(%esp)
  10894b:	e8 60 fb ff ff       	call   1084b0 <bufcache_read>
  memmove(lbuf->data, b->data, BSIZE);
  108950:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  108957:	00 
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
      break;
  }
  log.lh.sector[i] = b->sector;
  struct buf *lbuf = bufcache_read(b->dev, log.start+i+1);
  108958:	89 c7                	mov    %eax,%edi
  memmove(lbuf->data, b->data, BSIZE);
  10895a:	8d 46 18             	lea    0x18(%esi),%eax
  10895d:	89 44 24 04          	mov    %eax,0x4(%esp)
  108961:	8d 47 18             	lea    0x18(%edi),%eax
  108964:	89 04 24             	mov    %eax,(%esp)
  108967:	e8 64 b4 ff ff       	call   103dd0 <memmove>
  bufcache_write(lbuf);
  10896c:	89 3c 24             	mov    %edi,(%esp)
  10896f:	e8 2c fc ff ff       	call   1085a0 <bufcache_write>
  bufcache_release(lbuf);
  108974:	89 3c 24             	mov    %edi,(%esp)
  108977:	e8 64 fc ff ff       	call   1085e0 <bufcache_release>
  if (i == log.lh.n)
  10897c:	39 1d d8 13 e1 00    	cmp    %ebx,0xe113d8
  108982:	75 09                	jne    10898d <log_write+0xbd>
    log.lh.n++;
  108984:	83 c3 01             	add    $0x1,%ebx
  108987:	89 1d d8 13 e1 00    	mov    %ebx,0xe113d8
  b->flags |= B_DIRTY; // XXX prevent eviction
  10898d:	83 0e 04             	orl    $0x4,(%esi)
}
  108990:	83 c4 20             	add    $0x20,%esp
  108993:	5b                   	pop    %ebx
  108994:	5e                   	pop    %esi
  108995:	5f                   	pop    %edi
  108996:	c3                   	ret    
  108997:	90                   	nop
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    KERN_PANIC("too big a transaction. %d < %d <= %d", log.size, log.lh.n, LOGSIZE);
  108998:	89 44 24 10          	mov    %eax,0x10(%esp)
  10899c:	c7 44 24 14 0a 00 00 	movl   $0xa,0x14(%esp)
  1089a3:	00 
  1089a4:	89 54 24 0c          	mov    %edx,0xc(%esp)
  1089a8:	c7 44 24 08 54 c8 10 	movl   $0x10c854,0x8(%esp)
  1089af:	00 
  1089b0:	c7 44 24 04 a5 00 00 	movl   $0xa5,0x4(%esp)
  1089b7:	00 
  1089b8:	c7 04 24 7c c8 10 00 	movl   $0x10c87c,(%esp)
  1089bf:	e8 bc b7 ff ff       	call   104180 <debug_panic>
  if (!log.busy)
  1089c4:	a1 d0 13 e1 00       	mov    0xe113d0,%eax
  1089c9:	85 c0                	test   %eax,%eax
  1089cb:	0f 85 35 ff ff ff    	jne    108906 <log_write+0x36>
    KERN_PANIC("write outside of trans");
  1089d1:	c7 44 24 08 8a c8 10 	movl   $0x10c88a,0x8(%esp)
  1089d8:	00 
  1089d9:	c7 44 24 04 a7 00 00 	movl   $0xa7,0x4(%esp)
  1089e0:	00 
  1089e1:	c7 04 24 7c c8 10 00 	movl   $0x10c87c,(%esp)
  1089e8:	e8 93 b7 ff ff       	call   104180 <debug_panic>
  1089ed:	e9 14 ff ff ff       	jmp    108906 <log_write+0x36>
  1089f2:	66 90                	xchg   %ax,%ax
  1089f4:	66 90                	xchg   %ax,%ax
  1089f6:	66 90                	xchg   %ax,%ax
  1089f8:	66 90                	xchg   %ax,%ax
  1089fa:	66 90                	xchg   %ax,%ax
  1089fc:	66 90                	xchg   %ax,%ax
  1089fe:	66 90                	xchg   %ax,%ax

00108a00 <read_superblock>:
#include "bufcache.h"
#include "dinode.h"

// Read the super block.
void read_superblock(int dev, struct superblock *sb)
{
  108a00:	56                   	push   %esi
  108a01:	53                   	push   %ebx
  108a02:	83 ec 14             	sub    $0x14,%esp
  struct buf *bp;
  
  bp = bufcache_read(dev, 1);        // Block 1 is super block.
  108a05:	8b 44 24 20          	mov    0x20(%esp),%eax
  108a09:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  108a10:	00 
#include "bufcache.h"
#include "dinode.h"

// Read the super block.
void read_superblock(int dev, struct superblock *sb)
{
  108a11:	8b 74 24 24          	mov    0x24(%esp),%esi
  struct buf *bp;
  
  bp = bufcache_read(dev, 1);        // Block 1 is super block.
  108a15:	89 04 24             	mov    %eax,(%esp)
  108a18:	e8 93 fa ff ff       	call   1084b0 <bufcache_read>
  memmove(sb, bp->data, sizeof(*sb));
  108a1d:	89 34 24             	mov    %esi,(%esp)
  108a20:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  108a27:	00 
// Read the super block.
void read_superblock(int dev, struct superblock *sb)
{
  struct buf *bp;
  
  bp = bufcache_read(dev, 1);        // Block 1 is super block.
  108a28:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
  108a2a:	8d 40 18             	lea    0x18(%eax),%eax
  108a2d:	89 44 24 04          	mov    %eax,0x4(%esp)
  108a31:	e8 9a b3 ff ff       	call   103dd0 <memmove>
  bufcache_release(bp);
  108a36:	89 5c 24 20          	mov    %ebx,0x20(%esp)
}
  108a3a:	83 c4 14             	add    $0x14,%esp
  108a3d:	5b                   	pop    %ebx
  108a3e:	5e                   	pop    %esi
{
  struct buf *bp;
  
  bp = bufcache_read(dev, 1);        // Block 1 is super block.
  memmove(sb, bp->data, sizeof(*sb));
  bufcache_release(bp);
  108a3f:	e9 9c fb ff ff       	jmp    1085e0 <bufcache_release>
  108a44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  108a4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00108a50 <block_zero>:
}

// Zero a block.
void
block_zero(uint32_t dev, uint32_t bno)
{
  108a50:	53                   	push   %ebx
  108a51:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bufcache_read(dev, bno);
  108a54:	8b 44 24 24          	mov    0x24(%esp),%eax
  108a58:	89 44 24 04          	mov    %eax,0x4(%esp)
  108a5c:	8b 44 24 20          	mov    0x20(%esp),%eax
  108a60:	89 04 24             	mov    %eax,(%esp)
  108a63:	e8 48 fa ff ff       	call   1084b0 <bufcache_read>
  memset(bp->data, 0, BSIZE);
  108a68:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  108a6f:	00 
  108a70:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  108a77:	00 
void
block_zero(uint32_t dev, uint32_t bno)
{
  struct buf *bp;
  
  bp = bufcache_read(dev, bno);
  108a78:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
  108a7a:	8d 40 18             	lea    0x18(%eax),%eax
  108a7d:	89 04 24             	mov    %eax,(%esp)
  108a80:	e8 eb b2 ff ff       	call   103d70 <memset>
  log_write(bp);
  108a85:	89 1c 24             	mov    %ebx,(%esp)
  108a88:	e8 43 fe ff ff       	call   1088d0 <log_write>
  bufcache_release(bp);
  108a8d:	89 5c 24 20          	mov    %ebx,0x20(%esp)
}
  108a91:	83 c4 18             	add    $0x18,%esp
  108a94:	5b                   	pop    %ebx
  struct buf *bp;
  
  bp = bufcache_read(dev, bno);
  memset(bp->data, 0, BSIZE);
  log_write(bp);
  bufcache_release(bp);
  108a95:	e9 46 fb ff ff       	jmp    1085e0 <bufcache_release>
  108a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00108aa0 <block_alloc>:
}

// Allocate a zeroed disk block.
uint32_t
block_alloc(uint32_t dev)
{
  108aa0:	55                   	push   %ebp
  108aa1:	57                   	push   %edi
  108aa2:	56                   	push   %esi
  108aa3:	53                   	push   %ebx
  108aa4:	83 ec 2c             	sub    $0x2c,%esp
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  read_superblock(dev, &sb);
  108aa7:	8d 44 24 10          	lea    0x10(%esp),%eax
  108aab:	89 44 24 04          	mov    %eax,0x4(%esp)
  108aaf:	8b 44 24 40          	mov    0x40(%esp),%eax
  108ab3:	89 04 24             	mov    %eax,(%esp)
  108ab6:	e8 45 ff ff ff       	call   108a00 <read_superblock>
  for(b = 0; b < sb.size; b += BPB){
  108abb:	8b 44 24 10          	mov    0x10(%esp),%eax
  108abf:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  108ac6:	00 
  108ac7:	85 c0                	test   %eax,%eax
  108ac9:	0f 84 8a 00 00 00    	je     108b59 <block_alloc+0xb9>
    bp = bufcache_read(dev, BBLOCK(b, sb.ninodes));
  108acf:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  108ad3:	8b 44 24 18          	mov    0x18(%esp),%eax
  108ad7:	89 da                	mov    %ebx,%edx
  108ad9:	c1 fa 0c             	sar    $0xc,%edx
  108adc:	c1 e8 03             	shr    $0x3,%eax
  108adf:	8d 44 10 03          	lea    0x3(%eax,%edx,1),%eax
  108ae3:	89 44 24 04          	mov    %eax,0x4(%esp)
  108ae7:	8b 44 24 40          	mov    0x40(%esp),%eax
  108aeb:	89 04 24             	mov    %eax,(%esp)
  108aee:	e8 bd f9 ff ff       	call   1084b0 <bufcache_read>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
  108af3:	31 d2                	xor    %edx,%edx
  struct superblock sb;

  bp = 0;
  read_superblock(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bufcache_read(dev, BBLOCK(b, sb.ninodes));
  108af5:	89 c6                	mov    %eax,%esi
  108af7:	8b 44 24 10          	mov    0x10(%esp),%eax
  108afb:	89 44 24 08          	mov    %eax,0x8(%esp)
  108aff:	eb 34                	jmp    108b35 <block_alloc+0x95>
  108b01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
  108b08:	89 d1                	mov    %edx,%ecx
  108b0a:	b8 01 00 00 00       	mov    $0x1,%eax
  108b0f:	83 e1 07             	and    $0x7,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
  108b12:	89 d7                	mov    %edx,%edi
  bp = 0;
  read_superblock(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bufcache_read(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
  108b14:	d3 e0                	shl    %cl,%eax
      if((bp->data[bi/8] & m) == 0){  // Is block free?
  108b16:	c1 ff 03             	sar    $0x3,%edi
  bp = 0;
  read_superblock(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bufcache_read(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
  108b19:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
  108b1b:	0f b6 44 3e 18       	movzbl 0x18(%esi,%edi,1),%eax
  108b20:	0f b6 e8             	movzbl %al,%ebp
  108b23:	85 cd                	test   %ecx,%ebp
  108b25:	74 41                	je     108b68 <block_alloc+0xc8>

  bp = 0;
  read_superblock(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bufcache_read(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
  108b27:	83 c2 01             	add    $0x1,%edx
  108b2a:	83 c3 01             	add    $0x1,%ebx
  108b2d:	81 fa 00 10 00 00    	cmp    $0x1000,%edx
  108b33:	74 06                	je     108b3b <block_alloc+0x9b>
  108b35:	3b 5c 24 08          	cmp    0x8(%esp),%ebx
  108b39:	72 cd                	jb     108b08 <block_alloc+0x68>
        bufcache_release(bp);
        block_zero(dev, b + bi);
        return b + bi;
      }
    }
    bufcache_release(bp);
  108b3b:	89 34 24             	mov    %esi,(%esp)
  108b3e:	e8 9d fa ff ff       	call   1085e0 <bufcache_release>
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  read_superblock(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
  108b43:	81 44 24 0c 00 10 00 	addl   $0x1000,0xc(%esp)
  108b4a:	00 
  108b4b:	8b 44 24 0c          	mov    0xc(%esp),%eax
  108b4f:	3b 44 24 10          	cmp    0x10(%esp),%eax
  108b53:	0f 82 76 ff ff ff    	jb     108acf <block_alloc+0x2f>
      }
    }
    bufcache_release(bp);
  }
 ("balloc: out of blocks");
}
  108b59:	83 c4 2c             	add    $0x2c,%esp
  108b5c:	5b                   	pop    %ebx
  108b5d:	5e                   	pop    %esi
  108b5e:	5f                   	pop    %edi
  108b5f:	5d                   	pop    %ebp
  108b60:	c3                   	ret    
  108b61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  108b68:	89 ca                	mov    %ecx,%edx
  108b6a:	89 c1                	mov    %eax,%ecx
  for(b = 0; b < sb.size; b += BPB){
    bp = bufcache_read(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
  108b6c:	09 d1                	or     %edx,%ecx
  108b6e:	88 4c 3e 18          	mov    %cl,0x18(%esi,%edi,1)
        log_write(bp);
  108b72:	89 34 24             	mov    %esi,(%esp)
  108b75:	e8 56 fd ff ff       	call   1088d0 <log_write>
        bufcache_release(bp);
  108b7a:	89 34 24             	mov    %esi,(%esp)
  108b7d:	e8 5e fa ff ff       	call   1085e0 <bufcache_release>
        block_zero(dev, b + bi);
  108b82:	8b 44 24 40          	mov    0x40(%esp),%eax
  108b86:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  108b8a:	89 04 24             	mov    %eax,(%esp)
  108b8d:	e8 be fe ff ff       	call   108a50 <block_zero>
      }
    }
    bufcache_release(bp);
  }
 ("balloc: out of blocks");
}
  108b92:	83 c4 2c             	add    $0x2c,%esp
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
        log_write(bp);
        bufcache_release(bp);
        block_zero(dev, b + bi);
        return b + bi;
  108b95:	89 d8                	mov    %ebx,%eax
      }
    }
    bufcache_release(bp);
  }
 ("balloc: out of blocks");
}
  108b97:	5b                   	pop    %ebx
  108b98:	5e                   	pop    %esi
  108b99:	5f                   	pop    %edi
  108b9a:	5d                   	pop    %ebp
  108b9b:	c3                   	ret    
  108b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00108ba0 <block_free>:

// Free a disk block.
void
block_free(uint32_t dev, uint32_t b)
{
  108ba0:	57                   	push   %edi
  int bi, m;

  read_superblock(dev, &sb);
  bp = bufcache_read(dev, BBLOCK(b, sb.ninodes));
  bi = b % BPB;
  m = 1 << (bi % 8);
  108ba1:	bf 01 00 00 00       	mov    $0x1,%edi
}

// Free a disk block.
void
block_free(uint32_t dev, uint32_t b)
{
  108ba6:	56                   	push   %esi
  108ba7:	53                   	push   %ebx
  108ba8:	83 ec 20             	sub    $0x20,%esp
  108bab:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  struct buf *bp;
  struct superblock sb;
  int bi, m;

  read_superblock(dev, &sb);
  108baf:	8d 44 24 10          	lea    0x10(%esp),%eax
}

// Free a disk block.
void
block_free(uint32_t dev, uint32_t b)
{
  108bb3:	8b 74 24 34          	mov    0x34(%esp),%esi
  struct buf *bp;
  struct superblock sb;
  int bi, m;

  read_superblock(dev, &sb);
  108bb7:	89 44 24 04          	mov    %eax,0x4(%esp)
  108bbb:	89 1c 24             	mov    %ebx,(%esp)
  108bbe:	e8 3d fe ff ff       	call   108a00 <read_superblock>
  bp = bufcache_read(dev, BBLOCK(b, sb.ninodes));
  108bc3:	8b 44 24 18          	mov    0x18(%esp),%eax
  108bc7:	89 f2                	mov    %esi,%edx
  108bc9:	c1 ea 0c             	shr    $0xc,%edx
  108bcc:	89 1c 24             	mov    %ebx,(%esp)
  108bcf:	c1 e8 03             	shr    $0x3,%eax
  108bd2:	8d 44 10 03          	lea    0x3(%eax,%edx,1),%eax
  108bd6:	89 44 24 04          	mov    %eax,0x4(%esp)
  108bda:	e8 d1 f8 ff ff       	call   1084b0 <bufcache_read>
  bi = b % BPB;
  m = 1 << (bi % 8);
  108bdf:	89 f1                	mov    %esi,%ecx
  struct superblock sb;
  int bi, m;

  read_superblock(dev, &sb);
  bp = bufcache_read(dev, BBLOCK(b, sb.ninodes));
  bi = b % BPB;
  108be1:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
  108be7:	c1 fe 03             	sar    $0x3,%esi
  int bi, m;

  read_superblock(dev, &sb);
  bp = bufcache_read(dev, BBLOCK(b, sb.ninodes));
  bi = b % BPB;
  m = 1 << (bi % 8);
  108bea:	83 e1 07             	and    $0x7,%ecx
  108bed:	d3 e7                	shl    %cl,%edi
  struct buf *bp;
  struct superblock sb;
  int bi, m;

  read_superblock(dev, &sb);
  bp = bufcache_read(dev, BBLOCK(b, sb.ninodes));
  108bef:	89 c3                	mov    %eax,%ebx
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
  108bf1:	0f b6 44 30 18       	movzbl 0x18(%eax,%esi,1),%eax
  108bf6:	0f b6 c8             	movzbl %al,%ecx
  108bf9:	89 c2                	mov    %eax,%edx
  108bfb:	85 f9                	test   %edi,%ecx
  108bfd:	75 21                	jne    108c20 <block_free+0x80>
    KERN_PANIC("freeing free block");
  108bff:	c7 44 24 08 a1 c8 10 	movl   $0x10c8a1,0x8(%esp)
  108c06:	00 
  108c07:	c7 44 24 04 45 00 00 	movl   $0x45,0x4(%esp)
  108c0e:	00 
  108c0f:	c7 04 24 b4 c8 10 00 	movl   $0x10c8b4,(%esp)
  108c16:	e8 65 b5 ff ff       	call   104180 <debug_panic>
  108c1b:	0f b6 54 33 18       	movzbl 0x18(%ebx,%esi,1),%edx
  bp->data[bi/8] &= ~m;
  108c20:	89 f8                	mov    %edi,%eax
  108c22:	f7 d0                	not    %eax
  108c24:	21 d0                	and    %edx,%eax
  108c26:	88 44 33 18          	mov    %al,0x18(%ebx,%esi,1)
  log_write(bp);
  108c2a:	89 1c 24             	mov    %ebx,(%esp)
  108c2d:	e8 9e fc ff ff       	call   1088d0 <log_write>
  bufcache_release(bp);
  108c32:	89 1c 24             	mov    %ebx,(%esp)
  108c35:	e8 a6 f9 ff ff       	call   1085e0 <bufcache_release>
}
  108c3a:	83 c4 20             	add    $0x20,%esp
  108c3d:	5b                   	pop    %ebx
  108c3e:	5e                   	pop    %esi
  108c3f:	5f                   	pop    %edi
  108c40:	c3                   	ret    
  108c41:	66 90                	xchg   %ax,%ax
  108c43:	66 90                	xchg   %ax,%ax
  108c45:	66 90                	xchg   %ax,%ax
  108c47:	66 90                	xchg   %ax,%ax
  108c49:	66 90                	xchg   %ax,%ax
  108c4b:	66 90                	xchg   %ax,%ax
  108c4d:	66 90                	xchg   %ax,%ax
  108c4f:	90                   	nop

00108c50 <bmap>:
 * Return the disk block address of the nth block in inode ip.
 * If there is no such block, bmap allocates one.
 */
static uint32_t
bmap(struct inode *ip, uint32_t bn)
{
  108c50:	55                   	push   %ebp
  108c51:	57                   	push   %edi
  108c52:	56                   	push   %esi
  108c53:	53                   	push   %ebx
  108c54:	89 c3                	mov    %eax,%ebx
  108c56:	83 ec 1c             	sub    $0x1c,%esp
  uint32_t addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
  108c59:	83 fa 0b             	cmp    $0xb,%edx
  108c5c:	77 12                	ja     108c70 <bmap+0x20>
  108c5e:	8d 34 90             	lea    (%eax,%edx,4),%esi
    if((addr = ip->addrs[bn]) == 0)
  108c61:	8b 46 1c             	mov    0x1c(%esi),%eax
  108c64:	85 c0                	test   %eax,%eax
  108c66:	74 60                	je     108cc8 <bmap+0x78>
    bufcache_release(bp);
    return addr;
  }

  KERN_PANIC("bmap: out of range");
}
  108c68:	83 c4 1c             	add    $0x1c,%esp
  108c6b:	5b                   	pop    %ebx
  108c6c:	5e                   	pop    %esi
  108c6d:	5f                   	pop    %edi
  108c6e:	5d                   	pop    %ebp
  108c6f:	c3                   	ret    
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = block_alloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
  108c70:	8d 72 f4             	lea    -0xc(%edx),%esi

  if(bn < NINDIRECT){
  108c73:	83 fe 7f             	cmp    $0x7f,%esi
  108c76:	77 68                	ja     108ce0 <bmap+0x90>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
  108c78:	8b 40 4c             	mov    0x4c(%eax),%eax
  108c7b:	85 c0                	test   %eax,%eax
  108c7d:	0f 84 85 00 00 00    	je     108d08 <bmap+0xb8>
      ip->addrs[NDIRECT] = addr = block_alloc(ip->dev);
    bp = bufcache_read(ip->dev, addr);
  108c83:	89 44 24 04          	mov    %eax,0x4(%esp)
  108c87:	8b 03                	mov    (%ebx),%eax
  108c89:	89 04 24             	mov    %eax,(%esp)
  108c8c:	e8 1f f8 ff ff       	call   1084b0 <bufcache_read>
    a = (uint32_t*)bp->data;
    if((addr = a[bn]) == 0){
  108c91:	8d 6c b0 18          	lea    0x18(%eax,%esi,4),%ebp

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = block_alloc(ip->dev);
    bp = bufcache_read(ip->dev, addr);
  108c95:	89 c7                	mov    %eax,%edi
    a = (uint32_t*)bp->data;
    if((addr = a[bn]) == 0){
  108c97:	8b 75 00             	mov    0x0(%ebp),%esi
  108c9a:	85 f6                	test   %esi,%esi
  108c9c:	75 17                	jne    108cb5 <bmap+0x65>
      a[bn] = addr = block_alloc(ip->dev);
  108c9e:	8b 03                	mov    (%ebx),%eax
  108ca0:	89 04 24             	mov    %eax,(%esp)
  108ca3:	e8 f8 fd ff ff       	call   108aa0 <block_alloc>
  108ca8:	89 45 00             	mov    %eax,0x0(%ebp)
  108cab:	89 c6                	mov    %eax,%esi
      log_write(bp);
  108cad:	89 3c 24             	mov    %edi,(%esp)
  108cb0:	e8 1b fc ff ff       	call   1088d0 <log_write>
    }
    bufcache_release(bp);
  108cb5:	89 3c 24             	mov    %edi,(%esp)
  108cb8:	e8 23 f9 ff ff       	call   1085e0 <bufcache_release>
    return addr;
  }

  KERN_PANIC("bmap: out of range");
}
  108cbd:	83 c4 1c             	add    $0x1c,%esp
    if((addr = a[bn]) == 0){
      a[bn] = addr = block_alloc(ip->dev);
      log_write(bp);
    }
    bufcache_release(bp);
    return addr;
  108cc0:	89 f0                	mov    %esi,%eax
  }

  KERN_PANIC("bmap: out of range");
}
  108cc2:	5b                   	pop    %ebx
  108cc3:	5e                   	pop    %esi
  108cc4:	5f                   	pop    %edi
  108cc5:	5d                   	pop    %ebp
  108cc6:	c3                   	ret    
  108cc7:	90                   	nop
  uint32_t addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = block_alloc(ip->dev);
  108cc8:	8b 03                	mov    (%ebx),%eax
  108cca:	89 04 24             	mov    %eax,(%esp)
  108ccd:	e8 ce fd ff ff       	call   108aa0 <block_alloc>
  108cd2:	89 46 1c             	mov    %eax,0x1c(%esi)
    bufcache_release(bp);
    return addr;
  }

  KERN_PANIC("bmap: out of range");
}
  108cd5:	83 c4 1c             	add    $0x1c,%esp
  108cd8:	5b                   	pop    %ebx
  108cd9:	5e                   	pop    %esi
  108cda:	5f                   	pop    %edi
  108cdb:	5d                   	pop    %ebp
  108cdc:	c3                   	ret    
  108cdd:	8d 76 00             	lea    0x0(%esi),%esi
    }
    bufcache_release(bp);
    return addr;
  }

  KERN_PANIC("bmap: out of range");
  108ce0:	c7 44 24 08 c4 c8 10 	movl   $0x10c8c4,0x8(%esp)
  108ce7:	00 
  108ce8:	c7 44 24 04 05 01 00 	movl   $0x105,0x4(%esp)
  108cef:	00 
  108cf0:	c7 04 24 d7 c8 10 00 	movl   $0x10c8d7,(%esp)
  108cf7:	e8 84 b4 ff ff       	call   104180 <debug_panic>
}
  108cfc:	83 c4 1c             	add    $0x1c,%esp
  108cff:	5b                   	pop    %ebx
  108d00:	5e                   	pop    %esi
  108d01:	5f                   	pop    %edi
  108d02:	5d                   	pop    %ebp
  108d03:	c3                   	ret    
  108d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = block_alloc(ip->dev);
  108d08:	8b 03                	mov    (%ebx),%eax
  108d0a:	89 04 24             	mov    %eax,(%esp)
  108d0d:	e8 8e fd ff ff       	call   108aa0 <block_alloc>
  108d12:	89 43 4c             	mov    %eax,0x4c(%ebx)
  108d15:	e9 69 ff ff ff       	jmp    108c83 <bmap+0x33>
  108d1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00108d20 <inode_init>:
  struct inode inode[NINODE];
} inode_cache;

void
inode_init(void)
{
  108d20:	83 ec 1c             	sub    $0x1c,%esp
  spinlock_init(&inode_cache.lock);
  108d23:	c7 04 24 20 14 e1 00 	movl   $0xe11420,(%esp)
  108d2a:	e8 81 cb ff ff       	call   1058b0 <spinlock_init>
}
  108d2f:	83 c4 1c             	add    $0x1c,%esp
  108d32:	c3                   	ret    
  108d33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  108d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00108d40 <inode_update>:
/**
 * Copy a modified in-memory inode to disk.
 */
void
inode_update(struct inode *ip)
{
  108d40:	56                   	push   %esi
  108d41:	53                   	push   %ebx
  108d42:	83 ec 14             	sub    $0x14,%esp
  108d45:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bufcache_read(ip->dev, IBLOCK(ip->inum));
  108d49:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  108d4c:	83 c3 1c             	add    $0x1c,%ebx
inode_update(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bufcache_read(ip->dev, IBLOCK(ip->inum));
  108d4f:	c1 e8 03             	shr    $0x3,%eax
  108d52:	83 c0 02             	add    $0x2,%eax
  108d55:	89 44 24 04          	mov    %eax,0x4(%esp)
  108d59:	8b 43 e4             	mov    -0x1c(%ebx),%eax
  108d5c:	89 04 24             	mov    %eax,(%esp)
  108d5f:	e8 4c f7 ff ff       	call   1084b0 <bufcache_read>
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  108d64:	8b 53 e8             	mov    -0x18(%ebx),%edx
  108d67:	83 e2 07             	and    $0x7,%edx
  108d6a:	c1 e2 06             	shl    $0x6,%edx
  108d6d:	8d 54 10 18          	lea    0x18(%eax,%edx,1),%edx
inode_update(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bufcache_read(ip->dev, IBLOCK(ip->inum));
  108d71:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  108d73:	0f b7 43 f4          	movzwl -0xc(%ebx),%eax
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  108d77:	83 c2 0c             	add    $0xc,%edx
  struct buf *bp;
  struct dinode *dip;

  bp = bufcache_read(ip->dev, IBLOCK(ip->inum));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  108d7a:	66 89 42 f4          	mov    %ax,-0xc(%edx)
  dip->major = ip->major;
  108d7e:	0f b7 43 f6          	movzwl -0xa(%ebx),%eax
  108d82:	66 89 42 f6          	mov    %ax,-0xa(%edx)
  dip->minor = ip->minor;
  108d86:	0f b7 43 f8          	movzwl -0x8(%ebx),%eax
  108d8a:	66 89 42 f8          	mov    %ax,-0x8(%edx)
  dip->nlink = ip->nlink;
  108d8e:	0f b7 43 fa          	movzwl -0x6(%ebx),%eax
  108d92:	66 89 42 fa          	mov    %ax,-0x6(%edx)
  dip->size = ip->size;
  108d96:	8b 43 fc             	mov    -0x4(%ebx),%eax
  108d99:	89 42 fc             	mov    %eax,-0x4(%edx)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  108d9c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  108da0:	89 14 24             	mov    %edx,(%esp)
  108da3:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
  108daa:	00 
  108dab:	e8 20 b0 ff ff       	call   103dd0 <memmove>
  log_write(bp);
  108db0:	89 34 24             	mov    %esi,(%esp)
  108db3:	e8 18 fb ff ff       	call   1088d0 <log_write>
  bufcache_release(bp);
  108db8:	89 74 24 20          	mov    %esi,0x20(%esp)
}
  108dbc:	83 c4 14             	add    $0x14,%esp
  108dbf:	5b                   	pop    %ebx
  108dc0:	5e                   	pop    %esi
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  bufcache_release(bp);
  108dc1:	e9 1a f8 ff ff       	jmp    1085e0 <bufcache_release>
  108dc6:	8d 76 00             	lea    0x0(%esi),%esi
  108dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00108dd0 <inode_get>:
 * and return the in-memory copy. Does not lock
 * the inode and does not read it from disk.
 */
struct inode*
inode_get(uint32_t dev, uint32_t inum)
{
  108dd0:	55                   	push   %ebp
  108dd1:	57                   	push   %edi
  108dd2:	56                   	push   %esi
  struct inode *ip, *empty;

  spinlock_acquire(&inode_cache.lock);

  // Is the inode already cached?
  empty = 0;
  108dd3:	31 f6                	xor    %esi,%esi
 * and return the in-memory copy. Does not lock
 * the inode and does not read it from disk.
 */
struct inode*
inode_get(uint32_t dev, uint32_t inum)
{
  108dd5:	53                   	push   %ebx

  spinlock_acquire(&inode_cache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &inode_cache.inode[0]; ip < &inode_cache.inode[NINODE]; ip++){
  108dd6:	bb 28 14 e1 00       	mov    $0xe11428,%ebx
 * and return the in-memory copy. Does not lock
 * the inode and does not read it from disk.
 */
struct inode*
inode_get(uint32_t dev, uint32_t inum)
{
  108ddb:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *empty;

  spinlock_acquire(&inode_cache.lock);
  108dde:	c7 04 24 20 14 e1 00 	movl   $0xe11420,(%esp)
 * and return the in-memory copy. Does not lock
 * the inode and does not read it from disk.
 */
struct inode*
inode_get(uint32_t dev, uint32_t inum)
{
  108de5:	8b 7c 24 30          	mov    0x30(%esp),%edi
  108de9:	8b 6c 24 34          	mov    0x34(%esp),%ebp
  struct inode *ip, *empty;

  spinlock_acquire(&inode_cache.lock);
  108ded:	e8 7e cc ff ff       	call   105a70 <spinlock_acquire>
  108df2:	eb 13                	jmp    108e07 <inode_get+0x37>
  108df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      spinlock_release(&inode_cache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
  108df8:	85 f6                	test   %esi,%esi
  108dfa:	74 3c                	je     108e38 <inode_get+0x68>

  spinlock_acquire(&inode_cache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &inode_cache.inode[0]; ip < &inode_cache.inode[NINODE]; ip++){
  108dfc:	83 c3 50             	add    $0x50,%ebx
  108dff:	81 fb c8 23 e1 00    	cmp    $0xe123c8,%ebx
  108e05:	74 41                	je     108e48 <inode_get+0x78>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
  108e07:	8b 53 08             	mov    0x8(%ebx),%edx
  108e0a:	85 d2                	test   %edx,%edx
  108e0c:	7e ea                	jle    108df8 <inode_get+0x28>
  108e0e:	39 3b                	cmp    %edi,(%ebx)
  108e10:	75 e6                	jne    108df8 <inode_get+0x28>
  108e12:	39 6b 04             	cmp    %ebp,0x4(%ebx)
  108e15:	75 e1                	jne    108df8 <inode_get+0x28>
      ip->ref++;
  108e17:	83 c2 01             	add    $0x1,%edx
      spinlock_release(&inode_cache.lock);
      return ip;
  108e1a:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &inode_cache.inode[0]; ip < &inode_cache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      spinlock_release(&inode_cache.lock);
  108e1c:	c7 04 24 20 14 e1 00 	movl   $0xe11420,(%esp)

  // Is the inode already cached?
  empty = 0;
  for(ip = &inode_cache.inode[0]; ip < &inode_cache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
  108e23:	89 53 08             	mov    %edx,0x8(%ebx)
      spinlock_release(&inode_cache.lock);
  108e26:	e8 c5 cc ff ff       	call   105af0 <spinlock_release>
  ip->ref = 1;
  ip->flags = 0;
  spinlock_release(&inode_cache.lock);

  return ip;
}
  108e2b:	83 c4 1c             	add    $0x1c,%esp
  108e2e:	89 f0                	mov    %esi,%eax
  108e30:	5b                   	pop    %ebx
  108e31:	5e                   	pop    %esi
  108e32:	5f                   	pop    %edi
  108e33:	5d                   	pop    %ebp
  108e34:	c3                   	ret    
  108e35:	8d 76 00             	lea    0x0(%esi),%esi
  108e38:	85 d2                	test   %edx,%edx
  108e3a:	0f 44 f3             	cmove  %ebx,%esi

  spinlock_acquire(&inode_cache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &inode_cache.inode[0]; ip < &inode_cache.inode[NINODE]; ip++){
  108e3d:	83 c3 50             	add    $0x50,%ebx
  108e40:	81 fb c8 23 e1 00    	cmp    $0xe123c8,%ebx
  108e46:	75 bf                	jne    108e07 <inode_get+0x37>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
  108e48:	85 f6                	test   %esi,%esi
  108e4a:	74 29                	je     108e75 <inode_get+0xa5>
    KERN_PANIC("inode_get: no inodes");

  ip = empty;
  ip->dev = dev;
  108e4c:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
  108e4e:	89 6e 04             	mov    %ebp,0x4(%esi)
  ip->ref = 1;
  108e51:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
  108e58:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
  spinlock_release(&inode_cache.lock);
  108e5f:	c7 04 24 20 14 e1 00 	movl   $0xe11420,(%esp)
  108e66:	e8 85 cc ff ff       	call   105af0 <spinlock_release>

  return ip;
}
  108e6b:	83 c4 1c             	add    $0x1c,%esp
  108e6e:	89 f0                	mov    %esi,%eax
  108e70:	5b                   	pop    %ebx
  108e71:	5e                   	pop    %esi
  108e72:	5f                   	pop    %edi
  108e73:	5d                   	pop    %ebp
  108e74:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    KERN_PANIC("inode_get: no inodes");
  108e75:	c7 44 24 08 e7 c8 10 	movl   $0x10c8e7,0x8(%esp)
  108e7c:	00 
  108e7d:	c7 44 24 04 6b 00 00 	movl   $0x6b,0x4(%esp)
  108e84:	00 
  108e85:	c7 04 24 d7 c8 10 00 	movl   $0x10c8d7,(%esp)
  108e8c:	e8 ef b2 ff ff       	call   104180 <debug_panic>
  108e91:	eb b9                	jmp    108e4c <inode_get+0x7c>
  108e93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  108e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00108ea0 <inode_alloc>:
 * Allocate a new inode with the given type on device dev.
 * A free inode has a type of zero.
 */
struct inode*
inode_alloc(uint32_t dev, short type)
{
  108ea0:	55                   	push   %ebp
  struct dinode *dip;
  struct superblock sb;

  read_superblock(dev, &sb);

  for(inum = 1; inum < sb.ninodes; inum++){
  108ea1:	bd 01 00 00 00       	mov    $0x1,%ebp
 * Allocate a new inode with the given type on device dev.
 * A free inode has a type of zero.
 */
struct inode*
inode_alloc(uint32_t dev, short type)
{
  108ea6:	57                   	push   %edi
  108ea7:	56                   	push   %esi
  108ea8:	53                   	push   %ebx
  struct dinode *dip;
  struct superblock sb;

  read_superblock(dev, &sb);

  for(inum = 1; inum < sb.ninodes; inum++){
  108ea9:	bb 01 00 00 00       	mov    $0x1,%ebx
 * Allocate a new inode with the given type on device dev.
 * A free inode has a type of zero.
 */
struct inode*
inode_alloc(uint32_t dev, short type)
{
  108eae:	83 ec 3c             	sub    $0x3c,%esp
  108eb1:	8b 44 24 54          	mov    0x54(%esp),%eax
  108eb5:	8b 74 24 50          	mov    0x50(%esp),%esi
  108eb9:	89 44 24 18          	mov    %eax,0x18(%esp)
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  read_superblock(dev, &sb);
  108ebd:	8d 44 24 20          	lea    0x20(%esp),%eax
  108ec1:	89 44 24 04          	mov    %eax,0x4(%esp)
  108ec5:	89 34 24             	mov    %esi,(%esp)
  108ec8:	e8 33 fb ff ff       	call   108a00 <read_superblock>

  for(inum = 1; inum < sb.ninodes; inum++){
  108ecd:	83 7c 24 28 01       	cmpl   $0x1,0x28(%esp)
  108ed2:	77 1f                	ja     108ef3 <inode_alloc+0x53>
  108ed4:	e9 8f 00 00 00       	jmp    108f68 <inode_alloc+0xc8>
  108ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      bufcache_release(bp);
      return inode_get(dev, inum);
    }
    bufcache_release(bp);
  108ee0:	89 04 24             	mov    %eax,(%esp)
  struct dinode *dip;
  struct superblock sb;

  read_superblock(dev, &sb);

  for(inum = 1; inum < sb.ninodes; inum++){
  108ee3:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      bufcache_release(bp);
      return inode_get(dev, inum);
    }
    bufcache_release(bp);
  108ee6:	e8 f5 f6 ff ff       	call   1085e0 <bufcache_release>
  struct dinode *dip;
  struct superblock sb;

  read_superblock(dev, &sb);

  for(inum = 1; inum < sb.ninodes; inum++){
  108eeb:	89 dd                	mov    %ebx,%ebp
  108eed:	3b 5c 24 28          	cmp    0x28(%esp),%ebx
  108ef1:	73 75                	jae    108f68 <inode_alloc+0xc8>
    bp = bufcache_read(dev, IBLOCK(inum));
  108ef3:	89 e8                	mov    %ebp,%eax
  108ef5:	c1 e8 03             	shr    $0x3,%eax
  108ef8:	83 c0 02             	add    $0x2,%eax
  108efb:	89 44 24 04          	mov    %eax,0x4(%esp)
  108eff:	89 34 24             	mov    %esi,(%esp)
  108f02:	e8 a9 f5 ff ff       	call   1084b0 <bufcache_read>
    dip = (struct dinode*)bp->data + inum%IPB;
  108f07:	89 ea                	mov    %ebp,%edx
  108f09:	83 e2 07             	and    $0x7,%edx
  108f0c:	c1 e2 06             	shl    $0x6,%edx
  108f0f:	8d 54 10 18          	lea    0x18(%eax,%edx,1),%edx
  struct superblock sb;

  read_superblock(dev, &sb);

  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bufcache_read(dev, IBLOCK(inum));
  108f13:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
    if(dip->type == 0){  // a free inode
  108f15:	66 83 3a 00          	cmpw   $0x0,(%edx)
  108f19:	75 c5                	jne    108ee0 <inode_alloc+0x40>
      memset(dip, 0, sizeof(*dip));
  108f1b:	89 14 24             	mov    %edx,(%esp)
  108f1e:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
  108f25:	00 
  108f26:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  108f2d:	00 
  108f2e:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  108f32:	e8 39 ae ff ff       	call   103d70 <memset>
      dip->type = type;
  108f37:	0f b7 44 24 18       	movzwl 0x18(%esp),%eax
  108f3c:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  108f40:	66 89 02             	mov    %ax,(%edx)
      log_write(bp);   // mark it allocated on the disk
  108f43:	89 3c 24             	mov    %edi,(%esp)
  108f46:	e8 85 f9 ff ff       	call   1088d0 <log_write>
      bufcache_release(bp);
  108f4b:	89 3c 24             	mov    %edi,(%esp)
  108f4e:	e8 8d f6 ff ff       	call   1085e0 <bufcache_release>
      return inode_get(dev, inum);
  108f53:	89 6c 24 04          	mov    %ebp,0x4(%esp)
  108f57:	89 34 24             	mov    %esi,(%esp)
  108f5a:	e8 71 fe ff ff       	call   108dd0 <inode_get>
    }
    bufcache_release(bp);
  }
  KERN_PANIC("inode_alloc: no inodes");
}
  108f5f:	83 c4 3c             	add    $0x3c,%esp
  108f62:	5b                   	pop    %ebx
  108f63:	5e                   	pop    %esi
  108f64:	5f                   	pop    %edi
  108f65:	5d                   	pop    %ebp
  108f66:	c3                   	ret    
  108f67:	90                   	nop
      bufcache_release(bp);
      return inode_get(dev, inum);
    }
    bufcache_release(bp);
  }
  KERN_PANIC("inode_alloc: no inodes");
  108f68:	c7 44 24 08 fc c8 10 	movl   $0x10c8fc,0x8(%esp)
  108f6f:	00 
  108f70:	c7 44 24 04 39 00 00 	movl   $0x39,0x4(%esp)
  108f77:	00 
  108f78:	c7 04 24 d7 c8 10 00 	movl   $0x10c8d7,(%esp)
  108f7f:	e8 fc b1 ff ff       	call   104180 <debug_panic>
}
  108f84:	83 c4 3c             	add    $0x3c,%esp
  108f87:	5b                   	pop    %ebx
  108f88:	5e                   	pop    %esi
  108f89:	5f                   	pop    %edi
  108f8a:	5d                   	pop    %ebp
  108f8b:	c3                   	ret    
  108f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00108f90 <inode_dup>:
 * Increment reference count for ip.
 * Returns ip to enable ip = inode_dup(ip1) idiom.
 */
struct inode*
inode_dup(struct inode *ip)
{
  108f90:	53                   	push   %ebx
  108f91:	83 ec 18             	sub    $0x18,%esp
  108f94:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  spinlock_acquire(&inode_cache.lock);
  108f98:	c7 04 24 20 14 e1 00 	movl   $0xe11420,(%esp)
  108f9f:	e8 cc ca ff ff       	call   105a70 <spinlock_acquire>
  ip->ref++;
  108fa4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  spinlock_release(&inode_cache.lock);
  108fa8:	c7 04 24 20 14 e1 00 	movl   $0xe11420,(%esp)
  108faf:	e8 3c cb ff ff       	call   105af0 <spinlock_release>
  return ip;
}
  108fb4:	83 c4 18             	add    $0x18,%esp
  108fb7:	89 d8                	mov    %ebx,%eax
  108fb9:	5b                   	pop    %ebx
  108fba:	c3                   	ret    
  108fbb:	90                   	nop
  108fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00108fc0 <inode_lock>:
 * Lock the given inode.
 * Reads the inode from disk if necessary.
 */
void
inode_lock(struct inode *ip)
{
  108fc0:	56                   	push   %esi
  108fc1:	53                   	push   %ebx
  108fc2:	83 ec 14             	sub    $0x14,%esp
  108fc5:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
  108fc9:	85 db                	test   %ebx,%ebx
  108fcb:	0f 84 f7 00 00 00    	je     1090c8 <inode_lock+0x108>
  108fd1:	8b 43 08             	mov    0x8(%ebx),%eax
  108fd4:	85 c0                	test   %eax,%eax
  108fd6:	0f 8e ec 00 00 00    	jle    1090c8 <inode_lock+0x108>
    KERN_PANIC("inode_lock");

  spinlock_acquire(&inode_cache.lock);
  108fdc:	c7 04 24 20 14 e1 00 	movl   $0xe11420,(%esp)
  108fe3:	e8 88 ca ff ff       	call   105a70 <spinlock_acquire>
  while(ip->flags & I_BUSY)
  108fe8:	8b 43 0c             	mov    0xc(%ebx),%eax
  108feb:	a8 01                	test   $0x1,%al
  108fed:	74 18                	je     109007 <inode_lock+0x47>
  108fef:	90                   	nop
    thread_sleep(ip, &inode_cache.lock);
  108ff0:	c7 44 24 04 20 14 e1 	movl   $0xe11420,0x4(%esp)
  108ff7:	00 
  108ff8:	89 1c 24             	mov    %ebx,(%esp)
  108ffb:	e8 80 e1 ff ff       	call   107180 <thread_sleep>

  if(ip == 0 || ip->ref < 1)
    KERN_PANIC("inode_lock");

  spinlock_acquire(&inode_cache.lock);
  while(ip->flags & I_BUSY)
  109000:	8b 43 0c             	mov    0xc(%ebx),%eax
  109003:	a8 01                	test   $0x1,%al
  109005:	75 e9                	jne    108ff0 <inode_lock+0x30>
    thread_sleep(ip, &inode_cache.lock);
  ip->flags |= I_BUSY;
  109007:	83 c8 01             	or     $0x1,%eax
  10900a:	89 43 0c             	mov    %eax,0xc(%ebx)
  spinlock_release(&inode_cache.lock);
  10900d:	c7 04 24 20 14 e1 00 	movl   $0xe11420,(%esp)
  109014:	e8 d7 ca ff ff       	call   105af0 <spinlock_release>
  
  if(!(ip->flags & I_VALID)){
  109019:	f6 43 0c 02          	testb  $0x2,0xc(%ebx)
  10901d:	74 09                	je     109028 <inode_lock+0x68>
    ip->flags |= I_VALID;
    if(ip->type == 0)
      KERN_PANIC("inode_lock: no type");
  }

}
  10901f:	83 c4 14             	add    $0x14,%esp
  109022:	5b                   	pop    %ebx
  109023:	5e                   	pop    %esi
  109024:	c3                   	ret    
  109025:	8d 76 00             	lea    0x0(%esi),%esi
    thread_sleep(ip, &inode_cache.lock);
  ip->flags |= I_BUSY;
  spinlock_release(&inode_cache.lock);
  
  if(!(ip->flags & I_VALID)){
    bp = bufcache_read(ip->dev, IBLOCK(ip->inum));
  109028:	8b 43 04             	mov    0x4(%ebx),%eax
  10902b:	c1 e8 03             	shr    $0x3,%eax
  10902e:	83 c0 02             	add    $0x2,%eax
  109031:	89 44 24 04          	mov    %eax,0x4(%esp)
  109035:	8b 03                	mov    (%ebx),%eax
  109037:	89 04 24             	mov    %eax,(%esp)
  10903a:	e8 71 f4 ff ff       	call   1084b0 <bufcache_read>
    dip = (struct dinode*)bp->data + ip->inum % IPB;
  10903f:	8b 53 04             	mov    0x4(%ebx),%edx
  109042:	83 e2 07             	and    $0x7,%edx
  109045:	c1 e2 06             	shl    $0x6,%edx
  109048:	8d 54 10 18          	lea    0x18(%eax,%edx,1),%edx
    thread_sleep(ip, &inode_cache.lock);
  ip->flags |= I_BUSY;
  spinlock_release(&inode_cache.lock);
  
  if(!(ip->flags & I_VALID)){
    bp = bufcache_read(ip->dev, IBLOCK(ip->inum));
  10904c:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum % IPB;
    ip->type = dip->type;
  10904e:	0f b7 02             	movzwl (%edx),%eax
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  109051:	83 c2 0c             	add    $0xc,%edx
  spinlock_release(&inode_cache.lock);
  
  if(!(ip->flags & I_VALID)){
    bp = bufcache_read(ip->dev, IBLOCK(ip->inum));
    dip = (struct dinode*)bp->data + ip->inum % IPB;
    ip->type = dip->type;
  109054:	66 89 43 10          	mov    %ax,0x10(%ebx)
    ip->major = dip->major;
  109058:	0f b7 42 f6          	movzwl -0xa(%edx),%eax
  10905c:	66 89 43 12          	mov    %ax,0x12(%ebx)
    ip->minor = dip->minor;
  109060:	0f b7 42 f8          	movzwl -0x8(%edx),%eax
  109064:	66 89 43 14          	mov    %ax,0x14(%ebx)
    ip->nlink = dip->nlink;
  109068:	0f b7 42 fa          	movzwl -0x6(%edx),%eax
  10906c:	66 89 43 16          	mov    %ax,0x16(%ebx)
    ip->size = dip->size;
  109070:	8b 42 fc             	mov    -0x4(%edx),%eax
  109073:	89 43 18             	mov    %eax,0x18(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  109076:	8d 43 1c             	lea    0x1c(%ebx),%eax
  109079:	89 54 24 04          	mov    %edx,0x4(%esp)
  10907d:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
  109084:	00 
  109085:	89 04 24             	mov    %eax,(%esp)
  109088:	e8 43 ad ff ff       	call   103dd0 <memmove>
    bufcache_release(bp);
  10908d:	89 34 24             	mov    %esi,(%esp)
  109090:	e8 4b f5 ff ff       	call   1085e0 <bufcache_release>
    ip->flags |= I_VALID;
  109095:	83 4b 0c 02          	orl    $0x2,0xc(%ebx)
    if(ip->type == 0)
  109099:	66 83 7b 10 00       	cmpw   $0x0,0x10(%ebx)
  10909e:	0f 85 7b ff ff ff    	jne    10901f <inode_lock+0x5f>
      KERN_PANIC("inode_lock: no type");
  1090a4:	c7 44 24 08 1e c9 10 	movl   $0x10c91e,0x8(%esp)
  1090ab:	00 
  1090ac:	c7 44 24 04 a3 00 00 	movl   $0xa3,0x4(%esp)
  1090b3:	00 
  1090b4:	c7 04 24 d7 c8 10 00 	movl   $0x10c8d7,(%esp)
  1090bb:	e8 c0 b0 ff ff       	call   104180 <debug_panic>
  }

}
  1090c0:	83 c4 14             	add    $0x14,%esp
  1090c3:	5b                   	pop    %ebx
  1090c4:	5e                   	pop    %esi
  1090c5:	c3                   	ret    
  1090c6:	66 90                	xchg   %ax,%ax
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    KERN_PANIC("inode_lock");
  1090c8:	c7 44 24 08 13 c9 10 	movl   $0x10c913,0x8(%esp)
  1090cf:	00 
  1090d0:	c7 44 24 04 8f 00 00 	movl   $0x8f,0x4(%esp)
  1090d7:	00 
  1090d8:	c7 04 24 d7 c8 10 00 	movl   $0x10c8d7,(%esp)
  1090df:	e8 9c b0 ff ff       	call   104180 <debug_panic>
  1090e4:	e9 f3 fe ff ff       	jmp    108fdc <inode_lock+0x1c>
  1090e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001090f0 <inode_unlock>:
/**
 * Unlock the given inode.
 */
void
inode_unlock(struct inode *ip)
{
  1090f0:	53                   	push   %ebx
  1090f1:	83 ec 18             	sub    $0x18,%esp
  1090f4:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
  1090f8:	85 db                	test   %ebx,%ebx
  1090fa:	74 06                	je     109102 <inode_unlock+0x12>
  1090fc:	f6 43 0c 01          	testb  $0x1,0xc(%ebx)
  109100:	75 46                	jne    109148 <inode_unlock+0x58>
    KERN_PANIC("inode_unlock");
  109102:	c7 44 24 08 32 c9 10 	movl   $0x10c932,0x8(%esp)
  109109:	00 
  10910a:	c7 44 24 04 af 00 00 	movl   $0xaf,0x4(%esp)
  109111:	00 
  109112:	c7 04 24 d7 c8 10 00 	movl   $0x10c8d7,(%esp)
  109119:	e8 62 b0 ff ff       	call   104180 <debug_panic>

  spinlock_acquire(&inode_cache.lock);
  10911e:	c7 04 24 20 14 e1 00 	movl   $0xe11420,(%esp)
  109125:	e8 46 c9 ff ff       	call   105a70 <spinlock_acquire>
  ip->flags &= ~I_BUSY;
  10912a:	83 63 0c fe          	andl   $0xfffffffe,0xc(%ebx)
  thread_wakeup(ip);
  10912e:	89 1c 24             	mov    %ebx,(%esp)
  109131:	e8 3a e1 ff ff       	call   107270 <thread_wakeup>
  spinlock_release(&inode_cache.lock);
  109136:	c7 44 24 20 20 14 e1 	movl   $0xe11420,0x20(%esp)
  10913d:	00 
}
  10913e:	83 c4 18             	add    $0x18,%esp
  109141:	5b                   	pop    %ebx
    KERN_PANIC("inode_unlock");

  spinlock_acquire(&inode_cache.lock);
  ip->flags &= ~I_BUSY;
  thread_wakeup(ip);
  spinlock_release(&inode_cache.lock);
  109142:	e9 a9 c9 ff ff       	jmp    105af0 <spinlock_release>
  109147:	90                   	nop
 * Unlock the given inode.
 */
void
inode_unlock(struct inode *ip)
{
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
  109148:	8b 43 08             	mov    0x8(%ebx),%eax
  10914b:	85 c0                	test   %eax,%eax
  10914d:	7f cf                	jg     10911e <inode_unlock+0x2e>
  10914f:	eb b1                	jmp    109102 <inode_unlock+0x12>
  109151:	eb 0d                	jmp    109160 <inode_put>
  109153:	90                   	nop
  109154:	90                   	nop
  109155:	90                   	nop
  109156:	90                   	nop
  109157:	90                   	nop
  109158:	90                   	nop
  109159:	90                   	nop
  10915a:	90                   	nop
  10915b:	90                   	nop
  10915c:	90                   	nop
  10915d:	90                   	nop
  10915e:	90                   	nop
  10915f:	90                   	nop

00109160 <inode_put>:
 * If that was the last reference and the inode has no links
 * to it, free the inode (and its content) on disk.
 */
void
inode_put(struct inode *ip)
{
  109160:	55                   	push   %ebp
  109161:	57                   	push   %edi
  109162:	56                   	push   %esi
  109163:	53                   	push   %ebx
  109164:	83 ec 1c             	sub    $0x1c,%esp
  109167:	8b 7c 24 30          	mov    0x30(%esp),%edi
  spinlock_acquire(&inode_cache.lock);
  10916b:	c7 04 24 20 14 e1 00 	movl   $0xe11420,(%esp)
  109172:	e8 f9 c8 ff ff       	call   105a70 <spinlock_acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
  109177:	8b 47 08             	mov    0x8(%edi),%eax
  10917a:	83 f8 01             	cmp    $0x1,%eax
  10917d:	74 21                	je     1091a0 <inode_put+0x40>
    inode_update(ip);
    spinlock_acquire(&inode_cache.lock);
    ip->flags = 0;
    thread_wakeup(ip);
  }
  ip->ref--;
  10917f:	83 e8 01             	sub    $0x1,%eax
  109182:	89 47 08             	mov    %eax,0x8(%edi)
  spinlock_release(&inode_cache.lock);
  109185:	c7 44 24 30 20 14 e1 	movl   $0xe11420,0x30(%esp)
  10918c:	00 
}
  10918d:	83 c4 1c             	add    $0x1c,%esp
  109190:	5b                   	pop    %ebx
  109191:	5e                   	pop    %esi
  109192:	5f                   	pop    %edi
  109193:	5d                   	pop    %ebp
    spinlock_acquire(&inode_cache.lock);
    ip->flags = 0;
    thread_wakeup(ip);
  }
  ip->ref--;
  spinlock_release(&inode_cache.lock);
  109194:	e9 57 c9 ff ff       	jmp    105af0 <spinlock_release>
  109199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 */
void
inode_put(struct inode *ip)
{
  spinlock_acquire(&inode_cache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
  1091a0:	8b 57 0c             	mov    0xc(%edi),%edx
  1091a3:	f6 c2 02             	test   $0x2,%dl
  1091a6:	74 d7                	je     10917f <inode_put+0x1f>
  1091a8:	66 83 7f 16 00       	cmpw   $0x0,0x16(%edi)
  1091ad:	75 d0                	jne    10917f <inode_put+0x1f>
    // inode has no links: truncate and free inode.
    if(ip->flags & I_BUSY)
  1091af:	f6 c2 01             	test   $0x1,%dl
  1091b2:	0f 85 02 01 00 00    	jne    1092ba <inode_put+0x15a>
      KERN_PANIC("inode_put busy");
    ip->flags |= I_BUSY;
  1091b8:	83 ca 01             	or     $0x1,%edx
  1091bb:	89 fb                	mov    %edi,%ebx
  1091bd:	89 57 0c             	mov    %edx,0xc(%edi)
  1091c0:	8d 77 30             	lea    0x30(%edi),%esi
    spinlock_release(&inode_cache.lock);
  1091c3:	c7 04 24 20 14 e1 00 	movl   $0xe11420,(%esp)
  1091ca:	e8 21 c9 ff ff       	call   105af0 <spinlock_release>
  1091cf:	eb 0e                	jmp    1091df <inode_put+0x7f>
  1091d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1091d8:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint32_t *a;

  for(i = 0; i < NDIRECT; i++){
  1091db:	39 f3                	cmp    %esi,%ebx
  1091dd:	74 23                	je     109202 <inode_put+0xa2>
    if(ip->addrs[i]){
  1091df:	8b 43 1c             	mov    0x1c(%ebx),%eax
  1091e2:	85 c0                	test   %eax,%eax
  1091e4:	74 f2                	je     1091d8 <inode_put+0x78>
      block_free(ip->dev, ip->addrs[i]);
  1091e6:	89 44 24 04          	mov    %eax,0x4(%esp)
  1091ea:	8b 07                	mov    (%edi),%eax
  1091ec:	83 c3 04             	add    $0x4,%ebx
  1091ef:	89 04 24             	mov    %eax,(%esp)
  1091f2:	e8 a9 f9 ff ff       	call   108ba0 <block_free>
      ip->addrs[i] = 0;
  1091f7:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
{
  int i, j;
  struct buf *bp;
  uint32_t *a;

  for(i = 0; i < NDIRECT; i++){
  1091fe:	39 f3                	cmp    %esi,%ebx
  109200:	75 dd                	jne    1091df <inode_put+0x7f>
      block_free(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
  109202:	8b 47 4c             	mov    0x4c(%edi),%eax
  109205:	85 c0                	test   %eax,%eax
  109207:	75 47                	jne    109250 <inode_put+0xf0>
    bufcache_release(bp);
    block_free(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  109209:	c7 47 18 00 00 00 00 	movl   $0x0,0x18(%edi)
  inode_update(ip);
  109210:	89 3c 24             	mov    %edi,(%esp)
  109213:	e8 28 fb ff ff       	call   108d40 <inode_update>
    if(ip->flags & I_BUSY)
      KERN_PANIC("inode_put busy");
    ip->flags |= I_BUSY;
    spinlock_release(&inode_cache.lock);
    inode_trunc(ip);
    ip->type = 0;
  109218:	31 c0                	xor    %eax,%eax
  10921a:	66 89 47 10          	mov    %ax,0x10(%edi)
    inode_update(ip);
  10921e:	89 3c 24             	mov    %edi,(%esp)
  109221:	e8 1a fb ff ff       	call   108d40 <inode_update>
    spinlock_acquire(&inode_cache.lock);
  109226:	c7 04 24 20 14 e1 00 	movl   $0xe11420,(%esp)
  10922d:	e8 3e c8 ff ff       	call   105a70 <spinlock_acquire>
    ip->flags = 0;
  109232:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    thread_wakeup(ip);
  109239:	89 3c 24             	mov    %edi,(%esp)
  10923c:	e8 2f e0 ff ff       	call   107270 <thread_wakeup>
  109241:	8b 47 08             	mov    0x8(%edi),%eax
  109244:	e9 36 ff ff ff       	jmp    10917f <inode_put+0x1f>
  109249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bufcache_read(ip->dev, ip->addrs[NDIRECT]);
  109250:	89 44 24 04          	mov    %eax,0x4(%esp)
  109254:	8b 07                	mov    (%edi),%eax
    a = (uint32_t*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
  109256:	31 db                	xor    %ebx,%ebx
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bufcache_read(ip->dev, ip->addrs[NDIRECT]);
  109258:	89 04 24             	mov    %eax,(%esp)
  10925b:	e8 50 f2 ff ff       	call   1084b0 <bufcache_read>
    a = (uint32_t*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
  109260:	31 d2                	xor    %edx,%edx
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bufcache_read(ip->dev, ip->addrs[NDIRECT]);
  109262:	89 c6                	mov    %eax,%esi
    a = (uint32_t*)bp->data;
  109264:	8d 68 18             	lea    0x18(%eax),%ebp
  109267:	eb 14                	jmp    10927d <inode_put+0x11d>
  109269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(j = 0; j < NINDIRECT; j++){
  109270:	83 c3 01             	add    $0x1,%ebx
  109273:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
  109279:	89 da                	mov    %ebx,%edx
  10927b:	74 18                	je     109295 <inode_put+0x135>
      if(a[j])
  10927d:	8b 54 95 00          	mov    0x0(%ebp,%edx,4),%edx
  109281:	85 d2                	test   %edx,%edx
  109283:	74 eb                	je     109270 <inode_put+0x110>
        block_free(ip->dev, a[j]);
  109285:	89 54 24 04          	mov    %edx,0x4(%esp)
  109289:	8b 07                	mov    (%edi),%eax
  10928b:	89 04 24             	mov    %eax,(%esp)
  10928e:	e8 0d f9 ff ff       	call   108ba0 <block_free>
  109293:	eb db                	jmp    109270 <inode_put+0x110>
    }
    bufcache_release(bp);
  109295:	89 34 24             	mov    %esi,(%esp)
  109298:	e8 43 f3 ff ff       	call   1085e0 <bufcache_release>
    block_free(ip->dev, ip->addrs[NDIRECT]);
  10929d:	8b 47 4c             	mov    0x4c(%edi),%eax
  1092a0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1092a4:	8b 07                	mov    (%edi),%eax
  1092a6:	89 04 24             	mov    %eax,(%esp)
  1092a9:	e8 f2 f8 ff ff       	call   108ba0 <block_free>
    ip->addrs[NDIRECT] = 0;
  1092ae:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
  1092b5:	e9 4f ff ff ff       	jmp    109209 <inode_put+0xa9>
{
  spinlock_acquire(&inode_cache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode has no links: truncate and free inode.
    if(ip->flags & I_BUSY)
      KERN_PANIC("inode_put busy");
  1092ba:	c7 44 24 08 3f c9 10 	movl   $0x10c93f,0x8(%esp)
  1092c1:	00 
  1092c2:	c7 44 24 04 c5 00 00 	movl   $0xc5,0x4(%esp)
  1092c9:	00 
  1092ca:	c7 04 24 d7 c8 10 00 	movl   $0x10c8d7,(%esp)
  1092d1:	e8 aa ae ff ff       	call   104180 <debug_panic>
  1092d6:	8b 57 0c             	mov    0xc(%edi),%edx
  1092d9:	e9 da fe ff ff       	jmp    1091b8 <inode_put+0x58>
  1092de:	66 90                	xchg   %ax,%ax

001092e0 <inode_unlockput>:
/**
 * Common idiom: unlock, then put.
 */
void
inode_unlockput(struct inode *ip)
{
  1092e0:	53                   	push   %ebx
  1092e1:	83 ec 18             	sub    $0x18,%esp
  1092e4:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  inode_unlock(ip);
  1092e8:	89 1c 24             	mov    %ebx,(%esp)
  1092eb:	e8 00 fe ff ff       	call   1090f0 <inode_unlock>
  inode_put(ip);
  1092f0:	89 5c 24 20          	mov    %ebx,0x20(%esp)
}
  1092f4:	83 c4 18             	add    $0x18,%esp
  1092f7:	5b                   	pop    %ebx
 */
void
inode_unlockput(struct inode *ip)
{
  inode_unlock(ip);
  inode_put(ip);
  1092f8:	e9 63 fe ff ff       	jmp    109160 <inode_put>
  1092fd:	8d 76 00             	lea    0x0(%esi),%esi

00109300 <inode_stat>:
/**
 * Copy stat information from inode.
 */
void
inode_stat(struct inode *ip, struct file_stat *st)
{
  109300:	8b 54 24 04          	mov    0x4(%esp),%edx
  109304:	8b 44 24 08          	mov    0x8(%esp),%eax
  st->dev = ip->dev;
  109308:	8b 0a                	mov    (%edx),%ecx
  10930a:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
  10930d:	8b 4a 04             	mov    0x4(%edx),%ecx
  109310:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
  109313:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
  109317:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
  10931a:	0f b7 4a 16          	movzwl 0x16(%edx),%ecx
  st->size = ip->size;
  10931e:	8b 52 18             	mov    0x18(%edx),%edx
inode_stat(struct inode *ip, struct file_stat *st)
{
  st->dev = ip->dev;
  st->ino = ip->inum;
  st->type = ip->type;
  st->nlink = ip->nlink;
  109321:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
  109325:	89 50 10             	mov    %edx,0x10(%eax)
  109328:	c3                   	ret    
  109329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00109330 <inode_read>:
/**
 * Read data from inode.
 */
int
inode_read(struct inode *ip, char *dst, uint32_t off, uint32_t n)
{
  109330:	55                   	push   %ebp
  109331:	57                   	push   %edi
  109332:	56                   	push   %esi
  109333:	53                   	push   %ebx
  109334:	83 ec 2c             	sub    $0x2c,%esp
  109337:	8b 44 24 44          	mov    0x44(%esp),%eax
  10933b:	8b 6c 24 40          	mov    0x40(%esp),%ebp
  10933f:	8b 5c 24 48          	mov    0x48(%esp),%ebx
  109343:	89 44 24 14          	mov    %eax,0x14(%esp)
  109347:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  uint32_t tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  10934b:	66 83 7d 10 03       	cmpw   $0x3,0x10(%ebp)
/**
 * Read data from inode.
 */
int
inode_read(struct inode *ip, char *dst, uint32_t off, uint32_t n)
{
  109350:	89 44 24 10          	mov    %eax,0x10(%esp)
  uint32_t tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  109354:	0f 84 b6 00 00 00    	je     109410 <inode_read+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
  10935a:	8b 45 18             	mov    0x18(%ebp),%eax
  10935d:	39 d8                	cmp    %ebx,%eax
  10935f:	0f 82 d3 00 00 00    	jb     109438 <inode_read+0x108>
  109365:	8b 7c 24 10          	mov    0x10(%esp),%edi
  109369:	89 fa                	mov    %edi,%edx
  10936b:	01 da                	add    %ebx,%edx
  10936d:	0f 82 c5 00 00 00    	jb     109438 <inode_read+0x108>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
  109373:	89 c1                	mov    %eax,%ecx
  109375:	29 d9                	sub    %ebx,%ecx
  109377:	39 d0                	cmp    %edx,%eax
  109379:	0f 43 cf             	cmovae %edi,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  10937c:	31 f6                	xor    %esi,%esi
  10937e:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
  109380:	89 4c 24 10          	mov    %ecx,0x10(%esp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  109384:	74 7e                	je     109404 <inode_read+0xd4>
  109386:	66 90                	xchg   %ax,%ax
    bp = bufcache_read(ip->dev, bmap(ip, off/BSIZE));
  109388:	89 da                	mov    %ebx,%edx
  10938a:	89 e8                	mov    %ebp,%eax
  10938c:	c1 ea 09             	shr    $0x9,%edx
  10938f:	e8 bc f8 ff ff       	call   108c50 <bmap>
  109394:	89 44 24 04          	mov    %eax,0x4(%esp)
  109398:	8b 45 00             	mov    0x0(%ebp),%eax
  10939b:	89 04 24             	mov    %eax,(%esp)
  10939e:	e8 0d f1 ff ff       	call   1084b0 <bufcache_read>
    m = min(n - tot, BSIZE - off%BSIZE);
  1093a3:	89 d9                	mov    %ebx,%ecx
  1093a5:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
  1093ab:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bufcache_read(ip->dev, bmap(ip, off/BSIZE));
  1093af:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
  1093b1:	b8 00 02 00 00       	mov    $0x200,%eax
  1093b6:	29 c8                	sub    %ecx,%eax
  1093b8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1093bc:	8b 44 24 10          	mov    0x10(%esp),%eax
  1093c0:	29 f0                	sub    %esi,%eax
  1093c2:	89 04 24             	mov    %eax,(%esp)
  1093c5:	e8 96 b9 ff ff       	call   104d60 <min>
    memmove(dst, bp->data + off%BSIZE, m);
  1093ca:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
  1093ce:	89 44 24 08          	mov    %eax,0x8(%esp)
  1093d2:	89 44 24 18          	mov    %eax,0x18(%esp)
  1093d6:	8d 44 0f 18          	lea    0x18(%edi,%ecx,1),%eax
  1093da:	8b 4c 24 14          	mov    0x14(%esp),%ecx
  1093de:	89 44 24 04          	mov    %eax,0x4(%esp)
  1093e2:	89 0c 24             	mov    %ecx,(%esp)
  1093e5:	e8 e6 a9 ff ff       	call   103dd0 <memmove>
    bufcache_release(bp);
  1093ea:	89 3c 24             	mov    %edi,(%esp)
  1093ed:	e8 ee f1 ff ff       	call   1085e0 <bufcache_release>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  1093f2:	8b 54 24 18          	mov    0x18(%esp),%edx
  1093f6:	01 54 24 14          	add    %edx,0x14(%esp)
  1093fa:	01 d6                	add    %edx,%esi
  1093fc:	01 d3                	add    %edx,%ebx
  1093fe:	39 74 24 10          	cmp    %esi,0x10(%esp)
  109402:	77 84                	ja     109388 <inode_read+0x58>
    bp = bufcache_read(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    bufcache_release(bp);
  }
  return n;
  109404:	8b 44 24 10          	mov    0x10(%esp),%eax
}
  109408:	83 c4 2c             	add    $0x2c,%esp
  10940b:	5b                   	pop    %ebx
  10940c:	5e                   	pop    %esi
  10940d:	5f                   	pop    %edi
  10940e:	5d                   	pop    %ebp
  10940f:	c3                   	ret    
{
  uint32_t tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
  109410:	0f bf 45 12          	movswl 0x12(%ebp),%eax
  109414:	66 83 f8 09          	cmp    $0x9,%ax
  109418:	77 1e                	ja     109438 <inode_read+0x108>
  10941a:	8b 15 00 db e0 00    	mov    0xe0db00,%edx
  109420:	8b 04 c2             	mov    (%edx,%eax,8),%eax
  109423:	85 c0                	test   %eax,%eax
  109425:	74 11                	je     109438 <inode_read+0x108>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  109427:	8b 74 24 10          	mov    0x10(%esp),%esi
  10942b:	89 74 24 48          	mov    %esi,0x48(%esp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    bufcache_release(bp);
  }
  return n;
}
  10942f:	83 c4 2c             	add    $0x2c,%esp
  109432:	5b                   	pop    %ebx
  109433:	5e                   	pop    %esi
  109434:	5f                   	pop    %edi
  109435:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  109436:	ff e0                	jmp    *%eax
  uint32_t tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
  109438:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10943d:	eb c9                	jmp    109408 <inode_read+0xd8>
  10943f:	90                   	nop

00109440 <inode_write>:
/**
 * Write data to inode.
 */
int
inode_write(struct inode *ip, char *src, uint32_t off, uint32_t n)
{
  109440:	55                   	push   %ebp
  109441:	57                   	push   %edi
  109442:	56                   	push   %esi
  109443:	53                   	push   %ebx
  109444:	83 ec 2c             	sub    $0x2c,%esp
  109447:	8b 44 24 44          	mov    0x44(%esp),%eax
  10944b:	8b 6c 24 40          	mov    0x40(%esp),%ebp
  10944f:	8b 5c 24 48          	mov    0x48(%esp),%ebx
  109453:	89 44 24 14          	mov    %eax,0x14(%esp)
  109457:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  uint32_t tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  10945b:	66 83 7d 10 03       	cmpw   $0x3,0x10(%ebp)
/**
 * Write data to inode.
 */
int
inode_write(struct inode *ip, char *src, uint32_t off, uint32_t n)
{
  109460:	89 44 24 10          	mov    %eax,0x10(%esp)
  uint32_t tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  109464:	0f 84 ce 00 00 00    	je     109538 <inode_write+0xf8>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
  10946a:	39 5d 18             	cmp    %ebx,0x18(%ebp)
  10946d:	0f 82 05 01 00 00    	jb     109578 <inode_write+0x138>
  109473:	8b 7c 24 10          	mov    0x10(%esp),%edi
  109477:	89 f8                	mov    %edi,%eax
  109479:	01 d8                	add    %ebx,%eax
  10947b:	0f 82 f7 00 00 00    	jb     109578 <inode_write+0x138>
    return -1;
  if(off + n > MAXFILE*BSIZE)
  109481:	3d 00 18 01 00       	cmp    $0x11800,%eax
  109486:	0f 87 ec 00 00 00    	ja     109578 <inode_write+0x138>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  10948c:	31 f6                	xor    %esi,%esi
  10948e:	85 ff                	test   %edi,%edi
  109490:	0f 84 8f 00 00 00    	je     109525 <inode_write+0xe5>
  109496:	66 90                	xchg   %ax,%ax
    bp = bufcache_read(ip->dev, bmap(ip, off/BSIZE));
  109498:	89 da                	mov    %ebx,%edx
  10949a:	89 e8                	mov    %ebp,%eax
  10949c:	c1 ea 09             	shr    $0x9,%edx
  10949f:	e8 ac f7 ff ff       	call   108c50 <bmap>
  1094a4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1094a8:	8b 45 00             	mov    0x0(%ebp),%eax
  1094ab:	89 04 24             	mov    %eax,(%esp)
  1094ae:	e8 fd ef ff ff       	call   1084b0 <bufcache_read>
    m = min(n - tot, BSIZE - off%BSIZE);
  1094b3:	89 d9                	mov    %ebx,%ecx
  1094b5:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
  1094bb:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bufcache_read(ip->dev, bmap(ip, off/BSIZE));
  1094bf:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
  1094c1:	b8 00 02 00 00       	mov    $0x200,%eax
  1094c6:	29 c8                	sub    %ecx,%eax
  1094c8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1094cc:	8b 44 24 10          	mov    0x10(%esp),%eax
  1094d0:	29 f0                	sub    %esi,%eax
  1094d2:	89 04 24             	mov    %eax,(%esp)
  1094d5:	e8 86 b8 ff ff       	call   104d60 <min>
    memmove(bp->data + off%BSIZE, src, m);
  1094da:	8b 4c 24 14          	mov    0x14(%esp),%ecx
  1094de:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  1094e2:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
  1094e6:	89 44 24 08          	mov    %eax,0x8(%esp)
  1094ea:	89 44 24 18          	mov    %eax,0x18(%esp)
  1094ee:	8d 44 0f 18          	lea    0x18(%edi,%ecx,1),%eax
  1094f2:	89 04 24             	mov    %eax,(%esp)
  1094f5:	e8 d6 a8 ff ff       	call   103dd0 <memmove>
    log_write(bp);
  1094fa:	89 3c 24             	mov    %edi,(%esp)
  1094fd:	e8 ce f3 ff ff       	call   1088d0 <log_write>
    bufcache_release(bp);
  109502:	89 3c 24             	mov    %edi,(%esp)
  109505:	e8 d6 f0 ff ff       	call   1085e0 <bufcache_release>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  10950a:	8b 54 24 18          	mov    0x18(%esp),%edx
  10950e:	01 54 24 14          	add    %edx,0x14(%esp)
  109512:	01 d6                	add    %edx,%esi
  109514:	01 d3                	add    %edx,%ebx
  109516:	39 74 24 10          	cmp    %esi,0x10(%esp)
  10951a:	0f 87 78 ff ff ff    	ja     109498 <inode_write+0x58>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    bufcache_release(bp);
  }

  if(n > 0 && off > ip->size){
  109520:	39 5d 18             	cmp    %ebx,0x18(%ebp)
  109523:	72 43                	jb     109568 <inode_write+0x128>
    ip->size = off;
    inode_update(ip);
  }
  return n;
  109525:	8b 44 24 10          	mov    0x10(%esp),%eax
}
  109529:	83 c4 2c             	add    $0x2c,%esp
  10952c:	5b                   	pop    %ebx
  10952d:	5e                   	pop    %esi
  10952e:	5f                   	pop    %edi
  10952f:	5d                   	pop    %ebp
  109530:	c3                   	ret    
  109531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  uint32_t tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
  109538:	0f bf 45 12          	movswl 0x12(%ebp),%eax
  10953c:	66 83 f8 09          	cmp    $0x9,%ax
  109540:	77 36                	ja     109578 <inode_write+0x138>
  109542:	8b 15 00 db e0 00    	mov    0xe0db00,%edx
  109548:	8b 44 c2 04          	mov    0x4(%edx,%eax,8),%eax
  10954c:	85 c0                	test   %eax,%eax
  10954e:	74 28                	je     109578 <inode_write+0x138>
      return -1;
    return devsw[ip->major].write(ip, src, n);
  109550:	8b 74 24 10          	mov    0x10(%esp),%esi
  109554:	89 74 24 48          	mov    %esi,0x48(%esp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    inode_update(ip);
  }
  return n;
}
  109558:	83 c4 2c             	add    $0x2c,%esp
  10955b:	5b                   	pop    %ebx
  10955c:	5e                   	pop    %esi
  10955d:	5f                   	pop    %edi
  10955e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  10955f:	ff e0                	jmp    *%eax
  109561:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    bufcache_release(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
  109568:	89 5d 18             	mov    %ebx,0x18(%ebp)
    inode_update(ip);
  10956b:	89 2c 24             	mov    %ebp,(%esp)
  10956e:	e8 cd f7 ff ff       	call   108d40 <inode_update>
  109573:	eb b0                	jmp    109525 <inode_write+0xe5>
  109575:	8d 76 00             	lea    0x0(%esi),%esi
  }
  return n;
}
  109578:	83 c4 2c             	add    $0x2c,%esp
  uint32_t tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
  10957b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(n > 0 && off > ip->size){
    ip->size = off;
    inode_update(ip);
  }
  return n;
}
  109580:	5b                   	pop    %ebx
  109581:	5e                   	pop    %esi
  109582:	5f                   	pop    %edi
  109583:	5d                   	pop    %ebp
  109584:	c3                   	ret    
  109585:	66 90                	xchg   %ax,%ax
  109587:	66 90                	xchg   %ax,%ax
  109589:	66 90                	xchg   %ax,%ax
  10958b:	66 90                	xchg   %ax,%ax
  10958d:	66 90                	xchg   %ax,%ax
  10958f:	90                   	nop

00109590 <dir_namecmp>:

// Directories

int
dir_namecmp(const char *s, const char *t)
{
  109590:	83 ec 1c             	sub    $0x1c,%esp
  return strncmp(s, t, DIRSIZ);
  109593:	8b 44 24 24          	mov    0x24(%esp),%eax
  109597:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  10959e:	00 
  10959f:	89 44 24 04          	mov    %eax,0x4(%esp)
  1095a3:	8b 44 24 20          	mov    0x20(%esp),%eax
  1095a7:	89 04 24             	mov    %eax,(%esp)
  1095aa:	e8 a1 a8 ff ff       	call   103e50 <strncmp>
}
  1095af:	83 c4 1c             	add    $0x1c,%esp
  1095b2:	c3                   	ret    
  1095b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1095b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001095c0 <dir_lookup>:
 * Look for a directory entry in a directory.
 * If found, set *poff to byte offset of entry.
 */
struct inode*
dir_lookup(struct inode *dp, char *name, uint32_t *poff)
{
  1095c0:	55                   	push   %ebp
  1095c1:	57                   	push   %edi
  1095c2:	56                   	push   %esi
  1095c3:	53                   	push   %ebx
  1095c4:	83 ec 2c             	sub    $0x2c,%esp
  1095c7:	8b 74 24 40          	mov    0x40(%esp),%esi
  uint32_t off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
  1095cb:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
  1095d0:	74 1c                	je     1095ee <dir_lookup+0x2e>
    KERN_PANIC("dir_lookup not DIR");
  1095d2:	c7 44 24 08 4e c9 10 	movl   $0x10c94e,0x8(%esp)
  1095d9:	00 
  1095da:	c7 44 24 04 1a 00 00 	movl   $0x1a,0x4(%esp)
  1095e1:	00 
  1095e2:	c7 04 24 61 c9 10 00 	movl   $0x10c961,(%esp)
  1095e9:	e8 92 ab ff ff       	call   104180 <debug_panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
  1095ee:	8b 56 18             	mov    0x18(%esi),%edx
  1095f1:	31 db                	xor    %ebx,%ebx
  1095f3:	8d 7c 24 10          	lea    0x10(%esp),%edi
// Directories

int
dir_namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
  1095f7:	8d 6c 24 12          	lea    0x12(%esp),%ebp
  struct dirent de;

  if(dp->type != T_DIR)
    KERN_PANIC("dir_lookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
  1095fb:	85 d2                	test   %edx,%edx
  1095fd:	75 15                	jne    109614 <dir_lookup+0x54>
  1095ff:	e9 9c 00 00 00       	jmp    1096a0 <dir_lookup+0xe0>
  109604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  109608:	83 c3 10             	add    $0x10,%ebx
  10960b:	39 5e 18             	cmp    %ebx,0x18(%esi)
  10960e:	0f 86 8c 00 00 00    	jbe    1096a0 <dir_lookup+0xe0>
    if(inode_read(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  109614:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  10961b:	00 
  10961c:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  109620:	89 7c 24 04          	mov    %edi,0x4(%esp)
  109624:	89 34 24             	mov    %esi,(%esp)
  109627:	e8 04 fd ff ff       	call   109330 <inode_read>
  10962c:	83 f8 10             	cmp    $0x10,%eax
  10962f:	74 1c                	je     10964d <dir_lookup+0x8d>
      KERN_PANIC("dir_link read");
  109631:	c7 44 24 08 6f c9 10 	movl   $0x10c96f,0x8(%esp)
  109638:	00 
  109639:	c7 44 24 04 1e 00 00 	movl   $0x1e,0x4(%esp)
  109640:	00 
  109641:	c7 04 24 61 c9 10 00 	movl   $0x10c961,(%esp)
  109648:	e8 33 ab ff ff       	call   104180 <debug_panic>
    if(de.inum == 0)
  10964d:	66 83 7c 24 10 00    	cmpw   $0x0,0x10(%esp)
  109653:	74 b3                	je     109608 <dir_lookup+0x48>
// Directories

int
dir_namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
  109655:	8b 44 24 44          	mov    0x44(%esp),%eax
  109659:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  109660:	00 
  109661:	89 6c 24 04          	mov    %ebp,0x4(%esp)
  109665:	89 04 24             	mov    %eax,(%esp)
  109668:	e8 e3 a7 ff ff       	call   103e50 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(inode_read(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      KERN_PANIC("dir_link read");
    if(de.inum == 0)
      continue;
    if(dir_namecmp(name, de.name) == 0){
  10966d:	85 c0                	test   %eax,%eax
  10966f:	75 97                	jne    109608 <dir_lookup+0x48>
      // entry matches path element
      if(poff)
  109671:	8b 44 24 48          	mov    0x48(%esp),%eax
  109675:	85 c0                	test   %eax,%eax
  109677:	74 06                	je     10967f <dir_lookup+0xbf>
        *poff = off;
  109679:	8b 44 24 48          	mov    0x48(%esp),%eax
  10967d:	89 18                	mov    %ebx,(%eax)
      inum = de.inum;
  10967f:	0f b7 44 24 10       	movzwl 0x10(%esp),%eax
  109684:	89 44 24 04          	mov    %eax,0x4(%esp)
      return inode_get(dp->dev, inum);
  109688:	8b 06                	mov    (%esi),%eax
  10968a:	89 04 24             	mov    %eax,(%esp)
  10968d:	e8 3e f7 ff ff       	call   108dd0 <inode_get>
    }
  }

  return 0;
}
  109692:	83 c4 2c             	add    $0x2c,%esp
  109695:	5b                   	pop    %ebx
  109696:	5e                   	pop    %esi
  109697:	5f                   	pop    %edi
  109698:	5d                   	pop    %ebp
  109699:	c3                   	ret    
  10969a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1096a0:	83 c4 2c             	add    $0x2c,%esp
      inum = de.inum;
      return inode_get(dp->dev, inum);
    }
  }

  return 0;
  1096a3:	31 c0                	xor    %eax,%eax
}
  1096a5:	5b                   	pop    %ebx
  1096a6:	5e                   	pop    %esi
  1096a7:	5f                   	pop    %edi
  1096a8:	5d                   	pop    %ebp
  1096a9:	c3                   	ret    
  1096aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001096b0 <dir_link>:

// Write a new directory entry (name, inum) into the directory dp.
int
dir_link(struct inode *dp, char *name, uint32_t inum)
{
  1096b0:	55                   	push   %ebp
  1096b1:	57                   	push   %edi
  1096b2:	56                   	push   %esi
  1096b3:	53                   	push   %ebx
  1096b4:	83 ec 2c             	sub    $0x2c,%esp
  1096b7:	8b 74 24 40          	mov    0x40(%esp),%esi
  1096bb:	8b 6c 24 44          	mov    0x44(%esp),%ebp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dir_lookup(dp, name, 0)) != 0){
  1096bf:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  1096c6:	00 
  1096c7:	89 34 24             	mov    %esi,(%esp)
  1096ca:	89 6c 24 04          	mov    %ebp,0x4(%esp)
  1096ce:	e8 ed fe ff ff       	call   1095c0 <dir_lookup>
  1096d3:	85 c0                	test   %eax,%eax
  1096d5:	0f 85 c4 00 00 00    	jne    10979f <dir_link+0xef>
    inode_put(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
  1096db:	8b 46 18             	mov    0x18(%esi),%eax
  1096de:	31 db                	xor    %ebx,%ebx
  1096e0:	8d 7c 24 10          	lea    0x10(%esp),%edi
  1096e4:	85 c0                	test   %eax,%eax
  1096e6:	75 10                	jne    1096f8 <dir_link+0x48>
  1096e8:	eb 4f                	jmp    109739 <dir_link+0x89>
  1096ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1096f0:	83 c3 10             	add    $0x10,%ebx
  1096f3:	39 5e 18             	cmp    %ebx,0x18(%esi)
  1096f6:	76 41                	jbe    109739 <dir_link+0x89>
    if(inode_read(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  1096f8:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  1096ff:	00 
  109700:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  109704:	89 7c 24 04          	mov    %edi,0x4(%esp)
  109708:	89 34 24             	mov    %esi,(%esp)
  10970b:	e8 20 fc ff ff       	call   109330 <inode_read>
  109710:	83 f8 10             	cmp    $0x10,%eax
  109713:	74 1c                	je     109731 <dir_link+0x81>
      KERN_PANIC("dir_link read");
  109715:	c7 44 24 08 6f c9 10 	movl   $0x10c96f,0x8(%esp)
  10971c:	00 
  10971d:	c7 44 24 04 3e 00 00 	movl   $0x3e,0x4(%esp)
  109724:	00 
  109725:	c7 04 24 61 c9 10 00 	movl   $0x10c961,(%esp)
  10972c:	e8 4f aa ff ff       	call   104180 <debug_panic>
    if(de.inum == 0)
  109731:	66 83 7c 24 10 00    	cmpw   $0x0,0x10(%esp)
  109737:	75 b7                	jne    1096f0 <dir_link+0x40>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  109739:	8d 44 24 12          	lea    0x12(%esp),%eax
  10973d:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  109744:	00 
  109745:	89 6c 24 04          	mov    %ebp,0x4(%esp)
  109749:	89 04 24             	mov    %eax,(%esp)
  10974c:	e8 af a8 ff ff       	call   104000 <strncpy>
  de.inum = inum;
  109751:	8b 44 24 48          	mov    0x48(%esp),%eax
  if(inode_write(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  109755:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    KERN_PANIC("dir_link");
  
  return 0;
  109759:	31 db                	xor    %ebx,%ebx
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(inode_write(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  10975b:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  109762:	00 
  109763:	89 7c 24 04          	mov    %edi,0x4(%esp)
  109767:	89 34 24             	mov    %esi,(%esp)
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  10976a:	66 89 44 24 10       	mov    %ax,0x10(%esp)
  if(inode_write(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  10976f:	e8 cc fc ff ff       	call   109440 <inode_write>
  109774:	83 f8 10             	cmp    $0x10,%eax
  109777:	74 1c                	je     109795 <dir_link+0xe5>
    KERN_PANIC("dir_link");
  109779:	c7 44 24 08 f3 c9 10 	movl   $0x10c9f3,0x8(%esp)
  109780:	00 
  109781:	c7 44 24 04 46 00 00 	movl   $0x46,0x4(%esp)
  109788:	00 
  109789:	c7 04 24 61 c9 10 00 	movl   $0x10c961,(%esp)
  109790:	e8 eb a9 ff ff       	call   104180 <debug_panic>
  
  return 0;
}
  109795:	83 c4 2c             	add    $0x2c,%esp
  109798:	89 d8                	mov    %ebx,%eax
  10979a:	5b                   	pop    %ebx
  10979b:	5e                   	pop    %esi
  10979c:	5f                   	pop    %edi
  10979d:	5d                   	pop    %ebp
  10979e:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dir_lookup(dp, name, 0)) != 0){
    inode_put(ip);
  10979f:	89 04 24             	mov    %eax,(%esp)
    return -1;
  1097a2:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dir_lookup(dp, name, 0)) != 0){
    inode_put(ip);
  1097a7:	e8 b4 f9 ff ff       	call   109160 <inode_put>
    return -1;
  1097ac:	eb e7                	jmp    109795 <dir_link+0xe5>
  1097ae:	66 90                	xchg   %ax,%ax

001097b0 <namex>:
 * If nameiparent is true, return the inode for the parent and copy the final
 * path element into name, which must have room for DIRSIZ bytes.
 */
static struct inode*
namex(char *path, bool nameiparent, char *name)
{
  1097b0:	55                   	push   %ebp
  1097b1:	57                   	push   %edi
  1097b2:	89 cf                	mov    %ecx,%edi
  1097b4:	56                   	push   %esi
  1097b5:	53                   	push   %ebx
  1097b6:	89 c3                	mov    %eax,%ebx
  1097b8:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *next;

  // If path is a full path, get the pointer to the root inode. Otherwise get
  // the inode corresponding to the current working directory.
  if(*path == '/'){
  1097bb:	80 3b 2f             	cmpb   $0x2f,(%ebx)
 * If nameiparent is true, return the inode for the parent and copy the final
 * path element into name, which must have room for DIRSIZ bytes.
 */
static struct inode*
namex(char *path, bool nameiparent, char *name)
{
  1097be:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  1097c2:	88 54 24 17          	mov    %dl,0x17(%esp)
  struct inode *ip, *next;

  // If path is a full path, get the pointer to the root inode. Otherwise get
  // the inode corresponding to the current working directory.
  if(*path == '/'){
  1097c6:	0f 84 18 01 00 00    	je     1098e4 <namex+0x134>
    ip = inode_get(ROOTDEV, ROOTINO);
  }
  else {
    ip = inode_dup((struct inode*) tcb_get_cwd(get_curid()));
  1097cc:	e8 9f d7 ff ff       	call   106f70 <get_curid>
  1097d1:	89 04 24             	mov    %eax,(%esp)
  1097d4:	e8 07 d4 ff ff       	call   106be0 <tcb_get_cwd>
  1097d9:	89 04 24             	mov    %eax,(%esp)
  1097dc:	e8 af f7 ff ff       	call   108f90 <inode_dup>
  1097e1:	89 c6                	mov    %eax,%esi
  1097e3:	eb 06                	jmp    1097eb <namex+0x3b>
  1097e5:	8d 76 00             	lea    0x0(%esi),%esi
{
  char *s;
  int len;
  
  while(*path == '/')
    path++;
  1097e8:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;
  
  while(*path == '/')
  1097eb:	0f b6 03             	movzbl (%ebx),%eax
  1097ee:	3c 2f                	cmp    $0x2f,%al
  1097f0:	74 f6                	je     1097e8 <namex+0x38>
    path++;
  if(*path == 0)
  1097f2:	84 c0                	test   %al,%al
  1097f4:	0f 84 d9 00 00 00    	je     1098d3 <namex+0x123>
    return 0;
  s = path;
  while(*path != '/' && *path != 0){
  1097fa:	0f b6 03             	movzbl (%ebx),%eax
  1097fd:	89 dd                	mov    %ebx,%ebp
  1097ff:	84 c0                	test   %al,%al
  109801:	0f 84 a1 00 00 00    	je     1098a8 <namex+0xf8>
  109807:	3c 2f                	cmp    $0x2f,%al
  109809:	75 09                	jne    109814 <namex+0x64>
  10980b:	e9 98 00 00 00       	jmp    1098a8 <namex+0xf8>
  109810:	3c 2f                	cmp    $0x2f,%al
  109812:	74 0b                	je     10981f <namex+0x6f>
    path++;
  109814:	83 c5 01             	add    $0x1,%ebp
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0){
  109817:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
  10981b:	84 c0                	test   %al,%al
  10981d:	75 f1                	jne    109810 <namex+0x60>
  10981f:	89 e9                	mov    %ebp,%ecx
  109821:	29 d9                	sub    %ebx,%ecx
    path++;
  }
  len = path - s;
  if(len >= DIRSIZ) {
  109823:	83 f9 0d             	cmp    $0xd,%ecx
  109826:	0f 8e 84 00 00 00    	jle    1098b0 <namex+0x100>
    memmove(name, s, DIRSIZ - 1);
  10982c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0){
    path++;
  109830:	89 eb                	mov    %ebp,%ebx
  }
  len = path - s;
  if(len >= DIRSIZ) {
    memmove(name, s, DIRSIZ - 1);
  109832:	c7 44 24 08 0d 00 00 	movl   $0xd,0x8(%esp)
  109839:	00 
  10983a:	89 3c 24             	mov    %edi,(%esp)
  10983d:	e8 8e a5 ff ff       	call   103dd0 <memmove>
    name[DIRSIZ - 1] = 0;
  109842:	c6 47 0d 00          	movb   $0x0,0xd(%edi)
  }
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
  109846:	80 7d 00 2f          	cmpb   $0x2f,0x0(%ebp)
  10984a:	75 0c                	jne    109858 <namex+0xa8>
  10984c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
  109850:	83 c3 01             	add    $0x1,%ebx
  }
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
  109853:	80 3b 2f             	cmpb   $0x2f,(%ebx)
  109856:	74 f8                	je     109850 <namex+0xa0>
    ip = inode_dup((struct inode*) tcb_get_cwd(get_curid()));
  }

  while((path = skipelem(path, name)) != 0){
    //KERN_INFO("    path=%s, name=%s\n", path, name);
    inode_lock(ip);
  109858:	89 34 24             	mov    %esi,(%esp)
  10985b:	e8 60 f7 ff ff       	call   108fc0 <inode_lock>
    if(ip->type != T_DIR){
  109860:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
  109865:	0f 85 94 00 00 00    	jne    1098ff <namex+0x14f>
      inode_unlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
  10986b:	80 7c 24 17 00       	cmpb   $0x0,0x17(%esp)
  109870:	74 09                	je     10987b <namex+0xcb>
  109872:	80 3b 00             	cmpb   $0x0,(%ebx)
  109875:	0f 84 a5 00 00 00    	je     109920 <namex+0x170>
      // Stop one level early.
      inode_unlock(ip);
      return ip;
    }
    if((next = dir_lookup(ip, name, 0)) == 0){
  10987b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  109882:	00 
  109883:	89 7c 24 04          	mov    %edi,0x4(%esp)
  109887:	89 34 24             	mov    %esi,(%esp)
  10988a:	e8 31 fd ff ff       	call   1095c0 <dir_lookup>
      inode_unlockput(ip);
  10988f:	89 34 24             	mov    %esi,(%esp)
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      inode_unlock(ip);
      return ip;
    }
    if((next = dir_lookup(ip, name, 0)) == 0){
  109892:	85 c0                	test   %eax,%eax
  109894:	89 c5                	mov    %eax,%ebp
  109896:	74 79                	je     109911 <namex+0x161>
      inode_unlockput(ip);
      return 0;
    }
    inode_unlockput(ip);
  109898:	e8 43 fa ff ff       	call   1092e0 <inode_unlockput>
    ip = next;
  10989d:	89 ee                	mov    %ebp,%esi
  10989f:	e9 47 ff ff ff       	jmp    1097eb <namex+0x3b>
  1098a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0){
  1098a8:	31 c9                	xor    %ecx,%ecx
  1098aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(len >= DIRSIZ) {
    memmove(name, s, DIRSIZ - 1);
    name[DIRSIZ - 1] = 0;
  }
  else {
    memmove(name, s, len);
  1098b0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  1098b4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    name[len] = 0;
  1098b8:	89 eb                	mov    %ebp,%ebx
  if(len >= DIRSIZ) {
    memmove(name, s, DIRSIZ - 1);
    name[DIRSIZ - 1] = 0;
  }
  else {
    memmove(name, s, len);
  1098ba:	89 3c 24             	mov    %edi,(%esp)
  1098bd:	89 4c 24 18          	mov    %ecx,0x18(%esp)
  1098c1:	e8 0a a5 ff ff       	call   103dd0 <memmove>
    name[len] = 0;
  1098c6:	8b 4c 24 18          	mov    0x18(%esp),%ecx
  1098ca:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
  1098ce:	e9 73 ff ff ff       	jmp    109846 <namex+0x96>
      return 0;
    }
    inode_unlockput(ip);
    ip = next;
  }
  if(nameiparent){
  1098d3:	80 7c 24 1c 00       	cmpb   $0x0,0x1c(%esp)
  1098d8:	75 58                	jne    109932 <namex+0x182>
  1098da:	89 f0                	mov    %esi,%eax
    inode_put(ip);
    return 0;
  }
  return ip;
}
  1098dc:	83 c4 2c             	add    $0x2c,%esp
  1098df:	5b                   	pop    %ebx
  1098e0:	5e                   	pop    %esi
  1098e1:	5f                   	pop    %edi
  1098e2:	5d                   	pop    %ebp
  1098e3:	c3                   	ret    
  struct inode *ip, *next;

  // If path is a full path, get the pointer to the root inode. Otherwise get
  // the inode corresponding to the current working directory.
  if(*path == '/'){
    ip = inode_get(ROOTDEV, ROOTINO);
  1098e4:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1098eb:	00 
  1098ec:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1098f3:	e8 d8 f4 ff ff       	call   108dd0 <inode_get>
  1098f8:	89 c6                	mov    %eax,%esi
  1098fa:	e9 ec fe ff ff       	jmp    1097eb <namex+0x3b>

  while((path = skipelem(path, name)) != 0){
    //KERN_INFO("    path=%s, name=%s\n", path, name);
    inode_lock(ip);
    if(ip->type != T_DIR){
      inode_unlockput(ip);
  1098ff:	89 34 24             	mov    %esi,(%esp)
  109902:	e8 d9 f9 ff ff       	call   1092e0 <inode_unlockput>
  if(nameiparent){
    inode_put(ip);
    return 0;
  }
  return ip;
}
  109907:	83 c4 2c             	add    $0x2c,%esp
  while((path = skipelem(path, name)) != 0){
    //KERN_INFO("    path=%s, name=%s\n", path, name);
    inode_lock(ip);
    if(ip->type != T_DIR){
      inode_unlockput(ip);
      return 0;
  10990a:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    inode_put(ip);
    return 0;
  }
  return ip;
}
  10990c:	5b                   	pop    %ebx
  10990d:	5e                   	pop    %esi
  10990e:	5f                   	pop    %edi
  10990f:	5d                   	pop    %ebp
  109910:	c3                   	ret    
      // Stop one level early.
      inode_unlock(ip);
      return ip;
    }
    if((next = dir_lookup(ip, name, 0)) == 0){
      inode_unlockput(ip);
  109911:	e8 ca f9 ff ff       	call   1092e0 <inode_unlockput>
  if(nameiparent){
    inode_put(ip);
    return 0;
  }
  return ip;
}
  109916:	83 c4 2c             	add    $0x2c,%esp
      inode_unlock(ip);
      return ip;
    }
    if((next = dir_lookup(ip, name, 0)) == 0){
      inode_unlockput(ip);
      return 0;
  109919:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    inode_put(ip);
    return 0;
  }
  return ip;
}
  10991b:	5b                   	pop    %ebx
  10991c:	5e                   	pop    %esi
  10991d:	5f                   	pop    %edi
  10991e:	5d                   	pop    %ebp
  10991f:	c3                   	ret    
      inode_unlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      inode_unlock(ip);
  109920:	89 34 24             	mov    %esi,(%esp)
  109923:	e8 c8 f7 ff ff       	call   1090f0 <inode_unlock>
  if(nameiparent){
    inode_put(ip);
    return 0;
  }
  return ip;
}
  109928:	83 c4 2c             	add    $0x2c,%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      inode_unlock(ip);
      return ip;
  10992b:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    inode_put(ip);
    return 0;
  }
  return ip;
}
  10992d:	5b                   	pop    %ebx
  10992e:	5e                   	pop    %esi
  10992f:	5f                   	pop    %edi
  109930:	5d                   	pop    %ebp
  109931:	c3                   	ret    
    }
    inode_unlockput(ip);
    ip = next;
  }
  if(nameiparent){
    inode_put(ip);
  109932:	89 34 24             	mov    %esi,(%esp)
  109935:	e8 26 f8 ff ff       	call   109160 <inode_put>
    return 0;
  10993a:	31 c0                	xor    %eax,%eax
  10993c:	eb 9e                	jmp    1098dc <namex+0x12c>
  10993e:	66 90                	xchg   %ax,%ax

00109940 <namei>:
/**
 * Return the inode corresponding to path.
 */
struct inode*
namei(char *path)
{
  109940:	83 ec 1c             	sub    $0x1c,%esp
  char name[DIRSIZ];
  return namex(path, FALSE, name);
  109943:	31 d2                	xor    %edx,%edx
  109945:	8b 44 24 20          	mov    0x20(%esp),%eax
  109949:	8d 4c 24 02          	lea    0x2(%esp),%ecx
  10994d:	e8 5e fe ff ff       	call   1097b0 <namex>
}
  109952:	83 c4 1c             	add    $0x1c,%esp
  109955:	c3                   	ret    
  109956:	8d 76 00             	lea    0x0(%esi),%esi
  109959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00109960 <nameiparent>:
 * element into name.
 */
struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, TRUE, name);
  109960:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  109964:	ba 01 00 00 00       	mov    $0x1,%edx
  109969:	8b 44 24 04          	mov    0x4(%esp),%eax
  10996d:	e9 3e fe ff ff       	jmp    1097b0 <namex>
  109972:	66 90                	xchg   %ax,%ax
  109974:	66 90                	xchg   %ax,%ax
  109976:	66 90                	xchg   %ax,%ax
  109978:	66 90                	xchg   %ax,%ax
  10997a:	66 90                	xchg   %ax,%ax
  10997c:	66 90                	xchg   %ax,%ax
  10997e:	66 90                	xchg   %ax,%ax

00109980 <file_init>:
  struct file file[NFILE];
} ftable;

void
file_init(void)
{
  109980:	83 ec 1c             	sub    $0x1c,%esp
  spinlock_init(&ftable.lock);
  109983:	c7 04 24 e0 23 e1 00 	movl   $0xe123e0,(%esp)
  10998a:	e8 21 bf ff ff       	call   1058b0 <spinlock_init>
}
  10998f:	83 c4 1c             	add    $0x1c,%esp
  109992:	c3                   	ret    
  109993:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  109999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001099a0 <file_alloc>:
/**
 * Allocate a file structure.
 */
struct file*
file_alloc(void)
{
  1099a0:	53                   	push   %ebx
  struct file *f;

  spinlock_acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
  1099a1:	bb e8 23 e1 00       	mov    $0xe123e8,%ebx
/**
 * Allocate a file structure.
 */
struct file*
file_alloc(void)
{
  1099a6:	83 ec 18             	sub    $0x18,%esp
  struct file *f;

  spinlock_acquire(&ftable.lock);
  1099a9:	c7 04 24 e0 23 e1 00 	movl   $0xe123e0,(%esp)
  1099b0:	e8 bb c0 ff ff       	call   105a70 <spinlock_acquire>
  1099b5:	eb 0c                	jmp    1099c3 <file_alloc+0x23>
  1099b7:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
  1099b8:	83 c3 14             	add    $0x14,%ebx
  1099bb:	81 fb b8 2b e1 00    	cmp    $0xe12bb8,%ebx
  1099c1:	74 25                	je     1099e8 <file_alloc+0x48>
    if(f->ref == 0){
  1099c3:	8b 43 04             	mov    0x4(%ebx),%eax
  1099c6:	85 c0                	test   %eax,%eax
  1099c8:	75 ee                	jne    1099b8 <file_alloc+0x18>
      f->ref = 1;
      spinlock_release(&ftable.lock);
  1099ca:	c7 04 24 e0 23 e1 00 	movl   $0xe123e0,(%esp)
  struct file *f;

  spinlock_acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
  1099d1:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      spinlock_release(&ftable.lock);
  1099d8:	e8 13 c1 ff ff       	call   105af0 <spinlock_release>
      return f;
    }
  }
  spinlock_release(&ftable.lock);
  return 0;
}
  1099dd:	83 c4 18             	add    $0x18,%esp
  spinlock_acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
      spinlock_release(&ftable.lock);
      return f;
  1099e0:	89 d8                	mov    %ebx,%eax
    }
  }
  spinlock_release(&ftable.lock);
  return 0;
}
  1099e2:	5b                   	pop    %ebx
  1099e3:	c3                   	ret    
  1099e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      f->ref = 1;
      spinlock_release(&ftable.lock);
      return f;
    }
  }
  spinlock_release(&ftable.lock);
  1099e8:	c7 04 24 e0 23 e1 00 	movl   $0xe123e0,(%esp)
  1099ef:	e8 fc c0 ff ff       	call   105af0 <spinlock_release>
  return 0;
}
  1099f4:	83 c4 18             	add    $0x18,%esp
      spinlock_release(&ftable.lock);
      return f;
    }
  }
  spinlock_release(&ftable.lock);
  return 0;
  1099f7:	31 c0                	xor    %eax,%eax
}
  1099f9:	5b                   	pop    %ebx
  1099fa:	c3                   	ret    
  1099fb:	90                   	nop
  1099fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00109a00 <file_dup>:
/**
 * Increment ref count for file f.
 */
struct file*
file_dup(struct file *f)
{
  109a00:	53                   	push   %ebx
  109a01:	83 ec 18             	sub    $0x18,%esp
  109a04:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  spinlock_acquire(&ftable.lock);
  109a08:	c7 04 24 e0 23 e1 00 	movl   $0xe123e0,(%esp)
  109a0f:	e8 5c c0 ff ff       	call   105a70 <spinlock_acquire>
  if(f->ref < 1)
  109a14:	8b 43 04             	mov    0x4(%ebx),%eax
  109a17:	85 c0                	test   %eax,%eax
  109a19:	7e 1d                	jle    109a38 <file_dup+0x38>
    KERN_PANIC("file_dup");
  f->ref++;
  109a1b:	83 c0 01             	add    $0x1,%eax
  109a1e:	89 43 04             	mov    %eax,0x4(%ebx)
  spinlock_release(&ftable.lock);
  109a21:	c7 04 24 e0 23 e1 00 	movl   $0xe123e0,(%esp)
  109a28:	e8 c3 c0 ff ff       	call   105af0 <spinlock_release>
  return f;
}
  109a2d:	83 c4 18             	add    $0x18,%esp
  109a30:	89 d8                	mov    %ebx,%eax
  109a32:	5b                   	pop    %ebx
  109a33:	c3                   	ret    
  109a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
struct file*
file_dup(struct file *f)
{
  spinlock_acquire(&ftable.lock);
  if(f->ref < 1)
    KERN_PANIC("file_dup");
  109a38:	c7 44 24 08 7d c9 10 	movl   $0x10c97d,0x8(%esp)
  109a3f:	00 
  109a40:	c7 44 24 04 35 00 00 	movl   $0x35,0x4(%esp)
  109a47:	00 
  109a48:	c7 04 24 86 c9 10 00 	movl   $0x10c986,(%esp)
  109a4f:	e8 2c a7 ff ff       	call   104180 <debug_panic>
  109a54:	8b 43 04             	mov    0x4(%ebx),%eax
  109a57:	eb c2                	jmp    109a1b <file_dup+0x1b>
  109a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00109a60 <file_close>:
/**
 * Close file f.  (Decrement ref count, close when reaches 0.)
 */
void
file_close(struct file *f)
{
  109a60:	57                   	push   %edi
  109a61:	56                   	push   %esi
  109a62:	53                   	push   %ebx
  109a63:	83 ec 10             	sub    $0x10,%esp
  109a66:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  struct file ff;

  spinlock_acquire(&ftable.lock);
  109a6a:	c7 04 24 e0 23 e1 00 	movl   $0xe123e0,(%esp)
  109a71:	e8 fa bf ff ff       	call   105a70 <spinlock_acquire>
  if(f->ref < 1)
  109a76:	8b 43 04             	mov    0x4(%ebx),%eax
  109a79:	85 c0                	test   %eax,%eax
  109a7b:	7e 53                	jle    109ad0 <file_close+0x70>
    KERN_PANIC("file_close");
  if(--f->ref > 0){
  109a7d:	83 e8 01             	sub    $0x1,%eax
  109a80:	85 c0                	test   %eax,%eax
  109a82:	89 43 04             	mov    %eax,0x4(%ebx)
  109a85:	7e 19                	jle    109aa0 <file_close+0x40>
    spinlock_release(&ftable.lock);
  109a87:	c7 44 24 20 e0 23 e1 	movl   $0xe123e0,0x20(%esp)
  109a8e:	00 
  if(ff.type == FD_INODE){
    begin_trans();
    inode_put(ff.ip);
    commit_trans();
  }
}
  109a8f:	83 c4 10             	add    $0x10,%esp
  109a92:	5b                   	pop    %ebx
  109a93:	5e                   	pop    %esi
  109a94:	5f                   	pop    %edi

  spinlock_acquire(&ftable.lock);
  if(f->ref < 1)
    KERN_PANIC("file_close");
  if(--f->ref > 0){
    spinlock_release(&ftable.lock);
  109a95:	e9 56 c0 ff ff       	jmp    105af0 <spinlock_release>
  109a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return;
  }
  ff = *f;
  109aa0:	8b 33                	mov    (%ebx),%esi
  109aa2:	8b 7b 0c             	mov    0xc(%ebx),%edi
  f->ref = 0;
  109aa5:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
  f->type = FD_NONE;
  109aac:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  spinlock_release(&ftable.lock);
  109ab2:	c7 04 24 e0 23 e1 00 	movl   $0xe123e0,(%esp)
  109ab9:	e8 32 c0 ff ff       	call   105af0 <spinlock_release>
  
  if(ff.type == FD_INODE){
  109abe:	83 fe 02             	cmp    $0x2,%esi
  109ac1:	74 35                	je     109af8 <file_close+0x98>
    begin_trans();
    inode_put(ff.ip);
    commit_trans();
  }
}
  109ac3:	83 c4 10             	add    $0x10,%esp
  109ac6:	5b                   	pop    %ebx
  109ac7:	5e                   	pop    %esi
  109ac8:	5f                   	pop    %edi
  109ac9:	c3                   	ret    
  109aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  struct file ff;

  spinlock_acquire(&ftable.lock);
  if(f->ref < 1)
    KERN_PANIC("file_close");
  109ad0:	c7 44 24 08 95 c9 10 	movl   $0x10c995,0x8(%esp)
  109ad7:	00 
  109ad8:	c7 44 24 04 45 00 00 	movl   $0x45,0x4(%esp)
  109adf:	00 
  109ae0:	c7 04 24 86 c9 10 00 	movl   $0x10c986,(%esp)
  109ae7:	e8 94 a6 ff ff       	call   104180 <debug_panic>
  109aec:	8b 43 04             	mov    0x4(%ebx),%eax
  109aef:	eb 8c                	jmp    109a7d <file_close+0x1d>
  109af1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  f->ref = 0;
  f->type = FD_NONE;
  spinlock_release(&ftable.lock);
  
  if(ff.type == FD_INODE){
    begin_trans();
  109af8:	e8 13 ed ff ff       	call   108810 <begin_trans>
    inode_put(ff.ip);
  109afd:	89 3c 24             	mov    %edi,(%esp)
  109b00:	e8 5b f6 ff ff       	call   109160 <inode_put>
    commit_trans();
  }
}
  109b05:	83 c4 10             	add    $0x10,%esp
  109b08:	5b                   	pop    %ebx
  109b09:	5e                   	pop    %esi
  109b0a:	5f                   	pop    %edi
  spinlock_release(&ftable.lock);
  
  if(ff.type == FD_INODE){
    begin_trans();
    inode_put(ff.ip);
    commit_trans();
  109b0b:	e9 60 ed ff ff       	jmp    108870 <commit_trans>

00109b10 <file_stat>:
/**
 * Get metadata about file f.
 */
int
file_stat(struct file *f, struct file_stat *st)
{
  109b10:	53                   	push   %ebx
  109b11:	83 ec 18             	sub    $0x18,%esp
  109b14:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  if(f->type == FD_INODE){
  109b18:	83 3b 02             	cmpl   $0x2,(%ebx)
  109b1b:	75 33                	jne    109b50 <file_stat+0x40>
    inode_lock(f->ip);
  109b1d:	8b 43 0c             	mov    0xc(%ebx),%eax
  109b20:	89 04 24             	mov    %eax,(%esp)
  109b23:	e8 98 f4 ff ff       	call   108fc0 <inode_lock>
    inode_stat(f->ip, st);
  109b28:	8b 44 24 24          	mov    0x24(%esp),%eax
  109b2c:	89 44 24 04          	mov    %eax,0x4(%esp)
  109b30:	8b 43 0c             	mov    0xc(%ebx),%eax
  109b33:	89 04 24             	mov    %eax,(%esp)
  109b36:	e8 c5 f7 ff ff       	call   109300 <inode_stat>
    inode_unlock(f->ip);
  109b3b:	8b 43 0c             	mov    0xc(%ebx),%eax
  109b3e:	89 04 24             	mov    %eax,(%esp)
  109b41:	e8 aa f5 ff ff       	call   1090f0 <inode_unlock>
    return 0;
  }
  return -1;
}
  109b46:	83 c4 18             	add    $0x18,%esp
{
  if(f->type == FD_INODE){
    inode_lock(f->ip);
    inode_stat(f->ip, st);
    inode_unlock(f->ip);
    return 0;
  109b49:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
  109b4b:	5b                   	pop    %ebx
  109b4c:	c3                   	ret    
  109b4d:	8d 76 00             	lea    0x0(%esi),%esi
  109b50:	83 c4 18             	add    $0x18,%esp
    inode_lock(f->ip);
    inode_stat(f->ip, st);
    inode_unlock(f->ip);
    return 0;
  }
  return -1;
  109b53:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  109b58:	5b                   	pop    %ebx
  109b59:	c3                   	ret    
  109b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00109b60 <file_read>:
/**
 * Read from file f.
 */
int
file_read(struct file *f, char *addr, int n)
{
  109b60:	56                   	push   %esi
  int r;

  if(f->readable == 0)
    return -1;
  109b61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
/**
 * Read from file f.
 */
int
file_read(struct file *f, char *addr, int n)
{
  109b66:	53                   	push   %ebx
  109b67:	83 ec 14             	sub    $0x14,%esp
  109b6a:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  int r;

  if(f->readable == 0)
  109b6e:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
  109b72:	74 21                	je     109b95 <file_read+0x35>
    return -1;
  if(f->type == FD_INODE){
  109b74:	83 3b 02             	cmpl   $0x2,(%ebx)
  109b77:	74 27                	je     109ba0 <file_read+0x40>
    if((r = inode_read(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    inode_unlock(f->ip);
    return r;
  }
  KERN_PANIC("file_read");
  109b79:	c7 44 24 08 a0 c9 10 	movl   $0x10c9a0,0x8(%esp)
  109b80:	00 
  109b81:	c7 44 24 04 76 00 00 	movl   $0x76,0x4(%esp)
  109b88:	00 
  109b89:	c7 04 24 86 c9 10 00 	movl   $0x10c986,(%esp)
  109b90:	e8 eb a5 ff ff       	call   104180 <debug_panic>
}
  109b95:	83 c4 14             	add    $0x14,%esp
  109b98:	5b                   	pop    %ebx
  109b99:	5e                   	pop    %esi
  109b9a:	c3                   	ret    
  109b9b:	90                   	nop
  109b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_INODE){
    inode_lock(f->ip);
  109ba0:	8b 43 0c             	mov    0xc(%ebx),%eax
  109ba3:	89 04 24             	mov    %eax,(%esp)
  109ba6:	e8 15 f4 ff ff       	call   108fc0 <inode_lock>
    if((r = inode_read(f->ip, addr, f->off, n)) > 0)
  109bab:	8b 44 24 28          	mov    0x28(%esp),%eax
  109baf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  109bb3:	8b 43 10             	mov    0x10(%ebx),%eax
  109bb6:	89 44 24 08          	mov    %eax,0x8(%esp)
  109bba:	8b 44 24 24          	mov    0x24(%esp),%eax
  109bbe:	89 44 24 04          	mov    %eax,0x4(%esp)
  109bc2:	8b 43 0c             	mov    0xc(%ebx),%eax
  109bc5:	89 04 24             	mov    %eax,(%esp)
  109bc8:	e8 63 f7 ff ff       	call   109330 <inode_read>
  109bcd:	85 c0                	test   %eax,%eax
  109bcf:	89 c6                	mov    %eax,%esi
  109bd1:	7e 03                	jle    109bd6 <file_read+0x76>
      f->off += r;
  109bd3:	01 43 10             	add    %eax,0x10(%ebx)
    inode_unlock(f->ip);
  109bd6:	8b 43 0c             	mov    0xc(%ebx),%eax
  109bd9:	89 04 24             	mov    %eax,(%esp)
  109bdc:	e8 0f f5 ff ff       	call   1090f0 <inode_unlock>
    return r;
  }
  KERN_PANIC("file_read");
}
  109be1:	83 c4 14             	add    $0x14,%esp

  if(f->readable == 0)
    return -1;
  if(f->type == FD_INODE){
    inode_lock(f->ip);
    if((r = inode_read(f->ip, addr, f->off, n)) > 0)
  109be4:	89 f0                	mov    %esi,%eax
      f->off += r;
    inode_unlock(f->ip);
    return r;
  }
  KERN_PANIC("file_read");
}
  109be6:	5b                   	pop    %ebx
  109be7:	5e                   	pop    %esi
  109be8:	c3                   	ret    
  109be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00109bf0 <file_write>:
/**
 * Write to file f.
 */
int
file_write(struct file *f, char *addr, int n)
{
  109bf0:	55                   	push   %ebp
  109bf1:	57                   	push   %edi
  109bf2:	56                   	push   %esi
  109bf3:	53                   	push   %ebx
  109bf4:	83 ec 1c             	sub    $0x1c,%esp
  109bf7:	8b 6c 24 30          	mov    0x30(%esp),%ebp
  int r;

  if(f->writable == 0)
  109bfb:	80 7d 09 00          	cmpb   $0x0,0x9(%ebp)
  109bff:	0f 84 c0 00 00 00    	je     109cc5 <file_write+0xd5>
    return -1;
  if(f->type == FD_INODE){
  109c05:	83 7d 00 02          	cmpl   $0x2,0x0(%ebp)
  109c09:	0f 85 c9 00 00 00    	jne    109cd8 <file_write+0xe8>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since inode_write()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
  109c0f:	8b 44 24 38          	mov    0x38(%esp),%eax
  109c13:	31 db                	xor    %ebx,%ebx
  109c15:	85 c0                	test   %eax,%eax
  109c17:	7f 46                	jg     109c5f <file_write+0x6f>
  109c19:	e9 e2 00 00 00       	jmp    109d00 <file_write+0x110>
  109c1e:	66 90                	xchg   %ax,%ax
        n1 = max;

      begin_trans();
      inode_lock(f->ip);
      if ((r = inode_write(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
  109c20:	01 45 10             	add    %eax,0x10(%ebp)
      inode_unlock(f->ip);
  109c23:	8b 45 0c             	mov    0xc(%ebp),%eax
  109c26:	89 04 24             	mov    %eax,(%esp)
  109c29:	e8 c2 f4 ff ff       	call   1090f0 <inode_unlock>
      commit_trans();
  109c2e:	e8 3d ec ff ff       	call   108870 <commit_trans>

      if(r < 0)
        break;
      if(r != n1)
  109c33:	39 f7                	cmp    %esi,%edi
  109c35:	74 1c                	je     109c53 <file_write+0x63>
        KERN_PANIC("short file_write");
  109c37:	c7 44 24 08 aa c9 10 	movl   $0x10c9aa,0x8(%esp)
  109c3e:	00 
  109c3f:	c7 44 24 04 9b 00 00 	movl   $0x9b,0x4(%esp)
  109c46:	00 
  109c47:	c7 04 24 86 c9 10 00 	movl   $0x10c986,(%esp)
  109c4e:	e8 2d a5 ff ff       	call   104180 <debug_panic>
      i += r;
  109c53:	01 fb                	add    %edi,%ebx
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since inode_write()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
  109c55:	39 5c 24 38          	cmp    %ebx,0x38(%esp)
  109c59:	0f 8e a1 00 00 00    	jle    109d00 <file_write+0x110>
      int n1 = n - i;
  109c5f:	8b 74 24 38          	mov    0x38(%esp),%esi
  109c63:	b8 00 06 00 00       	mov    $0x600,%eax
  109c68:	29 de                	sub    %ebx,%esi
  109c6a:	81 fe 00 06 00 00    	cmp    $0x600,%esi
  109c70:	0f 4f f0             	cmovg  %eax,%esi
      if(n1 > max)
        n1 = max;

      begin_trans();
  109c73:	e8 98 eb ff ff       	call   108810 <begin_trans>
      inode_lock(f->ip);
  109c78:	8b 45 0c             	mov    0xc(%ebp),%eax
  109c7b:	89 04 24             	mov    %eax,(%esp)
  109c7e:	e8 3d f3 ff ff       	call   108fc0 <inode_lock>
      if ((r = inode_write(f->ip, addr + i, f->off, n1)) > 0)
  109c83:	89 74 24 0c          	mov    %esi,0xc(%esp)
  109c87:	8b 45 10             	mov    0x10(%ebp),%eax
  109c8a:	89 44 24 08          	mov    %eax,0x8(%esp)
  109c8e:	8b 44 24 34          	mov    0x34(%esp),%eax
  109c92:	01 d8                	add    %ebx,%eax
  109c94:	89 44 24 04          	mov    %eax,0x4(%esp)
  109c98:	8b 45 0c             	mov    0xc(%ebp),%eax
  109c9b:	89 04 24             	mov    %eax,(%esp)
  109c9e:	e8 9d f7 ff ff       	call   109440 <inode_write>
  109ca3:	85 c0                	test   %eax,%eax
  109ca5:	89 c7                	mov    %eax,%edi
  109ca7:	0f 8f 73 ff ff ff    	jg     109c20 <file_write+0x30>
        f->off += r;
      inode_unlock(f->ip);
  109cad:	8b 45 0c             	mov    0xc(%ebp),%eax
  109cb0:	89 04 24             	mov    %eax,(%esp)
  109cb3:	e8 38 f4 ff ff       	call   1090f0 <inode_unlock>
      commit_trans();
  109cb8:	e8 b3 eb ff ff       	call   108870 <commit_trans>

      if(r < 0)
  109cbd:	85 ff                	test   %edi,%edi
  109cbf:	0f 84 6e ff ff ff    	je     109c33 <file_write+0x43>
      i += r;
    }
    return i == n ? n : -1;
  }
  KERN_PANIC("file_write");
}
  109cc5:	83 c4 1c             	add    $0x1c,%esp
file_write(struct file *f, char *addr, int n)
{
  int r;

  if(f->writable == 0)
    return -1;
  109cc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      i += r;
    }
    return i == n ? n : -1;
  }
  KERN_PANIC("file_write");
}
  109ccd:	5b                   	pop    %ebx
  109cce:	5e                   	pop    %esi
  109ccf:	5f                   	pop    %edi
  109cd0:	5d                   	pop    %ebp
  109cd1:	c3                   	ret    
  109cd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        KERN_PANIC("short file_write");
      i += r;
    }
    return i == n ? n : -1;
  }
  KERN_PANIC("file_write");
  109cd8:	c7 44 24 08 b0 c9 10 	movl   $0x10c9b0,0x8(%esp)
  109cdf:	00 
  109ce0:	c7 44 24 04 a0 00 00 	movl   $0xa0,0x4(%esp)
  109ce7:	00 
  109ce8:	c7 04 24 86 c9 10 00 	movl   $0x10c986,(%esp)
  109cef:	e8 8c a4 ff ff       	call   104180 <debug_panic>
}
  109cf4:	83 c4 1c             	add    $0x1c,%esp
  109cf7:	5b                   	pop    %ebx
  109cf8:	5e                   	pop    %esi
  109cf9:	5f                   	pop    %edi
  109cfa:	5d                   	pop    %ebp
  109cfb:	c3                   	ret    
  109cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        break;
      if(r != n1)
        KERN_PANIC("short file_write");
      i += r;
    }
    return i == n ? n : -1;
  109d00:	3b 5c 24 38          	cmp    0x38(%esp),%ebx
  109d04:	89 d8                	mov    %ebx,%eax
  109d06:	75 bd                	jne    109cc5 <file_write+0xd5>
  }
  KERN_PANIC("file_write");
}
  109d08:	83 c4 1c             	add    $0x1c,%esp
  109d0b:	5b                   	pop    %ebx
  109d0c:	5e                   	pop    %esi
  109d0d:	5f                   	pop    %edi
  109d0e:	5d                   	pop    %ebp
  109d0f:	c3                   	ret    

00109d10 <create.constprop.0>:
  syscall_set_errno(tf, E_DISK_OP);
  return;
}

static struct inode*
create(char *path, short type, short major, short minor)
  109d10:	55                   	push   %ebp
  109d11:	89 d5                	mov    %edx,%ebp
  109d13:	57                   	push   %edi
  109d14:	56                   	push   %esi
  109d15:	53                   	push   %ebx
  109d16:	83 ec 3c             	sub    $0x3c,%esp
{
  uint32_t off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  109d19:	8d 7c 24 22          	lea    0x22(%esp),%edi
  109d1d:	89 7c 24 04          	mov    %edi,0x4(%esp)
  109d21:	89 04 24             	mov    %eax,(%esp)
  109d24:	e8 37 fc ff ff       	call   109960 <nameiparent>
  109d29:	85 c0                	test   %eax,%eax
  109d2b:	89 c3                	mov    %eax,%ebx
  109d2d:	0f 84 dd 00 00 00    	je     109e10 <create.constprop.0+0x100>
    return 0;
  inode_lock(dp);
  109d33:	89 04 24             	mov    %eax,(%esp)
  109d36:	e8 85 f2 ff ff       	call   108fc0 <inode_lock>

  if((ip = dir_lookup(dp, name, &off)) != 0){
  109d3b:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  109d3f:	89 44 24 08          	mov    %eax,0x8(%esp)
  109d43:	89 7c 24 04          	mov    %edi,0x4(%esp)
  109d47:	89 1c 24             	mov    %ebx,(%esp)
  109d4a:	e8 71 f8 ff ff       	call   1095c0 <dir_lookup>
  109d4f:	85 c0                	test   %eax,%eax
  109d51:	89 c6                	mov    %eax,%esi
  109d53:	74 43                	je     109d98 <create.constprop.0+0x88>
    inode_unlockput(dp);
  109d55:	89 1c 24             	mov    %ebx,(%esp)
  109d58:	e8 83 f5 ff ff       	call   1092e0 <inode_unlockput>
    inode_lock(ip);
  109d5d:	89 34 24             	mov    %esi,(%esp)
  109d60:	e8 5b f2 ff ff       	call   108fc0 <inode_lock>
    if(type == T_FILE && ip->type == T_FILE)
  109d65:	66 83 fd 02          	cmp    $0x2,%bp
  109d69:	75 15                	jne    109d80 <create.constprop.0+0x70>
  109d6b:	66 83 7e 10 02       	cmpw   $0x2,0x10(%esi)
  109d70:	89 f0                	mov    %esi,%eax
  109d72:	75 0c                	jne    109d80 <create.constprop.0+0x70>
    KERN_PANIC("create: dir_link");

  inode_unlockput(dp);

  return ip;
}
  109d74:	83 c4 3c             	add    $0x3c,%esp
  109d77:	5b                   	pop    %ebx
  109d78:	5e                   	pop    %esi
  109d79:	5f                   	pop    %edi
  109d7a:	5d                   	pop    %ebp
  109d7b:	c3                   	ret    
  109d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dir_lookup(dp, name, &off)) != 0){
    inode_unlockput(dp);
    inode_lock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    inode_unlockput(ip);
  109d80:	89 34 24             	mov    %esi,(%esp)
  109d83:	e8 58 f5 ff ff       	call   1092e0 <inode_unlockput>
    KERN_PANIC("create: dir_link");

  inode_unlockput(dp);

  return ip;
}
  109d88:	83 c4 3c             	add    $0x3c,%esp
    inode_unlockput(dp);
    inode_lock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    inode_unlockput(ip);
    return 0;
  109d8b:	31 c0                	xor    %eax,%eax
    KERN_PANIC("create: dir_link");

  inode_unlockput(dp);

  return ip;
}
  109d8d:	5b                   	pop    %ebx
  109d8e:	5e                   	pop    %esi
  109d8f:	5f                   	pop    %edi
  109d90:	5d                   	pop    %ebp
  109d91:	c3                   	ret    
  109d92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      return ip;
    inode_unlockput(ip);
    return 0;
  }

  if((ip = inode_alloc(dp->dev, type)) == 0)
  109d98:	0f bf c5             	movswl %bp,%eax
  109d9b:	89 44 24 04          	mov    %eax,0x4(%esp)
  109d9f:	8b 03                	mov    (%ebx),%eax
  109da1:	89 04 24             	mov    %eax,(%esp)
  109da4:	e8 f7 f0 ff ff       	call   108ea0 <inode_alloc>
  109da9:	85 c0                	test   %eax,%eax
  109dab:	89 c6                	mov    %eax,%esi
  109dad:	0f 84 ee 00 00 00    	je     109ea1 <create.constprop.0+0x191>
    KERN_PANIC("create: ialloc");

  inode_lock(ip);
  109db3:	89 34 24             	mov    %esi,(%esp)
  109db6:	e8 05 f2 ff ff       	call   108fc0 <inode_lock>
  ip->major = major;
  109dbb:	31 c0                	xor    %eax,%eax
  ip->minor = minor;
  109dbd:	31 d2                	xor    %edx,%edx
  ip->nlink = 1;
  109dbf:	b9 01 00 00 00       	mov    $0x1,%ecx

  if((ip = inode_alloc(dp->dev, type)) == 0)
    KERN_PANIC("create: ialloc");

  inode_lock(ip);
  ip->major = major;
  109dc4:	66 89 46 12          	mov    %ax,0x12(%esi)
  ip->minor = minor;
  109dc8:	66 89 56 14          	mov    %dx,0x14(%esi)
  ip->nlink = 1;
  109dcc:	66 89 4e 16          	mov    %cx,0x16(%esi)
  inode_update(ip);
  109dd0:	89 34 24             	mov    %esi,(%esp)
  109dd3:	e8 68 ef ff ff       	call   108d40 <inode_update>

  if(type == T_DIR){  // Create . and .. entries.
  109dd8:	66 83 fd 01          	cmp    $0x1,%bp
  109ddc:	74 3a                	je     109e18 <create.constprop.0+0x108>
    if(   dir_link(ip, ".", ip->inum) < 0
       || dir_link(ip, "..", dp->inum) < 0)
      KERN_PANIC("create dots");
  }

  if(dir_link(dp, name, ip->inum) < 0)
  109dde:	8b 46 04             	mov    0x4(%esi),%eax
  109de1:	89 7c 24 04          	mov    %edi,0x4(%esp)
  109de5:	89 1c 24             	mov    %ebx,(%esp)
  109de8:	89 44 24 08          	mov    %eax,0x8(%esp)
  109dec:	e8 bf f8 ff ff       	call   1096b0 <dir_link>
  109df1:	85 c0                	test   %eax,%eax
  109df3:	0f 88 87 00 00 00    	js     109e80 <create.constprop.0+0x170>
    KERN_PANIC("create: dir_link");

  inode_unlockput(dp);
  109df9:	89 1c 24             	mov    %ebx,(%esp)
  109dfc:	e8 df f4 ff ff       	call   1092e0 <inode_unlockput>

  return ip;
}
  109e01:	83 c4 3c             	add    $0x3c,%esp
  }

  if(dir_link(dp, name, ip->inum) < 0)
    KERN_PANIC("create: dir_link");

  inode_unlockput(dp);
  109e04:	89 f0                	mov    %esi,%eax

  return ip;
}
  109e06:	5b                   	pop    %ebx
  109e07:	5e                   	pop    %esi
  109e08:	5f                   	pop    %edi
  109e09:	5d                   	pop    %ebp
  109e0a:	c3                   	ret    
  109e0b:	90                   	nop
  109e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint32_t off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
  109e10:	31 c0                	xor    %eax,%eax
  109e12:	e9 5d ff ff ff       	jmp    109d74 <create.constprop.0+0x64>
  109e17:	90                   	nop
  ip->minor = minor;
  ip->nlink = 1;
  inode_update(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
  109e18:	66 83 43 16 01       	addw   $0x1,0x16(%ebx)
    inode_update(dp);
  109e1d:	89 1c 24             	mov    %ebx,(%esp)
  109e20:	e8 1b ef ff ff       	call   108d40 <inode_update>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(   dir_link(ip, ".", ip->inum) < 0
  109e25:	8b 46 04             	mov    0x4(%esi),%eax
  109e28:	c7 44 24 04 e9 c9 10 	movl   $0x10c9e9,0x4(%esp)
  109e2f:	00 
  109e30:	89 34 24             	mov    %esi,(%esp)
  109e33:	89 44 24 08          	mov    %eax,0x8(%esp)
  109e37:	e8 74 f8 ff ff       	call   1096b0 <dir_link>
  109e3c:	85 c0                	test   %eax,%eax
  109e3e:	78 1b                	js     109e5b <create.constprop.0+0x14b>
       || dir_link(ip, "..", dp->inum) < 0)
  109e40:	8b 43 04             	mov    0x4(%ebx),%eax
  109e43:	c7 44 24 04 e8 c9 10 	movl   $0x10c9e8,0x4(%esp)
  109e4a:	00 
  109e4b:	89 34 24             	mov    %esi,(%esp)
  109e4e:	89 44 24 08          	mov    %eax,0x8(%esp)
  109e52:	e8 59 f8 ff ff       	call   1096b0 <dir_link>
  109e57:	85 c0                	test   %eax,%eax
  109e59:	79 83                	jns    109dde <create.constprop.0+0xce>
      KERN_PANIC("create dots");
  109e5b:	c7 44 24 08 dc c9 10 	movl   $0x10c9dc,0x8(%esp)
  109e62:	00 
  109e63:	c7 44 24 04 48 01 00 	movl   $0x148,0x4(%esp)
  109e6a:	00 
  109e6b:	c7 04 24 ca c9 10 00 	movl   $0x10c9ca,(%esp)
  109e72:	e8 09 a3 ff ff       	call   104180 <debug_panic>
  109e77:	e9 62 ff ff ff       	jmp    109dde <create.constprop.0+0xce>
  109e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  if(dir_link(dp, name, ip->inum) < 0)
    KERN_PANIC("create: dir_link");
  109e80:	c7 44 24 08 eb c9 10 	movl   $0x10c9eb,0x8(%esp)
  109e87:	00 
  109e88:	c7 44 24 04 4c 01 00 	movl   $0x14c,0x4(%esp)
  109e8f:	00 
  109e90:	c7 04 24 ca c9 10 00 	movl   $0x10c9ca,(%esp)
  109e97:	e8 e4 a2 ff ff       	call   104180 <debug_panic>
  109e9c:	e9 58 ff ff ff       	jmp    109df9 <create.constprop.0+0xe9>
    inode_unlockput(ip);
    return 0;
  }

  if((ip = inode_alloc(dp->dev, type)) == 0)
    KERN_PANIC("create: ialloc");
  109ea1:	c7 44 24 08 bb c9 10 	movl   $0x10c9bb,0x8(%esp)
  109ea8:	00 
  109ea9:	c7 44 24 04 3a 01 00 	movl   $0x13a,0x4(%esp)
  109eb0:	00 
  109eb1:	c7 04 24 ca c9 10 00 	movl   $0x10c9ca,(%esp)
  109eb8:	e8 c3 a2 ff ff       	call   104180 <debug_panic>
  109ebd:	e9 f1 fe ff ff       	jmp    109db3 <create.constprop.0+0xa3>
  109ec2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  109ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00109ed0 <sys_read>:
 * Return Value: Upon successful completion, read() shall return a non-negative
 * integer indicating the number of bytes actually read. Otherwise, the
 * functions shall return -1 and set errno E_BADF to indicate the error.
 */
void sys_read(tf_t *tf)
{
  109ed0:	55                   	push   %ebp
  109ed1:	57                   	push   %edi
  109ed2:	56                   	push   %esi
  109ed3:	53                   	push   %ebx
  109ed4:	83 ec 1c             	sub    $0x1c,%esp
  109ed7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  struct file *f;
  int fd;
  size_t n;
  int read = 0;

  fd = syscall_get_arg2(tf);
  109edb:	89 1c 24             	mov    %ebx,(%esp)
  109ede:	e8 1d d5 ff ff       	call   107400 <syscall_get_arg2>
  n = syscall_get_arg4(tf);
  109ee3:	89 1c 24             	mov    %ebx,(%esp)
  struct file *f;
  int fd;
  size_t n;
  int read = 0;

  fd = syscall_get_arg2(tf);
  109ee6:	89 c7                	mov    %eax,%edi
  n = syscall_get_arg4(tf);
  109ee8:	e8 33 d5 ff ff       	call   107420 <syscall_get_arg4>
  109eed:	89 c6                	mov    %eax,%esi

  f = tcb_get_openfiles(get_curid())[fd];
  109eef:	e8 7c d0 ff ff       	call   106f70 <get_curid>
  109ef4:	89 04 24             	mov    %eax,(%esp)
  109ef7:	e8 b4 cc ff ff       	call   106bb0 <tcb_get_openfiles>
  if (n < 0){
    syscall_set_retval1(tf, -1);
    syscall_set_errno(tf, E_BADF);
  }

  if ((read = file_read(f, fbuf, n)) < 0){
  109efc:	89 74 24 08          	mov    %esi,0x8(%esp)
  109f00:	c7 44 24 04 c0 2b e1 	movl   $0xe12bc0,0x4(%esp)
  109f07:	00 
  109f08:	8b 04 b8             	mov    (%eax,%edi,4),%eax
  109f0b:	89 04 24             	mov    %eax,(%esp)
  109f0e:	e8 4d fc ff ff       	call   109b60 <file_read>
  109f13:	85 c0                	test   %eax,%eax
  109f15:	89 c7                	mov    %eax,%edi
  109f17:	78 4f                	js     109f68 <sys_read+0x98>
    syscall_set_retval1(tf, -1);
    syscall_set_errno(tf, E_BADF);
  }
  else {
    pt_copyout(fbuf, get_curid(), syscall_get_arg3(tf), n);
  109f19:	89 1c 24             	mov    %ebx,(%esp)
  109f1c:	e8 ef d4 ff ff       	call   107410 <syscall_get_arg3>
  109f21:	89 c5                	mov    %eax,%ebp
  109f23:	e8 48 d0 ff ff       	call   106f70 <get_curid>
  109f28:	89 74 24 0c          	mov    %esi,0xc(%esp)
  109f2c:	89 6c 24 08          	mov    %ebp,0x8(%esp)
  109f30:	c7 04 24 c0 2b e1 00 	movl   $0xe12bc0,(%esp)
  109f37:	89 44 24 04          	mov    %eax,0x4(%esp)
  109f3b:	e8 e0 b4 ff ff       	call   105420 <pt_copyout>
    syscall_set_retval1(tf, read);
  109f40:	89 7c 24 04          	mov    %edi,0x4(%esp)
  109f44:	89 1c 24             	mov    %ebx,(%esp)
  109f47:	e8 44 d5 ff ff       	call   107490 <syscall_set_retval1>
    syscall_set_errno(tf, E_SUCC);
  109f4c:	89 1c 24             	mov    %ebx,(%esp)
  109f4f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  109f56:	00 
  109f57:	e8 24 d5 ff ff       	call   107480 <syscall_set_errno>
  }
}
  109f5c:	83 c4 1c             	add    $0x1c,%esp
  109f5f:	5b                   	pop    %ebx
  109f60:	5e                   	pop    %esi
  109f61:	5f                   	pop    %edi
  109f62:	5d                   	pop    %ebp
  109f63:	c3                   	ret    
  109f64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    syscall_set_retval1(tf, -1);
    syscall_set_errno(tf, E_BADF);
  }

  if ((read = file_read(f, fbuf, n)) < 0){
    syscall_set_retval1(tf, -1);
  109f68:	89 1c 24             	mov    %ebx,(%esp)
  109f6b:	c7 44 24 04 ff ff ff 	movl   $0xffffffff,0x4(%esp)
  109f72:	ff 
  109f73:	e8 18 d5 ff ff       	call   107490 <syscall_set_retval1>
    syscall_set_errno(tf, E_BADF);
  109f78:	89 1c 24             	mov    %ebx,(%esp)
  109f7b:	c7 44 24 04 1d 00 00 	movl   $0x1d,0x4(%esp)
  109f82:	00 
  109f83:	e8 f8 d4 ff ff       	call   107480 <syscall_set_errno>
  else {
    pt_copyout(fbuf, get_curid(), syscall_get_arg3(tf), n);
    syscall_set_retval1(tf, read);
    syscall_set_errno(tf, E_SUCC);
  }
}
  109f88:	83 c4 1c             	add    $0x1c,%esp
  109f8b:	5b                   	pop    %ebx
  109f8c:	5e                   	pop    %esi
  109f8d:	5f                   	pop    %edi
  109f8e:	5d                   	pop    %ebp
  109f8f:	c3                   	ret    

00109f90 <sys_write>:
 * written to the file associated with f. This number shall never be greater
 * than nbyte. Otherwise, -1 shall be returned and errno E_BADF set to indicate the
 * error.
 */
void sys_write(tf_t *tf)
{
  109f90:	55                   	push   %ebp
  109f91:	57                   	push   %edi
  109f92:	56                   	push   %esi
  109f93:	53                   	push   %ebx
  109f94:	83 ec 1c             	sub    $0x1c,%esp
  109f97:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  struct file *f;
  int fd;
  size_t n;

  fd = syscall_get_arg2(tf);
  109f9b:	89 1c 24             	mov    %ebx,(%esp)
  109f9e:	e8 5d d4 ff ff       	call   107400 <syscall_get_arg2>
  n = syscall_get_arg4(tf);
  109fa3:	89 1c 24             	mov    %ebx,(%esp)
{
  struct file *f;
  int fd;
  size_t n;

  fd = syscall_get_arg2(tf);
  109fa6:	89 c7                	mov    %eax,%edi
  n = syscall_get_arg4(tf);
  109fa8:	e8 73 d4 ff ff       	call   107420 <syscall_get_arg4>
  pt_copyin(get_curid(), syscall_get_arg3(tf), fbuf, n);
  109fad:	89 1c 24             	mov    %ebx,(%esp)
  struct file *f;
  int fd;
  size_t n;

  fd = syscall_get_arg2(tf);
  n = syscall_get_arg4(tf);
  109fb0:	89 c6                	mov    %eax,%esi
  pt_copyin(get_curid(), syscall_get_arg3(tf), fbuf, n);
  109fb2:	e8 59 d4 ff ff       	call   107410 <syscall_get_arg3>
  109fb7:	89 c5                	mov    %eax,%ebp
  109fb9:	e8 b2 cf ff ff       	call   106f70 <get_curid>
  109fbe:	89 74 24 0c          	mov    %esi,0xc(%esp)
  109fc2:	c7 44 24 08 c0 2b e1 	movl   $0xe12bc0,0x8(%esp)
  109fc9:	00 
  109fca:	89 6c 24 04          	mov    %ebp,0x4(%esp)
  109fce:	89 04 24             	mov    %eax,(%esp)
  109fd1:	e8 5a b3 ff ff       	call   105330 <pt_copyin>

  f = tcb_get_openfiles(get_curid())[fd];
  109fd6:	e8 95 cf ff ff       	call   106f70 <get_curid>
  109fdb:	89 04 24             	mov    %eax,(%esp)
  109fde:	e8 cd cb ff ff       	call   106bb0 <tcb_get_openfiles>
  
  if (file_write(f, fbuf, n) < 0 || n < 0){
  109fe3:	89 74 24 08          	mov    %esi,0x8(%esp)
  109fe7:	c7 44 24 04 c0 2b e1 	movl   $0xe12bc0,0x4(%esp)
  109fee:	00 
  109fef:	8b 04 b8             	mov    (%eax,%edi,4),%eax
  109ff2:	89 04 24             	mov    %eax,(%esp)
  109ff5:	e8 f6 fb ff ff       	call   109bf0 <file_write>
  109ffa:	85 c0                	test   %eax,%eax
  109ffc:	78 2a                	js     10a028 <sys_write+0x98>
    syscall_set_retval1(tf, -1);
    syscall_set_errno(tf, E_BADF);
  } else {
    syscall_set_retval1(tf, n);
  109ffe:	89 74 24 04          	mov    %esi,0x4(%esp)
  10a002:	89 1c 24             	mov    %ebx,(%esp)
  10a005:	e8 86 d4 ff ff       	call   107490 <syscall_set_retval1>
    syscall_set_errno(tf, E_SUCC);
  10a00a:	89 1c 24             	mov    %ebx,(%esp)
  10a00d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10a014:	00 
  10a015:	e8 66 d4 ff ff       	call   107480 <syscall_set_errno>
  }
}
  10a01a:	83 c4 1c             	add    $0x1c,%esp
  10a01d:	5b                   	pop    %ebx
  10a01e:	5e                   	pop    %esi
  10a01f:	5f                   	pop    %edi
  10a020:	5d                   	pop    %ebp
  10a021:	c3                   	ret    
  10a022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  pt_copyin(get_curid(), syscall_get_arg3(tf), fbuf, n);

  f = tcb_get_openfiles(get_curid())[fd];
  
  if (file_write(f, fbuf, n) < 0 || n < 0){
    syscall_set_retval1(tf, -1);
  10a028:	89 1c 24             	mov    %ebx,(%esp)
  10a02b:	c7 44 24 04 ff ff ff 	movl   $0xffffffff,0x4(%esp)
  10a032:	ff 
  10a033:	e8 58 d4 ff ff       	call   107490 <syscall_set_retval1>
    syscall_set_errno(tf, E_BADF);
  10a038:	89 1c 24             	mov    %ebx,(%esp)
  10a03b:	c7 44 24 04 1d 00 00 	movl   $0x1d,0x4(%esp)
  10a042:	00 
  10a043:	e8 38 d4 ff ff       	call   107480 <syscall_set_errno>
  } else {
    syscall_set_retval1(tf, n);
    syscall_set_errno(tf, E_SUCC);
  }
}
  10a048:	83 c4 1c             	add    $0x1c,%esp
  10a04b:	5b                   	pop    %ebx
  10a04c:	5e                   	pop    %esi
  10a04d:	5f                   	pop    %edi
  10a04e:	5d                   	pop    %ebp
  10a04f:	c3                   	ret    

0010a050 <sys_close>:
/**
 * Return Value: Upon successful completion, 0 shall be returned; otherwise, -1
 * shall be returned and errno E_BADF set to indicate the error.
 */
void sys_close(tf_t *tf)
{
  10a050:	57                   	push   %edi
  10a051:	56                   	push   %esi
  10a052:	53                   	push   %ebx
  10a053:	83 ec 10             	sub    $0x10,%esp
  10a056:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  int fd;
  struct file *f;

  fd = syscall_get_arg2(tf);
  10a05a:	89 1c 24             	mov    %ebx,(%esp)
  10a05d:	e8 9e d3 ff ff       	call   107400 <syscall_get_arg2>
  10a062:	89 c6                	mov    %eax,%esi
  f = tcb_get_openfiles(get_curid())[fd];
  10a064:	e8 07 cf ff ff       	call   106f70 <get_curid>
  10a069:	89 04 24             	mov    %eax,(%esp)
  10a06c:	e8 3f cb ff ff       	call   106bb0 <tcb_get_openfiles>

  if (fd < 0){
  10a071:	85 f6                	test   %esi,%esi
{
  int fd;
  struct file *f;

  fd = syscall_get_arg2(tf);
  f = tcb_get_openfiles(get_curid())[fd];
  10a073:	8b 3c b0             	mov    (%eax,%esi,4),%edi

  if (fd < 0){
  10a076:	78 48                	js     10a0c0 <sys_close+0x70>
    syscall_set_retval1(tf, -1);
    syscall_set_errno(tf, E_BADF);
  }
  
  tcb_set_openfiles(get_curid(), fd, 0);
  10a078:	e8 f3 ce ff ff       	call   106f70 <get_curid>
  10a07d:	89 74 24 04          	mov    %esi,0x4(%esp)
  10a081:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  10a088:	00 
  10a089:	89 04 24             	mov    %eax,(%esp)
  10a08c:	e8 2f cb ff ff       	call   106bc0 <tcb_set_openfiles>

  file_close(f);
  10a091:	89 3c 24             	mov    %edi,(%esp)
  10a094:	e8 c7 f9 ff ff       	call   109a60 <file_close>
  syscall_set_retval1(tf, 0);
  10a099:	89 1c 24             	mov    %ebx,(%esp)
  10a09c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10a0a3:	00 
  10a0a4:	e8 e7 d3 ff ff       	call   107490 <syscall_set_retval1>
  syscall_set_errno(tf, E_SUCC);
  10a0a9:	89 1c 24             	mov    %ebx,(%esp)
  10a0ac:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10a0b3:	00 
  10a0b4:	e8 c7 d3 ff ff       	call   107480 <syscall_set_errno>
}
  10a0b9:	83 c4 10             	add    $0x10,%esp
  10a0bc:	5b                   	pop    %ebx
  10a0bd:	5e                   	pop    %esi
  10a0be:	5f                   	pop    %edi
  10a0bf:	c3                   	ret    

  fd = syscall_get_arg2(tf);
  f = tcb_get_openfiles(get_curid())[fd];

  if (fd < 0){
    syscall_set_retval1(tf, -1);
  10a0c0:	c7 44 24 04 ff ff ff 	movl   $0xffffffff,0x4(%esp)
  10a0c7:	ff 
  10a0c8:	89 1c 24             	mov    %ebx,(%esp)
  10a0cb:	e8 c0 d3 ff ff       	call   107490 <syscall_set_retval1>
    syscall_set_errno(tf, E_BADF);
  10a0d0:	c7 44 24 04 1d 00 00 	movl   $0x1d,0x4(%esp)
  10a0d7:	00 
  10a0d8:	89 1c 24             	mov    %ebx,(%esp)
  10a0db:	e8 a0 d3 ff ff       	call   107480 <syscall_set_errno>
  10a0e0:	eb 96                	jmp    10a078 <sys_close+0x28>
  10a0e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10a0e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

0010a0f0 <sys_fstat>:
/**
 * Return Value: Upon successful completion, 0 shall be returned. Otherwise, -1
 * shall be returned and errno E_BADF set to indicate the error.
 */
void sys_fstat(tf_t *tf)
{
  10a0f0:	57                   	push   %edi
  10a0f1:	56                   	push   %esi
  10a0f2:	53                   	push   %ebx
  10a0f3:	83 ec 30             	sub    $0x30,%esp
  10a0f6:	8b 5c 24 40          	mov    0x40(%esp),%ebx

  fd = syscall_get_arg2(tf);

  f = tcb_get_openfiles(get_curid())[fd];  
  
  if (file_stat(f, &st) < 0) {
  10a0fa:	8d 74 24 1c          	lea    0x1c(%esp),%esi
{
  int fd;
  struct file *f;
  struct file_stat st;

  fd = syscall_get_arg2(tf);
  10a0fe:	89 1c 24             	mov    %ebx,(%esp)
  10a101:	e8 fa d2 ff ff       	call   107400 <syscall_get_arg2>
  10a106:	89 c7                	mov    %eax,%edi

  f = tcb_get_openfiles(get_curid())[fd];  
  10a108:	e8 63 ce ff ff       	call   106f70 <get_curid>
  10a10d:	89 04 24             	mov    %eax,(%esp)
  10a110:	e8 9b ca ff ff       	call   106bb0 <tcb_get_openfiles>
  
  if (file_stat(f, &st) < 0) {
  10a115:	89 74 24 04          	mov    %esi,0x4(%esp)
  10a119:	8b 04 b8             	mov    (%eax,%edi,4),%eax
  10a11c:	89 04 24             	mov    %eax,(%esp)
  10a11f:	e8 ec f9 ff ff       	call   109b10 <file_stat>
  10a124:	85 c0                	test   %eax,%eax
  10a126:	78 50                	js     10a178 <sys_fstat+0x88>
    syscall_set_retval1(tf, -1);
    syscall_set_errno(tf, E_BADF);
  } else {
    pt_copyout(syscall_get_arg3(tf), get_curid(), &st, (sizeof(st)));
  10a128:	e8 43 ce ff ff       	call   106f70 <get_curid>
  10a12d:	89 1c 24             	mov    %ebx,(%esp)
  10a130:	89 c7                	mov    %eax,%edi
  10a132:	e8 d9 d2 ff ff       	call   107410 <syscall_get_arg3>
  10a137:	89 74 24 08          	mov    %esi,0x8(%esp)
  10a13b:	89 7c 24 04          	mov    %edi,0x4(%esp)
  10a13f:	c7 44 24 0c 14 00 00 	movl   $0x14,0xc(%esp)
  10a146:	00 
  10a147:	89 04 24             	mov    %eax,(%esp)
  10a14a:	e8 d1 b2 ff ff       	call   105420 <pt_copyout>
    syscall_set_retval1(tf, 0);
  10a14f:	89 1c 24             	mov    %ebx,(%esp)
  10a152:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10a159:	00 
  10a15a:	e8 31 d3 ff ff       	call   107490 <syscall_set_retval1>
    syscall_set_errno(tf, E_SUCC);
  10a15f:	89 1c 24             	mov    %ebx,(%esp)
  10a162:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10a169:	00 
  10a16a:	e8 11 d3 ff ff       	call   107480 <syscall_set_errno>
  }
}
  10a16f:	83 c4 30             	add    $0x30,%esp
  10a172:	5b                   	pop    %ebx
  10a173:	5e                   	pop    %esi
  10a174:	5f                   	pop    %edi
  10a175:	c3                   	ret    
  10a176:	66 90                	xchg   %ax,%ax
  fd = syscall_get_arg2(tf);

  f = tcb_get_openfiles(get_curid())[fd];  
  
  if (file_stat(f, &st) < 0) {
    syscall_set_retval1(tf, -1);
  10a178:	89 1c 24             	mov    %ebx,(%esp)
  10a17b:	c7 44 24 04 ff ff ff 	movl   $0xffffffff,0x4(%esp)
  10a182:	ff 
  10a183:	e8 08 d3 ff ff       	call   107490 <syscall_set_retval1>
    syscall_set_errno(tf, E_BADF);
  10a188:	89 1c 24             	mov    %ebx,(%esp)
  10a18b:	c7 44 24 04 1d 00 00 	movl   $0x1d,0x4(%esp)
  10a192:	00 
  10a193:	e8 e8 d2 ff ff       	call   107480 <syscall_set_errno>
  } else {
    pt_copyout(syscall_get_arg3(tf), get_curid(), &st, (sizeof(st)));
    syscall_set_retval1(tf, 0);
    syscall_set_errno(tf, E_SUCC);
  }
}
  10a198:	83 c4 30             	add    $0x30,%esp
  10a19b:	5b                   	pop    %ebx
  10a19c:	5e                   	pop    %esi
  10a19d:	5f                   	pop    %edi
  10a19e:	c3                   	ret    
  10a19f:	90                   	nop

0010a1a0 <sys_link>:

/**
 * Create the path new as a link to the same inode as old.
 */
void sys_link(tf_t *tf)
{
  10a1a0:	55                   	push   %ebp
  10a1a1:	57                   	push   %edi
  10a1a2:	56                   	push   %esi
  10a1a3:	53                   	push   %ebx
  10a1a4:	81 ec 2c 01 00 00    	sub    $0x12c,%esp
  10a1aa:	8b b4 24 40 01 00 00 	mov    0x140(%esp),%esi
  char name[DIRSIZ], new[128], old[128];
  struct inode *dp, *ip;

  pt_copyin(get_curid(), syscall_get_arg2(tf), old, 128);
  10a1b1:	8d 9c 24 a0 00 00 00 	lea    0xa0(%esp),%ebx
  10a1b8:	89 34 24             	mov    %esi,(%esp)
  10a1bb:	e8 40 d2 ff ff       	call   107400 <syscall_get_arg2>
  10a1c0:	89 c7                	mov    %eax,%edi
  10a1c2:	e8 a9 cd ff ff       	call   106f70 <get_curid>
  10a1c7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  10a1cb:	89 7c 24 04          	mov    %edi,0x4(%esp)
  pt_copyin(get_curid(), syscall_get_arg3(tf), new, 128);
  10a1cf:	8d 7c 24 20          	lea    0x20(%esp),%edi
void sys_link(tf_t *tf)
{
  char name[DIRSIZ], new[128], old[128];
  struct inode *dp, *ip;

  pt_copyin(get_curid(), syscall_get_arg2(tf), old, 128);
  10a1d3:	c7 44 24 0c 80 00 00 	movl   $0x80,0xc(%esp)
  10a1da:	00 
  10a1db:	89 04 24             	mov    %eax,(%esp)
  10a1de:	e8 4d b1 ff ff       	call   105330 <pt_copyin>
  pt_copyin(get_curid(), syscall_get_arg3(tf), new, 128);
  10a1e3:	89 34 24             	mov    %esi,(%esp)
  10a1e6:	e8 25 d2 ff ff       	call   107410 <syscall_get_arg3>
  10a1eb:	89 c5                	mov    %eax,%ebp
  10a1ed:	e8 7e cd ff ff       	call   106f70 <get_curid>
  10a1f2:	c7 44 24 0c 80 00 00 	movl   $0x80,0xc(%esp)
  10a1f9:	00 
  10a1fa:	89 7c 24 08          	mov    %edi,0x8(%esp)
  10a1fe:	89 6c 24 04          	mov    %ebp,0x4(%esp)
  10a202:	89 04 24             	mov    %eax,(%esp)
  10a205:	e8 26 b1 ff ff       	call   105330 <pt_copyin>

  if((ip = namei(old)) == 0){
  10a20a:	89 1c 24             	mov    %ebx,(%esp)
  10a20d:	e8 2e f7 ff ff       	call   109940 <namei>
  10a212:	85 c0                	test   %eax,%eax
  10a214:	89 c3                	mov    %eax,%ebx
  10a216:	0f 84 d4 00 00 00    	je     10a2f0 <sys_link+0x150>
    syscall_set_errno(tf, E_NEXIST);
    return;
  }
  
  begin_trans();
  10a21c:	e8 ef e5 ff ff       	call   108810 <begin_trans>

  inode_lock(ip);
  10a221:	89 1c 24             	mov    %ebx,(%esp)
  10a224:	e8 97 ed ff ff       	call   108fc0 <inode_lock>
  if(ip->type == T_DIR){
  10a229:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
  10a22e:	74 56                	je     10a286 <sys_link+0xe6>
    commit_trans();
    syscall_set_errno(tf, E_DISK_OP);
    return;
  }

  ip->nlink++;
  10a230:	66 83 43 16 01       	addw   $0x1,0x16(%ebx)
  inode_update(ip);
  inode_unlock(ip);

  if((dp = nameiparent(new, name)) == 0)
  10a235:	8d 6c 24 12          	lea    0x12(%esp),%ebp
    syscall_set_errno(tf, E_DISK_OP);
    return;
  }

  ip->nlink++;
  inode_update(ip);
  10a239:	89 1c 24             	mov    %ebx,(%esp)
  10a23c:	e8 ff ea ff ff       	call   108d40 <inode_update>
  inode_unlock(ip);
  10a241:	89 1c 24             	mov    %ebx,(%esp)
  10a244:	e8 a7 ee ff ff       	call   1090f0 <inode_unlock>

  if((dp = nameiparent(new, name)) == 0)
  10a249:	89 3c 24             	mov    %edi,(%esp)
  10a24c:	89 6c 24 04          	mov    %ebp,0x4(%esp)
  10a250:	e8 0b f7 ff ff       	call   109960 <nameiparent>
  10a255:	85 c0                	test   %eax,%eax
  10a257:	89 c7                	mov    %eax,%edi
  10a259:	74 16                	je     10a271 <sys_link+0xd1>
    goto bad;
  inode_lock(dp);
  10a25b:	89 04 24             	mov    %eax,(%esp)
  10a25e:	e8 5d ed ff ff       	call   108fc0 <inode_lock>
  if(   dp->dev != ip->dev
  10a263:	8b 03                	mov    (%ebx),%eax
  10a265:	39 07                	cmp    %eax,(%edi)
  10a267:	74 47                	je     10a2b0 <sys_link+0x110>
     || dir_link(dp, name, ip->inum) < 0){
    inode_unlockput(dp);
  10a269:	89 3c 24             	mov    %edi,(%esp)
  10a26c:	e8 6f f0 ff ff       	call   1092e0 <inode_unlockput>

  syscall_set_errno(tf, E_SUCC);
  return;

bad:
  inode_lock(ip);
  10a271:	89 1c 24             	mov    %ebx,(%esp)
  10a274:	e8 47 ed ff ff       	call   108fc0 <inode_lock>
  ip->nlink--;
  10a279:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  inode_update(ip);
  10a27e:	89 1c 24             	mov    %ebx,(%esp)
  10a281:	e8 ba ea ff ff       	call   108d40 <inode_update>
  inode_unlockput(ip);
  10a286:	89 1c 24             	mov    %ebx,(%esp)
  10a289:	e8 52 f0 ff ff       	call   1092e0 <inode_unlockput>
  commit_trans();
  10a28e:	e8 dd e5 ff ff       	call   108870 <commit_trans>
  syscall_set_errno(tf, E_DISK_OP);
  10a293:	c7 44 24 04 0d 00 00 	movl   $0xd,0x4(%esp)
  10a29a:	00 
  10a29b:	89 34 24             	mov    %esi,(%esp)
  10a29e:	e8 dd d1 ff ff       	call   107480 <syscall_set_errno>
  return;
}
  10a2a3:	81 c4 2c 01 00 00    	add    $0x12c,%esp
  10a2a9:	5b                   	pop    %ebx
  10a2aa:	5e                   	pop    %esi
  10a2ab:	5f                   	pop    %edi
  10a2ac:	5d                   	pop    %ebp
  10a2ad:	c3                   	ret    
  10a2ae:	66 90                	xchg   %ax,%ax

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  inode_lock(dp);
  if(   dp->dev != ip->dev
     || dir_link(dp, name, ip->inum) < 0){
  10a2b0:	8b 43 04             	mov    0x4(%ebx),%eax
  10a2b3:	89 6c 24 04          	mov    %ebp,0x4(%esp)
  10a2b7:	89 3c 24             	mov    %edi,(%esp)
  10a2ba:	89 44 24 08          	mov    %eax,0x8(%esp)
  10a2be:	e8 ed f3 ff ff       	call   1096b0 <dir_link>
  10a2c3:	85 c0                	test   %eax,%eax
  10a2c5:	78 a2                	js     10a269 <sys_link+0xc9>
    inode_unlockput(dp);
    goto bad;
  }
  inode_unlockput(dp);
  10a2c7:	89 3c 24             	mov    %edi,(%esp)
  10a2ca:	e8 11 f0 ff ff       	call   1092e0 <inode_unlockput>
  inode_put(ip);
  10a2cf:	89 1c 24             	mov    %ebx,(%esp)
  10a2d2:	e8 89 ee ff ff       	call   109160 <inode_put>

  commit_trans();
  10a2d7:	e8 94 e5 ff ff       	call   108870 <commit_trans>

  syscall_set_errno(tf, E_SUCC);
  10a2dc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10a2e3:	00 
  10a2e4:	89 34 24             	mov    %esi,(%esp)
  10a2e7:	e8 94 d1 ff ff       	call   107480 <syscall_set_errno>
  return;
  10a2ec:	eb b5                	jmp    10a2a3 <sys_link+0x103>
  10a2ee:	66 90                	xchg   %ax,%ax

  pt_copyin(get_curid(), syscall_get_arg2(tf), old, 128);
  pt_copyin(get_curid(), syscall_get_arg3(tf), new, 128);

  if((ip = namei(old)) == 0){
    syscall_set_errno(tf, E_NEXIST);
  10a2f0:	89 34 24             	mov    %esi,(%esp)
  10a2f3:	c7 44 24 04 1a 00 00 	movl   $0x1a,0x4(%esp)
  10a2fa:	00 
  10a2fb:	e8 80 d1 ff ff       	call   107480 <syscall_set_errno>
  inode_update(ip);
  inode_unlockput(ip);
  commit_trans();
  syscall_set_errno(tf, E_DISK_OP);
  return;
}
  10a300:	81 c4 2c 01 00 00    	add    $0x12c,%esp
  10a306:	5b                   	pop    %ebx
  10a307:	5e                   	pop    %esi
  10a308:	5f                   	pop    %edi
  10a309:	5d                   	pop    %ebp
  10a30a:	c3                   	ret    
  10a30b:	90                   	nop
  10a30c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

0010a310 <sys_unlink>:
  }
  return 1;
}

void sys_unlink(tf_t *tf)
{
  10a310:	55                   	push   %ebp
  10a311:	57                   	push   %edi
  10a312:	56                   	push   %esi
  10a313:	53                   	push   %ebx
  10a314:	81 ec cc 00 00 00    	sub    $0xcc,%esp
  10a31a:	8b b4 24 e0 00 00 00 	mov    0xe0(%esp),%esi
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], path[128];
  uint32_t off;

  pt_copyin(get_curid(), syscall_get_arg2(tf), path, 128);
  10a321:	8d 5c 24 40          	lea    0x40(%esp),%ebx
  10a325:	89 34 24             	mov    %esi,(%esp)
  10a328:	e8 d3 d0 ff ff       	call   107400 <syscall_get_arg2>
  10a32d:	89 c7                	mov    %eax,%edi
  10a32f:	e8 3c cc ff ff       	call   106f70 <get_curid>
  10a334:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  10a338:	89 7c 24 04          	mov    %edi,0x4(%esp)

  if((dp = nameiparent(path, name)) == 0){
  10a33c:	8d 7c 24 22          	lea    0x22(%esp),%edi
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], path[128];
  uint32_t off;

  pt_copyin(get_curid(), syscall_get_arg2(tf), path, 128);
  10a340:	c7 44 24 0c 80 00 00 	movl   $0x80,0xc(%esp)
  10a347:	00 
  10a348:	89 04 24             	mov    %eax,(%esp)
  10a34b:	e8 e0 af ff ff       	call   105330 <pt_copyin>

  if((dp = nameiparent(path, name)) == 0){
  10a350:	89 1c 24             	mov    %ebx,(%esp)
  10a353:	89 7c 24 04          	mov    %edi,0x4(%esp)
  10a357:	e8 04 f6 ff ff       	call   109960 <nameiparent>
  10a35c:	85 c0                	test   %eax,%eax
  10a35e:	89 c3                	mov    %eax,%ebx
  10a360:	74 2e                	je     10a390 <sys_unlink+0x80>
    syscall_set_errno(tf, E_DISK_OP);
    return;
  }
  
  begin_trans();
  10a362:	e8 a9 e4 ff ff       	call   108810 <begin_trans>

  inode_lock(dp);
  10a367:	89 1c 24             	mov    %ebx,(%esp)
  10a36a:	e8 51 ec ff ff       	call   108fc0 <inode_lock>

  // Cannot unlink "." or "..".
  if(   dir_namecmp(name, ".") == 0
  10a36f:	c7 44 24 04 e9 c9 10 	movl   $0x10c9e9,0x4(%esp)
  10a376:	00 
  10a377:	89 3c 24             	mov    %edi,(%esp)
  10a37a:	e8 11 f2 ff ff       	call   109590 <dir_namecmp>
  10a37f:	85 c0                	test   %eax,%eax
  10a381:	75 2d                	jne    10a3b0 <sys_unlink+0xa0>

  syscall_set_errno(tf, E_SUCC);
  return;
  
bad:
  inode_unlockput(dp);
  10a383:	89 1c 24             	mov    %ebx,(%esp)
  10a386:	e8 55 ef ff ff       	call   1092e0 <inode_unlockput>
  commit_trans();
  10a38b:	e8 e0 e4 ff ff       	call   108870 <commit_trans>
  syscall_set_errno(tf, E_DISK_OP);
  10a390:	c7 44 24 04 0d 00 00 	movl   $0xd,0x4(%esp)
  10a397:	00 
  10a398:	89 34 24             	mov    %esi,(%esp)
  10a39b:	e8 e0 d0 ff ff       	call   107480 <syscall_set_errno>
  return;
}
  10a3a0:	81 c4 cc 00 00 00    	add    $0xcc,%esp
  10a3a6:	5b                   	pop    %ebx
  10a3a7:	5e                   	pop    %esi
  10a3a8:	5f                   	pop    %edi
  10a3a9:	5d                   	pop    %ebp
  10a3aa:	c3                   	ret    
  10a3ab:	90                   	nop
  10a3ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  inode_lock(dp);

  // Cannot unlink "." or "..".
  if(   dir_namecmp(name, ".") == 0
     || dir_namecmp(name, "..") == 0)
  10a3b0:	c7 44 24 04 e8 c9 10 	movl   $0x10c9e8,0x4(%esp)
  10a3b7:	00 
  10a3b8:	89 3c 24             	mov    %edi,(%esp)
  10a3bb:	e8 d0 f1 ff ff       	call   109590 <dir_namecmp>
  10a3c0:	85 c0                	test   %eax,%eax
  10a3c2:	74 bf                	je     10a383 <sys_unlink+0x73>
    goto bad;

  if((ip = dir_lookup(dp, name, &off)) == 0)
  10a3c4:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  10a3c8:	89 7c 24 04          	mov    %edi,0x4(%esp)
  10a3cc:	89 44 24 08          	mov    %eax,0x8(%esp)
  10a3d0:	89 1c 24             	mov    %ebx,(%esp)
  10a3d3:	e8 e8 f1 ff ff       	call   1095c0 <dir_lookup>
  10a3d8:	85 c0                	test   %eax,%eax
  10a3da:	89 c7                	mov    %eax,%edi
  10a3dc:	74 a5                	je     10a383 <sys_unlink+0x73>
    goto bad;
  inode_lock(ip);
  10a3de:	89 04 24             	mov    %eax,(%esp)
  10a3e1:	e8 da eb ff ff       	call   108fc0 <inode_lock>

  if(ip->nlink < 1)
  10a3e6:	66 83 7f 16 00       	cmpw   $0x0,0x16(%edi)
  10a3eb:	0f 8e 3f 01 00 00    	jle    10a530 <sys_unlink+0x220>
    KERN_PANIC("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
  10a3f1:	66 83 7f 10 01       	cmpw   $0x1,0x10(%edi)
  10a3f6:	0f 84 a4 00 00 00    	je     10a4a0 <sys_unlink+0x190>
    inode_unlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  10a3fc:	8d 44 24 30          	lea    0x30(%esp),%eax
  10a400:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  10a407:	00 
  10a408:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10a40f:	00 
  10a410:	89 04 24             	mov    %eax,(%esp)
  10a413:	e8 58 99 ff ff       	call   103d70 <memset>
  if(inode_write(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  10a418:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  10a41c:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  10a423:	00 
  10a424:	89 1c 24             	mov    %ebx,(%esp)
  10a427:	89 44 24 08          	mov    %eax,0x8(%esp)
  10a42b:	8d 44 24 30          	lea    0x30(%esp),%eax
  10a42f:	89 44 24 04          	mov    %eax,0x4(%esp)
  10a433:	e8 08 f0 ff ff       	call   109440 <inode_write>
  10a438:	83 f8 10             	cmp    $0x10,%eax
  10a43b:	74 1c                	je     10a459 <sys_unlink+0x149>
    KERN_PANIC("unlink: writei");
  10a43d:	c7 44 24 08 20 ca 10 	movl   $0x10ca20,0x8(%esp)
  10a444:	00 
  10a445:	c7 44 24 04 0e 01 00 	movl   $0x10e,0x4(%esp)
  10a44c:	00 
  10a44d:	c7 04 24 ca c9 10 00 	movl   $0x10c9ca,(%esp)
  10a454:	e8 27 9d ff ff       	call   104180 <debug_panic>
  if(ip->type == T_DIR){
  10a459:	66 83 7f 10 01       	cmpw   $0x1,0x10(%edi)
  10a45e:	0f 84 b4 00 00 00    	je     10a518 <sys_unlink+0x208>
    dp->nlink--;
    inode_update(dp);
  }
  inode_unlockput(dp);
  10a464:	89 1c 24             	mov    %ebx,(%esp)
  10a467:	e8 74 ee ff ff       	call   1092e0 <inode_unlockput>

  ip->nlink--;
  10a46c:	66 83 6f 16 01       	subw   $0x1,0x16(%edi)
  inode_update(ip);
  10a471:	89 3c 24             	mov    %edi,(%esp)
  10a474:	e8 c7 e8 ff ff       	call   108d40 <inode_update>
  inode_unlockput(ip);
  10a479:	89 3c 24             	mov    %edi,(%esp)
  10a47c:	e8 5f ee ff ff       	call   1092e0 <inode_unlockput>

  commit_trans();
  10a481:	e8 ea e3 ff ff       	call   108870 <commit_trans>

  syscall_set_errno(tf, E_SUCC);
  10a486:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10a48d:	00 
  10a48e:	89 34 24             	mov    %esi,(%esp)
  10a491:	e8 ea cf ff ff       	call   107480 <syscall_set_errno>
  return;
  10a496:	e9 05 ff ff ff       	jmp    10a3a0 <sys_unlink+0x90>
  10a49b:	90                   	nop
  10a49c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
  10a4a0:	83 7f 18 20          	cmpl   $0x20,0x18(%edi)
  10a4a4:	0f 86 52 ff ff ff    	jbe    10a3fc <sys_unlink+0xec>
  10a4aa:	bd 20 00 00 00       	mov    $0x20,%ebp
  10a4af:	90                   	nop
  10a4b0:	eb 12                	jmp    10a4c4 <sys_unlink+0x1b4>
  10a4b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10a4b8:	83 c5 10             	add    $0x10,%ebp
  10a4bb:	3b 6f 18             	cmp    0x18(%edi),%ebp
  10a4be:	0f 83 38 ff ff ff    	jae    10a3fc <sys_unlink+0xec>
    if(inode_read(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  10a4c4:	8d 44 24 30          	lea    0x30(%esp),%eax
  10a4c8:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  10a4cf:	00 
  10a4d0:	89 6c 24 08          	mov    %ebp,0x8(%esp)
  10a4d4:	89 44 24 04          	mov    %eax,0x4(%esp)
  10a4d8:	89 3c 24             	mov    %edi,(%esp)
  10a4db:	e8 50 ee ff ff       	call   109330 <inode_read>
  10a4e0:	83 f8 10             	cmp    $0x10,%eax
  10a4e3:	74 1c                	je     10a501 <sys_unlink+0x1f1>
      KERN_PANIC("isdirempty: readi");
  10a4e5:	c7 44 24 08 0e ca 10 	movl   $0x10ca0e,0x8(%esp)
  10a4ec:	00 
  10a4ed:	c7 44 24 04 e3 00 00 	movl   $0xe3,0x4(%esp)
  10a4f4:	00 
  10a4f5:	c7 04 24 ca c9 10 00 	movl   $0x10c9ca,(%esp)
  10a4fc:	e8 7f 9c ff ff       	call   104180 <debug_panic>
    if(de.inum != 0)
  10a501:	66 83 7c 24 30 00    	cmpw   $0x0,0x30(%esp)
  10a507:	74 af                	je     10a4b8 <sys_unlink+0x1a8>
  inode_lock(ip);

  if(ip->nlink < 1)
    KERN_PANIC("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    inode_unlockput(ip);
  10a509:	89 3c 24             	mov    %edi,(%esp)
  10a50c:	e8 cf ed ff ff       	call   1092e0 <inode_unlockput>
    goto bad;
  10a511:	e9 6d fe ff ff       	jmp    10a383 <sys_unlink+0x73>
  10a516:	66 90                	xchg   %ax,%ax

  memset(&de, 0, sizeof(de));
  if(inode_write(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    KERN_PANIC("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
  10a518:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
    inode_update(dp);
  10a51d:	89 1c 24             	mov    %ebx,(%esp)
  10a520:	e8 1b e8 ff ff       	call   108d40 <inode_update>
  10a525:	e9 3a ff ff ff       	jmp    10a464 <sys_unlink+0x154>
  10a52a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if((ip = dir_lookup(dp, name, &off)) == 0)
    goto bad;
  inode_lock(ip);

  if(ip->nlink < 1)
    KERN_PANIC("unlink: nlink < 1");
  10a530:	c7 44 24 08 fc c9 10 	movl   $0x10c9fc,0x8(%esp)
  10a537:	00 
  10a538:	c7 44 24 04 06 01 00 	movl   $0x106,0x4(%esp)
  10a53f:	00 
  10a540:	c7 04 24 ca c9 10 00 	movl   $0x10c9ca,(%esp)
  10a547:	e8 34 9c ff ff       	call   104180 <debug_panic>
  10a54c:	e9 a0 fe ff ff       	jmp    10a3f1 <sys_unlink+0xe1>
  10a551:	eb 0d                	jmp    10a560 <sys_open>
  10a553:	90                   	nop
  10a554:	90                   	nop
  10a555:	90                   	nop
  10a556:	90                   	nop
  10a557:	90                   	nop
  10a558:	90                   	nop
  10a559:	90                   	nop
  10a55a:	90                   	nop
  10a55b:	90                   	nop
  10a55c:	90                   	nop
  10a55d:	90                   	nop
  10a55e:	90                   	nop
  10a55f:	90                   	nop

0010a560 <sys_open>:

  return ip;
}

void sys_open(tf_t *tf)
{
  10a560:	55                   	push   %ebp
  10a561:	57                   	push   %edi
  10a562:	56                   	push   %esi
  10a563:	53                   	push   %ebx
  10a564:	81 ec ac 00 00 00    	sub    $0xac,%esp
  int fd, omode;
  struct file *f;
  struct inode *ip;

  static int first = TRUE;
  if (first) {
  10a56a:	8b 0d 10 03 11 00    	mov    0x110310,%ecx

  return ip;
}

void sys_open(tf_t *tf)
{
  10a570:	8b 9c 24 c0 00 00 00 	mov    0xc0(%esp),%ebx
  int fd, omode;
  struct file *f;
  struct inode *ip;

  static int first = TRUE;
  if (first) {
  10a577:	85 c9                	test   %ecx,%ecx
  10a579:	0f 85 09 01 00 00    	jne    10a688 <sys_open+0x128>
    first = FALSE;
    log_init();
  }

  pt_copyin(get_curid(), syscall_get_arg2(tf), path, 128);
  10a57f:	89 1c 24             	mov    %ebx,(%esp)
  10a582:	8d 74 24 20          	lea    0x20(%esp),%esi
  10a586:	e8 75 ce ff ff       	call   107400 <syscall_get_arg2>
  10a58b:	89 c7                	mov    %eax,%edi
  10a58d:	e8 de c9 ff ff       	call   106f70 <get_curid>
  10a592:	c7 44 24 0c 80 00 00 	movl   $0x80,0xc(%esp)
  10a599:	00 
  10a59a:	89 74 24 08          	mov    %esi,0x8(%esp)
  10a59e:	89 7c 24 04          	mov    %edi,0x4(%esp)
  10a5a2:	89 04 24             	mov    %eax,(%esp)
  10a5a5:	e8 86 ad ff ff       	call   105330 <pt_copyin>
  omode = syscall_get_arg3(tf);
  10a5aa:	89 1c 24             	mov    %ebx,(%esp)
  10a5ad:	e8 5e ce ff ff       	call   107410 <syscall_get_arg3>

  if (!path)
    KERN_PANIC("sys_open: no path");
  
  if(omode & O_CREATE){
  10a5b2:	f6 c4 02             	test   $0x2,%ah
    first = FALSE;
    log_init();
  }

  pt_copyin(get_curid(), syscall_get_arg2(tf), path, 128);
  omode = syscall_get_arg3(tf);
  10a5b5:	89 44 24 1c          	mov    %eax,0x1c(%esp)

  if (!path)
    KERN_PANIC("sys_open: no path");
  
  if(omode & O_CREATE){
  10a5b9:	0f 84 91 00 00 00    	je     10a650 <sys_open+0xf0>
    begin_trans();
  10a5bf:	e8 4c e2 ff ff       	call   108810 <begin_trans>
    ip = create(path, T_FILE, 0, 0);
  10a5c4:	ba 02 00 00 00       	mov    $0x2,%edx
  10a5c9:	89 f0                	mov    %esi,%eax
  10a5cb:	e8 40 f7 ff ff       	call   109d10 <create.constprop.0>
  10a5d0:	89 c6                	mov    %eax,%esi
    commit_trans();
  10a5d2:	e8 99 e2 ff ff       	call   108870 <commit_trans>
    if(ip == 0){
  10a5d7:	85 f6                	test   %esi,%esi
  10a5d9:	0f 84 56 01 00 00    	je     10a735 <sys_open+0x1d5>
      syscall_set_errno(tf, E_DISK_OP);
      return;
    }
  }

  if((f = file_alloc()) == 0 || (fd = fdalloc(f)) < 0){
  10a5df:	e8 bc f3 ff ff       	call   1099a0 <file_alloc>
  10a5e4:	85 c0                	test   %eax,%eax
  10a5e6:	89 c7                	mov    %eax,%edi
  10a5e8:	74 2e                	je     10a618 <sys_open+0xb8>
  10a5ea:	31 ed                	xor    %ebp,%ebp
  10a5ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;
  struct file *g;

  for(fd = 0; fd < NOFILE; fd++){
    if((g=(tcb_get_openfiles(get_curid())[fd])) == 0){
  10a5f0:	e8 7b c9 ff ff       	call   106f70 <get_curid>
  10a5f5:	89 04 24             	mov    %eax,(%esp)
  10a5f8:	e8 b3 c5 ff ff       	call   106bb0 <tcb_get_openfiles>
  10a5fd:	8b 04 a8             	mov    (%eax,%ebp,4),%eax
  10a600:	85 c0                	test   %eax,%eax
  10a602:	0f 84 98 00 00 00    	je     10a6a0 <sys_open+0x140>
fdalloc(struct file *f)
{
  int fd;
  struct file *g;

  for(fd = 0; fd < NOFILE; fd++){
  10a608:	83 c5 01             	add    $0x1,%ebp
  10a60b:	83 fd 10             	cmp    $0x10,%ebp
  10a60e:	75 e0                	jne    10a5f0 <sys_open+0x90>
    }
  }

  if((f = file_alloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      file_close(f);
  10a610:	89 3c 24             	mov    %edi,(%esp)
  10a613:	e8 48 f4 ff ff       	call   109a60 <file_close>
    inode_unlockput(ip);
  10a618:	89 34 24             	mov    %esi,(%esp)
  10a61b:	e8 c0 ec ff ff       	call   1092e0 <inode_unlockput>
    syscall_set_retval1(tf, -1);
  10a620:	c7 44 24 04 ff ff ff 	movl   $0xffffffff,0x4(%esp)
  10a627:	ff 
  10a628:	89 1c 24             	mov    %ebx,(%esp)
  10a62b:	e8 60 ce ff ff       	call   107490 <syscall_set_retval1>
    syscall_set_errno(tf, E_DISK_OP);
  10a630:	c7 44 24 04 0d 00 00 	movl   $0xd,0x4(%esp)
  10a637:	00 
  10a638:	89 1c 24             	mov    %ebx,(%esp)
  10a63b:	e8 40 ce ff ff       	call   107480 <syscall_set_errno>
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  syscall_set_retval1(tf, fd);
  syscall_set_errno(tf, E_SUCC);
}
  10a640:	81 c4 ac 00 00 00    	add    $0xac,%esp
  10a646:	5b                   	pop    %ebx
  10a647:	5e                   	pop    %esi
  10a648:	5f                   	pop    %edi
  10a649:	5d                   	pop    %ebp
  10a64a:	c3                   	ret    
  10a64b:	90                   	nop
  10a64c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      syscall_set_retval1(tf, -1);
      syscall_set_errno(tf, E_CREATE);
      return;
    }
  } else {
    if((ip = namei(path)) == 0){
  10a650:	89 34 24             	mov    %esi,(%esp)
  10a653:	e8 e8 f2 ff ff       	call   109940 <namei>
  10a658:	85 c0                	test   %eax,%eax
  10a65a:	89 c6                	mov    %eax,%esi
  10a65c:	0f 84 ae 00 00 00    	je     10a710 <sys_open+0x1b0>
      syscall_set_retval1(tf, -1);
      syscall_set_errno(tf, E_NEXIST);
      return;
    }
    inode_lock(ip);
  10a662:	89 04 24             	mov    %eax,(%esp)
  10a665:	e8 56 e9 ff ff       	call   108fc0 <inode_lock>
    if(ip->type == T_DIR && omode != O_RDONLY){
  10a66a:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
  10a66f:	0f 85 6a ff ff ff    	jne    10a5df <sys_open+0x7f>
  10a675:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  10a679:	85 d2                	test   %edx,%edx
  10a67b:	0f 84 5e ff ff ff    	je     10a5df <sys_open+0x7f>
  10a681:	eb 95                	jmp    10a618 <sys_open+0xb8>
  10a683:	90                   	nop
  10a684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct file *f;
  struct inode *ip;

  static int first = TRUE;
  if (first) {
    first = FALSE;
  10a688:	c7 05 10 03 11 00 00 	movl   $0x0,0x110310
  10a68f:	00 00 00 
    log_init();
  10a692:	e8 d9 e0 ff ff       	call   108770 <log_init>
  10a697:	e9 e3 fe ff ff       	jmp    10a57f <sys_open+0x1f>
  10a69c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct file *g;

  for(fd = 0; fd < NOFILE; fd++){
    if((g=(tcb_get_openfiles(get_curid())[fd])) == 0){
      tcb_set_openfiles(get_curid(), fd, f);
  10a6a0:	e8 cb c8 ff ff       	call   106f70 <get_curid>
  10a6a5:	89 7c 24 08          	mov    %edi,0x8(%esp)
  10a6a9:	89 6c 24 04          	mov    %ebp,0x4(%esp)
  10a6ad:	89 04 24             	mov    %eax,(%esp)
  10a6b0:	e8 0b c5 ff ff       	call   106bc0 <tcb_set_openfiles>
    inode_unlockput(ip);
    syscall_set_retval1(tf, -1);
    syscall_set_errno(tf, E_DISK_OP);
    return;
  }
  inode_unlock(ip);
  10a6b5:	89 34 24             	mov    %esi,(%esp)
  10a6b8:	e8 33 ea ff ff       	call   1090f0 <inode_unlock>

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  10a6bd:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
    return;
  }
  inode_unlock(ip);

  f->type = FD_INODE;
  f->ip = ip;
  10a6c1:	89 77 0c             	mov    %esi,0xc(%edi)
    syscall_set_errno(tf, E_DISK_OP);
    return;
  }
  inode_unlock(ip);

  f->type = FD_INODE;
  10a6c4:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  10a6ca:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
  10a6d1:	89 c8                	mov    %ecx,%eax
  10a6d3:	83 e0 01             	and    $0x1,%eax
  10a6d6:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  10a6d9:	83 e1 03             	and    $0x3,%ecx
  10a6dc:	0f 95 47 09          	setne  0x9(%edi)
  inode_unlock(ip);

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  10a6e0:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  syscall_set_retval1(tf, fd);
  10a6e3:	89 6c 24 04          	mov    %ebp,0x4(%esp)
  10a6e7:	89 1c 24             	mov    %ebx,(%esp)
  10a6ea:	e8 a1 cd ff ff       	call   107490 <syscall_set_retval1>
  syscall_set_errno(tf, E_SUCC);
  10a6ef:	89 1c 24             	mov    %ebx,(%esp)
  10a6f2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10a6f9:	00 
  10a6fa:	e8 81 cd ff ff       	call   107480 <syscall_set_errno>
}
  10a6ff:	81 c4 ac 00 00 00    	add    $0xac,%esp
  10a705:	5b                   	pop    %ebx
  10a706:	5e                   	pop    %esi
  10a707:	5f                   	pop    %edi
  10a708:	5d                   	pop    %ebp
  10a709:	c3                   	ret    
  10a70a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      syscall_set_errno(tf, E_CREATE);
      return;
    }
  } else {
    if((ip = namei(path)) == 0){
      syscall_set_retval1(tf, -1);
  10a710:	c7 44 24 04 ff ff ff 	movl   $0xffffffff,0x4(%esp)
  10a717:	ff 
  10a718:	89 1c 24             	mov    %ebx,(%esp)
  10a71b:	e8 70 cd ff ff       	call   107490 <syscall_set_retval1>
      syscall_set_errno(tf, E_NEXIST);
  10a720:	c7 44 24 04 1a 00 00 	movl   $0x1a,0x4(%esp)
  10a727:	00 
  10a728:	89 1c 24             	mov    %ebx,(%esp)
  10a72b:	e8 50 cd ff ff       	call   107480 <syscall_set_errno>
      return;
  10a730:	e9 0b ff ff ff       	jmp    10a640 <sys_open+0xe0>
  if(omode & O_CREATE){
    begin_trans();
    ip = create(path, T_FILE, 0, 0);
    commit_trans();
    if(ip == 0){
      syscall_set_retval1(tf, -1);
  10a735:	c7 44 24 04 ff ff ff 	movl   $0xffffffff,0x4(%esp)
  10a73c:	ff 
  10a73d:	89 1c 24             	mov    %ebx,(%esp)
  10a740:	e8 4b cd ff ff       	call   107490 <syscall_set_retval1>
      syscall_set_errno(tf, E_CREATE);
  10a745:	c7 44 24 04 1b 00 00 	movl   $0x1b,0x4(%esp)
  10a74c:	00 
  10a74d:	89 1c 24             	mov    %ebx,(%esp)
  10a750:	e8 2b cd ff ff       	call   107480 <syscall_set_errno>
      return;
  10a755:	e9 e6 fe ff ff       	jmp    10a640 <sys_open+0xe0>
  10a75a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

0010a760 <sys_mkdir>:
  syscall_set_retval1(tf, fd);
  syscall_set_errno(tf, E_SUCC);
}

void sys_mkdir(tf_t *tf)
{
  10a760:	57                   	push   %edi
  10a761:	56                   	push   %esi
  10a762:	53                   	push   %ebx
  10a763:	81 ec 90 00 00 00    	sub    $0x90,%esp
  10a769:	8b b4 24 a0 00 00 00 	mov    0xa0(%esp),%esi
  char path[128];
  struct inode *ip;

  pt_copyin(get_curid(), syscall_get_arg2(tf), path, 128);
  10a770:	8d 5c 24 10          	lea    0x10(%esp),%ebx
  10a774:	89 34 24             	mov    %esi,(%esp)
  10a777:	e8 84 cc ff ff       	call   107400 <syscall_get_arg2>
  10a77c:	89 c7                	mov    %eax,%edi
  10a77e:	e8 ed c7 ff ff       	call   106f70 <get_curid>
  10a783:	c7 44 24 0c 80 00 00 	movl   $0x80,0xc(%esp)
  10a78a:	00 
  10a78b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  10a78f:	89 7c 24 04          	mov    %edi,0x4(%esp)
  10a793:	89 04 24             	mov    %eax,(%esp)
  10a796:	e8 95 ab ff ff       	call   105330 <pt_copyin>

  begin_trans();
  10a79b:	e8 70 e0 ff ff       	call   108810 <begin_trans>
  if((ip = (struct inode*)create(path, T_DIR, 0, 0)) == 0){
  10a7a0:	ba 01 00 00 00       	mov    $0x1,%edx
  10a7a5:	89 d8                	mov    %ebx,%eax
  10a7a7:	e8 64 f5 ff ff       	call   109d10 <create.constprop.0>
  10a7ac:	85 c0                	test   %eax,%eax
  10a7ae:	74 28                	je     10a7d8 <sys_mkdir+0x78>
    commit_trans();
    syscall_set_errno(tf, E_DISK_OP);
    return;
  }
  inode_unlockput(ip);
  10a7b0:	89 04 24             	mov    %eax,(%esp)
  10a7b3:	e8 28 eb ff ff       	call   1092e0 <inode_unlockput>
  commit_trans();
  10a7b8:	e8 b3 e0 ff ff       	call   108870 <commit_trans>
  syscall_set_errno(tf, E_SUCC);
  10a7bd:	89 34 24             	mov    %esi,(%esp)
  10a7c0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10a7c7:	00 
  10a7c8:	e8 b3 cc ff ff       	call   107480 <syscall_set_errno>
}
  10a7cd:	81 c4 90 00 00 00    	add    $0x90,%esp
  10a7d3:	5b                   	pop    %ebx
  10a7d4:	5e                   	pop    %esi
  10a7d5:	5f                   	pop    %edi
  10a7d6:	c3                   	ret    
  10a7d7:	90                   	nop

  pt_copyin(get_curid(), syscall_get_arg2(tf), path, 128);

  begin_trans();
  if((ip = (struct inode*)create(path, T_DIR, 0, 0)) == 0){
    commit_trans();
  10a7d8:	e8 93 e0 ff ff       	call   108870 <commit_trans>
    syscall_set_errno(tf, E_DISK_OP);
  10a7dd:	89 34 24             	mov    %esi,(%esp)
  10a7e0:	c7 44 24 04 0d 00 00 	movl   $0xd,0x4(%esp)
  10a7e7:	00 
  10a7e8:	e8 93 cc ff ff       	call   107480 <syscall_set_errno>
    return;
  }
  inode_unlockput(ip);
  commit_trans();
  syscall_set_errno(tf, E_SUCC);
}
  10a7ed:	81 c4 90 00 00 00    	add    $0x90,%esp
  10a7f3:	5b                   	pop    %ebx
  10a7f4:	5e                   	pop    %esi
  10a7f5:	5f                   	pop    %edi
  10a7f6:	c3                   	ret    
  10a7f7:	89 f6                	mov    %esi,%esi
  10a7f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

0010a800 <sys_chdir>:

void sys_chdir(tf_t *tf)
{
  10a800:	55                   	push   %ebp
  10a801:	57                   	push   %edi
  10a802:	56                   	push   %esi
  10a803:	53                   	push   %ebx
  10a804:	81 ec 9c 00 00 00    	sub    $0x9c,%esp
  10a80a:	8b b4 24 b0 00 00 00 	mov    0xb0(%esp),%esi
  char path[128];
  struct inode *ip;
  int pid = get_curid();

  pt_copyin(get_curid(), syscall_get_arg2(tf), path, 128);
  10a811:	8d 5c 24 10          	lea    0x10(%esp),%ebx

void sys_chdir(tf_t *tf)
{
  char path[128];
  struct inode *ip;
  int pid = get_curid();
  10a815:	e8 56 c7 ff ff       	call   106f70 <get_curid>

  pt_copyin(get_curid(), syscall_get_arg2(tf), path, 128);
  10a81a:	89 34 24             	mov    %esi,(%esp)

void sys_chdir(tf_t *tf)
{
  char path[128];
  struct inode *ip;
  int pid = get_curid();
  10a81d:	89 c7                	mov    %eax,%edi

  pt_copyin(get_curid(), syscall_get_arg2(tf), path, 128);
  10a81f:	e8 dc cb ff ff       	call   107400 <syscall_get_arg2>
  10a824:	89 c5                	mov    %eax,%ebp
  10a826:	e8 45 c7 ff ff       	call   106f70 <get_curid>
  10a82b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  10a82f:	c7 44 24 0c 80 00 00 	movl   $0x80,0xc(%esp)
  10a836:	00 
  10a837:	89 6c 24 04          	mov    %ebp,0x4(%esp)
  10a83b:	89 04 24             	mov    %eax,(%esp)
  10a83e:	e8 ed aa ff ff       	call   105330 <pt_copyin>

  if((ip = namei(path)) == 0){
  10a843:	89 1c 24             	mov    %ebx,(%esp)
  10a846:	e8 f5 f0 ff ff       	call   109940 <namei>
  10a84b:	85 c0                	test   %eax,%eax
  10a84d:	89 c3                	mov    %eax,%ebx
  10a84f:	74 17                	je     10a868 <sys_chdir+0x68>
    syscall_set_errno(tf, E_DISK_OP);
    return;
  }
  inode_lock(ip);
  10a851:	89 04 24             	mov    %eax,(%esp)
  10a854:	e8 67 e7 ff ff       	call   108fc0 <inode_lock>
  if(ip->type != T_DIR){
  10a859:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
    inode_unlockput(ip);
  10a85e:	89 1c 24             	mov    %ebx,(%esp)
  if((ip = namei(path)) == 0){
    syscall_set_errno(tf, E_DISK_OP);
    return;
  }
  inode_lock(ip);
  if(ip->type != T_DIR){
  10a861:	74 25                	je     10a888 <sys_chdir+0x88>
    inode_unlockput(ip);
  10a863:	e8 78 ea ff ff       	call   1092e0 <inode_unlockput>
    syscall_set_errno(tf, E_DISK_OP);
  10a868:	89 34 24             	mov    %esi,(%esp)
  10a86b:	c7 44 24 04 0d 00 00 	movl   $0xd,0x4(%esp)
  10a872:	00 
  10a873:	e8 08 cc ff ff       	call   107480 <syscall_set_errno>
  }
  inode_unlock(ip);
  inode_put(tcb_get_cwd(pid));
  tcb_set_cwd(pid, ip);
  syscall_set_errno(tf, E_SUCC);
}
  10a878:	81 c4 9c 00 00 00    	add    $0x9c,%esp
  10a87e:	5b                   	pop    %ebx
  10a87f:	5e                   	pop    %esi
  10a880:	5f                   	pop    %edi
  10a881:	5d                   	pop    %ebp
  10a882:	c3                   	ret    
  10a883:	90                   	nop
  10a884:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(ip->type != T_DIR){
    inode_unlockput(ip);
    syscall_set_errno(tf, E_DISK_OP);
    return;
  }
  inode_unlock(ip);
  10a888:	e8 63 e8 ff ff       	call   1090f0 <inode_unlock>
  inode_put(tcb_get_cwd(pid));
  10a88d:	89 3c 24             	mov    %edi,(%esp)
  10a890:	e8 4b c3 ff ff       	call   106be0 <tcb_get_cwd>
  10a895:	89 04 24             	mov    %eax,(%esp)
  10a898:	e8 c3 e8 ff ff       	call   109160 <inode_put>
  tcb_set_cwd(pid, ip);
  10a89d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  10a8a1:	89 3c 24             	mov    %edi,(%esp)
  10a8a4:	e8 47 c3 ff ff       	call   106bf0 <tcb_set_cwd>
  syscall_set_errno(tf, E_SUCC);
  10a8a9:	89 34 24             	mov    %esi,(%esp)
  10a8ac:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10a8b3:	00 
  10a8b4:	e8 c7 cb ff ff       	call   107480 <syscall_set_errno>
}
  10a8b9:	81 c4 9c 00 00 00    	add    $0x9c,%esp
  10a8bf:	5b                   	pop    %ebx
  10a8c0:	5e                   	pop    %esi
  10a8c1:	5f                   	pop    %edi
  10a8c2:	5d                   	pop    %ebp
  10a8c3:	c3                   	ret    
  10a8c4:	66 90                	xchg   %ax,%ax
  10a8c6:	66 90                	xchg   %ax,%ax
  10a8c8:	66 90                	xchg   %ax,%ax
  10a8ca:	66 90                	xchg   %ax,%ax
  10a8cc:	66 90                	xchg   %ax,%ax
  10a8ce:	66 90                	xchg   %ax,%ax

0010a8d0 <__udivdi3>:
  10a8d0:	55                   	push   %ebp
  10a8d1:	57                   	push   %edi
  10a8d2:	56                   	push   %esi
  10a8d3:	83 ec 0c             	sub    $0xc,%esp
  10a8d6:	8b 44 24 28          	mov    0x28(%esp),%eax
  10a8da:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
  10a8de:	8b 6c 24 20          	mov    0x20(%esp),%ebp
  10a8e2:	8b 4c 24 24          	mov    0x24(%esp),%ecx
  10a8e6:	85 c0                	test   %eax,%eax
  10a8e8:	89 7c 24 04          	mov    %edi,0x4(%esp)
  10a8ec:	89 ea                	mov    %ebp,%edx
  10a8ee:	89 0c 24             	mov    %ecx,(%esp)
  10a8f1:	75 2d                	jne    10a920 <__udivdi3+0x50>
  10a8f3:	39 e9                	cmp    %ebp,%ecx
  10a8f5:	77 61                	ja     10a958 <__udivdi3+0x88>
  10a8f7:	85 c9                	test   %ecx,%ecx
  10a8f9:	89 ce                	mov    %ecx,%esi
  10a8fb:	75 0b                	jne    10a908 <__udivdi3+0x38>
  10a8fd:	b8 01 00 00 00       	mov    $0x1,%eax
  10a902:	31 d2                	xor    %edx,%edx
  10a904:	f7 f1                	div    %ecx
  10a906:	89 c6                	mov    %eax,%esi
  10a908:	31 d2                	xor    %edx,%edx
  10a90a:	89 e8                	mov    %ebp,%eax
  10a90c:	f7 f6                	div    %esi
  10a90e:	89 c5                	mov    %eax,%ebp
  10a910:	89 f8                	mov    %edi,%eax
  10a912:	f7 f6                	div    %esi
  10a914:	89 ea                	mov    %ebp,%edx
  10a916:	83 c4 0c             	add    $0xc,%esp
  10a919:	5e                   	pop    %esi
  10a91a:	5f                   	pop    %edi
  10a91b:	5d                   	pop    %ebp
  10a91c:	c3                   	ret    
  10a91d:	8d 76 00             	lea    0x0(%esi),%esi
  10a920:	39 e8                	cmp    %ebp,%eax
  10a922:	77 24                	ja     10a948 <__udivdi3+0x78>
  10a924:	0f bd e8             	bsr    %eax,%ebp
  10a927:	83 f5 1f             	xor    $0x1f,%ebp
  10a92a:	75 3c                	jne    10a968 <__udivdi3+0x98>
  10a92c:	8b 74 24 04          	mov    0x4(%esp),%esi
  10a930:	39 34 24             	cmp    %esi,(%esp)
  10a933:	0f 86 9f 00 00 00    	jbe    10a9d8 <__udivdi3+0x108>
  10a939:	39 d0                	cmp    %edx,%eax
  10a93b:	0f 82 97 00 00 00    	jb     10a9d8 <__udivdi3+0x108>
  10a941:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10a948:	31 d2                	xor    %edx,%edx
  10a94a:	31 c0                	xor    %eax,%eax
  10a94c:	83 c4 0c             	add    $0xc,%esp
  10a94f:	5e                   	pop    %esi
  10a950:	5f                   	pop    %edi
  10a951:	5d                   	pop    %ebp
  10a952:	c3                   	ret    
  10a953:	90                   	nop
  10a954:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10a958:	89 f8                	mov    %edi,%eax
  10a95a:	f7 f1                	div    %ecx
  10a95c:	31 d2                	xor    %edx,%edx
  10a95e:	83 c4 0c             	add    $0xc,%esp
  10a961:	5e                   	pop    %esi
  10a962:	5f                   	pop    %edi
  10a963:	5d                   	pop    %ebp
  10a964:	c3                   	ret    
  10a965:	8d 76 00             	lea    0x0(%esi),%esi
  10a968:	89 e9                	mov    %ebp,%ecx
  10a96a:	8b 3c 24             	mov    (%esp),%edi
  10a96d:	d3 e0                	shl    %cl,%eax
  10a96f:	89 c6                	mov    %eax,%esi
  10a971:	b8 20 00 00 00       	mov    $0x20,%eax
  10a976:	29 e8                	sub    %ebp,%eax
  10a978:	89 c1                	mov    %eax,%ecx
  10a97a:	d3 ef                	shr    %cl,%edi
  10a97c:	89 e9                	mov    %ebp,%ecx
  10a97e:	89 7c 24 08          	mov    %edi,0x8(%esp)
  10a982:	8b 3c 24             	mov    (%esp),%edi
  10a985:	09 74 24 08          	or     %esi,0x8(%esp)
  10a989:	89 d6                	mov    %edx,%esi
  10a98b:	d3 e7                	shl    %cl,%edi
  10a98d:	89 c1                	mov    %eax,%ecx
  10a98f:	89 3c 24             	mov    %edi,(%esp)
  10a992:	8b 7c 24 04          	mov    0x4(%esp),%edi
  10a996:	d3 ee                	shr    %cl,%esi
  10a998:	89 e9                	mov    %ebp,%ecx
  10a99a:	d3 e2                	shl    %cl,%edx
  10a99c:	89 c1                	mov    %eax,%ecx
  10a99e:	d3 ef                	shr    %cl,%edi
  10a9a0:	09 d7                	or     %edx,%edi
  10a9a2:	89 f2                	mov    %esi,%edx
  10a9a4:	89 f8                	mov    %edi,%eax
  10a9a6:	f7 74 24 08          	divl   0x8(%esp)
  10a9aa:	89 d6                	mov    %edx,%esi
  10a9ac:	89 c7                	mov    %eax,%edi
  10a9ae:	f7 24 24             	mull   (%esp)
  10a9b1:	39 d6                	cmp    %edx,%esi
  10a9b3:	89 14 24             	mov    %edx,(%esp)
  10a9b6:	72 30                	jb     10a9e8 <__udivdi3+0x118>
  10a9b8:	8b 54 24 04          	mov    0x4(%esp),%edx
  10a9bc:	89 e9                	mov    %ebp,%ecx
  10a9be:	d3 e2                	shl    %cl,%edx
  10a9c0:	39 c2                	cmp    %eax,%edx
  10a9c2:	73 05                	jae    10a9c9 <__udivdi3+0xf9>
  10a9c4:	3b 34 24             	cmp    (%esp),%esi
  10a9c7:	74 1f                	je     10a9e8 <__udivdi3+0x118>
  10a9c9:	89 f8                	mov    %edi,%eax
  10a9cb:	31 d2                	xor    %edx,%edx
  10a9cd:	e9 7a ff ff ff       	jmp    10a94c <__udivdi3+0x7c>
  10a9d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10a9d8:	31 d2                	xor    %edx,%edx
  10a9da:	b8 01 00 00 00       	mov    $0x1,%eax
  10a9df:	e9 68 ff ff ff       	jmp    10a94c <__udivdi3+0x7c>
  10a9e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10a9e8:	8d 47 ff             	lea    -0x1(%edi),%eax
  10a9eb:	31 d2                	xor    %edx,%edx
  10a9ed:	83 c4 0c             	add    $0xc,%esp
  10a9f0:	5e                   	pop    %esi
  10a9f1:	5f                   	pop    %edi
  10a9f2:	5d                   	pop    %ebp
  10a9f3:	c3                   	ret    
  10a9f4:	66 90                	xchg   %ax,%ax
  10a9f6:	66 90                	xchg   %ax,%ax
  10a9f8:	66 90                	xchg   %ax,%ax
  10a9fa:	66 90                	xchg   %ax,%ax
  10a9fc:	66 90                	xchg   %ax,%ax
  10a9fe:	66 90                	xchg   %ax,%ax

0010aa00 <__umoddi3>:
  10aa00:	55                   	push   %ebp
  10aa01:	57                   	push   %edi
  10aa02:	56                   	push   %esi
  10aa03:	83 ec 14             	sub    $0x14,%esp
  10aa06:	8b 44 24 28          	mov    0x28(%esp),%eax
  10aa0a:	8b 4c 24 24          	mov    0x24(%esp),%ecx
  10aa0e:	8b 74 24 2c          	mov    0x2c(%esp),%esi
  10aa12:	89 c7                	mov    %eax,%edi
  10aa14:	89 44 24 04          	mov    %eax,0x4(%esp)
  10aa18:	8b 44 24 30          	mov    0x30(%esp),%eax
  10aa1c:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  10aa20:	89 34 24             	mov    %esi,(%esp)
  10aa23:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  10aa27:	85 c0                	test   %eax,%eax
  10aa29:	89 c2                	mov    %eax,%edx
  10aa2b:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  10aa2f:	75 17                	jne    10aa48 <__umoddi3+0x48>
  10aa31:	39 fe                	cmp    %edi,%esi
  10aa33:	76 4b                	jbe    10aa80 <__umoddi3+0x80>
  10aa35:	89 c8                	mov    %ecx,%eax
  10aa37:	89 fa                	mov    %edi,%edx
  10aa39:	f7 f6                	div    %esi
  10aa3b:	89 d0                	mov    %edx,%eax
  10aa3d:	31 d2                	xor    %edx,%edx
  10aa3f:	83 c4 14             	add    $0x14,%esp
  10aa42:	5e                   	pop    %esi
  10aa43:	5f                   	pop    %edi
  10aa44:	5d                   	pop    %ebp
  10aa45:	c3                   	ret    
  10aa46:	66 90                	xchg   %ax,%ax
  10aa48:	39 f8                	cmp    %edi,%eax
  10aa4a:	77 54                	ja     10aaa0 <__umoddi3+0xa0>
  10aa4c:	0f bd e8             	bsr    %eax,%ebp
  10aa4f:	83 f5 1f             	xor    $0x1f,%ebp
  10aa52:	75 5c                	jne    10aab0 <__umoddi3+0xb0>
  10aa54:	8b 7c 24 08          	mov    0x8(%esp),%edi
  10aa58:	39 3c 24             	cmp    %edi,(%esp)
  10aa5b:	0f 87 e7 00 00 00    	ja     10ab48 <__umoddi3+0x148>
  10aa61:	8b 7c 24 04          	mov    0x4(%esp),%edi
  10aa65:	29 f1                	sub    %esi,%ecx
  10aa67:	19 c7                	sbb    %eax,%edi
  10aa69:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  10aa6d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  10aa71:	8b 44 24 08          	mov    0x8(%esp),%eax
  10aa75:	8b 54 24 0c          	mov    0xc(%esp),%edx
  10aa79:	83 c4 14             	add    $0x14,%esp
  10aa7c:	5e                   	pop    %esi
  10aa7d:	5f                   	pop    %edi
  10aa7e:	5d                   	pop    %ebp
  10aa7f:	c3                   	ret    
  10aa80:	85 f6                	test   %esi,%esi
  10aa82:	89 f5                	mov    %esi,%ebp
  10aa84:	75 0b                	jne    10aa91 <__umoddi3+0x91>
  10aa86:	b8 01 00 00 00       	mov    $0x1,%eax
  10aa8b:	31 d2                	xor    %edx,%edx
  10aa8d:	f7 f6                	div    %esi
  10aa8f:	89 c5                	mov    %eax,%ebp
  10aa91:	8b 44 24 04          	mov    0x4(%esp),%eax
  10aa95:	31 d2                	xor    %edx,%edx
  10aa97:	f7 f5                	div    %ebp
  10aa99:	89 c8                	mov    %ecx,%eax
  10aa9b:	f7 f5                	div    %ebp
  10aa9d:	eb 9c                	jmp    10aa3b <__umoddi3+0x3b>
  10aa9f:	90                   	nop
  10aaa0:	89 c8                	mov    %ecx,%eax
  10aaa2:	89 fa                	mov    %edi,%edx
  10aaa4:	83 c4 14             	add    $0x14,%esp
  10aaa7:	5e                   	pop    %esi
  10aaa8:	5f                   	pop    %edi
  10aaa9:	5d                   	pop    %ebp
  10aaaa:	c3                   	ret    
  10aaab:	90                   	nop
  10aaac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10aab0:	8b 04 24             	mov    (%esp),%eax
  10aab3:	be 20 00 00 00       	mov    $0x20,%esi
  10aab8:	89 e9                	mov    %ebp,%ecx
  10aaba:	29 ee                	sub    %ebp,%esi
  10aabc:	d3 e2                	shl    %cl,%edx
  10aabe:	89 f1                	mov    %esi,%ecx
  10aac0:	d3 e8                	shr    %cl,%eax
  10aac2:	89 e9                	mov    %ebp,%ecx
  10aac4:	89 44 24 04          	mov    %eax,0x4(%esp)
  10aac8:	8b 04 24             	mov    (%esp),%eax
  10aacb:	09 54 24 04          	or     %edx,0x4(%esp)
  10aacf:	89 fa                	mov    %edi,%edx
  10aad1:	d3 e0                	shl    %cl,%eax
  10aad3:	89 f1                	mov    %esi,%ecx
  10aad5:	89 44 24 08          	mov    %eax,0x8(%esp)
  10aad9:	8b 44 24 10          	mov    0x10(%esp),%eax
  10aadd:	d3 ea                	shr    %cl,%edx
  10aadf:	89 e9                	mov    %ebp,%ecx
  10aae1:	d3 e7                	shl    %cl,%edi
  10aae3:	89 f1                	mov    %esi,%ecx
  10aae5:	d3 e8                	shr    %cl,%eax
  10aae7:	89 e9                	mov    %ebp,%ecx
  10aae9:	09 f8                	or     %edi,%eax
  10aaeb:	8b 7c 24 10          	mov    0x10(%esp),%edi
  10aaef:	f7 74 24 04          	divl   0x4(%esp)
  10aaf3:	d3 e7                	shl    %cl,%edi
  10aaf5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  10aaf9:	89 d7                	mov    %edx,%edi
  10aafb:	f7 64 24 08          	mull   0x8(%esp)
  10aaff:	39 d7                	cmp    %edx,%edi
  10ab01:	89 c1                	mov    %eax,%ecx
  10ab03:	89 14 24             	mov    %edx,(%esp)
  10ab06:	72 2c                	jb     10ab34 <__umoddi3+0x134>
  10ab08:	39 44 24 0c          	cmp    %eax,0xc(%esp)
  10ab0c:	72 22                	jb     10ab30 <__umoddi3+0x130>
  10ab0e:	8b 44 24 0c          	mov    0xc(%esp),%eax
  10ab12:	29 c8                	sub    %ecx,%eax
  10ab14:	19 d7                	sbb    %edx,%edi
  10ab16:	89 e9                	mov    %ebp,%ecx
  10ab18:	89 fa                	mov    %edi,%edx
  10ab1a:	d3 e8                	shr    %cl,%eax
  10ab1c:	89 f1                	mov    %esi,%ecx
  10ab1e:	d3 e2                	shl    %cl,%edx
  10ab20:	89 e9                	mov    %ebp,%ecx
  10ab22:	d3 ef                	shr    %cl,%edi
  10ab24:	09 d0                	or     %edx,%eax
  10ab26:	89 fa                	mov    %edi,%edx
  10ab28:	83 c4 14             	add    $0x14,%esp
  10ab2b:	5e                   	pop    %esi
  10ab2c:	5f                   	pop    %edi
  10ab2d:	5d                   	pop    %ebp
  10ab2e:	c3                   	ret    
  10ab2f:	90                   	nop
  10ab30:	39 d7                	cmp    %edx,%edi
  10ab32:	75 da                	jne    10ab0e <__umoddi3+0x10e>
  10ab34:	8b 14 24             	mov    (%esp),%edx
  10ab37:	89 c1                	mov    %eax,%ecx
  10ab39:	2b 4c 24 08          	sub    0x8(%esp),%ecx
  10ab3d:	1b 54 24 04          	sbb    0x4(%esp),%edx
  10ab41:	eb cb                	jmp    10ab0e <__umoddi3+0x10e>
  10ab43:	90                   	nop
  10ab44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10ab48:	3b 44 24 0c          	cmp    0xc(%esp),%eax
  10ab4c:	0f 82 0f ff ff ff    	jb     10aa61 <__umoddi3+0x61>
  10ab52:	e9 1a ff ff ff       	jmp    10aa71 <__umoddi3+0x71>
