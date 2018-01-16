
obj/user/pingpong/pong:     file format elf32-i386


Disassembly of section .text:

40000000 <main>:
#include <stdio.h>
#include <syscall.h>
#include <x86.h>

int main (int argc, char **argv)
{
40000000:	55                   	push   %ebp
40000001:	89 e5                	mov    %esp,%ebp
40000003:	53                   	push   %ebx
    printf("pong started.\n");

    unsigned int i;
    for (i = 0; i < 20; i++) {
40000004:	31 db                	xor    %ebx,%ebx
#include <stdio.h>
#include <syscall.h>
#include <x86.h>

int main (int argc, char **argv)
{
40000006:	83 e4 f0             	and    $0xfffffff0,%esp
40000009:	83 ec 10             	sub    $0x10,%esp
    printf("pong started.\n");
4000000c:	c7 04 24 cc 12 00 40 	movl   $0x400012cc,(%esp)
40000013:	e8 28 02 00 00       	call   40000240 <printf>
40000018:	eb 0e                	jmp    40000028 <main+0x28>
4000001a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

    unsigned int i;
    for (i = 0; i < 20; i++) {
40000020:	83 c3 01             	add    $0x1,%ebx
40000023:	83 fb 14             	cmp    $0x14,%ebx
40000026:	74 12                	je     4000003a <main+0x3a>
      if (i % 2 == 0)
40000028:	f6 c3 01             	test   $0x1,%bl
4000002b:	75 f3                	jne    40000020 <main+0x20>
int main (int argc, char **argv)
{
    printf("pong started.\n");

    unsigned int i;
    for (i = 0; i < 20; i++) {
4000002d:	83 c3 01             	add    $0x1,%ebx
      if (i % 2 == 0)
        consume();
40000030:	e8 fb 08 00 00       	call   40000930 <consume>
int main (int argc, char **argv)
{
    printf("pong started.\n");

    unsigned int i;
    for (i = 0; i < 20; i++) {
40000035:	83 fb 14             	cmp    $0x14,%ebx
40000038:	75 ee                	jne    40000028 <main+0x28>
      if (i % 2 == 0)
        consume();
    }

    return 0;
}
4000003a:	31 c0                	xor    %eax,%eax
4000003c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
4000003f:	c9                   	leave  
40000040:	c3                   	ret    

40000041 <_start>:
_start:
	/*
	 * If there are arguments on the stack, then the current stack will not
	 * be aligned to a nice big power-of-two boundary/
	 */
	testl	$0x0fffffff, %esp
40000041:	f7 c4 ff ff ff 0f    	test   $0xfffffff,%esp
	jnz	args_exist
40000047:	75 04                	jne    4000004d <args_exist>

40000049 <noargs>:

noargs:
	/* If no arguments are on the stack, push two dummy zero. */
	pushl	$0
40000049:	6a 00                	push   $0x0
	pushl	$0
4000004b:	6a 00                	push   $0x0

4000004d <args_exist>:

args_exist:
	/* Jump to the C part. */
	call	main
4000004d:	e8 ae ff ff ff       	call   40000000 <main>

	/* When returning, push the return value on the stack. */
	pushl	%eax
40000052:	50                   	push   %eax

40000053 <spin>:
spin:
	//call	yield
	jmp	spin
40000053:	eb fe                	jmp    40000053 <spin>
40000055:	66 90                	xchg   %ax,%ax
40000057:	66 90                	xchg   %ax,%ax
40000059:	66 90                	xchg   %ax,%ax
4000005b:	66 90                	xchg   %ax,%ax
4000005d:	66 90                	xchg   %ax,%ax
4000005f:	90                   	nop

40000060 <debug>:
#include <stdarg.h>
#include <stdio.h>

void
debug(const char *file, int line, const char *fmt, ...)
{
40000060:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	va_start(ap, fmt);
	printf("[D] %s:%d: ", file, line);
40000063:	8b 44 24 24          	mov    0x24(%esp),%eax
40000067:	c7 04 24 38 11 00 40 	movl   $0x40001138,(%esp)
4000006e:	89 44 24 08          	mov    %eax,0x8(%esp)
40000072:	8b 44 24 20          	mov    0x20(%esp),%eax
40000076:	89 44 24 04          	mov    %eax,0x4(%esp)
4000007a:	e8 c1 01 00 00       	call   40000240 <printf>
	vcprintf(fmt, ap);
4000007f:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000083:	89 44 24 04          	mov    %eax,0x4(%esp)
40000087:	8b 44 24 28          	mov    0x28(%esp),%eax
4000008b:	89 04 24             	mov    %eax,(%esp)
4000008e:	e8 4d 01 00 00       	call   400001e0 <vcprintf>
	va_end(ap);
}
40000093:	83 c4 1c             	add    $0x1c,%esp
40000096:	c3                   	ret    
40000097:	89 f6                	mov    %esi,%esi
40000099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

400000a0 <warn>:

void
warn(const char *file, int line, const char *fmt, ...)
{
400000a0:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	va_start(ap, fmt);
	printf("[W] %s:%d: ", file, line);
400000a3:	8b 44 24 24          	mov    0x24(%esp),%eax
400000a7:	c7 04 24 44 11 00 40 	movl   $0x40001144,(%esp)
400000ae:	89 44 24 08          	mov    %eax,0x8(%esp)
400000b2:	8b 44 24 20          	mov    0x20(%esp),%eax
400000b6:	89 44 24 04          	mov    %eax,0x4(%esp)
400000ba:	e8 81 01 00 00       	call   40000240 <printf>
	vcprintf(fmt, ap);
400000bf:	8d 44 24 2c          	lea    0x2c(%esp),%eax
400000c3:	89 44 24 04          	mov    %eax,0x4(%esp)
400000c7:	8b 44 24 28          	mov    0x28(%esp),%eax
400000cb:	89 04 24             	mov    %eax,(%esp)
400000ce:	e8 0d 01 00 00       	call   400001e0 <vcprintf>
	va_end(ap);
}
400000d3:	83 c4 1c             	add    $0x1c,%esp
400000d6:	c3                   	ret    
400000d7:	89 f6                	mov    %esi,%esi
400000d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

400000e0 <panic>:

void
panic(const char *file, int line, const char *fmt, ...)
{
400000e0:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	va_start(ap, fmt);
	printf("[P] %s:%d: ", file, line);
400000e3:	8b 44 24 24          	mov    0x24(%esp),%eax
400000e7:	c7 04 24 50 11 00 40 	movl   $0x40001150,(%esp)
400000ee:	89 44 24 08          	mov    %eax,0x8(%esp)
400000f2:	8b 44 24 20          	mov    0x20(%esp),%eax
400000f6:	89 44 24 04          	mov    %eax,0x4(%esp)
400000fa:	e8 41 01 00 00       	call   40000240 <printf>
	vcprintf(fmt, ap);
400000ff:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000103:	89 44 24 04          	mov    %eax,0x4(%esp)
40000107:	8b 44 24 28          	mov    0x28(%esp),%eax
4000010b:	89 04 24             	mov    %eax,(%esp)
4000010e:	e8 cd 00 00 00       	call   400001e0 <vcprintf>
40000113:	90                   	nop
40000114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	va_end(ap);

	while (1)
		yield();
40000118:	e8 f3 07 00 00       	call   40000910 <yield>
4000011d:	eb f9                	jmp    40000118 <panic+0x38>
4000011f:	90                   	nop

40000120 <atoi>:
#include <stdlib.h>

int
atoi(const char *buf, int *i)
{
40000120:	55                   	push   %ebp
40000121:	57                   	push   %edi
40000122:	56                   	push   %esi
40000123:	53                   	push   %ebx
40000124:	8b 74 24 14          	mov    0x14(%esp),%esi
	int loc = 0;
	int numstart = 0;
	int acc = 0;
	int negative = 0;
	if (buf[loc] == '+')
40000128:	0f b6 06             	movzbl (%esi),%eax
4000012b:	3c 2b                	cmp    $0x2b,%al
4000012d:	74 51                	je     40000180 <atoi+0x60>
		loc++;
	else if (buf[loc] == '-') {
4000012f:	3c 2d                	cmp    $0x2d,%al
40000131:	0f 94 c0             	sete   %al
40000134:	0f b6 c0             	movzbl %al,%eax
40000137:	89 c5                	mov    %eax,%ebp
40000139:	89 c7                	mov    %eax,%edi
		negative = 1;
		loc++;
	}
	numstart = loc;
	// no grab the numbers
	while ('0' <= buf[loc] && buf[loc] <= '9') {
4000013b:	0f be 0c 06          	movsbl (%esi,%eax,1),%ecx
4000013f:	8d 41 d0             	lea    -0x30(%ecx),%eax
40000142:	3c 09                	cmp    $0x9,%al
40000144:	77 4a                	ja     40000190 <atoi+0x70>
40000146:	89 f8                	mov    %edi,%eax
int
atoi(const char *buf, int *i)
{
	int loc = 0;
	int numstart = 0;
	int acc = 0;
40000148:	31 d2                	xor    %edx,%edx
4000014a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	}
	numstart = loc;
	// no grab the numbers
	while ('0' <= buf[loc] && buf[loc] <= '9') {
		acc = acc*10 + (buf[loc]-'0');
		loc++;
40000150:	83 c0 01             	add    $0x1,%eax
		loc++;
	}
	numstart = loc;
	// no grab the numbers
	while ('0' <= buf[loc] && buf[loc] <= '9') {
		acc = acc*10 + (buf[loc]-'0');
40000153:	8d 14 92             	lea    (%edx,%edx,4),%edx
40000156:	8d 54 51 d0          	lea    -0x30(%ecx,%edx,2),%edx
		negative = 1;
		loc++;
	}
	numstart = loc;
	// no grab the numbers
	while ('0' <= buf[loc] && buf[loc] <= '9') {
4000015a:	0f be 0c 06          	movsbl (%esi,%eax,1),%ecx
4000015e:	8d 59 d0             	lea    -0x30(%ecx),%ebx
40000161:	80 fb 09             	cmp    $0x9,%bl
40000164:	76 ea                	jbe    40000150 <atoi+0x30>
		acc = acc*10 + (buf[loc]-'0');
		loc++;
	}
	if (numstart == loc) {
40000166:	39 c7                	cmp    %eax,%edi
40000168:	74 26                	je     40000190 <atoi+0x70>
		// no numbers have actually been scanned
		return 0;
	}
	if (negative)
		acc = - acc;
4000016a:	89 d1                	mov    %edx,%ecx
4000016c:	f7 d9                	neg    %ecx
4000016e:	85 ed                	test   %ebp,%ebp
40000170:	0f 45 d1             	cmovne %ecx,%edx
	*i = acc;
40000173:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000177:	89 11                	mov    %edx,(%ecx)
	return loc;
}
40000179:	5b                   	pop    %ebx
4000017a:	5e                   	pop    %esi
4000017b:	5f                   	pop    %edi
4000017c:	5d                   	pop    %ebp
4000017d:	c3                   	ret    
4000017e:	66 90                	xchg   %ax,%ax
40000180:	b8 01 00 00 00       	mov    $0x1,%eax
atoi(const char *buf, int *i)
{
	int loc = 0;
	int numstart = 0;
	int acc = 0;
	int negative = 0;
40000185:	31 ed                	xor    %ebp,%ebp
	if (buf[loc] == '+')
		loc++;
40000187:	bf 01 00 00 00       	mov    $0x1,%edi
4000018c:	eb ad                	jmp    4000013b <atoi+0x1b>
4000018e:	66 90                	xchg   %ax,%ax
	}
	if (negative)
		acc = - acc;
	*i = acc;
	return loc;
}
40000190:	5b                   	pop    %ebx
		acc = acc*10 + (buf[loc]-'0');
		loc++;
	}
	if (numstart == loc) {
		// no numbers have actually been scanned
		return 0;
40000191:	31 c0                	xor    %eax,%eax
	}
	if (negative)
		acc = - acc;
	*i = acc;
	return loc;
}
40000193:	5e                   	pop    %esi
40000194:	5f                   	pop    %edi
40000195:	5d                   	pop    %ebp
40000196:	c3                   	ret    
40000197:	66 90                	xchg   %ax,%ax
40000199:	66 90                	xchg   %ax,%ax
4000019b:	66 90                	xchg   %ax,%ax
4000019d:	66 90                	xchg   %ax,%ax
4000019f:	90                   	nop

400001a0 <putch>:
	char buf[MAX_BUF];
};

static void
putch(int ch, struct printbuf *b)
{
400001a0:	53                   	push   %ebx
400001a1:	8b 54 24 0c          	mov    0xc(%esp),%edx
	b->buf[b->idx++] = ch;
400001a5:	0f b6 5c 24 08       	movzbl 0x8(%esp),%ebx
400001aa:	8b 0a                	mov    (%edx),%ecx
400001ac:	8d 41 01             	lea    0x1(%ecx),%eax
	if (b->idx == MAX_BUF-1) {
400001af:	3d ff 0f 00 00       	cmp    $0xfff,%eax
};

static void
putch(int ch, struct printbuf *b)
{
	b->buf[b->idx++] = ch;
400001b4:	89 02                	mov    %eax,(%edx)
400001b6:	88 5c 0a 08          	mov    %bl,0x8(%edx,%ecx,1)
	if (b->idx == MAX_BUF-1) {
400001ba:	75 1a                	jne    400001d6 <putch+0x36>
		b->buf[b->idx] = 0;
400001bc:	c6 82 07 10 00 00 00 	movb   $0x0,0x1007(%edx)
		puts(b->buf, b->idx);
400001c3:	8d 5a 08             	lea    0x8(%edx),%ebx
#include <file.h>

static gcc_inline void
sys_puts(const char *s, size_t len)
{
	asm volatile("int %0" :
400001c6:	b9 ff 0f 00 00       	mov    $0xfff,%ecx
400001cb:	66 31 c0             	xor    %ax,%ax
400001ce:	cd 30                	int    $0x30
		b->idx = 0;
400001d0:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
	}
	b->cnt++;
400001d6:	83 42 04 01          	addl   $0x1,0x4(%edx)
}
400001da:	5b                   	pop    %ebx
400001db:	c3                   	ret    
400001dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

400001e0 <vcprintf>:

int
vcprintf(const char *fmt, va_list ap)
{
400001e0:	53                   	push   %ebx
400001e1:	81 ec 28 10 00 00    	sub    $0x1028,%esp
	struct printbuf b;

	b.idx = 0;
	b.cnt = 0;
	vprintfmt((void*)putch, &b, fmt, ap);
400001e7:	8b 84 24 34 10 00 00 	mov    0x1034(%esp),%eax
400001ee:	8d 5c 24 20          	lea    0x20(%esp),%ebx
400001f2:	c7 04 24 a0 01 00 40 	movl   $0x400001a0,(%esp)
int
vcprintf(const char *fmt, va_list ap)
{
	struct printbuf b;

	b.idx = 0;
400001f9:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
40000200:	00 
	b.cnt = 0;
40000201:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
40000208:	00 
	vprintfmt((void*)putch, &b, fmt, ap);
40000209:	89 44 24 0c          	mov    %eax,0xc(%esp)
4000020d:	8b 84 24 30 10 00 00 	mov    0x1030(%esp),%eax
40000214:	89 44 24 08          	mov    %eax,0x8(%esp)
40000218:	8d 44 24 18          	lea    0x18(%esp),%eax
4000021c:	89 44 24 04          	mov    %eax,0x4(%esp)
40000220:	e8 7b 01 00 00       	call   400003a0 <vprintfmt>

	b.buf[b.idx] = 0;
40000225:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000229:	31 c0                	xor    %eax,%eax
4000022b:	c6 44 0c 20 00       	movb   $0x0,0x20(%esp,%ecx,1)
40000230:	cd 30                	int    $0x30
	puts(b.buf, b.idx);

	return b.cnt;
}
40000232:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000236:	81 c4 28 10 00 00    	add    $0x1028,%esp
4000023c:	5b                   	pop    %ebx
4000023d:	c3                   	ret    
4000023e:	66 90                	xchg   %ax,%ax

40000240 <printf>:

int
printf(const char *fmt, ...)
{
40000240:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	int cnt;

	va_start(ap, fmt);
	cnt = vcprintf(fmt, ap);
40000243:	8d 44 24 24          	lea    0x24(%esp),%eax
40000247:	89 44 24 04          	mov    %eax,0x4(%esp)
4000024b:	8b 44 24 20          	mov    0x20(%esp),%eax
4000024f:	89 04 24             	mov    %eax,(%esp)
40000252:	e8 89 ff ff ff       	call   400001e0 <vcprintf>
	va_end(ap);

	return cnt;
}
40000257:	83 c4 1c             	add    $0x1c,%esp
4000025a:	c3                   	ret    
4000025b:	66 90                	xchg   %ax,%ax
4000025d:	66 90                	xchg   %ax,%ax
4000025f:	90                   	nop

40000260 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
40000260:	55                   	push   %ebp
40000261:	57                   	push   %edi
40000262:	89 d7                	mov    %edx,%edi
40000264:	56                   	push   %esi
40000265:	89 c6                	mov    %eax,%esi
40000267:	53                   	push   %ebx
40000268:	83 ec 3c             	sub    $0x3c,%esp
4000026b:	8b 44 24 50          	mov    0x50(%esp),%eax
4000026f:	8b 4c 24 58          	mov    0x58(%esp),%ecx
40000273:	8b 5c 24 5c          	mov    0x5c(%esp),%ebx
40000277:	8b 6c 24 60          	mov    0x60(%esp),%ebp
4000027b:	89 44 24 20          	mov    %eax,0x20(%esp)
4000027f:	8b 44 24 54          	mov    0x54(%esp),%eax
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
40000283:	89 ca                	mov    %ecx,%edx
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
40000285:	89 4c 24 28          	mov    %ecx,0x28(%esp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
40000289:	31 c9                	xor    %ecx,%ecx
4000028b:	89 54 24 18          	mov    %edx,0x18(%esp)
4000028f:	39 c1                	cmp    %eax,%ecx
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
40000291:	89 44 24 24          	mov    %eax,0x24(%esp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
40000295:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
40000299:	0f 83 a9 00 00 00    	jae    40000348 <printnum+0xe8>
		printnum(putch, putdat, num / base, base, width - 1, padc);
4000029f:	8b 44 24 28          	mov    0x28(%esp),%eax
400002a3:	83 eb 01             	sub    $0x1,%ebx
400002a6:	8b 54 24 1c          	mov    0x1c(%esp),%edx
400002aa:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
400002ae:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
400002b2:	89 6c 24 10          	mov    %ebp,0x10(%esp)
400002b6:	89 44 24 08          	mov    %eax,0x8(%esp)
400002ba:	8b 44 24 18          	mov    0x18(%esp),%eax
400002be:	8b 4c 24 08          	mov    0x8(%esp),%ecx
400002c2:	89 54 24 0c          	mov    %edx,0xc(%esp)
400002c6:	89 5c 24 2c          	mov    %ebx,0x2c(%esp)
400002ca:	89 44 24 08          	mov    %eax,0x8(%esp)
400002ce:	8b 44 24 20          	mov    0x20(%esp),%eax
400002d2:	89 4c 24 28          	mov    %ecx,0x28(%esp)
400002d6:	89 04 24             	mov    %eax,(%esp)
400002d9:	8b 44 24 24          	mov    0x24(%esp),%eax
400002dd:	89 44 24 04          	mov    %eax,0x4(%esp)
400002e1:	e8 ca 0b 00 00       	call   40000eb0 <__udivdi3>
400002e6:	8b 4c 24 28          	mov    0x28(%esp),%ecx
400002ea:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
400002ee:	89 4c 24 08          	mov    %ecx,0x8(%esp)
400002f2:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
400002f6:	89 04 24             	mov    %eax,(%esp)
400002f9:	89 f0                	mov    %esi,%eax
400002fb:	89 54 24 04          	mov    %edx,0x4(%esp)
400002ff:	89 fa                	mov    %edi,%edx
40000301:	e8 5a ff ff ff       	call   40000260 <printnum>
		while (--width > 0)
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
40000306:	8b 44 24 18          	mov    0x18(%esp),%eax
4000030a:	8b 54 24 1c          	mov    0x1c(%esp),%edx
4000030e:	89 7c 24 54          	mov    %edi,0x54(%esp)
40000312:	89 44 24 08          	mov    %eax,0x8(%esp)
40000316:	8b 44 24 20          	mov    0x20(%esp),%eax
4000031a:	89 54 24 0c          	mov    %edx,0xc(%esp)
4000031e:	89 04 24             	mov    %eax,(%esp)
40000321:	8b 44 24 24          	mov    0x24(%esp),%eax
40000325:	89 44 24 04          	mov    %eax,0x4(%esp)
40000329:	e8 b2 0c 00 00       	call   40000fe0 <__umoddi3>
4000032e:	0f be 80 5c 11 00 40 	movsbl 0x4000115c(%eax),%eax
40000335:	89 44 24 50          	mov    %eax,0x50(%esp)
}
40000339:	83 c4 3c             	add    $0x3c,%esp
		while (--width > 0)
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
4000033c:	89 f0                	mov    %esi,%eax
}
4000033e:	5b                   	pop    %ebx
4000033f:	5e                   	pop    %esi
40000340:	5f                   	pop    %edi
40000341:	5d                   	pop    %ebp
		while (--width > 0)
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
40000342:	ff e0                	jmp    *%eax
40000344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
40000348:	76 1e                	jbe    40000368 <printnum+0x108>
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
4000034a:	83 eb 01             	sub    $0x1,%ebx
4000034d:	85 db                	test   %ebx,%ebx
4000034f:	7e b5                	jle    40000306 <printnum+0xa6>
40000351:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			putch(padc, putdat);
40000358:	89 7c 24 04          	mov    %edi,0x4(%esp)
4000035c:	89 2c 24             	mov    %ebp,(%esp)
4000035f:	ff d6                	call   *%esi
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
40000361:	83 eb 01             	sub    $0x1,%ebx
40000364:	75 f2                	jne    40000358 <printnum+0xf8>
40000366:	eb 9e                	jmp    40000306 <printnum+0xa6>
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
40000368:	8b 44 24 20          	mov    0x20(%esp),%eax
4000036c:	39 44 24 28          	cmp    %eax,0x28(%esp)
40000370:	0f 86 29 ff ff ff    	jbe    4000029f <printnum+0x3f>
40000376:	eb d2                	jmp    4000034a <printnum+0xea>
40000378:	90                   	nop
40000379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000380 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
40000380:	8b 44 24 08          	mov    0x8(%esp),%eax
	b->cnt++;
	if (b->buf < b->ebuf)
40000384:	8b 10                	mov    (%eax),%edx
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
	b->cnt++;
40000386:	83 40 08 01          	addl   $0x1,0x8(%eax)
	if (b->buf < b->ebuf)
4000038a:	3b 50 04             	cmp    0x4(%eax),%edx
4000038d:	73 0b                	jae    4000039a <sprintputch+0x1a>
		*b->buf++ = ch;
4000038f:	8d 4a 01             	lea    0x1(%edx),%ecx
40000392:	89 08                	mov    %ecx,(%eax)
40000394:	8b 44 24 04          	mov    0x4(%esp),%eax
40000398:	88 02                	mov    %al,(%edx)
4000039a:	f3 c3                	repz ret 
4000039c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

400003a0 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
400003a0:	55                   	push   %ebp
400003a1:	57                   	push   %edi
400003a2:	56                   	push   %esi
400003a3:	53                   	push   %ebx
400003a4:	83 ec 3c             	sub    $0x3c,%esp
400003a7:	8b 6c 24 50          	mov    0x50(%esp),%ebp
400003ab:	8b 74 24 54          	mov    0x54(%esp),%esi
400003af:	8b 7c 24 58          	mov    0x58(%esp),%edi
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
400003b3:	0f b6 07             	movzbl (%edi),%eax
400003b6:	8d 5f 01             	lea    0x1(%edi),%ebx
400003b9:	83 f8 25             	cmp    $0x25,%eax
400003bc:	75 17                	jne    400003d5 <vprintfmt+0x35>
400003be:	eb 28                	jmp    400003e8 <vprintfmt+0x48>
400003c0:	83 c3 01             	add    $0x1,%ebx
			if (ch == '\0')
				return;
			putch(ch, putdat);
400003c3:	89 04 24             	mov    %eax,(%esp)
400003c6:	89 74 24 04          	mov    %esi,0x4(%esp)
400003ca:	ff d5                	call   *%ebp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
400003cc:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
400003d0:	83 f8 25             	cmp    $0x25,%eax
400003d3:	74 13                	je     400003e8 <vprintfmt+0x48>
			if (ch == '\0')
400003d5:	85 c0                	test   %eax,%eax
400003d7:	75 e7                	jne    400003c0 <vprintfmt+0x20>
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
400003d9:	83 c4 3c             	add    $0x3c,%esp
400003dc:	5b                   	pop    %ebx
400003dd:	5e                   	pop    %esi
400003de:	5f                   	pop    %edi
400003df:	5d                   	pop    %ebp
400003e0:	c3                   	ret    
400003e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			if (width < 0)
				width = 0;
			goto reswitch;

		case '#':
			altflag = 1;
400003e8:	c6 44 24 24 20       	movb   $0x20,0x24(%esp)
400003ed:	ba ff ff ff ff       	mov    $0xffffffff,%edx
400003f2:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
400003f9:	00 
400003fa:	c7 44 24 20 ff ff ff 	movl   $0xffffffff,0x20(%esp)
40000401:	ff 
40000402:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
40000409:	00 
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
4000040a:	0f b6 03             	movzbl (%ebx),%eax
4000040d:	8d 7b 01             	lea    0x1(%ebx),%edi
40000410:	0f b6 c8             	movzbl %al,%ecx
40000413:	83 e8 23             	sub    $0x23,%eax
40000416:	3c 55                	cmp    $0x55,%al
40000418:	0f 87 69 02 00 00    	ja     40000687 <vprintfmt+0x2e7>
4000041e:	0f b6 c0             	movzbl %al,%eax
40000421:	ff 24 85 74 11 00 40 	jmp    *0x40001174(,%eax,4)
40000428:	89 fb                	mov    %edi,%ebx
			padc = '-';
			goto reswitch;

			// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
4000042a:	c6 44 24 24 30       	movb   $0x30,0x24(%esp)
4000042f:	eb d9                	jmp    4000040a <vprintfmt+0x6a>
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
				precision = precision * 10 + ch - '0';
				ch = *fmt;
40000431:	0f be 43 01          	movsbl 0x1(%ebx),%eax
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
				precision = precision * 10 + ch - '0';
40000435:	8d 51 d0             	lea    -0x30(%ecx),%edx
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
40000438:	89 fb                	mov    %edi,%ebx
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
4000043a:	8d 48 d0             	lea    -0x30(%eax),%ecx
4000043d:	83 f9 09             	cmp    $0x9,%ecx
40000440:	0f 87 02 02 00 00    	ja     40000648 <vprintfmt+0x2a8>
40000446:	66 90                	xchg   %ax,%ax
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
40000448:	83 c3 01             	add    $0x1,%ebx
				precision = precision * 10 + ch - '0';
4000044b:	8d 14 92             	lea    (%edx,%edx,4),%edx
4000044e:	8d 54 50 d0          	lea    -0x30(%eax,%edx,2),%edx
				ch = *fmt;
40000452:	0f be 03             	movsbl (%ebx),%eax
				if (ch < '0' || ch > '9')
40000455:	8d 48 d0             	lea    -0x30(%eax),%ecx
40000458:	83 f9 09             	cmp    $0x9,%ecx
4000045b:	76 eb                	jbe    40000448 <vprintfmt+0xa8>
4000045d:	e9 e6 01 00 00       	jmp    40000648 <vprintfmt+0x2a8>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
40000462:	8b 44 24 5c          	mov    0x5c(%esp),%eax
			lflag++;
			goto reswitch;

			// character
		case 'c':
			putch(va_arg(ap, int), putdat);
40000466:	89 74 24 04          	mov    %esi,0x4(%esp)
4000046a:	83 44 24 5c 04       	addl   $0x4,0x5c(%esp)
4000046f:	8b 00                	mov    (%eax),%eax
40000471:	89 04 24             	mov    %eax,(%esp)
40000474:	ff d5                	call   *%ebp
			break;
40000476:	e9 38 ff ff ff       	jmp    400003b3 <vprintfmt+0x13>
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, long long);
4000047b:	8b 44 24 5c          	mov    0x5c(%esp),%eax
// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
4000047f:	83 7c 24 28 01       	cmpl   $0x1,0x28(%esp)
		return va_arg(*ap, long long);
40000484:	8b 08                	mov    (%eax),%ecx
// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
40000486:	0f 8e e7 02 00 00    	jle    40000773 <vprintfmt+0x3d3>
		return va_arg(*ap, long long);
4000048c:	8b 58 04             	mov    0x4(%eax),%ebx
4000048f:	83 c0 08             	add    $0x8,%eax
40000492:	89 44 24 5c          	mov    %eax,0x5c(%esp)
				putch(' ', putdat);
			break;

			// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
40000496:	89 ca                	mov    %ecx,%edx
40000498:	89 d9                	mov    %ebx,%ecx
			if ((long long) num < 0) {
4000049a:	85 c9                	test   %ecx,%ecx
4000049c:	bb 0a 00 00 00       	mov    $0xa,%ebx
400004a1:	0f 88 dd 02 00 00    	js     40000784 <vprintfmt+0x3e4>
			// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
			base = 16;
		number:
			printnum(putch, putdat, num, base, width, padc);
400004a7:	0f be 44 24 24       	movsbl 0x24(%esp),%eax
400004ac:	89 14 24             	mov    %edx,(%esp)
400004af:	89 f2                	mov    %esi,%edx
400004b1:	89 5c 24 08          	mov    %ebx,0x8(%esp)
400004b5:	89 4c 24 04          	mov    %ecx,0x4(%esp)
400004b9:	89 44 24 10          	mov    %eax,0x10(%esp)
400004bd:	8b 44 24 20          	mov    0x20(%esp),%eax
400004c1:	89 44 24 0c          	mov    %eax,0xc(%esp)
400004c5:	89 e8                	mov    %ebp,%eax
400004c7:	e8 94 fd ff ff       	call   40000260 <printnum>
			break;
400004cc:	e9 e2 fe ff ff       	jmp    400003b3 <vprintfmt+0x13>
				width = precision, precision = -1;
			goto reswitch;

			// long flag (doubled for long long)
		case 'l':
			lflag++;
400004d1:	83 44 24 28 01       	addl   $0x1,0x28(%esp)
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
400004d6:	89 fb                	mov    %edi,%ebx
			goto reswitch;

			// long flag (doubled for long long)
		case 'l':
			lflag++;
			goto reswitch;
400004d8:	e9 2d ff ff ff       	jmp    4000040a <vprintfmt+0x6a>
			num = getuint(&ap, lflag);
			base = 8;
			goto number;
#else
			// Replace this with your code.
			putch('X', putdat);
400004dd:	89 74 24 04          	mov    %esi,0x4(%esp)
400004e1:	c7 04 24 58 00 00 00 	movl   $0x58,(%esp)
400004e8:	ff d5                	call   *%ebp
			putch('X', putdat);
400004ea:	89 74 24 04          	mov    %esi,0x4(%esp)
400004ee:	c7 04 24 58 00 00 00 	movl   $0x58,(%esp)
400004f5:	ff d5                	call   *%ebp
			putch('X', putdat);
400004f7:	89 74 24 04          	mov    %esi,0x4(%esp)
400004fb:	c7 04 24 58 00 00 00 	movl   $0x58,(%esp)
40000502:	ff d5                	call   *%ebp
			break;
40000504:	e9 aa fe ff ff       	jmp    400003b3 <vprintfmt+0x13>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
40000509:	8b 5c 24 5c          	mov    0x5c(%esp),%ebx
			break;
#endif

			// pointer
		case 'p':
			putch('0', putdat);
4000050d:	89 74 24 04          	mov    %esi,0x4(%esp)
40000511:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
40000518:	ff d5                	call   *%ebp
			putch('x', putdat);
4000051a:	89 74 24 04          	mov    %esi,0x4(%esp)
4000051e:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
40000525:	ff d5                	call   *%ebp
			num = (unsigned long long)
40000527:	8b 13                	mov    (%ebx),%edx
40000529:	31 c9                	xor    %ecx,%ecx
				(uintptr_t) va_arg(ap, void *);
4000052b:	83 44 24 5c 04       	addl   $0x4,0x5c(%esp)
			base = 16;
			goto number;
40000530:	bb 10 00 00 00       	mov    $0x10,%ebx
40000535:	e9 6d ff ff ff       	jmp    400004a7 <vprintfmt+0x107>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
4000053a:	8b 44 24 5c          	mov    0x5c(%esp),%eax
			putch(va_arg(ap, int), putdat);
			break;

			// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
4000053e:	83 44 24 5c 04       	addl   $0x4,0x5c(%esp)
40000543:	8b 08                	mov    (%eax),%ecx
				p = "(null)";
40000545:	b8 6d 11 00 40       	mov    $0x4000116d,%eax
4000054a:	85 c9                	test   %ecx,%ecx
4000054c:	0f 44 c8             	cmove  %eax,%ecx
			if (width > 0 && padc != '-')
4000054f:	80 7c 24 24 2d       	cmpb   $0x2d,0x24(%esp)
40000554:	0f 85 a9 01 00 00    	jne    40000703 <vprintfmt+0x363>
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
4000055a:	0f be 01             	movsbl (%ecx),%eax
4000055d:	8d 59 01             	lea    0x1(%ecx),%ebx
40000560:	85 c0                	test   %eax,%eax
40000562:	0f 84 52 01 00 00    	je     400006ba <vprintfmt+0x31a>
40000568:	89 74 24 54          	mov    %esi,0x54(%esp)
4000056c:	89 de                	mov    %ebx,%esi
4000056e:	89 d3                	mov    %edx,%ebx
40000570:	89 7c 24 58          	mov    %edi,0x58(%esp)
40000574:	8b 7c 24 20          	mov    0x20(%esp),%edi
40000578:	eb 25                	jmp    4000059f <vprintfmt+0x1ff>
4000057a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
40000580:	8b 4c 24 54          	mov    0x54(%esp),%ecx
40000584:	89 04 24             	mov    %eax,(%esp)
40000587:	89 4c 24 04          	mov    %ecx,0x4(%esp)
4000058b:	ff d5                	call   *%ebp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
4000058d:	83 c6 01             	add    $0x1,%esi
40000590:	0f be 46 ff          	movsbl -0x1(%esi),%eax
40000594:	83 ef 01             	sub    $0x1,%edi
40000597:	85 c0                	test   %eax,%eax
40000599:	0f 84 0f 01 00 00    	je     400006ae <vprintfmt+0x30e>
4000059f:	85 db                	test   %ebx,%ebx
400005a1:	78 0c                	js     400005af <vprintfmt+0x20f>
400005a3:	83 eb 01             	sub    $0x1,%ebx
400005a6:	83 fb ff             	cmp    $0xffffffff,%ebx
400005a9:	0f 84 ff 00 00 00    	je     400006ae <vprintfmt+0x30e>
				if (altflag && (ch < ' ' || ch > '~'))
400005af:	8b 54 24 18          	mov    0x18(%esp),%edx
400005b3:	85 d2                	test   %edx,%edx
400005b5:	74 c9                	je     40000580 <vprintfmt+0x1e0>
400005b7:	8d 48 e0             	lea    -0x20(%eax),%ecx
400005ba:	83 f9 5e             	cmp    $0x5e,%ecx
400005bd:	76 c1                	jbe    40000580 <vprintfmt+0x1e0>
					putch('?', putdat);
400005bf:	8b 44 24 54          	mov    0x54(%esp),%eax
400005c3:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
400005ca:	89 44 24 04          	mov    %eax,0x4(%esp)
400005ce:	ff d5                	call   *%ebp
400005d0:	eb bb                	jmp    4000058d <vprintfmt+0x1ed>
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, unsigned long long);
400005d2:	8b 44 24 5c          	mov    0x5c(%esp),%eax
// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
400005d6:	83 7c 24 28 01       	cmpl   $0x1,0x28(%esp)
		return va_arg(*ap, unsigned long long);
400005db:	8b 10                	mov    (%eax),%edx
// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
400005dd:	0f 8e 04 01 00 00    	jle    400006e7 <vprintfmt+0x347>
		return va_arg(*ap, unsigned long long);
400005e3:	8b 48 04             	mov    0x4(%eax),%ecx
400005e6:	83 c0 08             	add    $0x8,%eax
400005e9:	89 44 24 5c          	mov    %eax,0x5c(%esp)

			// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
			base = 10;
			goto number;
400005ed:	bb 0a 00 00 00       	mov    $0xa,%ebx
400005f2:	e9 b0 fe ff ff       	jmp    400004a7 <vprintfmt+0x107>
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, unsigned long long);
400005f7:	8b 44 24 5c          	mov    0x5c(%esp),%eax
// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
400005fb:	83 7c 24 28 01       	cmpl   $0x1,0x28(%esp)
		return va_arg(*ap, unsigned long long);
40000600:	8b 10                	mov    (%eax),%edx
// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
40000602:	0f 8e ed 00 00 00    	jle    400006f5 <vprintfmt+0x355>
		return va_arg(*ap, unsigned long long);
40000608:	8b 48 04             	mov    0x4(%eax),%ecx
4000060b:	83 c0 08             	add    $0x8,%eax
4000060e:	89 44 24 5c          	mov    %eax,0x5c(%esp)
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
				(uintptr_t) va_arg(ap, void *);
			base = 16;
			goto number;
40000612:	bb 10 00 00 00       	mov    $0x10,%ebx
40000617:	e9 8b fe ff ff       	jmp    400004a7 <vprintfmt+0x107>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
4000061c:	89 fb                	mov    %edi,%ebx
			if (width < 0)
				width = 0;
			goto reswitch;

		case '#':
			altflag = 1;
4000061e:	c7 44 24 18 01 00 00 	movl   $0x1,0x18(%esp)
40000625:	00 
			goto reswitch;
40000626:	e9 df fd ff ff       	jmp    4000040a <vprintfmt+0x6a>
			printnum(putch, putdat, num, base, width, padc);
			break;

			// escaped '%' character
		case '%':
			putch(ch, putdat);
4000062b:	89 74 24 04          	mov    %esi,0x4(%esp)
4000062f:	89 0c 24             	mov    %ecx,(%esp)
40000632:	ff d5                	call   *%ebp
			break;
40000634:	e9 7a fd ff ff       	jmp    400003b3 <vprintfmt+0x13>
					break;
			}
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
40000639:	8b 44 24 5c          	mov    0x5c(%esp),%eax
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
4000063d:	89 fb                	mov    %edi,%ebx
					break;
			}
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
4000063f:	8b 10                	mov    (%eax),%edx
40000641:	83 c0 04             	add    $0x4,%eax
40000644:	89 44 24 5c          	mov    %eax,0x5c(%esp)
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
40000648:	8b 7c 24 20          	mov    0x20(%esp),%edi
4000064c:	85 ff                	test   %edi,%edi
4000064e:	0f 89 b6 fd ff ff    	jns    4000040a <vprintfmt+0x6a>
				width = precision, precision = -1;
40000654:	89 54 24 20          	mov    %edx,0x20(%esp)
40000658:	ba ff ff ff ff       	mov    $0xffffffff,%edx
4000065d:	e9 a8 fd ff ff       	jmp    4000040a <vprintfmt+0x6a>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
40000662:	89 fb                	mov    %edi,%ebx

			// flag to pad on the right
		case '-':
			padc = '-';
40000664:	c6 44 24 24 2d       	movb   $0x2d,0x24(%esp)
40000669:	e9 9c fd ff ff       	jmp    4000040a <vprintfmt+0x6a>
4000066e:	8b 4c 24 20          	mov    0x20(%esp),%ecx
40000672:	b8 00 00 00 00       	mov    $0x0,%eax
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
40000677:	89 fb                	mov    %edi,%ebx
40000679:	85 c9                	test   %ecx,%ecx
4000067b:	0f 49 c1             	cmovns %ecx,%eax
4000067e:	89 44 24 20          	mov    %eax,0x20(%esp)
40000682:	e9 83 fd ff ff       	jmp    4000040a <vprintfmt+0x6a>
			putch(ch, putdat);
			break;

			// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
40000687:	89 74 24 04          	mov    %esi,0x4(%esp)
			for (fmt--; fmt[-1] != '%'; fmt--)
4000068b:	89 df                	mov    %ebx,%edi
			putch(ch, putdat);
			break;

			// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
4000068d:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
40000694:	ff d5                	call   *%ebp
			for (fmt--; fmt[-1] != '%'; fmt--)
40000696:	80 7b ff 25          	cmpb   $0x25,-0x1(%ebx)
4000069a:	0f 84 13 fd ff ff    	je     400003b3 <vprintfmt+0x13>
400006a0:	83 ef 01             	sub    $0x1,%edi
400006a3:	80 7f ff 25          	cmpb   $0x25,-0x1(%edi)
400006a7:	75 f7                	jne    400006a0 <vprintfmt+0x300>
400006a9:	e9 05 fd ff ff       	jmp    400003b3 <vprintfmt+0x13>
400006ae:	89 7c 24 20          	mov    %edi,0x20(%esp)
400006b2:	8b 74 24 54          	mov    0x54(%esp),%esi
400006b6:	8b 7c 24 58          	mov    0x58(%esp),%edi
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
400006ba:	8b 4c 24 20          	mov    0x20(%esp),%ecx
400006be:	8b 5c 24 20          	mov    0x20(%esp),%ebx
400006c2:	85 c9                	test   %ecx,%ecx
400006c4:	0f 8e e9 fc ff ff    	jle    400003b3 <vprintfmt+0x13>
400006ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
				putch(' ', putdat);
400006d0:	89 74 24 04          	mov    %esi,0x4(%esp)
400006d4:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
400006db:	ff d5                	call   *%ebp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
400006dd:	83 eb 01             	sub    $0x1,%ebx
400006e0:	75 ee                	jne    400006d0 <vprintfmt+0x330>
400006e2:	e9 cc fc ff ff       	jmp    400003b3 <vprintfmt+0x13>
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, unsigned long long);
	else if (lflag)
		return va_arg(*ap, unsigned long);
400006e7:	83 c0 04             	add    $0x4,%eax
400006ea:	31 c9                	xor    %ecx,%ecx
400006ec:	89 44 24 5c          	mov    %eax,0x5c(%esp)
400006f0:	e9 f8 fe ff ff       	jmp    400005ed <vprintfmt+0x24d>
400006f5:	83 c0 04             	add    $0x4,%eax
400006f8:	31 c9                	xor    %ecx,%ecx
400006fa:	89 44 24 5c          	mov    %eax,0x5c(%esp)
400006fe:	e9 0f ff ff ff       	jmp    40000612 <vprintfmt+0x272>

			// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
40000703:	8b 5c 24 20          	mov    0x20(%esp),%ebx
40000707:	85 db                	test   %ebx,%ebx
40000709:	0f 8e 4b fe ff ff    	jle    4000055a <vprintfmt+0x1ba>
				for (width -= strnlen(p, precision); width > 0; width--)
4000070f:	89 54 24 04          	mov    %edx,0x4(%esp)
40000713:	89 0c 24             	mov    %ecx,(%esp)
40000716:	89 54 24 2c          	mov    %edx,0x2c(%esp)
4000071a:	89 4c 24 28          	mov    %ecx,0x28(%esp)
4000071e:	e8 ad 02 00 00       	call   400009d0 <strnlen>
40000723:	8b 4c 24 28          	mov    0x28(%esp),%ecx
40000727:	8b 54 24 2c          	mov    0x2c(%esp),%edx
4000072b:	29 44 24 20          	sub    %eax,0x20(%esp)
4000072f:	8b 44 24 20          	mov    0x20(%esp),%eax
40000733:	85 c0                	test   %eax,%eax
40000735:	0f 8e 1f fe ff ff    	jle    4000055a <vprintfmt+0x1ba>
4000073b:	0f be 5c 24 24       	movsbl 0x24(%esp),%ebx
40000740:	89 7c 24 58          	mov    %edi,0x58(%esp)
40000744:	89 c7                	mov    %eax,%edi
40000746:	89 4c 24 20          	mov    %ecx,0x20(%esp)
4000074a:	89 54 24 24          	mov    %edx,0x24(%esp)
4000074e:	66 90                	xchg   %ax,%ax
					putch(padc, putdat);
40000750:	89 74 24 04          	mov    %esi,0x4(%esp)
40000754:	89 1c 24             	mov    %ebx,(%esp)
40000757:	ff d5                	call   *%ebp
			// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
40000759:	83 ef 01             	sub    $0x1,%edi
4000075c:	75 f2                	jne    40000750 <vprintfmt+0x3b0>
4000075e:	8b 4c 24 20          	mov    0x20(%esp),%ecx
40000762:	8b 54 24 24          	mov    0x24(%esp),%edx
40000766:	89 7c 24 20          	mov    %edi,0x20(%esp)
4000076a:	8b 7c 24 58          	mov    0x58(%esp),%edi
4000076e:	e9 e7 fd ff ff       	jmp    4000055a <vprintfmt+0x1ba>
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, long long);
	else if (lflag)
		return va_arg(*ap, long);
40000773:	89 cb                	mov    %ecx,%ebx
40000775:	83 c0 04             	add    $0x4,%eax
40000778:	c1 fb 1f             	sar    $0x1f,%ebx
4000077b:	89 44 24 5c          	mov    %eax,0x5c(%esp)
4000077f:	e9 12 fd ff ff       	jmp    40000496 <vprintfmt+0xf6>
40000784:	89 54 24 18          	mov    %edx,0x18(%esp)
40000788:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)

			// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
			if ((long long) num < 0) {
				putch('-', putdat);
4000078c:	89 74 24 04          	mov    %esi,0x4(%esp)
40000790:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
40000797:	ff d5                	call   *%ebp
				num = -(long long) num;
40000799:	8b 54 24 18          	mov    0x18(%esp),%edx
4000079d:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
400007a1:	f7 da                	neg    %edx
400007a3:	83 d1 00             	adc    $0x0,%ecx
400007a6:	f7 d9                	neg    %ecx
400007a8:	e9 fa fc ff ff       	jmp    400004a7 <vprintfmt+0x107>
400007ad:	8d 76 00             	lea    0x0(%esi),%esi

400007b0 <printfmt>:
	}
}

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
400007b0:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;

	va_start(ap, fmt);
	vprintfmt(putch, putdat, fmt, ap);
