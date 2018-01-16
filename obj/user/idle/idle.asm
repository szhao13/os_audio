
obj/user/idle/idle:     file format elf32-i386


Disassembly of section .text:

40000000 <main>:
#include <stdio.h>
#include <syscall.h>
#include <x86.h>

int main (int argc, char **argv)
{
40000000:	55                   	push   %ebp
40000001:	89 e5                	mov    %esp,%ebp
40000003:	83 e4 f0             	and    $0xfffffff0,%esp
40000006:	83 ec 10             	sub    $0x10,%esp
    printf ("idle\n");
40000009:	c7 04 24 dc 12 00 40 	movl   $0x400012dc,(%esp)
40000010:	e8 3b 02 00 00       	call   40000250 <printf>

    pid_t fstest_pid;

    if ((fstest_pid = spawn (4, 1000)) != -1)
40000015:	c7 44 24 04 e8 03 00 	movl   $0x3e8,0x4(%esp)
4000001c:	00 
4000001d:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
40000024:	e8 d7 08 00 00       	call   40000900 <spawn>
40000029:	83 f8 ff             	cmp    $0xffffffff,%eax
4000002c:	74 14                	je     40000042 <main+0x42>
        printf ("fstest in process %d.\n", fstest_pid);
4000002e:	89 44 24 04          	mov    %eax,0x4(%esp)
40000032:	c7 04 24 e2 12 00 40 	movl   $0x400012e2,(%esp)
40000039:	e8 12 02 00 00       	call   40000250 <printf>
    else
        printf ("Failed to launch fstest.\n");

    return 0;
}
4000003e:	31 c0                	xor    %eax,%eax
40000040:	c9                   	leave  
40000041:	c3                   	ret    
    pid_t fstest_pid;

    if ((fstest_pid = spawn (4, 1000)) != -1)
        printf ("fstest in process %d.\n", fstest_pid);
    else
        printf ("Failed to launch fstest.\n");
40000042:	c7 04 24 f9 12 00 40 	movl   $0x400012f9,(%esp)
40000049:	e8 02 02 00 00       	call   40000250 <printf>
4000004e:	eb ee                	jmp    4000003e <main+0x3e>

40000050 <_start>:
_start:
	/*
	 * If there are arguments on the stack, then the current stack will not
	 * be aligned to a nice big power-of-two boundary/
	 */
	testl	$0x0fffffff, %esp
40000050:	f7 c4 ff ff ff 0f    	test   $0xfffffff,%esp
	jnz	args_exist
40000056:	75 04                	jne    4000005c <args_exist>

40000058 <noargs>:

noargs:
	/* If no arguments are on the stack, push two dummy zero. */
	pushl	$0
40000058:	6a 00                	push   $0x0
	pushl	$0
4000005a:	6a 00                	push   $0x0

4000005c <args_exist>:

args_exist:
	/* Jump to the C part. */
	call	main
4000005c:	e8 9f ff ff ff       	call   40000000 <main>

	/* When returning, push the return value on the stack. */
	pushl	%eax
40000061:	50                   	push   %eax

40000062 <spin>:
spin:
	//call	yield
	jmp	spin
40000062:	eb fe                	jmp    40000062 <spin>
40000064:	66 90                	xchg   %ax,%ax
40000066:	66 90                	xchg   %ax,%ax
40000068:	66 90                	xchg   %ax,%ax
4000006a:	66 90                	xchg   %ax,%ax
4000006c:	66 90                	xchg   %ax,%ax
4000006e:	66 90                	xchg   %ax,%ax

40000070 <debug>:
#include <stdarg.h>
#include <stdio.h>

void
debug(const char *file, int line, const char *fmt, ...)
{
40000070:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	va_start(ap, fmt);
	printf("[D] %s:%d: ", file, line);
40000073:	8b 44 24 24          	mov    0x24(%esp),%eax
40000077:	c7 04 24 48 11 00 40 	movl   $0x40001148,(%esp)
4000007e:	89 44 24 08          	mov    %eax,0x8(%esp)
40000082:	8b 44 24 20          	mov    0x20(%esp),%eax
40000086:	89 44 24 04          	mov    %eax,0x4(%esp)
4000008a:	e8 c1 01 00 00       	call   40000250 <printf>
	vcprintf(fmt, ap);
4000008f:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000093:	89 44 24 04          	mov    %eax,0x4(%esp)
40000097:	8b 44 24 28          	mov    0x28(%esp),%eax
4000009b:	89 04 24             	mov    %eax,(%esp)
4000009e:	e8 4d 01 00 00       	call   400001f0 <vcprintf>
	va_end(ap);
}
400000a3:	83 c4 1c             	add    $0x1c,%esp
400000a6:	c3                   	ret    
400000a7:	89 f6                	mov    %esi,%esi
400000a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

400000b0 <warn>:

void
warn(const char *file, int line, const char *fmt, ...)
{
400000b0:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	va_start(ap, fmt);
	printf("[W] %s:%d: ", file, line);
400000b3:	8b 44 24 24          	mov    0x24(%esp),%eax
400000b7:	c7 04 24 54 11 00 40 	movl   $0x40001154,(%esp)
400000be:	89 44 24 08          	mov    %eax,0x8(%esp)
400000c2:	8b 44 24 20          	mov    0x20(%esp),%eax
400000c6:	89 44 24 04          	mov    %eax,0x4(%esp)
400000ca:	e8 81 01 00 00       	call   40000250 <printf>
	vcprintf(fmt, ap);
400000cf:	8d 44 24 2c          	lea    0x2c(%esp),%eax
400000d3:	89 44 24 04          	mov    %eax,0x4(%esp)
400000d7:	8b 44 24 28          	mov    0x28(%esp),%eax
400000db:	89 04 24             	mov    %eax,(%esp)
400000de:	e8 0d 01 00 00       	call   400001f0 <vcprintf>
	va_end(ap);
}
400000e3:	83 c4 1c             	add    $0x1c,%esp
400000e6:	c3                   	ret    
400000e7:	89 f6                	mov    %esi,%esi
400000e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

400000f0 <panic>:

void
panic(const char *file, int line, const char *fmt, ...)
{
400000f0:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	va_start(ap, fmt);
	printf("[P] %s:%d: ", file, line);
400000f3:	8b 44 24 24          	mov    0x24(%esp),%eax
400000f7:	c7 04 24 60 11 00 40 	movl   $0x40001160,(%esp)
400000fe:	89 44 24 08          	mov    %eax,0x8(%esp)
40000102:	8b 44 24 20          	mov    0x20(%esp),%eax
40000106:	89 44 24 04          	mov    %eax,0x4(%esp)
4000010a:	e8 41 01 00 00       	call   40000250 <printf>
	vcprintf(fmt, ap);
4000010f:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000113:	89 44 24 04          	mov    %eax,0x4(%esp)
40000117:	8b 44 24 28          	mov    0x28(%esp),%eax
4000011b:	89 04 24             	mov    %eax,(%esp)
4000011e:	e8 cd 00 00 00       	call   400001f0 <vcprintf>
40000123:	90                   	nop
40000124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	va_end(ap);

	while (1)
		yield();
40000128:	e8 f3 07 00 00       	call   40000920 <yield>
4000012d:	eb f9                	jmp    40000128 <panic+0x38>
4000012f:	90                   	nop

40000130 <atoi>:
#include <stdlib.h>

int
atoi(const char *buf, int *i)
{
40000130:	55                   	push   %ebp
40000131:	57                   	push   %edi
40000132:	56                   	push   %esi
40000133:	53                   	push   %ebx
40000134:	8b 74 24 14          	mov    0x14(%esp),%esi
	int loc = 0;
	int numstart = 0;
	int acc = 0;
	int negative = 0;
	if (buf[loc] == '+')
40000138:	0f b6 06             	movzbl (%esi),%eax
4000013b:	3c 2b                	cmp    $0x2b,%al
4000013d:	74 51                	je     40000190 <atoi+0x60>
		loc++;
	else if (buf[loc] == '-') {
4000013f:	3c 2d                	cmp    $0x2d,%al
40000141:	0f 94 c0             	sete   %al
40000144:	0f b6 c0             	movzbl %al,%eax
40000147:	89 c5                	mov    %eax,%ebp
40000149:	89 c7                	mov    %eax,%edi
		negative = 1;
		loc++;
	}
	numstart = loc;
	// no grab the numbers
	while ('0' <= buf[loc] && buf[loc] <= '9') {
4000014b:	0f be 0c 06          	movsbl (%esi,%eax,1),%ecx
4000014f:	8d 41 d0             	lea    -0x30(%ecx),%eax
40000152:	3c 09                	cmp    $0x9,%al
40000154:	77 4a                	ja     400001a0 <atoi+0x70>
40000156:	89 f8                	mov    %edi,%eax
int
atoi(const char *buf, int *i)
{
	int loc = 0;
	int numstart = 0;
	int acc = 0;
40000158:	31 d2                	xor    %edx,%edx
4000015a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	}
	numstart = loc;
	// no grab the numbers
	while ('0' <= buf[loc] && buf[loc] <= '9') {
		acc = acc*10 + (buf[loc]-'0');
		loc++;
40000160:	83 c0 01             	add    $0x1,%eax
		loc++;
	}
	numstart = loc;
	// no grab the numbers
	while ('0' <= buf[loc] && buf[loc] <= '9') {
		acc = acc*10 + (buf[loc]-'0');
40000163:	8d 14 92             	lea    (%edx,%edx,4),%edx
40000166:	8d 54 51 d0          	lea    -0x30(%ecx,%edx,2),%edx
		negative = 1;
		loc++;
	}
	numstart = loc;
	// no grab the numbers
	while ('0' <= buf[loc] && buf[loc] <= '9') {
4000016a:	0f be 0c 06          	movsbl (%esi,%eax,1),%ecx
4000016e:	8d 59 d0             	lea    -0x30(%ecx),%ebx
40000171:	80 fb 09             	cmp    $0x9,%bl
40000174:	76 ea                	jbe    40000160 <atoi+0x30>
		acc = acc*10 + (buf[loc]-'0');
		loc++;
	}
	if (numstart == loc) {
40000176:	39 c7                	cmp    %eax,%edi
40000178:	74 26                	je     400001a0 <atoi+0x70>
		// no numbers have actually been scanned
		return 0;
	}
	if (negative)
		acc = - acc;
4000017a:	89 d1                	mov    %edx,%ecx
4000017c:	f7 d9                	neg    %ecx
4000017e:	85 ed                	test   %ebp,%ebp
40000180:	0f 45 d1             	cmovne %ecx,%edx
	*i = acc;
40000183:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000187:	89 11                	mov    %edx,(%ecx)
	return loc;
}
40000189:	5b                   	pop    %ebx
4000018a:	5e                   	pop    %esi
4000018b:	5f                   	pop    %edi
4000018c:	5d                   	pop    %ebp
4000018d:	c3                   	ret    
4000018e:	66 90                	xchg   %ax,%ax
40000190:	b8 01 00 00 00       	mov    $0x1,%eax
atoi(const char *buf, int *i)
{
	int loc = 0;
	int numstart = 0;
	int acc = 0;
	int negative = 0;
40000195:	31 ed                	xor    %ebp,%ebp
	if (buf[loc] == '+')
		loc++;
40000197:	bf 01 00 00 00       	mov    $0x1,%edi
4000019c:	eb ad                	jmp    4000014b <atoi+0x1b>
4000019e:	66 90                	xchg   %ax,%ax
	}
	if (negative)
		acc = - acc;
	*i = acc;
	return loc;
}
400001a0:	5b                   	pop    %ebx
		acc = acc*10 + (buf[loc]-'0');
		loc++;
	}
	if (numstart == loc) {
		// no numbers have actually been scanned
		return 0;
400001a1:	31 c0                	xor    %eax,%eax
	}
	if (negative)
		acc = - acc;
	*i = acc;
	return loc;
}
400001a3:	5e                   	pop    %esi
400001a4:	5f                   	pop    %edi
400001a5:	5d                   	pop    %ebp
400001a6:	c3                   	ret    
400001a7:	66 90                	xchg   %ax,%ax
400001a9:	66 90                	xchg   %ax,%ax
400001ab:	66 90                	xchg   %ax,%ax
400001ad:	66 90                	xchg   %ax,%ax
400001af:	90                   	nop

400001b0 <putch>:
	char buf[MAX_BUF];
};

