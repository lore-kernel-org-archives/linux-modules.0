Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976757;
	b=yU0xTkkMRLdT5pn+MR40Go65o+qTWA/XHRpOb3aczbwkIiX5p04Yk4zZncjxh/at8UVm
	 vyq1ueV6EqcrgM5yEKIVreCjcJR8JGDfqrx+IGZhCWBxzHE0fQ6neQSdTkas9umJ+M39i
	 tujuZgwdTB4c/YxHZXfXCzjUddeM32UjRwcmFCfUOpWOLwsd9QobUaeDw1c/X+3l/6UTi
	 yZTrtyiOwSklfX3Vd86SEMZhqvPvO34Ff/wh4W+dvRQ8RwEa9YoLdiwuVTrphygyaDaKC
	 KDyvmUwiGGuU6/2MFR5XRTtl/LR9c9J3N3O6Jns5wsUcbwz39kixeoGnOkeBlltbGWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976757;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=l9YxZv2Vfzr3V+FeQUpS8Gd+zPlMw1+YkgPLaCOaQTo=;
	b=JWz/ZdrjIq0MX7j4E4o13YD5jeDSBA3GcxSaqUwYmMcGNRaxcwOHYxmFPiitdWx7RvQP
	 11sD16VQZQmAsjMyRxichBB59eBfy2I/9JlwDZ84y67kNkGvUx+5GnA9L8tFZ24SLDgnE
	 RnehlecV7DERR/fnmykQkIL+5SwxFYr+Doh362uuqgcu6ieKIbIGMyUbH4LaxIcn+8hLs
	 sW6/VpgU0iTEnxKgjhkKGEtifaVreVvEG4Jw2WWJBasDyRXzNTkztGpIWzRDHHLv/mM8K
	 eOH71p3KzJMcz0rFfyJBq9zuryytndu+M7TdriFyJ2ElWv2C/jlMcHw35+AK0mOyMdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=fw92Y32k;
	arc=none smtp.remote-ip=212.227.15.19
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0679606A32C;
	Fri,  6 Nov 2026 14:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0679606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=fw92Y32k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1793976740; x=1794581540; i=deller@gmx.de;
	bh=l9YxZv2Vfzr3V+FeQUpS8Gd+zPlMw1+YkgPLaCOaQTo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fw92Y32km0pxBcKevSxUCpdTcs+QRMbePffyJ04IxrDf6TMf4Ru+FfSah5OJM4BG
	 AkXEACGWqEl5+xFdryNHb7BGYS8OLz6qHV9PgmVT3+88wH2AXBxdbCnuOgNdQbDAH
	 1epuniCFsg93sNlpzpCVXKI5m4BBfuDDvytgb08PUfNJYx9gdEfEn64eAZlcLht6v
	 d1Vv0bLI2FdfGJo6JLItAgqpyKLmMT+CXGAfkpS51+JVfkWCB7i+O8bTNMl7hgARl
	 /4zbdg0YNKj/M2sQZTTD4+Ztkgvf/IU8vYtpSd4XS4C/r+gyRvlGo5zV5QDAosenV
	 H37S4AqcGdP2LlRKGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYPi-1wsDPg18AK-00k1dU; Fri, 06
 Nov 2026 15:52:20 +0100
Message-ID: <3aad6baa-c5e7-49a6-939f-b95b062b6be6@gmx.de>
Date: Fri, 6 Nov 2026 15:52:12 +0100
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/4] kallsyms: embed source file:line info in kernel
 stack traces
To: Sasha Levin <sashal@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Richard Weinberger <richard@nod.at>, Juergen Gross <jgross@suse.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 Greg KH <gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Kees Cook <kees@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Thorsten Leemhuis <linux@leemhuis.info>, Vlastimil Babka
 <vbabka@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Vivian Wang <wangruikang@iscas.ac.cn>, Zhen Lei
 <thunder.leizhen@huawei.com>, Sami Tolvanen <samitolvanen@google.com>,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org