400007b3:	8d 44 24 2c          	lea    0x2c(%esp),%eax
400007b7:	89 44 24 0c          	mov    %eax,0xc(%esp)
400007bb:	8b 44 24 28          	mov    0x28(%esp),%eax
400007bf:	89 44 24 08          	mov    %eax,0x8(%esp)
400007c3:	8b 44 24 24          	mov    0x24(%esp),%eax
400007c7:	89 44 24 04          	mov    %eax,0x4(%esp)
400007cb:	8b 44 24 20          	mov    0x20(%esp),%eax
400007cf:	89 04 24             	mov    %eax,(%esp)
400007d2:	e8 c9 fb ff ff       	call   400003a0 <vprintfmt>
	va_end(ap);
}
400007d7:	83 c4 1c             	add    $0x1c,%esp
400007da:	c3                   	ret    
400007db:	90                   	nop
400007dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

400007e0 <vsprintf>:
		*b->buf++ = ch;
}

int
vsprintf(char *buf, const char *fmt, va_list ap)
{
400007e0:	83 ec 2c             	sub    $0x2c,%esp
	//assert(buf != NULL);
	struct sprintbuf b = {buf, (char*)(intptr_t)~0, 0};
400007e3:	8b 44 24 30          	mov    0x30(%esp),%eax

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
400007e7:	c7 04 24 80 03 00 40 	movl   $0x40000380,(%esp)

int
vsprintf(char *buf, const char *fmt, va_list ap)
{
	//assert(buf != NULL);
	struct sprintbuf b = {buf, (char*)(intptr_t)~0, 0};
400007ee:	c7 44 24 18 ff ff ff 	movl   $0xffffffff,0x18(%esp)
400007f5:	ff 
400007f6:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
400007fd:	00 
400007fe:	89 44 24 14          	mov    %eax,0x14(%esp)

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
40000802:	8b 44 24 38          	mov    0x38(%esp),%eax
40000806:	89 44 24 0c          	mov    %eax,0xc(%esp)
4000080a:	8b 44 24 34          	mov    0x34(%esp),%eax
4000080e:	89 44 24 08          	mov    %eax,0x8(%esp)
40000812:	8d 44 24 14          	lea    0x14(%esp),%eax
40000816:	89 44 24 04          	mov    %eax,0x4(%esp)
4000081a:	e8 81 fb ff ff       	call   400003a0 <vprintfmt>

	// null terminate the buffer
	*b.buf = '\0';
4000081f:	8b 44 24 14          	mov    0x14(%esp),%eax
40000823:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
}
40000826:	8b 44 24 1c          	mov    0x1c(%esp),%eax
4000082a:	83 c4 2c             	add    $0x2c,%esp
4000082d:	c3                   	ret    
4000082e:	66 90                	xchg   %ax,%ax

40000830 <sprintf>:

int
sprintf(char *buf, const char *fmt, ...)
{
40000830:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
	rc = vsprintf(buf, fmt, ap);
40000833:	8d 44 24 28          	lea    0x28(%esp),%eax
40000837:	89 44 24 08          	mov    %eax,0x8(%esp)
4000083b:	8b 44 24 24          	mov    0x24(%esp),%eax
4000083f:	89 44 24 04          	mov    %eax,0x4(%esp)
40000843:	8b 44 24 20          	mov    0x20(%esp),%eax
40000847:	89 04 24             	mov    %eax,(%esp)
4000084a:	e8 91 ff ff ff       	call   400007e0 <vsprintf>
	va_end(ap);

	return rc;
}
4000084f:	83 c4 1c             	add    $0x1c,%esp
40000852:	c3                   	ret    
40000853:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000860 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
40000860:	83 ec 2c             	sub    $0x2c,%esp
40000863:	8b 44 24 30          	mov    0x30(%esp),%eax
	//assert(buf != NULL && n > 0);
	struct sprintbuf b = {buf, buf+n-1, 0};
40000867:	8b 54 24 34          	mov    0x34(%esp),%edx

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
4000086b:	c7 04 24 80 03 00 40 	movl   $0x40000380,(%esp)

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
	//assert(buf != NULL && n > 0);
	struct sprintbuf b = {buf, buf+n-1, 0};
40000872:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
40000879:	00 
4000087a:	89 44 24 14          	mov    %eax,0x14(%esp)
4000087e:	8d 44 10 ff          	lea    -0x1(%eax,%edx,1),%eax
40000882:	89 44 24 18          	mov    %eax,0x18(%esp)

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
40000886:	8b 44 24 3c          	mov    0x3c(%esp),%eax
4000088a:	89 44 24 0c          	mov    %eax,0xc(%esp)
4000088e:	8b 44 24 38          	mov    0x38(%esp),%eax
40000892:	89 44 24 08          	mov    %eax,0x8(%esp)
40000896:	8d 44 24 14          	lea    0x14(%esp),%eax
4000089a:	89 44 24 04          	mov    %eax,0x4(%esp)
4000089e:	e8 fd fa ff ff       	call   400003a0 <vprintfmt>

	// null terminate the buffer
	*b.buf = '\0';
400008a3:	8b 44 24 14          	mov    0x14(%esp),%eax
400008a7:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
}
400008aa:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400008ae:	83 c4 2c             	add    $0x2c,%esp
400008b1:	c3                   	ret    
400008b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400008b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

