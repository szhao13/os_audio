
obj/user/fstest/fstest:     file format elf32-i386


Disassembly of section .text:

40000000 <main>:
}


int
main(int argc, char *argv[])
{
40000000:	55                   	push   %ebp
40000001:	89 e5                	mov    %esp,%ebp
40000003:	56                   	push   %esi
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40000004:	be 99 33 00 40       	mov    $0x40003399,%esi
40000009:	53                   	push   %ebx
4000000a:	89 f3                	mov    %esi,%ebx
4000000c:	83 e4 f0             	and    $0xfffffff0,%esp
4000000f:	83 ec 10             	sub    $0x10,%esp
  printf("*******usertests starting*******\n\n");
40000012:	c7 04 24 50 38 00 40 	movl   $0x40003850,(%esp)
40000019:	e8 b2 02 00 00       	call   400002d0 <printf>

  printf("=====test file usertests.ran does not exists=====\n");
4000001e:	c7 04 24 74 38 00 40 	movl   $0x40003874,(%esp)
40000025:	e8 a6 02 00 00       	call   400002d0 <printf>
4000002a:	31 c9                	xor    %ecx,%ecx
4000002c:	b8 05 00 00 00       	mov    $0x5,%eax
40000031:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40000033:	85 c0                	test   %eax,%eax
40000035:	0f 84 7d 00 00 00    	je     400000b8 <main+0xb8>

  if(open("usertests.ran", O_RDONLY) >= 0){
    printf("already ran user tests (file usertests.ran exists) -- recreate certikos_disk.img\n");
    exit();
  }
  printf("=====test file usertests.ran does not exists: ok\n\n");
4000003b:	c7 04 24 fc 38 00 40 	movl   $0x400038fc,(%esp)
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40000042:	89 f3                	mov    %esi,%ebx
40000044:	e8 87 02 00 00       	call   400002d0 <printf>
40000049:	b9 00 02 00 00       	mov    $0x200,%ecx
4000004e:	b8 05 00 00 00       	mov    $0x5,%eax
40000053:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40000055:	83 ca ff             	or     $0xffffffff,%edx
40000058:	85 c0                	test   %eax,%eax
4000005a:	0f 44 d3             	cmove  %ebx,%edx
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
4000005d:	b8 06 00 00 00       	mov    $0x6,%eax
40000062:	89 d3                	mov    %edx,%ebx
40000064:	cd 30                	int    $0x30
  close(open("usertests.ran", O_CREATE));

  smallfile();
40000066:	e8 d5 0e 00 00       	call   40000f40 <smallfile>
  bigfile1();
4000006b:	e8 60 10 00 00       	call   400010d0 <bigfile1>
  createtest();
40000070:	e8 1b 12 00 00       	call   40001290 <createtest>

  rmdot();
40000075:	e8 c6 12 00 00       	call   40001340 <rmdot>
  fourteen();
4000007a:	e8 11 14 00 00       	call   40001490 <fourteen>
4000007f:	90                   	nop
  bigfile2();
40000080:	e8 4b 15 00 00       	call   400015d0 <bigfile2>
  subdir();
40000085:	e8 36 17 00 00       	call   400017c0 <subdir>
  linktest();
4000008a:	e8 21 1d 00 00       	call   40001db0 <linktest>
4000008f:	90                   	nop
  unlinkread();
40000090:	e8 1b 1f 00 00       	call   40001fb0 <unlinkread>
  dirfile();
40000095:	e8 b6 20 00 00       	call   40002150 <dirfile>
  iref();
4000009a:	e8 91 22 00 00       	call   40002330 <iref>
4000009f:	90                   	nop
  bigdir(); // slow
400000a0:	e8 8b 23 00 00       	call   40002430 <bigdir>
  printf("*******end of tests*******\n");
400000a5:	c7 04 24 a7 33 00 40 	movl   $0x400033a7,(%esp)
400000ac:	e8 1f 02 00 00       	call   400002d0 <printf>
}
400000b1:	8d 65 f8             	lea    -0x8(%ebp),%esp
400000b4:	5b                   	pop    %ebx
400000b5:	5e                   	pop    %esi
400000b6:	5d                   	pop    %ebp
400000b7:	c3                   	ret    
{
  printf("*******usertests starting*******\n\n");

  printf("=====test file usertests.ran does not exists=====\n");

  if(open("usertests.ran", O_RDONLY) >= 0){
400000b8:	85 db                	test   %ebx,%ebx
400000ba:	0f 88 7b ff ff ff    	js     4000003b <main+0x3b>
    printf("already ran user tests (file usertests.ran exists) -- recreate certikos_disk.img\n");
400000c0:	c7 04 24 a8 38 00 40 	movl   $0x400038a8,(%esp)
400000c7:	e8 04 02 00 00       	call   400002d0 <printf>
    exit();
400000cc:	eb e3                	jmp    400000b1 <main+0xb1>

400000ce <_start>:
_start:
	/*
	 * If there are arguments on the stack, then the current stack will not
	 * be aligned to a nice big power-of-two boundary/
	 */
	testl	$0x0fffffff, %esp
400000ce:	f7 c4 ff ff ff 0f    	test   $0xfffffff,%esp
	jnz	args_exist
400000d4:	75 04                	jne    400000da <args_exist>

400000d6 <noargs>:

noargs:
	/* If no arguments are on the stack, push two dummy zero. */
	pushl	$0
400000d6:	6a 00                	push   $0x0
	pushl	$0
400000d8:	6a 00                	push   $0x0

400000da <args_exist>:

args_exist:
	/* Jump to the C part. */
	call	main
400000da:	e8 21 ff ff ff       	call   40000000 <main>

	/* When returning, push the return value on the stack. */
	pushl	%eax
400000df:	50                   	push   %eax

400000e0 <spin>:
spin:
	//call	yield
	jmp	spin
400000e0:	eb fe                	jmp    400000e0 <spin>
400000e2:	66 90                	xchg   %ax,%ax
400000e4:	66 90                	xchg   %ax,%ax
400000e6:	66 90                	xchg   %ax,%ax
400000e8:	66 90                	xchg   %ax,%ax
400000ea:	66 90                	xchg   %ax,%ax
400000ec:	66 90                	xchg   %ax,%ax
400000ee:	66 90                	xchg   %ax,%ax

400000f0 <debug>:
#include <stdarg.h>
#include <stdio.h>

void
debug(const char *file, int line, const char *fmt, ...)
{
400000f0:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	va_start(ap, fmt);
	printf("[D] %s:%d: ", file, line);
400000f3:	8b 44 24 24          	mov    0x24(%esp),%eax
400000f7:	c7 04 24 e8 27 00 40 	movl   $0x400027e8,(%esp)
400000fe:	89 44 24 08          	mov    %eax,0x8(%esp)
40000102:	8b 44 24 20          	mov    0x20(%esp),%eax
40000106:	89 44 24 04          	mov    %eax,0x4(%esp)
4000010a:	e8 c1 01 00 00       	call   400002d0 <printf>
	vcprintf(fmt, ap);
4000010f:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000113:	89 44 24 04          	mov    %eax,0x4(%esp)
40000117:	8b 44 24 28          	mov    0x28(%esp),%eax
4000011b:	89 04 24             	mov    %eax,(%esp)
4000011e:	e8 4d 01 00 00       	call   40000270 <vcprintf>
	va_end(ap);
}
40000123:	83 c4 1c             	add    $0x1c,%esp
40000126:	c3                   	ret    
40000127:	89 f6                	mov    %esi,%esi
40000129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000130 <warn>:

void
warn(const char *file, int line, const char *fmt, ...)
{
40000130:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	va_start(ap, fmt);
	printf("[W] %s:%d: ", file, line);
40000133:	8b 44 24 24          	mov    0x24(%esp),%eax
40000137:	c7 04 24 f4 27 00 40 	movl   $0x400027f4,(%esp)
4000013e:	89 44 24 08          	mov    %eax,0x8(%esp)
40000142:	8b 44 24 20          	mov    0x20(%esp),%eax
40000146:	89 44 24 04          	mov    %eax,0x4(%esp)
4000014a:	e8 81 01 00 00       	call   400002d0 <printf>
	vcprintf(fmt, ap);
4000014f:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000153:	89 44 24 04          	mov    %eax,0x4(%esp)
40000157:	8b 44 24 28          	mov    0x28(%esp),%eax
4000015b:	89 04 24             	mov    %eax,(%esp)
4000015e:	e8 0d 01 00 00       	call   40000270 <vcprintf>
	va_end(ap);
}
40000163:	83 c4 1c             	add    $0x1c,%esp
40000166:	c3                   	ret    
40000167:	89 f6                	mov    %esi,%esi
40000169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000170 <panic>:

void
panic(const char *file, int line, const char *fmt, ...)
{
40000170:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	va_start(ap, fmt);
	printf("[P] %s:%d: ", file, line);
40000173:	8b 44 24 24          	mov    0x24(%esp),%eax
40000177:	c7 04 24 00 28 00 40 	movl   $0x40002800,(%esp)
4000017e:	89 44 24 08          	mov    %eax,0x8(%esp)
40000182:	8b 44 24 20          	mov    0x20(%esp),%eax
40000186:	89 44 24 04          	mov    %eax,0x4(%esp)
4000018a:	e8 41 01 00 00       	call   400002d0 <printf>
	vcprintf(fmt, ap);
4000018f:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000193:	89 44 24 04          	mov    %eax,0x4(%esp)
40000197:	8b 44 24 28          	mov    0x28(%esp),%eax
4000019b:	89 04 24             	mov    %eax,(%esp)
4000019e:	e8 cd 00 00 00       	call   40000270 <vcprintf>
400001a3:	90                   	nop
400001a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	va_end(ap);

	while (1)
		yield();
400001a8:	e8 f3 07 00 00       	call   400009a0 <yield>
400001ad:	eb f9                	jmp    400001a8 <panic+0x38>
400001af:	90                   	nop

400001b0 <atoi>:
#include <stdlib.h>

int
atoi(const char *buf, int *i)
{
400001b0:	55                   	push   %ebp
400001b1:	57                   	push   %edi
400001b2:	56                   	push   %esi
400001b3:	53                   	push   %ebx
400001b4:	8b 74 24 14          	mov    0x14(%esp),%esi
	int loc = 0;
	int numstart = 0;
	int acc = 0;
	int negative = 0;
	if (buf[loc] == '+')
400001b8:	0f b6 06             	movzbl (%esi),%eax
400001bb:	3c 2b                	cmp    $0x2b,%al
400001bd:	74 51                	je     40000210 <atoi+0x60>
		loc++;
	else if (buf[loc] == '-') {
400001bf:	3c 2d                	cmp    $0x2d,%al
400001c1:	0f 94 c0             	sete   %al
400001c4:	0f b6 c0             	movzbl %al,%eax
400001c7:	89 c5                	mov    %eax,%ebp
400001c9:	89 c7                	mov    %eax,%edi
		negative = 1;
		loc++;
	}
	numstart = loc;
	// no grab the numbers
	while ('0' <= buf[loc] && buf[loc] <= '9') {
400001cb:	0f be 0c 06          	movsbl (%esi,%eax,1),%ecx
400001cf:	8d 41 d0             	lea    -0x30(%ecx),%eax
400001d2:	3c 09                	cmp    $0x9,%al
400001d4:	77 4a                	ja     40000220 <atoi+0x70>
400001d6:	89 f8                	mov    %edi,%eax
int
atoi(const char *buf, int *i)
{
	int loc = 0;
	int numstart = 0;
	int acc = 0;
400001d8:	31 d2                	xor    %edx,%edx
400001da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	}
	numstart = loc;
	// no grab the numbers
	while ('0' <= buf[loc] && buf[loc] <= '9') {
		acc = acc*10 + (buf[loc]-'0');
		loc++;
400001e0:	83 c0 01             	add    $0x1,%eax
		loc++;
	}
	numstart = loc;
	// no grab the numbers
	while ('0' <= buf[loc] && buf[loc] <= '9') {
		acc = acc*10 + (buf[loc]-'0');
400001e3:	8d 14 92             	lea    (%edx,%edx,4),%edx
400001e6:	8d 54 51 d0          	lea    -0x30(%ecx,%edx,2),%edx
		negative = 1;
		loc++;
	}
	numstart = loc;
	// no grab the numbers
	while ('0' <= buf[loc] && buf[loc] <= '9') {
400001ea:	0f be 0c 06          	movsbl (%esi,%eax,1),%ecx
400001ee:	8d 59 d0             	lea    -0x30(%ecx),%ebx
400001f1:	80 fb 09             	cmp    $0x9,%bl
400001f4:	76 ea                	jbe    400001e0 <atoi+0x30>
		acc = acc*10 + (buf[loc]-'0');
		loc++;
	}
	if (numstart == loc) {
400001f6:	39 c7                	cmp    %eax,%edi
400001f8:	74 26                	je     40000220 <atoi+0x70>
		// no numbers have actually been scanned
		return 0;
	}
	if (negative)
		acc = - acc;
400001fa:	89 d1                	mov    %edx,%ecx
400001fc:	f7 d9                	neg    %ecx
400001fe:	85 ed                	test   %ebp,%ebp
40000200:	0f 45 d1             	cmovne %ecx,%edx
	*i = acc;
40000203:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000207:	89 11                	mov    %edx,(%ecx)
	return loc;
}
40000209:	5b                   	pop    %ebx
4000020a:	5e                   	pop    %esi
4000020b:	5f                   	pop    %edi
4000020c:	5d                   	pop    %ebp
4000020d:	c3                   	ret    
4000020e:	66 90                	xchg   %ax,%ax
40000210:	b8 01 00 00 00       	mov    $0x1,%eax
atoi(const char *buf, int *i)
{
	int loc = 0;
	int numstart = 0;
	int acc = 0;
	int negative = 0;
40000215:	31 ed                	xor    %ebp,%ebp
	if (buf[loc] == '+')
		loc++;
40000217:	bf 01 00 00 00       	mov    $0x1,%edi
4000021c:	eb ad                	jmp    400001cb <atoi+0x1b>
4000021e:	66 90                	xchg   %ax,%ax
	}
	if (negative)
		acc = - acc;
	*i = acc;
	return loc;
}
40000220:	5b                   	pop    %ebx
		acc = acc*10 + (buf[loc]-'0');
		loc++;
	}
	if (numstart == loc) {
		// no numbers have actually been scanned
		return 0;
40000221:	31 c0                	xor    %eax,%eax
	}
	if (negative)
		acc = - acc;
	*i = acc;
	return loc;
}
40000223:	5e                   	pop    %esi
40000224:	5f                   	pop    %edi
40000225:	5d                   	pop    %ebp
40000226:	c3                   	ret    
40000227:	66 90                	xchg   %ax,%ax
40000229:	66 90                	xchg   %ax,%ax
4000022b:	66 90                	xchg   %ax,%ax
4000022d:	66 90                	xchg   %ax,%ax
4000022f:	90                   	nop

40000230 <putch>:
	char buf[MAX_BUF];
};

static void
putch(int ch, struct printbuf *b)
{
40000230:	53                   	push   %ebx
40000231:	8b 54 24 0c          	mov    0xc(%esp),%edx
	b->buf[b->idx++] = ch;
40000235:	0f b6 5c 24 08       	movzbl 0x8(%esp),%ebx
4000023a:	8b 0a                	mov    (%edx),%ecx
4000023c:	8d 41 01             	lea    0x1(%ecx),%eax
	if (b->idx == MAX_BUF-1) {
4000023f:	3d ff 0f 00 00       	cmp    $0xfff,%eax
};

static void
putch(int ch, struct printbuf *b)
{
	b->buf[b->idx++] = ch;
40000244:	89 02                	mov    %eax,(%edx)
40000246:	88 5c 0a 08          	mov    %bl,0x8(%edx,%ecx,1)
	if (b->idx == MAX_BUF-1) {
4000024a:	75 1a                	jne    40000266 <putch+0x36>
		b->buf[b->idx] = 0;
4000024c:	c6 82 07 10 00 00 00 	movb   $0x0,0x1007(%edx)
		puts(b->buf, b->idx);
40000253:	8d 5a 08             	lea    0x8(%edx),%ebx
#include <file.h>

static gcc_inline void
sys_puts(const char *s, size_t len)
{
	asm volatile("int %0" :
40000256:	b9 ff 0f 00 00       	mov    $0xfff,%ecx
4000025b:	66 31 c0             	xor    %ax,%ax
4000025e:	cd 30                	int    $0x30
		b->idx = 0;
40000260:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
	}
	b->cnt++;
40000266:	83 42 04 01          	addl   $0x1,0x4(%edx)
}
4000026a:	5b                   	pop    %ebx
4000026b:	c3                   	ret    
4000026c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000270 <vcprintf>:

int
vcprintf(const char *fmt, va_list ap)
{
40000270:	53                   	push   %ebx
40000271:	81 ec 28 10 00 00    	sub    $0x1028,%esp
	struct printbuf b;

	b.idx = 0;
	b.cnt = 0;
	vprintfmt((void*)putch, &b, fmt, ap);
40000277:	8b 84 24 34 10 00 00 	mov    0x1034(%esp),%eax
4000027e:	8d 5c 24 20          	lea    0x20(%esp),%ebx
40000282:	c7 04 24 30 02 00 40 	movl   $0x40000230,(%esp)
int
vcprintf(const char *fmt, va_list ap)
{
	struct printbuf b;

	b.idx = 0;
40000289:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
40000290:	00 
	b.cnt = 0;
40000291:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
40000298:	00 
	vprintfmt((void*)putch, &b, fmt, ap);
40000299:	89 44 24 0c          	mov    %eax,0xc(%esp)
4000029d:	8b 84 24 30 10 00 00 	mov    0x1030(%esp),%eax
400002a4:	89 44 24 08          	mov    %eax,0x8(%esp)
400002a8:	8d 44 24 18          	lea    0x18(%esp),%eax
400002ac:	89 44 24 04          	mov    %eax,0x4(%esp)
400002b0:	e8 7b 01 00 00       	call   40000430 <vprintfmt>

	b.buf[b.idx] = 0;
400002b5:	8b 4c 24 18          	mov    0x18(%esp),%ecx
400002b9:	31 c0                	xor    %eax,%eax
400002bb:	c6 44 0c 20 00       	movb   $0x0,0x20(%esp,%ecx,1)
400002c0:	cd 30                	int    $0x30
	puts(b.buf, b.idx);

	return b.cnt;
}
400002c2:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400002c6:	81 c4 28 10 00 00    	add    $0x1028,%esp
400002cc:	5b                   	pop    %ebx
400002cd:	c3                   	ret    
400002ce:	66 90                	xchg   %ax,%ax

400002d0 <printf>:

int
printf(const char *fmt, ...)
{
400002d0:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	int cnt;

	va_start(ap, fmt);
	cnt = vcprintf(fmt, ap);
400002d3:	8d 44 24 24          	lea    0x24(%esp),%eax
400002d7:	89 44 24 04          	mov    %eax,0x4(%esp)
400002db:	8b 44 24 20          	mov    0x20(%esp),%eax
400002df:	89 04 24             	mov    %eax,(%esp)
400002e2:	e8 89 ff ff ff       	call   40000270 <vcprintf>
	va_end(ap);

	return cnt;
}
400002e7:	83 c4 1c             	add    $0x1c,%esp
400002ea:	c3                   	ret    
400002eb:	66 90                	xchg   %ax,%ax
400002ed:	66 90                	xchg   %ax,%ax
400002ef:	90                   	nop

400002f0 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
400002f0:	55                   	push   %ebp
400002f1:	57                   	push   %edi
400002f2:	89 d7                	mov    %edx,%edi
400002f4:	56                   	push   %esi
400002f5:	89 c6                	mov    %eax,%esi
400002f7:	53                   	push   %ebx
400002f8:	83 ec 3c             	sub    $0x3c,%esp
400002fb:	8b 44 24 50          	mov    0x50(%esp),%eax
400002ff:	8b 4c 24 58          	mov    0x58(%esp),%ecx
40000303:	8b 5c 24 5c          	mov    0x5c(%esp),%ebx
40000307:	8b 6c 24 60          	mov    0x60(%esp),%ebp
4000030b:	89 44 24 20          	mov    %eax,0x20(%esp)
4000030f:	8b 44 24 54          	mov    0x54(%esp),%eax
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
40000313:	89 ca                	mov    %ecx,%edx
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
40000315:	89 4c 24 28          	mov    %ecx,0x28(%esp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
40000319:	31 c9                	xor    %ecx,%ecx
4000031b:	89 54 24 18          	mov    %edx,0x18(%esp)
4000031f:	39 c1                	cmp    %eax,%ecx
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
40000321:	89 44 24 24          	mov    %eax,0x24(%esp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
40000325:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
40000329:	0f 83 a9 00 00 00    	jae    400003d8 <printnum+0xe8>
		printnum(putch, putdat, num / base, base, width - 1, padc);
4000032f:	8b 44 24 28          	mov    0x28(%esp),%eax
40000333:	83 eb 01             	sub    $0x1,%ebx
40000336:	8b 54 24 1c          	mov    0x1c(%esp),%edx
4000033a:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
4000033e:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40000342:	89 6c 24 10          	mov    %ebp,0x10(%esp)
40000346:	89 44 24 08          	mov    %eax,0x8(%esp)
4000034a:	8b 44 24 18          	mov    0x18(%esp),%eax
4000034e:	8b 4c 24 08          	mov    0x8(%esp),%ecx
40000352:	89 54 24 0c          	mov    %edx,0xc(%esp)
40000356:	89 5c 24 2c          	mov    %ebx,0x2c(%esp)
4000035a:	89 44 24 08          	mov    %eax,0x8(%esp)
4000035e:	8b 44 24 20          	mov    0x20(%esp),%eax
40000362:	89 4c 24 28          	mov    %ecx,0x28(%esp)
40000366:	89 04 24             	mov    %eax,(%esp)
40000369:	8b 44 24 24          	mov    0x24(%esp),%eax
4000036d:	89 44 24 04          	mov    %eax,0x4(%esp)
40000371:	e8 ea 21 00 00       	call   40002560 <__udivdi3>
40000376:	8b 4c 24 28          	mov    0x28(%esp),%ecx
4000037a:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
4000037e:	89 4c 24 08          	mov    %ecx,0x8(%esp)
40000382:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
40000386:	89 04 24             	mov    %eax,(%esp)
40000389:	89 f0                	mov    %esi,%eax
4000038b:	89 54 24 04          	mov    %edx,0x4(%esp)
4000038f:	89 fa                	mov    %edi,%edx
40000391:	e8 5a ff ff ff       	call   400002f0 <printnum>
		while (--width > 0)
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
40000396:	8b 44 24 18          	mov    0x18(%esp),%eax
4000039a:	8b 54 24 1c          	mov    0x1c(%esp),%edx
4000039e:	89 7c 24 54          	mov    %edi,0x54(%esp)
400003a2:	89 44 24 08          	mov    %eax,0x8(%esp)
400003a6:	8b 44 24 20          	mov    0x20(%esp),%eax
400003aa:	89 54 24 0c          	mov    %edx,0xc(%esp)
400003ae:	89 04 24             	mov    %eax,(%esp)
400003b1:	8b 44 24 24          	mov    0x24(%esp),%eax
400003b5:	89 44 24 04          	mov    %eax,0x4(%esp)
400003b9:	e8 d2 22 00 00       	call   40002690 <__umoddi3>
400003be:	0f be 80 0c 28 00 40 	movsbl 0x4000280c(%eax),%eax
400003c5:	89 44 24 50          	mov    %eax,0x50(%esp)
}
400003c9:	83 c4 3c             	add    $0x3c,%esp
		while (--width > 0)
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
400003cc:	89 f0                	mov    %esi,%eax
}
400003ce:	5b                   	pop    %ebx
400003cf:	5e                   	pop    %esi
400003d0:	5f                   	pop    %edi
400003d1:	5d                   	pop    %ebp
		while (--width > 0)
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
400003d2:	ff e0                	jmp    *%eax
400003d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
400003d8:	76 1e                	jbe    400003f8 <printnum+0x108>
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
400003da:	83 eb 01             	sub    $0x1,%ebx
400003dd:	85 db                	test   %ebx,%ebx
400003df:	7e b5                	jle    40000396 <printnum+0xa6>
400003e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			putch(padc, putdat);
400003e8:	89 7c 24 04          	mov    %edi,0x4(%esp)
400003ec:	89 2c 24             	mov    %ebp,(%esp)
400003ef:	ff d6                	call   *%esi
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
400003f1:	83 eb 01             	sub    $0x1,%ebx
400003f4:	75 f2                	jne    400003e8 <printnum+0xf8>
400003f6:	eb 9e                	jmp    40000396 <printnum+0xa6>
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
400003f8:	8b 44 24 20          	mov    0x20(%esp),%eax
400003fc:	39 44 24 28          	cmp    %eax,0x28(%esp)
40000400:	0f 86 29 ff ff ff    	jbe    4000032f <printnum+0x3f>
40000406:	eb d2                	jmp    400003da <printnum+0xea>
40000408:	90                   	nop
40000409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000410 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
40000410:	8b 44 24 08          	mov    0x8(%esp),%eax
	b->cnt++;
	if (b->buf < b->ebuf)
40000414:	8b 10                	mov    (%eax),%edx
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
	b->cnt++;
40000416:	83 40 08 01          	addl   $0x1,0x8(%eax)
	if (b->buf < b->ebuf)
4000041a:	3b 50 04             	cmp    0x4(%eax),%edx
4000041d:	73 0b                	jae    4000042a <sprintputch+0x1a>
		*b->buf++ = ch;
4000041f:	8d 4a 01             	lea    0x1(%edx),%ecx
40000422:	89 08                	mov    %ecx,(%eax)
40000424:	8b 44 24 04          	mov    0x4(%esp),%eax
40000428:	88 02                	mov    %al,(%edx)
4000042a:	f3 c3                	repz ret 
4000042c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000430 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
40000430:	55                   	push   %ebp
40000431:	57                   	push   %edi
40000432:	56                   	push   %esi
40000433:	53                   	push   %ebx
40000434:	83 ec 3c             	sub    $0x3c,%esp
40000437:	8b 6c 24 50          	mov    0x50(%esp),%ebp
4000043b:	8b 74 24 54          	mov    0x54(%esp),%esi
4000043f:	8b 7c 24 58          	mov    0x58(%esp),%edi
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
40000443:	0f b6 07             	movzbl (%edi),%eax
40000446:	8d 5f 01             	lea    0x1(%edi),%ebx
40000449:	83 f8 25             	cmp    $0x25,%eax
4000044c:	75 17                	jne    40000465 <vprintfmt+0x35>
4000044e:	eb 28                	jmp    40000478 <vprintfmt+0x48>
40000450:	83 c3 01             	add    $0x1,%ebx
			if (ch == '\0')
				return;
			putch(ch, putdat);
40000453:	89 04 24             	mov    %eax,(%esp)
40000456:	89 74 24 04          	mov    %esi,0x4(%esp)
4000045a:	ff d5                	call   *%ebp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
4000045c:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
40000460:	83 f8 25             	cmp    $0x25,%eax
40000463:	74 13                	je     40000478 <vprintfmt+0x48>
			if (ch == '\0')
40000465:	85 c0                	test   %eax,%eax
40000467:	75 e7                	jne    40000450 <vprintfmt+0x20>
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
40000469:	83 c4 3c             	add    $0x3c,%esp
4000046c:	5b                   	pop    %ebx
4000046d:	5e                   	pop    %esi
4000046e:	5f                   	pop    %edi
4000046f:	5d                   	pop    %ebp
40000470:	c3                   	ret    
40000471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			if (width < 0)
				width = 0;
			goto reswitch;

		case '#':
			altflag = 1;
40000478:	c6 44 24 24 20       	movb   $0x20,0x24(%esp)
4000047d:	ba ff ff ff ff       	mov    $0xffffffff,%edx
40000482:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
40000489:	00 
4000048a:	c7 44 24 20 ff ff ff 	movl   $0xffffffff,0x20(%esp)
40000491:	ff 
40000492:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
40000499:	00 
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
4000049a:	0f b6 03             	movzbl (%ebx),%eax
4000049d:	8d 7b 01             	lea    0x1(%ebx),%edi
400004a0:	0f b6 c8             	movzbl %al,%ecx
400004a3:	83 e8 23             	sub    $0x23,%eax
400004a6:	3c 55                	cmp    $0x55,%al
400004a8:	0f 87 69 02 00 00    	ja     40000717 <vprintfmt+0x2e7>
400004ae:	0f b6 c0             	movzbl %al,%eax
400004b1:	ff 24 85 24 28 00 40 	jmp    *0x40002824(,%eax,4)
400004b8:	89 fb                	mov    %edi,%ebx
			padc = '-';
			goto reswitch;

			// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
400004ba:	c6 44 24 24 30       	movb   $0x30,0x24(%esp)
400004bf:	eb d9                	jmp    4000049a <vprintfmt+0x6a>
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
				precision = precision * 10 + ch - '0';
				ch = *fmt;
400004c1:	0f be 43 01          	movsbl 0x1(%ebx),%eax
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
				precision = precision * 10 + ch - '0';
400004c5:	8d 51 d0             	lea    -0x30(%ecx),%edx
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
400004c8:	89 fb                	mov    %edi,%ebx
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
400004ca:	8d 48 d0             	lea    -0x30(%eax),%ecx
400004cd:	83 f9 09             	cmp    $0x9,%ecx
400004d0:	0f 87 02 02 00 00    	ja     400006d8 <vprintfmt+0x2a8>
400004d6:	66 90                	xchg   %ax,%ax
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
400004d8:	83 c3 01             	add    $0x1,%ebx
				precision = precision * 10 + ch - '0';
400004db:	8d 14 92             	lea    (%edx,%edx,4),%edx
400004de:	8d 54 50 d0          	lea    -0x30(%eax,%edx,2),%edx
				ch = *fmt;
400004e2:	0f be 03             	movsbl (%ebx),%eax
				if (ch < '0' || ch > '9')
400004e5:	8d 48 d0             	lea    -0x30(%eax),%ecx
400004e8:	83 f9 09             	cmp    $0x9,%ecx
400004eb:	76 eb                	jbe    400004d8 <vprintfmt+0xa8>
400004ed:	e9 e6 01 00 00       	jmp    400006d8 <vprintfmt+0x2a8>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
400004f2:	8b 44 24 5c          	mov    0x5c(%esp),%eax
			lflag++;
			goto reswitch;

			// character
		case 'c':
			putch(va_arg(ap, int), putdat);
400004f6:	89 74 24 04          	mov    %esi,0x4(%esp)
400004fa:	83 44 24 5c 04       	addl   $0x4,0x5c(%esp)
400004ff:	8b 00                	mov    (%eax),%eax
40000501:	89 04 24             	mov    %eax,(%esp)
40000504:	ff d5                	call   *%ebp
			break;
40000506:	e9 38 ff ff ff       	jmp    40000443 <vprintfmt+0x13>
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, long long);
4000050b:	8b 44 24 5c          	mov    0x5c(%esp),%eax
// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
4000050f:	83 7c 24 28 01       	cmpl   $0x1,0x28(%esp)
		return va_arg(*ap, long long);
40000514:	8b 08                	mov    (%eax),%ecx
// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
40000516:	0f 8e e7 02 00 00    	jle    40000803 <vprintfmt+0x3d3>
		return va_arg(*ap, long long);
4000051c:	8b 58 04             	mov    0x4(%eax),%ebx
4000051f:	83 c0 08             	add    $0x8,%eax
40000522:	89 44 24 5c          	mov    %eax,0x5c(%esp)
				putch(' ', putdat);
			break;

			// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
40000526:	89 ca                	mov    %ecx,%edx
40000528:	89 d9                	mov    %ebx,%ecx
			if ((long long) num < 0) {
4000052a:	85 c9                	test   %ecx,%ecx
4000052c:	bb 0a 00 00 00       	mov    $0xa,%ebx
40000531:	0f 88 dd 02 00 00    	js     40000814 <vprintfmt+0x3e4>
			// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
			base = 16;
		number:
			printnum(putch, putdat, num, base, width, padc);
40000537:	0f be 44 24 24       	movsbl 0x24(%esp),%eax
4000053c:	89 14 24             	mov    %edx,(%esp)
4000053f:	89 f2                	mov    %esi,%edx
40000541:	89 5c 24 08          	mov    %ebx,0x8(%esp)
40000545:	89 4c 24 04          	mov    %ecx,0x4(%esp)
40000549:	89 44 24 10          	mov    %eax,0x10(%esp)
4000054d:	8b 44 24 20          	mov    0x20(%esp),%eax
40000551:	89 44 24 0c          	mov    %eax,0xc(%esp)
40000555:	89 e8                	mov    %ebp,%eax
40000557:	e8 94 fd ff ff       	call   400002f0 <printnum>
			break;
4000055c:	e9 e2 fe ff ff       	jmp    40000443 <vprintfmt+0x13>
				width = precision, precision = -1;
			goto reswitch;

			// long flag (doubled for long long)
		case 'l':
			lflag++;
40000561:	83 44 24 28 01       	addl   $0x1,0x28(%esp)
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
40000566:	89 fb                	mov    %edi,%ebx
			goto reswitch;

			// long flag (doubled for long long)
		case 'l':
			lflag++;
			goto reswitch;
40000568:	e9 2d ff ff ff       	jmp    4000049a <vprintfmt+0x6a>
			num = getuint(&ap, lflag);
			base = 8;
			goto number;
#else
			// Replace this with your code.
			putch('X', putdat);
4000056d:	89 74 24 04          	mov    %esi,0x4(%esp)
40000571:	c7 04 24 58 00 00 00 	movl   $0x58,(%esp)
40000578:	ff d5                	call   *%ebp
			putch('X', putdat);
4000057a:	89 74 24 04          	mov    %esi,0x4(%esp)
4000057e:	c7 04 24 58 00 00 00 	movl   $0x58,(%esp)
40000585:	ff d5                	call   *%ebp
			putch('X', putdat);
40000587:	89 74 24 04          	mov    %esi,0x4(%esp)
4000058b:	c7 04 24 58 00 00 00 	movl   $0x58,(%esp)
40000592:	ff d5                	call   *%ebp
			break;
40000594:	e9 aa fe ff ff       	jmp    40000443 <vprintfmt+0x13>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
40000599:	8b 5c 24 5c          	mov    0x5c(%esp),%ebx
			break;
#endif

			// pointer
		case 'p':
			putch('0', putdat);
4000059d:	89 74 24 04          	mov    %esi,0x4(%esp)
400005a1:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
400005a8:	ff d5                	call   *%ebp
			putch('x', putdat);
400005aa:	89 74 24 04          	mov    %esi,0x4(%esp)
400005ae:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
400005b5:	ff d5                	call   *%ebp
			num = (unsigned long long)
400005b7:	8b 13                	mov    (%ebx),%edx
400005b9:	31 c9                	xor    %ecx,%ecx
				(uintptr_t) va_arg(ap, void *);
400005bb:	83 44 24 5c 04       	addl   $0x4,0x5c(%esp)
			base = 16;
			goto number;
400005c0:	bb 10 00 00 00       	mov    $0x10,%ebx
400005c5:	e9 6d ff ff ff       	jmp    40000537 <vprintfmt+0x107>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
400005ca:	8b 44 24 5c          	mov    0x5c(%esp),%eax
			putch(va_arg(ap, int), putdat);
			break;

			// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
400005ce:	83 44 24 5c 04       	addl   $0x4,0x5c(%esp)
400005d3:	8b 08                	mov    (%eax),%ecx
				p = "(null)";
400005d5:	b8 1d 28 00 40       	mov    $0x4000281d,%eax
400005da:	85 c9                	test   %ecx,%ecx
400005dc:	0f 44 c8             	cmove  %eax,%ecx
			if (width > 0 && padc != '-')
400005df:	80 7c 24 24 2d       	cmpb   $0x2d,0x24(%esp)
400005e4:	0f 85 a9 01 00 00    	jne    40000793 <vprintfmt+0x363>
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
400005ea:	0f be 01             	movsbl (%ecx),%eax
400005ed:	8d 59 01             	lea    0x1(%ecx),%ebx
400005f0:	85 c0                	test   %eax,%eax
400005f2:	0f 84 52 01 00 00    	je     4000074a <vprintfmt+0x31a>
400005f8:	89 74 24 54          	mov    %esi,0x54(%esp)
400005fc:	89 de                	mov    %ebx,%esi
400005fe:	89 d3                	mov    %edx,%ebx
40000600:	89 7c 24 58          	mov    %edi,0x58(%esp)
40000604:	8b 7c 24 20          	mov    0x20(%esp),%edi
40000608:	eb 25                	jmp    4000062f <vprintfmt+0x1ff>
4000060a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
40000610:	8b 4c 24 54          	mov    0x54(%esp),%ecx
40000614:	89 04 24             	mov    %eax,(%esp)
40000617:	89 4c 24 04          	mov    %ecx,0x4(%esp)
4000061b:	ff d5                	call   *%ebp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
4000061d:	83 c6 01             	add    $0x1,%esi
40000620:	0f be 46 ff          	movsbl -0x1(%esi),%eax
40000624:	83 ef 01             	sub    $0x1,%edi
40000627:	85 c0                	test   %eax,%eax
40000629:	0f 84 0f 01 00 00    	je     4000073e <vprintfmt+0x30e>
4000062f:	85 db                	test   %ebx,%ebx
40000631:	78 0c                	js     4000063f <vprintfmt+0x20f>
40000633:	83 eb 01             	sub    $0x1,%ebx
40000636:	83 fb ff             	cmp    $0xffffffff,%ebx
40000639:	0f 84 ff 00 00 00    	je     4000073e <vprintfmt+0x30e>
				if (altflag && (ch < ' ' || ch > '~'))
4000063f:	8b 54 24 18          	mov    0x18(%esp),%edx
40000643:	85 d2                	test   %edx,%edx
40000645:	74 c9                	je     40000610 <vprintfmt+0x1e0>
40000647:	8d 48 e0             	lea    -0x20(%eax),%ecx
4000064a:	83 f9 5e             	cmp    $0x5e,%ecx
4000064d:	76 c1                	jbe    40000610 <vprintfmt+0x1e0>
					putch('?', putdat);
4000064f:	8b 44 24 54          	mov    0x54(%esp),%eax
40000653:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
4000065a:	89 44 24 04          	mov    %eax,0x4(%esp)
4000065e:	ff d5                	call   *%ebp
40000660:	eb bb                	jmp    4000061d <vprintfmt+0x1ed>
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, unsigned long long);
40000662:	8b 44 24 5c          	mov    0x5c(%esp),%eax
// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
40000666:	83 7c 24 28 01       	cmpl   $0x1,0x28(%esp)
		return va_arg(*ap, unsigned long long);
4000066b:	8b 10                	mov    (%eax),%edx
// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
4000066d:	0f 8e 04 01 00 00    	jle    40000777 <vprintfmt+0x347>
		return va_arg(*ap, unsigned long long);
40000673:	8b 48 04             	mov    0x4(%eax),%ecx
40000676:	83 c0 08             	add    $0x8,%eax
40000679:	89 44 24 5c          	mov    %eax,0x5c(%esp)

			// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
			base = 10;
			goto number;
4000067d:	bb 0a 00 00 00       	mov    $0xa,%ebx
40000682:	e9 b0 fe ff ff       	jmp    40000537 <vprintfmt+0x107>
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, unsigned long long);
40000687:	8b 44 24 5c          	mov    0x5c(%esp),%eax
// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
4000068b:	83 7c 24 28 01       	cmpl   $0x1,0x28(%esp)
		return va_arg(*ap, unsigned long long);
40000690:	8b 10                	mov    (%eax),%edx
// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
40000692:	0f 8e ed 00 00 00    	jle    40000785 <vprintfmt+0x355>
		return va_arg(*ap, unsigned long long);
40000698:	8b 48 04             	mov    0x4(%eax),%ecx
4000069b:	83 c0 08             	add    $0x8,%eax
4000069e:	89 44 24 5c          	mov    %eax,0x5c(%esp)
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
				(uintptr_t) va_arg(ap, void *);
			base = 16;
			goto number;
400006a2:	bb 10 00 00 00       	mov    $0x10,%ebx
400006a7:	e9 8b fe ff ff       	jmp    40000537 <vprintfmt+0x107>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
400006ac:	89 fb                	mov    %edi,%ebx
			if (width < 0)
				width = 0;
			goto reswitch;

		case '#':
			altflag = 1;
400006ae:	c7 44 24 18 01 00 00 	movl   $0x1,0x18(%esp)
400006b5:	00 
			goto reswitch;
400006b6:	e9 df fd ff ff       	jmp    4000049a <vprintfmt+0x6a>
			printnum(putch, putdat, num, base, width, padc);
			break;

			// escaped '%' character
		case '%':
			putch(ch, putdat);
400006bb:	89 74 24 04          	mov    %esi,0x4(%esp)
400006bf:	89 0c 24             	mov    %ecx,(%esp)
400006c2:	ff d5                	call   *%ebp
			break;
400006c4:	e9 7a fd ff ff       	jmp    40000443 <vprintfmt+0x13>
					break;
			}
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
400006c9:	8b 44 24 5c          	mov    0x5c(%esp),%eax
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
400006cd:	89 fb                	mov    %edi,%ebx
					break;
			}
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
400006cf:	8b 10                	mov    (%eax),%edx
400006d1:	83 c0 04             	add    $0x4,%eax
400006d4:	89 44 24 5c          	mov    %eax,0x5c(%esp)
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
400006d8:	8b 7c 24 20          	mov    0x20(%esp),%edi
400006dc:	85 ff                	test   %edi,%edi
400006de:	0f 89 b6 fd ff ff    	jns    4000049a <vprintfmt+0x6a>
				width = precision, precision = -1;