static void
putch(int ch, struct printbuf *b)
{
400001b0:	53                   	push   %ebx
400001b1:	8b 54 24 0c          	mov    0xc(%esp),%edx
	b->buf[b->idx++] = ch;
400001b5:	0f b6 5c 24 08       	movzbl 0x8(%esp),%ebx
400001ba:	8b 0a                	mov    (%edx),%ecx
400001bc:	8d 41 01             	lea    0x1(%ecx),%eax
	if (b->idx == MAX_BUF-1) {
400001bf:	3d ff 0f 00 00       	cmp    $0xfff,%eax
};

static void
putch(int ch, struct printbuf *b)
{
	b->buf[b->idx++] = ch;
400001c4:	89 02                	mov    %eax,(%edx)
400001c6:	88 5c 0a 08          	mov    %bl,0x8(%edx,%ecx,1)
	if (b->idx == MAX_BUF-1) {
400001ca:	75 1a                	jne    400001e6 <putch+0x36>
		b->buf[b->idx] = 0;
400001cc:	c6 82 07 10 00 00 00 	movb   $0x0,0x1007(%edx)
		puts(b->buf, b->idx);
400001d3:	8d 5a 08             	lea    0x8(%edx),%ebx
#include <file.h>

static gcc_inline void
sys_puts(const char *s, size_t len)
{
	asm volatile("int %0" :
400001d6:	b9 ff 0f 00 00       	mov    $0xfff,%ecx
400001db:	66 31 c0             	xor    %ax,%ax
400001de:	cd 30                	int    $0x30
		b->idx = 0;
400001e0:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
	}
	b->cnt++;
400001e6:	83 42 04 01          	addl   $0x1,0x4(%edx)
}
400001ea:	5b                   	pop    %ebx
400001eb:	c3                   	ret    
400001ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

400001f0 <vcprintf>:

int
vcprintf(const char *fmt, va_list ap)
{
400001f0:	53                   	push   %ebx
400001f1:	81 ec 28 10 00 00    	sub    $0x1028,%esp
	struct printbuf b;

	b.idx = 0;
	b.cnt = 0;
	vprintfmt((void*)putch, &b, fmt, ap);
400001f7:	8b 84 24 34 10 00 00 	mov    0x1034(%esp),%eax
400001fe:	8d 5c 24 20          	lea    0x20(%esp),%ebx
40000202:	c7 04 24 b0 01 00 40 	movl   $0x400001b0,(%esp)
int
vcprintf(const char *fmt, va_list ap)
{
	struct printbuf b;

	b.idx = 0;
40000209:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
40000210:	00 
	b.cnt = 0;
40000211:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
40000218:	00 
	vprintfmt((void*)putch, &b, fmt, ap);
40000219:	89 44 24 0c          	mov    %eax,0xc(%esp)
4000021d:	8b 84 24 30 10 00 00 	mov    0x1030(%esp),%eax
40000224:	89 44 24 08          	mov    %eax,0x8(%esp)
40000228:	8d 44 24 18          	lea    0x18(%esp),%eax
4000022c:	89 44 24 04          	mov    %eax,0x4(%esp)
40000230:	e8 7b 01 00 00       	call   400003b0 <vprintfmt>

	b.buf[b.idx] = 0;
40000235:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000239:	31 c0                	xor    %eax,%eax
4000023b:	c6 44 0c 20 00       	movb   $0x0,0x20(%esp,%ecx,1)
40000240:	cd 30                	int    $0x30
	puts(b.buf, b.idx);

	return b.cnt;
}
40000242:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000246:	81 c4 28 10 00 00    	add    $0x1028,%esp
4000024c:	5b                   	pop    %ebx
4000024d:	c3                   	ret    
4000024e:	66 90                	xchg   %ax,%ax

40000250 <printf>:

int
printf(const char *fmt, ...)
{
40000250:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	int cnt;

	va_start(ap, fmt);
	cnt = vcprintf(fmt, ap);
40000253:	8d 44 24 24          	lea    0x24(%esp),%eax
40000257:	89 44 24 04          	mov    %eax,0x4(%esp)
4000025b:	8b 44 24 20          	mov    0x20(%esp),%eax
4000025f:	89 04 24             	mov    %eax,(%esp)
40000262:	e8 89 ff ff ff       	call   400001f0 <vcprintf>
	va_end(ap);

	return cnt;
}
40000267:	83 c4 1c             	add    $0x1c,%esp
4000026a:	c3                   	ret    
4000026b:	66 90                	xchg   %ax,%ax
4000026d:	66 90                	xchg   %ax,%ax
4000026f:	90                   	nop

40000270 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
40000270:	55                   	push   %ebp
40000271:	57                   	push   %edi
40000272:	89 d7                	mov    %edx,%edi
40000274:	56                   	push   %esi
40000275:	89 c6                	mov    %eax,%esi
40000277:	53                   	push   %ebx
40000278:	83 ec 3c             	sub    $0x3c,%esp
4000027b:	8b 44 24 50          	mov    0x50(%esp),%eax
4000027f:	8b 4c 24 58          	mov    0x58(%esp),%ecx
40000283:	8b 5c 24 5c          	mov    0x5c(%esp),%ebx
40000287:	8b 6c 24 60          	mov    0x60(%esp),%ebp
4000028b:	89 44 24 20          	mov    %eax,0x20(%esp)
4000028f:	8b 44 24 54          	mov    0x54(%esp),%eax
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
40000293:	89 ca                	mov    %ecx,%edx
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
40000295:	89 4c 24 28          	mov    %ecx,0x28(%esp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
40000299:	31 c9                	xor    %ecx,%ecx
4000029b:	89 54 24 18          	mov    %edx,0x18(%esp)
4000029f:	39 c1                	cmp    %eax,%ecx
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
400002a1:	89 44 24 24          	mov    %eax,0x24(%esp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
400002a5:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
400002a9:	0f 83 a9 00 00 00    	jae    40000358 <printnum+0xe8>
		printnum(putch, putdat, num / base, base, width - 1, padc);
400002af:	8b 44 24 28          	mov    0x28(%esp),%eax
400002b3:	83 eb 01             	sub    $0x1,%ebx
400002b6:	8b 54 24 1c          	mov    0x1c(%esp),%edx
400002ba:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
400002be:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
400002c2:	89 6c 24 10          	mov    %ebp,0x10(%esp)
400002c6:	89 44 24 08          	mov    %eax,0x8(%esp)
400002ca:	8b 44 24 18          	mov    0x18(%esp),%eax
400002ce:	8b 4c 24 08          	mov    0x8(%esp),%ecx
400002d2:	89 54 24 0c          	mov    %edx,0xc(%esp)
400002d6:	89 5c 24 2c          	mov    %ebx,0x2c(%esp)
400002da:	89 44 24 08          	mov    %eax,0x8(%esp)
400002de:	8b 44 24 20          	mov    0x20(%esp),%eax
400002e2:	89 4c 24 28          	mov    %ecx,0x28(%esp)
400002e6:	89 04 24             	mov    %eax,(%esp)
400002e9:	8b 44 24 24          	mov    0x24(%esp),%eax
400002ed:	89 44 24 04          	mov    %eax,0x4(%esp)
400002f1:	e8 ca 0b 00 00       	call   40000ec0 <__udivdi3>
400002f6:	8b 4c 24 28          	mov    0x28(%esp),%ecx
400002fa:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
400002fe:	89 4c 24 08          	mov    %ecx,0x8(%esp)
40000302:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
40000306:	89 04 24             	mov    %eax,(%esp)
40000309:	89 f0                	mov    %esi,%eax
4000030b:	89 54 24 04          	mov    %edx,0x4(%esp)
4000030f:	89 fa                	mov    %edi,%edx
40000311:	e8 5a ff ff ff       	call   40000270 <printnum>
		while (--width > 0)
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
40000316:	8b 44 24 18          	mov    0x18(%esp),%eax
4000031a:	8b 54 24 1c          	mov    0x1c(%esp),%edx
4000031e:	89 7c 24 54          	mov    %edi,0x54(%esp)
40000322:	89 44 24 08          	mov    %eax,0x8(%esp)
40000326:	8b 44 24 20          	mov    0x20(%esp),%eax
4000032a:	89 54 24 0c          	mov    %edx,0xc(%esp)
4000032e:	89 04 24             	mov    %eax,(%esp)
40000331:	8b 44 24 24          	mov    0x24(%esp),%eax
40000335:	89 44 24 04          	mov    %eax,0x4(%esp)
40000339:	e8 b2 0c 00 00       	call   40000ff0 <__umoddi3>
4000033e:	0f be 80 6c 11 00 40 	movsbl 0x4000116c(%eax),%eax
40000345:	89 44 24 50          	mov    %eax,0x50(%esp)
}
40000349:	83 c4 3c             	add    $0x3c,%esp
		while (--width > 0)
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
4000034c:	89 f0                	mov    %esi,%eax
}
4000034e:	5b                   	pop    %ebx
4000034f:	5e                   	pop    %esi
40000350:	5f                   	pop    %edi
40000351:	5d                   	pop    %ebp
		while (--width > 0)
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
40000352:	ff e0                	jmp    *%eax
40000354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
40000358:	76 1e                	jbe    40000378 <printnum+0x108>
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
4000035a:	83 eb 01             	sub    $0x1,%ebx
4000035d:	85 db                	test   %ebx,%ebx
4000035f:	7e b5                	jle    40000316 <printnum+0xa6>
40000361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			putch(padc, putdat);
40000368:	89 7c 24 04          	mov    %edi,0x4(%esp)
4000036c:	89 2c 24             	mov    %ebp,(%esp)
4000036f:	ff d6                	call   *%esi
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
40000371:	83 eb 01             	sub    $0x1,%ebx
40000374:	75 f2                	jne    40000368 <printnum+0xf8>
40000376:	eb 9e                	jmp    40000316 <printnum+0xa6>
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
40000378:	8b 44 24 20          	mov    0x20(%esp),%eax
4000037c:	39 44 24 28          	cmp    %eax,0x28(%esp)
40000380:	0f 86 29 ff ff ff    	jbe    400002af <printnum+0x3f>
40000386:	eb d2                	jmp    4000035a <printnum+0xea>
40000388:	90                   	nop
40000389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000390 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
40000390:	8b 44 24 08          	mov    0x8(%esp),%eax
	b->cnt++;
	if (b->buf < b->ebuf)
40000394:	8b 10                	mov    (%eax),%edx
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
	b->cnt++;
40000396:	83 40 08 01          	addl   $0x1,0x8(%eax)
	if (b->buf < b->ebuf)
4000039a:	3b 50 04             	cmp    0x4(%eax),%edx
4000039d:	73 0b                	jae    400003aa <sprintputch+0x1a>
		*b->buf++ = ch;
4000039f:	8d 4a 01             	lea    0x1(%edx),%ecx
400003a2:	89 08                	mov    %ecx,(%eax)
400003a4:	8b 44 24 04          	mov    0x4(%esp),%eax
400003a8:	88 02                	mov    %al,(%edx)
400003aa:	f3 c3                	repz ret 
400003ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

400003b0 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
400003b0:	55                   	push   %ebp
400003b1:	57                   	push   %edi
400003b2:	56                   	push   %esi
400003b3:	53                   	push   %ebx
400003b4:	83 ec 3c             	sub    $0x3c,%esp
400003b7:	8b 6c 24 50          	mov    0x50(%esp),%ebp
400003bb:	8b 74 24 54          	mov    0x54(%esp),%esi
400003bf:	8b 7c 24 58          	mov    0x58(%esp),%edi
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
400003c3:	0f b6 07             	movzbl (%edi),%eax
400003c6:	8d 5f 01             	lea    0x1(%edi),%ebx
400003c9:	83 f8 25             	cmp    $0x25,%eax
400003cc:	75 17                	jne    400003e5 <vprintfmt+0x35>
400003ce:	eb 28                	jmp    400003f8 <vprintfmt+0x48>
400003d0:	83 c3 01             	add    $0x1,%ebx
			if (ch == '\0')
				return;
			putch(ch, putdat);
400003d3:	89 04 24             	mov    %eax,(%esp)
400003d6:	89 74 24 04          	mov    %esi,0x4(%esp)
400003da:	ff d5                	call   *%ebp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
400003dc:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
400003e0:	83 f8 25             	cmp    $0x25,%eax
400003e3:	74 13                	je     400003f8 <vprintfmt+0x48>
			if (ch == '\0')
400003e5:	85 c0                	test   %eax,%eax
400003e7:	75 e7                	jne    400003d0 <vprintfmt+0x20>
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
400003e9:	83 c4 3c             	add    $0x3c,%esp
400003ec:	5b                   	pop    %ebx
400003ed:	5e                   	pop    %esi
400003ee:	5f                   	pop    %edi
400003ef:	5d                   	pop    %ebp
400003f0:	c3                   	ret    
400003f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			if (width < 0)
				width = 0;
			goto reswitch;

		case '#':
			altflag = 1;
400003f8:	c6 44 24 24 20       	movb   $0x20,0x24(%esp)
400003fd:	ba ff ff ff ff       	mov    $0xffffffff,%edx
40000402:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
40000409:	00 
4000040a:	c7 44 24 20 ff ff ff 	movl   $0xffffffff,0x20(%esp)
40000411:	ff 
40000412:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
40000419:	00 
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
4000041a:	0f b6 03             	movzbl (%ebx),%eax
4000041d:	8d 7b 01             	lea    0x1(%ebx),%edi
40000420:	0f b6 c8             	movzbl %al,%ecx
40000423:	83 e8 23             	sub    $0x23,%eax
40000426:	3c 55                	cmp    $0x55,%al
40000428:	0f 87 69 02 00 00    	ja     40000697 <vprintfmt+0x2e7>
4000042e:	0f b6 c0             	movzbl %al,%eax
40000431:	ff 24 85 84 11 00 40 	jmp    *0x40001184(,%eax,4)
40000438:	89 fb                	mov    %edi,%ebx
			padc = '-';
			goto reswitch;

			// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
4000043a:	c6 44 24 24 30       	movb   $0x30,0x24(%esp)
4000043f:	eb d9                	jmp    4000041a <vprintfmt+0x6a>
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
				precision = precision * 10 + ch - '0';
				ch = *fmt;
40000441:	0f be 43 01          	movsbl 0x1(%ebx),%eax
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
				precision = precision * 10 + ch - '0';
40000445:	8d 51 d0             	lea    -0x30(%ecx),%edx
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
40000448:	89 fb                	mov    %edi,%ebx
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
4000044a:	8d 48 d0             	lea    -0x30(%eax),%ecx
4000044d:	83 f9 09             	cmp    $0x9,%ecx
40000450:	0f 87 02 02 00 00    	ja     40000658 <vprintfmt+0x2a8>
40000456:	66 90                	xchg   %ax,%ax
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
40000458:	83 c3 01             	add    $0x1,%ebx
				precision = precision * 10 + ch - '0';
4000045b:	8d 14 92             	lea    (%edx,%edx,4),%edx
4000045e:	8d 54 50 d0          	lea    -0x30(%eax,%edx,2),%edx
				ch = *fmt;
40000462:	0f be 03             	movsbl (%ebx),%eax
				if (ch < '0' || ch > '9')
40000465:	8d 48 d0             	lea    -0x30(%eax),%ecx
40000468:	83 f9 09             	cmp    $0x9,%ecx
4000046b:	76 eb                	jbe    40000458 <vprintfmt+0xa8>
4000046d:	e9 e6 01 00 00       	jmp    40000658 <vprintfmt+0x2a8>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
40000472:	8b 44 24 5c          	mov    0x5c(%esp),%eax
			lflag++;
			goto reswitch;

			// character
		case 'c':
			putch(va_arg(ap, int), putdat);
40000476:	89 74 24 04          	mov    %esi,0x4(%esp)
4000047a:	83 44 24 5c 04       	addl   $0x4,0x5c(%esp)
4000047f:	8b 00                	mov    (%eax),%eax
40000481:	89 04 24             	mov    %eax,(%esp)
40000484:	ff d5                	call   *%ebp
			break;
40000486:	e9 38 ff ff ff       	jmp    400003c3 <vprintfmt+0x13>
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, long long);
4000048b:	8b 44 24 5c          	mov    0x5c(%esp),%eax
// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
4000048f:	83 7c 24 28 01       	cmpl   $0x1,0x28(%esp)
		return va_arg(*ap, long long);
40000494:	8b 08                	mov    (%eax),%ecx
// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
40000496:	0f 8e e7 02 00 00    	jle    40000783 <vprintfmt+0x3d3>
		return va_arg(*ap, long long);
4000049c:	8b 58 04             	mov    0x4(%eax),%ebx
4000049f:	83 c0 08             	add    $0x8,%eax
400004a2:	89 44 24 5c          	mov    %eax,0x5c(%esp)
				putch(' ', putdat);
			break;

			// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
400004a6:	89 ca                	mov    %ecx,%edx
400004a8:	89 d9                	mov    %ebx,%ecx
			if ((long long) num < 0) {
400004aa:	85 c9                	test   %ecx,%ecx
400004ac:	bb 0a 00 00 00       	mov    $0xa,%ebx
400004b1:	0f 88 dd 02 00 00    	js     40000794 <vprintfmt+0x3e4>
			// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
			base = 16;
		number:
			printnum(putch, putdat, num, base, width, padc);
400004b7:	0f be 44 24 24       	movsbl 0x24(%esp),%eax
400004bc:	89 14 24             	mov    %edx,(%esp)
400004bf:	89 f2                	mov    %esi,%edx
400004c1:	89 5c 24 08          	mov    %ebx,0x8(%esp)
400004c5:	89 4c 24 04          	mov    %ecx,0x4(%esp)
400004c9:	89 44 24 10          	mov    %eax,0x10(%esp)
400004cd:	8b 44 24 20          	mov    0x20(%esp),%eax
400004d1:	89 44 24 0c          	mov    %eax,0xc(%esp)
400004d5:	89 e8                	mov    %ebp,%eax
400004d7:	e8 94 fd ff ff       	call   40000270 <printnum>
			break;
400004dc:	e9 e2 fe ff ff       	jmp    400003c3 <vprintfmt+0x13>
				width = precision, precision = -1;
			goto reswitch;

			// long flag (doubled for long long)
		case 'l':
			lflag++;
400004e1:	83 44 24 28 01       	addl   $0x1,0x28(%esp)
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
400004e6:	89 fb                	mov    %edi,%ebx
			goto reswitch;

			// long flag (doubled for long long)
		case 'l':
			lflag++;
			goto reswitch;
400004e8:	e9 2d ff ff ff       	jmp    4000041a <vprintfmt+0x6a>
			num = getuint(&ap, lflag);
			base = 8;
			goto number;
#else
			// Replace this with your code.
			putch('X', putdat);
400004ed:	89 74 24 04          	mov    %esi,0x4(%esp)
400004f1:	c7 04 24 58 00 00 00 	movl   $0x58,(%esp)
400004f8:	ff d5                	call   *%ebp
			putch('X', putdat);
400004fa:	89 74 24 04          	mov    %esi,0x4(%esp)
400004fe:	c7 04 24 58 00 00 00 	movl   $0x58,(%esp)
40000505:	ff d5                	call   *%ebp
			putch('X', putdat);
40000507:	89 74 24 04          	mov    %esi,0x4(%esp)
4000050b:	c7 04 24 58 00 00 00 	movl   $0x58,(%esp)
40000512:	ff d5                	call   *%ebp
			break;
40000514:	e9 aa fe ff ff       	jmp    400003c3 <vprintfmt+0x13>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
40000519:	8b 5c 24 5c          	mov    0x5c(%esp),%ebx
			break;
#endif

			// pointer
		case 'p':
			putch('0', putdat);
4000051d:	89 74 24 04          	mov    %esi,0x4(%esp)
40000521:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
40000528:	ff d5                	call   *%ebp
			putch('x', putdat);
4000052a:	89 74 24 04          	mov    %esi,0x4(%esp)
4000052e:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
40000535:	ff d5                	call   *%ebp
			num = (unsigned long long)
40000537:	8b 13                	mov    (%ebx),%edx
40000539:	31 c9                	xor    %ecx,%ecx
				(uintptr_t) va_arg(ap, void *);
4000053b:	83 44 24 5c 04       	addl   $0x4,0x5c(%esp)
			base = 16;
			goto number;
40000540:	bb 10 00 00 00       	mov    $0x10,%ebx
40000545:	e9 6d ff ff ff       	jmp    400004b7 <vprintfmt+0x107>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
4000054a:	8b 44 24 5c          	mov    0x5c(%esp),%eax
			putch(va_arg(ap, int), putdat);
			break;

			// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
4000054e:	83 44 24 5c 04       	addl   $0x4,0x5c(%esp)
40000553:	8b 08                	mov    (%eax),%ecx
				p = "(null)";
40000555:	b8 7d 11 00 40       	mov    $0x4000117d,%eax
4000055a:	85 c9                	test   %ecx,%ecx
4000055c:	0f 44 c8             	cmove  %eax,%ecx
			if (width > 0 && padc != '-')
4000055f:	80 7c 24 24 2d       	cmpb   $0x2d,0x24(%esp)
40000564:	0f 85 a9 01 00 00    	jne    40000713 <vprintfmt+0x363>
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
4000056a:	0f be 01             	movsbl (%ecx),%eax
4000056d:	8d 59 01             	lea    0x1(%ecx),%ebx
40000570:	85 c0                	test   %eax,%eax
40000572:	0f 84 52 01 00 00    	je     400006ca <vprintfmt+0x31a>
40000578:	89 74 24 54          	mov    %esi,0x54(%esp)
4000057c:	89 de                	mov    %ebx,%esi
4000057e:	89 d3                	mov    %edx,%ebx
40000580:	89 7c 24 58          	mov    %edi,0x58(%esp)
40000584:	8b 7c 24 20          	mov    0x20(%esp),%edi
40000588:	eb 25                	jmp    400005af <vprintfmt+0x1ff>
4000058a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
40000590:	8b 4c 24 54          	mov    0x54(%esp),%ecx
40000594:	89 04 24             	mov    %eax,(%esp)
40000597:	89 4c 24 04          	mov    %ecx,0x4(%esp)
4000059b:	ff d5                	call   *%ebp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
4000059d:	83 c6 01             	add    $0x1,%esi
400005a0:	0f be 46 ff          	movsbl -0x1(%esi),%eax
400005a4:	83 ef 01             	sub    $0x1,%edi
400005a7:	85 c0                	test   %eax,%eax
400005a9:	0f 84 0f 01 00 00    	je     400006be <vprintfmt+0x30e>
400005af:	85 db                	test   %ebx,%ebx
400005b1:	78 0c                	js     400005bf <vprintfmt+0x20f>
400005b3:	83 eb 01             	sub    $0x1,%ebx
400005b6:	83 fb ff             	cmp    $0xffffffff,%ebx
400005b9:	0f 84 ff 00 00 00    	je     400006be <vprintfmt+0x30e>
				if (altflag && (ch < ' ' || ch > '~'))
400005bf:	8b 54 24 18          	mov    0x18(%esp),%edx
400005c3:	85 d2                	test   %edx,%edx
400005c5:	74 c9                	je     40000590 <vprintfmt+0x1e0>
400005c7:	8d 48 e0             	lea    -0x20(%eax),%ecx
400005ca:	83 f9 5e             	cmp    $0x5e,%ecx
400005cd:	76 c1                	jbe    40000590 <vprintfmt+0x1e0>
					putch('?', putdat);
400005cf:	8b 44 24 54          	mov    0x54(%esp),%eax
400005d3:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
400005da:	89 44 24 04          	mov    %eax,0x4(%esp)
400005de:	ff d5                	call   *%ebp
400005e0:	eb bb                	jmp    4000059d <vprintfmt+0x1ed>
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, unsigned long long);
400005e2:	8b 44 24 5c          	mov    0x5c(%esp),%eax
// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
400005e6:	83 7c 24 28 01       	cmpl   $0x1,0x28(%esp)
		return va_arg(*ap, unsigned long long);
400005eb:	8b 10                	mov    (%eax),%edx
// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
400005ed:	0f 8e 04 01 00 00    	jle    400006f7 <vprintfmt+0x347>
		return va_arg(*ap, unsigned long long);
400005f3:	8b 48 04             	mov    0x4(%eax),%ecx
400005f6:	83 c0 08             	add    $0x8,%eax
400005f9:	89 44 24 5c          	mov    %eax,0x5c(%esp)

			// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
			base = 10;
			goto number;
400005fd:	bb 0a 00 00 00       	mov    $0xa,%ebx
40000602:	e9 b0 fe ff ff       	jmp    400004b7 <vprintfmt+0x107>
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, unsigned long long);
40000607:	8b 44 24 5c          	mov    0x5c(%esp),%eax
// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
4000060b:	83 7c 24 28 01       	cmpl   $0x1,0x28(%esp)
		return va_arg(*ap, unsigned long long);
40000610:	8b 10                	mov    (%eax),%edx
// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
40000612:	0f 8e ed 00 00 00    	jle    40000705 <vprintfmt+0x355>
		return va_arg(*ap, unsigned long long);
40000618:	8b 48 04             	mov    0x4(%eax),%ecx
4000061b:	83 c0 08             	add    $0x8,%eax
4000061e:	89 44 24 5c          	mov    %eax,0x5c(%esp)
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
				(uintptr_t) va_arg(ap, void *);
			base = 16;
			goto number;
40000622:	bb 10 00 00 00       	mov    $0x10,%ebx
40000627:	e9 8b fe ff ff       	jmp    400004b7 <vprintfmt+0x107>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
4000062c:	89 fb                	mov    %edi,%ebx
			if (width < 0)
				width = 0;
			goto reswitch;

		case '#':
			altflag = 1;
4000062e:	c7 44 24 18 01 00 00 	movl   $0x1,0x18(%esp)
40000635:	00 
			goto reswitch;
40000636:	e9 df fd ff ff       	jmp    4000041a <vprintfmt+0x6a>
			printnum(putch, putdat, num, base, width, padc);
			break;

			// escaped '%' character
		case '%':
			putch(ch, putdat);
4000063b:	89 74 24 04          	mov    %esi,0x4(%esp)
4000063f:	89 0c 24             	mov    %ecx,(%esp)
40000642:	ff d5                	call   *%ebp
			break;
40000644:	e9 7a fd ff ff       	jmp    400003c3 <vprintfmt+0x13>
					break;
			}
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
40000649:	8b 44 24 5c          	mov    0x5c(%esp),%eax
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
4000064d:	89 fb                	mov    %edi,%ebx
					break;
			}
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
4000064f:	8b 10                	mov    (%eax),%edx
40000651:	83 c0 04             	add    $0x4,%eax
40000654:	89 44 24 5c          	mov    %eax,0x5c(%esp)
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
40000658:	8b 7c 24 20          	mov    0x20(%esp),%edi
4000065c:	85 ff                	test   %edi,%edi
4000065e:	0f 89 b6 fd ff ff    	jns    4000041a <vprintfmt+0x6a>
				width = precision, precision = -1;