References: <20261106132432.248387-1-sashal@kernel.org>
 <20261106132432.248387-2-sashal@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261106132432.248387-2-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y7KehjYUehCyt9VUljgwl4RPAr2sMOy4ys0LLqQlvddRqOnXogH
 IFNDAoYMu4HPuMeGnzzYvHk2PgmxqJMU21lWMVVdNhLK0CZDzXKtaOOsEk+RWyvqDYTV5O4
 zoTlBoIBaXCRVxidbE69+iHnpJkut2Nsb8nDuTURlTl1c8o4UNyNSqZSx1Ww1HyYlnM5Qa4
 20JbQrTU23XE5Uj5rl0mQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SnUgHtR6Cy8=;w4Wk8EasSrd7nW23W6dm/0ED+d7
 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

On 11/6/26 14:24, Sasha Levin wrote:
> Add CONFIG_KALLSYMS_LINEINFO, which embeds a compact address-to-line
> lookup table in the kernel image so stack traces directly print source
> file and line number information:
>=20
>    root@localhost:~# echo c > /proc/sysrq-trigger
>    [   11.201987] sysrq: Trigger a crash
>    [   11.202831] Kernel panic - not syncing: sysrq triggered crash
>    [   11.206218] Call Trace:
>    [   11.206501]  <TASK>
>    [   11.206749]  dump_stack_lvl+0x5d/0x80 (lib/dump_stack.c:94)
>    [   11.207403]  vpanic+0x36e/0x620 (kernel/panic.c:650)
>    [   11.208565]  ? __lock_acquire+0x465/0x2240 (kernel/locking/lockdep=
.c:4674)
>    [   11.209324]  panic+0xc9/0xd0 (kernel/panic.c:787)
>    [   11.211873]  ? find_held_lock+0x2b/0x80 (kernel/locking/lockdep.c:=
5350)
>    [   11.212597]  ? lock_release+0xd3/0x300 (kernel/locking/lockdep.c:5=
535)
>    [   11.213312]  sysrq_handle_crash+0x1a/0x20 (drivers/tty/sysrq.c:154=
)
>    [   11.214005]  __handle_sysrq.cold+0x66/0x256 (drivers/tty/sysrq.c:6=
11)
>    [   11.214712]  write_sysrq_trigger+0x65/0x80 (drivers/tty/sysrq.c:12=
21)
>    [   11.215424]  proc_reg_write+0x1bd/0x3c0 (fs/proc/inode.c:330)
>    [   11.216061]  vfs_write+0x1c6/0xff0 (fs/read_write.c:686)
>    [   11.218848]  ksys_write+0xfa/0x200 (fs/read_write.c:740)
>    [   11.222394]  do_syscall_64+0xf3/0x690 (arch/x86/entry/syscall_64.c=
:63)
>    [   11.223942]  entry_SYSCALL_64_after_hwframe+0x77/0x7f (arch/x86/en=
try/entry_64.S:121)
>=20
> At build time, a new host tool (scripts/gen_lineinfo) reads DWARF
> .debug_line from vmlinux using libdw (elfutils), extracts all
> address-to-file:line mappings, and generates an assembly file with
> sorted parallel arrays (offsets from _text, file IDs, and line
> numbers). These are linked into vmlinux as .rodata.
>=20
> At runtime, kallsyms_lookup_lineinfo() does a binary search on the
> table and __sprint_symbol() appends "(file:line)" to each stack frame.
> The lookup uses offsets from _text so it works with KASLR, requires no
> locks or allocations, and is safe in any context including panic.
>=20
> The suffix is appended for every symbol variant that already prints an
> offset, so %pS, %pSb and the %pB backtrace forms all carry it: arm64
> prints frames with %pSb and the generic stack_trace_print() uses %pS.
> sprint_symbol_no_offset(), which backs lowercase %ps, stays bare
> because callers suffix it with a literal "()".
>=20
> A line program emits several rows per address, and every row but the
> last covers zero bytes, so the generator keeps the last row at each
> address.  That is the row addr2line reports, and for an inlined call it
> names the inlined body rather than the call site.
>=20
> Rows the compiler marks with line 0 declare that no source location
> applies from there on (DWARF5 6.2.2), and the end of a line program's
> sequence says the same of the bytes past it.  Both are kept, as entries
> whose line is zero that the lookup reads as "no annotation", so an
> address the compiler deliberately left unattributed reports nothing
> instead of inheriting the line above it.
>=20
> The feature requires CONFIG_DEBUG_INFO (for DWARF data) and libelf
> and libdw (from elfutils) on the build host.
>=20
> Memory footprint, measured with:
>=20
>    make ARCH=3Dx86_64 O=3D$B defconfig
>    ./scripts/config --file $B/.config -e DEBUG_INFO \
>                                       -e DEBUG_INFO_DWARF_TOOLCHAIN_DEFA=
ULT
>    make ARCH=3Dx86_64 O=3D$B olddefconfig && make ARCH=3Dx86_64 O=3D$B -=
j$(nproc)
>    strip -g $B/vmlinux -o vmlinux.nodbg && stat -c %s vmlinux.nodbg
>=20
>    Table: 1,657,663 entries from 4,234 source files
>      lineinfo_addrs[]     1,657,663 x u32  =3D  6.3 MiB
>      lineinfo_file_ids[]  1,657,663 x u16  =3D  3.2 MiB
>      lineinfo_lines[]     1,657,663 x u32  =3D  6.3 MiB
>      file_offsets + filenames              =3D  0.1 MiB
>      Total .rodata increase:               =3D 15.9 MiB
>=20
>    vmlinux (stripped):  52.2 MiB -> 68.2 MiB  (+16.0 MiB / +30.6%)
>=20
> That is the cost of the uncompressed format introduced here; the delta
> compression added later in this series brings it down to +8.0 MiB
> (+15.3%) on the same config.
>=20
> Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>