400008c0 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
400008c0:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
	rc = vsnprintf(buf, n, fmt, ap);
400008c3:	8d 44 24 2c          	lea    0x2c(%esp),%eax
400008c7:	89 44 24 0c          	mov    %eax,0xc(%esp)
400008cb:	8b 44 24 28          	mov    0x28(%esp),%eax
400008cf:	89 44 24 08          	mov    %eax,0x8(%esp)
400008d3:	8b 44 24 24          	mov    0x24(%esp),%eax
400008d7:	89 44 24 04          	mov    %eax,0x4(%esp)
400008db:	8b 44 24 20          	mov    0x20(%esp),%eax
400008df:	89 04 24             	mov    %eax,(%esp)
400008e2:	e8 79 ff ff ff       	call   40000860 <vsnprintf>
	va_end(ap);

	return rc;
}
400008e7:	83 c4 1c             	add    $0x1c,%esp
400008ea:	c3                   	ret    
400008eb:	66 90                	xchg   %ax,%ax
400008ed:	66 90                	xchg   %ax,%ax
400008ef:	90                   	nop

400008f0 <spawn>:
#include <syscall.h>
#include <types.h>

pid_t
spawn(uintptr_t exec, unsigned int quota)
{
400008f0:	53                   	push   %ebx
sys_spawn(uintptr_t exec, unsigned int quota)
{
	int errno;
	pid_t pid;

	asm volatile("int %2"
400008f1:	b8 01 00 00 00       	mov    $0x1,%eax
400008f6:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
400008fa:	8b 5c 24 08          	mov    0x8(%esp),%ebx
400008fe:	cd 30                	int    $0x30
		       "a" (SYS_spawn),
		       "b" (exec),
		       "c" (quota)
		     : "cc", "memory");

	return errno ? -1 : pid;
40000900:	ba ff ff ff ff       	mov    $0xffffffff,%edx
40000905:	85 c0                	test   %eax,%eax
40000907:	0f 44 d3             	cmove  %ebx,%edx
	return sys_spawn(exec, quota);
}
4000090a:	89 d0                	mov    %edx,%eax
4000090c:	5b                   	pop    %ebx
4000090d:	c3                   	ret    
4000090e:	66 90                	xchg   %ax,%ax

40000910 <yield>:
}