40000664:	89 54 24 20          	mov    %edx,0x20(%esp)
40000668:	ba ff ff ff ff       	mov    $0xffffffff,%edx
4000066d:	e9 a8 fd ff ff       	jmp    4000041a <vprintfmt+0x6a>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
40000672:	89 fb                	mov    %edi,%ebx

			// flag to pad on the right
		case '-':
			padc = '-';
40000674:	c6 44 24 24 2d       	movb   $0x2d,0x24(%esp)
40000679:	e9 9c fd ff ff       	jmp    4000041a <vprintfmt+0x6a>
4000067e:	8b 4c 24 20          	mov    0x20(%esp),%ecx
40000682:	b8 00 00 00 00       	mov    $0x0,%eax
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
40000687:	89 fb                	mov    %edi,%ebx
40000689:	85 c9                	test   %ecx,%ecx
4000068b:	0f 49 c1             	cmovns %ecx,%eax
4000068e:	89 44 24 20          	mov    %eax,0x20(%esp)
40000692:	e9 83 fd ff ff       	jmp    4000041a <vprintfmt+0x6a>
			putch(ch, putdat);
			break;

			// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
40000697:	89 74 24 04          	mov    %esi,0x4(%esp)
			for (fmt--; fmt[-1] != '%'; fmt--)
4000069b:	89 df                	mov    %ebx,%edi
			putch(ch, putdat);
			break;

			// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
4000069d:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
400006a4:	ff d5                	call   *%ebp
			for (fmt--; fmt[-1] != '%'; fmt--)
400006a6:	80 7b ff 25          	cmpb   $0x25,-0x1(%ebx)
400006aa:	0f 84 13 fd ff ff    	je     400003c3 <vprintfmt+0x13>
400006b0:	83 ef 01             	sub    $0x1,%edi
400006b3:	80 7f ff 25          	cmpb   $0x25,-0x1(%edi)
400006b7:	75 f7                	jne    400006b0 <vprintfmt+0x300>
400006b9:	e9 05 fd ff ff       	jmp    400003c3 <vprintfmt+0x13>
400006be:	89 7c 24 20          	mov    %edi,0x20(%esp)
400006c2:	8b 74 24 54          	mov    0x54(%esp),%esi
400006c6:	8b 7c 24 58          	mov    0x58(%esp),%edi
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
400006ca:	8b 4c 24 20          	mov    0x20(%esp),%ecx
400006ce:	8b 5c 24 20          	mov    0x20(%esp),%ebx
400006d2:	85 c9                	test   %ecx,%ecx
400006d4:	0f 8e e9 fc ff ff    	jle    400003c3 <vprintfmt+0x13>
400006da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
				putch(' ', putdat);
