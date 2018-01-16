
obj/boot/boot1.elf:     file format elf32-i386


Disassembly of section .text:

00007e00 <start>:
	.set SMAP_SIG, 0x0534D4150	# "SMAP"

	.globl start
start:
	.code16
	cli
    7e00:	fa                   	cli    
	cld
    7e01:	fc                   	cld    

00007e02 <seta20.1>:

	/* enable A20 */
seta20.1:
	inb	$0x64, %al
    7e02:	e4 64                	in     $0x64,%al
	testb	$0x2, %al
    7e04:	a8 02                	test   $0x2,%al
	jnz	seta20.1
    7e06:	75 fa                	jne    7e02 <seta20.1>
	movb	$0xd1, %al
    7e08:	b0 d1                	mov    $0xd1,%al
	outb	%al, $0x64
    7e0a:	e6 64                	out    %al,$0x64

00007e0c <seta20.2>:
seta20.2:
	inb	$0x64, %al
    7e0c:	e4 64                	in     $0x64,%al
	testb	$0x2, %al
    7e0e:	a8 02                	test   $0x2,%al
	jnz	seta20.2
    7e10:	75 fa                	jne    7e0c <seta20.2>
	movb	$0xdf, %al
    7e12:	b0 df                	mov    $0xdf,%al
	outb	%al, $0x60
    7e14:	e6 60                	out    %al,$0x60

00007e16 <set_video_mode.2>:

	/*
	 * print starting message
	 */
set_video_mode.2:
	movw	$STARTUP_MSG, %si
    7e16:	be ab 7e e8 81       	mov    $0x81e87eab,%esi
	call	putstr
    7e1b:	00 66 31             	add    %ah,0x31(%esi)

00007e1c <e820>:

	/*
	 * detect the physical memory map
	 */
e820:
	xorl	%ebx, %ebx		# ebx must be 0 when first calling e820
    7e1c:	66 31 db             	xor    %bx,%bx
	movl	$SMAP_SIG, %edx		# edx must be 'SMAP' when calling e820
    7e1f:	66 ba 50 41          	mov    $0x4150,%dx
    7e23:	4d                   	dec    %ebp
    7e24:	53                   	push   %ebx
	movw	$(smap+4), %di		# set the address of the output buffer
    7e25:	bf 2a 7f 66 b9       	mov    $0xb9667f2a,%edi

00007e28 <e820.1>:
e820.1:
	movl	$20, %ecx		# set the size of the output buffer
    7e28:	66 b9 14 00          	mov    $0x14,%cx
    7e2c:	00 00                	add    %al,(%eax)
	movl	$0xe820, %eax		# set the BIOS service code
    7e2e:	66 b8 20 e8          	mov    $0xe820,%ax
    7e32:	00 00                	add    %al,(%eax)
	int	$0x15			# call BIOS service e820h
    7e34:	cd 15                	int    $0x15

00007e36 <e820.2>:
e820.2:
	jc	e820.fail		# error during e820h
    7e36:	72 24                	jb     7e5c <e820.fail>
	cmpl	$SMAP_SIG, %eax		# check eax, which should be 'SMAP'
    7e38:	66 3d 50 41          	cmp    $0x4150,%ax
    7e3c:	4d                   	dec    %ebp
    7e3d:	53                   	push   %ebx
	jne	e820.fail
    7e3e:	75 1c                	jne    7e5c <e820.fail>

00007e40 <e820.3>:
e820.3:
	movl	$20, -4(%di)
    7e40:	66 c7 45 fc 14 00    	movw   $0x14,-0x4(%ebp)
    7e46:	00 00                	add    %al,(%eax)
	addw	$24, %di
    7e48:	83 c7 18             	add    $0x18,%edi
	cmpl	$0x0, %ebx		# whether it's the last descriptor
    7e4b:	66 83 fb 00          	cmp    $0x0,%bx
	je	e820.4
    7e4f:	74 02                	je     7e53 <e820.4>
	jmp	e820.1
    7e51:	eb d5                	jmp    7e28 <e820.1>

00007e53 <e820.4>:
e820.4:					# zero the descriptor after the last one
	xorb	%al, %al
    7e53:	30 c0                	xor    %al,%al
	movw	$20, %cx
    7e55:	b9 14 00 f3 aa       	mov    $0xaaf30014,%ecx
	rep	stosb
	jmp	switch_prot
    7e5a:	eb 09                	jmp    7e65 <switch_prot>

00007e5c <e820.fail>:
e820.fail:
	movw	$E820_FAIL_MSG, %si
    7e5c:	be bd 7e e8 3b       	mov    $0x3be87ebd,%esi
	call	putstr
    7e61:	00 eb                	add    %ch,%bl
	jmp	spin16
    7e63:	00 f4                	add    %dh,%ah

00007e64 <spin16>:

spin16:
	hlt
    7e64:	f4                   	hlt    

00007e65 <switch_prot>:

	/*
	 * load the bootstrap GDT
	 */
switch_prot:
	lgdt	gdtdesc
    7e65:	0f 01 16             	lgdtl  (%esi)
    7e68:	20 7f 0f             	and    %bh,0xf(%edi)
	movl	%cr0, %eax
    7e6b:	20 c0                	and    %al,%al
	orl	$CR0_PE_ON, %eax
    7e6d:	66 83 c8 01          	or     $0x1,%ax
	movl	%eax, %cr0
    7e71:	0f 22 c0             	mov    %eax,%cr0
	/*
	 * switch to the protected mode
	 */
	ljmp	$PROT_MODE_CSEG, $protcseg
    7e74:	ea 79 7e 08 00 66 b8 	ljmp   $0xb866,$0x87e79

00007e79 <protcseg>:

	.code32
protcseg:
	movw	$PROT_MODE_DSEG, %ax
    7e79:	66 b8 10 00          	mov    $0x10,%ax
	movw	%ax, %ds
    7e7d:	8e d8                	mov    %eax,%ds
	movw	%ax, %es
    7e7f:	8e c0                	mov    %eax,%es
	movw	%ax, %fs
    7e81:	8e e0                	mov    %eax,%fs
	movw	%ax, %gs
    7e83:	8e e8                	mov    %eax,%gs
	movw	%ax, %ss
    7e85:	8e d0                	mov    %eax,%ss

	/*
	 * jump to the C part
	 * (dev, lba, smap)
	 */
	pushl	$smap
    7e87:	68 26 7f 00 00       	push   $0x7f26
	pushl	$BOOT0
    7e8c:	68 00 7c 00 00       	push   $0x7c00
	movl	(BOOT0-4), %eax
    7e91:	a1 fc 7b 00 00       	mov    0x7bfc,%eax
	pushl	%eax
    7e96:	50                   	push   %eax
	call	boot1main
    7e97:	e8 af 0f 00 00       	call   8e4b <boot1main>

00007e9c <spin>:

spin:
	hlt
    7e9c:	f4                   	hlt    

00007e9d <putstr>:
/*
 * print a string (@ %si) to the screen
 */
	.globl putstr
putstr:
	pusha
    7e9d:	60                   	pusha  
	movb	$0xe, %ah
    7e9e:	b4 0e                	mov    $0xe,%ah

00007ea0 <putstr.1>:
putstr.1:
	lodsb
    7ea0:	ac                   	lods   %ds:(%esi),%al
	cmp	$0, %al
    7ea1:	3c 00                	cmp    $0x0,%al
	je	putstr.2
    7ea3:	74 04                	je     7ea9 <putstr.2>
	int	$0x10
    7ea5:	cd 10                	int    $0x10
	jmp	putstr.1
    7ea7:	eb f7                	jmp    7ea0 <putstr.1>

00007ea9 <putstr.2>:
putstr.2:
	popa
    7ea9:	61                   	popa   
	ret
    7eaa:	c3                   	ret    

00007eab <STARTUP_MSG>:
    7eab:	53                   	push   %ebx
    7eac:	74 61                	je     7f0f <gdt+0x17>
    7eae:	72 74                	jb     7f24 <gdtdesc+0x4>
    7eb0:	20 62 6f             	and    %ah,0x6f(%edx)
    7eb3:	6f                   	outsl  %ds:(%esi),(%dx)
    7eb4:	74 31                	je     7ee7 <NO_BOOTABLE_MSG+0x8>
    7eb6:	20 2e                	and    %ch,(%esi)
    7eb8:	2e 2e 0d 0a 00 65 72 	cs cs or $0x7265000a,%eax

00007ebd <E820_FAIL_MSG>:
    7ebd:	65 72 72             	gs jb  7f32 <smap+0xc>
    7ec0:	6f                   	outsl  %ds:(%esi),(%dx)
    7ec1:	72 20                	jb     7ee3 <NO_BOOTABLE_MSG+0x4>
    7ec3:	77 68                	ja     7f2d <smap+0x7>
    7ec5:	65 6e                	outsb  %gs:(%esi),(%dx)
    7ec7:	20 64 65 74          	and    %ah,0x74(%ebp,%eiz,2)
    7ecb:	65 63 74 69 6e       	arpl   %si,%gs:0x6e(%ecx,%ebp,2)
    7ed0:	67 20 6d 65          	and    %ch,0x65(%di)
    7ed4:	6d                   	insl   (%dx),%es:(%edi)
    7ed5:	6f                   	outsl  %ds:(%esi),(%dx)
    7ed6:	72 79                	jb     7f51 <smap+0x2b>
    7ed8:	20 6d 61             	and    %ch,0x61(%ebp)
    7edb:	70 0d                	jo     7eea <NO_BOOTABLE_MSG+0xb>
    7edd:	0a 00                	or     (%eax),%al

00007edf <NO_BOOTABLE_MSG>:
    7edf:	4e                   	dec    %esi
    7ee0:	6f                   	outsl  %ds:(%esi),(%dx)
    7ee1:	20 62 6f             	and    %ah,0x6f(%edx)
    7ee4:	6f                   	outsl  %ds:(%esi),(%dx)
    7ee5:	74 61                	je     7f48 <smap+0x22>
    7ee7:	62 6c 65 20          	bound  %ebp,0x20(%ebp,%eiz,2)
    7eeb:	70 61                	jo     7f4e <smap+0x28>
    7eed:	72 74                	jb     7f63 <smap+0x3d>
    7eef:	69 74 69 6f 6e 2e 0d 	imul   $0xa0d2e6e,0x6f(%ecx,%ebp,2),%esi
    7ef6:	0a 
    7ef7:	00 00                	add    %al,(%eax)

00007ef8 <gdt>:
    7ef8:	00 00                	add    %al,(%eax)
    7efa:	00 00                	add    %al,(%eax)
    7efc:	00 00                	add    %al,(%eax)
    7efe:	00 00                	add    %al,(%eax)
    7f00:	ff                   	(bad)  
    7f01:	ff 00                	incl   (%eax)
    7f03:	00 00                	add    %al,(%eax)
    7f05:	9a cf 00 ff ff 00 00 	lcall  $0x0,$0xffff00cf
    7f0c:	00 92 cf 00 ff ff    	add    %dl,-0xff31(%edx)
    7f12:	00 00                	add    %al,(%eax)
    7f14:	00 9e 00 00 ff ff    	add    %bl,-0x10000(%esi)
    7f1a:	00 00                	add    %al,(%eax)
    7f1c:	00 92 00 00 27 00    	add    %dl,0x270000(%edx)

00007f20 <gdtdesc>:
    7f20:	27                   	daa    
    7f21:	00 f8                	add    %bh,%al
    7f23:	7e 00                	jle    7f25 <gdtdesc+0x5>
    7f25:	00 00                	add    %al,(%eax)

00007f26 <smap>:
    7f26:	00 00                	add    %al,(%eax)
    7f28:	00 00                	add    %al,(%eax)
    7f2a:	00 00                	add    %al,(%eax)
    7f2c:	00 00                	add    %al,(%eax)
    7f2e:	00 00                	add    %al,(%eax)
    7f30:	00 00                	add    %al,(%eax)
    7f32:	00 00                	add    %al,(%eax)
    7f34:	00 00                	add    %al,(%eax)
    7f36:	00 00                	add    %al,(%eax)
    7f38:	00 00                	add    %al,(%eax)
    7f3a:	00 00                	add    %al,(%eax)
    7f3c:	00 00                	add    %al,(%eax)
    7f3e:	00 00                	add    %al,(%eax)
    7f40:	00 00                	add    %al,(%eax)
    7f42:	00 00                	add    %al,(%eax)
    7f44:	00 00                	add    %al,(%eax)
    7f46:	00 00                	add    %al,(%eax)
    7f48:	00 00                	add    %al,(%eax)
    7f4a:	00 00                	add    %al,(%eax)
    7f4c:	00 00                	add    %al,(%eax)
    7f4e:	00 00                	add    %al,(%eax)
    7f50:	00 00                	add    %al,(%eax)
    7f52:	00 00                	add    %al,(%eax)
    7f54:	00 00                	add    %al,(%eax)
    7f56:	00 00                	add    %al,(%eax)
    7f58:	00 00                	add    %al,(%eax)
    7f5a:	00 00                	add    %al,(%eax)
    7f5c:	00 00                	add    %al,(%eax)
    7f5e:	00 00                	add    %al,(%eax)
    7f60:	00 00                	add    %al,(%eax)
    7f62:	00 00                	add    %al,(%eax)
    7f64:	00 00                	add    %al,(%eax)
    7f66:	00 00                	add    %al,(%eax)
    7f68:	00 00                	add    %al,(%eax)
    7f6a:	00 00                	add    %al,(%eax)
    7f6c:	00 00                	add    %al,(%eax)
    7f6e:	00 00                	add    %al,(%eax)
    7f70:	00 00                	add    %al,(%eax)
    7f72:	00 00                	add    %al,(%eax)
    7f74:	00 00                	add    %al,(%eax)
    7f76:	00 00                	add    %al,(%eax)
    7f78:	00 00                	add    %al,(%eax)
    7f7a:	00 00                	add    %al,(%eax)
    7f7c:	00 00                	add    %al,(%eax)
    7f7e:	00 00                	add    %al,(%eax)
    7f80:	00 00                	add    %al,(%eax)
    7f82:	00 00                	add    %al,(%eax)
    7f84:	00 00                	add    %al,(%eax)
    7f86:	00 00                	add    %al,(%eax)
    7f88:	00 00                	add    %al,(%eax)
    7f8a:	00 00                	add    %al,(%eax)
    7f8c:	00 00                	add    %al,(%eax)
    7f8e:	00 00                	add    %al,(%eax)
    7f90:	00 00                	add    %al,(%eax)
    7f92:	00 00                	add    %al,(%eax)
    7f94:	00 00                	add    %al,(%eax)
    7f96:	00 00                	add    %al,(%eax)
    7f98:	00 00                	add    %al,(%eax)
    7f9a:	00 00                	add    %al,(%eax)
    7f9c:	00 00                	add    %al,(%eax)
    7f9e:	00 00                	add    %al,(%eax)
    7fa0:	00 00                	add    %al,(%eax)
    7fa2:	00 00                	add    %al,(%eax)
    7fa4:	00 00                	add    %al,(%eax)
    7fa6:	00 00                	add    %al,(%eax)
    7fa8:	00 00                	add    %al,(%eax)
    7faa:	00 00                	add    %al,(%eax)
    7fac:	00 00                	add    %al,(%eax)
    7fae:	00 00                	add    %al,(%eax)
    7fb0:	00 00                	add    %al,(%eax)
    7fb2:	00 00                	add    %al,(%eax)
    7fb4:	00 00                	add    %al,(%eax)
    7fb6:	00 00                	add    %al,(%eax)
    7fb8:	00 00                	add    %al,(%eax)
    7fba:	00 00                	add    %al,(%eax)
    7fbc:	00 00                	add    %al,(%eax)
    7fbe:	00 00                	add    %al,(%eax)
    7fc0:	00 00                	add    %al,(%eax)
    7fc2:	00 00                	add    %al,(%eax)
    7fc4:	00 00                	add    %al,(%eax)
    7fc6:	00 00                	add    %al,(%eax)
    7fc8:	00 00                	add    %al,(%eax)
    7fca:	00 00                	add    %al,(%eax)
    7fcc:	00 00                	add    %al,(%eax)
    7fce:	00 00                	add    %al,(%eax)
    7fd0:	00 00                	add    %al,(%eax)
    7fd2:	00 00                	add    %al,(%eax)
    7fd4:	00 00                	add    %al,(%eax)
    7fd6:	00 00                	add    %al,(%eax)
    7fd8:	00 00                	add    %al,(%eax)
    7fda:	00 00                	add    %al,(%eax)
    7fdc:	00 00                	add    %al,(%eax)
    7fde:	00 00                	add    %al,(%eax)
    7fe0:	00 00                	add    %al,(%eax)
    7fe2:	00 00                	add    %al,(%eax)
    7fe4:	00 00                	add    %al,(%eax)
    7fe6:	00 00                	add    %al,(%eax)
    7fe8:	00 00                	add    %al,(%eax)
    7fea:	00 00                	add    %al,(%eax)
    7fec:	00 00                	add    %al,(%eax)
    7fee:	00 00                	add    %al,(%eax)
    7ff0:	00 00                	add    %al,(%eax)
    7ff2:	00 00                	add    %al,(%eax)
    7ff4:	00 00                	add    %al,(%eax)
    7ff6:	00 00                	add    %al,(%eax)
    7ff8:	00 00                	add    %al,(%eax)
    7ffa:	00 00                	add    %al,(%eax)
    7ffc:	00 00                	add    %al,(%eax)
    7ffe:	00 00                	add    %al,(%eax)
    8000:	00 00                	add    %al,(%eax)
    8002:	00 00                	add    %al,(%eax)
    8004:	00 00                	add    %al,(%eax)
    8006:	00 00                	add    %al,(%eax)
    8008:	00 00                	add    %al,(%eax)
    800a:	00 00                	add    %al,(%eax)
    800c:	00 00                	add    %al,(%eax)
    800e:	00 00                	add    %al,(%eax)
    8010:	00 00                	add    %al,(%eax)
    8012:	00 00                	add    %al,(%eax)
    8014:	00 00                	add    %al,(%eax)
    8016:	00 00                	add    %al,(%eax)
    8018:	00 00                	add    %al,(%eax)
    801a:	00 00                	add    %al,(%eax)
    801c:	00 00                	add    %al,(%eax)
    801e:	00 00                	add    %al,(%eax)
    8020:	00 00                	add    %al,(%eax)
    8022:	00 00                	add    %al,(%eax)
    8024:	00 00                	add    %al,(%eax)
    8026:	00 00                	add    %al,(%eax)
    8028:	00 00                	add    %al,(%eax)
    802a:	00 00                	add    %al,(%eax)
    802c:	00 00                	add    %al,(%eax)
    802e:	00 00                	add    %al,(%eax)
    8030:	00 00                	add    %al,(%eax)
    8032:	00 00                	add    %al,(%eax)
    8034:	00 00                	add    %al,(%eax)
    8036:	00 00                	add    %al,(%eax)
    8038:	00 00                	add    %al,(%eax)
    803a:	00 00                	add    %al,(%eax)
    803c:	00 00                	add    %al,(%eax)
    803e:	00 00                	add    %al,(%eax)
    8040:	00 00                	add    %al,(%eax)
    8042:	00 00                	add    %al,(%eax)
    8044:	00 00                	add    %al,(%eax)
    8046:	00 00                	add    %al,(%eax)
    8048:	00 00                	add    %al,(%eax)
    804a:	00 00                	add    %al,(%eax)
    804c:	00 00                	add    %al,(%eax)
    804e:	00 00                	add    %al,(%eax)
    8050:	00 00                	add    %al,(%eax)
    8052:	00 00                	add    %al,(%eax)
    8054:	00 00                	add    %al,(%eax)
    8056:	00 00                	add    %al,(%eax)
    8058:	00 00                	add    %al,(%eax)
    805a:	00 00                	add    %al,(%eax)
    805c:	00 00                	add    %al,(%eax)
    805e:	00 00                	add    %al,(%eax)
    8060:	00 00                	add    %al,(%eax)
    8062:	00 00                	add    %al,(%eax)
    8064:	00 00                	add    %al,(%eax)
    8066:	00 00                	add    %al,(%eax)
    8068:	00 00                	add    %al,(%eax)
    806a:	00 00                	add    %al,(%eax)
    806c:	00 00                	add    %al,(%eax)
    806e:	00 00                	add    %al,(%eax)
    8070:	00 00                	add    %al,(%eax)
    8072:	00 00                	add    %al,(%eax)
    8074:	00 00                	add    %al,(%eax)
    8076:	00 00                	add    %al,(%eax)
    8078:	00 00                	add    %al,(%eax)
    807a:	00 00                	add    %al,(%eax)
    807c:	00 00                	add    %al,(%eax)
    807e:	00 00                	add    %al,(%eax)
    8080:	00 00                	add    %al,(%eax)
    8082:	00 00                	add    %al,(%eax)
    8084:	00 00                	add    %al,(%eax)
    8086:	00 00                	add    %al,(%eax)
    8088:	00 00                	add    %al,(%eax)
    808a:	00 00                	add    %al,(%eax)
    808c:	00 00                	add    %al,(%eax)
    808e:	00 00                	add    %al,(%eax)
    8090:	00 00                	add    %al,(%eax)
    8092:	00 00                	add    %al,(%eax)
    8094:	00 00                	add    %al,(%eax)
    8096:	00 00                	add    %al,(%eax)
    8098:	00 00                	add    %al,(%eax)
    809a:	00 00                	add    %al,(%eax)
    809c:	00 00                	add    %al,(%eax)
    809e:	00 00                	add    %al,(%eax)
    80a0:	00 00                	add    %al,(%eax)
    80a2:	00 00                	add    %al,(%eax)
    80a4:	00 00                	add    %al,(%eax)
    80a6:	00 00                	add    %al,(%eax)
    80a8:	00 00                	add    %al,(%eax)
    80aa:	00 00                	add    %al,(%eax)
    80ac:	00 00                	add    %al,(%eax)
    80ae:	00 00                	add    %al,(%eax)
    80b0:	00 00                	add    %al,(%eax)
    80b2:	00 00                	add    %al,(%eax)
    80b4:	00 00                	add    %al,(%eax)
    80b6:	00 00                	add    %al,(%eax)
    80b8:	00 00                	add    %al,(%eax)
    80ba:	00 00                	add    %al,(%eax)
    80bc:	00 00                	add    %al,(%eax)
    80be:	00 00                	add    %al,(%eax)
    80c0:	00 00                	add    %al,(%eax)
    80c2:	00 00                	add    %al,(%eax)
    80c4:	00 00                	add    %al,(%eax)
    80c6:	00 00                	add    %al,(%eax)
    80c8:	00 00                	add    %al,(%eax)
    80ca:	00 00                	add    %al,(%eax)
    80cc:	00 00                	add    %al,(%eax)
    80ce:	00 00                	add    %al,(%eax)
    80d0:	00 00                	add    %al,(%eax)
    80d2:	00 00                	add    %al,(%eax)
    80d4:	00 00                	add    %al,(%eax)
    80d6:	00 00                	add    %al,(%eax)
    80d8:	00 00                	add    %al,(%eax)
    80da:	00 00                	add    %al,(%eax)
    80dc:	00 00                	add    %al,(%eax)
    80de:	00 00                	add    %al,(%eax)
    80e0:	00 00                	add    %al,(%eax)
    80e2:	00 00                	add    %al,(%eax)
    80e4:	00 00                	add    %al,(%eax)
    80e6:	00 00                	add    %al,(%eax)
    80e8:	00 00                	add    %al,(%eax)
    80ea:	00 00                	add    %al,(%eax)
    80ec:	00 00                	add    %al,(%eax)
    80ee:	00 00                	add    %al,(%eax)
    80f0:	00 00                	add    %al,(%eax)
    80f2:	00 00                	add    %al,(%eax)
    80f4:	00 00                	add    %al,(%eax)
    80f6:	00 00                	add    %al,(%eax)
    80f8:	00 00                	add    %al,(%eax)
    80fa:	00 00                	add    %al,(%eax)
    80fc:	00 00                	add    %al,(%eax)
    80fe:	00 00                	add    %al,(%eax)
    8100:	00 00                	add    %al,(%eax)
    8102:	00 00                	add    %al,(%eax)
    8104:	00 00                	add    %al,(%eax)
    8106:	00 00                	add    %al,(%eax)
    8108:	00 00                	add    %al,(%eax)
    810a:	00 00                	add    %al,(%eax)
    810c:	00 00                	add    %al,(%eax)
    810e:	00 00                	add    %al,(%eax)
    8110:	00 00                	add    %al,(%eax)
    8112:	00 00                	add    %al,(%eax)
    8114:	00 00                	add    %al,(%eax)
    8116:	00 00                	add    %al,(%eax)
    8118:	00 00                	add    %al,(%eax)
    811a:	00 00                	add    %al,(%eax)
    811c:	00 00                	add    %al,(%eax)
    811e:	00 00                	add    %al,(%eax)
    8120:	00 00                	add    %al,(%eax)
    8122:	00 00                	add    %al,(%eax)
    8124:	00 00                	add    %al,(%eax)
    8126:	00 00                	add    %al,(%eax)
    8128:	00 00                	add    %al,(%eax)
    812a:	00 00                	add    %al,(%eax)
    812c:	00 00                	add    %al,(%eax)
    812e:	00 00                	add    %al,(%eax)
    8130:	00 00                	add    %al,(%eax)
    8132:	00 00                	add    %al,(%eax)
    8134:	00 00                	add    %al,(%eax)
    8136:	00 00                	add    %al,(%eax)
    8138:	00 00                	add    %al,(%eax)
    813a:	00 00                	add    %al,(%eax)
    813c:	00 00                	add    %al,(%eax)
    813e:	00 00                	add    %al,(%eax)
    8140:	00 00                	add    %al,(%eax)
    8142:	00 00                	add    %al,(%eax)
    8144:	00 00                	add    %al,(%eax)
    8146:	00 00                	add    %al,(%eax)
    8148:	00 00                	add    %al,(%eax)
    814a:	00 00                	add    %al,(%eax)
    814c:	00 00                	add    %al,(%eax)
    814e:	00 00                	add    %al,(%eax)
    8150:	00 00                	add    %al,(%eax)
    8152:	00 00                	add    %al,(%eax)
    8154:	00 00                	add    %al,(%eax)
    8156:	00 00                	add    %al,(%eax)
    8158:	00 00                	add    %al,(%eax)
    815a:	00 00                	add    %al,(%eax)
    815c:	00 00                	add    %al,(%eax)
    815e:	00 00                	add    %al,(%eax)
    8160:	00 00                	add    %al,(%eax)
    8162:	00 00                	add    %al,(%eax)
    8164:	00 00                	add    %al,(%eax)
    8166:	00 00                	add    %al,(%eax)
    8168:	00 00                	add    %al,(%eax)
    816a:	00 00                	add    %al,(%eax)
    816c:	00 00                	add    %al,(%eax)
    816e:	00 00                	add    %al,(%eax)
    8170:	00 00                	add    %al,(%eax)
    8172:	00 00                	add    %al,(%eax)
    8174:	00 00                	add    %al,(%eax)
    8176:	00 00                	add    %al,(%eax)
    8178:	00 00                	add    %al,(%eax)
    817a:	00 00                	add    %al,(%eax)
    817c:	00 00                	add    %al,(%eax)
    817e:	00 00                	add    %al,(%eax)
    8180:	00 00                	add    %al,(%eax)
    8182:	00 00                	add    %al,(%eax)
    8184:	00 00                	add    %al,(%eax)
    8186:	00 00                	add    %al,(%eax)
    8188:	00 00                	add    %al,(%eax)
    818a:	00 00                	add    %al,(%eax)
    818c:	00 00                	add    %al,(%eax)
    818e:	00 00                	add    %al,(%eax)
    8190:	00 00                	add    %al,(%eax)
    8192:	00 00                	add    %al,(%eax)
    8194:	00 00                	add    %al,(%eax)
    8196:	00 00                	add    %al,(%eax)
    8198:	00 00                	add    %al,(%eax)
    819a:	00 00                	add    %al,(%eax)
    819c:	00 00                	add    %al,(%eax)
    819e:	00 00                	add    %al,(%eax)
    81a0:	00 00                	add    %al,(%eax)
    81a2:	00 00                	add    %al,(%eax)
    81a4:	00 00                	add    %al,(%eax)
    81a6:	00 00                	add    %al,(%eax)
    81a8:	00 00                	add    %al,(%eax)
    81aa:	00 00                	add    %al,(%eax)
    81ac:	00 00                	add    %al,(%eax)
    81ae:	00 00                	add    %al,(%eax)
    81b0:	00 00                	add    %al,(%eax)
    81b2:	00 00                	add    %al,(%eax)
    81b4:	00 00                	add    %al,(%eax)
    81b6:	00 00                	add    %al,(%eax)
    81b8:	00 00                	add    %al,(%eax)
    81ba:	00 00                	add    %al,(%eax)
    81bc:	00 00                	add    %al,(%eax)
    81be:	00 00                	add    %al,(%eax)
    81c0:	00 00                	add    %al,(%eax)
    81c2:	00 00                	add    %al,(%eax)
    81c4:	00 00                	add    %al,(%eax)
    81c6:	00 00                	add    %al,(%eax)
    81c8:	00 00                	add    %al,(%eax)
    81ca:	00 00                	add    %al,(%eax)
    81cc:	00 00                	add    %al,(%eax)
    81ce:	00 00                	add    %al,(%eax)
    81d0:	00 00                	add    %al,(%eax)
    81d2:	00 00                	add    %al,(%eax)
    81d4:	00 00                	add    %al,(%eax)
    81d6:	00 00                	add    %al,(%eax)
    81d8:	00 00                	add    %al,(%eax)
    81da:	00 00                	add    %al,(%eax)
    81dc:	00 00                	add    %al,(%eax)
    81de:	00 00                	add    %al,(%eax)
    81e0:	00 00                	add    %al,(%eax)
    81e2:	00 00                	add    %al,(%eax)
    81e4:	00 00                	add    %al,(%eax)
    81e6:	00 00                	add    %al,(%eax)
    81e8:	00 00                	add    %al,(%eax)
    81ea:	00 00                	add    %al,(%eax)
    81ec:	00 00                	add    %al,(%eax)
    81ee:	00 00                	add    %al,(%eax)
    81f0:	00 00                	add    %al,(%eax)
    81f2:	00 00                	add    %al,(%eax)
    81f4:	00 00                	add    %al,(%eax)
    81f6:	00 00                	add    %al,(%eax)
    81f8:	00 00                	add    %al,(%eax)
    81fa:	00 00                	add    %al,(%eax)
    81fc:	00 00                	add    %al,(%eax)
    81fe:	00 00                	add    %al,(%eax)
    8200:	00 00                	add    %al,(%eax)
    8202:	00 00                	add    %al,(%eax)
    8204:	00 00                	add    %al,(%eax)
    8206:	00 00                	add    %al,(%eax)
    8208:	00 00                	add    %al,(%eax)
    820a:	00 00                	add    %al,(%eax)
    820c:	00 00                	add    %al,(%eax)
    820e:	00 00                	add    %al,(%eax)
    8210:	00 00                	add    %al,(%eax)
    8212:	00 00                	add    %al,(%eax)
    8214:	00 00                	add    %al,(%eax)
    8216:	00 00                	add    %al,(%eax)
    8218:	00 00                	add    %al,(%eax)
    821a:	00 00                	add    %al,(%eax)
    821c:	00 00                	add    %al,(%eax)
    821e:	00 00                	add    %al,(%eax)
    8220:	00 00                	add    %al,(%eax)
    8222:	00 00                	add    %al,(%eax)
    8224:	00 00                	add    %al,(%eax)
    8226:	00 00                	add    %al,(%eax)
    8228:	00 00                	add    %al,(%eax)
    822a:	00 00                	add    %al,(%eax)
    822c:	00 00                	add    %al,(%eax)
    822e:	00 00                	add    %al,(%eax)
    8230:	00 00                	add    %al,(%eax)
    8232:	00 00                	add    %al,(%eax)
    8234:	00 00                	add    %al,(%eax)
    8236:	00 00                	add    %al,(%eax)
    8238:	00 00                	add    %al,(%eax)
    823a:	00 00                	add    %al,(%eax)
    823c:	00 00                	add    %al,(%eax)
    823e:	00 00                	add    %al,(%eax)
    8240:	00 00                	add    %al,(%eax)
    8242:	00 00                	add    %al,(%eax)
    8244:	00 00                	add    %al,(%eax)
    8246:	00 00                	add    %al,(%eax)
    8248:	00 00                	add    %al,(%eax)
    824a:	00 00                	add    %al,(%eax)
    824c:	00 00                	add    %al,(%eax)
    824e:	00 00                	add    %al,(%eax)
    8250:	00 00                	add    %al,(%eax)
    8252:	00 00                	add    %al,(%eax)
    8254:	00 00                	add    %al,(%eax)
    8256:	00 00                	add    %al,(%eax)
    8258:	00 00                	add    %al,(%eax)
    825a:	00 00                	add    %al,(%eax)
    825c:	00 00                	add    %al,(%eax)
    825e:	00 00                	add    %al,(%eax)
    8260:	00 00                	add    %al,(%eax)
    8262:	00 00                	add    %al,(%eax)
    8264:	00 00                	add    %al,(%eax)
    8266:	00 00                	add    %al,(%eax)
    8268:	00 00                	add    %al,(%eax)
    826a:	00 00                	add    %al,(%eax)
    826c:	00 00                	add    %al,(%eax)
    826e:	00 00                	add    %al,(%eax)
    8270:	00 00                	add    %al,(%eax)
    8272:	00 00                	add    %al,(%eax)
    8274:	00 00                	add    %al,(%eax)
    8276:	00 00                	add    %al,(%eax)
    8278:	00 00                	add    %al,(%eax)
    827a:	00 00                	add    %al,(%eax)
    827c:	00 00                	add    %al,(%eax)
    827e:	00 00                	add    %al,(%eax)
    8280:	00 00                	add    %al,(%eax)
    8282:	00 00                	add    %al,(%eax)
    8284:	00 00                	add    %al,(%eax)
    8286:	00 00                	add    %al,(%eax)
    8288:	00 00                	add    %al,(%eax)
    828a:	00 00                	add    %al,(%eax)
    828c:	00 00                	add    %al,(%eax)
    828e:	00 00                	add    %al,(%eax)
    8290:	00 00                	add    %al,(%eax)
    8292:	00 00                	add    %al,(%eax)
    8294:	00 00                	add    %al,(%eax)
    8296:	00 00                	add    %al,(%eax)
    8298:	00 00                	add    %al,(%eax)
    829a:	00 00                	add    %al,(%eax)
    829c:	00 00                	add    %al,(%eax)
    829e:	00 00                	add    %al,(%eax)
    82a0:	00 00                	add    %al,(%eax)
    82a2:	00 00                	add    %al,(%eax)
    82a4:	00 00                	add    %al,(%eax)
    82a6:	00 00                	add    %al,(%eax)
    82a8:	00 00                	add    %al,(%eax)
    82aa:	00 00                	add    %al,(%eax)
    82ac:	00 00                	add    %al,(%eax)
    82ae:	00 00                	add    %al,(%eax)
    82b0:	00 00                	add    %al,(%eax)
    82b2:	00 00                	add    %al,(%eax)
    82b4:	00 00                	add    %al,(%eax)
    82b6:	00 00                	add    %al,(%eax)
    82b8:	00 00                	add    %al,(%eax)
    82ba:	00 00                	add    %al,(%eax)
    82bc:	00 00                	add    %al,(%eax)
    82be:	00 00                	add    %al,(%eax)
    82c0:	00 00                	add    %al,(%eax)
    82c2:	00 00                	add    %al,(%eax)
    82c4:	00 00                	add    %al,(%eax)
    82c6:	00 00                	add    %al,(%eax)
    82c8:	00 00                	add    %al,(%eax)
    82ca:	00 00                	add    %al,(%eax)
    82cc:	00 00                	add    %al,(%eax)
    82ce:	00 00                	add    %al,(%eax)
    82d0:	00 00                	add    %al,(%eax)
    82d2:	00 00                	add    %al,(%eax)
    82d4:	00 00                	add    %al,(%eax)
    82d6:	00 00                	add    %al,(%eax)
    82d8:	00 00                	add    %al,(%eax)
    82da:	00 00                	add    %al,(%eax)
    82dc:	00 00                	add    %al,(%eax)
    82de:	00 00                	add    %al,(%eax)
    82e0:	00 00                	add    %al,(%eax)
    82e2:	00 00                	add    %al,(%eax)
    82e4:	00 00                	add    %al,(%eax)
    82e6:	00 00                	add    %al,(%eax)
    82e8:	00 00                	add    %al,(%eax)
    82ea:	00 00                	add    %al,(%eax)
    82ec:	00 00                	add    %al,(%eax)
    82ee:	00 00                	add    %al,(%eax)
    82f0:	00 00                	add    %al,(%eax)
    82f2:	00 00                	add    %al,(%eax)
    82f4:	00 00                	add    %al,(%eax)
    82f6:	00 00                	add    %al,(%eax)
    82f8:	00 00                	add    %al,(%eax)
    82fa:	00 00                	add    %al,(%eax)
    82fc:	00 00                	add    %al,(%eax)
    82fe:	00 00                	add    %al,(%eax)
    8300:	00 00                	add    %al,(%eax)
    8302:	00 00                	add    %al,(%eax)
    8304:	00 00                	add    %al,(%eax)
    8306:	00 00                	add    %al,(%eax)
    8308:	00 00                	add    %al,(%eax)
    830a:	00 00                	add    %al,(%eax)
    830c:	00 00                	add    %al,(%eax)
    830e:	00 00                	add    %al,(%eax)
    8310:	00 00                	add    %al,(%eax)
    8312:	00 00                	add    %al,(%eax)
    8314:	00 00                	add    %al,(%eax)
    8316:	00 00                	add    %al,(%eax)
    8318:	00 00                	add    %al,(%eax)
    831a:	00 00                	add    %al,(%eax)
    831c:	00 00                	add    %al,(%eax)
    831e:	00 00                	add    %al,(%eax)
    8320:	00 00                	add    %al,(%eax)
    8322:	00 00                	add    %al,(%eax)
    8324:	00 00                	add    %al,(%eax)
    8326:	00 00                	add    %al,(%eax)
    8328:	00 00                	add    %al,(%eax)
    832a:	00 00                	add    %al,(%eax)
    832c:	00 00                	add    %al,(%eax)
    832e:	00 00                	add    %al,(%eax)
    8330:	00 00                	add    %al,(%eax)
    8332:	00 00                	add    %al,(%eax)
    8334:	00 00                	add    %al,(%eax)
    8336:	00 00                	add    %al,(%eax)
    8338:	00 00                	add    %al,(%eax)
    833a:	00 00                	add    %al,(%eax)
    833c:	00 00                	add    %al,(%eax)
    833e:	00 00                	add    %al,(%eax)
    8340:	00 00                	add    %al,(%eax)
    8342:	00 00                	add    %al,(%eax)
    8344:	00 00                	add    %al,(%eax)
    8346:	00 00                	add    %al,(%eax)
    8348:	00 00                	add    %al,(%eax)
    834a:	00 00                	add    %al,(%eax)
    834c:	00 00                	add    %al,(%eax)
    834e:	00 00                	add    %al,(%eax)
    8350:	00 00                	add    %al,(%eax)
    8352:	00 00                	add    %al,(%eax)
    8354:	00 00                	add    %al,(%eax)
    8356:	00 00                	add    %al,(%eax)
    8358:	00 00                	add    %al,(%eax)
    835a:	00 00                	add    %al,(%eax)
    835c:	00 00                	add    %al,(%eax)
    835e:	00 00                	add    %al,(%eax)
    8360:	00 00                	add    %al,(%eax)
    8362:	00 00                	add    %al,(%eax)
    8364:	00 00                	add    %al,(%eax)
    8366:	00 00                	add    %al,(%eax)
    8368:	00 00                	add    %al,(%eax)
    836a:	00 00                	add    %al,(%eax)
    836c:	00 00                	add    %al,(%eax)
    836e:	00 00                	add    %al,(%eax)
    8370:	00 00                	add    %al,(%eax)
    8372:	00 00                	add    %al,(%eax)
    8374:	00 00                	add    %al,(%eax)
    8376:	00 00                	add    %al,(%eax)
    8378:	00 00                	add    %al,(%eax)
    837a:	00 00                	add    %al,(%eax)
    837c:	00 00                	add    %al,(%eax)
    837e:	00 00                	add    %al,(%eax)
    8380:	00 00                	add    %al,(%eax)
    8382:	00 00                	add    %al,(%eax)
    8384:	00 00                	add    %al,(%eax)
    8386:	00 00                	add    %al,(%eax)
    8388:	00 00                	add    %al,(%eax)
    838a:	00 00                	add    %al,(%eax)
    838c:	00 00                	add    %al,(%eax)
    838e:	00 00                	add    %al,(%eax)
    8390:	00 00                	add    %al,(%eax)
    8392:	00 00                	add    %al,(%eax)
    8394:	00 00                	add    %al,(%eax)
    8396:	00 00                	add    %al,(%eax)
    8398:	00 00                	add    %al,(%eax)
    839a:	00 00                	add    %al,(%eax)
    839c:	00 00                	add    %al,(%eax)
    839e:	00 00                	add    %al,(%eax)
    83a0:	00 00                	add    %al,(%eax)
    83a2:	00 00                	add    %al,(%eax)
    83a4:	00 00                	add    %al,(%eax)
    83a6:	00 00                	add    %al,(%eax)
    83a8:	00 00                	add    %al,(%eax)
    83aa:	00 00                	add    %al,(%eax)
    83ac:	00 00                	add    %al,(%eax)
    83ae:	00 00                	add    %al,(%eax)
    83b0:	00 00                	add    %al,(%eax)
    83b2:	00 00                	add    %al,(%eax)
    83b4:	00 00                	add    %al,(%eax)
    83b6:	00 00                	add    %al,(%eax)
    83b8:	00 00                	add    %al,(%eax)
    83ba:	00 00                	add    %al,(%eax)
    83bc:	00 00                	add    %al,(%eax)
    83be:	00 00                	add    %al,(%eax)
    83c0:	00 00                	add    %al,(%eax)
    83c2:	00 00                	add    %al,(%eax)
    83c4:	00 00                	add    %al,(%eax)
    83c6:	00 00                	add    %al,(%eax)
    83c8:	00 00                	add    %al,(%eax)
    83ca:	00 00                	add    %al,(%eax)
    83cc:	00 00                	add    %al,(%eax)
    83ce:	00 00                	add    %al,(%eax)
    83d0:	00 00                	add    %al,(%eax)
    83d2:	00 00                	add    %al,(%eax)
    83d4:	00 00                	add    %al,(%eax)
    83d6:	00 00                	add    %al,(%eax)
    83d8:	00 00                	add    %al,(%eax)
    83da:	00 00                	add    %al,(%eax)
    83dc:	00 00                	add    %al,(%eax)
    83de:	00 00                	add    %al,(%eax)
    83e0:	00 00                	add    %al,(%eax)
    83e2:	00 00                	add    %al,(%eax)
    83e4:	00 00                	add    %al,(%eax)
    83e6:	00 00                	add    %al,(%eax)
    83e8:	00 00                	add    %al,(%eax)
    83ea:	00 00                	add    %al,(%eax)
    83ec:	00 00                	add    %al,(%eax)
    83ee:	00 00                	add    %al,(%eax)
    83f0:	00 00                	add    %al,(%eax)
    83f2:	00 00                	add    %al,(%eax)
    83f4:	00 00                	add    %al,(%eax)
    83f6:	00 00                	add    %al,(%eax)
    83f8:	00 00                	add    %al,(%eax)
    83fa:	00 00                	add    %al,(%eax)
    83fc:	00 00                	add    %al,(%eax)
    83fe:	00 00                	add    %al,(%eax)
    8400:	00 00                	add    %al,(%eax)
    8402:	00 00                	add    %al,(%eax)
    8404:	00 00                	add    %al,(%eax)
    8406:	00 00                	add    %al,(%eax)
    8408:	00 00                	add    %al,(%eax)
    840a:	00 00                	add    %al,(%eax)
    840c:	00 00                	add    %al,(%eax)
    840e:	00 00                	add    %al,(%eax)
    8410:	00 00                	add    %al,(%eax)
    8412:	00 00                	add    %al,(%eax)
    8414:	00 00                	add    %al,(%eax)
    8416:	00 00                	add    %al,(%eax)
    8418:	00 00                	add    %al,(%eax)
    841a:	00 00                	add    %al,(%eax)
    841c:	00 00                	add    %al,(%eax)
    841e:	00 00                	add    %al,(%eax)
    8420:	00 00                	add    %al,(%eax)
    8422:	00 00                	add    %al,(%eax)
    8424:	00 00                	add    %al,(%eax)
    8426:	00 00                	add    %al,(%eax)
    8428:	00 00                	add    %al,(%eax)
    842a:	00 00                	add    %al,(%eax)
    842c:	00 00                	add    %al,(%eax)
    842e:	00 00                	add    %al,(%eax)
    8430:	00 00                	add    %al,(%eax)
    8432:	00 00                	add    %al,(%eax)
    8434:	00 00                	add    %al,(%eax)
    8436:	00 00                	add    %al,(%eax)
    8438:	00 00                	add    %al,(%eax)
    843a:	00 00                	add    %al,(%eax)
    843c:	00 00                	add    %al,(%eax)
    843e:	00 00                	add    %al,(%eax)
    8440:	00 00                	add    %al,(%eax)
    8442:	00 00                	add    %al,(%eax)
    8444:	00 00                	add    %al,(%eax)
    8446:	00 00                	add    %al,(%eax)
    8448:	00 00                	add    %al,(%eax)
    844a:	00 00                	add    %al,(%eax)
    844c:	00 00                	add    %al,(%eax)
    844e:	00 00                	add    %al,(%eax)
    8450:	00 00                	add    %al,(%eax)
    8452:	00 00                	add    %al,(%eax)
    8454:	00 00                	add    %al,(%eax)
    8456:	00 00                	add    %al,(%eax)
    8458:	00 00                	add    %al,(%eax)
    845a:	00 00                	add    %al,(%eax)
    845c:	00 00                	add    %al,(%eax)
    845e:	00 00                	add    %al,(%eax)
    8460:	00 00                	add    %al,(%eax)
    8462:	00 00                	add    %al,(%eax)
    8464:	00 00                	add    %al,(%eax)
    8466:	00 00                	add    %al,(%eax)
    8468:	00 00                	add    %al,(%eax)
    846a:	00 00                	add    %al,(%eax)
    846c:	00 00                	add    %al,(%eax)
    846e:	00 00                	add    %al,(%eax)
    8470:	00 00                	add    %al,(%eax)
    8472:	00 00                	add    %al,(%eax)
    8474:	00 00                	add    %al,(%eax)
    8476:	00 00                	add    %al,(%eax)
    8478:	00 00                	add    %al,(%eax)
    847a:	00 00                	add    %al,(%eax)
    847c:	00 00                	add    %al,(%eax)
    847e:	00 00                	add    %al,(%eax)
    8480:	00 00                	add    %al,(%eax)
    8482:	00 00                	add    %al,(%eax)
    8484:	00 00                	add    %al,(%eax)
    8486:	00 00                	add    %al,(%eax)
    8488:	00 00                	add    %al,(%eax)
    848a:	00 00                	add    %al,(%eax)
    848c:	00 00                	add    %al,(%eax)
    848e:	00 00                	add    %al,(%eax)
    8490:	00 00                	add    %al,(%eax)
    8492:	00 00                	add    %al,(%eax)
    8494:	00 00                	add    %al,(%eax)
    8496:	00 00                	add    %al,(%eax)
    8498:	00 00                	add    %al,(%eax)
    849a:	00 00                	add    %al,(%eax)
    849c:	00 00                	add    %al,(%eax)
    849e:	00 00                	add    %al,(%eax)
    84a0:	00 00                	add    %al,(%eax)
    84a2:	00 00                	add    %al,(%eax)
    84a4:	00 00                	add    %al,(%eax)
    84a6:	00 00                	add    %al,(%eax)
    84a8:	00 00                	add    %al,(%eax)
    84aa:	00 00                	add    %al,(%eax)
    84ac:	00 00                	add    %al,(%eax)
    84ae:	00 00                	add    %al,(%eax)
    84b0:	00 00                	add    %al,(%eax)
    84b2:	00 00                	add    %al,(%eax)
    84b4:	00 00                	add    %al,(%eax)
    84b6:	00 00                	add    %al,(%eax)
    84b8:	00 00                	add    %al,(%eax)
    84ba:	00 00                	add    %al,(%eax)
    84bc:	00 00                	add    %al,(%eax)
    84be:	00 00                	add    %al,(%eax)
    84c0:	00 00                	add    %al,(%eax)
    84c2:	00 00                	add    %al,(%eax)
    84c4:	00 00                	add    %al,(%eax)
    84c6:	00 00                	add    %al,(%eax)
    84c8:	00 00                	add    %al,(%eax)
    84ca:	00 00                	add    %al,(%eax)
    84cc:	00 00                	add    %al,(%eax)
    84ce:	00 00                	add    %al,(%eax)
    84d0:	00 00                	add    %al,(%eax)
    84d2:	00 00                	add    %al,(%eax)
    84d4:	00 00                	add    %al,(%eax)
    84d6:	00 00                	add    %al,(%eax)
    84d8:	00 00                	add    %al,(%eax)
    84da:	00 00                	add    %al,(%eax)
    84dc:	00 00                	add    %al,(%eax)
    84de:	00 00                	add    %al,(%eax)
    84e0:	00 00                	add    %al,(%eax)
    84e2:	00 00                	add    %al,(%eax)
    84e4:	00 00                	add    %al,(%eax)
    84e6:	00 00                	add    %al,(%eax)
    84e8:	00 00                	add    %al,(%eax)
    84ea:	00 00                	add    %al,(%eax)
    84ec:	00 00                	add    %al,(%eax)
    84ee:	00 00                	add    %al,(%eax)
    84f0:	00 00                	add    %al,(%eax)
    84f2:	00 00                	add    %al,(%eax)
    84f4:	00 00                	add    %al,(%eax)
    84f6:	00 00                	add    %al,(%eax)
    84f8:	00 00                	add    %al,(%eax)
    84fa:	00 00                	add    %al,(%eax)
    84fc:	00 00                	add    %al,(%eax)
    84fe:	00 00                	add    %al,(%eax)
    8500:	00 00                	add    %al,(%eax)
    8502:	00 00                	add    %al,(%eax)
    8504:	00 00                	add    %al,(%eax)
    8506:	00 00                	add    %al,(%eax)
    8508:	00 00                	add    %al,(%eax)
    850a:	00 00                	add    %al,(%eax)
    850c:	00 00                	add    %al,(%eax)
    850e:	00 00                	add    %al,(%eax)
    8510:	00 00                	add    %al,(%eax)
    8512:	00 00                	add    %al,(%eax)
    8514:	00 00                	add    %al,(%eax)
    8516:	00 00                	add    %al,(%eax)
    8518:	00 00                	add    %al,(%eax)
    851a:	00 00                	add    %al,(%eax)
    851c:	00 00                	add    %al,(%eax)
    851e:	00 00                	add    %al,(%eax)
    8520:	00 00                	add    %al,(%eax)
    8522:	00 00                	add    %al,(%eax)
    8524:	00 00                	add    %al,(%eax)
    8526:	00 00                	add    %al,(%eax)
    8528:	00 00                	add    %al,(%eax)
    852a:	00 00                	add    %al,(%eax)
    852c:	00 00                	add    %al,(%eax)
    852e:	00 00                	add    %al,(%eax)
    8530:	00 00                	add    %al,(%eax)
    8532:	00 00                	add    %al,(%eax)
    8534:	00 00                	add    %al,(%eax)
    8536:	00 00                	add    %al,(%eax)
    8538:	00 00                	add    %al,(%eax)
    853a:	00 00                	add    %al,(%eax)
    853c:	00 00                	add    %al,(%eax)
    853e:	00 00                	add    %al,(%eax)
    8540:	00 00                	add    %al,(%eax)
    8542:	00 00                	add    %al,(%eax)
    8544:	00 00                	add    %al,(%eax)
    8546:	00 00                	add    %al,(%eax)
    8548:	00 00                	add    %al,(%eax)
    854a:	00 00                	add    %al,(%eax)
    854c:	00 00                	add    %al,(%eax)
    854e:	00 00                	add    %al,(%eax)
    8550:	00 00                	add    %al,(%eax)
    8552:	00 00                	add    %al,(%eax)
    8554:	00 00                	add    %al,(%eax)
    8556:	00 00                	add    %al,(%eax)
    8558:	00 00                	add    %al,(%eax)
    855a:	00 00                	add    %al,(%eax)
    855c:	00 00                	add    %al,(%eax)
    855e:	00 00                	add    %al,(%eax)
    8560:	00 00                	add    %al,(%eax)
    8562:	00 00                	add    %al,(%eax)
    8564:	00 00                	add    %al,(%eax)
    8566:	00 00                	add    %al,(%eax)
    8568:	00 00                	add    %al,(%eax)
    856a:	00 00                	add    %al,(%eax)
    856c:	00 00                	add    %al,(%eax)
    856e:	00 00                	add    %al,(%eax)
    8570:	00 00                	add    %al,(%eax)
    8572:	00 00                	add    %al,(%eax)
    8574:	00 00                	add    %al,(%eax)
    8576:	00 00                	add    %al,(%eax)
    8578:	00 00                	add    %al,(%eax)
    857a:	00 00                	add    %al,(%eax)
    857c:	00 00                	add    %al,(%eax)
    857e:	00 00                	add    %al,(%eax)
    8580:	00 00                	add    %al,(%eax)
    8582:	00 00                	add    %al,(%eax)
    8584:	00 00                	add    %al,(%eax)
    8586:	00 00                	add    %al,(%eax)
    8588:	00 00                	add    %al,(%eax)
    858a:	00 00                	add    %al,(%eax)
    858c:	00 00                	add    %al,(%eax)
    858e:	00 00                	add    %al,(%eax)
    8590:	00 00                	add    %al,(%eax)
    8592:	00 00                	add    %al,(%eax)
    8594:	00 00                	add    %al,(%eax)
    8596:	00 00                	add    %al,(%eax)
    8598:	00 00                	add    %al,(%eax)
    859a:	00 00                	add    %al,(%eax)
    859c:	00 00                	add    %al,(%eax)
    859e:	00 00                	add    %al,(%eax)
    85a0:	00 00                	add    %al,(%eax)
    85a2:	00 00                	add    %al,(%eax)
    85a4:	00 00                	add    %al,(%eax)
    85a6:	00 00                	add    %al,(%eax)
    85a8:	00 00                	add    %al,(%eax)
    85aa:	00 00                	add    %al,(%eax)
    85ac:	00 00                	add    %al,(%eax)
    85ae:	00 00                	add    %al,(%eax)
    85b0:	00 00                	add    %al,(%eax)
    85b2:	00 00                	add    %al,(%eax)
    85b4:	00 00                	add    %al,(%eax)
    85b6:	00 00                	add    %al,(%eax)
    85b8:	00 00                	add    %al,(%eax)
    85ba:	00 00                	add    %al,(%eax)
    85bc:	00 00                	add    %al,(%eax)
    85be:	00 00                	add    %al,(%eax)
    85c0:	00 00                	add    %al,(%eax)
    85c2:	00 00                	add    %al,(%eax)
    85c4:	00 00                	add    %al,(%eax)
    85c6:	00 00                	add    %al,(%eax)
    85c8:	00 00                	add    %al,(%eax)
    85ca:	00 00                	add    %al,(%eax)
    85cc:	00 00                	add    %al,(%eax)
    85ce:	00 00                	add    %al,(%eax)
    85d0:	00 00                	add    %al,(%eax)
    85d2:	00 00                	add    %al,(%eax)
    85d4:	00 00                	add    %al,(%eax)
    85d6:	00 00                	add    %al,(%eax)
    85d8:	00 00                	add    %al,(%eax)
    85da:	00 00                	add    %al,(%eax)
    85dc:	00 00                	add    %al,(%eax)
    85de:	00 00                	add    %al,(%eax)
    85e0:	00 00                	add    %al,(%eax)
    85e2:	00 00                	add    %al,(%eax)
    85e4:	00 00                	add    %al,(%eax)
    85e6:	00 00                	add    %al,(%eax)
    85e8:	00 00                	add    %al,(%eax)
    85ea:	00 00                	add    %al,(%eax)
    85ec:	00 00                	add    %al,(%eax)
    85ee:	00 00                	add    %al,(%eax)
    85f0:	00 00                	add    %al,(%eax)
    85f2:	00 00                	add    %al,(%eax)
    85f4:	00 00                	add    %al,(%eax)
    85f6:	00 00                	add    %al,(%eax)
    85f8:	00 00                	add    %al,(%eax)
    85fa:	00 00                	add    %al,(%eax)
    85fc:	00 00                	add    %al,(%eax)
    85fe:	00 00                	add    %al,(%eax)
    8600:	00 00                	add    %al,(%eax)
    8602:	00 00                	add    %al,(%eax)
    8604:	00 00                	add    %al,(%eax)
    8606:	00 00                	add    %al,(%eax)
    8608:	00 00                	add    %al,(%eax)
    860a:	00 00                	add    %al,(%eax)
    860c:	00 00                	add    %al,(%eax)
    860e:	00 00                	add    %al,(%eax)
    8610:	00 00                	add    %al,(%eax)
    8612:	00 00                	add    %al,(%eax)
    8614:	00 00                	add    %al,(%eax)
    8616:	00 00                	add    %al,(%eax)
    8618:	00 00                	add    %al,(%eax)
    861a:	00 00                	add    %al,(%eax)
    861c:	00 00                	add    %al,(%eax)
    861e:	00 00                	add    %al,(%eax)
    8620:	00 00                	add    %al,(%eax)
    8622:	00 00                	add    %al,(%eax)
    8624:	00 00                	add    %al,(%eax)
    8626:	00 00                	add    %al,(%eax)
    8628:	00 00                	add    %al,(%eax)
    862a:	00 00                	add    %al,(%eax)
    862c:	00 00                	add    %al,(%eax)
    862e:	00 00                	add    %al,(%eax)
    8630:	00 00                	add    %al,(%eax)
    8632:	00 00                	add    %al,(%eax)
    8634:	00 00                	add    %al,(%eax)
    8636:	00 00                	add    %al,(%eax)
    8638:	00 00                	add    %al,(%eax)
    863a:	00 00                	add    %al,(%eax)
    863c:	00 00                	add    %al,(%eax)
    863e:	00 00                	add    %al,(%eax)
    8640:	00 00                	add    %al,(%eax)
    8642:	00 00                	add    %al,(%eax)
    8644:	00 00                	add    %al,(%eax)
    8646:	00 00                	add    %al,(%eax)
    8648:	00 00                	add    %al,(%eax)
    864a:	00 00                	add    %al,(%eax)
    864c:	00 00                	add    %al,(%eax)
    864e:	00 00                	add    %al,(%eax)
    8650:	00 00                	add    %al,(%eax)
    8652:	00 00                	add    %al,(%eax)
    8654:	00 00                	add    %al,(%eax)
    8656:	00 00                	add    %al,(%eax)
    8658:	00 00                	add    %al,(%eax)
    865a:	00 00                	add    %al,(%eax)
    865c:	00 00                	add    %al,(%eax)
    865e:	00 00                	add    %al,(%eax)
    8660:	00 00                	add    %al,(%eax)
    8662:	00 00                	add    %al,(%eax)
    8664:	00 00                	add    %al,(%eax)
    8666:	00 00                	add    %al,(%eax)
    8668:	00 00                	add    %al,(%eax)
    866a:	00 00                	add    %al,(%eax)
    866c:	00 00                	add    %al,(%eax)
    866e:	00 00                	add    %al,(%eax)
    8670:	00 00                	add    %al,(%eax)
    8672:	00 00                	add    %al,(%eax)
    8674:	00 00                	add    %al,(%eax)
    8676:	00 00                	add    %al,(%eax)
    8678:	00 00                	add    %al,(%eax)
    867a:	00 00                	add    %al,(%eax)
    867c:	00 00                	add    %al,(%eax)
    867e:	00 00                	add    %al,(%eax)
    8680:	00 00                	add    %al,(%eax)
    8682:	00 00                	add    %al,(%eax)
    8684:	00 00                	add    %al,(%eax)
    8686:	00 00                	add    %al,(%eax)
    8688:	00 00                	add    %al,(%eax)
    868a:	00 00                	add    %al,(%eax)
    868c:	00 00                	add    %al,(%eax)
    868e:	00 00                	add    %al,(%eax)
    8690:	00 00                	add    %al,(%eax)
    8692:	00 00                	add    %al,(%eax)
    8694:	00 00                	add    %al,(%eax)
    8696:	00 00                	add    %al,(%eax)
    8698:	00 00                	add    %al,(%eax)
    869a:	00 00                	add    %al,(%eax)
    869c:	00 00                	add    %al,(%eax)
    869e:	00 00                	add    %al,(%eax)
    86a0:	00 00                	add    %al,(%eax)
    86a2:	00 00                	add    %al,(%eax)
    86a4:	00 00                	add    %al,(%eax)
    86a6:	00 00                	add    %al,(%eax)
    86a8:	00 00                	add    %al,(%eax)
    86aa:	00 00                	add    %al,(%eax)
    86ac:	00 00                	add    %al,(%eax)
    86ae:	00 00                	add    %al,(%eax)
    86b0:	00 00                	add    %al,(%eax)
    86b2:	00 00                	add    %al,(%eax)
    86b4:	00 00                	add    %al,(%eax)
    86b6:	00 00                	add    %al,(%eax)
    86b8:	00 00                	add    %al,(%eax)
    86ba:	00 00                	add    %al,(%eax)
    86bc:	00 00                	add    %al,(%eax)
    86be:	00 00                	add    %al,(%eax)
    86c0:	00 00                	add    %al,(%eax)
    86c2:	00 00                	add    %al,(%eax)
    86c4:	00 00                	add    %al,(%eax)
    86c6:	00 00                	add    %al,(%eax)
    86c8:	00 00                	add    %al,(%eax)
    86ca:	00 00                	add    %al,(%eax)
    86cc:	00 00                	add    %al,(%eax)
    86ce:	00 00                	add    %al,(%eax)
    86d0:	00 00                	add    %al,(%eax)
    86d2:	00 00                	add    %al,(%eax)
    86d4:	00 00                	add    %al,(%eax)
    86d6:	00 00                	add    %al,(%eax)
    86d8:	00 00                	add    %al,(%eax)
    86da:	00 00                	add    %al,(%eax)
    86dc:	00 00                	add    %al,(%eax)
    86de:	00 00                	add    %al,(%eax)
    86e0:	00 00                	add    %al,(%eax)
    86e2:	00 00                	add    %al,(%eax)
    86e4:	00 00                	add    %al,(%eax)
    86e6:	00 00                	add    %al,(%eax)
    86e8:	00 00                	add    %al,(%eax)
    86ea:	00 00                	add    %al,(%eax)
    86ec:	00 00                	add    %al,(%eax)
    86ee:	00 00                	add    %al,(%eax)
    86f0:	00 00                	add    %al,(%eax)
    86f2:	00 00                	add    %al,(%eax)
    86f4:	00 00                	add    %al,(%eax)
    86f6:	00 00                	add    %al,(%eax)
    86f8:	00 00                	add    %al,(%eax)
    86fa:	00 00                	add    %al,(%eax)
    86fc:	00 00                	add    %al,(%eax)
    86fe:	00 00                	add    %al,(%eax)
    8700:	00 00                	add    %al,(%eax)
    8702:	00 00                	add    %al,(%eax)
    8704:	00 00                	add    %al,(%eax)
    8706:	00 00                	add    %al,(%eax)
    8708:	00 00                	add    %al,(%eax)
    870a:	00 00                	add    %al,(%eax)
    870c:	00 00                	add    %al,(%eax)
    870e:	00 00                	add    %al,(%eax)
    8710:	00 00                	add    %al,(%eax)
    8712:	00 00                	add    %al,(%eax)
    8714:	00 00                	add    %al,(%eax)
    8716:	00 00                	add    %al,(%eax)
    8718:	00 00                	add    %al,(%eax)
    871a:	00 00                	add    %al,(%eax)
    871c:	00 00                	add    %al,(%eax)
    871e:	00 00                	add    %al,(%eax)
    8720:	00 00                	add    %al,(%eax)
    8722:	00 00                	add    %al,(%eax)
    8724:	00 00                	add    %al,(%eax)
    8726:	00 00                	add    %al,(%eax)
    8728:	00 00                	add    %al,(%eax)
    872a:	00 00                	add    %al,(%eax)
    872c:	00 00                	add    %al,(%eax)
    872e:	00 00                	add    %al,(%eax)
    8730:	00 00                	add    %al,(%eax)
    8732:	00 00                	add    %al,(%eax)
    8734:	00 00                	add    %al,(%eax)
    8736:	00 00                	add    %al,(%eax)
    8738:	00 00                	add    %al,(%eax)
    873a:	00 00                	add    %al,(%eax)
    873c:	00 00                	add    %al,(%eax)
    873e:	00 00                	add    %al,(%eax)
    8740:	00 00                	add    %al,(%eax)
    8742:	00 00                	add    %al,(%eax)
    8744:	00 00                	add    %al,(%eax)
    8746:	00 00                	add    %al,(%eax)
    8748:	00 00                	add    %al,(%eax)
    874a:	00 00                	add    %al,(%eax)
    874c:	00 00                	add    %al,(%eax)
    874e:	00 00                	add    %al,(%eax)
    8750:	00 00                	add    %al,(%eax)
    8752:	00 00                	add    %al,(%eax)
    8754:	00 00                	add    %al,(%eax)
    8756:	00 00                	add    %al,(%eax)
    8758:	00 00                	add    %al,(%eax)
    875a:	00 00                	add    %al,(%eax)
    875c:	00 00                	add    %al,(%eax)
    875e:	00 00                	add    %al,(%eax)
    8760:	00 00                	add    %al,(%eax)
    8762:	00 00                	add    %al,(%eax)
    8764:	00 00                	add    %al,(%eax)
    8766:	00 00                	add    %al,(%eax)
    8768:	00 00                	add    %al,(%eax)
    876a:	00 00                	add    %al,(%eax)
    876c:	00 00                	add    %al,(%eax)
    876e:	00 00                	add    %al,(%eax)
    8770:	00 00                	add    %al,(%eax)
    8772:	00 00                	add    %al,(%eax)
    8774:	00 00                	add    %al,(%eax)
    8776:	00 00                	add    %al,(%eax)
    8778:	00 00                	add    %al,(%eax)
    877a:	00 00                	add    %al,(%eax)
    877c:	00 00                	add    %al,(%eax)
    877e:	00 00                	add    %al,(%eax)
    8780:	00 00                	add    %al,(%eax)
    8782:	00 00                	add    %al,(%eax)
    8784:	00 00                	add    %al,(%eax)
    8786:	00 00                	add    %al,(%eax)
    8788:	00 00                	add    %al,(%eax)
    878a:	00 00                	add    %al,(%eax)
    878c:	00 00                	add    %al,(%eax)
    878e:	00 00                	add    %al,(%eax)
    8790:	00 00                	add    %al,(%eax)
    8792:	00 00                	add    %al,(%eax)
    8794:	00 00                	add    %al,(%eax)
    8796:	00 00                	add    %al,(%eax)
    8798:	00 00                	add    %al,(%eax)
    879a:	00 00                	add    %al,(%eax)
    879c:	00 00                	add    %al,(%eax)
    879e:	00 00                	add    %al,(%eax)
    87a0:	00 00                	add    %al,(%eax)
    87a2:	00 00                	add    %al,(%eax)
    87a4:	00 00                	add    %al,(%eax)
    87a6:	00 00                	add    %al,(%eax)
    87a8:	00 00                	add    %al,(%eax)
    87aa:	00 00                	add    %al,(%eax)
    87ac:	00 00                	add    %al,(%eax)
    87ae:	00 00                	add    %al,(%eax)
    87b0:	00 00                	add    %al,(%eax)
    87b2:	00 00                	add    %al,(%eax)
    87b4:	00 00                	add    %al,(%eax)
    87b6:	00 00                	add    %al,(%eax)
    87b8:	00 00                	add    %al,(%eax)
    87ba:	00 00                	add    %al,(%eax)
    87bc:	00 00                	add    %al,(%eax)
    87be:	00 00                	add    %al,(%eax)
    87c0:	00 00                	add    %al,(%eax)
    87c2:	00 00                	add    %al,(%eax)
    87c4:	00 00                	add    %al,(%eax)
    87c6:	00 00                	add    %al,(%eax)
    87c8:	00 00                	add    %al,(%eax)
    87ca:	00 00                	add    %al,(%eax)
    87cc:	00 00                	add    %al,(%eax)
    87ce:	00 00                	add    %al,(%eax)
    87d0:	00 00                	add    %al,(%eax)
    87d2:	00 00                	add    %al,(%eax)
    87d4:	00 00                	add    %al,(%eax)
    87d6:	00 00                	add    %al,(%eax)
    87d8:	00 00                	add    %al,(%eax)
    87da:	00 00                	add    %al,(%eax)
    87dc:	00 00                	add    %al,(%eax)
    87de:	00 00                	add    %al,(%eax)
    87e0:	00 00                	add    %al,(%eax)
    87e2:	00 00                	add    %al,(%eax)
    87e4:	00 00                	add    %al,(%eax)
    87e6:	00 00                	add    %al,(%eax)
    87e8:	00 00                	add    %al,(%eax)
    87ea:	00 00                	add    %al,(%eax)
    87ec:	00 00                	add    %al,(%eax)
    87ee:	00 00                	add    %al,(%eax)
    87f0:	00 00                	add    %al,(%eax)
    87f2:	00 00                	add    %al,(%eax)
    87f4:	00 00                	add    %al,(%eax)
    87f6:	00 00                	add    %al,(%eax)
    87f8:	00 00                	add    %al,(%eax)
    87fa:	00 00                	add    %al,(%eax)
    87fc:	00 00                	add    %al,(%eax)
    87fe:	00 00                	add    %al,(%eax)
    8800:	00 00                	add    %al,(%eax)
    8802:	00 00                	add    %al,(%eax)
    8804:	00 00                	add    %al,(%eax)
    8806:	00 00                	add    %al,(%eax)
    8808:	00 00                	add    %al,(%eax)
    880a:	00 00                	add    %al,(%eax)
    880c:	00 00                	add    %al,(%eax)
    880e:	00 00                	add    %al,(%eax)
    8810:	00 00                	add    %al,(%eax)
    8812:	00 00                	add    %al,(%eax)
    8814:	00 00                	add    %al,(%eax)
    8816:	00 00                	add    %al,(%eax)
    8818:	00 00                	add    %al,(%eax)
    881a:	00 00                	add    %al,(%eax)
    881c:	00 00                	add    %al,(%eax)
    881e:	00 00                	add    %al,(%eax)
    8820:	00 00                	add    %al,(%eax)
    8822:	00 00                	add    %al,(%eax)
    8824:	00 00                	add    %al,(%eax)
    8826:	00 00                	add    %al,(%eax)
    8828:	00 00                	add    %al,(%eax)
    882a:	00 00                	add    %al,(%eax)
    882c:	00 00                	add    %al,(%eax)
    882e:	00 00                	add    %al,(%eax)
    8830:	00 00                	add    %al,(%eax)
    8832:	00 00                	add    %al,(%eax)
    8834:	00 00                	add    %al,(%eax)
    8836:	00 00                	add    %al,(%eax)
    8838:	00 00                	add    %al,(%eax)
    883a:	00 00                	add    %al,(%eax)
    883c:	00 00                	add    %al,(%eax)
    883e:	00 00                	add    %al,(%eax)
    8840:	00 00                	add    %al,(%eax)
    8842:	00 00                	add    %al,(%eax)
    8844:	00 00                	add    %al,(%eax)
    8846:	00 00                	add    %al,(%eax)
    8848:	00 00                	add    %al,(%eax)
    884a:	00 00                	add    %al,(%eax)
    884c:	00 00                	add    %al,(%eax)
    884e:	00 00                	add    %al,(%eax)
    8850:	00 00                	add    %al,(%eax)
    8852:	00 00                	add    %al,(%eax)
    8854:	00 00                	add    %al,(%eax)
    8856:	00 00                	add    %al,(%eax)
    8858:	00 00                	add    %al,(%eax)
    885a:	00 00                	add    %al,(%eax)
    885c:	00 00                	add    %al,(%eax)
    885e:	00 00                	add    %al,(%eax)
    8860:	00 00                	add    %al,(%eax)
    8862:	00 00                	add    %al,(%eax)
    8864:	00 00                	add    %al,(%eax)
    8866:	00 00                	add    %al,(%eax)
    8868:	00 00                	add    %al,(%eax)
    886a:	00 00                	add    %al,(%eax)
    886c:	00 00                	add    %al,(%eax)
    886e:	00 00                	add    %al,(%eax)
    8870:	00 00                	add    %al,(%eax)
    8872:	00 00                	add    %al,(%eax)
    8874:	00 00                	add    %al,(%eax)
    8876:	00 00                	add    %al,(%eax)
    8878:	00 00                	add    %al,(%eax)
    887a:	00 00                	add    %al,(%eax)
    887c:	00 00                	add    %al,(%eax)
    887e:	00 00                	add    %al,(%eax)
    8880:	00 00                	add    %al,(%eax)
    8882:	00 00                	add    %al,(%eax)
    8884:	00 00                	add    %al,(%eax)
    8886:	00 00                	add    %al,(%eax)
    8888:	00 00                	add    %al,(%eax)
    888a:	00 00                	add    %al,(%eax)
    888c:	00 00                	add    %al,(%eax)
    888e:	00 00                	add    %al,(%eax)
    8890:	00 00                	add    %al,(%eax)
    8892:	00 00                	add    %al,(%eax)
    8894:	00 00                	add    %al,(%eax)
    8896:	00 00                	add    %al,(%eax)
    8898:	00 00                	add    %al,(%eax)
    889a:	00 00                	add    %al,(%eax)
    889c:	00 00                	add    %al,(%eax)
    889e:	00 00                	add    %al,(%eax)
    88a0:	00 00                	add    %al,(%eax)
    88a2:	00 00                	add    %al,(%eax)
    88a4:	00 00                	add    %al,(%eax)
    88a6:	00 00                	add    %al,(%eax)
    88a8:	00 00                	add    %al,(%eax)
    88aa:	00 00                	add    %al,(%eax)
    88ac:	00 00                	add    %al,(%eax)
    88ae:	00 00                	add    %al,(%eax)
    88b0:	00 00                	add    %al,(%eax)
    88b2:	00 00                	add    %al,(%eax)
    88b4:	00 00                	add    %al,(%eax)
    88b6:	00 00                	add    %al,(%eax)
    88b8:	00 00                	add    %al,(%eax)
    88ba:	00 00                	add    %al,(%eax)
    88bc:	00 00                	add    %al,(%eax)
    88be:	00 00                	add    %al,(%eax)
    88c0:	00 00                	add    %al,(%eax)
    88c2:	00 00                	add    %al,(%eax)
    88c4:	00 00                	add    %al,(%eax)
    88c6:	00 00                	add    %al,(%eax)
    88c8:	00 00                	add    %al,(%eax)
    88ca:	00 00                	add    %al,(%eax)
    88cc:	00 00                	add    %al,(%eax)
    88ce:	00 00                	add    %al,(%eax)
    88d0:	00 00                	add    %al,(%eax)
    88d2:	00 00                	add    %al,(%eax)
    88d4:	00 00                	add    %al,(%eax)
    88d6:	00 00                	add    %al,(%eax)
    88d8:	00 00                	add    %al,(%eax)
    88da:	00 00                	add    %al,(%eax)
    88dc:	00 00                	add    %al,(%eax)
    88de:	00 00                	add    %al,(%eax)
    88e0:	00 00                	add    %al,(%eax)
    88e2:	00 00                	add    %al,(%eax)
    88e4:	00 00                	add    %al,(%eax)
    88e6:	00 00                	add    %al,(%eax)
    88e8:	00 00                	add    %al,(%eax)
    88ea:	00 00                	add    %al,(%eax)
    88ec:	00 00                	add    %al,(%eax)
    88ee:	00 00                	add    %al,(%eax)
    88f0:	00 00                	add    %al,(%eax)
    88f2:	00 00                	add    %al,(%eax)
    88f4:	00 00                	add    %al,(%eax)
    88f6:	00 00                	add    %al,(%eax)
    88f8:	00 00                	add    %al,(%eax)
    88fa:	00 00                	add    %al,(%eax)
    88fc:	00 00                	add    %al,(%eax)
    88fe:	00 00                	add    %al,(%eax)
    8900:	00 00                	add    %al,(%eax)
    8902:	00 00                	add    %al,(%eax)
    8904:	00 00                	add    %al,(%eax)
    8906:	00 00                	add    %al,(%eax)
    8908:	00 00                	add    %al,(%eax)
    890a:	00 00                	add    %al,(%eax)
    890c:	00 00                	add    %al,(%eax)
    890e:	00 00                	add    %al,(%eax)
    8910:	00 00                	add    %al,(%eax)
    8912:	00 00                	add    %al,(%eax)
    8914:	00 00                	add    %al,(%eax)
    8916:	00 00                	add    %al,(%eax)
    8918:	00 00                	add    %al,(%eax)
    891a:	00 00                	add    %al,(%eax)
    891c:	00 00                	add    %al,(%eax)
    891e:	00 00                	add    %al,(%eax)
    8920:	00 00                	add    %al,(%eax)
    8922:	00 00                	add    %al,(%eax)
    8924:	00 00                	add    %al,(%eax)
    8926:	00 00                	add    %al,(%eax)
    8928:	00 00                	add    %al,(%eax)
    892a:	00 00                	add    %al,(%eax)
    892c:	00 00                	add    %al,(%eax)
    892e:	00 00                	add    %al,(%eax)
    8930:	00 00                	add    %al,(%eax)
    8932:	00 00                	add    %al,(%eax)
    8934:	00 00                	add    %al,(%eax)
    8936:	00 00                	add    %al,(%eax)
    8938:	00 00                	add    %al,(%eax)
    893a:	00 00                	add    %al,(%eax)
    893c:	00 00                	add    %al,(%eax)
    893e:	00 00                	add    %al,(%eax)
    8940:	00 00                	add    %al,(%eax)
    8942:	00 00                	add    %al,(%eax)
    8944:	00 00                	add    %al,(%eax)
    8946:	00 00                	add    %al,(%eax)
    8948:	00 00                	add    %al,(%eax)
    894a:	00 00                	add    %al,(%eax)
    894c:	00 00                	add    %al,(%eax)
    894e:	00 00                	add    %al,(%eax)
    8950:	00 00                	add    %al,(%eax)
    8952:	00 00                	add    %al,(%eax)
    8954:	00 00                	add    %al,(%eax)
    8956:	00 00                	add    %al,(%eax)
    8958:	00 00                	add    %al,(%eax)
    895a:	00 00                	add    %al,(%eax)
    895c:	00 00                	add    %al,(%eax)
    895e:	00 00                	add    %al,(%eax)
    8960:	00 00                	add    %al,(%eax)
    8962:	00 00                	add    %al,(%eax)
    8964:	00 00                	add    %al,(%eax)
    8966:	00 00                	add    %al,(%eax)
    8968:	00 00                	add    %al,(%eax)
    896a:	00 00                	add    %al,(%eax)
    896c:	00 00                	add    %al,(%eax)
    896e:	00 00                	add    %al,(%eax)
    8970:	00 00                	add    %al,(%eax)
    8972:	00 00                	add    %al,(%eax)
    8974:	00 00                	add    %al,(%eax)
    8976:	00 00                	add    %al,(%eax)
    8978:	00 00                	add    %al,(%eax)
    897a:	00 00                	add    %al,(%eax)
    897c:	00 00                	add    %al,(%eax)
    897e:	00 00                	add    %al,(%eax)
    8980:	00 00                	add    %al,(%eax)
    8982:	00 00                	add    %al,(%eax)
    8984:	00 00                	add    %al,(%eax)
    8986:	00 00                	add    %al,(%eax)
    8988:	00 00                	add    %al,(%eax)
    898a:	00 00                	add    %al,(%eax)
    898c:	00 00                	add    %al,(%eax)
    898e:	00 00                	add    %al,(%eax)
    8990:	00 00                	add    %al,(%eax)
    8992:	00 00                	add    %al,(%eax)
    8994:	00 00                	add    %al,(%eax)
    8996:	00 00                	add    %al,(%eax)
    8998:	00 00                	add    %al,(%eax)
    899a:	00 00                	add    %al,(%eax)
    899c:	00 00                	add    %al,(%eax)
    899e:	00 00                	add    %al,(%eax)
    89a0:	00 00                	add    %al,(%eax)
    89a2:	00 00                	add    %al,(%eax)
    89a4:	00 00                	add    %al,(%eax)
    89a6:	00 00                	add    %al,(%eax)
    89a8:	00 00                	add    %al,(%eax)
    89aa:	00 00                	add    %al,(%eax)
    89ac:	00 00                	add    %al,(%eax)
    89ae:	00 00                	add    %al,(%eax)
    89b0:	00 00                	add    %al,(%eax)
    89b2:	00 00                	add    %al,(%eax)
    89b4:	00 00                	add    %al,(%eax)
    89b6:	00 00                	add    %al,(%eax)
    89b8:	00 00                	add    %al,(%eax)
    89ba:	00 00                	add    %al,(%eax)
    89bc:	00 00                	add    %al,(%eax)
    89be:	00 00                	add    %al,(%eax)
    89c0:	00 00                	add    %al,(%eax)
    89c2:	00 00                	add    %al,(%eax)
    89c4:	00 00                	add    %al,(%eax)
    89c6:	00 00                	add    %al,(%eax)
    89c8:	00 00                	add    %al,(%eax)
    89ca:	00 00                	add    %al,(%eax)
    89cc:	00 00                	add    %al,(%eax)
    89ce:	00 00                	add    %al,(%eax)
    89d0:	00 00                	add    %al,(%eax)
    89d2:	00 00                	add    %al,(%eax)
    89d4:	00 00                	add    %al,(%eax)
    89d6:	00 00                	add    %al,(%eax)
    89d8:	00 00                	add    %al,(%eax)
    89da:	00 00                	add    %al,(%eax)
    89dc:	00 00                	add    %al,(%eax)
    89de:	00 00                	add    %al,(%eax)
    89e0:	00 00                	add    %al,(%eax)
    89e2:	00 00                	add    %al,(%eax)
    89e4:	00 00                	add    %al,(%eax)
    89e6:	00 00                	add    %al,(%eax)
    89e8:	00 00                	add    %al,(%eax)
    89ea:	00 00                	add    %al,(%eax)
    89ec:	00 00                	add    %al,(%eax)
    89ee:	00 00                	add    %al,(%eax)
    89f0:	00 00                	add    %al,(%eax)
    89f2:	00 00                	add    %al,(%eax)
    89f4:	00 00                	add    %al,(%eax)
    89f6:	00 00                	add    %al,(%eax)
    89f8:	00 00                	add    %al,(%eax)
    89fa:	00 00                	add    %al,(%eax)
    89fc:	00 00                	add    %al,(%eax)
    89fe:	00 00                	add    %al,(%eax)
    8a00:	00 00                	add    %al,(%eax)
    8a02:	00 00                	add    %al,(%eax)
    8a04:	00 00                	add    %al,(%eax)
    8a06:	00 00                	add    %al,(%eax)
    8a08:	00 00                	add    %al,(%eax)
    8a0a:	00 00                	add    %al,(%eax)
    8a0c:	00 00                	add    %al,(%eax)
    8a0e:	00 00                	add    %al,(%eax)
    8a10:	00 00                	add    %al,(%eax)
    8a12:	00 00                	add    %al,(%eax)
    8a14:	00 00                	add    %al,(%eax)
    8a16:	00 00                	add    %al,(%eax)
    8a18:	00 00                	add    %al,(%eax)
    8a1a:	00 00                	add    %al,(%eax)
    8a1c:	00 00                	add    %al,(%eax)
    8a1e:	00 00                	add    %al,(%eax)
    8a20:	00 00                	add    %al,(%eax)
    8a22:	00 00                	add    %al,(%eax)
    8a24:	00 00                	add    %al,(%eax)
    8a26:	00 00                	add    %al,(%eax)
    8a28:	00 00                	add    %al,(%eax)
    8a2a:	00 00                	add    %al,(%eax)
    8a2c:	00 00                	add    %al,(%eax)
    8a2e:	00 00                	add    %al,(%eax)
    8a30:	00 00                	add    %al,(%eax)
    8a32:	00 00                	add    %al,(%eax)
    8a34:	00 00                	add    %al,(%eax)
    8a36:	00 00                	add    %al,(%eax)
    8a38:	00 00                	add    %al,(%eax)
    8a3a:	00 00                	add    %al,(%eax)
    8a3c:	00 00                	add    %al,(%eax)
    8a3e:	00 00                	add    %al,(%eax)
    8a40:	00 00                	add    %al,(%eax)
    8a42:	00 00                	add    %al,(%eax)
    8a44:	00 00                	add    %al,(%eax)
    8a46:	00 00                	add    %al,(%eax)
    8a48:	00 00                	add    %al,(%eax)
    8a4a:	00 00                	add    %al,(%eax)
    8a4c:	00 00                	add    %al,(%eax)
    8a4e:	00 00                	add    %al,(%eax)
    8a50:	00 00                	add    %al,(%eax)
    8a52:	00 00                	add    %al,(%eax)
    8a54:	00 00                	add    %al,(%eax)
    8a56:	00 00                	add    %al,(%eax)
    8a58:	00 00                	add    %al,(%eax)
    8a5a:	00 00                	add    %al,(%eax)
    8a5c:	00 00                	add    %al,(%eax)
    8a5e:	00 00                	add    %al,(%eax)
    8a60:	00 00                	add    %al,(%eax)
    8a62:	00 00                	add    %al,(%eax)
    8a64:	00 00                	add    %al,(%eax)
    8a66:	00 00                	add    %al,(%eax)
    8a68:	00 00                	add    %al,(%eax)
    8a6a:	00 00                	add    %al,(%eax)
    8a6c:	00 00                	add    %al,(%eax)
    8a6e:	00 00                	add    %al,(%eax)
    8a70:	00 00                	add    %al,(%eax)
    8a72:	00 00                	add    %al,(%eax)
    8a74:	00 00                	add    %al,(%eax)
    8a76:	00 00                	add    %al,(%eax)
    8a78:	00 00                	add    %al,(%eax)
    8a7a:	00 00                	add    %al,(%eax)
    8a7c:	00 00                	add    %al,(%eax)
    8a7e:	00 00                	add    %al,(%eax)
    8a80:	00 00                	add    %al,(%eax)
    8a82:	00 00                	add    %al,(%eax)
    8a84:	00 00                	add    %al,(%eax)
    8a86:	00 00                	add    %al,(%eax)
    8a88:	00 00                	add    %al,(%eax)
    8a8a:	00 00                	add    %al,(%eax)
    8a8c:	00 00                	add    %al,(%eax)
    8a8e:	00 00                	add    %al,(%eax)
    8a90:	00 00                	add    %al,(%eax)
    8a92:	00 00                	add    %al,(%eax)
    8a94:	00 00                	add    %al,(%eax)
    8a96:	00 00                	add    %al,(%eax)
    8a98:	00 00                	add    %al,(%eax)
    8a9a:	00 00                	add    %al,(%eax)
    8a9c:	00 00                	add    %al,(%eax)
    8a9e:	00 00                	add    %al,(%eax)
    8aa0:	00 00                	add    %al,(%eax)
    8aa2:	00 00                	add    %al,(%eax)
    8aa4:	00 00                	add    %al,(%eax)
    8aa6:	00 00                	add    %al,(%eax)
    8aa8:	00 00                	add    %al,(%eax)
    8aaa:	00 00                	add    %al,(%eax)
    8aac:	00 00                	add    %al,(%eax)
    8aae:	00 00                	add    %al,(%eax)
    8ab0:	00 00                	add    %al,(%eax)
    8ab2:	00 00                	add    %al,(%eax)
    8ab4:	00 00                	add    %al,(%eax)
    8ab6:	00 00                	add    %al,(%eax)
    8ab8:	00 00                	add    %al,(%eax)
    8aba:	00 00                	add    %al,(%eax)
    8abc:	00 00                	add    %al,(%eax)
    8abe:	00 00                	add    %al,(%eax)
    8ac0:	00 00                	add    %al,(%eax)
    8ac2:	00 00                	add    %al,(%eax)
    8ac4:	00 00                	add    %al,(%eax)
    8ac6:	00 00                	add    %al,(%eax)
    8ac8:	00 00                	add    %al,(%eax)
    8aca:	00 00                	add    %al,(%eax)
    8acc:	00 00                	add    %al,(%eax)
    8ace:	00 00                	add    %al,(%eax)
    8ad0:	00 00                	add    %al,(%eax)
    8ad2:	00 00                	add    %al,(%eax)
    8ad4:	00 00                	add    %al,(%eax)
    8ad6:	00 00                	add    %al,(%eax)
    8ad8:	00 00                	add    %al,(%eax)
    8ada:	00 00                	add    %al,(%eax)
    8adc:	00 00                	add    %al,(%eax)
    8ade:	00 00                	add    %al,(%eax)
    8ae0:	00 00                	add    %al,(%eax)
    8ae2:	00 00                	add    %al,(%eax)
    8ae4:	00 00                	add    %al,(%eax)
    8ae6:	00 00                	add    %al,(%eax)
    8ae8:	00 00                	add    %al,(%eax)
    8aea:	00 00                	add    %al,(%eax)
    8aec:	00 00                	add    %al,(%eax)
    8aee:	00 00                	add    %al,(%eax)
    8af0:	00 00                	add    %al,(%eax)
    8af2:	00 00                	add    %al,(%eax)
    8af4:	00 00                	add    %al,(%eax)
    8af6:	00 00                	add    %al,(%eax)
    8af8:	00 00                	add    %al,(%eax)
    8afa:	00 00                	add    %al,(%eax)
    8afc:	00 00                	add    %al,(%eax)
    8afe:	00 00                	add    %al,(%eax)
    8b00:	00 00                	add    %al,(%eax)
    8b02:	00 00                	add    %al,(%eax)
    8b04:	00 00                	add    %al,(%eax)
    8b06:	00 00                	add    %al,(%eax)
    8b08:	00 00                	add    %al,(%eax)
    8b0a:	00 00                	add    %al,(%eax)
    8b0c:	00 00                	add    %al,(%eax)
    8b0e:	00 00                	add    %al,(%eax)
    8b10:	00 00                	add    %al,(%eax)
    8b12:	00 00                	add    %al,(%eax)
    8b14:	00 00                	add    %al,(%eax)
    8b16:	00 00                	add    %al,(%eax)
    8b18:	00 00                	add    %al,(%eax)
    8b1a:	00 00                	add    %al,(%eax)
    8b1c:	00 00                	add    %al,(%eax)
    8b1e:	00 00                	add    %al,(%eax)
    8b20:	00 00                	add    %al,(%eax)
    8b22:	00 00                	add    %al,(%eax)
    8b24:	00 00                	add    %al,(%eax)

00008b26 <putc>:
 */
volatile char *video = (volatile char*) 0xB8000;

void
putc (int l, int color, char ch)
{
    8b26:	55                   	push   %ebp
    8b27:	89 e5                	mov    %esp,%ebp
    8b29:	8b 45 08             	mov    0x8(%ebp),%eax
	volatile char * p = video + l * 2;
	* p = ch;
    8b2c:	8b 55 10             	mov    0x10(%ebp),%edx
volatile char *video = (volatile char*) 0xB8000;

void
putc (int l, int color, char ch)
{
	volatile char * p = video + l * 2;
    8b2f:	01 c0                	add    %eax,%eax
    8b31:	03 05 80 92 00 00    	add    0x9280,%eax
	* p = ch;
    8b37:	88 10                	mov    %dl,(%eax)
	* (p + 1) = color;
    8b39:	8b 55 0c             	mov    0xc(%ebp),%edx
    8b3c:	88 50 01             	mov    %dl,0x1(%eax)
}
    8b3f:	5d                   	pop    %ebp
    8b40:	c3                   	ret    

00008b41 <puts>:


int
puts (int r, int c, int color, const char *string)
{
    8b41:	55                   	push   %ebp
    8b42:	89 e5                	mov    %esp,%ebp
    8b44:	56                   	push   %esi
    8b45:	53                   	push   %ebx
    8b46:	8b 5d 14             	mov    0x14(%ebp),%ebx
	int l = r * 80 + c;
    8b49:	6b 45 08 50          	imul   $0x50,0x8(%ebp),%eax
    8b4d:	03 45 0c             	add    0xc(%ebp),%eax
    8b50:	29 c3                	sub    %eax,%ebx
	while (*string != 0)
    8b52:	0f be 14 03          	movsbl (%ebx,%eax,1),%edx
    8b56:	84 d2                	test   %dl,%dl
    8b58:	74 14                	je     8b6e <puts+0x2d>
	{
		putc (l++, color, *string++);
    8b5a:	52                   	push   %edx
    8b5b:	ff 75 10             	pushl  0x10(%ebp)
    8b5e:	8d 70 01             	lea    0x1(%eax),%esi
    8b61:	50                   	push   %eax
    8b62:	e8 bf ff ff ff       	call   8b26 <putc>
    8b67:	83 c4 0c             	add    $0xc,%esp
    8b6a:	89 f0                	mov    %esi,%eax
    8b6c:	eb e4                	jmp    8b52 <puts+0x11>
	}
	return l;
}
    8b6e:	8d 65 f8             	lea    -0x8(%ebp),%esp
    8b71:	5b                   	pop    %ebx
    8b72:	5e                   	pop    %esi
    8b73:	5d                   	pop    %ebp
    8b74:	c3                   	ret    

00008b75 <putline>:
char * blank =
"                                                                                ";

void
putline (char * s)
{
    8b75:	55                   	push   %ebp
	puts (row = (row >= CRT_ROWS) ? 0 : row + 1, 0, VGA_CLR_BLACK, blank);
    8b76:	a1 0c 93 00 00       	mov    0x930c,%eax
char * blank =
"                                                                                ";

void
putline (char * s)
{
    8b7b:	89 e5                	mov    %esp,%ebp
    8b7d:	53                   	push   %ebx
	puts (row = (row >= CRT_ROWS) ? 0 : row + 1, 0, VGA_CLR_BLACK, blank);
    8b7e:	31 db                	xor    %ebx,%ebx
    8b80:	ff 35 7c 92 00 00    	pushl  0x927c
    8b86:	83 f8 18             	cmp    $0x18,%eax
    8b89:	8d 50 01             	lea    0x1(%eax),%edx
    8b8c:	0f 4e da             	cmovle %edx,%ebx
    8b8f:	6a 00                	push   $0x0
    8b91:	6a 00                	push   $0x0
    8b93:	53                   	push   %ebx
    8b94:	89 1d 0c 93 00 00    	mov    %ebx,0x930c
    8b9a:	e8 a2 ff ff ff       	call   8b41 <puts>
	puts (row, 0, VGA_CLR_WHITE, s);
    8b9f:	ff 75 08             	pushl  0x8(%ebp)
    8ba2:	6a 0f                	push   $0xf
    8ba4:	6a 00                	push   $0x0
    8ba6:	53                   	push   %ebx
    8ba7:	e8 95 ff ff ff       	call   8b41 <puts>
    8bac:	83 c4 20             	add    $0x20,%esp
}
    8baf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    8bb2:	c9                   	leave  
    8bb3:	c3                   	ret    

00008bb4 <roll>:

void
roll (int r)
{
    8bb4:	55                   	push   %ebp
    8bb5:	89 e5                	mov    %esp,%ebp
	row = r;
    8bb7:	8b 45 08             	mov    0x8(%ebp),%eax
}
    8bba:	5d                   	pop    %ebp
}

void
roll (int r)
{
	row = r;
    8bbb:	a3 0c 93 00 00       	mov    %eax,0x930c
}
    8bc0:	c3                   	ret    

00008bc1 <panic>:

void
panic (char * m)
{
    8bc1:	55                   	push   %ebp
    8bc2:	89 e5                	mov    %esp,%ebp
	puts (0, 0, VGA_CLR_RED, m);
    8bc4:	ff 75 08             	pushl  0x8(%ebp)
    8bc7:	6a 04                	push   $0x4
    8bc9:	6a 00                	push   $0x0
    8bcb:	6a 00                	push   $0x0
    8bcd:	e8 6f ff ff ff       	call   8b41 <puts>
    8bd2:	83 c4 10             	add    $0x10,%esp
	while (1)
	{
		asm volatile("hlt");
    8bd5:	f4                   	hlt    
    8bd6:	eb fd                	jmp    8bd5 <panic+0x14>

00008bd8 <strlen>:
 * string
 */

int
strlen (const char *s)
{
    8bd8:	55                   	push   %ebp
	int n;

	for (n = 0; *s != '\0'; s++)
    8bd9:	31 c0                	xor    %eax,%eax
 * string
 */

int
strlen (const char *s)
{
    8bdb:	89 e5                	mov    %esp,%ebp
    8bdd:	8b 55 08             	mov    0x8(%ebp),%edx
	int n;

	for (n = 0; *s != '\0'; s++)
    8be0:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    8be4:	74 03                	je     8be9 <strlen+0x11>
		n++;
    8be6:	40                   	inc    %eax
    8be7:	eb f7                	jmp    8be0 <strlen+0x8>
	return n;
}
    8be9:	5d                   	pop    %ebp
    8bea:	c3                   	ret    

00008beb <reverse>:

/* reverse:  reverse string s in place */
void
reverse (char s[])
{
    8beb:	55                   	push   %ebp
    8bec:	89 e5                	mov    %esp,%ebp
    8bee:	56                   	push   %esi
    8bef:	53                   	push   %ebx
    8bf0:	8b 5d 08             	mov    0x8(%ebp),%ebx
	int i, j;
	char c;

	for (i = 0, j = strlen (s) - 1; i < j; i++, j--)
    8bf3:	53                   	push   %ebx
    8bf4:	e8 df ff ff ff       	call   8bd8 <strlen>
    8bf9:	5a                   	pop    %edx
    8bfa:	31 d2                	xor    %edx,%edx
    8bfc:	48                   	dec    %eax
    8bfd:	39 c2                	cmp    %eax,%edx
    8bff:	7d 13                	jge    8c14 <reverse+0x29>
	{
		c = s[i];
    8c01:	0f b6 34 13          	movzbl (%ebx,%edx,1),%esi
		s[i] = s[j];
    8c05:	8a 0c 03             	mov    (%ebx,%eax,1),%cl
    8c08:	88 0c 13             	mov    %cl,(%ebx,%edx,1)
		s[j] = c;
    8c0b:	89 f1                	mov    %esi,%ecx
reverse (char s[])
{
	int i, j;
	char c;

	for (i = 0, j = strlen (s) - 1; i < j; i++, j--)
    8c0d:	42                   	inc    %edx
	{
		c = s[i];
		s[i] = s[j];
		s[j] = c;
    8c0e:	88 0c 03             	mov    %cl,(%ebx,%eax,1)
reverse (char s[])
{
	int i, j;
	char c;

	for (i = 0, j = strlen (s) - 1; i < j; i++, j--)
    8c11:	48                   	dec    %eax
    8c12:	eb e9                	jmp    8bfd <reverse+0x12>
	{
		c = s[i];
		s[i] = s[j];
		s[j] = c;
	}
}
    8c14:	8d 65 f8             	lea    -0x8(%ebp),%esp
    8c17:	5b                   	pop    %ebx
    8c18:	5e                   	pop    %esi
    8c19:	5d                   	pop    %ebp
    8c1a:	c3                   	ret    

00008c1b <itox>:

/* itoa:  convert n to characters in s */
void
itox (int n, char s[], int root, char * table)
{
    8c1b:	55                   	push   %ebp
    8c1c:	89 e5                	mov    %esp,%ebp
    8c1e:	57                   	push   %edi
    8c1f:	56                   	push   %esi
    8c20:	31 f6                	xor    %esi,%esi
    8c22:	53                   	push   %ebx
    8c23:	83 ec 08             	sub    $0x8,%esp
    8c26:	8b 45 08             	mov    0x8(%ebp),%eax
    8c29:	8b 7d 10             	mov    0x10(%ebp),%edi
    8c2c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    8c2f:	89 c2                	mov    %eax,%edx
    8c31:	89 7d ec             	mov    %edi,-0x14(%ebp)
    8c34:	8b 7d 14             	mov    0x14(%ebp),%edi
    8c37:	c1 fa 1f             	sar    $0x1f,%edx
    8c3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    8c3d:	31 d0                	xor    %edx,%eax
    8c3f:	29 d0                	sub    %edx,%eax
	if ((sign = n) < 0) /* record sign */
		n = -n; /* make n positive */
	i = 0;
	do
	{ /* generate digits in reverse order */
		s[i++] = table[n % root]; /* get next digit */
    8c41:	99                   	cltd   
    8c42:	f7 7d ec             	idivl  -0x14(%ebp)
    8c45:	8d 4e 01             	lea    0x1(%esi),%ecx
    8c48:	8a 14 17             	mov    (%edi,%edx,1),%dl
	} while ((n /= root) > 0); /* delete it */
    8c4b:	85 c0                	test   %eax,%eax
	if ((sign = n) < 0) /* record sign */
		n = -n; /* make n positive */
	i = 0;
	do
	{ /* generate digits in reverse order */
		s[i++] = table[n % root]; /* get next digit */
    8c4d:	88 54 0b ff          	mov    %dl,-0x1(%ebx,%ecx,1)
	} while ((n /= root) > 0); /* delete it */
    8c51:	7e 04                	jle    8c57 <itox+0x3c>
	if ((sign = n) < 0) /* record sign */
		n = -n; /* make n positive */
	i = 0;
	do
	{ /* generate digits in reverse order */
		s[i++] = table[n % root]; /* get next digit */
    8c53:	89 ce                	mov    %ecx,%esi
    8c55:	eb ea                	jmp    8c41 <itox+0x26>
	} while ((n /= root) > 0); /* delete it */
	if (sign < 0)
    8c57:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
	if ((sign = n) < 0) /* record sign */
		n = -n; /* make n positive */
	i = 0;
	do
	{ /* generate digits in reverse order */
		s[i++] = table[n % root]; /* get next digit */
    8c5b:	89 c8                	mov    %ecx,%eax
	} while ((n /= root) > 0); /* delete it */
	if (sign < 0)
    8c5d:	79 07                	jns    8c66 <itox+0x4b>
		s[i++] = '-';
    8c5f:	8d 4e 02             	lea    0x2(%esi),%ecx
    8c62:	c6 04 03 2d          	movb   $0x2d,(%ebx,%eax,1)
	s[i] = '\0';
    8c66:	c6 04 0b 00          	movb   $0x0,(%ebx,%ecx,1)
	reverse (s);
    8c6a:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
    8c6d:	58                   	pop    %eax
    8c6e:	5a                   	pop    %edx
    8c6f:	5b                   	pop    %ebx
    8c70:	5e                   	pop    %esi
    8c71:	5f                   	pop    %edi
    8c72:	5d                   	pop    %ebp
		s[i++] = table[n % root]; /* get next digit */
	} while ((n /= root) > 0); /* delete it */
	if (sign < 0)
		s[i++] = '-';
	s[i] = '\0';
	reverse (s);
    8c73:	e9 73 ff ff ff       	jmp    8beb <reverse>

00008c78 <itoa>:
}

void
itoa (int n, char s[])
{
    8c78:	55                   	push   %ebp
    8c79:	89 e5                	mov    %esp,%ebp
	static char dec[] = "0123456789";
	itox(n, s, 10, dec);
    8c7b:	68 70 92 00 00       	push   $0x9270
    8c80:	6a 0a                	push   $0xa
    8c82:	ff 75 0c             	pushl  0xc(%ebp)
    8c85:	ff 75 08             	pushl  0x8(%ebp)
    8c88:	e8 8e ff ff ff       	call   8c1b <itox>
    8c8d:	83 c4 10             	add    $0x10,%esp
}
    8c90:	c9                   	leave  
    8c91:	c3                   	ret    

00008c92 <itoh>:


void
itoh (int n, char* s)
{
    8c92:	55                   	push   %ebp
    8c93:	89 e5                	mov    %esp,%ebp
	static char hex[] = "0123456789abcdef";
	itox(n, s, 16, hex);
    8c95:	68 5c 92 00 00       	push   $0x925c
    8c9a:	6a 10                	push   $0x10
    8c9c:	ff 75 0c             	pushl  0xc(%ebp)
    8c9f:	ff 75 08             	pushl  0x8(%ebp)
    8ca2:	e8 74 ff ff ff       	call   8c1b <itox>
    8ca7:	83 c4 10             	add    $0x10,%esp
}
    8caa:	c9                   	leave  
    8cab:	c3                   	ret    

00008cac <puti>:

static char puti_str[40];

void
puti (int32_t i)
{
    8cac:	55                   	push   %ebp
    8cad:	89 e5                	mov    %esp,%ebp
	itoh (i, puti_str);
    8caf:	68 e4 92 00 00       	push   $0x92e4
    8cb4:	ff 75 08             	pushl  0x8(%ebp)
    8cb7:	e8 d6 ff ff ff       	call   8c92 <itoh>
	putline (puti_str);
    8cbc:	58                   	pop    %eax
    8cbd:	c7 45 08 e4 92 00 00 	movl   $0x92e4,0x8(%ebp)
    8cc4:	5a                   	pop    %edx
}
    8cc5:	c9                   	leave  

void
puti (int32_t i)
{
	itoh (i, puti_str);
	putline (puti_str);
    8cc6:	e9 aa fe ff ff       	jmp    8b75 <putline>

00008ccb <readsector>:
		/* do nothing */;
}

void
readsector (void *dst, uint32_t offset)
{
    8ccb:	55                   	push   %ebp

static inline uint8_t
inb(int port)
{
	uint8_t data;
	__asm __volatile("inb %w1,%0" : "=a" (data) : "d" (port));
    8ccc:	ba f7 01 00 00       	mov    $0x1f7,%edx
    8cd1:	89 e5                	mov    %esp,%ebp
    8cd3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    8cd6:	57                   	push   %edi
    8cd7:	ec                   	in     (%dx),%al
 */
static void
waitdisk (void)
{
	// wait for disk reaady
	while ((inb (0x1F7) & 0xC0) != 0x40)
    8cd8:	83 e0 c0             	and    $0xffffffc0,%eax
    8cdb:	3c 40                	cmp    $0x40,%al
    8cdd:	75 f8                	jne    8cd7 <readsector+0xc>
 * x86 instructions
 */
static inline void
outb(int port, uint8_t data)
{
	__asm __volatile("outb %0,%w1" : : "a" (data), "d" (port));
    8cdf:	ba f2 01 00 00       	mov    $0x1f2,%edx
    8ce4:	b0 01                	mov    $0x1,%al
    8ce6:	ee                   	out    %al,(%dx)
    8ce7:	0f b6 c1             	movzbl %cl,%eax
    8cea:	b2 f3                	mov    $0xf3,%dl
    8cec:	ee                   	out    %al,(%dx)
    8ced:	0f b6 c5             	movzbl %ch,%eax
    8cf0:	b2 f4                	mov    $0xf4,%dl
    8cf2:	ee                   	out    %al,(%dx)
	waitdisk ();

	outb (0x1F2, 1);		// count = 1
	outb (0x1F3, offset);
	outb (0x1F4, offset >> 8);
	outb (0x1F5, offset >> 16);
    8cf3:	89 c8                	mov    %ecx,%eax
    8cf5:	b2 f5                	mov    $0xf5,%dl
    8cf7:	c1 e8 10             	shr    $0x10,%eax
    8cfa:	0f b6 c0             	movzbl %al,%eax
    8cfd:	ee                   	out    %al,(%dx)
	outb (0x1F6, (offset >> 24) | 0xE0);
    8cfe:	c1 e9 18             	shr    $0x18,%ecx
    8d01:	b2 f6                	mov    $0xf6,%dl
    8d03:	88 c8                	mov    %cl,%al
    8d05:	83 c8 e0             	or     $0xffffffe0,%eax
    8d08:	ee                   	out    %al,(%dx)
    8d09:	b0 20                	mov    $0x20,%al
    8d0b:	b2 f7                	mov    $0xf7,%dl
    8d0d:	ee                   	out    %al,(%dx)

static inline uint8_t
inb(int port)
{
	uint8_t data;
	__asm __volatile("inb %w1,%0" : "=a" (data) : "d" (port));
    8d0e:	ec                   	in     (%dx),%al
 */
static void
waitdisk (void)
{
	// wait for disk reaady
	while ((inb (0x1F7) & 0xC0) != 0x40)
    8d0f:	83 e0 c0             	and    $0xffffffc0,%eax
    8d12:	3c 40                	cmp    $0x40,%al
    8d14:	75 f8                	jne    8d0e <readsector+0x43>
}

static inline void
insl(int port, void *addr, int cnt)
{
	__asm __volatile("cld\n\trepne\n\tinsl"			:
    8d16:	8b 7d 08             	mov    0x8(%ebp),%edi
    8d19:	b9 80 00 00 00       	mov    $0x80,%ecx
    8d1e:	ba f0 01 00 00       	mov    $0x1f0,%edx
    8d23:	fc                   	cld    
    8d24:	f2 6d                	repnz insl (%dx),%es:(%edi)
	// wait for disk to be ready
	waitdisk ();

	// read a sector
	insl (0x1F0, dst, SECTOR_SIZE / 4);
}
    8d26:	5f                   	pop    %edi
    8d27:	5d                   	pop    %ebp
    8d28:	c3                   	ret    

00008d29 <readsection>:

// Read 'count' bytes at 'offset' from kernel into virtual address 'va'.
// Might copy more than asked
void
readsection (uint32_t va, uint32_t count, uint32_t offset, uint32_t lba)
{
    8d29:	55                   	push   %ebp
    8d2a:	89 e5                	mov    %esp,%ebp
    8d2c:	57                   	push   %edi
    8d2d:	56                   	push   %esi
    8d2e:	8b 75 08             	mov    0x8(%ebp),%esi
    8d31:	53                   	push   %ebx
    8d32:	8b 5d 10             	mov    0x10(%ebp),%ebx
	uint32_t end_va;

	va &= 0xFFFFFF;
    8d35:	89 f7                	mov    %esi,%edi
	end_va = va + count;
	// round down to sector boundary
	va &= ~(SECTOR_SIZE - 1);
    8d37:	81 e6 00 fe ff 00    	and    $0xfffe00,%esi
void
readsection (uint32_t va, uint32_t count, uint32_t offset, uint32_t lba)
{
	uint32_t end_va;

	va &= 0xFFFFFF;
    8d3d:	81 e7 ff ff ff 00    	and    $0xffffff,%edi
	end_va = va + count;
	// round down to sector boundary
	va &= ~(SECTOR_SIZE - 1);

	// translate from bytes to sectors, and kernel starts at sector 1
	offset = (offset / SECTOR_SIZE) + lba;
    8d43:	c1 eb 09             	shr    $0x9,%ebx
readsection (uint32_t va, uint32_t count, uint32_t offset, uint32_t lba)
{
	uint32_t end_va;

	va &= 0xFFFFFF;
	end_va = va + count;
    8d46:	03 7d 0c             	add    0xc(%ebp),%edi
	// round down to sector boundary
	va &= ~(SECTOR_SIZE - 1);

	// translate from bytes to sectors, and kernel starts at sector 1
	offset = (offset / SECTOR_SIZE) + lba;
    8d49:	03 5d 14             	add    0x14(%ebp),%ebx

	// If this is too slow, we could read lots of sectors at a time.
	// We'd write more to memory than asked, but it doesn't matter --
	// we load in increasing order.
	while (va < end_va)
    8d4c:	39 fe                	cmp    %edi,%esi
    8d4e:	73 12                	jae    8d62 <readsection+0x39>
	{
		readsector ((uint8_t*) va, offset);
    8d50:	53                   	push   %ebx
		va += SECTOR_SIZE;
		offset++;
    8d51:	43                   	inc    %ebx
	// If this is too slow, we could read lots of sectors at a time.
	// We'd write more to memory than asked, but it doesn't matter --
	// we load in increasing order.
	while (va < end_va)
	{
		readsector ((uint8_t*) va, offset);
    8d52:	56                   	push   %esi
		va += SECTOR_SIZE;
    8d53:	81 c6 00 02 00 00    	add    $0x200,%esi
	// If this is too slow, we could read lots of sectors at a time.
	// We'd write more to memory than asked, but it doesn't matter --
	// we load in increasing order.
	while (va < end_va)
	{
		readsector ((uint8_t*) va, offset);
    8d59:	e8 6d ff ff ff       	call   8ccb <readsector>
		va += SECTOR_SIZE;
		offset++;
    8d5e:	58                   	pop    %eax
    8d5f:	5a                   	pop    %edx
    8d60:	eb ea                	jmp    8d4c <readsection+0x23>
	}
}
    8d62:	8d 65 f4             	lea    -0xc(%ebp),%esp
    8d65:	5b                   	pop    %ebx
    8d66:	5e                   	pop    %esi
    8d67:	5f                   	pop    %edi
    8d68:	5d                   	pop    %ebp
    8d69:	c3                   	ret    

00008d6a <load_kernel>:

#define ELFHDR		((elfhdr *) 0x20000)

uint32_t
load_kernel(uint32_t dkernel)
{
    8d6a:	55                   	push   %ebp
    8d6b:	89 e5                	mov    %esp,%ebp
    8d6d:	57                   	push   %edi
    8d6e:	56                   	push   %esi
    8d6f:	53                   	push   %ebx
    8d70:	83 ec 0c             	sub    $0xc,%esp
    8d73:	8b 75 08             	mov    0x8(%ebp),%esi
	// load kernel from the beginning of the first bootable partition
	proghdr *ph, *eph;

	readsection((uint32_t) ELFHDR, SECTOR_SIZE * 8, 0, dkernel);
    8d76:	56                   	push   %esi
    8d77:	6a 00                	push   $0x0
    8d79:	68 00 10 00 00       	push   $0x1000
    8d7e:	68 00 00 02 00       	push   $0x20000
    8d83:	e8 a1 ff ff ff       	call   8d29 <readsection>

	// is this a valid ELF?
	if (ELFHDR->e_magic != ELF_MAGIC)
    8d88:	83 c4 10             	add    $0x10,%esp
    8d8b:	81 3d 00 00 02 00 7f 	cmpl   $0x464c457f,0x20000
    8d92:	45 4c 46 
    8d95:	74 10                	je     8da7 <load_kernel+0x3d>
		panic ("Kernel is not a valid elf.");
    8d97:	83 ec 0c             	sub    $0xc,%esp
    8d9a:	68 52 8f 00 00       	push   $0x8f52
    8d9f:	e8 1d fe ff ff       	call   8bc1 <panic>
    8da4:	83 c4 10             	add    $0x10,%esp

	// load each program segment (ignores ph flags)
	ph = (proghdr *) ((uint8_t *) ELFHDR + ELFHDR->e_phoff);
    8da7:	a1 1c 00 02 00       	mov    0x2001c,%eax
    8dac:	8d 98 00 00 02 00    	lea    0x20000(%eax),%ebx
	eph = ph + ELFHDR->e_phnum;
    8db2:	0f b7 05 2c 00 02 00 	movzwl 0x2002c,%eax
    8db9:	c1 e0 05             	shl    $0x5,%eax
    8dbc:	8d 3c 03             	lea    (%ebx,%eax,1),%edi

	for (; ph < eph; ph++)
    8dbf:	39 fb                	cmp    %edi,%ebx
    8dc1:	73 17                	jae    8dda <load_kernel+0x70>
	{
		readsection(ph->p_va, ph->p_memsz, ph->p_offset, dkernel);
    8dc3:	56                   	push   %esi

	// load each program segment (ignores ph flags)
	ph = (proghdr *) ((uint8_t *) ELFHDR + ELFHDR->e_phoff);
	eph = ph + ELFHDR->e_phnum;

	for (; ph < eph; ph++)
    8dc4:	83 c3 20             	add    $0x20,%ebx
	{
		readsection(ph->p_va, ph->p_memsz, ph->p_offset, dkernel);
    8dc7:	ff 73 e4             	pushl  -0x1c(%ebx)
    8dca:	ff 73 f4             	pushl  -0xc(%ebx)
    8dcd:	ff 73 e8             	pushl  -0x18(%ebx)
    8dd0:	e8 54 ff ff ff       	call   8d29 <readsection>

	// load each program segment (ignores ph flags)
	ph = (proghdr *) ((uint8_t *) ELFHDR + ELFHDR->e_phoff);
	eph = ph + ELFHDR->e_phnum;

	for (; ph < eph; ph++)
    8dd5:	83 c4 10             	add    $0x10,%esp
    8dd8:	eb e5                	jmp    8dbf <load_kernel+0x55>
	{
		readsection(ph->p_va, ph->p_memsz, ph->p_offset, dkernel);
	}

	return (ELFHDR->e_entry & 0xFFFFFF);
    8dda:	a1 18 00 02 00       	mov    0x20018,%eax
}
    8ddf:	8d 65 f4             	lea    -0xc(%ebp),%esp
    8de2:	5b                   	pop    %ebx
    8de3:	5e                   	pop    %esi
    8de4:	5f                   	pop    %edi
	for (; ph < eph; ph++)
	{
		readsection(ph->p_va, ph->p_memsz, ph->p_offset, dkernel);
	}

	return (ELFHDR->e_entry & 0xFFFFFF);
    8de5:	25 ff ff ff 00       	and    $0xffffff,%eax
}
    8dea:	5d                   	pop    %ebp
    8deb:	c3                   	ret    

00008dec <parse_e820>:

mboot_info_t *
parse_e820 (bios_smap_t *smap)
{
    8dec:	55                   	push   %ebp
    8ded:	89 e5                	mov    %esp,%ebp
    8def:	56                   	push   %esi
    8df0:	8b 75 08             	mov    0x8(%ebp),%esi
    8df3:	53                   	push   %ebx
	bios_smap_t *p;
	uint32_t mmap_len;
	p = smap;
	mmap_len = 0;
	putline ("* E820 Memory Map *");
    8df4:	83 ec 0c             	sub    $0xc,%esp
    8df7:	68 6d 8f 00 00       	push   $0x8f6d
    8dfc:	e8 74 fd ff ff       	call   8b75 <putline>
mboot_info_t *
parse_e820 (bios_smap_t *smap)
{
	bios_smap_t *p;
	uint32_t mmap_len;
	p = smap;
    8e01:	89 f3                	mov    %esi,%ebx
	mmap_len = 0;
	putline ("* E820 Memory Map *");
	while (p->base_addr != 0 || p->length != 0 || p->type != 0)
    8e03:	83 c4 10             	add    $0x10,%esp
    8e06:	8b 43 04             	mov    0x4(%ebx),%eax
    8e09:	89 da                	mov    %ebx,%edx
    8e0b:	29 f2                	sub    %esi,%edx
    8e0d:	89 c1                	mov    %eax,%ecx
    8e0f:	0b 4b 08             	or     0x8(%ebx),%ecx
    8e12:	74 11                	je     8e25 <parse_e820+0x39>
	{
		puti (p->base_addr);
    8e14:	83 ec 0c             	sub    $0xc,%esp
		p ++;
    8e17:	83 c3 18             	add    $0x18,%ebx
	p = smap;
	mmap_len = 0;
	putline ("* E820 Memory Map *");
	while (p->base_addr != 0 || p->length != 0 || p->type != 0)
	{
		puti (p->base_addr);
    8e1a:	50                   	push   %eax
    8e1b:	e8 8c fe ff ff       	call   8cac <puti>
		p ++;
    8e20:	83 c4 10             	add    $0x10,%esp
    8e23:	eb e1                	jmp    8e06 <parse_e820+0x1a>
	bios_smap_t *p;
	uint32_t mmap_len;
	p = smap;
	mmap_len = 0;
	putline ("* E820 Memory Map *");
	while (p->base_addr != 0 || p->length != 0 || p->type != 0)
    8e25:	8b 4b 10             	mov    0x10(%ebx),%ecx
    8e28:	0b 4b 0c             	or     0xc(%ebx),%ecx
    8e2b:	75 e7                	jne    8e14 <parse_e820+0x28>
    8e2d:	83 7b 14 00          	cmpl   $0x0,0x14(%ebx)
    8e31:	75 e1                	jne    8e14 <parse_e820+0x28>
		puti (p->base_addr);
		p ++;
		mmap_len += sizeof(bios_smap_t);
	}
	mboot_info.mmap_length = mmap_len;
	mboot_info.mmap_addr = (uint32_t) smap;
    8e33:	89 35 b4 92 00 00    	mov    %esi,0x92b4
	return &mboot_info;
}
    8e39:	b8 84 92 00 00       	mov    $0x9284,%eax
	{
		puti (p->base_addr);
		p ++;
		mmap_len += sizeof(bios_smap_t);
	}
	mboot_info.mmap_length = mmap_len;
    8e3e:	89 15 b0 92 00 00    	mov    %edx,0x92b0
	mboot_info.mmap_addr = (uint32_t) smap;
	return &mboot_info;
}
    8e44:	8d 65 f8             	lea    -0x8(%ebp),%esp
    8e47:	5b                   	pop    %ebx
    8e48:	5e                   	pop    %esi
    8e49:	5d                   	pop    %ebp
    8e4a:	c3                   	ret    

00008e4b <boot1main>:
mboot_info_t mboot_info =
	{ .flags = (1 << 6), };

void
boot1main (uint32_t dev, mbr_t * mbr, bios_smap_t *smap)
{
    8e4b:	55                   	push   %ebp
    8e4c:	89 e5                	mov    %esp,%ebp
    8e4e:	56                   	push   %esi
    8e4f:	8b 75 0c             	mov    0xc(%ebp),%esi
    8e52:	53                   	push   %ebx
    8e53:	8b 5d 10             	mov    0x10(%ebp),%ebx
	roll(3); putline("Start boot1 main ...");
    8e56:	83 ec 0c             	sub    $0xc,%esp
    8e59:	6a 03                	push   $0x3
    8e5b:	e8 54 fd ff ff       	call   8bb4 <roll>
    8e60:	c7 04 24 81 8f 00 00 	movl   $0x8f81,(%esp)
    8e67:	e8 09 fd ff ff       	call   8b75 <putline>
    8e6c:	83 c4 10             	add    $0x10,%esp

	// search bootable partition
	int i;
	uint32_t bootable_lba = 0;
	for (i = 0; i < 4; i++)
    8e6f:	31 c0                	xor    %eax,%eax
    8e71:	89 c2                	mov    %eax,%edx
    8e73:	c1 e2 04             	shl    $0x4,%edx
	{
		if ( mbr->partition[i].bootable == BOOTABLE_PARTITION)
    8e76:	80 bc 16 be 01 00 00 	cmpb   $0x80,0x1be(%esi,%edx,1)
    8e7d:	80 
    8e7e:	75 0c                	jne    8e8c <boot1main+0x41>
		{
			bootable_lba = mbr->partition[i].first_lba;
    8e80:	83 c0 1b             	add    $0x1b,%eax
    8e83:	c1 e0 04             	shl    $0x4,%eax
    8e86:	8b 74 06 16          	mov    0x16(%esi,%eax,1),%esi
    8e8a:	eb 18                	jmp    8ea4 <boot1main+0x59>
	roll(3); putline("Start boot1 main ...");

	// search bootable partition
	int i;
	uint32_t bootable_lba = 0;
	for (i = 0; i < 4; i++)
    8e8c:	40                   	inc    %eax
    8e8d:	83 f8 04             	cmp    $0x4,%eax
    8e90:	75 df                	jne    8e71 <boot1main+0x26>
			break;
		}
	}

	if (i == 4)
		panic ("Cannot find bootable partition!");
    8e92:	83 ec 0c             	sub    $0xc,%esp
{
	roll(3); putline("Start boot1 main ...");

	// search bootable partition
	int i;
	uint32_t bootable_lba = 0;
    8e95:	31 f6                	xor    %esi,%esi
			break;
		}
	}

	if (i == 4)
		panic ("Cannot find bootable partition!");
    8e97:	68 ce 8f 00 00       	push   $0x8fce
    8e9c:	e8 20 fd ff ff       	call   8bc1 <panic>
    8ea1:	83 c4 10             	add    $0x10,%esp

	parse_e820 (smap);
    8ea4:	83 ec 0c             	sub    $0xc,%esp
    8ea7:	53                   	push   %ebx
    8ea8:	e8 3f ff ff ff       	call   8dec <parse_e820>

	putline ("Load kernel ...\n");
    8ead:	c7 04 24 96 8f 00 00 	movl   $0x8f96,(%esp)
    8eb4:	e8 bc fc ff ff       	call   8b75 <putline>
	uint32_t entry = load_kernel(bootable_lba);
    8eb9:	89 34 24             	mov    %esi,(%esp)
    8ebc:	e8 a9 fe ff ff       	call   8d6a <load_kernel>

	putline ("Start kernel ...\n");
    8ec1:	c7 04 24 a7 8f 00 00 	movl   $0x8fa7,(%esp)
		panic ("Cannot find bootable partition!");

	parse_e820 (smap);

	putline ("Load kernel ...\n");
	uint32_t entry = load_kernel(bootable_lba);
    8ec8:	89 c3                	mov    %eax,%ebx

	putline ("Start kernel ...\n");
    8eca:	e8 a6 fc ff ff       	call   8b75 <putline>

	exec_kernel (entry, &mboot_info);
    8ecf:	58                   	pop    %eax
    8ed0:	5a                   	pop    %edx
    8ed1:	68 84 92 00 00       	push   $0x9284
    8ed6:	53                   	push   %ebx
    8ed7:	e8 15 00 00 00       	call   8ef1 <exec_kernel>

	panic ("Fail to load kernel.");
    8edc:	83 c4 10             	add    $0x10,%esp
    8edf:	c7 45 08 b9 8f 00 00 	movl   $0x8fb9,0x8(%ebp)

}
    8ee6:	8d 65 f8             	lea    -0x8(%ebp),%esp
    8ee9:	5b                   	pop    %ebx
    8eea:	5e                   	pop    %esi
    8eeb:	5d                   	pop    %ebp

	putline ("Start kernel ...\n");

	exec_kernel (entry, &mboot_info);

	panic ("Fail to load kernel.");
    8eec:	e9 d0 fc ff ff       	jmp    8bc1 <panic>

00008ef1 <exec_kernel>:
	.set  MBOOT_INFO_MAGIC, 0x2badb002

	.globl	exec_kernel
	.code32
exec_kernel:
	cli
    8ef1:	fa                   	cli    
	movl	$MBOOT_INFO_MAGIC, %eax
    8ef2:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
	movl	8(%esp), %ebx
    8ef7:	8b 5c 24 08          	mov    0x8(%esp),%ebx
	movl	4(%esp), %edx
    8efb:	8b 54 24 04          	mov    0x4(%esp),%edx
	jmp	*%edx
    8eff:	ff e2                	jmp    *%edx

Disassembly of section .rodata:

00008f01 <.rodata>:
    8f01:	20 20                	and    %ah,(%eax)
    8f03:	20 20                	and    %ah,(%eax)
    8f05:	20 20                	and    %ah,(%eax)
    8f07:	20 20                	and    %ah,(%eax)
    8f09:	20 20                	and    %ah,(%eax)
    8f0b:	20 20                	and    %ah,(%eax)
    8f0d:	20 20                	and    %ah,(%eax)
    8f0f:	20 20                	and    %ah,(%eax)
    8f11:	20 20                	and    %ah,(%eax)
    8f13:	20 20                	and    %ah,(%eax)
    8f15:	20 20                	and    %ah,(%eax)
    8f17:	20 20                	and    %ah,(%eax)
    8f19:	20 20                	and    %ah,(%eax)
    8f1b:	20 20                	and    %ah,(%eax)
    8f1d:	20 20                	and    %ah,(%eax)
    8f1f:	20 20                	and    %ah,(%eax)
    8f21:	20 20                	and    %ah,(%eax)
    8f23:	20 20                	and    %ah,(%eax)
    8f25:	20 20                	and    %ah,(%eax)
    8f27:	20 20                	and    %ah,(%eax)
    8f29:	20 20                	and    %ah,(%eax)
    8f2b:	20 20                	and    %ah,(%eax)
    8f2d:	20 20                	and    %ah,(%eax)
    8f2f:	20 20                	and    %ah,(%eax)
    8f31:	20 20                	and    %ah,(%eax)
    8f33:	20 20                	and    %ah,(%eax)
    8f35:	20 20                	and    %ah,(%eax)
    8f37:	20 20                	and    %ah,(%eax)
    8f39:	20 20                	and    %ah,(%eax)
    8f3b:	20 20                	and    %ah,(%eax)
    8f3d:	20 20                	and    %ah,(%eax)
    8f3f:	20 20                	and    %ah,(%eax)
    8f41:	20 20                	and    %ah,(%eax)
    8f43:	20 20                	and    %ah,(%eax)
    8f45:	20 20                	and    %ah,(%eax)
    8f47:	20 20                	and    %ah,(%eax)
    8f49:	20 20                	and    %ah,(%eax)
    8f4b:	20 20                	and    %ah,(%eax)
    8f4d:	20 20                	and    %ah,(%eax)
    8f4f:	20 20                	and    %ah,(%eax)
    8f51:	00 4b 65             	add    %cl,0x65(%ebx)
    8f54:	72 6e                	jb     8fc4 <exec_kernel+0xd3>
    8f56:	65 6c                	gs insb (%dx),%es:(%edi)
    8f58:	20 69 73             	and    %ch,0x73(%ecx)
    8f5b:	20 6e 6f             	and    %ch,0x6f(%esi)
    8f5e:	74 20                	je     8f80 <exec_kernel+0x8f>
    8f60:	61                   	popa   
    8f61:	20 76 61             	and    %dh,0x61(%esi)
    8f64:	6c                   	insb   (%dx),%es:(%edi)
    8f65:	69 64 20 65 6c 66 2e 	imul   $0x2e666c,0x65(%eax,%eiz,1),%esp
    8f6c:	00 
    8f6d:	2a 20                	sub    (%eax),%ah
    8f6f:	45                   	inc    %ebp
    8f70:	38 32                	cmp    %dh,(%edx)
    8f72:	30 20                	xor    %ah,(%eax)
    8f74:	4d                   	dec    %ebp
    8f75:	65 6d                	gs insl (%dx),%es:(%edi)
    8f77:	6f                   	outsl  %ds:(%esi),(%dx)
    8f78:	72 79                	jb     8ff3 <exec_kernel+0x102>
    8f7a:	20 4d 61             	and    %cl,0x61(%ebp)
    8f7d:	70 20                	jo     8f9f <exec_kernel+0xae>
    8f7f:	2a 00                	sub    (%eax),%al
    8f81:	53                   	push   %ebx
    8f82:	74 61                	je     8fe5 <exec_kernel+0xf4>
    8f84:	72 74                	jb     8ffa <exec_kernel+0x109>
    8f86:	20 62 6f             	and    %ah,0x6f(%edx)
    8f89:	6f                   	outsl  %ds:(%esi),(%dx)
    8f8a:	74 31                	je     8fbd <exec_kernel+0xcc>
    8f8c:	20 6d 61             	and    %ch,0x61(%ebp)
    8f8f:	69 6e 20 2e 2e 2e 00 	imul   $0x2e2e2e,0x20(%esi),%ebp
    8f96:	4c                   	dec    %esp
    8f97:	6f                   	outsl  %ds:(%esi),(%dx)
    8f98:	61                   	popa   
    8f99:	64 20 6b 65          	and    %ch,%fs:0x65(%ebx)
    8f9d:	72 6e                	jb     900d <exec_kernel+0x11c>
    8f9f:	65 6c                	gs insb (%dx),%es:(%edi)
    8fa1:	20 2e                	and    %ch,(%esi)
    8fa3:	2e 2e 0a 00          	cs or  %cs:(%eax),%al
    8fa7:	53                   	push   %ebx
    8fa8:	74 61                	je     900b <exec_kernel+0x11a>
    8faa:	72 74                	jb     9020 <exec_kernel+0x12f>
    8fac:	20 6b 65             	and    %ch,0x65(%ebx)
    8faf:	72 6e                	jb     901f <exec_kernel+0x12e>
    8fb1:	65 6c                	gs insb (%dx),%es:(%edi)
    8fb3:	20 2e                	and    %ch,(%esi)
    8fb5:	2e 2e 0a 00          	cs or  %cs:(%eax),%al
    8fb9:	46                   	inc    %esi
    8fba:	61                   	popa   
    8fbb:	69 6c 20 74 6f 20 6c 	imul   $0x6f6c206f,0x74(%eax,%eiz,1),%ebp
    8fc2:	6f 
    8fc3:	61                   	popa   
    8fc4:	64 20 6b 65          	and    %ch,%fs:0x65(%ebx)
    8fc8:	72 6e                	jb     9038 <exec_kernel+0x147>
    8fca:	65 6c                	gs insb (%dx),%es:(%edi)
    8fcc:	2e 00 43 61          	add    %al,%cs:0x61(%ebx)
    8fd0:	6e                   	outsb  %ds:(%esi),(%dx)
    8fd1:	6e                   	outsb  %ds:(%esi),(%dx)
    8fd2:	6f                   	outsl  %ds:(%esi),(%dx)
    8fd3:	74 20                	je     8ff5 <exec_kernel+0x104>
    8fd5:	66 69 6e 64 20 62    	imul   $0x6220,0x64(%esi),%bp
    8fdb:	6f                   	outsl  %ds:(%esi),(%dx)
    8fdc:	6f                   	outsl  %ds:(%esi),(%dx)
    8fdd:	74 61                	je     9040 <exec_kernel+0x14f>
    8fdf:	62 6c 65 20          	bound  %ebp,0x20(%ebp,%eiz,2)
    8fe3:	70 61                	jo     9046 <exec_kernel+0x155>
    8fe5:	72 74                	jb     905b <exec_kernel+0x16a>
    8fe7:	69                   	.byte 0x69
    8fe8:	74 69                	je     9053 <exec_kernel+0x162>
    8fea:	6f                   	outsl  %ds:(%esi),(%dx)
    8feb:	6e                   	outsb  %ds:(%esi),(%dx)
    8fec:	21 00                	and    %eax,(%eax)

Disassembly of section .eh_frame:

00008ff0 <.eh_frame>:
    8ff0:	14 00                	adc    $0x0,%al
    8ff2:	00 00                	add    %al,(%eax)
    8ff4:	00 00                	add    %al,(%eax)
    8ff6:	00 00                	add    %al,(%eax)
    8ff8:	01 7a 52             	add    %edi,0x52(%edx)
    8ffb:	00 01                	add    %al,(%ecx)
    8ffd:	7c 08                	jl     9007 <exec_kernel+0x116>
    8fff:	01 1b                	add    %ebx,(%ebx)
    9001:	0c 04                	or     $0x4,%al
    9003:	04 88                	add    $0x88,%al
    9005:	01 00                	add    %eax,(%eax)
    9007:	00 1c 00             	add    %bl,(%eax,%eax,1)
    900a:	00 00                	add    %al,(%eax)
    900c:	1c 00                	sbb    $0x0,%al
    900e:	00 00                	add    %al,(%eax)
    9010:	16                   	push   %ss
    9011:	fb                   	sti    
    9012:	ff                   	(bad)  
    9013:	ff 1b                	lcall  *(%ebx)
    9015:	00 00                	add    %al,(%eax)
    9017:	00 00                	add    %al,(%eax)
    9019:	41                   	inc    %ecx
    901a:	0e                   	push   %cs
    901b:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9021:	57                   	push   %edi
    9022:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    9025:	04 00                	add    $0x0,%al
    9027:	00 24 00             	add    %ah,(%eax,%eax,1)
    902a:	00 00                	add    %al,(%eax)
    902c:	3c 00                	cmp    $0x0,%al
    902e:	00 00                	add    %al,(%eax)
    9030:	11 fb                	adc    %edi,%ebx
    9032:	ff                   	(bad)  
    9033:	ff 34 00             	pushl  (%eax,%eax,1)
    9036:	00 00                	add    %al,(%eax)
    9038:	00 41 0e             	add    %al,0xe(%ecx)
    903b:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9041:	42                   	inc    %edx
    9042:	86 03                	xchg   %al,(%ebx)
    9044:	83 04 6c c3          	addl   $0xffffffc3,(%esp,%ebp,2)
    9048:	41                   	inc    %ecx
    9049:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
    904d:	04 04                	add    $0x4,%al
    904f:	00 20                	add    %ah,(%eax)
    9051:	00 00                	add    %al,(%eax)
    9053:	00 64 00 00          	add    %ah,0x0(%eax,%eax,1)
    9057:	00 1d fb ff ff 3f    	add    %bl,0x3ffffffb
    905d:	00 00                	add    %al,(%eax)
    905f:	00 00                	add    %al,(%eax)
    9061:	41                   	inc    %ecx
    9062:	0e                   	push   %cs
    9063:	08 85 02 47 0d 05    	or     %al,0x50d4702(%ebp)
    9069:	41                   	inc    %ecx
    906a:	83 03 75             	addl   $0x75,(%ebx)
    906d:	c5 c3 0c             	(bad)  
    9070:	04 04                	add    $0x4,%al
    9072:	00 00                	add    %al,(%eax)
    9074:	1c 00                	sbb    $0x0,%al
    9076:	00 00                	add    %al,(%eax)
    9078:	88 00                	mov    %al,(%eax)
    907a:	00 00                	add    %al,(%eax)
    907c:	38 fb                	cmp    %bh,%bl
    907e:	ff                   	(bad)  
    907f:	ff 0d 00 00 00 00    	decl   0x0
    9085:	41                   	inc    %ecx
    9086:	0e                   	push   %cs
    9087:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    908d:	44                   	inc    %esp
    908e:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    9091:	04 00                	add    $0x0,%al
    9093:	00 18                	add    %bl,(%eax)
    9095:	00 00                	add    %al,(%eax)
    9097:	00 a8 00 00 00 25    	add    %ch,0x25000000(%eax)
    909d:	fb                   	sti    
    909e:	ff                   	(bad)  
    909f:	ff 17                	call   *(%edi)
    90a1:	00 00                	add    %al,(%eax)
    90a3:	00 00                	add    %al,(%eax)
    90a5:	41                   	inc    %ecx
    90a6:	0e                   	push   %cs
    90a7:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    90ad:	00 00                	add    %al,(%eax)
    90af:	00 1c 00             	add    %bl,(%eax,%eax,1)
    90b2:	00 00                	add    %al,(%eax)
    90b4:	c4 00                	les    (%eax),%eax
    90b6:	00 00                	add    %al,(%eax)
    90b8:	20 fb                	and    %bh,%bl
    90ba:	ff                   	(bad)  
    90bb:	ff 13                	call   *(%ebx)
    90bd:	00 00                	add    %al,(%eax)
    90bf:	00 00                	add    %al,(%eax)
    90c1:	41                   	inc    %ecx
    90c2:	0e                   	push   %cs
    90c3:	08 85 02 44 0d 05    	or     %al,0x50d4402(%ebp)
    90c9:	4d                   	dec    %ebp
    90ca:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    90cd:	04 00                	add    $0x0,%al
    90cf:	00 24 00             	add    %ah,(%eax,%eax,1)
    90d2:	00 00                	add    %al,(%eax)
    90d4:	e4 00                	in     $0x0,%al
    90d6:	00 00                	add    %al,(%eax)
    90d8:	13 fb                	adc    %ebx,%edi
    90da:	ff                   	(bad)  
    90db:	ff 30                	pushl  (%eax)
    90dd:	00 00                	add    %al,(%eax)
    90df:	00 00                	add    %al,(%eax)
    90e1:	41                   	inc    %ecx
    90e2:	0e                   	push   %cs
    90e3:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    90e9:	42                   	inc    %edx
    90ea:	86 03                	xchg   %al,(%ebx)
    90ec:	83 04 68 c3          	addl   $0xffffffc3,(%eax,%ebp,2)
    90f0:	41                   	inc    %ecx
    90f1:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
    90f5:	04 04                	add    $0x4,%al
    90f7:	00 2c 00             	add    %ch,(%eax,%eax,1)
    90fa:	00 00                	add    %al,(%eax)
    90fc:	0c 01                	or     $0x1,%al
    90fe:	00 00                	add    %al,(%eax)
    9100:	1b fb                	sbb    %ebx,%edi
    9102:	ff                   	(bad)  
    9103:	ff 5d 00             	lcall  *0x0(%ebp)
    9106:	00 00                	add    %al,(%eax)
    9108:	00 41 0e             	add    %al,0xe(%ecx)
    910b:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9111:	42                   	inc    %edx
    9112:	87 03                	xchg   %eax,(%ebx)
    9114:	86 04 46             	xchg   %al,(%esi,%eax,2)
    9117:	83 05 02 4a c3 41 c6 	addl   $0xffffffc6,0x41c34a02
    911e:	41                   	inc    %ecx
    911f:	c7 41 c5 0c 04 04 00 	movl   $0x4040c,-0x3b(%ecx)
    9126:	00 00                	add    %al,(%eax)
    9128:	1c 00                	sbb    $0x0,%al
    912a:	00 00                	add    %al,(%eax)
    912c:	3c 01                	cmp    $0x1,%al
    912e:	00 00                	add    %al,(%eax)
    9130:	48                   	dec    %eax
    9131:	fb                   	sti    
    9132:	ff                   	(bad)  
    9133:	ff 1a                	lcall  *(%edx)
    9135:	00 00                	add    %al,(%eax)
    9137:	00 00                	add    %al,(%eax)
    9139:	41                   	inc    %ecx
    913a:	0e                   	push   %cs
    913b:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9141:	56                   	push   %esi
    9142:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    9145:	04 00                	add    $0x0,%al
    9147:	00 1c 00             	add    %bl,(%eax,%eax,1)
    914a:	00 00                	add    %al,(%eax)
    914c:	5c                   	pop    %esp
    914d:	01 00                	add    %eax,(%eax)
    914f:	00 42 fb             	add    %al,-0x5(%edx)
    9152:	ff                   	(bad)  
    9153:	ff 1a                	lcall  *(%edx)
    9155:	00 00                	add    %al,(%eax)
    9157:	00 00                	add    %al,(%eax)
    9159:	41                   	inc    %ecx
    915a:	0e                   	push   %cs
    915b:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9161:	56                   	push   %esi
    9162:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    9165:	04 00                	add    $0x0,%al
    9167:	00 1c 00             	add    %bl,(%eax,%eax,1)
    916a:	00 00                	add    %al,(%eax)
    916c:	7c 01                	jl     916f <exec_kernel+0x27e>
    916e:	00 00                	add    %al,(%eax)
    9170:	3c fb                	cmp    $0xfb,%al
    9172:	ff                   	(bad)  
    9173:	ff 1f                	lcall  *(%edi)
    9175:	00 00                	add    %al,(%eax)
    9177:	00 00                	add    %al,(%eax)
    9179:	41                   	inc    %ecx
    917a:	0e                   	push   %cs
    917b:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9181:	57                   	push   %edi
    9182:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    9185:	04 00                	add    $0x0,%al
    9187:	00 20                	add    %ah,(%eax)
    9189:	00 00                	add    %al,(%eax)
    918b:	00 9c 01 00 00 3b fb 	add    %bl,-0x4c50000(%ecx,%eax,1)
    9192:	ff                   	(bad)  
    9193:	ff 5e 00             	lcall  *0x0(%esi)
    9196:	00 00                	add    %al,(%eax)
    9198:	00 41 0e             	add    %al,0xe(%ecx)
    919b:	08 85 02 47 0d 05    	or     %al,0x50d4702(%ebp)
    91a1:	44                   	inc    %esp
    91a2:	87 03                	xchg   %eax,(%ebx)
    91a4:	02 50 c7             	add    -0x39(%eax),%dl
    91a7:	41                   	inc    %ecx
    91a8:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    91ab:	04 28                	add    $0x28,%al
    91ad:	00 00                	add    %al,(%eax)
    91af:	00 c0                	add    %al,%al
    91b1:	01 00                	add    %eax,(%eax)
    91b3:	00 75 fb             	add    %dh,-0x5(%ebp)
    91b6:	ff                   	(bad)  
    91b7:	ff 41 00             	incl   0x0(%ecx)
    91ba:	00 00                	add    %al,(%eax)
    91bc:	00 41 0e             	add    %al,0xe(%ecx)
    91bf:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    91c5:	42                   	inc    %edx
    91c6:	87 03                	xchg   %eax,(%ebx)
    91c8:	86 04 44             	xchg   %al,(%esp,%eax,2)
    91cb:	83 05 74 c3 41 c6 41 	addl   $0x41,0xc641c374
    91d2:	c7 41 c5 0c 04 04 28 	movl   $0x2804040c,-0x3b(%ecx)
    91d9:	00 00                	add    %al,(%eax)
    91db:	00 ec                	add    %ch,%ah
    91dd:	01 00                	add    %eax,(%eax)
    91df:	00 8a fb ff ff 82    	add    %cl,-0x7d000005(%edx)
    91e5:	00 00                	add    %al,(%eax)
    91e7:	00 00                	add    %al,(%eax)
    91e9:	41                   	inc    %ecx
    91ea:	0e                   	push   %cs
    91eb:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    91f1:	46                   	inc    %esi
    91f2:	87 03                	xchg   %eax,(%ebx)
    91f4:	86 04 83             	xchg   %al,(%ebx,%eax,4)
    91f7:	05 02 70 c3 41       	add    $0x41c37002,%eax
    91fc:	c6 41 c7 46          	movb   $0x46,-0x39(%ecx)
    9200:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    9203:	04 28                	add    $0x28,%al
    9205:	00 00                	add    %al,(%eax)
    9207:	00 18                	add    %bl,(%eax)
    9209:	02 00                	add    (%eax),%al
    920b:	00 e0                	add    %ah,%al
    920d:	fb                   	sti    
    920e:	ff                   	(bad)  
    920f:	ff 5f 00             	lcall  *0x0(%edi)
    9212:	00 00                	add    %al,(%eax)
    9214:	00 41 0e             	add    %al,0xe(%ecx)
    9217:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    921d:	41                   	inc    %ecx
    921e:	86 03                	xchg   %al,(%ebx)
    9220:	44                   	inc    %esp
    9221:	83 04 02 54          	addl   $0x54,(%edx,%eax,1)
    9225:	c3                   	ret    
    9226:	41                   	inc    %ecx
    9227:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
    922b:	04 04                	add    $0x4,%al
    922d:	00 00                	add    %al,(%eax)
    922f:	00 28                	add    %ch,(%eax)
    9231:	00 00                	add    %al,(%eax)
    9233:	00 44 02 00          	add    %al,0x0(%edx,%eax,1)
    9237:	00 13                	add    %dl,(%ebx)
    9239:	fc                   	cld    
    923a:	ff                   	(bad)  
    923b:	ff a6 00 00 00 00    	jmp    *0x0(%esi)
    9241:	41                   	inc    %ecx
    9242:	0e                   	push   %cs
    9243:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9249:	41                   	inc    %ecx
    924a:	86 03                	xchg   %al,(%ebx)
    924c:	44                   	inc    %esp
    924d:	83 04 02 97          	addl   $0xffffff97,(%edx,%eax,1)
    9251:	c3                   	ret    
    9252:	41                   	inc    %ecx
    9253:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
    9257:	04 04                	add    $0x4,%al
    9259:	00 00                	add    %al,(%eax)
    925b:	00                   	.byte 0x0

Disassembly of section .data:

0000925c <hex.1134>:
    925c:	30 31                	xor    %dh,(%ecx)
    925e:	32 33                	xor    (%ebx),%dh
    9260:	34 35                	xor    $0x35,%al
    9262:	36 37                	ss aaa 
    9264:	38 39                	cmp    %bh,(%ecx)
    9266:	61                   	popa   
    9267:	62 63 64             	bound  %esp,0x64(%ebx)
    926a:	65 66 00 00          	data16 add %al,%gs:(%eax)
    926e:	00 00                	add    %al,(%eax)

00009270 <dec.1129>:
    9270:	30 31                	xor    %dh,(%ecx)
    9272:	32 33                	xor    (%ebx),%dh
    9274:	34 35                	xor    $0x35,%al
    9276:	36 37                	ss aaa 
    9278:	38 39                	cmp    %bh,(%ecx)
    927a:	00 00                	add    %al,(%eax)

0000927c <blank>:
    927c:	01 8f 00 00 00 80    	add    %ecx,-0x80000000(%edi)

00009280 <video>:
    9280:	00 80 0b 00 40 00    	add    %al,0x40000b(%eax)

00009284 <mboot_info>:
    9284:	40                   	inc    %eax
    9285:	00 00                	add    %al,(%eax)
    9287:	00 00                	add    %al,(%eax)
    9289:	00 00                	add    %al,(%eax)
    928b:	00 00                	add    %al,(%eax)
    928d:	00 00                	add    %al,(%eax)
    928f:	00 00                	add    %al,(%eax)
    9291:	00 00                	add    %al,(%eax)
    9293:	00 00                	add    %al,(%eax)
    9295:	00 00                	add    %al,(%eax)
    9297:	00 00                	add    %al,(%eax)
    9299:	00 00                	add    %al,(%eax)
    929b:	00 00                	add    %al,(%eax)
    929d:	00 00                	add    %al,(%eax)
    929f:	00 00                	add    %al,(%eax)
    92a1:	00 00                	add    %al,(%eax)
    92a3:	00 00                	add    %al,(%eax)
    92a5:	00 00                	add    %al,(%eax)
    92a7:	00 00                	add    %al,(%eax)
    92a9:	00 00                	add    %al,(%eax)
    92ab:	00 00                	add    %al,(%eax)
    92ad:	00 00                	add    %al,(%eax)
    92af:	00 00                	add    %al,(%eax)
    92b1:	00 00                	add    %al,(%eax)
    92b3:	00 00                	add    %al,(%eax)
    92b5:	00 00                	add    %al,(%eax)
    92b7:	00 00                	add    %al,(%eax)
    92b9:	00 00                	add    %al,(%eax)
    92bb:	00 00                	add    %al,(%eax)
    92bd:	00 00                	add    %al,(%eax)
    92bf:	00 00                	add    %al,(%eax)
    92c1:	00 00                	add    %al,(%eax)
    92c3:	00 00                	add    %al,(%eax)
    92c5:	00 00                	add    %al,(%eax)
    92c7:	00 00                	add    %al,(%eax)
    92c9:	00 00                	add    %al,(%eax)
    92cb:	00 00                	add    %al,(%eax)
    92cd:	00 00                	add    %al,(%eax)
    92cf:	00 00                	add    %al,(%eax)
    92d1:	00 00                	add    %al,(%eax)
    92d3:	00 00                	add    %al,(%eax)
    92d5:	00 00                	add    %al,(%eax)
    92d7:	00 00                	add    %al,(%eax)
    92d9:	00 00                	add    %al,(%eax)
    92db:	00 00                	add    %al,(%eax)
    92dd:	00 00                	add    %al,(%eax)
    92df:	00 00                	add    %al,(%eax)
    92e1:	00 00                	add    %al,(%eax)
    92e3:	00                   	.byte 0x0

Disassembly of section .bss:

000092e4 <__bss_start>:
    92e4:	00 00                	add    %al,(%eax)
    92e6:	00 00                	add    %al,(%eax)
    92e8:	00 00                	add    %al,(%eax)
    92ea:	00 00                	add    %al,(%eax)
    92ec:	00 00                	add    %al,(%eax)
    92ee:	00 00                	add    %al,(%eax)
    92f0:	00 00                	add    %al,(%eax)
    92f2:	00 00                	add    %al,(%eax)
    92f4:	00 00                	add    %al,(%eax)
    92f6:	00 00                	add    %al,(%eax)
    92f8:	00 00                	add    %al,(%eax)
    92fa:	00 00                	add    %al,(%eax)
    92fc:	00 00                	add    %al,(%eax)
    92fe:	00 00                	add    %al,(%eax)
    9300:	00 00                	add    %al,(%eax)
    9302:	00 00                	add    %al,(%eax)
    9304:	00 00                	add    %al,(%eax)
    9306:	00 00                	add    %al,(%eax)
    9308:	00 00                	add    %al,(%eax)
    930a:	00 00                	add    %al,(%eax)

0000930c <row>:
    930c:	00 00                	add    %al,(%eax)
    930e:	00 00                	add    %al,(%eax)

Disassembly of section .comment:

00000000 <.comment>:
   0:	47                   	inc    %edi
   1:	43                   	inc    %ebx
   2:	43                   	inc    %ebx
   3:	3a 20                	cmp    (%eax),%ah
   5:	28 55 62             	sub    %dl,0x62(%ebp)
   8:	75 6e                	jne    78 <PROT_MODE_DSEG+0x68>
   a:	74 75                	je     81 <PR_BOOTABLE+0x1>
   c:	20 34 2e             	and    %dh,(%esi,%ebp,1)
   f:	38 2e                	cmp    %ch,(%esi)
  11:	35 2d 34 75 62       	xor    $0x6275342d,%eax
  16:	75 6e                	jne    86 <PR_BOOTABLE+0x6>
  18:	74 75                	je     8f <PR_BOOTABLE+0xf>
  1a:	32 29                	xor    (%ecx),%ch
  1c:	20 34 2e             	and    %dh,(%esi,%ebp,1)
  1f:	38 2e                	cmp    %ch,(%esi)
  21:	35                   	.byte 0x35
  22:	00                   	.byte 0x0

Disassembly of section .debug_aranges:

00000000 <.debug_aranges>:
   0:	1c 00                	sbb    $0x0,%al
   2:	00 00                	add    %al,(%eax)
   4:	02 00                	add    (%eax),%al
   6:	00 00                	add    %al,(%eax)
   8:	00 00                	add    %al,(%eax)
   a:	04 00                	add    $0x0,%al
   c:	00 00                	add    %al,(%eax)
   e:	00 00                	add    %al,(%eax)
  10:	00 7e 00             	add    %bh,0x0(%esi)
  13:	00 26                	add    %ah,(%esi)
  15:	0d 00 00 00 00       	or     $0x0,%eax
  1a:	00 00                	add    %al,(%eax)
  1c:	00 00                	add    %al,(%eax)
  1e:	00 00                	add    %al,(%eax)
  20:	1c 00                	sbb    $0x0,%al
  22:	00 00                	add    %al,(%eax)
  24:	02 00                	add    (%eax),%al
  26:	46                   	inc    %esi
  27:	00 00                	add    %al,(%eax)
  29:	00 04 00             	add    %al,(%eax,%eax,1)
  2c:	00 00                	add    %al,(%eax)
  2e:	00 00                	add    %al,(%eax)
  30:	26 8b 00             	mov    %es:(%eax),%eax
  33:	00 44 02 00          	add    %al,0x0(%edx,%eax,1)
  37:	00 00                	add    %al,(%eax)
  39:	00 00                	add    %al,(%eax)
  3b:	00 00                	add    %al,(%eax)
  3d:	00 00                	add    %al,(%eax)
  3f:	00 1c 00             	add    %bl,(%eax,%eax,1)
  42:	00 00                	add    %al,(%eax)
  44:	02 00                	add    (%eax),%al
  46:	ec                   	in     (%dx),%al
  47:	06                   	push   %es
  48:	00 00                	add    %al,(%eax)
  4a:	04 00                	add    $0x0,%al
  4c:	00 00                	add    %al,(%eax)
  4e:	00 00                	add    %al,(%eax)
  50:	6a 8d                	push   $0xffffff8d
  52:	00 00                	add    %al,(%eax)
  54:	87 01                	xchg   %eax,(%ecx)
  56:	00 00                	add    %al,(%eax)
  58:	00 00                	add    %al,(%eax)
  5a:	00 00                	add    %al,(%eax)
  5c:	00 00                	add    %al,(%eax)
  5e:	00 00                	add    %al,(%eax)
  60:	1c 00                	sbb    $0x0,%al
  62:	00 00                	add    %al,(%eax)
  64:	02 00                	add    (%eax),%al
  66:	0d 0e 00 00 04       	or     $0x400000e,%eax
  6b:	00 00                	add    %al,(%eax)
  6d:	00 00                	add    %al,(%eax)
  6f:	00 f1                	add    %dh,%cl
  71:	8e 00                	mov    (%eax),%es
  73:	00 10                	add    %dl,(%eax)
  75:	00 00                	add    %al,(%eax)
  77:	00 00                	add    %al,(%eax)
  79:	00 00                	add    %al,(%eax)
  7b:	00 00                	add    %al,(%eax)
  7d:	00 00                	add    %al,(%eax)
  7f:	00                   	.byte 0x0

Disassembly of section .debug_info:

00000000 <.debug_info>:
   0:	42                   	inc    %edx
   1:	00 00                	add    %al,(%eax)
   3:	00 02                	add    %al,(%edx)
   5:	00 00                	add    %al,(%eax)
   7:	00 00                	add    %al,(%eax)
   9:	00 04 01             	add    %al,(%ecx,%eax,1)
   c:	00 00                	add    %al,(%eax)
   e:	00 00                	add    %al,(%eax)
  10:	00 7e 00             	add    %bh,0x0(%esi)
  13:	00 26                	add    %ah,(%esi)
  15:	8b 00                	mov    (%eax),%eax
  17:	00 62 6f             	add    %ah,0x6f(%edx)
  1a:	6f                   	outsl  %ds:(%esi),(%dx)
  1b:	74 2f                	je     4c <PROT_MODE_DSEG+0x3c>
  1d:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  20:	74 31                	je     53 <PROT_MODE_DSEG+0x43>
  22:	2f                   	das    
  23:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  26:	74 31                	je     59 <PROT_MODE_DSEG+0x49>
  28:	2e 53                	cs push %ebx
  2a:	00 2f                	add    %ch,(%edi)
  2c:	72 6f                	jb     9d <PR_BOOTABLE+0x1d>
  2e:	6f                   	outsl  %ds:(%esi),(%dx)
  2f:	74 2f                	je     60 <PROT_MODE_DSEG+0x50>
  31:	63 6f 64             	arpl   %bp,0x64(%edi)
  34:	65 00 47 4e          	add    %al,%gs:0x4e(%edi)
  38:	55                   	push   %ebp
  39:	20 41 53             	and    %al,0x53(%ecx)
  3c:	20 32                	and    %dh,(%edx)
  3e:	2e 32 36             	xor    %cs:(%esi),%dh
  41:	2e 31 00             	xor    %eax,%cs:(%eax)
  44:	01 80 a2 06 00 00    	add    %eax,0x6a2(%eax)
  4a:	04 00                	add    $0x0,%al
  4c:	14 00                	adc    $0x0,%al
  4e:	00 00                	add    %al,(%eax)
  50:	04 01                	add    $0x1,%al
  52:	74 00                	je     54 <PROT_MODE_DSEG+0x44>
  54:	00 00                	add    %al,(%eax)
  56:	01 4c 00 00          	add    %ecx,0x0(%eax,%eax,1)
  5a:	00 4c 01 00          	add    %cl,0x0(%ecx,%eax,1)
  5e:	00 26                	add    %ah,(%esi)
  60:	8b 00                	mov    (%eax),%eax
  62:	00 44 02 00          	add    %al,0x0(%edx,%eax,1)
  66:	00 80 00 00 00 02    	add    %al,0x2000000(%eax)
  6c:	01 06                	add    %eax,(%esi)
  6e:	e2 00                	loop   70 <PROT_MODE_DSEG+0x60>
  70:	00 00                	add    %al,(%eax)
  72:	03 62 00             	add    0x0(%edx),%esp
  75:	00 00                	add    %al,(%eax)
  77:	02 0d 37 00 00 00    	add    0x37,%cl
  7d:	02 01                	add    (%ecx),%al
  7f:	08 e0                	or     %ah,%al
  81:	00 00                	add    %al,(%eax)
  83:	00 02                	add    %al,(%edx)
  85:	02 05 10 00 00 00    	add    0x10,%al
  8b:	02 02                	add    (%edx),%al
  8d:	07                   	pop    %es
  8e:	32 01                	xor    (%ecx),%al
  90:	00 00                	add    %al,(%eax)
  92:	03 15 01 00 00 02    	add    0x2000001,%edx
  98:	10 57 00             	adc    %dl,0x0(%edi)
  9b:	00 00                	add    %al,(%eax)
  9d:	04 04                	add    $0x4,%al
  9f:	05 69 6e 74 00       	add    $0x746e69,%eax
  a4:	03 14 01             	add    (%ecx,%eax,1),%edx
  a7:	00 00                	add    %al,(%eax)
  a9:	02 11                	add    (%ecx),%dl
  ab:	69 00 00 00 02 04    	imul   $0x4020000,(%eax),%eax
  b1:	07                   	pop    %es
  b2:	02 01                	add    (%ecx),%al
  b4:	00 00                	add    %al,(%eax)
  b6:	02 08                	add    (%eax),%cl
  b8:	05 2e 00 00 00       	add    $0x2e,%eax
  bd:	02 08                	add    (%eax),%cl
  bf:	07                   	pop    %es
  c0:	f8                   	clc    
  c1:	00 00                	add    %al,(%eax)
  c3:	00 02                	add    %al,(%edx)
  c5:	04 07                	add    $0x7,%al
  c7:	1a 00                	sbb    (%eax),%al
  c9:	00 00                	add    %al,(%eax)
  cb:	05 69 6e 62 00       	add    $0x626e69,%eax
  d0:	02 25 2c 00 00 00    	add    0x2c,%ah
  d6:	03 ac 00 00 00 06 5c 	add    0x5c060000(%eax,%eax,1),%ebp
  dd:	01 00                	add    %eax,(%eax)
  df:	00 02                	add    %al,(%edx)
  e1:	25 57 00 00 00       	and    $0x57,%eax
  e6:	07                   	pop    %es
  e7:	57                   	push   %edi
  e8:	01 00                	add    %eax,(%eax)
  ea:	00 02                	add    %al,(%edx)
  ec:	27                   	daa    
  ed:	2c 00                	sub    $0x0,%al
  ef:	00 00                	add    %al,(%eax)
  f1:	00 08                	add    %cl,(%eax)
  f3:	6a 00                	push   $0x0
  f5:	00 00                	add    %al,(%eax)
  f7:	02 19                	add    (%ecx),%bl
  f9:	03 cf                	add    %edi,%ecx
  fb:	00 00                	add    %al,(%eax)
  fd:	00 06                	add    %al,(%esi)
  ff:	5c                   	pop    %esp
 100:	01 00                	add    %eax,(%eax)
 102:	00 02                	add    %al,(%edx)
 104:	19 57 00             	sbb    %edx,0x0(%edi)
 107:	00 00                	add    %al,(%eax)
 109:	06                   	push   %es
 10a:	57                   	push   %edi
 10b:	01 00                	add    %eax,(%eax)
 10d:	00 02                	add    %al,(%edx)
 10f:	19 2c 00             	sbb    %ebp,(%eax,%eax,1)
 112:	00 00                	add    %al,(%eax)
 114:	00 08                	add    %cl,(%eax)
 116:	6f                   	outsl  %ds:(%esi),(%dx)
 117:	00 00                	add    %al,(%eax)
 119:	00 02                	add    %al,(%edx)
 11b:	2d 03 fd 00 00       	sub    $0xfd03,%eax
 120:	00 06                	add    %al,(%esi)
 122:	5c                   	pop    %esp
 123:	01 00                	add    %eax,(%eax)
 125:	00 02                	add    %al,(%edx)
 127:	2d 57 00 00 00       	sub    $0x57,%eax
 12c:	06                   	push   %es
 12d:	a5                   	movsl  %ds:(%esi),%es:(%edi)
 12e:	03 00                	add    (%eax),%eax
 130:	00 02                	add    %al,(%edx)
 132:	2d fd 00 00 00       	sub    $0xfd,%eax
 137:	09 63 6e             	or     %esp,0x6e(%ebx)
 13a:	74 00                	je     13c <PR_BOOTABLE+0xbc>
 13c:	02 2d 57 00 00 00    	add    0x57,%ch
 142:	00 0a                	add    %cl,(%edx)
 144:	04 0b                	add    $0xb,%al
 146:	f3 00 00             	repz add %al,(%eax)
 149:	00 01                	add    %al,(%ecx)
 14b:	09 26                	or     %esp,(%esi)
 14d:	8b 00                	mov    (%eax),%eax
 14f:	00 1b                	add    %bl,(%ebx)
 151:	00 00                	add    %al,(%eax)
 153:	00 01                	add    %al,(%ecx)
 155:	9c                   	pushf  
 156:	47                   	inc    %edi
 157:	01 00                	add    %eax,(%eax)
 159:	00 0c 6c             	add    %cl,(%esp,%ebp,2)
 15c:	00 01                	add    %al,(%ecx)
 15e:	09 57 00             	or     %edx,0x0(%edi)
 161:	00 00                	add    %al,(%eax)
 163:	02 91 00 0d 1d 01    	add    0x11d0d00(%ecx),%dl
 169:	00 00                	add    %al,(%eax)
 16b:	01 09                	add    %ecx,(%ecx)
 16d:	57                   	push   %edi
 16e:	00 00                	add    %al,(%eax)
 170:	00 02                	add    %al,(%edx)
 172:	91                   	xchg   %eax,%ecx
 173:	04 0c                	add    $0xc,%al
 175:	63 68 00             	arpl   %bp,0x0(%eax)
 178:	01 09                	add    %ecx,(%ecx)
 17a:	47                   	inc    %edi
 17b:	01 00                	add    %eax,(%eax)
 17d:	00 02                	add    %al,(%edx)
 17f:	91                   	xchg   %eax,%ecx
 180:	08 0e                	or     %cl,(%esi)
 182:	70 00                	jo     184 <PR_BOOTABLE+0x104>
 184:	01 0b                	add    %ecx,(%ebx)
 186:	4e                   	dec    %esi
 187:	01 00                	add    %eax,(%eax)
 189:	00 01                	add    %al,(%ecx)
 18b:	50                   	push   %eax
 18c:	00 02                	add    %al,(%edx)
 18e:	01 06                	add    %eax,(%esi)
 190:	e9 00 00 00 0f       	jmp    f000195 <_end+0xeff6e85>
 195:	04 54                	add    $0x54,%al
 197:	01 00                	add    %eax,(%eax)
 199:	00 10                	add    %dl,(%eax)
 19b:	47                   	inc    %edi
 19c:	01 00                	add    %eax,(%eax)
 19e:	00 11                	add    %dl,(%ecx)
 1a0:	28 01                	sub    %al,(%ecx)
 1a2:	00 00                	add    %al,(%eax)
 1a4:	01 12                	add    %edx,(%edx)
 1a6:	57                   	push   %edi
 1a7:	00 00                	add    %al,(%eax)
 1a9:	00 41 8b             	add    %al,-0x75(%ecx)
 1ac:	00 00                	add    %al,(%eax)
 1ae:	34 00                	xor    $0x0,%al
 1b0:	00 00                	add    %al,(%eax)
 1b2:	01 9c be 01 00 00 0c 	add    %ebx,0xc000001(%esi,%edi,4)
 1b9:	72 00                	jb     1bb <PR_BOOTABLE+0x13b>
 1bb:	01 12                	add    %edx,(%edx)
 1bd:	57                   	push   %edi
 1be:	00 00                	add    %al,(%eax)
 1c0:	00 02                	add    %al,(%edx)
 1c2:	91                   	xchg   %eax,%ecx
 1c3:	00 0c 63             	add    %cl,(%ebx,%eiz,2)
 1c6:	00 01                	add    %al,(%ecx)
 1c8:	12 57 00             	adc    0x0(%edi),%dl
 1cb:	00 00                	add    %al,(%eax)
 1cd:	02 91 04 0d 1d 01    	add    0x11d0d04(%ecx),%dl
 1d3:	00 00                	add    %al,(%eax)
 1d5:	01 12                	add    %edx,(%edx)
 1d7:	57                   	push   %edi
 1d8:	00 00                	add    %al,(%eax)
 1da:	00 02                	add    %al,(%edx)
 1dc:	91                   	xchg   %eax,%ecx
 1dd:	08 12                	or     %dl,(%edx)
 1df:	cd 00                	int    $0x0
 1e1:	00 00                	add    %al,(%eax)
 1e3:	01 12                	add    %edx,(%edx)
 1e5:	be 01 00 00 00       	mov    $0x1,%esi
 1ea:	00 00                	add    %al,(%eax)
 1ec:	00 13                	add    %dl,(%ebx)
 1ee:	6c                   	insb   (%dx),%es:(%edi)
 1ef:	00 01                	add    %al,(%ecx)
 1f1:	14 57                	adc    $0x57,%al
 1f3:	00 00                	add    %al,(%eax)
 1f5:	00 86 00 00 00 14    	add    %al,0x14000000(%esi)
 1fb:	67 8b 00             	mov    (%bx,%si),%eax
 1fe:	00 ff                	add    %bh,%bh
 200:	00 00                	add    %al,(%eax)
 202:	00 00                	add    %al,(%eax)
 204:	0f 04                	(bad)  
 206:	c4 01                	les    (%ecx),%eax
 208:	00 00                	add    %al,(%eax)
 20a:	15 47 01 00 00       	adc    $0x147,%eax
 20f:	0b 61 01             	or     0x1(%ecx),%esp
 212:	00 00                	add    %al,(%eax)
 214:	01 22                	add    %esp,(%edx)
 216:	75 8b                	jne    1a3 <PR_BOOTABLE+0x123>
 218:	00 00                	add    %al,(%eax)
 21a:	3f                   	aas    
 21b:	00 00                	add    %al,(%eax)
 21d:	00 01                	add    %al,(%ecx)
 21f:	9c                   	pushf  
 220:	fd                   	std    
 221:	01 00                	add    %eax,(%eax)
 223:	00 0c 73             	add    %cl,(%ebx,%esi,2)
 226:	00 01                	add    %al,(%ecx)
 228:	22 fd                	and    %ch,%bh
 22a:	01 00                	add    %eax,(%eax)
 22c:	00 02                	add    %al,(%edx)
 22e:	91                   	xchg   %eax,%ecx
 22f:	00 14 9f             	add    %dl,(%edi,%ebx,4)
 232:	8b 00                	mov    (%eax),%eax
 234:	00 59 01             	add    %bl,0x1(%ecx)
 237:	00 00                	add    %al,(%eax)
 239:	14 ac                	adc    $0xac,%al
 23b:	8b 00                	mov    (%eax),%eax
 23d:	00 59 01             	add    %bl,0x1(%ecx)
 240:	00 00                	add    %al,(%eax)
 242:	00 0f                	add    %cl,(%edi)
 244:	04 47                	add    $0x47,%al
 246:	01 00                	add    %eax,(%eax)
 248:	00 0b                	add    %cl,(%ebx)
 24a:	23 00                	and    (%eax),%eax
 24c:	00 00                	add    %al,(%eax)
 24e:	01 29                	add    %ebp,(%ecx)
 250:	b4 8b                	mov    $0x8b,%ah
 252:	00 00                	add    %al,(%eax)
 254:	0d 00 00 00 01       	or     $0x1000000,%eax
 259:	9c                   	pushf  
 25a:	25 02 00 00 0c       	and    $0xc000002,%eax
 25f:	72 00                	jb     261 <PR_BOOTABLE+0x1e1>
 261:	01 29                	add    %ebp,(%ecx)
 263:	57                   	push   %edi
 264:	00 00                	add    %al,(%eax)
 266:	00 02                	add    %al,(%edx)
 268:	91                   	xchg   %eax,%ecx
 269:	00 00                	add    %al,(%eax)
 26b:	0b 28                	or     (%eax),%ebp
 26d:	00 00                	add    %al,(%eax)
 26f:	00 01                	add    %al,(%ecx)
 271:	2f                   	das    
 272:	c1 8b 00 00 17 00 00 	rorl   $0x0,0x170000(%ebx)
 279:	00 01                	add    %al,(%ecx)
 27b:	9c                   	pushf  
 27c:	50                   	push   %eax
 27d:	02 00                	add    (%eax),%al
 27f:	00 0c 6d 00 01 2f fd 	add    %cl,-0x2d0ff00(,%ebp,2)
 286:	01 00                	add    %eax,(%eax)
 288:	00 02                	add    %al,(%edx)
 28a:	91                   	xchg   %eax,%ecx
 28b:	00 14 d2             	add    %dl,(%edx,%edx,8)
 28e:	8b 00                	mov    (%eax),%eax
 290:	00 59 01             	add    %bl,0x1(%ecx)
 293:	00 00                	add    %al,(%eax)
 295:	00 11                	add    %dl,(%ecx)
 297:	45                   	inc    %ebp
 298:	01 00                	add    %eax,(%eax)
 29a:	00 01                	add    %al,(%ecx)
 29c:	47                   	inc    %edi
 29d:	57                   	push   %edi
 29e:	00 00                	add    %al,(%eax)
 2a0:	00 d8                	add    %bl,%al
 2a2:	8b 00                	mov    (%eax),%eax
 2a4:	00 13                	add    %dl,(%ebx)
 2a6:	00 00                	add    %al,(%eax)
 2a8:	00 01                	add    %al,(%ecx)
 2aa:	9c                   	pushf  
 2ab:	84 02                	test   %al,(%edx)
 2ad:	00 00                	add    %al,(%eax)
 2af:	16                   	push   %ss
 2b0:	73 00                	jae    2b2 <PR_BOOTABLE+0x232>
 2b2:	01 47 be             	add    %eax,-0x42(%edi)
 2b5:	01 00                	add    %eax,(%eax)
 2b7:	00 c0                	add    %al,%al
 2b9:	00 00                	add    %al,(%eax)
 2bb:	00 13                	add    %dl,(%ebx)
 2bd:	6e                   	outsb  %ds:(%esi),(%dx)
 2be:	00 01                	add    %al,(%ecx)
 2c0:	49                   	dec    %ecx
 2c1:	57                   	push   %edi
 2c2:	00 00                	add    %al,(%eax)
 2c4:	00 e5                	add    %ah,%ch
 2c6:	00 00                	add    %al,(%eax)
 2c8:	00 00                	add    %al,(%eax)
 2ca:	0b 69 01             	or     0x1(%ecx),%ebp
 2cd:	00 00                	add    %al,(%eax)
 2cf:	01 52 eb             	add    %edx,-0x15(%edx)
 2d2:	8b 00                	mov    (%eax),%eax
 2d4:	00 30                	add    %dh,(%eax)
 2d6:	00 00                	add    %al,(%eax)
 2d8:	00 01                	add    %al,(%ecx)
 2da:	9c                   	pushf  
 2db:	d4 02                	aam    $0x2
 2dd:	00 00                	add    %al,(%eax)
 2df:	0c 73                	or     $0x73,%al
 2e1:	00 01                	add    %al,(%ecx)
 2e3:	52                   	push   %edx
 2e4:	fd                   	std    
 2e5:	01 00                	add    %eax,(%eax)
 2e7:	00 02                	add    %al,(%edx)
 2e9:	91                   	xchg   %eax,%ecx
 2ea:	00 13                	add    %dl,(%ebx)
 2ec:	69 00 01 54 57 00    	imul   $0x575401,(%eax),%eax
 2f2:	00 00                	add    %al,(%eax)
 2f4:	04 01                	add    $0x1,%al
 2f6:	00 00                	add    %al,(%eax)
 2f8:	0e                   	push   %cs
 2f9:	6a 00                	push   $0x0
 2fb:	01 54 57 00          	add    %edx,0x0(%edi,%edx,2)
 2ff:	00 00                	add    %al,(%eax)
 301:	01 50 13             	add    %edx,0x13(%eax)
 304:	63 00                	arpl   %ax,(%eax)
 306:	01 55 47             	add    %edx,0x47(%ebp)
 309:	01 00                	add    %eax,(%eax)
 30b:	00 23                	add    %ah,(%ebx)
 30d:	01 00                	add    %eax,(%eax)
 30f:	00 14 f9             	add    %dl,(%ecx,%edi,8)
 312:	8b 00                	mov    (%eax),%eax
 314:	00 50 02             	add    %dl,0x2(%eax)
 317:	00 00                	add    %al,(%eax)
 319:	00 0b                	add    %cl,(%ebx)
 31b:	23 01                	and    (%ecx),%eax
 31d:	00 00                	add    %al,(%eax)
 31f:	01 61 1b             	add    %esp,0x1b(%ecx)
 322:	8c 00                	mov    %es,(%eax)
 324:	00 5d 00             	add    %bl,0x0(%ebp)
 327:	00 00                	add    %al,(%eax)
 329:	01 9c 44 03 00 00 16 	add    %ebx,0x16000003(%esp,%eax,2)
 330:	6e                   	outsb  %ds:(%esi),(%dx)
 331:	00 01                	add    %al,(%ecx)
 333:	61                   	popa   
 334:	57                   	push   %edi
 335:	00 00                	add    %al,(%eax)
 337:	00 36                	add    %dh,(%esi)
 339:	01 00                	add    %eax,(%eax)
 33b:	00 0c 73             	add    %cl,(%ebx,%esi,2)
 33e:	00 01                	add    %al,(%ecx)
 340:	61                   	popa   
 341:	fd                   	std    
 342:	01 00                	add    %eax,(%eax)
 344:	00 02                	add    %al,(%edx)
 346:	91                   	xchg   %eax,%ecx
 347:	04 0d                	add    $0xd,%al
 349:	80 01 00             	addb   $0x0,(%ecx)
 34c:	00 01                	add    %al,(%ecx)
 34e:	61                   	popa   
 34f:	57                   	push   %edi
 350:	00 00                	add    %al,(%eax)
 352:	00 02                	add    %al,(%edx)
 354:	91                   	xchg   %eax,%ecx
 355:	08 0d 89 03 00 00    	or     %cl,0x389
 35b:	01 61 fd             	add    %esp,-0x3(%ecx)
 35e:	01 00                	add    %eax,(%eax)
 360:	00 02                	add    %al,(%edx)
 362:	91                   	xchg   %eax,%ecx
 363:	0c 13                	or     $0x13,%al
 365:	69 00 01 63 57 00    	imul   $0x576301,(%eax),%eax
 36b:	00 00                	add    %al,(%eax)
 36d:	60                   	pusha  
 36e:	01 00                	add    %eax,(%eax)
 370:	00 17                	add    %dl,(%edi)
 372:	2d 01 00 00 01       	sub    $0x1000001,%eax
 377:	63 57 00             	arpl   %dx,0x0(%edi)
 37a:	00 00                	add    %al,(%eax)
 37c:	94                   	xchg   %eax,%esp
 37d:	01 00                	add    %eax,(%eax)
 37f:	00 18                	add    %bl,(%eax)
 381:	78 8c                	js     30f <PR_BOOTABLE+0x28f>
 383:	00 00                	add    %al,(%eax)
 385:	84 02                	test   %al,(%edx)
 387:	00 00                	add    %al,(%eax)
 389:	00 0b                	add    %cl,(%ebx)
 38b:	0f 01 00             	sgdtl  (%eax)
 38e:	00 01                	add    %al,(%ecx)
 390:	73 78                	jae    40a <PR_BOOTABLE+0x38a>
 392:	8c 00                	mov    %es,(%eax)
 394:	00 1a                	add    %bl,(%edx)
 396:	00 00                	add    %al,(%eax)
 398:	00 01                	add    %al,(%ecx)
 39a:	9c                   	pushf  
 39b:	8c 03                	mov    %es,(%ebx)
 39d:	00 00                	add    %al,(%eax)
 39f:	0c 6e                	or     $0x6e,%al
 3a1:	00 01                	add    %al,(%ecx)
 3a3:	73 57                	jae    3fc <PR_BOOTABLE+0x37c>
 3a5:	00 00                	add    %al,(%eax)
 3a7:	00 02                	add    %al,(%edx)
 3a9:	91                   	xchg   %eax,%ecx
 3aa:	00 0c 73             	add    %cl,(%ebx,%esi,2)
 3ad:	00 01                	add    %al,(%ecx)
 3af:	73 fd                	jae    3ae <PR_BOOTABLE+0x32e>
 3b1:	01 00                	add    %eax,(%eax)
 3b3:	00 02                	add    %al,(%edx)
 3b5:	91                   	xchg   %eax,%ecx
 3b6:	04 0e                	add    $0xe,%al
 3b8:	64 65 63 00          	fs arpl %ax,%gs:(%eax)
 3bc:	01 75 8c             	add    %esi,-0x74(%ebp)
 3bf:	03 00                	add    (%eax),%eax
 3c1:	00 05 03 70 92 00    	add    %al,0x927003
 3c7:	00 14 8d 8c 00 00 d4 	add    %dl,-0x2bffff74(,%ecx,4)
 3ce:	02 00                	add    (%eax),%al
 3d0:	00 00                	add    %al,(%eax)
 3d2:	19 47 01             	sbb    %eax,0x1(%edi)
 3d5:	00 00                	add    %al,(%eax)
 3d7:	9c                   	pushf  
 3d8:	03 00                	add    (%eax),%eax
 3da:	00 1a                	add    %bl,(%edx)
 3dc:	7e 00                	jle    3de <PR_BOOTABLE+0x35e>
 3de:	00 00                	add    %al,(%eax)
 3e0:	0a 00                	or     (%eax),%al
 3e2:	0b ee                	or     %esi,%ebp
 3e4:	00 00                	add    %al,(%eax)
 3e6:	00 01                	add    %al,(%ecx)
 3e8:	7b 92                	jnp    37c <PR_BOOTABLE+0x2fc>
 3ea:	8c 00                	mov    %es,(%eax)
 3ec:	00 1a                	add    %bl,(%edx)
 3ee:	00 00                	add    %al,(%eax)
 3f0:	00 01                	add    %al,(%ecx)
 3f2:	9c                   	pushf  
 3f3:	e4 03                	in     $0x3,%al
 3f5:	00 00                	add    %al,(%eax)
 3f7:	0c 6e                	or     $0x6e,%al
 3f9:	00 01                	add    %al,(%ecx)
 3fb:	7b 57                	jnp    454 <PR_BOOTABLE+0x3d4>
 3fd:	00 00                	add    %al,(%eax)
 3ff:	00 02                	add    %al,(%edx)
 401:	91                   	xchg   %eax,%ecx
 402:	00 0c 73             	add    %cl,(%ebx,%esi,2)
 405:	00 01                	add    %al,(%ecx)
 407:	7b fd                	jnp    406 <PR_BOOTABLE+0x386>
 409:	01 00                	add    %eax,(%eax)
 40b:	00 02                	add    %al,(%edx)
 40d:	91                   	xchg   %eax,%ecx
 40e:	04 0e                	add    $0xe,%al
 410:	68 65 78 00 01       	push   $0x1007865
 415:	7d e4                	jge    3fb <PR_BOOTABLE+0x37b>
 417:	03 00                	add    (%eax),%eax
 419:	00 05 03 5c 92 00    	add    %al,0x925c03
 41f:	00 14 a7             	add    %dl,(%edi,%eiz,4)
 422:	8c 00                	mov    %es,(%eax)
 424:	00 d4                	add    %dl,%ah
 426:	02 00                	add    (%eax),%al
 428:	00 00                	add    %al,(%eax)
 42a:	19 47 01             	sbb    %eax,0x1(%edi)
 42d:	00 00                	add    %al,(%eax)
 42f:	f4                   	hlt    
 430:	03 00                	add    (%eax),%eax
 432:	00 1a                	add    %bl,(%edx)
 434:	7e 00                	jle    436 <PR_BOOTABLE+0x3b6>
 436:	00 00                	add    %al,(%eax)
 438:	10 00                	adc    %al,(%eax)
 43a:	0b 3c 00             	or     (%eax,%eax,1),%edi
 43d:	00 00                	add    %al,(%eax)
 43f:	01 3b                	add    %edi,(%ebx)
 441:	ac                   	lods   %ds:(%esi),%al
 442:	8c 00                	mov    %es,(%eax)
 444:	00 1f                	add    %bl,(%edi)
 446:	00 00                	add    %al,(%eax)
 448:	00 01                	add    %al,(%ecx)
 44a:	9c                   	pushf  
 44b:	28 04 00             	sub    %al,(%eax,%eax,1)
 44e:	00 0c 69             	add    %cl,(%ecx,%ebp,2)
 451:	00 01                	add    %al,(%ecx)
 453:	3b 4c 00 00          	cmp    0x0(%eax,%eax,1),%ecx
 457:	00 02                	add    %al,(%edx)
 459:	91                   	xchg   %eax,%ecx
 45a:	00 14 bc             	add    %dl,(%esp,%edi,4)
 45d:	8c 00                	mov    %es,(%eax)
 45f:	00 9c 03 00 00 18 cb 	add    %bl,-0x34e80000(%ebx,%eax,1)
 466:	8c 00                	mov    %es,(%eax)
 468:	00 c9                	add    %cl,%cl
 46a:	01 00                	add    %eax,(%eax)
 46c:	00 00                	add    %al,(%eax)
 46e:	1b 07                	sbb    (%edi),%eax
 470:	00 00                	add    %al,(%eax)
 472:	00 01                	add    %al,(%ecx)
 474:	86 01                	xchg   %al,(%ecx)
 476:	0b 41 00             	or     0x0(%ecx),%eax
 479:	00 00                	add    %al,(%eax)
 47b:	01 8e cb 8c 00 00    	add    %ecx,0x8ccb(%esi)
 481:	5e                   	pop    %esi
 482:	00 00                	add    %al,(%eax)
 484:	00 01                	add    %al,(%ecx)
 486:	9c                   	pushf  
 487:	ea 05 00 00 0c 64 73 	ljmp   $0x7364,$0xc000005
 48e:	74 00                	je     490 <PR_BOOTABLE+0x410>
 490:	01 8e fd 00 00 00    	add    %ecx,0xfd(%esi)
 496:	02 91 00 0d ed 01    	add    0x1ed0d00(%ecx),%dl
 49c:	00 00                	add    %al,(%eax)
 49e:	01 8e 5e 00 00 00    	add    %ecx,0x5e(%esi)
 4a4:	02 91 04 1c 28 04    	add    0x4281c04(%ecx),%dl
 4aa:	00 00                	add    %al,(%eax)
 4ac:	cc                   	int3   
 4ad:	8c 00                	mov    %es,(%eax)
 4af:	00 00                	add    %al,(%eax)
 4b1:	00 00                	add    %al,(%eax)
 4b3:	00 01                	add    %al,(%ecx)
 4b5:	91                   	xchg   %eax,%ecx
 4b6:	9b                   	fwait
 4b7:	04 00                	add    $0x0,%al
 4b9:	00 1d 85 00 00 00    	add    %bl,0x85
 4bf:	cc                   	int3   
 4c0:	8c 00                	mov    %es,(%eax)
 4c2:	00 18                	add    %bl,(%eax)
 4c4:	00 00                	add    %al,(%eax)
 4c6:	00 01                	add    %al,(%ecx)
 4c8:	89 1e                	mov    %ebx,(%esi)
 4ca:	95                   	xchg   %eax,%ebp
 4cb:	00 00                	add    %al,(%eax)
 4cd:	00 f7                	add    %dh,%bh
 4cf:	01 1f                	add    %ebx,(%edi)
 4d1:	18 00                	sbb    %al,(%eax)
 4d3:	00 00                	add    %al,(%eax)
 4d5:	20 a0 00 00 00 bf    	and    %ah,-0x41000000(%eax)
 4db:	01 00                	add    %eax,(%eax)
 4dd:	00 00                	add    %al,(%eax)
 4df:	00 00                	add    %al,(%eax)
 4e1:	21 ac 00 00 00 df 8c 	and    %ebp,-0x73210000(%eax,%eax,1)
 4e8:	00 00                	add    %al,(%eax)
 4ea:	0b 00                	or     (%eax),%eax
 4ec:	00 00                	add    %al,(%eax)
 4ee:	01 93 bc 04 00 00    	add    %edx,0x4bc(%ebx)
 4f4:	22 c3                	and    %bl,%al
 4f6:	00 00                	add    %al,(%eax)
 4f8:	00 01                	add    %al,(%ecx)
 4fa:	1e                   	push   %ds
 4fb:	b8 00 00 00 f2       	mov    $0xf2000000,%eax
 500:	01 00                	add    %eax,(%eax)
 502:	21 ac 00 00 00 ea 8c 	and    %ebp,-0x73160000(%eax,%eax,1)
 509:	00 00                	add    %al,(%eax)
 50b:	06                   	push   %es
 50c:	00 00                	add    %al,(%eax)
 50e:	00 01                	add    %al,(%ecx)
 510:	94                   	xchg   %eax,%esp
 511:	e4 04                	in     $0x4,%al
 513:	00 00                	add    %al,(%eax)
 515:	23 c3                	and    %ebx,%eax
 517:	00 00                	add    %al,(%eax)
 519:	00 07                	add    %al,(%edi)
 51b:	91                   	xchg   %eax,%ecx
 51c:	04 06                	add    $0x6,%al
 51e:	08 ff                	or     %bh,%bh
 520:	1a 9f 1e b8 00 00    	sbb    0xb81e(%edi),%bl
 526:	00 f3                	add    %dh,%bl
 528:	01 00                	add    %eax,(%eax)
 52a:	21 ac 00 00 00 f0 8c 	and    %ebp,-0x73100000(%eax,%eax,1)
 531:	00 00                	add    %al,(%eax)
 533:	03 00                	add    (%eax),%eax
 535:	00 00                	add    %al,(%eax)
 537:	01 95 0e 05 00 00    	add    %edx,0x50e(%ebp)
 53d:	23 c3                	and    %ebx,%eax
 53f:	00 00                	add    %al,(%eax)
 541:	00 09                	add    %cl,(%ecx)
 543:	91                   	xchg   %eax,%ecx
 544:	04 06                	add    $0x6,%al
 546:	38 25 08 ff 1a 9f    	cmp    %ah,0x9f1aff08
 54c:	1e                   	push   %ds
 54d:	b8 00 00 00 f4       	mov    $0xf4000000,%eax
 552:	01 00                	add    %eax,(%eax)
 554:	1c ac                	sbb    $0xac,%al
 556:	00 00                	add    %al,(%eax)
 558:	00 f5                	add    %dh,%ch
 55a:	8c 00                	mov    %es,(%eax)
 55c:	00 30                	add    %dh,(%eax)
 55e:	00 00                	add    %al,(%eax)
 560:	00 01                	add    %al,(%ecx)
 562:	96                   	xchg   %eax,%esi
 563:	38 05 00 00 23 c3    	cmp    %al,0xc3230000
 569:	00 00                	add    %al,(%eax)
 56b:	00 09                	add    %cl,(%ecx)
 56d:	91                   	xchg   %eax,%ecx
 56e:	04 06                	add    $0x6,%al
 570:	40                   	inc    %eax
 571:	25 08 ff 1a 9f       	and    $0x9f1aff08,%eax
 576:	1e                   	push   %ds
 577:	b8 00 00 00 f5       	mov    $0xf5000000,%eax
 57c:	01 00                	add    %eax,(%eax)
 57e:	1c ac                	sbb    $0xac,%al
 580:	00 00                	add    %al,(%eax)
 582:	00 01                	add    %al,(%ecx)
 584:	8d 00                	lea    (%eax),%eax
 586:	00 48 00             	add    %cl,0x0(%eax)
 589:	00 00                	add    %al,(%eax)
 58b:	01 97 61 05 00 00    	add    %edx,0x561(%edi)
 591:	23 c3                	and    %ebx,%eax
 593:	00 00                	add    %al,(%eax)
 595:	00 08                	add    %cl,(%eax)
 597:	91                   	xchg   %eax,%ecx
 598:	07                   	pop    %es
 599:	94                   	xchg   %eax,%esp
 59a:	01 09                	add    %ecx,(%ecx)
 59c:	e0 21                	loopne 5bf <PR_BOOTABLE+0x53f>
 59e:	9f                   	lahf   
 59f:	1e                   	push   %ds
 5a0:	b8 00 00 00 f6       	mov    $0xf6000000,%eax
 5a5:	01 00                	add    %eax,(%eax)
 5a7:	21 ac 00 00 00 09 8d 	and    %ebp,-0x72f70000(%eax,%eax,1)
 5ae:	00 00                	add    %al,(%eax)
 5b0:	05 00 00 00 01       	add    $0x1000000,%eax
 5b5:	98                   	cwtl   
 5b6:	82                   	(bad)  
 5b7:	05 00 00 22 c3       	add    $0xc3220000,%eax
 5bc:	00 00                	add    %al,(%eax)
 5be:	00 20                	add    %ah,(%eax)
 5c0:	1e                   	push   %ds
 5c1:	b8 00 00 00 f7       	mov    $0xf7000000,%eax
 5c6:	01 00                	add    %eax,(%eax)
 5c8:	21 28                	and    %ebp,(%eax)
 5ca:	04 00                	add    $0x0,%al
 5cc:	00 0e                	add    %cl,(%esi)
 5ce:	8d 00                	lea    (%eax),%eax
 5d0:	00 08                	add    %cl,(%eax)
 5d2:	00 00                	add    %al,(%eax)
 5d4:	00 01                	add    %al,(%ecx)
 5d6:	9b                   	fwait
 5d7:	c0 05 00 00 24 85 00 	rolb   $0x0,0x85240000
 5de:	00 00                	add    %al,(%eax)
 5e0:	0e                   	push   %cs
 5e1:	8d 00                	lea    (%eax),%eax
 5e3:	00 01                	add    %al,(%ecx)
 5e5:	00 00                	add    %al,(%eax)
 5e7:	00 01                	add    %al,(%ecx)
 5e9:	89 1e                	mov    %ebx,(%esi)
 5eb:	95                   	xchg   %eax,%ebp
 5ec:	00 00                	add    %al,(%eax)
 5ee:	00 f7                	add    %dh,%bh
 5f0:	01 25 0e 8d 00 00    	add    %esp,0x8d0e
 5f6:	01 00                	add    %eax,(%eax)
 5f8:	00 00                	add    %al,(%eax)
 5fa:	20 a0 00 00 00 d2    	and    %ah,-0x2e000000(%eax)
 600:	01 00                	add    %eax,(%eax)
 602:	00 00                	add    %al,(%eax)
 604:	00 00                	add    %al,(%eax)
 606:	24 cf                	and    $0xcf,%al
 608:	00 00                	add    %al,(%eax)
 60a:	00 16                	add    %dl,(%esi)
 60c:	8d 00                	lea    (%eax),%eax
 60e:	00 10                	add    %dl,(%eax)
 610:	00 00                	add    %al,(%eax)
 612:	00 01                	add    %al,(%ecx)
 614:	9e                   	sahf   
 615:	26 f1                	es icebp 
 617:	00 00                	add    %al,(%eax)
 619:	00 e5                	add    %ah,%ch
 61b:	01 00                	add    %eax,(%eax)
 61d:	00 26                	add    %ah,(%esi)
 61f:	e6 00                	out    %al,$0x0
 621:	00 00                	add    %al,(%eax)
 623:	fa                   	cli    
 624:	01 00                	add    %eax,(%eax)
 626:	00 1e                	add    %bl,(%esi)
 628:	db 00                	fildl  (%eax)
 62a:	00 00                	add    %al,(%eax)
 62c:	f0 01 00             	lock add %eax,(%eax)
 62f:	00 0b                	add    %cl,(%ebx)
 631:	d4 00                	aam    $0x0
 633:	00 00                	add    %al,(%eax)
 635:	01 a4 29 8d 00 00 41 	add    %esp,0x4100008d(%ecx,%ebp,1)
 63c:	00 00                	add    %al,(%eax)
 63e:	00 01                	add    %al,(%ecx)
 640:	9c                   	pushf  
 641:	51                   	push   %ecx
 642:	06                   	push   %es
 643:	00 00                	add    %al,(%eax)
 645:	16                   	push   %ss
 646:	76 61                	jbe    6a9 <PR_BOOTABLE+0x629>
 648:	00 01                	add    %al,(%ecx)
 64a:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 64b:	5e                   	pop    %esi
 64c:	00 00                	add    %al,(%eax)
 64e:	00 0e                	add    %cl,(%esi)
 650:	02 00                	add    (%eax),%al
 652:	00 0d 44 04 00 00    	add    %cl,0x444
 658:	01 a4 5e 00 00 00 02 	add    %esp,0x2000000(%esi,%ebx,2)
 65f:	91                   	xchg   %eax,%ecx
 660:	04 12                	add    $0x12,%al
 662:	ed                   	in     (%dx),%eax
 663:	01 00                	add    %eax,(%eax)
 665:	00 01                	add    %al,(%ecx)
 667:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 668:	5e                   	pop    %esi
 669:	00 00                	add    %al,(%eax)
 66b:	00 71 02             	add    %dh,0x2(%ecx)
 66e:	00 00                	add    %al,(%eax)
 670:	0c 6c                	or     $0x6c,%al
 672:	62 61 00             	bound  %esp,0x0(%ecx)
 675:	01 a4 5e 00 00 00 02 	add    %esp,0x2000000(%esi,%ebx,2)
 67c:	91                   	xchg   %eax,%ecx
 67d:	0c 17                	or     $0x17,%al
 67f:	00 00                	add    %al,(%eax)
 681:	00 00                	add    %al,(%eax)
 683:	01 a6 5e 00 00 00    	add    %esp,0x5e(%esi)
 689:	c0 02 00             	rolb   $0x0,(%edx)
 68c:	00 14 5e             	add    %dl,(%esi,%ebx,2)
 68f:	8d 00                	lea    (%eax),%eax
 691:	00 30                	add    %dh,(%eax)
 693:	04 00                	add    $0x0,%al
 695:	00 00                	add    %al,(%eax)
 697:	0e                   	push   %cs
 698:	72 6f                	jb     709 <PR_BOOTABLE+0x689>
 69a:	77 00                	ja     69c <PR_BOOTABLE+0x61c>
 69c:	01 1c 57             	add    %ebx,(%edi,%edx,2)
 69f:	00 00                	add    %al,(%eax)
 6a1:	00 05 03 0c 93 00    	add    %al,0x930c03
 6a7:	00 19                	add    %bl,(%ecx)
 6a9:	47                   	inc    %edi
 6aa:	01 00                	add    %eax,(%eax)
 6ac:	00 72 06             	add    %dh,0x6(%edx)
 6af:	00 00                	add    %al,(%eax)
 6b1:	1a 7e 00             	sbb    0x0(%esi),%bh
 6b4:	00 00                	add    %al,(%eax)
 6b6:	27                   	daa    
 6b7:	00 27                	add    %ah,(%edi)
 6b9:	71 01                	jno    6bc <PR_BOOTABLE+0x63c>
 6bb:	00 00                	add    %al,(%eax)
 6bd:	01 38                	add    %edi,(%eax)
 6bf:	62 06                	bound  %eax,(%esi)
 6c1:	00 00                	add    %al,(%eax)
 6c3:	05 03 e4 92 00       	add    $0x92e403,%eax
 6c8:	00 28                	add    %ch,(%eax)
 6ca:	85 01                	test   %eax,(%ecx)
 6cc:	00 00                	add    %al,(%eax)
 6ce:	01 06                	add    %eax,(%esi)
 6d0:	4e                   	dec    %esi
 6d1:	01 00                	add    %eax,(%eax)
 6d3:	00 05 03 80 92 00    	add    %al,0x928003
 6d9:	00 28                	add    %ch,(%eax)
 6db:	7a 01                	jp     6de <PR_BOOTABLE+0x65e>
 6dd:	00 00                	add    %al,(%eax)
 6df:	01 1e                	add    %ebx,(%esi)
 6e1:	fd                   	std    
 6e2:	01 00                	add    %eax,(%eax)
 6e4:	00 05 03 7c 92 00    	add    %al,0x927c03
 6ea:	00 00                	add    %al,(%eax)
 6ec:	1d 07 00 00 04       	sbb    $0x4000007,%eax
 6f1:	00 2a                	add    %ch,(%edx)
 6f3:	02 00                	add    (%eax),%al
 6f5:	00 04 01             	add    %al,(%ecx,%eax,1)
 6f8:	74 00                	je     6fa <PR_BOOTABLE+0x67a>
 6fa:	00 00                	add    %al,(%eax)
 6fc:	01 28                	add    %ebp,(%eax)
 6fe:	04 00                	add    $0x0,%al
 700:	00 4c 01 00          	add    %cl,0x0(%ecx,%eax,1)
 704:	00 6a 8d             	add    %ch,-0x73(%edx)
 707:	00 00                	add    %al,(%eax)
 709:	87 01                	xchg   %eax,(%ecx)
 70b:	00 00                	add    %al,(%eax)
 70d:	e0 01                	loopne 710 <PR_BOOTABLE+0x690>
 70f:	00 00                	add    %al,(%eax)
 711:	02 01                	add    (%ecx),%al
 713:	06                   	push   %es
 714:	e2 00                	loop   716 <PR_BOOTABLE+0x696>
 716:	00 00                	add    %al,(%eax)
 718:	03 62 00             	add    0x0(%edx),%esp
 71b:	00 00                	add    %al,(%eax)
 71d:	02 0d 37 00 00 00    	add    0x37,%cl
 723:	02 01                	add    (%ecx),%al
 725:	08 e0                	or     %ah,%al
 727:	00 00                	add    %al,(%eax)
 729:	00 02                	add    %al,(%edx)
 72b:	02 05 10 00 00 00    	add    0x10,%al
 731:	03 1f                	add    (%edi),%ebx
 733:	03 00                	add    (%eax),%eax
 735:	00 02                	add    %al,(%edx)
 737:	0f 50                	(bad)  
 739:	00 00                	add    %al,(%eax)
 73b:	00 02                	add    %al,(%edx)
 73d:	02 07                	add    (%edi),%al
 73f:	32 01                	xor    (%ecx),%al
 741:	00 00                	add    %al,(%eax)
 743:	03 15 01 00 00 02    	add    0x2000001,%edx
 749:	10 62 00             	adc    %ah,0x0(%edx)
 74c:	00 00                	add    %al,(%eax)
 74e:	04 04                	add    $0x4,%al
 750:	05 69 6e 74 00       	add    $0x746e69,%eax
 755:	03 14 01             	add    (%ecx,%eax,1),%edx
 758:	00 00                	add    %al,(%eax)
 75a:	02 11                	add    (%ecx),%dl
 75c:	74 00                	je     75e <PR_BOOTABLE+0x6de>
 75e:	00 00                	add    %al,(%eax)
 760:	02 04 07             	add    (%edi,%eax,1),%al
 763:	02 01                	add    (%ecx),%al
 765:	00 00                	add    %al,(%eax)
 767:	02 08                	add    (%eax),%cl
 769:	05 2e 00 00 00       	add    $0x2e,%eax
 76e:	03 ce                	add    %esi,%ecx
 770:	01 00                	add    %eax,(%eax)
 772:	00 02                	add    %al,(%edx)
 774:	13 8d 00 00 00 02    	adc    0x2000000(%ebp),%ecx
 77a:	08 07                	or     %al,(%edi)
 77c:	f8                   	clc    
 77d:	00 00                	add    %al,(%eax)
 77f:	00 05 10 02 65 e4    	add    %al,0xe4650210
 785:	00 00                	add    %al,(%eax)
 787:	00 06                	add    %al,(%esi)
 789:	11 03                	adc    %eax,(%ebx)
 78b:	00 00                	add    %al,(%eax)
 78d:	02 67 2c             	add    0x2c(%edi),%ah
 790:	00 00                	add    %al,(%eax)
 792:	00 00                	add    %al,(%eax)
 794:	06                   	push   %es
 795:	f3 02 00             	repz add (%eax),%al
 798:	00 02                	add    %al,(%edx)
 79a:	6a e4                	push   $0xffffffe4
 79c:	00 00                	add    %al,(%eax)
 79e:	00 01                	add    %al,(%ecx)
 7a0:	07                   	pop    %es
 7a1:	69 64 00 02 6b 2c 00 	imul   $0x2c6b,0x2(%eax,%eax,1),%esp
 7a8:	00 
 7a9:	00 04 06             	add    %al,(%esi,%eax,1)
 7ac:	97                   	xchg   %eax,%edi
 7ad:	03 00                	add    (%eax),%eax
 7af:	00 02                	add    %al,(%edx)
 7b1:	6f                   	outsl  %ds:(%esi),(%dx)
 7b2:	e4 00                	in     $0x0,%al
 7b4:	00 00                	add    %al,(%eax)
 7b6:	05 06 db 03 00       	add    $0x3db06,%eax
 7bb:	00 02                	add    %al,(%edx)
 7bd:	70 69                	jo     828 <PR_BOOTABLE+0x7a8>
 7bf:	00 00                	add    %al,(%eax)
 7c1:	00 08                	add    %cl,(%eax)
 7c3:	06                   	push   %es
 7c4:	97                   	xchg   %eax,%edi
 7c5:	04 00                	add    $0x0,%al
 7c7:	00 02                	add    %al,(%edx)
 7c9:	71 69                	jno    834 <PR_BOOTABLE+0x7b4>
 7cb:	00 00                	add    %al,(%eax)
 7cd:	00 0c 00             	add    %cl,(%eax,%eax,1)
 7d0:	08 2c 00             	or     %ch,(%eax,%eax,1)
 7d3:	00 00                	add    %al,(%eax)
 7d5:	f4                   	hlt    
 7d6:	00 00                	add    %al,(%eax)
 7d8:	00 09                	add    %cl,(%ecx)
 7da:	f4                   	hlt    
 7db:	00 00                	add    %al,(%eax)
 7dd:	00 02                	add    %al,(%edx)
 7df:	00 02                	add    %al,(%edx)
 7e1:	04 07                	add    $0x7,%al
 7e3:	1a 00                	sbb    (%eax),%al
 7e5:	00 00                	add    %al,(%eax)
 7e7:	0a 6d 62             	or     0x62(%ebp),%ch
 7ea:	72 00                	jb     7ec <PR_BOOTABLE+0x76c>
 7ec:	00 02                	add    %al,(%edx)
 7ee:	02 61 3c             	add    0x3c(%ecx),%ah
 7f1:	01 00                	add    %eax,(%eax)
 7f3:	00 06                	add    %al,(%esi)
 7f5:	f4                   	hlt    
 7f6:	01 00                	add    %eax,(%eax)
 7f8:	00 02                	add    %al,(%edx)
 7fa:	63 3c 01             	arpl   %di,(%ecx,%eax,1)
 7fd:	00 00                	add    %al,(%eax)
 7ff:	00 0b                	add    %cl,(%ebx)
 801:	8b 01                	mov    (%ecx),%eax
 803:	00 00                	add    %al,(%eax)
 805:	02 64 4d 01          	add    0x1(%ebp,%ecx,2),%ah
 809:	00 00                	add    %al,(%eax)
 80b:	b4 01                	mov    $0x1,%ah
 80d:	0b 91 02 00 00 02    	or     0x2000002(%ecx),%edx
 813:	72 5d                	jb     872 <PR_BOOTABLE+0x7f2>
 815:	01 00                	add    %eax,(%eax)
 817:	00 be 01 0b 04 04    	add    %bh,0x4040b01(%esi)
 81d:	00 00                	add    %al,(%eax)
 81f:	02 73 6d             	add    0x6d(%ebx),%dh
 822:	01 00                	add    %eax,(%eax)
 824:	00 fe                	add    %bh,%dh
 826:	01 00                	add    %eax,(%eax)
 828:	08 2c 00             	or     %ch,(%eax,%eax,1)
 82b:	00 00                	add    %al,(%eax)
 82d:	4d                   	dec    %ebp
 82e:	01 00                	add    %eax,(%eax)
 830:	00 0c f4             	add    %cl,(%esp,%esi,8)
 833:	00 00                	add    %al,(%eax)
 835:	00 b3 01 00 08 2c    	add    %dh,0x2c080001(%ebx)
 83b:	00 00                	add    %al,(%eax)
 83d:	00 5d 01             	add    %bl,0x1(%ebp)
 840:	00 00                	add    %al,(%eax)
 842:	09 f4                	or     %esi,%esp
 844:	00 00                	add    %al,(%eax)
 846:	00 09                	add    %cl,(%ecx)
 848:	00 08                	add    %cl,(%eax)
 84a:	94                   	xchg   %eax,%esp
 84b:	00 00                	add    %al,(%eax)
 84d:	00 6d 01             	add    %ch,0x1(%ebp)
 850:	00 00                	add    %al,(%eax)
 852:	09 f4                	or     %esi,%esp
 854:	00 00                	add    %al,(%eax)
 856:	00 03                	add    %al,(%ebx)
 858:	00 08                	add    %cl,(%eax)
 85a:	2c 00                	sub    $0x0,%al
 85c:	00 00                	add    %al,(%eax)
 85e:	7d 01                	jge    861 <PR_BOOTABLE+0x7e1>
 860:	00 00                	add    %al,(%eax)
 862:	09 f4                	or     %esi,%esp
 864:	00 00                	add    %al,(%eax)
 866:	00 01                	add    %al,(%ecx)
 868:	00 03                	add    %al,(%ebx)
 86a:	6f                   	outsl  %ds:(%esi),(%dx)
 86b:	02 00                	add    (%eax),%al
 86d:	00 02                	add    %al,(%edx)
 86f:	74 fb                	je     86c <PR_BOOTABLE+0x7ec>
 871:	00 00                	add    %al,(%eax)
 873:	00 0d fd 02 00 00    	add    %cl,0x2fd
 879:	18 02                	sbb    %al,(%edx)
 87b:	7e c5                	jle    842 <PR_BOOTABLE+0x7c2>
 87d:	01 00                	add    %eax,(%eax)
 87f:	00 06                	add    %al,(%esi)
 881:	d6                   	(bad)  
 882:	03 00                	add    (%eax),%eax
 884:	00 02                	add    %al,(%edx)
 886:	7f 69                	jg     8f1 <PR_BOOTABLE+0x871>
 888:	00 00                	add    %al,(%eax)
 88a:	00 00                	add    %al,(%eax)
 88c:	06                   	push   %es
 88d:	a0 03 00 00 02       	mov    0x2000003,%al
 892:	80 82 00 00 00 04 06 	addb   $0x6,0x4000000(%edx)
 899:	2d 03 00 00 02       	sub    $0x2000003,%eax
 89e:	81 82 00 00 00 0c 06 	addl   $0x27706,0xc000000(%edx)
 8a5:	77 02 00 
 8a8:	00 02                	add    %al,(%edx)
 8aa:	82                   	(bad)  
 8ab:	69 00 00 00 14 00    	imul   $0x140000,(%eax),%eax
 8b1:	03 a6 02 00 00 02    	add    0x2000002(%esi),%esp
 8b7:	83 88 01 00 00 0d 94 	orl    $0xffffff94,0xd000001(%eax)
 8be:	01 00                	add    %eax,(%eax)
 8c0:	00 34 02             	add    %dh,(%edx,%eax,1)
 8c3:	8b 91 02 00 00 06    	mov    0x6000002(%ecx),%edx
 8c9:	8f 03                	popl   (%ebx)
 8cb:	00 00                	add    %al,(%eax)
 8cd:	02 8c 69 00 00 00 00 	add    0x0(%ecx,%ebp,2),%cl
 8d4:	06                   	push   %es
 8d5:	68 03 00 00 02       	push   $0x2000003
 8da:	8d 91 02 00 00 04    	lea    0x4000002(%ecx),%edx
 8e0:	06                   	push   %es
 8e1:	75 02                	jne    8e5 <PR_BOOTABLE+0x865>
 8e3:	00 00                	add    %al,(%eax)
 8e5:	02 8e 45 00 00 00    	add    0x45(%esi),%cl
 8eb:	10 06                	adc    %al,(%esi)
 8ed:	0f 02 00             	lar    (%eax),%eax
 8f0:	00 02                	add    %al,(%edx)
 8f2:	8f 45 00             	popl   0x0(%ebp)
 8f5:	00 00                	add    %al,(%eax)
 8f7:	12 06                	adc    (%esi),%al
 8f9:	d6                   	(bad)  
 8fa:	02 00                	add    (%eax),%al
 8fc:	00 02                	add    %al,(%edx)
 8fe:	90                   	nop
 8ff:	69 00 00 00 14 06    	imul   $0x6140000,(%eax),%eax
 905:	c6 01 00             	movb   $0x0,(%ecx)
 908:	00 02                	add    %al,(%edx)
 90a:	91                   	xchg   %eax,%ecx
 90b:	69 00 00 00 18 06    	imul   $0x6180000,(%eax),%eax
 911:	9b                   	fwait
 912:	01 00                	add    %eax,(%eax)
 914:	00 02                	add    %al,(%edx)
 916:	92                   	xchg   %eax,%edx
 917:	69 00 00 00 1c 06    	imul   $0x61c0000,(%eax),%eax
 91d:	b3 03                	mov    $0x3,%bl
 91f:	00 00                	add    %al,(%eax)
 921:	02 93 69 00 00 00    	add    0x69(%ebx),%dl
 927:	20 06                	and    %al,(%esi)
 929:	ff 01                	incl   (%ecx)
 92b:	00 00                	add    %al,(%eax)
 92d:	02 94 69 00 00 00 24 	add    0x24000000(%ecx,%ebp,2),%dl
 934:	06                   	push   %es
 935:	88 02                	mov    %al,(%edx)
 937:	00 00                	add    %al,(%eax)
 939:	02 95 45 00 00 00    	add    0x45(%ebp),%dl
 93f:	28 06                	sub    %al,(%esi)
 941:	19 02                	sbb    %eax,(%edx)
 943:	00 00                	add    %al,(%eax)
 945:	02 96 45 00 00 00    	add    0x45(%esi),%dl
 94b:	2a 06                	sub    (%esi),%al
 94d:	fc                   	cld    
 94e:	03 00                	add    (%eax),%eax
 950:	00 02                	add    %al,(%edx)
 952:	97                   	xchg   %eax,%edi
 953:	45                   	inc    %ebp
 954:	00 00                	add    %al,(%eax)
 956:	00 2c 06             	add    %ch,(%esi,%eax,1)
 959:	5d                   	pop    %ebp
 95a:	02 00                	add    (%eax),%al
 95c:	00 02                	add    %al,(%edx)
 95e:	98                   	cwtl   
 95f:	45                   	inc    %ebp
 960:	00 00                	add    %al,(%eax)
 962:	00 2e                	add    %ch,(%esi)
 964:	06                   	push   %es
 965:	0e                   	push   %cs
 966:	04 00                	add    $0x0,%al
 968:	00 02                	add    %al,(%edx)
 96a:	99                   	cltd   
 96b:	45                   	inc    %ebp
 96c:	00 00                	add    %al,(%eax)
 96e:	00 30                	add    %dh,(%eax)
 970:	06                   	push   %es
 971:	9b                   	fwait
 972:	02 00                	add    (%eax),%al
 974:	00 02                	add    %al,(%edx)
 976:	9a 45 00 00 00 32 00 	lcall  $0x32,$0x45
 97d:	08 2c 00             	or     %ch,(%eax,%eax,1)
 980:	00 00                	add    %al,(%eax)
 982:	a1 02 00 00 09       	mov    0x9000002,%eax
 987:	f4                   	hlt    
 988:	00 00                	add    %al,(%eax)
 98a:	00 0b                	add    %cl,(%ebx)
 98c:	00 03                	add    %al,(%ebx)
 98e:	ad                   	lods   %ds:(%esi),%eax
 98f:	01 00                	add    %eax,(%eax)
 991:	00 02                	add    %al,(%edx)
 993:	9b                   	fwait
 994:	d0 01                	rolb   (%ecx)
 996:	00 00                	add    %al,(%eax)
 998:	0d 55 02 00 00       	or     $0x255,%eax
 99d:	20 02                	and    %al,(%edx)
 99f:	9e                   	sahf   
 9a0:	19 03                	sbb    %eax,(%ebx)
 9a2:	00 00                	add    %al,(%eax)
 9a4:	06                   	push   %es
 9a5:	4e                   	dec    %esi
 9a6:	02 00                	add    (%eax),%al
 9a8:	00 02                	add    %al,(%edx)
 9aa:	9f                   	lahf   
 9ab:	69 00 00 00 00 06    	imul   $0x6000000,(%eax),%eax
 9b1:	eb 01                	jmp    9b4 <PR_BOOTABLE+0x934>
 9b3:	00 00                	add    %al,(%eax)
 9b5:	02 a0 69 00 00 00    	add    0x69(%eax),%ah
 9bb:	04 06                	add    $0x6,%al
 9bd:	3f                   	aas    
 9be:	03 00                	add    (%eax),%eax
 9c0:	00 02                	add    %al,(%edx)
 9c2:	a1 69 00 00 00       	mov    0x69,%eax
 9c7:	08 06                	or     %al,(%esi)
 9c9:	92                   	xchg   %eax,%edx
 9ca:	04 00                	add    $0x0,%al
 9cc:	00 02                	add    %al,(%edx)
 9ce:	a2 69 00 00 00       	mov    %al,0x69
 9d3:	0c 06                	or     $0x6,%al
 9d5:	f3 03 00             	repz add (%eax),%eax
 9d8:	00 02                	add    %al,(%edx)
 9da:	a3 69 00 00 00       	mov    %eax,0x69
 9df:	10 06                	adc    %al,(%esi)
 9e1:	e3 01                	jecxz  9e4 <PR_BOOTABLE+0x964>
 9e3:	00 00                	add    %al,(%eax)
 9e5:	02 a4 69 00 00 00 14 	add    0x14000000(%ecx,%ebp,2),%ah
 9ec:	06                   	push   %es
 9ed:	55                   	push   %ebp
 9ee:	03 00                	add    (%eax),%eax
 9f0:	00 02                	add    %al,(%edx)
 9f2:	a5                   	movsl  %ds:(%esi),%es:(%edi)
 9f3:	69 00 00 00 18 06    	imul   $0x6180000,(%eax),%eax
 9f9:	80 04 00 00          	addb   $0x0,(%eax,%eax,1)
 9fd:	02 a6 69 00 00 00    	add    0x69(%esi),%ah
 a03:	1c 00                	sbb    $0x0,%al
 a05:	03 55 02             	add    0x2(%ebp),%edx
 a08:	00 00                	add    %al,(%eax)
 a0a:	02 a7 ac 02 00 00    	add    0x2ac(%edi),%ah
 a10:	05 04 02 b6 5d       	add    $0x5db60204,%eax
 a15:	03 00                	add    (%eax),%eax
 a17:	00 06                	add    %al,(%esi)
 a19:	ec                   	in     (%dx),%al
 a1a:	02 00                	add    (%eax),%al
 a1c:	00 02                	add    %al,(%edx)
 a1e:	b7 2c                	mov    $0x2c,%bh
 a20:	00 00                	add    %al,(%eax)
 a22:	00 00                	add    %al,(%eax)
 a24:	06                   	push   %es
 a25:	e0 02                	loopne a29 <PR_BOOTABLE+0x9a9>
 a27:	00 00                	add    %al,(%eax)
 a29:	02 b8 2c 00 00 00    	add    0x2c(%eax),%bh
 a2f:	01 06                	add    %eax,(%esi)
 a31:	e6 02                	out    %al,$0x2
 a33:	00 00                	add    %al,(%eax)
 a35:	02 b9 2c 00 00 00    	add    0x2c(%ecx),%bh
 a3b:	02 06                	add    (%esi),%al
 a3d:	48                   	dec    %eax
 a3e:	02 00                	add    (%eax),%al
 a40:	00 02                	add    %al,(%edx)
 a42:	ba 2c 00 00 00       	mov    $0x2c,%edx
 a47:	03 00                	add    (%eax),%eax
 a49:	05 10 02 c7 96       	add    $0x96c70210,%eax
 a4e:	03 00                	add    (%eax),%eax
 a50:	00 06                	add    %al,(%esi)
 a52:	d3 03                	roll   %cl,(%ebx)
 a54:	00 00                	add    %al,(%eax)
 a56:	02 c8                	add    %al,%cl
 a58:	69 00 00 00 00 06    	imul   $0x6000000,(%eax),%eax
 a5e:	40                   	inc    %eax
 a5f:	02 00                	add    (%eax),%al
 a61:	00 02                	add    %al,(%edx)
 a63:	c9                   	leave  
 a64:	69 00 00 00 04 06    	imul   $0x6040000,(%eax),%eax
 a6a:	a5                   	movsl  %ds:(%esi),%es:(%edi)
 a6b:	03 00                	add    (%eax),%eax
 a6d:	00 02                	add    %al,(%edx)
 a6f:	ca 69 00             	lret   $0x69
 a72:	00 00                	add    %al,(%eax)
 a74:	08 06                	or     %al,(%esi)
 a76:	4a                   	dec    %edx
 a77:	04 00                	add    $0x0,%al
 a79:	00 02                	add    %al,(%edx)
 a7b:	cb                   	lret   
 a7c:	69 00 00 00 0c 00    	imul   $0xc0000,(%eax),%eax
 a82:	05 10 02 cd cf       	add    $0xcfcd0210,%eax
 a87:	03 00                	add    (%eax),%eax
 a89:	00 07                	add    %al,(%edi)
 a8b:	6e                   	outsb  %ds:(%esi),(%dx)
 a8c:	75 6d                	jne    afb <PR_BOOTABLE+0xa7b>
 a8e:	00 02                	add    %al,(%edx)
 a90:	ce                   	into   
 a91:	69 00 00 00 00 06    	imul   $0x6000000,(%eax),%eax
 a97:	d6                   	(bad)  
 a98:	03 00                	add    (%eax),%eax
 a9a:	00 02                	add    %al,(%edx)
 a9c:	cf                   	iret   
 a9d:	69 00 00 00 04 06    	imul   $0x6040000,(%eax),%eax
 aa3:	a5                   	movsl  %ds:(%esi),%es:(%edi)
 aa4:	03 00                	add    (%eax),%eax
 aa6:	00 02                	add    %al,(%edx)
 aa8:	d0 69 00             	shrb   0x0(%ecx)
 aab:	00 00                	add    %al,(%eax)
 aad:	08 06                	or     %al,(%esi)
 aaf:	69 02 00 00 02 d1    	imul   $0xd1020000,(%edx),%eax
 ab5:	69 00 00 00 0c 00    	imul   $0xc0000,(%eax),%eax
 abb:	0e                   	push   %cs
 abc:	10 02                	adc    %al,(%edx)
 abe:	c6                   	(bad)  
 abf:	ee                   	out    %al,(%dx)
 ac0:	03 00                	add    (%eax),%eax
 ac2:	00 0f                	add    %cl,(%edi)
 ac4:	3b 02                	cmp    (%edx),%eax
 ac6:	00 00                	add    %al,(%eax)
 ac8:	02 cc                	add    %ah,%cl
 aca:	5d                   	pop    %ebp
 acb:	03 00                	add    (%eax),%eax
 acd:	00 10                	add    %dl,(%eax)
 acf:	65 6c                	gs insb (%dx),%es:(%edi)
 ad1:	66 00 02             	data16 add %al,(%edx)
 ad4:	d2 96 03 00 00 00    	rclb   %cl,0x3(%esi)
 ada:	0d 34 03 00 00       	or     $0x334,%eax
 adf:	60                   	pusha  
 ae0:	02 ae f7 04 00 00    	add    0x4f7(%esi),%ch
 ae6:	06                   	push   %es
 ae7:	01 02                	add    %eax,(%edx)
 ae9:	00 00                	add    %al,(%eax)
 aeb:	02 af 69 00 00 00    	add    0x69(%edi),%ch
 af1:	00 06                	add    %al,(%esi)
 af3:	07                   	pop    %es
 af4:	03 00                	add    (%eax),%eax
 af6:	00 02                	add    %al,(%edx)
 af8:	b2 69                	mov    $0x69,%dl
 afa:	00 00                	add    %al,(%eax)
 afc:	00 04 06             	add    %al,(%esi,%eax,1)
 aff:	bb 03 00 00 02       	mov    $0x2000003,%ebx
 b04:	b3 69                	mov    $0x69,%bl
 b06:	00 00                	add    %al,(%eax)
 b08:	00 08                	add    %cl,(%eax)
 b0a:	06                   	push   %es
 b0b:	6e                   	outsb  %ds:(%esi),(%dx)
 b0c:	03 00                	add    (%eax),%eax
 b0e:	00 02                	add    %al,(%edx)
 b10:	bb 24 03 00 00       	mov    $0x324,%ebx
 b15:	0c 06                	or     $0x6,%al
 b17:	07                   	pop    %es
 b18:	02 00                	add    (%eax),%al
 b1a:	00 02                	add    %al,(%edx)
 b1c:	be 69 00 00 00       	mov    $0x69,%esi
 b21:	10 06                	adc    %al,(%esi)
 b23:	3f                   	aas    
 b24:	04 00                	add    $0x0,%al
 b26:	00 02                	add    %al,(%edx)
 b28:	c2 69 00             	ret    $0x69
 b2b:	00 00                	add    %al,(%eax)
 b2d:	14 06                	adc    $0x6,%al
 b2f:	31 02                	xor    %eax,(%edx)
 b31:	00 00                	add    %al,(%eax)
 b33:	02 c3                	add    %bl,%al
 b35:	69 00 00 00 18 06    	imul   $0x6180000,(%eax),%eax
 b3b:	1a 03                	sbb    (%ebx),%al
 b3d:	00 00                	add    %al,(%eax)
 b3f:	02 d3                	add    %bl,%dl
 b41:	cf                   	iret   
 b42:	03 00                	add    (%eax),%eax
 b44:	00 1c 06             	add    %bl,(%esi,%eax,1)
 b47:	28 03                	sub    %al,(%ebx)
 b49:	00 00                	add    %al,(%eax)
 b4b:	02 d6                	add    %dh,%dl
 b4d:	69 00 00 00 2c 06    	imul   $0x62c0000,(%eax),%eax
 b53:	a3 01 00 00 02       	mov    %eax,0x2000001
 b58:	d8 69 00             	fsubrs 0x0(%ecx)
 b5b:	00 00                	add    %al,(%eax)
 b5d:	30 06                	xor    %al,(%esi)
 b5f:	e5 03                	in     $0x3,%eax
 b61:	00 00                	add    %al,(%eax)
 b63:	02 dc                	add    %ah,%bl
 b65:	69 00 00 00 34 06    	imul   $0x6340000,(%eax),%eax
 b6b:	7c 02                	jl     b6f <PR_BOOTABLE+0xaef>
 b6d:	00 00                	add    %al,(%eax)
 b6f:	02 dd                	add    %ch,%bl
 b71:	69 00 00 00 38 06    	imul   $0x6380000,(%eax),%eax
 b77:	82                   	(bad)  
 b78:	03 00                	add    (%eax),%eax
 b7a:	00 02                	add    %al,(%edx)
 b7c:	e0 69                	loopne be7 <PR_BOOTABLE+0xb67>
 b7e:	00 00                	add    %al,(%eax)
 b80:	00 3c 06             	add    %bh,(%esi,%eax,1)
 b83:	54                   	push   %esp
 b84:	04 00                	add    $0x0,%al
 b86:	00 02                	add    %al,(%edx)
 b88:	e3 69                	jecxz  bf3 <PR_BOOTABLE+0xb73>
 b8a:	00 00                	add    %al,(%eax)
 b8c:	00 40 06             	add    %al,0x6(%eax)
 b8f:	88 04 00             	mov    %al,(%eax,%eax,1)
 b92:	00 02                	add    %al,(%edx)
 b94:	e6 69                	out    %al,$0x69
 b96:	00 00                	add    %al,(%eax)
 b98:	00 44 06 44          	add    %al,0x44(%esi,%eax,1)
 b9c:	03 00                	add    (%eax),%eax
 b9e:	00 02                	add    %al,(%edx)
 ba0:	e9 69 00 00 00       	jmp    c0e <PR_BOOTABLE+0xb8e>
 ba5:	48                   	dec    %eax
 ba6:	06                   	push   %es
 ba7:	c5 03                	lds    (%ebx),%eax
 ba9:	00 00                	add    %al,(%eax)
 bab:	02 ea                	add    %dl,%ch
 bad:	69 00 00 00 4c 06    	imul   $0x64c0000,(%eax),%eax
 bb3:	aa                   	stos   %al,%es:(%edi)
 bb4:	03 00                	add    (%eax),%eax
 bb6:	00 02                	add    %al,(%edx)
 bb8:	eb 69                	jmp    c23 <PR_BOOTABLE+0xba3>
 bba:	00 00                	add    %al,(%eax)
 bbc:	00 50 06             	add    %dl,0x6(%eax)
 bbf:	65 04 00             	gs add $0x0,%al
 bc2:	00 02                	add    %al,(%edx)
 bc4:	ec                   	in     (%dx),%al
 bc5:	69 00 00 00 54 06    	imul   $0x6540000,(%eax),%eax
 bcb:	b4 01                	mov    $0x1,%ah
 bcd:	00 00                	add    %al,(%eax)
 bcf:	02 ed                	add    %ch,%ch
 bd1:	69 00 00 00 58 06    	imul   $0x6580000,(%eax),%eax
 bd7:	16                   	push   %ss
 bd8:	04 00                	add    $0x0,%al
 bda:	00 02                	add    %al,(%edx)
 bdc:	ee                   	out    %al,(%dx)
 bdd:	69 00 00 00 5c 00    	imul   $0x5c0000,(%eax),%eax
 be3:	03 b2 02 00 00 02    	add    0x2000002(%edx),%esi
 be9:	ef                   	out    %eax,(%dx)
 bea:	ee                   	out    %al,(%dx)
 beb:	03 00                	add    (%eax),%eax
 bed:	00 11                	add    %dl,(%ecx)
 bef:	d7                   	xlat   %ds:(%ebx)
 bf0:	01 00                	add    %eax,(%eax)
 bf2:	00 01                	add    %al,(%ecx)
 bf4:	2f                   	das    
 bf5:	69 00 00 00 6a 8d    	imul   $0x8d6a0000,(%eax),%eax
 bfb:	00 00                	add    %al,(%eax)
 bfd:	82                   	(bad)  
 bfe:	00 00                	add    %al,(%eax)
 c00:	00 01                	add    %al,(%ecx)
 c02:	9c                   	pushf  
 c03:	62 05 00 00 12 7a    	bound  %eax,0x7a120000
 c09:	03 00                	add    (%eax),%eax
 c0b:	00 01                	add    %al,(%ecx)
 c0d:	2f                   	das    
 c0e:	69 00 00 00 02 91    	imul   $0x91020000,(%eax),%eax
 c14:	00 13                	add    %dl,(%ebx)
 c16:	70 68                	jo     c80 <PR_BOOTABLE+0xc00>
 c18:	00 01                	add    %al,(%ecx)
 c1a:	32 62 05             	xor    0x5(%edx),%ah
 c1d:	00 00                	add    %al,(%eax)
 c1f:	eb 02                	jmp    c23 <PR_BOOTABLE+0xba3>
 c21:	00 00                	add    %al,(%eax)
 c23:	13 65 70             	adc    0x70(%ebp),%esp
 c26:	68 00 01 32 62       	push   $0x62320100
 c2b:	05 00 00 16 03       	add    $0x3160000,%eax
 c30:	00 00                	add    %al,(%eax)
 c32:	14 88                	adc    $0x88,%al
 c34:	8d 00                	lea    (%eax),%eax
 c36:	00 9d 06 00 00 14    	add    %bl,0x14000006(%ebp)
 c3c:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 c3d:	8d 00                	lea    (%eax),%eax
 c3f:	00 bd 06 00 00 14    	add    %bh,0x14000006(%ebp)
 c45:	d5 8d                	aad    $0x8d
 c47:	00 00                	add    %al,(%eax)
 c49:	9d                   	popf   
 c4a:	06                   	push   %es
 c4b:	00 00                	add    %al,(%eax)
 c4d:	00 15 04 19 03 00    	add    %dl,0x31904
 c53:	00 11                	add    %dl,(%ecx)
 c55:	5d                   	pop    %ebp
 c56:	03 00                	add    (%eax),%eax
 c58:	00 01                	add    %al,(%ecx)
 c5a:	47                   	inc    %edi
 c5b:	be 05 00 00 ec       	mov    $0xec000005,%esi
 c60:	8d 00                	lea    (%eax),%eax
 c62:	00 5f 00             	add    %bl,0x0(%edi)
 c65:	00 00                	add    %al,(%eax)
 c67:	01 9c be 05 00 00 12 	add    %ebx,0x12000005(%esi,%edi,4)
 c6e:	02 03                	add    (%ebx),%al
 c70:	00 00                	add    %al,(%eax)
 c72:	01 47 c4             	add    %eax,-0x3c(%edi)
 c75:	05 00 00 02 91       	add    $0x91020000,%eax
 c7a:	00 13                	add    %dl,(%ebx)
 c7c:	70 00                	jo     c7e <PR_BOOTABLE+0xbfe>
 c7e:	01 49 c4             	add    %ecx,-0x3c(%ecx)
 c81:	05 00 00 29 03       	add    $0x3290000,%eax
 c86:	00 00                	add    %al,(%eax)
 c88:	16                   	push   %ss
 c89:	77 04                	ja     c8f <PR_BOOTABLE+0xc0f>
 c8b:	00 00                	add    %al,(%eax)
 c8d:	01 4a 69             	add    %ecx,0x69(%edx)
 c90:	00 00                	add    %al,(%eax)
 c92:	00 60 03             	add    %ah,0x3(%eax)
 c95:	00 00                	add    %al,(%eax)
 c97:	14 01                	adc    $0x1,%al
 c99:	8e 00                	mov    (%eax),%es
 c9b:	00 db                	add    %bl,%bl
 c9d:	06                   	push   %es
 c9e:	00 00                	add    %al,(%eax)
 ca0:	14 20                	adc    $0x20,%al
 ca2:	8e 00                	mov    (%eax),%es
 ca4:	00 ec                	add    %ch,%ah
 ca6:	06                   	push   %es
 ca7:	00 00                	add    %al,(%eax)
 ca9:	00 15 04 f7 04 00    	add    %dl,0x4f704
 caf:	00 15 04 c5 01 00    	add    %dl,0x1c504
 cb5:	00 17                	add    %dl,(%edi)
 cb7:	cc                   	int3   
 cb8:	02 00                	add    (%eax),%al
 cba:	00 01                	add    %al,(%ecx)
 cbc:	0c 4b                	or     $0x4b,%al
 cbe:	8e 00                	mov    (%eax),%es
 cc0:	00 a6 00 00 00 01    	add    %ah,0x1000000(%esi)
 cc6:	9c                   	pushf  
 cc7:	86 06                	xchg   %al,(%esi)
 cc9:	00 00                	add    %al,(%eax)
 ccb:	18 64 65 76          	sbb    %ah,0x76(%ebp,%eiz,2)
 ccf:	00 01                	add    %al,(%ecx)
 cd1:	0c 69                	or     $0x69,%al
 cd3:	00 00                	add    %al,(%eax)
 cd5:	00 02                	add    %al,(%edx)
 cd7:	91                   	xchg   %eax,%ecx
 cd8:	00 18                	add    %bl,(%eax)
 cda:	6d                   	insl   (%dx),%es:(%edi)
 cdb:	62 72 00             	bound  %esi,0x0(%edx)
 cde:	01 0c 86             	add    %ecx,(%esi,%eax,4)
 ce1:	06                   	push   %es
 ce2:	00 00                	add    %al,(%eax)
 ce4:	02 91 04 12 02 03    	add    0x3021204(%ecx),%dl
 cea:	00 00                	add    %al,(%eax)
 cec:	01 0c c4             	add    %ecx,(%esp,%eax,8)
 cef:	05 00 00 02 91       	add    $0x91020000,%eax
 cf4:	08 13                	or     %dl,(%ebx)
 cf6:	69 00 01 11 62 00    	imul   $0x621101,(%eax),%eax
 cfc:	00 00                	add    %al,(%eax)
 cfe:	ac                   	lods   %ds:(%esi),%al
 cff:	03 00                	add    (%eax),%eax
 d01:	00 16                	add    %dl,(%esi)
 d03:	bf 02 00 00 01       	mov    $0x1000002,%edi
 d08:	12 69 00             	adc    0x0(%ecx),%ch
 d0b:	00 00                	add    %al,(%eax)
 d0d:	e3 03                	jecxz  d12 <PR_BOOTABLE+0xc92>
 d0f:	00 00                	add    %al,(%eax)
 d11:	16                   	push   %ss
 d12:	c8 01 00 00          	enter  $0x1,$0x0
 d16:	01 22                	add    %esp,(%edx)
 d18:	69 00 00 00 0e 04    	imul   $0x40e0000,(%eax),%eax
 d1e:	00 00                	add    %al,(%eax)
 d20:	14 60                	adc    $0x60,%al
 d22:	8e 00                	mov    (%eax),%es
 d24:	00 fd                	add    %bh,%ch
 d26:	06                   	push   %es
 d27:	00 00                	add    %al,(%eax)
 d29:	14 6c                	adc    $0x6c,%al
 d2b:	8e 00                	mov    (%eax),%es
 d2d:	00 db                	add    %bl,%bl
 d2f:	06                   	push   %es
 d30:	00 00                	add    %al,(%eax)
 d32:	14 a1                	adc    $0xa1,%al
 d34:	8e 00                	mov    (%eax),%es
 d36:	00 bd 06 00 00 14    	add    %bh,0x14000006(%ebp)
 d3c:	ad                   	lods   %ds:(%esi),%eax
 d3d:	8e 00                	mov    (%eax),%es
 d3f:	00 68 05             	add    %ch,0x5(%eax)
 d42:	00 00                	add    %al,(%eax)
 d44:	14 b9                	adc    $0xb9,%al
 d46:	8e 00                	mov    (%eax),%es
 d48:	00 db                	add    %bl,%bl
 d4a:	06                   	push   %es
 d4b:	00 00                	add    %al,(%eax)
 d4d:	14 c1                	adc    $0xc1,%al
 d4f:	8e 00                	mov    (%eax),%es
 d51:	00 02                	add    %al,(%edx)
 d53:	05 00 00 14 cf       	add    $0xcf140000,%eax
 d58:	8e 00                	mov    (%eax),%es
 d5a:	00 db                	add    %bl,%bl
 d5c:	06                   	push   %es
 d5d:	00 00                	add    %al,(%eax)
 d5f:	14 dc                	adc    $0xdc,%al
 d61:	8e 00                	mov    (%eax),%es
 d63:	00 0e                	add    %cl,(%esi)
 d65:	07                   	pop    %es
 d66:	00 00                	add    %al,(%eax)
 d68:	19 f1                	sbb    %esi,%ecx
 d6a:	8e 00                	mov    (%eax),%es
 d6c:	00 bd 06 00 00 00    	add    %bh,0x6(%ebp)
 d72:	15 04 7d 01 00       	adc    $0x17d04,%eax
 d77:	00 1a                	add    %bl,(%edx)
 d79:	34 03                	xor    $0x3,%al
 d7b:	00 00                	add    %al,(%eax)
 d7d:	01 08                	add    %ecx,(%eax)
 d7f:	f7 04 00 00 05 03 84 	testl  $0x84030500,(%eax,%eax,1)
 d86:	92                   	xchg   %eax,%edx
 d87:	00 00                	add    %al,(%eax)
 d89:	1b d4                	sbb    %esp,%edx
 d8b:	00 00                	add    %al,(%eax)
 d8d:	00 02                	add    %al,(%edx)
 d8f:	78 bd                	js     d4e <PR_BOOTABLE+0xcce>
 d91:	06                   	push   %es
 d92:	00 00                	add    %al,(%eax)
 d94:	1c 69                	sbb    $0x69,%al
 d96:	00 00                	add    %al,(%eax)
 d98:	00 1c 69             	add    %bl,(%ecx,%ebp,2)
 d9b:	00 00                	add    %al,(%eax)
 d9d:	00 1c 69             	add    %bl,(%ecx,%ebp,2)
 da0:	00 00                	add    %al,(%eax)
 da2:	00 1c 69             	add    %bl,(%ecx,%ebp,2)
 da5:	00 00                	add    %al,(%eax)
 da7:	00 00                	add    %al,(%eax)
 da9:	1b 28                	sbb    (%eax),%ebp
 dab:	00 00                	add    %al,(%eax)
 dad:	00 02                	add    %al,(%edx)
 daf:	52                   	push   %edx
 db0:	ce                   	into   
 db1:	06                   	push   %es
 db2:	00 00                	add    %al,(%eax)
 db4:	1c ce                	sbb    $0xce,%al
 db6:	06                   	push   %es
 db7:	00 00                	add    %al,(%eax)
 db9:	00 15 04 d4 06 00    	add    %dl,0x6d404
 dbf:	00 02                	add    %al,(%edx)
 dc1:	01 06                	add    %eax,(%esi)
 dc3:	e9 00 00 00 1b       	jmp    1b000dc8 <_end+0x1aff7ab8>
 dc8:	61                   	popa   
 dc9:	01 00                	add    %eax,(%eax)
 dcb:	00 02                	add    %al,(%edx)
 dcd:	4f                   	dec    %edi
 dce:	ec                   	in     (%dx),%al
 dcf:	06                   	push   %es
 dd0:	00 00                	add    %al,(%eax)
 dd2:	1c ce                	sbb    $0xce,%al
 dd4:	06                   	push   %es
 dd5:	00 00                	add    %al,(%eax)
 dd7:	00 1b                	add    %bl,(%ebx)
 dd9:	3c 00                	cmp    $0x0,%al
 ddb:	00 00                	add    %al,(%eax)
 ddd:	02 50 fd             	add    -0x3(%eax),%dl
 de0:	06                   	push   %es
 de1:	00 00                	add    %al,(%eax)
 de3:	1c 57                	sbb    $0x57,%al
 de5:	00 00                	add    %al,(%eax)
 de7:	00 00                	add    %al,(%eax)
 de9:	1b 23                	sbb    (%ebx),%esp
 deb:	00 00                	add    %al,(%eax)
 ded:	00 02                	add    %al,(%edx)
 def:	51                   	push   %ecx
 df0:	0e                   	push   %cs
 df1:	07                   	pop    %es
 df2:	00 00                	add    %al,(%eax)
 df4:	1c 62                	sbb    $0x62,%al
 df6:	00 00                	add    %al,(%eax)
 df8:	00 00                	add    %al,(%eax)
 dfa:	1d 25 02 00 00       	sbb    $0x225,%eax
 dff:	01 06                	add    %eax,(%esi)
 e01:	1c 69                	sbb    $0x69,%al
 e03:	00 00                	add    %al,(%eax)
 e05:	00 1c be             	add    %bl,(%esi,%edi,4)
 e08:	05 00 00 00 00       	add    $0x0,%eax
 e0d:	48                   	dec    %eax
 e0e:	00 00                	add    %al,(%eax)
 e10:	00 02                	add    %al,(%edx)
 e12:	00 cb                	add    %cl,%bl
 e14:	03 00                	add    (%eax),%eax
 e16:	00 04 01             	add    %al,(%ecx,%eax,1)
 e19:	95                   	xchg   %eax,%ebp
 e1a:	02 00                	add    (%eax),%al
 e1c:	00 f1                	add    %dh,%cl
 e1e:	8e 00                	mov    (%eax),%es
 e20:	00 01                	add    %al,(%ecx)
 e22:	8f 00                	popl   (%eax)
 e24:	00 62 6f             	add    %ah,0x6f(%edx)
 e27:	6f                   	outsl  %ds:(%esi),(%dx)
 e28:	74 2f                	je     e59 <PR_BOOTABLE+0xdd9>
 e2a:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 e2d:	74 31                	je     e60 <PR_BOOTABLE+0xde0>
 e2f:	2f                   	das    
 e30:	65 78 65             	gs js  e98 <PR_BOOTABLE+0xe18>
 e33:	63 5f 6b             	arpl   %bx,0x6b(%edi)
 e36:	65 72 6e             	gs jb  ea7 <PR_BOOTABLE+0xe27>
 e39:	65 6c                	gs insb (%dx),%es:(%edi)
 e3b:	2e 53                	cs push %ebx
 e3d:	00 2f                	add    %ch,(%edi)
 e3f:	72 6f                	jb     eb0 <PR_BOOTABLE+0xe30>
 e41:	6f                   	outsl  %ds:(%esi),(%dx)
 e42:	74 2f                	je     e73 <PR_BOOTABLE+0xdf3>
 e44:	63 6f 64             	arpl   %bp,0x64(%edi)
 e47:	65 00 47 4e          	add    %al,%gs:0x4e(%edi)
 e4b:	55                   	push   %ebp
 e4c:	20 41 53             	and    %al,0x53(%ecx)
 e4f:	20 32                	and    %dh,(%edx)
 e51:	2e 32 36             	xor    %cs:(%esi),%dh
 e54:	2e 31 00             	xor    %eax,%cs:(%eax)
 e57:	01                   	.byte 0x1
 e58:	80                   	.byte 0x80

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	01 11                	add    %edx,(%ecx)
   2:	00 10                	add    %dl,(%eax)
   4:	06                   	push   %es
   5:	11 01                	adc    %eax,(%ecx)
   7:	12 01                	adc    (%ecx),%al
   9:	03 08                	add    (%eax),%ecx
   b:	1b 08                	sbb    (%eax),%ecx
   d:	25 08 13 05 00       	and    $0x51308,%eax
  12:	00 00                	add    %al,(%eax)
  14:	01 11                	add    %edx,(%ecx)
  16:	01 25 0e 13 0b 03    	add    %esp,0x30b130e
  1c:	0e                   	push   %cs
  1d:	1b 0e                	sbb    (%esi),%ecx
  1f:	11 01                	adc    %eax,(%ecx)
  21:	12 06                	adc    (%esi),%al
  23:	10 17                	adc    %dl,(%edi)
  25:	00 00                	add    %al,(%eax)
  27:	02 24 00             	add    (%eax,%eax,1),%ah
  2a:	0b 0b                	or     (%ebx),%ecx
  2c:	3e 0b 03             	or     %ds:(%ebx),%eax
  2f:	0e                   	push   %cs
  30:	00 00                	add    %al,(%eax)
  32:	03 16                	add    (%esi),%edx
  34:	00 03                	add    %al,(%ebx)
  36:	0e                   	push   %cs
  37:	3a 0b                	cmp    (%ebx),%cl
  39:	3b 0b                	cmp    (%ebx),%ecx
  3b:	49                   	dec    %ecx
  3c:	13 00                	adc    (%eax),%eax
  3e:	00 04 24             	add    %al,(%esp)
  41:	00 0b                	add    %cl,(%ebx)
  43:	0b 3e                	or     (%esi),%edi
  45:	0b 03                	or     (%ebx),%eax
  47:	08 00                	or     %al,(%eax)
  49:	00 05 2e 01 03 08    	add    %al,0x803012e
  4f:	3a 0b                	cmp    (%ebx),%cl
  51:	3b 0b                	cmp    (%ebx),%ecx
  53:	27                   	daa    
  54:	19 49 13             	sbb    %ecx,0x13(%ecx)
  57:	20 0b                	and    %cl,(%ebx)
  59:	01 13                	add    %edx,(%ebx)
  5b:	00 00                	add    %al,(%eax)
  5d:	06                   	push   %es
  5e:	05 00 03 0e 3a       	add    $0x3a0e0300,%eax
  63:	0b 3b                	or     (%ebx),%edi
  65:	0b 49 13             	or     0x13(%ecx),%ecx
  68:	00 00                	add    %al,(%eax)
  6a:	07                   	pop    %es
  6b:	34 00                	xor    $0x0,%al
  6d:	03 0e                	add    (%esi),%ecx
  6f:	3a 0b                	cmp    (%ebx),%cl
  71:	3b 0b                	cmp    (%ebx),%ecx
  73:	49                   	dec    %ecx
  74:	13 00                	adc    (%eax),%eax
  76:	00 08                	add    %cl,(%eax)
  78:	2e 01 03             	add    %eax,%cs:(%ebx)
  7b:	0e                   	push   %cs
  7c:	3a 0b                	cmp    (%ebx),%cl
  7e:	3b 0b                	cmp    (%ebx),%ecx
  80:	27                   	daa    
  81:	19 20                	sbb    %esp,(%eax)
  83:	0b 01                	or     (%ecx),%eax
  85:	13 00                	adc    (%eax),%eax
  87:	00 09                	add    %cl,(%ecx)
  89:	05 00 03 08 3a       	add    $0x3a080300,%eax
  8e:	0b 3b                	or     (%ebx),%edi
  90:	0b 49 13             	or     0x13(%ecx),%ecx
  93:	00 00                	add    %al,(%eax)
  95:	0a 0f                	or     (%edi),%cl
  97:	00 0b                	add    %cl,(%ebx)
  99:	0b 00                	or     (%eax),%eax
  9b:	00 0b                	add    %cl,(%ebx)
  9d:	2e 01 3f             	add    %edi,%cs:(%edi)
  a0:	19 03                	sbb    %eax,(%ebx)
  a2:	0e                   	push   %cs
  a3:	3a 0b                	cmp    (%ebx),%cl
  a5:	3b 0b                	cmp    (%ebx),%ecx
  a7:	27                   	daa    
  a8:	19 11                	sbb    %edx,(%ecx)
  aa:	01 12                	add    %edx,(%edx)
  ac:	06                   	push   %es
  ad:	40                   	inc    %eax
  ae:	18 97 42 19 01 13    	sbb    %dl,0x13011942(%edi)
  b4:	00 00                	add    %al,(%eax)
  b6:	0c 05                	or     $0x5,%al
  b8:	00 03                	add    %al,(%ebx)
  ba:	08 3a                	or     %bh,(%edx)
  bc:	0b 3b                	or     (%ebx),%edi
  be:	0b 49 13             	or     0x13(%ecx),%ecx
  c1:	02 18                	add    (%eax),%bl
  c3:	00 00                	add    %al,(%eax)
  c5:	0d 05 00 03 0e       	or     $0xe030005,%eax
  ca:	3a 0b                	cmp    (%ebx),%cl
  cc:	3b 0b                	cmp    (%ebx),%ecx
  ce:	49                   	dec    %ecx
  cf:	13 02                	adc    (%edx),%eax
  d1:	18 00                	sbb    %al,(%eax)
  d3:	00 0e                	add    %cl,(%esi)
  d5:	34 00                	xor    $0x0,%al
  d7:	03 08                	add    (%eax),%ecx
  d9:	3a 0b                	cmp    (%ebx),%cl
  db:	3b 0b                	cmp    (%ebx),%ecx
  dd:	49                   	dec    %ecx
  de:	13 02                	adc    (%edx),%eax
  e0:	18 00                	sbb    %al,(%eax)
  e2:	00 0f                	add    %cl,(%edi)
  e4:	0f 00 0b             	str    (%ebx)
  e7:	0b 49 13             	or     0x13(%ecx),%ecx
  ea:	00 00                	add    %al,(%eax)
  ec:	10 35 00 49 13 00    	adc    %dh,0x134900
  f2:	00 11                	add    %dl,(%ecx)
  f4:	2e 01 3f             	add    %edi,%cs:(%edi)
  f7:	19 03                	sbb    %eax,(%ebx)
  f9:	0e                   	push   %cs
  fa:	3a 0b                	cmp    (%ebx),%cl
  fc:	3b 0b                	cmp    (%ebx),%ecx
  fe:	27                   	daa    
  ff:	19 49 13             	sbb    %ecx,0x13(%ecx)
 102:	11 01                	adc    %eax,(%ecx)
 104:	12 06                	adc    (%esi),%al
 106:	40                   	inc    %eax
 107:	18 97 42 19 01 13    	sbb    %dl,0x13011942(%edi)
 10d:	00 00                	add    %al,(%eax)
 10f:	12 05 00 03 0e 3a    	adc    0x3a0e0300,%al
 115:	0b 3b                	or     (%ebx),%edi
 117:	0b 49 13             	or     0x13(%ecx),%ecx
 11a:	02 17                	add    (%edi),%dl
 11c:	00 00                	add    %al,(%eax)
 11e:	13 34 00             	adc    (%eax,%eax,1),%esi
 121:	03 08                	add    (%eax),%ecx
 123:	3a 0b                	cmp    (%ebx),%cl
 125:	3b 0b                	cmp    (%ebx),%ecx
 127:	49                   	dec    %ecx
 128:	13 02                	adc    (%edx),%eax
 12a:	17                   	pop    %ss
 12b:	00 00                	add    %al,(%eax)
 12d:	14 89                	adc    $0x89,%al
 12f:	82                   	(bad)  
 130:	01 00                	add    %eax,(%eax)
 132:	11 01                	adc    %eax,(%ecx)
 134:	31 13                	xor    %edx,(%ebx)
 136:	00 00                	add    %al,(%eax)
 138:	15 26 00 49 13       	adc    $0x13490026,%eax
 13d:	00 00                	add    %al,(%eax)
 13f:	16                   	push   %ss
 140:	05 00 03 08 3a       	add    $0x3a080300,%eax
 145:	0b 3b                	or     (%ebx),%edi
 147:	0b 49 13             	or     0x13(%ecx),%ecx
 14a:	02 17                	add    (%edi),%dl
 14c:	00 00                	add    %al,(%eax)
 14e:	17                   	pop    %ss
 14f:	34 00                	xor    $0x0,%al
 151:	03 0e                	add    (%esi),%ecx
 153:	3a 0b                	cmp    (%ebx),%cl
 155:	3b 0b                	cmp    (%ebx),%ecx
 157:	49                   	dec    %ecx
 158:	13 02                	adc    (%edx),%eax
 15a:	17                   	pop    %ss
 15b:	00 00                	add    %al,(%eax)
 15d:	18 89 82 01 00 11    	sbb    %cl,0x11000182(%ecx)
 163:	01 95 42 19 31 13    	add    %edx,0x13311942(%ebp)
 169:	00 00                	add    %al,(%eax)
 16b:	19 01                	sbb    %eax,(%ecx)
 16d:	01 49 13             	add    %ecx,0x13(%ecx)
 170:	01 13                	add    %edx,(%ebx)
 172:	00 00                	add    %al,(%eax)
 174:	1a 21                	sbb    (%ecx),%ah
 176:	00 49 13             	add    %cl,0x13(%ecx)
 179:	2f                   	das    
 17a:	0b 00                	or     (%eax),%eax
 17c:	00 1b                	add    %bl,(%ebx)
 17e:	2e 00 03             	add    %al,%cs:(%ebx)
 181:	0e                   	push   %cs
 182:	3a 0b                	cmp    (%ebx),%cl
 184:	3b 0b                	cmp    (%ebx),%ecx
 186:	27                   	daa    
 187:	19 20                	sbb    %esp,(%eax)
 189:	0b 00                	or     (%eax),%eax
 18b:	00 1c 1d 01 31 13 52 	add    %bl,0x52133101(,%ebx,1)
 192:	01 55 17             	add    %edx,0x17(%ebp)
 195:	58                   	pop    %eax
 196:	0b 59 0b             	or     0xb(%ecx),%ebx
 199:	01 13                	add    %edx,(%ebx)
 19b:	00 00                	add    %al,(%eax)
 19d:	1d 1d 01 31 13       	sbb    $0x1331011d,%eax
 1a2:	52                   	push   %edx
 1a3:	01 55 17             	add    %edx,0x17(%ebp)
 1a6:	58                   	pop    %eax
 1a7:	0b 59 0b             	or     0xb(%ecx),%ebx
 1aa:	00 00                	add    %al,(%eax)
 1ac:	1e                   	push   %ds
 1ad:	05 00 31 13 1c       	add    $0x1c133100,%eax
 1b2:	05 00 00 1f 0b       	add    $0xb1f0000,%eax
 1b7:	01 55 17             	add    %edx,0x17(%ebp)
 1ba:	00 00                	add    %al,(%eax)
 1bc:	20 34 00             	and    %dh,(%eax,%eax,1)
 1bf:	31 13                	xor    %edx,(%ebx)
 1c1:	02 17                	add    (%edi),%dl
 1c3:	00 00                	add    %al,(%eax)
 1c5:	21 1d 01 31 13 11    	and    %ebx,0x11133101
 1cb:	01 12                	add    %edx,(%edx)
 1cd:	06                   	push   %es
 1ce:	58                   	pop    %eax
 1cf:	0b 59 0b             	or     0xb(%ecx),%ebx
 1d2:	01 13                	add    %edx,(%ebx)
 1d4:	00 00                	add    %al,(%eax)
 1d6:	22 05 00 31 13 1c    	and    0x1c133100,%al
 1dc:	0b 00                	or     (%eax),%eax
 1de:	00 23                	add    %ah,(%ebx)
 1e0:	05 00 31 13 02       	add    $0x2133100,%eax
 1e5:	18 00                	sbb    %al,(%eax)
 1e7:	00 24 1d 01 31 13 11 	add    %ah,0x11133101(,%ebx,1)
 1ee:	01 12                	add    %edx,(%edx)
 1f0:	06                   	push   %es
 1f1:	58                   	pop    %eax
 1f2:	0b 59 0b             	or     0xb(%ecx),%ebx
 1f5:	00 00                	add    %al,(%eax)
 1f7:	25 0b 01 11 01       	and    $0x111010b,%eax
 1fc:	12 06                	adc    (%esi),%al
 1fe:	00 00                	add    %al,(%eax)
 200:	26 05 00 31 13 02    	es add $0x2133100,%eax
 206:	17                   	pop    %ss
 207:	00 00                	add    %al,(%eax)
 209:	27                   	daa    
 20a:	34 00                	xor    $0x0,%al
 20c:	03 0e                	add    (%esi),%ecx
 20e:	3a 0b                	cmp    (%ebx),%cl
 210:	3b 0b                	cmp    (%ebx),%ecx
 212:	49                   	dec    %ecx
 213:	13 02                	adc    (%edx),%eax
 215:	18 00                	sbb    %al,(%eax)
 217:	00 28                	add    %ch,(%eax)
 219:	34 00                	xor    $0x0,%al
 21b:	03 0e                	add    (%esi),%ecx
 21d:	3a 0b                	cmp    (%ebx),%cl
 21f:	3b 0b                	cmp    (%ebx),%ecx
 221:	49                   	dec    %ecx
 222:	13 3f                	adc    (%edi),%edi
 224:	19 02                	sbb    %eax,(%edx)
 226:	18 00                	sbb    %al,(%eax)
 228:	00 00                	add    %al,(%eax)
 22a:	01 11                	add    %edx,(%ecx)
 22c:	01 25 0e 13 0b 03    	add    %esp,0x30b130e
 232:	0e                   	push   %cs
 233:	1b 0e                	sbb    (%esi),%ecx
 235:	11 01                	adc    %eax,(%ecx)
 237:	12 06                	adc    (%esi),%al
 239:	10 17                	adc    %dl,(%edi)
 23b:	00 00                	add    %al,(%eax)
 23d:	02 24 00             	add    (%eax,%eax,1),%ah
 240:	0b 0b                	or     (%ebx),%ecx
 242:	3e 0b 03             	or     %ds:(%ebx),%eax
 245:	0e                   	push   %cs
 246:	00 00                	add    %al,(%eax)
 248:	03 16                	add    (%esi),%edx
 24a:	00 03                	add    %al,(%ebx)
 24c:	0e                   	push   %cs
 24d:	3a 0b                	cmp    (%ebx),%cl
 24f:	3b 0b                	cmp    (%ebx),%ecx
 251:	49                   	dec    %ecx
 252:	13 00                	adc    (%eax),%eax
 254:	00 04 24             	add    %al,(%esp)
 257:	00 0b                	add    %cl,(%ebx)
 259:	0b 3e                	or     (%esi),%edi
 25b:	0b 03                	or     (%ebx),%eax
 25d:	08 00                	or     %al,(%eax)
 25f:	00 05 13 01 0b 0b    	add    %al,0xb0b0113
 265:	3a 0b                	cmp    (%ebx),%cl
 267:	3b 0b                	cmp    (%ebx),%ecx
 269:	01 13                	add    %edx,(%ebx)
 26b:	00 00                	add    %al,(%eax)
 26d:	06                   	push   %es
 26e:	0d 00 03 0e 3a       	or     $0x3a0e0300,%eax
 273:	0b 3b                	or     (%ebx),%edi
 275:	0b 49 13             	or     0x13(%ecx),%ecx
 278:	38 0b                	cmp    %cl,(%ebx)
 27a:	00 00                	add    %al,(%eax)
 27c:	07                   	pop    %es
 27d:	0d 00 03 08 3a       	or     $0x3a080300,%eax
 282:	0b 3b                	or     (%ebx),%edi
 284:	0b 49 13             	or     0x13(%ecx),%ecx
 287:	38 0b                	cmp    %cl,(%ebx)
 289:	00 00                	add    %al,(%eax)
 28b:	08 01                	or     %al,(%ecx)
 28d:	01 49 13             	add    %ecx,0x13(%ecx)
 290:	01 13                	add    %edx,(%ebx)
 292:	00 00                	add    %al,(%eax)
 294:	09 21                	or     %esp,(%ecx)
 296:	00 49 13             	add    %cl,0x13(%ecx)
 299:	2f                   	das    
 29a:	0b 00                	or     (%eax),%eax
 29c:	00 0a                	add    %cl,(%edx)
 29e:	13 01                	adc    (%ecx),%eax
 2a0:	03 08                	add    (%eax),%ecx
 2a2:	0b 05 3a 0b 3b 0b    	or     0xb3b0b3a,%eax
 2a8:	01 13                	add    %edx,(%ebx)
 2aa:	00 00                	add    %al,(%eax)
 2ac:	0b 0d 00 03 0e 3a    	or     0x3a0e0300,%ecx
 2b2:	0b 3b                	or     (%ebx),%edi
 2b4:	0b 49 13             	or     0x13(%ecx),%ecx
 2b7:	38 05 00 00 0c 21    	cmp    %al,0x210c0000
 2bd:	00 49 13             	add    %cl,0x13(%ecx)
 2c0:	2f                   	das    
 2c1:	05 00 00 0d 13       	add    $0x130d0000,%eax
 2c6:	01 03                	add    %eax,(%ebx)
 2c8:	0e                   	push   %cs
 2c9:	0b 0b                	or     (%ebx),%ecx
 2cb:	3a 0b                	cmp    (%ebx),%cl
 2cd:	3b 0b                	cmp    (%ebx),%ecx
 2cf:	01 13                	add    %edx,(%ebx)
 2d1:	00 00                	add    %al,(%eax)
 2d3:	0e                   	push   %cs
 2d4:	17                   	pop    %ss
 2d5:	01 0b                	add    %ecx,(%ebx)
 2d7:	0b 3a                	or     (%edx),%edi
 2d9:	0b 3b                	or     (%ebx),%edi
 2db:	0b 01                	or     (%ecx),%eax
 2dd:	13 00                	adc    (%eax),%eax
 2df:	00 0f                	add    %cl,(%edi)
 2e1:	0d 00 03 0e 3a       	or     $0x3a0e0300,%eax
 2e6:	0b 3b                	or     (%ebx),%edi
 2e8:	0b 49 13             	or     0x13(%ecx),%ecx
 2eb:	00 00                	add    %al,(%eax)
 2ed:	10 0d 00 03 08 3a    	adc    %cl,0x3a080300
 2f3:	0b 3b                	or     (%ebx),%edi
 2f5:	0b 49 13             	or     0x13(%ecx),%ecx
 2f8:	00 00                	add    %al,(%eax)
 2fa:	11 2e                	adc    %ebp,(%esi)
 2fc:	01 3f                	add    %edi,(%edi)
 2fe:	19 03                	sbb    %eax,(%ebx)
 300:	0e                   	push   %cs
 301:	3a 0b                	cmp    (%ebx),%cl
 303:	3b 0b                	cmp    (%ebx),%ecx
 305:	27                   	daa    
 306:	19 49 13             	sbb    %ecx,0x13(%ecx)
 309:	11 01                	adc    %eax,(%ecx)
 30b:	12 06                	adc    (%esi),%al
 30d:	40                   	inc    %eax
 30e:	18 97 42 19 01 13    	sbb    %dl,0x13011942(%edi)
 314:	00 00                	add    %al,(%eax)
 316:	12 05 00 03 0e 3a    	adc    0x3a0e0300,%al
 31c:	0b 3b                	or     (%ebx),%edi
 31e:	0b 49 13             	or     0x13(%ecx),%ecx
 321:	02 18                	add    (%eax),%bl
 323:	00 00                	add    %al,(%eax)
 325:	13 34 00             	adc    (%eax,%eax,1),%esi
 328:	03 08                	add    (%eax),%ecx
 32a:	3a 0b                	cmp    (%ebx),%cl
 32c:	3b 0b                	cmp    (%ebx),%ecx
 32e:	49                   	dec    %ecx
 32f:	13 02                	adc    (%edx),%eax
 331:	17                   	pop    %ss
 332:	00 00                	add    %al,(%eax)
 334:	14 89                	adc    $0x89,%al
 336:	82                   	(bad)  
 337:	01 00                	add    %eax,(%eax)
 339:	11 01                	adc    %eax,(%ecx)
 33b:	31 13                	xor    %edx,(%ebx)
 33d:	00 00                	add    %al,(%eax)
 33f:	15 0f 00 0b 0b       	adc    $0xb0b000f,%eax
 344:	49                   	dec    %ecx
 345:	13 00                	adc    (%eax),%eax
 347:	00 16                	add    %dl,(%esi)
 349:	34 00                	xor    $0x0,%al
 34b:	03 0e                	add    (%esi),%ecx
 34d:	3a 0b                	cmp    (%ebx),%cl
 34f:	3b 0b                	cmp    (%ebx),%ecx
 351:	49                   	dec    %ecx
 352:	13 02                	adc    (%edx),%eax
 354:	17                   	pop    %ss
 355:	00 00                	add    %al,(%eax)
 357:	17                   	pop    %ss
 358:	2e 01 3f             	add    %edi,%cs:(%edi)
 35b:	19 03                	sbb    %eax,(%ebx)
 35d:	0e                   	push   %cs
 35e:	3a 0b                	cmp    (%ebx),%cl
 360:	3b 0b                	cmp    (%ebx),%ecx
 362:	27                   	daa    
 363:	19 11                	sbb    %edx,(%ecx)
 365:	01 12                	add    %edx,(%edx)
 367:	06                   	push   %es
 368:	40                   	inc    %eax
 369:	18 97 42 19 01 13    	sbb    %dl,0x13011942(%edi)
 36f:	00 00                	add    %al,(%eax)
 371:	18 05 00 03 08 3a    	sbb    %al,0x3a080300
 377:	0b 3b                	or     (%ebx),%edi
 379:	0b 49 13             	or     0x13(%ecx),%ecx
 37c:	02 18                	add    (%eax),%bl
 37e:	00 00                	add    %al,(%eax)
 380:	19 89 82 01 00 11    	sbb    %ecx,0x11000182(%ecx)
 386:	01 95 42 19 31 13    	add    %edx,0x13311942(%ebp)
 38c:	00 00                	add    %al,(%eax)
 38e:	1a 34 00             	sbb    (%eax,%eax,1),%dh
 391:	03 0e                	add    (%esi),%ecx
 393:	3a 0b                	cmp    (%ebx),%cl
 395:	3b 0b                	cmp    (%ebx),%ecx
 397:	49                   	dec    %ecx
 398:	13 3f                	adc    (%edi),%edi
 39a:	19 02                	sbb    %eax,(%edx)
 39c:	18 00                	sbb    %al,(%eax)
 39e:	00 1b                	add    %bl,(%ebx)
 3a0:	2e 01 3f             	add    %edi,%cs:(%edi)
 3a3:	19 03                	sbb    %eax,(%ebx)
 3a5:	0e                   	push   %cs
 3a6:	3a 0b                	cmp    (%ebx),%cl
 3a8:	3b 0b                	cmp    (%ebx),%ecx
 3aa:	27                   	daa    
 3ab:	19 3c 19             	sbb    %edi,(%ecx,%ebx,1)
 3ae:	01 13                	add    %edx,(%ebx)
 3b0:	00 00                	add    %al,(%eax)
 3b2:	1c 05                	sbb    $0x5,%al
 3b4:	00 49 13             	add    %cl,0x13(%ecx)
 3b7:	00 00                	add    %al,(%eax)
 3b9:	1d 2e 01 3f 19       	sbb    $0x193f012e,%eax
 3be:	03 0e                	add    (%esi),%ecx
 3c0:	3a 0b                	cmp    (%ebx),%cl
 3c2:	3b 0b                	cmp    (%ebx),%ecx
 3c4:	27                   	daa    
 3c5:	19 3c 19             	sbb    %edi,(%ecx,%ebx,1)
 3c8:	00 00                	add    %al,(%eax)
 3ca:	00 01                	add    %al,(%ecx)
 3cc:	11 00                	adc    %eax,(%eax)
 3ce:	10 06                	adc    %al,(%esi)
 3d0:	11 01                	adc    %eax,(%ecx)
 3d2:	12 01                	adc    (%ecx),%al
 3d4:	03 08                	add    (%eax),%ecx
 3d6:	1b 08                	sbb    (%eax),%ecx
 3d8:	25 08 13 05 00       	and    $0x51308,%eax
 3dd:	00 00                	add    %al,(%eax)

Disassembly of section .debug_line:

00000000 <.debug_line>:
   0:	7c 00                	jl     2 <CR0_PE_ON+0x1>
   2:	00 00                	add    %al,(%eax)
   4:	02 00                	add    (%eax),%al
   6:	29 00                	sub    %eax,(%eax)
   8:	00 00                	add    %al,(%eax)
   a:	01 01                	add    %eax,(%ecx)
   c:	fb                   	sti    
   d:	0e                   	push   %cs
   e:	0d 00 01 01 01       	or     $0x1010100,%eax
  13:	01 00                	add    %eax,(%eax)
  15:	00 00                	add    %al,(%eax)
  17:	01 00                	add    %eax,(%eax)
  19:	00 01                	add    %al,(%ecx)
  1b:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  1e:	74 2f                	je     4f <PROT_MODE_DSEG+0x3f>
  20:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  23:	74 31                	je     56 <PROT_MODE_DSEG+0x46>
  25:	00 00                	add    %al,(%eax)
  27:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  2a:	74 31                	je     5d <PROT_MODE_DSEG+0x4d>
  2c:	2e 53                	cs push %ebx
  2e:	00 01                	add    %al,(%ecx)
  30:	00 00                	add    %al,(%eax)
  32:	00 00                	add    %al,(%eax)
  34:	05 02 00 7e 00       	add    $0x7e0002,%eax
  39:	00 03                	add    %al,(%ebx)
  3b:	2a 01                	sub    (%ecx),%al
  3d:	21 24 2f             	and    %esp,(%edi,%ebp,1)
  40:	2f                   	das    
  41:	2f                   	das    
  42:	2f                   	das    
  43:	30 2f                	xor    %ch,(%edi)
  45:	2f                   	das    
  46:	2f                   	das    
  47:	2f                   	das    
  48:	34 3d                	xor    $0x3d,%al
  4a:	42                   	inc    %edx
  4b:	3d 67 3e 67 67       	cmp    $0x67673e67,%eax
  50:	30 2f                	xor    %ch,(%edi)
  52:	67 30 83 3d 4b       	xor    %al,0x4b3d(%bp,%di)
  57:	2f                   	das    
  58:	30 2f                	xor    %ch,(%edi)
  5a:	3d 2f 30 3d 3d       	cmp    $0x3d3d302f,%eax
  5f:	31 26                	xor    %esp,(%esi)
  61:	59                   	pop    %ecx
  62:	3d 4b 40 5c 4b       	cmp    $0x4b5c404b,%eax
  67:	2f                   	das    
  68:	2f                   	das    
  69:	2f                   	das    
  6a:	2f                   	das    
  6b:	34 59                	xor    $0x59,%al
  6d:	59                   	pop    %ecx
  6e:	59                   	pop    %ecx
  6f:	21 5b 27             	and    %ebx,0x27(%ebx)
  72:	21 30                	and    %esi,(%eax)
  74:	21 2f                	and    %ebp,(%edi)
  76:	2f                   	das    
  77:	2f                   	das    
  78:	30 21                	xor    %ah,(%ecx)
  7a:	02 fc                	add    %ah,%bh
  7c:	18 00                	sbb    %al,(%eax)
  7e:	01 01                	add    %eax,(%ecx)
  80:	5c                   	pop    %esp
  81:	01 00                	add    %eax,(%eax)
  83:	00 02                	add    %al,(%edx)
  85:	00 3a                	add    %bh,(%edx)
  87:	00 00                	add    %al,(%eax)
  89:	00 01                	add    %al,(%ecx)
  8b:	01 fb                	add    %edi,%ebx
  8d:	0e                   	push   %cs
  8e:	0d 00 01 01 01       	or     $0x1010100,%eax
  93:	01 00                	add    %eax,(%eax)
  95:	00 00                	add    %al,(%eax)
  97:	01 00                	add    %eax,(%eax)
  99:	00 01                	add    %al,(%ecx)
  9b:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  9e:	74 2f                	je     cf <PR_BOOTABLE+0x4f>
  a0:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  a3:	74 31                	je     d6 <PR_BOOTABLE+0x56>
  a5:	00 00                	add    %al,(%eax)
  a7:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  aa:	74 31                	je     dd <PR_BOOTABLE+0x5d>
  ac:	6c                   	insb   (%dx),%es:(%edi)
  ad:	69 62 2e 63 00 01 00 	imul   $0x10063,0x2e(%edx),%esp
  b4:	00 62 6f             	add    %ah,0x6f(%edx)
  b7:	6f                   	outsl  %ds:(%esi),(%dx)
  b8:	74 31                	je     eb <PR_BOOTABLE+0x6b>
  ba:	6c                   	insb   (%dx),%es:(%edi)
  bb:	69 62 2e 68 00 01 00 	imul   $0x10068,0x2e(%edx),%esp
  c2:	00 00                	add    %al,(%eax)
  c4:	00 05 02 26 8b 00    	add    %al,0x8b2602
  ca:	00 03                	add    %al,(%ebx)
  cc:	09 01                	or     %eax,(%ecx)
  ce:	3c 3e                	cmp    $0x3e,%al
  d0:	3b 83 2f 67 33 58    	cmp    0x5833672f(%ebx),%eax
  d6:	3d 00 02 04 01       	cmp    $0x1040200,%eax
  db:	91                   	xchg   %eax,%ecx
  dc:	84 08                	test   %cl,(%eax)
  de:	3f                   	aas    
  df:	03 09                	add    (%ecx),%ecx
  e1:	74 21                	je     104 <PR_BOOTABLE+0x84>
  e3:	57                   	push   %edi
  e4:	3d 08 f3 f3 5c       	cmp    $0x5cf3f308,%eax
  e9:	3d 3d 1f 59 24       	cmp    $0x24591f3d,%eax
  ee:	3d 00 02 04 01       	cmp    $0x1040200,%eax
  f3:	08 15 03 14 3c 23    	or     %dl,0x233c1403
  f9:	2b 2e                	sub    (%esi),%ebp
  fb:	00 02                	add    %al,(%edx)
  fd:	04 01                	add    $0x1,%al
  ff:	3f                   	aas    
 100:	00 02                	add    %al,(%edx)
 102:	04 02                	add    $0x2,%al
 104:	67 3e 33 58 40       	xor    %ds:0x40(%bx,%si),%ebx
 109:	00 02                	add    %al,(%edx)
 10b:	04 01                	add    $0x1,%al
 10d:	06                   	push   %es
 10e:	9e                   	sahf   
 10f:	00 02                	add    %al,(%edx)
 111:	04 02                	add    $0x2,%al
 113:	06                   	push   %es
 114:	4c                   	dec    %esp
 115:	00 02                	add    %al,(%edx)
 117:	04 02                	add    $0x2,%al
 119:	4b                   	dec    %ebx
 11a:	00 02                	add    %al,(%edx)
 11c:	04 02                	add    $0x2,%al
 11e:	67 00 02             	add    %al,(%bp,%si)
 121:	04 02                	add    $0x2,%al
 123:	2a 00                	sub    (%eax),%al
 125:	02 04 02             	add    (%edx,%eax,1),%al
 128:	24 00                	and    $0x0,%al
 12a:	02 04 02             	add    (%edx,%eax,1),%al
 12d:	38 42 79             	cmp    %al,0x79(%edx)
 130:	ac                   	lods   %ds:(%esi),%al
 131:	00 02                	add    %al,(%edx)
 133:	04 01                	add    $0x1,%al
 135:	08 a6 00 02 04 01    	or     %ah,0x1040200(%esi)
 13b:	9f                   	lahf   
 13c:	00 02                	add    %al,(%edx)
 13e:	04 01                	add    $0x1,%al
 140:	2d 00 02 04 01       	sub    $0x1040200,%eax
 145:	4b                   	dec    %ebx
 146:	2d 4c 48 30 2f       	sub    $0x2f30484c,%eax
 14b:	75 4b                	jne    198 <PR_BOOTABLE+0x118>
 14d:	3d 65 5d 3e 08       	cmp    $0x83e5d65,%eax
 152:	4b                   	dec    %ebx
 153:	33 3e                	xor    (%esi),%edi
 155:	08 4b 03             	or     %cl,0x3(%ebx)
 158:	bd 7f 2e 3d c9       	mov    $0xc93d2e7f,%ebp
 15d:	91                   	xchg   %eax,%ecx
 15e:	1f                   	pop    %ds
 15f:	03 d1                	add    %ecx,%edx
 161:	00 58 04             	add    %bl,0x4(%eax)
 164:	02 03                	add    (%ebx),%al
 166:	99                   	cltd   
 167:	7f 20                	jg     189 <PR_BOOTABLE+0x109>
 169:	04 01                	add    $0x1,%al
 16b:	03 e7                	add    %edi,%esp
 16d:	00 58 04             	add    %bl,0x4(%eax)
 170:	02 03                	add    (%ebx),%al
 172:	99                   	cltd   
 173:	7f 66                	jg     1db <PR_BOOTABLE+0x15b>
 175:	04 01                	add    $0x1,%al
 177:	03 e1                	add    %ecx,%esp
 179:	00 20                	add    %ah,(%eax)
 17b:	04 02                	add    $0x2,%al
 17d:	03 92 7f 74 04 01    	add    0x104747f(%edx),%edx
 183:	03 fb                	add    %ebx,%edi
 185:	00 08                	add    %cl,(%eax)
 187:	3c 04                	cmp    $0x4,%al
 189:	02 03                	add    (%ebx),%al
 18b:	85 7f 2e             	test   %edi,0x2e(%edi)
 18e:	04 01                	add    $0x1,%al
 190:	03 fb                	add    %ebx,%edi
 192:	00 2e                	add    %ch,(%esi)
 194:	04 02                	add    $0x2,%al
 196:	03 85 7f 66 04 01    	add    0x104667f(%ebp),%eax
 19c:	03 fc                	add    %esp,%edi
 19e:	00 20                	add    %ah,(%eax)
 1a0:	04 02                	add    $0x2,%al
 1a2:	03 84 7f 3c 04 01 03 	add    0x301043c(%edi,%edi,2),%eax
 1a9:	fc                   	cld    
 1aa:	00 2e                	add    %ch,(%esi)
 1ac:	04 02                	add    $0x2,%al
 1ae:	03 84 7f 58 03 0d 66 	add    0x660d0358(%edi,%edi,2),%eax
 1b5:	04 01                	add    $0x1,%al
 1b7:	03 e1                	add    %ecx,%esp
 1b9:	00 20                	add    %ah,(%eax)
 1bb:	04 02                	add    $0x2,%al
 1bd:	03 a6 7f 74 04 01    	add    0x104747f(%esi),%esp
 1c3:	03 f0                	add    %eax,%esi
 1c5:	00 f2                	add    %dh,%dl
 1c7:	42                   	inc    %edx
 1c8:	90                   	nop
 1c9:	3f                   	aas    
 1ca:	31 63 6c             	xor    %esp,0x6c(%ebx)
 1cd:	37                   	aaa    
 1ce:	41                   	inc    %ecx
 1cf:	00 02                	add    %al,(%edx)
 1d1:	04 01                	add    $0x1,%al
 1d3:	41                   	inc    %ecx
 1d4:	4c                   	dec    %esp
 1d5:	22 1e                	and    (%esi),%bl
 1d7:	21 65 5a             	and    %esp,0x5a(%ebp)
 1da:	4c                   	dec    %esp
 1db:	02 08                	add    (%eax),%cl
 1dd:	00 01                	add    %al,(%ecx)
 1df:	01 b1 00 00 00 02    	add    %esi,0x2000000(%ecx)
 1e5:	00 3b                	add    %bh,(%ebx)
 1e7:	00 00                	add    %al,(%eax)
 1e9:	00 01                	add    %al,(%ecx)
 1eb:	01 fb                	add    %edi,%ebx
 1ed:	0e                   	push   %cs
 1ee:	0d 00 01 01 01       	or     $0x1010100,%eax
 1f3:	01 00                	add    %eax,(%eax)
 1f5:	00 00                	add    %al,(%eax)
 1f7:	01 00                	add    %eax,(%eax)
 1f9:	00 01                	add    %al,(%ecx)
 1fb:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 1fe:	74 2f                	je     22f <PR_BOOTABLE+0x1af>
 200:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 203:	74 31                	je     236 <PR_BOOTABLE+0x1b6>
 205:	00 00                	add    %al,(%eax)
 207:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 20a:	74 31                	je     23d <PR_BOOTABLE+0x1bd>
 20c:	6d                   	insl   (%dx),%es:(%edi)
 20d:	61                   	popa   
 20e:	69 6e 2e 63 00 01 00 	imul   $0x10063,0x2e(%esi),%ebp
 215:	00 62 6f             	add    %ah,0x6f(%edx)
 218:	6f                   	outsl  %ds:(%esi),(%dx)
 219:	74 31                	je     24c <PR_BOOTABLE+0x1cc>
 21b:	6c                   	insb   (%dx),%es:(%edi)
 21c:	69 62 2e 68 00 01 00 	imul   $0x10068,0x2e(%edx),%esp
 223:	00 00                	add    %al,(%eax)
 225:	00 05 02 6a 8d 00    	add    %al,0x8d6a02
 22b:	00 03                	add    %al,(%ebx)
 22d:	2f                   	das    
 22e:	01 90 40 08 23 e5    	add    %edx,-0x1adcf7c0(%eax)
 234:	f5                   	cmc    
 235:	ad                   	lods   %ds:(%esi),%eax
 236:	00 02                	add    %al,(%edx)
 238:	04 01                	add    $0x1,%al
 23a:	ca 00 02             	lret   $0x200
 23d:	04 02                	add    $0x2,%al
 23f:	4c                   	dec    %esp
 240:	00 02                	add    %al,(%edx)
 242:	04 02                	add    $0x2,%al
 244:	1e                   	push   %ds
 245:	00 02                	add    %al,(%edx)
 247:	04 02                	add    $0x2,%al
 249:	3e 00 02             	add    %al,%ds:(%edx)
 24c:	04 02                	add    $0x2,%al
 24e:	d4 5d                	aam    $0x5d
 250:	59                   	pop    %ecx
 251:	65 59                	gs pop %ecx
 253:	32 87 c6 31 00 02    	xor    0x20031c6(%edi),%al
 259:	04 01                	add    $0x1,%al
 25b:	06                   	push   %es
 25c:	3c 06                	cmp    $0x6,%al
 25e:	d8 3d 3b 67 00 02    	fdivrs 0x200673b
 264:	04 02                	add    $0x2,%al
 266:	55                   	push   %ebp
 267:	00 02                	add    %al,(%edx)
 269:	04 01                	add    $0x1,%al
 26b:	06                   	push   %es
 26c:	82                   	(bad)  
 26d:	06                   	push   %es
 26e:	6d                   	insl   (%dx),%es:(%edi)
 26f:	68 55 69 03 b6       	push   $0xb6036955
 274:	7f 74                	jg     2ea <PR_BOOTABLE+0x26a>
 276:	82                   	(bad)  
 277:	3d 08 87 76 a0       	cmp    $0xa0768708,%eax
 27c:	b6 03                	mov    $0x3,%dh
 27e:	0a 66 03             	or     0x3(%esi),%ah
 281:	75 3c                	jne    2bf <PR_BOOTABLE+0x23f>
 283:	03 0b                	add    (%ebx),%ecx
 285:	2e ca 92 bb          	cs lret $0xbb92
 289:	84 72 30             	test   %dh,0x30(%edx)
 28c:	5a                   	pop    %edx
 28d:	ca a0 64             	lret   $0x64a0
 290:	02 05 00 01 01 46    	add    0x46010100,%al
 296:	00 00                	add    %al,(%eax)
 298:	00 02                	add    %al,(%edx)
 29a:	00 2f                	add    %ch,(%edi)
 29c:	00 00                	add    %al,(%eax)
 29e:	00 01                	add    %al,(%ecx)
 2a0:	01 fb                	add    %edi,%ebx
 2a2:	0e                   	push   %cs
 2a3:	0d 00 01 01 01       	or     $0x1010100,%eax
 2a8:	01 00                	add    %eax,(%eax)
 2aa:	00 00                	add    %al,(%eax)
 2ac:	01 00                	add    %eax,(%eax)
 2ae:	00 01                	add    %al,(%ecx)
 2b0:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 2b3:	74 2f                	je     2e4 <PR_BOOTABLE+0x264>
 2b5:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 2b8:	74 31                	je     2eb <PR_BOOTABLE+0x26b>
 2ba:	00 00                	add    %al,(%eax)
 2bc:	65 78 65             	gs js  324 <PR_BOOTABLE+0x2a4>
 2bf:	63 5f 6b             	arpl   %bx,0x6b(%edi)
 2c2:	65 72 6e             	gs jb  333 <PR_BOOTABLE+0x2b3>
 2c5:	65 6c                	gs insb (%dx),%es:(%edi)
 2c7:	2e 53                	cs push %ebx
 2c9:	00 01                	add    %al,(%ecx)
 2cb:	00 00                	add    %al,(%eax)
 2cd:	00 00                	add    %al,(%eax)
 2cf:	05 02 f1 8e 00       	add    $0x8ef102,%eax
 2d4:	00 17                	add    %dl,(%edi)
 2d6:	21 59 4b             	and    %ebx,0x4b(%ecx)
 2d9:	4b                   	dec    %ebx
 2da:	02 02                	add    (%edx),%al
 2dc:	00 01                	add    %al,(%ecx)
 2de:	01                   	.byte 0x1

Disassembly of section .debug_str:

00000000 <.debug_str>:
   0:	65 6e                	outsb  %gs:(%esi),(%dx)
   2:	64 5f                	fs pop %edi
   4:	76 61                	jbe    67 <PROT_MODE_DSEG+0x57>
   6:	00 77 61             	add    %dh,0x61(%edi)
   9:	69 74 64 69 73 6b 00 	imul   $0x73006b73,0x69(%esp,%eiz,2),%esi
  10:	73 
  11:	68 6f 72 74 20       	push   $0x2074726f
  16:	69 6e 74 00 73 69 7a 	imul   $0x7a697300,0x74(%esi),%ebp
  1d:	65 74 79             	gs je  99 <PR_BOOTABLE+0x19>
  20:	70 65                	jo     87 <PR_BOOTABLE+0x7>
  22:	00 72 6f             	add    %dh,0x6f(%edx)
  25:	6c                   	insb   (%dx),%es:(%edi)
  26:	6c                   	insb   (%dx),%es:(%edi)
  27:	00 70 61             	add    %dh,0x61(%eax)
  2a:	6e                   	outsb  %ds:(%esi),(%dx)
  2b:	69 63 00 6c 6f 6e 67 	imul   $0x676e6f6c,0x0(%ebx),%esp
  32:	20 6c 6f 6e          	and    %ch,0x6e(%edi,%ebp,2)
  36:	67 20 69 6e          	and    %ch,0x6e(%bx,%di)
  3a:	74 00                	je     3c <PROT_MODE_DSEG+0x2c>
  3c:	70 75                	jo     b3 <PR_BOOTABLE+0x33>
  3e:	74 69                	je     a9 <PR_BOOTABLE+0x29>
  40:	00 72 65             	add    %dh,0x65(%edx)
  43:	61                   	popa   
  44:	64 73 65             	fs jae ac <PR_BOOTABLE+0x2c>
  47:	63 74 6f 72          	arpl   %si,0x72(%edi,%ebp,2)
  4b:	00 62 6f             	add    %ah,0x6f(%edx)
  4e:	6f                   	outsl  %ds:(%esi),(%dx)
  4f:	74 2f                	je     80 <PR_BOOTABLE>
  51:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  54:	74 31                	je     87 <PR_BOOTABLE+0x7>
  56:	2f                   	das    
  57:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  5a:	74 31                	je     8d <PR_BOOTABLE+0xd>
  5c:	6c                   	insb   (%dx),%es:(%edi)
  5d:	69 62 2e 63 00 75 69 	imul   $0x69750063,0x2e(%edx),%esp
  64:	6e                   	outsb  %ds:(%esi),(%dx)
  65:	74 38                	je     9f <PR_BOOTABLE+0x1f>
  67:	5f                   	pop    %edi
  68:	74 00                	je     6a <PROT_MODE_DSEG+0x5a>
  6a:	6f                   	outsl  %ds:(%esi),(%dx)
  6b:	75 74                	jne    e1 <PR_BOOTABLE+0x61>
  6d:	62 00                	bound  %eax,(%eax)
  6f:	69 6e 73 6c 00 47 4e 	imul   $0x4e47006c,0x73(%esi),%ebp
  76:	55                   	push   %ebp
  77:	20 43 20             	and    %al,0x20(%ebx)
  7a:	34 2e                	xor    $0x2e,%al
  7c:	38 2e                	cmp    %ch,(%esi)
  7e:	35 20 2d 6d 33       	xor    $0x336d2d20,%eax
  83:	32 20                	xor    (%eax),%ah
  85:	2d 6d 74 75 6e       	sub    $0x6e75746d,%eax
  8a:	65 3d 67 65 6e 65    	gs cmp $0x656e6567,%eax
  90:	72 69                	jb     fb <PR_BOOTABLE+0x7b>
  92:	63 20                	arpl   %sp,(%eax)
  94:	2d 6d 61 72 63       	sub    $0x6372616d,%eax
  99:	68 3d 69 36 38       	push   $0x3836693d
  9e:	36 20 2d 67 20 2d 4f 	and    %ch,%ss:0x4f2d2067
  a5:	73 20                	jae    c7 <PR_BOOTABLE+0x47>
  a7:	2d 4f 73 20 2d       	sub    $0x2d20734f,%eax
  ac:	66 6e                	data16 outsb %ds:(%esi),(%dx)
  ae:	6f                   	outsl  %ds:(%esi),(%dx)
  af:	2d 62 75 69 6c       	sub    $0x6c697562,%eax
  b4:	74 69                	je     11f <PR_BOOTABLE+0x9f>
  b6:	6e                   	outsb  %ds:(%esi),(%dx)
  b7:	20 2d 66 6e 6f 2d    	and    %ch,0x2d6f6e66
  bd:	73 74                	jae    133 <PR_BOOTABLE+0xb3>
  bf:	61                   	popa   
  c0:	63 6b 2d             	arpl   %bp,0x2d(%ebx)
  c3:	70 72                	jo     137 <PR_BOOTABLE+0xb7>
  c5:	6f                   	outsl  %ds:(%esi),(%dx)
  c6:	74 65                	je     12d <PR_BOOTABLE+0xad>
  c8:	63 74 6f 72          	arpl   %si,0x72(%edi,%ebp,2)
  cc:	00 73 74             	add    %dh,0x74(%ebx)
  cf:	72 69                	jb     13a <PR_BOOTABLE+0xba>
  d1:	6e                   	outsb  %ds:(%esi),(%dx)
  d2:	67 00 72 65          	add    %dh,0x65(%bp,%si)
  d6:	61                   	popa   
  d7:	64 73 65             	fs jae 13f <PR_BOOTABLE+0xbf>
  da:	63 74 69 6f          	arpl   %si,0x6f(%ecx,%ebp,2)
  de:	6e                   	outsb  %ds:(%esi),(%dx)
  df:	00 75 6e             	add    %dh,0x6e(%ebp)
  e2:	73 69                	jae    14d <PR_BOOTABLE+0xcd>
  e4:	67 6e                	outsb  %ds:(%si),(%dx)
  e6:	65 64 20 63 68       	gs and %ah,%fs:0x68(%ebx)
  eb:	61                   	popa   
  ec:	72 00                	jb     ee <PR_BOOTABLE+0x6e>
  ee:	69 74 6f 68 00 70 75 	imul   $0x74757000,0x68(%edi,%ebp,2),%esi
  f5:	74 
  f6:	63 00                	arpl   %ax,(%eax)
  f8:	6c                   	insb   (%dx),%es:(%edi)
  f9:	6f                   	outsl  %ds:(%esi),(%dx)
  fa:	6e                   	outsb  %ds:(%esi),(%dx)
  fb:	67 20 6c 6f          	and    %ch,0x6f(%si)
  ff:	6e                   	outsb  %ds:(%esi),(%dx)
 100:	67 20 75 6e          	and    %dh,0x6e(%di)
 104:	73 69                	jae    16f <PR_BOOTABLE+0xef>
 106:	67 6e                	outsb  %ds:(%si),(%dx)
 108:	65 64 20 69 6e       	gs and %ch,%fs:0x6e(%ecx)
 10d:	74 00                	je     10f <PR_BOOTABLE+0x8f>
 10f:	69 74 6f 61 00 75 69 	imul   $0x6e697500,0x61(%edi,%ebp,2),%esi
 116:	6e 
 117:	74 33                	je     14c <PR_BOOTABLE+0xcc>
 119:	32 5f 74             	xor    0x74(%edi),%bl
 11c:	00 63 6f             	add    %ah,0x6f(%ebx)
 11f:	6c                   	insb   (%dx),%es:(%edi)
 120:	6f                   	outsl  %ds:(%esi),(%dx)
 121:	72 00                	jb     123 <PR_BOOTABLE+0xa3>
 123:	69 74 6f 78 00 70 75 	imul   $0x74757000,0x78(%edi,%ebp,2),%esi
 12a:	74 
 12b:	73 00                	jae    12d <PR_BOOTABLE+0xad>
 12d:	73 69                	jae    198 <PR_BOOTABLE+0x118>
 12f:	67 6e                	outsb  %ds:(%si),(%dx)
 131:	00 73 68             	add    %dh,0x68(%ebx)
 134:	6f                   	outsl  %ds:(%esi),(%dx)
 135:	72 74                	jb     1ab <PR_BOOTABLE+0x12b>
 137:	20 75 6e             	and    %dh,0x6e(%ebp)
 13a:	73 69                	jae    1a5 <PR_BOOTABLE+0x125>
 13c:	67 6e                	outsb  %ds:(%si),(%dx)
 13e:	65 64 20 69 6e       	gs and %ch,%fs:0x6e(%ecx)
 143:	74 00                	je     145 <PR_BOOTABLE+0xc5>
 145:	73 74                	jae    1bb <PR_BOOTABLE+0x13b>
 147:	72 6c                	jb     1b5 <PR_BOOTABLE+0x135>
 149:	65 6e                	outsb  %gs:(%esi),(%dx)
 14b:	00 2f                	add    %ch,(%edi)
 14d:	72 6f                	jb     1be <PR_BOOTABLE+0x13e>
 14f:	6f                   	outsl  %ds:(%esi),(%dx)
 150:	74 2f                	je     181 <PR_BOOTABLE+0x101>
 152:	63 6f 64             	arpl   %bp,0x64(%edi)
 155:	65 00 64 61 74       	add    %ah,%gs:0x74(%ecx,%eiz,2)
 15a:	61                   	popa   
 15b:	00 70 6f             	add    %dh,0x6f(%eax)
 15e:	72 74                	jb     1d4 <PR_BOOTABLE+0x154>
 160:	00 70 75             	add    %dh,0x75(%eax)
 163:	74 6c                	je     1d1 <PR_BOOTABLE+0x151>
 165:	69 6e 65 00 72 65 76 	imul   $0x76657200,0x65(%esi),%ebp
 16c:	65 72 73             	gs jb  1e2 <PR_BOOTABLE+0x162>
 16f:	65 00 70 75          	add    %dh,%gs:0x75(%eax)
 173:	74 69                	je     1de <PR_BOOTABLE+0x15e>
 175:	5f                   	pop    %edi
 176:	73 74                	jae    1ec <PR_BOOTABLE+0x16c>
 178:	72 00                	jb     17a <PR_BOOTABLE+0xfa>
 17a:	62 6c 61 6e          	bound  %ebp,0x6e(%ecx,%eiz,2)
 17e:	6b 00 72             	imul   $0x72,(%eax),%eax
 181:	6f                   	outsl  %ds:(%esi),(%dx)
 182:	6f                   	outsl  %ds:(%esi),(%dx)
 183:	74 00                	je     185 <PR_BOOTABLE+0x105>
 185:	76 69                	jbe    1f0 <PR_BOOTABLE+0x170>
 187:	64 65 6f             	fs outsl %gs:(%esi),(%dx)
 18a:	00 64 69 73          	add    %ah,0x73(%ecx,%ebp,2)
 18e:	6b 5f 73 69          	imul   $0x69,0x73(%edi),%ebx
 192:	67 00 65 6c          	add    %ah,0x6c(%di)
 196:	66 68 64 66          	pushw  $0x6664
 19a:	00 65 5f             	add    %ah,0x5f(%ebp)
 19d:	70 68                	jo     207 <PR_BOOTABLE+0x187>
 19f:	6f                   	outsl  %ds:(%esi),(%dx)
 1a0:	66 66 00 6d 6d       	data16 data16 add %ch,0x6d(%ebp)
 1a5:	61                   	popa   
 1a6:	70 5f                	jo     207 <PR_BOOTABLE+0x187>
 1a8:	61                   	popa   
 1a9:	64 64 72 00          	fs fs jb 1ad <PR_BOOTABLE+0x12d>
 1ad:	65 6c                	gs insb (%dx),%es:(%edi)
 1af:	66 68 64 72          	pushw  $0x7264
 1b3:	00 76 62             	add    %dh,0x62(%esi)
 1b6:	65 5f                	gs pop %edi
 1b8:	69 6e 74 65 72 66 61 	imul   $0x61667265,0x74(%esi),%ebp
 1bf:	63 65 5f             	arpl   %sp,0x5f(%ebp)
 1c2:	6f                   	outsl  %ds:(%esi),(%dx)
 1c3:	66 66 00 65 5f       	data16 data16 add %ah,0x5f(%ebp)
 1c8:	65 6e                	outsb  %gs:(%esi),(%dx)
 1ca:	74 72                	je     23e <PR_BOOTABLE+0x1be>
 1cc:	79 00                	jns    1ce <PR_BOOTABLE+0x14e>
 1ce:	75 69                	jne    239 <PR_BOOTABLE+0x1b9>
 1d0:	6e                   	outsb  %ds:(%esi),(%dx)
 1d1:	74 36                	je     209 <PR_BOOTABLE+0x189>
 1d3:	34 5f                	xor    $0x5f,%al
 1d5:	74 00                	je     1d7 <PR_BOOTABLE+0x157>
 1d7:	6c                   	insb   (%dx),%es:(%edi)
 1d8:	6f                   	outsl  %ds:(%esi),(%dx)
 1d9:	61                   	popa   
 1da:	64 5f                	fs pop %edi
 1dc:	6b 65 72 6e          	imul   $0x6e,0x72(%ebp),%esp
 1e0:	65 6c                	gs insb (%dx),%es:(%edi)
 1e2:	00 70 5f             	add    %dh,0x5f(%eax)
 1e5:	6d                   	insl   (%dx),%es:(%edi)
 1e6:	65 6d                	gs insl (%dx),%es:(%edi)
 1e8:	73 7a                	jae    264 <PR_BOOTABLE+0x1e4>
 1ea:	00 70 5f             	add    %dh,0x5f(%eax)
 1ed:	6f                   	outsl  %ds:(%esi),(%dx)
 1ee:	66 66 73 65          	data16 data16 jae 257 <PR_BOOTABLE+0x1d7>
 1f2:	74 00                	je     1f4 <PR_BOOTABLE+0x174>
 1f4:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 1f7:	74 6c                	je     265 <PR_BOOTABLE+0x1e5>
 1f9:	6f                   	outsl  %ds:(%esi),(%dx)
 1fa:	61                   	popa   
 1fb:	64 65 72 00          	fs gs jb 1ff <PR_BOOTABLE+0x17f>
 1ff:	65 5f                	gs pop %edi
 201:	66 6c                	data16 insb (%dx),%es:(%edi)
 203:	61                   	popa   
 204:	67 73 00             	addr16 jae 207 <PR_BOOTABLE+0x187>
 207:	63 6d 64             	arpl   %bp,0x64(%ebp)
 20a:	6c                   	insb   (%dx),%es:(%edi)
 20b:	69 6e 65 00 65 5f 6d 	imul   $0x6d5f6500,0x65(%esi),%ebp
 212:	61                   	popa   
 213:	63 68 69             	arpl   %bp,0x69(%eax)
 216:	6e                   	outsb  %ds:(%esi),(%dx)
 217:	65 00 65 5f          	add    %ah,%gs:0x5f(%ebp)
 21b:	70 68                	jo     285 <PR_BOOTABLE+0x205>
 21d:	65 6e                	outsb  %gs:(%esi),(%dx)
 21f:	74 73                	je     294 <PR_BOOTABLE+0x214>
 221:	69 7a 65 00 65 78 65 	imul   $0x65786500,0x65(%edx),%edi
 228:	63 5f 6b             	arpl   %bx,0x6b(%edi)
 22b:	65 72 6e             	gs jb  29c <PR_BOOTABLE+0x21c>
 22e:	65 6c                	gs insb (%dx),%es:(%edi)
 230:	00 6d 6f             	add    %ch,0x6f(%ebp)
 233:	64 73 5f             	fs jae 295 <PR_BOOTABLE+0x215>
 236:	61                   	popa   
 237:	64 64 72 00          	fs fs jb 23b <PR_BOOTABLE+0x1bb>
 23b:	61                   	popa   
 23c:	6f                   	outsl  %ds:(%esi),(%dx)
 23d:	75 74                	jne    2b3 <PR_BOOTABLE+0x233>
 23f:	00 73 74             	add    %dh,0x74(%ebx)
 242:	72 73                	jb     2b7 <PR_BOOTABLE+0x237>
 244:	69 7a 65 00 70 61 72 	imul   $0x72617000,0x65(%edx),%edi
 24b:	74 33                	je     280 <PR_BOOTABLE+0x200>
 24d:	00 70 5f             	add    %dh,0x5f(%eax)
 250:	74 79                	je     2cb <PR_BOOTABLE+0x24b>
 252:	70 65                	jo     2b9 <PR_BOOTABLE+0x239>
 254:	00 70 72             	add    %dh,0x72(%eax)
 257:	6f                   	outsl  %ds:(%esi),(%dx)
 258:	67 68 64 72 00 65    	addr16 push $0x65007264
 25e:	5f                   	pop    %edi
 25f:	73 68                	jae    2c9 <PR_BOOTABLE+0x249>
 261:	65 6e                	outsb  %gs:(%esi),(%dx)
 263:	74 73                	je     2d8 <PR_BOOTABLE+0x258>
 265:	69 7a 65 00 73 68 6e 	imul   $0x6e687300,0x65(%edx),%edi
 26c:	64 78 00             	fs js  26f <PR_BOOTABLE+0x1ef>
 26f:	6d                   	insl   (%dx),%es:(%edi)
 270:	62 72 5f             	bound  %esi,0x5f(%edx)
 273:	74 00                	je     275 <PR_BOOTABLE+0x1f5>
 275:	65 5f                	gs pop %edi
 277:	74 79                	je     2f2 <PR_BOOTABLE+0x272>
 279:	70 65                	jo     2e0 <PR_BOOTABLE+0x260>
 27b:	00 64 72 69          	add    %ah,0x69(%edx,%esi,2)
 27f:	76 65                	jbe    2e6 <PR_BOOTABLE+0x266>
 281:	73 5f                	jae    2e2 <PR_BOOTABLE+0x262>
 283:	61                   	popa   
 284:	64 64 72 00          	fs fs jb 288 <PR_BOOTABLE+0x208>
 288:	65 5f                	gs pop %edi
 28a:	65 68 73 69 7a 65    	gs push $0x657a6973
 290:	00 70 61             	add    %dh,0x61(%eax)
 293:	72 74                	jb     309 <PR_BOOTABLE+0x289>
 295:	69 74 69 6f 6e 00 65 	imul   $0x5f65006e,0x6f(%ecx,%ebp,2),%esi
 29c:	5f 
 29d:	73 68                	jae    307 <PR_BOOTABLE+0x287>
 29f:	73 74                	jae    315 <PR_BOOTABLE+0x295>
 2a1:	72 6e                	jb     311 <PR_BOOTABLE+0x291>
 2a3:	64 78 00             	fs js  2a6 <PR_BOOTABLE+0x226>
 2a6:	62 69 6f             	bound  %ebp,0x6f(%ecx)
 2a9:	73 5f                	jae    30a <PR_BOOTABLE+0x28a>
 2ab:	73 6d                	jae    31a <PR_BOOTABLE+0x29a>
 2ad:	61                   	popa   
 2ae:	70 5f                	jo     30f <PR_BOOTABLE+0x28f>
 2b0:	74 00                	je     2b2 <PR_BOOTABLE+0x232>
 2b2:	6d                   	insl   (%dx),%es:(%edi)
 2b3:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 2b6:	74 5f                	je     317 <PR_BOOTABLE+0x297>
 2b8:	69 6e 66 6f 5f 74 00 	imul   $0x745f6f,0x66(%esi),%ebp
 2bf:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 2c2:	74 61                	je     325 <PR_BOOTABLE+0x2a5>
 2c4:	62 6c 65 5f          	bound  %ebp,0x5f(%ebp,%eiz,2)
 2c8:	6c                   	insb   (%dx),%es:(%edi)
 2c9:	62 61 00             	bound  %esp,0x0(%ecx)
 2cc:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 2cf:	74 31                	je     302 <PR_BOOTABLE+0x282>
 2d1:	6d                   	insl   (%dx),%es:(%edi)
 2d2:	61                   	popa   
 2d3:	69 6e 00 65 5f 76 65 	imul   $0x65765f65,0x0(%esi),%ebp
 2da:	72 73                	jb     34f <PR_BOOTABLE+0x2cf>
 2dc:	69 6f 6e 00 70 61 72 	imul   $0x72617000,0x6e(%edi),%ebp
 2e3:	74 31                	je     316 <PR_BOOTABLE+0x296>
 2e5:	00 70 61             	add    %dh,0x61(%eax)
 2e8:	72 74                	jb     35e <PR_BOOTABLE+0x2de>
 2ea:	32 00                	xor    (%eax),%al
 2ec:	64 72 69             	fs jb  358 <PR_BOOTABLE+0x2d8>
 2ef:	76 65                	jbe    356 <PR_BOOTABLE+0x2d6>
 2f1:	72 00                	jb     2f3 <PR_BOOTABLE+0x273>
 2f3:	66 69 72 73 74 5f    	imul   $0x5f74,0x73(%edx),%si
 2f9:	63 68 73             	arpl   %bp,0x73(%eax)
 2fc:	00 62 69             	add    %ah,0x69(%edx)
 2ff:	6f                   	outsl  %ds:(%esi),(%dx)
 300:	73 5f                	jae    361 <PR_BOOTABLE+0x2e1>
 302:	73 6d                	jae    371 <PR_BOOTABLE+0x2f1>
 304:	61                   	popa   
 305:	70 00                	jo     307 <PR_BOOTABLE+0x287>
 307:	6d                   	insl   (%dx),%es:(%edi)
 308:	65 6d                	gs insl (%dx),%es:(%edi)
 30a:	5f                   	pop    %edi
 30b:	6c                   	insb   (%dx),%es:(%edi)
 30c:	6f                   	outsl  %ds:(%esi),(%dx)
 30d:	77 65                	ja     374 <PR_BOOTABLE+0x2f4>
 30f:	72 00                	jb     311 <PR_BOOTABLE+0x291>
 311:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 314:	74 61                	je     377 <PR_BOOTABLE+0x2f7>
 316:	62 6c 65 00          	bound  %ebp,0x0(%ebp,%eiz,2)
 31a:	73 79                	jae    395 <PR_BOOTABLE+0x315>
 31c:	6d                   	insl   (%dx),%es:(%edi)
 31d:	73 00                	jae    31f <PR_BOOTABLE+0x29f>
 31f:	75 69                	jne    38a <PR_BOOTABLE+0x30a>
 321:	6e                   	outsb  %ds:(%esi),(%dx)
 322:	74 31                	je     355 <PR_BOOTABLE+0x2d5>
 324:	36 5f                	ss pop %edi
 326:	74 00                	je     328 <PR_BOOTABLE+0x2a8>
 328:	6d                   	insl   (%dx),%es:(%edi)
 329:	6d                   	insl   (%dx),%es:(%edi)
 32a:	61                   	popa   
 32b:	70 5f                	jo     38c <PR_BOOTABLE+0x30c>
 32d:	6c                   	insb   (%dx),%es:(%edi)
 32e:	65 6e                	outsb  %gs:(%esi),(%dx)
 330:	67 74 68             	addr16 je 39b <PR_BOOTABLE+0x31b>
 333:	00 6d 62             	add    %ch,0x62(%ebp)
 336:	6f                   	outsl  %ds:(%esi),(%dx)
 337:	6f                   	outsl  %ds:(%esi),(%dx)
 338:	74 5f                	je     399 <PR_BOOTABLE+0x319>
 33a:	69 6e 66 6f 00 70 5f 	imul   $0x5f70006f,0x66(%esi),%ebp
 341:	76 61                	jbe    3a4 <PR_BOOTABLE+0x324>
 343:	00 76 62             	add    %dh,0x62(%esi)
 346:	65 5f                	gs pop %edi
 348:	63 6f 6e             	arpl   %bp,0x6e(%edi)
 34b:	74 72                	je     3bf <PR_BOOTABLE+0x33f>
 34d:	6f                   	outsl  %ds:(%esi),(%dx)
 34e:	6c                   	insb   (%dx),%es:(%edi)
 34f:	5f                   	pop    %edi
 350:	69 6e 66 6f 00 70 5f 	imul   $0x5f70006f,0x66(%esi),%ebp
 357:	66 6c                	data16 insb (%dx),%es:(%edi)
 359:	61                   	popa   
 35a:	67 73 00             	addr16 jae 35d <PR_BOOTABLE+0x2dd>
 35d:	70 61                	jo     3c0 <PR_BOOTABLE+0x340>
 35f:	72 73                	jb     3d4 <PR_BOOTABLE+0x354>
 361:	65 5f                	gs pop %edi
 363:	65 38 32             	cmp    %dh,%gs:(%edx)
 366:	30 00                	xor    %al,(%eax)
 368:	65 5f                	gs pop %edi
 36a:	65 6c                	gs insb (%dx),%es:(%edi)
 36c:	66 00 62 6f          	data16 add %ah,0x6f(%edx)
 370:	6f                   	outsl  %ds:(%esi),(%dx)
 371:	74 5f                	je     3d2 <PR_BOOTABLE+0x352>
 373:	64 65 76 69          	fs gs jbe 3e0 <PR_BOOTABLE+0x360>
 377:	63 65 00             	arpl   %sp,0x0(%ebp)
 37a:	64 6b 65 72 6e       	imul   $0x6e,%fs:0x72(%ebp),%esp
 37f:	65 6c                	gs insb (%dx),%es:(%edi)
 381:	00 63 6f             	add    %ah,0x6f(%ebx)
 384:	6e                   	outsb  %ds:(%esi),(%dx)
 385:	66 69 67 5f 74 61    	imul   $0x6174,0x5f(%edi),%sp
 38b:	62 6c 65 00          	bound  %ebp,0x0(%ebp,%eiz,2)
 38f:	65 5f                	gs pop %edi
 391:	6d                   	insl   (%dx),%es:(%edi)
 392:	61                   	popa   
 393:	67 69 63 00 6c 61 73 	imul   $0x7473616c,0x0(%bp,%di),%esp
 39a:	74 
 39b:	5f                   	pop    %edi
 39c:	63 68 73             	arpl   %bp,0x73(%eax)
 39f:	00 62 61             	add    %ah,0x61(%edx)
 3a2:	73 65                	jae    409 <PR_BOOTABLE+0x389>
 3a4:	5f                   	pop    %edi
 3a5:	61                   	popa   
 3a6:	64 64 72 00          	fs fs jb 3aa <PR_BOOTABLE+0x32a>
 3aa:	76 62                	jbe    40e <PR_BOOTABLE+0x38e>
 3ac:	65 5f                	gs pop %edi
 3ae:	6d                   	insl   (%dx),%es:(%edi)
 3af:	6f                   	outsl  %ds:(%esi),(%dx)
 3b0:	64 65 00 65 5f       	fs add %ah,%gs:0x5f(%ebp)
 3b5:	73 68                	jae    41f <PR_BOOTABLE+0x39f>
 3b7:	6f                   	outsl  %ds:(%esi),(%dx)
 3b8:	66 66 00 6d 65       	data16 data16 add %ch,0x65(%ebp)
 3bd:	6d                   	insl   (%dx),%es:(%edi)
 3be:	5f                   	pop    %edi
 3bf:	75 70                	jne    431 <PR_BOOTABLE+0x3b1>
 3c1:	70 65                	jo     428 <PR_BOOTABLE+0x3a8>
 3c3:	72 00                	jb     3c5 <PR_BOOTABLE+0x345>
 3c5:	76 62                	jbe    429 <PR_BOOTABLE+0x3a9>
 3c7:	65 5f                	gs pop %edi
 3c9:	6d                   	insl   (%dx),%es:(%edi)
 3ca:	6f                   	outsl  %ds:(%esi),(%dx)
 3cb:	64 65 5f             	fs gs pop %edi
 3ce:	69 6e 66 6f 00 74 61 	imul   $0x6174006f,0x66(%esi),%ebp
 3d5:	62 73 69             	bound  %esi,0x69(%ebx)
 3d8:	7a 65                	jp     43f <PR_BOOTABLE+0x3bf>
 3da:	00 66 69             	add    %ah,0x69(%esi)
 3dd:	72 73                	jb     452 <PR_BOOTABLE+0x3d2>
 3df:	74 5f                	je     440 <PR_BOOTABLE+0x3c0>
 3e1:	6c                   	insb   (%dx),%es:(%edi)
 3e2:	62 61 00             	bound  %esp,0x0(%ecx)
 3e5:	64 72 69             	fs jb  451 <PR_BOOTABLE+0x3d1>
 3e8:	76 65                	jbe    44f <PR_BOOTABLE+0x3cf>
 3ea:	73 5f                	jae    44b <PR_BOOTABLE+0x3cb>
 3ec:	6c                   	insb   (%dx),%es:(%edi)
 3ed:	65 6e                	outsb  %gs:(%esi),(%dx)
 3ef:	67 74 68             	addr16 je 45a <PR_BOOTABLE+0x3da>
 3f2:	00 70 5f             	add    %dh,0x5f(%eax)
 3f5:	66 69 6c 65 73 7a 00 	imul   $0x7a,0x73(%ebp,%eiz,2),%bp
 3fc:	65 5f                	gs pop %edi
 3fe:	70 68                	jo     468 <PR_BOOTABLE+0x3e8>
 400:	6e                   	outsb  %ds:(%esi),(%dx)
 401:	75 6d                	jne    470 <PR_BOOTABLE+0x3f0>
 403:	00 73 69             	add    %dh,0x69(%ebx)
 406:	67 6e                	outsb  %ds:(%si),(%dx)
 408:	61                   	popa   
 409:	74 75                	je     480 <PR_BOOTABLE+0x400>
 40b:	72 65                	jb     472 <PR_BOOTABLE+0x3f2>
 40d:	00 65 5f             	add    %ah,0x5f(%ebp)
 410:	73 68                	jae    47a <PR_BOOTABLE+0x3fa>
 412:	6e                   	outsb  %ds:(%esi),(%dx)
 413:	75 6d                	jne    482 <PR_BOOTABLE+0x402>
 415:	00 76 62             	add    %dh,0x62(%esi)
 418:	65 5f                	gs pop %edi
 41a:	69 6e 74 65 72 66 61 	imul   $0x61667265,0x74(%esi),%ebp
 421:	63 65 5f             	arpl   %sp,0x5f(%ebp)
 424:	6c                   	insb   (%dx),%es:(%edi)
 425:	65 6e                	outsb  %gs:(%esi),(%dx)
 427:	00 62 6f             	add    %ah,0x6f(%edx)
 42a:	6f                   	outsl  %ds:(%esi),(%dx)
 42b:	74 2f                	je     45c <PR_BOOTABLE+0x3dc>
 42d:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 430:	74 31                	je     463 <PR_BOOTABLE+0x3e3>
 432:	2f                   	das    
 433:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 436:	74 31                	je     469 <PR_BOOTABLE+0x3e9>
 438:	6d                   	insl   (%dx),%es:(%edi)
 439:	61                   	popa   
 43a:	69 6e 2e 63 00 6d 6f 	imul   $0x6f6d0063,0x2e(%esi),%ebp
 441:	64 73 5f             	fs jae 4a3 <PR_BOOTABLE+0x423>
 444:	63 6f 75             	arpl   %bp,0x75(%edi)
 447:	6e                   	outsb  %ds:(%esi),(%dx)
 448:	74 00                	je     44a <PR_BOOTABLE+0x3ca>
 44a:	5f                   	pop    %edi
 44b:	72 65                	jb     4b2 <PR_BOOTABLE+0x432>
 44d:	73 65                	jae    4b4 <PR_BOOTABLE+0x434>
 44f:	72 76                	jb     4c7 <PR_BOOTABLE+0x447>
 451:	65 64 00 62 6f       	gs add %ah,%fs:0x6f(%edx)
 456:	6f                   	outsl  %ds:(%esi),(%dx)
 457:	74 5f                	je     4b8 <PR_BOOTABLE+0x438>
 459:	6c                   	insb   (%dx),%es:(%edi)
 45a:	6f                   	outsl  %ds:(%esi),(%dx)
 45b:	61                   	popa   
 45c:	64 65 72 5f          	fs gs jb 4bf <PR_BOOTABLE+0x43f>
 460:	6e                   	outsb  %ds:(%esi),(%dx)
 461:	61                   	popa   
 462:	6d                   	insl   (%dx),%es:(%edi)
 463:	65 00 76 62          	add    %dh,%gs:0x62(%esi)
 467:	65 5f                	gs pop %edi
 469:	69 6e 74 65 72 66 61 	imul   $0x61667265,0x74(%esi),%ebp
 470:	63 65 5f             	arpl   %sp,0x5f(%ebp)
 473:	73 65                	jae    4da <PR_BOOTABLE+0x45a>
 475:	67 00 6d 6d          	add    %ch,0x6d(%di)
 479:	61                   	popa   
 47a:	70 5f                	jo     4db <PR_BOOTABLE+0x45b>
 47c:	6c                   	insb   (%dx),%es:(%edi)
 47d:	65 6e                	outsb  %gs:(%esi),(%dx)
 47f:	00 70 5f             	add    %dh,0x5f(%eax)
 482:	61                   	popa   
 483:	6c                   	insb   (%dx),%es:(%edi)
 484:	69 67 6e 00 61 70 6d 	imul   $0x6d706100,0x6e(%edi),%esp
 48b:	5f                   	pop    %edi
 48c:	74 61                	je     4ef <PR_BOOTABLE+0x46f>
 48e:	62 6c 65 00          	bound  %ebp,0x0(%ebp,%eiz,2)
 492:	70 5f                	jo     4f3 <PR_BOOTABLE+0x473>
 494:	70 61                	jo     4f7 <PR_BOOTABLE+0x477>
 496:	00 73 65             	add    %dh,0x65(%ebx)
 499:	63 74 6f 72          	arpl   %si,0x72(%edi,%ebp,2)
 49d:	73 5f                	jae    4fe <PR_BOOTABLE+0x47e>
 49f:	63 6f 75             	arpl   %bp,0x75(%edi)
 4a2:	6e                   	outsb  %ds:(%esi),(%dx)
 4a3:	74 00                	je     4a5 <PR_BOOTABLE+0x425>

Disassembly of section .debug_loc:

00000000 <.debug_loc>:
   0:	1b 00                	sbb    (%eax),%eax
   2:	00 00                	add    %al,(%eax)
   4:	2c 00                	sub    $0x0,%al
   6:	00 00                	add    %al,(%eax)
   8:	02 00                	add    (%eax),%al
   a:	91                   	xchg   %eax,%ecx
   b:	0c 2c                	or     $0x2c,%al
   d:	00 00                	add    %al,(%eax)
   f:	00 34 00             	add    %dh,(%eax,%eax,1)
  12:	00 00                	add    %al,(%eax)
  14:	12 00                	adc    (%eax),%al
  16:	91                   	xchg   %eax,%ecx
  17:	0c 06                	or     $0x6,%al
  19:	91                   	xchg   %eax,%ecx
  1a:	00 06                	add    %al,(%esi)
  1c:	08 50 1e             	or     %dl,0x1e(%eax)
  1f:	1c 70                	sbb    $0x70,%al
  21:	00 22                	add    %ah,(%edx)
  23:	91                   	xchg   %eax,%ecx
  24:	04 06                	add    $0x6,%al
  26:	1c 9f                	sbb    $0x9f,%al
  28:	34 00                	xor    $0x0,%al
  2a:	00 00                	add    %al,(%eax)
  2c:	40                   	inc    %eax
  2d:	00 00                	add    %al,(%eax)
  2f:	00 14 00             	add    %dl,(%eax,%eax,1)
  32:	91                   	xchg   %eax,%ecx
  33:	0c 06                	or     $0x6,%al
  35:	91                   	xchg   %eax,%ecx
  36:	00 06                	add    %al,(%esi)
  38:	08 50 1e             	or     %dl,0x1e(%eax)
  3b:	1c 91                	sbb    $0x91,%al
  3d:	04 06                	add    $0x6,%al
  3f:	1c 70                	sbb    $0x70,%al
  41:	00 22                	add    %ah,(%edx)
  43:	23 01                	and    (%ecx),%eax
  45:	9f                   	lahf   
  46:	40                   	inc    %eax
  47:	00 00                	add    %al,(%eax)
  49:	00 48 00             	add    %cl,0x0(%eax)
  4c:	00 00                	add    %al,(%eax)
  4e:	12 00                	adc    (%eax),%al
  50:	91                   	xchg   %eax,%ecx
  51:	0c 06                	or     $0x6,%al
  53:	91                   	xchg   %eax,%ecx
  54:	00 06                	add    %al,(%esi)
  56:	08 50 1e             	or     %dl,0x1e(%eax)
  59:	1c 91                	sbb    $0x91,%al
  5b:	04 06                	add    $0x6,%al
  5d:	1c 76                	sbb    $0x76,%al
  5f:	00 22                	add    %ah,(%edx)
  61:	9f                   	lahf   
  62:	48                   	dec    %eax
  63:	00 00                	add    %al,(%eax)
  65:	00 4f 00             	add    %cl,0x0(%edi)
  68:	00 00                	add    %al,(%eax)
  6a:	12 00                	adc    (%eax),%al
  6c:	91                   	xchg   %eax,%ecx
  6d:	0c 06                	or     $0x6,%al
  6f:	91                   	xchg   %eax,%ecx
  70:	00 06                	add    %al,(%esi)
  72:	08 50 1e             	or     %dl,0x1e(%eax)
  75:	1c 70                	sbb    $0x70,%al
  77:	00 22                	add    %ah,(%edx)
  79:	91                   	xchg   %eax,%ecx
  7a:	04 06                	add    $0x6,%al
  7c:	1c 9f                	sbb    $0x9f,%al
  7e:	00 00                	add    %al,(%eax)
  80:	00 00                	add    %al,(%eax)
  82:	00 00                	add    %al,(%eax)
  84:	00 00                	add    %al,(%eax)
  86:	27                   	daa    
  87:	00 00                	add    %al,(%eax)
  89:	00 2a                	add    %ch,(%edx)
  8b:	00 00                	add    %al,(%eax)
  8d:	00 07                	add    %al,(%edi)
  8f:	00 70 00             	add    %dh,0x0(%eax)
  92:	91                   	xchg   %eax,%ecx
  93:	04 06                	add    $0x6,%al
  95:	22 9f 2a 00 00 00    	and    0x2a(%edi),%bl
  9b:	3b 00                	cmp    (%eax),%eax
  9d:	00 00                	add    %al,(%eax)
  9f:	01 00                	add    %eax,(%eax)
  a1:	50                   	push   %eax
  a2:	3b 00                	cmp    (%eax),%eax
  a4:	00 00                	add    %al,(%eax)
  a6:	48                   	dec    %eax
  a7:	00 00                	add    %al,(%eax)
  a9:	00 01                	add    %al,(%ecx)
  ab:	00 56 48             	add    %dl,0x48(%esi)
  ae:	00 00                	add    %al,(%eax)
  b0:	00 4f 00             	add    %cl,0x0(%edi)
  b3:	00 00                	add    %al,(%eax)
  b5:	01 00                	add    %eax,(%eax)
  b7:	50                   	push   %eax
  b8:	00 00                	add    %al,(%eax)
  ba:	00 00                	add    %al,(%eax)
  bc:	00 00                	add    %al,(%eax)
  be:	00 00                	add    %al,(%eax)
  c0:	b2 00                	mov    $0x0,%dl
  c2:	00 00                	add    %al,(%eax)
  c4:	ba 00 00 00 02       	mov    $0x2000000,%edx
  c9:	00 91 00 ba 00 00    	add    %dl,0xba00(%ecx)
  cf:	00 c5                	add    %al,%ch
  d1:	00 00                	add    %al,(%eax)
  d3:	00 07                	add    %al,(%edi)
  d5:	00 91 00 06 70 00    	add    %dl,0x700600(%ecx)
  db:	22 9f 00 00 00 00    	and    0x0(%edi),%bl
  e1:	00 00                	add    %al,(%eax)
  e3:	00 00                	add    %al,(%eax)
  e5:	b2 00                	mov    $0x0,%dl
  e7:	00 00                	add    %al,(%eax)
  e9:	ba 00 00 00 02       	mov    $0x2000000,%edx
  ee:	00 30                	add    %dh,(%eax)
  f0:	9f                   	lahf   
  f1:	ba 00 00 00 c5       	mov    $0xc5000000,%edx
  f6:	00 00                	add    %al,(%eax)
  f8:	00 01                	add    %al,(%ecx)
  fa:	00 50 00             	add    %dl,0x0(%eax)
  fd:	00 00                	add    %al,(%eax)
  ff:	00 00                	add    %al,(%eax)
 101:	00 00                	add    %al,(%eax)
 103:	00 c5                	add    %al,%ch
 105:	00 00                	add    %al,(%eax)
 107:	00 d7                	add    %dl,%bh
 109:	00 00                	add    %al,(%eax)
 10b:	00 02                	add    %al,(%edx)
 10d:	00 30                	add    %dh,(%eax)
 10f:	9f                   	lahf   
 110:	d7                   	xlat   %ds:(%ebx)
 111:	00 00                	add    %al,(%eax)
 113:	00 f5                	add    %dh,%ch
 115:	00 00                	add    %al,(%eax)
 117:	00 01                	add    %al,(%ecx)
 119:	00 52 00             	add    %dl,0x0(%edx)
 11c:	00 00                	add    %al,(%eax)
 11e:	00 00                	add    %al,(%eax)
 120:	00 00                	add    %al,(%eax)
 122:	00 df                	add    %bl,%bh
 124:	00 00                	add    %al,(%eax)
 126:	00 ee                	add    %ch,%dh
 128:	00 00                	add    %al,(%eax)
 12a:	00 01                	add    %al,(%ecx)
 12c:	00 56 00             	add    %dl,0x0(%esi)
 12f:	00 00                	add    %al,(%eax)
 131:	00 00                	add    %al,(%eax)
 133:	00 00                	add    %al,(%eax)
 135:	00 f5                	add    %dh,%ch
 137:	00 00                	add    %al,(%eax)
 139:	00 1b                	add    %bl,(%ebx)
 13b:	01 00                	add    %eax,(%eax)
 13d:	00 02                	add    %al,(%edx)
 13f:	00 91 00 1b 01 00    	add    %dl,0x11b00(%ecx)
 145:	00 1f                	add    %bl,(%edi)
 147:	01 00                	add    %eax,(%eax)
 149:	00 01                	add    %al,(%ecx)
 14b:	00 50 2b             	add    %dl,0x2b(%eax)
 14e:	01 00                	add    %eax,(%eax)
 150:	00 37                	add    %dh,(%edi)
 152:	01 00                	add    %eax,(%eax)
 154:	00 01                	add    %al,(%ecx)
 156:	00 50 00             	add    %dl,0x0(%eax)
 159:	00 00                	add    %al,(%eax)
 15b:	00 00                	add    %al,(%eax)
 15d:	00 00                	add    %al,(%eax)
 15f:	00 1b                	add    %bl,(%ebx)
 161:	01 00                	add    %eax,(%eax)
 163:	00 22                	add    %ah,(%edx)
 165:	01 00                	add    %eax,(%eax)
 167:	00 01                	add    %al,(%ecx)
 169:	00 56 22             	add    %dl,0x22(%esi)
 16c:	01 00                	add    %eax,(%eax)
 16e:	00 39                	add    %bh,(%ecx)
 170:	01 00                	add    %eax,(%eax)
 172:	00 01                	add    %al,(%ecx)
 174:	00 51 39             	add    %dl,0x39(%ecx)
 177:	01 00                	add    %eax,(%eax)
 179:	00 3c 01             	add    %bh,(%ecx,%eax,1)
 17c:	00 00                	add    %al,(%eax)
 17e:	01 00                	add    %eax,(%eax)
 180:	50                   	push   %eax
 181:	3c 01                	cmp    $0x1,%al
 183:	00 00                	add    %al,(%eax)
 185:	51                   	push   %ecx
 186:	01 00                	add    %eax,(%eax)
 188:	00 01                	add    %al,(%ecx)
 18a:	00 51 00             	add    %dl,0x0(%ecx)
 18d:	00 00                	add    %al,(%eax)
 18f:	00 00                	add    %al,(%eax)
 191:	00 00                	add    %al,(%eax)
 193:	00 03                	add    %al,(%ebx)
 195:	01 00                	add    %eax,(%eax)
 197:	00 19                	add    %bl,(%ecx)
 199:	01 00                	add    %eax,(%eax)
 19b:	00 01                	add    %al,(%ecx)
 19d:	00 50 19             	add    %dl,0x19(%eax)
 1a0:	01 00                	add    %eax,(%eax)
 1a2:	00 47 01             	add    %al,0x1(%edi)
 1a5:	00 00                	add    %al,(%eax)
 1a7:	02 00                	add    (%eax),%al
 1a9:	91                   	xchg   %eax,%ecx
 1aa:	00 47 01             	add    %al,0x1(%edi)
 1ad:	00 00                	add    %al,(%eax)
 1af:	52                   	push   %edx
 1b0:	01 00                	add    %eax,(%eax)
 1b2:	00 02                	add    %al,(%edx)
 1b4:	00 91 68 00 00 00    	add    %dl,0x68(%ecx)
 1ba:	00 00                	add    %al,(%eax)
 1bc:	00 00                	add    %al,(%eax)
 1be:	00 b2 01 00 00 b5    	add    %dh,-0x4affffff(%edx)
 1c4:	01 00                	add    %eax,(%eax)
 1c6:	00 01                	add    %al,(%ecx)
 1c8:	00 50 00             	add    %dl,0x0(%eax)
 1cb:	00 00                	add    %al,(%eax)
 1cd:	00 00                	add    %al,(%eax)
 1cf:	00 00                	add    %al,(%eax)
 1d1:	00 e9                	add    %ch,%cl
 1d3:	01 00                	add    %eax,(%eax)
 1d5:	00 ec                	add    %ch,%ah
 1d7:	01 00                	add    %eax,(%eax)
 1d9:	00 01                	add    %al,(%ecx)
 1db:	00 50 00             	add    %dl,0x0(%eax)
 1de:	00 00                	add    %al,(%eax)
 1e0:	00 00                	add    %al,(%eax)
 1e2:	00 00                	add    %al,(%eax)
 1e4:	00 f0                	add    %dh,%al
 1e6:	01 00                	add    %eax,(%eax)
 1e8:	00 00                	add    %al,(%eax)
 1ea:	02 00                	add    (%eax),%al
 1ec:	00 03                	add    %al,(%ebx)
 1ee:	00 08                	add    %cl,(%eax)
 1f0:	80 9f 00 00 00 00 00 	sbbb   $0x0,0x0(%edi)
 1f7:	00 00                	add    %al,(%eax)
 1f9:	00 f0                	add    %dh,%al
 1fb:	01 00                	add    %eax,(%eax)
 1fd:	00 00                	add    %al,(%eax)
 1ff:	02 00                	add    (%eax),%al
 201:	00 02                	add    %al,(%edx)
 203:	00 91 00 00 00 00    	add    %dl,0x0(%ecx)
 209:	00 00                	add    %al,(%eax)
 20b:	00 00                	add    %al,(%eax)
 20d:	00 03                	add    %al,(%ebx)
 20f:	02 00                	add    (%eax),%al
 211:	00 0b                	add    %cl,(%ebx)
 213:	02 00                	add    (%eax),%al
 215:	00 02                	add    %al,(%edx)
 217:	00 91 00 0b 02 00    	add    %dl,0x20b00(%ecx)
 21d:	00 1d 02 00 00 0a    	add    %bl,0xa000002
 223:	00 91 00 06 0c ff    	add    %dl,-0xf3fa00(%ecx)
 229:	ff                   	(bad)  
 22a:	ff 00                	incl   (%eax)
 22c:	1a 9f 1d 02 00 00    	sbb    0x21d(%edi),%bl
 232:	23 02                	and    (%edx),%eax
 234:	00 00                	add    %al,(%eax)
 236:	01 00                	add    %eax,(%eax)
 238:	57                   	push   %edi
 239:	23 02                	and    (%edx),%eax
 23b:	00 00                	add    %al,(%eax)
 23d:	33 02                	xor    (%edx),%eax
 23f:	00 00                	add    %al,(%eax)
 241:	01 00                	add    %eax,(%eax)
 243:	56                   	push   %esi
 244:	33 02                	xor    (%edx),%eax
 246:	00 00                	add    %al,(%eax)
 248:	37                   	aaa    
 249:	02 00                	add    (%eax),%al
 24b:	00 02                	add    %al,(%edx)
 24d:	00 74 00 37          	add    %dh,0x37(%eax,%eax,1)
 251:	02 00                	add    (%eax),%al
 253:	00 38                	add    %bh,(%eax)
 255:	02 00                	add    (%eax),%al
 257:	00 04 00             	add    %al,(%eax,%eax,1)
 25a:	76 80                	jbe    1dc <PR_BOOTABLE+0x15c>
 25c:	7c 9f                	jl     1fd <PR_BOOTABLE+0x17d>
 25e:	38 02                	cmp    %al,(%edx)
 260:	00 00                	add    %al,(%eax)
 262:	41                   	inc    %ecx
 263:	02 00                	add    (%eax),%al
 265:	00 01                	add    %al,(%ecx)
 267:	00 56 00             	add    %dl,0x0(%esi)
 26a:	00 00                	add    %al,(%eax)
 26c:	00 00                	add    %al,(%eax)
 26e:	00 00                	add    %al,(%eax)
 270:	00 03                	add    %al,(%ebx)
 272:	02 00                	add    (%eax),%al
 274:	00 26                	add    %ah,(%esi)
 276:	02 00                	add    (%eax),%al
 278:	00 02                	add    %al,(%edx)
 27a:	00 91 08 26 02 00    	add    %dl,0x22608(%ecx)
 280:	00 2c 02             	add    %ch,(%edx,%eax,1)
 283:	00 00                	add    %al,(%eax)
 285:	01 00                	add    %eax,(%eax)
 287:	53                   	push   %ebx
 288:	2c 02                	sub    $0x2,%al
 28a:	00 00                	add    %al,(%eax)
 28c:	2d 02 00 00 02       	sub    $0x2000002,%eax
 291:	00 74 00 2d          	add    %dh,0x2d(%eax,%eax,1)
 295:	02 00                	add    (%eax),%al
 297:	00 37                	add    %dh,(%edi)
 299:	02 00                	add    (%eax),%al
 29b:	00 02                	add    %al,(%edx)
 29d:	00 74 04 37          	add    %dh,0x37(%esp,%eax,1)
 2a1:	02 00                	add    (%eax),%al
 2a3:	00 38                	add    %bh,(%eax)
 2a5:	02 00                	add    (%eax),%al
 2a7:	00 03                	add    %al,(%ebx)
 2a9:	00 73 7f             	add    %dh,0x7f(%ebx)
 2ac:	9f                   	lahf   
 2ad:	38 02                	cmp    %al,(%edx)
 2af:	00 00                	add    %al,(%eax)
 2b1:	40                   	inc    %eax
 2b2:	02 00                	add    (%eax),%al
 2b4:	00 01                	add    %al,(%ecx)
 2b6:	00 53 00             	add    %dl,0x0(%ebx)
 2b9:	00 00                	add    %al,(%eax)
 2bb:	00 00                	add    %al,(%eax)
 2bd:	00 00                	add    %al,(%eax)
 2bf:	00 23                	add    %ah,(%ebx)
 2c1:	02 00                	add    (%eax),%al
 2c3:	00 42 02             	add    %al,0x2(%edx)
 2c6:	00 00                	add    %al,(%eax)
 2c8:	01 00                	add    %eax,(%eax)
 2ca:	57                   	push   %edi
 2cb:	42                   	inc    %edx
 2cc:	02 00                	add    (%eax),%al
 2ce:	00 44 02 00          	add    %al,0x0(%edx,%eax,1)
 2d2:	00 0e                	add    %cl,(%esi)
 2d4:	00 91 00 06 0c ff    	add    %dl,-0xf3fa00(%ecx)
 2da:	ff                   	(bad)  
 2db:	ff 00                	incl   (%eax)
 2dd:	1a 91 04 06 22 9f    	sbb    -0x60ddf9fc(%ecx),%dl
 2e3:	00 00                	add    %al,(%eax)
 2e5:	00 00                	add    %al,(%eax)
 2e7:	00 00                	add    %al,(%eax)
 2e9:	00 00                	add    %al,(%eax)
 2eb:	48                   	dec    %eax
 2ec:	00 00                	add    %al,(%eax)
 2ee:	00 5d 00             	add    %bl,0x0(%ebp)
 2f1:	00 00                	add    %al,(%eax)
 2f3:	01 00                	add    %eax,(%eax)
 2f5:	53                   	push   %ebx
 2f6:	5d                   	pop    %ebp
 2f7:	00 00                	add    %al,(%eax)
 2f9:	00 6b 00             	add    %ch,0x0(%ebx)
 2fc:	00 00                	add    %al,(%eax)
 2fe:	03 00                	add    (%eax),%eax
 300:	73 60                	jae    362 <PR_BOOTABLE+0x2e2>
 302:	9f                   	lahf   
 303:	6b 00 00             	imul   $0x0,(%eax),%eax
 306:	00 79 00             	add    %bh,0x0(%ecx)
 309:	00 00                	add    %al,(%eax)
 30b:	01 00                	add    %eax,(%eax)
 30d:	53                   	push   %ebx
 30e:	00 00                	add    %al,(%eax)
 310:	00 00                	add    %al,(%eax)
 312:	00 00                	add    %al,(%eax)
 314:	00 00                	add    %al,(%eax)
 316:	55                   	push   %ebp
 317:	00 00                	add    %al,(%eax)
 319:	00 7b 00             	add    %bh,0x0(%ebx)
 31c:	00 00                	add    %al,(%eax)
 31e:	01 00                	add    %eax,(%eax)
 320:	57                   	push   %edi
 321:	00 00                	add    %al,(%eax)
 323:	00 00                	add    %al,(%eax)
 325:	00 00                	add    %al,(%eax)
 327:	00 00                	add    %al,(%eax)
 329:	89 00                	mov    %eax,(%eax)
 32b:	00 00                	add    %al,(%eax)
 32d:	9c                   	pushf  
 32e:	00 00                	add    %al,(%eax)
 330:	00 02                	add    %al,(%edx)
 332:	00 91 00 9c 00 00    	add    %dl,0x9c00(%ecx)
 338:	00 b0 00 00 00 01    	add    %dh,0x1000000(%eax)
 33e:	00 53 b0             	add    %dl,-0x50(%ebx)
 341:	00 00                	add    %al,(%eax)
 343:	00 b6 00 00 00 03    	add    %dh,0x3000000(%esi)
 349:	00 73 68             	add    %dh,0x68(%ebx)
 34c:	9f                   	lahf   
 34d:	b6 00                	mov    $0x0,%dh
 34f:	00 00                	add    %al,(%eax)
 351:	de 00                	fiadd  (%eax)
 353:	00 00                	add    %al,(%eax)
 355:	01 00                	add    %eax,(%eax)
 357:	53                   	push   %ebx
 358:	00 00                	add    %al,(%eax)
 35a:	00 00                	add    %al,(%eax)
 35c:	00 00                	add    %al,(%eax)
 35e:	00 00                	add    %al,(%eax)
 360:	89 00                	mov    %eax,(%eax)
 362:	00 00                	add    %al,(%eax)
 364:	9c                   	pushf  
 365:	00 00                	add    %al,(%eax)
 367:	00 02                	add    %al,(%edx)
 369:	00 30                	add    %dh,(%eax)
 36b:	9f                   	lahf   
 36c:	a3 00 00 00 b5       	mov    %eax,0xb5000000
 371:	00 00                	add    %al,(%eax)
 373:	00 01                	add    %al,(%ecx)
 375:	00 52 b5             	add    %dl,-0x4b(%edx)
 378:	00 00                	add    %al,(%eax)
 37a:	00 b6 00 00 00 08    	add    %dh,0x8000000(%esi)
 380:	00 73 00             	add    %dh,0x0(%ebx)
 383:	76 00                	jbe    385 <PR_BOOTABLE+0x305>
 385:	1c 48                	sbb    $0x48,%al
 387:	1c 9f                	sbb    $0x9f,%al
 389:	b6 00                	mov    $0x0,%dh
 38b:	00 00                	add    %al,(%eax)
 38d:	bb 00 00 00 06       	mov    $0x6000000,%ebx
 392:	00 73 00             	add    %dh,0x0(%ebx)
 395:	76 00                	jbe    397 <PR_BOOTABLE+0x317>
 397:	1c 9f                	sbb    $0x9f,%al
 399:	bb 00 00 00 e1       	mov    $0xe1000000,%ebx
 39e:	00 00                	add    %al,(%eax)
 3a0:	00 01                	add    %al,(%ecx)
 3a2:	00 52 00             	add    %dl,0x0(%edx)
 3a5:	00 00                	add    %al,(%eax)
 3a7:	00 00                	add    %al,(%eax)
 3a9:	00 00                	add    %al,(%eax)
 3ab:	00 02                	add    %al,(%edx)
 3ad:	01 00                	add    %eax,(%eax)
 3af:	00 07                	add    %al,(%edi)
 3b1:	01 00                	add    %eax,(%eax)
 3b3:	00 02                	add    %al,(%edx)
 3b5:	00 30                	add    %dh,(%eax)
 3b7:	9f                   	lahf   
 3b8:	07                   	pop    %es
 3b9:	01 00                	add    %eax,(%eax)
 3bb:	00 19                	add    %bl,(%ecx)
 3bd:	01 00                	add    %eax,(%eax)
 3bf:	00 01                	add    %al,(%ecx)
 3c1:	00 50 19             	add    %dl,0x19(%eax)
 3c4:	01 00                	add    %eax,(%eax)
 3c6:	00 1c 01             	add    %bl,(%ecx,%eax,1)
 3c9:	00 00                	add    %al,(%eax)
 3cb:	03 00                	add    (%eax),%eax
 3cd:	70 65                	jo     434 <PR_BOOTABLE+0x3b4>
 3cf:	9f                   	lahf   
 3d0:	22 01                	and    (%ecx),%al
 3d2:	00 00                	add    %al,(%eax)
 3d4:	36 01 00             	add    %eax,%ss:(%eax)
 3d7:	00 01                	add    %al,(%ecx)
 3d9:	00 50 00             	add    %dl,0x0(%eax)
 3dc:	00 00                	add    %al,(%eax)
 3de:	00 00                	add    %al,(%eax)
 3e0:	00 00                	add    %al,(%eax)
 3e2:	00 02                	add    %al,(%edx)
 3e4:	01 00                	add    %eax,(%eax)
 3e6:	00 20                	add    %ah,(%eax)
 3e8:	01 00                	add    %eax,(%eax)
 3ea:	00 02                	add    %al,(%edx)
 3ec:	00 30                	add    %dh,(%eax)
 3ee:	9f                   	lahf   
 3ef:	20 01                	and    %al,(%ecx)
 3f1:	00 00                	add    %al,(%eax)
 3f3:	22 01                	and    (%ecx),%al
 3f5:	00 00                	add    %al,(%eax)
 3f7:	01 00                	add    %eax,(%eax)
 3f9:	56                   	push   %esi
 3fa:	22 01                	and    (%ecx),%al
 3fc:	00 00                	add    %al,(%eax)
 3fe:	3a 01                	cmp    (%ecx),%al
 400:	00 00                	add    %al,(%eax)
 402:	02 00                	add    (%eax),%al
 404:	30 9f 00 00 00 00    	xor    %bl,0x0(%edi)
 40a:	00 00                	add    %al,(%eax)
 40c:	00 00                	add    %al,(%eax)
 40e:	60                   	pusha  
 40f:	01 00                	add    %eax,(%eax)
 411:	00 64 01 00          	add    %ah,0x0(%ecx,%eax,1)
 415:	00 01                	add    %al,(%ecx)
 417:	00 50 64             	add    %dl,0x64(%eax)
 41a:	01 00                	add    %eax,(%eax)
 41c:	00 80 01 00 00 01    	add    %al,0x1000001(%eax)
 422:	00 53 00             	add    %dl,0x0(%ebx)
 425:	00 00                	add    %al,(%eax)
 427:	00 00                	add    %al,(%eax)
 429:	00 00                	add    %al,(%eax)
 42b:	00                   	.byte 0x0

Disassembly of section .debug_ranges:

00000000 <.debug_ranges>:
   0:	a6                   	cmpsb  %es:(%edi),%ds:(%esi)
   1:	01 00                	add    %eax,(%eax)
   3:	00 ab 01 00 00 b1    	add    %ch,-0x4effffff(%ebx)
   9:	01 00                	add    %eax,(%eax)
   b:	00 b9 01 00 00 00    	add    %bh,0x1(%ecx)
  11:	00 00                	add    %al,(%eax)
  13:	00 00                	add    %al,(%eax)
  15:	00 00                	add    %al,(%eax)
  17:	00 a6 01 00 00 ab    	add    %ah,-0x54ffffff(%esi)
  1d:	01 00                	add    %eax,(%eax)
  1f:	00 b1 01 00 00 b2    	add    %dh,-0x4dffffff(%ecx)
  25:	01 00                	add    %eax,(%eax)
  27:	00 00                	add    %al,(%eax)
  29:	00 00                	add    %al,(%eax)
  2b:	00 00                	add    %al,(%eax)
  2d:	00 00                	add    %al,(%eax)
  2f:	00 cf                	add    %cl,%bh
  31:	01 00                	add    %eax,(%eax)
  33:	00 d1                	add    %dl,%cl
  35:	01 00                	add    %eax,(%eax)
  37:	00 d7                	add    %dl,%bh
  39:	01 00                	add    %eax,(%eax)
  3b:	00 d8                	add    %bl,%al
  3d:	01 00                	add    %eax,(%eax)
  3f:	00 00                	add    %al,(%eax)
  41:	00 00                	add    %al,(%eax)
  43:	00 00                	add    %al,(%eax)
  45:	00 00                	add    %al,(%eax)
  47:	00 db                	add    %bl,%bl
  49:	01 00                	add    %eax,(%eax)
  4b:	00 dd                	add    %bl,%ch
  4d:	01 00                	add    %eax,(%eax)
  4f:	00 e2                	add    %ah,%dl
  51:	01 00                	add    %eax,(%eax)
  53:	00 e3                	add    %ah,%bl
  55:	01 00                	add    %eax,(%eax)
  57:	00 00                	add    %al,(%eax)
  59:	00 00                	add    %al,(%eax)
  5b:	00 00                	add    %al,(%eax)
  5d:	00 00                	add    %al,(%eax)
  5f:	00                   	.byte 0x0
