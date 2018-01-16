
obj/user/pingpong/ding:     file format elf32-i386


Disassembly of section .text:

40000000 <main>:
#include <proc.h>
#include <stdio.h>
#include <syscall.h>

int main (int argc, char **argv)
{
40000000:	55                   	push   %ebp
40000001:	89 e5                	mov    %esp,%ebp
40000003:	83 e4 f0             	and    $0xfffffff0,%esp
40000006:	83 ec 10             	sub    $0x10,%esp
    printf("ding started.\n");
40000009:	c7 04 24 9c 12 00 40 	movl   $0x4000129c,(%esp)
40000010:	e8 fb 01 00 00       	call   40000210 <printf>

    return 0;
}
40000015:	31 c0                	xor    %eax,%eax
40000017:	c9                   	leave  
40000018:	c3                   	ret    

40000019 <_start>:
_start:
	/*
	 * If there are arguments on the stack, then the current stack will not
	 * be aligned to a nice big power-of-two boundary/
	 */
	testl	$0x0fffffff, %esp
40000019:	f7 c4 ff ff ff 0f    	test   $0xfffffff,%esp
	jnz	args_exist
4000001f:	75 04                	jne    40000025 <args_exist>

40000021 <noargs>:

noargs:
	/* If no arguments are on the stack, push two dummy zero. */
	pushl	$0
40000021:	6a 00                	push   $0x0
	pushl	$0
40000023:	6a 00                	push   $0x0

40000025 <args_exist>:

args_exist:
	/* Jump to the C part. */
	call	main
40000025:	e8 d6 ff ff ff       	call   40000000 <main>

	/* When returning, push the return value on the stack. */
	pushl	%eax
4000002a:	50                   	push   %eax

4000002b <spin>:
spin:
	//call	yield
	jmp	spin
4000002b:	eb fe                	jmp    4000002b <spin>
4000002d:	66 90                	xchg   %ax,%ax
4000002f:	90                   	nop

40000030 <debug>:
#include <stdarg.h>
#include <stdio.h>

void
debug(const char *file, int line, const char *fmt, ...)
{
40000030:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	va_start(ap, fmt);
	printf("[D] %s:%d: ", file, line);
40000033:	8b 44 24 24          	mov    0x24(%esp),%eax
40000037:	c7 04 24 08 11 00 40 	movl   $0x40001108,(%esp)
4000003e:	89 44 24 08          	mov    %eax,0x8(%esp)
40000042:	8b 44 24 20          	mov    0x20(%esp),%eax
40000046:	89 44 24 04          	mov    %eax,0x4(%esp)
4000004a:	e8 c1 01 00 00       	call   40000210 <printf>
	vcprintf(fmt, ap);
4000004f:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000053:	89 44 24 04          	mov    %eax,0x4(%esp)
40000057:	8b 44 24 28          	mov    0x28(%esp),%eax
4000005b:	89 04 24             	mov    %eax,(%esp)
4000005e:	e8 4d 01 00 00       	call   400001b0 <vcprintf>
	va_end(ap);
}
40000063:	83 c4 1c             	add    $0x1c,%esp
40000066:	c3                   	ret    
40000067:	89 f6                	mov    %esi,%esi
40000069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000070 <warn>:

void
warn(const char *file, int line, const char *fmt, ...)
{
40000070:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	va_start(ap, fmt);
	printf("[W] %s:%d: ", file, line);
40000073:	8b 44 24 24          	mov    0x24(%esp),%eax
40000077:	c7 04 24 14 11 00 40 	movl   $0x40001114,(%esp)
4000007e:	89 44 24 08          	mov    %eax,0x8(%esp)
40000082:	8b 44 24 20          	mov    0x20(%esp),%eax
40000086:	89 44 24 04          	mov    %eax,0x4(%esp)
4000008a:	e8 81 01 00 00       	call   40000210 <printf>
	vcprintf(fmt, ap);
4000008f:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000093:	89 44 24 04          	mov    %eax,0x4(%esp)
40000097:	8b 44 24 28          	mov    0x28(%esp),%eax
4000009b:	89 04 24             	mov    %eax,(%esp)
4000009e:	e8 0d 01 00 00       	call   400001b0 <vcprintf>
	va_end(ap);
}
400000a3:	83 c4 1c             	add    $0x1c,%esp
400000a6:	c3                   	ret    
400000a7:	89 f6                	mov    %esi,%esi
400000a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

400000b0 <panic>:

void
panic(const char *file, int line, const char *fmt, ...)
{
400000b0:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	va_start(ap, fmt);
	printf("[P] %s:%d: ", file, line);
400000b3:	8b 44 24 24          	mov    0x24(%esp),%eax
400000b7:	c7 04 24 20 11 00 40 	movl   $0x40001120,(%esp)
400000be:	89 44 24 08          	mov    %eax,0x8(%esp)
400000c2:	8b 44 24 20          	mov    0x20(%esp),%eax
400000c6:	89 44 24 04          	mov    %eax,0x4(%esp)
400000ca:	e8 41 01 00 00       	call   40000210 <printf>
	vcprintf(fmt, ap);
400000cf:	8d 44 24 2c          	lea    0x2c(%esp),%eax
400000d3:	89 44 24 04          	mov    %eax,0x4(%esp)
400000d7:	8b 44 24 28          	mov    0x28(%esp),%eax
400000db:	89 04 24             	mov    %eax,(%esp)
400000de:	e8 cd 00 00 00       	call   400001b0 <vcprintf>
400000e3:	90                   	nop
400000e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	va_end(ap);

	while (1)
		yield();
400000e8:	e8 f3 07 00 00       	call   400008e0 <yield>
400000ed:	eb f9                	jmp    400000e8 <panic+0x38>
400000ef:	90                   	nop

400000f0 <atoi>:
#include <stdlib.h>

int
atoi(const char *buf, int *i)
{
400000f0:	55                   	push   %ebp
400000f1:	57                   	push   %edi
400000f2:	56                   	push   %esi
400000f3:	53                   	push   %ebx
400000f4:	8b 74 24 14          	mov    0x14(%esp),%esi
	int loc = 0;
	int numstart = 0;
	int acc = 0;
	int negative = 0;
	if (buf[loc] == '+')
400000f8:	0f b6 06             	movzbl (%esi),%eax
400000fb:	3c 2b                	cmp    $0x2b,%al
400000fd:	74 51                	je     40000150 <atoi+0x60>
		loc++;
	else if (buf[loc] == '-') {
400000ff:	3c 2d                	cmp    $0x2d,%al
40000101:	0f 94 c0             	sete   %al
40000104:	0f b6 c0             	movzbl %al,%eax
40000107:	89 c5                	mov    %eax,%ebp
40000109:	89 c7                	mov    %eax,%edi
		negative = 1;
		loc++;
	}
	numstart = loc;
	// no grab the numbers
	while ('0' <= buf[loc] && buf[loc] <= '9') {
4000010b:	0f be 0c 06          	movsbl (%esi,%eax,1),%ecx
4000010f:	8d 41 d0             	lea    -0x30(%ecx),%eax
40000112:	3c 09                	cmp    $0x9,%al
40000114:	77 4a                	ja     40000160 <atoi+0x70>
40000116:	89 f8                	mov    %edi,%eax
int
atoi(const char *buf, int *i)
{
	int loc = 0;
	int numstart = 0;
	int acc = 0;
40000118:	31 d2                	xor    %edx,%edx
4000011a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	}
	numstart = loc;
	// no grab the numbers
	while ('0' <= buf[loc] && buf[loc] <= '9') {
		acc = acc*10 + (buf[loc]-'0');
		loc++;
40000120:	83 c0 01             	add    $0x1,%eax
		loc++;
	}
	numstart = loc;
	// no grab the numbers
	while ('0' <= buf[loc] && buf[loc] <= '9') {
		acc = acc*10 + (buf[loc]-'0');
40000123:	8d 14 92             	lea    (%edx,%edx,4),%edx
40000126:	8d 54 51 d0          	lea    -0x30(%ecx,%edx,2),%edx
		negative = 1;
		loc++;
	}
	numstart = loc;
	// no grab the numbers
	while ('0' <= buf[loc] && buf[loc] <= '9') {
4000012a:	0f be 0c 06          	movsbl (%esi,%eax,1),%ecx
4000012e:	8d 59 d0             	lea    -0x30(%ecx),%ebx
40000131:	80 fb 09             	cmp    $0x9,%bl
40000134:	76 ea                	jbe    40000120 <atoi+0x30>
		acc = acc*10 + (buf[loc]-'0');
		loc++;
	}
	if (numstart == loc) {
40000136:	39 c7                	cmp    %eax,%edi
40000138:	74 26                	je     40000160 <atoi+0x70>
		// no numbers have actually been scanned
		return 0;
	}
	if (negative)
		acc = - acc;
4000013a:	89 d1                	mov    %edx,%ecx
4000013c:	f7 d9                	neg    %ecx
4000013e:	85 ed                	test   %ebp,%ebp
40000140:	0f 45 d1             	cmovne %ecx,%edx
	*i = acc;
40000143:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000147:	89 11                	mov    %edx,(%ecx)
	return loc;
}
40000149:	5b                   	pop    %ebx
4000014a:	5e                   	pop    %esi
4000014b:	5f                   	pop    %edi
4000014c:	5d                   	pop    %ebp
4000014d:	c3                   	ret    
4000014e:	66 90                	xchg   %ax,%ax
40000150:	b8 01 00 00 00       	mov    $0x1,%eax
atoi(const char *buf, int *i)
{
	int loc = 0;
	int numstart = 0;
	int acc = 0;
	int negative = 0;
40000155:	31 ed                	xor    %ebp,%ebp
	if (buf[loc] == '+')
		loc++;
40000157:	bf 01 00 00 00       	mov    $0x1,%edi
4000015c:	eb ad                	jmp    4000010b <atoi+0x1b>
4000015e:	66 90                	xchg   %ax,%ax
	}
	if (negative)
		acc = - acc;
	*i = acc;
	return loc;
}
40000160:	5b                   	pop    %ebx
		acc = acc*10 + (buf[loc]-'0');
		loc++;
	}
	if (numstart == loc) {
		// no numbers have actually been scanned
		return 0;
40000161:	31 c0                	xor    %eax,%eax
	}
	if (negative)
		acc = - acc;
	*i = acc;
	return loc;
}
40000163:	5e                   	pop    %esi
40000164:	5f                   	pop    %edi
40000165:	5d                   	pop    %ebp
40000166:	c3                   	ret    
40000167:	66 90                	xchg   %ax,%ax
40000169:	66 90                	xchg   %ax,%ax
4000016b:	66 90                	xchg   %ax,%ax
4000016d:	66 90                	xchg   %ax,%ax
4000016f:	90                   	nop

40000170 <putch>:
	char buf[MAX_BUF];
};