400006e4:	89 54 24 20          	mov    %edx,0x20(%esp)
400006e8:	ba ff ff ff ff       	mov    $0xffffffff,%edx
400006ed:	e9 a8 fd ff ff       	jmp    4000049a <vprintfmt+0x6a>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
400006f2:	89 fb                	mov    %edi,%ebx

			// flag to pad on the right
		case '-':
			padc = '-';
400006f4:	c6 44 24 24 2d       	movb   $0x2d,0x24(%esp)
400006f9:	e9 9c fd ff ff       	jmp    4000049a <vprintfmt+0x6a>
400006fe:	8b 4c 24 20          	mov    0x20(%esp),%ecx
40000702:	b8 00 00 00 00       	mov    $0x0,%eax
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
40000707:	89 fb                	mov    %edi,%ebx
40000709:	85 c9                	test   %ecx,%ecx
4000070b:	0f 49 c1             	cmovns %ecx,%eax
4000070e:	89 44 24 20          	mov    %eax,0x20(%esp)
40000712:	e9 83 fd ff ff       	jmp    4000049a <vprintfmt+0x6a>
			putch(ch, putdat);
			break;

			// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
40000717:	89 74 24 04          	mov    %esi,0x4(%esp)
			for (fmt--; fmt[-1] != '%'; fmt--)
4000071b:	89 df                	mov    %ebx,%edi
			putch(ch, putdat);
			break;

			// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
4000071d:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
40000724:	ff d5                	call   *%ebp
			for (fmt--; fmt[-1] != '%'; fmt--)
40000726:	80 7b ff 25          	cmpb   $0x25,-0x1(%ebx)
4000072a:	0f 84 13 fd ff ff    	je     40000443 <vprintfmt+0x13>
40000730:	83 ef 01             	sub    $0x1,%edi
40000733:	80 7f ff 25          	cmpb   $0x25,-0x1(%edi)
40000737:	75 f7                	jne    40000730 <vprintfmt+0x300>
40000739:	e9 05 fd ff ff       	jmp    40000443 <vprintfmt+0x13>
4000073e:	89 7c 24 20          	mov    %edi,0x20(%esp)
40000742:	8b 74 24 54          	mov    0x54(%esp),%esi
40000746:	8b 7c 24 58          	mov    0x58(%esp),%edi
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
4000074a:	8b 4c 24 20          	mov    0x20(%esp),%ecx
4000074e:	8b 5c 24 20          	mov    0x20(%esp),%ebx
40000752:	85 c9                	test   %ecx,%ecx
40000754:	0f 8e e9 fc ff ff    	jle    40000443 <vprintfmt+0x13>
4000075a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
				putch(' ', putdat);
40000760:	89 74 24 04          	mov    %esi,0x4(%esp)
40000764:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
4000076b:	ff d5                	call   *%ebp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
4000076d:	83 eb 01             	sub    $0x1,%ebx
40000770:	75 ee                	jne    40000760 <vprintfmt+0x330>
40000772:	e9 cc fc ff ff       	jmp    40000443 <vprintfmt+0x13>
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, unsigned long long);
	else if (lflag)
		return va_arg(*ap, unsigned long);
40000777:	83 c0 04             	add    $0x4,%eax
4000077a:	31 c9                	xor    %ecx,%ecx
4000077c:	89 44 24 5c          	mov    %eax,0x5c(%esp)
40000780:	e9 f8 fe ff ff       	jmp    4000067d <vprintfmt+0x24d>
40000785:	83 c0 04             	add    $0x4,%eax
40000788:	31 c9                	xor    %ecx,%ecx
4000078a:	89 44 24 5c          	mov    %eax,0x5c(%esp)
4000078e:	e9 0f ff ff ff       	jmp    400006a2 <vprintfmt+0x272>

			// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
40000793:	8b 5c 24 20          	mov    0x20(%esp),%ebx
40000797:	85 db                	test   %ebx,%ebx
40000799:	0f 8e 4b fe ff ff    	jle    400005ea <vprintfmt+0x1ba>
				for (width -= strnlen(p, precision); width > 0; width--)
4000079f:	89 54 24 04          	mov    %edx,0x4(%esp)
400007a3:	89 0c 24             	mov    %ecx,(%esp)
400007a6:	89 54 24 2c          	mov    %edx,0x2c(%esp)
400007aa:	89 4c 24 28          	mov    %ecx,0x28(%esp)
400007ae:	e8 ad 02 00 00       	call   40000a60 <strnlen>
400007b3:	8b 4c 24 28          	mov    0x28(%esp),%ecx
400007b7:	8b 54 24 2c          	mov    0x2c(%esp),%edx
400007bb:	29 44 24 20          	sub    %eax,0x20(%esp)
400007bf:	8b 44 24 20          	mov    0x20(%esp),%eax
400007c3:	85 c0                	test   %eax,%eax
400007c5:	0f 8e 1f fe ff ff    	jle    400005ea <vprintfmt+0x1ba>
400007cb:	0f be 5c 24 24       	movsbl 0x24(%esp),%ebx
400007d0:	89 7c 24 58          	mov    %edi,0x58(%esp)
400007d4:	89 c7                	mov    %eax,%edi
400007d6:	89 4c 24 20          	mov    %ecx,0x20(%esp)
400007da:	89 54 24 24          	mov    %edx,0x24(%esp)
400007de:	66 90                	xchg   %ax,%ax
					putch(padc, putdat);
400007e0:	89 74 24 04          	mov    %esi,0x4(%esp)
400007e4:	89 1c 24             	mov    %ebx,(%esp)
400007e7:	ff d5                	call   *%ebp
			// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
400007e9:	83 ef 01             	sub    $0x1,%edi
400007ec:	75 f2                	jne    400007e0 <vprintfmt+0x3b0>
400007ee:	8b 4c 24 20          	mov    0x20(%esp),%ecx
400007f2:	8b 54 24 24          	mov    0x24(%esp),%edx
400007f6:	89 7c 24 20          	mov    %edi,0x20(%esp)
400007fa:	8b 7c 24 58          	mov    0x58(%esp),%edi
400007fe:	e9 e7 fd ff ff       	jmp    400005ea <vprintfmt+0x1ba>
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, long long);
	else if (lflag)
		return va_arg(*ap, long);
40000803:	89 cb                	mov    %ecx,%ebx
40000805:	83 c0 04             	add    $0x4,%eax
40000808:	c1 fb 1f             	sar    $0x1f,%ebx
4000080b:	89 44 24 5c          	mov    %eax,0x5c(%esp)
4000080f:	e9 12 fd ff ff       	jmp    40000526 <vprintfmt+0xf6>
40000814:	89 54 24 18          	mov    %edx,0x18(%esp)
40000818:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)

			// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
			if ((long long) num < 0) {
				putch('-', putdat);
4000081c:	89 74 24 04          	mov    %esi,0x4(%esp)
40000820:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
40000827:	ff d5                	call   *%ebp
				num = -(long long) num;
40000829:	8b 54 24 18          	mov    0x18(%esp),%edx
4000082d:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
40000831:	f7 da                	neg    %edx
40000833:	83 d1 00             	adc    $0x0,%ecx
40000836:	f7 d9                	neg    %ecx
40000838:	e9 fa fc ff ff       	jmp    40000537 <vprintfmt+0x107>
4000083d:	8d 76 00             	lea    0x0(%esi),%esi

40000840 <printfmt>:
	}
}

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
40000840:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;

	va_start(ap, fmt);
	vprintfmt(putch, putdat, fmt, ap);
40000843:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000847:	89 44 24 0c          	mov    %eax,0xc(%esp)
4000084b:	8b 44 24 28          	mov    0x28(%esp),%eax
4000084f:	89 44 24 08          	mov    %eax,0x8(%esp)
40000853:	8b 44 24 24          	mov    0x24(%esp),%eax
40000857:	89 44 24 04          	mov    %eax,0x4(%esp)
4000085b:	8b 44 24 20          	mov    0x20(%esp),%eax
4000085f:	89 04 24             	mov    %eax,(%esp)
40000862:	e8 c9 fb ff ff       	call   40000430 <vprintfmt>
	va_end(ap);
}
40000867:	83 c4 1c             	add    $0x1c,%esp
4000086a:	c3                   	ret    
4000086b:	90                   	nop
4000086c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000870 <vsprintf>:
		*b->buf++ = ch;
}

int
vsprintf(char *buf, const char *fmt, va_list ap)
{
40000870:	83 ec 2c             	sub    $0x2c,%esp
	//assert(buf != NULL);
	struct sprintbuf b = {buf, (char*)(intptr_t)~0, 0};
40000873:	8b 44 24 30          	mov    0x30(%esp),%eax

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
40000877:	c7 04 24 10 04 00 40 	movl   $0x40000410,(%esp)

int
vsprintf(char *buf, const char *fmt, va_list ap)
{
	//assert(buf != NULL);
	struct sprintbuf b = {buf, (char*)(intptr_t)~0, 0};
4000087e:	c7 44 24 18 ff ff ff 	movl   $0xffffffff,0x18(%esp)
40000885:	ff 
40000886:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
4000088d:	00 
4000088e:	89 44 24 14          	mov    %eax,0x14(%esp)

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
40000892:	8b 44 24 38          	mov    0x38(%esp),%eax
40000896:	89 44 24 0c          	mov    %eax,0xc(%esp)
4000089a:	8b 44 24 34          	mov    0x34(%esp),%eax
4000089e:	89 44 24 08          	mov    %eax,0x8(%esp)
400008a2:	8d 44 24 14          	lea    0x14(%esp),%eax
400008a6:	89 44 24 04          	mov    %eax,0x4(%esp)
400008aa:	e8 81 fb ff ff       	call   40000430 <vprintfmt>

	// null terminate the buffer
	*b.buf = '\0';
400008af:	8b 44 24 14          	mov    0x14(%esp),%eax
400008b3:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
}
400008b6:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400008ba:	83 c4 2c             	add    $0x2c,%esp
400008bd:	c3                   	ret    
400008be:	66 90                	xchg   %ax,%ax

400008c0 <sprintf>:

int
sprintf(char *buf, const char *fmt, ...)
{
400008c0:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
	rc = vsprintf(buf, fmt, ap);
400008c3:	8d 44 24 28          	lea    0x28(%esp),%eax
400008c7:	89 44 24 08          	mov    %eax,0x8(%esp)
400008cb:	8b 44 24 24          	mov    0x24(%esp),%eax
400008cf:	89 44 24 04          	mov    %eax,0x4(%esp)
400008d3:	8b 44 24 20          	mov    0x20(%esp),%eax
400008d7:	89 04 24             	mov    %eax,(%esp)
400008da:	e8 91 ff ff ff       	call   40000870 <vsprintf>
	va_end(ap);

	return rc;
}
400008df:	83 c4 1c             	add    $0x1c,%esp
400008e2:	c3                   	ret    
400008e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
400008e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

400008f0 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
400008f0:	83 ec 2c             	sub    $0x2c,%esp
400008f3:	8b 44 24 30          	mov    0x30(%esp),%eax
	//assert(buf != NULL && n > 0);
	struct sprintbuf b = {buf, buf+n-1, 0};
400008f7:	8b 54 24 34          	mov    0x34(%esp),%edx

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
400008fb:	c7 04 24 10 04 00 40 	movl   $0x40000410,(%esp)

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
	//assert(buf != NULL && n > 0);
	struct sprintbuf b = {buf, buf+n-1, 0};
40000902:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
40000909:	00 
4000090a:	89 44 24 14          	mov    %eax,0x14(%esp)
4000090e:	8d 44 10 ff          	lea    -0x1(%eax,%edx,1),%eax
40000912:	89 44 24 18          	mov    %eax,0x18(%esp)

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
40000916:	8b 44 24 3c          	mov    0x3c(%esp),%eax
4000091a:	89 44 24 0c          	mov    %eax,0xc(%esp)
4000091e:	8b 44 24 38          	mov    0x38(%esp),%eax
40000922:	89 44 24 08          	mov    %eax,0x8(%esp)
40000926:	8d 44 24 14          	lea    0x14(%esp),%eax
4000092a:	89 44 24 04          	mov    %eax,0x4(%esp)
4000092e:	e8 fd fa ff ff       	call   40000430 <vprintfmt>

	// null terminate the buffer
	*b.buf = '\0';
40000933:	8b 44 24 14          	mov    0x14(%esp),%eax
40000937:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
}
4000093a:	8b 44 24 1c          	mov    0x1c(%esp),%eax
4000093e:	83 c4 2c             	add    $0x2c,%esp
40000941:	c3                   	ret    
40000942:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000950 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
40000950:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
	rc = vsnprintf(buf, n, fmt, ap);
40000953:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000957:	89 44 24 0c          	mov    %eax,0xc(%esp)
4000095b:	8b 44 24 28          	mov    0x28(%esp),%eax
4000095f:	89 44 24 08          	mov    %eax,0x8(%esp)
40000963:	8b 44 24 24          	mov    0x24(%esp),%eax
40000967:	89 44 24 04          	mov    %eax,0x4(%esp)
4000096b:	8b 44 24 20          	mov    0x20(%esp),%eax
4000096f:	89 04 24             	mov    %eax,(%esp)
40000972:	e8 79 ff ff ff       	call   400008f0 <vsnprintf>
	va_end(ap);

	return rc;
}
40000977:	83 c4 1c             	add    $0x1c,%esp
4000097a:	c3                   	ret    
4000097b:	66 90                	xchg   %ax,%ax
4000097d:	66 90                	xchg   %ax,%ax
4000097f:	90                   	nop

40000980 <spawn>:
#include <syscall.h>
#include <types.h>

pid_t
spawn(uintptr_t exec, unsigned int quota)
{
40000980:	53                   	push   %ebx
sys_spawn(uintptr_t exec, unsigned int quota)
{
	int errno;
	pid_t pid;

	asm volatile("int %2"
40000981:	b8 01 00 00 00       	mov    $0x1,%eax
40000986:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
4000098a:	8b 5c 24 08          	mov    0x8(%esp),%ebx
4000098e:	cd 30                	int    $0x30
		       "a" (SYS_spawn),
		       "b" (exec),
		       "c" (quota)
		     : "cc", "memory");

	return errno ? -1 : pid;
40000990:	ba ff ff ff ff       	mov    $0xffffffff,%edx
40000995:	85 c0                	test   %eax,%eax
40000997:	0f 44 d3             	cmove  %ebx,%edx
	return sys_spawn(exec, quota);
}
4000099a:	89 d0                	mov    %edx,%eax
4000099c:	5b                   	pop    %ebx
4000099d:	c3                   	ret    
4000099e:	66 90                	xchg   %ax,%ax

400009a0 <yield>:
}