static gcc_inline void
sys_yield(void)
{
	asm volatile("int %0" :
40000910:	b8 02 00 00 00       	mov    $0x2,%eax
40000915:	cd 30                	int    $0x30
40000917:	c3                   	ret    
40000918:	90                   	nop
40000919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000920 <produce>:
}

static gcc_inline void
sys_produce(void)
{
	asm volatile("int %0" :
40000920:	b8 03 00 00 00       	mov    $0x3,%eax
40000925:	cd 30                	int    $0x30
40000927:	c3                   	ret    
40000928:	90                   	nop
40000929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000930 <consume>:
}

static gcc_inline void
sys_consume(void)
{
	asm volatile("int %0" :
40000930:	b8 04 00 00 00       	mov    $0x4,%eax
40000935:	cd 30                	int    $0x30
40000937:	c3                   	ret    
40000938:	66 90                	xchg   %ax,%ax
4000093a:	66 90                	xchg   %ax,%ax
4000093c:	66 90                	xchg   %ax,%ax
4000093e:	66 90                	xchg   %ax,%ax

40000940 <spinlock_init>:
}

void
spinlock_init(spinlock_t *lk)
{
	*lk = 0;
40000940:	8b 44 24 04          	mov    0x4(%esp),%eax
40000944:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
4000094a:	c3                   	ret    
4000094b:	90                   	nop
4000094c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000950 <spinlock_acquire>:
}

void
spinlock_acquire(spinlock_t *lk)
{
40000950:	8b 54 24 04          	mov    0x4(%esp),%edx
static inline uint32_t
xchg(volatile uint32_t *addr, uint32_t newval)
{
	uint32_t result;

	asm volatile("lock; xchgl %0, %1" :
40000954:	b8 01 00 00 00       	mov    $0x1,%eax
40000959:	f0 87 02             	lock xchg %eax,(%edx)
}

void
spinlock_acquire(spinlock_t *lk)
{
	while(xchg(lk, 1) != 0)
4000095c:	85 c0                	test   %eax,%eax
static inline uint32_t
xchg(volatile uint32_t *addr, uint32_t newval)
{
	uint32_t result;

	asm volatile("lock; xchgl %0, %1" :
4000095e:	b9 01 00 00 00       	mov    $0x1,%ecx
}

void
spinlock_acquire(spinlock_t *lk)
{
	while(xchg(lk, 1) != 0)
40000963:	74 0e                	je     40000973 <spinlock_acquire+0x23>
40000965:	8d 76 00             	lea    0x0(%esi),%esi
		asm volatile("pause");
40000968:	f3 90                	pause  
static inline uint32_t
xchg(volatile uint32_t *addr, uint32_t newval)
{
	uint32_t result;

	asm volatile("lock; xchgl %0, %1" :
4000096a:	89 c8                	mov    %ecx,%eax
4000096c:	f0 87 02             	lock xchg %eax,(%edx)
}

void
spinlock_acquire(spinlock_t *lk)
{
	while(xchg(lk, 1) != 0)
4000096f:	85 c0                	test   %eax,%eax
40000971:	75 f5                	jne    40000968 <spinlock_acquire+0x18>
40000973:	f3 c3                	repz ret 
40000975:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000980 <spinlock_release>:
}

// Release the lock.
void
spinlock_release(spinlock_t *lk)
{
40000980:	8b 54 24 04          	mov    0x4(%esp),%edx

// Check whether this cpu is holding the lock.
bool
spinlock_holding(spinlock_t *lock)
{
	return *lock;
40000984:	8b 02                	mov    (%edx),%eax

// Release the lock.
void
spinlock_release(spinlock_t *lk)
{
	if (spinlock_holding(lk) == FALSE)
40000986:	84 c0                	test   %al,%al
40000988:	74 05                	je     4000098f <spinlock_release+0xf>
static inline uint32_t
xchg(volatile uint32_t *addr, uint32_t newval)
{
	uint32_t result;

	asm volatile("lock; xchgl %0, %1" :
4000098a:	31 c0                	xor    %eax,%eax
4000098c:	f0 87 02             	lock xchg %eax,(%edx)
4000098f:	f3 c3                	repz ret 
40000991:	eb 0d                	jmp    400009a0 <spinlock_holding>
40000993:	90                   	nop
40000994:	90                   	nop
40000995:	90                   	nop
40000996:	90                   	nop
40000997:	90                   	nop
40000998:	90                   	nop
40000999:	90                   	nop
4000099a:	90                   	nop
4000099b:	90                   	nop
4000099c:	90                   	nop
4000099d:	90                   	nop
4000099e:	90                   	nop
4000099f:	90                   	nop

400009a0 <spinlock_holding>:

// Check whether this cpu is holding the lock.
bool
spinlock_holding(spinlock_t *lock)
{
	return *lock;
400009a0:	8b 44 24 04          	mov    0x4(%esp),%eax
400009a4:	8b 00                	mov    (%eax),%eax
}
400009a6:	c3                   	ret    
400009a7:	66 90                	xchg   %ax,%ax
400009a9:	66 90                	xchg   %ax,%ax
400009ab:	66 90                	xchg   %ax,%ax
400009ad:	66 90                	xchg   %ax,%ax
400009af:	90                   	nop

400009b0 <strlen>:
#include <string.h>
#include <types.h>

int
strlen(const char *s)
{
400009b0:	8b 54 24 04          	mov    0x4(%esp),%edx
	int n;

	for (n = 0; *s != '\0'; s++)
400009b4:	31 c0                	xor    %eax,%eax
400009b6:	80 3a 00             	cmpb   $0x0,(%edx)
400009b9:	74 10                	je     400009cb <strlen+0x1b>
400009bb:	90                   	nop
400009bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		n++;
400009c0:	83 c0 01             	add    $0x1,%eax
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
400009c3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
400009c7:	75 f7                	jne    400009c0 <strlen+0x10>
400009c9:	f3 c3                	repz ret 
		n++;
	return n;
}
400009cb:	f3 c3                	repz ret 
400009cd:	8d 76 00             	lea    0x0(%esi),%esi

400009d0 <strnlen>:

int
strnlen(const char *s, size_t size)
{
400009d0:	53                   	push   %ebx
400009d1:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
400009d5:	8b 5c 24 08          	mov    0x8(%esp),%ebx
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
400009d9:	85 c9                	test   %ecx,%ecx
400009db:	74 25                	je     40000a02 <strnlen+0x32>
400009dd:	80 3b 00             	cmpb   $0x0,(%ebx)
400009e0:	74 20                	je     40000a02 <strnlen+0x32>
400009e2:	ba 01 00 00 00       	mov    $0x1,%edx
400009e7:	eb 11                	jmp    400009fa <strnlen+0x2a>
400009e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400009f0:	83 c2 01             	add    $0x1,%edx
400009f3:	80 7c 13 ff 00       	cmpb   $0x0,-0x1(%ebx,%edx,1)
400009f8:	74 06                	je     40000a00 <strnlen+0x30>
400009fa:	39 ca                	cmp    %ecx,%edx
		n++;
400009fc:	89 d0                	mov    %edx,%eax
int
strnlen(const char *s, size_t size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
400009fe:	75 f0                	jne    400009f0 <strnlen+0x20>
		n++;
	return n;
}
40000a00:	5b                   	pop    %ebx
40000a01:	c3                   	ret    
int
strnlen(const char *s, size_t size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000a02:	31 c0                	xor    %eax,%eax
		n++;
	return n;
}
40000a04:	5b                   	pop    %ebx
40000a05:	c3                   	ret    
40000a06:	8d 76 00             	lea    0x0(%esi),%esi
40000a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000a10 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
40000a10:	53                   	push   %ebx
40000a11:	8b 44 24 08          	mov    0x8(%esp),%eax
40000a15:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
	char *ret;

	ret = dst;
	while ((*dst++ = *src++) != '\0')
40000a19:	89 c2                	mov    %eax,%edx
40000a1b:	90                   	nop
40000a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000a20:	83 c1 01             	add    $0x1,%ecx
40000a23:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
40000a27:	83 c2 01             	add    $0x1,%edx
40000a2a:	84 db                	test   %bl,%bl
40000a2c:	88 5a ff             	mov    %bl,-0x1(%edx)
40000a2f:	75 ef                	jne    40000a20 <strcpy+0x10>
		/* do nothing */;
	return ret;
}
40000a31:	5b                   	pop    %ebx
40000a32:	c3                   	ret    
40000a33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000a40 <strncpy>:

char *
strncpy(char *dst, const char *src, size_t size)
{
40000a40:	57                   	push   %edi
40000a41:	56                   	push   %esi
40000a42:	53                   	push   %ebx
40000a43:	8b 74 24 18          	mov    0x18(%esp),%esi
40000a47:	8b 7c 24 10          	mov    0x10(%esp),%edi
40000a4b:	8b 4c 24 14          	mov    0x14(%esp),%ecx
	size_t i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
40000a4f:	85 f6                	test   %esi,%esi
40000a51:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
40000a54:	89 fa                	mov    %edi,%edx
40000a56:	74 13                	je     40000a6b <strncpy+0x2b>
		*dst++ = *src;
40000a58:	0f b6 01             	movzbl (%ecx),%eax
40000a5b:	83 c2 01             	add    $0x1,%edx
40000a5e:	88 42 ff             	mov    %al,-0x1(%edx)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
40000a61:	80 39 01             	cmpb   $0x1,(%ecx)
40000a64:	83 d9 ff             	sbb    $0xffffffff,%ecx
{
	size_t i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
40000a67:	39 da                	cmp    %ebx,%edx
40000a69:	75 ed                	jne    40000a58 <strncpy+0x18>
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
}
40000a6b:	89 f8                	mov    %edi,%eax
40000a6d:	5b                   	pop    %ebx
40000a6e:	5e                   	pop    %esi
40000a6f:	5f                   	pop    %edi
40000a70:	c3                   	ret    
40000a71:	eb 0d                	jmp    40000a80 <strlcpy>
40000a73:	90                   	nop
40000a74:	90                   	nop
40000a75:	90                   	nop
40000a76:	90                   	nop
40000a77:	90                   	nop
40000a78:	90                   	nop
40000a79:	90                   	nop
40000a7a:	90                   	nop
40000a7b:	90                   	nop
40000a7c:	90                   	nop
40000a7d:	90                   	nop
40000a7e:	90                   	nop
40000a7f:	90                   	nop

40000a80 <strlcpy>:

size_t
strlcpy(char *dst, const char *src, size_t size)
{
40000a80:	56                   	push   %esi
40000a81:	31 c0                	xor    %eax,%eax
40000a83:	53                   	push   %ebx
40000a84:	8b 74 24 14          	mov    0x14(%esp),%esi
40000a88:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
40000a8c:	85 f6                	test   %esi,%esi
40000a8e:	74 36                	je     40000ac6 <strlcpy+0x46>
		while (--size > 0 && *src != '\0')
40000a90:	83 fe 01             	cmp    $0x1,%esi
40000a93:	74 34                	je     40000ac9 <strlcpy+0x49>
40000a95:	0f b6 0b             	movzbl (%ebx),%ecx
40000a98:	84 c9                	test   %cl,%cl
40000a9a:	74 2d                	je     40000ac9 <strlcpy+0x49>
40000a9c:	83 ee 02             	sub    $0x2,%esi
40000a9f:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000aa3:	eb 0e                	jmp    40000ab3 <strlcpy+0x33>
40000aa5:	8d 76 00             	lea    0x0(%esi),%esi
40000aa8:	83 c0 01             	add    $0x1,%eax
40000aab:	0f b6 0c 03          	movzbl (%ebx,%eax,1),%ecx
40000aaf:	84 c9                	test   %cl,%cl
40000ab1:	74 0a                	je     40000abd <strlcpy+0x3d>
			*dst++ = *src++;
40000ab3:	83 c2 01             	add    $0x1,%edx
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
40000ab6:	39 f0                	cmp    %esi,%eax
			*dst++ = *src++;
40000ab8:	88 4a ff             	mov    %cl,-0x1(%edx)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
40000abb:	75 eb                	jne    40000aa8 <strlcpy+0x28>
40000abd:	89 d0                	mov    %edx,%eax
40000abf:	2b 44 24 0c          	sub    0xc(%esp),%eax
			*dst++ = *src++;
		*dst = '\0';
40000ac3:	c6 02 00             	movb   $0x0,(%edx)
	}
	return dst - dst_in;
}
40000ac6:	5b                   	pop    %ebx
40000ac7:	5e                   	pop    %esi
40000ac8:	c3                   	ret    
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
40000ac9:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000acd:	eb f4                	jmp    40000ac3 <strlcpy+0x43>
40000acf:	90                   	nop

40000ad0 <strcmp>:
	return dst - dst_in;
}

int
strcmp(const char *p, const char *q)
{
40000ad0:	53                   	push   %ebx
40000ad1:	8b 54 24 08          	mov    0x8(%esp),%edx
40000ad5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
	while (*p && *p == *q)
40000ad9:	0f b6 02             	movzbl (%edx),%eax
40000adc:	84 c0                	test   %al,%al
40000ade:	74 2d                	je     40000b0d <strcmp+0x3d>
40000ae0:	0f b6 19             	movzbl (%ecx),%ebx
40000ae3:	38 d8                	cmp    %bl,%al
40000ae5:	74 0f                	je     40000af6 <strcmp+0x26>
40000ae7:	eb 2b                	jmp    40000b14 <strcmp+0x44>
40000ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000af0:	38 c8                	cmp    %cl,%al
40000af2:	75 15                	jne    40000b09 <strcmp+0x39>
		p++, q++;
40000af4:	89 d9                	mov    %ebx,%ecx
40000af6:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
40000af9:	0f b6 02             	movzbl (%edx),%eax
		p++, q++;
40000afc:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
40000aff:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
40000b03:	84 c0                	test   %al,%al
40000b05:	75 e9                	jne    40000af0 <strcmp+0x20>
40000b07:	31 c0                	xor    %eax,%eax
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
40000b09:	29 c8                	sub    %ecx,%eax
}
40000b0b:	5b                   	pop    %ebx
40000b0c:	c3                   	ret    
40000b0d:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
40000b10:	31 c0                	xor    %eax,%eax
40000b12:	eb f5                	jmp    40000b09 <strcmp+0x39>
40000b14:	0f b6 cb             	movzbl %bl,%ecx
40000b17:	eb f0                	jmp    40000b09 <strcmp+0x39>
40000b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000b20 <strncmp>:
	return (int) ((unsigned char) *p - (unsigned char) *q);
}

int
strncmp(const char *p, const char *q, size_t n)
{
40000b20:	56                   	push   %esi
40000b21:	53                   	push   %ebx
40000b22:	8b 74 24 14          	mov    0x14(%esp),%esi
40000b26:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000b2a:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	while (n > 0 && *p && *p == *q)
40000b2e:	85 f6                	test   %esi,%esi
40000b30:	74 30                	je     40000b62 <strncmp+0x42>
40000b32:	0f b6 01             	movzbl (%ecx),%eax
40000b35:	84 c0                	test   %al,%al
40000b37:	74 2e                	je     40000b67 <strncmp+0x47>
40000b39:	0f b6 13             	movzbl (%ebx),%edx
40000b3c:	38 d0                	cmp    %dl,%al
40000b3e:	75 3e                	jne    40000b7e <strncmp+0x5e>
40000b40:	8d 51 01             	lea    0x1(%ecx),%edx
40000b43:	01 ce                	add    %ecx,%esi
40000b45:	eb 14                	jmp    40000b5b <strncmp+0x3b>
40000b47:	90                   	nop
40000b48:	0f b6 02             	movzbl (%edx),%eax
40000b4b:	84 c0                	test   %al,%al
40000b4d:	74 29                	je     40000b78 <strncmp+0x58>
40000b4f:	0f b6 19             	movzbl (%ecx),%ebx
40000b52:	83 c2 01             	add    $0x1,%edx
40000b55:	38 d8                	cmp    %bl,%al
40000b57:	75 17                	jne    40000b70 <strncmp+0x50>
		n--, p++, q++;
40000b59:	89 cb                	mov    %ecx,%ebx
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
40000b5b:	39 f2                	cmp    %esi,%edx
		n--, p++, q++;
40000b5d:	8d 4b 01             	lea    0x1(%ebx),%ecx
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
40000b60:	75 e6                	jne    40000b48 <strncmp+0x28>
		n--, p++, q++;
	if (n == 0)
		return 0;
40000b62:	31 c0                	xor    %eax,%eax
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
}
40000b64:	5b                   	pop    %ebx
40000b65:	5e                   	pop    %esi
40000b66:	c3                   	ret    
40000b67:	0f b6 1b             	movzbl (%ebx),%ebx
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
40000b6a:	31 c0                	xor    %eax,%eax
40000b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		n--, p++, q++;
	if (n == 0)
		return 0;
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
40000b70:	0f b6 d3             	movzbl %bl,%edx
40000b73:	29 d0                	sub    %edx,%eax
}
40000b75:	5b                   	pop    %ebx
40000b76:	5e                   	pop    %esi
40000b77:	c3                   	ret    
40000b78:	0f b6 5b 01          	movzbl 0x1(%ebx),%ebx
40000b7c:	eb f2                	jmp    40000b70 <strncmp+0x50>
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
40000b7e:	89 d3                	mov    %edx,%ebx
40000b80:	eb ee                	jmp    40000b70 <strncmp+0x50>
40000b82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000b90 <strchr>:
		return (int) ((unsigned char) *p - (unsigned char) *q);
}

char *
strchr(const char *s, char c)
{
40000b90:	53                   	push   %ebx
40000b91:	8b 44 24 08          	mov    0x8(%esp),%eax
40000b95:	8b 54 24 0c          	mov    0xc(%esp),%edx
	for (; *s; s++)
40000b99:	0f b6 18             	movzbl (%eax),%ebx
40000b9c:	84 db                	test   %bl,%bl
40000b9e:	74 16                	je     40000bb6 <strchr+0x26>
		if (*s == c)
40000ba0:	38 d3                	cmp    %dl,%bl
40000ba2:	89 d1                	mov    %edx,%ecx
40000ba4:	75 06                	jne    40000bac <strchr+0x1c>
40000ba6:	eb 10                	jmp    40000bb8 <strchr+0x28>
40000ba8:	38 ca                	cmp    %cl,%dl
40000baa:	74 0c                	je     40000bb8 <strchr+0x28>
}

char *
strchr(const char *s, char c)
{
	for (; *s; s++)
40000bac:	83 c0 01             	add    $0x1,%eax
40000baf:	0f b6 10             	movzbl (%eax),%edx
40000bb2:	84 d2                	test   %dl,%dl
40000bb4:	75 f2                	jne    40000ba8 <strchr+0x18>
		if (*s == c)
			return (char *) s;
	return 0;
40000bb6:	31 c0                	xor    %eax,%eax
}
40000bb8:	5b                   	pop    %ebx
40000bb9:	c3                   	ret    
40000bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000bc0 <strfind>:

char *
strfind(const char *s, char c)
{
40000bc0:	53                   	push   %ebx
40000bc1:	8b 44 24 08          	mov    0x8(%esp),%eax
40000bc5:	8b 54 24 0c          	mov    0xc(%esp),%edx
	for (; *s; s++)
40000bc9:	0f b6 18             	movzbl (%eax),%ebx
40000bcc:	84 db                	test   %bl,%bl
40000bce:	74 16                	je     40000be6 <strfind+0x26>
		if (*s == c)
40000bd0:	38 d3                	cmp    %dl,%bl
40000bd2:	89 d1                	mov    %edx,%ecx
40000bd4:	75 06                	jne    40000bdc <strfind+0x1c>
40000bd6:	eb 0e                	jmp    40000be6 <strfind+0x26>
40000bd8:	38 ca                	cmp    %cl,%dl
40000bda:	74 0a                	je     40000be6 <strfind+0x26>
}

char *
strfind(const char *s, char c)
{
	for (; *s; s++)
40000bdc:	83 c0 01             	add    $0x1,%eax
40000bdf:	0f b6 10             	movzbl (%eax),%edx
40000be2:	84 d2                	test   %dl,%dl
40000be4:	75 f2                	jne    40000bd8 <strfind+0x18>
		if (*s == c)
			break;
	return (char *) s;
}
40000be6:	5b                   	pop    %ebx
40000be7:	c3                   	ret    
40000be8:	90                   	nop
40000be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000bf0 <strtol>:


long
strtol(const char *s, char **endptr, int base)
{
40000bf0:	55                   	push   %ebp
40000bf1:	57                   	push   %edi
40000bf2:	56                   	push   %esi
40000bf3:	53                   	push   %ebx
40000bf4:	8b 54 24 14          	mov    0x14(%esp),%edx
40000bf8:	8b 74 24 18          	mov    0x18(%esp),%esi
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
40000bfc:	0f b6 0a             	movzbl (%edx),%ecx
40000bff:	80 f9 20             	cmp    $0x20,%cl
40000c02:	0f 85 e6 00 00 00    	jne    40000cee <strtol+0xfe>
		s++;
40000c08:	83 c2 01             	add    $0x1,%edx
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
40000c0b:	0f b6 0a             	movzbl (%edx),%ecx
40000c0e:	80 f9 09             	cmp    $0x9,%cl
40000c11:	74 f5                	je     40000c08 <strtol+0x18>
40000c13:	80 f9 20             	cmp    $0x20,%cl
40000c16:	74 f0                	je     40000c08 <strtol+0x18>
		s++;

	// plus/minus sign
	if (*s == '+')
40000c18:	80 f9 2b             	cmp    $0x2b,%cl
40000c1b:	0f 84 8f 00 00 00    	je     40000cb0 <strtol+0xc0>


long
strtol(const char *s, char **endptr, int base)
{
	int neg = 0;
40000c21:	31 ff                	xor    %edi,%edi
		s++;

	// plus/minus sign
	if (*s == '+')
		s++;
	else if (*s == '-')
40000c23:	80 f9 2d             	cmp    $0x2d,%cl
40000c26:	0f 84 94 00 00 00    	je     40000cc0 <strtol+0xd0>
		s++, neg = 1;

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000c2c:	f7 44 24 1c ef ff ff 	testl  $0xffffffef,0x1c(%esp)
40000c33:	ff 
40000c34:	0f be 0a             	movsbl (%edx),%ecx
40000c37:	75 19                	jne    40000c52 <strtol+0x62>
40000c39:	80 f9 30             	cmp    $0x30,%cl
40000c3c:	0f 84 8a 00 00 00    	je     40000ccc <strtol+0xdc>
		s += 2, base = 16;
	else if (base == 0 && s[0] == '0')
40000c42:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
40000c46:	85 db                	test   %ebx,%ebx
40000c48:	75 08                	jne    40000c52 <strtol+0x62>
		s++, base = 8;
	else if (base == 0)
		base = 10;
40000c4a:	c7 44 24 1c 0a 00 00 	movl   $0xa,0x1c(%esp)
40000c51:	00 
		s++;
	else if (*s == '-')
		s++, neg = 1;

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000c52:	31 db                	xor    %ebx,%ebx
40000c54:	eb 18                	jmp    40000c6e <strtol+0x7e>
40000c56:	66 90                	xchg   %ax,%ax
	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
			dig = *s - '0';
40000c58:	83 e9 30             	sub    $0x30,%ecx
			dig = *s - 'a' + 10;
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
40000c5b:	3b 4c 24 1c          	cmp    0x1c(%esp),%ecx
40000c5f:	7d 28                	jge    40000c89 <strtol+0x99>
			break;
		s++, val = (val * base) + dig;
40000c61:	0f af 5c 24 1c       	imul   0x1c(%esp),%ebx
40000c66:	83 c2 01             	add    $0x1,%edx
40000c69:	01 cb                	add    %ecx,%ebx
40000c6b:	0f be 0a             	movsbl (%edx),%ecx

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
40000c6e:	8d 69 d0             	lea    -0x30(%ecx),%ebp
40000c71:	89 e8                	mov    %ebp,%eax
40000c73:	3c 09                	cmp    $0x9,%al
40000c75:	76 e1                	jbe    40000c58 <strtol+0x68>
			dig = *s - '0';
		else if (*s >= 'a' && *s <= 'z')
40000c77:	8d 69 9f             	lea    -0x61(%ecx),%ebp
40000c7a:	89 e8                	mov    %ebp,%eax
40000c7c:	3c 19                	cmp    $0x19,%al
40000c7e:	77 20                	ja     40000ca0 <strtol+0xb0>
			dig = *s - 'a' + 10;
40000c80:	83 e9 57             	sub    $0x57,%ecx
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
40000c83:	3b 4c 24 1c          	cmp    0x1c(%esp),%ecx
40000c87:	7c d8                	jl     40000c61 <strtol+0x71>
			break;
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
40000c89:	85 f6                	test   %esi,%esi
40000c8b:	74 02                	je     40000c8f <strtol+0x9f>
		*endptr = (char *) s;
40000c8d:	89 16                	mov    %edx,(%esi)
	return (neg ? -val : val);
40000c8f:	89 d8                	mov    %ebx,%eax
40000c91:	f7 d8                	neg    %eax
40000c93:	85 ff                	test   %edi,%edi
40000c95:	0f 44 c3             	cmove  %ebx,%eax
}
40000c98:	5b                   	pop    %ebx
40000c99:	5e                   	pop    %esi
40000c9a:	5f                   	pop    %edi
40000c9b:	5d                   	pop    %ebp
40000c9c:	c3                   	ret    
40000c9d:	8d 76 00             	lea    0x0(%esi),%esi

		if (*s >= '0' && *s <= '9')
			dig = *s - '0';
		else if (*s >= 'a' && *s <= 'z')
			dig = *s - 'a' + 10;
		else if (*s >= 'A' && *s <= 'Z')
40000ca0:	8d 69 bf             	lea    -0x41(%ecx),%ebp
40000ca3:	89 e8                	mov    %ebp,%eax
40000ca5:	3c 19                	cmp    $0x19,%al
40000ca7:	77 e0                	ja     40000c89 <strtol+0x99>
			dig = *s - 'A' + 10;
40000ca9:	83 e9 37             	sub    $0x37,%ecx
40000cac:	eb ad                	jmp    40000c5b <strtol+0x6b>
40000cae:	66 90                	xchg   %ax,%ax
	while (*s == ' ' || *s == '\t')
		s++;

	// plus/minus sign
	if (*s == '+')
		s++;
40000cb0:	83 c2 01             	add    $0x1,%edx


long
strtol(const char *s, char **endptr, int base)
{
	int neg = 0;
40000cb3:	31 ff                	xor    %edi,%edi
40000cb5:	e9 72 ff ff ff       	jmp    40000c2c <strtol+0x3c>
40000cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

	// plus/minus sign
	if (*s == '+')
		s++;
	else if (*s == '-')
		s++, neg = 1;
40000cc0:	83 c2 01             	add    $0x1,%edx
40000cc3:	66 bf 01 00          	mov    $0x1,%di
40000cc7:	e9 60 ff ff ff       	jmp    40000c2c <strtol+0x3c>

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000ccc:	80 7a 01 78          	cmpb   $0x78,0x1(%edx)
40000cd0:	74 2a                	je     40000cfc <strtol+0x10c>
		s += 2, base = 16;
	else if (base == 0 && s[0] == '0')
40000cd2:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000cd6:	85 c0                	test   %eax,%eax
40000cd8:	75 36                	jne    40000d10 <strtol+0x120>
40000cda:	0f be 4a 01          	movsbl 0x1(%edx),%ecx
		s++, base = 8;
40000cde:	83 c2 01             	add    $0x1,%edx
40000ce1:	c7 44 24 1c 08 00 00 	movl   $0x8,0x1c(%esp)
40000ce8:	00 
40000ce9:	e9 64 ff ff ff       	jmp    40000c52 <strtol+0x62>
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
40000cee:	80 f9 09             	cmp    $0x9,%cl
40000cf1:	0f 84 11 ff ff ff    	je     40000c08 <strtol+0x18>
40000cf7:	e9 1c ff ff ff       	jmp    40000c18 <strtol+0x28>
40000cfc:	0f be 4a 02          	movsbl 0x2(%edx),%ecx
	else if (*s == '-')
		s++, neg = 1;

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
		s += 2, base = 16;
40000d00:	83 c2 02             	add    $0x2,%edx
40000d03:	c7 44 24 1c 10 00 00 	movl   $0x10,0x1c(%esp)
40000d0a:	00 
40000d0b:	e9 42 ff ff ff       	jmp    40000c52 <strtol+0x62>
		s++;
	else if (*s == '-')
		s++, neg = 1;

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000d10:	b9 30 00 00 00       	mov    $0x30,%ecx
40000d15:	e9 38 ff ff ff       	jmp    40000c52 <strtol+0x62>
40000d1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000d20 <memset>:
	return (neg ? -val : val);
}

void *
memset(void *v, int c, size_t n)
{
40000d20:	57                   	push   %edi
40000d21:	56                   	push   %esi
40000d22:	53                   	push   %ebx
40000d23:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000d27:	8b 7c 24 10          	mov    0x10(%esp),%edi
	if (n == 0)
40000d2b:	85 c9                	test   %ecx,%ecx
40000d2d:	74 14                	je     40000d43 <memset+0x23>
		return v;
	if ((int)v%4 == 0 && n%4 == 0) {
40000d2f:	f7 c7 03 00 00 00    	test   $0x3,%edi
40000d35:	75 05                	jne    40000d3c <memset+0x1c>
40000d37:	f6 c1 03             	test   $0x3,%cl
40000d3a:	74 14                	je     40000d50 <memset+0x30>
		c = (c<<24)|(c<<16)|(c<<8)|c;
		asm volatile("cld; rep stosl\n"
			     :: "D" (v), "a" (c), "c" (n/4)
			     : "cc", "memory");
	} else
		asm volatile("cld; rep stosb\n"
40000d3c:	8b 44 24 14          	mov    0x14(%esp),%eax
40000d40:	fc                   	cld    
40000d41:	f3 aa                	rep stos %al,%es:(%edi)
			     :: "D" (v), "a" (c), "c" (n)
			     : "cc", "memory");
	return v;
}
40000d43:	89 f8                	mov    %edi,%eax
40000d45:	5b                   	pop    %ebx
40000d46:	5e                   	pop    %esi
40000d47:	5f                   	pop    %edi
40000d48:	c3                   	ret    
40000d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
memset(void *v, int c, size_t n)
{
	if (n == 0)
		return v;
	if ((int)v%4 == 0 && n%4 == 0) {
		c &= 0xFF;
40000d50:	0f b6 54 24 14       	movzbl 0x14(%esp),%edx
		c = (c<<24)|(c<<16)|(c<<8)|c;
		asm volatile("cld; rep stosl\n"
			     :: "D" (v), "a" (c), "c" (n/4)
40000d55:	c1 e9 02             	shr    $0x2,%ecx
{
	if (n == 0)
		return v;
	if ((int)v%4 == 0 && n%4 == 0) {
		c &= 0xFF;
		c = (c<<24)|(c<<16)|(c<<8)|c;
40000d58:	89 d0                	mov    %edx,%eax
40000d5a:	89 d6                	mov    %edx,%esi
40000d5c:	c1 e0 18             	shl    $0x18,%eax
40000d5f:	89 d3                	mov    %edx,%ebx
40000d61:	c1 e6 10             	shl    $0x10,%esi
40000d64:	09 f0                	or     %esi,%eax
40000d66:	c1 e3 08             	shl    $0x8,%ebx
40000d69:	09 d0                	or     %edx,%eax
40000d6b:	09 d8                	or     %ebx,%eax
		asm volatile("cld; rep stosl\n"
40000d6d:	fc                   	cld    
40000d6e:	f3 ab                	rep stos %eax,%es:(%edi)
	} else
		asm volatile("cld; rep stosb\n"
			     :: "D" (v), "a" (c), "c" (n)
			     : "cc", "memory");
	return v;
}
40000d70:	89 f8                	mov    %edi,%eax
40000d72:	5b                   	pop    %ebx
40000d73:	5e                   	pop    %esi
40000d74:	5f                   	pop    %edi
40000d75:	c3                   	ret    
40000d76:	8d 76 00             	lea    0x0(%esi),%esi
40000d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000d80 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
40000d80:	57                   	push   %edi
40000d81:	56                   	push   %esi
40000d82:	8b 44 24 0c          	mov    0xc(%esp),%eax
40000d86:	8b 74 24 10          	mov    0x10(%esp),%esi
40000d8a:	8b 4c 24 14          	mov    0x14(%esp),%ecx
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
40000d8e:	39 c6                	cmp    %eax,%esi
40000d90:	73 26                	jae    40000db8 <memmove+0x38>
40000d92:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
40000d95:	39 d0                	cmp    %edx,%eax
40000d97:	73 1f                	jae    40000db8 <memmove+0x38>
		s += n;
		d += n;
40000d99:	8d 3c 08             	lea    (%eax,%ecx,1),%edi
40000d9c:	89 d6                	mov    %edx,%esi
40000d9e:	09 fe                	or     %edi,%esi
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
40000da0:	83 e6 03             	and    $0x3,%esi
40000da3:	74 33                	je     40000dd8 <memmove+0x58>
			asm volatile("std; rep movsl\n"
				     :: "D" (d-4), "S" (s-4), "c" (n/4)
				     : "cc", "memory");
		else
			asm volatile("std; rep movsb\n"
				     :: "D" (d-1), "S" (s-1), "c" (n)
40000da5:	83 ef 01             	sub    $0x1,%edi
40000da8:	8d 72 ff             	lea    -0x1(%edx),%esi
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
			asm volatile("std; rep movsl\n"
				     :: "D" (d-4), "S" (s-4), "c" (n/4)
				     : "cc", "memory");
		else
			asm volatile("std; rep movsb\n"
40000dab:	fd                   	std    
40000dac:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
				     :: "D" (d-1), "S" (s-1), "c" (n)
				     : "cc", "memory");
		// Some versions of GCC rely on DF being clear
		asm volatile("cld" ::: "cc");
40000dae:	fc                   	cld    
			asm volatile("cld; rep movsb\n"
				     :: "D" (d), "S" (s), "c" (n)
				     : "cc", "memory");
	}
	return dst;
}
40000daf:	5e                   	pop    %esi
40000db0:	5f                   	pop    %edi
40000db1:	c3                   	ret    
40000db2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000db8:	89 f2                	mov    %esi,%edx
40000dba:	09 c2                	or     %eax,%edx
				     :: "D" (d-1), "S" (s-1), "c" (n)
				     : "cc", "memory");
		// Some versions of GCC rely on DF being clear
		asm volatile("cld" ::: "cc");
	} else {
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
40000dbc:	83 e2 03             	and    $0x3,%edx
40000dbf:	75 0f                	jne    40000dd0 <memmove+0x50>
40000dc1:	f6 c1 03             	test   $0x3,%cl
40000dc4:	75 0a                	jne    40000dd0 <memmove+0x50>
			asm volatile("cld; rep movsl\n"
				     :: "D" (d), "S" (s), "c" (n/4)
40000dc6:	c1 e9 02             	shr    $0x2,%ecx
				     : "cc", "memory");
		// Some versions of GCC rely on DF being clear
		asm volatile("cld" ::: "cc");
	} else {
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
			asm volatile("cld; rep movsl\n"
40000dc9:	89 c7                	mov    %eax,%edi
40000dcb:	fc                   	cld    
40000dcc:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000dce:	eb 05                	jmp    40000dd5 <memmove+0x55>
				     :: "D" (d), "S" (s), "c" (n/4)
				     : "cc", "memory");
		else
			asm volatile("cld; rep movsb\n"
40000dd0:	89 c7                	mov    %eax,%edi
40000dd2:	fc                   	cld    
40000dd3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
				     :: "D" (d), "S" (s), "c" (n)
				     : "cc", "memory");
	}
	return dst;
}
40000dd5:	5e                   	pop    %esi
40000dd6:	5f                   	pop    %edi
40000dd7:	c3                   	ret    
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
40000dd8:	f6 c1 03             	test   $0x3,%cl
40000ddb:	75 c8                	jne    40000da5 <memmove+0x25>
			asm volatile("std; rep movsl\n"
				     :: "D" (d-4), "S" (s-4), "c" (n/4)
40000ddd:	83 ef 04             	sub    $0x4,%edi
40000de0:	8d 72 fc             	lea    -0x4(%edx),%esi
40000de3:	c1 e9 02             	shr    $0x2,%ecx
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
			asm volatile("std; rep movsl\n"
40000de6:	fd                   	std    
40000de7:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000de9:	eb c3                	jmp    40000dae <memmove+0x2e>
40000deb:	90                   	nop
40000dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000df0 <memcpy>:
}

void *
memcpy(void *dst, const void *src, size_t n)
{
	return memmove(dst, src, n);
40000df0:	eb 8e                	jmp    40000d80 <memmove>
40000df2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000e00 <memcmp>:
}

int
memcmp(const void *v1, const void *v2, size_t n)
{
40000e00:	57                   	push   %edi
40000e01:	56                   	push   %esi
40000e02:	53                   	push   %ebx
40000e03:	8b 44 24 18          	mov    0x18(%esp),%eax
40000e07:	8b 5c 24 10          	mov    0x10(%esp),%ebx
40000e0b:	8b 74 24 14          	mov    0x14(%esp),%esi
	const uint8_t *s1 = (const uint8_t *) v1;
	const uint8_t *s2 = (const uint8_t *) v2;

	while (n-- > 0) {
40000e0f:	85 c0                	test   %eax,%eax
40000e11:	8d 78 ff             	lea    -0x1(%eax),%edi
40000e14:	74 26                	je     40000e3c <memcmp+0x3c>
		if (*s1 != *s2)
40000e16:	0f b6 03             	movzbl (%ebx),%eax
40000e19:	31 d2                	xor    %edx,%edx
40000e1b:	0f b6 0e             	movzbl (%esi),%ecx
40000e1e:	38 c8                	cmp    %cl,%al
40000e20:	74 16                	je     40000e38 <memcmp+0x38>
40000e22:	eb 24                	jmp    40000e48 <memcmp+0x48>
40000e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000e28:	0f b6 44 13 01       	movzbl 0x1(%ebx,%edx,1),%eax
40000e2d:	83 c2 01             	add    $0x1,%edx
40000e30:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
40000e34:	38 c8                	cmp    %cl,%al
40000e36:	75 10                	jne    40000e48 <memcmp+0x48>
memcmp(const void *v1, const void *v2, size_t n)
{
	const uint8_t *s1 = (const uint8_t *) v1;
	const uint8_t *s2 = (const uint8_t *) v2;

	while (n-- > 0) {
40000e38:	39 fa                	cmp    %edi,%edx
40000e3a:	75 ec                	jne    40000e28 <memcmp+0x28>
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
}
40000e3c:	5b                   	pop    %ebx
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
40000e3d:	31 c0                	xor    %eax,%eax
}
40000e3f:	5e                   	pop    %esi
40000e40:	5f                   	pop    %edi
40000e41:	c3                   	ret    
40000e42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000e48:	5b                   	pop    %ebx
	const uint8_t *s1 = (const uint8_t *) v1;
	const uint8_t *s2 = (const uint8_t *) v2;

	while (n-- > 0) {
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
40000e49:	29 c8                	sub    %ecx,%eax
		s1++, s2++;
	}

	return 0;
}
40000e4b:	5e                   	pop    %esi
40000e4c:	5f                   	pop    %edi
40000e4d:	c3                   	ret    
40000e4e:	66 90                	xchg   %ax,%ax

40000e50 <memchr>:

void *
memchr(const void *s, int c, size_t n)
{
40000e50:	53                   	push   %ebx
40000e51:	8b 44 24 08          	mov    0x8(%esp),%eax
	const void *ends = (const char *) s + n;
40000e55:	8b 54 24 10          	mov    0x10(%esp),%edx
	return 0;
}

void *
memchr(const void *s, int c, size_t n)
{
40000e59:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
	const void *ends = (const char *) s + n;
40000e5d:	01 c2                	add    %eax,%edx
	for (; s < ends; s++)
40000e5f:	39 d0                	cmp    %edx,%eax
40000e61:	73 18                	jae    40000e7b <memchr+0x2b>
		if (*(const unsigned char *) s == (unsigned char) c)
40000e63:	38 18                	cmp    %bl,(%eax)
40000e65:	89 d9                	mov    %ebx,%ecx
40000e67:	75 0b                	jne    40000e74 <memchr+0x24>
40000e69:	eb 12                	jmp    40000e7d <memchr+0x2d>
40000e6b:	90                   	nop
40000e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000e70:	38 08                	cmp    %cl,(%eax)
40000e72:	74 09                	je     40000e7d <memchr+0x2d>

void *
memchr(const void *s, int c, size_t n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
40000e74:	83 c0 01             	add    $0x1,%eax
40000e77:	39 d0                	cmp    %edx,%eax
40000e79:	75 f5                	jne    40000e70 <memchr+0x20>
		if (*(const unsigned char *) s == (unsigned char) c)
			return (void *) s;
	return NULL;
40000e7b:	31 c0                	xor    %eax,%eax
}
40000e7d:	5b                   	pop    %ebx
40000e7e:	c3                   	ret    
40000e7f:	90                   	nop

40000e80 <memzero>:

void *
memzero(void *v, size_t n)
{
40000e80:	83 ec 0c             	sub    $0xc,%esp
	return memset(v, 0, n);
40000e83:	8b 44 24 14          	mov    0x14(%esp),%eax
40000e87:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
40000e8e:	00 
40000e8f:	89 44 24 08          	mov    %eax,0x8(%esp)
40000e93:	8b 44 24 10          	mov    0x10(%esp),%eax
40000e97:	89 04 24             	mov    %eax,(%esp)
40000e9a:	e8 81 fe ff ff       	call   40000d20 <memset>
}
40000e9f:	83 c4 0c             	add    $0xc,%esp
40000ea2:	c3                   	ret    
40000ea3:	66 90                	xchg   %ax,%ax
40000ea5:	66 90                	xchg   %ax,%ax
40000ea7:	66 90                	xchg   %ax,%ax
40000ea9:	66 90                	xchg   %ax,%ax
40000eab:	66 90                	xchg   %ax,%ax
40000ead:	66 90                	xchg   %ax,%ax
40000eaf:	90                   	nop

40000eb0 <__udivdi3>:
40000eb0:	55                   	push   %ebp
40000eb1:	57                   	push   %edi
40000eb2:	56                   	push   %esi
40000eb3:	83 ec 0c             	sub    $0xc,%esp
40000eb6:	8b 44 24 28          	mov    0x28(%esp),%eax
40000eba:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
40000ebe:	8b 6c 24 20          	mov    0x20(%esp),%ebp
40000ec2:	8b 4c 24 24          	mov    0x24(%esp),%ecx
40000ec6:	85 c0                	test   %eax,%eax
40000ec8:	89 7c 24 04          	mov    %edi,0x4(%esp)
40000ecc:	89 ea                	mov    %ebp,%edx
40000ece:	89 0c 24             	mov    %ecx,(%esp)
40000ed1:	75 2d                	jne    40000f00 <__udivdi3+0x50>
40000ed3:	39 e9                	cmp    %ebp,%ecx
40000ed5:	77 61                	ja     40000f38 <__udivdi3+0x88>
40000ed7:	85 c9                	test   %ecx,%ecx
40000ed9:	89 ce                	mov    %ecx,%esi
40000edb:	75 0b                	jne    40000ee8 <__udivdi3+0x38>
40000edd:	b8 01 00 00 00       	mov    $0x1,%eax
40000ee2:	31 d2                	xor    %edx,%edx
40000ee4:	f7 f1                	div    %ecx
40000ee6:	89 c6                	mov    %eax,%esi
40000ee8:	31 d2                	xor    %edx,%edx
40000eea:	89 e8                	mov    %ebp,%eax
40000eec:	f7 f6                	div    %esi
40000eee:	89 c5                	mov    %eax,%ebp
40000ef0:	89 f8                	mov    %edi,%eax
40000ef2:	f7 f6                	div    %esi
40000ef4:	89 ea                	mov    %ebp,%edx
40000ef6:	83 c4 0c             	add    $0xc,%esp
40000ef9:	5e                   	pop    %esi
40000efa:	5f                   	pop    %edi
40000efb:	5d                   	pop    %ebp
40000efc:	c3                   	ret    
40000efd:	8d 76 00             	lea    0x0(%esi),%esi
40000f00:	39 e8                	cmp    %ebp,%eax
40000f02:	77 24                	ja     40000f28 <__udivdi3+0x78>
40000f04:	0f bd e8             	bsr    %eax,%ebp
40000f07:	83 f5 1f             	xor    $0x1f,%ebp
40000f0a:	75 3c                	jne    40000f48 <__udivdi3+0x98>
40000f0c:	8b 74 24 04          	mov    0x4(%esp),%esi
40000f10:	39 34 24             	cmp    %esi,(%esp)
40000f13:	0f 86 9f 00 00 00    	jbe    40000fb8 <__udivdi3+0x108>
40000f19:	39 d0                	cmp    %edx,%eax
40000f1b:	0f 82 97 00 00 00    	jb     40000fb8 <__udivdi3+0x108>
40000f21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000f28:	31 d2                	xor    %edx,%edx
40000f2a:	31 c0                	xor    %eax,%eax
40000f2c:	83 c4 0c             	add    $0xc,%esp
40000f2f:	5e                   	pop    %esi
40000f30:	5f                   	pop    %edi
40000f31:	5d                   	pop    %ebp
40000f32:	c3                   	ret    
40000f33:	90                   	nop
40000f34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000f38:	89 f8                	mov    %edi,%eax
40000f3a:	f7 f1                	div    %ecx
40000f3c:	31 d2                	xor    %edx,%edx
40000f3e:	83 c4 0c             	add    $0xc,%esp
40000f41:	5e                   	pop    %esi
40000f42:	5f                   	pop    %edi
40000f43:	5d                   	pop    %ebp
40000f44:	c3                   	ret    
40000f45:	8d 76 00             	lea    0x0(%esi),%esi
40000f48:	89 e9                	mov    %ebp,%ecx
40000f4a:	8b 3c 24             	mov    (%esp),%edi
40000f4d:	d3 e0                	shl    %cl,%eax
40000f4f:	89 c6                	mov    %eax,%esi
40000f51:	b8 20 00 00 00       	mov    $0x20,%eax
40000f56:	29 e8                	sub    %ebp,%eax
40000f58:	89 c1                	mov    %eax,%ecx
40000f5a:	d3 ef                	shr    %cl,%edi
40000f5c:	89 e9                	mov    %ebp,%ecx
40000f5e:	89 7c 24 08          	mov    %edi,0x8(%esp)
40000f62:	8b 3c 24             	mov    (%esp),%edi
40000f65:	09 74 24 08          	or     %esi,0x8(%esp)
40000f69:	89 d6                	mov    %edx,%esi
40000f6b:	d3 e7                	shl    %cl,%edi
40000f6d:	89 c1                	mov    %eax,%ecx
40000f6f:	89 3c 24             	mov    %edi,(%esp)
40000f72:	8b 7c 24 04          	mov    0x4(%esp),%edi
40000f76:	d3 ee                	shr    %cl,%esi
40000f78:	89 e9                	mov    %ebp,%ecx
40000f7a:	d3 e2                	shl    %cl,%edx
40000f7c:	89 c1                	mov    %eax,%ecx
40000f7e:	d3 ef                	shr    %cl,%edi
40000f80:	09 d7                	or     %edx,%edi
40000f82:	89 f2                	mov    %esi,%edx
40000f84:	89 f8                	mov    %edi,%eax
40000f86:	f7 74 24 08          	divl   0x8(%esp)
40000f8a:	89 d6                	mov    %edx,%esi
40000f8c:	89 c7                	mov    %eax,%edi
40000f8e:	f7 24 24             	mull   (%esp)
40000f91:	39 d6                	cmp    %edx,%esi
40000f93:	89 14 24             	mov    %edx,(%esp)
40000f96:	72 30                	jb     40000fc8 <__udivdi3+0x118>
40000f98:	8b 54 24 04          	mov    0x4(%esp),%edx
40000f9c:	89 e9                	mov    %ebp,%ecx
40000f9e:	d3 e2                	shl    %cl,%edx
40000fa0:	39 c2                	cmp    %eax,%edx
40000fa2:	73 05                	jae    40000fa9 <__udivdi3+0xf9>
40000fa4:	3b 34 24             	cmp    (%esp),%esi
40000fa7:	74 1f                	je     40000fc8 <__udivdi3+0x118>
40000fa9:	89 f8                	mov    %edi,%eax
40000fab:	31 d2                	xor    %edx,%edx
40000fad:	e9 7a ff ff ff       	jmp    40000f2c <__udivdi3+0x7c>
40000fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000fb8:	31 d2                	xor    %edx,%edx
40000fba:	b8 01 00 00 00       	mov    $0x1,%eax
40000fbf:	e9 68 ff ff ff       	jmp    40000f2c <__udivdi3+0x7c>
40000fc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000fc8:	8d 47 ff             	lea    -0x1(%edi),%eax
40000fcb:	31 d2                	xor    %edx,%edx
40000fcd:	83 c4 0c             	add    $0xc,%esp
40000fd0:	5e                   	pop    %esi
40000fd1:	5f                   	pop    %edi
40000fd2:	5d                   	pop    %ebp
40000fd3:	c3                   	ret    
40000fd4:	66 90                	xchg   %ax,%ax
40000fd6:	66 90                	xchg   %ax,%ax
40000fd8:	66 90                	xchg   %ax,%ax
40000fda:	66 90                	xchg   %ax,%ax
40000fdc:	66 90                	xchg   %ax,%ax
40000fde:	66 90                	xchg   %ax,%ax

40000fe0 <__umoddi3>:
40000fe0:	55                   	push   %ebp
40000fe1:	57                   	push   %edi
40000fe2:	56                   	push   %esi
40000fe3:	83 ec 14             	sub    $0x14,%esp
40000fe6:	8b 44 24 28          	mov    0x28(%esp),%eax
40000fea:	8b 4c 24 24          	mov    0x24(%esp),%ecx
40000fee:	8b 74 24 2c          	mov    0x2c(%esp),%esi
40000ff2:	89 c7                	mov    %eax,%edi
40000ff4:	89 44 24 04          	mov    %eax,0x4(%esp)
40000ff8:	8b 44 24 30          	mov    0x30(%esp),%eax
40000ffc:	89 4c 24 10          	mov    %ecx,0x10(%esp)
40001000:	89 34 24             	mov    %esi,(%esp)
40001003:	89 4c 24 08          	mov    %ecx,0x8(%esp)
40001007:	85 c0                	test   %eax,%eax
40001009:	89 c2                	mov    %eax,%edx
4000100b:	89 7c 24 0c          	mov    %edi,0xc(%esp)
4000100f:	75 17                	jne    40001028 <__umoddi3+0x48>
40001011:	39 fe                	cmp    %edi,%esi
40001013:	76 4b                	jbe    40001060 <__umoddi3+0x80>
40001015:	89 c8                	mov    %ecx,%eax
40001017:	89 fa                	mov    %edi,%edx
40001019:	f7 f6                	div    %esi
4000101b:	89 d0                	mov    %edx,%eax
4000101d:	31 d2                	xor    %edx,%edx
4000101f:	83 c4 14             	add    $0x14,%esp
40001022:	5e                   	pop    %esi
40001023:	5f                   	pop    %edi
40001024:	5d                   	pop    %ebp
40001025:	c3                   	ret    
40001026:	66 90                	xchg   %ax,%ax
40001028:	39 f8                	cmp    %edi,%eax
4000102a:	77 54                	ja     40001080 <__umoddi3+0xa0>
4000102c:	0f bd e8             	bsr    %eax,%ebp
4000102f:	83 f5 1f             	xor    $0x1f,%ebp
40001032:	75 5c                	jne    40001090 <__umoddi3+0xb0>
40001034:	8b 7c 24 08          	mov    0x8(%esp),%edi
40001038:	39 3c 24             	cmp    %edi,(%esp)
4000103b:	0f 87 e7 00 00 00    	ja     40001128 <__umoddi3+0x148>
40001041:	8b 7c 24 04          	mov    0x4(%esp),%edi
40001045:	29 f1                	sub    %esi,%ecx
40001047:	19 c7                	sbb    %eax,%edi
40001049:	89 4c 24 08          	mov    %ecx,0x8(%esp)
4000104d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
40001051:	8b 44 24 08          	mov    0x8(%esp),%eax
40001055:	8b 54 24 0c          	mov    0xc(%esp),%edx
40001059:	83 c4 14             	add    $0x14,%esp
4000105c:	5e                   	pop    %esi
4000105d:	5f                   	pop    %edi
4000105e:	5d                   	pop    %ebp
4000105f:	c3                   	ret    
40001060:	85 f6                	test   %esi,%esi
40001062:	89 f5                	mov    %esi,%ebp
40001064:	75 0b                	jne    40001071 <__umoddi3+0x91>
40001066:	b8 01 00 00 00       	mov    $0x1,%eax
4000106b:	31 d2                	xor    %edx,%edx
4000106d:	f7 f6                	div    %esi
4000106f:	89 c5                	mov    %eax,%ebp
40001071:	8b 44 24 04          	mov    0x4(%esp),%eax
40001075:	31 d2                	xor    %edx,%edx
40001077:	f7 f5                	div    %ebp
40001079:	89 c8                	mov    %ecx,%eax
4000107b:	f7 f5                	div    %ebp
4000107d:	eb 9c                	jmp    4000101b <__umoddi3+0x3b>
4000107f:	90                   	nop
40001080:	89 c8                	mov    %ecx,%eax
40001082:	89 fa                	mov    %edi,%edx
40001084:	83 c4 14             	add    $0x14,%esp
40001087:	5e                   	pop    %esi
40001088:	5f                   	pop    %edi
40001089:	5d                   	pop    %ebp
4000108a:	c3                   	ret    
4000108b:	90                   	nop
4000108c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40001090:	8b 04 24             	mov    (%esp),%eax
40001093:	be 20 00 00 00       	mov    $0x20,%esi
40001098:	89 e9                	mov    %ebp,%ecx
4000109a:	29 ee                	sub    %ebp,%esi
4000109c:	d3 e2                	shl    %cl,%edx
4000109e:	89 f1                	mov    %esi,%ecx
400010a0:	d3 e8                	shr    %cl,%eax
400010a2:	89 e9                	mov    %ebp,%ecx
400010a4:	89 44 24 04          	mov    %eax,0x4(%esp)
400010a8:	8b 04 24             	mov    (%esp),%eax
400010ab:	09 54 24 04          	or     %edx,0x4(%esp)
400010af:	89 fa                	mov    %edi,%edx
400010b1:	d3 e0                	shl    %cl,%eax
400010b3:	89 f1                	mov    %esi,%ecx
400010b5:	89 44 24 08          	mov    %eax,0x8(%esp)
400010b9:	8b 44 24 10          	mov    0x10(%esp),%eax
400010bd:	d3 ea                	shr    %cl,%edx
400010bf:	89 e9                	mov    %ebp,%ecx
400010c1:	d3 e7                	shl    %cl,%edi
400010c3:	89 f1                	mov    %esi,%ecx
400010c5:	d3 e8                	shr    %cl,%eax
400010c7:	89 e9                	mov    %ebp,%ecx
400010c9:	09 f8                	or     %edi,%eax
400010cb:	8b 7c 24 10          	mov    0x10(%esp),%edi
400010cf:	f7 74 24 04          	divl   0x4(%esp)
400010d3:	d3 e7                	shl    %cl,%edi
400010d5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
400010d9:	89 d7                	mov    %edx,%edi
400010db:	f7 64 24 08          	mull   0x8(%esp)
400010df:	39 d7                	cmp    %edx,%edi
400010e1:	89 c1                	mov    %eax,%ecx
400010e3:	89 14 24             	mov    %edx,(%esp)
400010e6:	72 2c                	jb     40001114 <__umoddi3+0x134>
400010e8:	39 44 24 0c          	cmp    %eax,0xc(%esp)
400010ec:	72 22                	jb     40001110 <__umoddi3+0x130>
400010ee:	8b 44 24 0c          	mov    0xc(%esp),%eax
400010f2:	29 c8                	sub    %ecx,%eax
400010f4:	19 d7                	sbb    %edx,%edi
400010f6:	89 e9                	mov    %ebp,%ecx
400010f8:	89 fa                	mov    %edi,%edx
400010fa:	d3 e8                	shr    %cl,%eax
400010fc:	89 f1                	mov    %esi,%ecx
400010fe:	d3 e2                	shl    %cl,%edx
40001100:	89 e9                	mov    %ebp,%ecx
40001102:	d3 ef                	shr    %cl,%edi
40001104:	09 d0                	or     %edx,%eax
40001106:	89 fa                	mov    %edi,%edx
40001108:	83 c4 14             	add    $0x14,%esp
4000110b:	5e                   	pop    %esi
4000110c:	5f                   	pop    %edi
4000110d:	5d                   	pop    %ebp
4000110e:	c3                   	ret    
4000110f:	90                   	nop
40001110:	39 d7                	cmp    %edx,%edi
40001112:	75 da                	jne    400010ee <__umoddi3+0x10e>
40001114:	8b 14 24             	mov    (%esp),%edx
40001117:	89 c1                	mov    %eax,%ecx
40001119:	2b 4c 24 08          	sub    0x8(%esp),%ecx
4000111d:	1b 54 24 04          	sbb    0x4(%esp),%edx
40001121:	eb cb                	jmp    400010ee <__umoddi3+0x10e>
40001123:	90                   	nop
40001124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40001128:	3b 44 24 0c          	cmp    0xc(%esp),%eax
4000112c:	0f 82 0f ff ff ff    	jb     40001041 <__umoddi3+0x61>
40001132:	e9 1a ff ff ff       	jmp    40001051 <__umoddi3+0x71>