static void
putch(int ch, struct printbuf *b)
{
40000170:	53                   	push   %ebx
40000171:	8b 54 24 0c          	mov    0xc(%esp),%edx
	b->buf[b->idx++] = ch;
40000175:	0f b6 5c 24 08       	movzbl 0x8(%esp),%ebx
4000017a:	8b 0a                	mov    (%edx),%ecx
4000017c:	8d 41 01             	lea    0x1(%ecx),%eax
	if (b->idx == MAX_BUF-1) {
4000017f:	3d ff 0f 00 00       	cmp    $0xfff,%eax
};

static void
putch(int ch, struct printbuf *b)
{
	b->buf[b->idx++] = ch;
40000184:	89 02                	mov    %eax,(%edx)
40000186:	88 5c 0a 08          	mov    %bl,0x8(%edx,%ecx,1)
	if (b->idx == MAX_BUF-1) {
4000018a:	75 1a                	jne    400001a6 <putch+0x36>
		b->buf[b->idx] = 0;
4000018c:	c6 82 07 10 00 00 00 	movb   $0x0,0x1007(%edx)
		puts(b->buf, b->idx);
40000193:	8d 5a 08             	lea    0x8(%edx),%ebx
#include <file.h>

static gcc_inline void
sys_puts(const char *s, size_t len)
{
	asm volatile("int %0" :
40000196:	b9 ff 0f 00 00       	mov    $0xfff,%ecx
4000019b:	66 31 c0             	xor    %ax,%ax
4000019e:	cd 30                	int    $0x30
		b->idx = 0;
400001a0:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
	}
	b->cnt++;
400001a6:	83 42 04 01          	addl   $0x1,0x4(%edx)
}
400001aa:	5b                   	pop    %ebx
400001ab:	c3                   	ret    
400001ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

400001b0 <vcprintf>:

int
vcprintf(const char *fmt, va_list ap)
{
400001b0:	53                   	push   %ebx
400001b1:	81 ec 28 10 00 00    	sub    $0x1028,%esp
	struct printbuf b;

	b.idx = 0;
	b.cnt = 0;
	vprintfmt((void*)putch, &b, fmt, ap);
400001b7:	8b 84 24 34 10 00 00 	mov    0x1034(%esp),%eax
400001be:	8d 5c 24 20          	lea    0x20(%esp),%ebx
400001c2:	c7 04 24 70 01 00 40 	movl   $0x40000170,(%esp)
int
vcprintf(const char *fmt, va_list ap)
{
	struct printbuf b;

	b.idx = 0;
400001c9:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
400001d0:	00 
	b.cnt = 0;
400001d1:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
400001d8:	00 
	vprintfmt((void*)putch, &b, fmt, ap);
400001d9:	89 44 24 0c          	mov    %eax,0xc(%esp)
400001dd:	8b 84 24 30 10 00 00 	mov    0x1030(%esp),%eax
400001e4:	89 44 24 08          	mov    %eax,0x8(%esp)
400001e8:	8d 44 24 18          	lea    0x18(%esp),%eax
400001ec:	89 44 24 04          	mov    %eax,0x4(%esp)
400001f0:	e8 7b 01 00 00       	call   40000370 <vprintfmt>

	b.buf[b.idx] = 0;
400001f5:	8b 4c 24 18          	mov    0x18(%esp),%ecx
400001f9:	31 c0                	xor    %eax,%eax
400001fb:	c6 44 0c 20 00       	movb   $0x0,0x20(%esp,%ecx,1)
40000200:	cd 30                	int    $0x30
	puts(b.buf, b.idx);

	return b.cnt;
}
40000202:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000206:	81 c4 28 10 00 00    	add    $0x1028,%esp
4000020c:	5b                   	pop    %ebx
4000020d:	c3                   	ret    
4000020e:	66 90                	xchg   %ax,%ax

40000210 <printf>:

int
printf(const char *fmt, ...)
{
40000210:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	int cnt;

	va_start(ap, fmt);
	cnt = vcprintf(fmt, ap);
40000213:	8d 44 24 24          	lea    0x24(%esp),%eax
40000217:	89 44 24 04          	mov    %eax,0x4(%esp)
4000021b:	8b 44 24 20          	mov    0x20(%esp),%eax
4000021f:	89 04 24             	mov    %eax,(%esp)
40000222:	e8 89 ff ff ff       	call   400001b0 <vcprintf>
	va_end(ap);

	return cnt;
}
40000227:	83 c4 1c             	add    $0x1c,%esp
4000022a:	c3                   	ret    
4000022b:	66 90                	xchg   %ax,%ax
4000022d:	66 90                	xchg   %ax,%ax
4000022f:	90                   	nop

40000230 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
40000230:	55                   	push   %ebp
40000231:	57                   	push   %edi
40000232:	89 d7                	mov    %edx,%edi
40000234:	56                   	push   %esi
40000235:	89 c6                	mov    %eax,%esi
40000237:	53                   	push   %ebx
40000238:	83 ec 3c             	sub    $0x3c,%esp
4000023b:	8b 44 24 50          	mov    0x50(%esp),%eax
4000023f:	8b 4c 24 58          	mov    0x58(%esp),%ecx
40000243:	8b 5c 24 5c          	mov    0x5c(%esp),%ebx
40000247:	8b 6c 24 60          	mov    0x60(%esp),%ebp
4000024b:	89 44 24 20          	mov    %eax,0x20(%esp)
4000024f:	8b 44 24 54          	mov    0x54(%esp),%eax
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
40000253:	89 ca                	mov    %ecx,%edx
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
40000255:	89 4c 24 28          	mov    %ecx,0x28(%esp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
40000259:	31 c9                	xor    %ecx,%ecx
4000025b:	89 54 24 18          	mov    %edx,0x18(%esp)
4000025f:	39 c1                	cmp    %eax,%ecx
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
40000261:	89 44 24 24          	mov    %eax,0x24(%esp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
40000265:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
40000269:	0f 83 a9 00 00 00    	jae    40000318 <printnum+0xe8>
		printnum(putch, putdat, num / base, base, width - 1, padc);
4000026f:	8b 44 24 28          	mov    0x28(%esp),%eax
40000273:	83 eb 01             	sub    $0x1,%ebx
40000276:	8b 54 24 1c          	mov    0x1c(%esp),%edx
4000027a:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
4000027e:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40000282:	89 6c 24 10          	mov    %ebp,0x10(%esp)
40000286:	89 44 24 08          	mov    %eax,0x8(%esp)
4000028a:	8b 44 24 18          	mov    0x18(%esp),%eax
4000028e:	8b 4c 24 08          	mov    0x8(%esp),%ecx
40000292:	89 54 24 0c          	mov    %edx,0xc(%esp)
40000296:	89 5c 24 2c          	mov    %ebx,0x2c(%esp)
4000029a:	89 44 24 08          	mov    %eax,0x8(%esp)
4000029e:	8b 44 24 20          	mov    0x20(%esp),%eax
400002a2:	89 4c 24 28          	mov    %ecx,0x28(%esp)
400002a6:	89 04 24             	mov    %eax,(%esp)
400002a9:	8b 44 24 24          	mov    0x24(%esp),%eax
400002ad:	89 44 24 04          	mov    %eax,0x4(%esp)
400002b1:	e8 ca 0b 00 00       	call   40000e80 <__udivdi3>
400002b6:	8b 4c 24 28          	mov    0x28(%esp),%ecx
400002ba:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
400002be:	89 4c 24 08          	mov    %ecx,0x8(%esp)
400002c2:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
400002c6:	89 04 24             	mov    %eax,(%esp)
400002c9:	89 f0                	mov    %esi,%eax
400002cb:	89 54 24 04          	mov    %edx,0x4(%esp)
400002cf:	89 fa                	mov    %edi,%edx
400002d1:	e8 5a ff ff ff       	call   40000230 <printnum>
		while (--width > 0)
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
400002d6:	8b 44 24 18          	mov    0x18(%esp),%eax
400002da:	8b 54 24 1c          	mov    0x1c(%esp),%edx
400002de:	89 7c 24 54          	mov    %edi,0x54(%esp)
400002e2:	89 44 24 08          	mov    %eax,0x8(%esp)
400002e6:	8b 44 24 20          	mov    0x20(%esp),%eax
400002ea:	89 54 24 0c          	mov    %edx,0xc(%esp)
400002ee:	89 04 24             	mov    %eax,(%esp)
400002f1:	8b 44 24 24          	mov    0x24(%esp),%eax
400002f5:	89 44 24 04          	mov    %eax,0x4(%esp)
400002f9:	e8 b2 0c 00 00       	call   40000fb0 <__umoddi3>
400002fe:	0f be 80 2c 11 00 40 	movsbl 0x4000112c(%eax),%eax
40000305:	89 44 24 50          	mov    %eax,0x50(%esp)
}
40000309:	83 c4 3c             	add    $0x3c,%esp
		while (--width > 0)
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
4000030c:	89 f0                	mov    %esi,%eax
}
4000030e:	5b                   	pop    %ebx
4000030f:	5e                   	pop    %esi
40000310:	5f                   	pop    %edi
40000311:	5d                   	pop    %ebp
		while (--width > 0)
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
40000312:	ff e0                	jmp    *%eax
40000314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
40000318:	76 1e                	jbe    40000338 <printnum+0x108>
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
4000031a:	83 eb 01             	sub    $0x1,%ebx
4000031d:	85 db                	test   %ebx,%ebx
4000031f:	7e b5                	jle    400002d6 <printnum+0xa6>
40000321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			putch(padc, putdat);
40000328:	89 7c 24 04          	mov    %edi,0x4(%esp)
4000032c:	89 2c 24             	mov    %ebp,(%esp)
4000032f:	ff d6                	call   *%esi
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
40000331:	83 eb 01             	sub    $0x1,%ebx
40000334:	75 f2                	jne    40000328 <printnum+0xf8>
40000336:	eb 9e                	jmp    400002d6 <printnum+0xa6>
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
40000338:	8b 44 24 20          	mov    0x20(%esp),%eax
4000033c:	39 44 24 28          	cmp    %eax,0x28(%esp)
40000340:	0f 86 29 ff ff ff    	jbe    4000026f <printnum+0x3f>
40000346:	eb d2                	jmp    4000031a <printnum+0xea>
40000348:	90                   	nop
40000349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000350 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
40000350:	8b 44 24 08          	mov    0x8(%esp),%eax
	b->cnt++;
	if (b->buf < b->ebuf)
40000354:	8b 10                	mov    (%eax),%edx
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
	b->cnt++;
40000356:	83 40 08 01          	addl   $0x1,0x8(%eax)
	if (b->buf < b->ebuf)
4000035a:	3b 50 04             	cmp    0x4(%eax),%edx
4000035d:	73 0b                	jae    4000036a <sprintputch+0x1a>
		*b->buf++ = ch;
4000035f:	8d 4a 01             	lea    0x1(%edx),%ecx
40000362:	89 08                	mov    %ecx,(%eax)
40000364:	8b 44 24 04          	mov    0x4(%esp),%eax
40000368:	88 02                	mov    %al,(%edx)
4000036a:	f3 c3                	repz ret 
4000036c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000370 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
40000370:	55                   	push   %ebp
40000371:	57                   	push   %edi
40000372:	56                   	push   %esi
40000373:	53                   	push   %ebx
40000374:	83 ec 3c             	sub    $0x3c,%esp
40000377:	8b 6c 24 50          	mov    0x50(%esp),%ebp
4000037b:	8b 74 24 54          	mov    0x54(%esp),%esi
4000037f:	8b 7c 24 58          	mov    0x58(%esp),%edi
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
40000383:	0f b6 07             	movzbl (%edi),%eax
40000386:	8d 5f 01             	lea    0x1(%edi),%ebx
40000389:	83 f8 25             	cmp    $0x25,%eax
4000038c:	75 17                	jne    400003a5 <vprintfmt+0x35>
4000038e:	eb 28                	jmp    400003b8 <vprintfmt+0x48>
40000390:	83 c3 01             	add    $0x1,%ebx
			if (ch == '\0')
				return;
			putch(ch, putdat);
40000393:	89 04 24             	mov    %eax,(%esp)
40000396:	89 74 24 04          	mov    %esi,0x4(%esp)
4000039a:	ff d5                	call   *%ebp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
4000039c:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
400003a0:	83 f8 25             	cmp    $0x25,%eax
400003a3:	74 13                	je     400003b8 <vprintfmt+0x48>
			if (ch == '\0')
400003a5:	85 c0                	test   %eax,%eax
400003a7:	75 e7                	jne    40000390 <vprintfmt+0x20>
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
400003a9:	83 c4 3c             	add    $0x3c,%esp
400003ac:	5b                   	pop    %ebx
400003ad:	5e                   	pop    %esi
400003ae:	5f                   	pop    %edi
400003af:	5d                   	pop    %ebp
400003b0:	c3                   	ret    
400003b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			if (width < 0)
				width = 0;
			goto reswitch;

		case '#':
			altflag = 1;
400003b8:	c6 44 24 24 20       	movb   $0x20,0x24(%esp)
400003bd:	ba ff ff ff ff       	mov    $0xffffffff,%edx
400003c2:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
400003c9:	00 
400003ca:	c7 44 24 20 ff ff ff 	movl   $0xffffffff,0x20(%esp)
400003d1:	ff 
400003d2:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
400003d9:	00 
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
400003da:	0f b6 03             	movzbl (%ebx),%eax
400003dd:	8d 7b 01             	lea    0x1(%ebx),%edi
400003e0:	0f b6 c8             	movzbl %al,%ecx
400003e3:	83 e8 23             	sub    $0x23,%eax
400003e6:	3c 55                	cmp    $0x55,%al
400003e8:	0f 87 69 02 00 00    	ja     40000657 <vprintfmt+0x2e7>
400003ee:	0f b6 c0             	movzbl %al,%eax
400003f1:	ff 24 85 44 11 00 40 	jmp    *0x40001144(,%eax,4)
400003f8:	89 fb                	mov    %edi,%ebx
			padc = '-';
			goto reswitch;

			// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
400003fa:	c6 44 24 24 30       	movb   $0x30,0x24(%esp)
400003ff:	eb d9                	jmp    400003da <vprintfmt+0x6a>
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
				precision = precision * 10 + ch - '0';
				ch = *fmt;
40000401:	0f be 43 01          	movsbl 0x1(%ebx),%eax
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
				precision = precision * 10 + ch - '0';
40000405:	8d 51 d0             	lea    -0x30(%ecx),%edx
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
40000408:	89 fb                	mov    %edi,%ebx
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
4000040a:	8d 48 d0             	lea    -0x30(%eax),%ecx
4000040d:	83 f9 09             	cmp    $0x9,%ecx
40000410:	0f 87 02 02 00 00    	ja     40000618 <vprintfmt+0x2a8>
40000416:	66 90                	xchg   %ax,%ax
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
40000418:	83 c3 01             	add    $0x1,%ebx
				precision = precision * 10 + ch - '0';
4000041b:	8d 14 92             	lea    (%edx,%edx,4),%edx
4000041e:	8d 54 50 d0          	lea    -0x30(%eax,%edx,2),%edx
				ch = *fmt;
40000422:	0f be 03             	movsbl (%ebx),%eax
				if (ch < '0' || ch > '9')
40000425:	8d 48 d0             	lea    -0x30(%eax),%ecx
40000428:	83 f9 09             	cmp    $0x9,%ecx
4000042b:	76 eb                	jbe    40000418 <vprintfmt+0xa8>
4000042d:	e9 e6 01 00 00       	jmp    40000618 <vprintfmt+0x2a8>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
40000432:	8b 44 24 5c          	mov    0x5c(%esp),%eax
			lflag++;
			goto reswitch;

			// character
		case 'c':
			putch(va_arg(ap, int), putdat);
40000436:	89 74 24 04          	mov    %esi,0x4(%esp)
4000043a:	83 44 24 5c 04       	addl   $0x4,0x5c(%esp)
4000043f:	8b 00                	mov    (%eax),%eax
40000441:	89 04 24             	mov    %eax,(%esp)
40000444:	ff d5                	call   *%ebp
			break;
40000446:	e9 38 ff ff ff       	jmp    40000383 <vprintfmt+0x13>
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, long long);
4000044b:	8b 44 24 5c          	mov    0x5c(%esp),%eax
// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
4000044f:	83 7c 24 28 01       	cmpl   $0x1,0x28(%esp)
		return va_arg(*ap, long long);
40000454:	8b 08                	mov    (%eax),%ecx
// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
40000456:	0f 8e e7 02 00 00    	jle    40000743 <vprintfmt+0x3d3>
		return va_arg(*ap, long long);
4000045c:	8b 58 04             	mov    0x4(%eax),%ebx
4000045f:	83 c0 08             	add    $0x8,%eax
40000462:	89 44 24 5c          	mov    %eax,0x5c(%esp)
				putch(' ', putdat);
			break;

			// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
40000466:	89 ca                	mov    %ecx,%edx
40000468:	89 d9                	mov    %ebx,%ecx
			if ((long long) num < 0) {
4000046a:	85 c9                	test   %ecx,%ecx
4000046c:	bb 0a 00 00 00       	mov    $0xa,%ebx
40000471:	0f 88 dd 02 00 00    	js     40000754 <vprintfmt+0x3e4>
			// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
			base = 16;
		number:
			printnum(putch, putdat, num, base, width, padc);
40000477:	0f be 44 24 24       	movsbl 0x24(%esp),%eax
4000047c:	89 14 24             	mov    %edx,(%esp)
4000047f:	89 f2                	mov    %esi,%edx
40000481:	89 5c 24 08          	mov    %ebx,0x8(%esp)
40000485:	89 4c 24 04          	mov    %ecx,0x4(%esp)
40000489:	89 44 24 10          	mov    %eax,0x10(%esp)
4000048d:	8b 44 24 20          	mov    0x20(%esp),%eax
40000491:	89 44 24 0c          	mov    %eax,0xc(%esp)
40000495:	89 e8                	mov    %ebp,%eax
40000497:	e8 94 fd ff ff       	call   40000230 <printnum>
			break;
4000049c:	e9 e2 fe ff ff       	jmp    40000383 <vprintfmt+0x13>
				width = precision, precision = -1;
			goto reswitch;

			// long flag (doubled for long long)
		case 'l':
			lflag++;
400004a1:	83 44 24 28 01       	addl   $0x1,0x28(%esp)
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
400004a6:	89 fb                	mov    %edi,%ebx
			goto reswitch;

			// long flag (doubled for long long)
		case 'l':
			lflag++;
			goto reswitch;
400004a8:	e9 2d ff ff ff       	jmp    400003da <vprintfmt+0x6a>
			num = getuint(&ap, lflag);
			base = 8;
			goto number;
#else
			// Replace this with your code.
			putch('X', putdat);
400004ad:	89 74 24 04          	mov    %esi,0x4(%esp)
400004b1:	c7 04 24 58 00 00 00 	movl   $0x58,(%esp)
400004b8:	ff d5                	call   *%ebp
			putch('X', putdat);
400004ba:	89 74 24 04          	mov    %esi,0x4(%esp)
400004be:	c7 04 24 58 00 00 00 	movl   $0x58,(%esp)
400004c5:	ff d5                	call   *%ebp
			putch('X', putdat);
400004c7:	89 74 24 04          	mov    %esi,0x4(%esp)
400004cb:	c7 04 24 58 00 00 00 	movl   $0x58,(%esp)
400004d2:	ff d5                	call   *%ebp
			break;
400004d4:	e9 aa fe ff ff       	jmp    40000383 <vprintfmt+0x13>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
400004d9:	8b 5c 24 5c          	mov    0x5c(%esp),%ebx
			break;
#endif

			// pointer
		case 'p':
			putch('0', putdat);
400004dd:	89 74 24 04          	mov    %esi,0x4(%esp)
400004e1:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
400004e8:	ff d5                	call   *%ebp
			putch('x', putdat);
400004ea:	89 74 24 04          	mov    %esi,0x4(%esp)
400004ee:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
400004f5:	ff d5                	call   *%ebp
			num = (unsigned long long)
400004f7:	8b 13                	mov    (%ebx),%edx
400004f9:	31 c9                	xor    %ecx,%ecx
				(uintptr_t) va_arg(ap, void *);
400004fb:	83 44 24 5c 04       	addl   $0x4,0x5c(%esp)
			base = 16;
			goto number;
40000500:	bb 10 00 00 00       	mov    $0x10,%ebx
40000505:	e9 6d ff ff ff       	jmp    40000477 <vprintfmt+0x107>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
4000050a:	8b 44 24 5c          	mov    0x5c(%esp),%eax
			putch(va_arg(ap, int), putdat);
			break;

			// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
4000050e:	83 44 24 5c 04       	addl   $0x4,0x5c(%esp)
40000513:	8b 08                	mov    (%eax),%ecx
				p = "(null)";
40000515:	b8 3d 11 00 40       	mov    $0x4000113d,%eax
4000051a:	85 c9                	test   %ecx,%ecx
4000051c:	0f 44 c8             	cmove  %eax,%ecx
			if (width > 0 && padc != '-')
4000051f:	80 7c 24 24 2d       	cmpb   $0x2d,0x24(%esp)
40000524:	0f 85 a9 01 00 00    	jne    400006d3 <vprintfmt+0x363>
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
4000052a:	0f be 01             	movsbl (%ecx),%eax
4000052d:	8d 59 01             	lea    0x1(%ecx),%ebx
40000530:	85 c0                	test   %eax,%eax
40000532:	0f 84 52 01 00 00    	je     4000068a <vprintfmt+0x31a>
40000538:	89 74 24 54          	mov    %esi,0x54(%esp)
4000053c:	89 de                	mov    %ebx,%esi
4000053e:	89 d3                	mov    %edx,%ebx
40000540:	89 7c 24 58          	mov    %edi,0x58(%esp)
40000544:	8b 7c 24 20          	mov    0x20(%esp),%edi
40000548:	eb 25                	jmp    4000056f <vprintfmt+0x1ff>
4000054a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
40000550:	8b 4c 24 54          	mov    0x54(%esp),%ecx
40000554:	89 04 24             	mov    %eax,(%esp)
40000557:	89 4c 24 04          	mov    %ecx,0x4(%esp)
4000055b:	ff d5                	call   *%ebp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
4000055d:	83 c6 01             	add    $0x1,%esi
40000560:	0f be 46 ff          	movsbl -0x1(%esi),%eax
40000564:	83 ef 01             	sub    $0x1,%edi
40000567:	85 c0                	test   %eax,%eax
40000569:	0f 84 0f 01 00 00    	je     4000067e <vprintfmt+0x30e>
4000056f:	85 db                	test   %ebx,%ebx
40000571:	78 0c                	js     4000057f <vprintfmt+0x20f>
40000573:	83 eb 01             	sub    $0x1,%ebx
40000576:	83 fb ff             	cmp    $0xffffffff,%ebx
40000579:	0f 84 ff 00 00 00    	je     4000067e <vprintfmt+0x30e>
				if (altflag && (ch < ' ' || ch > '~'))
4000057f:	8b 54 24 18          	mov    0x18(%esp),%edx
40000583:	85 d2                	test   %edx,%edx
40000585:	74 c9                	je     40000550 <vprintfmt+0x1e0>
40000587:	8d 48 e0             	lea    -0x20(%eax),%ecx
4000058a:	83 f9 5e             	cmp    $0x5e,%ecx
4000058d:	76 c1                	jbe    40000550 <vprintfmt+0x1e0>
					putch('?', putdat);
4000058f:	8b 44 24 54          	mov    0x54(%esp),%eax
40000593:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
4000059a:	89 44 24 04          	mov    %eax,0x4(%esp)
4000059e:	ff d5                	call   *%ebp
400005a0:	eb bb                	jmp    4000055d <vprintfmt+0x1ed>
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, unsigned long long);
400005a2:	8b 44 24 5c          	mov    0x5c(%esp),%eax
// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
400005a6:	83 7c 24 28 01       	cmpl   $0x1,0x28(%esp)
		return va_arg(*ap, unsigned long long);
400005ab:	8b 10                	mov    (%eax),%edx
// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
400005ad:	0f 8e 04 01 00 00    	jle    400006b7 <vprintfmt+0x347>
		return va_arg(*ap, unsigned long long);
400005b3:	8b 48 04             	mov    0x4(%eax),%ecx
400005b6:	83 c0 08             	add    $0x8,%eax
400005b9:	89 44 24 5c          	mov    %eax,0x5c(%esp)

			// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
			base = 10;
			goto number;
400005bd:	bb 0a 00 00 00       	mov    $0xa,%ebx
400005c2:	e9 b0 fe ff ff       	jmp    40000477 <vprintfmt+0x107>
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, unsigned long long);
400005c7:	8b 44 24 5c          	mov    0x5c(%esp),%eax
// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
400005cb:	83 7c 24 28 01       	cmpl   $0x1,0x28(%esp)
		return va_arg(*ap, unsigned long long);
400005d0:	8b 10                	mov    (%eax),%edx
// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
400005d2:	0f 8e ed 00 00 00    	jle    400006c5 <vprintfmt+0x355>
		return va_arg(*ap, unsigned long long);
400005d8:	8b 48 04             	mov    0x4(%eax),%ecx
400005db:	83 c0 08             	add    $0x8,%eax
400005de:	89 44 24 5c          	mov    %eax,0x5c(%esp)
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
				(uintptr_t) va_arg(ap, void *);
			base = 16;
			goto number;
400005e2:	bb 10 00 00 00       	mov    $0x10,%ebx
400005e7:	e9 8b fe ff ff       	jmp    40000477 <vprintfmt+0x107>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
400005ec:	89 fb                	mov    %edi,%ebx
			if (width < 0)
				width = 0;
			goto reswitch;

		case '#':
			altflag = 1;
400005ee:	c7 44 24 18 01 00 00 	movl   $0x1,0x18(%esp)
400005f5:	00 
			goto reswitch;
400005f6:	e9 df fd ff ff       	jmp    400003da <vprintfmt+0x6a>
			printnum(putch, putdat, num, base, width, padc);
			break;

			// escaped '%' character
		case '%':
			putch(ch, putdat);
400005fb:	89 74 24 04          	mov    %esi,0x4(%esp)
400005ff:	89 0c 24             	mov    %ecx,(%esp)
40000602:	ff d5                	call   *%ebp
			break;
40000604:	e9 7a fd ff ff       	jmp    40000383 <vprintfmt+0x13>
					break;
			}
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
40000609:	8b 44 24 5c          	mov    0x5c(%esp),%eax
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
4000060d:	89 fb                	mov    %edi,%ebx
					break;
			}
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
4000060f:	8b 10                	mov    (%eax),%edx
40000611:	83 c0 04             	add    $0x4,%eax
40000614:	89 44 24 5c          	mov    %eax,0x5c(%esp)
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
40000618:	8b 7c 24 20          	mov    0x20(%esp),%edi
4000061c:	85 ff                	test   %edi,%edi
4000061e:	0f 89 b6 fd ff ff    	jns    400003da <vprintfmt+0x6a>
				width = precision, precision = -1;