400006e0:	89 74 24 04          	mov    %esi,0x4(%esp)
400006e4:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
400006eb:	ff d5                	call   *%ebp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
400006ed:	83 eb 01             	sub    $0x1,%ebx
400006f0:	75 ee                	jne    400006e0 <vprintfmt+0x330>
400006f2:	e9 cc fc ff ff       	jmp    400003c3 <vprintfmt+0x13>
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, unsigned long long);
	else if (lflag)
		return va_arg(*ap, unsigned long);
400006f7:	83 c0 04             	add    $0x4,%eax
400006fa:	31 c9                	xor    %ecx,%ecx
400006fc:	89 44 24 5c          	mov    %eax,0x5c(%esp)
40000700:	e9 f8 fe ff ff       	jmp    400005fd <vprintfmt+0x24d>
40000705:	83 c0 04             	add    $0x4,%eax
40000708:	31 c9                	xor    %ecx,%ecx
4000070a:	89 44 24 5c          	mov    %eax,0x5c(%esp)
4000070e:	e9 0f ff ff ff       	jmp    40000622 <vprintfmt+0x272>

			// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
40000713:	8b 5c 24 20          	mov    0x20(%esp),%ebx
40000717:	85 db                	test   %ebx,%ebx
40000719:	0f 8e 4b fe ff ff    	jle    4000056a <vprintfmt+0x1ba>
				for (width -= strnlen(p, precision); width > 0; width--)
4000071f:	89 54 24 04          	mov    %edx,0x4(%esp)
40000723:	89 0c 24             	mov    %ecx,(%esp)
40000726:	89 54 24 2c          	mov    %edx,0x2c(%esp)
4000072a:	89 4c 24 28          	mov    %ecx,0x28(%esp)
4000072e:	e8 ad 02 00 00       	call   400009e0 <strnlen>
40000733:	8b 4c 24 28          	mov    0x28(%esp),%ecx
40000737:	8b 54 24 2c          	mov    0x2c(%esp),%edx
4000073b:	29 44 24 20          	sub    %eax,0x20(%esp)
4000073f:	8b 44 24 20          	mov    0x20(%esp),%eax
40000743:	85 c0                	test   %eax,%eax
40000745:	0f 8e 1f fe ff ff    	jle    4000056a <vprintfmt+0x1ba>
4000074b:	0f be 5c 24 24       	movsbl 0x24(%esp),%ebx
40000750:	89 7c 24 58          	mov    %edi,0x58(%esp)
40000754:	89 c7                	mov    %eax,%edi
40000756:	89 4c 24 20          	mov    %ecx,0x20(%esp)
4000075a:	89 54 24 24          	mov    %edx,0x24(%esp)
4000075e:	66 90                	xchg   %ax,%ax
					putch(padc, putdat);
40000760:	89 74 24 04          	mov    %esi,0x4(%esp)
40000764:	89 1c 24             	mov    %ebx,(%esp)
40000767:	ff d5                	call   *%ebp
			// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
40000769:	83 ef 01             	sub    $0x1,%edi
4000076c:	75 f2                	jne    40000760 <vprintfmt+0x3b0>
4000076e:	8b 4c 24 20          	mov    0x20(%esp),%ecx
40000772:	8b 54 24 24          	mov    0x24(%esp),%edx
40000776:	89 7c 24 20          	mov    %edi,0x20(%esp)
4000077a:	8b 7c 24 58          	mov    0x58(%esp),%edi
4000077e:	e9 e7 fd ff ff       	jmp    4000056a <vprintfmt+0x1ba>
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, long long);
	else if (lflag)
		return va_arg(*ap, long);
40000783:	89 cb                	mov    %ecx,%ebx
40000785:	83 c0 04             	add    $0x4,%eax
40000788:	c1 fb 1f             	sar    $0x1f,%ebx
4000078b:	89 44 24 5c          	mov    %eax,0x5c(%esp)
4000078f:	e9 12 fd ff ff       	jmp    400004a6 <vprintfmt+0xf6>
40000794:	89 54 24 18          	mov    %edx,0x18(%esp)
40000798:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)

			// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
			if ((long long) num < 0) {
				putch('-', putdat);
4000079c:	89 74 24 04          	mov    %esi,0x4(%esp)
400007a0:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
400007a7:	ff d5                	call   *%ebp
				num = -(long long) num;
400007a9:	8b 54 24 18          	mov    0x18(%esp),%edx
400007ad:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
400007b1:	f7 da                	neg    %edx
400007b3:	83 d1 00             	adc    $0x0,%ecx
400007b6:	f7 d9                	neg    %ecx
400007b8:	e9 fa fc ff ff       	jmp    400004b7 <vprintfmt+0x107>
400007bd:	8d 76 00             	lea    0x0(%esi),%esi

400007c0 <printfmt>:
	}
}

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
400007c0:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;

	va_start(ap, fmt);
	vprintfmt(putch, putdat, fmt, ap);
400007c3:	8d 44 24 2c          	lea    0x2c(%esp),%eax
400007c7:	89 44 24 0c          	mov    %eax,0xc(%esp)
400007cb:	8b 44 24 28          	mov    0x28(%esp),%eax
400007cf:	89 44 24 08          	mov    %eax,0x8(%esp)
400007d3:	8b 44 24 24          	mov    0x24(%esp),%eax
400007d7:	89 44 24 04          	mov    %eax,0x4(%esp)
400007db:	8b 44 24 20          	mov    0x20(%esp),%eax
400007df:	89 04 24             	mov    %eax,(%esp)
400007e2:	e8 c9 fb ff ff       	call   400003b0 <vprintfmt>
	va_end(ap);
}
400007e7:	83 c4 1c             	add    $0x1c,%esp
400007ea:	c3                   	ret    
400007eb:	90                   	nop
400007ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

400007f0 <vsprintf>:
		*b->buf++ = ch;
}

int
vsprintf(char *buf, const char *fmt, va_list ap)
{
400007f0:	83 ec 2c             	sub    $0x2c,%esp
	//assert(buf != NULL);
	struct sprintbuf b = {buf, (char*)(intptr_t)~0, 0};
400007f3:	8b 44 24 30          	mov    0x30(%esp),%eax

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
400007f7:	c7 04 24 90 03 00 40 	movl   $0x40000390,(%esp)

int
vsprintf(char *buf, const char *fmt, va_list ap)
{
	//assert(buf != NULL);
	struct sprintbuf b = {buf, (char*)(intptr_t)~0, 0};
400007fe:	c7 44 24 18 ff ff ff 	movl   $0xffffffff,0x18(%esp)
40000805:	ff 
40000806:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
4000080d:	00 
4000080e:	89 44 24 14          	mov    %eax,0x14(%esp)

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
40000812:	8b 44 24 38          	mov    0x38(%esp),%eax
40000816:	89 44 24 0c          	mov    %eax,0xc(%esp)
4000081a:	8b 44 24 34          	mov    0x34(%esp),%eax
4000081e:	89 44 24 08          	mov    %eax,0x8(%esp)
40000822:	8d 44 24 14          	lea    0x14(%esp),%eax
40000826:	89 44 24 04          	mov    %eax,0x4(%esp)
4000082a:	e8 81 fb ff ff       	call   400003b0 <vprintfmt>

	// null terminate the buffer
	*b.buf = '\0';
4000082f:	8b 44 24 14          	mov    0x14(%esp),%eax
40000833:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
}
40000836:	8b 44 24 1c          	mov    0x1c(%esp),%eax
4000083a:	83 c4 2c             	add    $0x2c,%esp
4000083d:	c3                   	ret    
4000083e:	66 90                	xchg   %ax,%ax

40000840 <sprintf>:

int
sprintf(char *buf, const char *fmt, ...)
{
40000840:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
	rc = vsprintf(buf, fmt, ap);
40000843:	8d 44 24 28          	lea    0x28(%esp),%eax
40000847:	89 44 24 08          	mov    %eax,0x8(%esp)
4000084b:	8b 44 24 24          	mov    0x24(%esp),%eax
4000084f:	89 44 24 04          	mov    %eax,0x4(%esp)
40000853:	8b 44 24 20          	mov    0x20(%esp),%eax
40000857:	89 04 24             	mov    %eax,(%esp)
4000085a:	e8 91 ff ff ff       	call   400007f0 <vsprintf>
	va_end(ap);

	return rc;
}
4000085f:	83 c4 1c             	add    $0x1c,%esp
40000862:	c3                   	ret    
40000863:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000870 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
40000870:	83 ec 2c             	sub    $0x2c,%esp
40000873:	8b 44 24 30          	mov    0x30(%esp),%eax
	//assert(buf != NULL && n > 0);
	struct sprintbuf b = {buf, buf+n-1, 0};
40000877:	8b 54 24 34          	mov    0x34(%esp),%edx

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
4000087b:	c7 04 24 90 03 00 40 	movl   $0x40000390,(%esp)

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
	//assert(buf != NULL && n > 0);
	struct sprintbuf b = {buf, buf+n-1, 0};
40000882:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
40000889:	00 
4000088a:	89 44 24 14          	mov    %eax,0x14(%esp)
4000088e:	8d 44 10 ff          	lea    -0x1(%eax,%edx,1),%eax
40000892:	89 44 24 18          	mov    %eax,0x18(%esp)

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
40000896:	8b 44 24 3c          	mov    0x3c(%esp),%eax
4000089a:	89 44 24 0c          	mov    %eax,0xc(%esp)
4000089e:	8b 44 24 38          	mov    0x38(%esp),%eax
400008a2:	89 44 24 08          	mov    %eax,0x8(%esp)
400008a6:	8d 44 24 14          	lea    0x14(%esp),%eax
400008aa:	89 44 24 04          	mov    %eax,0x4(%esp)
400008ae:	e8 fd fa ff ff       	call   400003b0 <vprintfmt>

	// null terminate the buffer
	*b.buf = '\0';
400008b3:	8b 44 24 14          	mov    0x14(%esp),%eax
400008b7:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
}
400008ba:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400008be:	83 c4 2c             	add    $0x2c,%esp
400008c1:	c3                   	ret    
400008c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400008c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

400008d0 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
400008d0:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
	rc = vsnprintf(buf, n, fmt, ap);
400008d3:	8d 44 24 2c          	lea    0x2c(%esp),%eax
400008d7:	89 44 24 0c          	mov    %eax,0xc(%esp)
400008db:	8b 44 24 28          	mov    0x28(%esp),%eax
400008df:	89 44 24 08          	mov    %eax,0x8(%esp)
400008e3:	8b 44 24 24          	mov    0x24(%esp),%eax
400008e7:	89 44 24 04          	mov    %eax,0x4(%esp)
400008eb:	8b 44 24 20          	mov    0x20(%esp),%eax
400008ef:	89 04 24             	mov    %eax,(%esp)
400008f2:	e8 79 ff ff ff       	call   40000870 <vsnprintf>
	va_end(ap);

	return rc;
}
400008f7:	83 c4 1c             	add    $0x1c,%esp
400008fa:	c3                   	ret    
400008fb:	66 90                	xchg   %ax,%ax
400008fd:	66 90                	xchg   %ax,%ax
400008ff:	90                   	nop

40000900 <spawn>:
#include <syscall.h>
#include <types.h>

pid_t
spawn(uintptr_t exec, unsigned int quota)
{
40000900:	53                   	push   %ebx
sys_spawn(uintptr_t exec, unsigned int quota)
{
	int errno;
	pid_t pid;

	asm volatile("int %2"
40000901:	b8 01 00 00 00       	mov    $0x1,%eax
40000906:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
4000090a:	8b 5c 24 08          	mov    0x8(%esp),%ebx
4000090e:	cd 30                	int    $0x30
		       "a" (SYS_spawn),
		       "b" (exec),
		       "c" (quota)
		     : "cc", "memory");

	return errno ? -1 : pid;
40000910:	ba ff ff ff ff       	mov    $0xffffffff,%edx
40000915:	85 c0                	test   %eax,%eax
40000917:	0f 44 d3             	cmove  %ebx,%edx
	return sys_spawn(exec, quota);
}
4000091a:	89 d0                	mov    %edx,%eax
4000091c:	5b                   	pop    %ebx
4000091d:	c3                   	ret    
4000091e:	66 90                	xchg   %ax,%ax

40000920 <yield>:
}