static gcc_inline void
sys_yield(void)
{
	asm volatile("int %0" :
400009a0:	b8 02 00 00 00       	mov    $0x2,%eax
400009a5:	cd 30                	int    $0x30
400009a7:	c3                   	ret    
400009a8:	90                   	nop
400009a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

400009b0 <produce>:
}

static gcc_inline void
sys_produce(void)
{
	asm volatile("int %0" :
400009b0:	b8 03 00 00 00       	mov    $0x3,%eax
400009b5:	cd 30                	int    $0x30
400009b7:	c3                   	ret    
400009b8:	90                   	nop
400009b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

400009c0 <consume>:
}

static gcc_inline void
sys_consume(void)
{
	asm volatile("int %0" :
400009c0:	b8 04 00 00 00       	mov    $0x4,%eax
400009c5:	cd 30                	int    $0x30
400009c7:	c3                   	ret    
400009c8:	66 90                	xchg   %ax,%ax
400009ca:	66 90                	xchg   %ax,%ax
400009cc:	66 90                	xchg   %ax,%ax
400009ce:	66 90                	xchg   %ax,%ax

400009d0 <spinlock_init>:
}

void
spinlock_init(spinlock_t *lk)
{
	*lk = 0;
400009d0:	8b 44 24 04          	mov    0x4(%esp),%eax
400009d4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
400009da:	c3                   	ret    
400009db:	90                   	nop
400009dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

400009e0 <spinlock_acquire>:
}

void
spinlock_acquire(spinlock_t *lk)
{
400009e0:	8b 54 24 04          	mov    0x4(%esp),%edx
static inline uint32_t
xchg(volatile uint32_t *addr, uint32_t newval)
{
	uint32_t result;

	asm volatile("lock; xchgl %0, %1" :
400009e4:	b8 01 00 00 00       	mov    $0x1,%eax
400009e9:	f0 87 02             	lock xchg %eax,(%edx)
}

void
spinlock_acquire(spinlock_t *lk)
{
	while(xchg(lk, 1) != 0)
400009ec:	85 c0                	test   %eax,%eax
static inline uint32_t
xchg(volatile uint32_t *addr, uint32_t newval)
{
	uint32_t result;

	asm volatile("lock; xchgl %0, %1" :
400009ee:	b9 01 00 00 00       	mov    $0x1,%ecx
}

void
spinlock_acquire(spinlock_t *lk)
{
	while(xchg(lk, 1) != 0)
400009f3:	74 0e                	je     40000a03 <spinlock_acquire+0x23>
400009f5:	8d 76 00             	lea    0x0(%esi),%esi
		asm volatile("pause");
400009f8:	f3 90                	pause  
static inline uint32_t
xchg(volatile uint32_t *addr, uint32_t newval)
{
	uint32_t result;

	asm volatile("lock; xchgl %0, %1" :
400009fa:	89 c8                	mov    %ecx,%eax
400009fc:	f0 87 02             	lock xchg %eax,(%edx)
}

void
spinlock_acquire(spinlock_t *lk)
{
	while(xchg(lk, 1) != 0)
400009ff:	85 c0                	test   %eax,%eax
40000a01:	75 f5                	jne    400009f8 <spinlock_acquire+0x18>
40000a03:	f3 c3                	repz ret 
40000a05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000a10 <spinlock_release>:
}

// Release the lock.
void
spinlock_release(spinlock_t *lk)
{
40000a10:	8b 54 24 04          	mov    0x4(%esp),%edx

// Check whether this cpu is holding the lock.
bool
spinlock_holding(spinlock_t *lock)
{
	return *lock;
40000a14:	8b 02                	mov    (%edx),%eax

// Release the lock.
void
spinlock_release(spinlock_t *lk)
{
	if (spinlock_holding(lk) == FALSE)
40000a16:	84 c0                	test   %al,%al
40000a18:	74 05                	je     40000a1f <spinlock_release+0xf>
static inline uint32_t
xchg(volatile uint32_t *addr, uint32_t newval)
{
	uint32_t result;

	asm volatile("lock; xchgl %0, %1" :
40000a1a:	31 c0                	xor    %eax,%eax
40000a1c:	f0 87 02             	lock xchg %eax,(%edx)
40000a1f:	f3 c3                	repz ret 
40000a21:	eb 0d                	jmp    40000a30 <spinlock_holding>
40000a23:	90                   	nop
40000a24:	90                   	nop
40000a25:	90                   	nop
40000a26:	90                   	nop
40000a27:	90                   	nop
40000a28:	90                   	nop
40000a29:	90                   	nop
40000a2a:	90                   	nop
40000a2b:	90                   	nop
40000a2c:	90                   	nop
40000a2d:	90                   	nop
40000a2e:	90                   	nop
40000a2f:	90                   	nop

40000a30 <spinlock_holding>:

// Check whether this cpu is holding the lock.
bool
spinlock_holding(spinlock_t *lock)
{
	return *lock;
40000a30:	8b 44 24 04          	mov    0x4(%esp),%eax
40000a34:	8b 00                	mov    (%eax),%eax
}
40000a36:	c3                   	ret    
40000a37:	66 90                	xchg   %ax,%ax
40000a39:	66 90                	xchg   %ax,%ax
40000a3b:	66 90                	xchg   %ax,%ax
40000a3d:	66 90                	xchg   %ax,%ax
40000a3f:	90                   	nop

40000a40 <strlen>:
#include <string.h>
#include <types.h>

int
strlen(const char *s)
{
40000a40:	8b 54 24 04          	mov    0x4(%esp),%edx
	int n;

	for (n = 0; *s != '\0'; s++)
40000a44:	31 c0                	xor    %eax,%eax
40000a46:	80 3a 00             	cmpb   $0x0,(%edx)
40000a49:	74 10                	je     40000a5b <strlen+0x1b>
40000a4b:	90                   	nop
40000a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		n++;
40000a50:	83 c0 01             	add    $0x1,%eax
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
40000a53:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
40000a57:	75 f7                	jne    40000a50 <strlen+0x10>
40000a59:	f3 c3                	repz ret 
		n++;
	return n;
}
40000a5b:	f3 c3                	repz ret 
40000a5d:	8d 76 00             	lea    0x0(%esi),%esi

40000a60 <strnlen>:

int
strnlen(const char *s, size_t size)
{
40000a60:	53                   	push   %ebx
40000a61:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000a65:	8b 5c 24 08          	mov    0x8(%esp),%ebx
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000a69:	85 c9                	test   %ecx,%ecx
40000a6b:	74 25                	je     40000a92 <strnlen+0x32>
40000a6d:	80 3b 00             	cmpb   $0x0,(%ebx)
40000a70:	74 20                	je     40000a92 <strnlen+0x32>
40000a72:	ba 01 00 00 00       	mov    $0x1,%edx
40000a77:	eb 11                	jmp    40000a8a <strnlen+0x2a>
40000a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000a80:	83 c2 01             	add    $0x1,%edx
40000a83:	80 7c 13 ff 00       	cmpb   $0x0,-0x1(%ebx,%edx,1)
40000a88:	74 06                	je     40000a90 <strnlen+0x30>
40000a8a:	39 ca                	cmp    %ecx,%edx
		n++;
40000a8c:	89 d0                	mov    %edx,%eax
int
strnlen(const char *s, size_t size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000a8e:	75 f0                	jne    40000a80 <strnlen+0x20>
		n++;
	return n;
}
40000a90:	5b                   	pop    %ebx
40000a91:	c3                   	ret    
int
strnlen(const char *s, size_t size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000a92:	31 c0                	xor    %eax,%eax
		n++;
	return n;
}
40000a94:	5b                   	pop    %ebx
40000a95:	c3                   	ret    
40000a96:	8d 76 00             	lea    0x0(%esi),%esi
40000a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000aa0 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
40000aa0:	53                   	push   %ebx
40000aa1:	8b 44 24 08          	mov    0x8(%esp),%eax
40000aa5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
	char *ret;

	ret = dst;
	while ((*dst++ = *src++) != '\0')
40000aa9:	89 c2                	mov    %eax,%edx
40000aab:	90                   	nop
40000aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000ab0:	83 c1 01             	add    $0x1,%ecx
40000ab3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
40000ab7:	83 c2 01             	add    $0x1,%edx
40000aba:	84 db                	test   %bl,%bl
40000abc:	88 5a ff             	mov    %bl,-0x1(%edx)
40000abf:	75 ef                	jne    40000ab0 <strcpy+0x10>
		/* do nothing */;
	return ret;
}
40000ac1:	5b                   	pop    %ebx
40000ac2:	c3                   	ret    
40000ac3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000ad0 <strncpy>:

char *
strncpy(char *dst, const char *src, size_t size)
{
40000ad0:	57                   	push   %edi
40000ad1:	56                   	push   %esi
40000ad2:	53                   	push   %ebx
40000ad3:	8b 74 24 18          	mov    0x18(%esp),%esi
40000ad7:	8b 7c 24 10          	mov    0x10(%esp),%edi
40000adb:	8b 4c 24 14          	mov    0x14(%esp),%ecx
	size_t i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
40000adf:	85 f6                	test   %esi,%esi
40000ae1:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
40000ae4:	89 fa                	mov    %edi,%edx
40000ae6:	74 13                	je     40000afb <strncpy+0x2b>
		*dst++ = *src;
40000ae8:	0f b6 01             	movzbl (%ecx),%eax
40000aeb:	83 c2 01             	add    $0x1,%edx
40000aee:	88 42 ff             	mov    %al,-0x1(%edx)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
40000af1:	80 39 01             	cmpb   $0x1,(%ecx)
40000af4:	83 d9 ff             	sbb    $0xffffffff,%ecx
{
	size_t i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
40000af7:	39 da                	cmp    %ebx,%edx
40000af9:	75 ed                	jne    40000ae8 <strncpy+0x18>
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
}
40000afb:	89 f8                	mov    %edi,%eax
40000afd:	5b                   	pop    %ebx
40000afe:	5e                   	pop    %esi
40000aff:	5f                   	pop    %edi
40000b00:	c3                   	ret    
40000b01:	eb 0d                	jmp    40000b10 <strlcpy>
40000b03:	90                   	nop
40000b04:	90                   	nop
40000b05:	90                   	nop
40000b06:	90                   	nop
40000b07:	90                   	nop
40000b08:	90                   	nop
40000b09:	90                   	nop
40000b0a:	90                   	nop
40000b0b:	90                   	nop
40000b0c:	90                   	nop
40000b0d:	90                   	nop
40000b0e:	90                   	nop
40000b0f:	90                   	nop

40000b10 <strlcpy>:

size_t
strlcpy(char *dst, const char *src, size_t size)
{
40000b10:	56                   	push   %esi
40000b11:	31 c0                	xor    %eax,%eax
40000b13:	53                   	push   %ebx
40000b14:	8b 74 24 14          	mov    0x14(%esp),%esi
40000b18:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
40000b1c:	85 f6                	test   %esi,%esi
40000b1e:	74 36                	je     40000b56 <strlcpy+0x46>
		while (--size > 0 && *src != '\0')
40000b20:	83 fe 01             	cmp    $0x1,%esi
40000b23:	74 34                	je     40000b59 <strlcpy+0x49>
40000b25:	0f b6 0b             	movzbl (%ebx),%ecx
40000b28:	84 c9                	test   %cl,%cl
40000b2a:	74 2d                	je     40000b59 <strlcpy+0x49>
40000b2c:	83 ee 02             	sub    $0x2,%esi
40000b2f:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000b33:	eb 0e                	jmp    40000b43 <strlcpy+0x33>
40000b35:	8d 76 00             	lea    0x0(%esi),%esi
40000b38:	83 c0 01             	add    $0x1,%eax
40000b3b:	0f b6 0c 03          	movzbl (%ebx,%eax,1),%ecx
40000b3f:	84 c9                	test   %cl,%cl
40000b41:	74 0a                	je     40000b4d <strlcpy+0x3d>
			*dst++ = *src++;
40000b43:	83 c2 01             	add    $0x1,%edx
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
40000b46:	39 f0                	cmp    %esi,%eax
			*dst++ = *src++;
40000b48:	88 4a ff             	mov    %cl,-0x1(%edx)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
40000b4b:	75 eb                	jne    40000b38 <strlcpy+0x28>
40000b4d:	89 d0                	mov    %edx,%eax
40000b4f:	2b 44 24 0c          	sub    0xc(%esp),%eax
			*dst++ = *src++;
		*dst = '\0';
40000b53:	c6 02 00             	movb   $0x0,(%edx)
	}
	return dst - dst_in;
}
40000b56:	5b                   	pop    %ebx
40000b57:	5e                   	pop    %esi
40000b58:	c3                   	ret    
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
40000b59:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000b5d:	eb f4                	jmp    40000b53 <strlcpy+0x43>
40000b5f:	90                   	nop

40000b60 <strcmp>:
	return dst - dst_in;
}

int
strcmp(const char *p, const char *q)
{
40000b60:	53                   	push   %ebx
40000b61:	8b 54 24 08          	mov    0x8(%esp),%edx
40000b65:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
	while (*p && *p == *q)
40000b69:	0f b6 02             	movzbl (%edx),%eax
40000b6c:	84 c0                	test   %al,%al
40000b6e:	74 2d                	je     40000b9d <strcmp+0x3d>
40000b70:	0f b6 19             	movzbl (%ecx),%ebx
40000b73:	38 d8                	cmp    %bl,%al
40000b75:	74 0f                	je     40000b86 <strcmp+0x26>
40000b77:	eb 2b                	jmp    40000ba4 <strcmp+0x44>
40000b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b80:	38 c8                	cmp    %cl,%al
40000b82:	75 15                	jne    40000b99 <strcmp+0x39>
		p++, q++;
40000b84:	89 d9                	mov    %ebx,%ecx
40000b86:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
40000b89:	0f b6 02             	movzbl (%edx),%eax
		p++, q++;
40000b8c:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
40000b8f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
40000b93:	84 c0                	test   %al,%al
40000b95:	75 e9                	jne    40000b80 <strcmp+0x20>
40000b97:	31 c0                	xor    %eax,%eax
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
40000b99:	29 c8                	sub    %ecx,%eax
}
40000b9b:	5b                   	pop    %ebx
40000b9c:	c3                   	ret    
40000b9d:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
40000ba0:	31 c0                	xor    %eax,%eax
40000ba2:	eb f5                	jmp    40000b99 <strcmp+0x39>
40000ba4:	0f b6 cb             	movzbl %bl,%ecx
40000ba7:	eb f0                	jmp    40000b99 <strcmp+0x39>
40000ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000bb0 <strncmp>:
	return (int) ((unsigned char) *p - (unsigned char) *q);
}

int
strncmp(const char *p, const char *q, size_t n)
{
40000bb0:	56                   	push   %esi
40000bb1:	53                   	push   %ebx
40000bb2:	8b 74 24 14          	mov    0x14(%esp),%esi
40000bb6:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000bba:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	while (n > 0 && *p && *p == *q)
40000bbe:	85 f6                	test   %esi,%esi
40000bc0:	74 30                	je     40000bf2 <strncmp+0x42>
40000bc2:	0f b6 01             	movzbl (%ecx),%eax
40000bc5:	84 c0                	test   %al,%al
40000bc7:	74 2e                	je     40000bf7 <strncmp+0x47>
40000bc9:	0f b6 13             	movzbl (%ebx),%edx
40000bcc:	38 d0                	cmp    %dl,%al
40000bce:	75 3e                	jne    40000c0e <strncmp+0x5e>
40000bd0:	8d 51 01             	lea    0x1(%ecx),%edx
40000bd3:	01 ce                	add    %ecx,%esi
40000bd5:	eb 14                	jmp    40000beb <strncmp+0x3b>
40000bd7:	90                   	nop
40000bd8:	0f b6 02             	movzbl (%edx),%eax
40000bdb:	84 c0                	test   %al,%al
40000bdd:	74 29                	je     40000c08 <strncmp+0x58>
40000bdf:	0f b6 19             	movzbl (%ecx),%ebx
40000be2:	83 c2 01             	add    $0x1,%edx
40000be5:	38 d8                	cmp    %bl,%al
40000be7:	75 17                	jne    40000c00 <strncmp+0x50>
		n--, p++, q++;
40000be9:	89 cb                	mov    %ecx,%ebx
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
40000beb:	39 f2                	cmp    %esi,%edx
		n--, p++, q++;
40000bed:	8d 4b 01             	lea    0x1(%ebx),%ecx
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
40000bf0:	75 e6                	jne    40000bd8 <strncmp+0x28>
		n--, p++, q++;
	if (n == 0)
		return 0;
40000bf2:	31 c0                	xor    %eax,%eax
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
}
40000bf4:	5b                   	pop    %ebx
40000bf5:	5e                   	pop    %esi
40000bf6:	c3                   	ret    
40000bf7:	0f b6 1b             	movzbl (%ebx),%ebx
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
40000bfa:	31 c0                	xor    %eax,%eax
40000bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		n--, p++, q++;
	if (n == 0)
		return 0;
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
40000c00:	0f b6 d3             	movzbl %bl,%edx
40000c03:	29 d0                	sub    %edx,%eax
}
40000c05:	5b                   	pop    %ebx
40000c06:	5e                   	pop    %esi
40000c07:	c3                   	ret    
40000c08:	0f b6 5b 01          	movzbl 0x1(%ebx),%ebx
40000c0c:	eb f2                	jmp    40000c00 <strncmp+0x50>
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
40000c0e:	89 d3                	mov    %edx,%ebx
40000c10:	eb ee                	jmp    40000c00 <strncmp+0x50>
40000c12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000c20 <strchr>:
		return (int) ((unsigned char) *p - (unsigned char) *q);
}

char *
strchr(const char *s, char c)
{
40000c20:	53                   	push   %ebx
40000c21:	8b 44 24 08          	mov    0x8(%esp),%eax
40000c25:	8b 54 24 0c          	mov    0xc(%esp),%edx
	for (; *s; s++)
40000c29:	0f b6 18             	movzbl (%eax),%ebx
40000c2c:	84 db                	test   %bl,%bl
40000c2e:	74 16                	je     40000c46 <strchr+0x26>
		if (*s == c)
40000c30:	38 d3                	cmp    %dl,%bl
40000c32:	89 d1                	mov    %edx,%ecx
40000c34:	75 06                	jne    40000c3c <strchr+0x1c>
40000c36:	eb 10                	jmp    40000c48 <strchr+0x28>
40000c38:	38 ca                	cmp    %cl,%dl
40000c3a:	74 0c                	je     40000c48 <strchr+0x28>
}

char *
strchr(const char *s, char c)
{
	for (; *s; s++)
40000c3c:	83 c0 01             	add    $0x1,%eax
40000c3f:	0f b6 10             	movzbl (%eax),%edx
40000c42:	84 d2                	test   %dl,%dl
40000c44:	75 f2                	jne    40000c38 <strchr+0x18>
		if (*s == c)
			return (char *) s;
	return 0;
40000c46:	31 c0                	xor    %eax,%eax
}
40000c48:	5b                   	pop    %ebx
40000c49:	c3                   	ret    
40000c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000c50 <strfind>:

char *
strfind(const char *s, char c)
{
40000c50:	53                   	push   %ebx
40000c51:	8b 44 24 08          	mov    0x8(%esp),%eax
40000c55:	8b 54 24 0c          	mov    0xc(%esp),%edx
	for (; *s; s++)
40000c59:	0f b6 18             	movzbl (%eax),%ebx
40000c5c:	84 db                	test   %bl,%bl
40000c5e:	74 16                	je     40000c76 <strfind+0x26>
		if (*s == c)
40000c60:	38 d3                	cmp    %dl,%bl
40000c62:	89 d1                	mov    %edx,%ecx
40000c64:	75 06                	jne    40000c6c <strfind+0x1c>
40000c66:	eb 0e                	jmp    40000c76 <strfind+0x26>
40000c68:	38 ca                	cmp    %cl,%dl
40000c6a:	74 0a                	je     40000c76 <strfind+0x26>
}

char *
strfind(const char *s, char c)
{
	for (; *s; s++)
40000c6c:	83 c0 01             	add    $0x1,%eax
40000c6f:	0f b6 10             	movzbl (%eax),%edx
40000c72:	84 d2                	test   %dl,%dl
40000c74:	75 f2                	jne    40000c68 <strfind+0x18>
		if (*s == c)
			break;
	return (char *) s;
}
40000c76:	5b                   	pop    %ebx
40000c77:	c3                   	ret    
40000c78:	90                   	nop
40000c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000c80 <strtol>:


long
strtol(const char *s, char **endptr, int base)
{
40000c80:	55                   	push   %ebp
40000c81:	57                   	push   %edi
40000c82:	56                   	push   %esi
40000c83:	53                   	push   %ebx
40000c84:	8b 54 24 14          	mov    0x14(%esp),%edx
40000c88:	8b 74 24 18          	mov    0x18(%esp),%esi
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
40000c8c:	0f b6 0a             	movzbl (%edx),%ecx
40000c8f:	80 f9 20             	cmp    $0x20,%cl
40000c92:	0f 85 e6 00 00 00    	jne    40000d7e <strtol+0xfe>
		s++;
40000c98:	83 c2 01             	add    $0x1,%edx
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
40000c9b:	0f b6 0a             	movzbl (%edx),%ecx
40000c9e:	80 f9 09             	cmp    $0x9,%cl
40000ca1:	74 f5                	je     40000c98 <strtol+0x18>
40000ca3:	80 f9 20             	cmp    $0x20,%cl
40000ca6:	74 f0                	je     40000c98 <strtol+0x18>
		s++;

	// plus/minus sign
	if (*s == '+')
40000ca8:	80 f9 2b             	cmp    $0x2b,%cl
40000cab:	0f 84 8f 00 00 00    	je     40000d40 <strtol+0xc0>


long
strtol(const char *s, char **endptr, int base)
{
	int neg = 0;
40000cb1:	31 ff                	xor    %edi,%edi
		s++;

	// plus/minus sign
	if (*s == '+')
		s++;
	else if (*s == '-')
40000cb3:	80 f9 2d             	cmp    $0x2d,%cl
40000cb6:	0f 84 94 00 00 00    	je     40000d50 <strtol+0xd0>
		s++, neg = 1;

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000cbc:	f7 44 24 1c ef ff ff 	testl  $0xffffffef,0x1c(%esp)
40000cc3:	ff 
40000cc4:	0f be 0a             	movsbl (%edx),%ecx
40000cc7:	75 19                	jne    40000ce2 <strtol+0x62>
40000cc9:	80 f9 30             	cmp    $0x30,%cl
40000ccc:	0f 84 8a 00 00 00    	je     40000d5c <strtol+0xdc>
		s += 2, base = 16;
	else if (base == 0 && s[0] == '0')
40000cd2:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
40000cd6:	85 db                	test   %ebx,%ebx
40000cd8:	75 08                	jne    40000ce2 <strtol+0x62>
		s++, base = 8;
	else if (base == 0)
		base = 10;
40000cda:	c7 44 24 1c 0a 00 00 	movl   $0xa,0x1c(%esp)
40000ce1:	00 
		s++;
	else if (*s == '-')
		s++, neg = 1;

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000ce2:	31 db                	xor    %ebx,%ebx
40000ce4:	eb 18                	jmp    40000cfe <strtol+0x7e>
40000ce6:	66 90                	xchg   %ax,%ax
	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
			dig = *s - '0';
40000ce8:	83 e9 30             	sub    $0x30,%ecx
			dig = *s - 'a' + 10;
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
40000ceb:	3b 4c 24 1c          	cmp    0x1c(%esp),%ecx
40000cef:	7d 28                	jge    40000d19 <strtol+0x99>
			break;
		s++, val = (val * base) + dig;
40000cf1:	0f af 5c 24 1c       	imul   0x1c(%esp),%ebx
40000cf6:	83 c2 01             	add    $0x1,%edx
40000cf9:	01 cb                	add    %ecx,%ebx
40000cfb:	0f be 0a             	movsbl (%edx),%ecx

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
40000cfe:	8d 69 d0             	lea    -0x30(%ecx),%ebp
40000d01:	89 e8                	mov    %ebp,%eax
40000d03:	3c 09                	cmp    $0x9,%al
40000d05:	76 e1                	jbe    40000ce8 <strtol+0x68>
			dig = *s - '0';
		else if (*s >= 'a' && *s <= 'z')
40000d07:	8d 69 9f             	lea    -0x61(%ecx),%ebp
40000d0a:	89 e8                	mov    %ebp,%eax
40000d0c:	3c 19                	cmp    $0x19,%al
40000d0e:	77 20                	ja     40000d30 <strtol+0xb0>
			dig = *s - 'a' + 10;
40000d10:	83 e9 57             	sub    $0x57,%ecx
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
40000d13:	3b 4c 24 1c          	cmp    0x1c(%esp),%ecx
40000d17:	7c d8                	jl     40000cf1 <strtol+0x71>
			break;
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
40000d19:	85 f6                	test   %esi,%esi
40000d1b:	74 02                	je     40000d1f <strtol+0x9f>
		*endptr = (char *) s;
40000d1d:	89 16                	mov    %edx,(%esi)
	return (neg ? -val : val);
40000d1f:	89 d8                	mov    %ebx,%eax
40000d21:	f7 d8                	neg    %eax
40000d23:	85 ff                	test   %edi,%edi
40000d25:	0f 44 c3             	cmove  %ebx,%eax
}
40000d28:	5b                   	pop    %ebx
40000d29:	5e                   	pop    %esi
40000d2a:	5f                   	pop    %edi
40000d2b:	5d                   	pop    %ebp
40000d2c:	c3                   	ret    
40000d2d:	8d 76 00             	lea    0x0(%esi),%esi

		if (*s >= '0' && *s <= '9')
			dig = *s - '0';
		else if (*s >= 'a' && *s <= 'z')
			dig = *s - 'a' + 10;
		else if (*s >= 'A' && *s <= 'Z')
40000d30:	8d 69 bf             	lea    -0x41(%ecx),%ebp
40000d33:	89 e8                	mov    %ebp,%eax
40000d35:	3c 19                	cmp    $0x19,%al
40000d37:	77 e0                	ja     40000d19 <strtol+0x99>
			dig = *s - 'A' + 10;
40000d39:	83 e9 37             	sub    $0x37,%ecx
40000d3c:	eb ad                	jmp    40000ceb <strtol+0x6b>
40000d3e:	66 90                	xchg   %ax,%ax
	while (*s == ' ' || *s == '\t')
		s++;

	// plus/minus sign
	if (*s == '+')
		s++;
40000d40:	83 c2 01             	add    $0x1,%edx


long
strtol(const char *s, char **endptr, int base)
{
	int neg = 0;
40000d43:	31 ff                	xor    %edi,%edi
40000d45:	e9 72 ff ff ff       	jmp    40000cbc <strtol+0x3c>
40000d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

	// plus/minus sign
	if (*s == '+')
		s++;
	else if (*s == '-')
		s++, neg = 1;
40000d50:	83 c2 01             	add    $0x1,%edx
40000d53:	66 bf 01 00          	mov    $0x1,%di
40000d57:	e9 60 ff ff ff       	jmp    40000cbc <strtol+0x3c>

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000d5c:	80 7a 01 78          	cmpb   $0x78,0x1(%edx)
40000d60:	74 2a                	je     40000d8c <strtol+0x10c>
		s += 2, base = 16;
	else if (base == 0 && s[0] == '0')
40000d62:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000d66:	85 c0                	test   %eax,%eax
40000d68:	75 36                	jne    40000da0 <strtol+0x120>
40000d6a:	0f be 4a 01          	movsbl 0x1(%edx),%ecx
		s++, base = 8;
40000d6e:	83 c2 01             	add    $0x1,%edx
40000d71:	c7 44 24 1c 08 00 00 	movl   $0x8,0x1c(%esp)
40000d78:	00 
40000d79:	e9 64 ff ff ff       	jmp    40000ce2 <strtol+0x62>
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
40000d7e:	80 f9 09             	cmp    $0x9,%cl
40000d81:	0f 84 11 ff ff ff    	je     40000c98 <strtol+0x18>
40000d87:	e9 1c ff ff ff       	jmp    40000ca8 <strtol+0x28>
40000d8c:	0f be 4a 02          	movsbl 0x2(%edx),%ecx
	else if (*s == '-')
		s++, neg = 1;

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
		s += 2, base = 16;
40000d90:	83 c2 02             	add    $0x2,%edx
40000d93:	c7 44 24 1c 10 00 00 	movl   $0x10,0x1c(%esp)
40000d9a:	00 
40000d9b:	e9 42 ff ff ff       	jmp    40000ce2 <strtol+0x62>
		s++;
	else if (*s == '-')
		s++, neg = 1;

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000da0:	b9 30 00 00 00       	mov    $0x30,%ecx
40000da5:	e9 38 ff ff ff       	jmp    40000ce2 <strtol+0x62>
40000daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000db0 <memset>:
	return (neg ? -val : val);
}

void *
memset(void *v, int c, size_t n)
{
40000db0:	57                   	push   %edi
40000db1:	56                   	push   %esi
40000db2:	53                   	push   %ebx
40000db3:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000db7:	8b 7c 24 10          	mov    0x10(%esp),%edi
	if (n == 0)
40000dbb:	85 c9                	test   %ecx,%ecx
40000dbd:	74 14                	je     40000dd3 <memset+0x23>
		return v;
	if ((int)v%4 == 0 && n%4 == 0) {
40000dbf:	f7 c7 03 00 00 00    	test   $0x3,%edi
40000dc5:	75 05                	jne    40000dcc <memset+0x1c>
40000dc7:	f6 c1 03             	test   $0x3,%cl
40000dca:	74 14                	je     40000de0 <memset+0x30>
		c = (c<<24)|(c<<16)|(c<<8)|c;
		asm volatile("cld; rep stosl\n"
			     :: "D" (v), "a" (c), "c" (n/4)
			     : "cc", "memory");
	} else
		asm volatile("cld; rep stosb\n"
40000dcc:	8b 44 24 14          	mov    0x14(%esp),%eax
40000dd0:	fc                   	cld    
40000dd1:	f3 aa                	rep stos %al,%es:(%edi)
			     :: "D" (v), "a" (c), "c" (n)
			     : "cc", "memory");
	return v;
}
40000dd3:	89 f8                	mov    %edi,%eax
40000dd5:	5b                   	pop    %ebx
40000dd6:	5e                   	pop    %esi
40000dd7:	5f                   	pop    %edi
40000dd8:	c3                   	ret    
40000dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
memset(void *v, int c, size_t n)
{
	if (n == 0)
		return v;
	if ((int)v%4 == 0 && n%4 == 0) {
		c &= 0xFF;
40000de0:	0f b6 54 24 14       	movzbl 0x14(%esp),%edx
		c = (c<<24)|(c<<16)|(c<<8)|c;
		asm volatile("cld; rep stosl\n"
			     :: "D" (v), "a" (c), "c" (n/4)
40000de5:	c1 e9 02             	shr    $0x2,%ecx
{
	if (n == 0)
		return v;
	if ((int)v%4 == 0 && n%4 == 0) {
		c &= 0xFF;
		c = (c<<24)|(c<<16)|(c<<8)|c;
40000de8:	89 d0                	mov    %edx,%eax
40000dea:	89 d6                	mov    %edx,%esi
40000dec:	c1 e0 18             	shl    $0x18,%eax
40000def:	89 d3                	mov    %edx,%ebx
40000df1:	c1 e6 10             	shl    $0x10,%esi
40000df4:	09 f0                	or     %esi,%eax
40000df6:	c1 e3 08             	shl    $0x8,%ebx
40000df9:	09 d0                	or     %edx,%eax
40000dfb:	09 d8                	or     %ebx,%eax
		asm volatile("cld; rep stosl\n"
40000dfd:	fc                   	cld    
40000dfe:	f3 ab                	rep stos %eax,%es:(%edi)
	} else
		asm volatile("cld; rep stosb\n"
			     :: "D" (v), "a" (c), "c" (n)
			     : "cc", "memory");
	return v;
}
40000e00:	89 f8                	mov    %edi,%eax
40000e02:	5b                   	pop    %ebx
40000e03:	5e                   	pop    %esi
40000e04:	5f                   	pop    %edi
40000e05:	c3                   	ret    
40000e06:	8d 76 00             	lea    0x0(%esi),%esi
40000e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000e10 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
40000e10:	57                   	push   %edi
40000e11:	56                   	push   %esi
40000e12:	8b 44 24 0c          	mov    0xc(%esp),%eax
40000e16:	8b 74 24 10          	mov    0x10(%esp),%esi
40000e1a:	8b 4c 24 14          	mov    0x14(%esp),%ecx
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
40000e1e:	39 c6                	cmp    %eax,%esi
40000e20:	73 26                	jae    40000e48 <memmove+0x38>
40000e22:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
40000e25:	39 d0                	cmp    %edx,%eax
40000e27:	73 1f                	jae    40000e48 <memmove+0x38>
		s += n;
		d += n;
40000e29:	8d 3c 08             	lea    (%eax,%ecx,1),%edi
40000e2c:	89 d6                	mov    %edx,%esi
40000e2e:	09 fe                	or     %edi,%esi
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
40000e30:	83 e6 03             	and    $0x3,%esi
40000e33:	74 33                	je     40000e68 <memmove+0x58>
			asm volatile("std; rep movsl\n"
				     :: "D" (d-4), "S" (s-4), "c" (n/4)
				     : "cc", "memory");
		else
			asm volatile("std; rep movsb\n"
				     :: "D" (d-1), "S" (s-1), "c" (n)
40000e35:	83 ef 01             	sub    $0x1,%edi
40000e38:	8d 72 ff             	lea    -0x1(%edx),%esi
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
			asm volatile("std; rep movsl\n"
				     :: "D" (d-4), "S" (s-4), "c" (n/4)
				     : "cc", "memory");
		else
			asm volatile("std; rep movsb\n"
40000e3b:	fd                   	std    
40000e3c:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
				     :: "D" (d-1), "S" (s-1), "c" (n)
				     : "cc", "memory");
		// Some versions of GCC rely on DF being clear
		asm volatile("cld" ::: "cc");
40000e3e:	fc                   	cld    
			asm volatile("cld; rep movsb\n"
				     :: "D" (d), "S" (s), "c" (n)
				     : "cc", "memory");
	}
	return dst;
}
40000e3f:	5e                   	pop    %esi
40000e40:	5f                   	pop    %edi
40000e41:	c3                   	ret    
40000e42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000e48:	89 f2                	mov    %esi,%edx
40000e4a:	09 c2                	or     %eax,%edx
				     :: "D" (d-1), "S" (s-1), "c" (n)
				     : "cc", "memory");
		// Some versions of GCC rely on DF being clear
		asm volatile("cld" ::: "cc");
	} else {
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
40000e4c:	83 e2 03             	and    $0x3,%edx
40000e4f:	75 0f                	jne    40000e60 <memmove+0x50>
40000e51:	f6 c1 03             	test   $0x3,%cl
40000e54:	75 0a                	jne    40000e60 <memmove+0x50>
			asm volatile("cld; rep movsl\n"
				     :: "D" (d), "S" (s), "c" (n/4)
40000e56:	c1 e9 02             	shr    $0x2,%ecx
				     : "cc", "memory");
		// Some versions of GCC rely on DF being clear
		asm volatile("cld" ::: "cc");
	} else {
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
			asm volatile("cld; rep movsl\n"
40000e59:	89 c7                	mov    %eax,%edi
40000e5b:	fc                   	cld    
40000e5c:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000e5e:	eb 05                	jmp    40000e65 <memmove+0x55>
				     :: "D" (d), "S" (s), "c" (n/4)
				     : "cc", "memory");
		else
			asm volatile("cld; rep movsb\n"
40000e60:	89 c7                	mov    %eax,%edi
40000e62:	fc                   	cld    
40000e63:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
				     :: "D" (d), "S" (s), "c" (n)
				     : "cc", "memory");
	}
	return dst;
}
40000e65:	5e                   	pop    %esi
40000e66:	5f                   	pop    %edi
40000e67:	c3                   	ret    
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
40000e68:	f6 c1 03             	test   $0x3,%cl
40000e6b:	75 c8                	jne    40000e35 <memmove+0x25>
			asm volatile("std; rep movsl\n"
				     :: "D" (d-4), "S" (s-4), "c" (n/4)
40000e6d:	83 ef 04             	sub    $0x4,%edi
40000e70:	8d 72 fc             	lea    -0x4(%edx),%esi
40000e73:	c1 e9 02             	shr    $0x2,%ecx
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
			asm volatile("std; rep movsl\n"
40000e76:	fd                   	std    
40000e77:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000e79:	eb c3                	jmp    40000e3e <memmove+0x2e>
40000e7b:	90                   	nop
40000e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000e80 <memcpy>:
}

void *
memcpy(void *dst, const void *src, size_t n)
{
	return memmove(dst, src, n);
40000e80:	eb 8e                	jmp    40000e10 <memmove>
40000e82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000e90 <memcmp>:
}

int
memcmp(const void *v1, const void *v2, size_t n)
{
40000e90:	57                   	push   %edi
40000e91:	56                   	push   %esi
40000e92:	53                   	push   %ebx
40000e93:	8b 44 24 18          	mov    0x18(%esp),%eax
40000e97:	8b 5c 24 10          	mov    0x10(%esp),%ebx
40000e9b:	8b 74 24 14          	mov    0x14(%esp),%esi
	const uint8_t *s1 = (const uint8_t *) v1;
	const uint8_t *s2 = (const uint8_t *) v2;

	while (n-- > 0) {
40000e9f:	85 c0                	test   %eax,%eax
40000ea1:	8d 78 ff             	lea    -0x1(%eax),%edi
40000ea4:	74 26                	je     40000ecc <memcmp+0x3c>
		if (*s1 != *s2)
40000ea6:	0f b6 03             	movzbl (%ebx),%eax
40000ea9:	31 d2                	xor    %edx,%edx
40000eab:	0f b6 0e             	movzbl (%esi),%ecx
40000eae:	38 c8                	cmp    %cl,%al
40000eb0:	74 16                	je     40000ec8 <memcmp+0x38>
40000eb2:	eb 24                	jmp    40000ed8 <memcmp+0x48>
40000eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000eb8:	0f b6 44 13 01       	movzbl 0x1(%ebx,%edx,1),%eax
40000ebd:	83 c2 01             	add    $0x1,%edx
40000ec0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
40000ec4:	38 c8                	cmp    %cl,%al
40000ec6:	75 10                	jne    40000ed8 <memcmp+0x48>
memcmp(const void *v1, const void *v2, size_t n)
{
	const uint8_t *s1 = (const uint8_t *) v1;
	const uint8_t *s2 = (const uint8_t *) v2;

	while (n-- > 0) {
40000ec8:	39 fa                	cmp    %edi,%edx
40000eca:	75 ec                	jne    40000eb8 <memcmp+0x28>
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
}
40000ecc:	5b                   	pop    %ebx
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
40000ecd:	31 c0                	xor    %eax,%eax
}
40000ecf:	5e                   	pop    %esi
40000ed0:	5f                   	pop    %edi
40000ed1:	c3                   	ret    
40000ed2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000ed8:	5b                   	pop    %ebx
	const uint8_t *s1 = (const uint8_t *) v1;
	const uint8_t *s2 = (const uint8_t *) v2;

	while (n-- > 0) {
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
40000ed9:	29 c8                	sub    %ecx,%eax
		s1++, s2++;
	}

	return 0;
}
40000edb:	5e                   	pop    %esi
40000edc:	5f                   	pop    %edi
40000edd:	c3                   	ret    
40000ede:	66 90                	xchg   %ax,%ax

40000ee0 <memchr>:

void *
memchr(const void *s, int c, size_t n)
{
40000ee0:	53                   	push   %ebx
40000ee1:	8b 44 24 08          	mov    0x8(%esp),%eax
	const void *ends = (const char *) s + n;
40000ee5:	8b 54 24 10          	mov    0x10(%esp),%edx
	return 0;
}

void *
memchr(const void *s, int c, size_t n)
{
40000ee9:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
	const void *ends = (const char *) s + n;
40000eed:	01 c2                	add    %eax,%edx
	for (; s < ends; s++)
40000eef:	39 d0                	cmp    %edx,%eax
40000ef1:	73 18                	jae    40000f0b <memchr+0x2b>
		if (*(const unsigned char *) s == (unsigned char) c)
40000ef3:	38 18                	cmp    %bl,(%eax)
40000ef5:	89 d9                	mov    %ebx,%ecx
40000ef7:	75 0b                	jne    40000f04 <memchr+0x24>
40000ef9:	eb 12                	jmp    40000f0d <memchr+0x2d>
40000efb:	90                   	nop
40000efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000f00:	38 08                	cmp    %cl,(%eax)
40000f02:	74 09                	je     40000f0d <memchr+0x2d>

void *
memchr(const void *s, int c, size_t n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
40000f04:	83 c0 01             	add    $0x1,%eax
40000f07:	39 d0                	cmp    %edx,%eax
40000f09:	75 f5                	jne    40000f00 <memchr+0x20>
		if (*(const unsigned char *) s == (unsigned char) c)
			return (void *) s;
	return NULL;
40000f0b:	31 c0                	xor    %eax,%eax
}
40000f0d:	5b                   	pop    %ebx
40000f0e:	c3                   	ret    
40000f0f:	90                   	nop

40000f10 <memzero>:

void *
memzero(void *v, size_t n)
{
40000f10:	83 ec 0c             	sub    $0xc,%esp
	return memset(v, 0, n);
40000f13:	8b 44 24 14          	mov    0x14(%esp),%eax
40000f17:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
40000f1e:	00 
40000f1f:	89 44 24 08          	mov    %eax,0x8(%esp)
40000f23:	8b 44 24 10          	mov    0x10(%esp),%eax
40000f27:	89 04 24             	mov    %eax,(%esp)
40000f2a:	e8 81 fe ff ff       	call   40000db0 <memset>
}
40000f2f:	83 c4 0c             	add    $0xc,%esp
40000f32:	c3                   	ret    
40000f33:	66 90                	xchg   %ax,%ax
40000f35:	66 90                	xchg   %ax,%ax
40000f37:	66 90                	xchg   %ax,%ax
40000f39:	66 90                	xchg   %ax,%ax
40000f3b:	66 90                	xchg   %ax,%ax
40000f3d:	66 90                	xchg   %ax,%ax
40000f3f:	90                   	nop

40000f40 <smallfile>:

// simple file system tests

void
smallfile(void)
{
40000f40:	55                   	push   %ebp
40000f41:	57                   	push   %edi
40000f42:	56                   	push   %esi
40000f43:	53                   	push   %ebx
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40000f44:	bb 97 29 00 40       	mov    $0x40002997,%ebx
40000f49:	83 ec 1c             	sub    $0x1c,%esp
  int fd;
  int i;

  printf("=====small file test=====\n");
40000f4c:	c7 04 24 7c 29 00 40 	movl   $0x4000297c,(%esp)
40000f53:	e8 78 f3 ff ff       	call   400002d0 <printf>
40000f58:	b9 02 02 00 00       	mov    $0x202,%ecx
40000f5d:	b8 05 00 00 00       	mov    $0x5,%eax
40000f62:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40000f64:	85 c0                	test   %eax,%eax
40000f66:	74 18                	je     40000f80 <smallfile+0x40>
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf("creat small succeeded; ok, fd: %d\n", fd);
  } else {
    printf("error: creat small failed!\n");
40000f68:	c7 04 24 9d 29 00 40 	movl   $0x4000299d,(%esp)
40000f6f:	e8 5c f3 ff ff       	call   400002d0 <printf>
40000f74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(unlink("small") < 0){
    printf("unlink small failed\n");
    exit();
  }
  printf("=====small file test ok=====\n\n");
}
40000f78:	83 c4 1c             	add    $0x1c,%esp
40000f7b:	5b                   	pop    %ebx
40000f7c:	5e                   	pop    %esi
40000f7d:	5f                   	pop    %edi
40000f7e:	5d                   	pop    %ebp
40000f7f:	c3                   	ret    
  int fd;
  int i;

  printf("=====small file test=====\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
40000f80:	85 db                	test   %ebx,%ebx
40000f82:	89 de                	mov    %ebx,%esi
40000f84:	78 e2                	js     40000f68 <smallfile+0x28>
    printf("creat small succeeded; ok, fd: %d\n", fd);
40000f86:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  } else {
    printf("error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
40000f8a:	31 ed                	xor    %ebp,%ebp
sys_write(int fd, char *p, int n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
40000f8c:	bf 08 00 00 00       	mov    $0x8,%edi
  int i;

  printf("=====small file test=====\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf("creat small succeeded; ok, fd: %d\n", fd);
40000f91:	c7 04 24 dc 33 00 40 	movl   $0x400033dc,(%esp)
40000f98:	e8 33 f3 ff ff       	call   400002d0 <printf>
40000f9d:	8d 76 00             	lea    0x0(%esi),%esi
40000fa0:	89 f8                	mov    %edi,%eax
40000fa2:	89 f3                	mov    %esi,%ebx
40000fa4:	b9 b9 29 00 40       	mov    $0x400029b9,%ecx
40000fa9:	ba 0a 00 00 00       	mov    $0xa,%edx
40000fae:	cd 30                	int    $0x30
		       "b" (fd),
		       "c" (p),
		       "d" (n)
		     : "cc", "memory");

	return errno ? -1 : ret;
40000fb0:	85 c0                	test   %eax,%eax
sys_write(int fd, char *p, int n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
40000fb2:	89 da                	mov    %ebx,%edx
		       "b" (fd),
		       "c" (p),
		       "d" (n)
		     : "cc", "memory");

	return errno ? -1 : ret;
40000fb4:	74 1a                	je     40000fd0 <smallfile+0x90>
    printf("error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
      printf("error: write aa %d new file failed\n", i);
40000fb6:	89 6c 24 04          	mov    %ebp,0x4(%esp)
40000fba:	c7 04 24 00 34 00 40 	movl   $0x40003400,(%esp)
40000fc1:	e8 0a f3 ff ff       	call   400002d0 <printf>
  if(unlink("small") < 0){
    printf("unlink small failed\n");
    exit();
  }
  printf("=====small file test ok=====\n\n");
}
40000fc6:	83 c4 1c             	add    $0x1c,%esp
40000fc9:	5b                   	pop    %ebx
40000fca:	5e                   	pop    %esi
40000fcb:	5f                   	pop    %edi
40000fcc:	5d                   	pop    %ebp
40000fcd:	c3                   	ret    
40000fce:	66 90                	xchg   %ax,%ax
  } else {
    printf("error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
40000fd0:	83 fb 0a             	cmp    $0xa,%ebx
40000fd3:	75 e1                	jne    40000fb6 <smallfile+0x76>
sys_write(int fd, char *p, int n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
40000fd5:	b9 c4 29 00 40       	mov    $0x400029c4,%ecx
40000fda:	89 f8                	mov    %edi,%eax
40000fdc:	89 f3                	mov    %esi,%ebx
40000fde:	cd 30                	int    $0x30
		       "b" (fd),
		       "c" (p),
		       "d" (n)
		     : "cc", "memory");

	return errno ? -1 : ret;
40000fe0:	85 c0                	test   %eax,%eax
40000fe2:	74 14                	je     40000ff8 <smallfile+0xb8>
      printf("error: write aa %d new file failed\n", i);
      exit();
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf("error: write bb %d new file failed\n", i);
40000fe4:	89 6c 24 04          	mov    %ebp,0x4(%esp)
40000fe8:	c7 04 24 24 34 00 40 	movl   $0x40003424,(%esp)
40000fef:	e8 dc f2 ff ff       	call   400002d0 <printf>
      exit();
40000ff4:	eb 82                	jmp    40000f78 <smallfile+0x38>
40000ff6:	66 90                	xchg   %ax,%ax
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
      printf("error: write aa %d new file failed\n", i);
      exit();
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
40000ff8:	83 fb 0a             	cmp    $0xa,%ebx
40000ffb:	75 e7                	jne    40000fe4 <smallfile+0xa4>
    printf("creat small succeeded; ok, fd: %d\n", fd);
  } else {
    printf("error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
40000ffd:	83 c5 01             	add    $0x1,%ebp
40001000:	83 fd 64             	cmp    $0x64,%ebp
40001003:	75 9b                	jne    40000fa0 <smallfile+0x60>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf("error: write bb %d new file failed\n", i);
      exit();
    }
  }
  printf("writes ok\n");
40001005:	c7 04 24 cf 29 00 40 	movl   $0x400029cf,(%esp)
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
4000100c:	bf 06 00 00 00       	mov    $0x6,%edi
40001011:	89 f3                	mov    %esi,%ebx
40001013:	89 44 24 0c          	mov    %eax,0xc(%esp)
40001017:	e8 b4 f2 ff ff       	call   400002d0 <printf>
4000101c:	89 f8                	mov    %edi,%eax
4000101e:	cd 30                	int    $0x30
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001020:	b8 05 00 00 00       	mov    $0x5,%eax
40001025:	bb 97 29 00 40       	mov    $0x40002997,%ebx
4000102a:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
4000102e:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40001030:	85 c0                	test   %eax,%eax
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001032:	89 de                	mov    %ebx,%esi
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40001034:	74 11                	je     40001047 <smallfile+0x107>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf("open small succeeded ok\n");
  } else {
    printf("error: open small failed!\n");
40001036:	c7 04 24 f3 29 00 40 	movl   $0x400029f3,(%esp)
4000103d:	e8 8e f2 ff ff       	call   400002d0 <printf>
    exit();
40001042:	e9 31 ff ff ff       	jmp    40000f78 <smallfile+0x38>
    }
  }
  printf("writes ok\n");
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
40001047:	85 db                	test   %ebx,%ebx
40001049:	78 eb                	js     40001036 <smallfile+0xf6>
    printf("open small succeeded ok\n");
4000104b:	c7 04 24 da 29 00 40 	movl   $0x400029da,(%esp)
40001052:	e8 79 f2 ff ff       	call   400002d0 <printf>
sys_read(int fd, char *buf, size_t n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
40001057:	ba d0 07 00 00       	mov    $0x7d0,%edx
4000105c:	b9 a0 54 00 40       	mov    $0x400054a0,%ecx
40001061:	b8 07 00 00 00       	mov    $0x7,%eax
40001066:	cd 30                	int    $0x30
		       "b" (fd),
		       "c" (buf),
		       "d" (n)
		     : "cc", "memory");

	return errno ? -1 : ret;
40001068:	85 c0                	test   %eax,%eax
4000106a:	75 3b                	jne    400010a7 <smallfile+0x167>
  } else {
    printf("error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
4000106c:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
40001072:	75 33                	jne    400010a7 <smallfile+0x167>
    printf("read succeeded ok\n");
40001074:	c7 04 24 0e 2a 00 40 	movl   $0x40002a0e,(%esp)
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
4000107b:	89 f3                	mov    %esi,%ebx
4000107d:	e8 4e f2 ff ff       	call   400002d0 <printf>
40001082:	89 f8                	mov    %edi,%eax
40001084:	cd 30                	int    $0x30
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001086:	b8 0c 00 00 00       	mov    $0xc,%eax
4000108b:	bb 97 29 00 40       	mov    $0x40002997,%ebx
40001090:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_unlink),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001092:	85 c0                	test   %eax,%eax
40001094:	74 22                	je     400010b8 <smallfile+0x178>
    exit();
  }
  close(fd);

  if(unlink("small") < 0){
    printf("unlink small failed\n");
40001096:	c7 04 24 21 2a 00 40 	movl   $0x40002a21,(%esp)
4000109d:	e8 2e f2 ff ff       	call   400002d0 <printf>
    exit();
400010a2:	e9 d1 fe ff ff       	jmp    40000f78 <smallfile+0x38>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf("read succeeded ok\n");
  } else {
    printf("read failed\n");
400010a7:	c7 04 24 3b 31 00 40 	movl   $0x4000313b,(%esp)
400010ae:	e8 1d f2 ff ff       	call   400002d0 <printf>
    exit();
400010b3:	e9 c0 fe ff ff       	jmp    40000f78 <smallfile+0x38>

  if(unlink("small") < 0){
    printf("unlink small failed\n");
    exit();
  }
  printf("=====small file test ok=====\n\n");
400010b8:	c7 04 24 48 34 00 40 	movl   $0x40003448,(%esp)
400010bf:	e8 0c f2 ff ff       	call   400002d0 <printf>
400010c4:	e9 af fe ff ff       	jmp    40000f78 <smallfile+0x38>
400010c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

400010d0 <bigfile1>:
}


void
bigfile1(void)
{
400010d0:	55                   	push   %ebp
400010d1:	57                   	push   %edi
400010d2:	56                   	push   %esi
400010d3:	53                   	push   %ebx
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
400010d4:	bb ba 2a 00 40       	mov    $0x40002aba,%ebx
400010d9:	83 ec 1c             	sub    $0x1c,%esp
  int i, fd, n;

  printf("=====big files test=====\n");
400010dc:	c7 04 24 36 2a 00 40 	movl   $0x40002a36,(%esp)
400010e3:	e8 e8 f1 ff ff       	call   400002d0 <printf>
400010e8:	b9 02 02 00 00       	mov    $0x202,%ecx
400010ed:	b8 05 00 00 00       	mov    $0x5,%eax
400010f2:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
400010f4:	85 c0                	test   %eax,%eax
400010f6:	74 18                	je     40001110 <bigfile1+0x40>

  fd = open("big", O_CREATE|O_RDWR);
  if(fd < 0){
    printf("error: creat big failed!\n");
400010f8:	c7 04 24 50 2a 00 40 	movl   $0x40002a50,(%esp)
400010ff:	e8 cc f1 ff ff       	call   400002d0 <printf>
  if(unlink("big") < 0){
    printf("unlink big failed\n");
    exit();
  }
  printf("=====big files ok=====\n\n");
}
40001104:	83 c4 1c             	add    $0x1c,%esp
40001107:	5b                   	pop    %ebx
40001108:	5e                   	pop    %esi
40001109:	5f                   	pop    %edi
4000110a:	5d                   	pop    %ebp
4000110b:	c3                   	ret    
4000110c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int i, fd, n;

  printf("=====big files test=====\n");

  fd = open("big", O_CREATE|O_RDWR);
  if(fd < 0){
40001110:	85 db                	test   %ebx,%ebx
40001112:	89 df                	mov    %ebx,%edi
40001114:	78 e2                	js     400010f8 <bigfile1+0x28>
    printf("error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
40001116:	bd a0 54 00 40       	mov    $0x400054a0,%ebp
sys_write(int fd, char *p, int n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
4000111b:	ba 00 02 00 00       	mov    $0x200,%edx
40001120:	c7 05 a0 54 00 40 00 	movl   $0x0,0x400054a0
40001127:	00 00 00 
4000112a:	b0 08                	mov    $0x8,%al
4000112c:	89 e9                	mov    %ebp,%ecx
4000112e:	cd 30                	int    $0x30
		       "b" (fd),
		       "c" (p),
		       "d" (n)
		     : "cc", "memory");

	return errno ? -1 : ret;
40001130:	85 c0                	test   %eax,%eax
40001132:	75 6c                	jne    400011a0 <bigfile1+0xd0>
    if(write(fd, buf, 512) != 512){
40001134:	81 fb 00 02 00 00    	cmp    $0x200,%ebx
4000113a:	75 64                	jne    400011a0 <bigfile1+0xd0>
  if(fd < 0){
    printf("error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
4000113c:	be 01 00 00 00       	mov    $0x1,%esi
sys_write(int fd, char *p, int n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
40001141:	ba 00 02 00 00       	mov    $0x200,%edx
40001146:	66 90                	xchg   %ax,%ax
    ((int*)buf)[0] = i;
40001148:	89 35 a0 54 00 40    	mov    %esi,0x400054a0
4000114e:	b8 08 00 00 00       	mov    $0x8,%eax
40001153:	89 fb                	mov    %edi,%ebx
40001155:	89 e9                	mov    %ebp,%ecx
40001157:	cd 30                	int    $0x30
		       "b" (fd),
		       "c" (p),
		       "d" (n)
		     : "cc", "memory");

	return errno ? -1 : ret;
40001159:	85 c0                	test   %eax,%eax
4000115b:	75 4b                	jne    400011a8 <bigfile1+0xd8>
    if(write(fd, buf, 512) != 512){
4000115d:	81 fb 00 02 00 00    	cmp    $0x200,%ebx
40001163:	75 43                	jne    400011a8 <bigfile1+0xd8>
  if(fd < 0){
    printf("error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
40001165:	83 c6 01             	add    $0x1,%esi
40001168:	81 fe 8c 00 00 00    	cmp    $0x8c,%esi
4000116e:	75 d8                	jne    40001148 <bigfile1+0x78>
40001170:	89 c1                	mov    %eax,%ecx
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
40001172:	89 fb                	mov    %edi,%ebx
40001174:	b8 06 00 00 00       	mov    $0x6,%eax
40001179:	cd 30                	int    $0x30
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
4000117b:	b8 05 00 00 00       	mov    $0x5,%eax
40001180:	bb ba 2a 00 40       	mov    $0x40002aba,%ebx
40001185:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40001187:	85 c0                	test   %eax,%eax
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001189:	89 df                	mov    %ebx,%edi
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
4000118b:	74 33                	je     400011c0 <bigfile1+0xf0>

  close(fd);

  fd = open("big", O_RDONLY);
  if(fd < 0){
    printf("error: open big failed!\n");
4000118d:	c7 04 24 88 2a 00 40 	movl   $0x40002a88,(%esp)
40001194:	e8 37 f1 ff ff       	call   400002d0 <printf>
    exit();
40001199:	e9 66 ff ff ff       	jmp    40001104 <bigfile1+0x34>
4000119e:	66 90                	xchg   %ax,%ax
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
    if(write(fd, buf, 512) != 512){
400011a0:	31 f6                	xor    %esi,%esi
400011a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      printf("error: write big file failed\n", i);
400011a8:	89 74 24 04          	mov    %esi,0x4(%esp)
400011ac:	c7 04 24 6a 2a 00 40 	movl   $0x40002a6a,(%esp)
400011b3:	e8 18 f1 ff ff       	call   400002d0 <printf>
  if(unlink("big") < 0){
    printf("unlink big failed\n");
    exit();
  }
  printf("=====big files ok=====\n\n");
}
400011b8:	83 c4 1c             	add    $0x1c,%esp
400011bb:	5b                   	pop    %ebx
400011bc:	5e                   	pop    %esi
400011bd:	5f                   	pop    %edi
400011be:	5d                   	pop    %ebp
400011bf:	c3                   	ret    
  }

  close(fd);

  fd = open("big", O_RDONLY);
  if(fd < 0){
400011c0:	85 db                	test   %ebx,%ebx
400011c2:	78 c9                	js     4000118d <bigfile1+0xbd>
400011c4:	31 f6                	xor    %esi,%esi
sys_read(int fd, char *buf, size_t n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
400011c6:	ba 00 02 00 00       	mov    $0x200,%edx
400011cb:	eb 1d                	jmp    400011ea <bigfile1+0x11a>
400011cd:	8d 76 00             	lea    0x0(%esi),%esi
  }

  n = 0;
  for(;;){
    i = read(fd, buf, 512);
    if(i == 0){
400011d0:	85 db                	test   %ebx,%ebx
		       "b" (fd),
		       "c" (buf),
		       "d" (n)
		     : "cc", "memory");

	return errno ? -1 : ret;
400011d2:	89 d8                	mov    %ebx,%eax
400011d4:	74 3d                	je     40001213 <bigfile1+0x143>
      if(n == MAXFILE - 1){
        printf("read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512){
400011d6:	81 fb 00 02 00 00    	cmp    $0x200,%ebx
400011dc:	75 20                	jne    400011fe <bigfile1+0x12e>
      printf("read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n){
400011de:	a1 a0 54 00 40       	mov    0x400054a0,%eax
400011e3:	39 f0                	cmp    %esi,%eax
400011e5:	75 5e                	jne    40001245 <bigfile1+0x175>
      printf("read content of block %d is %d\n",
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
400011e7:	83 c6 01             	add    $0x1,%esi
sys_read(int fd, char *buf, size_t n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
400011ea:	b8 07 00 00 00       	mov    $0x7,%eax
400011ef:	89 fb                	mov    %edi,%ebx
400011f1:	89 e9                	mov    %ebp,%ecx
400011f3:	cd 30                	int    $0x30
		       "b" (fd),
		       "c" (buf),
		       "d" (n)
		     : "cc", "memory");

	return errno ? -1 : ret;
400011f5:	85 c0                	test   %eax,%eax
400011f7:	74 d7                	je     400011d0 <bigfile1+0x100>
400011f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
        printf("read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512){
      printf("read failed %d\n", i);
400011fe:	89 44 24 04          	mov    %eax,0x4(%esp)
40001202:	c7 04 24 be 2a 00 40 	movl   $0x40002abe,(%esp)
40001209:	e8 c2 f0 ff ff       	call   400002d0 <printf>
      exit();
4000120e:	e9 f1 fe ff ff       	jmp    40001104 <bigfile1+0x34>

  n = 0;
  for(;;){
    i = read(fd, buf, 512);
    if(i == 0){
      if(n == MAXFILE - 1){
40001213:	81 fe 8b 00 00 00    	cmp    $0x8b,%esi
40001219:	74 43                	je     4000125e <bigfile1+0x18e>
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
4000121b:	b8 06 00 00 00       	mov    $0x6,%eax
40001220:	89 fb                	mov    %edi,%ebx
40001222:	cd 30                	int    $0x30
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001224:	b8 0c 00 00 00       	mov    $0xc,%eax
40001229:	bb ba 2a 00 40       	mov    $0x40002aba,%ebx
4000122e:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_unlink),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001230:	85 c0                	test   %eax,%eax
40001232:	74 43                	je     40001277 <bigfile1+0x1a7>
    }
    n++;
  }
  close(fd);
  if(unlink("big") < 0){
    printf("unlink big failed\n");
40001234:	c7 04 24 ce 2a 00 40 	movl   $0x40002ace,(%esp)
4000123b:	e8 90 f0 ff ff       	call   400002d0 <printf>
    exit();
40001240:	e9 bf fe ff ff       	jmp    40001104 <bigfile1+0x34>
    } else if(i != 512){
      printf("read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n){
      printf("read content of block %d is %d\n",
40001245:	89 44 24 08          	mov    %eax,0x8(%esp)
40001249:	89 74 24 04          	mov    %esi,0x4(%esp)
4000124d:	c7 04 24 68 34 00 40 	movl   $0x40003468,(%esp)
40001254:	e8 77 f0 ff ff       	call   400002d0 <printf>
             n, ((int*)buf)[0]);
      exit();
40001259:	e9 a6 fe ff ff       	jmp    40001104 <bigfile1+0x34>
  n = 0;
  for(;;){
    i = read(fd, buf, 512);
    if(i == 0){
      if(n == MAXFILE - 1){
        printf("read only %d blocks from big", n);
4000125e:	c7 44 24 04 8b 00 00 	movl   $0x8b,0x4(%esp)
40001265:	00 
40001266:	c7 04 24 a1 2a 00 40 	movl   $0x40002aa1,(%esp)
4000126d:	e8 5e f0 ff ff       	call   400002d0 <printf>
        exit();
40001272:	e9 8d fe ff ff       	jmp    40001104 <bigfile1+0x34>
  close(fd);
  if(unlink("big") < 0){
    printf("unlink big failed\n");
    exit();
  }
  printf("=====big files ok=====\n\n");
40001277:	c7 04 24 e1 2a 00 40 	movl   $0x40002ae1,(%esp)
4000127e:	e8 4d f0 ff ff       	call   400002d0 <printf>
40001283:	e9 7c fe ff ff       	jmp    40001104 <bigfile1+0x34>
40001288:	90                   	nop
40001289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40001290 <createtest>:
}

void
createtest(void)
{
40001290:	55                   	push   %ebp
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001291:	bd 05 00 00 00       	mov    $0x5,%ebp
40001296:	57                   	push   %edi
  int i, fd;

  printf("=====many creates, followed by unlink test=====\n");

  name[0] = 'a';
  name[2] = '\0';
40001297:	bf 30 00 00 00       	mov    $0x30,%edi
  printf("=====big files ok=====\n\n");
}

void
createtest(void)
{
4000129c:	56                   	push   %esi
4000129d:	be a0 74 00 40       	mov    $0x400074a0,%esi
400012a2:	53                   	push   %ebx
400012a3:	83 ec 1c             	sub    $0x1c,%esp
  int i, fd;

  printf("=====many creates, followed by unlink test=====\n");
400012a6:	c7 04 24 88 34 00 40 	movl   $0x40003488,(%esp)
400012ad:	e8 1e f0 ff ff       	call   400002d0 <printf>
400012b2:	b9 02 02 00 00       	mov    $0x202,%ecx

  name[0] = 'a';
400012b7:	c6 05 a0 74 00 40 61 	movb   $0x61,0x400074a0
  name[2] = '\0';
400012be:	c6 05 a2 74 00 40 00 	movb   $0x0,0x400074a2
400012c5:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 10; i++){
    name[1] = '0' + i;
400012c8:	89 f8                	mov    %edi,%eax
400012ca:	89 f3                	mov    %esi,%ebx
400012cc:	a2 a1 74 00 40       	mov    %al,0x400074a1
400012d1:	89 e8                	mov    %ebp,%eax
400012d3:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
400012d5:	ba ff ff ff ff       	mov    $0xffffffff,%edx
400012da:	85 c0                	test   %eax,%eax
400012dc:	0f 44 d3             	cmove  %ebx,%edx
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
400012df:	b8 06 00 00 00       	mov    $0x6,%eax
400012e4:	89 d3                	mov    %edx,%ebx
400012e6:	cd 30                	int    $0x30
400012e8:	83 c7 01             	add    $0x1,%edi

  printf("=====many creates, followed by unlink test=====\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 10; i++){
400012eb:	89 f8                	mov    %edi,%eax
400012ed:	3c 3a                	cmp    $0x3a,%al
400012ef:	75 d7                	jne    400012c8 <createtest+0x38>
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
400012f1:	c6 05 a0 74 00 40 61 	movb   $0x61,0x400074a0
  name[2] = '\0';
400012f8:	ba 30 00 00 00       	mov    $0x30,%edx
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
400012fd:	b9 0c 00 00 00       	mov    $0xc,%ecx
40001302:	c6 05 a2 74 00 40 00 	movb   $0x0,0x400074a2
40001309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 10; i++){
    name[1] = '0' + i;
40001310:	88 15 a1 74 00 40    	mov    %dl,0x400074a1
40001316:	89 c8                	mov    %ecx,%eax
40001318:	89 f3                	mov    %esi,%ebx
4000131a:	cd 30                	int    $0x30
4000131c:	83 c2 01             	add    $0x1,%edx
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 10; i++){
4000131f:	80 fa 3a             	cmp    $0x3a,%dl
40001322:	75 ec                	jne    40001310 <createtest+0x80>
    name[1] = '0' + i;
    unlink(name);
  }
  printf("=====many creates, followed by unlink; ok=====\n\n");
40001324:	c7 04 24 bc 34 00 40 	movl   $0x400034bc,(%esp)
4000132b:	e8 a0 ef ff ff       	call   400002d0 <printf>
}
40001330:	83 c4 1c             	add    $0x1c,%esp
40001333:	5b                   	pop    %ebx
40001334:	5e                   	pop    %esi
40001335:	5f                   	pop    %edi
40001336:	5d                   	pop    %ebp
40001337:	c3                   	ret    
40001338:	90                   	nop
40001339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40001340 <rmdot>:

void
rmdot(void)
{
40001340:	56                   	push   %esi
static gcc_inline int
sys_mkdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001341:	be 10 2b 00 40       	mov    $0x40002b10,%esi
40001346:	53                   	push   %ebx
40001347:	89 f3                	mov    %esi,%ebx
40001349:	83 ec 14             	sub    $0x14,%esp
  printf("=====rmdot test=====\n");
4000134c:	c7 04 24 fa 2a 00 40 	movl   $0x40002afa,(%esp)
40001353:	e8 78 ef ff ff       	call   400002d0 <printf>
40001358:	b8 09 00 00 00       	mov    $0x9,%eax
4000135d:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_mkdir),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
4000135f:	85 c0                	test   %eax,%eax
40001361:	74 15                	je     40001378 <rmdot+0x38>
  if(mkdir("dots") != 0){
    printf("mkdir dots failed\n");
40001363:	c7 04 24 1c 2b 00 40 	movl   $0x40002b1c,(%esp)
4000136a:	e8 61 ef ff ff       	call   400002d0 <printf>
  if(unlink("dots") != 0){
    printf("unlink dots failed!\n");
    exit();
  }
  printf("=====rmdot ok=====\n\n");
}
4000136f:	83 c4 14             	add    $0x14,%esp
40001372:	5b                   	pop    %ebx
40001373:	5e                   	pop    %esi
40001374:	c3                   	ret    
40001375:	8d 76 00             	lea    0x0(%esi),%esi
static gcc_inline int
sys_chdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001378:	ba 0a 00 00 00       	mov    $0xa,%edx
4000137d:	89 f3                	mov    %esi,%ebx
4000137f:	89 d0                	mov    %edx,%eax
40001381:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_chdir),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001383:	85 c0                	test   %eax,%eax
40001385:	74 19                	je     400013a0 <rmdot+0x60>
  if(mkdir("dots") != 0){
    printf("mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
    printf("chdir dots failed\n");
40001387:	c7 04 24 2f 2b 00 40 	movl   $0x40002b2f,(%esp)
4000138e:	e8 3d ef ff ff       	call   400002d0 <printf>
  if(unlink("dots") != 0){
    printf("unlink dots failed!\n");
    exit();
  }
  printf("=====rmdot ok=====\n\n");
}
40001393:	83 c4 14             	add    $0x14,%esp
40001396:	5b                   	pop    %ebx
40001397:	5e                   	pop    %esi
40001398:	c3                   	ret    
40001399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
400013a0:	b9 0c 00 00 00       	mov    $0xc,%ecx
400013a5:	bb 16 2f 00 40       	mov    $0x40002f16,%ebx
400013aa:	89 c8                	mov    %ecx,%eax
400013ac:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_unlink),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
400013ae:	85 c0                	test   %eax,%eax
400013b0:	74 5e                	je     40001410 <rmdot+0xd0>
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
400013b2:	bb 15 2f 00 40       	mov    $0x40002f15,%ebx
400013b7:	89 c8                	mov    %ecx,%eax
400013b9:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_unlink),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
400013bb:	85 c0                	test   %eax,%eax
400013bd:	74 69                	je     40001428 <rmdot+0xe8>
static gcc_inline int
sys_chdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
400013bf:	bb 5f 2b 00 40       	mov    $0x40002b5f,%ebx
400013c4:	89 d0                	mov    %edx,%eax
400013c6:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_chdir),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
400013c8:	85 c0                	test   %eax,%eax
400013ca:	74 0c                	je     400013d8 <rmdot+0x98>
  if(unlink("..") == 0){
    printf("rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
    printf("chdir '/' failed\n");
400013cc:	c7 04 24 61 2b 00 40 	movl   $0x40002b61,(%esp)
400013d3:	e8 f8 ee ff ff       	call   400002d0 <printf>
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
400013d8:	ba 0c 00 00 00       	mov    $0xc,%edx
400013dd:	bb 15 2b 00 40       	mov    $0x40002b15,%ebx
400013e2:	89 d0                	mov    %edx,%eax
400013e4:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_unlink),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
400013e6:	85 c0                	test   %eax,%eax
400013e8:	74 56                	je     40001440 <rmdot+0x100>
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
400013ea:	bb 8a 2b 00 40       	mov    $0x40002b8a,%ebx
400013ef:	89 d0                	mov    %edx,%eax
400013f1:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_unlink),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
400013f3:	85 c0                	test   %eax,%eax
400013f5:	75 61                	jne    40001458 <rmdot+0x118>
  if(unlink("dots/.") == 0){
    printf("unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
    printf("unlink dots/.. worked!\n");
400013f7:	c7 04 24 92 2b 00 40 	movl   $0x40002b92,(%esp)
400013fe:	e8 cd ee ff ff       	call   400002d0 <printf>
  if(unlink("dots") != 0){
    printf("unlink dots failed!\n");
    exit();
  }
  printf("=====rmdot ok=====\n\n");
}
40001403:	83 c4 14             	add    $0x14,%esp
40001406:	5b                   	pop    %ebx
40001407:	5e                   	pop    %esi
40001408:	c3                   	ret    
40001409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(chdir("dots") != 0){
    printf("chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
    printf("rm . worked!\n");
40001410:	c7 04 24 42 2b 00 40 	movl   $0x40002b42,(%esp)
40001417:	e8 b4 ee ff ff       	call   400002d0 <printf>
  if(unlink("dots") != 0){
    printf("unlink dots failed!\n");
    exit();
  }
  printf("=====rmdot ok=====\n\n");
}
4000141c:	83 c4 14             	add    $0x14,%esp
4000141f:	5b                   	pop    %ebx
40001420:	5e                   	pop    %esi
40001421:	c3                   	ret    
40001422:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(unlink(".") == 0){
    printf("rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
    printf("rm .. worked!\n");
40001428:	c7 04 24 50 2b 00 40 	movl   $0x40002b50,(%esp)
4000142f:	e8 9c ee ff ff       	call   400002d0 <printf>
  if(unlink("dots") != 0){
    printf("unlink dots failed!\n");
    exit();
  }
  printf("=====rmdot ok=====\n\n");
}
40001434:	83 c4 14             	add    $0x14,%esp
40001437:	5b                   	pop    %ebx
40001438:	5e                   	pop    %esi
40001439:	c3                   	ret    
4000143a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(chdir("/") != 0){
    printf("chdir '/' failed\n");
    //    exit();
  }
  if(unlink("dots/.") == 0){
    printf("unlink dots/. worked!\n");
40001440:	c7 04 24 73 2b 00 40 	movl   $0x40002b73,(%esp)
40001447:	e8 84 ee ff ff       	call   400002d0 <printf>
    exit();
4000144c:	e9 1e ff ff ff       	jmp    4000136f <rmdot+0x2f>
40001451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001458:	89 d0                	mov    %edx,%eax
4000145a:	89 f3                	mov    %esi,%ebx
4000145c:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_unlink),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
4000145e:	85 c0                	test   %eax,%eax
40001460:	74 16                	je     40001478 <rmdot+0x138>
  if(unlink("dots/..") == 0){
    printf("unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
    printf("unlink dots failed!\n");
40001462:	c7 04 24 aa 2b 00 40 	movl   $0x40002baa,(%esp)
40001469:	e8 62 ee ff ff       	call   400002d0 <printf>
    exit();
4000146e:	e9 fc fe ff ff       	jmp    4000136f <rmdot+0x2f>
40001473:	90                   	nop
40001474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  printf("=====rmdot ok=====\n\n");
40001478:	c7 04 24 bf 2b 00 40 	movl   $0x40002bbf,(%esp)
4000147f:	e8 4c ee ff ff       	call   400002d0 <printf>
40001484:	e9 e6 fe ff ff       	jmp    4000136f <rmdot+0x2f>
40001489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40001490 <fourteen>:
}


void
fourteen(void)
{
40001490:	55                   	push   %ebp
40001491:	57                   	push   %edi
40001492:	56                   	push   %esi
40001493:	53                   	push   %ebx
static gcc_inline int
sys_mkdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001494:	bb fc 2b 00 40       	mov    $0x40002bfc,%ebx
40001499:	83 ec 1c             	sub    $0x1c,%esp
  int fd;

  // DIRSIZ is 14.
  printf("=====fourteen test=====\n");
4000149c:	c7 04 24 d4 2b 00 40 	movl   $0x40002bd4,(%esp)
400014a3:	e8 28 ee ff ff       	call   400002d0 <printf>
400014a8:	ba 09 00 00 00       	mov    $0x9,%edx
400014ad:	89 d0                	mov    %edx,%eax
400014af:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_mkdir),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
400014b1:	85 c0                	test   %eax,%eax
400014b3:	74 1b                	je     400014d0 <fourteen+0x40>

  if(mkdir("12345678901234") != 0){
    printf("mkdir 12345678901234 failed\n");
400014b5:	c7 04 24 0b 2c 00 40 	movl   $0x40002c0b,(%esp)
400014bc:	e8 0f ee ff ff       	call   400002d0 <printf>
    printf("mkdir 12345678901234/123456789012345 succeeded!\n");
    exit();
  }

  printf("=====fourteen ok=====\n\n");
}
400014c1:	83 c4 1c             	add    $0x1c,%esp
400014c4:	5b                   	pop    %ebx
400014c5:	5e                   	pop    %esi
400014c6:	5f                   	pop    %edi
400014c7:	5d                   	pop    %ebp
400014c8:	c3                   	ret    
400014c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static gcc_inline int
sys_mkdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
400014d0:	bd 9c 35 00 40       	mov    $0x4000359c,%ebp
400014d5:	89 d0                	mov    %edx,%eax
400014d7:	89 eb                	mov    %ebp,%ebx
400014d9:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_mkdir),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
400014db:	85 c0                	test   %eax,%eax
400014dd:	74 19                	je     400014f8 <fourteen+0x68>
  if(mkdir("12345678901234") != 0){
    printf("mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    printf("mkdir 12345678901234/123456789012345 failed\n");
400014df:	c7 04 24 bc 35 00 40 	movl   $0x400035bc,(%esp)
400014e6:	e8 e5 ed ff ff       	call   400002d0 <printf>
    printf("mkdir 12345678901234/123456789012345 succeeded!\n");
    exit();
  }

  printf("=====fourteen ok=====\n\n");
}
400014eb:	83 c4 1c             	add    $0x1c,%esp
400014ee:	5b                   	pop    %ebx
400014ef:	5e                   	pop    %esi
400014f0:	5f                   	pop    %edi
400014f1:	5d                   	pop    %ebp
400014f2:	c3                   	ret    
400014f3:	90                   	nop
400014f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
400014f8:	bf 05 00 00 00       	mov    $0x5,%edi
400014fd:	b9 00 02 00 00       	mov    $0x200,%ecx
40001502:	bb ec 35 00 40       	mov    $0x400035ec,%ebx
40001507:	89 f8                	mov    %edi,%eax
40001509:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
4000150b:	85 c0                	test   %eax,%eax
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
4000150d:	89 c1                	mov    %eax,%ecx
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
4000150f:	0f 85 9b 00 00 00    	jne    400015b0 <fourteen+0x120>
  if(mkdir("12345678901234/123456789012345") != 0){
    printf("mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
  if(fd < 0){
40001515:	85 db                	test   %ebx,%ebx
40001517:	0f 88 93 00 00 00    	js     400015b0 <fourteen+0x120>
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
4000151d:	be 06 00 00 00       	mov    $0x6,%esi
40001522:	89 f0                	mov    %esi,%eax
40001524:	cd 30                	int    $0x30
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001526:	bb 30 35 00 40       	mov    $0x40003530,%ebx
4000152b:	89 f8                	mov    %edi,%eax
4000152d:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
4000152f:	85 c0                	test   %eax,%eax
40001531:	74 15                	je     40001548 <fourteen+0xb8>
    exit();
  }
  close(fd);
  fd = open("12345678901234/12345678901234/12345678901234", 0);
  if(fd < 0){
    printf("open 12345678901234/12345678901234/12345678901234 failed\n");
40001533:	c7 04 24 60 35 00 40 	movl   $0x40003560,(%esp)
4000153a:	e8 91 ed ff ff       	call   400002d0 <printf>
    exit();
4000153f:	eb 80                	jmp    400014c1 <fourteen+0x31>
40001541:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    printf("create 123456789012345/123456789012345/123456789012345 failed\n");
    exit();
  }
  close(fd);
  fd = open("12345678901234/12345678901234/12345678901234", 0);
  if(fd < 0){
40001548:	85 db                	test   %ebx,%ebx
4000154a:	78 e7                	js     40001533 <fourteen+0xa3>
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
4000154c:	89 f0                	mov    %esi,%eax
4000154e:	cd 30                	int    $0x30
static gcc_inline int
sys_mkdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001550:	bb ed 2b 00 40       	mov    $0x40002bed,%ebx
40001555:	89 d0                	mov    %edx,%eax
40001557:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_mkdir),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001559:	85 c0                	test   %eax,%eax
4000155b:	74 3b                	je     40001598 <fourteen+0x108>
static gcc_inline int
sys_mkdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
4000155d:	89 d0                	mov    %edx,%eax
4000155f:	89 eb                	mov    %ebp,%ebx
40001561:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_mkdir),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001563:	85 c0                	test   %eax,%eax
40001565:	74 19                	je     40001580 <fourteen+0xf0>
  if(mkdir("12345678901234/123456789012345") == 0){
    printf("mkdir 12345678901234/123456789012345 succeeded!\n");
    exit();
  }

  printf("=====fourteen ok=====\n\n");
40001567:	c7 04 24 28 2c 00 40 	movl   $0x40002c28,(%esp)
4000156e:	e8 5d ed ff ff       	call   400002d0 <printf>
}
40001573:	83 c4 1c             	add    $0x1c,%esp
40001576:	5b                   	pop    %ebx
40001577:	5e                   	pop    %esi
40001578:	5f                   	pop    %edi
40001579:	5d                   	pop    %ebp
4000157a:	c3                   	ret    
4000157b:	90                   	nop
4000157c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mkdir("12345678901234/12345678901234") == 0){
    printf("mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") == 0){
    printf("mkdir 12345678901234/123456789012345 succeeded!\n");
40001580:	c7 04 24 4c 36 00 40 	movl   $0x4000364c,(%esp)
40001587:	e8 44 ed ff ff       	call   400002d0 <printf>
    exit();
  }

  printf("=====fourteen ok=====\n\n");
}
4000158c:	83 c4 1c             	add    $0x1c,%esp
4000158f:	5b                   	pop    %ebx
40001590:	5e                   	pop    %esi
40001591:	5f                   	pop    %edi
40001592:	5d                   	pop    %ebp
40001593:	c3                   	ret    
40001594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit();
  }
  close(fd);

  if(mkdir("12345678901234/12345678901234") == 0){
    printf("mkdir 12345678901234/12345678901234 succeeded!\n");
40001598:	c7 04 24 1c 36 00 40 	movl   $0x4000361c,(%esp)
4000159f:	e8 2c ed ff ff       	call   400002d0 <printf>
    printf("mkdir 12345678901234/123456789012345 succeeded!\n");
    exit();
  }

  printf("=====fourteen ok=====\n\n");
}
400015a4:	83 c4 1c             	add    $0x1c,%esp
400015a7:	5b                   	pop    %ebx
400015a8:	5e                   	pop    %esi
400015a9:	5f                   	pop    %edi
400015aa:	5d                   	pop    %ebp
400015ab:	c3                   	ret    
400015ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf("mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
  if(fd < 0){
    printf("create 123456789012345/123456789012345/123456789012345 failed\n");
400015b0:	c7 04 24 f0 34 00 40 	movl   $0x400034f0,(%esp)
400015b7:	e8 14 ed ff ff       	call   400002d0 <printf>
    exit();
400015bc:	e9 00 ff ff ff       	jmp    400014c1 <fourteen+0x31>
400015c1:	eb 0d                	jmp    400015d0 <bigfile2>
400015c3:	90                   	nop
400015c4:	90                   	nop
400015c5:	90                   	nop
400015c6:	90                   	nop
400015c7:	90                   	nop
400015c8:	90                   	nop
400015c9:	90                   	nop
400015ca:	90                   	nop
400015cb:	90                   	nop
400015cc:	90                   	nop
400015cd:	90                   	nop
400015ce:	90                   	nop
400015cf:	90                   	nop

400015d0 <bigfile2>:
  printf("=====fourteen ok=====\n\n");
}

void
bigfile2(void)
{
400015d0:	55                   	push   %ebp
400015d1:	57                   	push   %edi
400015d2:	56                   	push   %esi
400015d3:	53                   	push   %ebx
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
400015d4:	bb 66 2c 00 40       	mov    $0x40002c66,%ebx
400015d9:	83 ec 1c             	sub    $0x1c,%esp
  int fd, i, total, cc;

  printf("=====bigfile test=====\n");
400015dc:	c7 04 24 40 2c 00 40 	movl   $0x40002c40,(%esp)
400015e3:	e8 e8 ec ff ff       	call   400002d0 <printf>
400015e8:	b8 0c 00 00 00       	mov    $0xc,%eax
400015ed:	cd 30                	int    $0x30
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
400015ef:	b9 02 02 00 00       	mov    $0x202,%ecx
400015f4:	b8 05 00 00 00       	mov    $0x5,%eax
400015f9:	bb 66 2c 00 40       	mov    $0x40002c66,%ebx
400015fe:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40001600:	85 c0                	test   %eax,%eax
40001602:	74 14                	je     40001618 <bigfile2+0x48>

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf("cannot create bigfile");
40001604:	c7 04 24 58 2c 00 40 	movl   $0x40002c58,(%esp)
4000160b:	e8 c0 ec ff ff       	call   400002d0 <printf>
    exit();
  }
  unlink("bigfile");

  printf("=====bigfile test ok=====\n\n");
}
40001610:	83 c4 1c             	add    $0x1c,%esp
40001613:	5b                   	pop    %ebx
40001614:	5e                   	pop    %esi
40001615:	5f                   	pop    %edi
40001616:	5d                   	pop    %ebp
40001617:	c3                   	ret    

  printf("=====bigfile test=====\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
40001618:	85 db                	test   %ebx,%ebx
4000161a:	89 df                	mov    %ebx,%edi
4000161c:	78 e6                	js     40001604 <bigfile2+0x34>
4000161e:	31 f6                	xor    %esi,%esi
sys_write(int fd, char *p, int n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
40001620:	bd 08 00 00 00       	mov    $0x8,%ebp
40001625:	8d 76 00             	lea    0x0(%esi),%esi
    printf("cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
40001628:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
4000162f:	00 
40001630:	89 fb                	mov    %edi,%ebx
40001632:	89 74 24 04          	mov    %esi,0x4(%esp)
40001636:	c7 04 24 a0 54 00 40 	movl   $0x400054a0,(%esp)
4000163d:	e8 6e f7 ff ff       	call   40000db0 <memset>
40001642:	ba 58 02 00 00       	mov    $0x258,%edx
40001647:	89 e8                	mov    %ebp,%eax
40001649:	b9 a0 54 00 40       	mov    $0x400054a0,%ecx
4000164e:	cd 30                	int    $0x30
		       "b" (fd),
		       "c" (p),
		       "d" (n)
		     : "cc", "memory");

	return errno ? -1 : ret;
40001650:	85 c0                	test   %eax,%eax
40001652:	74 14                	je     40001668 <bigfile2+0x98>
    if(write(fd, buf, 600) != 600){
      printf("write bigfile failed\n");
40001654:	c7 04 24 6e 2c 00 40 	movl   $0x40002c6e,(%esp)
4000165b:	e8 70 ec ff ff       	call   400002d0 <printf>
    exit();
  }
  unlink("bigfile");

  printf("=====bigfile test ok=====\n\n");
}
40001660:	83 c4 1c             	add    $0x1c,%esp
40001663:	5b                   	pop    %ebx
40001664:	5e                   	pop    %esi
40001665:	5f                   	pop    %edi
40001666:	5d                   	pop    %ebp
40001667:	c3                   	ret    
    printf("cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    if(write(fd, buf, 600) != 600){
40001668:	81 fb 58 02 00 00    	cmp    $0x258,%ebx
4000166e:	75 e4                	jne    40001654 <bigfile2+0x84>
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf("cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
40001670:	83 c6 01             	add    $0x1,%esi
40001673:	83 fe 14             	cmp    $0x14,%esi
40001676:	75 b0                	jne    40001628 <bigfile2+0x58>
40001678:	89 c1                	mov    %eax,%ecx
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
4000167a:	89 fb                	mov    %edi,%ebx
4000167c:	b8 06 00 00 00       	mov    $0x6,%eax
40001681:	cd 30                	int    $0x30
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001683:	b8 05 00 00 00       	mov    $0x5,%eax
40001688:	bb 66 2c 00 40       	mov    $0x40002c66,%ebx
4000168d:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
4000168f:	85 c0                	test   %eax,%eax
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001691:	89 dd                	mov    %ebx,%ebp
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40001693:	74 13                	je     400016a8 <bigfile2+0xd8>
  }
  close(fd);

  fd = open("bigfile", 0);
  if(fd < 0){
    printf("cannot open bigfile\n");
40001695:	c7 04 24 99 2c 00 40 	movl   $0x40002c99,(%esp)
4000169c:	e8 2f ec ff ff       	call   400002d0 <printf>
    exit();
400016a1:	e9 6a ff ff ff       	jmp    40001610 <bigfile2+0x40>
400016a6:	66 90                	xchg   %ax,%ax
    }
  }
  close(fd);

  fd = open("bigfile", 0);
  if(fd < 0){
400016a8:	85 db                	test   %ebx,%ebx
400016aa:	78 e9                	js     40001695 <bigfile2+0xc5>
sys_read(int fd, char *buf, size_t n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
400016ac:	ba 2c 01 00 00       	mov    $0x12c,%edx
400016b1:	b0 07                	mov    $0x7,%al
400016b3:	b9 a0 54 00 40       	mov    $0x400054a0,%ecx
400016b8:	cd 30                	int    $0x30
		       "b" (fd),
		       "c" (buf),
		       "d" (n)
		     : "cc", "memory");

	return errno ? -1 : ret;
400016ba:	85 c0                	test   %eax,%eax
400016bc:	75 7d                	jne    4000173b <bigfile2+0x16b>
    exit();
  }
  total = 0;
  for(i = 0; ; i++){
    cc = read(fd, buf, 300);
    if(cc < 0){
400016be:	85 db                	test   %ebx,%ebx
400016c0:	78 79                	js     4000173b <bigfile2+0x16b>
      printf("read bigfile failed\n");
      exit();
    }
    if(cc == 0)
400016c2:	0f 84 99 00 00 00    	je     40001761 <bigfile2+0x191>
      break;
    if(cc != 300){
400016c8:	81 fb 2c 01 00 00    	cmp    $0x12c,%ebx
400016ce:	66 90                	xchg   %ax,%ax
400016d0:	0f 85 af 00 00 00    	jne    40001785 <bigfile2+0x1b5>
      printf("short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
400016d6:	80 3d a0 54 00 40 00 	cmpb   $0x0,0x400054a0
400016dd:	75 71                	jne    40001750 <bigfile2+0x180>
400016df:	80 3d cb 55 00 40 00 	cmpb   $0x0,0x400055cb
400016e6:	75 68                	jne    40001750 <bigfile2+0x180>
400016e8:	31 ff                	xor    %edi,%edi
400016ea:	31 f6                	xor    %esi,%esi
sys_read(int fd, char *buf, size_t n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
400016ec:	ba 2c 01 00 00       	mov    $0x12c,%edx
400016f1:	eb 2d                	jmp    40001720 <bigfile2+0x150>
400016f3:	90                   	nop
400016f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit();
  }
  total = 0;
  for(i = 0; ; i++){
    cc = read(fd, buf, 300);
    if(cc < 0){
400016f8:	85 db                	test   %ebx,%ebx
400016fa:	78 3f                	js     4000173b <bigfile2+0x16b>
      printf("read bigfile failed\n");
      exit();
    }
    if(cc == 0)
400016fc:	74 65                	je     40001763 <bigfile2+0x193>
      break;
    if(cc != 300){
400016fe:	81 fb 2c 01 00 00    	cmp    $0x12c,%ebx
40001704:	75 7f                	jne    40001785 <bigfile2+0x1b5>
      printf("short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
40001706:	0f be 05 a0 54 00 40 	movsbl 0x400054a0,%eax
4000170d:	89 f1                	mov    %esi,%ecx
4000170f:	d1 f9                	sar    %ecx
40001711:	39 c8                	cmp    %ecx,%eax
40001713:	75 3b                	jne    40001750 <bigfile2+0x180>
40001715:	0f be 0d cb 55 00 40 	movsbl 0x400055cb,%ecx
4000171c:	39 c8                	cmp    %ecx,%eax
4000171e:	75 30                	jne    40001750 <bigfile2+0x180>
      printf("read bigfile wrong data\n");
      exit();
    }
    total += cc;
40001720:	81 c7 2c 01 00 00    	add    $0x12c,%edi
  if(fd < 0){
    printf("cannot open bigfile\n");
    exit();
  }
  total = 0;
  for(i = 0; ; i++){
40001726:	83 c6 01             	add    $0x1,%esi
40001729:	b8 07 00 00 00       	mov    $0x7,%eax
4000172e:	89 eb                	mov    %ebp,%ebx
40001730:	b9 a0 54 00 40       	mov    $0x400054a0,%ecx
40001735:	cd 30                	int    $0x30
		       "b" (fd),
		       "c" (buf),
		       "d" (n)
		     : "cc", "memory");

	return errno ? -1 : ret;
40001737:	85 c0                	test   %eax,%eax
40001739:	74 bd                	je     400016f8 <bigfile2+0x128>
    cc = read(fd, buf, 300);
    if(cc < 0){
      printf("read bigfile failed\n");
4000173b:	c7 04 24 84 2c 00 40 	movl   $0x40002c84,(%esp)
40001742:	e8 89 eb ff ff       	call   400002d0 <printf>
    exit();
  }
  unlink("bigfile");

  printf("=====bigfile test ok=====\n\n");
}
40001747:	83 c4 1c             	add    $0x1c,%esp
4000174a:	5b                   	pop    %ebx
4000174b:	5e                   	pop    %esi
4000174c:	5f                   	pop    %edi
4000174d:	5d                   	pop    %ebp
4000174e:	c3                   	ret    
4000174f:	90                   	nop
    if(cc != 300){
      printf("short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
      printf("read bigfile wrong data\n");
40001750:	c7 04 24 c2 2c 00 40 	movl   $0x40002cc2,(%esp)
40001757:	e8 74 eb ff ff       	call   400002d0 <printf>
      exit();
4000175c:	e9 af fe ff ff       	jmp    40001610 <bigfile2+0x40>
    cc = read(fd, buf, 300);
    if(cc < 0){
      printf("read bigfile failed\n");
      exit();
    }
    if(cc == 0)
40001761:	31 ff                	xor    %edi,%edi
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
40001763:	b8 06 00 00 00       	mov    $0x6,%eax
40001768:	89 eb                	mov    %ebp,%ebx
4000176a:	cd 30                	int    $0x30
      exit();
    }
    total += cc;
  }
  close(fd);
  if(total != 20*600){
4000176c:	81 ff e0 2e 00 00    	cmp    $0x2ee0,%edi
40001772:	74 22                	je     40001796 <bigfile2+0x1c6>
    printf("read bigfile wrong total\n");
40001774:	c7 04 24 db 2c 00 40 	movl   $0x40002cdb,(%esp)
4000177b:	e8 50 eb ff ff       	call   400002d0 <printf>
    exit();
40001780:	e9 8b fe ff ff       	jmp    40001610 <bigfile2+0x40>
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
      printf("short read bigfile\n");
40001785:	c7 04 24 ae 2c 00 40 	movl   $0x40002cae,(%esp)
4000178c:	e8 3f eb ff ff       	call   400002d0 <printf>
      exit();
40001791:	e9 7a fe ff ff       	jmp    40001610 <bigfile2+0x40>
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001796:	b8 0c 00 00 00       	mov    $0xc,%eax
4000179b:	bb 66 2c 00 40       	mov    $0x40002c66,%ebx
400017a0:	cd 30                	int    $0x30
    printf("read bigfile wrong total\n");
    exit();
  }
  unlink("bigfile");

  printf("=====bigfile test ok=====\n\n");
400017a2:	c7 04 24 f5 2c 00 40 	movl   $0x40002cf5,(%esp)
400017a9:	e8 22 eb ff ff       	call   400002d0 <printf>
400017ae:	e9 5d fe ff ff       	jmp    40001610 <bigfile2+0x40>
400017b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
400017b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

400017c0 <subdir>:
}


void
subdir(void)
{
400017c0:	55                   	push   %ebp
400017c1:	57                   	push   %edi
400017c2:	bf 61 2d 00 40       	mov    $0x40002d61,%edi
400017c7:	56                   	push   %esi
400017c8:	be 0c 00 00 00       	mov    $0xc,%esi
400017cd:	53                   	push   %ebx
400017ce:	89 fb                	mov    %edi,%ebx
400017d0:	83 ec 1c             	sub    $0x1c,%esp
  int fd, cc;

  printf("=====subdir test=====\n");
400017d3:	c7 04 24 11 2d 00 40 	movl   $0x40002d11,(%esp)
400017da:	e8 f1 ea ff ff       	call   400002d0 <printf>
400017df:	89 f0                	mov    %esi,%eax
400017e1:	cd 30                	int    $0x30
static gcc_inline int
sys_mkdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
400017e3:	b8 09 00 00 00       	mov    $0x9,%eax
400017e8:	bb 10 2f 00 40       	mov    $0x40002f10,%ebx
400017ed:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_mkdir),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
400017ef:	85 c0                	test   %eax,%eax
400017f1:	74 15                	je     40001808 <subdir+0x48>

  unlink("ff");
  if(mkdir("dd") != 0){
    printf("subdir mkdir dd failed\n");
400017f3:	c7 04 24 7c 2e 00 40 	movl   $0x40002e7c,(%esp)
400017fa:	e8 d1 ea ff ff       	call   400002d0 <printf>
    printf("unlink dd failed\n");
    exit();
  }

  printf("=====subdir ok=====\n\n");
}
400017ff:	83 c4 1c             	add    $0x1c,%esp
40001802:	5b                   	pop    %ebx
40001803:	5e                   	pop    %esi
40001804:	5f                   	pop    %edi
40001805:	5d                   	pop    %ebp
40001806:	c3                   	ret    
40001807:	90                   	nop
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001808:	b8 05 00 00 00       	mov    $0x5,%eax
4000180d:	bb 9b 2d 00 40       	mov    $0x40002d9b,%ebx
40001812:	b9 02 02 00 00       	mov    $0x202,%ecx
40001817:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40001819:	85 c0                	test   %eax,%eax
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
4000181b:	89 dd                	mov    %ebx,%ebp
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
4000181d:	0f 85 dd 00 00 00    	jne    40001900 <subdir+0x140>
    printf("subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
40001823:	85 ed                	test   %ebp,%ebp
40001825:	0f 88 d5 00 00 00    	js     40001900 <subdir+0x140>
sys_write(int fd, char *p, int n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
4000182b:	ba 02 00 00 00       	mov    $0x2,%edx
40001830:	b8 08 00 00 00       	mov    $0x8,%eax
40001835:	89 eb                	mov    %ebp,%ebx
40001837:	89 f9                	mov    %edi,%ecx
40001839:	cd 30                	int    $0x30
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
4000183b:	bf 06 00 00 00       	mov    $0x6,%edi
40001840:	89 eb                	mov    %ebp,%ebx
40001842:	89 f8                	mov    %edi,%eax
40001844:	cd 30                	int    $0x30
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001846:	bb 10 2f 00 40       	mov    $0x40002f10,%ebx
4000184b:	89 f0                	mov    %esi,%eax
4000184d:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_unlink),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
4000184f:	85 c0                	test   %eax,%eax
40001851:	0f 84 91 00 00 00    	je     400018e8 <subdir+0x128>
static gcc_inline int
sys_mkdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001857:	bd 94 2e 00 40       	mov    $0x40002e94,%ebp
4000185c:	b8 09 00 00 00       	mov    $0x9,%eax
40001861:	89 eb                	mov    %ebp,%ebx
40001863:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_mkdir),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001865:	85 c0                	test   %eax,%eax
40001867:	74 17                	je     40001880 <subdir+0xc0>
    printf("unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("dd/dd") != 0){
    printf("subdir mkdir dd/dd failed\n");
40001869:	c7 04 24 9a 2e 00 40 	movl   $0x40002e9a,(%esp)
40001870:	e8 5b ea ff ff       	call   400002d0 <printf>
    printf("unlink dd failed\n");
    exit();
  }

  printf("=====subdir ok=====\n\n");
}
40001875:	83 c4 1c             	add    $0x1c,%esp
40001878:	5b                   	pop    %ebx
40001879:	5e                   	pop    %esi
4000187a:	5f                   	pop    %edi
4000187b:	5d                   	pop    %ebp
4000187c:	c3                   	ret    
4000187d:	8d 76 00             	lea    0x0(%esi),%esi
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001880:	b8 05 00 00 00       	mov    $0x5,%eax
40001885:	bb 98 2d 00 40       	mov    $0x40002d98,%ebx
4000188a:	b9 02 02 00 00       	mov    $0x202,%ecx
4000188f:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40001891:	85 c0                	test   %eax,%eax
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001893:	89 de                	mov    %ebx,%esi
40001895:	89 44 24 0c          	mov    %eax,0xc(%esp)
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40001899:	0f 85 01 01 00 00    	jne    400019a0 <subdir+0x1e0>
    printf("subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
4000189f:	85 f6                	test   %esi,%esi
400018a1:	0f 88 f9 00 00 00    	js     400019a0 <subdir+0x1e0>
sys_write(int fd, char *p, int n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
400018a7:	b9 55 2d 00 40       	mov    $0x40002d55,%ecx
400018ac:	b8 08 00 00 00       	mov    $0x8,%eax
400018b1:	89 f3                	mov    %esi,%ebx
400018b3:	cd 30                	int    $0x30
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
400018b5:	89 f8                	mov    %edi,%eax
400018b7:	89 f3                	mov    %esi,%ebx
400018b9:	cd 30                	int    $0x30
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
400018bb:	bb 58 2d 00 40       	mov    $0x40002d58,%ebx
400018c0:	b8 05 00 00 00       	mov    $0x5,%eax
400018c5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
400018c9:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
400018cb:	85 c0                	test   %eax,%eax
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
400018cd:	89 de                	mov    %ebx,%esi
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
400018cf:	74 47                	je     40001918 <subdir+0x158>
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
  if(fd < 0){
    printf("open dd/dd/../ff failed\n");
400018d1:	c7 04 24 64 2d 00 40 	movl   $0x40002d64,(%esp)
400018d8:	e8 f3 e9 ff ff       	call   400002d0 <printf>
    exit();
400018dd:	e9 1d ff ff ff       	jmp    400017ff <subdir+0x3f>
400018e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  write(fd, "ff", 2);
  close(fd);
  
  if(unlink("dd") >= 0){
    printf("unlink dd (non-empty dir) succeeded!\n");
400018e8:	c7 04 24 cc 36 00 40 	movl   $0x400036cc,(%esp)
400018ef:	e8 dc e9 ff ff       	call   400002d0 <printf>
    printf("unlink dd failed\n");
    exit();
  }

  printf("=====subdir ok=====\n\n");
}
400018f4:	83 c4 1c             	add    $0x1c,%esp
400018f7:	5b                   	pop    %ebx
400018f8:	5e                   	pop    %esi
400018f9:	5f                   	pop    %edi
400018fa:	5d                   	pop    %ebp
400018fb:	c3                   	ret    
400018fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf("create dd/ff failed\n");
40001900:	c7 04 24 28 2d 00 40 	movl   $0x40002d28,(%esp)
40001907:	e8 c4 e9 ff ff       	call   400002d0 <printf>
    exit();
4000190c:	e9 ee fe ff ff       	jmp    400017ff <subdir+0x3f>
40001911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
  if(fd < 0){
40001918:	85 db                	test   %ebx,%ebx
4000191a:	78 b5                	js     400018d1 <subdir+0x111>
sys_read(int fd, char *buf, size_t n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
4000191c:	bf a0 54 00 40       	mov    $0x400054a0,%edi
40001921:	ba 00 20 00 00       	mov    $0x2000,%edx
40001926:	b8 07 00 00 00       	mov    $0x7,%eax
4000192b:	89 f9                	mov    %edi,%ecx
4000192d:	cd 30                	int    $0x30
		       "b" (fd),
		       "c" (buf),
		       "d" (n)
		     : "cc", "memory");

	return errno ? -1 : ret;
4000192f:	85 c0                	test   %eax,%eax
40001931:	75 0e                	jne    40001941 <subdir+0x181>
    printf("open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
  if(cc != 2 || buf[0] != 'f'){
40001933:	83 fb 02             	cmp    $0x2,%ebx
40001936:	75 09                	jne    40001941 <subdir+0x181>
40001938:	80 3d a0 54 00 40 66 	cmpb   $0x66,0x400054a0
4000193f:	74 17                	je     40001958 <subdir+0x198>
    printf("dd/dd/../ff wrong content\n");
40001941:	c7 04 24 7d 2d 00 40 	movl   $0x40002d7d,(%esp)
40001948:	e8 83 e9 ff ff       	call   400002d0 <printf>
    printf("unlink dd failed\n");
    exit();
  }

  printf("=====subdir ok=====\n\n");
}
4000194d:	83 c4 1c             	add    $0x1c,%esp
40001950:	5b                   	pop    %ebx
40001951:	5e                   	pop    %esi
40001952:	5f                   	pop    %edi
40001953:	5d                   	pop    %ebp
40001954:	c3                   	ret    
40001955:	8d 76 00             	lea    0x0(%esi),%esi
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
40001958:	b8 06 00 00 00       	mov    $0x6,%eax
4000195d:	89 f3                	mov    %esi,%ebx
4000195f:	cd 30                	int    $0x30
static gcc_inline int
sys_link(char *old, char* new)
{
  int errno, ret;

	asm volatile("int %2"
40001961:	ba 98 2d 00 40       	mov    $0x40002d98,%edx
40001966:	be a1 2d 00 40       	mov    $0x40002da1,%esi
4000196b:	b8 0b 00 00 00       	mov    $0xb,%eax
40001970:	89 d3                	mov    %edx,%ebx
40001972:	89 f1                	mov    %esi,%ecx
40001974:	cd 30                	int    $0x30
		       "a" (SYS_link),
		       "b" (old),
		       "c" (new)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001976:	85 c0                	test   %eax,%eax
40001978:	75 3e                	jne    400019b8 <subdir+0x1f8>
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
4000197a:	b8 0c 00 00 00       	mov    $0xc,%eax
4000197f:	89 d3                	mov    %edx,%ebx
40001981:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_unlink),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001983:	85 c0                	test   %eax,%eax
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001985:	89 c1                	mov    %eax,%ecx
		     : "i" (T_SYSCALL),
		       "a" (SYS_unlink),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001987:	74 47                	je     400019d0 <subdir+0x210>
    printf("link dd/dd/ff dd/dd/ffff failed\n");
    exit();
  }

  if(unlink("dd/dd/ff") != 0){
    printf("unlink dd/dd/ff failed\n");
40001989:	c7 04 24 b5 2e 00 40 	movl   $0x40002eb5,(%esp)
40001990:	e8 3b e9 ff ff       	call   400002d0 <printf>
    exit();
40001995:	e9 65 fe ff ff       	jmp    400017ff <subdir+0x3f>
4000199a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf("create dd/dd/ff failed\n");
400019a0:	c7 04 24 3d 2d 00 40 	movl   $0x40002d3d,(%esp)
400019a7:	e8 24 e9 ff ff       	call   400002d0 <printf>
    exit();
400019ac:	e9 4e fe ff ff       	jmp    400017ff <subdir+0x3f>
400019b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
  }
  close(fd);

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    printf("link dd/dd/ff dd/dd/ffff failed\n");
400019b8:	c7 04 24 f4 36 00 40 	movl   $0x400036f4,(%esp)
400019bf:	e8 0c e9 ff ff       	call   400002d0 <printf>
    exit();
400019c4:	e9 36 fe ff ff       	jmp    400017ff <subdir+0x3f>
400019c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
400019d0:	b8 05 00 00 00       	mov    $0x5,%eax
400019d5:	89 d3                	mov    %edx,%ebx
400019d7:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
400019d9:	85 c0                	test   %eax,%eax
400019db:	75 1b                	jne    400019f8 <subdir+0x238>

  if(unlink("dd/dd/ff") != 0){
    printf("unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
400019dd:	85 db                	test   %ebx,%ebx
400019df:	78 17                	js     400019f8 <subdir+0x238>
    printf("open (unlinked) dd/dd/ff succeeded\n");
400019e1:	c7 04 24 80 36 00 40 	movl   $0x40003680,(%esp)
400019e8:	e8 e3 e8 ff ff       	call   400002d0 <printf>
    exit();
400019ed:	e9 0d fe ff ff       	jmp    400017ff <subdir+0x3f>
400019f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
static gcc_inline int
sys_chdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
400019f8:	ba 0a 00 00 00       	mov    $0xa,%edx
400019fd:	bb 10 2f 00 40       	mov    $0x40002f10,%ebx
40001a02:	89 d0                	mov    %edx,%eax
40001a04:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_chdir),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001a06:	85 c0                	test   %eax,%eax
40001a08:	74 16                	je     40001a20 <subdir+0x260>
  }

  if(chdir("dd") != 0){
    printf("chdir dd failed\n");
40001a0a:	c7 04 24 cd 2e 00 40 	movl   $0x40002ecd,(%esp)
40001a11:	e8 ba e8 ff ff       	call   400002d0 <printf>
    exit();
40001a16:	e9 e4 fd ff ff       	jmp    400017ff <subdir+0x3f>
40001a1b:	90                   	nop
40001a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static gcc_inline int
sys_chdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001a20:	bb de 2e 00 40       	mov    $0x40002ede,%ebx
40001a25:	89 d0                	mov    %edx,%eax
40001a27:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_chdir),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001a29:	85 c0                	test   %eax,%eax
40001a2b:	75 33                	jne    40001a60 <subdir+0x2a0>
static gcc_inline int
sys_chdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001a2d:	bb 04 2f 00 40       	mov    $0x40002f04,%ebx
40001a32:	89 d0                	mov    %edx,%eax
40001a34:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_chdir),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001a36:	85 c0                	test   %eax,%eax
40001a38:	75 26                	jne    40001a60 <subdir+0x2a0>
static gcc_inline int
sys_chdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001a3a:	bb 13 2f 00 40       	mov    $0x40002f13,%ebx
40001a3f:	89 d0                	mov    %edx,%eax
40001a41:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_chdir),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001a43:	85 c0                	test   %eax,%eax
static gcc_inline int
sys_chdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001a45:	89 c1                	mov    %eax,%ecx
		     : "i" (T_SYSCALL),
		       "a" (SYS_chdir),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001a47:	74 28                	je     40001a71 <subdir+0x2b1>
  if(chdir("dd/../../../dd") != 0){
    printf("chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    printf("chdir ./.. failed\n");
40001a49:	c7 04 24 18 2f 00 40 	movl   $0x40002f18,(%esp)
40001a50:	e8 7b e8 ff ff       	call   400002d0 <printf>
    exit();
40001a55:	e9 a5 fd ff ff       	jmp    400017ff <subdir+0x3f>
40001a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(chdir("dd") != 0){
    printf("chdir dd failed\n");
    exit();
  }
  if(chdir("dd/../../dd") != 0){
    printf("chdir dd/../../dd failed\n");
40001a60:	c7 04 24 ea 2e 00 40 	movl   $0x40002eea,(%esp)
40001a67:	e8 64 e8 ff ff       	call   400002d0 <printf>
    exit();
40001a6c:	e9 8e fd ff ff       	jmp    400017ff <subdir+0x3f>
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001a71:	b8 05 00 00 00       	mov    $0x5,%eax
40001a76:	89 f3                	mov    %esi,%ebx
40001a78:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40001a7a:	85 c0                	test   %eax,%eax
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001a7c:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40001a80:	74 11                	je     40001a93 <subdir+0x2d3>
    exit();
  }

  fd = open("dd/dd/ffff", 0);
  if(fd < 0){
    printf("open dd/dd/ffff failed\n");
40001a82:	c7 04 24 ac 2d 00 40 	movl   $0x40002dac,(%esp)
40001a89:	e8 42 e8 ff ff       	call   400002d0 <printf>
    exit();
40001a8e:	e9 6c fd ff ff       	jmp    400017ff <subdir+0x3f>
    printf("chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
  if(fd < 0){
40001a93:	8b 44 24 0c          	mov    0xc(%esp),%eax
40001a97:	85 c0                	test   %eax,%eax
40001a99:	78 e7                	js     40001a82 <subdir+0x2c2>
sys_read(int fd, char *buf, size_t n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
40001a9b:	ba 00 20 00 00       	mov    $0x2000,%edx
40001aa0:	b8 07 00 00 00       	mov    $0x7,%eax
40001aa5:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40001aa9:	89 f9                	mov    %edi,%ecx
40001aab:	cd 30                	int    $0x30
		       "b" (fd),
		       "c" (buf),
		       "d" (n)
		     : "cc", "memory");

	return errno ? -1 : ret;
40001aad:	85 c0                	test   %eax,%eax
sys_read(int fd, char *buf, size_t n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
40001aaf:	89 c1                	mov    %eax,%ecx
		       "b" (fd),
		       "c" (buf),
		       "d" (n)
		     : "cc", "memory");

	return errno ? -1 : ret;
40001ab1:	74 11                	je     40001ac4 <subdir+0x304>
    printf("open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    printf("read dd/dd/ffff wrong len\n");
40001ab3:	c7 04 24 c4 2d 00 40 	movl   $0x40002dc4,(%esp)
40001aba:	e8 11 e8 ff ff       	call   400002d0 <printf>
    exit();
40001abf:	e9 3b fd ff ff       	jmp    400017ff <subdir+0x3f>
  fd = open("dd/dd/ffff", 0);
  if(fd < 0){
    printf("open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
40001ac4:	83 fb 02             	cmp    $0x2,%ebx
40001ac7:	75 ea                	jne    40001ab3 <subdir+0x2f3>
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
40001ac9:	b8 06 00 00 00       	mov    $0x6,%eax
40001ace:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40001ad2:	cd 30                	int    $0x30
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001ad4:	b8 05 00 00 00       	mov    $0x5,%eax
40001ad9:	bb 98 2d 00 40       	mov    $0x40002d98,%ebx
40001ade:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40001ae0:	85 c0                	test   %eax,%eax
40001ae2:	75 15                	jne    40001af9 <subdir+0x339>
    printf("read dd/dd/ffff wrong len\n");
    exit();
  }
  close(fd);

  if(open("dd/dd/ff", O_RDONLY) >= 0){
40001ae4:	85 db                	test   %ebx,%ebx
40001ae6:	78 11                	js     40001af9 <subdir+0x339>
    printf("open (unlinked) dd/dd/ff succeeded!\n");
40001ae8:	c7 04 24 a4 36 00 40 	movl   $0x400036a4,(%esp)
40001aef:	e8 dc e7 ff ff       	call   400002d0 <printf>
    exit();
40001af4:	e9 06 fd ff ff       	jmp    400017ff <subdir+0x3f>
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001af9:	bf df 2d 00 40       	mov    $0x40002ddf,%edi
40001afe:	b9 02 02 00 00       	mov    $0x202,%ecx
40001b03:	b8 05 00 00 00       	mov    $0x5,%eax
40001b08:	89 fb                	mov    %edi,%ebx
40001b0a:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40001b0c:	85 c0                	test   %eax,%eax
40001b0e:	75 15                	jne    40001b25 <subdir+0x365>
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
40001b10:	85 db                	test   %ebx,%ebx
40001b12:	78 11                	js     40001b25 <subdir+0x365>
    printf("create dd/ff/ff succeeded!\n");
40001b14:	c7 04 24 e8 2d 00 40 	movl   $0x40002de8,(%esp)
40001b1b:	e8 b0 e7 ff ff       	call   400002d0 <printf>
    exit();
40001b20:	e9 da fc ff ff       	jmp    400017ff <subdir+0x3f>
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001b25:	b9 02 02 00 00       	mov    $0x202,%ecx
40001b2a:	b8 05 00 00 00       	mov    $0x5,%eax
40001b2f:	bb 04 2e 00 40       	mov    $0x40002e04,%ebx
40001b34:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40001b36:	85 c0                	test   %eax,%eax
40001b38:	75 15                	jne    40001b4f <subdir+0x38f>
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
40001b3a:	85 db                	test   %ebx,%ebx
40001b3c:	78 11                	js     40001b4f <subdir+0x38f>
    printf("create dd/xx/ff succeeded!\n");
40001b3e:	c7 04 24 0d 2e 00 40 	movl   $0x40002e0d,(%esp)
40001b45:	e8 86 e7 ff ff       	call   400002d0 <printf>
    exit();
40001b4a:	e9 b0 fc ff ff       	jmp    400017ff <subdir+0x3f>
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001b4f:	b9 00 02 00 00       	mov    $0x200,%ecx
40001b54:	b8 05 00 00 00       	mov    $0x5,%eax
40001b59:	bb 10 2f 00 40       	mov    $0x40002f10,%ebx
40001b5e:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40001b60:	85 c0                	test   %eax,%eax
40001b62:	75 15                	jne    40001b79 <subdir+0x3b9>
  }
  if(open("dd", O_CREATE) >= 0){
40001b64:	85 db                	test   %ebx,%ebx
40001b66:	78 11                	js     40001b79 <subdir+0x3b9>
    printf("create dd succeeded!\n");
40001b68:	c7 04 24 29 2e 00 40 	movl   $0x40002e29,(%esp)
40001b6f:	e8 5c e7 ff ff       	call   400002d0 <printf>
    exit();
40001b74:	e9 86 fc ff ff       	jmp    400017ff <subdir+0x3f>
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001b79:	b9 02 00 00 00       	mov    $0x2,%ecx
40001b7e:	b8 05 00 00 00       	mov    $0x5,%eax
40001b83:	bb 10 2f 00 40       	mov    $0x40002f10,%ebx
40001b88:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40001b8a:	85 c0                	test   %eax,%eax
40001b8c:	75 15                	jne    40001ba3 <subdir+0x3e3>
  }
  if(open("dd", O_RDWR) >= 0){
40001b8e:	85 db                	test   %ebx,%ebx
40001b90:	78 11                	js     40001ba3 <subdir+0x3e3>
    printf("open dd rdwr succeeded!\n");
40001b92:	c7 04 24 3f 2e 00 40 	movl   $0x40002e3f,(%esp)
40001b99:	e8 32 e7 ff ff       	call   400002d0 <printf>
    exit();
40001b9e:	e9 5c fc ff ff       	jmp    400017ff <subdir+0x3f>
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001ba3:	b9 01 00 00 00       	mov    $0x1,%ecx
40001ba8:	b8 05 00 00 00       	mov    $0x5,%eax
40001bad:	bb 10 2f 00 40       	mov    $0x40002f10,%ebx
40001bb2:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40001bb4:	85 c0                	test   %eax,%eax
40001bb6:	75 15                	jne    40001bcd <subdir+0x40d>
  }
  if(open("dd", O_WRONLY) >= 0){
40001bb8:	85 db                	test   %ebx,%ebx
40001bba:	78 11                	js     40001bcd <subdir+0x40d>
    printf("open dd wronly succeeded!\n");
40001bbc:	c7 04 24 58 2e 00 40 	movl   $0x40002e58,(%esp)
40001bc3:	e8 08 e7 ff ff       	call   400002d0 <printf>
    exit();
40001bc8:	e9 32 fc ff ff       	jmp    400017ff <subdir+0x3f>
static gcc_inline int
sys_link(char *old, char* new)
{
  int errno, ret;

	asm volatile("int %2"
40001bcd:	ba 0b 00 00 00       	mov    $0xb,%edx
40001bd2:	b9 73 2e 00 40       	mov    $0x40002e73,%ecx
40001bd7:	89 d0                	mov    %edx,%eax
40001bd9:	89 fb                	mov    %edi,%ebx
40001bdb:	cd 30                	int    $0x30
		       "a" (SYS_link),
		       "b" (old),
		       "c" (new)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001bdd:	85 c0                	test   %eax,%eax
40001bdf:	74 20                	je     40001c01 <subdir+0x441>
static gcc_inline int
sys_link(char *old, char* new)
{
  int errno, ret;

	asm volatile("int %2"
40001be1:	bf 04 2e 00 40       	mov    $0x40002e04,%edi
40001be6:	89 d0                	mov    %edx,%eax
40001be8:	89 fb                	mov    %edi,%ebx
40001bea:	cd 30                	int    $0x30
		       "a" (SYS_link),
		       "b" (old),
		       "c" (new)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001bec:	85 c0                	test   %eax,%eax
40001bee:	75 22                	jne    40001c12 <subdir+0x452>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf("link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf("link dd/xx/ff dd/dd/xx succeeded!\n");
40001bf0:	c7 04 24 3c 37 00 40 	movl   $0x4000373c,(%esp)
40001bf7:	e8 d4 e6 ff ff       	call   400002d0 <printf>
    exit();
40001bfc:	e9 fe fb ff ff       	jmp    400017ff <subdir+0x3f>
  if(open("dd", O_WRONLY) >= 0){
    printf("open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf("link dd/ff/ff dd/dd/xx succeeded!\n");
40001c01:	c7 04 24 18 37 00 40 	movl   $0x40003718,(%esp)
40001c08:	e8 c3 e6 ff ff       	call   400002d0 <printf>
    exit();
40001c0d:	e9 ed fb ff ff       	jmp    400017ff <subdir+0x3f>
static gcc_inline int
sys_link(char *old, char* new)
{
  int errno, ret;

	asm volatile("int %2"
40001c12:	89 d0                	mov    %edx,%eax
40001c14:	bb 9b 2d 00 40       	mov    $0x40002d9b,%ebx
40001c19:	89 f1                	mov    %esi,%ecx
40001c1b:	cd 30                	int    $0x30
		       "a" (SYS_link),
		       "b" (old),
		       "c" (new)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001c1d:	85 c0                	test   %eax,%eax
40001c1f:	75 11                	jne    40001c32 <subdir+0x472>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf("link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf("link dd/ff dd/dd/ffff succeeded!\n");
40001c21:	c7 04 24 60 37 00 40 	movl   $0x40003760,(%esp)
40001c28:	e8 a3 e6 ff ff       	call   400002d0 <printf>
    exit();
40001c2d:	e9 cd fb ff ff       	jmp    400017ff <subdir+0x3f>
static gcc_inline int
sys_mkdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001c32:	ba 09 00 00 00       	mov    $0x9,%edx
40001c37:	bb df 2d 00 40       	mov    $0x40002ddf,%ebx
40001c3c:	89 d0                	mov    %edx,%eax
40001c3e:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_mkdir),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001c40:	85 c0                	test   %eax,%eax
40001c42:	75 11                	jne    40001c55 <subdir+0x495>
  }
  if(mkdir("dd/ff/ff") == 0){
    printf("mkdir dd/ff/ff succeeded!\n");
40001c44:	c7 04 24 2b 2f 00 40 	movl   $0x40002f2b,(%esp)
40001c4b:	e8 80 e6 ff ff       	call   400002d0 <printf>
    exit();
40001c50:	e9 aa fb ff ff       	jmp    400017ff <subdir+0x3f>
static gcc_inline int
sys_mkdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001c55:	89 d0                	mov    %edx,%eax
40001c57:	89 fb                	mov    %edi,%ebx
40001c59:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_mkdir),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001c5b:	85 c0                	test   %eax,%eax
40001c5d:	75 11                	jne    40001c70 <subdir+0x4b0>
  }
  if(mkdir("dd/xx/ff") == 0){
    printf("mkdir dd/xx/ff succeeded!\n");
40001c5f:	c7 04 24 46 2f 00 40 	movl   $0x40002f46,(%esp)
40001c66:	e8 65 e6 ff ff       	call   400002d0 <printf>
    exit();
40001c6b:	e9 8f fb ff ff       	jmp    400017ff <subdir+0x3f>
static gcc_inline int
sys_mkdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001c70:	bb a1 2d 00 40       	mov    $0x40002da1,%ebx
40001c75:	89 d0                	mov    %edx,%eax
40001c77:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_mkdir),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001c79:	85 c0                	test   %eax,%eax
40001c7b:	75 11                	jne    40001c8e <subdir+0x4ce>
  }
  if(mkdir("dd/dd/ffff") == 0){
    printf("mkdir dd/dd/ffff succeeded!\n");
40001c7d:	c7 04 24 61 2f 00 40 	movl   $0x40002f61,(%esp)
40001c84:	e8 47 e6 ff ff       	call   400002d0 <printf>
    exit();
40001c89:	e9 71 fb ff ff       	jmp    400017ff <subdir+0x3f>
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001c8e:	ba 0c 00 00 00       	mov    $0xc,%edx
40001c93:	89 fb                	mov    %edi,%ebx
40001c95:	89 d0                	mov    %edx,%eax
40001c97:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_unlink),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001c99:	85 c0                	test   %eax,%eax
40001c9b:	75 11                	jne    40001cae <subdir+0x4ee>
  }
  if(unlink("dd/xx/ff") == 0){
    printf("unlink dd/xx/ff succeeded!\n");
40001c9d:	c7 04 24 7e 2f 00 40 	movl   $0x40002f7e,(%esp)
40001ca4:	e8 27 e6 ff ff       	call   400002d0 <printf>
    exit();
40001ca9:	e9 51 fb ff ff       	jmp    400017ff <subdir+0x3f>
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001cae:	89 d0                	mov    %edx,%eax
40001cb0:	bb df 2d 00 40       	mov    $0x40002ddf,%ebx
40001cb5:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_unlink),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001cb7:	85 c0                	test   %eax,%eax
40001cb9:	74 23                	je     40001cde <subdir+0x51e>
static gcc_inline int
sys_chdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001cbb:	ba 0a 00 00 00       	mov    $0xa,%edx
40001cc0:	bb 9b 2d 00 40       	mov    $0x40002d9b,%ebx
40001cc5:	89 d0                	mov    %edx,%eax
40001cc7:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_chdir),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001cc9:	85 c0                	test   %eax,%eax
40001ccb:	75 22                	jne    40001cef <subdir+0x52f>
  if(unlink("dd/ff/ff") == 0){
    printf("unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    printf("chdir dd/ff succeeded!\n");
40001ccd:	c7 04 24 b6 2f 00 40 	movl   $0x40002fb6,(%esp)
40001cd4:	e8 f7 e5 ff ff       	call   400002d0 <printf>
    exit();
40001cd9:	e9 21 fb ff ff       	jmp    400017ff <subdir+0x3f>
  if(unlink("dd/xx/ff") == 0){
    printf("unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    printf("unlink dd/ff/ff succeeded!\n");
40001cde:	c7 04 24 9a 2f 00 40 	movl   $0x40002f9a,(%esp)
40001ce5:	e8 e6 e5 ff ff       	call   400002d0 <printf>
    exit();
40001cea:	e9 10 fb ff ff       	jmp    400017ff <subdir+0x3f>
static gcc_inline int
sys_chdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001cef:	bb 76 2e 00 40       	mov    $0x40002e76,%ebx
40001cf4:	89 d0                	mov    %edx,%eax
40001cf6:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_chdir),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001cf8:	85 c0                	test   %eax,%eax
40001cfa:	75 11                	jne    40001d0d <subdir+0x54d>
  if(chdir("dd/ff") == 0){
    printf("chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    printf("chdir dd/xx succeeded!\n");
40001cfc:	c7 04 24 ce 2f 00 40 	movl   $0x40002fce,(%esp)
40001d03:	e8 c8 e5 ff ff       	call   400002d0 <printf>
    exit();
40001d08:	e9 f2 fa ff ff       	jmp    400017ff <subdir+0x3f>
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001d0d:	ba 0c 00 00 00       	mov    $0xc,%edx
40001d12:	89 f3                	mov    %esi,%ebx
40001d14:	89 d0                	mov    %edx,%eax
40001d16:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_unlink),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001d18:	85 c0                	test   %eax,%eax
40001d1a:	0f 85 69 fc ff ff    	jne    40001989 <subdir+0x1c9>
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001d20:	89 d0                	mov    %edx,%eax
40001d22:	bb 9b 2d 00 40       	mov    $0x40002d9b,%ebx
40001d27:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_unlink),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001d29:	85 c0                	test   %eax,%eax
40001d2b:	74 11                	je     40001d3e <subdir+0x57e>
  if(unlink("dd/dd/ffff") != 0){
    printf("unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    printf("unlink dd/ff failed\n");
40001d2d:	c7 04 24 e6 2f 00 40 	movl   $0x40002fe6,(%esp)
40001d34:	e8 97 e5 ff ff       	call   400002d0 <printf>
    exit();
40001d39:	e9 c1 fa ff ff       	jmp    400017ff <subdir+0x3f>
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001d3e:	89 d0                	mov    %edx,%eax
40001d40:	bb 10 2f 00 40       	mov    $0x40002f10,%ebx
40001d45:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_unlink),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001d47:	85 c0                	test   %eax,%eax
40001d49:	75 11                	jne    40001d5c <subdir+0x59c>
  }
  if(unlink("dd") == 0){
    printf("unlink non-empty dd succeeded!\n");
40001d4b:	c7 04 24 84 37 00 40 	movl   $0x40003784,(%esp)
40001d52:	e8 79 e5 ff ff       	call   400002d0 <printf>
    exit();
40001d57:	e9 a3 fa ff ff       	jmp    400017ff <subdir+0x3f>
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001d5c:	89 d0                	mov    %edx,%eax
40001d5e:	89 eb                	mov    %ebp,%ebx
40001d60:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_unlink),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001d62:	85 c0                	test   %eax,%eax
40001d64:	75 1e                	jne    40001d84 <subdir+0x5c4>
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001d66:	bb 10 2f 00 40       	mov    $0x40002f10,%ebx
40001d6b:	89 d0                	mov    %edx,%eax
40001d6d:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_unlink),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001d6f:	85 c0                	test   %eax,%eax
40001d71:	74 22                	je     40001d95 <subdir+0x5d5>
  if(unlink("dd/dd") < 0){
    printf("unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    printf("unlink dd failed\n");
40001d73:	c7 04 24 10 30 00 40 	movl   $0x40003010,(%esp)
40001d7a:	e8 51 e5 ff ff       	call   400002d0 <printf>
    exit();
40001d7f:	e9 7b fa ff ff       	jmp    400017ff <subdir+0x3f>
  if(unlink("dd") == 0){
    printf("unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    printf("unlink dd/dd failed\n");
40001d84:	c7 04 24 fb 2f 00 40 	movl   $0x40002ffb,(%esp)
40001d8b:	e8 40 e5 ff ff       	call   400002d0 <printf>
    exit();
40001d90:	e9 6a fa ff ff       	jmp    400017ff <subdir+0x3f>
  if(unlink("dd") < 0){
    printf("unlink dd failed\n");
    exit();
  }

  printf("=====subdir ok=====\n\n");
40001d95:	c7 04 24 22 30 00 40 	movl   $0x40003022,(%esp)
40001d9c:	e8 2f e5 ff ff       	call   400002d0 <printf>
40001da1:	e9 59 fa ff ff       	jmp    400017ff <subdir+0x3f>
40001da6:	8d 76 00             	lea    0x0(%esi),%esi
40001da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40001db0 <linktest>:
}

void
linktest(void)
{
40001db0:	55                   	push   %ebp
40001db1:	57                   	push   %edi
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001db2:	bf 0c 00 00 00       	mov    $0xc,%edi
40001db7:	56                   	push   %esi
40001db8:	be 4c 30 00 40       	mov    $0x4000304c,%esi
40001dbd:	53                   	push   %ebx
40001dbe:	89 f3                	mov    %esi,%ebx
40001dc0:	83 ec 1c             	sub    $0x1c,%esp
  int fd;

  printf("=====linktest=====\n");
40001dc3:	c7 04 24 38 30 00 40 	movl   $0x40003038,(%esp)
40001dca:	e8 01 e5 ff ff       	call   400002d0 <printf>
40001dcf:	89 f8                	mov    %edi,%eax
40001dd1:	cd 30                	int    $0x30
40001dd3:	bd 50 30 00 40       	mov    $0x40003050,%ebp
40001dd8:	89 f8                	mov    %edi,%eax
40001dda:	89 eb                	mov    %ebp,%ebx
40001ddc:	cd 30                	int    $0x30
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001dde:	ba 05 00 00 00       	mov    $0x5,%edx
40001de3:	b9 02 02 00 00       	mov    $0x202,%ecx
40001de8:	89 d0                	mov    %edx,%eax
40001dea:	89 f3                	mov    %esi,%ebx
40001dec:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40001dee:	85 c0                	test   %eax,%eax
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001df0:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40001df4:	74 1a                	je     40001e10 <linktest+0x60>
  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
  if(fd < 0){
    printf("create lf1 failed\n");
40001df6:	c7 04 24 54 30 00 40 	movl   $0x40003054,(%esp)
40001dfd:	e8 ce e4 ff ff       	call   400002d0 <printf>
    printf("link . lf1 succeeded! oops\n");
    exit();
  }

  printf("=====linktest ok=====\n\n");
}
40001e02:	83 c4 1c             	add    $0x1c,%esp
40001e05:	5b                   	pop    %ebx
40001e06:	5e                   	pop    %esi
40001e07:	5f                   	pop    %edi
40001e08:	5d                   	pop    %ebp
40001e09:	c3                   	ret    
40001e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
  if(fd < 0){
40001e10:	85 db                	test   %ebx,%ebx
40001e12:	78 e2                	js     40001df6 <linktest+0x46>
sys_write(int fd, char *p, int n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
40001e14:	b9 67 30 00 40       	mov    $0x40003067,%ecx
40001e19:	b8 08 00 00 00       	mov    $0x8,%eax
40001e1e:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40001e22:	cd 30                	int    $0x30
		       "b" (fd),
		       "c" (p),
		       "d" (n)
		     : "cc", "memory");

	return errno ? -1 : ret;
40001e24:	85 c0                	test   %eax,%eax
sys_write(int fd, char *p, int n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
40001e26:	89 da                	mov    %ebx,%edx
		       "b" (fd),
		       "c" (p),
		       "d" (n)
		     : "cc", "memory");

	return errno ? -1 : ret;
40001e28:	75 36                	jne    40001e60 <linktest+0xb0>
    printf("create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
40001e2a:	83 fb 05             	cmp    $0x5,%ebx
40001e2d:	75 31                	jne    40001e60 <linktest+0xb0>
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
40001e2f:	b8 06 00 00 00       	mov    $0x6,%eax
40001e34:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40001e38:	cd 30                	int    $0x30
static gcc_inline int
sys_link(char *old, char* new)
{
  int errno, ret;

	asm volatile("int %2"
40001e3a:	b8 0b 00 00 00       	mov    $0xb,%eax
40001e3f:	89 f3                	mov    %esi,%ebx
40001e41:	89 e9                	mov    %ebp,%ecx
40001e43:	cd 30                	int    $0x30
		       "a" (SYS_link),
		       "b" (old),
		       "c" (new)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001e45:	85 c0                	test   %eax,%eax
static gcc_inline int
sys_link(char *old, char* new)
{
  int errno, ret;

	asm volatile("int %2"
40001e47:	89 c1                	mov    %eax,%ecx
		       "a" (SYS_link),
		       "b" (old),
		       "c" (new)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001e49:	74 2d                	je     40001e78 <linktest+0xc8>
    exit();
  }
  close(fd);

  if(link("lf1", "lf2") < 0){
    printf("link lf1 lf2 failed\n");
40001e4b:	c7 04 24 a1 30 00 40 	movl   $0x400030a1,(%esp)
40001e52:	e8 79 e4 ff ff       	call   400002d0 <printf>
    printf("link . lf1 succeeded! oops\n");
    exit();
  }

  printf("=====linktest ok=====\n\n");
}
40001e57:	83 c4 1c             	add    $0x1c,%esp
40001e5a:	5b                   	pop    %ebx
40001e5b:	5e                   	pop    %esi
40001e5c:	5f                   	pop    %edi
40001e5d:	5d                   	pop    %ebp
40001e5e:	c3                   	ret    
40001e5f:	90                   	nop
  if(fd < 0){
    printf("create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    printf("write lf1 failed\n");
40001e60:	c7 04 24 6d 30 00 40 	movl   $0x4000306d,(%esp)
40001e67:	e8 64 e4 ff ff       	call   400002d0 <printf>
    printf("link . lf1 succeeded! oops\n");
    exit();
  }

  printf("=====linktest ok=====\n\n");
}
40001e6c:	83 c4 1c             	add    $0x1c,%esp
40001e6f:	5b                   	pop    %ebx
40001e70:	5e                   	pop    %esi
40001e71:	5f                   	pop    %edi
40001e72:	5d                   	pop    %ebp
40001e73:	c3                   	ret    
40001e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001e78:	89 f8                	mov    %edi,%eax
40001e7a:	89 f3                	mov    %esi,%ebx
40001e7c:	cd 30                	int    $0x30
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001e7e:	89 d0                	mov    %edx,%eax
40001e80:	89 f3                	mov    %esi,%ebx
40001e82:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40001e84:	85 c0                	test   %eax,%eax
40001e86:	75 18                	jne    40001ea0 <linktest+0xf0>
    printf("link lf1 lf2 failed\n");
    exit();
  }
  unlink("lf1");

  if(open("lf1", 0) >= 0){
40001e88:	85 db                	test   %ebx,%ebx
40001e8a:	78 14                	js     40001ea0 <linktest+0xf0>
    printf("unlinked lf1 but it is still there!\n");
40001e8c:	c7 04 24 a4 37 00 40 	movl   $0x400037a4,(%esp)
40001e93:	e8 38 e4 ff ff       	call   400002d0 <printf>
    printf("link . lf1 succeeded! oops\n");
    exit();
  }

  printf("=====linktest ok=====\n\n");
}
40001e98:	83 c4 1c             	add    $0x1c,%esp
40001e9b:	5b                   	pop    %ebx
40001e9c:	5e                   	pop    %esi
40001e9d:	5f                   	pop    %edi
40001e9e:	5d                   	pop    %ebp
40001e9f:	c3                   	ret    
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001ea0:	bf 50 30 00 40       	mov    $0x40003050,%edi
40001ea5:	31 c9                	xor    %ecx,%ecx
40001ea7:	b8 05 00 00 00       	mov    $0x5,%eax
40001eac:	89 eb                	mov    %ebp,%ebx
40001eae:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40001eb0:	85 c0                	test   %eax,%eax
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001eb2:	89 dd                	mov    %ebx,%ebp
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40001eb4:	0f 85 a6 00 00 00    	jne    40001f60 <linktest+0x1b0>
    printf("unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
  if(fd < 0){
40001eba:	85 db                	test   %ebx,%ebx
40001ebc:	0f 88 9e 00 00 00    	js     40001f60 <linktest+0x1b0>
sys_read(int fd, char *buf, size_t n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
40001ec2:	ba 00 20 00 00       	mov    $0x2000,%edx
40001ec7:	b9 a0 54 00 40       	mov    $0x400054a0,%ecx
40001ecc:	b8 07 00 00 00       	mov    $0x7,%eax
40001ed1:	cd 30                	int    $0x30
		       "b" (fd),
		       "c" (buf),
		       "d" (n)
		     : "cc", "memory");

	return errno ? -1 : ret;
40001ed3:	85 c0                	test   %eax,%eax
40001ed5:	74 19                	je     40001ef0 <linktest+0x140>
    printf("open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    printf("read lf2 failed\n");
40001ed7:	c7 04 24 90 30 00 40 	movl   $0x40003090,(%esp)
40001ede:	e8 ed e3 ff ff       	call   400002d0 <printf>
    printf("link . lf1 succeeded! oops\n");
    exit();
  }

  printf("=====linktest ok=====\n\n");
}
40001ee3:	83 c4 1c             	add    $0x1c,%esp
40001ee6:	5b                   	pop    %ebx
40001ee7:	5e                   	pop    %esi
40001ee8:	5f                   	pop    %edi
40001ee9:	5d                   	pop    %ebp
40001eea:	c3                   	ret    
40001eeb:	90                   	nop
40001eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  fd = open("lf2", 0);
  if(fd < 0){
    printf("open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
40001ef0:	83 fb 05             	cmp    $0x5,%ebx
40001ef3:	75 e2                	jne    40001ed7 <linktest+0x127>
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
40001ef5:	b8 06 00 00 00       	mov    $0x6,%eax
40001efa:	89 eb                	mov    %ebp,%ebx
40001efc:	cd 30                	int    $0x30
static gcc_inline int
sys_link(char *old, char* new)
{
  int errno, ret;

	asm volatile("int %2"
40001efe:	ba 0b 00 00 00       	mov    $0xb,%edx
40001f03:	89 fb                	mov    %edi,%ebx
40001f05:	89 d0                	mov    %edx,%eax
40001f07:	89 f9                	mov    %edi,%ecx
40001f09:	cd 30                	int    $0x30
		       "a" (SYS_link),
		       "b" (old),
		       "c" (new)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001f0b:	85 c0                	test   %eax,%eax
40001f0d:	74 39                	je     40001f48 <linktest+0x198>
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40001f0f:	b8 0c 00 00 00       	mov    $0xc,%eax
40001f14:	89 fb                	mov    %edi,%ebx
40001f16:	cd 30                	int    $0x30
static gcc_inline int
sys_link(char *old, char* new)
{
  int errno, ret;

	asm volatile("int %2"
40001f18:	89 d0                	mov    %edx,%eax
40001f1a:	89 fb                	mov    %edi,%ebx
40001f1c:	89 f1                	mov    %esi,%ecx
40001f1e:	cd 30                	int    $0x30
		       "a" (SYS_link),
		       "b" (old),
		       "c" (new)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001f20:	85 c0                	test   %eax,%eax
40001f22:	74 54                	je     40001f78 <linktest+0x1c8>
static gcc_inline int
sys_link(char *old, char* new)
{
  int errno, ret;

	asm volatile("int %2"
40001f24:	bb 16 2f 00 40       	mov    $0x40002f16,%ebx
40001f29:	b9 4c 30 00 40       	mov    $0x4000304c,%ecx
40001f2e:	89 d0                	mov    %edx,%eax
40001f30:	cd 30                	int    $0x30
		       "a" (SYS_link),
		       "b" (old),
		       "c" (new)
		     : "cc", "memory");

	return errno ? -1 : 0;
40001f32:	85 c0                	test   %eax,%eax
40001f34:	75 5a                	jne    40001f90 <linktest+0x1e0>
    printf("link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    printf("link . lf1 succeeded! oops\n");
40001f36:	c7 04 24 d4 30 00 40 	movl   $0x400030d4,(%esp)
40001f3d:	e8 8e e3 ff ff       	call   400002d0 <printf>
    exit();
40001f42:	e9 bb fe ff ff       	jmp    40001e02 <linktest+0x52>
40001f47:	90                   	nop
    exit();
  }
  close(fd);

  if(link("lf2", "lf2") >= 0){
    printf("link lf2 lf2 succeeded! oops\n");
40001f48:	c7 04 24 b6 30 00 40 	movl   $0x400030b6,(%esp)
40001f4f:	e8 7c e3 ff ff       	call   400002d0 <printf>
    exit();
40001f54:	e9 a9 fe ff ff       	jmp    40001e02 <linktest+0x52>
40001f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
  }

  fd = open("lf2", 0);
  if(fd < 0){
    printf("open lf2 failed\n");
40001f60:	c7 04 24 7f 30 00 40 	movl   $0x4000307f,(%esp)
40001f67:	e8 64 e3 ff ff       	call   400002d0 <printf>
    exit();
40001f6c:	e9 91 fe ff ff       	jmp    40001e02 <linktest+0x52>
40001f71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
  }

  unlink("lf2");
  if(link("lf2", "lf1") >= 0){
    printf("link non-existant succeeded! oops\n");
40001f78:	c7 04 24 cc 37 00 40 	movl   $0x400037cc,(%esp)
40001f7f:	e8 4c e3 ff ff       	call   400002d0 <printf>
    exit();
40001f84:	e9 79 fe ff ff       	jmp    40001e02 <linktest+0x52>
40001f89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(link(".", "lf1") >= 0){
    printf("link . lf1 succeeded! oops\n");
    exit();
  }

  printf("=====linktest ok=====\n\n");
40001f90:	c7 04 24 f0 30 00 40 	movl   $0x400030f0,(%esp)
40001f97:	e8 34 e3 ff ff       	call   400002d0 <printf>
40001f9c:	e9 61 fe ff ff       	jmp    40001e02 <linktest+0x52>
40001fa1:	eb 0d                	jmp    40001fb0 <unlinkread>
40001fa3:	90                   	nop
40001fa4:	90                   	nop
40001fa5:	90                   	nop
40001fa6:	90                   	nop
40001fa7:	90                   	nop
40001fa8:	90                   	nop
40001fa9:	90                   	nop
40001faa:	90                   	nop
40001fab:	90                   	nop
40001fac:	90                   	nop
40001fad:	90                   	nop
40001fae:	90                   	nop
40001faf:	90                   	nop

40001fb0 <unlinkread>:
}

// can I unlink a file and still read it?
void
unlinkread(void)
{
40001fb0:	55                   	push   %ebp
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40001fb1:	bd 02 02 00 00       	mov    $0x202,%ebp
40001fb6:	57                   	push   %edi
40001fb7:	56                   	push   %esi
40001fb8:	be 23 31 00 40       	mov    $0x40003123,%esi
40001fbd:	53                   	push   %ebx
40001fbe:	89 f3                	mov    %esi,%ebx
40001fc0:	83 ec 1c             	sub    $0x1c,%esp
  int fd, fd1;

  printf("=====unlinkread test=====\n");
40001fc3:	c7 04 24 08 31 00 40 	movl   $0x40003108,(%esp)
40001fca:	e8 01 e3 ff ff       	call   400002d0 <printf>
40001fcf:	ba 05 00 00 00       	mov    $0x5,%edx
40001fd4:	89 e9                	mov    %ebp,%ecx
40001fd6:	89 d0                	mov    %edx,%eax
40001fd8:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40001fda:	85 c0                	test   %eax,%eax
40001fdc:	74 1a                	je     40001ff8 <unlinkread+0x48>
  fd = open("unlinkread", O_CREATE | O_RDWR);
  if(fd < 0){
    printf("create unlinkread failed\n");
40001fde:	c7 04 24 2e 31 00 40 	movl   $0x4000312e,(%esp)
40001fe5:	e8 e6 e2 ff ff       	call   400002d0 <printf>
    exit();
  }
  close(fd);
  unlink("unlinkread");
  printf("=====unlinkread ok=====\n\n");
}
40001fea:	83 c4 1c             	add    $0x1c,%esp
40001fed:	5b                   	pop    %ebx
40001fee:	5e                   	pop    %esi
40001fef:	5f                   	pop    %edi
40001ff0:	5d                   	pop    %ebp
40001ff1:	c3                   	ret    
40001ff2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  int fd, fd1;

  printf("=====unlinkread test=====\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
  if(fd < 0){
40001ff8:	85 db                	test   %ebx,%ebx
40001ffa:	89 df                	mov    %ebx,%edi
40001ffc:	78 e0                	js     40001fde <unlinkread+0x2e>
sys_write(int fd, char *p, int n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
40001ffe:	b9 67 30 00 40       	mov    $0x40003067,%ecx
40002003:	b8 08 00 00 00       	mov    $0x8,%eax
40002008:	cd 30                	int    $0x30
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
4000200a:	b8 06 00 00 00       	mov    $0x6,%eax
4000200f:	89 fb                	mov    %edi,%ebx
40002011:	cd 30                	int    $0x30
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40002013:	b9 02 00 00 00       	mov    $0x2,%ecx
40002018:	89 d0                	mov    %edx,%eax
4000201a:	89 f3                	mov    %esi,%ebx
4000201c:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
4000201e:	85 c0                	test   %eax,%eax
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40002020:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40002024:	0f 85 de 00 00 00    	jne    40002108 <unlinkread+0x158>
  }
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
  if(fd < 0){
4000202a:	85 db                	test   %ebx,%ebx
4000202c:	0f 88 d6 00 00 00    	js     40002108 <unlinkread+0x158>
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40002032:	b8 0c 00 00 00       	mov    $0xc,%eax
40002037:	89 f3                	mov    %esi,%ebx
40002039:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_unlink),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
4000203b:	85 c0                	test   %eax,%eax
4000203d:	74 19                	je     40002058 <unlinkread+0xa8>
    printf("open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    printf("unlink unlinkread failed\n");
4000203f:	c7 04 24 c5 31 00 40 	movl   $0x400031c5,(%esp)
40002046:	e8 85 e2 ff ff       	call   400002d0 <printf>
    exit();
  }
  close(fd);
  unlink("unlinkread");
  printf("=====unlinkread ok=====\n\n");
}
4000204b:	83 c4 1c             	add    $0x1c,%esp
4000204e:	5b                   	pop    %ebx
4000204f:	5e                   	pop    %esi
40002050:	5f                   	pop    %edi
40002051:	5d                   	pop    %ebp
40002052:	c3                   	ret    
40002053:	90                   	nop
40002054:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40002058:	89 d0                	mov    %edx,%eax
4000205a:	89 f3                	mov    %esi,%ebx
4000205c:	89 e9                	mov    %ebp,%ecx
4000205e:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40002060:	bf ff ff ff ff       	mov    $0xffffffff,%edi
40002065:	85 c0                	test   %eax,%eax
40002067:	0f 44 fb             	cmove  %ebx,%edi
sys_write(int fd, char *p, int n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
4000206a:	ba 03 00 00 00       	mov    $0x3,%edx
4000206f:	b9 60 31 00 40       	mov    $0x40003160,%ecx
40002074:	b8 08 00 00 00       	mov    $0x8,%eax
40002079:	89 fb                	mov    %edi,%ebx
4000207b:	cd 30                	int    $0x30
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
4000207d:	b8 06 00 00 00       	mov    $0x6,%eax
40002082:	89 fb                	mov    %edi,%ebx
40002084:	cd 30                	int    $0x30
sys_read(int fd, char *buf, size_t n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
40002086:	b9 a0 54 00 40       	mov    $0x400054a0,%ecx
4000208b:	66 ba 00 20          	mov    $0x2000,%dx
4000208f:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40002093:	b8 07 00 00 00       	mov    $0x7,%eax
40002098:	cd 30                	int    $0x30
		       "b" (fd),
		       "c" (buf),
		       "d" (n)
		     : "cc", "memory");

	return errno ? -1 : ret;
4000209a:	85 c0                	test   %eax,%eax
4000209c:	74 1a                	je     400020b8 <unlinkread+0x108>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
  write(fd1, "yyy", 3);
  close(fd1);

  if(read(fd, buf, sizeof(buf)) != 5){
    printf("unlinkread read failed");
4000209e:	c7 04 24 64 31 00 40 	movl   $0x40003164,(%esp)
400020a5:	e8 26 e2 ff ff       	call   400002d0 <printf>
    exit();
  }
  close(fd);
  unlink("unlinkread");
  printf("=====unlinkread ok=====\n\n");
}
400020aa:	83 c4 1c             	add    $0x1c,%esp
400020ad:	5b                   	pop    %ebx
400020ae:	5e                   	pop    %esi
400020af:	5f                   	pop    %edi
400020b0:	5d                   	pop    %ebp
400020b1:	c3                   	ret    
400020b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
  write(fd1, "yyy", 3);
  close(fd1);

  if(read(fd, buf, sizeof(buf)) != 5){
400020b8:	83 fb 05             	cmp    $0x5,%ebx
400020bb:	75 e1                	jne    4000209e <unlinkread+0xee>
    printf("unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
400020bd:	80 3d a0 54 00 40 68 	cmpb   $0x68,0x400054a0
400020c4:	75 72                	jne    40002138 <unlinkread+0x188>
sys_write(int fd, char *p, int n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
400020c6:	ba 0a 00 00 00       	mov    $0xa,%edx
400020cb:	b8 08 00 00 00       	mov    $0x8,%eax
400020d0:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
400020d4:	cd 30                	int    $0x30
		       "b" (fd),
		       "c" (p),
		       "d" (n)
		     : "cc", "memory");

	return errno ? -1 : ret;
400020d6:	85 c0                	test   %eax,%eax
400020d8:	75 46                	jne    40002120 <unlinkread+0x170>
    printf("unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
400020da:	83 fb 0a             	cmp    $0xa,%ebx
400020dd:	75 41                	jne    40002120 <unlinkread+0x170>
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
400020df:	b8 06 00 00 00       	mov    $0x6,%eax
400020e4:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
400020e8:	cd 30                	int    $0x30
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
400020ea:	b8 0c 00 00 00       	mov    $0xc,%eax
400020ef:	89 f3                	mov    %esi,%ebx
400020f1:	cd 30                	int    $0x30
    printf("unlinkread write failed\n");
    exit();
  }
  close(fd);
  unlink("unlinkread");
  printf("=====unlinkread ok=====\n\n");
400020f3:	c7 04 24 ab 31 00 40 	movl   $0x400031ab,(%esp)
400020fa:	e8 d1 e1 ff ff       	call   400002d0 <printf>
400020ff:	e9 e6 fe ff ff       	jmp    40001fea <unlinkread+0x3a>
40002104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
  if(fd < 0){
    printf("open unlinkread failed\n");
40002108:	c7 04 24 48 31 00 40 	movl   $0x40003148,(%esp)
4000210f:	e8 bc e1 ff ff       	call   400002d0 <printf>
    exit();
40002114:	e9 d1 fe ff ff       	jmp    40001fea <unlinkread+0x3a>
40002119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(buf[0] != 'h'){
    printf("unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    printf("unlinkread write failed\n");
40002120:	c7 04 24 92 31 00 40 	movl   $0x40003192,(%esp)
40002127:	e8 a4 e1 ff ff       	call   400002d0 <printf>
    exit();
  }
  close(fd);
  unlink("unlinkread");
  printf("=====unlinkread ok=====\n\n");
}
4000212c:	83 c4 1c             	add    $0x1c,%esp
4000212f:	5b                   	pop    %ebx
40002130:	5e                   	pop    %esi
40002131:	5f                   	pop    %edi
40002132:	5d                   	pop    %ebp
40002133:	c3                   	ret    
40002134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(read(fd, buf, sizeof(buf)) != 5){
    printf("unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    printf("unlinkread wrong data\n");
40002138:	c7 04 24 7b 31 00 40 	movl   $0x4000317b,(%esp)
4000213f:	e8 8c e1 ff ff       	call   400002d0 <printf>
    exit();
  }
  close(fd);
  unlink("unlinkread");
  printf("=====unlinkread ok=====\n\n");
}
40002144:	83 c4 1c             	add    $0x1c,%esp
40002147:	5b                   	pop    %ebx
40002148:	5e                   	pop    %esi
40002149:	5f                   	pop    %edi
4000214a:	5d                   	pop    %ebp
4000214b:	c3                   	ret    
4000214c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40002150 <dirfile>:

void
dirfile(void)
{
40002150:	57                   	push   %edi
40002151:	56                   	push   %esi
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40002152:	be 05 00 00 00       	mov    $0x5,%esi
40002157:	53                   	push   %ebx
40002158:	83 ec 10             	sub    $0x10,%esp
  int fd;

  printf("=====dir vs file=====\n");
4000215b:	c7 04 24 df 31 00 40 	movl   $0x400031df,(%esp)
40002162:	e8 69 e1 ff ff       	call   400002d0 <printf>
40002167:	ba f6 31 00 40       	mov    $0x400031f6,%edx
4000216c:	b9 00 02 00 00       	mov    $0x200,%ecx
40002171:	89 f0                	mov    %esi,%eax
40002173:	89 d3                	mov    %edx,%ebx
40002175:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
40002177:	85 c0                	test   %eax,%eax
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40002179:	89 c1                	mov    %eax,%ecx
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
4000217b:	74 13                	je     40002190 <dirfile+0x40>

  fd = open("dirfile", O_CREATE);
  if(fd < 0){
    printf("create dirfile failed\n");
4000217d:	c7 04 24 fe 31 00 40 	movl   $0x400031fe,(%esp)
40002184:	e8 47 e1 ff ff       	call   400002d0 <printf>
    exit();
  }
  close(fd);

  printf("=====dir vs file OK=====\n\n");
}
40002189:	83 c4 10             	add    $0x10,%esp
4000218c:	5b                   	pop    %ebx
4000218d:	5e                   	pop    %esi
4000218e:	5f                   	pop    %edi
4000218f:	c3                   	ret    
  int fd;

  printf("=====dir vs file=====\n");

  fd = open("dirfile", O_CREATE);
  if(fd < 0){
40002190:	85 db                	test   %ebx,%ebx
40002192:	78 e9                	js     4000217d <dirfile+0x2d>
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
40002194:	b8 06 00 00 00       	mov    $0x6,%eax
40002199:	cd 30                	int    $0x30
static gcc_inline int
sys_chdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
4000219b:	b8 0a 00 00 00       	mov    $0xa,%eax
400021a0:	89 d3                	mov    %edx,%ebx
400021a2:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_chdir),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
400021a4:	85 c0                	test   %eax,%eax
400021a6:	74 28                	je     400021d0 <dirfile+0x80>
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
400021a8:	bf 33 32 00 40       	mov    $0x40003233,%edi
400021ad:	89 f0                	mov    %esi,%eax
400021af:	89 fb                	mov    %edi,%ebx
400021b1:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
400021b3:	85 c0                	test   %eax,%eax
400021b5:	75 31                	jne    400021e8 <dirfile+0x98>
  if(chdir("dirfile") == 0){
    printf("chdir dirfile succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", 0);
  if(fd >= 0){
400021b7:	85 db                	test   %ebx,%ebx
400021b9:	78 2d                	js     400021e8 <dirfile+0x98>
    printf("create dirfile/xx succeeded!\n");
400021bb:	c7 04 24 15 32 00 40 	movl   $0x40003215,(%esp)
400021c2:	e8 09 e1 ff ff       	call   400002d0 <printf>
    exit();
  }
  close(fd);

  printf("=====dir vs file OK=====\n\n");
}
400021c7:	83 c4 10             	add    $0x10,%esp
400021ca:	5b                   	pop    %ebx
400021cb:	5e                   	pop    %esi
400021cc:	5f                   	pop    %edi
400021cd:	c3                   	ret    
400021ce:	66 90                	xchg   %ax,%ax
    printf("create dirfile failed\n");
    exit();
  }
  close(fd);
  if(chdir("dirfile") == 0){
    printf("chdir dirfile succeeded!\n");
400021d0:	c7 04 24 6d 32 00 40 	movl   $0x4000326d,(%esp)
400021d7:	e8 f4 e0 ff ff       	call   400002d0 <printf>
    exit();
  }
  close(fd);

  printf("=====dir vs file OK=====\n\n");
}
400021dc:	83 c4 10             	add    $0x10,%esp
400021df:	5b                   	pop    %ebx
400021e0:	5e                   	pop    %esi
400021e1:	5f                   	pop    %edi
400021e2:	c3                   	ret    
400021e3:	90                   	nop
400021e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
400021e8:	b9 00 02 00 00       	mov    $0x200,%ecx
400021ed:	b8 05 00 00 00       	mov    $0x5,%eax
400021f2:	89 fb                	mov    %edi,%ebx
400021f4:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
400021f6:	85 c0                	test   %eax,%eax
400021f8:	75 06                	jne    40002200 <dirfile+0xb0>
  if(fd >= 0){
    printf("create dirfile/xx succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", O_CREATE);
  if(fd >= 0){
400021fa:	85 db                	test   %ebx,%ebx
400021fc:	79 bd                	jns    400021bb <dirfile+0x6b>
400021fe:	66 90                	xchg   %ax,%ax
static gcc_inline int
sys_mkdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40002200:	b9 33 32 00 40       	mov    $0x40003233,%ecx
40002205:	b8 09 00 00 00       	mov    $0x9,%eax
4000220a:	89 fb                	mov    %edi,%ebx
4000220c:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_mkdir),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
4000220e:	85 c0                	test   %eax,%eax
40002210:	74 26                	je     40002238 <dirfile+0xe8>
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40002212:	be 0c 00 00 00       	mov    $0xc,%esi
40002217:	89 cb                	mov    %ecx,%ebx
40002219:	89 f0                	mov    %esi,%eax
4000221b:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_unlink),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
4000221d:	85 c0                	test   %eax,%eax
4000221f:	75 2f                	jne    40002250 <dirfile+0x100>
  if(mkdir("dirfile/xx") == 0){
    printf("mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
    printf("unlink dirfile/xx succeeded!\n");
40002221:	c7 04 24 a4 32 00 40 	movl   $0x400032a4,(%esp)
40002228:	e8 a3 e0 ff ff       	call   400002d0 <printf>
    exit();
4000222d:	e9 57 ff ff ff       	jmp    40002189 <dirfile+0x39>
40002232:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(fd >= 0){
    printf("create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
    printf("mkdir dirfile/xx succeeded!\n");
40002238:	c7 04 24 87 32 00 40 	movl   $0x40003287,(%esp)
4000223f:	e8 8c e0 ff ff       	call   400002d0 <printf>
    exit();
  }
  close(fd);

  printf("=====dir vs file OK=====\n\n");
}
40002244:	83 c4 10             	add    $0x10,%esp
40002247:	5b                   	pop    %ebx
40002248:	5e                   	pop    %esi
40002249:	5f                   	pop    %edi
4000224a:	c3                   	ret    
4000224b:	90                   	nop
4000224c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static gcc_inline int
sys_link(char *old, char* new)
{
  int errno, ret;

	asm volatile("int %2"
40002250:	bb c2 32 00 40       	mov    $0x400032c2,%ebx
40002255:	b8 0b 00 00 00       	mov    $0xb,%eax
4000225a:	cd 30                	int    $0x30
		       "a" (SYS_link),
		       "b" (old),
		       "c" (new)
		     : "cc", "memory");

	return errno ? -1 : 0;
4000225c:	85 c0                	test   %eax,%eax
4000225e:	74 20                	je     40002280 <dirfile+0x130>
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40002260:	89 f0                	mov    %esi,%eax
40002262:	89 d3                	mov    %edx,%ebx
40002264:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_unlink),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40002266:	85 c0                	test   %eax,%eax
40002268:	74 2e                	je     40002298 <dirfile+0x148>
  if(link("README", "dirfile/xx") == 0){
    printf("link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
    printf("unlink dirfile failed!\n");
4000226a:	c7 04 24 c9 32 00 40 	movl   $0x400032c9,(%esp)
40002271:	e8 5a e0 ff ff       	call   400002d0 <printf>
    exit();
40002276:	e9 0e ff ff ff       	jmp    40002189 <dirfile+0x39>
4000227b:	90                   	nop
4000227c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(unlink("dirfile/xx") == 0){
    printf("unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
    printf("link to dirfile/xx succeeded!\n");
40002280:	c7 04 24 10 38 00 40 	movl   $0x40003810,(%esp)
40002287:	e8 44 e0 ff ff       	call   400002d0 <printf>
    exit();
4000228c:	e9 f8 fe ff ff       	jmp    40002189 <dirfile+0x39>
40002291:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40002298:	ba 16 2f 00 40       	mov    $0x40002f16,%edx
4000229d:	b9 02 00 00 00       	mov    $0x2,%ecx
400022a2:	b8 05 00 00 00       	mov    $0x5,%eax
400022a7:	89 d3                	mov    %edx,%ebx
400022a9:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
400022ab:	85 c0                	test   %eax,%eax
400022ad:	75 19                	jne    400022c8 <dirfile+0x178>
    printf("unlink dirfile failed!\n");
    exit();
  }

  fd = open(".", O_RDWR);
  if(fd >= 0){
400022af:	85 db                	test   %ebx,%ebx
400022b1:	78 15                	js     400022c8 <dirfile+0x178>
    printf("open . for writing succeeded!\n");
400022b3:	c7 04 24 f0 37 00 40 	movl   $0x400037f0,(%esp)
400022ba:	e8 11 e0 ff ff       	call   400002d0 <printf>
    exit();
400022bf:	e9 c5 fe ff ff       	jmp    40002189 <dirfile+0x39>
400022c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
400022c8:	31 c9                	xor    %ecx,%ecx
400022ca:	b8 05 00 00 00       	mov    $0x5,%eax
400022cf:	89 d3                	mov    %edx,%ebx
400022d1:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
400022d3:	be ff ff ff ff       	mov    $0xffffffff,%esi
400022d8:	85 c0                	test   %eax,%eax
400022da:	0f 44 f3             	cmove  %ebx,%esi
sys_write(int fd, char *p, int n)
{
	int errno;
	size_t ret;

	asm volatile("int %2"
400022dd:	ba 01 00 00 00       	mov    $0x1,%edx
400022e2:	b9 7a 2e 00 40       	mov    $0x40002e7a,%ecx
400022e7:	b8 08 00 00 00       	mov    $0x8,%eax
400022ec:	89 f3                	mov    %esi,%ebx
400022ee:	cd 30                	int    $0x30
		       "b" (fd),
		       "c" (p),
		       "d" (n)
		     : "cc", "memory");

	return errno ? -1 : ret;
400022f0:	85 c0                	test   %eax,%eax
400022f2:	75 1c                	jne    40002310 <dirfile+0x1c0>
  }
  fd = open(".", 0);
  if(write(fd, "x", 1) > 0){
400022f4:	85 db                	test   %ebx,%ebx
400022f6:	7e 18                	jle    40002310 <dirfile+0x1c0>
    printf("write . succeeded!\n");
400022f8:	c7 04 24 3e 32 00 40 	movl   $0x4000323e,(%esp)
400022ff:	e8 cc df ff ff       	call   400002d0 <printf>
    exit();
40002304:	e9 80 fe ff ff       	jmp    40002189 <dirfile+0x39>
40002309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
40002310:	b8 06 00 00 00       	mov    $0x6,%eax
40002315:	89 f3                	mov    %esi,%ebx
40002317:	cd 30                	int    $0x30
  }
  close(fd);

  printf("=====dir vs file OK=====\n\n");
40002319:	c7 04 24 52 32 00 40 	movl   $0x40003252,(%esp)
40002320:	e8 ab df ff ff       	call   400002d0 <printf>
40002325:	e9 5f fe ff ff       	jmp    40002189 <dirfile+0x39>
4000232a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40002330 <iref>:
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
40002330:	55                   	push   %ebp
40002331:	bd fc 32 00 40       	mov    $0x400032fc,%ebp
40002336:	57                   	push   %edi
  int i, fd;

  printf("=====empty file name=====\n");
40002337:	bf 33 00 00 00       	mov    $0x33,%edi
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
4000233c:	56                   	push   %esi
static gcc_inline int
sys_mkdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
4000233d:	be 09 00 00 00       	mov    $0x9,%esi
40002342:	53                   	push   %ebx
40002343:	83 ec 1c             	sub    $0x1c,%esp
  int i, fd;

  printf("=====empty file name=====\n");
40002346:	c7 04 24 e1 32 00 40 	movl   $0x400032e1,(%esp)
4000234d:	e8 7e df ff ff       	call   400002d0 <printf>
40002352:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40002358:	89 f0                	mov    %esi,%eax
4000235a:	89 eb                	mov    %ebp,%ebx
4000235c:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_mkdir),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
4000235e:	85 c0                	test   %eax,%eax
40002360:	74 16                	je     40002378 <iref+0x48>

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
      printf("mkdir irefd failed\n");
40002362:	c7 04 24 02 33 00 40 	movl   $0x40003302,(%esp)
40002369:	e8 62 df ff ff       	call   400002d0 <printf>
    unlink("xx");
  }

  chdir("/");
  printf("=====empty file name OK=====\n\n");
}
4000236e:	83 c4 1c             	add    $0x1c,%esp
40002371:	5b                   	pop    %ebx
40002372:	5e                   	pop    %esi
40002373:	5f                   	pop    %edi
40002374:	5d                   	pop    %ebp
40002375:	c3                   	ret    
40002376:	66 90                	xchg   %ax,%ax
static gcc_inline int
sys_chdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40002378:	b8 0a 00 00 00       	mov    $0xa,%eax
4000237d:	bb fc 32 00 40       	mov    $0x400032fc,%ebx
40002382:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_chdir),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40002384:	85 c0                	test   %eax,%eax
40002386:	74 18                	je     400023a0 <iref+0x70>
    if(mkdir("irefd") != 0){
      printf("mkdir irefd failed\n");
      exit();
    }
    if(chdir("irefd") != 0){
      printf("chdir irefd failed\n");
40002388:	c7 04 24 16 33 00 40 	movl   $0x40003316,(%esp)
4000238f:	e8 3c df ff ff       	call   400002d0 <printf>
    unlink("xx");
  }

  chdir("/");
  printf("=====empty file name OK=====\n\n");
}
40002394:	83 c4 1c             	add    $0x1c,%esp
40002397:	5b                   	pop    %ebx
40002398:	5e                   	pop    %esi
40002399:	5f                   	pop    %edi
4000239a:	5d                   	pop    %ebp
4000239b:	c3                   	ret    
4000239c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static gcc_inline int
sys_mkdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
400023a0:	ba 6c 32 00 40       	mov    $0x4000326c,%edx
400023a5:	89 f0                	mov    %esi,%eax
400023a7:	89 d3                	mov    %edx,%ebx
400023a9:	cd 30                	int    $0x30
static gcc_inline int
sys_link(char *old, char* new)
{
  int errno, ret;

	asm volatile("int %2"
400023ab:	bb c2 32 00 40       	mov    $0x400032c2,%ebx
400023b0:	b8 0b 00 00 00       	mov    $0xb,%eax
400023b5:	89 d1                	mov    %edx,%ecx
400023b7:	cd 30                	int    $0x30
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
400023b9:	b9 00 02 00 00       	mov    $0x200,%ecx
400023be:	b8 05 00 00 00       	mov    $0x5,%eax
400023c3:	89 d3                	mov    %edx,%ebx
400023c5:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
400023c7:	85 c0                	test   %eax,%eax
400023c9:	75 0b                	jne    400023d6 <iref+0xa6>
    }

    mkdir("");
    link("README", "");
    fd = open("", O_CREATE);
    if(fd >= 0)
400023cb:	85 db                	test   %ebx,%ebx
400023cd:	78 07                	js     400023d6 <iref+0xa6>
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
400023cf:	b8 06 00 00 00       	mov    $0x6,%eax
400023d4:	cd 30                	int    $0x30
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
400023d6:	ba 79 2e 00 40       	mov    $0x40002e79,%edx
400023db:	b9 00 02 00 00       	mov    $0x200,%ecx
400023e0:	b8 05 00 00 00       	mov    $0x5,%eax
400023e5:	89 d3                	mov    %edx,%ebx
400023e7:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
400023e9:	85 c0                	test   %eax,%eax
400023eb:	75 08                	jne    400023f5 <iref+0xc5>
      close(fd);
    fd = open("xx", O_CREATE);
    if(fd >= 0)
400023ed:	85 db                	test   %ebx,%ebx
400023ef:	78 04                	js     400023f5 <iref+0xc5>
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
400023f1:	b0 06                	mov    $0x6,%al
400023f3:	cd 30                	int    $0x30
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
400023f5:	b8 0c 00 00 00       	mov    $0xc,%eax
400023fa:	89 d3                	mov    %edx,%ebx
400023fc:	cd 30                	int    $0x30
  int i, fd;

  printf("=====empty file name=====\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
400023fe:	83 ef 01             	sub    $0x1,%edi
40002401:	0f 85 51 ff ff ff    	jne    40002358 <iref+0x28>
static gcc_inline int
sys_chdir(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40002407:	bb 5f 2b 00 40       	mov    $0x40002b5f,%ebx
4000240c:	b8 0a 00 00 00       	mov    $0xa,%eax
40002411:	cd 30                	int    $0x30
      close(fd);
    unlink("xx");
  }

  chdir("/");
  printf("=====empty file name OK=====\n\n");
40002413:	c7 04 24 30 38 00 40 	movl   $0x40003830,(%esp)
4000241a:	e8 b1 de ff ff       	call   400002d0 <printf>
4000241f:	e9 4a ff ff ff       	jmp    4000236e <iref+0x3e>
40002424:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
4000242a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

40002430 <bigdir>:
  char namel[10];

// directory that uses indirect blocks
void
bigdir(void)
{
40002430:	57                   	push   %edi
40002431:	56                   	push   %esi
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
40002432:	be 41 33 00 40       	mov    $0x40003341,%esi
40002437:	53                   	push   %ebx
40002438:	89 f3                	mov    %esi,%ebx
4000243a:	83 ec 10             	sub    $0x10,%esp
  int i, fd;

  printf("=====bigdir test=====\n");
4000243d:	c7 04 24 2a 33 00 40 	movl   $0x4000332a,(%esp)
40002444:	e8 87 de ff ff       	call   400002d0 <printf>
40002449:	b8 0c 00 00 00       	mov    $0xc,%eax
4000244e:	cd 30                	int    $0x30
sys_open(char *path, int omode)
{
	int errno;
	int fd;

	asm volatile("int %2"
40002450:	b9 00 02 00 00       	mov    $0x200,%ecx
40002455:	b8 05 00 00 00       	mov    $0x5,%eax
4000245a:	89 f3                	mov    %esi,%ebx
4000245c:	cd 30                	int    $0x30
		       "a" (SYS_open),
		       "b" (path),
		       "c" (omode)
		     : "cc", "memory");

	return errno ? -1 : fd;
4000245e:	85 c0                	test   %eax,%eax
40002460:	74 16                	je     40002478 <bigdir+0x48>
  unlink("bd");

  fd = open("bd", O_CREATE);
  if(fd < 0){
    printf("bigdir create failed\n");
40002462:	c7 04 24 44 33 00 40 	movl   $0x40003344,(%esp)
40002469:	e8 62 de ff ff       	call   400002d0 <printf>
4000246e:	66 90                	xchg   %ax,%ax
      exit();
    }
  }

  printf("=====bigdir ok=====\n\n");
}
40002470:	83 c4 10             	add    $0x10,%esp
40002473:	5b                   	pop    %ebx
40002474:	5e                   	pop    %esi
40002475:	5f                   	pop    %edi
40002476:	c3                   	ret    
40002477:	90                   	nop

  printf("=====bigdir test=====\n");
  unlink("bd");

  fd = open("bd", O_CREATE);
  if(fd < 0){
40002478:	85 db                	test   %ebx,%ebx
4000247a:	78 e6                	js     40002462 <bigdir+0x32>
sys_close(int fd)
{
	int errno;
	int ret;

	asm volatile("int %2"
4000247c:	b8 06 00 00 00       	mov    $0x6,%eax
40002481:	cd 30                	int    $0x30
40002483:	31 d2                	xor    %edx,%edx
40002485:	b9 80 54 00 40       	mov    $0x40005480,%ecx
static gcc_inline int
sys_link(char *old, char* new)
{
  int errno, ret;

	asm volatile("int %2"
4000248a:	bf 0b 00 00 00       	mov    $0xb,%edi
4000248f:	90                   	nop
  }
  close(fd);

  for(i = 0; i < 500; i++){
    namel[0] = 'x';
    namel[1] = '0' + (i / 64);
40002490:	89 d0                	mov    %edx,%eax
40002492:	89 f3                	mov    %esi,%ebx
40002494:	c1 f8 06             	sar    $0x6,%eax
40002497:	83 c0 30             	add    $0x30,%eax
4000249a:	a2 81 54 00 40       	mov    %al,0x40005481
    namel[2] = '0' + (i % 64);
4000249f:	89 d0                	mov    %edx,%eax
400024a1:	83 e0 3f             	and    $0x3f,%eax
400024a4:	83 c0 30             	add    $0x30,%eax
400024a7:	a2 82 54 00 40       	mov    %al,0x40005482
400024ac:	89 f8                	mov    %edi,%eax
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    namel[0] = 'x';
400024ae:	c6 05 80 54 00 40 78 	movb   $0x78,0x40005480
    namel[1] = '0' + (i / 64);
    namel[2] = '0' + (i % 64);
    namel[3] = '\0';
400024b5:	c6 05 83 54 00 40 00 	movb   $0x0,0x40005483
400024bc:	cd 30                	int    $0x30
		       "a" (SYS_link),
		       "b" (old),
		       "c" (new)
		     : "cc", "memory");

	return errno ? -1 : 0;
400024be:	85 c0                	test   %eax,%eax
400024c0:	74 16                	je     400024d8 <bigdir+0xa8>
    if(link("bd", namel) != 0){
      printf("bigdir link failed\n");
400024c2:	c7 04 24 70 33 00 40 	movl   $0x40003370,(%esp)
400024c9:	e8 02 de ff ff       	call   400002d0 <printf>
      exit();
    }
  }

  printf("=====bigdir ok=====\n\n");
}
400024ce:	83 c4 10             	add    $0x10,%esp
400024d1:	5b                   	pop    %ebx
400024d2:	5e                   	pop    %esi
400024d3:	5f                   	pop    %edi
400024d4:	c3                   	ret    
400024d5:	8d 76 00             	lea    0x0(%esi),%esi
    printf("bigdir create failed\n");
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
400024d8:	83 c2 01             	add    $0x1,%edx
400024db:	81 fa f4 01 00 00    	cmp    $0x1f4,%edx
400024e1:	75 ad                	jne    40002490 <bigdir+0x60>
static gcc_inline int
sys_unlink(char *path)
{
  int errno, ret;

	asm volatile("int %2"
400024e3:	b8 0c 00 00 00       	mov    $0xc,%eax
400024e8:	bb 41 33 00 40       	mov    $0x40003341,%ebx
400024ed:	cd 30                	int    $0x30
400024ef:	31 d2                	xor    %edx,%edx
400024f1:	be 0c 00 00 00       	mov    $0xc,%esi
400024f6:	66 90                	xchg   %ax,%ax
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    namel[0] = 'x';
    namel[1] = '0' + (i / 64);
400024f8:	89 d0                	mov    %edx,%eax
400024fa:	89 cb                	mov    %ecx,%ebx
400024fc:	c1 f8 06             	sar    $0x6,%eax
400024ff:	83 c0 30             	add    $0x30,%eax
40002502:	a2 81 54 00 40       	mov    %al,0x40005481
    namel[2] = '0' + (i % 64);
40002507:	89 d0                	mov    %edx,%eax
40002509:	83 e0 3f             	and    $0x3f,%eax
4000250c:	83 c0 30             	add    $0x30,%eax
4000250f:	a2 82 54 00 40       	mov    %al,0x40005482
40002514:	89 f0                	mov    %esi,%eax
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    namel[0] = 'x';
40002516:	c6 05 80 54 00 40 78 	movb   $0x78,0x40005480
    namel[1] = '0' + (i / 64);
    namel[2] = '0' + (i % 64);
    namel[3] = '\0';
4000251d:	c6 05 83 54 00 40 00 	movb   $0x0,0x40005483
40002524:	cd 30                	int    $0x30
		     : "i" (T_SYSCALL),
		       "a" (SYS_unlink),
		       "b" (path)
		     : "cc", "memory");

	return errno ? -1 : 0;
40002526:	85 c0                	test   %eax,%eax
40002528:	74 16                	je     40002540 <bigdir+0x110>
    if(unlink(namel) != 0){
      printf("bigdir unlink failed");
4000252a:	c7 04 24 84 33 00 40 	movl   $0x40003384,(%esp)
40002531:	e8 9a dd ff ff       	call   400002d0 <printf>
      exit();
40002536:	e9 35 ff ff ff       	jmp    40002470 <bigdir+0x40>
4000253b:	90                   	nop
4000253c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      exit();
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
40002540:	83 c2 01             	add    $0x1,%edx
40002543:	81 fa f4 01 00 00    	cmp    $0x1f4,%edx
40002549:	75 ad                	jne    400024f8 <bigdir+0xc8>
      printf("bigdir unlink failed");
      exit();
    }
  }

  printf("=====bigdir ok=====\n\n");
4000254b:	c7 04 24 5a 33 00 40 	movl   $0x4000335a,(%esp)
40002552:	e8 79 dd ff ff       	call   400002d0 <printf>
40002557:	e9 14 ff ff ff       	jmp    40002470 <bigdir+0x40>
4000255c:	66 90                	xchg   %ax,%ax
4000255e:	66 90                	xchg   %ax,%ax

40002560 <__udivdi3>:
40002560:	55                   	push   %ebp
40002561:	57                   	push   %edi
40002562:	56                   	push   %esi
40002563:	83 ec 0c             	sub    $0xc,%esp
40002566:	8b 44 24 28          	mov    0x28(%esp),%eax
4000256a:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
4000256e:	8b 6c 24 20          	mov    0x20(%esp),%ebp
40002572:	8b 4c 24 24          	mov    0x24(%esp),%ecx
40002576:	85 c0                	test   %eax,%eax
40002578:	89 7c 24 04          	mov    %edi,0x4(%esp)
4000257c:	89 ea                	mov    %ebp,%edx
4000257e:	89 0c 24             	mov    %ecx,(%esp)
40002581:	75 2d                	jne    400025b0 <__udivdi3+0x50>
40002583:	39 e9                	cmp    %ebp,%ecx
40002585:	77 61                	ja     400025e8 <__udivdi3+0x88>
40002587:	85 c9                	test   %ecx,%ecx
40002589:	89 ce                	mov    %ecx,%esi
4000258b:	75 0b                	jne    40002598 <__udivdi3+0x38>
4000258d:	b8 01 00 00 00       	mov    $0x1,%eax
40002592:	31 d2                	xor    %edx,%edx
40002594:	f7 f1                	div    %ecx
40002596:	89 c6                	mov    %eax,%esi
40002598:	31 d2                	xor    %edx,%edx
4000259a:	89 e8                	mov    %ebp,%eax
4000259c:	f7 f6                	div    %esi
4000259e:	89 c5                	mov    %eax,%ebp
400025a0:	89 f8                	mov    %edi,%eax
400025a2:	f7 f6                	div    %esi
400025a4:	89 ea                	mov    %ebp,%edx
400025a6:	83 c4 0c             	add    $0xc,%esp
400025a9:	5e                   	pop    %esi
400025aa:	5f                   	pop    %edi
400025ab:	5d                   	pop    %ebp
400025ac:	c3                   	ret    
400025ad:	8d 76 00             	lea    0x0(%esi),%esi
400025b0:	39 e8                	cmp    %ebp,%eax
400025b2:	77 24                	ja     400025d8 <__udivdi3+0x78>
400025b4:	0f bd e8             	bsr    %eax,%ebp
400025b7:	83 f5 1f             	xor    $0x1f,%ebp
400025ba:	75 3c                	jne    400025f8 <__udivdi3+0x98>
400025bc:	8b 74 24 04          	mov    0x4(%esp),%esi
400025c0:	39 34 24             	cmp    %esi,(%esp)
400025c3:	0f 86 9f 00 00 00    	jbe    40002668 <__udivdi3+0x108>
400025c9:	39 d0                	cmp    %edx,%eax
400025cb:	0f 82 97 00 00 00    	jb     40002668 <__udivdi3+0x108>
400025d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400025d8:	31 d2                	xor    %edx,%edx
400025da:	31 c0                	xor    %eax,%eax
400025dc:	83 c4 0c             	add    $0xc,%esp
400025df:	5e                   	pop    %esi
400025e0:	5f                   	pop    %edi
400025e1:	5d                   	pop    %ebp
400025e2:	c3                   	ret    
400025e3:	90                   	nop
400025e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400025e8:	89 f8                	mov    %edi,%eax
400025ea:	f7 f1                	div    %ecx
400025ec:	31 d2                	xor    %edx,%edx
400025ee:	83 c4 0c             	add    $0xc,%esp
400025f1:	5e                   	pop    %esi
400025f2:	5f                   	pop    %edi
400025f3:	5d                   	pop    %ebp
400025f4:	c3                   	ret    
400025f5:	8d 76 00             	lea    0x0(%esi),%esi
400025f8:	89 e9                	mov    %ebp,%ecx
400025fa:	8b 3c 24             	mov    (%esp),%edi
400025fd:	d3 e0                	shl    %cl,%eax
400025ff:	89 c6                	mov    %eax,%esi
40002601:	b8 20 00 00 00       	mov    $0x20,%eax
40002606:	29 e8                	sub    %ebp,%eax
40002608:	89 c1                	mov    %eax,%ecx
4000260a:	d3 ef                	shr    %cl,%edi
4000260c:	89 e9                	mov    %ebp,%ecx
4000260e:	89 7c 24 08          	mov    %edi,0x8(%esp)
40002612:	8b 3c 24             	mov    (%esp),%edi
40002615:	09 74 24 08          	or     %esi,0x8(%esp)
40002619:	89 d6                	mov    %edx,%esi
4000261b:	d3 e7                	shl    %cl,%edi
4000261d:	89 c1                	mov    %eax,%ecx
4000261f:	89 3c 24             	mov    %edi,(%esp)
40002622:	8b 7c 24 04          	mov    0x4(%esp),%edi
40002626:	d3 ee                	shr    %cl,%esi
40002628:	89 e9                	mov    %ebp,%ecx
4000262a:	d3 e2                	shl    %cl,%edx
4000262c:	89 c1                	mov    %eax,%ecx
4000262e:	d3 ef                	shr    %cl,%edi
40002630:	09 d7                	or     %edx,%edi
40002632:	89 f2                	mov    %esi,%edx
40002634:	89 f8                	mov    %edi,%eax
40002636:	f7 74 24 08          	divl   0x8(%esp)
4000263a:	89 d6                	mov    %edx,%esi
4000263c:	89 c7                	mov    %eax,%edi
4000263e:	f7 24 24             	mull   (%esp)
40002641:	39 d6                	cmp    %edx,%esi
40002643:	89 14 24             	mov    %edx,(%esp)
40002646:	72 30                	jb     40002678 <__udivdi3+0x118>
40002648:	8b 54 24 04          	mov    0x4(%esp),%edx
4000264c:	89 e9                	mov    %ebp,%ecx
4000264e:	d3 e2                	shl    %cl,%edx
40002650:	39 c2                	cmp    %eax,%edx
40002652:	73 05                	jae    40002659 <__udivdi3+0xf9>
40002654:	3b 34 24             	cmp    (%esp),%esi
40002657:	74 1f                	je     40002678 <__udivdi3+0x118>
40002659:	89 f8                	mov    %edi,%eax
4000265b:	31 d2                	xor    %edx,%edx
4000265d:	e9 7a ff ff ff       	jmp    400025dc <__udivdi3+0x7c>
40002662:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40002668:	31 d2                	xor    %edx,%edx
4000266a:	b8 01 00 00 00       	mov    $0x1,%eax
4000266f:	e9 68 ff ff ff       	jmp    400025dc <__udivdi3+0x7c>
40002674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40002678:	8d 47 ff             	lea    -0x1(%edi),%eax
4000267b:	31 d2                	xor    %edx,%edx
4000267d:	83 c4 0c             	add    $0xc,%esp
40002680:	5e                   	pop    %esi
40002681:	5f                   	pop    %edi
40002682:	5d                   	pop    %ebp
40002683:	c3                   	ret    
40002684:	66 90                	xchg   %ax,%ax
40002686:	66 90                	xchg   %ax,%ax
40002688:	66 90                	xchg   %ax,%ax
4000268a:	66 90                	xchg   %ax,%ax
4000268c:	66 90                	xchg   %ax,%ax
4000268e:	66 90                	xchg   %ax,%ax

40002690 <__umoddi3>:
40002690:	55                   	push   %ebp
40002691:	57                   	push   %edi
40002692:	56                   	push   %esi
40002693:	83 ec 14             	sub    $0x14,%esp
40002696:	8b 44 24 28          	mov    0x28(%esp),%eax
4000269a:	8b 4c 24 24          	mov    0x24(%esp),%ecx
4000269e:	8b 74 24 2c          	mov    0x2c(%esp),%esi
400026a2:	89 c7                	mov    %eax,%edi
400026a4:	89 44 24 04          	mov    %eax,0x4(%esp)
400026a8:	8b 44 24 30          	mov    0x30(%esp),%eax
400026ac:	89 4c 24 10          	mov    %ecx,0x10(%esp)
400026b0:	89 34 24             	mov    %esi,(%esp)
400026b3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
400026b7:	85 c0                	test   %eax,%eax
400026b9:	89 c2                	mov    %eax,%edx
400026bb:	89 7c 24 0c          	mov    %edi,0xc(%esp)
400026bf:	75 17                	jne    400026d8 <__umoddi3+0x48>
400026c1:	39 fe                	cmp    %edi,%esi
400026c3:	76 4b                	jbe    40002710 <__umoddi3+0x80>
400026c5:	89 c8                	mov    %ecx,%eax
400026c7:	89 fa                	mov    %edi,%edx
400026c9:	f7 f6                	div    %esi
400026cb:	89 d0                	mov    %edx,%eax
400026cd:	31 d2                	xor    %edx,%edx
400026cf:	83 c4 14             	add    $0x14,%esp
400026d2:	5e                   	pop    %esi
400026d3:	5f                   	pop    %edi
400026d4:	5d                   	pop    %ebp
400026d5:	c3                   	ret    
400026d6:	66 90                	xchg   %ax,%ax
400026d8:	39 f8                	cmp    %edi,%eax
400026da:	77 54                	ja     40002730 <__umoddi3+0xa0>
400026dc:	0f bd e8             	bsr    %eax,%ebp
400026df:	83 f5 1f             	xor    $0x1f,%ebp
400026e2:	75 5c                	jne    40002740 <__umoddi3+0xb0>
400026e4:	8b 7c 24 08          	mov    0x8(%esp),%edi
400026e8:	39 3c 24             	cmp    %edi,(%esp)
400026eb:	0f 87 e7 00 00 00    	ja     400027d8 <__umoddi3+0x148>
400026f1:	8b 7c 24 04          	mov    0x4(%esp),%edi
400026f5:	29 f1                	sub    %esi,%ecx
400026f7:	19 c7                	sbb    %eax,%edi
400026f9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
400026fd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
40002701:	8b 44 24 08          	mov    0x8(%esp),%eax
40002705:	8b 54 24 0c          	mov    0xc(%esp),%edx
40002709:	83 c4 14             	add    $0x14,%esp
4000270c:	5e                   	pop    %esi
4000270d:	5f                   	pop    %edi
4000270e:	5d                   	pop    %ebp
4000270f:	c3                   	ret    
40002710:	85 f6                	test   %esi,%esi
40002712:	89 f5                	mov    %esi,%ebp
40002714:	75 0b                	jne    40002721 <__umoddi3+0x91>
40002716:	b8 01 00 00 00       	mov    $0x1,%eax
4000271b:	31 d2                	xor    %edx,%edx
4000271d:	f7 f6                	div    %esi
4000271f:	89 c5                	mov    %eax,%ebp
40002721:	8b 44 24 04          	mov    0x4(%esp),%eax
40002725:	31 d2                	xor    %edx,%edx
40002727:	f7 f5                	div    %ebp
40002729:	89 c8                	mov    %ecx,%eax
4000272b:	f7 f5                	div    %ebp
4000272d:	eb 9c                	jmp    400026cb <__umoddi3+0x3b>
4000272f:	90                   	nop
40002730:	89 c8                	mov    %ecx,%eax
40002732:	89 fa                	mov    %edi,%edx
40002734:	83 c4 14             	add    $0x14,%esp
40002737:	5e                   	pop    %esi
40002738:	5f                   	pop    %edi
40002739:	5d                   	pop    %ebp
4000273a:	c3                   	ret    
4000273b:	90                   	nop
4000273c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40002740:	8b 04 24             	mov    (%esp),%eax
40002743:	be 20 00 00 00       	mov    $0x20,%esi
40002748:	89 e9                	mov    %ebp,%ecx
4000274a:	29 ee                	sub    %ebp,%esi
4000274c:	d3 e2                	shl    %cl,%edx
4000274e:	89 f1                	mov    %esi,%ecx
40002750:	d3 e8                	shr    %cl,%eax
40002752:	89 e9                	mov    %ebp,%ecx
40002754:	89 44 24 04          	mov    %eax,0x4(%esp)
40002758:	8b 04 24             	mov    (%esp),%eax
4000275b:	09 54 24 04          	or     %edx,0x4(%esp)
4000275f:	89 fa                	mov    %edi,%edx
40002761:	d3 e0                	shl    %cl,%eax
40002763:	89 f1                	mov    %esi,%ecx
40002765:	89 44 24 08          	mov    %eax,0x8(%esp)
40002769:	8b 44 24 10          	mov    0x10(%esp),%eax
4000276d:	d3 ea                	shr    %cl,%edx
4000276f:	89 e9                	mov    %ebp,%ecx
40002771:	d3 e7                	shl    %cl,%edi
40002773:	89 f1                	mov    %esi,%ecx
40002775:	d3 e8                	shr    %cl,%eax
40002777:	89 e9                	mov    %ebp,%ecx
40002779:	09 f8                	or     %edi,%eax
4000277b:	8b 7c 24 10          	mov    0x10(%esp),%edi
4000277f:	f7 74 24 04          	divl   0x4(%esp)
40002783:	d3 e7                	shl    %cl,%edi
40002785:	89 7c 24 0c          	mov    %edi,0xc(%esp)
40002789:	89 d7                	mov    %edx,%edi
4000278b:	f7 64 24 08          	mull   0x8(%esp)
4000278f:	39 d7                	cmp    %edx,%edi
40002791:	89 c1                	mov    %eax,%ecx
40002793:	89 14 24             	mov    %edx,(%esp)
40002796:	72 2c                	jb     400027c4 <__umoddi3+0x134>
40002798:	39 44 24 0c          	cmp    %eax,0xc(%esp)
4000279c:	72 22                	jb     400027c0 <__umoddi3+0x130>
4000279e:	8b 44 24 0c          	mov    0xc(%esp),%eax
400027a2:	29 c8                	sub    %ecx,%eax
400027a4:	19 d7                	sbb    %edx,%edi
400027a6:	89 e9                	mov    %ebp,%ecx
400027a8:	89 fa                	mov    %edi,%edx
400027aa:	d3 e8                	shr    %cl,%eax
400027ac:	89 f1                	mov    %esi,%ecx
400027ae:	d3 e2                	shl    %cl,%edx
400027b0:	89 e9                	mov    %ebp,%ecx
400027b2:	d3 ef                	shr    %cl,%edi
400027b4:	09 d0                	or     %edx,%eax
400027b6:	89 fa                	mov    %edi,%edx
400027b8:	83 c4 14             	add    $0x14,%esp
400027bb:	5e                   	pop    %esi
400027bc:	5f                   	pop    %edi
400027bd:	5d                   	pop    %ebp
400027be:	c3                   	ret    
400027bf:	90                   	nop
400027c0:	39 d7                	cmp    %edx,%edi
400027c2:	75 da                	jne    4000279e <__umoddi3+0x10e>
400027c4:	8b 14 24             	mov    (%esp),%edx
400027c7:	89 c1                	mov    %eax,%ecx
400027c9:	2b 4c 24 08          	sub    0x8(%esp),%ecx
400027cd:	1b 54 24 04          	sbb    0x4(%esp),%edx
400027d1:	eb cb                	jmp    4000279e <__umoddi3+0x10e>
400027d3:	90                   	nop
400027d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400027d8:	3b 44 24 0c          	cmp    0xc(%esp),%eax
400027dc:	0f 82 0f ff ff ff    	jb     400026f1 <__umoddi3+0x61>
400027e2:	e9 1a ff ff ff       	jmp    40002701 <__umoddi3+0x71>