40000624:	89 54 24 20          	mov    %edx,0x20(%esp)
40000628:	ba ff ff ff ff       	mov    $0xffffffff,%edx
4000062d:	e9 a8 fd ff ff       	jmp    400003da <vprintfmt+0x6a>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
40000632:	89 fb                	mov    %edi,%ebx

			// flag to pad on the right
		case '-':
			padc = '-';
40000634:	c6 44 24 24 2d       	movb   $0x2d,0x24(%esp)
40000639:	e9 9c fd ff ff       	jmp    400003da <vprintfmt+0x6a>
4000063e:	8b 4c 24 20          	mov    0x20(%esp),%ecx
40000642:	b8 00 00 00 00       	mov    $0x0,%eax
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
40000647:	89 fb                	mov    %edi,%ebx
40000649:	85 c9                	test   %ecx,%ecx
4000064b:	0f 49 c1             	cmovns %ecx,%eax
4000064e:	89 44 24 20          	mov    %eax,0x20(%esp)
40000652:	e9 83 fd ff ff       	jmp    400003da <vprintfmt+0x6a>
			putch(ch, putdat);
			break;

			// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
40000657:	89 74 24 04          	mov    %esi,0x4(%esp)
			for (fmt--; fmt[-1] != '%'; fmt--)
4000065b:	89 df                	mov    %ebx,%edi
			putch(ch, putdat);
			break;

			// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
4000065d:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
40000664:	ff d5                	call   *%ebp
			for (fmt--; fmt[-1] != '%'; fmt--)
40000666:	80 7b ff 25          	cmpb   $0x25,-0x1(%ebx)
4000066a:	0f 84 13 fd ff ff    	je     40000383 <vprintfmt+0x13>
40000670:	83 ef 01             	sub    $0x1,%edi
40000673:	80 7f ff 25          	cmpb   $0x25,-0x1(%edi)
40000677:	75 f7                	jne    40000670 <vprintfmt+0x300>
40000679:	e9 05 fd ff ff       	jmp    40000383 <vprintfmt+0x13>
4000067e:	89 7c 24 20          	mov    %edi,0x20(%esp)
40000682:	8b 74 24 54          	mov    0x54(%esp),%esi
40000686:	8b 7c 24 58          	mov    0x58(%esp),%edi
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
4000068a:	8b 4c 24 20          	mov    0x20(%esp),%ecx
4000068e:	8b 5c 24 20          	mov    0x20(%esp),%ebx
40000692:	85 c9                	test   %ecx,%ecx
40000694:	0f 8e e9 fc ff ff    	jle    40000383 <vprintfmt+0x13>
4000069a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
				putch(' ', putdat);
400006a0:	89 74 24 04          	mov    %esi,0x4(%esp)
400006a4:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
400006ab:	ff d5                	call   *%ebp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
400006ad:	83 eb 01             	sub    $0x1,%ebx
400006b0:	75 ee                	jne    400006a0 <vprintfmt+0x330>
400006b2:	e9 cc fc ff ff       	jmp    40000383 <vprintfmt+0x13>
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, unsigned long long);
	else if (lflag)
		return va_arg(*ap, unsigned long);
400006b7:	83 c0 04             	add    $0x4,%eax
400006ba:	31 c9                	xor    %ecx,%ecx
400006bc:	89 44 24 5c          	mov    %eax,0x5c(%esp)
400006c0:	e9 f8 fe ff ff       	jmp    400005bd <vprintfmt+0x24d>
400006c5:	83 c0 04             	add    $0x4,%eax
400006c8:	31 c9                	xor    %ecx,%ecx
400006ca:	89 44 24 5c          	mov    %eax,0x5c(%esp)
400006ce:	e9 0f ff ff ff       	jmp    400005e2 <vprintfmt+0x272>

			// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