static gcc_inline void
sys_yield(void)
{
	asm volatile("int %0" :
40000920:	b8 02 00 00 00       	mov    $0x2,%eax
40000925:	cd 30                	int    $0x30
40000927:	c3                   	ret    
40000928:	90                   	nop
40000929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000930 <produce>:
}

static gcc_inline void
sys_produce(void)
{
	asm volatile("int %0" :
40000930:	b8 03 00 00 00       	mov    $0x3,%eax
40000935:	cd 30                	int    $0x30
40000937:	c3                   	ret    
40000938:	90                   	nop
40000939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000940 <consume>:
}

static gcc_inline void
sys_consume(void)
{
	asm volatile("int %0" :
40000940:	b8 04 00 00 00       	mov    $0x4,%eax
40000945:	cd 30                	int    $0x30
40000947:	c3                   	ret    
40000948:	66 90                	xchg   %ax,%ax
4000094a:	66 90                	xchg   %ax,%ax
4000094c:	66 90                	xchg   %ax,%ax
4000094e:	66 90                	xchg   %ax,%ax

40000950 <spinlock_init>:
}

void
spinlock_init(spinlock_t *lk)
{
	*lk = 0;
40000950:	8b 44 24 04          	mov    0x4(%esp),%eax
40000954:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
4000095a:	c3                   	ret    
4000095b:	90                   	nop
4000095c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000960 <spinlock_acquire>:
}

void
spinlock_acquire(spinlock_t *lk)
{
40000960:	8b 54 24 04          	mov    0x4(%esp),%edx
static inline uint32_t
xchg(volatile uint32_t *addr, uint32_t newval)
{
	uint32_t result;

	asm volatile("lock; xchgl %0, %1" :
40000964:	b8 01 00 00 00       	mov    $0x1,%eax
40000969:	f0 87 02             	lock xchg %eax,(%edx)
}

void
spinlock_acquire(spinlock_t *lk)
{
	while(xchg(lk, 1) != 0)
4000096c:	85 c0                	test   %eax,%eax
static inline uint32_t
xchg(volatile uint32_t *addr, uint32_t newval)
{
	uint32_t result;

	asm volatile("lock; xchgl %0, %1" :
4000096e:	b9 01 00 00 00       	mov    $0x1,%ecx
}

void
spinlock_acquire(spinlock_t *lk)
{
	while(xchg(lk, 1) != 0)
40000973:	74 0e                	je     40000983 <spinlock_acquire+0x23>
40000975:	8d 76 00             	lea    0x0(%esi),%esi
		asm volatile("pause");
40000978:	f3 90                	pause  
static inline uint32_t
xchg(volatile uint32_t *addr, uint32_t newval)
{
	uint32_t result;

	asm volatile("lock; xchgl %0, %1" :
4000097a:	89 c8                	mov    %ecx,%eax
4000097c:	f0 87 02             	lock xchg %eax,(%edx)
}

void
spinlock_acquire(spinlock_t *lk)
{
	while(xchg(lk, 1) != 0)
4000097f:	85 c0                	test   %eax,%eax
40000981:	75 f5                	jne    40000978 <spinlock_acquire+0x18>
40000983:	f3 c3                	repz ret 
40000985:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000990 <spinlock_release>:
}

// Release the lock.
void
spinlock_release(spinlock_t *lk)
{
40000990:	8b 54 24 04          	mov    0x4(%esp),%edx

// Check whether this cpu is holding the lock.
bool
spinlock_holding(spinlock_t *lock)
{
	return *lock;
40000994:	8b 02                	mov    (%edx),%eax

// Release the lock.
void
spinlock_release(spinlock_t *lk)
{
	if (spinlock_holding(lk) == FALSE)
40000996:	84 c0                	test   %al,%al
40000998:	74 05                	je     4000099f <spinlock_release+0xf>
static inline uint32_t
xchg(volatile uint32_t *addr, uint32_t newval)
{
	uint32_t result;

	asm volatile("lock; xchgl %0, %1" :
4000099a:	31 c0                	xor    %eax,%eax
4000099c:	f0 87 02             	lock xchg %eax,(%edx)
4000099f:	f3 c3                	repz ret 
400009a1:	eb 0d                	jmp    400009b0 <spinlock_holding>
400009a3:	90                   	nop
400009a4:	90                   	nop
400009a5:	90                   	nop
400009a6:	90                   	nop
400009a7:	90                   	nop
400009a8:	90                   	nop
400009a9:	90                   	nop
400009aa:	90                   	nop
400009ab:	90                   	nop
400009ac:	90                   	nop
400009ad:	90                   	nop
400009ae:	90                   	nop
400009af:	90                   	nop

400009b0 <spinlock_holding>:

// Check whether this cpu is holding the lock.
bool
spinlock_holding(spinlock_t *lock)
{
	return *lock;
400009b0:	8b 44 24 04          	mov    0x4(%esp),%eax
400009b4:	8b 00                	mov    (%eax),%eax
}
400009b6:	c3                   	ret    
400009b7:	66 90                	xchg   %ax,%ax
400009b9:	66 90                	xchg   %ax,%ax
400009bb:	66 90                	xchg   %ax,%ax
400009bd:	66 90                	xchg   %ax,%ax
400009bf:	90                   	nop

400009c0 <strlen>:
#include <string.h>
#include <types.h>

int
strlen(const char *s)
{
400009c0:	8b 54 24 04          	mov    0x4(%esp),%edx
	int n;

	for (n = 0; *s != '\0'; s++)
400009c4:	31 c0                	xor    %eax,%eax
400009c6:	80 3a 00             	cmpb   $0x0,(%edx)
400009c9:	74 10                	je     400009db <strlen+0x1b>
400009cb:	90                   	nop
400009cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		n++;
400009d0:	83 c0 01             	add    $0x1,%eax
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
400009d3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
400009d7:	75 f7                	jne    400009d0 <strlen+0x10>
400009d9:	f3 c3                	repz ret 
		n++;
	return n;
}
400009db:	f3 c3                	repz ret 
400009dd:	8d 76 00             	lea    0x0(%esi),%esi

400009e0 <strnlen>:

int
strnlen(const char *s, size_t size)
{
400009e0:	53                   	push   %ebx
400009e1:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
400009e5:	8b 5c 24 08          	mov    0x8(%esp),%ebx
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
400009e9:	85 c9                	test   %ecx,%ecx
400009eb:	74 25                	je     40000a12 <strnlen+0x32>
400009ed:	80 3b 00             	cmpb   $0x0,(%ebx)
400009f0:	74 20                	je     40000a12 <strnlen+0x32>
400009f2:	ba 01 00 00 00       	mov    $0x1,%edx
400009f7:	eb 11                	jmp    40000a0a <strnlen+0x2a>
400009f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000a00:	83 c2 01             	add    $0x1,%edx
40000a03:	80 7c 13 ff 00       	cmpb   $0x0,-0x1(%ebx,%edx,1)
40000a08:	74 06                	je     40000a10 <strnlen+0x30>
40000a0a:	39 ca                	cmp    %ecx,%edx
		n++;
40000a0c:	89 d0                	mov    %edx,%eax
int
strnlen(const char *s, size_t size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000a0e:	75 f0                	jne    40000a00 <strnlen+0x20>
		n++;
	return n;
}
40000a10:	5b                   	pop    %ebx
40000a11:	c3                   	ret    
int
strnlen(const char *s, size_t size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000a12:	31 c0                	xor    %eax,%eax
		n++;
	return n;
}
40000a14:	5b                   	pop    %ebx
40000a15:	c3                   	ret    
40000a16:	8d 76 00             	lea    0x0(%esi),%esi
40000a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000a20 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
40000a20:	53                   	push   %ebx
40000a21:	8b 44 24 08          	mov    0x8(%esp),%eax
40000a25:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
	char *ret;

	ret = dst;
	while ((*dst++ = *src++) != '\0')
40000a29:	89 c2                	mov    %eax,%edx
40000a2b:	90                   	nop
40000a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000a30:	83 c1 01             	add    $0x1,%ecx
40000a33:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
40000a37:	83 c2 01             	add    $0x1,%edx
40000a3a:	84 db                	test   %bl,%bl
40000a3c:	88 5a ff             	mov    %bl,-0x1(%edx)
40000a3f:	75 ef                	jne    40000a30 <strcpy+0x10>
		/* do nothing */;
	return ret;
}
40000a41:	5b                   	pop    %ebx
40000a42:	c3                   	ret    
40000a43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000a50 <strncpy>:

char *
strncpy(char *dst, const char *src, size_t size)
{
40000a50:	57                   	push   %edi
40000a51:	56                   	push   %esi
40000a52:	53                   	push   %ebx
40000a53:	8b 74 24 18          	mov    0x18(%esp),%esi
40000a57:	8b 7c 24 10          	mov    0x10(%esp),%edi
40000a5b:	8b 4c 24 14          	mov    0x14(%esp),%ecx
	size_t i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
40000a5f:	85 f6                	test   %esi,%esi
40000a61:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
40000a64:	89 fa                	mov    %edi,%edx
40000a66:	74 13                	je     40000a7b <strncpy+0x2b>
		*dst++ = *src;
40000a68:	0f b6 01             	movzbl (%ecx),%eax
40000a6b:	83 c2 01             	add    $0x1,%edx
40000a6e:	88 42 ff             	mov    %al,-0x1(%edx)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
40000a71:	80 39 01             	cmpb   $0x1,(%ecx)
40000a74:	83 d9 ff             	sbb    $0xffffffff,%ecx
{
	size_t i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
40000a77:	39 da                	cmp    %ebx,%edx
40000a79:	75 ed                	jne    40000a68 <strncpy+0x18>
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
}
40000a7b:	89 f8                	mov    %edi,%eax
40000a7d:	5b                   	pop    %ebx
40000a7e:	5e                   	pop    %esi
40000a7f:	5f                   	pop    %edi
40000a80:	c3                   	ret    
40000a81:	eb 0d                	jmp    40000a90 <strlcpy>
40000a83:	90                   	nop
40000a84:	90                   	nop
40000a85:	90                   	nop
40000a86:	90                   	nop
40000a87:	90                   	nop
40000a88:	90                   	nop
40000a89:	90                   	nop
40000a8a:	90                   	nop
40000a8b:	90                   	nop
40000a8c:	90                   	nop
40000a8d:	90                   	nop
40000a8e:	90                   	nop
40000a8f:	90                   	nop

40000a90 <strlcpy>:

size_t
strlcpy(char *dst, const char *src, size_t size)
{
40000a90:	56                   	push   %esi
40000a91:	31 c0                	xor    %eax,%eax
40000a93:	53                   	push   %ebx
40000a94:	8b 74 24 14          	mov    0x14(%esp),%esi
40000a98:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
40000a9c:	85 f6                	test   %esi,%esi
40000a9e:	74 36                	je     40000ad6 <strlcpy+0x46>
		while (--size > 0 && *src != '\0')
40000aa0:	83 fe 01             	cmp    $0x1,%esi
40000aa3:	74 34                	je     40000ad9 <strlcpy+0x49>
40000aa5:	0f b6 0b             	movzbl (%ebx),%ecx
40000aa8:	84 c9                	test   %cl,%cl
40000aaa:	74 2d                	je     40000ad9 <strlcpy+0x49>
40000aac:	83 ee 02             	sub    $0x2,%esi
40000aaf:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000ab3:	eb 0e                	jmp    40000ac3 <strlcpy+0x33>
40000ab5:	8d 76 00             	lea    0x0(%esi),%esi
40000ab8:	83 c0 01             	add    $0x1,%eax
40000abb:	0f b6 0c 03          	movzbl (%ebx,%eax,1),%ecx
40000abf:	84 c9                	test   %cl,%cl
40000ac1:	74 0a                	je     40000acd <strlcpy+0x3d>
			*dst++ = *src++;
40000ac3:	83 c2 01             	add    $0x1,%edx
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
40000ac6:	39 f0                	cmp    %esi,%eax
			*dst++ = *src++;
40000ac8:	88 4a ff             	mov    %cl,-0x1(%edx)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
40000acb:	75 eb                	jne    40000ab8 <strlcpy+0x28>
40000acd:	89 d0                	mov    %edx,%eax
40000acf:	2b 44 24 0c          	sub    0xc(%esp),%eax
			*dst++ = *src++;
		*dst = '\0';
40000ad3:	c6 02 00             	movb   $0x0,(%edx)
	}
	return dst - dst_in;
}
40000ad6:	5b                   	pop    %ebx
40000ad7:	5e                   	pop    %esi
40000ad8:	c3                   	ret    
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
40000ad9:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000add:	eb f4                	jmp    40000ad3 <strlcpy+0x43>
40000adf:	90                   	nop

40000ae0 <strcmp>:
	return dst - dst_in;
}

int
strcmp(const char *p, const char *q)
{
40000ae0:	53                   	push   %ebx
40000ae1:	8b 54 24 08          	mov    0x8(%esp),%edx
40000ae5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
	while (*p && *p == *q)
40000ae9:	0f b6 02             	movzbl (%edx),%eax
40000aec:	84 c0                	test   %al,%al
40000aee:	74 2d                	je     40000b1d <strcmp+0x3d>
40000af0:	0f b6 19             	movzbl (%ecx),%ebx
40000af3:	38 d8                	cmp    %bl,%al
40000af5:	74 0f                	je     40000b06 <strcmp+0x26>
40000af7:	eb 2b                	jmp    40000b24 <strcmp+0x44>
40000af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b00:	38 c8                	cmp    %cl,%al
40000b02:	75 15                	jne    40000b19 <strcmp+0x39>
		p++, q++;
40000b04:	89 d9                	mov    %ebx,%ecx
40000b06:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
40000b09:	0f b6 02             	movzbl (%edx),%eax
		p++, q++;
40000b0c:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
40000b0f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
40000b13:	84 c0                	test   %al,%al
40000b15:	75 e9                	jne    40000b00 <strcmp+0x20>
40000b17:	31 c0                	xor    %eax,%eax
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
40000b19:	29 c8                	sub    %ecx,%eax
}
40000b1b:	5b                   	pop    %ebx
40000b1c:	c3                   	ret    
40000b1d:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
40000b20:	31 c0                	xor    %eax,%eax
40000b22:	eb f5                	jmp    40000b19 <strcmp+0x39>
40000b24:	0f b6 cb             	movzbl %bl,%ecx
40000b27:	eb f0                	jmp    40000b19 <strcmp+0x39>
40000b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000b30 <strncmp>:
	return (int) ((unsigned char) *p - (unsigned char) *q);
}

int
strncmp(const char *p, const char *q, size_t n)
{
40000b30:	56                   	push   %esi
40000b31:	53                   	push   %ebx
40000b32:	8b 74 24 14          	mov    0x14(%esp),%esi
40000b36:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000b3a:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	while (n > 0 && *p && *p == *q)
40000b3e:	85 f6                	test   %esi,%esi
40000b40:	74 30                	je     40000b72 <strncmp+0x42>
40000b42:	0f b6 01             	movzbl (%ecx),%eax
40000b45:	84 c0                	test   %al,%al
40000b47:	74 2e                	je     40000b77 <strncmp+0x47>
40000b49:	0f b6 13             	movzbl (%ebx),%edx
40000b4c:	38 d0                	cmp    %dl,%al
40000b4e:	75 3e                	jne    40000b8e <strncmp+0x5e>
40000b50:	8d 51 01             	lea    0x1(%ecx),%edx
40000b53:	01 ce                	add    %ecx,%esi
40000b55:	eb 14                	jmp    40000b6b <strncmp+0x3b>
40000b57:	90                   	nop
40000b58:	0f b6 02             	movzbl (%edx),%eax
40000b5b:	84 c0                	test   %al,%al
40000b5d:	74 29                	je     40000b88 <strncmp+0x58>
40000b5f:	0f b6 19             	movzbl (%ecx),%ebx
40000b62:	83 c2 01             	add    $0x1,%edx
40000b65:	38 d8                	cmp    %bl,%al
40000b67:	75 17                	jne    40000b80 <strncmp+0x50>
		n--, p++, q++;
40000b69:	89 cb                	mov    %ecx,%ebx
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
40000b6b:	39 f2                	cmp    %esi,%edx
		n--, p++, q++;
40000b6d:	8d 4b 01             	lea    0x1(%ebx),%ecx
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
40000b70:	75 e6                	jne    40000b58 <strncmp+0x28>
		n--, p++, q++;
	if (n == 0)
		return 0;
40000b72:	31 c0                	xor    %eax,%eax
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
}
40000b74:	5b                   	pop    %ebx
40000b75:	5e                   	pop    %esi
40000b76:	c3                   	ret    
40000b77:	0f b6 1b             	movzbl (%ebx),%ebx
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
40000b7a:	31 c0                	xor    %eax,%eax
40000b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		n--, p++, q++;
	if (n == 0)
		return 0;
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
40000b80:	0f b6 d3             	movzbl %bl,%edx
40000b83:	29 d0                	sub    %edx,%eax
}
40000b85:	5b                   	pop    %ebx
40000b86:	5e                   	pop    %esi
40000b87:	c3                   	ret    
40000b88:	0f b6 5b 01          	movzbl 0x1(%ebx),%ebx
40000b8c:	eb f2                	jmp    40000b80 <strncmp+0x50>
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
40000b8e:	89 d3                	mov    %edx,%ebx
40000b90:	eb ee                	jmp    40000b80 <strncmp+0x50>
40000b92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000ba0 <strchr>:
		return (int) ((unsigned char) *p - (unsigned char) *q);
}

char *
strchr(const char *s, char c)
{
40000ba0:	53                   	push   %ebx
40000ba1:	8b 44 24 08          	mov    0x8(%esp),%eax
40000ba5:	8b 54 24 0c          	mov    0xc(%esp),%edx
	for (; *s; s++)
40000ba9:	0f b6 18             	movzbl (%eax),%ebx
40000bac:	84 db                	test   %bl,%bl
40000bae:	74 16                	je     40000bc6 <strchr+0x26>
		if (*s == c)
40000bb0:	38 d3                	cmp    %dl,%bl
40000bb2:	89 d1                	mov    %edx,%ecx
40000bb4:	75 06                	jne    40000bbc <strchr+0x1c>
40000bb6:	eb 10                	jmp    40000bc8 <strchr+0x28>
40000bb8:	38 ca                	cmp    %cl,%dl
40000bba:	74 0c                	je     40000bc8 <strchr+0x28>
}

char *
strchr(const char *s, char c)
{
	for (; *s; s++)
40000bbc:	83 c0 01             	add    $0x1,%eax
40000bbf:	0f b6 10             	movzbl (%eax),%edx
40000bc2:	84 d2                	test   %dl,%dl
40000bc4:	75 f2                	jne    40000bb8 <strchr+0x18>
		if (*s == c)
			return (char *) s;
	return 0;
40000bc6:	31 c0                	xor    %eax,%eax
}
40000bc8:	5b                   	pop    %ebx
40000bc9:	c3                   	ret    
40000bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000bd0 <strfind>:

char *
strfind(const char *s, char c)
{
40000bd0:	53                   	push   %ebx
40000bd1:	8b 44 24 08          	mov    0x8(%esp),%eax
40000bd5:	8b 54 24 0c          	mov    0xc(%esp),%edx
	for (; *s; s++)
40000bd9:	0f b6 18             	movzbl (%eax),%ebx
40000bdc:	84 db                	test   %bl,%bl
40000bde:	74 16                	je     40000bf6 <strfind+0x26>
		if (*s == c)
40000be0:	38 d3                	cmp    %dl,%bl
40000be2:	89 d1                	mov    %edx,%ecx
40000be4:	75 06                	jne    40000bec <strfind+0x1c>
40000be6:	eb 0e                	jmp    40000bf6 <strfind+0x26>
40000be8:	38 ca                	cmp    %cl,%dl
40000bea:	74 0a                	je     40000bf6 <strfind+0x26>
}

char *
strfind(const char *s, char c)
{
	for (; *s; s++)
40000bec:	83 c0 01             	add    $0x1,%eax
40000bef:	0f b6 10             	movzbl (%eax),%edx
40000bf2:	84 d2                	test   %dl,%dl
40000bf4:	75 f2                	jne    40000be8 <strfind+0x18>
		if (*s == c)
			break;
	return (char *) s;
}
40000bf6:	5b                   	pop    %ebx
40000bf7:	c3                   	ret    
40000bf8:	90                   	nop
40000bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000c00 <strtol>:


long
strtol(const char *s, char **endptr, int base)
{
40000c00:	55                   	push   %ebp
40000c01:	57                   	push   %edi
40000c02:	56                   	push   %esi
40000c03:	53                   	push   %ebx
40000c04:	8b 54 24 14          	mov    0x14(%esp),%edx
40000c08:	8b 74 24 18          	mov    0x18(%esp),%esi
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
40000c0c:	0f b6 0a             	movzbl (%edx),%ecx
40000c0f:	80 f9 20             	cmp    $0x20,%cl
40000c12:	0f 85 e6 00 00 00    	jne    40000cfe <strtol+0xfe>
		s++;
40000c18:	83 c2 01             	add    $0x1,%edx
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
40000c1b:	0f b6 0a             	movzbl (%edx),%ecx
40000c1e:	80 f9 09             	cmp    $0x9,%cl
40000c21:	74 f5                	je     40000c18 <strtol+0x18>
40000c23:	80 f9 20             	cmp    $0x20,%cl
40000c26:	74 f0                	je     40000c18 <strtol+0x18>
		s++;

	// plus/minus sign
	if (*s == '+')
40000c28:	80 f9 2b             	cmp    $0x2b,%cl
40000c2b:	0f 84 8f 00 00 00    	je     40000cc0 <strtol+0xc0>


long
strtol(const char *s, char **endptr, int base)
{
	int neg = 0;
40000c31:	31 ff                	xor    %edi,%edi
		s++;

	// plus/minus sign
	if (*s == '+')
		s++;
	else if (*s == '-')
40000c33:	80 f9 2d             	cmp    $0x2d,%cl
40000c36:	0f 84 94 00 00 00    	je     40000cd0 <strtol+0xd0>
		s++, neg = 1;

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000c3c:	f7 44 24 1c ef ff ff 	testl  $0xffffffef,0x1c(%esp)
40000c43:	ff 
40000c44:	0f be 0a             	movsbl (%edx),%ecx
40000c47:	75 19                	jne    40000c62 <strtol+0x62>
40000c49:	80 f9 30             	cmp    $0x30,%cl
40000c4c:	0f 84 8a 00 00 00    	je     40000cdc <strtol+0xdc>
		s += 2, base = 16;
	else if (base == 0 && s[0] == '0')
40000c52:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
40000c56:	85 db                	test   %ebx,%ebx
40000c58:	75 08                	jne    40000c62 <strtol+0x62>
		s++, base = 8;
	else if (base == 0)
		base = 10;
40000c5a:	c7 44 24 1c 0a 00 00 	movl   $0xa,0x1c(%esp)
40000c61:	00 
		s++;
	else if (*s == '-')
		s++, neg = 1;

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000c62:	31 db                	xor    %ebx,%ebx
40000c64:	eb 18                	jmp    40000c7e <strtol+0x7e>
40000c66:	66 90                	xchg   %ax,%ax
	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
			dig = *s - '0';
40000c68:	83 e9 30             	sub    $0x30,%ecx
			dig = *s - 'a' + 10;
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
40000c6b:	3b 4c 24 1c          	cmp    0x1c(%esp),%ecx
40000c6f:	7d 28                	jge    40000c99 <strtol+0x99>
			break;
		s++, val = (val * base) + dig;
40000c71:	0f af 5c 24 1c       	imul   0x1c(%esp),%ebx
40000c76:	83 c2 01             	add    $0x1,%edx
40000c79:	01 cb                	add    %ecx,%ebx
40000c7b:	0f be 0a             	movsbl (%edx),%ecx

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
40000c7e:	8d 69 d0             	lea    -0x30(%ecx),%ebp
40000c81:	89 e8                	mov    %ebp,%eax
40000c83:	3c 09                	cmp    $0x9,%al
40000c85:	76 e1                	jbe    40000c68 <strtol+0x68>
			dig = *s - '0';
		else if (*s >= 'a' && *s <= 'z')
40000c87:	8d 69 9f             	lea    -0x61(%ecx),%ebp
40000c8a:	89 e8                	mov    %ebp,%eax
40000c8c:	3c 19                	cmp    $0x19,%al
40000c8e:	77 20                	ja     40000cb0 <strtol+0xb0>
			dig = *s - 'a' + 10;
40000c90:	83 e9 57             	sub    $0x57,%ecx
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
40000c93:	3b 4c 24 1c          	cmp    0x1c(%esp),%ecx
40000c97:	7c d8                	jl     40000c71 <strtol+0x71>
			break;
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
40000c99:	85 f6                	test   %esi,%esi
40000c9b:	74 02                	je     40000c9f <strtol+0x9f>
		*endptr = (char *) s;
40000c9d:	89 16                	mov    %edx,(%esi)
	return (neg ? -val : val);
40000c9f:	89 d8                	mov    %ebx,%eax
40000ca1:	f7 d8                	neg    %eax
40000ca3:	85 ff                	test   %edi,%edi
40000ca5:	0f 44 c3             	cmove  %ebx,%eax
}
40000ca8:	5b                   	pop    %ebx
40000ca9:	5e                   	pop    %esi
40000caa:	5f                   	pop    %edi
40000cab:	5d                   	pop    %ebp
40000cac:	c3                   	ret    
40000cad:	8d 76 00             	lea    0x0(%esi),%esi

		if (*s >= '0' && *s <= '9')
			dig = *s - '0';
		else if (*s >= 'a' && *s <= 'z')
			dig = *s - 'a' + 10;
		else if (*s >= 'A' && *s <= 'Z')
40000cb0:	8d 69 bf             	lea    -0x41(%ecx),%ebp
40000cb3:	89 e8                	mov    %ebp,%eax
40000cb5:	3c 19                	cmp    $0x19,%al
40000cb7:	77 e0                	ja     40000c99 <strtol+0x99>
			dig = *s - 'A' + 10;
40000cb9:	83 e9 37             	sub    $0x37,%ecx
40000cbc:	eb ad                	jmp    40000c6b <strtol+0x6b>
40000cbe:	66 90                	xchg   %ax,%ax
	while (*s == ' ' || *s == '\t')
		s++;

	// plus/minus sign
	if (*s == '+')
		s++;
40000cc0:	83 c2 01             	add    $0x1,%edx


long
strtol(const char *s, char **endptr, int base)
{
	int neg = 0;
40000cc3:	31 ff                	xor    %edi,%edi
40000cc5:	e9 72 ff ff ff       	jmp    40000c3c <strtol+0x3c>
40000cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

	// plus/minus sign
	if (*s == '+')
		s++;
	else if (*s == '-')
		s++, neg = 1;
40000cd0:	83 c2 01             	add    $0x1,%edx
40000cd3:	66 bf 01 00          	mov    $0x1,%di
40000cd7:	e9 60 ff ff ff       	jmp    40000c3c <strtol+0x3c>

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000cdc:	80 7a 01 78          	cmpb   $0x78,0x1(%edx)
40000ce0:	74 2a                	je     40000d0c <strtol+0x10c>
		s += 2, base = 16;
	else if (base == 0 && s[0] == '0')
40000ce2:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000ce6:	85 c0                	test   %eax,%eax
40000ce8:	75 36                	jne    40000d20 <strtol+0x120>
40000cea:	0f be 4a 01          	movsbl 0x1(%edx),%ecx
		s++, base = 8;
40000cee:	83 c2 01             	add    $0x1,%edx
40000cf1:	c7 44 24 1c 08 00 00 	movl   $0x8,0x1c(%esp)
40000cf8:	00 
40000cf9:	e9 64 ff ff ff       	jmp    40000c62 <strtol+0x62>
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
40000cfe:	80 f9 09             	cmp    $0x9,%cl
40000d01:	0f 84 11 ff ff ff    	je     40000c18 <strtol+0x18>
40000d07:	e9 1c ff ff ff       	jmp    40000c28 <strtol+0x28>
40000d0c:	0f be 4a 02          	movsbl 0x2(%edx),%ecx
	else if (*s == '-')
		s++, neg = 1;

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
		s += 2, base = 16;
40000d10:	83 c2 02             	add    $0x2,%edx
40000d13:	c7 44 24 1c 10 00 00 	movl   $0x10,0x1c(%esp)
40000d1a:	00 
40000d1b:	e9 42 ff ff ff       	jmp    40000c62 <strtol+0x62>
		s++;
	else if (*s == '-')
		s++, neg = 1;

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000d20:	b9 30 00 00 00       	mov    $0x30,%ecx
40000d25:	e9 38 ff ff ff       	jmp    40000c62 <strtol+0x62>
40000d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000d30 <memset>:
	return (neg ? -val : val);
}

void *
memset(void *v, int c, size_t n)
{
40000d30:	57                   	push   %edi
40000d31:	56                   	push   %esi
40000d32:	53                   	push   %ebx
40000d33:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000d37:	8b 7c 24 10          	mov    0x10(%esp),%edi
	if (n == 0)
40000d3b:	85 c9                	test   %ecx,%ecx
40000d3d:	74 14                	je     40000d53 <memset+0x23>
		return v;
	if ((int)v%4 == 0 && n%4 == 0) {
40000d3f:	f7 c7 03 00 00 00    	test   $0x3,%edi
40000d45:	75 05                	jne    40000d4c <memset+0x1c>
40000d47:	f6 c1 03             	test   $0x3,%cl
40000d4a:	74 14                	je     40000d60 <memset+0x30>
		c = (c<<24)|(c<<16)|(c<<8)|c;
		asm volatile("cld; rep stosl\n"
			     :: "D" (v), "a" (c), "c" (n/4)
			     : "cc", "memory");
	} else
		asm volatile("cld; rep stosb\n"
40000d4c:	8b 44 24 14          	mov    0x14(%esp),%eax
40000d50:	fc                   	cld    
40000d51:	f3 aa                	rep stos %al,%es:(%edi)
			     :: "D" (v), "a" (c), "c" (n)
			     : "cc", "memory");
	return v;
}
40000d53:	89 f8                	mov    %edi,%eax
40000d55:	5b                   	pop    %ebx
40000d56:	5e                   	pop    %esi
40000d57:	5f                   	pop    %edi
40000d58:	c3                   	ret    
40000d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
memset(void *v, int c, size_t n)
{
	if (n == 0)
		return v;
	if ((int)v%4 == 0 && n%4 == 0) {
		c &= 0xFF;
40000d60:	0f b6 54 24 14       	movzbl 0x14(%esp),%edx
		c = (c<<24)|(c<<16)|(c<<8)|c;
		asm volatile("cld; rep stosl\n"
			     :: "D" (v), "a" (c), "c" (n/4)
40000d65:	c1 e9 02             	shr    $0x2,%ecx
{
	if (n == 0)
		return v;
	if ((int)v%4 == 0 && n%4 == 0) {
		c &= 0xFF;
		c = (c<<24)|(c<<16)|(c<<8)|c;
40000d68:	89 d0                	mov    %edx,%eax
40000d6a:	89 d6                	mov    %edx,%esi
40000d6c:	c1 e0 18             	shl    $0x18,%eax
40000d6f:	89 d3                	mov    %edx,%ebx
40000d71:	c1 e6 10             	shl    $0x10,%esi
40000d74:	09 f0                	or     %esi,%eax
40000d76:	c1 e3 08             	shl    $0x8,%ebx
40000d79:	09 d0                	or     %edx,%eax
40000d7b:	09 d8                	or     %ebx,%eax
		asm volatile("cld; rep stosl\n"
40000d7d:	fc                   	cld    
40000d7e:	f3 ab                	rep stos %eax,%es:(%edi)
	} else
		asm volatile("cld; rep stosb\n"
			     :: "D" (v), "a" (c), "c" (n)
			     : "cc", "memory");
	return v;
}
40000d80:	89 f8                	mov    %edi,%eax
40000d82:	5b                   	pop    %ebx
40000d83:	5e                   	pop    %esi
40000d84:	5f                   	pop    %edi
40000d85:	c3                   	ret    
40000d86:	8d 76 00             	lea    0x0(%esi),%esi
40000d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000d90 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
40000d90:	57                   	push   %edi
40000d91:	56                   	push   %esi
40000d92:	8b 44 24 0c          	mov    0xc(%esp),%eax
40000d96:	8b 74 24 10          	mov    0x10(%esp),%esi
40000d9a:	8b 4c 24 14          	mov    0x14(%esp),%ecx
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
40000d9e:	39 c6                	cmp    %eax,%esi
40000da0:	73 26                	jae    40000dc8 <memmove+0x38>
40000da2:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
40000da5:	39 d0                	cmp    %edx,%eax
40000da7:	73 1f                	jae    40000dc8 <memmove+0x38>
		s += n;
		d += n;
40000da9:	8d 3c 08             	lea    (%eax,%ecx,1),%edi
40000dac:	89 d6                	mov    %edx,%esi
40000dae:	09 fe                	or     %edi,%esi
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
40000db0:	83 e6 03             	and    $0x3,%esi
40000db3:	74 33                	je     40000de8 <memmove+0x58>
			asm volatile("std; rep movsl\n"
				     :: "D" (d-4), "S" (s-4), "c" (n/4)
				     : "cc", "memory");
		else
			asm volatile("std; rep movsb\n"
				     :: "D" (d-1), "S" (s-1), "c" (n)
40000db5:	83 ef 01             	sub    $0x1,%edi
40000db8:	8d 72 ff             	lea    -0x1(%edx),%esi
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
			asm volatile("std; rep movsl\n"
				     :: "D" (d-4), "S" (s-4), "c" (n/4)
				     : "cc", "memory");
		else
			asm volatile("std; rep movsb\n"
40000dbb:	fd                   	std    
40000dbc:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
				     :: "D" (d-1), "S" (s-1), "c" (n)
				     : "cc", "memory");
		// Some versions of GCC rely on DF being clear
		asm volatile("cld" ::: "cc");
40000dbe:	fc                   	cld    
			asm volatile("cld; rep movsb\n"
				     :: "D" (d), "S" (s), "c" (n)
				     : "cc", "memory");
	}
	return dst;
}
40000dbf:	5e                   	pop    %esi
40000dc0:	5f                   	pop    %edi
40000dc1:	c3                   	ret    
40000dc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000dc8:	89 f2                	mov    %esi,%edx
40000dca:	09 c2                	or     %eax,%edx
				     :: "D" (d-1), "S" (s-1), "c" (n)
				     : "cc", "memory");
		// Some versions of GCC rely on DF being clear
		asm volatile("cld" ::: "cc");
	} else {
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
40000dcc:	83 e2 03             	and    $0x3,%edx
40000dcf:	75 0f                	jne    40000de0 <memmove+0x50>
40000dd1:	f6 c1 03             	test   $0x3,%cl
40000dd4:	75 0a                	jne    40000de0 <memmove+0x50>
			asm volatile("cld; rep movsl\n"
				     :: "D" (d), "S" (s), "c" (n/4)
40000dd6:	c1 e9 02             	shr    $0x2,%ecx
				     : "cc", "memory");
		// Some versions of GCC rely on DF being clear
		asm volatile("cld" ::: "cc");
	} else {
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
			asm volatile("cld; rep movsl\n"
40000dd9:	89 c7                	mov    %eax,%edi
40000ddb:	fc                   	cld    
40000ddc:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000dde:	eb 05                	jmp    40000de5 <memmove+0x55>
				     :: "D" (d), "S" (s), "c" (n/4)
				     : "cc", "memory");
		else
			asm volatile("cld; rep movsb\n"
40000de0:	89 c7                	mov    %eax,%edi
40000de2:	fc                   	cld    
40000de3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
				     :: "D" (d), "S" (s), "c" (n)
				     : "cc", "memory");
	}
	return dst;
}
40000de5:	5e                   	pop    %esi
40000de6:	5f                   	pop    %edi
40000de7:	c3                   	ret    
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
40000de8:	f6 c1 03             	test   $0x3,%cl
40000deb:	75 c8                	jne    40000db5 <memmove+0x25>
			asm volatile("std; rep movsl\n"
				     :: "D" (d-4), "S" (s-4), "c" (n/4)
40000ded:	83 ef 04             	sub    $0x4,%edi
40000df0:	8d 72 fc             	lea    -0x4(%edx),%esi
40000df3:	c1 e9 02             	shr    $0x2,%ecx
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
			asm volatile("std; rep movsl\n"
40000df6:	fd                   	std    
40000df7:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000df9:	eb c3                	jmp    40000dbe <memmove+0x2e>
40000dfb:	90                   	nop
40000dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000e00 <memcpy>:
}

void *
memcpy(void *dst, const void *src, size_t n)
{
	return memmove(dst, src, n);
40000e00:	eb 8e                	jmp    40000d90 <memmove>
40000e02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000e10 <memcmp>:
}

int
memcmp(const void *v1, const void *v2, size_t n)
{
40000e10:	57                   	push   %edi
40000e11:	56                   	push   %esi
40000e12:	53                   	push   %ebx
40000e13:	8b 44 24 18          	mov    0x18(%esp),%eax
40000e17:	8b 5c 24 10          	mov    0x10(%esp),%ebx
40000e1b:	8b 74 24 14          	mov    0x14(%esp),%esi
	const uint8_t *s1 = (const uint8_t *) v1;
	const uint8_t *s2 = (const uint8_t *) v2;

	while (n-- > 0) {
40000e1f:	85 c0                	test   %eax,%eax
40000e21:	8d 78 ff             	lea    -0x1(%eax),%edi
40000e24:	74 26                	je     40000e4c <memcmp+0x3c>
		if (*s1 != *s2)
40000e26:	0f b6 03             	movzbl (%ebx),%eax
40000e29:	31 d2                	xor    %edx,%edx
40000e2b:	0f b6 0e             	movzbl (%esi),%ecx
40000e2e:	38 c8                	cmp    %cl,%al
40000e30:	74 16                	je     40000e48 <memcmp+0x38>
40000e32:	eb 24                	jmp    40000e58 <memcmp+0x48>
40000e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000e38:	0f b6 44 13 01       	movzbl 0x1(%ebx,%edx,1),%eax
40000e3d:	83 c2 01             	add    $0x1,%edx
40000e40:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
40000e44:	38 c8                	cmp    %cl,%al
40000e46:	75 10                	jne    40000e58 <memcmp+0x48>
memcmp(const void *v1, const void *v2, size_t n)
{
	const uint8_t *s1 = (const uint8_t *) v1;
	const uint8_t *s2 = (const uint8_t *) v2;

	while (n-- > 0) {
40000e48:	39 fa                	cmp    %edi,%edx
40000e4a:	75 ec                	jne    40000e38 <memcmp+0x28>
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
}
40000e4c:	5b                   	pop    %ebx
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
40000e4d:	31 c0                	xor    %eax,%eax
}
40000e4f:	5e                   	pop    %esi
40000e50:	5f                   	pop    %edi
40000e51:	c3                   	ret    
40000e52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000e58:	5b                   	pop    %ebx
	const uint8_t *s1 = (const uint8_t *) v1;
	const uint8_t *s2 = (const uint8_t *) v2;

	while (n-- > 0) {
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
40000e59:	29 c8                	sub    %ecx,%eax
		s1++, s2++;
	}

	return 0;
}
40000e5b:	5e                   	pop    %esi
40000e5c:	5f                   	pop    %edi
40000e5d:	c3                   	ret    
40000e5e:	66 90                	xchg   %ax,%ax

40000e60 <memchr>:

void *
memchr(const void *s, int c, size_t n)
{
40000e60:	53                   	push   %ebx
40000e61:	8b 44 24 08          	mov    0x8(%esp),%eax
	const void *ends = (const char *) s + n;
40000e65:	8b 54 24 10          	mov    0x10(%esp),%edx
	return 0;
}

void *
memchr(const void *s, int c, size_t n)
{
40000e69:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
	const void *ends = (const char *) s + n;
40000e6d:	01 c2                	add    %eax,%edx
	for (; s < ends; s++)
40000e6f:	39 d0                	cmp    %edx,%eax
40000e71:	73 18                	jae    40000e8b <memchr+0x2b>
		if (*(const unsigned char *) s == (unsigned char) c)
40000e73:	38 18                	cmp    %bl,(%eax)
40000e75:	89 d9                	mov    %ebx,%ecx
40000e77:	75 0b                	jne    40000e84 <memchr+0x24>
40000e79:	eb 12                	jmp    40000e8d <memchr+0x2d>
40000e7b:	90                   	nop
40000e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000e80:	38 08                	cmp    %cl,(%eax)
40000e82:	74 09                	je     40000e8d <memchr+0x2d>

void *
memchr(const void *s, int c, size_t n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
40000e84:	83 c0 01             	add    $0x1,%eax
40000e87:	39 d0                	cmp    %edx,%eax
40000e89:	75 f5                	jne    40000e80 <memchr+0x20>
		if (*(const unsigned char *) s == (unsigned char) c)
			return (void *) s;
	return NULL;
40000e8b:	31 c0                	xor    %eax,%eax
}
40000e8d:	5b                   	pop    %ebx
40000e8e:	c3                   	ret    
40000e8f:	90                   	nop

40000e90 <memzero>:

void *
memzero(void *v, size_t n)
{
40000e90:	83 ec 0c             	sub    $0xc,%esp
	return memset(v, 0, n);
40000e93:	8b 44 24 14          	mov    0x14(%esp),%eax
40000e97:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
40000e9e:	00 
40000e9f:	89 44 24 08          	mov    %eax,0x8(%esp)
40000ea3:	8b 44 24 10          	mov    0x10(%esp),%eax
40000ea7:	89 04 24             	mov    %eax,(%esp)
40000eaa:	e8 81 fe ff ff       	call   40000d30 <memset>
}
40000eaf:	83 c4 0c             	add    $0xc,%esp
40000eb2:	c3                   	ret    
40000eb3:	66 90                	xchg   %ax,%ax
40000eb5:	66 90                	xchg   %ax,%ax
40000eb7:	66 90                	xchg   %ax,%ax
40000eb9:	66 90                	xchg   %ax,%ax
40000ebb:	66 90                	xchg   %ax,%ax
40000ebd:	66 90                	xchg   %ax,%ax
40000ebf:	90                   	nop

40000ec0 <__udivdi3>:
40000ec0:	55                   	push   %ebp
40000ec1:	57                   	push   %edi
40000ec2:	56                   	push   %esi
40000ec3:	83 ec 0c             	sub    $0xc,%esp
40000ec6:	8b 44 24 28          	mov    0x28(%esp),%eax
40000eca:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
40000ece:	8b 6c 24 20          	mov    0x20(%esp),%ebp
40000ed2:	8b 4c 24 24          	mov    0x24(%esp),%ecx
40000ed6:	85 c0                	test   %eax,%eax
40000ed8:	89 7c 24 04          	mov    %edi,0x4(%esp)
40000edc:	89 ea                	mov    %ebp,%edx
40000ede:	89 0c 24             	mov    %ecx,(%esp)
40000ee1:	75 2d                	jne    40000f10 <__udivdi3+0x50>
40000ee3:	39 e9                	cmp    %ebp,%ecx
40000ee5:	77 61                	ja     40000f48 <__udivdi3+0x88>
40000ee7:	85 c9                	test   %ecx,%ecx
40000ee9:	89 ce                	mov    %ecx,%esi
40000eeb:	75 0b                	jne    40000ef8 <__udivdi3+0x38>
40000eed:	b8 01 00 00 00       	mov    $0x1,%eax
40000ef2:	31 d2                	xor    %edx,%edx
40000ef4:	f7 f1                	div    %ecx
40000ef6:	89 c6                	mov    %eax,%esi
40000ef8:	31 d2                	xor    %edx,%edx
40000efa:	89 e8                	mov    %ebp,%eax
40000efc:	f7 f6                	div    %esi
40000efe:	89 c5                	mov    %eax,%ebp
40000f00:	89 f8                	mov    %edi,%eax
40000f02:	f7 f6                	div    %esi
40000f04:	89 ea                	mov    %ebp,%edx
40000f06:	83 c4 0c             	add    $0xc,%esp
40000f09:	5e                   	pop    %esi
40000f0a:	5f                   	pop    %edi
40000f0b:	5d                   	pop    %ebp
40000f0c:	c3                   	ret    
40000f0d:	8d 76 00             	lea    0x0(%esi),%esi
40000f10:	39 e8                	cmp    %ebp,%eax
40000f12:	77 24                	ja     40000f38 <__udivdi3+0x78>
40000f14:	0f bd e8             	bsr    %eax,%ebp
40000f17:	83 f5 1f             	xor    $0x1f,%ebp
40000f1a:	75 3c                	jne    40000f58 <__udivdi3+0x98>
40000f1c:	8b 74 24 04          	mov    0x4(%esp),%esi
40000f20:	39 34 24             	cmp    %esi,(%esp)
40000f23:	0f 86 9f 00 00 00    	jbe    40000fc8 <__udivdi3+0x108>
40000f29:	39 d0                	cmp    %edx,%eax
40000f2b:	0f 82 97 00 00 00    	jb     40000fc8 <__udivdi3+0x108>
40000f31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000f38:	31 d2                	xor    %edx,%edx
40000f3a:	31 c0                	xor    %eax,%eax
40000f3c:	83 c4 0c             	add    $0xc,%esp
40000f3f:	5e                   	pop    %esi
40000f40:	5f                   	pop    %edi
40000f41:	5d                   	pop    %ebp
40000f42:	c3                   	ret    
40000f43:	90                   	nop
40000f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000f48:	89 f8                	mov    %edi,%eax
40000f4a:	f7 f1                	div    %ecx
40000f4c:	31 d2                	xor    %edx,%edx
40000f4e:	83 c4 0c             	add    $0xc,%esp
40000f51:	5e                   	pop    %esi
40000f52:	5f                   	pop    %edi
40000f53:	5d                   	pop    %ebp
40000f54:	c3                   	ret    
40000f55:	8d 76 00             	lea    0x0(%esi),%esi
40000f58:	89 e9                	mov    %ebp,%ecx
40000f5a:	8b 3c 24             	mov    (%esp),%edi
40000f5d:	d3 e0                	shl    %cl,%eax
40000f5f:	89 c6                	mov    %eax,%esi
40000f61:	b8 20 00 00 00       	mov    $0x20,%eax
40000f66:	29 e8                	sub    %ebp,%eax
40000f68:	89 c1                	mov    %eax,%ecx
40000f6a:	d3 ef                	shr    %cl,%edi
40000f6c:	89 e9                	mov    %ebp,%ecx
40000f6e:	89 7c 24 08          	mov    %edi,0x8(%esp)
40000f72:	8b 3c 24             	mov    (%esp),%edi
40000f75:	09 74 24 08          	or     %esi,0x8(%esp)
40000f79:	89 d6                	mov    %edx,%esi
40000f7b:	d3 e7                	shl    %cl,%edi
40000f7d:	89 c1                	mov    %eax,%ecx
40000f7f:	89 3c 24             	mov    %edi,(%esp)
40000f82:	8b 7c 24 04          	mov    0x4(%esp),%edi
40000f86:	d3 ee                	shr    %cl,%esi
40000f88:	89 e9                	mov    %ebp,%ecx
40000f8a:	d3 e2                	shl    %cl,%edx
40000f8c:	89 c1                	mov    %eax,%ecx
40000f8e:	d3 ef                	shr    %cl,%edi
40000f90:	09 d7                	or     %edx,%edi
40000f92:	89 f2                	mov    %esi,%edx
40000f94:	89 f8                	mov    %edi,%eax
40000f96:	f7 74 24 08          	divl   0x8(%esp)
40000f9a:	89 d6                	mov    %edx,%esi
40000f9c:	89 c7                	mov    %eax,%edi
40000f9e:	f7 24 24             	mull   (%esp)
40000fa1:	39 d6                	cmp    %edx,%esi
40000fa3:	89 14 24             	mov    %edx,(%esp)
40000fa6:	72 30                	jb     40000fd8 <__udivdi3+0x118>
40000fa8:	8b 54 24 04          	mov    0x4(%esp),%edx
40000fac:	89 e9                	mov    %ebp,%ecx
40000fae:	d3 e2                	shl    %cl,%edx
40000fb0:	39 c2                	cmp    %eax,%edx
40000fb2:	73 05                	jae    40000fb9 <__udivdi3+0xf9>
40000fb4:	3b 34 24             	cmp    (%esp),%esi
40000fb7:	74 1f                	je     40000fd8 <__udivdi3+0x118>
40000fb9:	89 f8                	mov    %edi,%eax
40000fbb:	31 d2                	xor    %edx,%edx
40000fbd:	e9 7a ff ff ff       	jmp    40000f3c <__udivdi3+0x7c>
40000fc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000fc8:	31 d2                	xor    %edx,%edx
40000fca:	b8 01 00 00 00       	mov    $0x1,%eax
40000fcf:	e9 68 ff ff ff       	jmp    40000f3c <__udivdi3+0x7c>
40000fd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000fd8:	8d 47 ff             	lea    -0x1(%edi),%eax
40000fdb:	31 d2                	xor    %edx,%edx
40000fdd:	83 c4 0c             	add    $0xc,%esp
40000fe0:	5e                   	pop    %esi
40000fe1:	5f                   	pop    %edi
40000fe2:	5d                   	pop    %ebp
40000fe3:	c3                   	ret    
40000fe4:	66 90                	xchg   %ax,%ax
40000fe6:	66 90                	xchg   %ax,%ax
40000fe8:	66 90                	xchg   %ax,%ax
40000fea:	66 90                	xchg   %ax,%ax
40000fec:	66 90                	xchg   %ax,%ax
40000fee:	66 90                	xchg   %ax,%ax

40000ff0 <__umoddi3>:
40000ff0:	55                   	push   %ebp
40000ff1:	57                   	push   %edi
40000ff2:	56                   	push   %esi
40000ff3:	83 ec 14             	sub    $0x14,%esp
40000ff6:	8b 44 24 28          	mov    0x28(%esp),%eax
40000ffa:	8b 4c 24 24          	mov    0x24(%esp),%ecx
40000ffe:	8b 74 24 2c          	mov    0x2c(%esp),%esi
40001002:	89 c7                	mov    %eax,%edi
40001004:	89 44 24 04          	mov    %eax,0x4(%esp)
40001008:	8b 44 24 30          	mov    0x30(%esp),%eax
4000100c:	89 4c 24 10          	mov    %ecx,0x10(%esp)
40001010:	89 34 24             	mov    %esi,(%esp)
40001013:	89 4c 24 08          	mov    %ecx,0x8(%esp)
40001017:	85 c0                	test   %eax,%eax
40001019:	89 c2                	mov    %eax,%edx
4000101b:	89 7c 24 0c          	mov    %edi,0xc(%esp)
4000101f:	75 17                	jne    40001038 <__umoddi3+0x48>
40001021:	39 fe                	cmp    %edi,%esi
40001023:	76 4b                	jbe    40001070 <__umoddi3+0x80>
40001025:	89 c8                	mov    %ecx,%eax
40001027:	89 fa                	mov    %edi,%edx
40001029:	f7 f6                	div    %esi
4000102b:	89 d0                	mov    %edx,%eax
4000102d:	31 d2                	xor    %edx,%edx
4000102f:	83 c4 14             	add    $0x14,%esp
40001032:	5e                   	pop    %esi
40001033:	5f                   	pop    %edi
40001034:	5d                   	pop    %ebp
40001035:	c3                   	ret    
40001036:	66 90                	xchg   %ax,%ax
40001038:	39 f8                	cmp    %edi,%eax
4000103a:	77 54                	ja     40001090 <__umoddi3+0xa0>
4000103c:	0f bd e8             	bsr    %eax,%ebp
4000103f:	83 f5 1f             	xor    $0x1f,%ebp
40001042:	75 5c                	jne    400010a0 <__umoddi3+0xb0>
40001044:	8b 7c 24 08          	mov    0x8(%esp),%edi
40001048:	39 3c 24             	cmp    %edi,(%esp)
4000104b:	0f 87 e7 00 00 00    	ja     40001138 <__umoddi3+0x148>
40001051:	8b 7c 24 04          	mov    0x4(%esp),%edi
40001055:	29 f1                	sub    %esi,%ecx
40001057:	19 c7                	sbb    %eax,%edi
40001059:	89 4c 24 08          	mov    %ecx,0x8(%esp)
4000105d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
40001061:	8b 44 24 08          	mov    0x8(%esp),%eax
40001065:	8b 54 24 0c          	mov    0xc(%esp),%edx
40001069:	83 c4 14             	add    $0x14,%esp
4000106c:	5e                   	pop    %esi
4000106d:	5f                   	pop    %edi
4000106e:	5d                   	pop    %ebp
4000106f:	c3                   	ret    
40001070:	85 f6                	test   %esi,%esi
40001072:	89 f5                	mov    %esi,%ebp
40001074:	75 0b                	jne    40001081 <__umoddi3+0x91>
40001076:	b8 01 00 00 00       	mov    $0x1,%eax
4000107b:	31 d2                	xor    %edx,%edx
4000107d:	f7 f6                	div    %esi
4000107f:	89 c5                	mov    %eax,%ebp
40001081:	8b 44 24 04          	mov    0x4(%esp),%eax
40001085:	31 d2                	xor    %edx,%edx
40001087:	f7 f5                	div    %ebp
40001089:	89 c8                	mov    %ecx,%eax
4000108b:	f7 f5                	div    %ebp
4000108d:	eb 9c                	jmp    4000102b <__umoddi3+0x3b>
4000108f:	90                   	nop
40001090:	89 c8                	mov    %ecx,%eax
40001092:	89 fa                	mov    %edi,%edx
40001094:	83 c4 14             	add    $0x14,%esp
40001097:	5e                   	pop    %esi
40001098:	5f                   	pop    %edi
40001099:	5d                   	pop    %ebp
4000109a:	c3                   	ret    
4000109b:	90                   	nop
4000109c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400010a0:	8b 04 24             	mov    (%esp),%eax
400010a3:	be 20 00 00 00       	mov    $0x20,%esi
400010a8:	89 e9                	mov    %ebp,%ecx
400010aa:	29 ee                	sub    %ebp,%esi
400010ac:	d3 e2                	shl    %cl,%edx
400010ae:	89 f1                	mov    %esi,%ecx
400010b0:	d3 e8                	shr    %cl,%eax
400010b2:	89 e9                	mov    %ebp,%ecx
400010b4:	89 44 24 04          	mov    %eax,0x4(%esp)
400010b8:	8b 04 24             	mov    (%esp),%eax
400010bb:	09 54 24 04          	or     %edx,0x4(%esp)
400010bf:	89 fa                	mov    %edi,%edx
400010c1:	d3 e0                	shl    %cl,%eax
400010c3:	89 f1                	mov    %esi,%ecx
400010c5:	89 44 24 08          	mov    %eax,0x8(%esp)
400010c9:	8b 44 24 10          	mov    0x10(%esp),%eax
400010cd:	d3 ea                	shr    %cl,%edx
400010cf:	89 e9                	mov    %ebp,%ecx
400010d1:	d3 e7                	shl    %cl,%edi
400010d3:	89 f1                	mov    %esi,%ecx
400010d5:	d3 e8                	shr    %cl,%eax
400010d7:	89 e9                	mov    %ebp,%ecx
400010d9:	09 f8                	or     %edi,%eax
400010db:	8b 7c 24 10          	mov    0x10(%esp),%edi
400010df:	f7 74 24 04          	divl   0x4(%esp)
400010e3:	d3 e7                	shl    %cl,%edi
400010e5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
400010e9:	89 d7                	mov    %edx,%edi
400010eb:	f7 64 24 08          	mull   0x8(%esp)
400010ef:	39 d7                	cmp    %edx,%edi
400010f1:	89 c1                	mov    %eax,%ecx
400010f3:	89 14 24             	mov    %edx,(%esp)
400010f6:	72 2c                	jb     40001124 <__umoddi3+0x134>
400010f8:	39 44 24 0c          	cmp    %eax,0xc(%esp)
400010fc:	72 22                	jb     40001120 <__umoddi3+0x130>
400010fe:	8b 44 24 0c          	mov    0xc(%esp),%eax
40001102:	29 c8                	sub    %ecx,%eax
40001104:	19 d7                	sbb    %edx,%edi
40001106:	89 e9                	mov    %ebp,%ecx
40001108:	89 fa                	mov    %edi,%edx
4000110a:	d3 e8                	shr    %cl,%eax
4000110c:	89 f1                	mov    %esi,%ecx
4000110e:	d3 e2                	shl    %cl,%edx
40001110:	89 e9                	mov    %ebp,%ecx
40001112:	d3 ef                	shr    %cl,%edi
40001114:	09 d0                	or     %edx,%eax
40001116:	89 fa                	mov    %edi,%edx
40001118:	83 c4 14             	add    $0x14,%esp
4000111b:	5e                   	pop    %esi
4000111c:	5f                   	pop    %edi
4000111d:	5d                   	pop    %ebp
4000111e:	c3                   	ret    
4000111f:	90                   	nop
40001120:	39 d7                	cmp    %edx,%edi
40001122:	75 da                	jne    400010fe <__umoddi3+0x10e>
40001124:	8b 14 24             	mov    (%esp),%edx
40001127:	89 c1                	mov    %eax,%ecx
40001129:	2b 4c 24 08          	sub    0x8(%esp),%ecx
4000112d:	1b 54 24 04          	sbb    0x4(%esp),%edx
40001131:	eb cb                	jmp    400010fe <__umoddi3+0x10e>
40001133:	90                   	nop
40001134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40001138:	3b 44 24 0c          	cmp    0xc(%esp),%eax
4000113c:	0f 82 0f ff ff ff    	jb     40001051 <__umoddi3+0x61>
40001142:	e9 1a ff ff ff       	jmp    40001061 <__umoddi3+0x71>