Tested-by: Helge Deller <deller@gmx.de>   # parisc
Acked-by: Helge Deller <deller@gmx.de>

Example:

root@62:/# echo c > /proc/sysrq-trigger
[   95.740284] sysrq: Trigger a crash
[   95.745518] Kernel panic - not syncing: sysrq triggered crash
[   95.746724] CPU: 1 UID: 0 PID: 1 Comm: bash Not tainted 7.4.0-rc1+ #326=
3 VOLUNTARY
[   95.746724] Hardware name: 9000/778/B160L
[   95.746724] Backtrace:
[   95.746724]  [<1041d778>] show_stack+0x54/0x78 (arch/parisc/kernel/trap=
s.c:212)
[   95.746724]  [<10413404>] dump_stack_lvl+0x80/0xc8 (lib/dump_stack.c:12=
2)
[   95.746724]  [<10413468>] dump_stack+0x1c/0x2c (lib/dump_stack.c:130)
[   95.746724]  [<10401288>] vpanic+0x14c/0x340 (kernel/panic.c:561)
[   95.746724]  [<104014b0>] panic+0x34/0x48 (kernel/panic.c:787)
[   95.746724]  [<10e6cbcc>] sysrq_handle_crash+0x20/0x34 (drivers/tty/sys=
rq.c:154)
[   95.746724]  [<10e6d734>] __handle_sysrq+0xb4/0x1d8 (drivers/tty/sysrq.=
c:635)
[   95.746724]  [<10e6e1b4>] write_sysrq_trigger+0x90/0xe0 (drivers/tty/sy=
srq.c:1220)
[   95.746724]  [<10977d88>] proc_reg_write+0xd4/0x120 (fs/proc/inode.c:34=
3)
[   95.746724]  [<1088c9cc>] vfs_write+0xbc/0x468 (fs/read_write.c:690)
[   95.746724]  [<1088cf5c>] ksys_write+0x7c/0x12c (fs/read_write.c:740)
[   95.746724]  [<1088d028>] sys_write+0x1c/0x3c (fs/read_write.c:747)
[   95.746724]  [<10418334>] syscall_exit+0x0/0x10 (arch/parisc/kernel/ent=
ry.S:1722)
[   95.746724]
[   95.746724] ---[ end Kernel panic - not syncing: sysrq triggered crash =
]---