400006d3:	8b 5c 24 20          	mov    0x20(%esp),%ebx
400006d7:	85 db                	test   %ebx,%ebx
400006d9:	0f 8e 4b fe ff ff    	jle    4000052a <vprintfmt+0x1ba>
				for (width -= strnlen(p, precision); width > 0; width--)
400006df:	89 54 24 04          	mov    %edx,0x4(%esp)
400006e3:	89 0c 24             	mov    %ecx,(%esp)
400006e6:	89 54 24 2c          	mov    %edx,0x2c(%esp)
400006ea:	89 4c 24 28          	mov    %ecx,0x28(%esp)
400006ee:	e8 ad 02 00 00       	call   400009a0 <strnlen>
400006f3:	8b 4c 24 28          	mov    0x28(%esp),%ecx
400006f7:	8b 54 24 2c          	mov    0x2c(%esp),%edx
400006fb:	29 44 24 20          	sub    %eax,0x20(%esp)
400006ff:	8b 44 24 20          	mov    0x20(%esp),%eax
40000703:	85 c0                	test   %eax,%eax
40000705:	0f 8e 1f fe ff ff    	jle    4000052a <vprintfmt+0x1ba>
4000070b:	0f be 5c 24 24       	movsbl 0x24(%esp),%ebx
40000710:	89 7c 24 58          	mov    %edi,0x58(%esp)
40000714:	89 c7                	mov    %eax,%edi
40000716:	89 4c 24 20          	mov    %ecx,0x20(%esp)
4000071a:	89 54 24 24          	mov    %edx,0x24(%esp)
4000071e:	66 90                	xchg   %ax,%ax
					putch(padc, putdat);
40000720:	89 74 24 04          	mov    %esi,0x4(%esp)
40000724:	89 1c 24             	mov    %ebx,(%esp)
40000727:	ff d5                	call   *%ebp
			// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
40000729:	83 ef 01             	sub    $0x1,%edi
4000072c:	75 f2                	jne    40000720 <vprintfmt+0x3b0>
4000072e:	8b 4c 24 20          	mov    0x20(%esp),%ecx
40000732:	8b 54 24 24          	mov    0x24(%esp),%edx
40000736:	89 7c 24 20          	mov    %edi,0x20(%esp)
4000073a:	8b 7c 24 58          	mov    0x58(%esp),%edi
4000073e:	e9 e7 fd ff ff       	jmp    4000052a <vprintfmt+0x1ba>
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, long long);
	else if (lflag)
		return va_arg(*ap, long);
40000743:	89 cb                	mov    %ecx,%ebx
40000745:	83 c0 04             	add    $0x4,%eax
40000748:	c1 fb 1f             	sar    $0x1f,%ebx
4000074b:	89 44 24 5c          	mov    %eax,0x5c(%esp)
4000074f:	e9 12 fd ff ff       	jmp    40000466 <vprintfmt+0xf6>
40000754:	89 54 24 18          	mov    %edx,0x18(%esp)
40000758:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)

			// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
			if ((long long) num < 0) {
				putch('-', putdat);
4000075c:	89 74 24 04          	mov    %esi,0x4(%esp)
40000760:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
40000767:	ff d5                	call   *%ebp
				num = -(long long) num;
40000769:	8b 54 24 18          	mov    0x18(%esp),%edx
4000076d:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
40000771:	f7 da                	neg    %edx
40000773:	83 d1 00             	adc    $0x0,%ecx
40000776:	f7 d9                	neg    %ecx
40000778:	e9 fa fc ff ff       	jmp    40000477 <vprintfmt+0x107>
4000077d:	8d 76 00             	lea    0x0(%esi),%esi

40000780 <printfmt>:
	}
}

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
40000780:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;

	va_start(ap, fmt);
	vprintfmt(putch, putdat, fmt, ap);
40000783:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000787:	89 44 24 0c          	mov    %eax,0xc(%esp)
4000078b:	8b 44 24 28          	mov    0x28(%esp),%eax
4000078f:	89 44 24 08          	mov    %eax,0x8(%esp)
40000793:	8b 44 24 24          	mov    0x24(%esp),%eax
40000797:	89 44 24 04          	mov    %eax,0x4(%esp)
4000079b:	8b 44 24 20          	mov    0x20(%esp),%eax
4000079f:	89 04 24             	mov    %eax,(%esp)
400007a2:	e8 c9 fb ff ff       	call   40000370 <vprintfmt>
	va_end(ap);
}
400007a7:	83 c4 1c             	add    $0x1c,%esp
400007aa:	c3                   	ret    
400007ab:	90                   	nop
400007ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

400007b0 <vsprintf>:
		*b->buf++ = ch;
}

int
vsprintf(char *buf, const char *fmt, va_list ap)
{
400007b0:	83 ec 2c             	sub    $0x2c,%esp
	//assert(buf != NULL);
	struct sprintbuf b = {buf, (char*)(intptr_t)~0, 0};
400007b3:	8b 44 24 30          	mov    0x30(%esp),%eax

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
400007b7:	c7 04 24 50 03 00 40 	movl   $0x40000350,(%esp)

int
vsprintf(char *buf, const char *fmt, va_list ap)
{
	//assert(buf != NULL);
	struct sprintbuf b = {buf, (char*)(intptr_t)~0, 0};
400007be:	c7 44 24 18 ff ff ff 	movl   $0xffffffff,0x18(%esp)
400007c5:	ff 
400007c6:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
400007cd:	00 
400007ce:	89 44 24 14          	mov    %eax,0x14(%esp)

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
400007d2:	8b 44 24 38          	mov    0x38(%esp),%eax
400007d6:	89 44 24 0c          	mov    %eax,0xc(%esp)
400007da:	8b 44 24 34          	mov    0x34(%esp),%eax
400007de:	89 44 24 08          	mov    %eax,0x8(%esp)
400007e2:	8d 44 24 14          	lea    0x14(%esp),%eax
400007e6:	89 44 24 04          	mov    %eax,0x4(%esp)
400007ea:	e8 81 fb ff ff       	call   40000370 <vprintfmt>

	// null terminate the buffer
	*b.buf = '\0';
400007ef:	8b 44 24 14          	mov    0x14(%esp),%eax
400007f3:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
}
400007f6:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400007fa:	83 c4 2c             	add    $0x2c,%esp
400007fd:	c3                   	ret    
400007fe:	66 90                	xchg   %ax,%ax

40000800 <sprintf>:

int
sprintf(char *buf, const char *fmt, ...)
{
40000800:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
	rc = vsprintf(buf, fmt, ap);
40000803:	8d 44 24 28          	lea    0x28(%esp),%eax
40000807:	89 44 24 08          	mov    %eax,0x8(%esp)
4000080b:	8b 44 24 24          	mov    0x24(%esp),%eax
4000080f:	89 44 24 04          	mov    %eax,0x4(%esp)
40000813:	8b 44 24 20          	mov    0x20(%esp),%eax
40000817:	89 04 24             	mov    %eax,(%esp)
4000081a:	e8 91 ff ff ff       	call   400007b0 <vsprintf>
	va_end(ap);

	return rc;
}
4000081f:	83 c4 1c             	add    $0x1c,%esp
40000822:	c3                   	ret    
40000823:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000830 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
40000830:	83 ec 2c             	sub    $0x2c,%esp
40000833:	8b 44 24 30          	mov    0x30(%esp),%eax
	//assert(buf != NULL && n > 0);
	struct sprintbuf b = {buf, buf+n-1, 0};
40000837:	8b 54 24 34          	mov    0x34(%esp),%edx

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
4000083b:	c7 04 24 50 03 00 40 	movl   $0x40000350,(%esp)

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
	//assert(buf != NULL && n > 0);
	struct sprintbuf b = {buf, buf+n-1, 0};
40000842:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
40000849:	00 
4000084a:	89 44 24 14          	mov    %eax,0x14(%esp)
4000084e:	8d 44 10 ff          	lea    -0x1(%eax,%edx,1),%eax
40000852:	89 44 24 18          	mov    %eax,0x18(%esp)

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
40000856:	8b 44 24 3c          	mov    0x3c(%esp),%eax
4000085a:	89 44 24 0c          	mov    %eax,0xc(%esp)
4000085e:	8b 44 24 38          	mov    0x38(%esp),%eax
40000862:	89 44 24 08          	mov    %eax,0x8(%esp)
40000866:	8d 44 24 14          	lea    0x14(%esp),%eax
4000086a:	89 44 24 04          	mov    %eax,0x4(%esp)
4000086e:	e8 fd fa ff ff       	call   40000370 <vprintfmt>

	// null terminate the buffer
	*b.buf = '\0';
40000873:	8b 44 24 14          	mov    0x14(%esp),%eax
40000877:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
}
4000087a:	8b 44 24 1c          	mov    0x1c(%esp),%eax
4000087e:	83 c4 2c             	add    $0x2c,%esp
40000881:	c3                   	ret    
40000882:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000890 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
40000890:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
	rc = vsnprintf(buf, n, fmt, ap);
40000893:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000897:	89 44 24 0c          	mov    %eax,0xc(%esp)
4000089b:	8b 44 24 28          	mov    0x28(%esp),%eax
4000089f:	89 44 24 08          	mov    %eax,0x8(%esp)
400008a3:	8b 44 24 24          	mov    0x24(%esp),%eax
400008a7:	89 44 24 04          	mov    %eax,0x4(%esp)
400008ab:	8b 44 24 20          	mov    0x20(%esp),%eax
400008af:	89 04 24             	mov    %eax,(%esp)
400008b2:	e8 79 ff ff ff       	call   40000830 <vsnprintf>
	va_end(ap);

	return rc;
}
400008b7:	83 c4 1c             	add    $0x1c,%esp
400008ba:	c3                   	ret    
400008bb:	66 90                	xchg   %ax,%ax
400008bd:	66 90                	xchg   %ax,%ax
400008bf:	90                   	nop

400008c0 <spawn>:
#include <syscall.h>
#include <types.h>

pid_t
spawn(uintptr_t exec, unsigned int quota)
{
400008c0:	53                   	push   %ebx
sys_spawn(uintptr_t exec, unsigned int quota)
{
	int errno;
	pid_t pid;

	asm volatile("int %2"
400008c1:	b8 01 00 00 00       	mov    $0x1,%eax
400008c6:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
400008ca:	8b 5c 24 08          	mov    0x8(%esp),%ebx
400008ce:	cd 30                	int    $0x30
		       "a" (SYS_spawn),
		       "b" (exec),
		       "c" (quota)
		     : "cc", "memory");

	return errno ? -1 : pid;
400008d0:	ba ff ff ff ff       	mov    $0xffffffff,%edx
400008d5:	85 c0                	test   %eax,%eax
400008d7:	0f 44 d3             	cmove  %ebx,%edx
	return sys_spawn(exec, quota);
}
400008da:	89 d0                	mov    %edx,%eax
400008dc:	5b                   	pop    %ebx
400008dd:	c3                   	ret    
400008de:	66 90                	xchg   %ax,%ax

400008e0 <yield>:
}

static gcc_inline void
sys_yield(void)
{
	asm volatile("int %0" :
400008e0:	b8 02 00 00 00       	mov    $0x2,%eax
400008e5:	cd 30                	int    $0x30
400008e7:	c3                   	ret    
400008e8:	90                   	nop
400008e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

400008f0 <produce>:
}

static gcc_inline void
sys_produce(void)
{
	asm volatile("int %0" :
400008f0:	b8 03 00 00 00       	mov    $0x3,%eax
400008f5:	cd 30                	int    $0x30
400008f7:	c3                   	ret    
400008f8:	90                   	nop
400008f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000900 <consume>:
}

static gcc_inline void
sys_consume(void)
{
	asm volatile("int %0" :
40000900:	b8 04 00 00 00       	mov    $0x4,%eax
40000905:	cd 30                	int    $0x30
40000907:	c3                   	ret    
40000908:	66 90                	xchg   %ax,%ax
4000090a:	66 90                	xchg   %ax,%ax
4000090c:	66 90                	xchg   %ax,%ax
4000090e:	66 90                	xchg   %ax,%ax

40000910 <spinlock_init>:
}

void
spinlock_init(spinlock_t *lk)
{
	*lk = 0;
40000910:	8b 44 24 04          	mov    0x4(%esp),%eax
40000914:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
4000091a:	c3                   	ret    
4000091b:	90                   	nop
4000091c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000920 <spinlock_acquire>:
}

void
spinlock_acquire(spinlock_t *lk)
{
40000920:	8b 54 24 04          	mov    0x4(%esp),%edx
static inline uint32_t
xchg(volatile uint32_t *addr, uint32_t newval)
{
	uint32_t result;

	asm volatile("lock; xchgl %0, %1" :
40000924:	b8 01 00 00 00       	mov    $0x1,%eax
40000929:	f0 87 02             	lock xchg %eax,(%edx)
}

void
spinlock_acquire(spinlock_t *lk)
{
	while(xchg(lk, 1) != 0)
4000092c:	85 c0                	test   %eax,%eax
static inline uint32_t
xchg(volatile uint32_t *addr, uint32_t newval)
{
	uint32_t result;

	asm volatile("lock; xchgl %0, %1" :
4000092e:	b9 01 00 00 00       	mov    $0x1,%ecx
}

void
spinlock_acquire(spinlock_t *lk)
{
	while(xchg(lk, 1) != 0)
40000933:	74 0e                	je     40000943 <spinlock_acquire+0x23>
40000935:	8d 76 00             	lea    0x0(%esi),%esi
		asm volatile("pause");
40000938:	f3 90                	pause  
static inline uint32_t
xchg(volatile uint32_t *addr, uint32_t newval)
{
	uint32_t result;

	asm volatile("lock; xchgl %0, %1" :
4000093a:	89 c8                	mov    %ecx,%eax
4000093c:	f0 87 02             	lock xchg %eax,(%edx)
}

void
spinlock_acquire(spinlock_t *lk)
{
	while(xchg(lk, 1) != 0)
4000093f:	85 c0                	test   %eax,%eax
40000941:	75 f5                	jne    40000938 <spinlock_acquire+0x18>
40000943:	f3 c3                	repz ret 
40000945:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000950 <spinlock_release>:
}

// Release the lock.
void
spinlock_release(spinlock_t *lk)
{
40000950:	8b 54 24 04          	mov    0x4(%esp),%edx

// Check whether this cpu is holding the lock.
bool
spinlock_holding(spinlock_t *lock)
{
	return *lock;
40000954:	8b 02                	mov    (%edx),%eax

// Release the lock.
void
spinlock_release(spinlock_t *lk)
{
	if (spinlock_holding(lk) == FALSE)
40000956:	84 c0                	test   %al,%al
40000958:	74 05                	je     4000095f <spinlock_release+0xf>
static inline uint32_t
xchg(volatile uint32_t *addr, uint32_t newval)
{
	uint32_t result;

	asm volatile("lock; xchgl %0, %1" :
4000095a:	31 c0                	xor    %eax,%eax
4000095c:	f0 87 02             	lock xchg %eax,(%edx)
4000095f:	f3 c3                	repz ret 
40000961:	eb 0d                	jmp    40000970 <spinlock_holding>
40000963:	90                   	nop
40000964:	90                   	nop
40000965:	90                   	nop
40000966:	90                   	nop
40000967:	90                   	nop
40000968:	90                   	nop
40000969:	90                   	nop
4000096a:	90                   	nop
4000096b:	90                   	nop
4000096c:	90                   	nop
4000096d:	90                   	nop
4000096e:	90                   	nop
4000096f:	90                   	nop

40000970 <spinlock_holding>:

// Check whether this cpu is holding the lock.
bool
spinlock_holding(spinlock_t *lock)
{
	return *lock;
40000970:	8b 44 24 04          	mov    0x4(%esp),%eax
40000974:	8b 00                	mov    (%eax),%eax
}
40000976:	c3                   	ret    
40000977:	66 90                	xchg   %ax,%ax
40000979:	66 90                	xchg   %ax,%ax
4000097b:	66 90                	xchg   %ax,%ax
4000097d:	66 90                	xchg   %ax,%ax
4000097f:	90                   	nop

40000980 <strlen>:
#include <string.h>
#include <types.h>

int
strlen(const char *s)
{
40000980:	8b 54 24 04          	mov    0x4(%esp),%edx
	int n;

	for (n = 0; *s != '\0'; s++)
40000984:	31 c0                	xor    %eax,%eax
40000986:	80 3a 00             	cmpb   $0x0,(%edx)
40000989:	74 10                	je     4000099b <strlen+0x1b>
4000098b:	90                   	nop
4000098c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		n++;
40000990:	83 c0 01             	add    $0x1,%eax
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
40000993:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
40000997:	75 f7                	jne    40000990 <strlen+0x10>
40000999:	f3 c3                	repz ret 
		n++;
	return n;
}
4000099b:	f3 c3                	repz ret 
4000099d:	8d 76 00             	lea    0x0(%esi),%esi

400009a0 <strnlen>:

int
strnlen(const char *s, size_t size)
{
400009a0:	53                   	push   %ebx
400009a1:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
400009a5:	8b 5c 24 08          	mov    0x8(%esp),%ebx
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
400009a9:	85 c9                	test   %ecx,%ecx
400009ab:	74 25                	je     400009d2 <strnlen+0x32>
400009ad:	80 3b 00             	cmpb   $0x0,(%ebx)
400009b0:	74 20                	je     400009d2 <strnlen+0x32>
400009b2:	ba 01 00 00 00       	mov    $0x1,%edx
400009b7:	eb 11                	jmp    400009ca <strnlen+0x2a>
400009b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400009c0:	83 c2 01             	add    $0x1,%edx
400009c3:	80 7c 13 ff 00       	cmpb   $0x0,-0x1(%ebx,%edx,1)
400009c8:	74 06                	je     400009d0 <strnlen+0x30>
400009ca:	39 ca                	cmp    %ecx,%edx
		n++;
400009cc:	89 d0                	mov    %edx,%eax
int
strnlen(const char *s, size_t size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
400009ce:	75 f0                	jne    400009c0 <strnlen+0x20>
		n++;
	return n;
}
400009d0:	5b                   	pop    %ebx
400009d1:	c3                   	ret    
int
strnlen(const char *s, size_t size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
400009d2:	31 c0                	xor    %eax,%eax
		n++;
	return n;
}
400009d4:	5b                   	pop    %ebx
400009d5:	c3                   	ret    
400009d6:	8d 76 00             	lea    0x0(%esi),%esi
400009d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

400009e0 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
400009e0:	53                   	push   %ebx
400009e1:	8b 44 24 08          	mov    0x8(%esp),%eax
400009e5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
	char *ret;

	ret = dst;
	while ((*dst++ = *src++) != '\0')
400009e9:	89 c2                	mov    %eax,%edx
400009eb:	90                   	nop
400009ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400009f0:	83 c1 01             	add    $0x1,%ecx
400009f3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
400009f7:	83 c2 01             	add    $0x1,%edx
400009fa:	84 db                	test   %bl,%bl
400009fc:	88 5a ff             	mov    %bl,-0x1(%edx)
400009ff:	75 ef                	jne    400009f0 <strcpy+0x10>
		/* do nothing */;
	return ret;
}
40000a01:	5b                   	pop    %ebx
40000a02:	c3                   	ret    
40000a03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000a10 <strncpy>:

char *
strncpy(char *dst, const char *src, size_t size)
{
40000a10:	57                   	push   %edi
40000a11:	56                   	push   %esi
40000a12:	53                   	push   %ebx
40000a13:	8b 74 24 18          	mov    0x18(%esp),%esi
40000a17:	8b 7c 24 10          	mov    0x10(%esp),%edi
40000a1b:	8b 4c 24 14          	mov    0x14(%esp),%ecx
	size_t i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
40000a1f:	85 f6                	test   %esi,%esi
40000a21:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
40000a24:	89 fa                	mov    %edi,%edx
40000a26:	74 13                	je     40000a3b <strncpy+0x2b>
		*dst++ = *src;
40000a28:	0f b6 01             	movzbl (%ecx),%eax
40000a2b:	83 c2 01             	add    $0x1,%edx
40000a2e:	88 42 ff             	mov    %al,-0x1(%edx)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
40000a31:	80 39 01             	cmpb   $0x1,(%ecx)
40000a34:	83 d9 ff             	sbb    $0xffffffff,%ecx
{
	size_t i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
40000a37:	39 da                	cmp    %ebx,%edx
40000a39:	75 ed                	jne    40000a28 <strncpy+0x18>
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
}
40000a3b:	89 f8                	mov    %edi,%eax
40000a3d:	5b                   	pop    %ebx
40000a3e:	5e                   	pop    %esi
40000a3f:	5f                   	pop    %edi
40000a40:	c3                   	ret    
40000a41:	eb 0d                	jmp    40000a50 <strlcpy>
40000a43:	90                   	nop
40000a44:	90                   	nop
40000a45:	90                   	nop
40000a46:	90                   	nop
40000a47:	90                   	nop
40000a48:	90                   	nop
40000a49:	90                   	nop
40000a4a:	90                   	nop
40000a4b:	90                   	nop
40000a4c:	90                   	nop
40000a4d:	90                   	nop
40000a4e:	90                   	nop
40000a4f:	90                   	nop

40000a50 <strlcpy>:

size_t
strlcpy(char *dst, const char *src, size_t size)
{
40000a50:	56                   	push   %esi
40000a51:	31 c0                	xor    %eax,%eax
40000a53:	53                   	push   %ebx
40000a54:	8b 74 24 14          	mov    0x14(%esp),%esi
40000a58:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
40000a5c:	85 f6                	test   %esi,%esi
40000a5e:	74 36                	je     40000a96 <strlcpy+0x46>
		while (--size > 0 && *src != '\0')
40000a60:	83 fe 01             	cmp    $0x1,%esi
40000a63:	74 34                	je     40000a99 <strlcpy+0x49>
40000a65:	0f b6 0b             	movzbl (%ebx),%ecx
40000a68:	84 c9                	test   %cl,%cl
40000a6a:	74 2d                	je     40000a99 <strlcpy+0x49>
40000a6c:	83 ee 02             	sub    $0x2,%esi
40000a6f:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000a73:	eb 0e                	jmp    40000a83 <strlcpy+0x33>
40000a75:	8d 76 00             	lea    0x0(%esi),%esi
40000a78:	83 c0 01             	add    $0x1,%eax
40000a7b:	0f b6 0c 03          	movzbl (%ebx,%eax,1),%ecx
40000a7f:	84 c9                	test   %cl,%cl
40000a81:	74 0a                	je     40000a8d <strlcpy+0x3d>
			*dst++ = *src++;
40000a83:	83 c2 01             	add    $0x1,%edx
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
40000a86:	39 f0                	cmp    %esi,%eax
			*dst++ = *src++;
40000a88:	88 4a ff             	mov    %cl,-0x1(%edx)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
40000a8b:	75 eb                	jne    40000a78 <strlcpy+0x28>
40000a8d:	89 d0                	mov    %edx,%eax
40000a8f:	2b 44 24 0c          	sub    0xc(%esp),%eax
			*dst++ = *src++;
		*dst = '\0';
40000a93:	c6 02 00             	movb   $0x0,(%edx)
	}
	return dst - dst_in;
}
40000a96:	5b                   	pop    %ebx
40000a97:	5e                   	pop    %esi
40000a98:	c3                   	ret    
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
40000a99:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000a9d:	eb f4                	jmp    40000a93 <strlcpy+0x43>
40000a9f:	90                   	nop

40000aa0 <strcmp>:
	return dst - dst_in;
}

int
strcmp(const char *p, const char *q)
{
40000aa0:	53                   	push   %ebx
40000aa1:	8b 54 24 08          	mov    0x8(%esp),%edx
40000aa5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
	while (*p && *p == *q)
40000aa9:	0f b6 02             	movzbl (%edx),%eax
40000aac:	84 c0                	test   %al,%al
40000aae:	74 2d                	je     40000add <strcmp+0x3d>
40000ab0:	0f b6 19             	movzbl (%ecx),%ebx
40000ab3:	38 d8                	cmp    %bl,%al
40000ab5:	74 0f                	je     40000ac6 <strcmp+0x26>
40000ab7:	eb 2b                	jmp    40000ae4 <strcmp+0x44>
40000ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000ac0:	38 c8                	cmp    %cl,%al
40000ac2:	75 15                	jne    40000ad9 <strcmp+0x39>
		p++, q++;
40000ac4:	89 d9                	mov    %ebx,%ecx
40000ac6:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
40000ac9:	0f b6 02             	movzbl (%edx),%eax
		p++, q++;
40000acc:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
40000acf:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
40000ad3:	84 c0                	test   %al,%al
40000ad5:	75 e9                	jne    40000ac0 <strcmp+0x20>
40000ad7:	31 c0                	xor    %eax,%eax
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
40000ad9:	29 c8                	sub    %ecx,%eax
}
40000adb:	5b                   	pop    %ebx
40000adc:	c3                   	ret    
40000add:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
40000ae0:	31 c0                	xor    %eax,%eax
40000ae2:	eb f5                	jmp    40000ad9 <strcmp+0x39>
40000ae4:	0f b6 cb             	movzbl %bl,%ecx
40000ae7:	eb f0                	jmp    40000ad9 <strcmp+0x39>
40000ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000af0 <strncmp>:
	return (int) ((unsigned char) *p - (unsigned char) *q);
}

int
strncmp(const char *p, const char *q, size_t n)
{
40000af0:	56                   	push   %esi
40000af1:	53                   	push   %ebx
40000af2:	8b 74 24 14          	mov    0x14(%esp),%esi
40000af6:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000afa:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	while (n > 0 && *p && *p == *q)
40000afe:	85 f6                	test   %esi,%esi
40000b00:	74 30                	je     40000b32 <strncmp+0x42>
40000b02:	0f b6 01             	movzbl (%ecx),%eax
40000b05:	84 c0                	test   %al,%al
40000b07:	74 2e                	je     40000b37 <strncmp+0x47>
40000b09:	0f b6 13             	movzbl (%ebx),%edx
40000b0c:	38 d0                	cmp    %dl,%al
40000b0e:	75 3e                	jne    40000b4e <strncmp+0x5e>
40000b10:	8d 51 01             	lea    0x1(%ecx),%edx
40000b13:	01 ce                	add    %ecx,%esi
40000b15:	eb 14                	jmp    40000b2b <strncmp+0x3b>
40000b17:	90                   	nop
40000b18:	0f b6 02             	movzbl (%edx),%eax
40000b1b:	84 c0                	test   %al,%al
40000b1d:	74 29                	je     40000b48 <strncmp+0x58>
40000b1f:	0f b6 19             	movzbl (%ecx),%ebx
40000b22:	83 c2 01             	add    $0x1,%edx
40000b25:	38 d8                	cmp    %bl,%al
40000b27:	75 17                	jne    40000b40 <strncmp+0x50>
		n--, p++, q++;
40000b29:	89 cb                	mov    %ecx,%ebx
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
40000b2b:	39 f2                	cmp    %esi,%edx
		n--, p++, q++;
40000b2d:	8d 4b 01             	lea    0x1(%ebx),%ecx
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
40000b30:	75 e6                	jne    40000b18 <strncmp+0x28>
		n--, p++, q++;
	if (n == 0)
		return 0;
40000b32:	31 c0                	xor    %eax,%eax
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
}
40000b34:	5b                   	pop    %ebx
40000b35:	5e                   	pop    %esi
40000b36:	c3                   	ret    
40000b37:	0f b6 1b             	movzbl (%ebx),%ebx
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
40000b3a:	31 c0                	xor    %eax,%eax
40000b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		n--, p++, q++;
	if (n == 0)
		return 0;
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
40000b40:	0f b6 d3             	movzbl %bl,%edx
40000b43:	29 d0                	sub    %edx,%eax
}
40000b45:	5b                   	pop    %ebx
40000b46:	5e                   	pop    %esi
40000b47:	c3                   	ret    
40000b48:	0f b6 5b 01          	movzbl 0x1(%ebx),%ebx
40000b4c:	eb f2                	jmp    40000b40 <strncmp+0x50>
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
40000b4e:	89 d3                	mov    %edx,%ebx
40000b50:	eb ee                	jmp    40000b40 <strncmp+0x50>
40000b52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000b60 <strchr>:
		return (int) ((unsigned char) *p - (unsigned char) *q);
}

char *
strchr(const char *s, char c)
{
40000b60:	53                   	push   %ebx
40000b61:	8b 44 24 08          	mov    0x8(%esp),%eax
40000b65:	8b 54 24 0c          	mov    0xc(%esp),%edx
	for (; *s; s++)
40000b69:	0f b6 18             	movzbl (%eax),%ebx
40000b6c:	84 db                	test   %bl,%bl
40000b6e:	74 16                	je     40000b86 <strchr+0x26>
		if (*s == c)
40000b70:	38 d3                	cmp    %dl,%bl
40000b72:	89 d1                	mov    %edx,%ecx
40000b74:	75 06                	jne    40000b7c <strchr+0x1c>
40000b76:	eb 10                	jmp    40000b88 <strchr+0x28>
40000b78:	38 ca                	cmp    %cl,%dl
40000b7a:	74 0c                	je     40000b88 <strchr+0x28>
}

char *
strchr(const char *s, char c)
{
	for (; *s; s++)
40000b7c:	83 c0 01             	add    $0x1,%eax
40000b7f:	0f b6 10             	movzbl (%eax),%edx
40000b82:	84 d2                	test   %dl,%dl
40000b84:	75 f2                	jne    40000b78 <strchr+0x18>
		if (*s == c)
			return (char *) s;
	return 0;
40000b86:	31 c0                	xor    %eax,%eax
}
40000b88:	5b                   	pop    %ebx
40000b89:	c3                   	ret    
40000b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000b90 <strfind>:

char *
strfind(const char *s, char c)
{
40000b90:	53                   	push   %ebx
40000b91:	8b 44 24 08          	mov    0x8(%esp),%eax
40000b95:	8b 54 24 0c          	mov    0xc(%esp),%edx
	for (; *s; s++)
40000b99:	0f b6 18             	movzbl (%eax),%ebx
40000b9c:	84 db                	test   %bl,%bl
40000b9e:	74 16                	je     40000bb6 <strfind+0x26>
		if (*s == c)
40000ba0:	38 d3                	cmp    %dl,%bl
40000ba2:	89 d1                	mov    %edx,%ecx
40000ba4:	75 06                	jne    40000bac <strfind+0x1c>
40000ba6:	eb 0e                	jmp    40000bb6 <strfind+0x26>
40000ba8:	38 ca                	cmp    %cl,%dl
40000baa:	74 0a                	je     40000bb6 <strfind+0x26>
}

char *
strfind(const char *s, char c)
{
	for (; *s; s++)
40000bac:	83 c0 01             	add    $0x1,%eax
40000baf:	0f b6 10             	movzbl (%eax),%edx
40000bb2:	84 d2                	test   %dl,%dl
40000bb4:	75 f2                	jne    40000ba8 <strfind+0x18>
		if (*s == c)
			break;
	return (char *) s;
}
40000bb6:	5b                   	pop    %ebx
40000bb7:	c3                   	ret    
40000bb8:	90                   	nop
40000bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000bc0 <strtol>:


long
strtol(const char *s, char **endptr, int base)
{
40000bc0:	55                   	push   %ebp
40000bc1:	57                   	push   %edi
40000bc2:	56                   	push   %esi
40000bc3:	53                   	push   %ebx
40000bc4:	8b 54 24 14          	mov    0x14(%esp),%edx
40000bc8:	8b 74 24 18          	mov    0x18(%esp),%esi
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
40000bcc:	0f b6 0a             	movzbl (%edx),%ecx
40000bcf:	80 f9 20             	cmp    $0x20,%cl
40000bd2:	0f 85 e6 00 00 00    	jne    40000cbe <strtol+0xfe>
		s++;
40000bd8:	83 c2 01             	add    $0x1,%edx
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
40000bdb:	0f b6 0a             	movzbl (%edx),%ecx
40000bde:	80 f9 09             	cmp    $0x9,%cl
40000be1:	74 f5                	je     40000bd8 <strtol+0x18>
40000be3:	80 f9 20             	cmp    $0x20,%cl
40000be6:	74 f0                	je     40000bd8 <strtol+0x18>
		s++;

	// plus/minus sign
	if (*s == '+')
40000be8:	80 f9 2b             	cmp    $0x2b,%cl
40000beb:	0f 84 8f 00 00 00    	je     40000c80 <strtol+0xc0>


long
strtol(const char *s, char **endptr, int base)
{
	int neg = 0;
40000bf1:	31 ff                	xor    %edi,%edi
		s++;

	// plus/minus sign
	if (*s == '+')
		s++;
	else if (*s == '-')
40000bf3:	80 f9 2d             	cmp    $0x2d,%cl
40000bf6:	0f 84 94 00 00 00    	je     40000c90 <strtol+0xd0>
		s++, neg = 1;

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000bfc:	f7 44 24 1c ef ff ff 	testl  $0xffffffef,0x1c(%esp)
40000c03:	ff 
40000c04:	0f be 0a             	movsbl (%edx),%ecx
40000c07:	75 19                	jne    40000c22 <strtol+0x62>
40000c09:	80 f9 30             	cmp    $0x30,%cl
40000c0c:	0f 84 8a 00 00 00    	je     40000c9c <strtol+0xdc>
		s += 2, base = 16;
	else if (base == 0 && s[0] == '0')
40000c12:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
40000c16:	85 db                	test   %ebx,%ebx
40000c18:	75 08                	jne    40000c22 <strtol+0x62>
		s++, base = 8;
	else if (base == 0)
		base = 10;
40000c1a:	c7 44 24 1c 0a 00 00 	movl   $0xa,0x1c(%esp)
40000c21:	00 
		s++;
	else if (*s == '-')
		s++, neg = 1;

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000c22:	31 db                	xor    %ebx,%ebx
40000c24:	eb 18                	jmp    40000c3e <strtol+0x7e>
40000c26:	66 90                	xchg   %ax,%ax
	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
			dig = *s - '0';
40000c28:	83 e9 30             	sub    $0x30,%ecx
			dig = *s - 'a' + 10;
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
40000c2b:	3b 4c 24 1c          	cmp    0x1c(%esp),%ecx
40000c2f:	7d 28                	jge    40000c59 <strtol+0x99>
			break;
		s++, val = (val * base) + dig;
40000c31:	0f af 5c 24 1c       	imul   0x1c(%esp),%ebx
40000c36:	83 c2 01             	add    $0x1,%edx
40000c39:	01 cb                	add    %ecx,%ebx
40000c3b:	0f be 0a             	movsbl (%edx),%ecx

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
40000c3e:	8d 69 d0             	lea    -0x30(%ecx),%ebp
40000c41:	89 e8                	mov    %ebp,%eax
40000c43:	3c 09                	cmp    $0x9,%al
40000c45:	76 e1                	jbe    40000c28 <strtol+0x68>
			dig = *s - '0';
		else if (*s >= 'a' && *s <= 'z')
40000c47:	8d 69 9f             	lea    -0x61(%ecx),%ebp
40000c4a:	89 e8                	mov    %ebp,%eax
40000c4c:	3c 19                	cmp    $0x19,%al
40000c4e:	77 20                	ja     40000c70 <strtol+0xb0>
			dig = *s - 'a' + 10;
40000c50:	83 e9 57             	sub    $0x57,%ecx
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
40000c53:	3b 4c 24 1c          	cmp    0x1c(%esp),%ecx
40000c57:	7c d8                	jl     40000c31 <strtol+0x71>
			break;
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
40000c59:	85 f6                	test   %esi,%esi
40000c5b:	74 02                	je     40000c5f <strtol+0x9f>
		*endptr = (char *) s;
40000c5d:	89 16                	mov    %edx,(%esi)
	return (neg ? -val : val);
40000c5f:	89 d8                	mov    %ebx,%eax
40000c61:	f7 d8                	neg    %eax
40000c63:	85 ff                	test   %edi,%edi
40000c65:	0f 44 c3             	cmove  %ebx,%eax
}
40000c68:	5b                   	pop    %ebx
40000c69:	5e                   	pop    %esi
40000c6a:	5f                   	pop    %edi
40000c6b:	5d                   	pop    %ebp
40000c6c:	c3                   	ret    
40000c6d:	8d 76 00             	lea    0x0(%esi),%esi

		if (*s >= '0' && *s <= '9')
			dig = *s - '0';
		else if (*s >= 'a' && *s <= 'z')
			dig = *s - 'a' + 10;
		else if (*s >= 'A' && *s <= 'Z')
40000c70:	8d 69 bf             	lea    -0x41(%ecx),%ebp
40000c73:	89 e8                	mov    %ebp,%eax
40000c75:	3c 19                	cmp    $0x19,%al
40000c77:	77 e0                	ja     40000c59 <strtol+0x99>
			dig = *s - 'A' + 10;
40000c79:	83 e9 37             	sub    $0x37,%ecx
40000c7c:	eb ad                	jmp    40000c2b <strtol+0x6b>
40000c7e:	66 90                	xchg   %ax,%ax
	while (*s == ' ' || *s == '\t')
		s++;

	// plus/minus sign
	if (*s == '+')
		s++;
40000c80:	83 c2 01             	add    $0x1,%edx


long
strtol(const char *s, char **endptr, int base)
{
	int neg = 0;
40000c83:	31 ff                	xor    %edi,%edi
40000c85:	e9 72 ff ff ff       	jmp    40000bfc <strtol+0x3c>
40000c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

	// plus/minus sign
	if (*s == '+')
		s++;
	else if (*s == '-')
		s++, neg = 1;
40000c90:	83 c2 01             	add    $0x1,%edx
40000c93:	66 bf 01 00          	mov    $0x1,%di
40000c97:	e9 60 ff ff ff       	jmp    40000bfc <strtol+0x3c>

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000c9c:	80 7a 01 78          	cmpb   $0x78,0x1(%edx)
40000ca0:	74 2a                	je     40000ccc <strtol+0x10c>
		s += 2, base = 16;
	else if (base == 0 && s[0] == '0')
40000ca2:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000ca6:	85 c0                	test   %eax,%eax
40000ca8:	75 36                	jne    40000ce0 <strtol+0x120>
40000caa:	0f be 4a 01          	movsbl 0x1(%edx),%ecx
		s++, base = 8;
40000cae:	83 c2 01             	add    $0x1,%edx
40000cb1:	c7 44 24 1c 08 00 00 	movl   $0x8,0x1c(%esp)
40000cb8:	00 
40000cb9:	e9 64 ff ff ff       	jmp    40000c22 <strtol+0x62>
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
40000cbe:	80 f9 09             	cmp    $0x9,%cl
40000cc1:	0f 84 11 ff ff ff    	je     40000bd8 <strtol+0x18>
40000cc7:	e9 1c ff ff ff       	jmp    40000be8 <strtol+0x28>
40000ccc:	0f be 4a 02          	movsbl 0x2(%edx),%ecx
	else if (*s == '-')
		s++, neg = 1;

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
		s += 2, base = 16;
40000cd0:	83 c2 02             	add    $0x2,%edx
40000cd3:	c7 44 24 1c 10 00 00 	movl   $0x10,0x1c(%esp)
40000cda:	00 
40000cdb:	e9 42 ff ff ff       	jmp    40000c22 <strtol+0x62>
		s++;
	else if (*s == '-')
		s++, neg = 1;

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000ce0:	b9 30 00 00 00       	mov    $0x30,%ecx
40000ce5:	e9 38 ff ff ff       	jmp    40000c22 <strtol+0x62>
40000cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000cf0 <memset>:
	return (neg ? -val : val);
}

void *
memset(void *v, int c, size_t n)
{
40000cf0:	57                   	push   %edi
40000cf1:	56                   	push   %esi
40000cf2:	53                   	push   %ebx
40000cf3:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000cf7:	8b 7c 24 10          	mov    0x10(%esp),%edi
	if (n == 0)
40000cfb:	85 c9                	test   %ecx,%ecx
40000cfd:	74 14                	je     40000d13 <memset+0x23>
		return v;
	if ((int)v%4 == 0 && n%4 == 0) {
40000cff:	f7 c7 03 00 00 00    	test   $0x3,%edi
40000d05:	75 05                	jne    40000d0c <memset+0x1c>
40000d07:	f6 c1 03             	test   $0x3,%cl
40000d0a:	74 14                	je     40000d20 <memset+0x30>
		c = (c<<24)|(c<<16)|(c<<8)|c;
		asm volatile("cld; rep stosl\n"
			     :: "D" (v), "a" (c), "c" (n/4)
			     : "cc", "memory");
	} else
		asm volatile("cld; rep stosb\n"
40000d0c:	8b 44 24 14          	mov    0x14(%esp),%eax
40000d10:	fc                   	cld    
40000d11:	f3 aa                	rep stos %al,%es:(%edi)
			     :: "D" (v), "a" (c), "c" (n)
			     : "cc", "memory");
	return v;
}
40000d13:	89 f8                	mov    %edi,%eax
40000d15:	5b                   	pop    %ebx
40000d16:	5e                   	pop    %esi
40000d17:	5f                   	pop    %edi
40000d18:	c3                   	ret    
40000d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
memset(void *v, int c, size_t n)
{
	if (n == 0)
		return v;
	if ((int)v%4 == 0 && n%4 == 0) {
		c &= 0xFF;
40000d20:	0f b6 54 24 14       	movzbl 0x14(%esp),%edx
		c = (c<<24)|(c<<16)|(c<<8)|c;
		asm volatile("cld; rep stosl\n"
			     :: "D" (v), "a" (c), "c" (n/4)
40000d25:	c1 e9 02             	shr    $0x2,%ecx
{
	if (n == 0)
		return v;
	if ((int)v%4 == 0 && n%4 == 0) {
		c &= 0xFF;
		c = (c<<24)|(c<<16)|(c<<8)|c;
40000d28:	89 d0                	mov    %edx,%eax
40000d2a:	89 d6                	mov    %edx,%esi
40000d2c:	c1 e0 18             	shl    $0x18,%eax
40000d2f:	89 d3                	mov    %edx,%ebx
40000d31:	c1 e6 10             	shl    $0x10,%esi
40000d34:	09 f0                	or     %esi,%eax
40000d36:	c1 e3 08             	shl    $0x8,%ebx
40000d39:	09 d0                	or     %edx,%eax
40000d3b:	09 d8                	or     %ebx,%eax
		asm volatile("cld; rep stosl\n"
40000d3d:	fc                   	cld    
40000d3e:	f3 ab                	rep stos %eax,%es:(%edi)
	} else
		asm volatile("cld; rep stosb\n"
			     :: "D" (v), "a" (c), "c" (n)
			     : "cc", "memory");
	return v;
}
40000d40:	89 f8                	mov    %edi,%eax
40000d42:	5b                   	pop    %ebx
40000d43:	5e                   	pop    %esi
40000d44:	5f                   	pop    %edi
40000d45:	c3                   	ret    
40000d46:	8d 76 00             	lea    0x0(%esi),%esi
40000d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000d50 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
40000d50:	57                   	push   %edi
40000d51:	56                   	push   %esi
40000d52:	8b 44 24 0c          	mov    0xc(%esp),%eax
40000d56:	8b 74 24 10          	mov    0x10(%esp),%esi
40000d5a:	8b 4c 24 14          	mov    0x14(%esp),%ecx
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
40000d5e:	39 c6                	cmp    %eax,%esi
40000d60:	73 26                	jae    40000d88 <memmove+0x38>
40000d62:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
40000d65:	39 d0                	cmp    %edx,%eax
40000d67:	73 1f                	jae    40000d88 <memmove+0x38>
		s += n;
		d += n;
40000d69:	8d 3c 08             	lea    (%eax,%ecx,1),%edi
40000d6c:	89 d6                	mov    %edx,%esi
40000d6e:	09 fe                	or     %edi,%esi
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
40000d70:	83 e6 03             	and    $0x3,%esi
40000d73:	74 33                	je     40000da8 <memmove+0x58>
			asm volatile("std; rep movsl\n"
				     :: "D" (d-4), "S" (s-4), "c" (n/4)
				     : "cc", "memory");
		else
			asm volatile("std; rep movsb\n"
				     :: "D" (d-1), "S" (s-1), "c" (n)
40000d75:	83 ef 01             	sub    $0x1,%edi
40000d78:	8d 72 ff             	lea    -0x1(%edx),%esi
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
			asm volatile("std; rep movsl\n"
				     :: "D" (d-4), "S" (s-4), "c" (n/4)
				     : "cc", "memory");
		else
			asm volatile("std; rep movsb\n"
40000d7b:	fd                   	std    
40000d7c:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
				     :: "D" (d-1), "S" (s-1), "c" (n)
				     : "cc", "memory");
		// Some versions of GCC rely on DF being clear
		asm volatile("cld" ::: "cc");
40000d7e:	fc                   	cld    
			asm volatile("cld; rep movsb\n"
				     :: "D" (d), "S" (s), "c" (n)
				     : "cc", "memory");
	}
	return dst;
}
40000d7f:	5e                   	pop    %esi
40000d80:	5f                   	pop    %edi
40000d81:	c3                   	ret    
40000d82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000d88:	89 f2                	mov    %esi,%edx
40000d8a:	09 c2                	or     %eax,%edx
				     :: "D" (d-1), "S" (s-1), "c" (n)
				     : "cc", "memory");
		// Some versions of GCC rely on DF being clear
		asm volatile("cld" ::: "cc");
	} else {
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
40000d8c:	83 e2 03             	and    $0x3,%edx
40000d8f:	75 0f                	jne    40000da0 <memmove+0x50>
40000d91:	f6 c1 03             	test   $0x3,%cl
40000d94:	75 0a                	jne    40000da0 <memmove+0x50>
			asm volatile("cld; rep movsl\n"
				     :: "D" (d), "S" (s), "c" (n/4)
40000d96:	c1 e9 02             	shr    $0x2,%ecx
				     : "cc", "memory");
		// Some versions of GCC rely on DF being clear
		asm volatile("cld" ::: "cc");
	} else {
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
			asm volatile("cld; rep movsl\n"
40000d99:	89 c7                	mov    %eax,%edi
40000d9b:	fc                   	cld    
40000d9c:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000d9e:	eb 05                	jmp    40000da5 <memmove+0x55>
				     :: "D" (d), "S" (s), "c" (n/4)
				     : "cc", "memory");
		else
			asm volatile("cld; rep movsb\n"
40000da0:	89 c7                	mov    %eax,%edi
40000da2:	fc                   	cld    
40000da3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
				     :: "D" (d), "S" (s), "c" (n)
				     : "cc", "memory");
	}
	return dst;
}
40000da5:	5e                   	pop    %esi
40000da6:	5f                   	pop    %edi
40000da7:	c3                   	ret    
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
40000da8:	f6 c1 03             	test   $0x3,%cl
40000dab:	75 c8                	jne    40000d75 <memmove+0x25>
			asm volatile("std; rep movsl\n"
				     :: "D" (d-4), "S" (s-4), "c" (n/4)
40000dad:	83 ef 04             	sub    $0x4,%edi
40000db0:	8d 72 fc             	lea    -0x4(%edx),%esi
40000db3:	c1 e9 02             	shr    $0x2,%ecx
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
			asm volatile("std; rep movsl\n"
40000db6:	fd                   	std    
40000db7:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000db9:	eb c3                	jmp    40000d7e <memmove+0x2e>
40000dbb:	90                   	nop
40000dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000dc0 <memcpy>:
}

void *
memcpy(void *dst, const void *src, size_t n)
{
	return memmove(dst, src, n);
40000dc0:	eb 8e                	jmp    40000d50 <memmove>
40000dc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000dd0 <memcmp>:
}

int
memcmp(const void *v1, const void *v2, size_t n)
{
40000dd0:	57                   	push   %edi
40000dd1:	56                   	push   %esi
40000dd2:	53                   	push   %ebx
40000dd3:	8b 44 24 18          	mov    0x18(%esp),%eax
40000dd7:	8b 5c 24 10          	mov    0x10(%esp),%ebx
40000ddb:	8b 74 24 14          	mov    0x14(%esp),%esi
	const uint8_t *s1 = (const uint8_t *) v1;
	const uint8_t *s2 = (const uint8_t *) v2;

	while (n-- > 0) {
40000ddf:	85 c0                	test   %eax,%eax
40000de1:	8d 78 ff             	lea    -0x1(%eax),%edi
40000de4:	74 26                	je     40000e0c <memcmp+0x3c>
		if (*s1 != *s2)
40000de6:	0f b6 03             	movzbl (%ebx),%eax
40000de9:	31 d2                	xor    %edx,%edx
40000deb:	0f b6 0e             	movzbl (%esi),%ecx
40000dee:	38 c8                	cmp    %cl,%al
40000df0:	74 16                	je     40000e08 <memcmp+0x38>
40000df2:	eb 24                	jmp    40000e18 <memcmp+0x48>
40000df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000df8:	0f b6 44 13 01       	movzbl 0x1(%ebx,%edx,1),%eax
40000dfd:	83 c2 01             	add    $0x1,%edx
40000e00:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
40000e04:	38 c8                	cmp    %cl,%al
40000e06:	75 10                	jne    40000e18 <memcmp+0x48>
memcmp(const void *v1, const void *v2, size_t n)
{
	const uint8_t *s1 = (const uint8_t *) v1;
	const uint8_t *s2 = (const uint8_t *) v2;

	while (n-- > 0) {
40000e08:	39 fa                	cmp    %edi,%edx
40000e0a:	75 ec                	jne    40000df8 <memcmp+0x28>
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
}
40000e0c:	5b                   	pop    %ebx
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
40000e0d:	31 c0                	xor    %eax,%eax
}
40000e0f:	5e                   	pop    %esi
40000e10:	5f                   	pop    %edi
40000e11:	c3                   	ret    
40000e12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000e18:	5b                   	pop    %ebx
	const uint8_t *s1 = (const uint8_t *) v1;
	const uint8_t *s2 = (const uint8_t *) v2;

	while (n-- > 0) {
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
40000e19:	29 c8                	sub    %ecx,%eax
		s1++, s2++;
	}

	return 0;
}
40000e1b:	5e                   	pop    %esi
40000e1c:	5f                   	pop    %edi
40000e1d:	c3                   	ret    
40000e1e:	66 90                	xchg   %ax,%ax

40000e20 <memchr>:

void *
memchr(const void *s, int c, size_t n)
{
40000e20:	53                   	push   %ebx
40000e21:	8b 44 24 08          	mov    0x8(%esp),%eax
	const void *ends = (const char *) s + n;
40000e25:	8b 54 24 10          	mov    0x10(%esp),%edx
	return 0;
}

void *
memchr(const void *s, int c, size_t n)
{
40000e29:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
	const void *ends = (const char *) s + n;
40000e2d:	01 c2                	add    %eax,%edx
	for (; s < ends; s++)
40000e2f:	39 d0                	cmp    %edx,%eax
40000e31:	73 18                	jae    40000e4b <memchr+0x2b>
		if (*(const unsigned char *) s == (unsigned char) c)
40000e33:	38 18                	cmp    %bl,(%eax)
40000e35:	89 d9                	mov    %ebx,%ecx
40000e37:	75 0b                	jne    40000e44 <memchr+0x24>
40000e39:	eb 12                	jmp    40000e4d <memchr+0x2d>
40000e3b:	90                   	nop
40000e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000e40:	38 08                	cmp    %cl,(%eax)
40000e42:	74 09                	je     40000e4d <memchr+0x2d>

void *
memchr(const void *s, int c, size_t n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
40000e44:	83 c0 01             	add    $0x1,%eax
40000e47:	39 d0                	cmp    %edx,%eax
40000e49:	75 f5                	jne    40000e40 <memchr+0x20>
		if (*(const unsigned char *) s == (unsigned char) c)
			return (void *) s;
	return NULL;
40000e4b:	31 c0                	xor    %eax,%eax
}
40000e4d:	5b                   	pop    %ebx
40000e4e:	c3                   	ret    
40000e4f:	90                   	nop

40000e50 <memzero>:

void *
memzero(void *v, size_t n)
{
40000e50:	83 ec 0c             	sub    $0xc,%esp
	return memset(v, 0, n);
40000e53:	8b 44 24 14          	mov    0x14(%esp),%eax
40000e57:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
40000e5e:	00 
40000e5f:	89 44 24 08          	mov    %eax,0x8(%esp)
40000e63:	8b 44 24 10          	mov    0x10(%esp),%eax
40000e67:	89 04 24             	mov    %eax,(%esp)
40000e6a:	e8 81 fe ff ff       	call   40000cf0 <memset>
}
40000e6f:	83 c4 0c             	add    $0xc,%esp
40000e72:	c3                   	ret    
40000e73:	66 90                	xchg   %ax,%ax
40000e75:	66 90                	xchg   %ax,%ax
40000e77:	66 90                	xchg   %ax,%ax
40000e79:	66 90                	xchg   %ax,%ax
40000e7b:	66 90                	xchg   %ax,%ax
40000e7d:	66 90                	xchg   %ax,%ax
40000e7f:	90                   	nop

40000e80 <__udivdi3>:
40000e80:	55                   	push   %ebp
40000e81:	57                   	push   %edi
40000e82:	56                   	push   %esi
40000e83:	83 ec 0c             	sub    $0xc,%esp
40000e86:	8b 44 24 28          	mov    0x28(%esp),%eax
40000e8a:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
40000e8e:	8b 6c 24 20          	mov    0x20(%esp),%ebp
40000e92:	8b 4c 24 24          	mov    0x24(%esp),%ecx
40000e96:	85 c0                	test   %eax,%eax
40000e98:	89 7c 24 04          	mov    %edi,0x4(%esp)
40000e9c:	89 ea                	mov    %ebp,%edx
40000e9e:	89 0c 24             	mov    %ecx,(%esp)
40000ea1:	75 2d                	jne    40000ed0 <__udivdi3+0x50>
40000ea3:	39 e9                	cmp    %ebp,%ecx
40000ea5:	77 61                	ja     40000f08 <__udivdi3+0x88>
40000ea7:	85 c9                	test   %ecx,%ecx
40000ea9:	89 ce                	mov    %ecx,%esi
40000eab:	75 0b                	jne    40000eb8 <__udivdi3+0x38>
40000ead:	b8 01 00 00 00       	mov    $0x1,%eax
40000eb2:	31 d2                	xor    %edx,%edx
40000eb4:	f7 f1                	div    %ecx
40000eb6:	89 c6                	mov    %eax,%esi
40000eb8:	31 d2                	xor    %edx,%edx
40000eba:	89 e8                	mov    %ebp,%eax
40000ebc:	f7 f6                	div    %esi
40000ebe:	89 c5                	mov    %eax,%ebp
40000ec0:	89 f8                	mov    %edi,%eax
40000ec2:	f7 f6                	div    %esi
40000ec4:	89 ea                	mov    %ebp,%edx
40000ec6:	83 c4 0c             	add    $0xc,%esp
40000ec9:	5e                   	pop    %esi
40000eca:	5f                   	pop    %edi
40000ecb:	5d                   	pop    %ebp
40000ecc:	c3                   	ret    
40000ecd:	8d 76 00             	lea    0x0(%esi),%esi
40000ed0:	39 e8                	cmp    %ebp,%eax
40000ed2:	77 24                	ja     40000ef8 <__udivdi3+0x78>
40000ed4:	0f bd e8             	bsr    %eax,%ebp
40000ed7:	83 f5 1f             	xor    $0x1f,%ebp
40000eda:	75 3c                	jne    40000f18 <__udivdi3+0x98>
40000edc:	8b 74 24 04          	mov    0x4(%esp),%esi
40000ee0:	39 34 24             	cmp    %esi,(%esp)
40000ee3:	0f 86 9f 00 00 00    	jbe    40000f88 <__udivdi3+0x108>
40000ee9:	39 d0                	cmp    %edx,%eax
40000eeb:	0f 82 97 00 00 00    	jb     40000f88 <__udivdi3+0x108>
40000ef1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000ef8:	31 d2                	xor    %edx,%edx
40000efa:	31 c0                	xor    %eax,%eax
40000efc:	83 c4 0c             	add    $0xc,%esp
40000eff:	5e                   	pop    %esi
40000f00:	5f                   	pop    %edi
40000f01:	5d                   	pop    %ebp
40000f02:	c3                   	ret    
40000f03:	90                   	nop
40000f04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000f08:	89 f8                	mov    %edi,%eax
40000f0a:	f7 f1                	div    %ecx
40000f0c:	31 d2                	xor    %edx,%edx
40000f0e:	83 c4 0c             	add    $0xc,%esp
40000f11:	5e                   	pop    %esi
40000f12:	5f                   	pop    %edi
40000f13:	5d                   	pop    %ebp
40000f14:	c3                   	ret    
40000f15:	8d 76 00             	lea    0x0(%esi),%esi
40000f18:	89 e9                	mov    %ebp,%ecx
40000f1a:	8b 3c 24             	mov    (%esp),%edi
40000f1d:	d3 e0                	shl    %cl,%eax
40000f1f:	89 c6                	mov    %eax,%esi
40000f21:	b8 20 00 00 00       	mov    $0x20,%eax
40000f26:	29 e8                	sub    %ebp,%eax
40000f28:	89 c1                	mov    %eax,%ecx
40000f2a:	d3 ef                	shr    %cl,%edi
40000f2c:	89 e9                	mov    %ebp,%ecx
40000f2e:	89 7c 24 08          	mov    %edi,0x8(%esp)
40000f32:	8b 3c 24             	mov    (%esp),%edi
40000f35:	09 74 24 08          	or     %esi,0x8(%esp)
40000f39:	89 d6                	mov    %edx,%esi
40000f3b:	d3 e7                	shl    %cl,%edi
40000f3d:	89 c1                	mov    %eax,%ecx
40000f3f:	89 3c 24             	mov    %edi,(%esp)
40000f42:	8b 7c 24 04          	mov    0x4(%esp),%edi
40000f46:	d3 ee                	shr    %cl,%esi
40000f48:	89 e9                	mov    %ebp,%ecx
40000f4a:	d3 e2                	shl    %cl,%edx
40000f4c:	89 c1                	mov    %eax,%ecx
40000f4e:	d3 ef                	shr    %cl,%edi
40000f50:	09 d7                	or     %edx,%edi
40000f52:	89 f2                	mov    %esi,%edx
40000f54:	89 f8                	mov    %edi,%eax
40000f56:	f7 74 24 08          	divl   0x8(%esp)
40000f5a:	89 d6                	mov    %edx,%esi
40000f5c:	89 c7                	mov    %eax,%edi
40000f5e:	f7 24 24             	mull   (%esp)
40000f61:	39 d6                	cmp    %edx,%esi
40000f63:	89 14 24             	mov    %edx,(%esp)
40000f66:	72 30                	jb     40000f98 <__udivdi3+0x118>
40000f68:	8b 54 24 04          	mov    0x4(%esp),%edx
40000f6c:	89 e9                	mov    %ebp,%ecx
40000f6e:	d3 e2                	shl    %cl,%edx
40000f70:	39 c2                	cmp    %eax,%edx
40000f72:	73 05                	jae    40000f79 <__udivdi3+0xf9>
40000f74:	3b 34 24             	cmp    (%esp),%esi
40000f77:	74 1f                	je     40000f98 <__udivdi3+0x118>
40000f79:	89 f8                	mov    %edi,%eax
40000f7b:	31 d2                	xor    %edx,%edx
40000f7d:	e9 7a ff ff ff       	jmp    40000efc <__udivdi3+0x7c>
40000f82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000f88:	31 d2                	xor    %edx,%edx
40000f8a:	b8 01 00 00 00       	mov    $0x1,%eax
40000f8f:	e9 68 ff ff ff       	jmp    40000efc <__udivdi3+0x7c>
40000f94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000f98:	8d 47 ff             	lea    -0x1(%edi),%eax
40000f9b:	31 d2                	xor    %edx,%edx
40000f9d:	83 c4 0c             	add    $0xc,%esp
40000fa0:	5e                   	pop    %esi
40000fa1:	5f                   	pop    %edi
40000fa2:	5d                   	pop    %ebp
40000fa3:	c3                   	ret    
40000fa4:	66 90                	xchg   %ax,%ax
40000fa6:	66 90                	xchg   %ax,%ax
40000fa8:	66 90                	xchg   %ax,%ax
40000faa:	66 90                	xchg   %ax,%ax
40000fac:	66 90                	xchg   %ax,%ax
40000fae:	66 90                	xchg   %ax,%ax

40000fb0 <__umoddi3>:
40000fb0:	55                   	push   %ebp
40000fb1:	57                   	push   %edi
40000fb2:	56                   	push   %esi
40000fb3:	83 ec 14             	sub    $0x14,%esp
40000fb6:	8b 44 24 28          	mov    0x28(%esp),%eax
40000fba:	8b 4c 24 24          	mov    0x24(%esp),%ecx
40000fbe:	8b 74 24 2c          	mov    0x2c(%esp),%esi
40000fc2:	89 c7                	mov    %eax,%edi
40000fc4:	89 44 24 04          	mov    %eax,0x4(%esp)
40000fc8:	8b 44 24 30          	mov    0x30(%esp),%eax
40000fcc:	89 4c 24 10          	mov    %ecx,0x10(%esp)
40000fd0:	89 34 24             	mov    %esi,(%esp)
40000fd3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
40000fd7:	85 c0                	test   %eax,%eax
40000fd9:	89 c2                	mov    %eax,%edx
40000fdb:	89 7c 24 0c          	mov    %edi,0xc(%esp)
40000fdf:	75 17                	jne    40000ff8 <__umoddi3+0x48>
40000fe1:	39 fe                	cmp    %edi,%esi
40000fe3:	76 4b                	jbe    40001030 <__umoddi3+0x80>
40000fe5:	89 c8                	mov    %ecx,%eax
40000fe7:	89 fa                	mov    %edi,%edx
40000fe9:	f7 f6                	div    %esi
40000feb:	89 d0                	mov    %edx,%eax
40000fed:	31 d2                	xor    %edx,%edx
40000fef:	83 c4 14             	add    $0x14,%esp
40000ff2:	5e                   	pop    %esi
40000ff3:	5f                   	pop    %edi
40000ff4:	5d                   	pop    %ebp
40000ff5:	c3                   	ret    
40000ff6:	66 90                	xchg   %ax,%ax
40000ff8:	39 f8                	cmp    %edi,%eax
40000ffa:	77 54                	ja     40001050 <__umoddi3+0xa0>
40000ffc:	0f bd e8             	bsr    %eax,%ebp
40000fff:	83 f5 1f             	xor    $0x1f,%ebp
40001002:	75 5c                	jne    40001060 <__umoddi3+0xb0>
40001004:	8b 7c 24 08          	mov    0x8(%esp),%edi
40001008:	39 3c 24             	cmp    %edi,(%esp)
4000100b:	0f 87 e7 00 00 00    	ja     400010f8 <__umoddi3+0x148>
40001011:	8b 7c 24 04          	mov    0x4(%esp),%edi
40001015:	29 f1                	sub    %esi,%ecx
40001017:	19 c7                	sbb    %eax,%edi
40001019:	89 4c 24 08          	mov    %ecx,0x8(%esp)
4000101d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
40001021:	8b 44 24 08          	mov    0x8(%esp),%eax
40001025:	8b 54 24 0c          	mov    0xc(%esp),%edx
40001029:	83 c4 14             	add    $0x14,%esp
4000102c:	5e                   	pop    %esi
4000102d:	5f                   	pop    %edi
4000102e:	5d                   	pop    %ebp
4000102f:	c3                   	ret    
40001030:	85 f6                	test   %esi,%esi
40001032:	89 f5                	mov    %esi,%ebp
40001034:	75 0b                	jne    40001041 <__umoddi3+0x91>
40001036:	b8 01 00 00 00       	mov    $0x1,%eax
4000103b:	31 d2                	xor    %edx,%edx
4000103d:	f7 f6                	div    %esi
4000103f:	89 c5                	mov    %eax,%ebp
40001041:	8b 44 24 04          	mov    0x4(%esp),%eax
40001045:	31 d2                	xor    %edx,%edx
40001047:	f7 f5                	div    %ebp
40001049:	89 c8                	mov    %ecx,%eax
4000104b:	f7 f5                	div    %ebp
4000104d:	eb 9c                	jmp    40000feb <__umoddi3+0x3b>
4000104f:	90                   	nop
40001050:	89 c8                	mov    %ecx,%eax
40001052:	89 fa                	mov    %edi,%edx
40001054:	83 c4 14             	add    $0x14,%esp
40001057:	5e                   	pop    %esi
40001058:	5f                   	pop    %edi
40001059:	5d                   	pop    %ebp
4000105a:	c3                   	ret    
4000105b:	90                   	nop
4000105c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40001060:	8b 04 24             	mov    (%esp),%eax
40001063:	be 20 00 00 00       	mov    $0x20,%esi
40001068:	89 e9                	mov    %ebp,%ecx
4000106a:	29 ee                	sub    %ebp,%esi
4000106c:	d3 e2                	shl    %cl,%edx
4000106e:	89 f1                	mov    %esi,%ecx
40001070:	d3 e8                	shr    %cl,%eax
40001072:	89 e9                	mov    %ebp,%ecx
40001074:	89 44 24 04          	mov    %eax,0x4(%esp)
40001078:	8b 04 24             	mov    (%esp),%eax
4000107b:	09 54 24 04          	or     %edx,0x4(%esp)
4000107f:	89 fa                	mov    %edi,%edx
40001081:	d3 e0                	shl    %cl,%eax
40001083:	89 f1                	mov    %esi,%ecx
40001085:	89 44 24 08          	mov    %eax,0x8(%esp)
40001089:	8b 44 24 10          	mov    0x10(%esp),%eax
4000108d:	d3 ea                	shr    %cl,%edx
4000108f:	89 e9                	mov    %ebp,%ecx
40001091:	d3 e7                	shl    %cl,%edi
40001093:	89 f1                	mov    %esi,%ecx
40001095:	d3 e8                	shr    %cl,%eax
40001097:	89 e9                	mov    %ebp,%ecx
40001099:	09 f8                	or     %edi,%eax
4000109b:	8b 7c 24 10          	mov    0x10(%esp),%edi
4000109f:	f7 74 24 04          	divl   0x4(%esp)
400010a3:	d3 e7                	shl    %cl,%edi
400010a5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
400010a9:	89 d7                	mov    %edx,%edi
400010ab:	f7 64 24 08          	mull   0x8(%esp)
400010af:	39 d7                	cmp    %edx,%edi
400010b1:	89 c1                	mov    %eax,%ecx
400010b3:	89 14 24             	mov    %edx,(%esp)
400010b6:	72 2c                	jb     400010e4 <__umoddi3+0x134>
400010b8:	39 44 24 0c          	cmp    %eax,0xc(%esp)
400010bc:	72 22                	jb     400010e0 <__umoddi3+0x130>
400010be:	8b 44 24 0c          	mov    0xc(%esp),%eax
400010c2:	29 c8                	sub    %ecx,%eax
400010c4:	19 d7                	sbb    %edx,%edi
400010c6:	89 e9                	mov    %ebp,%ecx
400010c8:	89 fa                	mov    %edi,%edx
400010ca:	d3 e8                	shr    %cl,%eax
400010cc:	89 f1                	mov    %esi,%ecx
400010ce:	d3 e2                	shl    %cl,%edx
400010d0:	89 e9                	mov    %ebp,%ecx
400010d2:	d3 ef                	shr    %cl,%edi
400010d4:	09 d0                	or     %edx,%eax
400010d6:	89 fa                	mov    %edi,%edx
400010d8:	83 c4 14             	add    $0x14,%esp
400010db:	5e                   	pop    %esi
400010dc:	5f                   	pop    %edi
400010dd:	5d                   	pop    %ebp
400010de:	c3                   	ret    
400010df:	90                   	nop
400010e0:	39 d7                	cmp    %edx,%edi
400010e2:	75 da                	jne    400010be <__umoddi3+0x10e>
400010e4:	8b 14 24             	mov    (%esp),%edx
400010e7:	89 c1                	mov    %eax,%ecx
400010e9:	2b 4c 24 08          	sub    0x8(%esp),%ecx
400010ed:	1b 54 24 04          	sbb    0x4(%esp),%edx
400010f1:	eb cb                	jmp    400010be <__umoddi3+0x10e>
400010f3:	90                   	nop
400010f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400010f8:	3b 44 24 0c          	cmp    0xc(%esp),%eax
400010fc:	0f 82 0f ff ff ff    	jb     40001011 <__umoddi3+0x61>
40001102:	e9 1a ff ff ff       	jmp    40001021 <__umoddi3+0x71>
